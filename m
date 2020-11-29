Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5297B2C7946
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 14:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgK2NDs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 08:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgK2NDr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 08:03:47 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C578A207FF;
        Sun, 29 Nov 2020 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606654986;
        bh=vWOVg0X6nnhZG2prqsgcqi4aqWDLuKwj6j/bGUo0MH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cuEalWw6JEzHJbCXBXCdsrQs7/5Fuko0vQZst+/vv9D+7/b0LRrbPHBqsVNdWmtHW
         c7fGOEeowKYAZy9dB9lbBbqXZ6LkMIgGMCgrU0DE4es5LjgaGaqUE32oULDz5DJ88n
         1J+8uDbMRNWhbGeKEjYXcm3F6dBv8ZN31cJy7tvk=
Date:   Sun, 29 Nov 2020 13:03:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsmdsx: compact st_lsm6dsx_sensor_settings
 table
Message-ID: <20201129130302.62f4f38f@archlinux>
In-Reply-To: <c43286938b2fe03ab3abdb5fc095ea6b950abcb1.1606557946.git.lorenzo@kernel.org>
References: <c43286938b2fe03ab3abdb5fc095ea6b950abcb1.1606557946.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 11:08:01 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Shrink st_lsm6dsx_sensor_settings table size moving wai address info in
> id array and remove duplicated code
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.

thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 451 ++-----------------
>  2 files changed, 29 insertions(+), 425 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 4b4ec39d4400..b81da6053b3c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -266,7 +266,6 @@ struct st_lsm6dsx_ext_dev_settings {
>  
>  /**
>   * struct st_lsm6dsx_settings - ST IMU sensor settings
> - * @wai: Sensor WhoAmI default value.
>   * @reset: register address for reset.
>   * @boot: register address for boot.
>   * @bdu: register address for Block Data Update.
> @@ -284,7 +283,6 @@ struct st_lsm6dsx_ext_dev_settings {
>   * @shub_settings: i2c controller related settings.
>   */
>  struct st_lsm6dsx_settings {
> -	u8 wai;
>  	struct st_lsm6dsx_reg reset;
>  	struct st_lsm6dsx_reg boot;
>  	struct st_lsm6dsx_reg bdu;
> @@ -292,6 +290,7 @@ struct st_lsm6dsx_settings {
>  	struct {
>  		enum st_lsm6dsx_hw_id hw_id;
>  		const char *name;
> +		u8 wai;
>  	} id[ST_LSM6DSX_MAX_ID];
>  	struct {
>  		const struct iio_chan_spec *chan;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index a73c41dea5fc..c05910fa0de6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -90,7 +90,6 @@ static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
>  
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  	{
> -		.wai = 0x68,
>  		.reset = {
>  			.addr = 0x22,
>  			.mask = BIT(0),
> @@ -108,9 +107,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			{
>  				.hw_id = ST_LSM9DS1_ID,
>  				.name = ST_LSM9DS1_DEV_NAME,
> +				.wai = 0x68,
>  			}, {
>  				.hw_id = ST_LSM6DS0_ID,
>  				.name = ST_LSM6DS0_DEV_NAME,
> +				.wai = 0x68,
>  			},
>  		},
>  		.channels = {
> @@ -195,7 +196,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		},
>  	},
>  	{
> -		.wai = 0x69,
>  		.reset = {
>  			.addr = 0x12,
>  			.mask = BIT(0),
> @@ -213,6 +213,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			{
>  				.hw_id = ST_LSM6DS3_ID,
>  				.name = ST_LSM6DS3_DEV_NAME,
> +				.wai = 0x69,
>  			},
>  		},
>  		.channels = {
> @@ -361,7 +362,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		},
>  	},
>  	{
> -		.wai = 0x69,
>  		.reset = {
>  			.addr = 0x12,
>  			.mask = BIT(0),
> @@ -379,6 +379,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			{
>  				.hw_id = ST_LSM6DS3H_ID,
>  				.name = ST_LSM6DS3H_DEV_NAME,
> +				.wai = 0x69,
>  			},
>  		},
>  		.channels = {
> @@ -527,7 +528,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		},
>  	},
>  	{
> -		.wai = 0x6a,
>  		.reset = {
>  			.addr = 0x12,
>  			.mask = BIT(0),
> @@ -545,15 +545,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			{
>  				.hw_id = ST_LSM6DSL_ID,
>  				.name = ST_LSM6DSL_DEV_NAME,
> +				.wai = 0x6a,
>  			}, {
>  				.hw_id = ST_LSM6DSM_ID,
>  				.name = ST_LSM6DSM_DEV_NAME,
> +				.wai = 0x6a,
>  			}, {
>  				.hw_id = ST_ISM330DLC_ID,
>  				.name = ST_ISM330DLC_DEV_NAME,
> +				.wai = 0x6a,
>  			}, {
>  				.hw_id = ST_LSM6DS3TRC_ID,
>  				.name = ST_LSM6DS3TRC_DEV_NAME,
> +				.wai = 0x6a,
>  			},
>  		},
>  		.channels = {
> @@ -743,7 +747,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		},
>  	},
>  	{
> -		.wai = 0x6c,
>  		.reset = {
>  			.addr = 0x12,
>  			.mask = BIT(0),
> @@ -759,11 +762,29 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.max_fifo_size = 512,
>  		.id = {
>  			{
> +				.hw_id = ST_LSM6DSR_ID,
> +				.name = ST_LSM6DSR_DEV_NAME,
> +				.wai = 0x6b,
> +			}, {
> +				.hw_id = ST_ISM330DHCX_ID,
> +				.name = ST_ISM330DHCX_DEV_NAME,
> +				.wai = 0x6b,
> +			}, {
> +				.hw_id = ST_LSM6DSRX_ID,
> +				.name = ST_LSM6DSRX_DEV_NAME,
> +				.wai = 0x6b,
> +			}, {
>  				.hw_id = ST_LSM6DSO_ID,
>  				.name = ST_LSM6DSO_DEV_NAME,
> +				.wai = 0x6c,
>  			}, {
>  				.hw_id = ST_LSM6DSOX_ID,
>  				.name = ST_LSM6DSOX_DEV_NAME,
> +				.wai = 0x6c,
> +			}, {
> +				.hw_id = ST_LSM6DST_ID,
> +				.name = ST_LSM6DST_DEV_NAME,
> +				.wai = 0x6d,
>  			},
>  		},
>  		.channels = {
> @@ -951,7 +972,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		},
>  	},
>  	{
> -		.wai = 0x6b,
>  		.reset = {
>  			.addr = 0x12,
>  			.mask = BIT(0),
> @@ -969,6 +989,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			{
>  				.hw_id = ST_ASM330LHH_ID,
>  				.name = ST_ASM330LHH_DEV_NAME,
> +				.wai = 0x6b,
>  			},
>  		},
>  		.channels = {
> @@ -1123,422 +1144,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.wakeup_src_x_mask = BIT(2),
>  		},
>  	},
> -	{
> -		.wai = 0x6b,
> -		.reset = {
> -			.addr = 0x12,
> -			.mask = BIT(0),
> -		},
> -		.boot = {
> -			.addr = 0x12,
> -			.mask = BIT(7),
> -		},
> -		.bdu = {
> -			.addr = 0x12,
> -			.mask = BIT(6),
> -		},
> -		.max_fifo_size = 512,
> -		.id = {
> -			{
> -				.hw_id = ST_LSM6DSR_ID,
> -				.name = ST_LSM6DSR_DEV_NAME,
> -			}, {
> -				.hw_id = ST_ISM330DHCX_ID,
> -				.name = ST_ISM330DHCX_DEV_NAME,
> -			}, {
> -				.hw_id = ST_LSM6DSRX_ID,
> -				.name = ST_LSM6DSRX_DEV_NAME,
> -			},
> -		},
> -		.channels = {
> -			[ST_LSM6DSX_ID_ACC] = {
> -				.chan = st_lsm6dsx_acc_channels,
> -				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] = {
> -				.chan = st_lsm6dsx_gyro_channels,
> -				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
> -			},
> -		},
> -		.drdy_mask = {
> -			.addr = 0x13,
> -			.mask = BIT(3),
> -		},
> -		.odr_table = {
> -			[ST_LSM6DSX_ID_ACC] = {
> -				.reg = {
> -					.addr = 0x10,
> -					.mask = GENMASK(7, 4),
> -				},
> -				.odr_avl[0] = {  12500, 0x01 },
> -				.odr_avl[1] = {  26000, 0x02 },
> -				.odr_avl[2] = {  52000, 0x03 },
> -				.odr_avl[3] = { 104000, 0x04 },
> -				.odr_avl[4] = { 208000, 0x05 },
> -				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_avl[6] = { 833000, 0x07 },
> -				.odr_len = 7,
> -			},
> -			[ST_LSM6DSX_ID_GYRO] = {
> -				.reg = {
> -					.addr = 0x11,
> -					.mask = GENMASK(7, 4),
> -				},
> -				.odr_avl[0] = {  12500, 0x01 },
> -				.odr_avl[1] = {  26000, 0x02 },
> -				.odr_avl[2] = {  52000, 0x03 },
> -				.odr_avl[3] = { 104000, 0x04 },
> -				.odr_avl[4] = { 208000, 0x05 },
> -				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_avl[6] = { 833000, 0x07 },
> -				.odr_len = 7,
> -			},
> -		},
> -		.fs_table = {
> -			[ST_LSM6DSX_ID_ACC] = {
> -				.reg = {
> -					.addr = 0x10,
> -					.mask = GENMASK(3, 2),
> -				},
> -				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
> -				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
> -				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
> -				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x1 },
> -				.fs_len = 4,
> -			},
> -			[ST_LSM6DSX_ID_GYRO] = {
> -				.reg = {
> -					.addr = 0x11,
> -					.mask = GENMASK(3, 2),
> -				},
> -				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
> -				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
> -				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x2 },
> -				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
> -				.fs_len = 4,
> -			},
> -		},
> -		.irq_config = {
> -			.irq1 = {
> -				.addr = 0x0d,
> -				.mask = BIT(3),
> -			},
> -			.irq2 = {
> -				.addr = 0x0e,
> -				.mask = BIT(3),
> -			},
> -			.lir = {
> -				.addr = 0x56,
> -				.mask = BIT(0),
> -			},
> -			.clear_on_read = {
> -				.addr = 0x56,
> -				.mask = BIT(6),
> -			},
> -			.irq1_func = {
> -				.addr = 0x5e,
> -				.mask = BIT(5),
> -			},
> -			.irq2_func = {
> -				.addr = 0x5f,
> -				.mask = BIT(5),
> -			},
> -			.hla = {
> -				.addr = 0x12,
> -				.mask = BIT(5),
> -			},
> -			.od = {
> -				.addr = 0x12,
> -				.mask = BIT(4),
> -			},
> -		},
> -		.batch = {
> -			[ST_LSM6DSX_ID_ACC] = {
> -				.addr = 0x09,
> -				.mask = GENMASK(3, 0),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] = {
> -				.addr = 0x09,
> -				.mask = GENMASK(7, 4),
> -			},
> -		},
> -		.fifo_ops = {
> -			.update_fifo = st_lsm6dsx_update_fifo,
> -			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> -			.fifo_th = {
> -				.addr = 0x07,
> -				.mask = GENMASK(8, 0),
> -			},
> -			.fifo_diff = {
> -				.addr = 0x3a,
> -				.mask = GENMASK(9, 0),
> -			},
> -			.th_wl = 1,
> -		},
> -		.ts_settings = {
> -			.timer_en = {
> -				.addr = 0x19,
> -				.mask = BIT(5),
> -			},
> -			.decimator = {
> -				.addr = 0x0a,
> -				.mask = GENMASK(7, 6),
> -			},
> -			.freq_fine = 0x63,
> -		},
> -		.shub_settings = {
> -			.page_mux = {
> -				.addr = 0x01,
> -				.mask = BIT(6),
> -			},
> -			.master_en = {
> -				.sec_page = true,
> -				.addr = 0x14,
> -				.mask = BIT(2),
> -			},
> -			.pullup_en = {
> -				.sec_page = true,
> -				.addr = 0x14,
> -				.mask = BIT(3),
> -			},
> -			.aux_sens = {
> -				.addr = 0x14,
> -				.mask = GENMASK(1, 0),
> -			},
> -			.wr_once = {
> -				.addr = 0x14,
> -				.mask = BIT(6),
> -			},
> -			.num_ext_dev = 3,
> -			.shub_out = {
> -				.sec_page = true,
> -				.addr = 0x02,
> -			},
> -			.slv0_addr = 0x15,
> -			.dw_slv0_addr = 0x21,
> -			.batch_en = BIT(3),
> -		},
> -		.event_settings = {
> -			.enable_reg = {
> -				.addr = 0x58,
> -				.mask = BIT(7),
> -			},
> -			.wakeup_reg = {
> -				.addr = 0x5B,
> -				.mask = GENMASK(5, 0),
> -			},
> -			.wakeup_src_reg = 0x1b,
> -			.wakeup_src_status_mask = BIT(3),
> -			.wakeup_src_z_mask = BIT(0),
> -			.wakeup_src_y_mask = BIT(1),
> -			.wakeup_src_x_mask = BIT(2),
> -		}
> -	},
> -	{
> -		.wai = 0x6d,
> -		.reset = {
> -			.addr = 0x12,
> -			.mask = BIT(0),
> -		},
> -		.boot = {
> -			.addr = 0x12,
> -			.mask = BIT(7),
> -		},
> -		.bdu = {
> -			.addr = 0x12,
> -			.mask = BIT(6),
> -		},
> -		.max_fifo_size = 512,
> -		.id = {
> -			{
> -				.hw_id = ST_LSM6DST_ID,
> -				.name = ST_LSM6DST_DEV_NAME,
> -			},
> -		},
> -		.channels = {
> -			[ST_LSM6DSX_ID_ACC] = {
> -				.chan = st_lsm6dsx_acc_channels,
> -				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] = {
> -				.chan = st_lsm6dsx_gyro_channels,
> -				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
> -			},
> -		},
> -		.drdy_mask = {
> -			.addr = 0x13,
> -			.mask = BIT(3),
> -		},
> -		.odr_table = {
> -			[ST_LSM6DSX_ID_ACC] = {
> -				.reg = {
> -					.addr = 0x10,
> -					.mask = GENMASK(7, 4),
> -				},
> -				.odr_avl[0] = {  12500, 0x01 },
> -				.odr_avl[1] = {  26000, 0x02 },
> -				.odr_avl[2] = {  52000, 0x03 },
> -				.odr_avl[3] = { 104000, 0x04 },
> -				.odr_avl[4] = { 208000, 0x05 },
> -				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_avl[6] = { 833000, 0x07 },
> -				.odr_len = 7,
> -			},
> -			[ST_LSM6DSX_ID_GYRO] = {
> -				.reg = {
> -					.addr = 0x11,
> -					.mask = GENMASK(7, 4),
> -				},
> -				.odr_avl[0] = {  12500, 0x01 },
> -				.odr_avl[1] = {  26000, 0x02 },
> -				.odr_avl[2] = {  52000, 0x03 },
> -				.odr_avl[3] = { 104000, 0x04 },
> -				.odr_avl[4] = { 208000, 0x05 },
> -				.odr_avl[5] = { 416000, 0x06 },
> -				.odr_avl[6] = { 833000, 0x07 },
> -				.odr_len = 7,
> -			},
> -		},
> -		.fs_table = {
> -			[ST_LSM6DSX_ID_ACC] = {
> -				.reg = {
> -					.addr = 0x10,
> -					.mask = GENMASK(3, 2),
> -				},
> -				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
> -				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
> -				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
> -				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x1 },
> -				.fs_len = 4,
> -			},
> -			[ST_LSM6DSX_ID_GYRO] = {
> -				.reg = {
> -					.addr = 0x11,
> -					.mask = GENMASK(3, 2),
> -				},
> -				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
> -				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
> -				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x2 },
> -				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
> -				.fs_len = 4,
> -			},
> -		},
> -		.irq_config = {
> -			.irq1 = {
> -				.addr = 0x0d,
> -				.mask = BIT(3),
> -			},
> -			.irq2 = {
> -				.addr = 0x0e,
> -				.mask = BIT(3),
> -			},
> -			.lir = {
> -				.addr = 0x56,
> -				.mask = BIT(0),
> -			},
> -			.clear_on_read = {
> -				.addr = 0x56,
> -				.mask = BIT(6),
> -			},
> -			.irq1_func = {
> -				.addr = 0x5e,
> -				.mask = BIT(5),
> -			},
> -			.irq2_func = {
> -				.addr = 0x5f,
> -				.mask = BIT(5),
> -			},
> -			.hla = {
> -				.addr = 0x12,
> -				.mask = BIT(5),
> -			},
> -			.od = {
> -				.addr = 0x12,
> -				.mask = BIT(4),
> -			},
> -		},
> -		.batch = {
> -			[ST_LSM6DSX_ID_ACC] = {
> -				.addr = 0x09,
> -				.mask = GENMASK(3, 0),
> -			},
> -			[ST_LSM6DSX_ID_GYRO] = {
> -				.addr = 0x09,
> -				.mask = GENMASK(7, 4),
> -			},
> -		},
> -		.fifo_ops = {
> -			.update_fifo = st_lsm6dsx_update_fifo,
> -			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> -			.fifo_th = {
> -				.addr = 0x07,
> -				.mask = GENMASK(8, 0),
> -			},
> -			.fifo_diff = {
> -				.addr = 0x3a,
> -				.mask = GENMASK(9, 0),
> -			},
> -			.th_wl = 1,
> -		},
> -		.ts_settings = {
> -			.timer_en = {
> -				.addr = 0x19,
> -				.mask = BIT(5),
> -			},
> -			.decimator = {
> -				.addr = 0x0a,
> -				.mask = GENMASK(7, 6),
> -			},
> -			.freq_fine = 0x63,
> -		},
> -		.shub_settings = {
> -			.page_mux = {
> -				.addr = 0x01,
> -				.mask = BIT(6),
> -			},
> -			.master_en = {
> -				.sec_page = true,
> -				.addr = 0x14,
> -				.mask = BIT(2),
> -			},
> -			.pullup_en = {
> -				.sec_page = true,
> -				.addr = 0x14,
> -				.mask = BIT(3),
> -			},
> -			.aux_sens = {
> -				.addr = 0x14,
> -				.mask = GENMASK(1, 0),
> -			},
> -			.wr_once = {
> -				.addr = 0x14,
> -				.mask = BIT(6),
> -			},
> -			.num_ext_dev = 3,
> -			.shub_out = {
> -				.sec_page = true,
> -				.addr = 0x02,
> -			},
> -			.slv0_addr = 0x15,
> -			.dw_slv0_addr = 0x21,
> -			.batch_en = BIT(3),
> -		},
> -		.event_settings = {
> -			.enable_reg = {
> -				.addr = 0x58,
> -				.mask = BIT(7),
> -			},
> -			.wakeup_reg = {
> -				.addr = 0x5b,
> -				.mask = GENMASK(5, 0),
> -			},
> -			.wakeup_src_reg = 0x1b,
> -			.wakeup_src_status_mask = BIT(3),
> -			.wakeup_src_z_mask = BIT(0),
> -			.wakeup_src_y_mask = BIT(1),
> -			.wakeup_src_x_mask = BIT(2),
> -		},
> -	},
>  };
>  
>  int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
> @@ -1582,7 +1187,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
>  		return err;
>  	}
>  
> -	if (data != st_lsm6dsx_sensor_settings[i].wai) {
> +	if (data != st_lsm6dsx_sensor_settings[i].id[j].wai) {
>  		dev_err(hw->dev, "unsupported whoami [%02x]\n", data);
>  		return -ENODEV;
>  	}

