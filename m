Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2710F78A04E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjH0QxP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 12:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjH0QxA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 12:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F6F126
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 09:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C88A6121E
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 16:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B094C433C7;
        Sun, 27 Aug 2023 16:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693155174;
        bh=sNPfudDErK++d7E2enryhljjTmiFLGuh6TImRz1WxYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l7m2gkifymT7uGqhCuNQLDxnbtd28vjVzXSbSKaQWOmG77AC68virfbpeS3bqtkz1
         TVGfMZom+S1p5LMsP+075CEWaja9s7oT2yzvuCErd9M6EN1rhzJnwuagzaZDBmBcec
         2eIouUnfp9OY8OiJtNJMH2Dsa9YKH1CEAn0WMHMnNFDkGKvZFPu3hcgCeeXkp+7u/T
         bPoD84l/OcpRdcJ+ImCviPrxgBcQ3Vy61zRLcXT+AuHV0QATXwgUIcmQw8pbrxEj+9
         XyXSYu3UFKvNa+6SJFrarDiodJartk09p1AHvl83niDEGwRXkgzXdB1qcm03F6GN5C
         9uCyceuz6XUWw==
Date:   Sun, 27 Aug 2023 17:53:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH -next v2] iio: frequency: adf4350: Use device managed
 functions
Message-ID: <20230827175315.4e1c96ed@jic23-huawei>
In-Reply-To: <20230826064131.3773530-1-ruanjinjie@huawei.com>
References: <20230826064131.3773530-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Aug 2023 14:41:30 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> Also replace devm_regulator_get() and regulator_enable() with
> devm_regulator_get_enable() helper and remove regulator_disable().
> 
> Replace iio_device_register() with devm_iio_device_register() and remove
> iio_device_unregister().
> 
> And st->reg is not used anymore, so remove it.
> 
> This simplifies the code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>

Hi Jinjie,

This patch has exposed what looks like a minor bug to me in the existing code.
I think we should fix that as part of your changes. It's an obscure enough race
condition and lack of powering down on error, that I don't think we need to
separate the fix out from the main patch.

The short description (more inline) is register an additional devm callback
to set the device into software controlled power down mode after the device
is unregistered (and equivalent in the error path.)

Sorry this turned out to be more complex than expected!

Thanks,

Jonathan
 
> ---
> v2:
> - Also use devm_regulator_get_enable() and devm_iio_device_register().
> - Update the commit message and title.
> ---
>  drivers/iio/frequency/adf4350.c | 52 ++++++++-------------------------
>  1 file changed, 12 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 85e289700c3c..b38d024529eb 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -33,7 +33,6 @@ enum {
>  
>  struct adf4350_state {
>  	struct spi_device		*spi;
> -	struct regulator		*reg;
>  	struct gpio_desc		*lock_detect_gpiod;
>  	struct adf4350_platform_data	*pdata;
>  	struct clk			*clk;
> @@ -491,29 +490,20 @@ static int adf4350_probe(struct spi_device *spi)
>  	}
>  
>  	if (!pdata->clkin) {
> -		clk = devm_clk_get(&spi->dev, "clkin");
> +		clk = devm_clk_get_enabled(&spi->dev, "clkin");
>  		if (IS_ERR(clk))
> -			return -EPROBE_DEFER;
> -
> -		ret = clk_prepare_enable(clk);
> -		if (ret < 0)
> -			return ret;
> +			return PTR_ERR(clk);
>  	}
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (indio_dev == NULL) {
> -		ret =  -ENOMEM;
> -		goto error_disable_clk;
> -	}
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->reg = devm_regulator_get(&spi->dev, "vcc");
> -	if (!IS_ERR(st->reg)) {
> -		ret = regulator_enable(st->reg);
> -		if (ret)
> -			goto error_disable_clk;
> -	}
> +	ret = devm_regulator_get_enable(&spi->dev, "vcc");
> +	if (ret)
> +		return ret;
>  
>  	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
> @@ -544,47 +534,29 @@ static int adf4350_probe(struct spi_device *spi)
>  
>  	st->lock_detect_gpiod = devm_gpiod_get_optional(&spi->dev, NULL,
>  							GPIOD_IN);
> -	if (IS_ERR(st->lock_detect_gpiod)) {
> -		ret = PTR_ERR(st->lock_detect_gpiod);
> -		goto error_disable_reg;
> -	}
> +	if (IS_ERR(st->lock_detect_gpiod))
> +		return PTR_ERR(st->lock_detect_gpiod);
>  
>  	if (pdata->power_up_frequency) {
>  		ret = adf4350_set_freq(st, pdata->power_up_frequency);
>  		if (ret)
> -			goto error_disable_reg;
> +			return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
> -		goto error_disable_reg;
> +		return ret;
>  
>  	return 0;
> -
> -error_disable_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_disable(st->reg);
> -error_disable_clk:
> -	clk_disable_unprepare(clk);
> -
> -	return ret;
>  }
>  
>  static void adf4350_remove(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	struct adf4350_state *st = iio_priv(indio_dev);
> -	struct regulator *reg = st->reg;
>  
>  	st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
>  	adf4350_sync_config(st);

Unfortunately this shouts "bug" at me.  Nothing to do with your change
as such, but it's made a lot more obvious by it.

Couple of things that are wrong.

1) The device is powered down 'before' we unregister it with the
   subsystem and as such userspace interfaces are still exposed which
   probably won't do the right thing if the chip is powered down.

2) This isn't done in the error paths in probe.

The actual register update here "sort of" balances (in a fairly non obvious fashion)
one in adf4350_set_freq() so I would register a new callback with devm_add_action_or_reset()
after this block
  	if (pdata->power_up_frequency) {
 		ret = adf4350_set_freq(st, pdata->power_up_frequency);
  		if (ret)
 +			return ret;
  	}
(here)

that runs
  	st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
  	adf4350_sync_config(st);

in both error and remove paths.  Doing that will let us get
rid of the remove function completely.


> -
> -	iio_device_unregister(indio_dev);
> -
> -	clk_disable_unprepare(st->clk);
> -
> -	if (!IS_ERR(reg))
> -		regulator_disable(reg);
>  }
>  
>  static const struct of_device_id adf4350_of_match[] = {

