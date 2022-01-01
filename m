Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1598482812
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 18:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiAARoV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 12:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiAARoU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 12:44:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560CC061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 09:44:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06CB360AE0
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 17:44:20 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 2A0C4C36AE9;
        Sat,  1 Jan 2022 17:44:16 +0000 (UTC)
Date:   Sat, 1 Jan 2022 17:50:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 41/49] iio:pressure:bmp280: Switch from CONFIG_PM guards
 to pm_ptr() / __maybe_unused
Message-ID: <20220101174958.2e811a34@jic23-huawei>
In-Reply-To: <20211123211019.2271440-42-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <20211123211019.2271440-42-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 21:10:11 +0000
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
Dropping this one for now because it has the same complexity around
EXPORT_SYMBOL() and multiple modules so the compiler can't remove the
functions automatically.

Will rethink if there is a way to handle these multi module cases
at a later date.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 6 ++----
>  drivers/iio/pressure/bmp280-i2c.c  | 2 +-
>  drivers/iio/pressure/bmp280-spi.c  | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6b7da40f99c8..0653e1ea88da 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1138,8 +1138,7 @@ int bmp280_common_probe(struct device *dev,
>  }
>  EXPORT_SYMBOL(bmp280_common_probe);
>  
> -#ifdef CONFIG_PM
> -static int bmp280_runtime_suspend(struct device *dev)
> +static __maybe_unused int bmp280_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmp280_data *data = iio_priv(indio_dev);
> @@ -1147,7 +1146,7 @@ static int bmp280_runtime_suspend(struct device *dev)
>  	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
>  }
>  
> -static int bmp280_runtime_resume(struct device *dev)
> +static __maybe_unused int bmp280_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmp280_data *data = iio_priv(indio_dev);
> @@ -1159,7 +1158,6 @@ static int bmp280_runtime_resume(struct device *dev)
>  	usleep_range(data->start_up_time, data->start_up_time + 100);
>  	return data->chip_info->chip_config(data);
>  }
> -#endif /* CONFIG_PM */
>  
>  const struct dev_pm_ops bmp280_dev_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index 8b03ea15c0d0..35045bd92846 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -58,7 +58,7 @@ static struct i2c_driver bmp280_i2c_driver = {
>  	.driver = {
>  		.name	= "bmp280",
>  		.of_match_table = bmp280_of_i2c_match,
> -		.pm = &bmp280_dev_pm_ops,
> +		.pm = pm_ptr(&bmp280_dev_pm_ops),
>  	},
>  	.probe		= bmp280_i2c_probe,
>  	.id_table	= bmp280_i2c_id,
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index 625b86878ad8..41f6cc56d229 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -109,7 +109,7 @@ static struct spi_driver bmp280_spi_driver = {
>  	.driver = {
>  		.name = "bmp280",
>  		.of_match_table = bmp280_of_spi_match,
> -		.pm = &bmp280_dev_pm_ops,
> +		.pm = pm_ptr(&bmp280_dev_pm_ops),
>  	},
>  	.id_table = bmp280_spi_id,
>  	.probe = bmp280_spi_probe,

