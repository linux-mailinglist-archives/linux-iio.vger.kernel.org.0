Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5440791B1A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2019 04:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHSCsD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 22:48:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:43687 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfHSCsD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 22:48:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 19:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="p7s'?scan'208";a="171990416"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2019 19:48:02 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.25]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.11]) with mapi id 14.03.0439.000;
 Sun, 18 Aug 2019 19:48:02 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1] iio: hid-sensor-attributes: Convert to use int_pow()
Thread-Topic: [PATCH v1] iio: hid-sensor-attributes: Convert to use int_pow()
Thread-Index: AQHVVfo8teZHxu+3xUKxT1OizwI6QKcCOmsA
Date:   Mon, 19 Aug 2019 02:48:01 +0000
Message-ID: <238b32cb5fbd3482f74b8bf64ee34e7536f7afd9.camel@intel.com>
References: <20190619140702.18506-1-andriy.shevchenko@linux.intel.com>
         <20190622100642.7a8fb0ff@archlinux>
         <20190813144315.GH30120@smile.fi.intel.com>
         <20190818202206.63a5663f@archlinux>
In-Reply-To: <20190818202206.63a5663f@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.197.211]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-tksnzeGYbZyy6qPjf3TY"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-tksnzeGYbZyy6qPjf3TY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-08-18 at 20:22 +0100, Jonathan Cameron wrote:
> On Tue, 13 Aug 2019 17:43:15 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > On Sat, Jun 22, 2019 at 10:06:42AM +0100, Jonathan Cameron wrote:
> > > On Wed, 19 Jun 2019 17:07:02 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >  =20
> > > > Instead of linear approach to calculate power of 10, use
> > > > generic int_pow()
> > > > which does it better.
> > > >  */
> > > > u64 int_pow(u64 base, unsigned int exp)
> > > > {
> > > > 	u64 result =3D 1;
> > > >=20
> > > > 	while (exp) {
> > > > 		if (exp & 1)
> > > > 			result *=3D base;
> > > > 		exp >>=3D 1;
> > > > 		base *=3D base;
> > > > 	}
> > > >=20
> > > > 	return result;
> > > > }
> > > > Signed-off-by: Andy Shevchenko <
> > > > andriy.shevchenko@linux.intel.com> =20
> > >=20

Hi Jonathan,

> > > Hi Andy,
> > >=20
> > > Looks good to me, but I would like Srinivas to take a look and
> > > preferably test this a bit just to check we aren't all missing
> > > something
> > > subtle!
> > >=20
> > > +CC Srinivas =20
> >=20
> > Srinivas, do you have any comments on this?
>=20
> I think Srinivas got dropped from your CC list for some reason.
>=20
> Anyhow, it's been a while so let's conclude Srinivas is busy and
> rely on it being as obviously correct as it seems to be ;)
Looks correct to me.
I will be LPC, so hope to see you if you are there.

Thanks,
Srinivas

>=20
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan =20
> > > > ---
> > > >  .../hid-sensors/hid-sensor-attributes.c       | 53 ++++++++---
> > > > --------
> > > >  1 file changed, 22 insertions(+), 31 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> > > > attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-
> > > > attributes.c
> > > > index a8a3fe428d8d..b9dd19b34267 100644
> > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > > @@ -8,6 +8,7 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/interrupt.h>
> > > >  #include <linux/irq.h>
> > > > +#include <linux/kernel.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/hid-sensor-hub.h>
> > > >  #include <linux/iio/iio.h>
> > > > @@ -68,16 +69,6 @@ static struct {
> > > >  	{HID_USAGE_SENSOR_HUMIDITY, 0, 1000, 0},
> > > >  };
> > > > =20
> > > > -static int pow_10(unsigned power)
> > > > -{
> > > > -	int i;
> > > > -	int ret =3D 1;
> > > > -	for (i =3D 0; i < power; ++i)
> > > > -		ret =3D ret * 10;
> > > > -
> > > > -	return ret;
> > > > -}
> > > > -
> > > >  static void simple_div(int dividend, int divisor, int *whole,
> > > >  				int *micro_frac)
> > > >  {
> > > > @@ -96,14 +87,14 @@ static void simple_div(int dividend, int
> > > > divisor, int *whole,
> > > >  			rem *=3D 10;
> > > >  			exp++;
> > > >  		}
> > > > -		*micro_frac =3D (rem / divisor) * pow_10(6-exp);
> > > > +		*micro_frac =3D (rem / divisor) * int_pow(10, 6 -
> > > > exp);
> > > >  	}
> > > >  }
> > > > =20
> > > >  static void split_micro_fraction(unsigned int no, int exp, int
> > > > *val1, int *val2)
> > > >  {
> > > > -	*val1 =3D no/pow_10(exp);
> > > > -	*val2 =3D no%pow_10(exp) * pow_10(6-exp);
> > > > +	*val1 =3D no / int_pow(10, exp);
> > > > +	*val2 =3D no % int_pow(10, exp) * int_pow(10, 6 - exp);
> > > >  }
> > > > =20
> > > >  /*
> > > > @@ -125,7 +116,7 @@ static void convert_from_vtf_format(u32
> > > > value, int size, int exp,
> > > >  	}
> > > >  	exp =3D hid_sensor_convert_exponent(exp);
> > > >  	if (exp >=3D 0) {
> > > > -		*val1 =3D sign * value * pow_10(exp);
> > > > +		*val1 =3D sign * value * int_pow(10, exp);
> > > >  		*val2 =3D 0;
> > > >  	} else {
> > > >  		split_micro_fraction(value, -exp, val1, val2);
> > > > @@ -145,10 +136,10 @@ static u32 convert_to_vtf_format(int
> > > > size, int exp, int val1, int val2)
> > > >  		sign =3D -1;
> > > >  	exp =3D hid_sensor_convert_exponent(exp);
> > > >  	if (exp < 0) {
> > > > -		value =3D abs(val1) * pow_10(-exp);
> > > > -		value +=3D abs(val2) / pow_10(6+exp);
> > > > +		value =3D abs(val1) * int_pow(10, -exp);
> > > > +		value +=3D abs(val2) / int_pow(10, 6 + exp);
> > > >  	} else
> > > > -		value =3D abs(val1) / pow_10(exp);
> > > > +		value =3D abs(val1) / int_pow(10, exp);
> > > >  	if (sign < 0)
> > > >  		value =3D  ((1LL << (size * 8)) - value);
> > > > =20
> > > > @@ -211,12 +202,12 @@ int
> > > > hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
> > > >  	if (val1 < 0 || val2 < 0)
> > > >  		return -EINVAL;
> > > > =20
> > > > -	value =3D val1 * pow_10(6) + val2;
> > > > +	value =3D val1 * int_pow(10, 6) + val2;
> > > >  	if (value) {
> > > >  		if (st->poll.units =3D=3D
> > > > HID_USAGE_SENSOR_UNITS_MILLISECOND)
> > > > -			value =3D pow_10(9)/value;
> > > > +			value =3D int_pow(10, 9) / value;
> > > >  		else if (st->poll.units =3D=3D
> > > > HID_USAGE_SENSOR_UNITS_SECOND)
> > > > -			value =3D pow_10(6)/value;
> > > > +			value =3D int_pow(10, 6) / value;
> > > >  		else
> > > >  			value =3D 0;
> > > >  	}
> > > > @@ -311,34 +302,34 @@ static void adjust_exponent_nano(int
> > > > *val0, int *val1, int scale0,
> > > >  	int rem;
> > > > =20
> > > >  	if (exp > 0) {
> > > > -		*val0 =3D scale0 * pow_10(exp);
> > > > +		*val0 =3D scale0 * int_pow(10, exp);
> > > >  		res =3D 0;
> > > >  		if (exp > 9) {
> > > >  			*val1 =3D 0;
> > > >  			return;
> > > >  		}
> > > >  		for (i =3D 0; i < exp; ++i) {
> > > > -			x =3D scale1 / pow_10(8 - i);
> > > > -			res +=3D (pow_10(exp - 1 - i) * x);
> > > > -			scale1 =3D scale1 % pow_10(8 - i);
> > > > +			x =3D scale1 / int_pow(10, 8 - i);
> > > > +			res +=3D int_pow(10, exp - 1 - i) * x;
> > > > +			scale1 =3D scale1 % int_pow(10, 8 - i);
> > > >  		}
> > > >  		*val0 +=3D res;
> > > > -		*val1 =3D scale1 * pow_10(exp);
> > > > +		*val1 =3D scale1 * int_pow(10, exp);
> > > >  	} else if (exp < 0) {
> > > >  		exp =3D abs(exp);
> > > >  		if (exp > 9) {
> > > >  			*val0 =3D *val1 =3D 0;
> > > >  			return;
> > > >  		}
> > > > -		*val0 =3D scale0 / pow_10(exp);
> > > > -		rem =3D scale0 % pow_10(exp);
> > > > +		*val0 =3D scale0 / int_pow(10, exp);
> > > > +		rem =3D scale0 % int_pow(10, exp);
> > > >  		res =3D 0;
> > > >  		for (i =3D 0; i < (9 - exp); ++i) {
> > > > -			x =3D scale1 / pow_10(8 - i);
> > > > -			res +=3D (pow_10(8 - exp - i) * x);
> > > > -			scale1 =3D scale1 % pow_10(8 - i);
> > > > +			x =3D scale1 / int_pow(10, 8 - i);
> > > > +			res +=3D int_pow(10, 8 - exp - i) * x;
> > > > +			scale1 =3D scale1 % int_pow(10, 8 - i);
> > > >  		}
> > > > -		*val1 =3D rem * pow_10(9 - exp) + res;
> > > > +		*val1 =3D rem * int_pow(10, 9 - exp) + res;
> > > >  	} else {
> > > >  		*val0 =3D scale0;
> > > >  		*val1 =3D scale1; =20
> > >=20
> > >  =20
>=20
>=20

--=-tksnzeGYbZyy6qPjf3TY
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
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDgx
OTAyNDgwMFowIwYJKoZIhvcNAQkEMRYEFFXfBC6fpRQ+o1jPL00LVixD1OiFMA0GCSqGSIb3DQEB
AQUABIIBADJc4QQHU7Csew3EhAZocz0T0bM+0M03rYt1s6nHjFo3Ulw/TfWaEWyvBbtJkOpNz+gW
zXKulZ4FUAbgHBX08qgAI97MK6i2bgaNFpoXu5Qao/V0zhvEOzRL88FcTivXhAJqzkf50mLXBv6O
7/YSFuA1lb7yoF29mYNovuborUVKGjP73FT6+bqlNKN+yyUHt97B1544SrreqFw6XAjOjKc8fq2T
ZPkkHxAtdUmSfuhz+rj3tUoQ/uC5KXx11/ABgBkPD7zYmfrnyUNu5LJXUxtVAPDdB+liBjyQxEc5
3EQzqLaJv4h+Ay+Xp0O33WxB2VXsQzQZeG9G7M8zps4+XugAAAAAAAA=


--=-tksnzeGYbZyy6qPjf3TY--
