Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1092D43F
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2019 05:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfE2D1t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 May 2019 23:27:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:31676 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfE2D1t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 May 2019 23:27:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 20:27:48 -0700
X-ExtLoop1: 1
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2019 20:27:47 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 28 May 2019 20:27:47 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.251]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.165]) with mapi id 14.03.0415.000;
 Tue, 28 May 2019 20:27:46 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "jikos@kernel.org" <jikos@kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Xu, Even" <even.xu@intel.com>
Subject: Re: [PATCH] hid: remove NO_D3 flag for ish not CHV platform
Thread-Topic: [PATCH] hid: remove NO_D3 flag for ish not CHV platform
Thread-Index: AQHVDI0GAhvu/aY6BkWQ/IXL1ZBgUKZ3cI2AgAB9TgCAAo9pAIAHe/IA
Date:   Wed, 29 May 2019 03:27:46 +0000
Message-ID: <db5a3a3828c8be89b52ebfe4ebf5b863a8d87f03.camel@intel.com>
References: <1558082782-29279-1-git-send-email-hongyan.song@intel.com>
         <nycvar.YFH.7.76.1905221235140.1962@cbobk.fhfr.pm>
         <497b1b7fe4fca84f1a2bf450db196950c1e98310.camel@intel.com>
         <nycvar.YFH.7.76.1905241109390.1962@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1905241109390.1962@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.31]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-r/EMjY63fRpBqa30xOkC"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-r/EMjY63fRpBqa30xOkC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-05-24 at 11:10 +0200, Jiri Kosina wrote:
> On Wed, 22 May 2019, Pandruvada, Srinivas wrote:
>=20
> > > > From: Song Hongyan <hongyan.song@intel.com>
> >=20
> > Also commit summary "hid: remove NO_D3 flag for non Cherry Trail
> > (CHT)"
> >=20
> > > >=20
> > > > NO_D3 flag is set for CHV and the older platforms, the other
> > > > platform
> > > > suppose can enter D3, if have this NO_D3 flag set it can never
> > > > enter D3
> > >=20
> > > Could you please provide a little bit more descriptive changelog
> > > --
> > > namely=20
> > > what observable problem is it fixing.
> >=20
> >=20
> > In addition, I don't think this is a rc2+ release fix.
>=20
> Thanks Srinivas. Could you please Ack v2 so that I could queue it?
I want some more information in the commit and test information. So
Song will submit v3.

Thanks,
Srinivas


>=20

--=-r/EMjY63fRpBqa30xOkC
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
zFtUc0whb39jT7klbqWD26anBZ8LZsRmaU2FylSgaQm5IMl6ILV2cDVhBitGeKIwNYMqpcLejOnr
Zbrn3/QvAgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUBdulS2EQ0eFtMXDEFoVPVLcb8dwwHwYDVR0j
BBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3
dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJh
c2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRl
bC5jb20vMAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQC3BC7joH3dX6x9O8HsMgJ8DgZp
OnY6eG3DVzJSonWr++Pv4CRQ6wh+J7bH3hTBq+tb2xbe2ZAfudqX/gezisOufHOKm0gs1UGBxFdj
snEt87sD096N34r2lE1tUDyPARQNKangT4IFJ273PSYg2zlbbJYoWeOq76SS3SfcH58FsAO5d70d
cCAW38N1mc+LWHBnEEN3dfFrNQgZSiqZ8jenu/a3FhqbhIMZbwa/Zlnuz8LPUIrjiEblAhmab3m4
B+Dg1xocVmrPOrLbjxwULJldJEDvhwXzEeFCdTPp2/0O28Jmi0Upxb3QBfhczCcZ95/H6X6gQdfW
89/DPXl9Dl4IMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMcBCehwTtyBUDoAAAAAxwEwCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDUy
OTAzMjc0NlowIwYJKoZIhvcNAQkEMRYEFEBhsRkYU9rY9+5h13dVtZY1hEDLMA0GCSqGSIb3DQEB
AQUABIIBAIX9h4Y+H16YfYnNTQfN/7/H7USa3rOBVKfs8cR2PS0agzoOqoMkvic/mkyeCHmpkz3F
DMKVhqeBFCFn4dS0ffxGPK4AIQ6iUmmtPCOPT8BoGhpybQH4uOTnmHGVwbPE0X8WvpFR5zlcehSp
SQsK7unK2yZuAJY9KL9VEda3QpEyb+sCEp30Led3T4Zseut7164SQ8dsT+DEbkJVgK0QoQUbiaAm
yKiGpqsVjOEoAzBMj1PnzsaLK/LrYgV7MHw6BjGh4gIV+xCtlEmp7cYszMXvJ+WDewIlu7IOiDzA
bd2R7TJSs16dyOC10gaJLseRTNNmtuErg8O1U4ph6Zn9Fn4AAAAAAAA=


--=-r/EMjY63fRpBqa30xOkC--
