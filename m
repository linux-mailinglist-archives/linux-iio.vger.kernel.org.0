Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A66224CCF
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRQCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRQCs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:02:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B9B2076A;
        Sat, 18 Jul 2020 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595088167;
        bh=gCPyaXj3gDoDhRpX1/bqGUHn2gPCArtpU+D0BR05GpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d3EZhN95LHOi7blKYCQ8bSx/EHR2nvkUzhHMqLt7wnShygX2M1lDSFb5llcugQMGB
         5aLKrPCY/fL2FWUuqlhaBW8jjkaixfb2EluffzclP7QaSe76u4fLzcJdvXl+51ELGj
         FFp6yFtfn3zvpHZT4TjpBcBn0jkbO6OX3vl5qBjU=
Date:   Sat, 18 Jul 2020 17:02:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 24/30] iio: imu: inv_mpu6050: inv_mpu_core: Demote
 obvious misuse of kerneldoc to standard comment blocks
Message-ID: <20200718170243.7d5ae3a9@archlinux>
In-Reply-To: <20200717165538.3275050-25-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-25-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:32 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> No attempt has been made to document any of the demoted functions here.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:444: warning: Function parameter or member 'st' not described in 'inv_mpu6050_set_lpf_regs'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:444: warning: Function parameter or member 'val' not described in 'inv_mpu6050_set_lpf_regs'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:480: warning: Function parameter or member 'indio_dev' not described in 'inv_mpu6050_init_config'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:862: warning: Function parameter or member 'st' not described in 'inv_mpu6050_set_lpf'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:862: warning: Function parameter or member 'rate' not described in 'inv_mpu6050_set_lpf'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:893: warning: Function parameter or member 'dev' not described in 'inv_mpu6050_fifo_rate_store'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:893: warning: Function parameter or member 'attr' not described in 'inv_mpu6050_fifo_rate_store'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:893: warning: Function parameter or member 'buf' not described in 'inv_mpu6050_fifo_rate_store'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:893: warning: Function parameter or member 'count' not described in 'inv_mpu6050_fifo_rate_store'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:954: warning: Function parameter or member 'dev' not described in 'inv_fifo_rate_show'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:954: warning: Function parameter or member 'attr' not described in 'inv_fifo_rate_show'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:954: warning: Function parameter or member 'buf' not described in 'inv_fifo_rate_show'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:975: warning: Function parameter or member 'dev' not described in 'inv_attr_show'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:975: warning: Function parameter or member 'attr' not described in 'inv_attr_show'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:975: warning: Function parameter or member 'buf' not described in 'inv_attr_show'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c:1282: warning: Function parameter or member 'st' not described in 'inv_check_and_setup_chip'
> 
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 4d604fe842e5d..f6b2b2e8f1010 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -433,7 +433,7 @@ static int inv_mpu6050_set_gyro_fsr(struct inv_mpu6050_state *st,
>  	return regmap_write(st->map, st->reg->gyro_config, data);
>  }
>  
> -/**
> +/*
>   *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip dependent
>   *
>   *  MPU60xx/MPU9150 use only 1 register for accelerometer + gyroscope
> @@ -467,7 +467,7 @@ static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
>  	return regmap_write(st->map, st->reg->accel_lpf, val);
>  }
>  
> -/**
> +/*
>   *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
>   *
>   *  Initial configuration:
> @@ -847,7 +847,7 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  	return result;
>  }
>  
> -/**
> +/*
>   *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
>   *
>   *                  Based on the Nyquist principle, the bandwidth of the low
> @@ -884,7 +884,7 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  	return 0;
>  }
>  
> -/**
> +/*
>   * inv_mpu6050_fifo_rate_store() - Set fifo rate.
>   */
>  static ssize_t
> @@ -945,7 +945,7 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> -/**
> +/*
>   * inv_fifo_rate_show() - Get the current sampling rate.
>   */
>  static ssize_t
> @@ -962,7 +962,7 @@ inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
>  	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_rate);
>  }
>  
> -/**
> +/*
>   * inv_attr_show() - calling this function will show current
>   *                    parameters.
>   *
> @@ -1275,7 +1275,7 @@ static const struct iio_info mpu_info = {
>  	.debugfs_reg_access = &inv_mpu6050_reg_access,
>  };
>  
> -/**
> +/*
>   *  inv_check_and_setup_chip() - check and setup chip.
>   */
>  static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)

