import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App.jsx';
import './styles.css';

class AppErrorBoundary extends React.Component {
  constructor(props) { super(props); this.state = { error: null }; }
  static getDerivedStateFromError(error) { return { error }; }
  componentDidCatch(error) { console.error('AutoPay Manager render error:', error); }
  render() {
    if (this.state.error) return <div style={{maxWidth:640,margin:'12vh auto',padding:24,fontFamily:'sans-serif',color:'#173d2b'}}>
      <h1>GBSBFORYOU AutoPay Manager</h1>
      <h2>ऐप लोड नहीं हो पाया</h2>
      <p>तकनीकी त्रुटि मिली है। कृपया इस पेज को Refresh करें।</p>
      <pre style={{whiteSpace:'pre-wrap',background:'#fff3f0',padding:12,borderRadius:8,color:'#8b3028'}}>{String(this.state.error?.message || this.state.error)}</pre>
      <button onClick={() => location.reload()} style={{padding:'10px 16px',border:0,borderRadius:8,background:'#1c5638',color:'white'}}>Refresh</button>
    </div>;
    return this.props.children;
  }
}
window.addEventListener('error', event => {
  console.error('AutoPay Manager global error:', event.error || event.message);
});
window.addEventListener('unhandledrejection', event => {
  console.error('AutoPay Manager promise error:', event.reason);
});
const root = createRoot(document.getElementById('root'));
root.render(<React.StrictMode><AppErrorBoundary><App /></AppErrorBoundary></React.StrictMode>);
