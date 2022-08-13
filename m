Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE3591BFE
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 18:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiHMQVU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 12:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiHMQVS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 12:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB05212AE0
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 09:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 450B660F08
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 16:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03EDC433C1;
        Sat, 13 Aug 2022 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660407676;
        bh=GtzvwxITfPLaHPfd/q58nqomQnmVBfLdEmnWvuhQ64k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A8sCRkPoJkBKpU/d6oqkwRz0cZY6wF4BnSq8DKkPqd/hmlc802RUbhD9xfgSigwcy
         zq6NAL3AXBuzLkX+TpI8yqtLx0BIZIxd6q5Gg7iazLAWWxilOOZBlvw16p/ya/SNy4
         tz+07cvTdyzUx7Y5alnqsqtuFnEgUkuqFqlbnsgwypIg0W1JVcR3sz7V1gf+heinty
         IhQk2pUGmIcRTGpjSqCSyqR7lKctm61QNYFNlTaJzRqENOcH5zVobHsKZFR4FgcQ0/
         LaNBU7nOjYe3TUHPW9FXT+BnqwYi46iqhS6CA0ilrjO0332nSI0CM6UHPVeWIytCfm
         T0XwOlj+dcRUg==
Date:   Sat, 13 Aug 2022 17:31:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>,
        David Wu <david.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH 06/13] iio: adc: rockchip_saradc: Benefit from
 devm_clk_get_enabled() to simplify
Message-ID: <20220813173142.76774c97@jic23-huawei>
In-Reply-To: <20220808204740.307667-6-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
        <20220808204740.307667-6-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  8 Aug 2022 22:47:33 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Make use of devm_clk_get_enabled() to replace some code that effectively
> open codes this new function.
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

This might have side effects as it now enables the clock before calling
the clk_set_rate(). Also changes the clock start up ordering. Neither is th=
at
scary a change, but on really fussy hardware they might cause problems.

Add a few rock-chips people who have sent patches in last few years
to hopefully take a look or even better run a test.

Thanks,

Jonathan
=09
> ---
>  drivers/iio/adc/rockchip_saradc.c | 44 ++-----------------------------
>  1 file changed, 2 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip=
_saradc.c
> index b87ea7148b58..db1190faa223 100644
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

