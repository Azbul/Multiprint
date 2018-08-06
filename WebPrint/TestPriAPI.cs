using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Xps.Packaging;
using GemBox.Document;
using Microsoft.Win32;

namespace WebPrint
{
    public class TestPriAPI //перенести в службу, сделать интерфейсы
    {
        private DocumentModel document;

        public TestPriAPI()
            {
                ComponentInfo.SetLicense("FREE-LIMITED-KEY");
                ComponentInfo.FreeLimitReached += (s1, e1) => e1.FreeLimitReachedAction = FreeLimitReachedAction.ContinueAsTrial;
            }



    public void SetDoc(string docName)
        {

            //fileDialog.Filter = "DOCX files (*.docx, *.docm, *.dotm, *.dotx)|*.docx;*.docm;*.dotm;*.dotx|DOC files (*.doc, *.dot)|*.doc;*.dot|PDF files (*.pdf)|*.pdf|HTML files (*.html, *.htm)|*.html;*.htm|RTF files (*.rtf)|*.rtf|TXT files (*.txt)|*.txt";

            this.document = DocumentModel.Load(docName);

                /*this.ShowPrintPreview();
                this.EnableControls();*/
           
        }

        public string PrintAll()
        {
            // Print to default printer using default options
            try
            {
                return this.document.FileName;
            }

            catch (Exception ex)
            {
                return "Empty or NRE";
            }
        }

        public void PrintFromTo()
        {
            // We can use PrintDialog for defining print options
            PrintDialog printDialog = new PrintDialog();
            printDialog.UserPageRangeEnabled = true;
            //if correct page label
                PrintOptions printOptions = new PrintOptions();
                printOptions.FromPage = 1; //2  //test
                printOptions.ToPage = 2; //3

                this.document.Print(printDialog.PrintQueue.FullName, printOptions); //test
            
        }

        // We can use DocumentViewer for print preview (but we don't need).
        /*private void ShowPrintPreview()
        {
            // XpsDocument needs to stay referenced so that DocumentViewer can access additional required resources.
            // Otherwise, GC will collect/dispose XpsDocument and DocumentViewer will not work.
            XpsDocument xpsDocument = document.ConvertToXpsDocument(SaveOptions.XpsDefault);
            this.DocViewer.Tag = xpsDocument;

            this.DocViewer.Document = xpsDocument.GetFixedDocumentSequence();
        }

        private void EnableControls()
        {
            bool isEnabled = this.document != null;

            this.DocViewer.IsEnabled = isEnabled;
            this.SimplePrintFileBtn.IsEnabled = isEnabled;
            this.AdvancedPrintFileBtn.IsEnabled = isEnabled;
        }*/
    }
}