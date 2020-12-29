Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD17C2E7284
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 18:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgL2RKD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 12:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgL2RKD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 12:10:03 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EF8207C9;
        Tue, 29 Dec 2020 17:09:21 +0000 (UTC)
Date:   Tue, 29 Dec 2020 17:09:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Slaveyko Slaveykov <sis@melexis.com>
Cc:     Jonathan.Cameron@huawei.com, cmo@melexis.com,
        linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        lars@metafoo.de
Subject: Re: [PATCH v5 1/1] drivers: iio: temperature: Add delay after the
 addressed reset command in mlx90632.c
Message-ID: <20201229170918.631e58a5@archlinux>
In-Reply-To: <20201216115720.12404-2-sis@melexis.com>
References: <20201216115720.12404-1-sis@melexis.com>
        <20201216115720.12404-2-sis@melexis.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Dec 2020 13:57:20 +0200
Slaveyko Slaveykov <sis@melexis.com> wrote:

> After an I2C reset command, the mlx90632 needs some time before
> responding to other I2C commands. Without that delay, there is a chance
> that the I2C command(s) after the reset will not be accepted.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Crt Mori <cmo@melexis.com>
> Signed-off-by: Slaveyko Slaveykov <sis@melexis.com>

Note that this should have had a fixes tag so we know where to apply it whilst
backporting.  I took a look and ended up adding:
Fixes: e02472f74a81 ("iio:temperature:mlx90632: Adding extended calibration option")

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/mlx90632.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 503fe54a0bb9..608ccb1d8bc8 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -248,6 +248,12 @@ static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
>  	if (ret < 0)
>  		return ret;
>  
> +	/*
> +	 * Give the mlx90632 some time to reset properly before sending a new I2C command
> +	 * if this is not done, the following I2C command(s) will not be accepted.
> +	 */
> +	usleep_range(150, 200);
> +
>  	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
>  				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
>  				 (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));

