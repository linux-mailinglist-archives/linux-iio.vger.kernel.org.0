Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D05AB032
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 03:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfIFBfb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 21:35:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:2834 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbfIFBfb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 21:35:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 18:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="p7s'?scan'208";a="174129600"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga007.jf.intel.com with ESMTP; 05 Sep 2019 18:35:30 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Sep 2019 18:35:30 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.172]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.240]) with mapi id 14.03.0439.000;
 Thu, 5 Sep 2019 18:35:29 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     lkp <lkp@intel.com>
Subject: Re: [PATCH v1] iio: hid-sensor-attributes: Fix divisions for 32-bit
 platforms
Thread-Topic: [PATCH v1] iio: hid-sensor-attributes: Fix divisions for
 32-bit platforms
Thread-Index: AQHVY9z8BYaM6LxmFUqvXsidmi4c36ceVFgA
Date:   Fri, 6 Sep 2019 01:35:29 +0000
Message-ID: <6851830d050ddb2f27d1e6969755ee4f3293d37c.camel@intel.com>
References: <20190905112759.13035-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190905112759.13035-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.22.142]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-RJFWODRUHXbNnywHe96/"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-RJFWODRUHXbNnywHe96/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-05 at 14:27 +0300, Andy Shevchenko wrote:
> The commit 473d12f7638c
>=20
>   ("iio: hid-sensor-attributes: Convert to use int_pow()")
>=20
> converted to use generic int_pow() helper. Though, the generic one
> returns
> 64-bit value and, in cases when it is used as divisor, it compels 64-
> bit
> division from compiler.
>=20
> In order to fix this, introduce a temporary 32-bit variable to hold
> the result
> of int_pow() and use it as divisor afterwards.
>=20
> In couple of cases, replace int_pow() with a predefined unit factors
> for time
> and frequency.
>=20
> Fixes: 473d12f7638c ("iio: hid-sensor-attributes: Convert to use
> int_pow()")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  .../hid-sensors/hid-sensor-attributes.c       | 42 ++++++++++++-----
> --
>  1 file changed, 28 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index b9dd19b34267..442ff787f7af 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -10,10 +10,14 @@
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> +#include <linux/time.h>
> +
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> =20
> +#define HZ_PER_MHZ	1000000L
> +
>  static struct {
>  	u32 usage_id;
>  	int unit; /* 0 for default others from HID sensor spec */
> @@ -93,8 +97,10 @@ static void simple_div(int dividend, int divisor,
> int *whole,
> =20
>  static void split_micro_fraction(unsigned int no, int exp, int
> *val1, int *val2)
>  {
> -	*val1 =3D no / int_pow(10, exp);
> -	*val2 =3D no % int_pow(10, exp) * int_pow(10, 6 - exp);
> +	int divisor =3D int_pow(10, exp);
> +
> +	*val1 =3D no / divisor;
> +	*val2 =3D no % divisor * int_pow(10, 6 - exp);
>  }
> =20
>  /*
> @@ -129,6 +135,7 @@ static void convert_from_vtf_format(u32 value,
> int size, int exp,
> =20
>  static u32 convert_to_vtf_format(int size, int exp, int val1, int
> val2)
>  {
> +	int divisor;
>  	u32 value;
>  	int sign =3D 1;
> =20
> @@ -136,10 +143,13 @@ static u32 convert_to_vtf_format(int size, int
> exp, int val1, int val2)
>  		sign =3D -1;
>  	exp =3D hid_sensor_convert_exponent(exp);
>  	if (exp < 0) {
> +		divisor =3D int_pow(10, 6 + exp);
>  		value =3D abs(val1) * int_pow(10, -exp);
> -		value +=3D abs(val2) / int_pow(10, 6 + exp);
> -	} else
> -		value =3D abs(val1) / int_pow(10, exp);
> +		value +=3D abs(val2) / divisor;
> +	} else {
> +		divisor =3D int_pow(10, exp);
> +		value =3D abs(val1) / divisor;
> +	}
>  	if (sign < 0)
>  		value =3D  ((1LL << (size * 8)) - value);
> =20
> @@ -202,12 +212,12 @@ int hid_sensor_write_samp_freq_value(struct
> hid_sensor_common *st,
>  	if (val1 < 0 || val2 < 0)
>  		return -EINVAL;
> =20
> -	value =3D val1 * int_pow(10, 6) + val2;
> +	value =3D val1 * HZ_PER_MHZ + val2;
>  	if (value) {
>  		if (st->poll.units =3D=3D
> HID_USAGE_SENSOR_UNITS_MILLISECOND)
> -			value =3D int_pow(10, 9) / value;
> +			value =3D NSEC_PER_SEC / value;
>  		else if (st->poll.units =3D=3D
> HID_USAGE_SENSOR_UNITS_SECOND)
> -			value =3D int_pow(10, 6) / value;
> +			value =3D USEC_PER_SEC / value;
>  		else
>  			value =3D 0;
>  	}
> @@ -296,6 +306,7 @@ EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);
>  static void adjust_exponent_nano(int *val0, int *val1, int scale0,
>  				  int scale1, int exp)
>  {
> +	int divisor;
>  	int i;
>  	int x;
>  	int res;
> @@ -309,9 +320,10 @@ static void adjust_exponent_nano(int *val0, int
> *val1, int scale0,
>  			return;
>  		}
>  		for (i =3D 0; i < exp; ++i) {
> -			x =3D scale1 / int_pow(10, 8 - i);
> +			divisor =3D int_pow(10, 8 - i);
> +			x =3D scale1 / divisor;
>  			res +=3D int_pow(10, exp - 1 - i) * x;
> -			scale1 =3D scale1 % int_pow(10, 8 - i);
> +			scale1 =3D scale1 % divisor;
>  		}
>  		*val0 +=3D res;
>  		*val1 =3D scale1 * int_pow(10, exp);
> @@ -321,13 +333,15 @@ static void adjust_exponent_nano(int *val0, int
> *val1, int scale0,
>  			*val0 =3D *val1 =3D 0;
>  			return;
>  		}
> -		*val0 =3D scale0 / int_pow(10, exp);
> -		rem =3D scale0 % int_pow(10, exp);
> +		divisor =3D int_pow(10, exp);
> +		*val0 =3D scale0 / divisor;
> +		rem =3D scale0 % divisor;
>  		res =3D 0;
>  		for (i =3D 0; i < (9 - exp); ++i) {
> -			x =3D scale1 / int_pow(10, 8 - i);
> +			divisor =3D int_pow(10, 8 - i);
> +			x =3D scale1 / divisor;
>  			res +=3D int_pow(10, 8 - exp - i) * x;
> -			scale1 =3D scale1 % int_pow(10, 8 - i);
> +			scale1 =3D scale1 % divisor;
>  		}
>  		*val1 =3D rem * int_pow(10, 9 - exp) + res;
>  	} else {

--=-RJFWODRUHXbNnywHe96/
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
n4IJlKBiiK7B8oFPhD7KEZOWboHrE2uHLEkIXpp852sG0oFkLLstEDK9Z46WS4Ni1yfGRE6jY79A
DJOEZIX9AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUZ2w0kbL1uZEoQTmAiMqoAXL81L8wHwYDVR0j
BBgwFoAU2kEjnFqPca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEIuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzAiBggrBgEFBQcwAYYWaHR0cDovL29j
c3AuaW50ZWwuY29tLzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9y
eS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIw
NEIuY3J0MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQAXirNmyawI/PJRnjPoqNcgSr8N
8VXBvv8kwQidSNWKswBqo8ul8u+pkG7v8YjZUy1OJQUFXPvihht10Tb5O2xZ9hpIo4WFcRX2eg2Z
t6koRJUB9ZDjEETG2j4EpcGmWIBrDBNZLZTLIYG5JzsS6mGCq42AKspSAJD00vwfL0KlCc4BVUvC
64+q7etbf6c90n05KjfLfoUXBqwWLJCe3KPD20d/kbvesTzs2PVQxI7K1eL9n2rBoqBpcRY0ppkz
FKjiTQ8IcwhyWQbzLfVIy5tNuyinhNBRv3COOMGoayaljijEPcEHLE63tA2OIao2Hz6GLRYzg0mT
hCtsB4xSboPZMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEICEzMAAGknngjvas7THxUAAAAAaScwCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDkw
NjAxMzUyOFowIwYJKoZIhvcNAQkEMRYEFEnCXfx1pZoMkobj31DccGzX5e7KMA0GCSqGSIb3DQEB
AQUABIIBAFR2UHI0VmrORC+0wV6R1LAEd5+UWh9CP3pYGUigyNcmyDUrNwXtRM7HW26IXB+c1eUl
b11AlNTl+IbgEdrfkiZb827uMVc0EIUsq/l8WJp7rKWU/kJu9ZeKf5uMAfJdabRah8Zd+K8+T5Kg
aS+Jd/xonThPra6aU/2OoRLvZarCuVT3Xkc0wP0Cu0NmLrZolr2H14kQq9g1ZL6ZD2L591Uf61fu
Rk4qg7Id8szpE+Z/ANAGUEkMVFabRAQMoZNADJP29GCVpB7S7NamnWDQP6JER0pQ4gH3SlBUh3Tf
xBgPra0xvEmHSlH1M5Rlf67l0wweMBjKDFdOU0biIklsTMgAAAAAAAA=


--=-RJFWODRUHXbNnywHe96/--
