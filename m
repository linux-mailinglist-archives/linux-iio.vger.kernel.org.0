Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25E14F8D2
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2020 17:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgBAQXI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Feb 2020 11:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgBAQXI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Feb 2020 11:23:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA231206D3;
        Sat,  1 Feb 2020 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580574187;
        bh=x1vznGxXozS/hjB8sqVDcOqBSOe4F3cdKFfOi/g1R6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YPj/YMO+1KaDaHN7Yg7xZ7p8brl+I5JNyR5i38jw+2S//GR/Da+rzXzhW8TAiVSgH
         VGN97p3MyVzqgAtBJaFVTBGeqPthq1n0qBQtGrz9ju+YWz1cftREs5GcX8YxwtaMZp
         pOylV82PyIOk/L+FimAVnmoaM+xyoBF4/MSPBPyQ=
Date:   Sat, 1 Feb 2020 16:23:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 9/9] iio: imu: inv_mpu6050: fix LPF bandwidth setting
Message-ID: <20200201162303.46dc0461@archlinux>
In-Reply-To: <20200120093620.9681-10-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
        <20200120093620.9681-10-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jan 2020 10:36:20 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> As every chip has some little variant in LPF bandwidth values,
> use common values that are working for all chips.
> Simplify the LPF setting function.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
hmm. On this one I wonder if the 'fix' title is strictly accurate.
It's certainly a good thing to have, but I'm not sure if we will
want to backport it.  If you do, then break it out of this series
as a separate fix and add appropriate fixes tag.

All the other patches I haven't commented on in this series look fine
to me subject to Rob's suggestion of combining the dt ID additions for
the binding doc into one patch.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 30 ++++++++++++----------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 10 ++++----
>  2 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 9ecc667debbe..c4db9086775c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -707,30 +707,32 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  /**
>   *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
>   *
> - *                  Based on the Nyquist principle, the sampling rate must
> - *                  exceed twice of the bandwidth of the signal, or there
> - *                  would be alising. This function basically search for the
> - *                  correct low pass parameters based on the fifo rate, e.g,
> - *                  sampling frequency.
> + *                  Based on the Nyquist principle, the bandwidth of the low
> + *                  pass filter must not exceed the signal sampling rate divided
> + *                  by 2, or there would be aliasing.
> + *                  This function basically search for the correct low pass
> + *                  parameters based on the fifo rate, e.g, sampling frequency.
>   *
>   *  lpf is set automatically when setting sampling rate to avoid any aliases.
>   */
>  static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  {
> -	static const int hz[] = {188, 98, 42, 20, 10, 5};
> +	static const int hz[] = {400, 200, 90, 40, 20, 10};
>  	static const int d[] = {
> -		INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
> -		INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
> +		INV_MPU6050_FILTER_200HZ, INV_MPU6050_FILTER_100HZ,
> +		INV_MPU6050_FILTER_45HZ, INV_MPU6050_FILTER_20HZ,
>  		INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ
>  	};
> -	int i, h, result;
> +	int i, result;
>  	u8 data;
>  
> -	h = (rate >> 1);
> -	i = 0;
> -	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
> -		i++;
> -	data = d[i];
> +	data = INV_MPU6050_FILTER_5HZ;
> +	for (i = 0; i < ARRAY_SIZE(hz); ++i) {
> +		if (rate >= hz[i]) {
> +			data = d[i];
> +			break;
> +		}
> +	}
>  	result = inv_mpu6050_set_lpf_regs(st, data);
>  	if (result)
>  		return result;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 7ae614052210..9a81098a8b4d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -370,14 +370,14 @@ enum inv_mpu6050_scan {
>  };
>  
>  enum inv_mpu6050_filter_e {
> -	INV_MPU6050_FILTER_256HZ_NOLPF2 = 0,
> -	INV_MPU6050_FILTER_188HZ,
> -	INV_MPU6050_FILTER_98HZ,
> -	INV_MPU6050_FILTER_42HZ,
> +	INV_MPU6050_FILTER_NOLPF2 = 0,
> +	INV_MPU6050_FILTER_200HZ,
> +	INV_MPU6050_FILTER_100HZ,
> +	INV_MPU6050_FILTER_45HZ,
>  	INV_MPU6050_FILTER_20HZ,
>  	INV_MPU6050_FILTER_10HZ,
>  	INV_MPU6050_FILTER_5HZ,
> -	INV_MPU6050_FILTER_2100HZ_NOLPF,
> +	INV_MPU6050_FILTER_NOLPF,
>  	NUM_MPU6050_FILTER
>  };
>  

