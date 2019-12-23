Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05484129898
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWQLa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfLWQLa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:11:30 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD3520709;
        Mon, 23 Dec 2019 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577117489;
        bh=amsvyyuQdnyasQ/0uITUQtewr8CpNq491Zm+7Ygmkc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d/8dfdzE7Pqzlg60Wzll2oulNgC8kxkujFLx2T4C8TmdD1m71sUiaK+FTAP8tRdh/
         2sgy8X0HT3+n9b/5/ifuTM6cJb39MoTBOJiZvjk+jv8lM4dkfMmf2Q9Yx056WtQkic
         5q5ld25uMdMQW13zGqXBV0UDpT1TZbbMzkSD+F6Q=
Date:   Mon, 23 Dec 2019 16:11:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/3] iio: st_lsm6dsx: Drop unneeded OF code
Message-ID: <20191223161123.6f14e15b@archlinux>
In-Reply-To: <20191216181925.927-2-andriy.shevchenko@linux.intel.com>
References: <20191216181925.927-1-andriy.shevchenko@linux.intel.com>
        <20191216181925.927-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 20:19:24 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no need to have OF guard against ID table.
> Drop it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Agreed. Good to slowly push out this bit of legacy...

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 3 +--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index cd47ec1fedcb..0fb32131afce 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -12,7 +12,6 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> -#include <linux/of.h>
>  #include <linux/regmap.h>
>  
>  #include "st_lsm6dsx.h"
> @@ -122,7 +121,7 @@ static struct i2c_driver st_lsm6dsx_driver = {
>  	.driver = {
>  		.name = "st_lsm6dsx_i2c",
>  		.pm = &st_lsm6dsx_pm_ops,
> -		.of_match_table = of_match_ptr(st_lsm6dsx_i2c_of_match),
> +		.of_match_table = st_lsm6dsx_i2c_of_match,
>  	},
>  	.probe = st_lsm6dsx_i2c_probe,
>  	.id_table = st_lsm6dsx_i2c_id_table,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index 67ff36eac247..eb1086e4a951 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -12,7 +12,6 @@
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
> -#include <linux/of.h>
>  #include <linux/regmap.h>
>  
>  #include "st_lsm6dsx.h"
> @@ -122,7 +121,7 @@ static struct spi_driver st_lsm6dsx_driver = {
>  	.driver = {
>  		.name = "st_lsm6dsx_spi",
>  		.pm = &st_lsm6dsx_pm_ops,
> -		.of_match_table = of_match_ptr(st_lsm6dsx_spi_of_match),
> +		.of_match_table = st_lsm6dsx_spi_of_match,
>  	},
>  	.probe = st_lsm6dsx_spi_probe,
>  	.id_table = st_lsm6dsx_spi_id_table,

