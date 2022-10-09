Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AFE5F8B02
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJILzN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 07:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiJILzM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 07:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EDC2253C
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 04:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B123F60BC7
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 11:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EB5C433C1;
        Sun,  9 Oct 2022 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316510;
        bh=7G8FudK/SnVT+WU1Sm0q/dyYpMvSStBHIg7BMBTU6TQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UR19577n625itCGGwah2zEcsVrK7GXWXYh418H6KABhox1F2ZyJ79MKrtay4RxlI8
         gMIyVaz8FLIXQ2ZpVD5qziGkxHxwOQnUtTdBfAInr3wywprFiVh66BgsZoB5Rym1JI
         6MaX0DK1Dj43Ao20Eg0wcsNOvF3KII6wm7mrs3J3mDqXsziqOCe9nf364lm3r45+P4
         Yptnu+u8ccQwQnBTIy5PgBywzylk89JULJBUmmq6SHctduUApQBoAelArjllHOoN/l
         gusA6WO6msitCWzg3s8fpkFjYOcQ19aIclvWdh/D/H+KmU9KHIXVPu9oxESxxiQTog
         hvgcUQBkBpe8g==
Date:   Sun, 9 Oct 2022 12:55:26 +0100
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
Subject: Re: [PATCH v2 02/16] iio: adc: axp288_adc: do not use internal
 iio_dev lock
Message-ID: <20221009125526.0358bce6@jic23-huawei>
In-Reply-To: <20221004134909.1692021-3-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-3-nuno.sa@analog.com>
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

On Tue, 4 Oct 2022 15:48:55 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>=20
> While at it, properly include "mutex.h" for mutex related APIs.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied with tiny tweak to drop the unrelated white space change.

Applied to the togreg branch of iio.git which is only pushed out
as testing until after a rebase on rc1.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/axp288_adc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index 580361bd9849..53781010f789 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -9,6 +9,7 @@
> =20
>  #include <linux/dmi.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/regmap.h>
> @@ -50,6 +51,8 @@ enum axp288_adc_id {
>  struct axp288_adc_info {
>  	int irq;
>  	struct regmap *regmap;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex lock;
>  	bool ts_enabled;
>  };
> =20
> @@ -161,7 +164,7 @@ static int axp288_adc_read_raw(struct iio_dev *indio_=
dev,
>  	int ret;
>  	struct axp288_adc_info *info =3D iio_priv(indio_dev);
> =20
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&info->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (axp288_adc_set_ts(info, AXP288_ADC_TS_CURRENT_ON_ONDEMAND,
> @@ -178,7 +181,7 @@ static int axp288_adc_read_raw(struct iio_dev *indio_=
dev,
>  	default:
>  		ret =3D -EINVAL;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&info->lock);
> =20
>  	return ret;
>  }
> @@ -264,6 +267,7 @@ static int axp288_adc_probe(struct platform_device *p=
dev)
>  		return -ENOMEM;
> =20
>  	info =3D iio_priv(indio_dev);
> +
>  	info->irq =3D platform_get_irq(pdev, 0);
>  	if (info->irq < 0)
>  		return info->irq;
> @@ -289,6 +293,8 @@ static int axp288_adc_probe(struct platform_device *p=
dev)
>  	if (ret < 0)
>  		return ret;
> =20
> +	mutex_init(&info->lock);
> +
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
> =20

