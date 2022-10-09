Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC15F8B0A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJIMAz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJIMAy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 08:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18CA1B785
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 05:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D12760AF9
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 12:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57488C433C1;
        Sun,  9 Oct 2022 12:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316851;
        bh=sN+kF6C+YhnLb6iLjckXMy96iv0cGNwR/siab64Qy1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zdqx9QUOcjLyeatSrxTPUMWh5MJCz+kTvmeqh4MpJsygUr0csiVw6iaHHNGtE2nKk
         OcGoE7BX87kK9RvH5ghLJLNmlQvNZsas8hxC+0utnlLa9M864ZBgJ0Jv31zTQk54fx
         kJdA0E9y9ZHNOpBTLN8VRnf7XNfIqYC1Y1C0AIyj6MbANffJZsU7pgr++Zj6MWn9Bq
         43mVqCHtQ5BSRrAbBSyrFmnB6bFT2DTSCVeHsVGdCn4+LN//r749/IT15aYDBKoAo7
         ge/WQwdw5NFDOJUaOz5olBDiayo5gQzC5jdASudXwFOn7Xr8OGinSplaR0gRS2CY0D
         0rqq9PZiVi7Mg==
Date:   Sun, 9 Oct 2022 13:01:08 +0100
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
Subject: Re: [PATCH v2 06/16] iio: adc: meson_saradc: do not use internal
 iio_dev lock
Message-ID: <20221009130108.0d8b412c@jic23-huawei>
In-Reply-To: <20221004134909.1692021-7-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-7-nuno.sa@analog.com>
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

On Tue, 4 Oct 2022 15:48:59 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>=20
> While at it, properly include "mutex.h" for mutex related APIs.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied to the togreg branch of iio.git and pushed out (shortly) as testing
for 0-day etc to take a look.

Note I'll be rebasing on rc1 once it's out.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_sarad=
c.c
> index 1a68b099d323..85b6826cc10c 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -12,6 +12,7 @@
>  #include <linux/io.h>
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
> @@ -276,6 +277,8 @@ struct meson_sar_adc_priv {
>  	struct clk				*adc_div_clk;
>  	struct clk_divider			clk_div;
>  	struct completion			done;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex				lock;
>  	int					calibbias;
>  	int					calibscale;
>  	struct regmap				*tsc_regmap;
> @@ -486,7 +489,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_d=
ev)
>  	struct meson_sar_adc_priv *priv =3D iio_priv(indio_dev);
>  	int val, ret;
> =20
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&priv->lock);
> =20
>  	if (priv->param->has_bl30_integration) {
>  		/* prevent BL30 from using the SAR ADC while we are using it */
> @@ -504,7 +507,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_d=
ev)
>  						      !(val & MESON_SAR_ADC_DELAY_BL30_BUSY),
>  						      1, 10000);
>  		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&priv->lock);
>  			return ret;
>  		}
>  	}
> @@ -521,7 +524,7 @@ static void meson_sar_adc_unlock(struct iio_dev *indi=
o_dev)
>  		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
>  				   MESON_SAR_ADC_DELAY_KERNEL_BUSY, 0);
> =20
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&priv->lock);
>  }
> =20
>  static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
> @@ -1250,6 +1253,8 @@ static int meson_sar_adc_probe(struct platform_devi=
ce *pdev)
>  	if (ret)
>  		goto err;
> =20
> +	mutex_init(&priv->lock);
> +
>  	ret =3D meson_sar_adc_hw_enable(indio_dev);
>  	if (ret)
>  		goto err;

