Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9FE70A90B
	for <lists+linux-iio@lfdr.de>; Sat, 20 May 2023 18:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjETQRn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 May 2023 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjETQRm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2023 12:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864BEDB;
        Sat, 20 May 2023 09:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 201ED61B74;
        Sat, 20 May 2023 16:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849D9C433EF;
        Sat, 20 May 2023 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684599460;
        bh=qcdNhPUgEmbMWcpz4l8bXGsWTX62mn3ZgGinyGEIlBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KPN3SOurVwMIpAMdGO23lZ3eiviraBmQe57jt+Allh+6YDIoor4IJe95fdic8RVHt
         tGuWJ44hHcGXhkIrf+gUrXWqleADb4B5B7hJnyHON35rlD8YCUD2199SoWvG9YKm1o
         p7Q1A4WchhNCAjHX6qn6GJyNsxIItxZp51U27Y5n81d8GzVpWZuFr2Jr6/4iibX7UI
         VNIMmr4W7vYYev333YF3zVQkH6bmq6mFX8Vohkaiy40Ww1ktWp28nTmx/QVX37sFAI
         AV8UiHEPzLBdwOcQAon7t9cxftrVr0GRZWnzOSBLowWO89g/zEE3t+Yjh/jQ6ZRsEj
         i/dHqL9dAZpow==
Date:   Sat, 20 May 2023 17:33:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     inv.git-commit@tdk.com
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: fix timestamp reset
Message-ID: <20230520173350.5c344da5@jic23-huawei>
In-Reply-To: <20230509152202.245444-1-inv.git-commit@tdk.com>
References: <20230509152202.245444-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 May 2023 15:22:02 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Timestamp reset is not done in the correct place. It must be done
> before enabling buffer. The reason is that interrupt timestamping
> is always happening when the chip is on, even if the
> corresponding sensor is off. When the sensor restarts, timestamp
> is wrong if you don't do a reset first.
> 
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Cc: <stable@vger.kernel.org>

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan


> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 99576b2c171f..32d7f8364230 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -275,9 +275,14 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
>  	struct device *dev = regmap_get_device(st->map);
> +	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
>  
>  	pm_runtime_get_sync(dev);
>  
> +	mutex_lock(&st->lock);
> +	inv_icm42600_timestamp_reset(ts);
> +	mutex_unlock(&st->lock);
> +
>  	return 0;
>  }
>  
> @@ -375,7 +380,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
>  	struct device *dev = regmap_get_device(st->map);
>  	unsigned int sensor;
>  	unsigned int *watermark;
> -	struct inv_icm42600_timestamp *ts;
>  	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
>  	unsigned int sleep_temp = 0;
>  	unsigned int sleep_sensor = 0;
> @@ -385,11 +389,9 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
>  	if (indio_dev == st->indio_gyro) {
>  		sensor = INV_ICM42600_SENSOR_GYRO;
>  		watermark = &st->fifo.watermark.gyro;
> -		ts = iio_priv(st->indio_gyro);
>  	} else if (indio_dev == st->indio_accel) {
>  		sensor = INV_ICM42600_SENSOR_ACCEL;
>  		watermark = &st->fifo.watermark.accel;
> -		ts = iio_priv(st->indio_accel);
>  	} else {
>  		return -EINVAL;
>  	}
> @@ -417,8 +419,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
>  	if (!st->fifo.on)
>  		ret = inv_icm42600_set_temp_conf(st, false, &sleep_temp);
>  
> -	inv_icm42600_timestamp_reset(ts);
> -
>  out_unlock:
>  	mutex_unlock(&st->lock);
>  

