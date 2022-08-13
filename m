Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF10C591BF6
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiHMQP0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiHMQPZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 12:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E7101D0
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 09:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62C3260F14
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 16:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2CEC433D6;
        Sat, 13 Aug 2022 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660407322;
        bh=G/8EiDP7RDjwRkmzePKxhezdoXOOHqjwIYlb9dDnptE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lX/MefpaHgtU/vVnaKvhpezHu5kdQwByF1BGLlDvTnLqHLAbCojqaox6RniJEpgPx
         43ci0K3NOYxoxfcA5SgyNV0QaywQvjqLN8H7SvEvd8f/7oFk1iCHn0HfMepzFx6aNd
         doicQJx9YhM3C3UUiSbIErU7eX1tSbVcGi6JxcVn8CVDXFXDINjqQ9dFUic6d/baG/
         RooLr4+n8JAUkdhTrCImTSuJxCBr1eTs/N19fiDR1UI6yJxYQtNxx7ELKju2lytBpD
         crbu4iSgVA/Yru2bouySLRsYpC7P4EFb1dy3bE7XQpsFnISMfOwVK7FVkhR8Rt+Suw
         kyys6jh8OgV9w==
Date:   Sat, 13 Aug 2022 17:25:49 +0100
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
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 05/13] iio: adc: lpc18xx: Benefit from
 devm_clk_get_enabled() to simplify
Message-ID: <20220813172549.015c19fe@jic23-huawei>
In-Reply-To: <20220808204740.307667-5-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
        <20220808204740.307667-5-u.kleine-koenig@pengutronix.de>
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

On Mon,  8 Aug 2022 22:47:32 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Make use of devm_clk_get_enabled() to replace some code that effectively
> open codes this new function.
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
This makes me very slightly nervous because it juggles the order of
clock enabling and powering up the device (potentially anyway).
It's always possible that will cause problems - though I think it
is unlikely (and would cause all sorts of problems if someone
used a fixed regulator or clock) to I'm applying this anyway.

> ---
>  drivers/iio/adc/lpc18xx_adc.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>=20
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

