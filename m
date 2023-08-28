Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7EF78AE59
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 13:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjH1LBo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 07:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjH1LBS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 07:01:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2A619A
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 04:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B78618E8
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 11:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD9CC433C7;
        Mon, 28 Aug 2023 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693220450;
        bh=zUXWtiTa5HyO37rdNLAUgFkO6biH5P/G6jD6QYnHQ84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SHhoP5hUfFbDEgaaJpkkudPraTXYSCJyYvOrDiDQp8NiJie2YNtJXkeh1pR/Ozybn
         zPx8Qw9iQTrgN1a2p1H8c8v62lKDOBM94/609OD8/htQa4bHtRjW2TGgtJdoE3hrsW
         Ht8T4qve8xioVZv1OC5S6r+zG+bt3Cx1mOSgseu09QDV9233DRp+XbDhyYwc3qzFAS
         tPKsbT1Ji9B2PNcRLsSIm/ArT9vFQ4EWj5iagUkr1Il39UtWbK/yYOZ+hQGVxDZBPo
         WYKH2Wibp6lcwsKXDdgEmcoZX5UxP82yqnpD+Fqc3fN83ufui9EdxV2av6as1ZcyKL
         Wf/jFAavmsOKw==
Date:   Mon, 28 Aug 2023 12:01:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next v3] iio: frequency: adf4350: Use device managed
 functions and fix power down issue.
Message-ID: <20230828120110.6e4e1df2@jic23-huawei>
In-Reply-To: <20230828062717.2310219-1-ruanjinjie@huawei.com>
References: <20230828062717.2310219-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Aug 2023 14:27:16 +0800
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
> As Jonathan pointed out, couple of things that are wrong:
> 
> 1) The device is powered down 'before' we unregister it with the
>    subsystem and as such userspace interfaces are still exposed which
>    probably won't do the right thing if the chip is powered down.
> 
> 2) This isn't done in the error paths in probe.
> 
> To solve this problem, register a new callback adf4350_power_down()
> with devm_add_action_or_reset(), to enable software power down in both
> error and device detach path. So the remove function can be removed.
> 
> Remove spi_set_drvdata() from the probe function, since spi_get_drvdata()
> is not used anymore.
> 
> Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF4350/ADF4351 Wideband Synthesizers")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
Applied to the togreg branch of iio.git but only pushed out as testing for now
as I will be rebasing on rc1.  As such these won't appear in linux-next until
after the merge window has closed.

Thanks,

Jonathan

> ---
> v3:
> - Add a device managed hook to enable software power down.
> - Remove the remove function.
> - Remove the spi_set_drvdata() call in probe function.
> - Add the fix tag.
> - Update the commit message and title.
> v2:
> - Also use devm_regulator_get_enable() and devm_iio_device_register().
> - Update the commit message and title.
> ---
>  drivers/iio/frequency/adf4350.c | 77 +++++++++++----------------------
>  1 file changed, 26 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 85e289700c3c..2c17110f3b61 100644
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
> @@ -469,6 +468,15 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
>  	return pdata;
>  }
>  
> +static void adf4350_power_down(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct adf4350_state *st = iio_priv(indio_dev);
> +
> +	st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
> +	adf4350_sync_config(st);
> +}
> +
>  static int adf4350_probe(struct spi_device *spi)
>  {
>  	struct adf4350_platform_data *pdata;
> @@ -491,31 +499,21 @@ static int adf4350_probe(struct spi_device *spi)
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
> -	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
>  	st->pdata = pdata;
>  
> @@ -544,47 +542,25 @@ static int adf4350_probe(struct spi_device *spi)
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
> +	ret = devm_add_action_or_reset(&spi->dev, adf4350_power_down, indio_dev);
>  	if (ret)
> -		goto error_disable_reg;
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to add action to managed power down\n");
>  
> -	return 0;
> -
> -error_disable_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_disable(st->reg);
> -error_disable_clk:
> -	clk_disable_unprepare(clk);
> -
> -	return ret;
> -}
> -
> -static void adf4350_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct adf4350_state *st = iio_priv(indio_dev);
> -	struct regulator *reg = st->reg;
> -
> -	st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
> -	adf4350_sync_config(st);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	clk_disable_unprepare(st->clk);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		return ret;
>  
> -	if (!IS_ERR(reg))
> -		regulator_disable(reg);
> +	return 0;
>  }
>  
>  static const struct of_device_id adf4350_of_match[] = {
> @@ -607,7 +583,6 @@ static struct spi_driver adf4350_driver = {
>  		.of_match_table = adf4350_of_match,
>  	},
>  	.probe		= adf4350_probe,
> -	.remove		= adf4350_remove,
>  	.id_table	= adf4350_id,
>  };
>  module_spi_driver(adf4350_driver);

