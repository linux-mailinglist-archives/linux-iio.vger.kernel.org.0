Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C665E8DD3
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiIXP1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiIXP1J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 11:27:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB508B2CF
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64A38B80D87
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 15:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18007C433C1;
        Sat, 24 Sep 2022 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664033225;
        bh=K56eGXLGJNUqDJ6yNU+SPkp3jUptZSzn9pC/ayv3KBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d2zpm7xIppaORIFkSCk1Pm5PQOrv4LjYmobjcCpjwcoYxMfHNyBRrbCTFsZ28JQim
         zdkBrIbQLZQpNOm1JuY0QQNLAiA5alIJnJBaQA/JfUjU41ajbawQTvnJZGtRsnN7ml
         RlhOo5HPRYUmXhk1zlR/hINDeolxuAXepjmnXlnejbcL6xoftcLn7DoZOHl2vFnO1k
         RK+iDdgIY/Zc1wfDVvUcJnww6GQrc94VBfbFeEX/We3uWT4Lv0abm8EEXeYXlDqNsG
         oJ27KUtF4/jpjntVqYI1KUuyIhdNusvBM8dMmbCj95wPXzad3XoIdQkCLZS35H8+Gu
         +CIP/Qm5UMWgQ==
Date:   Sat, 24 Sep 2022 16:27:06 +0100
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
Subject: Re: [PATCH 05/15] iio: adc: lpc32xx_adc: do not use internal
 iio_dev lock
Message-ID: <20220924162706.2a731356@jic23-huawei>
In-Reply-To: <20220920112821.975359-6-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-6-nuno.sa@analog.com>
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

On Tue, 20 Sep 2022 13:28:11 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.

As with previous patch, mention the additional include cleanup.

>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/lpc32xx_adc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index b56ce15255cf..4136cf536d58 100644
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
> @@ -158,6 +161,7 @@ static int lpc32xx_adc_probe(struct platform_device *=
pdev)
>  		return -ENOMEM;
> =20
>  	st =3D iio_priv(iodev);
> +	mutex_init(&st->lock);
> =20
>  	st->adc_base =3D devm_ioremap(&pdev->dev, res->start,
>  				    resource_size(res));

