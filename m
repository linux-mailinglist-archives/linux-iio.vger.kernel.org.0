Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1548280B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 18:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiAAReT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 12:34:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33742 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiAAReT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 12:34:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 461FBB807E8
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 17:34:18 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 6B8C9C36AEC;
        Sat,  1 Jan 2022 17:34:15 +0000 (UTC)
Date:   Sat, 1 Jan 2022 17:40:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 37/49] iio:magn:hmc5843: Switch from CONFIG_PM_SLEEP
 guards to pm_ptr() / __maybe_unused
Message-ID: <20220101174003.4ec34b48@jic23-huawei>
In-Reply-To: <20211123211019.2271440-38-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <20211123211019.2271440-38-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 21:10:07 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> The pm_ptr() macro only removes the reference if CONFIG_PM is not
> set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
> will not always remove the pm_ops structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
This one needs some more thought before any conversion to the new
pm_sleep_ptr() etc as use of
DEFINE_SIMPLE_DEV_PM_OPS() leads to an unused warning for the _core.c
module - which explains the original __maybe_unused under the ifdef.

I'll drop it for now.

Jonathan


> ---
>  drivers/iio/magnetometer/hmc5843.h     | 5 -----
>  drivers/iio/magnetometer/hmc5843_i2c.c | 2 +-
>  drivers/iio/magnetometer/hmc5843_spi.c | 2 +-
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
> index 9120c8bbf3dd..c3444f3ab1dc 100644
> --- a/drivers/iio/magnetometer/hmc5843.h
> +++ b/drivers/iio/magnetometer/hmc5843.h
> @@ -55,13 +55,8 @@ void hmc5843_common_remove(struct device *dev);
>  int hmc5843_common_suspend(struct device *dev);
>  int hmc5843_common_resume(struct device *dev);
>  
> -#ifdef CONFIG_PM_SLEEP
>  static __maybe_unused SIMPLE_DEV_PM_OPS(hmc5843_pm_ops,
>  					hmc5843_common_suspend,
>  					hmc5843_common_resume);
> -#define HMC5843_PM_OPS (&hmc5843_pm_ops)
> -#else
> -#define HMC5843_PM_OPS NULL
> -#endif
>  
>  #endif /* HMC5843_CORE_H */
> diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
> index bc6e12f1d521..a7359f439f10 100644
> --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> @@ -93,7 +93,7 @@ MODULE_DEVICE_TABLE(of, hmc5843_of_match);
>  static struct i2c_driver hmc5843_driver = {
>  	.driver = {
>  		.name	= "hmc5843",
> -		.pm	= HMC5843_PM_OPS,
> +		.pm	= pm_ptr(&hmc5843_pm_ops),
>  		.of_match_table = hmc5843_of_match,
>  	},
>  	.id_table	= hmc5843_id,
> diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
> index 89cf59a62c28..c1bd2ff3c64a 100644
> --- a/drivers/iio/magnetometer/hmc5843_spi.c
> +++ b/drivers/iio/magnetometer/hmc5843_spi.c
> @@ -90,7 +90,7 @@ MODULE_DEVICE_TABLE(spi, hmc5843_id);
>  static struct spi_driver hmc5843_driver = {
>  		.driver = {
>  				.name = "hmc5843",
> -				.pm = HMC5843_PM_OPS,
> +				.pm = pm_ptr(&hmc5843_pm_ops),
>  		},
>  		.id_table = hmc5843_id,
>  		.probe = hmc5843_spi_probe,

