Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1803634D02B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC2MgB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 08:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhC2Mfl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 08:35:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF4461930;
        Mon, 29 Mar 2021 12:35:39 +0000 (UTC)
Date:   Mon, 29 Mar 2021 13:35:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: inv_mpu6050: Remove superfluous
 indio_dev->modes assignment
Message-ID: <20210329133546.4ac4eb3b@jic23-huawei>
In-Reply-To: <20210325131046.13383-1-lars@metafoo.de>
References: <20210325131046.13383-1-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Mar 2021 14:10:45 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The inv_mpu6050 driver manually assigns the indio_dev->modes property. But
> this is not necessary since it will be setup in iio_trigger_buffer_setup().
> 
> Remove the manual assignment.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Both applied to the togreg branch of iio.git and pushed out as testing fo the
autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 453c51c79655..99ee0a218875 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1591,7 +1591,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	}
>  
>  	indio_dev->info = &mpu_info;
> -	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
>  
>  	result = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  						 iio_pollfunc_store_time,

