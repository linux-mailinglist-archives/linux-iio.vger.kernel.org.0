Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B02591C02
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiHMQ3Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiHMQ3X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 12:29:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D890B13F6D
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 09:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96C08B800E2
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 16:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A549EC433C1;
        Sat, 13 Aug 2022 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660408160;
        bh=OZuItq6QJ9blBttuqCh21pdsOMLqjl5HZVqbr4Tul+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ukxfN3Zw4066EetUkpZDB2D46GBR1TGO2hICapcAaB4+2228lQsOnXqzVMKAD7zKD
         5zI8mn14Fes0Rbrm5/7qum9x7pvWjperPcgJB7oGiTVAgVqRjiXot6BFqSSU97ETgW
         LDpBC4QpjtaH7kAfCvp8CTNsJjH7UOZO7szlxE1POxY/9uTLKNEYGJZURxI1qGPpZ7
         Pz+SNkymvfgu64aTChINsgV7XLla3+wJQTv79Sv3NMQn6aC5rfRSuQaZcmZz4f88E3
         /VpkL/KWaogbwTbBY9PxU2YdXiPx4SCW0k/xtdAkL73zx+lFoeA6mH1ublSOPTNuNW
         I3lAKNyleBHMQ==
Date:   Sat, 13 Aug 2022 17:39:46 +0100
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
Subject: Re: [PATCH 01/13] iio: adc: ad7124: Benefit from
 devm_clk_get_enabled() to simplify
Message-ID: <20220813173946.74029e09@jic23-huawei>
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
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

On Mon,  8 Aug 2022 22:47:28 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> Make use of devm_clk_get_enabled() to replace some code that effectively
> open codes this new function.
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Always good to have a cover letter on series with lots of patches.
If nothing else it gives somewhere for replies to the whole series.

I'm a bit nervous about the ordering changes in 6 and 11 so want
to give those a little more time to get review.

Applied all the rest to what will be the togreg branch of iio.git
after a rebase on rc1.  For now pushed out as testing for 0-day
to see if it can find any problems we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index c5b785d8b241..4088786e1026 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -936,11 +936,6 @@ static void ad7124_reg_disable(void *r)
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
> @@ -993,18 +988,10 @@ static int ad7124_probe(struct spi_device *spi)
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
>=20
> base-commit: 8b3d743fc9e2542822826890b482afabf0e7522a

