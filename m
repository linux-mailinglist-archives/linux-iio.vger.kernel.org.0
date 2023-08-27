Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8454B78A089
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjH0Rvc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjH0RvC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 13:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924B12E
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 10:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C2DB616D0
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 17:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3C5C433C8;
        Sun, 27 Aug 2023 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693158658;
        bh=5xz3DHo3+ExcQzL2u+K582TBNT8T2t2bLx0+hhyHeY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rq5Tk1E8sKFUVkm6G+52xVFTMI+2FKZSsgG5zFjoEjWg2kaH6v0UrrqSYOEfSNWlr
         Bu2CyWnXCzvdw0lDExcrSUd/XslvOsp5Bl24LWzOfFuTT8cPPPIVqOorV8DFKc3O9e
         gJwuiwFZwNfIZDFfeoivM79lOosXGw7FffqW1aOh/4z5CalvUb+MZFnHYH+i+B9wJz
         lQun9vfgJjXZds4lKbaTr/rH3ApGD6ncnHxl2yyFuA2vWN5w5QvN1H/tJfHYV4nf9a
         zZWb0bmQYMhcn0jo6QcWGc3p9OWqMTVlXrZjf09yxW5KDHwsZehdy5dkShRH7yhRQM
         bsyPxwZEmGvXg==
Date:   Sun, 27 Aug 2023 18:51:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] staging: iio: Use devm_clk_get_enabled() helper
 function
Message-ID: <20230827185118.1fe35cc0@jic23-huawei>
In-Reply-To: <20230825095612.2972892-1-ruanjinjie@huawei.com>
References: <20230825095612.2972892-1-ruanjinjie@huawei.com>
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

On Fri, 25 Aug 2023 17:56:12 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Even for staging IIO drivers I generally prefer one patch per driver.
However I don't care enough for a simple case like this one so I've applied
it to the togreg branch of iio.git.

I made a minor tweak inline.  The driver in question has several similar
odd 
	ret = A;
	return ret;

blocks, but I've only tidied up the one you touched here

Thanks,

Jonathan

> ---
>  drivers/staging/iio/frequency/ad9832.c        | 15 +------------
>  drivers/staging/iio/frequency/ad9834.c        | 20 ++---------------
>  .../staging/iio/impedance-analyzer/ad5933.c   | 22 ++-----------------
>  3 files changed, 5 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 6f9eebd6c7ee..6c390c4eb26d 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -299,11 +299,6 @@ static void ad9832_reg_disable(void *reg)
>  	regulator_disable(reg);
>  }
>  
> -static void ad9832_clk_disable(void *clk)
> -{
> -	clk_disable_unprepare(clk);
> -}
> -
>  static int ad9832_probe(struct spi_device *spi)
>  {
>  	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -350,18 +345,10 @@ static int ad9832_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	st->mclk = devm_clk_get(&spi->dev, "mclk");
> +	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))
>  		return PTR_ERR(st->mclk);
>  
> -	ret = clk_prepare_enable(st->mclk);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad9832_clk_disable, st->mclk);
> -	if (ret)
> -		return ret;
> -
>  	st->spi = spi;
>  	mutex_init(&st->lock);
>  
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 285df0e489a6..4f35def05fb7 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -394,13 +394,6 @@ static void ad9834_disable_reg(void *data)
>  	regulator_disable(reg);
>  }
>  
> -static void ad9834_disable_clk(void *data)
> -{
> -	struct clk *clk = data;
> -
> -	clk_disable_unprepare(clk);
> -}
> -
>  static int ad9834_probe(struct spi_device *spi)
>  {
>  	struct ad9834_state *st;
> @@ -429,22 +422,13 @@ static int ad9834_probe(struct spi_device *spi)
>  	}
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
> -	st->mclk = devm_clk_get(&spi->dev, NULL);
> +	st->mclk = devm_clk_get_enabled(&spi->dev, NULL);
>  	if (IS_ERR(st->mclk)) {
> -		ret = PTR_ERR(st->mclk);
> -		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(st->mclk);
> -	if (ret) {
>  		dev_err(&spi->dev, "Failed to enable master clock\n");
> +		ret = PTR_ERR(st->mclk);
>  		return ret;
I combined this as
		return PTR_ERR(st->mclk);
whilst applying.

There are other equally messy error handling lines int his driver, but
whilst we are here we can clean at least this one up ;)

Jonathan
>  	}
>  
> -	ret = devm_add_action_or_reset(&spi->dev, ad9834_disable_clk, st->mclk);
> -	if (ret)
> -		return ret;
> -
>  	st->spi = spi;
>  	st->devid = spi_get_device_id(spi)->driver_data;
>  	indio_dev->name = spi_get_device_id(spi)->name;
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 46db6d91542a..e748a5d04e97 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -667,13 +667,6 @@ static void ad5933_reg_disable(void *data)
>  	regulator_disable(st->reg);
>  }
>  
> -static void ad5933_clk_disable(void *data)
> -{
> -	struct ad5933_state *st = data;
> -
> -	clk_disable_unprepare(st->mclk);
> -}
> -
>  static int ad5933_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> @@ -712,23 +705,12 @@ static int ad5933_probe(struct i2c_client *client)
>  
>  	st->vref_mv = ret / 1000;
>  
> -	st->mclk = devm_clk_get(&client->dev, "mclk");
> +	st->mclk = devm_clk_get_enabled(&client->dev, "mclk");
>  	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT)
>  		return PTR_ERR(st->mclk);
>  
> -	if (!IS_ERR(st->mclk)) {
> -		ret = clk_prepare_enable(st->mclk);
> -		if (ret < 0)
> -			return ret;
> -
> -		ret = devm_add_action_or_reset(&client->dev,
> -					       ad5933_clk_disable,
> -					       st);
> -		if (ret)
> -			return ret;
> -
> +	if (!IS_ERR(st->mclk))
>  		ext_clk_hz = clk_get_rate(st->mclk);
> -	}
>  
>  	if (ext_clk_hz) {
>  		st->mclk_hz = ext_clk_hz;

