import React, { useState } from 'react';
import { Document, Page, pdfjs } from 'react-pdf';
import 'react-pdf/dist/Page/AnnotationLayer.css';
import 'react-pdf/dist/Page/TextLayer.css';
import Button from '../common/Button';
import Spinner from '../common/Spinner';

// PDF.js worker'ının konumunu belirtiyoruz. Bu, kütüphanenin doğru çalışması için gerekli.
// Kütüphanenin kendi CDN'ini kullanmak en kolay yoldur.
pdfjs.GlobalWorkerOptions.workerSrc = `//unpkg.com/pdfjs-dist@${pdfjs.version}/build/pdf.worker.min.js`;

/**
 * PDF dosyalarını indirmeye izin vermeden tarayıcı içinde gösteren bileşen.
 * @param {object} props - Bileşenin aldığı proplar.
 * @param {string} props.fileUrl - Görüntülenecek PDF dosyasının URL'si.
 */
const PdfViewer = ({ fileUrl }) => {
  const [numPages, setNumPages] = useState(null);
  const [pageNumber, setPageNumber] = useState(1);

  function onDocumentLoadSuccess({ numPages }) {
    setNumPages(numPages);
    setPageNumber(1); // Yeni bir PDF yüklendiğinde ilk sayfaya git.
  }

  function changePage(offset) {
    setPageNumber(prevPageNumber => prevPageNumber + offset);
  }

  function previousPage() {
    if (pageNumber > 1) {
      changePage(-1);
    }
  }

  function nextPage() {
    if (pageNumber < numPages) {
      changePage(1);
    }
  }

  // Sağ tıklama menüsünü engelleyerek içeriğin korunmasına yardımcı oluyoruz.
  const handleContextMenu = (e) => {
    e.preventDefault();
  };

  return (
    <div className="pdf-viewer-container bg-gray-100 p-4 rounded-lg" onContextMenu={handleContextMenu}>
      <Document
        file={fileUrl}
        onLoadSuccess={onDocumentLoadSuccess}
        loading={<Spinner text="PDF Yükleniyor..." />}
        error={<p className="text-red-500">PDF yüklenirken bir hata oluştu.</p>}
      >
        <div className="pdf-page-wrapper overflow-auto border border-gray-300">
          <Page pageNumber={pageNumber} />
        </div>
      </Document>

      {numPages && (
        <div className="pagination-controls flex items-center justify-center mt-4 space-x-4">
          <Button onClick={previousPage} disabled={pageNumber <= 1}>
            Önceki Sayfa
          </Button>
          <p className="text-center font-semibold">
            Sayfa {pageNumber} / {numPages}
          </p>
          <Button onClick={nextPage} disabled={pageNumber >= numPages}>
            Sonraki Sayfa
          </Button>
        </div>
      )}
    </div>
  );
};

export default PdfViewer;
