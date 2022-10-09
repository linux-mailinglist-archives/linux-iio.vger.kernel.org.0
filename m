Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474FD5F8B06
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJIL5o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJIL5n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 07:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F627FD6
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 04:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96B5960BC1
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 11:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D84EC433D6;
        Sun,  9 Oct 2022 11:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316662;
        bh=n9FVRwbXSzvED7AdqW64tqTXRRb8tZLaditVYDqI4sQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jIfX6Ern8PHcfvI8f6zmSL1YKcbOhFMYtC3vT+u8ebG6l8usNIAZ4tpHaE5jeM6+q
         5cTsjpRu8lLQym5HkmUqknill+CrXTRc1bY+e0eFqLl9s/Wh9llDa1bWgrNkRb5N7M
         ifvSbH7IrgcORWKMpclCYybHv20Vw0dEDxaa+LErIIFRWGswzgJbSIsPwE4aps6v8C
         09Gx73mpr1hkJ6NnsjjpWv7FAHjTH0D1TAecUwYrnZPGY3JU9qTKDW9oNmclfl2toN
         Glw+gFFFt0Sl1jrYsY5B8Z4dgkjTViKhy0DadJJ6T93bJ74/uZdgaiegsJWvq4WLOX
         sMRxluUgJSTeA==
Date:   Sun, 9 Oct 2022 12:57:58 +0100
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
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Ciprian Regus" <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "Florian Boor" <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 04/16] iio: adc: lpc32xx_adc: do not use internal
 iio_dev lock
Message-ID: <20221009125758.77bf84c2@jic23-huawei>
In-Reply-To: <20221004134909.1692021-5-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-5-nuno.sa@analog.com>
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

On Tue, 4 Oct 2022 15:48:57 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>=20
> While at it, properly include "mutex.h" for mutex related APIs.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

Thanks,

J

> ---
>  drivers/iio/adc/lpc32xx_adc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index b56ce15255cf..732c924a976d 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -15,6 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> =20
> @@ -49,6 +50,8 @@ struct lpc32xx_adc_state {
>  	struct clk *clk;
>  	struct completion completion;
>  	struct regulator *vref;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex lock;
> =20
>  	u32 value;
>  };
> @@ -64,10 +67,10 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		ret =3D clk_prepare_enable(st->clk);
>  		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&st->lock);
>  			return ret;
>  		}
>  		/* Measurement setup */
> @@ -80,7 +83,7 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
>  		wait_for_completion(&st->completion); /* set by ISR */
>  		clk_disable_unprepare(st->clk);
>  		*val =3D st->value;
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
> =20
>  		return IIO_VAL_INT;
> =20
> @@ -201,6 +204,8 @@ static int lpc32xx_adc_probe(struct platform_device *=
pdev)
>  	iodev->modes =3D INDIO_DIRECT_MODE;
>  	iodev->num_channels =3D ARRAY_SIZE(lpc32xx_adc_iio_channels);
> =20
> +	mutex_init(&st->lock);
> +
>  	retval =3D devm_iio_device_register(&pdev->dev, iodev);
>  	if (retval)
>  		return retval;

