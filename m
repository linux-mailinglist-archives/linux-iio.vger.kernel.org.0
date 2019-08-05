Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD681EDC
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfHEORr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEORr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:17:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E396206C1;
        Mon,  5 Aug 2019 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565014665;
        bh=QYdms1rgu19cWiNaUhK7/Mf2PnpWseyLgTj6I9+x40s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iz9thEMfZiCbSaQEpjz0+vWaru55DdFxX/7nb3VgLmEZwKfkRabXEMFIanTtc4NAa
         cG2r4lJn7YgZQBiaw6iHmK5FTsRODiaWzMIhXMZU+DPMx9v/XFJUK89NOLy1aO2DAB
         L7ceuZgkQ4gTTl9Zy4J9Z4VWFvfNK2T2jPjLJLMo=
Date:   Mon, 5 Aug 2019 15:17:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: Re: [PATCH v2 1/4] iio: imu: st_lsm6dsx: move odr_table in
 st_lsm6dsx_sensor_settings
Message-ID: <20190805151741.60325cab@archlinux>
In-Reply-To: <272fcff0f774d95d93a6847b197c6161d88e8a98.1564427804.git.lorenzo@kernel.org>
References: <cover.1564427804.git.lorenzo@kernel.org>
        <272fcff0f774d95d93a6847b197c6161d88e8a98.1564427804.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jul 2019 21:22:28 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Move sensor odr table in st_lsm6dsx_sensor_settings in order to support
> sensors with different odr maps. This is a preliminary patch to add
> support for LSM9DS1 sensor to st_lsm6dsx driver
> 
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 196 ++++++++++++++++---
>  2 files changed, 166 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index af379a5429ed..3a89f3f6e2c7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -200,6 +200,7 @@ struct st_lsm6dsx_ext_dev_settings {
>   * @wai: Sensor WhoAmI default value.
>   * @max_fifo_size: Sensor max fifo length in FIFO words.
>   * @id: List of hw id/device name supported by the driver configuration.
> + * @odr_table: Hw sensors odr table (Hz + val).
>   * @decimator: List of decimator register info (addr + mask).
>   * @batch: List of FIFO batching register info (addr + mask).
>   * @fifo_ops: Sensor hw FIFO parameters.
> @@ -213,6 +214,7 @@ struct st_lsm6dsx_settings {
>  		enum st_lsm6dsx_hw_id hw_id;
>  		const char *name;
>  	} id[ST_LSM6DSX_MAX_ID];
> +	struct st_lsm6dsx_odr_table_entry odr_table[2];
>  	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_fifo_ops fifo_ops;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index d8c4417cf4eb..b3c6c9792913 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -69,33 +69,6 @@
>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
>  
> -static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
> -	[ST_LSM6DSX_ID_ACC] = {
> -		.reg = {
> -			.addr = 0x10,
> -			.mask = GENMASK(7, 4),
> -		},
> -		.odr_avl[0] = {  13, 0x01 },
> -		.odr_avl[1] = {  26, 0x02 },
> -		.odr_avl[2] = {  52, 0x03 },
> -		.odr_avl[3] = { 104, 0x04 },
> -		.odr_avl[4] = { 208, 0x05 },
> -		.odr_avl[5] = { 416, 0x06 },
> -	},
> -	[ST_LSM6DSX_ID_GYRO] = {
> -		.reg = {
> -			.addr = 0x11,
> -			.mask = GENMASK(7, 4),
> -		},
> -		.odr_avl[0] = {  13, 0x01 },
> -		.odr_avl[1] = {  26, 0x02 },
> -		.odr_avl[2] = {  52, 0x03 },
> -		.odr_avl[3] = { 104, 0x04 },
> -		.odr_avl[4] = { 208, 0x05 },
> -		.odr_avl[5] = { 416, 0x06 },
> -	}
> -};
> -
>  static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
>  	[ST_LSM6DSX_ID_ACC] = {
>  		.reg = {
> @@ -129,6 +102,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.name = ST_LSM6DS3_DEV_NAME,
>  			},
>  		},
> +		.odr_table = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.reg = {
> +					.addr = 0x10,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.reg = {
> +					.addr = 0x11,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +		},
>  		.decimator = {
>  			[ST_LSM6DSX_ID_ACC] = {
>  				.addr = 0x08,
> @@ -179,6 +178,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.name = ST_LSM6DS3H_DEV_NAME,
>  			},
>  		},
> +		.odr_table = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.reg = {
> +					.addr = 0x10,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.reg = {
> +					.addr = 0x11,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +		},
>  		.decimator = {
>  			[ST_LSM6DSX_ID_ACC] = {
>  				.addr = 0x08,
> @@ -238,6 +263,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.name = ST_LSM6DS3TRC_DEV_NAME,
>  			},
>  		},
> +		.odr_table = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.reg = {
> +					.addr = 0x10,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.reg = {
> +					.addr = 0x11,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +		},
>  		.decimator = {
>  			[ST_LSM6DSX_ID_ACC] = {
>  				.addr = 0x08,
> @@ -291,6 +342,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.name = ST_LSM6DSOX_DEV_NAME,
>  			},
>  		},
> +		.odr_table = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.reg = {
> +					.addr = 0x10,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.reg = {
> +					.addr = 0x11,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +		},
>  		.batch = {
>  			[ST_LSM6DSX_ID_ACC] = {
>  				.addr = 0x09,
> @@ -359,6 +436,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.name = ST_ASM330LHH_DEV_NAME,
>  			},
>  		},
> +		.odr_table = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.reg = {
> +					.addr = 0x10,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.reg = {
> +					.addr = 0x11,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +		},
>  		.batch = {
>  			[ST_LSM6DSX_ID_ACC] = {
>  				.addr = 0x09,
> @@ -401,6 +504,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.name = ST_LSM6DSR_DEV_NAME,
>  			},
>  		},
> +		.odr_table = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.reg = {
> +					.addr = 0x10,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.reg = {
> +					.addr = 0x11,
> +					.mask = GENMASK(7, 4),
> +				},
> +				.odr_avl[0] = {  13, 0x01 },
> +				.odr_avl[1] = {  26, 0x02 },
> +				.odr_avl[2] = {  52, 0x03 },
> +				.odr_avl[3] = { 104, 0x04 },
> +				.odr_avl[4] = { 208, 0x05 },
> +				.odr_avl[5] = { 416, 0x06 },
> +			},
> +		},
>  		.batch = {
>  			[ST_LSM6DSX_ID_ACC] = {
>  				.addr = 0x09,
> @@ -563,20 +692,22 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
>  
>  int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
>  {
> +	const struct st_lsm6dsx_odr_table_entry *odr_table;
>  	int i;
>  
> +	odr_table = &sensor->hw->settings->odr_table[sensor->id];
>  	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
>  		/*
>  		 * ext devices can run at different odr respect to
>  		 * accel sensor
>  		 */
> -		if (st_lsm6dsx_odr_table[sensor->id].odr_avl[i].hz >= odr)
> +		if (odr_table->odr_avl[i].hz >= odr)
>  			break;
>  
>  	if (i == ST_LSM6DSX_ODR_LIST_SIZE)
>  		return -EINVAL;
>  
> -	*val = st_lsm6dsx_odr_table[sensor->id].odr_avl[i].val;
> +	*val = odr_table->odr_avl[i].val;
>  
>  	return 0;
>  }
> @@ -641,7 +772,7 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 req_odr)
>  			return err;
>  	}
>  
> -	reg = &st_lsm6dsx_odr_table[ref_sensor->id].reg;
> +	reg = &hw->settings->odr_table[ref_sensor->id].reg;
>  	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
>  	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
>  }
> @@ -786,11 +917,12 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
>  	enum st_lsm6dsx_sensor_id id = sensor->id;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	int i, len = 0;
>  
>  	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -				 st_lsm6dsx_odr_table[id].odr_avl[i].hz);
> +				 hw->settings->odr_table[id].odr_avl[i].hz);
>  	buf[len - 1] = '\n';
>  
>  	return len;
> @@ -1040,7 +1172,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  	sensor = iio_priv(iio_dev);
>  	sensor->id = id;
>  	sensor->hw = hw;
> -	sensor->odr = st_lsm6dsx_odr_table[id].odr_avl[0].hz;
> +	sensor->odr = hw->settings->odr_table[id].odr_avl[0].hz;
>  	sensor->gain = st_lsm6dsx_fs_table[id].fs_avl[0].gain;
>  	sensor->watermark = 1;
>  

