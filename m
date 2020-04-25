Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB431B8850
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDYRzu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 13:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgDYRzu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 13:55:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3765720672;
        Sat, 25 Apr 2020 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587837349;
        bh=yafyNc78+05zFfVDCfWRgilZn+fGa4nu88i+kprdoGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fwi6otMjSxzceRW/ulwQ5mvNGFa2OfD2WKZCwSrIHe4cuFCzU3DbmNNFL+vTLZG88
         4vHA8/3Yo6QVAc+Vy8cDLyvKoJyTVa4FNV3tp9eJ6qwpEjTlwcUC7XGwIAZQ5aqXeP
         PB2D4XT7K21qUtJOlUVcbToSa4x2h83HWzJFsCH4=
Date:   Sat, 25 Apr 2020 18:55:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 3/3 v4] iio: magnetometer: ak8974: Provide scaling
Message-ID: <20200425185545.485ed904@archlinux>
In-Reply-To: <20200420204022.18235-3-linus.walleij@linaro.org>
References: <20200420204022.18235-1-linus.walleij@linaro.org>
        <20200420204022.18235-3-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 22:40:22 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> The manual for the HSCDTD008A gives us a scaling for the
> three axis as +/- 2.4mT (24 Gauss) per axis.
>=20
> The manual for the AMI305 and AMI306 gives us a scaling
> for the three axis as +/- 12 Gauss per axis.
>=20
> Tests with the HSCDTD008A sensor, cat the raw values:
> $ cat in_magn_*_raw
> raw
> 45
> 189
> -19
>=20
> The scaling factor in in_magn_*_scale is 0.001464843,
> which gives:
> 0.065 Gauss
> 0.277 Gauss
> -0.027 Gauss
>=20
> The earths magnetic field is in the range of 0.25 to 0.65
> Gauss on the surface according to Wikipedia, so these
> seem like reasonable values.
>=20
> Again we are guessing that the AK8974 has a 12 bit ADC,
> based on the similarity with AMI305 and AMI306.
>=20
> Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, but they'll sit in my testing branch for a while yet
most likely so can rebase (add tags / drop them etc) if others
still wish to comment.

Thanks,

Jonathan

> ---
> ChangeLog v3->v4:
> - Do not multiply the range with 2, instead divide by
>   two in divisor and dividend. (Thus it becomes 2^11
>   and 2^14 respectively.)
> - Use the IIO_VAL_FRACTIONAL_LOG2 trick and pass 2^11
>   or 2^14 as range.
> ChangeLog v2->v3:
> - Scale the 2.4mT/24Gauss to 15 bits for the HSCDTD008A.
> - Scale the 12 Gauss to 12 bits for the AMI305/AMI306
> - Use 12 bits for the other variants.
> - Return directly in the raw read function.
> ChangeLog v1->v2:
> - Split out the measurement refactoring.
> ---
>  drivers/iio/magnetometer/ak8974.c | 45 ++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer=
/ak8974.c
> index fb6d84b79a7a..2d500be9da40 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -606,6 +606,48 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (ak8974->variant) {
> +		case AK8974_WHOAMI_VALUE_AMI306:
> +		case AK8974_WHOAMI_VALUE_AMI305:
> +			/*
> +			 * The datasheet for AMI305 and AMI306, page 6
> +			 * specifies the range of the sensor to be
> +			 * +/- 12 Gauss.
> +			 */
> +			*val =3D 12;
> +			/*
> +			 * 12 bits are used, +/- 2^11
> +			 * [ -2048 .. 2047 ] (manual page 20)
> +			 * [ 0xf800 .. 0x07ff ]
> +			 */
> +			*val2 =3D 11;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case AK8974_WHOAMI_VALUE_HSCDTD008A:
> +			/*
> +			 * The datasheet for HSCDTF008A, page 3 specifies the
> +			 * range of the sensor as +/- 2.4 mT per axis, which
> +			 * corresponds to +/- 2400 uT =3D +/- 24 Gauss.
> +			 */
> +			*val =3D 24;
> +			/*
> +			 * 15 bits are used (set up in CTRL4), +/- 2^14
> +			 * [ -16384 .. 16383 ] (manual page 24)
> +			 * [ 0xc000 .. 0x3fff ]
> +			 */
> +			*val2 =3D 14;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			/* GUESSING +/- 12 Gauss */
> +			*val =3D 12;
> +			/* GUESSING 12 bits ADC +/- 2^11 */
> +			*val2 =3D 11;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +		break;
> +	default:
> +		/* Unknown request */
> +		break;
>  	}
> =20
>  	return -EINVAL;
> @@ -670,7 +712,8 @@ static const struct iio_chan_spec_ext_info ak8974_ext=
_info[] =3D {
>  		.type =3D IIO_MAGN,					\
>  		.modified =3D 1,						\
>  		.channel2 =3D IIO_MOD_##axis,				\
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> +			BIT(IIO_CHAN_INFO_SCALE),			\
>  		.ext_info =3D ak8974_ext_info,				\
>  		.address =3D index,					\
>  		.scan_index =3D index,					\

