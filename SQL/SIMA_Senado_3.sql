/****** Object:  UserDefinedTableType [dbo].[UDT_Dictionary]    Script Date: 20/12/2022 09:59:32 a. m. ******/
CREATE TYPE [dbo].[UDT_Dictionary] AS TABLE(
	[Key] [int] NULL,
	[Value] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fnCodigoDeJerarquiaMaxima]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnCodigoDeJerarquiaMaxima](@IdClasificacion INT)
RETURNS VARCHAR(50) WITH ENCRYPTION
AS  
BEGIN
	DECLARE @NomenclaturaDeJerarquia VARCHAR(255), @Niveles INT, @i INT, @Aux VARCHAR(255), @Aux2 VARCHAR(255), @Nivel INT
	SELECT @Nivel = 0
	SELECT @NomenclaturaDeJerarquia = dbo.fnNombreDeJerarquia(@idClasificacion)
	WHILE (CHARINDEX('.', @NomenclaturaDeJerarquia) > 1)
	BEGIN
		SELECT @Nivel = @Nivel + 1
		SELECT @NomenclaturaDeJerarquia = SUBSTRING(@NomenclaturaDeJerarquia, CHARINDEX('.', @NomenclaturaDeJerarquia) + 1, LEN(@NomenclaturaDeJerarquia))
	END
	SELECT @Nivel = @Nivel + 1
	SELECT @NomenclaturaDeJerarquia = dbo.fnNombreDeJerarquia(@IdClasificacion) + '.'
	SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
	SELECT @Aux = ''
	SELECT @Niveles = 0
	WHILE (@Niveles < @Nivel + 1)
	BEGIN
		SELECT @Niveles = @Niveles + 1
		SELECT @Aux2 = @Aux
		IF @i <> 0
		BEGIN
			SELECT @Aux = @Aux + SUBSTRING(@NomenclaturaDeJerarquia, 1, @i)
			SELECT @NomenclaturaDeJerarquia = SUBSTRING(@NomenclaturaDeJerarquia, @i + 1, LEN(@NomenclaturaDeJerarquia))
			SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
		END
		ELSE
			BREAK
	END
	RETURN (SELECT SUBSTRING(@Aux2, 1, LEN(@Aux2) - 1)
		FROM CuadroClasificacion c
		WHERE c.idClasificacion = dbo.fnGetIDJerarquia(SUBSTRING(@Aux2, 1, LEN(@Aux2) - 1)))
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnCodigoDeJerarquiaPorNivel]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnCodigoDeJerarquiaPorNivel](@IdClasificacion INT, @Nivel INT)
RETURNS VARCHAR(50) WITH ENCRYPTION
AS  
BEGIN
	DECLARE @NomenclaturaDeJerarquia VARCHAR(255), @Niveles INT, @i INT, @Aux VARCHAR(255), @Aux2 VARCHAR(255)

	SELECT @NomenclaturaDeJerarquia = dbo.fnNombreDeJerarquia(@IdClasificacion) + '.'

	SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
	SELECT @Aux = ''
	SELECT @Niveles = 0
	WHILE (@Niveles < @Nivel + 1)
	BEGIN
		SELECT @Niveles = @Niveles + 1
		SELECT @Aux2 = @Aux
		IF @i <> 0
		BEGIN
			SELECT @Aux = @Aux + SUBSTRING(@NomenclaturaDeJerarquia, 1, @i)
			SELECT @NomenclaturaDeJerarquia = SUBSTRING(@NomenclaturaDeJerarquia, @i + 1, LEN(@NomenclaturaDeJerarquia))
			SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
		END
		ELSE
			BREAK
	END
	RETURN (SELECT SUBSTRING(@Aux2, 1, LEN(@Aux2) - 1)
		FROM CuadroClasificacion c
		WHERE c.idClasificacion = dbo.fnGetIDJerarquia(SUBSTRING(@Aux2, 1, LEN(@Aux2) - 1)))

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnExtraeDigitosIniciales]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnExtraeDigitosIniciales](@cadena as varchar(256))

returns int  WITH ENCRYPTION

as 

begin
	declare @pos as int, @DigitosEncontrados as int
	select @pos = 1
	select @DigitosEncontrados = 0
	while @pos < len(@cadena)
	begin
		if isnumeric(substring(@cadena, 1, @pos)) = 1
			select @DigitosEncontrados = cast(substring(@cadena, 1, @pos) as int)
		select @pos = @pos + 1
	end
	
	return @DigitosEncontrados
end

GO
/****** Object:  UserDefinedFunction [dbo].[fnGetFundamentosLegalesDeClasificacion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnGetFundamentosLegalesDeClasificacion](@IdExpediente INT, @Separador CHAR(1))
RETURNS VARCHAR(255)  WITH ENCRYPTION
AS
BEGIN
	DECLARE @Temp TABLE (Descripcion VARCHAR(255), IdExpediente INT, IdFundamento INT)
	DECLARE @Count INT, @Cadena VARCHAR(255), @Id1 INT, @Id2 INT
	SELECT @Cadena = ''
	SELECT @Count = 0
	
	INSERT @Temp
	SELECT f.Descripcion, f.idFundamentosLegalesDeClasificacion, r.idExpediente
		FROM FundamentosLegalesDeClasificacion_Expedientes_Relaciones r
			JOIN FundamentosLegalesDeClasificacion f
				ON r.idFundamentosLegalesDeClasificacion = f.idFundamentosLegalesDeClasificacion
		WHERE r.idExpediente = @IdExpediente
	SELECT @Count = @@ROWCOUNT
	
	WHILE @Count > 0
	BEGIN
		SELECT TOP 1 @Cadena = 
			(CASE 
				WHEN @Cadena = '' THEN @Cadena + Descripcion
				ELSE @Cadena + @Separador + Descripcion
			END),
			@Id1 = IdExpediente,
			@Id2 = IdFundamento
		FROM @Temp
		DELETE @Temp WHERE idExpediente = @Id1 AND IdFundamento = @Id2
		SELECT @Count = @Count - 1	
	END
	
	RETURN @Cadena
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetIDJerarquia]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnGetIDJerarquia](@NombreDeJerarquia AS VARCHAR(255))  
RETURNS INT WITH ENCRYPTION
--Esta función devuelve el id de un código tecleado completo (toda la jerarquía). Si no lo encuentra devuelve -1.
AS  
BEGIN 
	DECLARE @idPadre INT, @idJerarquia INT, @i INT, @j INT
	DECLARE @aux VARCHAR(255)
	DECLARE @NivelUnico BIT
	--Asumo que el separador de jerarquías es el caracter "."
	DECLARE @Separador VARCHAR(5)
	SELECT @Separador = '.'
	--Si el último caracter es diferente del separador, continúo.
	IF (SUBSTRING(@NombreDeJerarquia, LEN(@NombreDeJerarquia), 1) = @Separador)
		SELECT @idJerarquia = -1
	ELSE
	BEGIN
		--Identifica el primer segmento, padre de todos los demás.
		SELECT @i = charindex(@Separador, @NombreDeJerarquia)
		IF (@i > 0)  --Tiene al menos un separador, lo que implica dos niveles.
		BEGIN
			SELECT @NivelUnico = 0
			SELECT @idPadre = idClasificacion
				FROM CuadroClasificacion
				WHERE nombre = SUBSTRING(@NombreDeJerarquia, 1, @i - 1)
					AND (idPadre IS NULL)
		END
		ELSE	--No tienen separador, así que es nivel único
		BEGIN
			SELECT @NivelUnico = 1	
			SELECT @idJerarquia = idClasificacion
				FROM CuadroClasificacion
				WHERE nombre = @NombreDeJerarquia
					AND (idPadre IS NULL)
			IF @@ROWCOUNT = 0
				SELECT @idJerarquia = -1
		END
		--Una vez obtenido el padre, me muevo hacia adentro, nivel por nivel hasta el último con el que salgo del WHILE.
		WHILE (@NivelUnico = 0)
		BEGIN
			SELECT @aux = SUBSTRING(@NombreDeJerarquia, @i + 1, LEN(@NombreDeJerarquia) - @i + 1)  
			SELECT @j = CHARINDEX(@Separador, @aux)
			IF (@j > 0)
			BEGIN
				SELECT @aux = SUBSTRING(@aux, 1, @j - 1)
	
				SELECT @IDJerarquia = idClasificacion
					FROM CuadroClasificacion
					WHERE nombre = @aux
						AND  idPadre = @IDPadre
	
				SELECT @IDPadre = @IDJerarquia
				SELECT @i = @i + @j
			END
			ELSE
			BEGIN
				SELECT @idJerarquia = idClasificacion
					FROM CuadroClasificacion
					WHERE nombre = @aux
						AND  idPadre = @IDPadre
				IF @@ROWCOUNT = 0
					SELECT @idJerarquia = -1
				BREAK
				
			END  --ELSE 
		END --WHILE (@i < ...
	END --IF (SUBSTRING(@NombreDeJerarquia ...
	RETURN @idJerarquia
END -- function
GO
/****** Object:  UserDefinedFunction [dbo].[fnNivelDeJerarquia]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnNivelDeJerarquia](@idClasificacion as int) 
returns int WITH ENCRYPTION
as  

begin 
	declare @idPadre int
	declare @NivelDeJerarquia int

	select @NivelDeJerarquia = 1

	select @idPadre = idPadre
	from CuadroClasificacion
	where idClasificacion = @idClasificacion

	while (@idPadre is not null)
	begin
		select @idClasificacion = @idPadre
		
		select @idPadre = idPadre
		from CuadroClasificacion
		where idClasificacion = @idClasificacion

		select @NivelDeJerarquia = @NivelDeJerarquia + 1

	end

  return @NivelDeJerarquia

end

GO
/****** Object:  UserDefinedFunction [dbo].[fnNombreDeJerarquia]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnNombreDeJerarquia](@idClasificacion as int)
returns varchar(255) WITH ENCRYPTION
as  
begin 
	declare @idPadre int
	declare @NomenclaturaDeJerarquia varchar(255)
	select @idPadre = idPadre, @NomenclaturaDeJerarquia = nombre
	from CuadroClasificacion
	where idClasificacion = @idClasificacion
	while (@idPadre is not null)
	begin
		select @idClasificacion = @idPadre
		
		select @idPadre = idPadre, @NomenclaturaDeJerarquia = nombre + '.' + @NomenclaturaDeJerarquia
		from CuadroClasificacion
		where idClasificacion = @idClasificacion
	end
  return @NomenclaturaDeJerarquia
end
GO
/****** Object:  UserDefinedFunction [dbo].[fnNombreDeJerarquiaMaxima]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnNombreDeJerarquiaMaxima](@IdClasificacion INT)
RETURNS VARCHAR(1024) WITH ENCRYPTION
AS   
BEGIN
	DECLARE @NomenclaturaDeJerarquia VARCHAR(255), @Niveles INT, @i INT, @Aux VARCHAR(255), @Aux2 VARCHAR(255), @Nivel INT
	SELECT @Nivel = 0
	SELECT @NomenclaturaDeJerarquia = dbo.fnNombreDeJerarquia(@idClasificacion)
	WHILE (CHARINDEX('.', @NomenclaturaDeJerarquia) > 1)
	BEGIN
		SELECT @Nivel = @Nivel + 1
		SELECT @NomenclaturaDeJerarquia = SUBSTRING(@NomenclaturaDeJerarquia, CHARINDEX('.', @NomenclaturaDeJerarquia) + 1, LEN(@NomenclaturaDeJerarquia))
	END
	SELECT @Nivel = @Nivel + 1
	SELECT @NomenclaturaDeJerarquia = dbo.fnNombreDeJerarquia(@IdClasificacion) + '.'
	SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
	SELECT @Aux = ''
	SELECT @Niveles = 0
	WHILE (@Niveles < @Nivel + 1)
	BEGIN
		SELECT @Niveles = @Niveles + 1
		SELECT @Aux2 = @Aux
		IF @i <> 0
		BEGIN
			SELECT @Aux = @Aux + SUBSTRING(@NomenclaturaDeJerarquia, 1, @i)
			SELECT @NomenclaturaDeJerarquia = SUBSTRING(@NomenclaturaDeJerarquia, @i + 1, LEN(@NomenclaturaDeJerarquia))
			SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
		END
		ELSE
			BREAK
	END
	RETURN (SELECT @Aux2 + SPACE(1) + c.Descripcion
		FROM CuadroClasificacion c
		WHERE c.idClasificacion = dbo.fnGetIDJerarquia(SUBSTRING(@Aux2, 1, LEN(@Aux2) - 1)))
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnNombreDeJerarquiaPorNivel]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- DROP FUNCTION [dbo].[fnNombreDeJerarquiaPorNivel]
ALTER FUNCTION [dbo].[fnNombreDeJerarquiaPorNivel]
(
	@IdClasificacion INT, @Nivel INT
)
RETURNS NVARCHAR(50) WITH ENCRYPTION
AS  
BEGIN
	DECLARE @NomenclaturaDeJerarquia VARCHAR(255), @Niveles INT, @i INT, @Aux VARCHAR(255), @Aux2 VARCHAR(255)

	SELECT @NomenclaturaDeJerarquia = dbo.fnNombreDeJerarquia(@IdClasificacion) + '.'

	SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
	SELECT @Aux = ''
	SELECT @Niveles = 0
	WHILE (@Niveles < @Nivel + 1)
	BEGIN
		SELECT @Niveles = @Niveles + 1
		SELECT @Aux2 = @Aux
		IF @i <> 0
		BEGIN
			SELECT @Aux = @Aux + SUBSTRING(@NomenclaturaDeJerarquia, 1, @i)
			SELECT @NomenclaturaDeJerarquia = SUBSTRING(@NomenclaturaDeJerarquia, @i + 1, LEN(@NomenclaturaDeJerarquia))
			SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
		END
		ELSE
			BREAK
	END
	RETURN (SELECT @Aux2 + SPACE(1) + c.Descripcion
		FROM CuadroClasificacion c
		WHERE c.idClasificacion = dbo.fnGetIDJerarquia(SUBSTRING(@Aux2, 1, LEN(@Aux2) - 1)))

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnNuevoNumeroDeExpediente]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnNuevoNumeroDeExpediente](@IdClasificacion INT, @FechaApertura DATETIME)
RETURNS  @NuevoExpediente TABLE
	(
		IdClasificacion INT,
		Ano INT,
		Consecutivo INT,
		NuevoNumero VARCHAR(11), 
		Insertar BIT
	) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Consecutivo INT
	SELECT @Consecutivo = ISNULL((SELECT c.Consecutivo 
					FROM ConsecutivosPorAnoYClasificacion c 
					WHERE c.idClasificacion = @IdClasificacion 
					AND c.Ano = YEAR(@FechaApertura)),
				-1)
	IF (@Consecutivo = -1)
		SET @Consecutivo = 0
	
	--Incremento el consecutivo
	SELECT @Consecutivo = @Consecutivo + 1
	--Preparo el nombre del Expediente
	INSERT @NuevoExpediente
	VALUES (
		@IdClasificacion,
		YEAR(@FechaApertura),
		@Consecutivo,
		LTRIM(RTRIM(STR(YEAR(@FechaApertura)))) + '/' + REPLICATE('0', 6 - LEN(LTRIM(RTRIM(STR(@Consecutivo))))) + LTRIM(RTRIM(STR(@Consecutivo))), CASE WHEN @Consecutivo = 1 THEN 1 ELSE 0 END)
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnOrdenamientoDeJerarquia]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnOrdenamientoDeJerarquia](@idClasificacion AS INT)
RETURNS NVARCHAR(10) WITH ENCRYPTION
AS
BEGIN
	RETURN SUBSTRING(dbo.fnNombreDeJerarquia(@idClasificacion), 7, 1) + SUBSTRING(dbo.fnNombreDeJerarquia(@idClasificacion), 5, 2) + SUBSTRING(dbo.fnNombreDeJerarquia(@idClasificacion), 9, LEN(dbo.fnNombreDeJerarquia(@idClasificacion)))
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitIDs]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnSplitIDs]
(
	@IdList VARCHAR(8000),
	@Delimiter CHAR(1)
)
RETURNS 
@ParsedList TABLE
(
	IdListed INT
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @OrderID VARCHAR(20), @Pos INT
	SET @IdList = LTRIM(RTRIM(@IdList))+ @Delimiter
	SET @Pos = CHARINDEX(@Delimiter, @IdList, 1)
	IF REPLACE(@IdList, @Delimiter, '') <> ''
	BEGIN
		WHILE @Pos > 0
		BEGIN
			SET @OrderID = LTRIM(RTRIM(LEFT(@IdList, @Pos - 1)))
			IF @OrderID <> ''
			BEGIN
				INSERT INTO @ParsedList (IdListed) 
				VALUES (CAST(@OrderID AS INT))
			END
			SET @IdList = RIGHT(@IdList, LEN(@IdList) - @Pos)
			SET @Pos = CHARINDEX(@Delimiter, @IdList, 1)
		END
	END	
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitTextIDS]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnSplitTextIDS] (@IdListText TEXT, @Delimiter CHAR(1))
RETURNS @OutputList TABLE
	(
		IdListed INT PRIMARY KEY CLUSTERED
	) WITH ENCRYPTION
AS
BEGIN
	DECLARE @ParsedList TABLE
		(
			IdListed INT PRIMARY KEY CLUSTERED
		)
	DECLARE @MaxLength INT
	DECLARE @IdFound VARCHAR(20), @IdList VARCHAR(8000), @IdListAux VARCHAR(8000)
	DECLARE @i INT, @j INT
	SELECT @MaxLength = 7000
	SELECT @j = 1
	WHILE(@j < DATALENGTH(@IdListText))
	BEGIN
		SELECT @IdList = RTRIM(LTRIM(SUBSTRING(@IdListText, @j, @MaxLength)))
		SELECT @IdList = RTRIM(LTRIM(SUBSTRING(@IdList, 1, LEN(@IdList) - CHARINDEX(@Delimiter, REVERSE(@IdList)))))
		IF LEN(@IdList) > 0
		BEGIN
			SELECT @j = @j + LEN(@IdList)
			IF SUBSTRING(@IdList, 1, 1) = @Delimiter  --Elimina el delimitador en caso de que la línea comienze con él.
				SELECT @IdList = RTRIM(LTRIM(SUBSTRING(@IdList, 2, LEN(@IdList))))
			SELECT @IdListAux = LTRIM(RTRIM(@IdList))+ @Delimiter
			SELECT @i = CHARINDEX(@Delimiter, @IdListAux)
			IF REPLACE(@IdListAux, @Delimiter, '') <> ''
				WHILE @i > 0
				BEGIN
					SELECT @IdFound = LTRIM(RTRIM(LEFT(@IdListAux, @i - 1)))
					IF @IdFound <> ''
						INSERT INTO @ParsedList (IdListed) 
							SELECT (CAST(@IdFound AS INT))
								WHERE CAST(@IdFound AS INT) NOT IN (SELECT IdListed FROM @ParsedList)
					SELECT @IdListAux = RIGHT(@IdListAux, LEN(@IdListAux) - @i)
					SELECT @i = CHARINDEX(@Delimiter, @IdListAux)
				END  --WHILE @i...
		END --IF LEN(@IdList...
		ELSE
			BREAK
	END --WHILE(@j < DATALENGTH...)
	SELECT @IdList = SUBSTRING(@IdListText, @j, DATALENGTH(@IdListText))
	IF SUBSTRING(@IdList, 1, 1) = @Delimiter  --Elimina el delimitador en caso de que la línea comienze con él.
		SELECT @IdList = RTRIM(LTRIM(SUBSTRING(@IdList, 2, LEN(@IdList))))
	SELECT @IdListAux = LTRIM(RTRIM(@IdList))+ @Delimiter
	SELECT @i = CHARINDEX(@Delimiter, @IdListAux)
	IF REPLACE(@IdListAux, @Delimiter, '') <> ''
	WHILE @i > 0
	BEGIN
		SET @IdFound = LTRIM(RTRIM(LEFT(@IdListAux, @i - 1)))
		IF @IdFound <> ''
			INSERT INTO @ParsedList (IdListed) 
				SELECT (CAST(@IdFound AS INT))
					WHERE CAST(@IdFound AS INT) NOT IN (SELECT IdListed FROM @ParsedList)
		SET @IdListAux = RIGHT(@IdListAux, LEN(@IdListAux) - @i)
		SET @i = CHARINDEX(@Delimiter, @IdListAux, 1)
	END	
	--Inserta en la tabla de de salida los ids ordenados
	INSERT INTO @OutputList
		SELECT * FROM @ParsedList ORDER BY 1
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitTextString]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fnSplitTextString] (@IdListText NVARCHAR(MAX), @Delimiter CHAR(1))
RETURNS @OutputList TABLE
	(
		IdListed NVARCHAR(250)
	) WITH ENCRYPTION
AS
BEGIN
	DECLARE @ParsedList TABLE
		(
			IdListed NVARCHAR(250)
		)
	DECLARE @MaxLength INT
	DECLARE @IdFound VARCHAR(250), @IdList VARCHAR(MAX), @IdListAux VARCHAR(MAX)
	DECLARE @i INT, @j INT
	SELECT @MaxLength = 7000
	SELECT @j = 1
	WHILE(@j < DATALENGTH(@IdListText))
	BEGIN
		SELECT @IdList = RTRIM(LTRIM(SUBSTRING(@IdListText, @j, @MaxLength)))
		SELECT @IdList = RTRIM(LTRIM(SUBSTRING(@IdList, 1, LEN(@IdList) - CHARINDEX(@Delimiter, REVERSE(@IdList)))))
		IF LEN(@IdList) > 0
		BEGIN
			SELECT @j = @j + LEN(@IdList)
			IF SUBSTRING(@IdList, 1, 1) = @Delimiter  --Elimina el delimitador en caso de que la línea comienze con él.
				SELECT @IdList = RTRIM(LTRIM(SUBSTRING(@IdList, 2, LEN(@IdList))))
			SELECT @IdListAux = LTRIM(RTRIM(@IdList))+ @Delimiter
			SELECT @i = CHARINDEX(@Delimiter, @IdListAux)
			IF REPLACE(@IdListAux, @Delimiter, '') <> ''
				WHILE @i > 0
				BEGIN
					SELECT @IdFound = LTRIM(RTRIM(LEFT(@IdListAux, @i - 1)))
					IF @IdFound <> ''
						INSERT INTO @ParsedList (IdListed) 
							SELECT @IdFound
								WHERE @IdFound NOT IN (SELECT IdListed FROM @ParsedList)
					SELECT @IdListAux = RIGHT(@IdListAux, LEN(@IdListAux) - @i)
					SELECT @i = CHARINDEX(@Delimiter, @IdListAux)
				END  --WHILE @i...
		END --IF LEN(@IdList...
		ELSE
			BREAK
	END --WHILE(@j < DATALENGTH...)
	SELECT @IdList = SUBSTRING(@IdListText, @j, DATALENGTH(@IdListText))
	IF SUBSTRING(@IdList, 1, 1) = @Delimiter  --Elimina el delimitador en caso de que la línea comienze con él.
		SELECT @IdList = RTRIM(LTRIM(SUBSTRING(@IdList, 2, LEN(@IdList))))
	SELECT @IdListAux = LTRIM(RTRIM(@IdList))+ @Delimiter
	SELECT @i = CHARINDEX(@Delimiter, @IdListAux)
	IF REPLACE(@IdListAux, @Delimiter, '') <> ''
	WHILE @i > 0
	BEGIN
		SET @IdFound = LTRIM(RTRIM(LEFT(@IdListAux, @i - 1)))
		IF @IdFound <> ''
			INSERT INTO @ParsedList (IdListed) 
				SELECT @IdFound
					WHERE @IdFound NOT IN (SELECT IdListed FROM @ParsedList)
		SET @IdListAux = RIGHT(@IdListAux, LEN(@IdListAux) - @i)
		SET @i = CHARINDEX(@Delimiter, @IdListAux, 1)
	END	
	--Inserta en la tabla de de salida los ids ordenados
	INSERT INTO @OutputList
		SELECT * FROM @ParsedList ORDER BY 1
	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnSubArbolDeCuentas]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION  [dbo].[fnSubArbolDeCuentas](@id as int)
returns @Resultados table (	idClasificacion				int, 
				idPadre					int, 
				Nombre					varchar(50), 
				Descripcion				varchar(250), 
--				idValorDocumental			integer,
				idPlazoDeConservacionTramite		integer,
				idPlazoDeConservacionConcentracion	integer,
				idDestinoFinal				integer,
				idInformacionClasificada		integer,
				Hijos					integer,
				Afectable				bit,
				Nivel					tinyint
				) WITH ENCRYPTION
as
begin
--set nocount on
declare @NivelMaximo int
declare @Nivel tinyint
set @Nivel = 1
declare @Contador int
--Inserta nodo inicial pasado como parámetro
insert into @Resultados 
select  
	c.idClasificacion,
	idPadre= ISNULL(c.idPadre,0),
	c.Nombre, 
	c.Descripcion, 
--	c.idValorDocumental,
	c.idPlazoDeConservacionTramite,
	c.idPlazoDeConservacionConcentracion,
	c.idDestinoFinal,
	c.idInformacionClasificada,
	Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
	Afectable = 
		CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion) > 0 THEN
			0
		ELSE
			1
		END,
	@Nivel 
from
	CuadroClasificacion c
--	JOIN Cat_Clasificacion_Cuentas ccc
--	ON c.idClasificacion = ccc.idClasificacion
--	JOIN Cat_Monedas cm
--	ON c.idMoneda = cm.idMoneda
where c.idClasificacion = @id
select @Contador = @@ROWCOUNT
while @Contador > 0
begin
      	--Inserta los nodos hijos del nodo actual
	insert into @Resultados 
	select  
		c.idClasificacion,
		idPadre= ISNULL(c.idPadre,0),
		c.Nombre, 
		c.Descripcion, 
--		c.idValorDocumental,
		c.idPlazoDeConservacionTramite,
		c.idPlazoDeConservacionConcentracion,
		c.idDestinoFinal,
		c.idInformacionClasificada,
--		ccc.Clasificacion,
--		ccc.Naturaleza,
--		ccc.Balance,
--		c.Activa,
--		c.idMoneda,
--		DescripcionMoneda = cm.Descripcion,
		Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
		Afectable = 
			CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion) > 0 THEN
				0
			ELSE
				1
			END,
		@Nivel + 1
	from 
		CuadroClasificacion c
		join @Resultados r 
		on c.idPadre = r.idClasificacion
--		JOIN Cat_Clasificacion_Cuentas ccc
--		ON c.idClasificacion = ccc.idClasificacion
	
--		JOIN Cat_Monedas cm
--		ON c.idMoneda = cm.idMoneda
	where r.Nivel = @Nivel
	
        select @Contador = @@ROWCOUNT, @Nivel = @Nivel + 1
end -- while
/*
select @NivelMaximo = max(Nivel) from @Resultados
if (@NivelDeSalida <= 0)	--Entrega todos los niveles
	select r.*, NivelMaximo = @NivelMaximo  from @Resultados r
	order by Nivel, Nombre
else				--Entrega SOLAMENTE el nivel especificado
	select r.*, NivelMaximo = @NivelMaximo from @Resultados r
	where r.Nivel = @NivelDeSalida
	order by Nombre
*/
return
end
GO
/****** Object:  StoredProcedure [dbo].[ActualizaEstatusExpedientesVencidos]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[ActualizaEstatusExpedientesVencidos]
	@FechaDeCorrida DATETIME WITH ENCRYPTION
AS
BEGIN
	
	--Marca los vencidos en trámite
	UPDATE e SET e.idEstatusExpediente = 2
	FROM Expedientes e
		JOIN PlazosDeConservacionTramite c ON e.idPlazoTramite = c.idPlazosDeConservacionTramite
	WHERE
		e.FechaCierreChecked = 1
		AND e.idEstatusExpediente = 1
		AND DATEDIFF(DAY, e.FechaCierre, @FechaDeCorrida) >= c.Dias

	--Marca los vencidos en concentración
	UPDATE e SET e.idEstatusExpediente = 5
	FROM Expedientes e
		JOIN PlazosDeConservacionConcentracion c ON e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion
	WHERE
		e.idEstatusExpediente = 4
		AND DATEDIFF(DAY, e.FechaCierre, @FechaDeCorrida) >= c.Dias
		
	
END



GO
/****** Object:  StoredProcedure [dbo].[AsignaCaja]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[AsignaCaja]

@Lista			TEXT,
@Caja			varchar(25),
@id_record_procesadoOK	integer = 0	output WITH ENCRYPTION

AS

DECLARE @err1	int
	
	BEGIN TRAN
	
	UPDATE 
		Expedientes
	SET 
		Caja = @Caja
	FROM
		Expedientes e
		JOIN dbo.fnSplitTextIDS(@Lista,',') e1
		ON e.idExpediente = e1.idListed

	SET @err1 = @@error 
	
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = 1
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			SELECT @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[AsignaOrdenDeDespliegue]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[AsignaOrdenDeDespliegue]
	@idClasificacion AS INT WITH ENCRYPTION

AS
	DECLARE @Nombre AS VARCHAR(255)

	SELECT @Nombre = UPPER(c.Nombre)
	FROM CuadroClasificacion c
	WHERE c.idClasificacion = @idClasificacion

	UPDATE CuadroClasificacion
		SET OrdenDeDespliegue =
	 		CASE 
				WHEN CHARINDEX('S', @Nombre) <> 0 THEN 5
				WHEN CHARINDEX('C', @Nombre) <> 0 THEN 10
				WHEN CHARINDEX('N', @Nombre) <> 0 THEN 15
				ELSE 0
			END
		WHERE idClasificacion = @idClasificacion

RETURN


GO
/****** Object:  StoredProcedure [dbo].[AsignarCajaConcentracion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Este sp reemplaza a "AsignaCaja"  						*/
/* Actualiza campo válido para archivo de concentración				*/
/* David R. Ahuja A. 14-agosto-2006 						*/
ALTER PROCEDURE [dbo].[AsignarCajaConcentracion]
	@Lista TEXT,
	@Caja NVARCHAR(25),
	@err1 INTEGER = 0 OUTPUT WITH ENCRYPTION
AS
BEGIN
	BEGIN TRANSACTION
	
		UPDATE 
			Expedientes
		SET 
			Caja = @Caja
		FROM
			Expedientes e
			JOIN dbo.fnSplitTextIDS(@Lista,',') e1
			ON e.idExpediente = e1.idListed
	
		SET @err1 = @@ERROR
	
	IF @err1 = 0
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[AsignarCajaTramite]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Este sp reemplaza a "AsignaCaja"  					*/
/* Actualiza la información para archivo de trámite 			*/
/* David R. Ahuja A. 14-agosto-2006  					*/
ALTER PROCEDURE [dbo].[AsignarCajaTramite]
	@Lista TEXT,
	@Caja NVARCHAR(25),
	@err1 INTEGER = 0 OUTPUT WITH ENCRYPTION
AS
BEGIN
	BEGIN TRANSACTION
	
		UPDATE 
			e
		SET 
			RelacionAnterior = @Caja
		FROM
			Expedientes e
			JOIN dbo.fnSplitTextIDS(@Lista,',') e1
			ON e.idExpediente = e1.idListed
	
		SET @err1 = @@ERROR
	
	IF @err1 = 0
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION
END
GO
/****** Object:  StoredProcedure [dbo].[Batch_SeleccionaExpedientesVencidosConcentracion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC Batch_SeleccionaExpedientesVencidosConcentracion 240, '2021-12-31'
--DROP PROCEDURE Batch_SeleccionaExpedientesVencidosConcentracion
ALTER PROCEDURE [dbo].[Batch_SeleccionaExpedientesVencidosConcentracion]
	@IdUnidAdm INT,
	@FechaDeCorte DATETIME,
	@Caja NVARCHAR(20) = '' WITH ENCRYPTION
AS
BEGIN
	SELECT e.idExpediente,
		e.Caja + ' - '
		+ (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
		+ e.Nombre + ' - ' 
		+ CONVERT(varchar(10),e.FechaCierre,103) + ' - '
		+ c.descripcion + '(T) - ' 
		+ pcc.descripcion + '(C) - ' 
		+ d.Descripcion + '(F) - '
		+ e.CampoAdicional1) as Expediente
	FROM Expedientes e
			INNER JOIN PlazosDeConservacionTramite c ON e.idPlazoTramite = c.idPlazosDeConservacionTramite
			INNER JOIN PlazosDeConservacionConcentracion pcc ON e.idPlazoConcentracion = pcc.idPlazosDeConservacionConcentracion
			INNER JOIN DestinoFinal d ON e.idDestinoFinal = d.idDestinoFinal
	WHERE e.FechaCierreChecked = 1
		AND e.idUnidadAdministrativa = @idUnidAdm
		AND DATEDIFF(DAY, e.FechaCierre, @FechaDeCorte) >= c.Dias + pcc.Dias
		AND e.idEstatusExpediente = 4
		AND e.idExpediente NOT IN (
			SELECT idExpediente 
			FROM Batches_Relaciones br 
				INNER JOIN Batches b ON br.idBatch = br.idBatch 
			WHERE b.idTipoDeBatch = 2 AND b.idUnidAdm = @idUnidAdm)
		AND e.Caja = CASE
				WHEN ISNULL(@Caja, '') = '' THEN e.Caja
				ELSE @Caja
			END
		AND d.idDestinoFinal = 2
	ORDER BY e.Caja,
		dbo.fnNombreDeJerarquia(e.idClasificacion), 
		e.Nombre, 
		e.FechaCierre;
END
GO
/****** Object:  StoredProcedure [dbo].[Batch_SeleccionaExpedientesVencidosConcentracionHistorico]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC Batch_SeleccionaExpedientesVencidosConcentracionHistorico 240, '2021-12-31'
--DROP PROCEDURE Batch_SeleccionaExpedientesVencidosConcentracionHistorico
ALTER PROCEDURE [dbo].[Batch_SeleccionaExpedientesVencidosConcentracionHistorico]
	@IdUnidAdm INT,
	@FechaDeCorte DATETIME,
	@Caja NVARCHAR(20) = '' WITH ENCRYPTION
AS
BEGIN
	SELECT e.idExpediente,
		e.Caja + ' - '
		+ (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
		+ e.Nombre + ' - ' 
		+ CONVERT(varchar(10),e.FechaCierre,103) + ' - '
		+ c.descripcion + '(T) - ' 
		+ pcc.descripcion + '(C) - ' 
		+ d.Descripcion + '(F) - '
		+ e.CampoAdicional1) as Expediente
	FROM Expedientes e
			INNER JOIN PlazosDeConservacionTramite c ON e.idPlazoTramite = c.idPlazosDeConservacionTramite
			INNER JOIN PlazosDeConservacionConcentracion pcc ON e.idPlazoConcentracion = pcc.idPlazosDeConservacionConcentracion
			INNER JOIN DestinoFinal d ON e.idDestinoFinal = d.idDestinoFinal
	WHERE e.FechaCierreChecked = 1
		AND e.idUnidadAdministrativa = @idUnidAdm
		AND DATEDIFF(DAY, e.FechaCierre, @FechaDeCorte) >= c.Dias + pcc.Dias
		AND e.idEstatusExpediente = 4
		AND e.idExpediente NOT IN (
			SELECT idExpediente 
			FROM Batches_Relaciones br 
				INNER JOIN Batches b ON br.idBatch = br.idBatch 
			WHERE b.idTipoDeBatch = 2 AND b.idUnidAdm = @idUnidAdm)
		AND e.Caja = CASE
				WHEN ISNULL(@Caja, '') = '' THEN e.Caja
				ELSE @Caja
			END
		AND d.idDestinoFinal = 3
	ORDER BY e.Caja,
		dbo.fnNombreDeJerarquia(e.idClasificacion), 
		e.Nombre, 
		e.FechaCierre;
END
GO
/****** Object:  StoredProcedure [dbo].[Batch_SeleccionaExpedientesVencidosTramite]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batch_SeleccionaExpedientesVencidosTramite
ALTER PROCEDURE [dbo].[Batch_SeleccionaExpedientesVencidosTramite]
	@IdUnidAdm INT,
	@FechaDeCorte DATETIME,
	@Caja NVARCHAR(20) WITH ENCRYPTION
AS
BEGIN
	SELECT e.idExpediente,
		e.RelacionAnterior + ' - '
		+ (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
		+ e.Nombre + ' - ' 
		+ CONVERT(NVARCHAR(10), e.FechaCierre,103) + ' - '
		+ c.descripcion + ' - '
		+ e.Asunto) as Expediente
	FROM Expedientes e
		INNER JOIN PlazosDeConservacionTramite c ON e.idPlazoTramite = c.idPlazosDeConservacionTramite
	WHERE e.FechaCierreChecked = 1
		AND e.idUnidadAdministrativa = @IdUnidAdm
		AND DATEDIFF(DAY, e.FechaCierre, @FechaDeCorte) >= c.Dias
		AND (e.idEstatusExpediente = 1 OR e.idEstatusExpediente = 2)
		AND e.idExpediente NOT IN (
			SELECT idExpediente 
			FROM Batches_Relaciones br 
				INNER JOIN Batches b ON br.idBatch = br.idBatch 
			WHERE b.idTipoDeBatch = 1 AND b.idUnidAdm = @IdUnidAdm)
		AND e.Caja = CASE
				WHEN ISNULL(@Caja, '') = '' THEN e.Caja
				ELSE @Caja
			END
	ORDER BY e.Caja,
		dbo.fnNombreDeJerarquia(e.idClasificacion), 
		e.nombre, 
		e.FechaCierre;

END




GO
/****** Object:  StoredProcedure [dbo].[Batches_Delete]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_DELETE
ALTER PROCEDURE [dbo].[Batches_Delete]
(
	@IdBatch INT,
	@IdRecordProcesadoOK INT = 0 OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Err1 INT = 0;

	BEGIN TRAN

	--Borro las relaciones del lote
	DELETE Batches_Relaciones
	WHERE idBatch = @IdBatch;

	SET @Err1 = @@ERROR;

	--Borro el lote
	DELETE Batches
	WHERE idBatch = @IdBatch;

	SET @Err1 = @Err1 + @@ERROR;

	--Sin error
	IF @Err1 = 0
	BEGIN
		COMMIT TRAN;
		--Devuelvo el id eliminado
		SET @IdRecordProcesadoOK = @IdBatch;
	END
	ELSE
	BEGIN
		ROLLBACK TRAN;
		--Devuelvo 0 si hubo error
		SET @IdRecordProcesadoOK = 0;
	END
END

GO
/****** Object:  StoredProcedure [dbo].[Batches_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_INSERT
ALTER PROCEDURE [dbo].[Batches_INSERT]
(
	@Descripcion NVARCHAR(50),
	@IdOperador INT,
	@FechaCreacion DATETIME,
	@IdTipoDeBatch INT,
	@IdUnidAdm INT,
	@FechaCorte	DATETIME,
	@IdRecordOK INT = 0 OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @err1 INT;
	SET @err1 = 0;

	BEGIN TRAN

	INSERT Batches (
		Descripcion,
		idOperador,
		FechaCreacion,
		idTipoDeBatch,
		idUnidAdm,
		FechaCorte
	)
	VALUES (
		@Descripcion,
		@idOperador,
		@FechaCreacion,
		@idTipoDeBatch,
		@idUnidAdm,
		@FechaCorte
	);

	SET @err1 = @@ERROR;
	IF @err1 = 0
	BEGIN
		COMMIT TRAN;
		/* Devuelvo el nuevo id como resultado */
		SELECT @IdRecordOK = MAX(idBatch) FROM Batches;
	END
	ELSE
	BEGIN
		ROLLBACK TRAN;
		/* Devuelvo 0 para señalar que hubo error */
		SELECT @IdRecordOK = 0;
	END
END

GO
/****** Object:  StoredProcedure [dbo].[Batches_ListaTramiteConcentracion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batch_ListaTramiteConcentracion
ALTER PROCEDURE [dbo].[Batches_ListaTramiteConcentracion]
(
	@IdBatch INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT 
	Unidad = (SELECT u.Descripcion
		FROM UnidadesAdministrativas u
		WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
	Procedencia = e.RelacionAnterior,
	Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
	Serie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
		END,
	Subserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
		END,
	Subsubserie =
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
		END,
	Subsubsubserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
		END,
	Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
	ValorPrimario =
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN 'A'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN 'C'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN 'L'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN 'H'
			ELSE ' '
		END,
	VigenciaDocumental =
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
	Expediente = e.Nombre,
	FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
	FechaCierre = CONVERT(VARCHAR(10), e.FechaCierre , 3),
	e.Asunto,
	e.CajaAnterior,
	UbicacionAnterior = e.RelacionAnterior,
	CajaNueva = e.Caja,
	FechaDeCorte =  CONVERT(VARCHAR(10), b.FechaCorte , 3),
	PlazoTramite = pct.Descripcion,
	PlazoConcentracion = pcc.Descripcion,
	CajaProv = br.CajaProv

	FROM
		Expedientes e
		JOIN Batches_Relaciones br
		ON e.idExpediente = br.idExpediente
		JOIN Batches b
		ON b.idBatch = br.idBatch
		JOIN PlazosDeConservacionTramite pct
		ON e.idPlazoTramite = pct.idPlazosDeConservacionTramite
		JOIN PlazosDeConservacionConcentracion pcc
		ON e.idPlazoConcentracion = pcc.idPlazosDeConservacionConcentracion
	WHERE
		b.idBatch = @idBatch
		and b.idTipoDeBatch = 1

END



GO
/****** Object:  StoredProcedure [dbo].[Batches_ListaTraspasoTerminado]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_ListaTraspasoTerminado
ALTER PROCEDURE [dbo].[Batches_ListaTraspasoTerminado]
(
	@IdBatch INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT Unidad = (SELECT u.Descripcion
			FROM UnidadesAdministrativas u
			WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
		Procedencia = e.RelacionAnterior,
		Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
		Serie = 
			CASE 
				WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
				ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
			END,
		Subserie = 
			CASE 
				WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
				ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
			END,
		Subsubserie =
			CASE 
				WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
				ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
			END,
		Subsubsubserie = 
			CASE 
				WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
				ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
			END,
		Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
		ValorPrimario =
			CASE
				WHEN 
					(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 1)
					= 1 THEN 'A'
				ELSE ' '
			END
			+
			CASE
				WHEN 
					(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 2)
					= 1 THEN 'C'
				ELSE ' '
			END
			+
			CASE
				WHEN 
					(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 3)
					= 1 THEN 'L'
				ELSE ' '
			END
			+
			CASE
				WHEN 
					(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 4)
					= 1 THEN 'H'
				ELSE ' '
			END,
		VigenciaDocumental =
			(SELECT UPPER(c.Descripcion)
				FROM PlazosDeConservacionConcentracion c
				WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
		Expediente = e.Nombre,
		FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
		FechaCierre = CONVERT(VARCHAR(10), e.FechaCierre , 3),
		e.Asunto,
		e.CajaAnterior,
		UbicacionAnterior = e.RelacionAnterior,
		CajaNueva = e.Caja,
		FechaDeCorte =  CONVERT(VARCHAR(10), b.FechaCorte , 3),
		PlazoTramite = pct.Descripcion,
		PlazoConcentracion = pcc.Descripcion,
		CajaProv = e.Caja
	FROM Expedientes e
		INNER JOIN Batches_Relaciones br ON e.idExpediente = br.idExpediente
		INNER JOIN Batches b ON b.idBatch = br.idBatch
		INNER JOIN PlazosDeConservacionTramite pct ON e.idPlazoTramite = pct.idPlazosDeConservacionTramite
		INNER JOIN PlazosDeConservacionConcentracion pcc ON e.idPlazoConcentracion = pcc.idPlazosDeConservacionConcentracion
	WHERE b.idBatch = @idBatch
	ORDER BY e.Nombre;
END



GO
/****** Object:  StoredProcedure [dbo].[Batches_Pendientes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC Batches_Pendientes 240, 1
--DROP PROCEDURE Batches_Pendientes
ALTER PROCEDURE [dbo].[Batches_Pendientes]
(
	@IdUnidadAdministrativa INT,
	@IdTipoDeBatch INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT b.IdBatch,
		CONVERT(NVARCHAR(50), b.idBatch) + ' - ' + ua.NombreCorto + ' - ' + CONVERT(NVARCHAR(10), b.FechaCorte, 103) + ' - ' + b.Descripcion AS Descripcion
	FROM
		Batches b
			INNER JOIN UnidadesAdministrativas ua ON b.idUnidAdm = ua.idUnidadAdministrativa
	WHERE (
			SELECT COUNT(*) 
			FROM Expedientes e 
				INNER JOIN Batches_Relaciones br ON e.idExpediente = br.idExpediente 
			WHERE br.idBatch = b.idBatch
			) > 0 
		AND b.idUnidAdm = @idUnidadAdministrativa
		AND b.idTipoDeBatch = @idTipoDeBatch
END




GO
/****** Object:  StoredProcedure [dbo].[Batches_Relaciones_CajaProv2_UpdateV1]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Batches_Relaciones_CajaProv2_UpdateV1]
(
	@IdBatch INT,
	@BatchesRelaciones UDT_Dictionary READONLY,
	@IdRecordOK	INT = 0	OUTPUT 
) WITH ENCRYPTION
AS 
BEGIN
	UPDATE b 
		SET CajaProv2 = r.[Value] 
	FROM Batches_Relaciones b
		INNER JOIN @BatchesRelaciones r ON b.idExpediente = r.[Key]
	WHERE b.idBatch = @IdBatch;

	SET @IdRecordOK = @@ERROR; 

END
GO
/****** Object:  StoredProcedure [dbo].[Batches_Relaciones_Delete]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_Relaciones_Delete
ALTER PROCEDURE [dbo].[Batches_Relaciones_Delete]
(
	@IdBatch INT,
	@IdExpediente INT,
	@StatusDeRegreso INT,
	@IdBatchEliminado INT = 0 OUTPUT
) WITH ENCRYPTION
AS
BEGIN

DECLARE @Err1 INT = 0;

	BEGIN TRAN;

	--Elimino el registro.
	DELETE Batches_Relaciones
	WHERE idBatch = @idBatch
		AND idExpediente = @idExpediente;

	SET @Err1 = @@ERROR;

	UPDATE Expedientes 
		SET idEstatusExpediente = @StatusDeRegreso 
	WHERE idExpediente = @idExpediente;
		
	SET @Err1 = @Err1 + @@ERROR;

	--Sin error
	IF @err1 = 0
	BEGIN
		COMMIT TRAN;
		--Devuelvo el id que ha sido eliminado.
		SET @IdBatchEliminado = @idBatch;
	END
	ELSE
	BEGIN
		ROLLBACK TRAN;
		--Devuelvo 0 para señalar que hubo error.
		SELECT @IdBatchEliminado = 0;
	END
END



GO
/****** Object:  StoredProcedure [dbo].[Batches_Relaciones_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_Relaciones_INSERT
ALTER PROCEDURE [dbo].[Batches_Relaciones_INSERT]
(
	@idBatch INT,
	@idExpediente INT,
	@CajaProv NVARCHAR(50),
	@IdRecordOK	INT = 0	OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @err1 INT;
	SELECT @err1 = 0;

	BEGIN TRAN;

	INSERT Batches_Relaciones (
		idBatch,
		idExpediente,
		CajaProv
	)
	VALUES (
		@idBatch,
		@idExpediente,
		@CajaProv
	);

	SET @err1 = @@ERROR; 

	IF (@err1 <> 0) GOTO HUBO_ERRORES
		SET @err1 = @@ERROR; 

HUBO_ERRORES:
	IF @err1 = 0
	BEGIN
		COMMIT TRAN;
		/* Devuelvo el nuevo id como resultado */
		SELECT @IdRecordOK = @idExpediente;
	END
	ELSE
	BEGIN
		ROLLBACK TRAN;
		/* Devuelvo 0 para señalar que hubo error */
		SELECT @IdRecordOK = 0;
	END
END



GO
/****** Object:  StoredProcedure [dbo].[Batches_Relaciones_InsertV1]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_Relaciones_InsertV1
ALTER PROCEDURE [dbo].[Batches_Relaciones_InsertV1]
(
	@idBatch INT,
	@BatchesRelaciones UDT_Dictionary READONLY,
	@IdRecordOK	INT = 0	OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	INSERT Batches_Relaciones (
		idBatch,
		idExpediente,
		CajaProv
	)
	SELECT @idBatch,
		[b].[Key],
		[b].[Value]
	FROM @BatchesRelaciones b;

	SET @IdRecordOK = @@ERROR; 

END
GO
/****** Object:  StoredProcedure [dbo].[Batches_SeleccionaExpedientesConCajaProvParaBaja]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_SeleccionaExpedientesConCajaProvParaBaja
ALTER PROCEDURE [dbo].[Batches_SeleccionaExpedientesConCajaProvParaBaja]
(
	@IdBatch INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT e.idExpediente,
		'[CAJA CONC ' + br.CajaProv2 +  + '] - [CAJA PROV ' + br.CajaProv + '] - ' + (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
		+ e.Nombre + ' - ' 
		+ CONVERT(varchar(10),e.FechaCierre,103) + ' - '
		+ c.descripcion + ' - '
		+ e.Asunto) as Expediente
	FROM Expedientes e
			INNER JOIN PlazosDeConservacionConcentracion c ON e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion
			INNER JOIN Batches_Relaciones br ON br.idExpediente = e.idExpediente
			INNER JOIN Batches b ON b.idBatch = br.idBatch
	WHERE b.idBatch = @idBatch
		AND LTRIM(RTRIM(br.CajaProv2)) <> ''
	ORDER BY br.CajaProv2, e.Nombre;
END




GO
/****** Object:  StoredProcedure [dbo].[Batches_SeleccionaExpedientesConCajaProvParaConcentracion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_SeleccionaExpedientesConCajaProvParaConcentracion
ALTER PROCEDURE [dbo].[Batches_SeleccionaExpedientesConCajaProvParaConcentracion]
(
	@IdBatch INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT e.idExpediente,
		'[CAJA CONC ' + br.CajaProv2 +  + '] - [CAJA PROV ' + br.CajaProv + '] - ' + (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
		+ e.Nombre + ' - ' 
		+ CONVERT(varchar(10),e.FechaCierre,103) + ' - '
		+ c.descripcion + ' - '
		+ e.Asunto) as Expediente
	FROM Expedientes e
			INNER JOIN PlazosDeConservacionTramite c ON e.idPlazoTramite = c.idPlazosDeConservacionTramite
			INNER JOIN Batches_Relaciones br ON br.idExpediente = e.idExpediente
			INNER JOIN Batches b ON b.idBatch = br.idBatch
	WHERE b.idBatch = @idBatch
		AND LTRIM(RTRIM(br.CajaProv2)) <> ''
	ORDER BY br.CajaProv2, e.Nombre;
END




GO
/****** Object:  StoredProcedure [dbo].[Batches_SeleccionaExpedientesConCajaProvParaHistorico]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_SeleccionaExpedientesConCajaProvParaHistorico
ALTER PROCEDURE [dbo].[Batches_SeleccionaExpedientesConCajaProvParaHistorico]
(
	@IdBatch INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT e.idExpediente,
		'[CAJA CONC ' + br.CajaProv2 +  + '] - [CAJA PROV ' + br.CajaProv + '] - ' + (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
		+ e.Nombre + ' - ' 
		+ CONVERT(varchar(10),e.FechaCierre,103) + ' - '
		+ c.descripcion + ' - '
		+ e.Asunto) as Expediente
	FROM Expedientes e
			INNER JOIN PlazosDeConservacionConcentracion c ON e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion
			INNER JOIN Batches_Relaciones br ON br.idExpediente = e.idExpediente
			INNER JOIN Batches b ON b.idBatch = br.idBatch
	WHERE b.idBatch = @idBatch
		AND LTRIM(RTRIM(br.CajaProv2)) <> ''
	ORDER BY br.CajaProv2, e.Nombre;
END




GO
/****** Object:  StoredProcedure [dbo].[Batches_SeleccionaExpedientesParaBaja]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_SeleccionaExpedientesParaBaja
ALTER PROCEDURE [dbo].[Batches_SeleccionaExpedientesParaBaja]
(
	@IdBatch INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT e.idExpediente,
		'[CAJA PROV ' + br.CajaProv + '] - ' + (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
		+ e.Nombre + ' - ' 
		+ CONVERT(varchar(10),e.FechaCierre,103) + ' - '
		+ c.descripcion + ' - '
		+ e.Asunto) as Expediente
	FROM Expedientes e
		INNER JOIN PlazosDeConservacionConcentracion c ON e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion
		INNER JOIN Batches_Relaciones br ON br.idExpediente = e.idExpediente
		INNER JOIN Batches b ON b.idBatch = br.idBatch
	WHERE b.idBatch = @idBatch
		AND LTRIM(RTRIM(br.CajaProv2)) = ''
	ORDER BY br.CajaProv, e.Nombre;
END



GO
/****** Object:  StoredProcedure [dbo].[Batches_SeleccionaExpedientesParaConcentracion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_SeleccionaExpedientesParaConcentracion
ALTER PROCEDURE [dbo].[Batches_SeleccionaExpedientesParaConcentracion]
(
	@IdBatch INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT e.idExpediente,
		'[CAJA PROV ' + br.CajaProv + '] - ' + (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
		+ e.Nombre + ' - ' 
		+ CONVERT(varchar(10),e.FechaCierre,103) + ' - '
		+ c.descripcion + ' - '
		+ e.Asunto) as Expediente
	FROM Expedientes e
		INNER JOIN PlazosDeConservacionTramite c ON e.idPlazoTramite = c.idPlazosDeConservacionTramite
		INNER JOIN Batches_Relaciones br ON br.idExpediente = e.idExpediente
		INNER JOIN Batches b ON b.idBatch = br.idBatch
	WHERE b.idBatch = @idBatch
		AND LTRIM(RTRIM(br.CajaProv2)) = ''
	ORDER BY br.CajaProv, e.Nombre;
END



GO
/****** Object:  StoredProcedure [dbo].[Batches_SeleccionaExpedientesParaHistorico]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_SeleccionaExpedientesParaHistorico
ALTER PROCEDURE [dbo].[Batches_SeleccionaExpedientesParaHistorico]
(
	@IdBatch INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT e.idExpediente,
		'[CAJA PROV ' + br.CajaProv + '] - ' + (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
		+ e.Nombre + ' - ' 
		+ CONVERT(varchar(10),e.FechaCierre,103) + ' - '
		+ c.descripcion + ' - '
		+ e.Asunto) as Expediente
	FROM Expedientes e
		INNER JOIN PlazosDeConservacionConcentracion c ON e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion
		INNER JOIN Batches_Relaciones br ON br.idExpediente = e.idExpediente
		INNER JOIN Batches b ON b.idBatch = br.idBatch
	WHERE b.idBatch = @idBatch
		AND LTRIM(RTRIM(br.CajaProv2)) = ''
	ORDER BY br.CajaProv, e.Nombre;
END



GO
/****** Object:  StoredProcedure [dbo].[Batches_VerificarEstatusExpedientes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Batches_VerificarEstatusExpedientes
ALTER PROCEDURE [dbo].[Batches_VerificarEstatusExpedientes]
(
	@IdBatch INT,
	@StatusAComprobar INT,
	@Respuesta INT OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	IF ( 
		SELECT COUNT(*)
		FROM 
			Expedientes e 
			INNER JOIN Batches_Relaciones br ON br.idExpediente = e.idExpediente
			INNER JOIN Batches b ON b.idBatch = br.idBatch
			INNER JOIN EstatusExpediente ee ON e.idEstatusExpediente = ee.idEstatusExpediente
		WHERE b.idBatch = @idBatch
			AND ee.idEstatusExpediente <> @StatusAComprobar
		) > 0
		SET @Respuesta = 0 
	ELSE 
		SET @Respuesta = 1
END
GO
/****** Object:  StoredProcedure [dbo].[BitacoraAcceso_Insert]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[BitacoraAcceso_Insert]
	@Identificador NCHAR(20),
	@IpAddress NCHAR(30),
	@LoginStatus BIT,
	@AppId INT WITH ENCRYPTION
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE @MaxId INT;

	SELECT 
		@MaxId = COALESCE(a.maxId, 0) + ROW_NUMBER() OVER (ORDER by (SELECT NULL))
		FROM (SELECT MAX(Id) AS maxId FROM BitacoraAcceso) a;

	INSERT INTO 
		BitacoraAcceso
		(
			Id,
			Identificador,
			IpAddress,
			LoginStatus,
			AppId
		)
		VALUES
		(
			@MaxId,
			@Identificador,
			@IpAddress,
			@LoginStatus,
			@AppId
		)

END
GO
/****** Object:  StoredProcedure [dbo].[CalidadDocumental_SELECTALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CalidadDocumental_SELECTALL] WITH ENCRYPTION

AS

SELECT * FROM CalidadDocumental


GO
/****** Object:  StoredProcedure [dbo].[CargaCuadroClasificacion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CargaCuadroClasificacion]
	@NivelInicial AS INTEGER = 2,
	@MaxNivel AS INTEGER = 16,
	@ErrorFound AS INTEGER = 0 OUTPUT WITH ENCRYPTION
AS
DECLARE @Nivel AS INTEGER
SELECT @Nivel = @NivelInicial
SELECT @ErrorFound = 0
--Verificar que no exista duplicidad de códigos
IF EXISTS(SELECT NULL
		FROM Codigos$ t1 JOIN Codigos$ t2 ON t1.codigo = t2.codigo
		WHERE t1.descripcion <> t2.descripcion)
	SELECT @ErrorFound = @ErrorFound + 1
ELSE
	IF @@ERROR > 0 
		SELECT @ErrorFound = @ErrorFound + 10
--Si no hay duplicidad, inserto nivel por nivel en el cuadro
SELECT @Nivel = @NivelInicial
BEGIN TRANSACTION 
	WHILE (@Nivel < @MaxNivel AND @ErrorFound = 0)
	BEGIN
		INSERT CuadroClasificacion (idPadre, Nombre, Descripcion, idPlazoDeConservacionConcentracion,
			idPlazoDeConservacionTramite, idDestinoFinal, idInformacionClasificada)
		SELECT 
			dbo.fnGetIDJerarquia(SUBSTRING(t.codigo, 1, LEN(REPLACE(t.codigo, '.', '')) - CHARINDEX('.', REVERSE(t.Codigo)) + t.nivel - 1)),		
			SUBSTRING(t.codigo, LEN(REPLACE(t.codigo, '.', '')) - CHARINDEX('.', REVERSE(t.Codigo)) + t.nivel + 1, LEN(t.codigo)),
			ISNULL(t.Descripcion, ''),
			ISNULL(t.Concentracion, 1),
			ISNULL(t.tramite, 1),
			ISNULL(t.Final, 1),
			ISNULL(t.Clasificacion, 1)
		FROM
			Codigos$ t
		WHERE
			t.nivel = @Nivel
	
		IF @@ERROR > 0 
			SELECT @ErrorFound = @ErrorFound + 100
	
		SELECT @Nivel = @Nivel + 1
		print 'Nivel ' + CONVERT(VARCHAR(10), @nivel)
		BREAK
	
	END
	--Recorro registro por registro para encontar varios idValorDocumental divididos por un separador
	--DECLARE @ValorDocumental AS NVARCHAR(255)
	--DECLARE @idClasificacion AS INTEGER
	--DECLARE ValorDocumentalLista CURSOR LOCAL FORWARD_ONLY STATIC FOR
	--	SELECT t.ValorDocumental, c.idClasificacion
	--	FROM Codigos$ t JOIN CuadroClasificacion c ON t.codigo = dbo.fnNombreDeJerarquia(c.idClasificacion)
	--	WHERE LEN(t.ValorDocumental) > 0 --IS NOT NULL
	--OPEN  ValorDocumentalLista
	--FETCH NEXT FROM ValorDocumentalLista 
	--INTO @ValorDocumental, @idClasificacion
	
	--WHILE @@FETCH_STATUS = 0
	--BEGIN
	--	--Inserto un registro por cada Código e idValorDocumentla (separados con la función fnSplitIDs)
	--	INSERT ValorDocumentalRelaciones (idClasificacion, idValorDocumental)
	--	SELECT @idClasificacion, s.idListed
	--	FROM dbo.fnSplitIDs(@ValorDocumental, '|') s
		
	--	IF @@ERROR > 0 
	--		SELECT @ErrorFound = @ErrorFound + 1000
	--	FETCH NEXT FROM ValorDocumentalLista 
	--	INTO @ValorDocumental, @idClasificacion	 
	--END
	
	--CLOSE ValorDocumentalLista
	--DEALLOCATE ValorDocumentalLista
	--IF @@ERROR > 0 
	--	SELECT @ErrorFound = @ErrorFound + 10000

	----Recorro registro por registro para encontar varios idFundamentosLegalesDeclasificacion divididos por un separador
	--DECLARE @Fundamento AS NVARCHAR(255)
	--DECLARE FundamentosLista CURSOR LOCAL FORWARD_ONLY STATIC FOR
	--	SELECT t.Fundamento, c.idClasificacion
	--	FROM Codigos$ t JOIN CuadroClasificacion c ON t.codigo = dbo.fnNombreDeJerarquia(c.idClasificacion)
	--	WHERE LEN(t.Fundamento) > 0  --IS NOT NULL
	--OPEN FundamentosLista
	--FETCH NEXT FROM FundamentosLista 
	--INTO @Fundamento, @idClasificacion
	
	--WHILE @@FETCH_STATUS = 0
	--BEGIN
	--	--Inserto un registro por cada Código e idFundamentosLegalesDeClasificacion (separados con la función fnSplitIDs)
	--	INSERT FundamentosLegalesDeClasificacionRelaciones (idFundamentosLegalesDeClasificacion, idClasificacion)
	--	SELECT s.idListed, @idClasificacion
	--	FROM dbo.fnSplitIDs(@Fundamento, '|') s
	--	IF @@ERROR > 0 
	--		SELECT @ErrorFound = @ErrorFound + 100000
		
	--	FETCH NEXT FROM FundamentosLista 
	--	INTO @Fundamento, @idClasificacion	 
	--END
	
	--CLOSE FundamentosLista
	--DEALLOCATE FundamentosLista
	--IF @@ERROR > 0 
	--	SELECT @ErrorFound = @ErrorFound + 1000000

	DECLARE @IdCodigoClasif INT
	DECLARE @Unidades NVARCHAR(50)
	DECLARE Codigos CURSOR LOCAL FORWARD_ONLY STATIC FOR
		SELECT c.idClasificacion, COALESCE(g.Unidades, '') 
		FROM Codigos$ g 
			INNER JOIN CuadroClasificacion c ON g.Codigo = dbo.fnNombreDeJerarquia(c.idClasificacion)
		WHERE COALESCE(Unidades, 'X') <> 'X'

	OPEN  Codigos

	FETCH NEXT FROM Codigos 
		INTO @IdCodigoClasif, @Unidades
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Inserto un registro por cada Código e idUnidadAdministrativa (separados con la función fnSplitIDs)
		INSERT UnidadesAdministrativasRelaciones(idClasificacion, idUnidadAdministrativa)
		SELECT @IdCodigoClasif, u.idUnidadAdministrativa
		FROM UnidadesAdministrativas u
			INNER JOIN dbo.fnSplitTextString(@Unidades, '|') s ON u.NombreCorto = s.IdListed
		
		FETCH NEXT FROM Codigos 
			INTO @IdCodigoClasif, @Unidades
	END
	
	CLOSE Codigos
	DEALLOCATE Codigos

	IF @@ERROR > 0 
		SELECT @ErrorFound = @ErrorFound + 10000000

--Si no hay errores, acepto todos los cambios
IF @ErrorFound = 0
	COMMIT TRANSACTION
ELSE
	ROLLBACK TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[CargaFormatoCaratula]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC CargaFormatoCaratula '23000, 2500, 2600,25000, 64500, 21000'
-- DROP PROCEDURE CargaFormatoCaratula
ALTER PROCEDURE [dbo].[CargaFormatoCaratula]
	@IDList TEXT,
	@Orden NVARCHAR(100) = ' Caja, Numero '  WITH ENCRYPTION
AS
BEGIN

	SELECT 
		Unidad = UPPER(u.Descripcion),
		Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2)),
		Serie = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3)),
		Subserie = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4)),
		Subsubsubserie = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5)),
		Codigo = UPPER(dbo.fnCodigoDeJerarquiaMaxima(e.idClasificacion)),
		Numero = UPPER(e.Nombre),
		Creacion = CONVERT(CHAR(10), e.FechaApertura, 103),
		Cierre = CASE
			WHEN (FechaCierreChecked = 1) THEN CONVERT(CHAR(10), e.FechaCierre, 103)
			ELSE ''
		END,
		Asunto = RTRIM(LTRIM(UPPER(e.Asunto))),
		RFC = RTRIM(LTRIM(UPPER(e.CampoAdicional1))),
		Administrativo = CASE
			WHEN 
				(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 1)
				= 1 THEN 'X'
			ELSE ''
			END,
		Contable = CASE
			WHEN 
				(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 2)
				= 1 THEN 'X'
			ELSE ''
			END,
		Legal = CASE
			WHEN 
				(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 3)
				= 1 THEN 'X'
			ELSE ''
			END,
		Historico = CASE
			WHEN 
				(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 4)
				= 1 THEN 'X'
			ELSE ''
			END,
		Reservado = CASE
			WHEN (idClasificacionStatus = 3) THEN 'X'
			ELSE ''
		END,
		Confidencial = CASE 
			WHEN (idClasificacionStatus = 4) THEN 'X'
			ELSE ''
		END,
		Tramite =
			(SELECT UPPER(t.Descripcion)
				FROM PlazosDeConservacionTramite t
				WHERE e.idPlazoTramite = t.idPlazosDeConservacionTramite),
		Concentracion =
			(SELECT UPPER(c.Descripcion)
				FROM PlazosDeConservacionConcentracion c
				WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion),
		Fojas = CASE 
				WHEN e.NumeroDeFojas = 0 THEN CHAR(0)
				ELSE CONVERT(VARCHAR(10), e.NumeroDeFojas)
		END,
		Caja = e.Caja,
		Baja = CASE
			WHEN (idDestinoFinal = 2) THEN 'X'
			ELSE ''
		END,
		ArchivoHistorico = CASE
			WHEN (idDestinoFinal = 3) THEN 'X'
			ELSE ''
		END,
		Original = CASE				
			WHEN (idCalidadDocumental = 2) THEN 'X'
			ELSE ''
		END,
		Copia = CASE
			WHEN (idCalidadDocumental = 3) THEN 'X'
			ELSE ''
		END,
		Mixto = CASE
			WHEN (idCalidadDocumental = 4) THEN 'X'
			ELSE ''
		END,
		Titular = (SELECT UPPER(Titular)
			FROM UnidadesAdministrativas u
			WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
		Elaboro = CASE
			WHEN (e.idUsuario_ElaboradoPor = -1) THEN 'Full Service de México, S.A. de C.V.'
			ELSE (SELECT Nombre FROM UsuariosReales WHERE idUsuarioReal = e.idUsuario_ElaboradoPor)
		END,
		Fundamento = dbo.fnGetFundamentosLegalesDeClasificacion(e.idExpediente, ','),
		Estatus = CASE e.idEstatusExpediente
			WHEN 1 THEN 'VT'
			WHEN 2 THEN 'BT'
			WHEN 3 THEN 'BT'
			WHEN 4 THEN 'VC'
			WHEN 5 THEN 'BC'
			WHEN 6 THEN 'H'
			ELSE ''
		END,
		e.idClasificacion,
		e.Nombre,
		e.CampoAdicional1,
		e.CampoAdicional2,
		e.FechaApertura,
		u.NombreCorto,
		e.Control1,
		e.Control2
	INTO #Caratulas
	FROM Expedientes e
		INNER JOIN dbo.fnSplitTextIDS(@IDList, ',') s ON e.IdExpediente = s.IdListed
		INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa = u.idUnidadAdministrativa;

	DECLARE @Salida NVARCHAR(1024);

	SET @Salida = 'SELECT * FROM #Caratulas ORDER BY ' + @Orden;

	EXEC(@Salida);

	DROP TABLE #Caratulas;

END

GO
/****** Object:  StoredProcedure [dbo].[CargaFundamentosLegalesDeClasificacion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CargaFundamentosLegalesDeClasificacion]

@idClasificacion	integer WITH ENCRYPTION

AS

SELECT 
	fl.idFundamentosLegalesDeClasificacion,
	fl.Descripcion,
	Activo = CASE 	WHEN	(SELECT COUNT(*) 
				FROM 
					FundamentosLegalesDeClasificacion fl2
					JOIN FundamentosLegalesDeClasificacionRelaciones flr
					ON fl2.idFundamentosLegalesDeClasificacion = flr.idFundamentosLegalesDeClasificacion
					JOIN CuadroClasificacion c
					ON flr.idClasificacion = c.idClasificacion
				WHERE
					flr.idClasificacion = @idClasificacion
					AND
					flr.idFundamentosLegalesDeClasificacion = fl.idFundamentosLegalesDeClasificacion
				) > 0
			THEN 1
			ELSE 0
		END
FROM 
	FundamentosLegalesDeClasificacion fl
ORDER BY
	Activo desc, fl.Descripcion asc
	 
GO
/****** Object:  StoredProcedure [dbo].[CargaFundamentosLegalesDeClasificacionDeExpedientes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CargaFundamentosLegalesDeClasificacionDeExpedientes]

@idExpediente	integer WITH ENCRYPTION

AS

SELECT 
	fl.idFundamentosLegalesDeClasificacion,
	fl.Descripcion,
	Activo = CASE 	WHEN	(SELECT COUNT(*) 
				FROM 
					FundamentosLegalesDeClasificacion fl2
					JOIN FundamentosLegalesDeClasificacion_Expedientes_Relaciones flr
					ON fl2.idFundamentosLegalesDeClasificacion = flr.idFundamentosLegalesDeClasificacion
					JOIN Expedientes e
					ON flr.idExpediente = e.idExpediente
				WHERE
					flr.idExpediente = @idExpediente
					AND
					flr.idFundamentosLegalesDeClasificacion = fl.idFundamentosLegalesDeClasificacion
				) > 0
			THEN 1
			ELSE 0
		END
FROM 
	FundamentosLegalesDeClasificacion fl
ORDER BY
	Activo desc, fl.Descripcion asc
	 
GO
/****** Object:  StoredProcedure [dbo].[CargaFundamentosLegalesDeDestinoFinal]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CargaFundamentosLegalesDeDestinoFinal]

@idClasificacion	integer WITH ENCRYPTION

AS 

SELECT 
	fldf.idFundamentoLegalDeDestinoFinal,
	fldf.Descripcion,
	Activo = CASE 	WHEN	(SELECT COUNT(*) 
				FROM 
					FundamentosLegalesDeDestinoFinal fldf2
					JOIN FundamentosLegalesDeDestinoFinalRelaciones fldfr
					ON fldf2.idFundamentoLegalDeDestinoFinal = fldfr.idFundamentoLegalDeDestinoFinal
					JOIN CuadroClasificacion c
					ON fldfr.idClasificacion = c.idClasificacion
				WHERE
					fldfr.idClasificacion = @idClasificacion
					AND
					fldfr.idFundamentoLegalDeDestinoFinal = fldf.idFundamentoLegalDeDestinoFinal
				) > 0
			THEN 1
			ELSE 0
		END
FROM 
	FundamentosLegalesDeDestinoFinal fldf
ORDER BY
	Activo desc , fldf.Descripcion asc

GO
/****** Object:  StoredProcedure [dbo].[CargaFundamentosLegalesDeDestinoFinalDeExpedientes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CargaFundamentosLegalesDeDestinoFinalDeExpedientes]

@idExpediente	integer WITH ENCRYPTION

AS 

SELECT 
	fldf.idFundamentoLegalDeDestinoFinal,
	fldf.Descripcion,
	Activo = CASE 	WHEN	(SELECT COUNT(*) 
				FROM 
					FundamentosLegalesDeDestinoFinal fldf2
					JOIN FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones fldfr
					ON fldf2.idFundamentoLegalDeDestinoFinal = fldfr.idFundamentoLegalDeDestinoFinal
					JOIN Expedientes e
					ON fldfr.idExpediente = e.idExpediente
				WHERE
					fldfr.idExpediente = @idExpediente
					AND
					fldfr.idFundamentoLegalDeDestinoFinal = fldf.idFundamentoLegalDeDestinoFinal
				) > 0
			THEN 1
			ELSE 0
		END
FROM 
	FundamentosLegalesDeDestinoFinal fldf
ORDER BY
	Activo desc , fldf.Descripcion asc

GO
/****** Object:  StoredProcedure [dbo].[CargaUnidadesAdministrativas]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--===============================================================
--DRAA. 2022-01-14.
--
--===============================================================
--EXEC CargaUnidadesAdministrativas 11
--DROP PROCEDURE [dbo].[CargaUnidadesAdministrativas]
ALTER PROCEDURE [dbo].[CargaUnidadesAdministrativas]
(
	@IdClasificacion INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT ua.idUnidadAdministrativa,
		ua.NombreCorto,
		Activo = 
			CASE 
				WHEN 
				(
					SELECT COUNT(*) 
					FROM UnidadesAdministrativas ua2
						INNER JOIN UnidadesAdministrativasRelaciones uar ON ua2.idUnidadAdministrativa = uar.idUnidadAdministrativa
						INNER JOIN CuadroClasificacion c ON uar.idClasificacion = c.idClasificacion
					WHERE uar.idClasificacion = @IdClasificacion
						AND uar.idUnidadAdministrativa = ua.idUnidadAdministrativa
				) > 0 THEN 1
				ELSE 0
			END
	FROM UnidadesAdministrativas ua
	ORDER BY Activo DESC, ua.NombreCorto ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[CargaUsuarioRealCodigosRelaciones]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC CargaUsuarioRealCodigosRelaciones 2
--DROP PROCEDURE [dbo].[CargaUsuarioRealCodigosRelaciones]
ALTER PROCEDURE [dbo].[CargaUsuarioRealCodigosRelaciones]
(
	@idParameter AS INT		--idUsuario real.
) WITH ENCRYPTION
AS
BEGIN
	SELECT MAX(cat.idClasificacion) AS IdClasificacion, dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 1) AS Codigo
	FROM UsuariosReales u
		INNER JOIN UsuariosRealesUnidadesAdministrativasRelaciones uar ON u.idUsuarioReal = uar.idUsuarioReal  
		INNER JOIN UnidadesAdministrativasRelaciones unrel ON uar.idUnidadAdministrativa = unrel.idUnidadAdministrativa
		INNER JOIN CuadroClasificacion cat ON unrel.idClasificacion = cat.idClasificacion 
	WHERE u.idUsuarioReal = @idParameter
	GROUP BY dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 1) 
	UNION
	SELECT MAX(cat.idClasificacion) AS IdClasificacion, dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 2) 
	FROM UsuariosReales u
		INNER JOIN UsuariosRealesUnidadesAdministrativasRelaciones uar ON u.idUsuarioReal = uar.idUsuarioReal  
		INNER JOIN UnidadesAdministrativasRelaciones unrel ON uar.idUnidadAdministrativa = unrel.idUnidadAdministrativa
		INNER JOIN CuadroClasificacion cat ON unrel.idClasificacion = cat.idClasificacion 
	WHERE u.idUsuarioReal = @idParameter
	GROUP BY dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 2) 
	UNION
	SELECT MAX(cat.idClasificacion) AS IdClasificacion, dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 3) 
	FROM UsuariosReales u
		INNER JOIN UsuariosRealesUnidadesAdministrativasRelaciones uar ON u.idUsuarioReal = uar.idUsuarioReal  
		INNER JOIN UnidadesAdministrativasRelaciones unrel ON uar.idUnidadAdministrativa = unrel.idUnidadAdministrativa
		INNER JOIN CuadroClasificacion cat ON unrel.idClasificacion = cat.idClasificacion 
	WHERE u.idUsuarioReal = @idParameter
	GROUP BY dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 3)
	UNION
	SELECT MAX(cat.idClasificacion) AS IdClasificacion, dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 4) 
	FROM UsuariosReales u
		INNER JOIN UsuariosRealesUnidadesAdministrativasRelaciones uar ON u.idUsuarioReal = uar.idUsuarioReal  
		INNER JOIN UnidadesAdministrativasRelaciones unrel ON uar.idUnidadAdministrativa = unrel.idUnidadAdministrativa
		INNER JOIN CuadroClasificacion cat ON unrel.idClasificacion = cat.idClasificacion 
	WHERE u.idUsuarioReal = @idParameter
	GROUP BY dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 4) 
	UNION
	SELECT MAX(cat.idClasificacion) AS IdClasificacion, dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 5) 
	FROM UsuariosReales u
		INNER JOIN UsuariosRealesUnidadesAdministrativasRelaciones uar ON u.idUsuarioReal = uar.idUsuarioReal  
		INNER JOIN UnidadesAdministrativasRelaciones unrel ON uar.idUnidadAdministrativa = unrel.idUnidadAdministrativa
		INNER JOIN CuadroClasificacion cat ON unrel.idClasificacion = cat.idClasificacion 
	WHERE u.idUsuarioReal = @idParameter
	GROUP BY dbo.fnCodigoDeJerarquiaPorNivel(cat.idClasificacion, 5) 
	ORDER BY 2;
END
GO
/****** Object:  StoredProcedure [dbo].[CargaUsuarioRealUnidadesAdministrativasRelaciones]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC CargaUsuarioRealUnidadesAdministrativasRelaciones 2
ALTER PROCEDURE [dbo].[CargaUsuarioRealUnidadesAdministrativasRelaciones]
(
	@idUsuario AS INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT 
		ua.idUnidadAdministrativa,
		ua.NombreCorto,
		Activo = CASE WHEN 
			(
				SELECT COUNT(*) 
				FROM UnidadesAdministrativas ua2
					INNER JOIN UsuariosRealesUnidadesAdministrativasRelaciones uar ON ua2.idUnidadAdministrativa = uar.idUnidadAdministrativa
						INNER JOIN UsuariosReales u ON uar.idUsuarioReal = u.idUsuarioReal
				WHERE uar.idUsuarioReal = @idUsuario
			) > 0 THEN 1
			ELSE 0
		END
	FROM UnidadesAdministrativas ua
	ORDER BY Activo DESC, 
		ua.Descripcion ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[CargaValorDocumental]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CargaValorDocumental]

@idClasificacion	integer WITH ENCRYPTION

AS

SELECT 
	vd.idValorDocumental,
	vd.Descripcion,
	Activo = CASE 	WHEN	(SELECT COUNT(*) 
				FROM 
					ValorDocumental vd2
					JOIN ValorDocumentalRelaciones vdr
					ON vd2.idValorDocumental = vdr.idValorDocumental
					JOIN CuadroClasificacion c
					ON vdr.idClasificacion = c.idClasificacion
				WHERE
					vdr.idClasificacion = @idClasificacion
					AND
					vdr.idValorDocumental = vd.idValorDocumental
				) > 0
			THEN 1
			ELSE 0
		END
FROM 
	ValorDocumental vd
--ORDER BY
--	Activo desc, fl.Descripcion asc

GO
/****** Object:  StoredProcedure [dbo].[CargaValorDocumentalDeExpedientes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CargaValorDocumentalDeExpedientes]

@idExpediente	integer WITH ENCRYPTION

AS

SELECT 
	vd.idValorDocumental,
	vd.Descripcion,
	Activo = CASE 	WHEN	(SELECT COUNT(*) 
				FROM 
					ValorDocumental vd2
					JOIN ValorDocumental_Expedientes_Relaciones vdr
					ON vd2.idValorDocumental = vdr.idValorDocumental
					JOIN Expedientes e
					ON vdr.idExpediente = e.idExpediente
				WHERE
					vdr.idExpediente = @idExpediente
					AND
					vdr.idValorDocumental = vd.idValorDocumental
				) > 0
			THEN 1
			ELSE 0
		END
FROM 
	ValorDocumental vd
--ORDER BY
--	Activo desc, fl.Descripcion asc

GO
/****** Object:  StoredProcedure [dbo].[ClasificacionNodosRaiz]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ClasificacionNodosRaiz]  WITH ENCRYPTION

AS

SELECT 
	c.idClasificacion,
	idPadre= ISNULL(idPadre,0),
	c.Nombre,
	c.Descripcion,
--	c.idValorDocumental,
	c.idPlazoDeConservacionTramite,
	c.idPlazoDeConservacionConcentracion,
	c.idDestinoFinal,
	c.idInformacionClasificada,
--	ccc.Clasificacion,
--	ccc.Naturaleza,
--	ccc.Balance,
--	c.Activa,
--	c.idMoneda,
--	DescripcionMoneda = cm.Descripcion,
	Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
	Afectable = 
		CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion)>0 THEN
			0
		ELSE
			1
		END
FROM 
	CuadroClasificacion c
	--JOIN Cat_Clasificacion_Cuentas ccc
	--ON c.idClasificacion = ccc.idClasificacion
	--JOIN Cat_Monedas cm
	--ON c.idMoneda = cm.idMoneda
WHERE 
	c.idPadre is null

ORDER BY c.Nombre

RETURN

GO
/****** Object:  StoredProcedure [dbo].[ClasificacionNodosRaizOrdenado]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ClasificacionNodosRaizOrdenado] WITH ENCRYPTION

AS

SELECT 
	c.OrdenDeDespliegue,
	dbo.fnExtraeDigitosIniciales(c.Nombre) as Ordenacion,
	c.idClasificacion,
	idPadre= ISNULL(idPadre,0),
	c.Nombre,
	c.Descripcion,
	c.idPlazoDeConservacionTramite,
	c.idPlazoDeConservacionConcentracion,
	c.idDestinoFinal,
	c.idInformacionClasificada,
	Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
	Afectable = 
		CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion)>0 THEN
			0
		ELSE
			1
		END
FROM 
	CuadroClasificacion c 
WHERE 
	c.idPadre is null

ORDER BY OrdenDeDespliegue, Ordenacion

RETURN


GO
/****** Object:  StoredProcedure [dbo].[ClasificacionStatus_SELECT_ONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ClasificacionStatus_SELECT_ONE] 

@idClasificacion		integer WITH ENCRYPTION

as

select  dbo.fnNombreDeJerarquia(idClasificacion) as NombreDeJerarquia,
		Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
	Afectable = 
		CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion) > 0 THEN
			0
		ELSE
			1
		END,
	c.idClasificacion,
	idPadre= ISNULL(c.idPadre,0),
	c.Nombre, 
	c.Descripcion, 
	c.idPlazoDeConservacionTramite,
	c.idPlazoDeConservacionConcentracion,
	c.idDestinoFinal,
	c.idInformacionClasificada
	FROM CuadroClasificacion c 
	WHERE c.idClasificacion = @idClasificacion

GO
/****** Object:  StoredProcedure [dbo].[ClasificacionStatus_SELECTALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ClasificacionStatus_SELECTALL] WITH ENCRYPTION

AS

SELECT * FROM ClasificacionStatus

GO
/****** Object:  StoredProcedure [dbo].[conviertePassword]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[conviertePassword]
(
	@IdUsuario INT,
	@Password NVARCHAR(100)
) WITH ENCRYPTION
AS

	UPDATE UsuariosVirtuales
	SET Clave = @Password
	WHERE idUsuarioVirtual = @IdUsuario;


RETURN
GO
/****** Object:  StoredProcedure [dbo].[CuadroClasificacion_DELETE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CuadroClasificacion_DELETE]

@idClasificacion		integer,

@id_record_procesadoOK		integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	/* Borro el record */
	DELETE 
		CuadroClasificacion
	WHERE
		idClasificacion = @idClasificacion

	SET @err1 = @@error

	/* Si no hubo ningun error */
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el id que ha sido eliminado */
			SELECT @id_record_procesadoOK = @idClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			SELECT @id_record_procesadook = 0 
		END

GO
/****** Object:  StoredProcedure [dbo].[CuadroClasificacion_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CuadroClasificacion_INSERT]

@IDPadre				integer,
@Nombre					varchar(50),
@Descripcion				varchar(250),
@idPlazoDeConservacionTramite		integer,
@idPlazoDeConservacionConcentracion	integer,
@idDestinoFinal				integer,
@idInformacionClasificada		integer,

@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int,
	@MyidPadre		int

SET @MyidPadre = CASE WHEN @IDPadre = 0 THEN
			NULL
		ELSE
			@IDPadre
		END

SELECT
	@err1 = 0

	BEGIN TRAN

	INSERT CuadroClasificacion
	(
		IDPadre,
		Nombre,
		Descripcion,
		idPlazoDeConservacionTramite,
		idPlazoDeConservacionConcentracion,
		idDestinoFinal,
		idInformacionClasificada
	)
	VALUES
	(
		@MyidPadre,
		@Nombre,
		@Descripcion,
		@idPlazoDeConservacionTramite,
		@idPlazoDeConservacionConcentracion,
		@idDestinoFinal,
		@idInformacionClasificada
	)

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = MAX(idClasificacion) FROM CuadroClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[CuadroClasificacion_UPDATE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CuadroClasificacion_UPDATE]

@idClasificacion			integer,
@idPadre				integer,
@Nombre					varchar(50),
@Descripcion				varchar(250),
@idPlazoDeConservacionTramite		integer,
@idPlazoDeConservacionConcentracion	integer,
@idDestinoFinal				integer,
@idInformacionClasificada		integer,

@id_record_procesadoOK		integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			integer

SELECT
	@err1 = 0

IF (@IDPadre = 0)
/* En el caso que esté editando un nodo hijo del raíz, no incluyo el parámetro IDPadre para evitar el error por el NULL */
	BEGIN
		BEGIN TRAN


		UPDATE CuadroClasificacion
		SET
--			idClasificacion = @idClasificacion,
			Nombre = @Nombre,
			Descripcion = @Descripcion,
			idPlazoDeConservacionTramite = @idPlazoDeConservacionTramite,
			idPlazoDeConservacionConcentracion = @idPlazoDeConservacionConcentracion,
			idDestinoFinal = @idDestinoFinal,
			idInformacionClasificada = @idInformacionClasificada
		FROM
			CuadroClasificacion
		WHERE
			idClasificacion = @idClasificacion


	END
ELSE
/* Si no estoy editando un nodo hijo del raíz, incluyo el parámetro IDPadre */
	BEGIN
		BEGIN TRAN

		UPDATE CuadroClasificacion
		SET
--			idClasificacion = @idClasificacion,
			idPadre = @idPadre,
			Nombre = @Nombre,
			Descripcion = @Descripcion,
			idPlazoDeConservacionTramite = @idPlazoDeConservacionTramite,
			idPlazoDeConservacionConcentracion = @idPlazoDeConservacionConcentracion,
			idDestinoFinal = @idDestinoFinal,
			idInformacionClasificada = @idInformacionClasificada
		FROM
			CuadroClasificacion
		WHERE
			idClasificacion = @idClasificacion
	END

SET @err1 = @@error

IF @err1 = 0
	BEGIN
		COMMIT TRAN
		/* Devuelvo el nuevo id como resultado */
		SELECT @id_record_procesadoOK = @idClasificacion
	END
ELSE
	BEGIN
		ROLLBACK TRAN
		/* Devuelvo 0 para señalar que hubo error */
		select @id_record_procesadoOK = 0
	END

GO
/****** Object:  StoredProcedure [dbo].[DestinoFinal_SELECTALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[DestinoFinal_SELECTALL] WITH ENCRYPTION

AS

SELECT * FROM DestinoFinal

GO
/****** Object:  StoredProcedure [dbo].[EstadisticaExpedientes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC EstadisticaExpedientes
--DROP PROCEDURE EstadisticaExpedientes
ALTER PROCEDURE [dbo].[EstadisticaExpedientes] WITH ENCRYPTION
AS
BEGIN
	-- Totales
	SELECT l0.TotalExpedientes AS TotalExpedientesBD,
		COALESCE(l1.ConImagenes, 0) AS ExpedientesConArchivoBD,
		COALESCE(l2.SinImagenes, 0) AS ExpedientesSinArchivoBD,
		COALESCE(l4.ImagenesVerificadas, 0) AS ArchivosLocalizadosFS,
		COALESCE(l5.ImagenesFaltantes, 0) AS ArchivosNoLocalizadosFS,
		COALESCE(l3.TotalImagenes, 0) AS TotalImagenes,
		COALESCE(l6.SinDigitalizacion, 0) AS SinDigitalizacion,
		COALESCE(l7.ConDigitalizacion, 0) AS ConDigitalizacion,
		l0.NumeroHojas AS TotalHojasBD
	FROM (
			SELECT COUNT(*) AS TotalExpedientes, SUM(NumeroDeFojas) AS NumeroHojas
			FROM Expedientes e 
		) l0,
		(
			SELECT COUNT(*) AS ConImagenes
			FROM Expedientes 
			WHERE idExpediente IN (
					SELECT idExpediente FROM Expedientes_PDF_Relaciones
				) 
				AND DocumentosDigitalizados = 1
		) l1,
		(
			SELECT COUNT(*) AS SinImagenes
			FROM Expedientes 
			WHERE idExpediente NOT IN (
					SELECT idExpediente FROM Expedientes_PDF_Relaciones
				)
				AND DocumentosDigitalizados = 1
			
		) l2, 
		(
			SELECT COUNT(*) AS TotalImagenes 
			FROM Expedientes_PDF_Relaciones r1 
				INNER JOIN Expedientes e1 ON r1.idExpediente = e1.idExpediente 
		) l3,
		(
			SELECT COUNT(*) AS ImagenesVerificadas
			FROM Expedientes_PDF_Relaciones r1 
				INNER JOIN Expedientes e1 ON r1.idExpediente = e1.idExpediente 
			WHERE r1.Verificado = 1
		) l4,
		(
			SELECT COUNT(*) AS ImagenesFaltantes
			FROM Expedientes_PDF_Relaciones r1 
				INNER JOIN Expedientes e1 ON r1.idExpediente = e1.idExpediente 
			WHERE r1.Verificado = 0
		) l5,
		(
			SELECT COUNT(*) AS SinDigitalizacion
			FROM Expedientes e 
			WHERE e.DocumentosDigitalizados = 0
		) l6,
		(
			SELECT COUNT(*) AS ConDigitalizacion
			FROM Expedientes e 
			WHERE e.DocumentosDigitalizados = 1
		) l7
	WHERE COALESCE(l1.ConImagenes, -1) > 0 
		OR COALESCE(l2.SinImagenes, -1) > 0 
		OR COALESCE(l3.TotalImagenes, -1) > 0 
		OR COALESCE(l4.ImagenesVerificadas, -1) > 0
		OR COALESCE(l5.ImagenesFaltantes, -1) > 0

	--Detallado por Unidad Administrativa
	SELECT u.Descripcion, 
		l0.TotalExpedientes AS TotalExpedientesBD,
		COALESCE(l1.ConImagenes, 0) AS ExpedientesConArchivoBD,
		COALESCE(l2.SinImagenes, 0) AS ExpedientesSinArchivoBD,
		COALESCE(l4.ImagenesVerificadas, 0) AS ArchivosLocalizadosFS,
		COALESCE(l5.ImagenesFaltantes, 0) AS ArchivosNoLocalizadosFS,
		COALESCE(l3.TotalImagenes, 0) AS TotalImagenes,
		COALESCE(l6.SinDigitalizacion, 0) AS SinDigitalizacion,
		COALESCE(l7.ConDigitalizacion, 0) AS ConDigitalizacion,
		l0.NumeroHojas AS TotalHojasBD
	FROM UnidadesAdministrativas u
		INNER JOIN (
			SELECT COUNT(*) AS TotalExpedientes, SUM(NumeroDeFojas) AS NumeroHojas, idUnidadAdministrativa 
			FROM Expedientes e 
			GROUP BY idUnidadAdministrativa
		) l0 ON u.idUnidadAdministrativa = l0.idUnidadAdministrativa
		LEFT JOIN (
			SELECT COUNT(*) AS ConImagenes, idUnidadAdministrativa 
			FROM Expedientes 
			WHERE idExpediente IN (
					SELECT idExpediente FROM Expedientes_PDF_Relaciones
				) 
				AND DocumentosDigitalizados = 1
			GROUP BY idUnidadAdministrativa
		) l1 ON u.idUnidadAdministrativa = l1.idUnidadAdministrativa
		LEFT JOIN (
			SELECT COUNT(*) AS SinImagenes, idUnidadAdministrativa 
			FROM Expedientes 
			WHERE idExpediente NOT IN (
					SELECT idExpediente FROM Expedientes_PDF_Relaciones
				) 
				AND DocumentosDigitalizados = 1
			GROUP BY idUnidadAdministrativa
		) l2 ON u.idUnidadAdministrativa = l2.idUnidadAdministrativa
		LEFT JOIN (
			SELECT COUNT(*) AS TotalImagenes, idUnidadAdministrativa 
			FROM Expedientes_PDF_Relaciones r1 
				INNER JOIN Expedientes e1 ON r1.idExpediente = e1.idExpediente 
			GROUP BY e1.idUnidadAdministrativa
		) l3 ON u.idUnidadAdministrativa = l3.idUnidadAdministrativa
		LEFT JOIN (
			SELECT COUNT(*) AS ImagenesVerificadas, idUnidadAdministrativa 
			FROM Expedientes_PDF_Relaciones r1 
				INNER JOIN Expedientes e1 ON r1.idExpediente = e1.idExpediente 
			WHERE r1.Verificado = 1
			GROUP BY e1.idUnidadAdministrativa
		) l4 ON u.idUnidadAdministrativa = l4.idUnidadAdministrativa
		LEFT JOIN (
			SELECT COUNT(*) AS ImagenesFaltantes, idUnidadAdministrativa 
			FROM Expedientes_PDF_Relaciones r1 
				INNER JOIN Expedientes e1 ON r1.idExpediente = e1.idExpediente 
			WHERE r1.Verificado = 0
			GROUP BY e1.idUnidadAdministrativa
		) l5 ON u.idUnidadAdministrativa = l5.idUnidadAdministrativa
		LEFT JOIN (
			SELECT COUNT(*) AS SinDigitalizacion, idUnidadAdministrativa 
			FROM Expedientes e 
			WHERE e.DocumentosDigitalizados = 0
			GROUP BY idUnidadAdministrativa
		) l6 ON u.idUnidadAdministrativa = l6.idUnidadAdministrativa
		LEFT JOIN (
			SELECT COUNT(*) AS ConDigitalizacion, idUnidadAdministrativa 
			FROM Expedientes e 
			WHERE e.DocumentosDigitalizados = 1
			GROUP BY idUnidadAdministrativa
		) l7 ON u.idUnidadAdministrativa = l7.idUnidadAdministrativa
	WHERE COALESCE(l1.ConImagenes, -1) > 0 
		OR COALESCE(l2.SinImagenes, -1) > 0 
		OR COALESCE(l3.TotalImagenes, -1) > 0 
		OR COALESCE(l4.ImagenesVerificadas, -1) > 0
		OR COALESCE(l5.ImagenesFaltantes, -1) > 0
	GROUP BY u.Descripcion,
		l0.TotalExpedientes,
		l1.ConImagenes,
		l2.SinImagenes,
		l4.ImagenesVerificadas,
		l5.ImagenesFaltantes,
		l3.TotalImagenes,
		l6.SinDigitalizacion,
		l7.ConDigitalizacion,
		l0.NumeroHojas

	--Detalle
	--SELECT e.IdExpediente, e.Nombre, r.NombrePDF
	--FROM Expedientes e
	--	INNER JOIN Expedientes_PDF_Relaciones r ON e.idExpediente = r.idExpediente
	--WHERE r.Verificado = 0

	--SELECT e.IdExpediente, e.Nombre
	--FROM Expedientes e
	--WHERE e.idExpediente NOT IN (SELECT idExpediente FROM Expedientes_PDF_Relaciones)
	--	AND e.DocumentosDigitalizados = 1

END	


GO
/****** Object:  StoredProcedure [dbo].[Etiquetas]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Etiquetas]
(
	@IDList TEXT,
	@Orden NVARCHAR(100) = ' caja, numero '
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Query NVARCHAR(MAX);

	SELECT 
		UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)) AS Fondo,
		UPPER(dbo.fnCodigoDeJerarquiaPorNivel(e.idClasificacion, 2)) AS Seccion,
		(CASE 
			WHEN UPPER(dbo.fnCodigoDeJerarquiaPorNivel(e.idClasificacion, 3)) = UPPER(dbo.fnCodigoDeJerarquiaMaxima(e.idClasificacion)) THEN '''' 
			ELSE UPPER(dbo.fnCodigoDeJerarquiaPorNivel(e.idClasificacion, 3)) 
		END) AS Serie,
		(CASE 
			WHEN UPPER(dbo.fnCodigoDeJerarquiaPorNivel(e.idClasificacion, 4)) = UPPER(dbo.fnCodigoDeJerarquiaMaxima(e.idClasificacion)) THEN '''' 
			ELSE UPPER(dbo.fnCodigoDeJerarquiaPorNivel(e.idClasificacion, 4)) 
		END) AS Subserie,
		UPPER(dbo.fnCodigoDeJerarquiaMaxima(e.idClasificacion)) AS Codigo,
		UPPER(e.Nombre) AS Nombre,
		e.idClasificacion,
		e.Caja,
		e.CampoAdicional1,
		e.CampoAdicional2,
		e.FechaApertura,
		u.NombreCorto,
		e.Control1,
		e.Control2 
	INTO #Etiquetas
	FROM Expedientes e 
		INNER JOIN dbo.fnSplitTextIDs(@IDList, ',') s ON e.IdExpediente = s.IdListed
		INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa = u.idUnidadAdministrativa;

	SET @Query= 'SELECT * FROM #Etiquetas ORDER BY ' + @Orden;
	
	EXEC(@Query);

	DROP TABLE #Etiquetas;
END
GO
/****** Object:  StoredProcedure [dbo].[ExpCambiaStatus]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ExpCambiaStatus]

@idExpediente	integer,
@Status		integer WITH ENCRYPTION

AS



UPDATE EXPEDIENTES SET idEstatusExpediente = @Status FROM EXPEDIENTES WHERE idExpediente = @idExpediente


GO
/****** Object:  StoredProcedure [dbo].[Expedientes_BUSCA]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






ALTER PROCEDURE [dbo].[Expedientes_BUSCA]
	@MiSQLString		varchar(4000),
	@MiCodigo		varchar(50),
	@MiExpediente		varchar(50),
	@MiExpedienteFinal	varchar(50),
	@MiTipo			varchar(50),
	@MiRFC			varchar(50),
	@MiAsunto		varchar(250),
	@MiCaja			varchar(25),
	@MiRelacionAnterior	VARCHAR(25),
	@MiFechaInicial		datetime,
	@MiFechaFinal		datetime WITH ENCRYPTION
AS
DECLARE @SQLString	NVARCHAR(4000)
DECLARE @ParmDefinition NVARCHAR(2000)
SET @SQLString = CONVERT(NVARCHAR(4000),@MiSQLString) 
SET @ParmDefinition = '@Codigo varchar(50), @Expediente varchar(50), @ExpedienteFinal varchar(50), @Tipo varchar(50), @RFC varchar(50), @Asunto varchar(250), @Caja varchar(25), @RelacionAnterior VARCHAR(25), @FechaInicial datetime, @FechaFinal datetime'
EXECUTE sp_executesql	@SQLString,
			@ParmDefinition,
			@Codigo = @MiCodigo,
			@Expediente = @MiExpediente,
			@ExpedienteFinal = @MiExpedienteFinal,
			@Tipo = @MiTipo,
			@RFC = @MiRFC,
			@Asunto = @MiAsunto,
			@Caja = @MiCaja,
			@RelacionAnterior = @MiRelacionAnterior,
			@FechaInicial = @MiFechaInicial,
			@FechaFinal = @MiFechaFinal
		






GO
/****** Object:  StoredProcedure [dbo].[Expedientes_BUSCA_2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Expedientes_BUSCA_2]

@MiSQLString		varchar(4000)--,
/*
@MiCodigo		varchar(50),
@MiExpediente		varchar(50),
@MiExpedienteFinal	varchar(50),
@MiTipo			varchar(50),
@MiRFC			varchar(50),
@MiAsunto		varchar(250),
@MiCaja			varchar(25),
@MiFechaInicial		datetime,
@MiFechaFinal		datetime
*/ WITH ENCRYPTION
AS

DECLARE @SQLString	NVARCHAR(4000)
DECLARE @ParmDefinition NVARCHAR(2000)

SET @SQLString = CONVERT(NVARCHAR(4000),@MiSQLString) 
SET @ParmDefinition ='' --'@Codigo varchar(50), @Expediente varchar(50), @ExpedienteFinal varchar(50), @Tipo varchar(50), @RFC varchar(50), @Asunto varchar(250), @Caja varchar(25), @FechaInicial datetime, @FechaFinal datetime'

EXECUTE sp_executesql	@SQLString,
			@ParmDefinition--,
/*
			@Codigo = @MiCodigo,
			@Expediente = @MiExpediente,
			@ExpedienteFinal = @MiExpedienteFinal,
			@Tipo = @MiTipo,
			@RFC = @MiRFC,
			@Asunto = @MiAsunto,
			@Caja = @MiCaja,
			@FechaInicial = @MiFechaInicial,
			@FechaFinal = @MiFechaFinal
		
*/

GO
/****** Object:  StoredProcedure [dbo].[Expedientes_BUSCA_WEB]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Expedientes_BUSCA_WEB]
(
	@SQLString NVARCHAR(MAX),
	@Codigo NVARCHAR(50),
	@Observaciones NVARCHAR(50),
	@Titulo	NVARCHAR(50),
	@Asunto	NVARCHAR(250),
	@Caja NVARCHAR(25),
	@RelacionAnterior NVARCHAR(25),
	@CajaAnterior NVARCHAR(25),
	@ItemAnterior NVARCHAR(25),
	@CampoAdicional3 NVARCHAR(25),
	@FechaInicial DATETIME,
	@FechaFinal	DATETIME,
	@Expediente	INT,
	@ExpedienteFinal INT
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Query NVARCHAR(MAX);
	DECLARE @ParmDefinition NVARCHAR(MAX);

	SET @Query = CONVERT(NVARCHAR(MAX), @SQLString); 

	SET @ParmDefinition = '@Codigo NVARCHAR(50), @Observaciones NVARCHAR(50), @Titulo NVARCHAR(50), @Asunto NVARCHAR(250), @Caja NVARCHAR(25), @RelacionAnterior NVARCHAR(25), @CajaAnterior NVARCHAR(25), @ItemAnterior NVARCHAR(25), @CampoAdicional3 NVARCHAR(25), @FechaInicial DATETIME, @FechaFinal DATETIME,  @Expediente NVARCHAR(50), @ExpedienteFinal NVARCHAR(50)';

	EXECUTE sp_executesql @Query,
				@ParmDefinition,
				@Codigo = @Codigo,
				@Observaciones = @Observaciones,
				@Titulo = @Titulo,
				@Asunto = @Asunto,
				@Caja = @Caja,
				@RelacionAnterior = @RelacionAnterior,
				@CajaAnterior = @CajaAnterior,
				@ItemAnterior = @ItemAnterior,
				@CampoAdicional3 = @CampoAdicional3,
				@FechaInicial = @FechaInicial,
				@FechaFinal = @FechaFinal,
				@Expediente = @Expediente,
				@ExpedienteFinal = @ExpedienteFinal;
END




GO
/****** Object:  StoredProcedure [dbo].[Expedientes_BUSCA_WEB2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Expedientes_BUSCA_WEB2]
	@MiSQLString		varchar(4000),
	@MiCodigo		varchar(50),
	@MiExpediente		varchar(50),
	@MiExpedienteFinal	varchar(50),
	@MiTipo			varchar(50),
	@MiRFC			varchar(50),
	@MiAsunto		varchar(250),
	@MiCaja			varchar(25),

	@MiAnaqC		varchar(25),
	@MiUbicC		varchar(25),
	@MiObsC			varchar(25),


	@MiRelacionAnterior	VARCHAR(25),
	@MiCajaAnterior		varchar(25),
	@MiItemAnterior		varchar(25),

	@MiCampoAdicional3	varchar(25),

	@MiFechaInicial		datetime,
	@MiFechaFinal		datetime WITH ENCRYPTION
AS 
DECLARE @SQLString	NVARCHAR(4000)
DECLARE @ParmDefinition NVARCHAR(2000)
SET @SQLString = CONVERT(NVARCHAR(4000),@MiSQLString) 
SET @ParmDefinition = '@Codigo varchar(50), @Expediente varchar(50), @ExpedienteFinal varchar(50), @Tipo varchar(50), @RFC varchar(50), @Asunto varchar(250), @Caja varchar(25),    @AnaqC varchar(25),@UbicC varchar(25),@ObsC varchar(25),        @RelacionAnterior VARCHAR(25), @CajaAnterior varchar(25), @ItemAnterior varchar(25), @CampoAdicional3 varchar(25), @FechaInicial datetime, @FechaFinal datetime'
EXECUTE sp_executesql	@SQLString,
			@ParmDefinition,
			@Codigo = @MiCodigo,
			@Expediente = @MiExpediente,
			@ExpedienteFinal = @MiExpedienteFinal,
			@Tipo = @MiTipo,
			@RFC = @MiRFC,
			@Asunto = @MiAsunto,

			@Caja = @MiCaja,

			@AnaqC = @MiAnaqC,
			@UbicC = @MiUbicC,
			@ObsC = @MiObsC,


			@RelacionAnterior = @MiRelacionAnterior,
			@CajaAnterior = @MiCajaAnterior,
			@ItemAnterior = @MiItemAnterior,
			@CampoAdicional3 = @MiCampoAdicional3,

			@FechaInicial = @MiFechaInicial,
			@FechaFinal = @MiFechaFinal
		



GO
/****** Object:  StoredProcedure [dbo].[Expedientes_Busqueda]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Expedientes_Busqueda
ALTER PROCEDURE [dbo].[Expedientes_Busqueda]
(
	@SQLString NVARCHAR(MAX),
	@Codigo NVARCHAR(50),
	@Observaciones NVARCHAR(50),
	@Titulo	NVARCHAR(50),
	@Asunto	NVARCHAR(250),
	@Caja NVARCHAR(25),
	@RelacionAnterior NVARCHAR(25),
	@CajaAnterior NVARCHAR(25),
	@ItemAnterior NVARCHAR(25),
	@CampoAdicional3 NVARCHAR(25),
	@FechaInicial DATETIME,
	@FechaFinal	DATETIME,
	@Expediente	INT,
	@ExpedienteFinal INT
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Query NVARCHAR(MAX);
	DECLARE @ParmDefinition NVARCHAR(MAX);

	SET @Query = CONVERT(NVARCHAR(MAX), @SQLString); 

	SET @ParmDefinition = '@Codigo NVARCHAR(50), @Observaciones NVARCHAR(50), @Titulo NVARCHAR(50), @Asunto NVARCHAR(250), @Caja NVARCHAR(25), @RelacionAnterior NVARCHAR(25), @CajaAnterior NVARCHAR(25), @ItemAnterior NVARCHAR(25), @CampoAdicional3 NVARCHAR(25), @FechaInicial DATETIME, @FechaFinal DATETIME,  @Expediente NVARCHAR(50), @ExpedienteFinal NVARCHAR(50)';

	CREATE TABLE #Temporal
	(
		Codigo NVARCHAR(50),
		IdExpediente INT,
		Expediente NVARCHAR(50),
		Observaciones NVARCHAR(50),
		Titulo NVARCHAR(MAX),
		Asunto NVARCHAR(MAX),
		RelacionAnterior NVARCHAR(50),
		Caja NVARCHAR(50),
		CajaAnterior NVARCHAR(50),
		Apertura NVARCHAR(10),
		Cierre NVARCHAR(10),
		NombreCorto NVARCHAR(100),
		Digitalizacion BIT
	);

	INSERT INTO #Temporal
	EXECUTE sp_executesql @Query,
				@ParmDefinition,
				@Codigo = @Codigo,
				@Observaciones = @Observaciones,
				@Titulo = @Titulo,
				@Asunto = @Asunto,
				@Caja = @Caja,
				@RelacionAnterior = @RelacionAnterior,
				@CajaAnterior = @CajaAnterior,
				@ItemAnterior = @ItemAnterior,
				@CampoAdicional3 = @CampoAdicional3,
				@FechaInicial = @FechaInicial,
				@FechaFinal = @FechaFinal,
				@Expediente = @Expediente,
				@ExpedienteFinal = @ExpedienteFinal;

	SELECT t.*, 
		COALESCE((SELECT TOP 1 NombrePDF FROM Expedientes_PDF_Relaciones WHERE idExpediente = t.IdExpediente), 'Sin definir') AS NombreArchivo, 
		CASE 
			WHEN t.Digitalizacion = 0 THEN -1
			ELSE (SELECT COUNT(NombrePDF) FROM Expedientes_PDF_Relaciones WHERE idExpediente = t.IdExpediente AND Verificado = 1)
		END AS ArchivosLocalizados,
		COALESCE((SELECT COUNT(Verificado) - SUM(CAST(Verificado AS INT)) FROM Expedientes_PDF_Relaciones WHERE idExpediente = t.IdExpediente), -1) AS ArchivosNoLocalizados
	FROM #Temporal t;

	DROP TABLE #Temporal;

END
GO
/****** Object:  StoredProcedure [dbo].[Expedientes_Busqueda_RRHH]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Expedientes_Busqueda_RRHH
ALTER PROCEDURE [dbo].[Expedientes_Busqueda_RRHH]
(
	@SQLString NVARCHAR(MAX),
	@Codigo NVARCHAR(50),
	@Observaciones NVARCHAR(50),
	@Titulo	NVARCHAR(50),
	@Asunto	NVARCHAR(250),
	@Caja NVARCHAR(25),
	@RelacionAnterior NVARCHAR(25),
	@CajaAnterior NVARCHAR(25),
	@ItemAnterior NVARCHAR(25),
	@CampoAdicional3 NVARCHAR(25),
	@FechaInicial DATETIME,
	@FechaFinal	DATETIME,
	@Expediente	INT,
	@ExpedienteFinal INT
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Query NVARCHAR(MAX);
	DECLARE @ParmDefinition NVARCHAR(MAX);

	SET @Query = CONVERT(NVARCHAR(MAX), @SQLString); 

	SET @ParmDefinition = '@Codigo NVARCHAR(50), @Observaciones NVARCHAR(50), @Titulo NVARCHAR(50), @Asunto NVARCHAR(250), @Caja NVARCHAR(25), @RelacionAnterior NVARCHAR(25), @CajaAnterior NVARCHAR(25), @ItemAnterior NVARCHAR(25), @CampoAdicional3 NVARCHAR(25), @FechaInicial DATETIME, @FechaFinal DATETIME,  @Expediente NVARCHAR(50), @ExpedienteFinal NVARCHAR(50)';

	CREATE TABLE #Temporal
	(
		Codigo NVARCHAR(50),
		IdExpediente INT,
		Expediente NVARCHAR(50),
		Estado NVARCHAR(50),
		Numero NVARCHAR(50),
		Nombre NVARCHAR(250),
		RelacionAnterior NVARCHAR(50),
		Caja NVARCHAR(50),
		CajaAnterior NVARCHAR(50),
		Contratacion NVARCHAR(50),
		Apertura NVARCHAR(10),
		Cierre NVARCHAR(10),
		NombreCorto NVARCHAR(100),
		Digitalizacion BIT
	);

	INSERT INTO #Temporal
	EXECUTE sp_executesql @Query,
				@ParmDefinition,
				@Codigo = @Codigo,
				@Observaciones = @Observaciones,
				@Titulo = @Titulo,
				@Asunto = @Asunto,
				@Caja = @Caja,
				@RelacionAnterior = @RelacionAnterior,
				@CajaAnterior = @CajaAnterior,
				@ItemAnterior = @ItemAnterior,
				@CampoAdicional3 = @CampoAdicional3,
				@FechaInicial = @FechaInicial,
				@FechaFinal = @FechaFinal,
				@Expediente = @Expediente,
				@ExpedienteFinal = @ExpedienteFinal;

	SELECT t.*, 
		COALESCE((SELECT TOP 1 NombrePDF FROM Expedientes_PDF_Relaciones WHERE idExpediente = t.IdExpediente), 'Sin definir') AS NombreArchivo, 
		CASE 
			WHEN t.Digitalizacion = 0 THEN -1
			ELSE (SELECT COUNT(NombrePDF) FROM Expedientes_PDF_Relaciones WHERE idExpediente = t.IdExpediente AND Verificado = 1)
		END AS ArchivosLocalizados,
		COALESCE((SELECT COUNT(Verificado) - SUM(CAST(Verificado AS INT)) FROM Expedientes_PDF_Relaciones WHERE idExpediente = t.IdExpediente), -1) AS ArchivosNoLocalizados
	FROM #Temporal t;

	DROP TABLE #Temporal;

END
GO
/****** Object:  StoredProcedure [dbo].[Expedientes_busquedaGeneral]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC Expedientes_busquedaGeneral 'SEN.01S.10', '2012/000001'
--DROP PROCEDURE Expedientes_busquedaGeneral
ALTER PROCEDURE [dbo].[Expedientes_busquedaGeneral]
(
	@Codigo	NVARCHAR(50) = '',
	@Numero	NVARCHAR(50) = '',
	@NumeroExpedienteFinal NVARCHAR(50) = '',
	@Titulo NVARCHAR(50) = '',
	@Observaciones NVARCHAR(50) = '',
	@Asunto NVARCHAR(MAX) = '',
	@Caja NVARCHAR(50) = '',
	@CajaOriginal NVARCHAR(50) = '',
	@FechaInicial DATE = '01/01/2010',
	@FechaFinal DATE = '01/01/2010',
	@BusquedaExacta BIT = 0
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Select AS NVARCHAR(MAX);
	DECLARE @Operador AS NVARCHAR(2);
	DECLARE @Where AS NVARCHAR(MAX);
	DECLARE @Params AS NVARCHAR(MAX);
	SET @Select = 
	'SELECT 
		e.idClasificacion,
		dbo.fnNombreDeJerarquia(e.idClasificacion) AS Codigo,
		e.Nombre AS Numero,
		e.CampoAdicional2 AS Titulo,
		e.Asunto,
		e.CampoAdicional1 AS Observaciones,
		e.Caja,
		e.CajaAnterior,
		e.FechaApertura AS Apertura,
		e.FechaCierre AS Cierre,
		e.FechaCierreChecked AS Cerrado,
		u.idUnidadAdministrativa,
		u.NombreCorto AS UnidadAdministrativa
	FROM Expedientes e
		INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa = u.idUnidadAdministrativa'

	SET @Where = ' WHERE ';

	IF @Codigo <> ''
		SET @Where = @Where + ' dbo.fnNombreDeJerarquia(e.idClasificacion) ' + CASE WHEN @BusquedaExacta = 1 THEN '= @Codigo ' ELSE 'LIKE @Codigo ' END;
	ELSE
		SET @Where = @Where + ' @Codigo = @Codigo ';

	IF @Numero <> ''
		SET @Where = @Where + ' AND e.Nombre = @Numero ';
	ELSE
		SET @Where = @Where + ' AND @Numero = @Numero ';
		



	SET @Select = @Select + @Where;

	SET @Params = '@Codigo NVARCHAR(50), @Numero NVARCHAR(50)'

	EXECUTE sp_executesql @Select,
			@Params,
			@Codigo = @Codigo,
			@Numero = @Numero

END


GO
/****** Object:  StoredProcedure [dbo].[Expedientes_CUENTA]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





ALTER PROCEDURE [dbo].[Expedientes_CUENTA]
	@MiSQLString		varchar(4000),
	@MiCodigo		varchar(50),
	@MiExpediente		varchar(50),
	@MiExpedienteFinal	varchar(50),
	@MiTipo			varchar(50),
	@MiRFC			varchar(50),
	@MiAsunto		varchar(250),
	@MiCaja			varchar(25),
	@MiRelacionAnterior	VARCHAR(25),
	@MiFechaInicial		datetime,
	@MiFechaFinal		datetime,
	@MiContador		integer output WITH ENCRYPTION
AS
DECLARE @SQLString	NVARCHAR(4000)
DECLARE @ParmDefinition NVARCHAR(2000)
SET @SQLString = CONVERT(NVARCHAR(4000),@MiSQLString) 
SET @ParmDefinition = '@Codigo varchar(50), @Expediente varchar(50), @ExpedienteFinal varchar(50), @Tipo varchar(50), @RFC varchar(50), @Asunto varchar(250), @Caja varchar(25), @RelacionAnterior VARCHAR(25), @FechaInicial datetime, @FechaFinal datetime, @Contador integer output'
EXECUTE sp_executesql	@SQLString,
			@ParmDefinition,
			@Codigo = @MiCodigo,
			@Expediente = @MiExpediente,
			@ExpedienteFinal = @MiExpedienteFinal,
			@Tipo = @MiTipo,
			@RFC = @MiRFC,
			@Asunto = @MiAsunto,
			@Caja = @MiCaja,
			@RelacionAnterior = @MiRelacionAnterior,
			@FechaInicial = @MiFechaInicial,
			@FechaFinal = @MiFechaFinal,
			@Contador = @MiContador output



GO
/****** Object:  StoredProcedure [dbo].[Expedientes_CUENTA_WEB]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Expedientes_CUENTA_WEB]
	@MiSQLString		varchar(4000),
	@MiCodigo		varchar(50),
	@MiExpediente		varchar(50),
	@MiExpedienteFinal	varchar(50),
	@MiTipo			varchar(50),
	@MiRFC			varchar(50),
	@MiAsunto		varchar(250),
	@MiCaja			varchar(25),
	@MiRelacionAnterior	VARCHAR(25),
	@MiCajaAnterior		varchar(25),
	@MiItemAnterior		varchar(25),

	@MiCampoAdicional3	varchar(25),

	@MiFechaInicial		datetime,
	@MiFechaFinal		datetime,
	@MiContador		integer output WITH ENCRYPTION
AS
DECLARE @SQLString	NVARCHAR(4000)
DECLARE @ParmDefinition NVARCHAR(2000)
SET @SQLString = CONVERT(NVARCHAR(4000),@MiSQLString) 
SET @ParmDefinition = '@Codigo varchar(50), @Expediente varchar(50), @ExpedienteFinal varchar(50), @Tipo varchar(50), @RFC varchar(50), @Asunto varchar(250), @Caja varchar(25), @RelacionAnterior VARCHAR(25), @CajaAnterior varchar(25), @ItemAnterior varchar(25), @CampoAdicional3 varchar(25), @FechaInicial datetime, @FechaFinal datetime, @Contador integer output'
EXECUTE sp_executesql	@SQLString,
			@ParmDefinition,
			@Codigo = @MiCodigo,
			@Expediente = @MiExpediente,
			@ExpedienteFinal = @MiExpedienteFinal,
			@Tipo = @MiTipo,
			@RFC = @MiRFC,
			@Asunto = @MiAsunto,
			@Caja = @MiCaja,
			@RelacionAnterior = @MiRelacionAnterior,
			@CajaAnterior = @MiCajaAnterior,
			@ItemAnterior = @MiItemAnterior,

			@CampoAdicional3 = @MiCampoAdicional3,

			@FechaInicial = @MiFechaInicial,
			@FechaFinal = @MiFechaFinal,
			@Contador = @MiContador output



GO
/****** Object:  StoredProcedure [dbo].[Expedientes_CUENTA_WEB2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Expedientes_CUENTA_WEB2]
	@MiSQLString		varchar(4000),
	@MiCodigo		varchar(50),
	@MiExpediente		varchar(50),
	@MiExpedienteFinal	varchar(50),
	@MiTipo			varchar(50),
	@MiRFC			varchar(50),
	@MiAsunto		varchar(250),
	@MiCaja			varchar(25),

	@MiAnaqC		varchar(25),
	@MiUbicC		varchar(25),
	@MiObsC			varchar(25),

	@MiRelacionAnterior	VARCHAR(25),
	@MiCajaAnterior		varchar(25),
	@MiItemAnterior		varchar(25),

	@MiCampoAdicional3	varchar(25),

	@MiFechaInicial		datetime,
	@MiFechaFinal		datetime,
	@MiContador		integer output WITH ENCRYPTION
AS
DECLARE @SQLString	NVARCHAR(4000)
DECLARE @ParmDefinition NVARCHAR(2000)
SET @SQLString = CONVERT(NVARCHAR(4000),@MiSQLString) 
SET @ParmDefinition = '@Codigo varchar(50), @Expediente varchar(50), @ExpedienteFinal varchar(50), @Tipo varchar(50), @RFC varchar(50), @Asunto varchar(250), @Caja varchar(25),       @AnaqC varchar(25),@UbicC varchar(25),@ObsC varchar(25),      @RelacionAnterior VARCHAR(25), @CajaAnterior varchar(25), @ItemAnterior varchar(25), @CampoAdicional3 varchar(25), @FechaInicial datetime, @FechaFinal datetime, @Contador integer output'
EXECUTE sp_executesql	@SQLString,
			@ParmDefinition,
			@Codigo = @MiCodigo,
			@Expediente = @MiExpediente,
			@ExpedienteFinal = @MiExpedienteFinal,
			@Tipo = @MiTipo,
			@RFC = @MiRFC,
			@Asunto = @MiAsunto,

			@Caja = @MiCaja,

			@AnaqC = @MiAnaqC,
			@UbicC = @MiUbicC,
			@ObsC = @MiObsC,

			@RelacionAnterior = @MiRelacionAnterior,
			@CajaAnterior = @MiCajaAnterior,
			@ItemAnterior = @MiItemAnterior,
			@CampoAdicional3 = @MiCampoAdicional3,

			@FechaInicial = @MiFechaInicial,
			@FechaFinal = @MiFechaFinal,
			@Contador = @MiContador output




GO
/****** Object:  StoredProcedure [dbo].[Expedientes_DELETE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Expedientes_DELETE]

	@idExpediente 		integer,
	@id_record_procesadoOK	integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int,
	@NextLeft_idExpediente	integer,
	@NextRight_idExpediente	integer

SELECT
	@err1 = 0

	BEGIN TRAN
	--Guardo hacia donde apunta por la izquierda el Expediente a borrar
	--SET @NextLeft_idExpediente = (SELECT NextLeft FROM Expedientes e WHERE e.idExpediente = @idExpediente)
	--Guardo hacia donde apunta por la derecha el Expediente a borrar
	--SET @NextRight_idExpediente = (SELECT NextRight FROM Expedientes e WHERE e.idExpediente = @idExpediente)

	--Borro los ficheros de relaciones
	DELETE ValorDocumental_Expedientes_Relaciones
	WHERE idExpediente = @idExpediente
	SET @err1 = @err1 + @@error 
	IF @err1 <> 0 GOTO ERROR_ENCONTRADO

	DELETE FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones
	WHERE idExpediente = @idExpediente
	SET @err1 = @err1 + @@error 
	IF @err1 <> 0 GOTO ERROR_ENCONTRADO

	DELETE FundamentosLegalesDeClasificacion_Expedientes_Relaciones
	WHERE idExpediente = @idExpediente
	SET @err1 = @err1 + @@error 
	IF @err1 <> 0 GOTO ERROR_ENCONTRADO

	DELETE Expedientes_PDF_Relaciones
	WHERE idExpediente = @idExpediente
	SET @err1 = @err1 + @@error 
	IF @err1 <> 0 GOTO ERROR_ENCONTRADO

	--Borro el Expediente
	DELETE Expedientes
	WHERE idExpediente = @idExpediente
	SET @err1 = @err1 + @@error 
	IF @err1 <> 0 GOTO ERROR_ENCONTRADO

	--Si tuve éxito, actualizo los punteros
	--para que los records vuelvan a quedar enlazados

	--Si el nodo borrado no tenía vecino por la izquierda...
	IF @NextLeft_idExpediente = 0 
		BEGIN
			--El record borrado estaba en el extremo izquierdo de la lista
			--por lo tanto el record que él apuntaba por la derecha debe
			--ser el nuevo extremo izquierdo
			IF @NextRight_idExpediente = 0 
				BEGIN
				--Si el record borrado también estaba en el extremo derecho de la lista,
				--eso quiere decir que era el único, así que no tengo a quien actualizar
					SET @NextRight_idExpediente = 0
				END
			ELSE
				BEGIN
					--UPDATE Expedientes SET NextLeft = 0 WHERE idExpediente = @NextRight_idExpediente
					SET @err1 = @err1 + @@error 
					IF @err1 <> 0 GOTO ERROR_ENCONTRADO
				END
		END
	ELSE
		BEGIN
			--El record borrado tenía un vecino por la izquierda, por lo tanto
			--dicho vecino debe ahora apuntar por la derecha al que apuntaba él por la derecha
			IF @NextRight_idExpediente = 0 
				BEGIN
					--El record borrado era el extremo derecho, por lo tanto el record
					--que él apuntaba por la izquierda se convierte en el nuevo extremo derecho
					--UPDATE Expedientes SET NextRight = 0 WHERE idExpediente = @NextLeft_idExpediente
					SET @err1 = @err1 + @@error 
					IF @err1 <> 0 GOTO ERROR_ENCONTRADO
				END
			ELSE
				BEGIN
					--El record borrado no era ni el extremo izquierdo ni el derecho,
					--por lo tanto debo actualizar los vecinos de la izquierda y de la
					--derecha. 

					--El de la izquierda debe apuntar ahora por su derecha al que apuntaba
					--por la derecha el que borré.
					--UPDATE Expedientes SET NextRight = @NextRight_idExpediente WHERE idExpediente = @NextLeft_idExpediente
					SET @err1 = @err1 + @@error 
					IF @err1 <> 0 GOTO ERROR_ENCONTRADO

					--El de la derecha debe apuntar ahora por su izquierda al que apuntaba 
					--por la izquierda el que borré.
					--UPDATE Expedientes SET NextLeft = @NextLeft_idExpediente WHERE idExpediente = @NextRight_idExpediente
					SET @err1 = @err1 + @@error 
					IF @err1 <> 0 GOTO ERROR_ENCONTRADO
				END
		END

ERROR_ENCONTRADO:
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END


GO
/****** Object:  StoredProcedure [dbo].[Expedientes_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[Expedientes_INSERT]
@idClasificacion				integer,
@Nombre						varchar(50),
@Asunto						varchar(250),
@NumeroDeFojas					integer,
@FechaApertura					datetime,
@FechaCierre					datetime,
@FechaCierreChecked				bit,
@FechaDePaseABajaHistorico			datetime,
@FechaDePaseABajaHistoricoChecked		bit,
@idUsuario_AutorizaBajaHistorico		integer,
@Caja						varchar(25),
@Pasillo					varchar(25),
@Anaquel					varchar(25),
@Entrepano					varchar(25),
@RelacionAnterior				varchar(25),
@CajaAnterior					varchar(25),
@ItemAnterior					varchar(25),
@FechaDeCreacion				datetime,
@idUsuario_ElaboradoPor				integer,
/*
OJO: 
********************************************
LOS PARÁMETROS COMENTADOS MÁS ABAJO SE REFIEREN
A LAS PROPIEDADES DE UN EXPEDIENTE, HEREDADAS DEL CUADRO 
DE CLASIFICACION ARCHIVÍSTICA A QUE PERTENECE.
COMENTO ESTOS CAMPOS POR LOS REQUERIMIENTOS DE SEGURIDAD
DEL SISTEMA, DE MANERA QUE SE PUEDA O NO DAR PERMISOS A LA
EDICIÓN DE LOS MISMOS, MEDIANTE LA ASIGNACIÓN
POR USUARIO VIRTUAL, DE PERMISOS DE EJECUCIÓN SOBRE OTRO SP.
TODOS LOS PARÁMETROS COMENTADOS TIENE VALOR POR DEFAULT,
POR LO QUE NO SON IMPRESCINDIBLES EN UN INSERT. SIN EMBARGO,
LA INSERCIÓN DEBE SER INMEDIATAMENTE SEGUIDA DE UN UPDATE
SOBRE LOS PARÁMETROS COMENTADOS. LOS VALORES DEL UPDATE
PUEDEN PROVENIR DEL CUADRO (SI EL USUARIO VIRTUAL NO
TIENE PERMISOS PARA CAMBIARLOS) O DEL VALOR DE LOS CONTROLES
DE LA FORMA (SI EL USUARIO VIRTUAL TIENE PERMISO). ESTO
ULTIMO LO DECIDE LA INTERFAZ.
LA EDICIÓN DE LOS PARÁMETROS COMENTADOS SE HACE CON EL SP
Expedientes_UPDATE_2
@idClasificacionStatus				integer,
@ClasificaSoloParte				bit,
@FojasParte					varchar(25),
@FechaClasificacion				datetime,
@FechaClasificacionChecked			bit,
@FechaPropuestaDesclasificacion			datetime,
@FechaPropuestaDesclasificacionChecked		bit,
@NuevaFechaDesclasificacion			datetime,
@NuevaFechaDesclasificacionChecked		bit,
@NuevaClasificaSoloParte			bit,
@NuevaFojasParte				varchar(25),
@idUsuario_AutorizaAmpliacionClasificacion	integer,
@FechaDeDesclasificacion			datetime,
@FechaDeDesclasificacionChecked			bit,
@idUsuario_AutorizaDesclasificacion		integer,
@idPlazoTramite					integer,
@idPlazoConcentracion				integer,
@idDestinoFinal					integer,
*/
@CampoAdicional1				varchar(50),
@CampoAdicional2				varchar(50),
@idUsuarioUltimaEdicion				integer,
@idUnidadAdministrativa				integer,
@idCalidadDocumental				integer,
@id_record_procesadoOK				integer = 0	output WITH ENCRYPTION
AS
	DECLARE @err1			int
	DECLARE @LastIDExpediente	int
	DECLARE @Consecutivo		int
	SET @err1 = 0
	BEGIN TRAN
	-- Busco el id del record final (si no existe, devuelvo -1)
	--SET @LastIDExpediente = ISNULL((SELECT e.idExpediente FROM Expedientes e WHERE e.NextRight =0),-1)
	SET @LastIDExpediente = -1
/*
OJO:
********************************************
ESTE CODIGO ESTA ADAPTADO A LOS REQUERIMIENTOS DE CAPUFE, EN QUE EL CÓDIGO SE GENERABA AUTOMÁTICAMENTE.
EN EL CASO DEL ISSSTE, NO ES NECESARIO PORQUE LOS CÓDIGOS SIEMPRE SE VAN A DAR POR TECLADO.
NO LO BORRO PARA TENERLO LISTO SI HACE FALTA DE NUEVO.
*/
	DECLARE @NuevoNumero AS VARCHAR(25)
	EXECUTE NuevoNumeroDeExpediente @idClasificacion, @FechaApertura, @NuevoNumero OUTPUT
	--Preparo el nombre del Expediente (si me pasaron una ?, lo sustituyo por el año seguido de un slash, seguido del @Consecutivo
	SET @Nombre = CASE
			WHEN @Nombre = '?' THEN @NuevoNumero
			ELSE @Nombre
			END
	--Inserto un record en Expedientes
	INSERT Expedientes
	(
		idClasificacion,
		Nombre,
		Asunto,
		NumeroDeFojas,
		FechaApertura,
		FechaCierre,
		FechaCierreChecked,
		FechaDePaseABajaHistorico,
		FechaDePaseABajaHistoricoChecked,
		idUsuario_AutorizaBajaHistorico,
		Caja,
		Pasillo,
		Anaquel,
		Entrepano,
		RelacionAnterior,
		CajaAnterior,
		ItemAnterior,
		FechaDeCreacion,
		idUsuario_ElaboradoPor,
/*
		idClasificacionStatus,
		ClasificaSoloParte,
		FojasParte,
		FechaClasificacion,
		FechaClasificacionChecked,
		FechaPropuestaDesclasificacion,
		FechaPropuestaDesclasificacionChecked,
		NuevaFechaDesclasificacion,
		NuevaFechaDesclasificacionChecked,
		NuevaClasificaSoloParte,
		NuevaFojasParte,
		idUsuario_AutorizaAmpliacionClasificacion,
		FechaDeDesclasificacion,
		FechaDeDesclasificacionChecked,
		idUsuario_AutorizaDesclasificacion,
		idPlazoTramite,
		idPlazoConcentracion,
		idDestinoFinal,
*/
		CampoAdicional1,
		CampoAdicional2,
		idUsuarioUltimaEdicion,
		idUnidadAdministrativa,
		idCalidadDocumental
	)
	VALUES
	(
		@idClasificacion,
		ltrim(rtrim(@Nombre)),
		ltrim(rtrim(@Asunto)),
		@NumeroDeFojas,
		@FechaApertura,
		@FechaCierre,
		@FechaCierreChecked,
		@FechaDePaseABajaHistorico,
		@FechaDePaseABajaHistoricoChecked,
		@idUsuario_AutorizaBajaHistorico,
		ltrim(rtrim(@Caja)),
		ltrim(rtrim(@Pasillo)),
		ltrim(rtrim(@Anaquel)),
		ltrim(rtrim(@Entrepano)),
		ltrim(rtrim(@RelacionAnterior)),
		ltrim(rtrim(@CajaAnterior)),
		ltrim(rtrim(@ItemAnterior)),
		@FechaDeCreacion,
		@idUsuario_ElaboradoPor,
/*
		@idClasificacionStatus,
		@ClasificaSoloParte,
		ltrim(rtrim(@FojasParte)),
		@FechaClasificacion,
		@FechaClasificacionChecked,
		@FechaPropuestaDesclasificacion,
		@FechaPropuestaDesclasificacionChecked,
		@NuevaFechaDesclasificacion,
		@NuevaFechaDesclasificacionChecked,
		@NuevaClasificaSoloParte,
		ltrim(rtrim(@NuevaFojasParte)),
		@idUsuario_AutorizaAmpliacionClasificacion,
		@FechaDeDesclasificacion,
		@FechaDeDesclasificacionChecked,
		@idUsuario_AutorizaDesclasificacion,
		@idPlazoTramite,
		@idPlazoConcentracion,
		@idDestinoFinal,
*/
		@CampoAdicional1,
		@CampoAdicional2,
		@idUsuarioUltimaEdicion,
		@idUnidadAdministrativa,
		@idCalidadDocumental
	)
	SET @err1 = @@error 
	IF (@err1 <> 0) GOTO HUBO_ERRORES
	--Busco el id del record recién insertado
	SET @id_record_procesadoOK = (SELECT MAX(idExpediente) FROM Expedientes)
	--Hago que el @LastIDExpediente apunte por la derecha al nuevo record
	--UPDATE Expedientes SET NextRight = @id_record_procesadoOK WHERE idExpediente = @LastIDExpediente
	SET @err1 = @@error 
	IF (@err1 <> 0) GOTO HUBO_ERRORES
HUBO_ERRORES:
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			SELECT @id_record_procesadoOK = 0
		END


GO
/****** Object:  StoredProcedure [dbo].[Expedientes_INSERT_2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Expedientes_INSERT_2]
@idClasificacion				integer,
@Nombre						varchar(50),
@Asunto						varchar(250),
@NumeroDeFojas					integer,
@FechaApertura					datetime,
@FechaCierre					datetime,
@FechaCierreChecked				bit,
@FechaDePaseABajaHistorico			datetime,
@FechaDePaseABajaHistoricoChecked		bit,
@idUsuario_AutorizaBajaHistorico		integer,
@Caja						varchar(25),
@Pasillo					varchar(25),
@Anaquel					varchar(25),
@Entrepano					varchar(25),
@RelacionAnterior				varchar(25),
@CajaAnterior					varchar(25),
@ItemAnterior					varchar(25),
@FechaDeCreacion				datetime,
@idUsuario_ElaboradoPor				integer,
/*
OJO: 
********************************************
LOS PARÁMETROS COMENTADOS MÁS ABAJO SE REFIEREN
A LAS PROPIEDADES DE UN EXPEDIENTE, HEREDADAS DEL CUADRO 
DE CLASIFICACION ARCHIVÍSTICA A QUE PERTENECE.
COMENTO ESTOS CAMPOS POR LOS REQUERIMIENTOS DE SEGURIDAD
DEL SISTEMA, DE MANERA QUE SE PUEDA O NO DAR PERMISOS A LA
EDICIÓN DE LOS MISMOS, MEDIANTE LA ASIGNACIÓN
POR USUARIO VIRTUAL, DE PERMISOS DE EJECUCIÓN SOBRE OTRO SP.
TODOS LOS PARÁMETROS COMENTADOS TIENE VALOR POR DEFAULT,
POR LO QUE NO SON IMPRESCINDIBLES EN UN INSERT. SIN EMBARGO,
LA INSERCIÓN DEBE SER INMEDIATAMENTE SEGUIDA DE UN UPDATE
SOBRE LOS PARÁMETROS COMENTADOS. LOS VALORES DEL UPDATE
PUEDEN PROVENIR DEL CUADRO (SI EL USUARIO VIRTUAL NO
TIENE PERMISOS PARA CAMBIARLOS) O DEL VALOR DE LOS CONTROLES
DE LA FORMA (SI EL USUARIO VIRTUAL TIENE PERMISO). ESTO
ULTIMO LO DECIDE LA INTERFAZ.
LA EDICIÓN DE LOS PARÁMETROS COMENTADOS SE HACE CON EL SP
Expedientes_UPDATE_2
@idClasificacionStatus				integer,
@ClasificaSoloParte				bit,
@FojasParte					varchar(25),
@FechaClasificacion				datetime,
@FechaClasificacionChecked			bit,
@FechaPropuestaDesclasificacion			datetime,
@FechaPropuestaDesclasificacionChecked		bit,
@NuevaFechaDesclasificacion			datetime,
@NuevaFechaDesclasificacionChecked		bit,
@NuevaClasificaSoloParte			bit,
@NuevaFojasParte				varchar(25),
@idUsuario_AutorizaAmpliacionClasificacion	integer,
@FechaDeDesclasificacion			datetime,
@FechaDeDesclasificacionChecked			bit,
@idUsuario_AutorizaDesclasificacion		integer,
@idPlazoTramite					integer,
@idPlazoConcentracion				integer,
@idDestinoFinal					integer,
*/
@CampoAdicional1				varchar(50),
@CampoAdicional2				varchar(50),
@idUsuarioUltimaEdicion				integer,
@idUnidadAdministrativa				integer,
@idCalidadDocumental				integer,
@CampoAdicional3				varchar(25),
@id_record_procesadoOK				integer = 0	output WITH ENCRYPTION
AS
	DECLARE @err1			int
	DECLARE @LastIDExpediente	int
	DECLARE @Consecutivo		int
	SET @err1 = 0
	BEGIN TRAN
	-- Busco el id del record final (si no existe, devuelvo -1)
	--SET @LastIDExpediente = ISNULL((SELECT e.idExpediente FROM Expedientes e WHERE e.NextRight =0),-1)
	SET @LastIDExpediente = -1
/*
OJO:
********************************************
ESTE CODIGO ESTA ADAPTADO A LOS REQUERIMIENTOS DE CAPUFE, EN QUE EL CÓDIGO SE GENERABA AUTOMÁTICAMENTE.
EN EL CASO DEL ISSSTE, NO ES NECESARIO PORQUE LOS CÓDIGOS SIEMPRE SE VAN A DAR POR TECLADO.
NO LO BORRO PARA TENERLO LISTO SI HACE FALTA DE NUEVO.
*/
	DECLARE @NuevoNumero AS VARCHAR(25)
	EXECUTE NuevoNumeroDeExpediente @idClasificacion, @FechaApertura, @NuevoNumero OUTPUT
	--Preparo el nombre del Expediente (si me pasaron una ?, lo sustituyo por el año seguido de un slash, seguido del @Consecutivo
	SET @Nombre = CASE
			WHEN @Nombre = '?' THEN @NuevoNumero
			ELSE @Nombre
			END
	--Inserto un record en Expedientes
	INSERT Expedientes
	(
		idClasificacion,
		Nombre,
		Asunto,
		NumeroDeFojas,
		FechaApertura,
		FechaCierre,
		FechaCierreChecked,
		FechaDePaseABajaHistorico,
		FechaDePaseABajaHistoricoChecked,
		idUsuario_AutorizaBajaHistorico,
		Caja,
		Pasillo,
		Anaquel,
		Entrepano,
		RelacionAnterior,
		CajaAnterior,
		ItemAnterior,
		FechaDeCreacion,
		idUsuario_ElaboradoPor,
/*
		idClasificacionStatus,
		ClasificaSoloParte,
		FojasParte,
		FechaClasificacion,
		FechaClasificacionChecked,
		FechaPropuestaDesclasificacion,
		FechaPropuestaDesclasificacionChecked,
		NuevaFechaDesclasificacion,
		NuevaFechaDesclasificacionChecked,
		NuevaClasificaSoloParte,
		NuevaFojasParte,
		idUsuario_AutorizaAmpliacionClasificacion,
		FechaDeDesclasificacion,
		FechaDeDesclasificacionChecked,
		idUsuario_AutorizaDesclasificacion,
		idPlazoTramite,
		idPlazoConcentracion,
		idDestinoFinal,
*/
		CampoAdicional1,
		CampoAdicional2,
		idUsuarioUltimaEdicion,
		idUnidadAdministrativa,
		idCalidadDocumental,
CampoAdicional3
	)
	VALUES
	(
		@idClasificacion,
		ltrim(rtrim(@Nombre)),
		ltrim(rtrim(@Asunto)),
		@NumeroDeFojas,
		@FechaApertura,
		@FechaCierre,
		@FechaCierreChecked,
		@FechaDePaseABajaHistorico,
		@FechaDePaseABajaHistoricoChecked,
		@idUsuario_AutorizaBajaHistorico,
		ltrim(rtrim(@Caja)),
		ltrim(rtrim(@Pasillo)),
		ltrim(rtrim(@Anaquel)),
		ltrim(rtrim(@Entrepano)),
		ltrim(rtrim(@RelacionAnterior)),
		ltrim(rtrim(@CajaAnterior)),
		ltrim(rtrim(@ItemAnterior)),
		@FechaDeCreacion,
		@idUsuario_ElaboradoPor,
/*
		@idClasificacionStatus,
		@ClasificaSoloParte,
		ltrim(rtrim(@FojasParte)),
		@FechaClasificacion,
		@FechaClasificacionChecked,
		@FechaPropuestaDesclasificacion,
		@FechaPropuestaDesclasificacionChecked,
		@NuevaFechaDesclasificacion,
		@NuevaFechaDesclasificacionChecked,
		@NuevaClasificaSoloParte,
		ltrim(rtrim(@NuevaFojasParte)),
		@idUsuario_AutorizaAmpliacionClasificacion,
		@FechaDeDesclasificacion,
		@FechaDeDesclasificacionChecked,
		@idUsuario_AutorizaDesclasificacion,
		@idPlazoTramite,
		@idPlazoConcentracion,
		@idDestinoFinal,
*/
		@CampoAdicional1,
		@CampoAdicional2,
		@idUsuarioUltimaEdicion,
		@idUnidadAdministrativa,
		@idCalidadDocumental,
@CampoAdicional3
	)
	SET @err1 = @@error 
	IF (@err1 <> 0) GOTO HUBO_ERRORES
	--Busco el id del record recién insertado
	SET @id_record_procesadoOK = (SELECT MAX(idExpediente) FROM Expedientes)
	--Hago que el @LastIDExpediente apunte por la derecha al nuevo record
	--UPDATE Expedientes SET NextRight = @id_record_procesadoOK WHERE idExpediente = @LastIDExpediente
	SET @err1 = @@error 
	IF (@err1 <> 0) GOTO HUBO_ERRORES
HUBO_ERRORES:
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			SELECT @id_record_procesadoOK = 0
		END



GO
/****** Object:  StoredProcedure [dbo].[Expedientes_SELECT_ONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[Expedientes_SELECT_ONE]
@idExpediente	INTEGER,
@idUsuarioReal	INTEGER WITH ENCRYPTION
AS
IF (@idExpediente = -1)
	BEGIN
		SELECT TOP 1 
			e.*, 
			Codigo = dbo.fnNombreDeJerarquia(e.idClasificacion),
			EstatusExpediente = s.DescripcionEstatus,
			TipoEstatus = s.TipoEstatus	
		FROM 
			Expedientes e
			JOIN UnidadesAdministrativas ua
			ON e.idUnidadAdministrativa = ua.idUnidadAdministrativa
			JOIN UsuariosRealesUnidadesAdministrativasRelaciones uruar
			ON ua.idUnidadAdministrativa = uruar.idUnidadAdministrativa
			JOIN UsuariosReales ur
			ON uruar.idUsuarioReal = ur.idUsuarioReal
			JOIN EstatusExpediente s 
			ON e.idEstatusExpediente = s.idEstatusExpediente
		WHERE
			ur.idUsuarioReal = @idUsuarioReal
	END
ELSE
	BEGIN
		SELECT 
			e2.*,
			Codigo = dbo.fnNombreDeJerarquia(e2.idClasificacion),
			EstatusExpediente = s.DescripcionEstatus,
			TipoEstatus = s.TipoEstatus
		FROM Expedientes e2
			JOIN EstatusExpediente s ON e2.idEstatusExpediente = s.idEstatusExpediente
		WHERE
			e2.idExpediente = @idExpediente
	END



GO
/****** Object:  StoredProcedure [dbo].[Expedientes_SELECT_ONE_2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





ALTER PROCEDURE [dbo].[Expedientes_SELECT_ONE_2]

@idExpediente	integer,
@idUsuarioReal	integer WITH ENCRYPTION

AS

		SELECT e2.*, dbo.fnNombreDeJerarquia(e2.idClasificacion) as Codigo,
		CONVERT(varchar(10), e2.FechaApertura, 103) as FechaAperturaDMA,
		CONVERT(varchar(10), e2.FechaCierre, 103) as FechaCierreDMA,
		CONVERT(varchar(10), e2.FechaDePaseABajaHistorico, 103) as FechaDePaseABajaHistoricoDMA,
		CONVERT(varchar(10), e2.FechaDeCreacion, 103) as FechaDeCreacionDMA,
		CONVERT(varchar(10), e2.FechaClasificacion, 103) as FechaClasificacionDMA,
		CONVERT(varchar(10), e2.FechaPropuestaDesclasificacion, 103) as FechaPropuestaDesclasificacionDMA,
		CONVERT(varchar(10), e2.NuevaFechaDesclasificacion, 103) as NuevaFechaDesclasificacionDMA,
		CONVERT(varchar(10), e2.FechaDeDesclasificacion, 103) as FechaDeDesclasificacionDMA
		FROM Expedientes e2 WHERE idExpediente = @idExpediente

/*
IF (@idExpediente = -1)
	BEGIN
		SELECT TOP 1 e.*, dbo.fnNombreDeJerarquia(e.idClasificacion) as Codigo,
		CONVERT(varchar(10), e.FechaApertura, 103) as FechaAperturaDMA,
		CONVERT(varchar(10), e.FechaCierre, 103) as FechaCierreDMA,
		CONVERT(varchar(10), e.FechaDePaseABajaHistorico, 103) as FechaDePaseABajaHistoricoDMA,
		CONVERT(varchar(10), e.FechaDeCreacion, 103) as FechaDeCreacionDMA,
		CONVERT(varchar(10), e.FechaClasificacion, 103) as FechaClasificacionDMA,
		CONVERT(varchar(10), e.FechaPropuestaDesclasificacion, 103) as FechaPropuestaDesclasificacionDMA,
		CONVERT(varchar(10), e.NuevaFechaDesclasificacion, 103) as NuevaFechaDesclasificacionDMA,
		CONVERT(varchar(10), e.FechaDeDesclasificacion, 103) as FechaDeDesclasificacionDMA
		FROM 
			Expedientes e
			JOIN UnidadesAdministrativas ua
			ON e.idUnidadAdministrativa = ua.idUnidadAdministrativa
			JOIN UsuariosRealesUnidadesAdministrativasRelaciones uruar
			ON ua.idUnidadAdministrativa = uruar.idUnidadAdministrativa
			JOIN UsuariosReales ur
			ON uruar.idUsuarioReal = ur.idUsuarioReal
		WHERE
			ur.idUsuarioReal = @idUsuarioReal
	END
ELSE
	BEGIN
		SELECT e2.*, dbo.fnNombreDeJerarquia(e2.idClasificacion) as Codigo,
		CONVERT(varchar(10), e2.FechaApertura, 103) as FechaAperturaDMA,
		CONVERT(varchar(10), e2.FechaCierre, 103) as FechaCierreDMA,
		CONVERT(varchar(10), e2.FechaDePaseABajaHistorico, 103) as FechaDePaseABajaHistoricoDMA,
		CONVERT(varchar(10), e2.FechaDeCreacion, 103) as FechaDeCreacionDMA,
		CONVERT(varchar(10), e2.FechaClasificacion, 103) as FechaClasificacionDMA,
		CONVERT(varchar(10), e2.FechaPropuestaDesclasificacion, 103) as FechaPropuestaDesclasificacionDMA,
		CONVERT(varchar(10), e2.NuevaFechaDesclasificacion, 103) as NuevaFechaDesclasificacionDMA,
		CONVERT(varchar(10), e2.FechaDeDesclasificacion, 103) as FechaDeDesclasificacionDMA
		FROM Expedientes e2 WHERE idExpediente = @idExpediente
	END
*/

/*
IF (@idExpediente = -1)
	BEGIN
		SELECT TOP 1 e.*, dbo.fnNombreDeJerarquia(e.idClasificacion) as Codigo FROM Expedientes e
	END
ELSE
	BEGIN
		SELECT e2.*, dbo.fnNombreDeJerarquia(e2.idClasificacion) as Codigo FROM Expedientes e2 WHERE idExpediente = @idExpediente
	END

*/






GO
/****** Object:  StoredProcedure [dbo].[Expedientes_TransferenciaWS]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC Expedientes_TransferenciaWS 10, 0
--DROP PROCEDURE Expedientes_TransferenciaWS
ALTER PROCEDURE [dbo].[Expedientes_TransferenciaWS]
(
	@MaximoRegistros INT = 1000,
	@ActualizaMarcaTransferencia BIT = 0
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Query AS NVARCHAR(MAX);

	CREATE TABLE #Expedientes
	(
		Id INT NOT NULL,
		CodigoClasificacion NVARCHAR(50) NOT NULL,
		NumeroExpediente NVARCHAR(50) NOT NULL,
		UnidadAdministrativa NVARCHAR(20) NOT NULL,
		IdExterno INT NOT NULL,
		NumeroCaja NVARCHAR(20) NOT NULL,
		Titulo NVARCHAR(MAX) NOT NULL,
		Asunto NVARCHAR(MAX) NOT NULL,
		Apertura DATETIME NOT NULL,
		Cierre DATETIME NOT NULL,
		NumeroHojas INT NOT NULL
	);

	SET @Query =
		' SELECT TOP ' + CONVERT(NVARCHAR(6), @MaximoRegistros) + ' e.idExpediente AS Id,
			dbo.fnNombreDeJerarquia(e.idClasificacion) AS CodigoClasificacion,
			e.Nombre AS NumeroExpediente,
			u.Codigo AS UnidadAdministrativa,
			u.idExternoAPI AS IdExterno,
			e.Caja AS NumeroCaja,
			e.CampoAdicional1 AS Titulo,
			e.Asunto AS Asunto,
			e.FechaApertura AS Apertura,
			e.FechaCierre AS Cierre,
			e.NumeroDeFojas AS NumeroHojas
		FROM Expedientes e
			INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa = u.idUnidadAdministrativa
		WHERE e.TransferidoWS = 0
			AND NOT EXISTS (SELECT NULL FROM Expedientes_PDF_Relaciones WHERE idExpediente = e.idExpediente AND Verificado = 0);';

	INSERT INTO #Expedientes
	EXEC (@Query);

	SELECT * FROM #Expedientes ORDER BY Id;

	SELECT r.idExpedientePDFRelaciones AS Id,
		r.Descripcion AS NombreArchivo,
		r.idExpediente AS IdExpediente,
		r.Verificado
	FROM Expedientes_PDF_Relaciones r
	WHERE r.idExpediente IN (SELECT Id FROM #Expedientes)
	ORDER BY IdExpediente, Id;

	IF @ActualizaMarcaTransferencia = 1
	BEGIN
		UPDATE Expedientes SET
			TransferidoWS = 1,
			TransFeridoWSFecha = GETDATE()
		WHERE idExpediente IN (SELECT Id FROM #Expedientes);		
	END

	DROP TABLE #Expedientes;
END
GO
/****** Object:  StoredProcedure [dbo].[Expedientes_UPDATE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Expedientes_UPDATE]
@idExpediente					integer,
@idClasificacion				integer,
@Nombre						varchar(50),
@Asunto						varchar(250),
@NumeroDeFojas					integer,
@FechaApertura					datetime,
@FechaCierre					datetime,
@FechaCierreChecked				bit,
@FechaDePaseABajaHistorico			datetime,
@FechaDePaseABajaHistoricoChecked		bit,
@idUsuario_AutorizaBajaHistorico		integer,
@Caja						varchar(25),
@Pasillo					varchar(25),
@Anaquel					varchar(25),
@Entrepano					varchar(25),
@RelacionAnterior				varchar(25),
@CajaAnterior					varchar(25),
@ItemAnterior					varchar(25),
@FechaDeCreacion				datetime,
/*
@idUsuario_ElaboradoPor				integer,
@idClasificacionStatus				integer,
@ClasificaSoloParte				bit,
@FojasParte					varchar(25),
@FechaClasificacion				datetime,
@FechaClasificacionChecked			bit,
@FechaPropuestaDesclasificacion			datetime,
@FechaPropuestaDesclasificacionChecked		bit,
@NuevaFechaDesclasificacion			datetime,
@NuevaFechaDesclasificacionChecked		bit,
@NuevaClasificaSoloParte			bit,
@NuevaFojasParte				varchar(25),
@idUsuario_AutorizaAmpliacionClasificacion	integer,
@FechaDeDesclasificacion			datetime,
@FechaDeDesclasificacionChecked			bit,
@idUsuario_AutorizaDesclasificacion		integer,
@idPlazoTramite					integer,
@idPlazoConcentracion				integer,
@idDestinoFinal					integer,
*/
@CampoAdicional1				varchar(50),
@CampoAdicional2				varchar(50),
@idUsuarioUltimaEdicion				integer,
@idUnidadAdministrativa				integer,
@idCalidadDocumental				integer,
@CampoAdicional3				varchar(50),
@id_record_procesadoOK				integer = 0	output WITH ENCRYPTION
AS
	DECLARE @err1			int
	SET @err1 = 0
	BEGIN TRAN
	UPDATE Expedientes
	SET
		idClasificacion = @idClasificacion,
		Nombre = ltrim(rtrim(@Nombre)),
		Asunto = ltrim(rtrim(@Asunto)),
		NumeroDeFojas = ltrim(rtrim(@NumeroDeFojas)),
		FechaApertura = @FechaApertura,
		FechaCierre = @FechaCierre,
		FechaCierreChecked = @FechaCierreChecked,
		FechaDePaseABajaHistorico = @FechaDePaseABajaHistorico,
		FechaDePaseABajaHistoricoChecked = @FechaDePaseABajaHistoricoChecked,
		idUsuario_AutorizaBajaHistorico = @idUsuario_AutorizaBajaHistorico,
		Caja = ltrim(rtrim(@Caja)),
		Pasillo = ltrim(rtrim(@Pasillo)),
		Anaquel = ltrim(rtrim(@Anaquel)),
		Entrepano = ltrim(rtrim(@Entrepano)),
		RelacionAnterior = ltrim(rtrim(@RelacionAnterior)),
		CajaAnterior = ltrim(rtrim(@CajaAnterior)),
		ItemAnterior = ltrim(rtrim(@ItemAnterior)),
		FechaDeCreacion = @FechaDeCreacion,
/*
		idUsuario_ElaboradoPor = @idUsuario_ElaboradoPor,
		idClasificacionStatus = @idClasificacionStatus,
		ClasificaSoloParte = @ClasificaSoloParte,
		FojasParte = ltrim(rtrim(@FojasParte)),
		FechaClasificacion = @FechaClasificacion,
		FechaClasificacionChecked = @FechaClasificacionChecked,
		FechaPropuestaDesclasificacion = @FechaPropuestaDesclasificacion,
		FechaPropuestaDesclasificacionChecked = @FechaPropuestaDesclasificacionChecked,
		NuevaFechaDesclasificacion = @NuevaFechaDesclasificacion,
		NuevaFechaDesclasificacionChecked = @NuevaFechaDesclasificacionChecked,
		NuevaClasificaSoloParte = @NuevaClasificaSoloParte,
		NuevaFojasParte = ltrim(rtrim(@NuevaFojasParte)),
		idUsuario_AutorizaAmpliacionClasificacion = @idUsuario_AutorizaAmpliacionClasificacion,
		FechaDeDesclasificacion = @FechaDeDesclasificacion,
		FechaDeDesclasificacionChecked = @FechaDeDesclasificacionChecked,
		idUsuario_AutorizaDesclasificacion = @idUsuario_AutorizaDesclasificacion,
		idPlazoTramite = @idPlazoTramite,
		idPlazoConcentracion = @idPlazoConcentracion,
		idDestinoFinal = @idDestinoFinal
*/
		CampoAdicional1 = @CampoAdicional1,
		CampoAdicional2 = @CampoAdicional2,
		idUsuarioUltimaEdicion = @idUsuarioUltimaEdicion,
		idUnidadAdministrativa = @idUnidadAdministrativa,
		idCalidadDocumental = @idCalidadDocumental,
		CampoAdicional3 = @CampoAdicional3
	FROM
		Expedientes
	WHERE
		idExpediente = @idExpediente
	SET @err1 = @@error 
	IF (@err1 <> 0) GOTO HUBO_ERRORES
HUBO_ERRORES:
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			SELECT @id_record_procesadoOK = 0
		END



GO
/****** Object:  StoredProcedure [dbo].[Expedientes_UPDATE_2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Expedientes_UPDATE_2]

@idExpediente					integer,

/*
@idClasificacion				integer,
@Nombre						varchar(50),
@Asunto						varchar(250),
@NumeroDeFojas					integer,
@FechaApertura					datetime,
@FechaCierre					datetime,
@FechaCierreChecked				bit,
@FechaDePaseABajaHistorico			datetime,
@FechaDePaseABajaHistoricoChecked		bit,
@idUsuario_AutorizaBajaHistorico		integer,
@Caja						varchar(25),
@Pasillo					varchar(25),
@Anaquel					varchar(25),
@Entrepano					varchar(25),
@RelacionAnterior				varchar(25),
@CajaAnterior					varchar(25),
@ItemAnterior					varchar(25),
@FechaDeCreacion				datetime,
@idUsuario_ElaboradoPor				integer,
*/


@idClasificacionStatus				integer,
@ClasificaSoloParte				bit,
@FojasParte					varchar(25),
@FechaClasificacion				datetime,
@FechaClasificacionChecked			bit,
@FechaPropuestaDesclasificacion			datetime,
@FechaPropuestaDesclasificacionChecked		bit,
@NuevaFechaDesclasificacion			datetime,
@NuevaFechaDesclasificacionChecked		bit,
@NuevaClasificaSoloParte			bit,
@NuevaFojasParte				varchar(25),
@idUsuario_AutorizaAmpliacionClasificacion	integer,
@FechaDeDesclasificacion			datetime,
@FechaDeDesclasificacionChecked			bit,
@idUsuario_AutorizaDesclasificacion		integer,
@idPlazoTramite					integer,
@idPlazoConcentracion				integer,
@idDestinoFinal					integer,

/*
@CampoAdicional1				varchar(50),
@CampoAdicional2				varchar(50),
@idUsuarioUltimaEdicion				integer,
*/

@id_record_procesadoOK				integer = 0	output WITH ENCRYPTION

AS

	DECLARE @err1			int

	SET @err1 = 0

	BEGIN TRAN

	UPDATE Expedientes
	SET
/*
		idClasificacion = @idClasificacion,
		Nombre = ltrim(rtrim(@Nombre)),
		Asunto = ltrim(rtrim(@Asunto)),
		NumeroDeFojas = ltrim(rtrim(@NumeroDeFojas)),
		FechaApertura = @FechaApertura,
		FechaCierre = @FechaCierre,
		FechaCierreChecked = @FechaCierreChecked,
		FechaDePaseABajaHistorico = @FechaDePaseABajaHistorico,
		FechaDePaseABajaHistoricoChecked = @FechaDePaseABajaHistoricoChecked,
		idUsuario_AutorizaBajaHistorico = @idUsuario_AutorizaBajaHistorico,
		Caja = ltrim(rtrim(@Caja)),
		Pasillo = ltrim(rtrim(@Pasillo)),
		Anaquel = ltrim(rtrim(@Anaquel)),
		Entrepano = ltrim(rtrim(@Entrepano)),
		RelacionAnterior = ltrim(rtrim(@RelacionAnterior)),
		CajaAnterior = ltrim(rtrim(@CajaAnterior)),
		ItemAnterior = ltrim(rtrim(@ItemAnterior)),
		FechaDeCreacion = @FechaDeCreacion,
		idUsuario_ElaboradoPor = @idUsuario_ElaboradoPor,
*/


		idClasificacionStatus = @idClasificacionStatus,
		ClasificaSoloParte = @ClasificaSoloParte,
		FojasParte = ltrim(rtrim(@FojasParte)),
		FechaClasificacion = @FechaClasificacion,
		FechaClasificacionChecked = @FechaClasificacionChecked,
		FechaPropuestaDesclasificacion = @FechaPropuestaDesclasificacion,
		FechaPropuestaDesclasificacionChecked = @FechaPropuestaDesclasificacionChecked,
		NuevaFechaDesclasificacion = @NuevaFechaDesclasificacion,
		NuevaFechaDesclasificacionChecked = @NuevaFechaDesclasificacionChecked,
		NuevaClasificaSoloParte = @NuevaClasificaSoloParte,
		NuevaFojasParte = ltrim(rtrim(@NuevaFojasParte)),
		idUsuario_AutorizaAmpliacionClasificacion = @idUsuario_AutorizaAmpliacionClasificacion,
		FechaDeDesclasificacion = @FechaDeDesclasificacion,
		FechaDeDesclasificacionChecked = @FechaDeDesclasificacionChecked,
		idUsuario_AutorizaDesclasificacion = @idUsuario_AutorizaDesclasificacion,
		idPlazoTramite = @idPlazoTramite,
		idPlazoConcentracion = @idPlazoConcentracion,
		idDestinoFinal = @idDestinoFinal

/*
		CampoAdicional1 = @CampoAdicional1,
		CampoAdicional2 = @CampoAdicional2,
		idUsuarioUltimaEdicion = @idUsuarioUltimaEdicion
*/
	FROM
		Expedientes
	WHERE
		idExpediente = @idExpediente

	SET @err1 = @@error 
	IF (@err1 <> 0) GOTO HUBO_ERRORES

HUBO_ERRORES:

	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			SELECT @id_record_procesadoOK = 0
		END


GO
/****** Object:  StoredProcedure [dbo].[Expedientes_Update_Status]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Expedientes_Update_Status
ALTER PROCEDURE [dbo].[Expedientes_Update_Status]
(
	@IdBatch INT,
	@Status INT,
	@IdRecordProcesadoOK INT = 0 OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	UPDATE e
		SET idEstatusExpediente = @Status,
		Caja = 
			(
				SELECT br2.CajaProv2 
				FROM Batches_Relaciones br2 
					INNER JOIN Batches b2 ON br2.idBatch = b2.idBatch
					INNER JOIN Expedientes e2 ON br2.idExpediente = e2.idExpediente
				WHERE e2.idExpediente = e.idExpediente 
				AND b2.idBatch = @idBatch
			)
	FROM Expedientes e
		INNER JOIN Batches_Relaciones br ON e.idExpediente = br.idExpediente
		INNER JOIN Batches b ON br.idBatch = b.idBatch
	WHERE b.idBatch = @idBatch;

	SET @IdRecordProcesadoOK = @@ERROR;
END



GO
/****** Object:  StoredProcedure [dbo].[ExpedientesPDF_Archivos_SELECT_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================================================
--Selecciona todos los documentos vinculados a expedientes.
--
--============================================================================
--EXEC ExpedientesPDF_Archivos_SELECT_ALL
--DROP PROCEDURE ExpedientesPDF_Archivos_SELECT_ALL
ALTER PROCEDURE [dbo].[ExpedientesPDF_Archivos_SELECT_ALL] WITH ENCRYPTION
AS
BEGIN
	SELECT idExpedientePDFRelaciones,
		NombrePDF,
		Verificado
	FROM Expedientes_PDF_Relaciones
	ORDER BY NombrePDF;
END

GO
/****** Object:  StoredProcedure [dbo].[ExpedientesPDF_Archivos_Verifica]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--============================================================================
--Actualiza registros de archivos como localizados o no localizados.
--
--============================================================================
--EXEC ExpedientesPDF_Archivos_Verifica
--DROP PROCEDURE ExpedientesPDF_Archivos_Verifica
ALTER PROCEDURE [dbo].[ExpedientesPDF_Archivos_Verifica]
(
	@IdList TEXT,
	@Verificado BIT = 0
) WITH ENCRYPTION
AS
BEGIN
	UPDATE r
		SET Verificado = @Verificado,
		FechaVerificacion = GETDATE()
	FROM Expedientes_PDF_Relaciones r
		INNER JOIN dbo.fnSplitTextIDS(@IdList, ',') l on r.idExpedientePDFRelaciones = l.IdListed;

END
GO
/****** Object:  StoredProcedure [dbo].[ExpedientesPDF_ReiniciaBanderaVerificacion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==================================================================================
-- Elimina banderas de verificación en listado de archivos vinculados a expedientes
-- ==================================================================================
ALTER PROCEDURE [dbo].[ExpedientesPDF_ReiniciaBanderaVerificacion] WITH ENCRYPTION
AS
BEGIN
	UPDATE Expedientes_PDF_Relaciones 
	SET Verificado = 0;
END
GO
/****** Object:  StoredProcedure [dbo].[ExpedientesPDF_SELECT_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC ExpedientesPDF_SELECT_ALL
--DROP PROCEDURE ExpedientesPDF_SELECT_ALL
ALTER PROCEDURE [dbo].[ExpedientesPDF_SELECT_ALL]
(
	@IdExpediente INTEGER
) WITH ENCRYPTION
AS
BEGIN
	SELECT idExpedientePDFRelaciones,
		idExpediente,	
		NombrePDF,
		Descripcion,	
		Verificado,
		FechaVerificacion
	FROM Expedientes_PDF_Relaciones epdfr
	WHERE epdfr.idExpediente = @idExpediente
		AND epdfr.Verificado = 1

END
GO
/****** Object:  StoredProcedure [dbo].[ExpedientesPorUnidadAdministrativa]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================================================
-- David R. Ahuja 
-- 2022-02-21. Calcula expedientes creados/modificados por cada unidad administrativa.
-- ===================================================================================
-- EXEC ExpedientesPorUnidadAdministrativa '2000/01/01', '2022/12/31'
ALTER PROCEDURE [dbo].[ExpedientesPorUnidadAdministrativa]
(
	@FechaInicial DATE,
	@FechaFinal DATE
) WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		ua.idUnidadAdministrativa,
		ua.Descripcion AS Nombre,
		COALESCE(ut.totPorUA, 0) as totPorUA,
		COALESCE(uf.entreFechas, 0) as entreFechas
		FROM UnidadesAdministrativas ua
			LEFT JOIN 
			(
				SELECT COUNT(u.idUnidadAdministrativa) as totPorUA, u.idUnidadAdministrativa 
				FROM Expedientes e 
					INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa  = u.idUnidadAdministrativa
				GROUP BY u.idUnidadAdministrativa 
			) AS ut ON ua.idUnidadAdministrativa = ut.idUnidadAdministrativa
			LEFT JOIN
			(
				SELECT COUNT(u.idUnidadAdministrativa) as entreFechas, u.idUnidadAdministrativa
				FROM Expedientes e 
					INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa  = u.idUnidadAdministrativa
				WHERE e.FechaDeCreacion  >= @FechaInicial AND e.FechaDeCreacion <= @FechaFinal
				GROUP BY u.idUnidadAdministrativa
			) AS uf ON ua.idUnidadAdministrativa = uf.idUnidadAdministrativa 
		WHERE 
			COALESCE(ut.totPorUA, 0) > 0 OR COALESCE(uf.entreFechas, 0) > 0
END
GO
/****** Object:  StoredProcedure [dbo].[ExpedientesPorUsuario]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =====================================================================
-- David R. Ahuja 
-- 2022-02-21. Calcula expedientes creados/modificados por cada usuario.
-- =====================================================================
ALTER PROCEDURE [dbo].[ExpedientesPorUsuario]
(
	@FechaInicial DATE,
	@FechaFinal DATE
) WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		ur.idUsuarioReal,
		ur.Nombre,
		COALESCE(ed.expEditados, 0) as expEditados,
		COALESCE(ec.expCreados, 0) as expCreados
		FROM UsuariosReales ur
			LEFT JOIN 
			(
				SELECT COUNT(us.idUsuarioReal) as expEditados, us.idUsuarioReal
				FROM Expedientes e 
					INNER JOIN UsuariosReales us ON e.idUsuario_ElaboradoPor = us.idUsuarioReal
				WHERE e.FechaDeCreacion >= @FechaInicial AND e.FechaDeCreacion <= @FechaFinal
				GROUP BY us.idUsuarioReal
			) AS ed ON ur.idUsuarioReal = ed.idUsuarioReal
			LEFT JOIN
			(
				SELECT COUNT(us.idUsuarioReal) AS expCreados, us.idUsuarioReal 
				FROM Expedientes e 
					INNER JOIN UsuariosReales us ON e.idUsuarioUltimaEdicion = us.idUsuarioReal
				WHERE e.FechaDeCreacion  >= @FechaInicial AND e.FechaDeCreacion <= @FechaFinal
				GROUP BY us.idUsuarioReal
			) AS ec ON ur.idUsuarioReal = ec.idUsuarioReal 
		WHERE 
			COALESCE(ed.expEditados, 0) > 0 OR COALESCE(ec.expCreados, 0) > 0
END
GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ALL]

@idExpediente				integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE FundamentosLegalesDeClasificacion_Expedientes_Relaciones
	WHERE idExpediente = @idExpediente

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END


GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ONE]

@idFundamentosLegalesDeClasificacion	integer,
@idExpediente				integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE FundamentosLegalesDeClasificacion_Expedientes_Relaciones
	WHERE idExpediente = @idExpediente AND idFundamentosLegalesDeClasificacion = @idFundamentosLegalesDeClasificacion

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END



GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeClasificacion_Expedientes_Relaciones_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeClasificacion_Expedientes_Relaciones_INSERT]

@idExpediente				integer,
@idFundamentosLegalesDeClasificacion	integer,

@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	INSERT FundamentosLegalesDeClasificacion_Expedientes_Relaciones
	(
		idExpediente,
		idFundamentosLegalesDeClasificacion
	)
	VALUES
	(
		@idExpediente,
		@idFundamentosLegalesDeClasificacion
	)

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END


GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeClasificacionRelaciones_DELETE_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeClasificacionRelaciones_DELETE_ALL]

@idClasificacion			integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE FundamentosLegalesDeClasificacionRelaciones
	WHERE idClasificacion = @idClasificacion

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeClasificacionRelaciones_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeClasificacionRelaciones_INSERT]

@idClasificacion			integer,
@idFundamentosLegalesDeClasificacion	integer,

@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	INSERT FundamentosLegalesDeClasificacionRelaciones
	(
		idClasificacion,
		idFundamentosLegalesDeClasificacion
	)
	VALUES
	(
		@idClasificacion,
		@idFundamentosLegalesDeClasificacion
	)

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ALL]

@idExpediente				integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones
	WHERE idExpediente = @idExpediente

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END


GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ONE]

@idFundamentoLegalDeDestinoFinal	integer,
@idExpediente				integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones
	WHERE idExpediente = @idExpediente AND idFundamentoLegalDeDestinoFinal = @idFundamentoLegalDeDestinoFinal

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END



GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_INSERT]

@idExpediente				integer,
@idFundamentoLegalDeDestinoFinal	integer,

@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	INSERT FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones
	(
		idExpediente,
		idFundamentoLegalDeDestinoFinal
	)
	VALUES
	(
		@idExpediente,
		@idFundamentoLegalDeDestinoFinal
	)

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END


GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeDestinoFinalRelaciones_DELETE_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeDestinoFinalRelaciones_DELETE_ALL]

@idClasificacion			integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE FundamentosLegalesDeDestinoFinalRelaciones
	WHERE idClasificacion = @idClasificacion

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[FundamentosLegalesDeDestinoFinalRelaciones_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FundamentosLegalesDeDestinoFinalRelaciones_INSERT]

@idClasificacion			integer,
@idFundamentoLegalDeDestinoFinal	integer,

@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	INSERT FundamentosLegalesDeDestinoFinalRelaciones
	(
		idClasificacion,
		idFundamentoLegalDeDestinoFinal
	)
	VALUES
	(
		@idClasificacion,
		@idFundamentoLegalDeDestinoFinal
	)

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[Gestion_AsignaDocumento]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Gestion_AsignaDocumento
ALTER PROCEDURE [dbo].[Gestion_AsignaDocumento]
(
	@IdGestionDocumentosInstancia INT,
	@IdExpedientePDFRelaciones INT
) WITH ENCRYPTION
AS
BEGIN
	IF NOT EXISTS (SELECT NULL FROM GestionDocumentosInstancia_ExpedientesPdf_Relaciones WHERE IdExpedientePDFRelaciones = @IdExpedientePDFRelaciones)
	BEGIN
		INSERT INTO GestionDocumentosInstancia_ExpedientesPdf_Relaciones (IdGestionDocumentosInstancia, IdExpedientePDFRelaciones)
		VALUES (@IdGestionDocumentosInstancia, @IdExpedientePDFRelaciones);
	END
	ELSE
	BEGIN
		DELETE GestionDocumentosInstancia_ExpedientesPdf_Relaciones
		WHERE IdExpedientePDFRelaciones = @IdExpedientePDFRelaciones;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Gestion_CargaSecciones]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC Gestion_CargaSecciones 2
--DROP PROCEDURE Gestion_CargaSecciones
ALTER PROCEDURE [dbo].[Gestion_CargaSecciones]
(
	@IdGestion INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT 0 AS Id, '0. Todas' As Seccion, 'Todas las secciones' As Descripcion

	UNION 

	SELECT IdGestionSeccionDocumental AS Id, Codigo AS Seccion, 
		Descripcion 
	FROM GestionSeccionesDocumentales gs
	WHERE gs.IdGestion = @IdGestion;
END

select * from GestionSeccionesDocumentales
GO
/****** Object:  StoredProcedure [dbo].[Gestion_DocumentosDisponiblesAsignados]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC Gestion_DocumentosDisponiblesAsignados 63763, 2, 0
--DROP PROCEDURE Gestion_DocumentosDisponiblesAsignados
ALTER PROCEDURE [dbo].[Gestion_DocumentosDisponiblesAsignados]
(
	@IdExpediente INT,
	@IdGestion INT = 2,		--Gestión 2 corresponde a expedientes de RRHH
	@IdSeccion INT = 0,		--Todas las secciones
	@SoloConImagen INT = 0	--Muestra solamente líneas con imagen vinculada
) WITH ENCRYPTION
AS
BEGIN
	--Si no existe gestión, creo los registros.
	IF NOT EXISTS (SELECT NULL FROM GestionDocumentosInstancia WHERE idExpediente = @IdExpediente)
	BEGIN
		INSERT INTO GestionDocumentosInstancia (IdExpediente, IdGestionDocumentos)
		SELECT @IdExpediente, gd.IdGestionDocumentos
		FROM GestionDocumentos gd
			INNER JOIN GestionSeccionesDocumentales gs ON gd.IdGestionSeccionDocumental = gs.IdGestionSeccionDocumental
			INNER JOIN Gestiones g ON gs.IdGestion = g.IdGestion
		WHERE g.IdGestion = @IdGestion
	END

	--Documentos disponibles.
	SELECT IdExpedientePDFRelaciones, 
		Descripcion,
		NombrePDF AS NombreArchivo
	FROM Expedientes_PDF_Relaciones r
	WHERE r.idExpedientePDFRelaciones NOT IN (SELECT COALESCE(IdExpedientePdfRelaciones, -1) FROM GestionDocumentosInstancia_ExpedientesPdf_Relaciones)
		AND r.idExpediente = @IdExpediente;

	--Documentos asignados
	SELECT gdi.IdGestionDocumentosInstancia,
		gd.IdGestionDocumentos,
		g.Descripcion AS Gestion,
		gs.Codigo AS Seccion,
		gd.CodigoTipoDocumento AS CodigoDocumento,
		gd.Descripcion,
		gd.Obligatorio,		
		gdi.FechaDocumento, 
		gdi.CampoAdicional1, 
		gdi.CampoAdicional2,
		gdi.CampoAdicional3,
		gdi.Observaciones AS Observaciones,
		COALESCE(r.IdExpedientePDFRelaciones, -1) AS IdExpedientePdfRelaciones,
		COALESCE(r.Descripcion, '') AS DescripcionArchivo,
		COALESCE(r.NombrePDF, '') AS NombreArchivo,
		gr.Id,
		ArchivoAsignado = 
			CASE WHEN COALESCE(r.NombrePDF, '') = '' THEN 0
				ELSE 1
			END,
		gs.IdGestionSeccionDocumental AS IdSeccion
	FROM GestionDocumentosInstancia gdi
		INNER JOIN GestionDocumentos gd ON gdi.IdGestionDocumentos = gd.IdGestionDocumentos
			INNER JOIN GestionSeccionesDocumentales gs ON gd.IdGestionSeccionDocumental = gs.IdGestionSeccionDocumental
				INNER JOIN Gestiones g ON gs.IdGestion = g.IdGestion
		LEFT OUTER JOIN GestionDocumentosInstancia_ExpedientesPdf_Relaciones gr ON gdi.IdGestionDocumentosInstancia = gr.IdGestionDocumentosInstancia
		LEFT OUTER JOIN Expedientes_PDF_Relaciones r ON r.idExpedientePDFRelaciones = gr.IdExpedientePDFRelaciones
	WHERE gdi.idExpediente = @IdExpediente
		AND gs.IdGestionSeccionDocumental = 
			CASE @IdSeccion
				WHEN 0 THEN gs.IdGestionSeccionDocumental
				ELSE @IdSeccion
			END
		AND COALESCE(r.idExpedientePDFRelaciones, -1) >= 
			CASE @SoloConImagen
				WHEN 0 THEN COALESCE(r.idExpedientePDFRelaciones, -1)
				ELSE 1
			END
	ORDER BY Seccion, CodigoDocumento;

END

GO
/****** Object:  StoredProcedure [dbo].[Gestion_ObtieneGestionExpediente]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE Gestion_ObtieneGestionExpediente
ALTER PROCEDURE [dbo].[Gestion_ObtieneGestionExpediente]
(
	@IdExpediente INT,
	@Gestion NVARCHAR(100) OUTPUT,
	@Asunto NVARCHAR(MAX) OUTPUT,
	@Titulo NVARCHAR(MAX) OUTPUT,
	@Observaciones NVARCHAR(MAX) OUTPUT,
	@CampoAdicional2 NVARCHAR(MAX) OUTPUT,
	@IdGestion INT OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	SELECT @Gestion = g.Descripcion,
		@Asunto = e.Asunto,
		@Titulo = e.CampoAdicional1,
		@IdGestion = e.idGestion,
		@Observaciones = e.Observaciones,
		@CampoAdicional2 = e.CampoAdicional2
	FROM Expedientes e
		INNER JOIN Gestiones g ON e.idGestion = g.IdGestion
	WHERE idExpediente = @IdExpediente;
END
GO
/****** Object:  StoredProcedure [dbo].[Get_First_Expediente]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Get_First_Expediente]

@idFirstExpediente	integer		output

AS

--SET @idFirstExpediente = ISNULL((SELECT e.idExpediente FROM Expedientes e WHERE e.NextLeft = 0),-1)

GO
/****** Object:  StoredProcedure [dbo].[Get_ID_From_Nombre_and_idPadre]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Get_ID_From_Nombre_and_idPadre]

@Nombre			varchar(50),
@idPadre		integer,
@idClasificacion	integer		output,
@Descripcion		varchar(250)	output WITH ENCRYPTION

AS
IF (@idPadre=0)
	BEGIN
		SET @idClasificacion = ISNULL((
			SELECT 
				cc.idClasificacion
			FROM 
				CuadroClasificacion cc
			WHERE
				ISNULL(cc.idPadre, -1) = -1
				AND
				cc.Nombre = @Nombre
			),-1)

		SET @Descripcion = ISNULL((
			SELECT 
				cc.Descripcion
			FROM 
				CuadroClasificacion cc
			WHERE
				ISNULL(cc.idPadre, -1) = -1
				AND
				cc.Nombre = @Nombre
			),'?')

	END
ELSE
	BEGIN
		SET @idClasificacion = ISNULL((
			SELECT 
				cc.idClasificacion
			FROM 
				CuadroClasificacion cc
			WHERE
				cc.idPadre = @idPadre
				AND
				cc.Nombre = @Nombre
			),-1)

		SET @Descripcion = ISNULL((
			SELECT 
				cc.Descripcion
			FROM 
				CuadroClasificacion cc
			WHERE
				cc.idPadre = @idPadre
				AND
				cc.Nombre = @Nombre
			),'?')

	END


GO
/****** Object:  StoredProcedure [dbo].[GET_IDUSUARIOREAL_FROM_LOGIN]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GET_IDUSUARIOREAL_FROM_LOGIN]

@Login			varchar(25),
@idUsuarioReal		integer	output,
@NombreUsuarioReal	varchar(50) output WITH ENCRYPTION

AS

SET @idUsuarioReal = ISNULL((SELECT idUsuarioReal FROM UsuariosReales ur WHERE ur.Login = @Login),-1)

SET @NombreUsuarioReal = ISNULL((SELECT nombre FROM UsuariosReales ur WHERE ur.Login = @Login),'?')

RETURN

GO
/****** Object:  StoredProcedure [dbo].[Get_Last_Expediente]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Get_Last_Expediente]

@idLastExpediente	integer		output WITH ENCRYPTION

AS

--SET @idLastExpediente = ISNULL((SELECT e.idExpediente FROM Expedientes e WHERE e.NextRight = 0),-1)

GO
/****** Object:  StoredProcedure [dbo].[Get_UsuarioReal_from_ID]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Get_UsuarioReal_from_ID]

@idUsuarioReal	integer,
@Nombre		varchar(50)	output WITH ENCRYPTION

AS

--SET @Nombre =ISNULL((SELECT ur.Nombre FROM UsuariosReales ur WHERE ur.idUsuarioReal = @idUsuarioReal),'')


SELECT @Nombre = ISNULL(ur.Nombre,'') FROM UsuariosReales ur WHERE ur.idUsuarioReal = @idUsuarioReal
GO
/****** Object:  StoredProcedure [dbo].[Get_UsuarioVirtual_From_UsuarioReal]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Get_UsuarioVirtual_From_UsuarioReal]
(
	@LoginUsuarioReal NVARCHAR(50),
	@PasswordUsuarioReal NVARCHAR(50),
	@LoginUsuarioVirtual NVARCHAR(50) OUTPUT,
	@PasswordUsuarioVirtual	NVARCHAR(50) OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	SET @LoginUsuarioVirtual = ISNULL(
					(SELECT uv.Login 
					FROM UsuariosVirtuales uv 
						INNER JOIN UsuariosReales ur ON uv.idUsuarioVirtual = ur.idUsuarioVirtual
					WHERE ur.Login = @LoginUsuarioReal AND ur.Clave = @PasswordUsuarioReal
					),'?')

	SET @PasswordUsuarioVirtual = ISNULL(
					(SELECT uv.Clave 
					FROM UsuariosVirtuales uv 
						INNER JOIN UsuariosReales ur ON uv.idUsuarioVirtual = ur.idUsuarioVirtual
					WHERE ur.Login = @LoginUsuarioReal AND ur.Clave = @PasswordUsuarioReal
					),'?')

END
GO
/****** Object:  StoredProcedure [dbo].[GetIDOrderNumber]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetIDOrderNumber]
	@Orden INT,
	@SelectSQLString VARCHAR(255),
	@IdOut INT OUTPUT WITH ENCRYPTION

AS

BEGIN
	SET NOCOUNT ON

	DECLARE @i INT

	CREATE TABLE #Tabla
		(IdTabla INT,
		Orden INT DEFAULT 0)

	SELECT @i = 0
	SELECT @IdOut = -1

	EXEC('INSERT #Tabla
		(idTabla) ' +
		@SelectSQLString)

	UPDATE #Tabla
		SET @i = Orden = @i + 1

	SELECT @IdOut = IdTabla
		FROM #Tabla
		WHERE Orden = @Orden

	DROP TABLE #Tabla

	SELECT @IdOut AS FoundId

END

GO
/****** Object:  StoredProcedure [dbo].[GetMaxOrderNumber]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetMaxOrderNumber]
	@SelectSQLString VARCHAR(255),
	@MaxOrder INT OUTPUT
	 WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON

	DECLARE @i INT

	CREATE TABLE #Tabla
		(IdTabla INT,
		Orden INT DEFAULT 0)

	SELECT @i = 0

	EXEC('INSERT #Tabla
		(idTabla) ' +
		@SelectSQLString)

	UPDATE #Tabla
		SET @i = Orden = @i + 1

	SELECT @MaxOrder = MAX(Orden)
		FROM #Tabla

	DROP TABLE #Tabla

	SELECT @MaxOrder AS TotalRecords

END

GO
/****** Object:  StoredProcedure [dbo].[GridVacio]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GridVacio]
 WITH ENCRYPTION
AS

SELECT 
	dbo.fnNombreDeJerarquia(e.idClasificacion) as Codigo, 
	e.idExpediente, 
	e.Nombre as Expediente, 
	e.CampoAdicional2  as Tipo, 
	e.CampoAdicional1  as RFC, 
	e.Asunto, e.Caja, 
	CONVERT(varchar(10),e.FechaApertura,103) as [F.Creacion] 
FROM 
	Expedientes e  
WHERE  idExpediente < -1000
GO
/****** Object:  StoredProcedure [dbo].[GuiaDeExpedientesExistentes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GuiaDeExpedientesExistentes]
(
	@IDList TEXT,
	@Orden NVARCHAR(100) = ' caja, numero'
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Query NVARCHAR(MAX);

	SELECT 
		Unidad = UPPER(u.Descripcion),
		Serie = dbo.fnNombreDeJerarquia(e.idClasificacion),
		Nombre = UPPER(e.Nombre),
		Apertura = CONVERT(CHAR(10), e.FechaApertura, 103),
		Asunto = RTRIM(LTRIM(UPPER(e.Asunto))),
		CampoAdicional1 = RTRIM(LTRIM(UPPER(e.CampoAdicional1))),
		CampoAdicional2 = RTRIM(LTRIM(UPPER(e.CampoAdicional2))),
		Caja = e.Caja,
		e.idClasificacion,
		e.FechaApertura,
		u.NombreCorto,
		e.Control1,
		e.Control2
	INTO #Guia
	FROM Expedientes e
		INNER JOIN dbo.fnSplitTextIDs(@IDList, ',') s ON e.IdExpediente = s.IdListed
		INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa = u.idUnidadAdministrativa;

	SET @Query= 'SELECT * FROM #Guia ORDER BY ' + @Orden;
	
	EXEC(@Query);

	DROP TABLE #Guia;

END

GO
/****** Object:  StoredProcedure [dbo].[IDDeJerarquia]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[IDDeJerarquia]
	@NombreDeJerarquia as varchar(255) WITH ENCRYPTION

as  
--Este procedimiento devuelve el id de un código tecleado completo (toda la jerarquía). Si no lo encuentra devuelve -1.

set nocount on

begin 
	declare @idPadre int, @idJerarquia int, @i int, @j int, @orden int
	declare @aux varchar(255)
	declare @NivelUnico bit

	declare @TablaDeJerarquia table (
					idClasificacion int,
					Nombre varchar(255),
					Descripcion varchar(255),
					Orden int,
					idPlazoDeConservacionTramite int,
					idPlazoDeConservacionConcentracion int,
					idDestinoFinal int,
					idInformacionClasificada int
					)

	--Asumo que el separador de jerarquías es el caracter "."
	declare @Separador varchar(5)
	select @Separador = '.'

	--Si el último caracter es diferente del separador, continúo.
	if (substring(@NombreDeJerarquia, len(@NombreDeJerarquia), 1) <> @Separador)
	begin
		select @orden = 1
		
		--Identifica el primer segmento, padre de todos los demás.
		select @i = charindex(@Separador, @NombreDeJerarquia)
		if (@i > 0)  --Tiene al menos un separador, lo que implica dos niveles.
		begin
			select @NivelUnico = 0
			select @IDPadre = idClasificacion
				from CuadroClasificacion
				where nombre = substring(@NombreDeJerarquia, 1, @i - 1)
					and isnull(idPadre, -1) = -1
			insert @TablaDeJerarquia	
				select idClasificacion, Nombre, Descripcion, @orden, idPlazoDeConservacionTramite, idPlazoDeConservacionConcentracion, idDestinoFinal, idInformacionClasificada
					from CuadroClasificacion
					where nombre = substring(@NombreDeJerarquia, 1, @i - 1)
						and isnull(idPadre, -1) = -1
		end
		else	--No tienen separador, así que es nivel único
		begin
			select @NivelUnico = 1	
			insert @TablaDeJerarquia	
			select idClasificacion, Nombre, Descripcion, @orden, idPlazoDeConservacionTramite, idPlazoDeConservacionConcentracion, idDestinoFinal, idInformacionClasificada
				from CuadroClasificacion
				where nombre = @NombreDeJerarquia
					and isnull(idPadre, -1) = -1
		end
		--Una vez obtenido el padre, me muevo hacia adentro, nivel por nivel hasta el último con el que salgo del while.
		while (@NivelUnico = 0)
		begin
			select @aux = substring(@NombreDeJerarquia, @i + 1, len(@NombreDeJerarquia) - @i + 1)  
			select @j = charindex(@Separador, @aux)
			if (@j > 0)
			begin
				select @aux = substring(@aux, 1, @j - 1)
	
				select @IDJerarquia = idClasificacion
					from CuadroClasificacion
					where nombre = @aux
						and idPadre = @IDPadre
	
				select @orden = @orden + 1
				insert @TablaDeJerarquia
				select idClasificacion, Nombre, Descripcion, @orden, idPlazoDeConservacionTramite, idPlazoDeConservacionConcentracion, idDestinoFinal, idInformacionClasificada
					from CuadroClasificacion
					where nombre = @aux
						and idPadre = @IDPadre
	
				select @IDPadre = @IDJerarquia
				select @i = @i + @j
			end
			else
			begin
				select @orden = @orden + 1
				insert @TablaDeJerarquia
				select idClasificacion, Nombre, Descripcion, @orden, idPlazoDeConservacionTramite, idPlazoDeConservacionConcentracion, idDestinoFinal, idInformacionClasificada
					from CuadroClasificacion
					where nombre = @aux
						and idPadre = @IDPadre
	
				select @IDJerarquia = idClasificacion
					from CuadroClasificacion
					where nombre = @aux
						and idPadre = @IDPadre
				if @@ROWCOUNT = 0
					delete @TablaDeJerarquia
				break
				
			end  --else 
		end --while (@i < ...
	end --if (substring(@NombreDeJerarquia ...

	select *
		from @TablaDeJerarquia
		order by orden

end -- procedure	
return




GO
/****** Object:  StoredProcedure [dbo].[Imagen_TransferenciaWS]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC Imagen_TransferenciaWS 1, 1
--DROP PROCEDURE Imagen_TransferenciaWS
ALTER PROCEDURE [dbo].[Imagen_TransferenciaWS]
(
	@IdExpediente INT,
	@IdImagen INT,
	@NombreArchivo NVARCHAR(1024) OUTPUT
) WITH ENCRYPTION
AS
BEGIN
	SELECT @NombreArchivo = NombrePDF
	FROM Expedientes_PDF_Relaciones 
	WHERE idExpediente = @IdExpediente
		AND idExpedientePDFRelaciones = @IdImagen;
END
GO
/****** Object:  StoredProcedure [dbo].[IsValidCode]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[IsValidCode]
	@idClasificacion AS INT,
	@idUsuarioReal AS INT,
	@IsValid AS BIT OUTPUT WITH ENCRYPTION
AS
BEGIN
	IF EXISTS
	(
		SELECT NULL 
		FROM UnidadesAdministrativasRelaciones u1 
			JOIN UsuariosRealesUnidadesAdministrativasRelaciones u2 ON u1.idUnidadAdministrativa = u2.idUnidadAdministrativa
		WHERE u1.idClasificacion = @idClasificacion
			AND u2.idUsuarioReal = @idUsuarioReal
	)
		SELECT @IsValid = 1
	ELSE
		SELECT @IsValid = 0
END


GO
/****** Object:  StoredProcedure [dbo].[LeeMemoStatusVigente]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LeeMemoStatusVigente]
AS
BEGIN
	SELECT MemoStatusVigenteField FROM MemoStatusVigente
END
GO
/****** Object:  StoredProcedure [dbo].[ListadoDeExpedientes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC ListadoDeExpedientes '22900'
ALTER PROCEDURE [dbo].[ListadoDeExpedientes]
(
	@IDList TEXT,
	@Orden NVARCHAR(100) = ' caja, nombre'
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @Query NVARCHAR(MAX);
	
	SELECT 
		UPPER(u.Descripcion) AS Unidad,
		e.RelacionAnterior AS Procedencia,
		UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)) AS Fondo,
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
		END AS Seccion,
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
		END AS Serie,
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
		END AS Subserie,
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
		END AS Subsubserie,
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 6))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 6))
		END AS Subsubsubserie,
		Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)) +
			(SELECT 
				MAX(cs.Descripcion) 
			FROM 
				ClasificacionStatus cs 
			WHERE cs.idClasificacionStatus = e.idClasificacionStatus),
		ValorPrimario = CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN 'A'
			ELSE SPACE(1)
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN 'C'
			ELSE SPACE(1)
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN 'L'
			ELSE SPACE(1)
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN 'H'
			ELSE SPACE(1)
		END,
		VigenciaDocumental = '',
		CONVERT(VARCHAR(10), e.FechaApertura, 3) AS FechaApertura, 
		CASE 
			WHEN e.FechaCierreChecked = 1 THEN CONVERT(VARCHAR(10), e.FechaCierre , 3) 
			ELSE SPACE(1) 
		END AS FechaCierre,
		e.Asunto,
		e.CajaAnterior,
		e.RelacionAnterior AS UbicacionAnterior,
		e.Caja,
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion) AS PlazoTramite,
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionTramite c
			WHERE e.idPlazoTramite = c.idPlazosDeConservacionTramite) AS PlazoConcentracion,
		e.idClasificacion,		
		e.Nombre,
		e.CampoAdicional1,
		e.CampoAdicional2,
		u.NombreCorto,
		e.Control1,
		e.Control2
	INTO #Lista
	FROM expedientes e 
		INNER JOIN dbo.fnSplitTextIDs(@IDList, ',') s ON e.IdExpediente = s.IdListed
		INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa = u.idUnidadAdministrativa;

	SET @Query = 'SELECT * FROM #Lista ORDER BY ' + @Orden;

	EXEC(@Query);

	DROP TABLE #Lista;

END



GO
/****** Object:  StoredProcedure [dbo].[ListadoDeExpedientesPorEstatus]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[ListadoDeExpedientesPorEstatus]
	@idEstatus INT WITH ENCRYPTION
AS 
SELECT  Unidad = (SELECT UPPER(u.Descripcion)
		FROM UnidadesAdministrativas u
		WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
	Procedencia = e.RelacionAnterior,
	Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
	Serie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
		END,
	Subserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
		END,
	Subsubserie =
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
		END,
	Subsubsubserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
		END,
	Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
	ValorPrimario =
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN 'A'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN 'C'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN 'L'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN 'H'
			ELSE ' '
		END,
	VigenciaDocumental =
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
	Expediente = e.Nombre,
	FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
	FechaCierre = CONVERT(VARCHAR(10), e.FechaCierre , 3),
	e.Asunto,
	e.CajaAnterior,
	UbicacionAnterior = e.ItemAnterior,
	CajaNueva = e.Caja
FROM
	Expedientes e
WHERE
	e.idEstatusExpediente = @idEstatus
ORDER BY
	e.idUnidadAdministrativa,
	dbo.fnNombreDeJerarquia(e.idClasificacion),
	e.FechaApertura,
	e.Nombre




GO
/****** Object:  StoredProcedure [dbo].[ListadoDeExpedientesPorEstatus2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ListadoDeExpedientesPorEstatus2]
	@idEstatus INT WITH ENCRYPTION
AS 
SELECT  Unidad = (SELECT UPPER(u.Descripcion)
		FROM UnidadesAdministrativas u
		WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
	Procedencia = e.RelacionAnterior,
	Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
	Serie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
		END,
	Subserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
		END,
	Subsubserie =
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
		END,
	Subsubsubserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
		END,
	Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
	ValorPrimario =
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN 'A'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN 'C'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN 'L'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN 'H'
			ELSE ' '
		END,
	VigenciaDocumental =
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
	Expediente = e.Nombre,
	FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
	FechaCierre = CONVERT(VARCHAR(10), e.FechaCierre , 3),
	e.Asunto,
	e.CajaAnterior,
	UbicacionAnterior = e.ItemAnterior,
	CajaNueva = e.Caja,
	FechaDeCorte = CONVERT(VARCHAR(10), msv.MemoStatusVigenteField , 3)
FROM
	Expedientes e, MemoStatusVigente msv
WHERE
	e.idEstatusExpediente = @idEstatus
ORDER BY
	e.idUnidadAdministrativa,
	dbo.fnNombreDeJerarquia(e.idClasificacion),
	e.FechaApertura,
	e.Nombre






GO
/****** Object:  StoredProcedure [dbo].[ListadoDeExpedientesPorEstatus3]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ListadoDeExpedientesPorEstatus3]
	@idEstatus INT WITH ENCRYPTION
AS 
SELECT  Unidad = (SELECT UPPER(u.Descripcion)
		FROM UnidadesAdministrativas u
		WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
	Procedencia = e.RelacionAnterior,
	Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
	Serie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
		END,
	Subserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
		END,
	Subsubserie =
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
		END,
	Subsubsubserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
		END,
	Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
	ValorPrimario =
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN 'A'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN 'C'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN 'L'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN 'H'
			ELSE ' '
		END,
	VigenciaDocumental =
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
	Expediente = e.Nombre,
	FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
	FechaCierre = CONVERT(VARCHAR(10), e.FechaCierre , 3),
	e.Asunto,
	e.CajaAnterior,
	UbicacionAnterior = e.ItemAnterior,
	CajaNueva = e.Caja,
	FechaDeCorte = CONVERT(VARCHAR(10), msv.MemoStatusVigenteField , 3)
FROM
	Expedientes e, MemoStatusVigente msv
WHERE
	e.idEstatusExpediente = @idEstatus
ORDER BY
	e.idUnidadAdministrativa,
	dbo.fnNombreDeJerarquia(e.idClasificacion),
	e.FechaApertura,
	e.Nombre






GO
/****** Object:  StoredProcedure [dbo].[ListadoDeExpedientesPorEstatusFiltrado]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE ListadoDeExpedientesPorEstatusFiltrado
ALTER PROCEDURE [dbo].[ListadoDeExpedientesPorEstatusFiltrado]
	@IdList TEXT,
	@Orden NVARCHAR(100) = ' Caja, Numero ',
	@IdEstatus INTEGER WITH ENCRYPTION
AS 
BEGIN
	DECLARE @SQLString NVARCHAR(4000), @ParmDefinition NVARCHAR(2000)

	SELECT  Unidad = UPPER(u.Descripcion),
		Procedencia = e.RelacionAnterior,
		Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
		Serie = 
			CASE 
				WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
				ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
			END,
		Subserie = 
			CASE 
				WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
				ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
			END,
		Subsubserie =
			CASE 
				WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
				ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
			END,
		Subsubsubserie = 
			CASE 
				WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
				ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
			END,
		Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
		ValorPrimario =
			CASE
				WHEN 
					(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 1)
					= 1 THEN 'A'
				ELSE ''
			END
			+
			CASE
				WHEN 
					(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 2)
					= 1 THEN 'C'
				ELSE ''
			END
			+
			CASE
				WHEN 
					(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 3)
					= 1 THEN 'L'
				ELSE ''
			END
			+
			CASE
				WHEN 
					(SELECT COUNT(*)
					FROM ValorDocumental_Expedientes_Relaciones v
					WHERE v.idExpediente = e.idExpediente
						AND v.idValorDocumental = 4)
					= 1 THEN 'H'
				ELSE ''
			END,
		VigenciaDocumental =
			(SELECT UPPER(c.Descripcion)
				FROM PlazosDeConservacionConcentracion c
				WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
		Expediente = e.Nombre,
		FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
		FechaCierre = CONVERT(VARCHAR(10), e.FechaCierre , 3),
		e.Asunto,
		e.CajaAnterior,
		UbicacionAnterior = e.RelacionAnterior,
		CajaNueva = e.Caja,
		FechaDeCorte = CONVERT(VARCHAR(10), msv.MemoStatusVigenteField , 3),
		PlazoTramite = pct.Descripcion,
		PlazoConcentracion = pcc.Descripcion,
		u.NombreCorto,
		e.Control1,
		e.Control2
	INTO #EstatusExpedientes
	FROM
		Expedientes e
			INNER JOIN dbo.fnSplitTextIDS(@IDList, ',') s ON e.IdExpediente = s.IdListed
			INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa = u.idUnidadAdministrativa
			INNER JOIN PlazosDeConservacionTramite pct ON pct.idPlazosDeConservacionTramite = e.idPlazoTramite
			INNER JOIN PlazosDeConservacionConcentracion pcc ON  pcc.idPlazosDeConservacionConcentracion = e.idPlazoConcentracion, 
		MemoStatusVigente msv 
	WHERE e.idEstatusExpediente = @idEstatus;

	DECLARE @Salida NVARCHAR(1024);

	SET @Salida = 'SELECT * FROM #EstatusExpedientes ORDER BY ' + @Orden;

	EXEC(@Salida);

	DROP TABLE #EstatusExpedientes;

END
GO
/****** Object:  StoredProcedure [dbo].[ListadoDeExpedientesPorEstatusSQL3]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ListadoDeExpedientesPorEstatusSQL3]
	
	@MiSQLString VARCHAR(8000),
	@MiCodigo VARCHAR(50),
	@MiExpediente VARCHAR(50),
	@MiExpedienteFinal VARCHAR(50),
	@MiTipo VARCHAR(50),
	@MiRFC VARCHAR(50),
	@MiAsunto VARCHAR(250),
	@MiCaja VARCHAR(25),
	@MiRelacionAnterior VARCHAR(25),
	@MiCajaAnterior varchar(25),
	@MiItemAnterior varchar(25),
	@MiCampoAdicional3 varchar(25),
	@MiOrden VARCHAR(50),
	@MiFechaInicial DATETIME,
	@MiFechaFinal DATETIME,
	@MiIDEstatus INTEGER WITH ENCRYPTION
AS 

DECLARE @SQLString NVARCHAR(4000), @ParmDefinition NVARCHAR(2000)

SELECT @SQLString = CONVERT(NVARCHAR(4000), 
'SELECT  Unidad = (SELECT UPPER(u.Descripcion)
		FROM UnidadesAdministrativas u
		WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
	Procedencia = e.RelacionAnterior,
	Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
	Serie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
		END,
	Subserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
		END,
	Subsubserie =
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
		END,
	Subsubsubserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
		END,
	Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
	ValorPrimario =
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN ''A''
			ELSE '' ''
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN ''C''
			ELSE '' ''
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN ''L''
			ELSE '' ''
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN ''H''
			ELSE '' ''
		END,
	VigenciaDocumental =
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
	Expediente = e.Nombre,
	FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
	FechaCierre = CONVERT(VARCHAR(10), e.FechaCierre , 3),
	e.Asunto,
	e.CajaAnterior,
	UbicacionAnterior = e.RelacionAnterior,
	CajaNueva = e.Caja,
	FechaDeCorte = CONVERT(VARCHAR(10), msv.MemoStatusVigenteField , 3),
	PlazoTramite = pct.Descripcion,
	PlazoConcentracion = pcc.Descripcion
FROM
	Expedientes e, MemoStatusVigente msv, PlazosDeConservacionTramite pct, PlazosDeConservacionConcentracion pcc
WHERE ' + @MiSQLString +
	' AND e.idEstatusExpediente = @idEstatus 
	AND pct.idPlazosDeConservacionTramite = e.idPlazoTramite 
	AND pcc.idPlazosDeConservacionConcentracion = e.idPlazoConcentracion 
ORDER BY
	e.idUnidadAdministrativa,
	dbo.fnNombreDeJerarquia(e.idClasificacion), ' + @MiOrden)

SELECT @ParmDefinition = '@Codigo varchar(50), @Expediente varchar(50), @ExpedienteFinal varchar(50), @Tipo varchar(50), @RFC varchar(50), @Asunto varchar(250), @Caja varchar(25),                @RelacionAnterior VARCHAR(25),       @CajaAnterior VARCHAR(25), @ItemAnterior VARCHAR(25), @CampoAdicional3 VARCHAR(25),                        @FechaInicial datetime, @FechaFinal datetime, @idEstatus integer'

EXECUTE sp_executesql	@SQLString,
			@ParmDefinition,
			@Codigo = @MiCodigo,
			@Expediente = @MiExpediente,
			@ExpedienteFinal = @MiExpedienteFinal,
			@Tipo = @MiTipo,
			@RFC = @MiRFC,
			@Asunto = @MiAsunto,
			@Caja = @MiCaja,

			@RelacionAnterior = @MiRelacionAnterior,

@CajaAnterior = @MiCajaAnterior,
@ItemAnterior = @MiItemAnterior,
@CampoAdicional3 = @MiCampoAdicional3,

			@FechaInicial = @MiFechaInicial,
			@FechaFinal = @MiFechaFinal,
			@idEstatus = @MiIDEstatus

RETURN

GO
/****** Object:  StoredProcedure [dbo].[ListadoDeExpedientesSQL2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ListadoDeExpedientesSQL2]
(
	@SQLCondicion NVARCHAR(MAX),
	@Codigo NVARCHAR(50),
	@Expediente NVARCHAR(50),
	@ExpedienteFinal NVARCHAR(50),
	@Tipo NVARCHAR(50),
	@RFC NVARCHAR(50),
	@Asunto NVARCHAR(250),
	@Caja NVARCHAR(25),
	@RelacionAnterior NVARCHAR(25),
	@CajaAnterior NVARCHAR(25),
	@ItemAnterior NVARCHAR(25),
	@CampoAdicional3 NVARCHAR(25),
	@Orden NVARCHAR(50) = '1',
	@FechaInicial DATETIME,
	@FechaFinal DATETIME 
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @SQLString NVARCHAR(MAX), @ParmDefinition NVARCHAR(2000);
	
	SELECT @SQLString = CONVERT(NVARCHAR(MAX), 
		'SELECT 
		UPPER(u.Descripcion) AS Unidad,
		e.RelacionAnterior AS Procedencia,
		UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)) AS Seccion,
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
		END AS Serie,
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
		END AS Subserie,
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
		END AS Subsubserie,
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
		END AS Subsubsubserie,
		Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)) +
			(SELECT 
				MAX(cs.Descripcion) 
			FROM 
				ClasificacionStatus cs 
			WHERE cs.idClasificacionStatus = e.idClasificacionStatus),
		ValorPrimario = CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN ''A''
			ELSE SPACE(1)
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN ''C''
			ELSE SPACE(1)
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN ''L''
			ELSE SPACE(1)
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN ''H''
			ELSE SPACE(1)
		END,
		VigenciaDocumental = '''',
		e.Nombre AS Expediente,
		CONVERT(VARCHAR(10), e.FechaApertura, 3) AS FechaApertura, 
		CASE 
			WHEN e.FechaCierreChecked = 1 THEN CONVERT(VARCHAR(10), e.FechaCierre , 3) 
			ELSE SPACE(1) 
		END AS FechaCierre,
		e.Asunto,
		e.CajaAnterior,
		e.RelacionAnterior AS UbicacionAnterior,
		e.Caja AS CajaNueva,
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion) AS PlazoTramite,
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionTramite c
			WHERE e.idPlazoTramite = c.idPlazosDeConservacionTramite) AS PlazoConcentracion 
		FROM expedientes e 
			INNER JOIN UnidadesAdministrativas u ON e.idUnidadAdministrativa = u.idUnidadAdministrativa 
		WHERE ' + @SQLCondicion + 
		' ORDER BY e.idUnidadAdministrativa, dbo.fnNombreDeJerarquia(e.idClasificacion), ' + @Orden)

	SELECT @ParmDefinition = '@Codigo VARCHAR(50), @Expediente VARCHAR(50), @ExpedienteFinal VARCHAR(50), @Tipo VARCHAR(50), @RFC VARCHAR(50), @Asunto VARCHAR(250), @Caja VARCHAR(25), @RelacionAnterior VARCHAR(25), @CajaAnterior VARCHAR(25), @ItemAnterior VARCHAR(25), @CampoAdicional3 VARCHAR(25), @FechaInicial DATETIME, @FechaFinal DATETIME'
	EXECUTE sp_executesql	@SQLString,
				@ParmDefinition,
				@Codigo = @Codigo,
				@Expediente = @Expediente,
				@ExpedienteFinal = @ExpedienteFinal,
				@Tipo = @Tipo,
				@RFC = @RFC,
				@Asunto = @Asunto,
				@Caja = @Caja,
				@RelacionAnterior = @RelacionAnterior,
				@CajaAnterior = @CajaAnterior,
				@ItemAnterior = @ItemAnterior,
				@CampoAdicional3 = @CampoAdicional3,
				@FechaInicial = @FechaInicial,
				@FechaFinal = @FechaFinal
END



GO
/****** Object:  StoredProcedure [dbo].[ListadoDeExpedientesSQL3]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListadoDeExpedientesSQL3]
	@MiSQLString VARCHAR(4000),
	@MiCodigo VARCHAR(50),
	@MiExpediente VARCHAR(50),
	@MiExpedienteFinal VARCHAR(50),
	@MiTipo VARCHAR(50),
	@MiRFC VARCHAR(50),
	@MiAsunto VARCHAR(250),
	@MiCaja VARCHAR(25),

	@MiAnaqC varchar(25),
	@MiUbicC varchar(25),
	@MiObsC varchar(25),

	@MiRelacionAnterior VARCHAR(25),


@MiCajaAnterior varchar(25),
@MiItemAnterior varchar(25),
@MiCampoAdicional3 varchar(25),
@MiOrden VARCHAR(50),

	@MiFechaInicial DATETIME,
	@MiFechaFinal DATETIME WITH ENCRYPTION
AS 
DECLARE @SQLString NVARCHAR(4000), @ParmDefinition NVARCHAR(2000)
SELECT @SQLString = CONVERT(NVARCHAR(4000), 
	'SELECT  Unidad = (SELECT UPPER(u.Descripcion)
		FROM UnidadesAdministrativas u
		WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
	Procedencia = e.RelacionAnterior,
	Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
	Serie = CASE 
		WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
		ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
	END,
	Subserie = CASE 
		WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
		ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
	END,
	Subsubserie = CASE 
		WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
		ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
	END,
	Subsubsubserie = CASE 
		WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
		ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
	END,
	Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
	ValorPrimario =
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN ''A''
			ELSE SPACE(1)
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN ''C''
			ELSE SPACE(1)
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN ''L''
			ELSE SPACE(1)
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN ''H''
		ELSE SPACE(1)
		END,
	VigenciaDocumental =
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
	Expediente = e.Nombre,
	FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
	FechaCierre = CASE WHEN e.FechaCierreChecked = 1 THEN CONVERT(VARCHAR(10), e.FechaCierre , 3) ELSE SPACE(1) END,
	e.Asunto,
	e.CajaAnterior,
	UbicacionAnterior = e.RelacionAnterior,
	CajaNueva = e.Caja
FROM expedientes e WHERE ' + @MiSQLString + ' ORDER BY e.idUnidadAdministrativa, dbo.fnNombreDeJerarquia(e.idClasificacion), ' + @MiOrden)
SELECT @ParmDefinition = '@Codigo VARCHAR(50), @Expediente VARCHAR(50), @ExpedienteFinal VARCHAR(50), @Tipo VARCHAR(50), @RFC VARCHAR(50), @Asunto VARCHAR(250), @Caja VARCHAR(25),    @AnaqC varchar(25), @UbicC varchar(25), @ObsC varchar(25),     @RelacionAnterior VARCHAR(25),                @CajaAnterior VARCHAR(25), @ItemAnterior VARCHAR(25), @CampoAdicional3 VARCHAR(25),                        @FechaInicial DATETIME, @FechaFinal DATETIME'
EXECUTE sp_executesql	@SQLString,
			@ParmDefinition,
			@Codigo = @MiCodigo,
			@Expediente = @MiExpediente,
			@ExpedienteFinal = @MiExpedienteFinal,
			@Tipo = @MiTipo,
			@RFC = @MiRFC,
			@Asunto = @MiAsunto,
			@Caja = @MiCaja,

			@AnaqC = @MiAnaqC,
			@UbicC = @MiUbicC,
			@ObsC = @MiObsC,

			@RelacionAnterior = @MiRelacionAnterior,


@CajaAnterior = @MiCajaAnterior,
@ItemAnterior = @MiItemAnterior,
@CampoAdicional3 = @MiCampoAdicional3,



			@FechaInicial = @MiFechaInicial,
			@FechaFinal = @MiFechaFinal
		
RETURN



GO
/****** Object:  StoredProcedure [dbo].[LocalizacionExpedientes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[LocalizacionExpedientes] WITH ENCRYPTION
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		u.Descripcion,
		e.CampoAdicional2,
		e.ItemAnterior,
		e.Asunto,
		Codigo = dbo.fnNombreDeJerarquia(e.idClasificacion),
		Expediente = e.Nombre,
		e.CajaAnterior,
		e.Caja,
		e.RelacionAnterior,
		e.CampoAdicional1
	FROM 
		expedientes e JOIN
			UnidadesAdministrativas u ON e.idUnidadAdministrativa = u.idUnidadAdministrativa
	ORDER BY
		e.CampoAdicional2, Codigo, Expediente
END


GO
/****** Object:  StoredProcedure [dbo].[MiEjecuta_sp]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[MiEjecuta_sp]
	(
		@CadenaSQLAEjecutar		varchar(4000),
		@CadenaDeParametrosDeEntrada	varchar(2000),
		@CadenaDeParametrosDeSalida	varchar(2000)	OUTPUT
	)  WITH ENCRYPTION
AS

	DECLARE @SQLString NVARCHAR(4000)
	DECLARE @ParmDefinition NVARCHAR(2000)
	
	SET @SQLString = CONVERT(NVARCHAR(4000),@CadenaSQLAEjecutar)
	SET @ParmDefinition = '@CadenaDeParametrosDeEntradaInterna varchar(2000), @CadenaDeParametrosDeSalidaInterna varchar(2000) OUTPUT'

	EXECUTE sp_executesql @SQLString, @ParmDefinition, @CadenaDeParametrosDeEntradaInterna=@CadenaDeParametrosDeEntrada, @CadenaDeParametrosDeSalidaInterna = @CadenaDeParametrosDeSalida OUTPUT


GO
/****** Object:  StoredProcedure [dbo].[Movimientos_idExpediente_DELETE_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Movimientos_idExpediente_DELETE_ALL]

@idExpediente		integer,
@id_record_procesadoOK	integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	/* Borro el record */
	DELETE 
		Movimientos
	WHERE
		idExpediente = @idExpediente

	SET @err1 = @@error

	/* Si no hubo ningun error */
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el id que ha sido eliminado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			SELECT @id_record_procesadook = 0 
		END

GO
/****** Object:  StoredProcedure [dbo].[Movimientos_idExpediente_DELETE_ONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Movimientos_idExpediente_DELETE_ONE]

@idMovimientos		integer,
@id_record_procesadoOK	integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	/* Borro el record */
	DELETE 
		Movimientos
	WHERE
		idMovimientos = @idMovimientos

	SET @err1 = @@error

	/* Si no hubo ningun error */
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el id que ha sido eliminado */
			SELECT @id_record_procesadoOK = @idMovimientos
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			SELECT @id_record_procesadook = 0 
		END

GO
/****** Object:  StoredProcedure [dbo].[Movimientos_idExpediente_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Movimientos_idExpediente_INSERT]

@Fecha				datetime,
@idUsuarioReal			integer,
@Descripcion			varchar(250),
@idExpediente			integer,
@QuienEntrega			varchar(50),
@QuienRecibe			varchar(50),
@DependenciaDelQueRecibe	varchar(50),

@id_record_procesadoOK	integer = 0	output WITH ENCRYPTION

AS

	DECLARE	@err1	int

	SET @err1 = 0

	BEGIN TRAN

	INSERT Movimientos
	(
		Fecha,
		idUsuarioReal,
		Descripcion,
		idExpediente,
		QuienEntrega,
		QuienRecibe,
		DependenciaDelQueRecibe
	)
	VALUES
	(
		@Fecha,
		@idUsuarioReal,
		@Descripcion,
		@idExpediente,
		@QuienEntrega,
		@QuienRecibe,
		@DependenciaDelQueRecibe
	)

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = MAX(idMovimientos) FROM Movimientos
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END


GO
/****** Object:  StoredProcedure [dbo].[Movimientos_idExpediente_SELECT_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Movimientos_idExpediente_SELECT_ALL]

@idExpediente	integer WITH ENCRYPTION

AS

		SELECT 
			m.idMovimientos, 
			CONVERT(datetime,m.Fecha,103) as Fecha, 
			m.idUsuarioReal, 
			m.Descripcion, 
			m.idExpediente, 
			ur.Nombre,
			m.QuienEntrega,
			m.QuienRecibe,
			m.DependenciaDelQueRecibe 
		FROM 
			Movimientos m
			JOIN UsuariosReales ur
			ON ur.idUsuarioReal = m.idUsuarioReal
		WHERE 
			m.idExpediente = @idExpediente
		ORDER BY 
			m.fecha, ur.Nombre

GO
/****** Object:  StoredProcedure [dbo].[Movimientos_idExpediente_SELECT_ALL_2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Movimientos_idExpediente_SELECT_ALL_2]

@idExpediente	integer WITH ENCRYPTION

AS

		SELECT 
			m.idMovimientos, 
			CONVERT(varchar(10),m.Fecha,103) as Fecha, 
			m.idUsuarioReal, 
			m.Descripcion,
			--SUBSTRING(m.Descripcion,1,40) as Descripcion, 
			m.idExpediente, 
			ur.Nombre,
			m.QuienEntrega,
			m.QuienRecibe,
			m.DependenciaDelQueRecibe,
			convert(datetime,m.fecha) as MyFecha 
		FROM 
			Movimientos m
			JOIN UsuariosReales ur
			ON ur.idUsuarioReal = m.idUsuarioReal
		WHERE 
			m.idExpediente = @idExpediente
		ORDER BY 
			MyFecha desc  --, ur.Nombre


GO
/****** Object:  StoredProcedure [dbo].[Movimientos_idExpediente_SELECT_ONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Movimientos_idExpediente_SELECT_ONE]

@idMovimientos	integer WITH ENCRYPTION

AS

		SELECT 
			m.idMovimientos, 
			CONVERT(datetime,m.Fecha,103) as Fecha, 
			m.idUsuarioReal, 
			m.Descripcion, 
			m.idExpediente, 
			ur.Nombre,
			m.QuienEntrega,
			m.QuienRecibe,
			m.DependenciaDelQueRecibe 
		FROM 
			Movimientos m
			JOIN UsuariosReales ur
			ON ur.idUsuarioReal = m.idUsuarioReal
		WHERE 
			m.idMovimientos = @idMovimientos
--		ORDER BY 
--			m.fecha, ur.Nombre

GO
/****** Object:  StoredProcedure [dbo].[Movimientos_idExpediente_SELECT_ONE_2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Movimientos_idExpediente_SELECT_ONE_2]

@idMovimientos	integer WITH ENCRYPTION

AS

		SELECT 
			m.idMovimientos, 
			CONVERT(varchar(10),m.Fecha,103) as FechaDMA, 
			m.idUsuarioReal, 
			m.Descripcion, 
			m.idExpediente, 
			ur.Nombre,
			m.QuienEntrega,
			m.QuienRecibe,
			m.DependenciaDelQueRecibe 
		FROM 
			Movimientos m
			JOIN UsuariosReales ur
			ON ur.idUsuarioReal = m.idUsuarioReal
		WHERE 
			m.idMovimientos = @idMovimientos
--		ORDER BY 
--			m.fecha, ur.Nombre


GO
/****** Object:  StoredProcedure [dbo].[Movimientos_idExpediente_UPDATE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Movimientos_idExpediente_UPDATE]

@idMovimientos			integer,
@Fecha				datetime,
@idUsuarioReal			integer,
@Descripcion			varchar(250),
@idExpediente			integer,
@QuienEntrega			varchar(50),
@QuienRecibe			varchar(50),
@DependenciaDelQueRecibe	varchar(50),

@id_record_procesadoOK	integer = 0	output WITH ENCRYPTION

AS

	DECLARE	@err1	int

	SET @err1 = 0

	BEGIN TRAN

	UPDATE Movimientos
	SET
		Fecha = @Fecha,
		idUsuarioReal = @idUsuarioReal,
		Descripcion = @Descripcion,
		idExpediente = @idExpediente,
		QuienEntrega = @QuienEntrega,
		QuienRecibe = @QuienRecibe,
		DependenciaDelQueRecibe = @DependenciaDelQueRecibe
	FROM 
		Movimientos
	WHERE
		idMovimientos = @idMovimientos

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idMovimientos
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[Movimientos_Para_Impresion]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Movimientos_Para_Impresion]

@idMovimientos	integer WITH ENCRYPTION

AS

		SELECT 
--			CONVERT(datetime,m.Fecha,103) as Fecha, 
			m.Fecha,
			m.QuienEntrega,
			m.QuienRecibe,
			m.DependenciaDelQueRecibe, 
			m.Descripcion,
			ur.Nombre as NombreOperador,
			dbo.fnNombreDeJerarquia(e.idClasificacion) as Jerarquia,
			e.Nombre as Expediente,
			e.Asunto as NombreInteresado
		FROM 
			Movimientos m
			JOIN UsuariosReales ur
			ON ur.idUsuarioReal = m.idUsuarioReal
			JOIN Expedientes e
			ON m.idExpediente = e.idExpediente
		WHERE 
			m.idMovimientos = @idMovimientos

GO
/****** Object:  StoredProcedure [dbo].[NombreDeJerarquia]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[NombreDeJerarquia](@idClasificacion as int) WITH ENCRYPTION

as  

begin 
	declare @idPadre int
	declare @NomenclaturaDeJerarquia char(20)

	select @idPadre = idPadre, @NomenclaturaDeJerarquia = nombre
	from CuadroClasificacion
	where idClasificacion = @idClasificacion

	print @NomenclaturaDeJerarquia 

	while (@idPadre is not null)
	begin
		select @idClasificacion = @idPadre
		
		select @idPadre = idPadre, @NomenclaturaDeJerarquia = nombre + '.' + @NomenclaturaDeJerarquia
		from CuadroClasificacion
		where idClasificacion = @idClasificacion
	print @NomenclaturaDeJerarquia

	end

  select Nomenclatura = @NomenclaturaDeJerarquia

end



GO
/****** Object:  StoredProcedure [dbo].[NombreDeJerarquiaPorNivel]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[NombreDeJerarquiaPorNivel]

@IdClasificacion INT,
@Nivel INT WITH ENCRYPTION

AS  
	DECLARE @NomenclaturaDeJerarquia VARCHAR(255), @Niveles INT, @i INT, @Aux VARCHAR(255), @Aux2 VARCHAR(255)

	SELECT @NomenclaturaDeJerarquia = dbo.fnNombreDeJerarquia(@IdClasificacion) + '.'

	SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
	SELECT @Aux = ''
	SELECT @Niveles = 0
	WHILE (@Niveles < @Nivel + 1)
	BEGIN
		SELECT @Niveles = @Niveles + 1
		SELECT @Aux2 = @Aux
		IF @i <> 0
		BEGIN
			SELECT @Aux = @Aux + SUBSTRING(@NomenclaturaDeJerarquia, 1, @i)
			SELECT @NomenclaturaDeJerarquia = SUBSTRING(@NomenclaturaDeJerarquia, @i + 1, LEN(@NomenclaturaDeJerarquia))
			SELECT @i = CHARINDEX('.', @NomenclaturaDeJerarquia)
		END
		ELSE
			BREAK
	END
	--SELECT @Aux2 = SUBSTRING(@Aux2, 1, LEN(@Aux2) - 1)
	SELECT Descripcion = @Aux2 + SPACE(1) + c.Descripcion
		FROM CuadroClasificacion c
		WHERE c.idClasificacion = dbo.fnGetIDJerarquia(SUBSTRING(@Aux2, 1, LEN(@Aux2) - 1))
	--SELECT @Aux2
RETURN

GO
/****** Object:  StoredProcedure [dbo].[NuevoNumeroDeExpediente]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[NuevoNumeroDeExpediente]
	@IdClasificacion INT,
	@FechaApertura DATETIME,
	@NuevoNumero VARCHAR(25) OUTPUT WITH ENCRYPTION
AS
BEGIN
	DECLARE @Consecutivo INT
	SELECT @Consecutivo = ISNULL((SELECT c.Consecutivo 
					FROM ConsecutivosPorAnoYClasificacion c 
					WHERE c.idClasificacion = @IdClasificacion 
					AND c.Ano = YEAR(@FechaApertura)),
				0)
	--Si no hay record, inserto uno nuevo
	IF (@Consecutivo = 0)
		INSERT ConsecutivosPorAnoYClasificacion
			(idClasificacion, Ano, Consecutivo) 
		VALUES 
			(@IdClasificacion, YEAR(@FechaApertura), 0)
	--Incremento el consecutivo
	SELECT @Consecutivo = @Consecutivo + 1
	--Actualizo el consecutivo para el año y el idClasificacion, para dejar preparada la siguiente lectura
	UPDATE ConsecutivosPorAnoYClasificacion 
	SET Consecutivo = @Consecutivo 
	WHERE IdClasificacion = @IdClasificacion 
	AND Ano = YEAR(@FechaApertura)
	--Preparo el nombre del Expediente 
	SELECT @NuevoNumero = LTRIM(RTRIM(STR(YEAR(@FechaApertura)))) + '/' + REPLICATE('0', 6 - LEN(LTRIM(RTRIM(STR(@Consecutivo))))) + LTRIM(RTRIM(STR(@Consecutivo)))
END


GO
/****** Object:  StoredProcedure [dbo].[NumeroDeHijos]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[NumeroDeHijos]

@idClasificacion	integer,
@Respuesta		integer output WITH ENCRYPTION

AS 

SET @Respuesta = ISNULL(
			(SELECT COUNT(*) 
			FROM CuadroClasificacion c1 
			WHERE c1.idPadre = @idClasificacion),
		0)	

GO
/****** Object:  StoredProcedure [dbo].[ParetoExpedientes]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ParetoExpedientes]
(
	@ValorPareto AS INT = 80
) WITH ENCRYPTION
AS 
BEGIN
	DECLARE @Pareto TABLE (
		Porcentaje FLOAT,
		Codigo NVARCHAR(20)
	);
	DECLARE @Total FLOAT;
	DECLARE @Porcentaje FLOAT;
	DECLARE @Codigo NVARCHAR(20);
	DECLARE @Suma FLOAT;
	DECLARE @Otros INT;
	DECLARE @OtrosTotal FLOAT;

	SELECT @Total = COUNT(nombre) FROM expedientes;
	SET @Suma = 0.0;
	SET @Otros = 0;
	SET @OtrosTotal = 0.0;
	DECLARE Porcentajes CURSOR FOR 
		SELECT COUNT(Nombre) / @Total, dbo.fnNombreDeJerarquia(idClasificacion) 
		FROM expedientes
		GROUP BY idClasificacion
		ORDER BY COUNT(Nombre) DESC;
	OPEN Porcentajes;
	FETCH NEXT FROM Porcentajes 
		INTO @Porcentaje, @Codigo;

	WHILE  @@FETCH_STATUS = 0
	BEGIN
		SET @Suma = @Suma + @Porcentaje;
		IF @Suma < (@ValorPareto / 100.0)
		BEGIN
			INSERT INTO @Pareto (Porcentaje, Codigo)
			SELECT ROUND(@Porcentaje * 100, 4), @Codigo;
		END
		ELSE
		BEGIN
			SET @Otros = @Otros + 1;
			SET @OtrosTotal = @OtrosTotal + @Porcentaje;
		END

		FETCH NEXT FROM Porcentajes 
			INTO @Porcentaje, @Codigo;
	END;

	CLOSE Porcentajes;
	DEALLOCATE Porcentajes;

	SELECT SUM(Porcentaje) AS Principales, COUNT(Porcentaje) AS Codigos, ROUND(@OtrosTotal * 100, 4) AS Demas, @Otros AS DemasCodigos FROM @Pareto;

	SELECT * FROM @Pareto;

END
GO
/****** Object:  StoredProcedure [dbo].[PlazosDeConservacionConcentracion_SELECTALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PlazosDeConservacionConcentracion_SELECTALL] WITH ENCRYPTION

AS

SELECT * FROM PlazosDeConservacionConcentracion

GO
/****** Object:  StoredProcedure [dbo].[PlazosDeConservacionTramite_SELECTALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PlazosDeConservacionTramite_SELECTALL] WITH ENCRYPTION

AS

SELECT * FROM PlazosDeConservacionTramite

GO
/****** Object:  StoredProcedure [dbo].[SelVencEnConc]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SelVencEnConc]
	@idUnidAdm	integer,
	@FechaDeCorte	DATETIME WITH ENCRYPTION
AS
BEGIN

SELECT 
	e.idExpediente,
	e.Caja + ' - '
	+ (dbo.fnNombreDeJerarquia(e.idClasificacion) + ' - ' 
	+ e.Nombre + ' - ' 
	+ CONVERT(varchar(10),e.FechaCierre,103) + ' - '
	+ c.descripcion + '(T) - ' 
	+ pcc.descripcion + '(C) - ' 
	+ e.Asunto) as Expediente
/*
        e.idExpediente,
	dbo.fnNombreDeJerarquia(e.idClasificacion) as Codigo,
        e.Nombre as Expediente,
        e.CampoAdicional2  as Tipo,
        e.CampoAdicional1  as RFC,
        e.Asunto,
        e.Caja,
        CONVERT(varchar(10),e.FechaApertura,103) as [F.Apertura],
        CONVERT(varchar(10),e.FechaCierre,103) as [F.Cierre],
	c.descripcion as Plazo
*/
FROM Expedientes e
	JOIN PlazosDeConservacionTramite c 
	ON e.idPlazoTramite = c.idPlazosDeConservacionTramite
	JOIN PlazosDeConservacionConcentracion pcc
	ON e.idPlazoConcentracion = pcc.idPlazosDeConservacionConcentracion
WHERE
	e.FechaCierreChecked = 1
	AND e.idUnidadAdministrativa = @idUnidAdm
	AND DATEDIFF(DAY, e.FechaCierre, @FechaDeCorte) >= c.Dias + pcc.Dias
	AND (e.idEstatusExpediente = 4)
	AND e.idExpediente NOT IN (SELECT idExpediente 
					FROM Batches_Relaciones br 
					JOIN Batches b 
					ON br.idBatch = br.idBatch 
					WHERE b.idTipoDeBatch = 2 AND b.idUnidAdm = @idUnidAdm)
ORDER BY dbo.fnNombreDeJerarquia(e.idClasificacion), e.Nombre, e.FechaCierre


END
GO
/****** Object:  StoredProcedure [dbo].[SelVencEnConc_New]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[SelVencEnConc_New]
	@idUnidAdm	integer,
	@FechaDeCorte	DATETIME WITH ENCRYPTION
AS
BEGIN

SELECT 
	Unidad = (SELECT u.Descripcion
		FROM UnidadesAdministrativas u
		WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
	Procedencia = e.RelacionAnterior,
	Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
	Serie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
		END,
	Subserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
		END,
	Subsubserie =
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
		END,
	Subsubsubserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
		END,
	Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
	ValorPrimario =
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN 'A'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN 'C'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN 'L'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN 'H'
			ELSE ' '
		END,
	VigenciaDocumental =
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
	Expediente = e.Nombre,
	FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
	FechaCierre = CONVERT(VARCHAR(10), e.FechaCierre , 3),
	e.Asunto,
	e.CajaAnterior,
	UbicacionAnterior = e.RelacionAnterior,
	CajaNueva = e.Caja,
	FechaDeCorte =  CONVERT(VARCHAR(10), @FechaDeCorte , 3),
	PlazoTramite = c.Descripcion,
	PlazoConcentracion = pcc.Descripcion, 
	CajaProv = ''  		--Campo agregado por compatibilidad con el TTX

FROM Expedientes e
	JOIN PlazosDeConservacionTramite c 
	ON e.idPlazoTramite = c.idPlazosDeConservacionTramite
	JOIN PlazosDeConservacionConcentracion pcc
	ON e.idPlazoConcentracion = pcc.idPlazosDeConservacionConcentracion
WHERE
	e.FechaCierreChecked = 1
	AND e.idUnidadAdministrativa = @idUnidAdm
	AND DATEDIFF(DAY, e.FechaCierre, @FechaDeCorte) >= c.Dias + pcc.Dias
	AND (e.idEstatusExpediente = 4)
	AND e.idExpediente NOT IN (SELECT idExpediente 
					FROM Batches_Relaciones br 
					JOIN Batches b 
					ON br.idBatch = br.idBatch 
					WHERE b.idTipoDeBatch = 2 AND b.idUnidAdm = @idUnidAdm)
ORDER BY dbo.fnNombreDeJerarquia(e.idClasificacion), e.Nombre, e.FechaCierre

END
GO
/****** Object:  StoredProcedure [dbo].[SubArbolDeCuentas]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SubArbolDeCuentas]
	@id int,			--Necesario, id de la cuenta por buscar.
	@NivelDeSalida int = 0		--Opcional, nivel por mostrar.
--	@NivelMaximo int = 0 output	--Opcional, devuelve nivel máximo. 
 WITH ENCRYPTION
as

set nocount on

declare @NivelMaximo int
declare @Resultados table (	idClasificacion				int, 
				idPadre					int, 
				Nombre					varchar(50), 
				Descripcion				varchar(250), 
--				idValorDocumental			integer,
				idPlazoDeConservacionTramite		integer,
				idPlazoDeConservacionConcentracion	integer,
				idDestinoFinal				integer,
				idInformacionClasificada		integer,
				Hijos					integer,
				Afectable				bit,
				Nivel					tinyint
				)


declare @Nivel tinyint
set @Nivel = 1

declare @Contador int

--Inserta nodo inicial pasado como parámetro
insert into @Resultados 
select  
	c.idClasificacion,
	idPadre= ISNULL(c.idPadre,0),
	c.Nombre, 
	c.Descripcion, 
--	c.idValorDocumental,
	c.idPlazoDeConservacionTramite,
	c.idPlazoDeConservacionConcentracion,
	c.idDestinoFinal,
	c.idInformacionClasificada,
	Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
	Afectable = 
		CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion) > 0 THEN
			0
		ELSE
			1
		END,
	@Nivel 
from
	CuadroClasificacion c
--	JOIN Cat_Clasificacion_Cuentas ccc
--	ON c.idClasificacion = ccc.idClasificacion
--	JOIN Cat_Monedas cm
--	ON c.idMoneda = cm.idMoneda

where c.idClasificacion = @id

select @Contador = @@ROWCOUNT

while @Contador > 0
begin
      	--Inserta los nodos hijos del nodo actual
	insert into @Resultados 
	select  
		c.idClasificacion,
		idPadre= ISNULL(c.idPadre,0),
		c.Nombre, 
		c.Descripcion, 
--		c.idValorDocumental,
		c.idPlazoDeConservacionTramite,
		c.idPlazoDeConservacionConcentracion,
		c.idDestinoFinal,
		c.idInformacionClasificada,
--		ccc.Clasificacion,
--		ccc.Naturaleza,
--		ccc.Balance,
--		c.Activa,
--		c.idMoneda,
--		DescripcionMoneda = cm.Descripcion,
		Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
		Afectable = 
			CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion) > 0 THEN
				0
			ELSE
				1
			END,
		@Nivel + 1
	from 
		CuadroClasificacion c
		join @Resultados r 
		on c.idPadre = r.idClasificacion

--		JOIN Cat_Clasificacion_Cuentas ccc
--		ON c.idClasificacion = ccc.idClasificacion
	
--		JOIN Cat_Monedas cm
--		ON c.idMoneda = cm.idMoneda

	where r.Nivel = @Nivel
	
        select @Contador = @@ROWCOUNT, @Nivel = @Nivel + 1
end -- while

select @NivelMaximo = max(Nivel) from @Resultados

if (@NivelDeSalida <= 0)	--Entrega todos los niveles
	select r.*, NivelMaximo = @NivelMaximo  from @Resultados r
	order by Nivel, Nombre
else				--Entrega SOLAMENTE el nivel especificado
	select r.*, NivelMaximo = @NivelMaximo from @Resultados r
	where r.Nivel = @NivelDeSalida
	order by Nombre
return

GO
/****** Object:  StoredProcedure [dbo].[SubArbolDeCuentasOrdenado]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SubArbolDeCuentasOrdenado]
	@id int,			--Necesario, id de la cuenta por buscar.
	@NivelDeSalida int = 0		--Opcional, nivel por mostrar.
	 WITH ENCRYPTION
as

set nocount on

declare @NivelMaximo int
declare @Resultados table (	idClasificacion				int, 
				idPadre					int, 
				Nombre					varchar(50), 
				Descripcion				varchar(250), 
				idPlazoDeConservacionTramite		integer,
				idPlazoDeConservacionConcentracion	integer,
				idDestinoFinal				integer,
				idInformacionClasificada		integer,
				Hijos					integer,
				Afectable				bit,
				Nivel					tinyint
				)


declare @Nivel tinyint
set @Nivel = 1

declare @Contador int

--Inserta nodo inicial pasado como parámetro
insert into @Resultados 
select  
	c.idClasificacion,
	idPadre= ISNULL(c.idPadre,0),
	c.Nombre, 
	c.Descripcion, 
	c.idPlazoDeConservacionTramite,
	c.idPlazoDeConservacionConcentracion,
	c.idDestinoFinal,
	c.idInformacionClasificada,
	Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
	Afectable = 
		CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion) > 0 THEN
			0
		ELSE
			1
		END,
	@Nivel 
from
	CuadroClasificacion c
where c.idClasificacion = @id

select @Contador = @@ROWCOUNT

while @Contador > 0
begin
      	--Inserta los nodos hijos del nodo actual
	insert into @Resultados 
	select  
		c.idClasificacion,
		idPadre= ISNULL(c.idPadre,0),
		c.Nombre, 
		c.Descripcion, 
		c.idPlazoDeConservacionTramite,
		c.idPlazoDeConservacionConcentracion,
		c.idDestinoFinal,
		c.idInformacionClasificada,
		Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
		Afectable = 
			CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion) > 0 THEN
				0
			ELSE
				1
			END,
		@Nivel + 1
	from 
		CuadroClasificacion c
		join @Resultados r 
		on c.idPadre = r.idClasificacion
	where r.Nivel = @Nivel
	
        select @Contador = @@ROWCOUNT, @Nivel = @Nivel + 1
end -- while

select @NivelMaximo = max(Nivel) from @Resultados

if (@NivelDeSalida <= 0)	--Entrega todos los niveles
	select dbo.fnExtraeDigitosIniciales(r.Nombre) as Ordenacion, r.*, NivelMaximo = @NivelMaximo  from @Resultados r
	order by Nivel, Ordenacion, Nombre
else				--Entrega SOLAMENTE el nivel especificado
	select dbo.fnExtraeDigitosIniciales(r.Nombre) as Ordenacion, r.*, NivelMaximo = @NivelMaximo from @Resultados r
	where r.Nivel = @NivelDeSalida
	order by  Ordenacion, Nombre
return

GO
/****** Object:  StoredProcedure [dbo].[SubArbolDeCuentasOrdenado2]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[SubArbolDeCuentasOrdenado2]
 WITH ENCRYPTION
as

select  dbo.fnNombreDeJerarquia(idClasificacion) as NombreDeJerarquia,
		Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
	Afectable = 
		CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion) > 0 THEN
			0
		ELSE
			1
		END,
	c.idClasificacion,
	idPadre= ISNULL(c.idPadre,0),
	c.Nombre, 
	c.Descripcion, 
	c.idPlazoDeConservacionTramite,
	c.idPlazoDeConservacionConcentracion,
	c.idDestinoFinal,
	c.idInformacionClasificada
	FROM CuadroClasificacion c ORDER BY NombreDeJerarquia

GO
/****** Object:  StoredProcedure [dbo].[SubArbolDeCuentasOrdenado3]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC SubArbolDeCuentasOrdenado3 ''
--DROP PROCEDURE SubArbolDeCuentasOrdenado3
ALTER PROCEDURE [dbo].[SubArbolDeCuentasOrdenado3]
(
	@CadenaABuscar NVARCHAR(250) = ''
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @SQLString NVARCHAR(MAX);

	SET @SQLString = '
		SELECT  dbo.fnNombreDeJerarquia(idClasificacion) AS NombreDeJerarquia,
			Hijos = (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion),
			Afectable = 
				CASE WHEN (SELECT COUNT(*) FROM CuadroClasificacion WHERE idPadre = c.idClasificacion) > 0 THEN
					0
				ELSE
					1
			END,
			c.idClasificacion,
			idPadre= ISNULL(c.idPadre,0),
			c.Nombre, 
			c.Descripcion, 
			c.idPlazoDeConservacionTramite,
			c.idPlazoDeConservacionConcentracion,
			c.idDestinoFinal,
			c.idInformacionClasificada
		FROM CuadroClasificacion c 
		WHERE dbo.fnNombreDeJerarquia(idClasificacion) LIKE ''' + @CadenaABuscar + '%'' 
		ORDER BY NombreDeJerarquia';

	EXECUTE sp_executesql @SQLString

END
GO
/****** Object:  StoredProcedure [dbo].[UnidadesAdministrativas_DELETE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UnidadesAdministrativas_DELETE]
	@Id AS INT WITH ENCRYPTION
AS

	DELETE UnidadesAdministrativas
	WHERE
		UnidadesAdministrativas.idUnidadAdministrativa = @Id		

RETURN

GO
/****** Object:  StoredProcedure [dbo].[UnidadesAdministrativas_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[UnidadesAdministrativas_INSERT]
	@Codigo VARCHAR(50),
	@NombreCorto VARCHAR(50),
	@Descripcion VARCHAR(250),
	@Titular VARCHAR(50),
	@Id INT OUTPUT WITH ENCRYPTION
AS
SET NOCOUNT ON
INSERT
	INTO UnidadesAdministrativas
		(Codigo, NombreCorto, Descripcion, Titular)
	VALUES (@Codigo, @NombreCorto, @Descripcion, @Titular)
SELECT
	@Id = MAX(idUnidadAdministrativa)
	FROM UnidadesAdministrativas
RETURN

GO
/****** Object:  StoredProcedure [dbo].[UnidadesAdministrativas_SELECTONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UnidadesAdministrativas_SELECTONE]
	@Id AS INT WITH ENCRYPTION

AS

	SELECT * 
		FROM UnidadesAdministrativas
		WHERE IdUnidadAdministrativa = @Id

RETURN

GO
/****** Object:  StoredProcedure [dbo].[UnidadesAdministrativas_UPDATE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[UnidadesAdministrativas_UPDATE]
	@Id  INT,
	@Codigo  VARCHAR(50),
	@NombreCorto VARCHAR(50),
	@Descripcion  VARCHAR(250),
	@Titular  VARCHAR(50) WITH ENCRYPTION
AS
UPDATE UnidadesAdministrativas
	SET 
		Codigo = @Codigo,
		NombreCorto = @NombreCorto,
		Descripcion = @Descripcion,
		Titular = @Titular
	WHERE
		UnidadesAdministrativas.idUnidadAdministrativa = @Id		
RETURN

GO
/****** Object:  StoredProcedure [dbo].[UnidadesAdministrativasDeUnUsuarioReal]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UnidadesAdministrativasDeUnUsuarioReal]
(
	@IdParameter AS INT
) WITH ENCRYPTION
AS
BEGIN
	SELECT *, 0 as SiempreCero 
	FROM UnidadesAdministrativas ua
		JOIN UsuariosRealesUnidadesAdministrativasRelaciones uruar
		ON ua.idUnidadAdministrativa = uruar.idUnidadAdministrativa
	WHERE 
		uruar.idUsuarioReal = @IdParameter
END
GO
/****** Object:  StoredProcedure [dbo].[UnidadesAdministrativasRelaciones_DELETE_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UnidadesAdministrativasRelaciones_DELETE_ALL]

@idClasificacion			integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE UnidadesAdministrativasRelaciones
	WHERE idClasificacion = @idClasificacion

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[UnidadesAdministrativasRelaciones_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UnidadesAdministrativasRelaciones_INSERT]

@idClasificacion			integer,
@idUnidadAdministrativa			integer,

@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	INSERT UnidadesAdministrativasRelaciones
	(
		idClasificacion,
		idUnidadAdministrativa
	)
	VALUES
	(
		@idClasificacion,
		@idUnidadAdministrativa
	)

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[UsuarioRealUnidadesAdministrativasRelaciones_DELETE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuarioRealUnidadesAdministrativasRelaciones_DELETE]
	@idUsuarioReal INT WITH ENCRYPTION

AS

	DELETE UsuariosRealesUnidadesAdministrativasRelaciones
	WHERE idUsuarioReal = @idUsuarioReal

RETURN
GO
/****** Object:  StoredProcedure [dbo].[UsuarioRealUnidadesAdministrativasRelaciones_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuarioRealUnidadesAdministrativasRelaciones_INSERT]
	@IdUsuarioReal INT,
	@IdUnidadAdministrativa INT WITH ENCRYPTION

AS

	INSERT UsuariosRealesUnidadesAdministrativasRelaciones 
		(IdUsuarioReal, IdUnidadAdministrativa)
		VALUES (@IdUsuarioReal, @IdUnidadAdministrativa)

RETURN
GO
/****** Object:  StoredProcedure [dbo].[UsuariosReales_DELETE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuariosReales_DELETE]
	@Id AS INT WITH ENCRYPTION
AS

DECLARE @Err AS INT
SELECT @Err = 0

BEGIN TRANSACTION

	DELETE UsuariosRealesUnidadesAdministrativasRelaciones
	WHERE
		IdUsuarioReal = @Id
	
	SELECT @Err = @@ERROR

	DELETE UsuariosReales
	WHERE
		UsuariosReales.idUsuarioReal = @Id		

	SELECT @Err = @Err + @@ERROR

IF @Err > 0
	ROLLBACK TRANSACTION
ELSE
	COMMIT TRANSACTION

RETURN


GO
/****** Object:  StoredProcedure [dbo].[UsuariosReales_FILTERED]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC UsuariosReales_FILTERED
-- DROP PROCEDURE UsuariosReales_FILTERED
ALTER PROCEDURE [dbo].[UsuariosReales_FILTERED]
(
	@CadenaABuscar NVARCHAR(250)
) WITH ENCRYPTION
AS
BEGIN
	DECLARE @SQLString NVARCHAR(MAX);

	SET @SQLString = '
		SELECT idUsuarioReal,
			idUsuarioVirtual,
			Login,
			Password,
			Nombre
		FROM UsuariosReales ur 
		WHERE ur.Nombre LIKE ''%' + @CadenaABuscar + '%'' 
			AND ur.idUsuarioReal <> -1 
		ORDER BY ur.Nombre';

	EXECUTE sp_executesql @SQLString;

END
GO
/****** Object:  StoredProcedure [dbo].[UsuariosReales_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuariosReales_INSERT]
	@Nombre AS VARCHAR(50),
	@Login AS VARCHAR(25),
	@Pwd AS VARCHAR(25),
	@IdUsuarioVirtual as INT,
	@Id AS INT OUTPUT
	 WITH ENCRYPTION
AS

SET NOCOUNT ON

INSERT
	INTO UsuariosReales
		(Nombre, Login, Clave, IdUsuarioVirtual)
	VALUES (@Nombre, @Login, @Pwd, @IdUsuarioVirtual)

SELECT
	@Id = MAX(idUsuarioReal)
	FROM UsuariosReales

RETURN
GO
/****** Object:  StoredProcedure [dbo].[UsuariosReales_SELECTALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuariosReales_SELECTALL] WITH ENCRYPTION
	
AS

SELECT * FROM UsuariosReales
WHERE idUsuarioReal <> -1

RETURN



GO
/****** Object:  StoredProcedure [dbo].[UsuariosReales_SELECTONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[UsuariosReales_SELECTONE]
	@Id AS INT WITH ENCRYPTION
AS
SELECT * FROM UsuariosReales
WHERE idUsuarioReal = @Id
RETURN


GO
/****** Object:  StoredProcedure [dbo].[UsuariosReales_UPDATE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[UsuariosReales_UPDATE]
	@Id AS INT,
	@Nombre AS VARCHAR(50),
	@Login AS VARCHAR(25),
	@Pwd AS VARCHAR(25),
	@IdUsuarioVirtual AS INT WITH ENCRYPTION

AS

UPDATE UsuariosReales
	SET 
		Nombre = @Nombre,
		Login = @Login,
		Clave = @Pwd,
		IdUsuarioVirtual = @IdUsuarioVirtual
	WHERE
		UsuariosReales.idUsuarioReal = @Id		

RETURN


GO
/****** Object:  StoredProcedure [dbo].[UsuariosVirtuales_DELETE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuariosVirtuales_DELETE]
	@Id AS INT WITH ENCRYPTION
AS

	DELETE UsuariosVirtuales
	WHERE
		UsuariosVirtuales.idUsuarioVirtual = @Id		

RETURN

GO
/****** Object:  StoredProcedure [dbo].[UsuariosVirtuales_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuariosVirtuales_INSERT]
	@Nombre AS VARCHAR(50),
	@Login AS VARCHAR(25),
	@Pwd AS VARCHAR(25),
	@Id AS INT OUTPUT WITH ENCRYPTION

AS

SET NOCOUNT ON

IF EXISTS (SELECT m.name AS login_name
		FROM master..syslogins m INNER JOIN sysusers s
  			ON m.sid = s.sid
		WHERE m.name = @Login)

	BEGIN
		INSERT
			INTO UsuariosVirtuales
				(Nombre, Login, Clave)
			VALUES (@Nombre, @Login, @Pwd)
		
		SELECT
			@Id = MAX(idUsuarioVirtual)
			FROM UsuariosVirtuales
	END
ELSE
	SELECT @Id = -1	
RETURN

GO
/****** Object:  StoredProcedure [dbo].[UsuariosVirtuales_SELECTALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuariosVirtuales_SELECTALL] WITH ENCRYPTION

AS

SELECT * FROM UsuariosVirtuales
WHERE idUsuarioVirtual <> -1

RETURN


GO
/****** Object:  StoredProcedure [dbo].[UsuariosVirtuales_SELECTONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuariosVirtuales_SELECTONE]
	@Id AS INT WITH ENCRYPTION
AS

SELECT * FROM UsuariosVirtuales
WHERE idUsuarioVirtual = @Id

RETURN
GO
/****** Object:  StoredProcedure [dbo].[UsuariosVirtuales_UPDATE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UsuariosVirtuales_UPDATE]
	@Id AS INT,
	@Nombre AS VARCHAR(50),
	@Login AS VARCHAR(25),
	@Pwd AS VARCHAR(25) WITH ENCRYPTION

AS

IF EXISTS (SELECT m.name AS login_name
		FROM master..syslogins m INNER JOIN sysusers s
  			ON m.sid = s.sid
		WHERE m.name = @Login)

	UPDATE UsuariosVirtuales
		SET 
			Nombre = @Nombre,
			Login = @Login,
			Clave = @Pwd
		WHERE
			UsuariosVirtuales.idUsuarioVirtual = @Id	

RETURN

/* select master..syslogins.name as login_name,
  sysusers.name as user_name
from master..syslogins inner join sysusers
  on master..syslogins.sid = sysusers.sid  */
GO
/****** Object:  StoredProcedure [dbo].[ValorDocumental_Expedientes_Relaciones_DELETE_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ValorDocumental_Expedientes_Relaciones_DELETE_ALL]

@idExpediente				integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE ValorDocumental_Expedientes_Relaciones
	WHERE idExpediente = @idExpediente

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END



GO
/****** Object:  StoredProcedure [dbo].[ValorDocumental_Expedientes_Relaciones_DELETE_ONE]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ValorDocumental_Expedientes_Relaciones_DELETE_ONE]

@idValorDocumental			integer,
@idExpediente				integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE ValorDocumental_Expedientes_Relaciones
	WHERE idExpediente = @idExpediente AND idValorDocumental = @idValorDocumental

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END




GO
/****** Object:  StoredProcedure [dbo].[ValorDocumental_Expedientes_Relaciones_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ValorDocumental_Expedientes_Relaciones_INSERT]

@idExpediente				integer,
@idValorDocumental			integer,

@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	INSERT ValorDocumental_Expedientes_Relaciones
	(
		idExpediente,
		idValorDocumental
	)
	VALUES
	(
		@idExpediente,
		@idValorDocumental
	)

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idExpediente
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END


GO
/****** Object:  StoredProcedure [dbo].[ValorDocumentalRelaciones_DELETE_ALL]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ValorDocumentalRelaciones_DELETE_ALL]

@idClasificacion			integer,
@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	DELETE ValorDocumentalRelaciones
	WHERE idClasificacion = @idClasificacion

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO
/****** Object:  StoredProcedure [dbo].[ValorDocumentalRelaciones_INSERT]    Script Date: 20/12/2022 09:59:32 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ValorDocumentalRelaciones_INSERT]

@idClasificacion			integer,
@idValorDocumental			integer,

@id_record_procesadoOK			integer = 0	output WITH ENCRYPTION

AS

DECLARE
	@err1 			int

SELECT
	@err1 = 0

	BEGIN TRAN

	INSERT ValorDocumentalRelaciones
	(
		idClasificacion,
		idValorDocumental
	)
	VALUES
	(
		@idClasificacion,
		@idValorDocumental
	)

	SET @err1 = @@error 
		
	IF @err1 = 0
		BEGIN
			COMMIT TRAN
			/* Devuelvo el nuevo id como resultado */
			SELECT @id_record_procesadoOK = @idClasificacion
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			/* Devuelvo 0 para señalar que hubo error */
			select @id_record_procesadoOK = 0
		END

GO

/****** Object:  StoredProcedure [dbo].[LeeMemoStatusVigente]    Script Date: 20/12/2022 10:58:29 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LeeMemoStatusVigente] WITH ENCRYPTION
AS
BEGIN
	SELECT MemoStatusVigenteField FROM MemoStatusVigente
END


/****** Object:  StoredProcedure [dbo].[Get_First_Expediente]    Script Date: 20/12/2022 11:00:44 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Get_First_Expediente]

@idFirstExpediente	integer		output WITH ENCRYPTION

AS

--SET @idFirstExpediente = ISNULL((SELECT e.idExpediente FROM Expedientes e WHERE e.NextLeft = 0),-1)

GO

/****** Object:  StoredProcedure [dbo].[SelVencEnTramite_New]    Script Date: 20/12/2022 11:03:12 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[SelVencEnTramite_New]
	@idUnidAdm	integer,
	@FechaDeCorte	DATETIME WITH ENCRYPTION
AS
BEGIN

SELECT 
	Unidad = (SELECT u.Descripcion
		FROM UnidadesAdministrativas u
		WHERE e.idUnidadAdministrativa = u.idUnidadAdministrativa),
	Procedencia = e.RelacionAnterior,
	Seccion = UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 1)),
	Serie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 2))
		END,
	Subserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 3))
		END,
	Subsubserie =
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 4))
		END,
	Subsubsubserie = 
		CASE 
			WHEN (SELECT UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))) = (SELECT UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion))) THEN ''''
			ELSE UPPER(dbo.fnNombreDeJerarquiaPorNivel(e.idClasificacion, 5))
		END,
	Codigo = UPPER(dbo.fnNombreDeJerarquiaMaxima(e.idClasificacion)),
	ValorPrimario =
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 1)
				= 1 THEN 'A'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 2)
				= 1 THEN 'C'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 3)
				= 1 THEN 'L'
			ELSE ' '
		END
		+
		CASE
			WHEN 
				(SELECT COUNT(*)
				FROM ValorDocumental_Expedientes_Relaciones v
				WHERE v.idExpediente = e.idExpediente
					AND v.idValorDocumental = 4)
				= 1 THEN 'H'
			ELSE ' '
		END,
	VigenciaDocumental =
		(SELECT UPPER(c.Descripcion)
			FROM PlazosDeConservacionConcentracion c
			WHERE e.idPlazoConcentracion = c.idPlazosDeConservacionConcentracion), 
	Expediente = e.Nombre,
	FechaApertura = CONVERT(VARCHAR(10), e.FechaApertura, 3), 
	FechaCierre = CONVERT(VARCHAR(10), e.FechaCierre , 3),
	e.Asunto,
	e.CajaAnterior,
	UbicacionAnterior = e.RelacionAnterior,
	CajaNueva = e.Caja,
	FechaDeCorte =  CONVERT(VARCHAR(10), @FechaDeCorte , 3),
	PlazoTramite = c.Descripcion,
	PlazoConcentracion = '', --Campo agregado por compatibilidad con el TTX
	CajaProv = ''  		--Campo agregado por compatibilidad con el TTX
FROM
	Expedientes e
		JOIN PlazosDeConservacionTramite c
		ON e.idPlazoTramite = c.idPlazosDeConservacionTramite
WHERE
	e.FechaCierreChecked = 1
	AND e.idUnidadAdministrativa = @idUnidAdm
	AND DATEDIFF(DAY, e.FechaCierre, @FechaDeCorte) >= c.Dias
	AND (e.idEstatusExpediente = 1 OR e.idEstatusExpediente = 2)
	AND e.idExpediente NOT IN (SELECT idExpediente 
					FROM Batches_Relaciones br 
					JOIN Batches b 
					ON br.idBatch = br.idBatch 
					WHERE b.idTipoDeBatch = 1 AND b.idUnidAdm = @idUnidAdm)
ORDER BY dbo.fnNombreDeJerarquia(e.idClasificacion), e.nombre, e.FechaCierre

END




GO


