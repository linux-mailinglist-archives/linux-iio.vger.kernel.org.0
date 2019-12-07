Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977CA115BF5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 12:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLGLMD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 06:12:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLGLMC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 06:12:02 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE3C524673;
        Sat,  7 Dec 2019 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575717121;
        bh=WI+LemDcpYVITCWDtrnmlI0yhoN0fnrcBkkObYh83kQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v80aqitChL36LevYdO7d+JONlcxEKJPjcmWF0Cjc0C9sXcZbAZAhfcP1FLz791ha6
         hYPVBOpBpEMX5eUfuD10pg5oUoN90523xjSdVPxOCgb6a1oGbhAs0M9oOBEWTOHJzN
         MW4KsiF/ojmy63bpbCiq71N0ZbVA5LCf8dvwnXcY=
Date:   Sat, 7 Dec 2019 11:11:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: max9611: Fix too short conversion time
 delay
Message-ID: <20191207111156.7e5139f0@archlinux>
In-Reply-To: <20191206131944.28707-1-geert+renesas@glider.be>
References: <20191206131944.28707-1-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  6 Dec 2019 14:19:44 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> As of commit b9ddd5091160793e ("iio: adc: max9611: Fix temperature
> reading in probe"), max9611 initialization sometimes fails on the
> Salvator-X(S) development board with:
>=20
>     max9611 4-007f: Invalid value received from ADC 0x8000: aborting
>     max9611: probe of 4-007f failed with error -5
>=20
> The max9611 driver tests communications with the chip by reading the die
> temperature during the probe function, which returns an invalid value.
>=20
> According to the datasheet, the typical ADC conversion time is 2 ms, but
> no minimum or maximum values are provided.  Maxim Technical Support
> confirmed this was tested with temperature Ta=3D25 degreeC, and promised
> to inform me if a maximum/minimum value is available (they didn't get
> back to me, so I assume it is not).
>=20
> However, the driver assumes a 1 ms conversion time.  Usually the
> usleep_range() call returns after more than 1.8 ms, hence it succeeds.
> When it returns earlier, the data register may be read too early, and
> the previous measurement value will be returned.  After boot, this is
> the temperature POR (power-on reset) value, causing the failure above.
>=20
> Fix this by increasing the delay from 1000-2000 =C2=B5s to 3000-3300 =C2=
=B5s.
>=20
> Note that this issue has always been present, but it was exposed by the
> aformentioned commit.
>=20
> Fixes: 69780a3bbc0b1e7e ("iio: adc: Add Maxim max9611 ADC driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Ah. I picked up v2 and did the tidy up.  Oh well, same result ;)

Jonathan

> ---
> After this patch, probing of the two max9611 sensors succeeded during
> ca. 3000 boot cycles on Salvator-X(S) boards, equipped with various
> R-Car H3/M3-W/M3-N SoCs.
>=20
> v3:
>   - Add Reviewed-by,
>   - Join split comment line,
>=20
> v2:
>   - Add Reviewed-by,
>   - Add feedback from Maxim Technical Support,
>   - Increase delay from 2000-2200 =C2=B5s to 3000-3300 =C2=B5s to play sa=
fe.
> ---
>  drivers/iio/adc/max9611.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index bf76dfb3f2c9530b..6250d4bf46dc9642 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -89,6 +89,12 @@
>  #define MAX9611_TEMP_SCALE_NUM		1000000
>  #define MAX9611_TEMP_SCALE_DIV		2083
> =20
> +/*
> + * Conversion time is 2 ms (typically) at Ta=3D25 degreeC
> + * No maximum value is known, so play it safe
> + */
> +#define MAX9611_CONV_TIME_US_RANGE	3000, 3300
> +
>  struct max9611_dev {
>  	struct device *dev;
>  	struct i2c_client *i2c_client;
> @@ -223,10 +229,9 @@ static int max9611_read_single(struct max9611_dev *m=
ax9611,
>  	}
> =20
>  	/*
> -	 * need a delay here to make register configuration
> -	 * stabilize. 1 msec at least, from empirical testing.
> +	 * need a delay here to make register configuration stabilize.
>  	 */
> -	usleep_range(1000, 2000);
> +	usleep_range(MAX9611_CONV_TIME_US_RANGE);
> =20
>  	ret =3D i2c_smbus_read_word_swapped(max9611->i2c_client, reg_addr);
>  	if (ret < 0) {
> @@ -493,7 +498,7 @@ static int max9611_init(struct max9611_dev *max9611)
>  			MAX9611_REG_CTRL2, 0);
>  		return ret;
>  	}
> -	usleep_range(1000, 2000);
> +	usleep_range(MAX9611_CONV_TIME_US_RANGE);
> =20
>  	return 0;
>  }

