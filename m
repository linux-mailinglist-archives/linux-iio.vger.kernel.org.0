Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501AD5E8DCF
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 17:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIXPY3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 11:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIXPYT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 11:24:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7878B19C06
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12F5061347
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 15:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E98AC433D6;
        Sat, 24 Sep 2022 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664033057;
        bh=1gU88OznqaSWekwuxOljVASWVDCEECwP7hlnsm3KYxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hnm6vfhU/N7dfe3NIpZ49rKxs3MqJXnXw+iVVBWr+yP9VAY63FN9TNbqoyidgU/Va
         PKUdViywZtBMeUUusa01YT7ZMNh43kdgSi501FFfj9YaQT5HwA7QijzoKq+kwArvmn
         qAvdApyg365QYCRSOzXrNySVOcXXkJALyoKdV+sv1agMGJJ1XjXGj0Lech990NOX8y
         QRAbS0tsI2zQHxOf1IZBjGVhVCZwXVSopWtf3ODV6XeRNp6BqWe67unkgdgGG136WO
         TFlfaiUONuNrgxiimU2oF7CIkSmT5bodwGaPLv+EGMDZPUt7PNIBPk2RCEXMUzetr4
         9BEFxaHppt1DA==
Date:   Sat, 24 Sep 2022 16:24:19 +0100
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
Subject: Re: [PATCH 03/15] iio: adc: axp288_adc: do not use internal iio_dev
 lock
Message-ID: <20220924162419.341bbe85@jic23-huawei>
In-Reply-To: <20220920112821.975359-4-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-4-nuno.sa@analog.com>
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

On Tue, 20 Sep 2022 13:28:09 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Looks good. Not sure how we missed cleaning this one up earlier
given how simple it is!  Anyhow, given Andy's feedback I'll wait for v2
to pick this up.

> ---
>  drivers/iio/adc/axp288_adc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index 580361bd9849..3bbb96156739 100644
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
> +	mutex_init(&info->lock);
>  	info->irq =3D platform_get_irq(pdev, 0);
>  	if (info->irq < 0)
>  		return info->irq;

