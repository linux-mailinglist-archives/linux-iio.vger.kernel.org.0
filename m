Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6E107F54
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfKWQSp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 11:18:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfKWQSp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 11:18:45 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D318D20706;
        Sat, 23 Nov 2019 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574525924;
        bh=L2Oy6pwvHk1mfvM2VOlYIsKuvxKuizc5kx6mFaGJ5iQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PWdK9ZNVMZ3Wer861KcnieH9WTU2SpEngisp7j6EWGGVOII6gFgbdlNHS0kbDo9bX
         cO9DLRkx9xlCBH4UP+lmc4unjQnrXs3PiaehvzL1wvcL36vkHbWLm3btjLvonO2DdE
         uNEkPnRY9DFDtwoPskSIuesDiq4BT9Di59aCLtHs=
Date:   Sat, 23 Nov 2019 16:18:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: inv_mpu6050: fix temperature reporting
 using bad unit
Message-ID: <20191123161840.4dace64c@archlinux>
In-Reply-To: <20191118103406.9353-1-jmaneyrol@invensense.com>
References: <20191118103406.9353-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 11:34:05 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Temperature should be reported in milli-degrees, not degrees. Fix
> scale values to use the correct unit.
> Fix round-up offset value for MPU6050 and add the values for
> MPU6500 family (different from MPU6050).
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hi.

This is combining several different things, but I can see that it
isn't easy to separate them out so I'll take it as is.

However, we need some information on how to backport this?
I'm guessing it won't be clean to do as the different parts
were added over time.  Perhaps a fixes tag for now to the latest
change that affects this code, then look at backporting relevant
parts by hand.

Thanks,

Jonathan


> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 23 +++++++++++-----------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 16 +++++++++++----
>  2 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 23c0557891a0..268240644adf 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -117,6 +117,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_6050,
>  		.config = &chip_config_6050,
>  		.fifo_size = 1024,
> +		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
>  	},
>  	{
>  		.whoami = INV_MPU6500_WHOAMI_VALUE,
> @@ -124,6 +125,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_6500,
>  		.config = &chip_config_6050,
>  		.fifo_size = 512,
> +		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
>  	},
>  	{
>  		.whoami = INV_MPU6515_WHOAMI_VALUE,
> @@ -131,6 +133,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_6500,
>  		.config = &chip_config_6050,
>  		.fifo_size = 512,
> +		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
>  	},
>  	{
>  		.whoami = INV_MPU6000_WHOAMI_VALUE,
> @@ -138,6 +141,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_6050,
>  		.config = &chip_config_6050,
>  		.fifo_size = 1024,
> +		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
>  	},
>  	{
>  		.whoami = INV_MPU9150_WHOAMI_VALUE,
> @@ -145,6 +149,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_6050,
>  		.config = &chip_config_6050,
>  		.fifo_size = 1024,
> +		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
>  	},
>  	{
>  		.whoami = INV_MPU9250_WHOAMI_VALUE,
> @@ -152,6 +157,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_6500,
>  		.config = &chip_config_6050,
>  		.fifo_size = 512,
> +		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
>  	},
>  	{
>  		.whoami = INV_MPU9255_WHOAMI_VALUE,
> @@ -159,6 +165,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_6500,
>  		.config = &chip_config_6050,
>  		.fifo_size = 512,
> +		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
>  	},
>  	{
>  		.whoami = INV_ICM20608_WHOAMI_VALUE,
> @@ -166,6 +173,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_6500,
>  		.config = &chip_config_6050,
>  		.fifo_size = 512,
> +		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
>  	{
>  		.whoami = INV_ICM20602_WHOAMI_VALUE,
> @@ -173,6 +181,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.reg = &reg_set_icm20602,
>  		.config = &chip_config_6050,
>  		.fifo_size = 1008,
> +		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
>  };
>  
> @@ -481,12 +490,8 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = 0;
> -			if (st->chip_type == INV_ICM20602)
> -				*val2 = INV_ICM20602_TEMP_SCALE;
> -			else
> -				*val2 = INV_MPU6050_TEMP_SCALE;
> -
> +			*val = st->hw->temp.scale / 1000000;
> +			*val2 = st->hw->temp.scale % 1000000;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_MAGN:
>  			return inv_mpu_magn_get_scale(st, chan, val, val2);
> @@ -496,11 +501,7 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			if (st->chip_type == INV_ICM20602)
> -				*val = INV_ICM20602_TEMP_OFFSET;
> -			else
> -				*val = INV_MPU6050_TEMP_OFFSET;
> -
> +			*val = st->hw->temp.offset;
>  			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index f1fb7b6bdab1..b096e010d4ee 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -107,6 +107,7 @@ struct inv_mpu6050_chip_config {
>   *  @reg:   register map of the chip.
>   *  @config:    configuration of the chip.
>   *  @fifo_size:	size of the FIFO in bytes.
> + *  @temp:	offset and scale to apply to raw temperature.
>   */
>  struct inv_mpu6050_hw {
>  	u8 whoami;
> @@ -114,6 +115,10 @@ struct inv_mpu6050_hw {
>  	const struct inv_mpu6050_reg_map *reg;
>  	const struct inv_mpu6050_chip_config *config;
>  	size_t fifo_size;
> +	struct {
> +		int offset;
> +		int scale;
> +	} temp;
>  };
>  
>  /*
> @@ -279,16 +284,19 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_REG_UP_TIME_MIN          5000
>  #define INV_MPU6050_REG_UP_TIME_MAX          10000
>  
> -#define INV_MPU6050_TEMP_OFFSET	             12421
> -#define INV_MPU6050_TEMP_SCALE               2941
> +#define INV_MPU6050_TEMP_OFFSET	             12420
> +#define INV_MPU6050_TEMP_SCALE               2941176
>  #define INV_MPU6050_MAX_GYRO_FS_PARAM        3
>  #define INV_MPU6050_MAX_ACCL_FS_PARAM        3
>  #define INV_MPU6050_THREE_AXIS               3
>  #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT    3
>  #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT    3
>  
> -#define INV_ICM20602_TEMP_OFFSET	     8170
> -#define INV_ICM20602_TEMP_SCALE		     3060
> +#define INV_MPU6500_TEMP_OFFSET              7011
> +#define INV_MPU6500_TEMP_SCALE               2995178
> +
> +#define INV_ICM20608_TEMP_OFFSET	     8170
> +#define INV_ICM20608_TEMP_SCALE		     3059976
>  
>  /* 6 + 6 + 7 (for MPU9x50) = 19 round up to 24 and plus 8 */
>  #define INV_MPU6050_OUTPUT_DATA_SIZE         32

