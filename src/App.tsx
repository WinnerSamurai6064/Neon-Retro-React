import { ArrowLeft, ArrowRight, Bell, BookOpen, Bookmark, Download, Home, Menu, RefreshCw, Search, Settings, Shield, Star, X } from 'lucide-react';
import './styles.css';

const quickActions = [
  { label: 'New Tab', icon: Star },
  { label: 'Bookmarks', icon: Bookmark },
  { label: 'History', icon: BookOpen },
  { label: 'Downloads', icon: Download },
];

const privacyControls = [
  'Fingerprint masking',
  'Block third-party cookies',
  'Ask before location access',
  'Use simulated location',
  'Clear cache on exit',
  'Clear cookies on exit',
];

function App() {
  return (
    <main className="app-shell">
      <section className="phone-frame">
        <header className="top-bar">
          <button className="icon-button"><Star size={22} /></button>
          <div className="address-bar">
            <Shield size={18} />
            <span>https://start.neonretro.local</span>
            <RefreshCw size={18} />
          </div>
          <button className="icon-button"><Menu size={24} /></button>
        </header>

        <section className="browser-area">
          <div className="welcome-card">
            <div className="brand-mark">NR</div>
            <p className="eyebrow">TEKDEV</p>
            <h1>Neon Retro</h1>
            <p className="subtitle">a browser</p>
            <p className="intro">
              Browse with tabs, downloads, bookmarks, notifications and practical privacy controls built into the experience.
            </p>
            <div className="search-card">
              <Search size={18} />
              <span>Search or enter address</span>
            </div>
          </div>

          <aside className="menu-panel">
            <div className="menu-head">
              <div>
                <strong>Neon Retro</strong>
                <span>a browser</span>
              </div>
              <X size={22} />
            </div>

            <div className="menu-list">
              {quickActions.map((item) => {
                const Icon = item.icon;
                return (
                  <button className="menu-row" key={item.label}>
                    <Icon size={24} />
                    <span>{item.label}</span>
                    <ArrowRight size={18} />
                  </button>
                );
              })}
            </div>

            <div className="settings-block">
              <p>Browser controls</p>
              {privacyControls.map((item, index) => (
                <label className="switch-row" key={item}>
                  <span>{item}</span>
                  <input type="checkbox" defaultChecked={index < 2} />
                </label>
              ))}
            </div>

            <button className="settings-link"><Settings size={22} /> Settings</button>
          </aside>
        </section>

        <nav className="bottom-nav">
          <button><ArrowLeft /></button>
          <button><ArrowRight /></button>
          <button className="active"><Home /></button>
          <button><Bookmark /></button>
          <button><Bell /></button>
        </nav>
      </section>
    </main>
  );
}

export default App;
