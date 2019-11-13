Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB3FAD1A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 10:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKMJgc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 04:36:32 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38607 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfKMJgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 04:36:32 -0500
X-Originating-IP: 93.34.114.233
Received: from uno.localdomain (93-34-114-233.ip49.fastwebnet.it [93.34.114.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E291720010;
        Wed, 13 Nov 2019 09:36:27 +0000 (UTC)
Date:   Wed, 13 Nov 2019 10:38:28 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: Fix too short conversion time delay
Message-ID: <20191113093828.vk5qqtlr7bs5z5fb@uno.localdomain>
References: <20191113092133.23723-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="awl3hpbx7r65k2ea"
Content-Disposition: inline
In-Reply-To: <20191113092133.23723-1-geert+renesas@glider.be>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--awl3hpbx7r65k2ea
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Nov 13, 2019 at 10:21:33AM +0100, Geert Uytterhoeven wrote:
> As of commit b9ddd5091160793e ("iio: adc: max9611: Fix temperature
> reading in probe"), max9611 initialization sometimes fails on the
> Salvator-X(S) development board with:
>
>     max9611 4-007f: Invalid value received from ADC 0x8000: aborting
>     max9611: probe of 4-007f failed with error -5
>
> The max9611 driver tests communications with the chip by reading the die
> temperature during the probe function, which returns an invalid value.
>
> According to the datasheet, the typical ADC conversion time is 2 ms, but
> no minimum or maximum values are provided.  However, the driver assumes
> a 1 ms conversion time.  Usually the usleep_range() call returns after
> more than 1.8 ms, hence it succeeds.  When it returns earlier, the data
> register may be read too early, and the previous measurement value will
> be returned.  After boot, this is the temperature POR (power-on reset)
> value, causing the failure above.
>
> Fix this by increasing the delay from 1000-2000 =C2=B5s to 2000-2200 =C2=
=B5s.
>
> Note that this issue has always been present, but it was exposed by the
> aformentioned commit.
>
> Fixes: 69780a3bbc0b1e7e ("iio: adc: Add Maxim max9611 ADC driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This problem was exposed in v5.3.
>
> After this patch, probing of the two max9611 sensors succeeded during
> ca. 3000 boot cycles on Salvator-X(S) boards, equipped with various
> R-Car H3/M3-W/M3-N SoCs.
> ---
>  drivers/iio/adc/max9611.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index da073d72f649f829..b0755f25356d700d 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -89,6 +89,11 @@
>  #define MAX9611_TEMP_SCALE_NUM		1000000
>  #define MAX9611_TEMP_SCALE_DIV		2083
>
> +/*
> + * Conversion time is 2 ms (typically)
> + */
> +#define MAX9611_CONV_TIME_US_RANGE	2000, 2200
> +

Is a 20% sleep range enough or should it be slightly lengthen ?

Apart from this, thanks a lot for finding the issue root cause!

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

>  struct max9611_dev {
>  	struct device *dev;
>  	struct i2c_client *i2c_client;

> @@ -238,9 +243,9 @@ static int max9611_read_single(struct max9611_dev *ma=
x9611,
>
>  	/*
>  	 * need a delay here to make register configuration
> -	 * stabilize. 1 msec at least, from empirical testing.
> +	 * stabilize.
>  	 */
> -	usleep_range(1000, 2000);
> +	usleep_range(MAX9611_CONV_TIME_US_RANGE);
>
>  	ret =3D i2c_smbus_read_word_swapped(max9611->i2c_client, reg_addr);
>  	if (ret < 0) {
> @@ -507,7 +512,7 @@ static int max9611_init(struct max9611_dev *max9611)
>  			MAX9611_REG_CTRL2, 0);
>  		return ret;
>  	}
> -	usleep_range(1000, 2000);
> +	usleep_range(MAX9611_CONV_TIME_US_RANGE);
>
>  	return 0;
>  }
> --
> 2.17.1
>

--awl3hpbx7r65k2ea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl3LzxQACgkQcjQGjxah
VjzhdA/7BuGKCuWi3ZGhqxzXvYRF9u8L9W9tpIsAE6Gx6AxVHU9W6kjlYKC/U7sj
5LnR4aJyXJBH47p6KwIq72GlC20HFrA7jd0cd/sSaP2T3ci459RK+VITyM64UYlU
WdBDriwpJyqoI0hRimUvpt/ELlP3RwM7p6xL6YgqSI0p86yzv49b1uK7XWnkpNBO
YANm1dzwVyhOuoefRg7o97QBTJrSdX3bUdGywVMCZs8XnNK0G1YWwOnrx2i8x020
WcBpw99YZkuLd29A4WcCrhOGxiKyVb4mdteQHKfvpiUN3tcsexhLr/W2TkIeQ1Ic
tGr8leCsu33R+EWiaJMY58/JRUBrcK0DQasVZO+lZcrOGowrblklrDQkmQYoMQd3
wB+Ivp47GjpLiRycHnI28JYO78ppxNwBpMChaEtuy5A6RMwDlD+4iPXLiMD7n3iy
Ar6VwJow65/C36b9U8bTZlVyVqI1vQDjysnLtW+6HocDCb0HAiBJwUlgYqp6e5/c
hgqm1e7UbVr3syyzHH38mHJ+GzuQEzJ5AASKerOPDTtq6K/a+0dhAGAG2X3bYia8
0Fe6qEbH14XcE05hpqx8nHdfmERtRzncfb0a1sZ7HzdY7H1eBiTy/+EVBx2Vqx+4
Ys1dW+z+21WIdtGOCF46fRqNZN6585AVcruHKGFG6wWSCz0eryg=
=cKOB
-----END PGP SIGNATURE-----

--awl3hpbx7r65k2ea--
