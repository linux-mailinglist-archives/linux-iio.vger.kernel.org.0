Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4265A482E5E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jan 2022 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiACGEA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jan 2022 01:04:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49098 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiACGD7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jan 2022 01:03:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73490B80B27
        for <linux-iio@vger.kernel.org>; Mon,  3 Jan 2022 06:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74784C36AE9;
        Mon,  3 Jan 2022 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641189837;
        bh=hKBexFXkQWive8cffNKZoy2NQT8FThXSLqT7pfoxMYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMNl7fyRakDAh/5TXOjPq9nfVrgmIBvWTRyj8iVMU15nkWBYOPvJXNhNBFMRBpzGN
         lKyjF9u+hir6U8wpAKr2XCgezdgkH7lK1kmEEiP9ULtWx/AlOH9W90iMXKmQlmuj/5
         qxoZWB1OnKoXmwmdWQnt1hhaFyGzFmeIFG0A88Ka7nsSoF7XW5QZz1Vlpueqh9nHgv
         P/8xMviBWkHeNJrCG9KPP32O45a3Y9ErDzwEj0qCX9bOUUaHjbUt5EB/4e1xtOjjqt
         EAmHcqyCnWB0Elmhw2JAga+PXSpDp3krjczO7Fl7SqlT7lO7q71Fen9lFhiVCHACrW
         qI5NCEXNS3+Lw==
Date:   Mon, 3 Jan 2022 11:33:50 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 44/51] iio:temperature:tmp007: Switch from
 CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Message-ID: <20220103060350.GC3581@thinkpad>
References: <20220102125617.1259804-1-jic23@kernel.org>
 <20220102125617.1259804-45-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102125617.1259804-45-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 02, 2022 at 12:56:10PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Cc: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/iio/temperature/tmp007.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
> index b422371a4674..f7a040f0ee4c 100644
> --- a/drivers/iio/temperature/tmp007.c
> +++ b/drivers/iio/temperature/tmp007.c
> @@ -537,7 +537,6 @@ static int tmp007_probe(struct i2c_client *client,
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int tmp007_suspend(struct device *dev)
>  {
>  	struct tmp007_data *data = iio_priv(i2c_get_clientdata(
> @@ -554,9 +553,8 @@ static int tmp007_resume(struct device *dev)
>  	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
>  			data->config | TMP007_CONFIG_CONV_EN);
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
> +DEFINE_SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
>  
>  static const struct of_device_id tmp007_of_match[] = {
>  	{ .compatible = "ti,tmp007", },
> @@ -574,7 +572,7 @@ static struct i2c_driver tmp007_driver = {
>  	.driver = {
>  		.name	= "tmp007",
>  		.of_match_table = tmp007_of_match,
> -		.pm	= &tmp007_pm_ops,
> +		.pm	= pm_sleep_ptr(&tmp007_pm_ops),
>  	},
>  	.probe		= tmp007_probe,
>  	.id_table	= tmp007_id,
> -- 
> 2.34.1
> 
