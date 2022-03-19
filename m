Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FFF4DE9F8
	for <lists+linux-iio@lfdr.de>; Sat, 19 Mar 2022 19:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiCSSQq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Mar 2022 14:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiCSSQp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Mar 2022 14:16:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1371AA04C;
        Sat, 19 Mar 2022 11:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2FCBB80D9B;
        Sat, 19 Mar 2022 18:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14046C340EC;
        Sat, 19 Mar 2022 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647713720;
        bh=Dhv4HLH1QHUCsAquZQFUITV9pIdJgaLXe9+CyyHB74c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H08MB0ENRogV7LsrFRueTqSGzFgC3+bvd8xOpGbvJFQ1lliTW9pAU+dHvKwIZoD1F
         qedZiVvB40INGtMHeJ5hbDzPHpS8Ty2I5IFHqS8zc6A5rHUYpHRiO951KaOfHjvTpF
         9Af0c/w4VyR0n7wou7FJ7EFY3YNqt8u8a3zLQv18Tbf16PYOTsrVO9wHjfedKNSFUz
         VIMdowoJNCg2zYpkRCF/Lf43UbppJDI97C77XWXRqmaypCtqSz6B2n72dgavrJLxRO
         mGoO/8R+i9VSocykRCVrJcswg+i7lsgmvXOrQYVxqpNO6AIlxvpCk8n2oXeXlMPk0u
         oU9RC4ty2PaSQ==
Date:   Sat, 19 Mar 2022 18:22:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Nuno Sa <nuno.sa@analog.com>,
        =?UTF-8?B?QW5kcsOp?= Gustavo Nakagomi Lopez <andregnl@usp.br>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 04/16] iio: Make use of devm_clk_get_enabled()
Message-ID: <20220319182240.30456776@jic23-huawei>
In-Reply-To: <20220314141643.22184-5-u.kleine-koenig@pengutronix.de>
References: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
        <20220314141643.22184-5-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Mar 2022 15:16:31 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Several drivers manually register a devm handler to disable their clk.
> Convert them to devm_clk_get_enabled().
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If this does get picked up, can who ever does it please provide
an immutable branch. With some many drivers cleaned up, it's very
likely to cause some merge fun somewhere otherwise.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c           | 15 +---------
>  drivers/iio/adc/ad7768-1.c         | 17 +-----------
>  drivers/iio/adc/ad9467.c           | 17 +-----------
>  drivers/iio/adc/ingenic-adc.c      | 15 ++--------
>  drivers/iio/adc/lpc18xx_adc.c      | 18 +-----------
>  drivers/iio/adc/rockchip_saradc.c  | 44 ++----------------------------
>  drivers/iio/adc/ti-ads131e08.c     | 19 +------------
>  drivers/iio/adc/xilinx-ams.c       | 15 +---------
>  drivers/iio/adc/xilinx-xadc-core.c | 18 +-----------
>  drivers/iio/frequency/adf4371.c    | 17 +-----------
>  drivers/iio/frequency/admv1013.c   | 15 +---------
>  drivers/iio/frequency/adrf6780.c   | 16 +----------
>  drivers/iio/imu/adis16475.c        | 15 +---------
>  13 files changed, 15 insertions(+), 226 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index b400bbe291aa..fcfa4e0b41fb 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -862,11 +862,6 @@ static void ad7124_reg_disable(void *r)
>  	regulator_disable(r);
>  }
> =20
> -static void ad7124_clk_disable(void *c)
> -{
> -	clk_disable_unprepare(c);
> -}
> -
>  static int ad7124_probe(struct spi_device *spi)
>  {
>  	const struct ad7124_chip_info *info;
> @@ -917,18 +912,10 @@ static int ad7124_probe(struct spi_device *spi)
>  			return ret;
>  	}
> =20
> -	st->mclk =3D devm_clk_get(&spi->dev, "mclk");
> +	st->mclk =3D devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))
>  		return PTR_ERR(st->mclk);
> =20
> -	ret =3D clk_prepare_enable(st->mclk);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, ad7124_clk_disable, st->mcl=
k);
> -	if (ret)
> -		return ret;
> -
>  	ret =3D ad7124_soft_reset(st);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index aa42ba759fa1..8ae34ed8fabd 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -539,13 +539,6 @@ static void ad7768_regulator_disable(void *data)
>  	regulator_disable(st->vref);
>  }
> =20
> -static void ad7768_clk_disable(void *data)
> -{
> -	struct ad7768_state *st =3D data;
> -
> -	clk_disable_unprepare(st->mclk);
> -}
> -
>  static int ad7768_set_channel_label(struct iio_dev *indio_dev,
>  						int num_channels)
>  {
> @@ -600,18 +593,10 @@ static int ad7768_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> =20
> -	st->mclk =3D devm_clk_get(&spi->dev, "mclk");
> +	st->mclk =3D devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))
>  		return PTR_ERR(st->mclk);
> =20
> -	ret =3D clk_prepare_enable(st->mclk);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, ad7768_clk_disable, st);
> -	if (ret)
> -		return ret;
> -
>  	st->mclk_freq =3D clk_get_rate(st->mclk);
> =20
>  	mutex_init(&st->lock);
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index dbfc8517cb8a..a07df0fd3329 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -378,13 +378,6 @@ static int ad9467_preenable_setup(struct adi_axi_adc=
_conv *conv)
>  	return ad9467_outputmode_set(st->spi, st->output_mode);
>  }
> =20
> -static void ad9467_clk_disable(void *data)
> -{
> -	struct ad9467_state *st =3D data;
> -
> -	clk_disable_unprepare(st->clk);
> -}
> -
>  static int ad9467_probe(struct spi_device *spi)
>  {
>  	const struct ad9467_chip_info *info;
> @@ -404,18 +397,10 @@ static int ad9467_probe(struct spi_device *spi)
>  	st =3D adi_axi_adc_conv_priv(conv);
>  	st->spi =3D spi;
> =20
> -	st->clk =3D devm_clk_get(&spi->dev, "adc-clk");
> +	st->clk =3D devm_clk_get_enabled(&spi->dev, "adc-clk");
>  	if (IS_ERR(st->clk))
>  		return PTR_ERR(st->clk);
> =20
> -	ret =3D clk_prepare_enable(st->clk);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, ad9467_clk_disable, st);
> -	if (ret)
> -		return ret;
> -
>  	st->pwrdown_gpio =3D devm_gpiod_get_optional(&spi->dev, "powerdown",
>  						   GPIOD_OUT_LOW);
>  	if (IS_ERR(st->pwrdown_gpio))
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index 2b3912c6ca6b..b6433bcd53f5 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -732,11 +732,6 @@ static int ingenic_adc_of_xlate(struct iio_dev *iio_=
dev,
>  	return -EINVAL;
>  }
> =20
> -static void ingenic_adc_clk_cleanup(void *data)
> -{
> -	clk_unprepare(data);
> -}
> -
>  static const struct iio_info ingenic_adc_info =3D {
>  	.write_raw =3D ingenic_adc_write_raw,
>  	.read_raw =3D ingenic_adc_read_raw,
> @@ -856,13 +851,13 @@ static int ingenic_adc_probe(struct platform_device=
 *pdev)
>  	if (IS_ERR(adc->base))
>  		return PTR_ERR(adc->base);
> =20
> -	adc->clk =3D devm_clk_get(dev, "adc");
> +	adc->clk =3D devm_clk_get_prepared(dev, "adc");
>  	if (IS_ERR(adc->clk)) {
>  		dev_err(dev, "Unable to get clock\n");
>  		return PTR_ERR(adc->clk);
>  	}
> =20
> -	ret =3D clk_prepare_enable(adc->clk);
> +	ret =3D clk_enable(adc->clk);
>  	if (ret) {
>  		dev_err(dev, "Failed to enable clock\n");
>  		return ret;
> @@ -891,12 +886,6 @@ static int ingenic_adc_probe(struct platform_device =
*pdev)
>  	usleep_range(2000, 3000); /* Must wait at least 2ms. */
>  	clk_disable(adc->clk);
> =20
> -	ret =3D devm_add_action_or_reset(dev, ingenic_adc_clk_cleanup, adc->clk=
);
> -	if (ret) {
> -		dev_err(dev, "Unable to add action\n");
> -		return ret;
> -	}
> -
>  	iio_dev->name =3D "jz-adc";
>  	iio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>  	iio_dev->setup_ops =3D &ingenic_buffer_setup_ops;
> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> index ae9c9384f23e..8bbc18aaa474 100644
> --- a/drivers/iio/adc/lpc18xx_adc.c
> +++ b/drivers/iio/adc/lpc18xx_adc.c
> @@ -122,11 +122,6 @@ static void lpc18xx_clear_cr_reg(void *data)
>  	writel(0, adc->base + LPC18XX_ADC_CR);
>  }
> =20
> -static void lpc18xx_clk_disable(void *clk)
> -{
> -	clk_disable_unprepare(clk);
> -}
> -
>  static void lpc18xx_regulator_disable(void *vref)
>  {
>  	regulator_disable(vref);
> @@ -152,7 +147,7 @@ static int lpc18xx_adc_probe(struct platform_device *=
pdev)
>  	if (IS_ERR(adc->base))
>  		return PTR_ERR(adc->base);
> =20
> -	adc->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	adc->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(adc->clk))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
>  				     "error getting clock\n");
> @@ -178,17 +173,6 @@ static int lpc18xx_adc_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D clk_prepare_enable(adc->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "unable to enable clock\n");
> -		return ret;
> -	}
> -
> -	ret =3D devm_add_action_or_reset(&pdev->dev, lpc18xx_clk_disable,
> -				       adc->clk);
> -	if (ret)
> -		return ret;
> -
>  	rate =3D clk_get_rate(adc->clk);
>  	clkdiv =3D DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
> =20
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip=
_saradc.c
> index 14b8df4ca9c8..0a053e8b2483 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -233,20 +233,6 @@ static void rockchip_saradc_reset_controller(struct =
reset_control *reset)
>  	reset_control_deassert(reset);
>  }
> =20
> -static void rockchip_saradc_clk_disable(void *data)
> -{
> -	struct rockchip_saradc *info =3D data;
> -
> -	clk_disable_unprepare(info->clk);
> -}
> -
> -static void rockchip_saradc_pclk_disable(void *data)
> -{
> -	struct rockchip_saradc *info =3D data;
> -
> -	clk_disable_unprepare(info->pclk);
> -}
> -
>  static void rockchip_saradc_regulator_disable(void *data)
>  {
>  	struct rockchip_saradc *info =3D data;
> @@ -380,12 +366,12 @@ static int rockchip_saradc_probe(struct platform_de=
vice *pdev)
>  		return ret;
>  	}
> =20
> -	info->pclk =3D devm_clk_get(&pdev->dev, "apb_pclk");
> +	info->pclk =3D devm_clk_get_enabled(&pdev->dev, "apb_pclk");
>  	if (IS_ERR(info->pclk))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(info->pclk),
>  				     "failed to get pclk\n");
> =20
> -	info->clk =3D devm_clk_get(&pdev->dev, "saradc");
> +	info->clk =3D devm_clk_get_enabled(&pdev->dev, "saradc");
>  	if (IS_ERR(info->clk))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
>  				     "failed to get adc clock\n");
> @@ -427,32 +413,6 @@ static int rockchip_saradc_probe(struct platform_dev=
ice *pdev)
> =20
>  	info->uv_vref =3D ret;
> =20
> -	ret =3D clk_prepare_enable(info->pclk);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to enable pclk\n");
> -		return ret;
> -	}
> -	ret =3D devm_add_action_or_reset(&pdev->dev,
> -				       rockchip_saradc_pclk_disable, info);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	ret =3D clk_prepare_enable(info->clk);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to enable converter clock\n");
> -		return ret;
> -	}
> -	ret =3D devm_add_action_or_reset(&pdev->dev,
> -				       rockchip_saradc_clk_disable, info);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> -			ret);
> -		return ret;
> -	}
> -
>  	platform_set_drvdata(pdev, indio_dev);
> =20
>  	indio_dev->name =3D dev_name(&pdev->dev);
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e0=
8.c
> index 0c2025a22575..7d7a8f0d3ab5 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -793,13 +793,6 @@ static void ads131e08_regulator_disable(void *data)
>  	regulator_disable(st->vref_reg);
>  }
> =20
> -static void ads131e08_clk_disable(void *data)
> -{
> -	struct ads131e08_state *st =3D data;
> -
> -	clk_disable_unprepare(st->adc_clk);
> -}
> -
>  static int ads131e08_probe(struct spi_device *spi)
>  {
>  	const struct ads131e08_info *info;
> @@ -892,21 +885,11 @@ static int ads131e08_probe(struct spi_device *spi)
>  		st->vref_reg =3D NULL;
>  	}
> =20
> -	st->adc_clk =3D devm_clk_get(&spi->dev, "adc-clk");
> +	st->adc_clk =3D devm_clk_get_enabled(&spi->dev, "adc-clk");
>  	if (IS_ERR(st->adc_clk))
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->adc_clk),
>  				     "failed to get the ADC clock\n");
> =20
> -	ret =3D clk_prepare_enable(st->adc_clk);
> -	if (ret) {
> -		dev_err(&spi->dev, "failed to prepare/enable the ADC clock\n");
> -		return ret;
> -	}
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, ads131e08_clk_disable, st);
> -	if (ret)
> -		return ret;
> -
>  	adc_clk_hz =3D clk_get_rate(st->adc_clk);
>  	if (!adc_clk_hz) {
>  		dev_err(&spi->dev, "failed to get the ADC clock rate\n");
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 8343c5f74121..4e4f0c80db54 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1343,11 +1343,6 @@ static const struct of_device_id ams_of_match_tabl=
e[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, ams_of_match_table);
> =20
> -static void ams_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static void ams_cancel_delayed_work(void *data)
>  {
>  	cancel_delayed_work(data);
> @@ -1377,18 +1372,10 @@ static int ams_probe(struct platform_device *pdev)
>  	if (IS_ERR(ams->base))
>  		return PTR_ERR(ams->base);
> =20
> -	ams->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	ams->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(ams->clk))
>  		return PTR_ERR(ams->clk);
> =20
> -	ret =3D clk_prepare_enable(ams->clk);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(&pdev->dev, ams_clk_disable_unprepare,=
 ams->clk);
> -	if (ret < 0)
> -		return ret;
> -
>  	INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
>  	ret =3D devm_add_action_or_reset(&pdev->dev, ams_cancel_delayed_work,
>  				       &ams->ams_unmask_work);
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-=
xadc-core.c
> index 823c8e5f9809..a520e07e4e08 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1299,13 +1299,6 @@ static const char * const xadc_type_names[] =3D {
>  	[XADC_TYPE_US] =3D "xilinx-system-monitor",
>  };
> =20
> -static void xadc_clk_disable_unprepare(void *data)
> -{
> -	struct clk *clk =3D data;
> -
> -	clk_disable_unprepare(clk);
> -}
> -
>  static void xadc_cancel_delayed_work(void *data)
>  {
>  	struct delayed_work *work =3D data;
> @@ -1383,19 +1376,10 @@ static int xadc_probe(struct platform_device *pde=
v)
>  		}
>  	}
> =20
> -	xadc->clk =3D devm_clk_get(dev, NULL);
> +	xadc->clk =3D devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(xadc->clk))
>  		return PTR_ERR(xadc->clk);
> =20
> -	ret =3D clk_prepare_enable(xadc->clk);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(dev,
> -				       xadc_clk_disable_unprepare, xadc->clk);
> -	if (ret)
> -		return ret;
> -
>  	/*
>  	 * Make sure not to exceed the maximum samplerate since otherwise the
>  	 * resulting interrupt storm will soft-lock the system.
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4=
371.c
> index ecd5e18995ad..54040b5fded0 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -540,13 +540,6 @@ static int adf4371_setup(struct adf4371_state *st)
>  	return regmap_bulk_write(st->regmap, ADF4371_REG(0x30), st->buf, 5);
>  }
> =20
> -static void adf4371_clk_disable(void *data)
> -{
> -	struct adf4371_state *st =3D data;
> -
> -	clk_disable_unprepare(st->clkin);
> -}
> -
>  static int adf4371_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id =3D spi_get_device_id(spi);
> @@ -579,18 +572,10 @@ static int adf4371_probe(struct spi_device *spi)
>  	indio_dev->channels =3D st->chip_info->channels;
>  	indio_dev->num_channels =3D st->chip_info->num_channels;
> =20
> -	st->clkin =3D devm_clk_get(&spi->dev, "clkin");
> +	st->clkin =3D devm_clk_get_enabled(&spi->dev, "clkin");
>  	if (IS_ERR(st->clkin))
>  		return PTR_ERR(st->clkin);
> =20
> -	ret =3D clk_prepare_enable(st->clkin);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, adf4371_clk_disable, st);
> -	if (ret)
> -		return ret;
> -
>  	st->clkin_freq =3D clk_get_rate(st->clkin);
> =20
>  	ret =3D adf4371_setup(st);
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/adm=
v1013.c
> index 3f3c478e9baa..b3e7eb322ade 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -490,11 +490,6 @@ static int admv1013_init(struct admv1013_state *st)
>  					  st->input_mode);
>  }
> =20
> -static void admv1013_clk_disable(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static void admv1013_reg_disable(void *data)
>  {
>  	regulator_disable(data);
> @@ -559,7 +554,7 @@ static int admv1013_properties_parse(struct admv1013_=
state *st)
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
>  				     "failed to get the common-mode voltage\n");
> =20
> -	st->clkin =3D devm_clk_get(&spi->dev, "lo_in");
> +	st->clkin =3D devm_clk_get_enabled(&spi->dev, "lo_in");
>  	if (IS_ERR(st->clkin))
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
>  				     "failed to get the LO input clock\n");
> @@ -601,14 +596,6 @@ static int admv1013_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D clk_prepare_enable(st->clkin);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, admv1013_clk_disable, st->c=
lkin);
> -	if (ret)
> -		return ret;
> -
>  	st->nb.notifier_call =3D admv1013_freq_change;
>  	ret =3D devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
>  	if (ret)
> diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adr=
f6780.c
> index 8255ffd174f6..d7bf34ceedd8 100644
> --- a/drivers/iio/frequency/adrf6780.c
> +++ b/drivers/iio/frequency/adrf6780.c
> @@ -441,11 +441,6 @@ static void adrf6780_properties_parse(struct adrf678=
0_state *st)
>  	st->vdet_out_en =3D device_property_read_bool(&spi->dev, "adi,vdet-out-=
en");
>  }
> =20
> -static void adrf6780_clk_disable(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static void adrf6780_powerdown(void *data)
>  {
>  	/* Disable all components in the Enable Register */
> @@ -473,20 +468,11 @@ static int adrf6780_probe(struct spi_device *spi)
> =20
>  	adrf6780_properties_parse(st);
> =20
> -	st->clkin =3D devm_clk_get(&spi->dev, "lo_in");
> +	st->clkin =3D devm_clk_get_enabled(&spi->dev, "lo_in");
>  	if (IS_ERR(st->clkin))
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
>  				     "failed to get the LO input clock\n");
> =20
> -	ret =3D clk_prepare_enable(st->clkin);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, adrf6780_clk_disable,
> -				       st->clkin);
> -	if (ret)
> -		return ret;
> -
>  	mutex_init(&st->lock);
> =20
>  	ret =3D adrf6780_init(st);
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index ea91d127077d..45a8765d7c16 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1120,11 +1120,6 @@ static irqreturn_t adis16475_trigger_handler(int i=
rq, void *p)
>  	return IRQ_HANDLED;
>  }
> =20
> -static void adis16475_disable_clk(void *data)
> -{
> -	clk_disable_unprepare((struct clk *)data);
> -}
> -
>  static int adis16475_config_sync_mode(struct adis16475 *st)
>  {
>  	int ret;
> @@ -1150,19 +1145,11 @@ static int adis16475_config_sync_mode(struct adis=
16475 *st)
> =20
>  	/* All the other modes require external input signal */
>  	if (sync->sync_mode !=3D ADIS16475_SYNC_OUTPUT) {
> -		struct clk *clk =3D devm_clk_get(dev, NULL);
> +		struct clk *clk =3D devm_clk_get_enabled(dev, NULL);
> =20
>  		if (IS_ERR(clk))
>  			return PTR_ERR(clk);
> =20
> -		ret =3D clk_prepare_enable(clk);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D devm_add_action_or_reset(dev, adis16475_disable_clk, clk);
> -		if (ret)
> -			return ret;
> -
>  		st->clk_freq =3D clk_get_rate(clk);
>  		if (st->clk_freq < sync->min_rate ||
>  		    st->clk_freq > sync->max_rate) {

