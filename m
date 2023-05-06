Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096116F9374
	for <lists+linux-iio@lfdr.de>; Sat,  6 May 2023 19:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEFRy1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 May 2023 13:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFRy0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 May 2023 13:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA12CE9;
        Sat,  6 May 2023 10:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62EB460DCF;
        Sat,  6 May 2023 17:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8890C433EF;
        Sat,  6 May 2023 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683395664;
        bh=H2M5vLijRuOMf/BtnVGqNUxp0Wd3Bew6sL93mZqxsoA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EAHRY+hqGxH/1OpBtSHLAJ1bMu9rt2GCJBhmvTmnbO+xBLtBx5w3yivfoaHqWz0VS
         BDybEvalPS9UtFyXajfMuljZWOJ/uPKajUWauqkSrHfRXBe7fe/gGT6zgBLrYOTyMm
         exoTb4j6ER8WLlfkqpuHvl3QOP/YHGMgPFcpAT0gUZ4GT6I/Fel2GaUpgJ6ZKGhEgT
         4OttALD/iDNyZt7HhzHJjxh4jTtRRc6uP/3rWofyWt91DFluuAAdrQXFND3Eis0F5N
         zZb534753vLC4+5PzBqnagYI9WEtwIuBAf87Y0/m14ED9gHscumPfsHJzWunahiHyB
         GCZniSvpN4hfg==
Date:   Sat, 6 May 2023 19:10:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     inv.git-commit@tdk.com
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp reset
Message-ID: <20230506191017.659b5196@jic23-huawei>
In-Reply-To: <20230503204410.165035-1-inv.git-commit@tdk.com>
References: <20230503204410.165035-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  3 May 2023 20:44:10 +0000
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
> Signed-off-by: <inv.git-commit@tdk.com>

What's this sign off?  

> Cc: <stable@vger.kernel.org>

Otherwise patch looks fine.

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

