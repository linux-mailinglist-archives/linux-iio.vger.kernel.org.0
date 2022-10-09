Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90FD5F8B0C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJIMFD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 08:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJIMFC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 08:05:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80971CB2A
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 05:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82828B80C90
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 12:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23204C433D6;
        Sun,  9 Oct 2022 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665317098;
        bh=UUCZHXapQyYG+PCcsykDS/jTdAwtKZAWa480AhmIzmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fTqp+PAqjIuheUuS7P083sCwCi35OJvowvlCPgDV5yKkGn10rR8W/K8Je+IRtEBJy
         U+KhDCToklH/7+gahUL/UUlKLXXGImVYXoG81w37/M723eZh2V4PIImRHWrjFjrKWC
         GjbxVxVDkIyhaBZ3u/FpIW14akHYrE/XLam+B8AYojMNxjTEfU/0Gx0uL6p4QdbFcq
         X8aB04iMXBMQI+Cg9JvaG+UX/KJTRmNnTWZIUBpjmUO0Q46gSCH6utIj8i6bAjRAWz
         ntxo94afrTemoJB5VUwCS1tA/KnKjWSj+cJ0O5Cd8rmDPtOoOOmLX9291GHS9f9phM
         fke+gqQU+4/xg==
Date:   Sun, 9 Oct 2022 13:05:14 +0100
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
Subject: Re: [PATCH v2 08/16] iio: adc: sc27xx_adc: do not use internal
 iio_dev lock
Message-ID: <20221009130514.133eff43@jic23-huawei>
In-Reply-To: <20221004134909.1692021-9-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-9-nuno.sa@analog.com>
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

On Tue, 4 Oct 2022 15:49:01 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>=20
> While at it, properly include "mutex.h" for mutex related APIs.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied. Pushed out as testing for now, will rebase after rc1.

Thanks,

J
> ---
>  drivers/iio/adc/sc27xx_adc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index f8421cbba8fa..ff1fc329bb9b 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -4,6 +4,7 @@
>  #include <linux/hwspinlock.h>
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -83,6 +84,8 @@ struct sc27xx_adc_data {
>  	struct device *dev;
>  	struct regulator *volref;
>  	struct regmap *regmap;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex lock;
>  	/*
>  	 * One hardware spinlock to synchronize between the multiple
>  	 * subsystems which will access the unique ADC controller.
> @@ -664,9 +667,9 @@ static int sc27xx_adc_read_raw(struct iio_dev *indio_=
dev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&data->lock);
>  		ret =3D sc27xx_adc_read(data, chan->channel, scale, &tmp);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&data->lock);
> =20
>  		if (ret)
>  			return ret;
> @@ -675,10 +678,10 @@ static int sc27xx_adc_read_raw(struct iio_dev *indi=
o_dev,
>  		return IIO_VAL_INT;
> =20
>  	case IIO_CHAN_INFO_PROCESSED:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&data->lock);
>  		ret =3D sc27xx_adc_read_processed(data, chan->channel, scale,
>  						&tmp);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&data->lock);
> =20
>  		if (ret)
>  			return ret;
> @@ -934,6 +937,9 @@ static int sc27xx_adc_probe(struct platform_device *p=
dev)
>  	indio_dev->info =3D &sc27xx_info;
>  	indio_dev->channels =3D sc27xx_channels;
>  	indio_dev->num_channels =3D ARRAY_SIZE(sc27xx_channels);
> +
> +	mutex_init(&sc27xx_data->lock);
> +
>  	ret =3D devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		dev_err(dev, "could not register iio (ADC)");

