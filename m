Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5975E8D76
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiIXOpT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiIXOpR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 10:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D826123
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 07:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2097861305
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 14:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288CFC433D6;
        Sat, 24 Sep 2022 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664030715;
        bh=UffGNaz7rGWSvwZEAeWcih42X65ZeRwe+5tP0CQeZtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mvLUuOHSDhTf1V1L5QzFkqfO4jSEa8QzLj0/FxGICZ67RfIVvYDI2xj63pk4MHr6J
         GCurpnbB3+bvf/HFnbO2mzg+gqXWKH6bSTuxokSj5w+wWaQDtgdVHcGIbRb/NswAoT
         IBRUU/CN8kc6CRzpbyoEqAqxILxcB85Z1uxCg2aXBW9/ws68XOWjU5OsfBluHNJ/fv
         lOHL4RfWYxVAoE9ORLZ/Vav2JgMagcW9obUy/8TY74cxxrZL7SrkP6eOIFUhF/OCON
         JrZ++QEejWFNwcN15u0IGQVcIRrkwAGB6+2DmXgTtYk/DSq9bXyo0dYqNnvMS67B0a
         YSKYmE5MkgQrg==
Date:   Sat, 24 Sep 2022 15:45:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 02/15] iio: adc: ad799x: do not use internal iio_dev
 lock
Message-ID: <20220924154517.6672e964@jic23-huawei>
In-Reply-To: <20220920112821.975359-3-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-3-nuno.sa@analog.com>
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

On Tue, 20 Sep 2022 13:28:08 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> 'mlock' was being grabbed when setting the device frequency. In order to
> not introduce any functional change a new lock is added. With that in
> mind, the lock also needs to be grabbed in the places where 'mlock' is.

The usage in here is an example of why we originally decided to take mlock
private...  Annoying hard to reason about.  One key thing this description
doesn't mention is protection of st->config vs device state and I think
the original usage of mlock is partly intended to protect that.

Upshot is I'm not confident enough on this one to be happy taking it without
more head scratching or some review from others!

>=20
> On the other places the lock was being used, we can just drop
> it since we are only doing one i2c bus read/write which is already
> safe.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> ---
>  drivers/iio/adc/ad799x.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 262bd7665b33..838ba8e77de1 100644
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

If we claim direct mode for the frequency writing we'll avoid racing with
buffers being enabled or other sysfs accesses that are claiming direct mode.

That made me think we could drop the lock, but the argument gets tricker
around st->config which is used in ad799x_scan_direct() and modified
in write_event_config() in a fashion that means it could be out of sync.
I'm not sure that matters but it is getting hard to reason about.


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
I think you do need the lock here and in other places where you want to ens=
ure the
st->config state matches that of the device.

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
> @@ -785,6 +790,7 @@ static int ad799x_probe(struct i2c_client *client,
>  		return -ENOMEM;
> =20
>  	st =3D iio_priv(indio_dev);
> +	mutex_init(&st->lock);
>  	/* this is only used for device removal purposes */
>  	i2c_set_clientdata(client, indio_dev);
> =20

