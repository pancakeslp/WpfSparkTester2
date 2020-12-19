using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace WpfSparkTester2
{
    public class ViewModel : INotifyPropertyChanged
    {
        #region INotifyPropertyChanged

        public event PropertyChangedEventHandler PropertyChanged;

        public void Set<T>(ref T storage, T value, [CallerMemberName] string propertyName = null)
        {
            if (!Equals(storage, value))
            {
                storage = value;
                RaisePropertyChanged(propertyName);
            }
        }

        public void RaisePropertyChanged([CallerMemberName] string propertyName = null) =>
           PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));

        #endregion


        bool _checked = default(bool);
        public bool Checked { get { return _checked; } set { Set(ref _checked, value); } }
    }
}
