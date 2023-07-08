using System;
using System.Text;
using System.Security.Cryptography;

namespace fsSimaServicios
{
    public class Encripcion
    {
        private readonly string _securityKey;

        public Encripcion(string securityKey)
        {
            _securityKey = securityKey;
        }

        public string Encripta(string toEncrypt)
        {
            return Encripta(toEncrypt, _securityKey);
        }

        public string Encripta(string toEncrypt, string securityKey)
        {
            byte[] keyArray;
            byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(toEncrypt);
            string key = _securityKey + securityKey;

            MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
            keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            hashmd5.Clear();

            TripleDESCryptoServiceProvider algoritmo = new TripleDESCryptoServiceProvider
            {
                //set the secret key for the tripleDES algorithm
                Key = keyArray,
                Mode = CipherMode.ECB,
                Padding = PaddingMode.PKCS7
            };

            ICryptoTransform cTransform = algoritmo.CreateEncryptor();
            //transform the specified region of bytes array to resultArray
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
            algoritmo.Clear();
            return Convert.ToBase64String(resultArray, 0, resultArray.Length);
        }

        public string Desencripta(string cipherString)
        {
            return Desencripta(cipherString, _securityKey);
        }

        public string Desencripta(string cipherString, string securityKey)
        {
            byte[] keyArray;

            byte[] toEncryptArray = Convert.FromBase64String(cipherString);
            string key = _securityKey + securityKey;

            MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
            keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));

            hashmd5.Clear();

            TripleDESCryptoServiceProvider algoritmo = new TripleDESCryptoServiceProvider
            {
                //set the secret key for the tripleDES algorithm
                Key = keyArray,
                Mode = CipherMode.ECB,
                Padding = PaddingMode.PKCS7
            };

            ICryptoTransform cTransform = algoritmo.CreateDecryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
            algoritmo.Clear();
            //return the Clear decrypted TEXT
            return UTF8Encoding.UTF8.GetString(resultArray);
        }
    }
}
