Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10475B4EA3
	for <lists+linux-iio@lfdr.de>; Sun, 11 Sep 2022 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiIKMAv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Sep 2022 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiIKMAu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Sep 2022 08:00:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDBE27FCB;
        Sun, 11 Sep 2022 05:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7021AB80B48;
        Sun, 11 Sep 2022 12:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1217EC433B5;
        Sun, 11 Sep 2022 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662897647;
        bh=4ZIlYtY3nd/sUEHGl0h8h3b8XH2TBIGz1gWIIt3GVpw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RmKtR1lU8D143UJ5kBLH7ZY0puD9VyiiA/VfQBpatbmK74uI7eMmeG8y8716iX9Ft
         qK7h1z1toaMhIf2rDHTbDbeS63B9IzfkxQKsxXT2d/E9OZsaBx4BDU+AeSggQ+d2xJ
         dvyVI/3T07ZZuJHz8hSz2nrBDxS2Qz1H8fg9X6MdK5wv/SJy+Yk22gcuRRzbZ/ofji
         hl5gkDCCTCkYEE4Gm6ZncdzA4lBO85O23XeRmw9wIEsBEFx3+MrJJL7qBXqKJhjGB/
         Bkadx8e8j/pWM95HRpHtj7UGHVQtT9Bwt7muRQUlluezq+zVx1EGkSz9ZQ527pZvo4
         osJoJnWKidawg==
Date:   Sun, 11 Sep 2022 12:26:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/3] iio: adc: ad7923: fix channel readings for some
 variants
Message-ID: <20220911122644.4d408fe6@jic23-huawei>
In-Reply-To: <20220909151413.1164754-2-nuno.sa@analog.com>
References: <20220909151413.1164754-1-nuno.sa@analog.com>
        <20220909151413.1164754-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 9 Sep 2022 17:14:11 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Some of the supported devices have 4 or 2 LSB trailing bits that should
> not be taken into account. Hence we need to shift these bits out which
> fits perfectly on the scan type shift property. This change fixes both
> raw and buffered reads.

Hi Nuno,

Seems that all the values of shift are 12 - realbits.
If that's the case, can we reduce the noise this patch creates by just
updating AD7923_V_CHAN() to set .shift =3D 12 - (bits) ?

I guess that's not as flexible if anyone adds support for a device
with different shifts, but I suspect that may never happen.

Given we want a fix to be minimal (and hence as likely as possible to backp=
ort
cleanly) I think that approach would be a cleaner choice.

Thanks,

Jonathan
>=20
> Fixes: f2f7a449707e ("iio:adc:ad7923: Add support for the ad7904/ad7914/a=
d7924")
> Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad7918=
/ad7928")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad7923.c | 46 +++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index edad1f30121d..910cf05e75cd 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -80,7 +80,7 @@ enum ad7923_id {
>  	AD7928
>  };
> =20
> -#define AD7923_V_CHAN(index, bits)					\
> +#define AD7923_V_CHAN(index, bits, _shift)				\
>  	{								\
>  		.type =3D IIO_VOLTAGE,					\
>  		.indexed =3D 1,						\
> @@ -93,38 +93,39 @@ enum ad7923_id {
>  			.sign =3D 'u',					\
>  			.realbits =3D (bits),				\
>  			.storagebits =3D 16,				\
> +			.shift =3D (_shift),				\
>  			.endianness =3D IIO_BE,				\
>  		},							\
>  	}
> =20
> -#define DECLARE_AD7923_CHANNELS(name, bits) \
> +#define DECLARE_AD7923_CHANNELS(name, bits, shift) \
>  const struct iio_chan_spec name ## _channels[] =3D { \
> -	AD7923_V_CHAN(0, bits), \
> -	AD7923_V_CHAN(1, bits), \
> -	AD7923_V_CHAN(2, bits), \
> -	AD7923_V_CHAN(3, bits), \
> +	AD7923_V_CHAN(0, bits, shift), \
> +	AD7923_V_CHAN(1, bits, shift), \
> +	AD7923_V_CHAN(2, bits, shift), \
> +	AD7923_V_CHAN(3, bits, shift), \
>  	IIO_CHAN_SOFT_TIMESTAMP(4), \
>  }
> =20
> -#define DECLARE_AD7908_CHANNELS(name, bits) \
> +#define DECLARE_AD7908_CHANNELS(name, bits, shift) \
>  const struct iio_chan_spec name ## _channels[] =3D { \
> -	AD7923_V_CHAN(0, bits), \
> -	AD7923_V_CHAN(1, bits), \
> -	AD7923_V_CHAN(2, bits), \
> -	AD7923_V_CHAN(3, bits), \
> -	AD7923_V_CHAN(4, bits), \
> -	AD7923_V_CHAN(5, bits), \
> -	AD7923_V_CHAN(6, bits), \
> -	AD7923_V_CHAN(7, bits), \
> +	AD7923_V_CHAN(0, bits, shift), \
> +	AD7923_V_CHAN(1, bits, shift), \
> +	AD7923_V_CHAN(2, bits, shift), \
> +	AD7923_V_CHAN(3, bits, shift), \
> +	AD7923_V_CHAN(4, bits, shift), \
> +	AD7923_V_CHAN(5, bits, shift), \
> +	AD7923_V_CHAN(6, bits, shift), \
> +	AD7923_V_CHAN(7, bits, shift), \
>  	IIO_CHAN_SOFT_TIMESTAMP(8), \
>  }
> =20
> -static DECLARE_AD7923_CHANNELS(ad7904, 8);
> -static DECLARE_AD7923_CHANNELS(ad7914, 10);
> -static DECLARE_AD7923_CHANNELS(ad7924, 12);
> -static DECLARE_AD7908_CHANNELS(ad7908, 8);
> -static DECLARE_AD7908_CHANNELS(ad7918, 10);
> -static DECLARE_AD7908_CHANNELS(ad7928, 12);
> +static DECLARE_AD7923_CHANNELS(ad7904, 8, 4);
> +static DECLARE_AD7923_CHANNELS(ad7914, 10, 2);
> +static DECLARE_AD7923_CHANNELS(ad7924, 12, 0);
> +static DECLARE_AD7908_CHANNELS(ad7908, 8, 4);
> +static DECLARE_AD7908_CHANNELS(ad7918, 10, 2);
> +static DECLARE_AD7908_CHANNELS(ad7928, 12, 0);
> =20
>  static const struct ad7923_chip_info ad7923_chip_info[] =3D {
>  	[AD7904] =3D {
> @@ -268,7 +269,8 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
>  			return ret;
> =20
>  		if (chan->address =3D=3D EXTRACT(ret, 12, 4))
> -			*val =3D EXTRACT(ret, 0, 12);
> +			*val =3D EXTRACT(ret, chan->scan_type.shift,
> +				       chan->scan_type.realbits);
>  		else
>  			return -EIO;
> =20

