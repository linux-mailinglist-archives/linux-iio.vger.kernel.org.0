Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F145F8B01
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJILxO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJILxN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 07:53:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ED42B19F
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 04:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A744AB80C03
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 11:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41A9C433C1;
        Sun,  9 Oct 2022 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316390;
        bh=qsz74MmjKWXTto8e5NlBeLW2eYHp/fAnJa9dnoOj1dY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vAsj/eVfy/Bu0FlYaK5w/yTiBn0ZZnFK3U9RA6uubKcIjBc2B2ULHE6hlJOI1P2TH
         rTMkY4uFtGzommk4xLfXFe6IXpJrPOpaSenIwSEhuy/OvWxTGD+OmjjQd/vhsQqmLM
         lZTGPWvYsuWxavdsn0m1iOiOpCq6cj+7w22jB5Jb+xfcSAkslY1ZOV5ksESVhLq5gO
         2rkdYYgqGrxOUV8P/I/2GA6t+58+626tu1rsjJt4Etv1+lfnW98HtNBmgtDJHWE35d
         v4lTt5OEXmmYzTjap77DYlu9rH7eGLMM6dFaRKJvNqghUF0QxIyssOeCy28XkqlwGm
         oVnZ7RvSy7qig==
Date:   Sun, 9 Oct 2022 12:53:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 01/16] iio: adc: ad799x: do not use internal iio_dev
 lock
Message-ID: <20221009125326.038e1469@jic23-huawei>
In-Reply-To: <20221004134909.1692021-2-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Oct 2022 15:48:54 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> 'mlock' was being grabbed when setting the device frequency. In order to
> not introduce any functional change a new lock is added. With that in
> mind, the lock also needs to be grabbed in the places where 'mlock' is
> since it was also being used to protect st->config against the current
> device state.
>=20
> On the other places the lock was being used, we can just drop
> it since we are only doing one i2c bus read/write which is already
> safe.
>=20
> While at it, properly include "mutex.h" for mutex related APIs.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
In interests of cutting down scope of any future versions
(Should there need to be anyway) I'm going to pick up the non controversial
patches.

Applied to the togreg branch of iio.git though that's only pushed out
as testing for now as we are mid merge window.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad799x.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 262bd7665b33..44f7a80a0749 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -28,6 +28,7 @@
>  #include <linux/types.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/bitops.h>
> =20
>  #include <linux/iio/iio.h>
> @@ -125,6 +126,8 @@ struct ad799x_state {
>  	const struct ad799x_chip_config	*chip_config;
>  	struct regulator		*reg;
>  	struct regulator		*vref;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex			lock;
>  	unsigned			id;
>  	u16				config;
> =20
> @@ -290,7 +293,9 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>  		ret =3D iio_device_claim_direct_mode(indio_dev);
>  		if (ret)
>  			return ret;
> +		mutex_lock(&st->lock);
>  		ret =3D ad799x_scan_direct(st, chan->scan_index);
> +		mutex_unlock(&st->lock);
>  		iio_device_release_direct_mode(indio_dev);
> =20
>  		if (ret < 0)
> @@ -351,7 +356,8 @@ static ssize_t ad799x_write_frequency(struct device *=
dev,
>  	if (ret)
>  		return ret;
> =20
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
> +
>  	ret =3D i2c_smbus_read_byte_data(st->client, AD7998_CYCLE_TMR_REG);
>  	if (ret < 0)
>  		goto error_ret_mutex;
> @@ -373,7 +379,7 @@ static ssize_t ad799x_write_frequency(struct device *=
dev,
>  	ret =3D len;
> =20
>  error_ret_mutex:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
> =20
>  	return ret;
>  }
> @@ -407,6 +413,8 @@ static int ad799x_write_event_config(struct iio_dev *=
indio_dev,
>  	if (ret)
>  		return ret;
> =20
> +	mutex_lock(&st->lock);
> +
>  	if (state)
>  		st->config |=3D BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT;
>  	else
> @@ -418,6 +426,7 @@ static int ad799x_write_event_config(struct iio_dev *=
indio_dev,
>  		st->config &=3D ~AD7998_ALERT_EN;
> =20
>  	ret =3D ad799x_write_config(st, st->config);
> +	mutex_unlock(&st->lock);
>  	iio_device_release_direct_mode(indio_dev);
>  	return ret;
>  }
> @@ -454,11 +463,9 @@ static int ad799x_write_event_value(struct iio_dev *=
indio_dev,
>  	if (val < 0 || val > GENMASK(chan->scan_type.realbits - 1, 0))
>  		return -EINVAL;
> =20
> -	mutex_lock(&indio_dev->mlock);
>  	ret =3D i2c_smbus_write_word_swapped(st->client,
>  		ad799x_threshold_reg(chan, dir, info),
>  		val << chan->scan_type.shift);
> -	mutex_unlock(&indio_dev->mlock);
> =20
>  	return ret;
>  }
> @@ -473,10 +480,8 @@ static int ad799x_read_event_value(struct iio_dev *i=
ndio_dev,
>  	int ret;
>  	struct ad799x_state *st =3D iio_priv(indio_dev);
> =20
> -	mutex_lock(&indio_dev->mlock);
>  	ret =3D i2c_smbus_read_word_swapped(st->client,
>  		ad799x_threshold_reg(chan, dir, info));
> -	mutex_unlock(&indio_dev->mlock);
>  	if (ret < 0)
>  		return ret;
>  	*val =3D (ret >> chan->scan_type.shift) &
> @@ -863,6 +868,9 @@ static int ad799x_probe(struct i2c_client *client,
>  		if (ret)
>  			goto error_cleanup_ring;
>  	}
> +
> +	mutex_init(&st->lock);
> +
>  	ret =3D iio_device_register(indio_dev);
>  	if (ret)
>  		goto error_cleanup_ring;

