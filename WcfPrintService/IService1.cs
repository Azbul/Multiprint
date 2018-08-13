using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.IO;

namespace WcfPrintService
{
    // ПРИМЕЧАНИЕ. Команду "Переименовать" в меню "Рефакторинг" можно использовать для одновременного изменения имени интерфейса "IService1" в коде и файле конфигурации.
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        ReturnValue Upload(FiledMetadata metadata);

        [OperationContract]
        void InitializePrintersToDb();

        [OperationContract]
        List<Printer> GetPrintersFromDb();

        [OperationContract]
        void SetQueueDataToDb(Pqueue pqueue);

        [OperationContract]
        List<Pqueue> GetPqueuesFromDb();

        [OperationContract]
        void Print(string fileOrPath, string printerName, string pages);     
    }

    [MessageContract]
    public class FiledMetadata
    {
        [MessageHeader(MustUnderstand =true)]
        public string FileName { get; set; }

        [MessageBodyMember(Order =1)]
        public Stream Stream { get; set; }

    }

    [MessageContract]
    public class ReturnValue
    {
        [MessageBodyMember]
        public bool UploadSucceed { get; set; }
    }

}