# disable binary stripping (saves ~30% of build time at no cost to rpm size)
%global __os_install_post %{nil}

Name:		    nitro-pyxis
Version:	  1
Release:    __BUILD_NUMBER__
Summary:	  Pyxis logging for Nitro
Group:		  Development/Tools
License:	  BBC Internal Only
URL:		    https://confluence.dev.bbc.co.uk/display/platform/Centralised+Logging+Service
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:	noarch
Source:     %{name}-%{version}-%{release}.tar.gz
Provides:	  nitro-pyxis

# disable RedHat Automatic Dependency Processing
AutoReqProv: no

Requires:   flume-ng-agent, flume-ng, java-1.7.0-openjdk, otg-analytics-flume-interceptors

%description
Pyxis logging for Nitro

%prep
%setup -cq

%build

%install
mkdir -p $RPM_BUILD_ROOT
cp -r * $RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644, root, root, 755)
%attr(644, root , root) /etc/flume-ng/conf/bbc-flume.conf
%attr(755, root , root) /etc/bake-scripts/nitro-pyxis/configure_logging

%pre

%post

%preun

%postun

%changelog

