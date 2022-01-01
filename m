Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25311482814
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiAARzQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 12:55:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41912 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiAARzQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 12:55:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A545B8091B
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 17:55:15 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id C6E0AC36AE9;
        Sat,  1 Jan 2022 17:55:11 +0000 (UTC)
Date:   Sat, 1 Jan 2022 18:00:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 48/49] iio:gyro:mpu3050: Switch from CONFIG_PM guards to
 pm_ptr() / __maybe_unused
Message-ID: <20220101180059.5168b43b@jic23-huawei>
In-Reply-To: <20211123211019.2271440-49-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <20211123211019.2271440-49-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 21:10:18 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
Another one I'm going to drop for now because the multiple module
nature of it means the compiler can't tell what it can remove.

Needs more thought.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/mpu3050-core.c | 8 +++-----
>  drivers/iio/gyro/mpu3050-i2c.c  | 2 +-
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index ea387efab62d..4ec107b9e779 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1281,19 +1281,17 @@ int mpu3050_common_remove(struct device *dev)
>  }
>  EXPORT_SYMBOL(mpu3050_common_remove);
>  
> -#ifdef CONFIG_PM
> -static int mpu3050_runtime_suspend(struct device *dev)
> +static __maybe_unused int mpu3050_runtime_suspend(struct device *dev)
>  {
>  	return mpu3050_power_down(iio_priv(dev_get_drvdata(dev)));
>  }
>  
> -static int mpu3050_runtime_resume(struct device *dev)
> +static __maybe_unused int mpu3050_runtime_resume(struct device *dev)
>  {
>  	return mpu3050_power_up(iio_priv(dev_get_drvdata(dev)));
>  }
> -#endif /* CONFIG_PM */
>  
> -const struct dev_pm_ops mpu3050_dev_pm_ops = {
> +const __maybe_unused struct dev_pm_ops mpu3050_dev_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>  				pm_runtime_force_resume)
>  	SET_RUNTIME_PM_OPS(mpu3050_runtime_suspend,
> diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
> index ef5bcbc4b45b..820133cad601 100644
> --- a/drivers/iio/gyro/mpu3050-i2c.c
> +++ b/drivers/iio/gyro/mpu3050-i2c.c
> @@ -114,7 +114,7 @@ static struct i2c_driver mpu3050_i2c_driver = {
>  	.driver = {
>  		.of_match_table = mpu3050_i2c_of_match,
>  		.name = "mpu3050-i2c",
> -		.pm = &mpu3050_dev_pm_ops,
> +		.pm = pm_ptr(&mpu3050_dev_pm_ops),
>  	},
>  };
>  module_i2c_driver(mpu3050_i2c_driver);

