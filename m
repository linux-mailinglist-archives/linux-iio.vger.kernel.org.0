Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660DF2697E
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2019 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfEVSEh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 May 2019 14:04:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:58562 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEVSEh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 May 2019 14:04:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 11:04:36 -0700
X-ExtLoop1: 1
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2019 11:04:35 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 22 May 2019 11:04:35 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.251]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.165]) with mapi id 14.03.0415.000;
 Wed, 22 May 2019 11:04:35 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "Song, Hongyan" <hongyan.song@intel.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Xu, Even" <even.xu@intel.com>
Subject: Re: [PATCH] hid: remove NO_D3 flag for ish not CHV platform
Thread-Topic: [PATCH] hid: remove NO_D3 flag for ish not CHV platform
Thread-Index: AQHVDI0GAhvu/aY6BkWQ/IXL1ZBgUKZ3cI2AgAB9TgA=
Date:   Wed, 22 May 2019 18:04:34 +0000
Message-ID: <497b1b7fe4fca84f1a2bf450db196950c1e98310.camel@intel.com>
References: <1558082782-29279-1-git-send-email-hongyan.song@intel.com>
         <nycvar.YFH.7.76.1905221235140.1962@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1905221235140.1962@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.192.124]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-TRjw2x1OutWDwf/DePsT"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-TRjw2x1OutWDwf/DePsT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-22 at 12:36 +0200, Jiri Kosina wrote:=20
> On Fri, 17 May 2019, hongyan.song@intel.com wrote:
>=20
> > From: Song Hongyan <hongyan.song@intel.com>
Also commit summary "hid: remove NO_D3 flag for non Cherry Trail (CHT)"


> >=20
> > NO_D3 flag is set for CHV and the older platforms, the other
> > platform
> > suppose can enter D3, if have this NO_D3 flag set it can never
> > enter D3
>=20
> Could you please provide a little bit more descriptive changelog --
> namely=20
> what observable problem is it fixing.


In addition, I don't think this is a rc2+ release fix.

Thanks,
Srinivas

>=20
> > Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> > ---
> >  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > index a6e1ee7..de1459b 100644
> > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > @@ -154,7 +154,9 @@ static int ish_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >  	/* mapping IO device memory */
> >  	hw->mem_addr =3D pcim_iomap_table(pdev)[0];
> >  	ishtp->pdev =3D pdev;
> > -	pdev->dev_flags |=3D PCI_DEV_FLAGS_NO_D3;
> > +	/*This NO_D3 flag is only for CHV and older platforms*/
>=20
> ... and while you're updating the changelog, please also stick a
> space=20
> before and after the comment mark.
>=20
> Thanks,
>=20

--=-TRjw2x1OutWDwf/DePsT
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
3SyI6+n6vMJgXVPqCZ+UUkqssxrHlBE2Wa5Z0MvLJIGB/Rwm/FA63bht6f4JWZH5uoRzW4SuyhsR
xVcjLhL3AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUqm34QzHPi1eNUuCtd75VDPG++SgwHwYDVR0j
BBgwFoAU2kEjnFqPca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEIuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzAiBggrBgEFBQcwAYYWaHR0cDovL29j
c3AuaW50ZWwuY29tLzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9y
eS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIw
NEIuY3J0MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQA7saUQRNb6+9biC882UTQMmxO9
6cbLa4/jipKD0mQvmUpZn/vcTTfQRKahKyW9mUFdbXvC7dVPvOF3LWTj1PK96TcnEssbWKVmJJ3t
gNjnoc8Yuj8AsOi5ErV+KXqJBddMyM7QLQprBlvSNLhZaT4OdT+561W4WVkBJf6hNPUwDn48+x/n
Cb/qTdIehTd+Oh1Rb3wyk2Ll268rRqO6/8cdi2NrrBfMX23wpl0MBCXCUMAD07Otx/bgoTJmLnZi
LNoR7WuA45dz6gNv6h4156p2qyZ8zmYWhjkR7fwBlUV10bFty4/PLghz2BIEH/QsHuY+QxSfFXCl
SsaBUrbEHklWMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEICEzMAAGlQPrQId7Ylrr4AAAAAaVAwCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDUy
MjE4MDQzMlowIwYJKoZIhvcNAQkEMRYEFOSai5k3Tx5D+9XahZ/Vj8Fbib/TMA0GCSqGSIb3DQEB
AQUABIIBAKS7y5bF2EB5ZdB4/g04T7/5TGgp57goNnVfrSxheMGRiU2rNPdcllVaib0HeP8FKDla
xZ6ba2xGhwZs0bRJD0UITgKufBAHzm9kMFR7eBW2RZpY0NOZaojBLRBZjM8hQ0vFie2XoDkL3b/U
7K6Hb21maRPBptJY2B8WY2pac+oWM1LooTwH//pICpv/yomYxQcJUVE7Rj0Ydq+9pITXs9MVvVnX
c5W919g1nWxyh1BNdYRDG7KYNtXXBxFHmnGhgM+IXXhfH8w5joJTnP3OG/I6i8W7dMLLasMUuj1C
y0dRdizjL8mdtMrNPL8xl+fahlBXZn6U0NilaRwe5fsYK34AAAAAAAA=


--=-TRjw2x1OutWDwf/DePsT--
