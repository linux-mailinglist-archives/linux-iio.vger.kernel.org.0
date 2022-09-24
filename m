Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10495E8DD1
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiIXP0Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 11:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIXP0Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 11:26:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6A2656C
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09ABCB801B9
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 15:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDAEC433C1;
        Sat, 24 Sep 2022 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664033180;
        bh=mrFI7ONNqcKCXJbtWHFoq/iPiCayS08Oha0UjYfBXn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nhXw/ztGaPsFHfTINnvveraB0d5izw0b3jRAtltkB/jF9NH3mGx9ikNjJ2h3V8ui6
         /vSj8M/ook2IWaFlnQl1WKflShWdQQfxoHeKWi+u1PUK12R0KWDglIvr+5tUW/CHeh
         Lj5N5vJBBwHFodWbqnNxdO4g0Tp7JYwOkQeBaXILYkWVhzD6ve7YAF4KqJqHCEo5hT
         K4bfjlAznBTQgakohXEJFPFzeL0RT0qNF/iSf9kUwrZbiHE9XvTxUQM0HAsHcOuIdV
         LrPil8H/0MeTFxhysnfeKhJU20y3+nthHQMKD1WemB5X+j4nv8ZxpGW6hDwjcpa8JR
         YU0TCvhzFg/7g==
Date:   Sat, 24 Sep 2022 16:26:22 +0100
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
Subject: Re: [PATCH 04/15] iio: adc: imx7d_adc: do not use internal iio_dev
 lock
Message-ID: <20220924162622.66802d96@jic23-huawei>
In-Reply-To: <20220920112821.975359-5-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-5-nuno.sa@analog.com>
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

On Tue, 20 Sep 2022 13:28:10 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.

Mention the mutex.h include.  Technically it's an unrelated (good) change.
Definitely not worth a separate patch however so just mention it in the
description.

>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/imx7d_adc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 86caff1d006b..fa19f5e09079 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> =20
> @@ -108,7 +109,8 @@ struct imx7d_adc {
>  	struct device *dev;
>  	void __iomem *regs;
>  	struct clk *clk;
> -
> +	/* lock to protect against multiple access to the device */
> +	struct mutex lock;
>  	u32 vref_uv;
>  	u32 value;
>  	u32 channel;
> @@ -293,7 +295,7 @@ static int imx7d_adc_read_raw(struct iio_dev *indio_d=
ev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&info->lock);
>  		reinit_completion(&info->completion);
> =20
>  		channel =3D chan->channel & 0x03;
> @@ -303,16 +305,16 @@ static int imx7d_adc_read_raw(struct iio_dev *indio=
_dev,
>  		ret =3D wait_for_completion_interruptible_timeout
>  				(&info->completion, IMX7D_ADC_TIMEOUT);
>  		if (ret =3D=3D 0) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);
>  			return -ETIMEDOUT;
>  		}
>  		if (ret < 0) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);
>  			return ret;
>  		}
> =20
>  		*val =3D info->value;
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&info->lock);
>  		return IIO_VAL_INT;
> =20
>  	case IIO_CHAN_INFO_SCALE:
> @@ -487,6 +489,7 @@ static int imx7d_adc_probe(struct platform_device *pd=
ev)
> =20
>  	info =3D iio_priv(indio_dev);
>  	info->dev =3D dev;
> +	mutex_init(&info->lock);
> =20
>  	info->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(info->regs))

