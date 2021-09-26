Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73B41886F
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhIZL5F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 07:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhIZL5E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 07:57:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC1C460F45;
        Sun, 26 Sep 2021 11:55:27 +0000 (UTC)
Date:   Sun, 26 Sep 2021 12:59:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: move max_fifo_size in
 st_lsm6dsx_fifo_ops
Message-ID: <20210926125916.6540ba7a@jic23-huawei>
In-Reply-To: <b2981cb9a00784a84fec0ea62183629216ec3b38.1632388011.git.lorenzo@kernel.org>
References: <b2981cb9a00784a84fec0ea62183629216ec3b38.1632388011.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Sep 2021 11:08:24 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> This patch does not introduce any logic change, just small code
> rearrangement.
Hi Lorenzo, 

Why?  I can make an educated guess that it is to put all the fifo related stuff
in one place, but you probably need to state that in the patch description.

Thanks,

Jonathan

> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  4 ++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 16 +++++++++-------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 5ef55763a6cc..6ac4eac36458 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -143,6 +143,7 @@ struct st_lsm6dsx_fs_table_entry {
>   * @read_fifo: Read FIFO callback.
>   * @fifo_th: FIFO threshold register info (addr + mask).
>   * @fifo_diff: FIFO diff status register info (addr + mask).
> + * @max_size: Sensor max fifo length in FIFO words.
>   * @th_wl: FIFO threshold word length.
>   */
>  struct st_lsm6dsx_fifo_ops {
> @@ -156,6 +157,7 @@ struct st_lsm6dsx_fifo_ops {
>  		u8 addr;
>  		u16 mask;
>  	} fifo_diff;
> +	u16 max_size;
>  	u8 th_wl;
>  };
>  
> @@ -271,7 +273,6 @@ struct st_lsm6dsx_ext_dev_settings {
>   * @reset: register address for reset.
>   * @boot: register address for boot.
>   * @bdu: register address for Block Data Update.
> - * @max_fifo_size: Sensor max fifo length in FIFO words.
>   * @id: List of hw id/device name supported by the driver configuration.
>   * @channels: IIO channels supported by the device.
>   * @irq_config: interrupts related registers.
> @@ -288,7 +289,6 @@ struct st_lsm6dsx_settings {
>  	struct st_lsm6dsx_reg reset;
>  	struct st_lsm6dsx_reg boot;
>  	struct st_lsm6dsx_reg bdu;
> -	u16 max_fifo_size;
>  	struct {
>  		enum st_lsm6dsx_hw_id hw_id;
>  		const char *name;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index db45f1fc0b81..0f54df85134a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -102,7 +102,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.addr = 0x22,
>  			.mask = BIT(6),
>  		},
> -		.max_fifo_size = 32,
>  		.id = {
>  			{
>  				.hw_id = ST_LSM9DS1_ID,
> @@ -194,6 +193,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = BIT(4),
>  			},
>  		},
> +		.fifo_ops = {
> +			.max_size = 32,
> +		},
>  	},
>  	{
>  		.reset = {
> @@ -208,7 +210,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.addr = 0x12,
>  			.mask = BIT(6),
>  		},
> -		.max_fifo_size = 1365,
>  		.id = {
>  			{
>  				.hw_id = ST_LSM6DS3_ID,
> @@ -329,6 +330,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x3a,
>  				.mask = GENMASK(11, 0),
>  			},
> +			.max_size = 1365,
>  			.th_wl = 3, /* 1LSB = 2B */
>  		},
>  		.ts_settings = {
> @@ -374,7 +376,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.addr = 0x12,
>  			.mask = BIT(6),
>  		},
> -		.max_fifo_size = 682,
>  		.id = {
>  			{
>  				.hw_id = ST_LSM6DS3H_ID,
> @@ -495,6 +496,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x3a,
>  				.mask = GENMASK(11, 0),
>  			},
> +			.max_size = 682,
>  			.th_wl = 3, /* 1LSB = 2B */
>  		},
>  		.ts_settings = {
> @@ -540,7 +542,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.addr = 0x12,
>  			.mask = BIT(6),
>  		},
> -		.max_fifo_size = 682,
>  		.id = {
>  			{
>  				.hw_id = ST_LSM6DSL_ID,
> @@ -677,6 +678,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x3a,
>  				.mask = GENMASK(10, 0),
>  			},
> +			.max_size = 682,
>  			.th_wl = 3, /* 1LSB = 2B */
>  		},
>  		.ts_settings = {
> @@ -759,7 +761,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.addr = 0x12,
>  			.mask = BIT(6),
>  		},
> -		.max_fifo_size = 512,
>  		.id = {
>  			{
>  				.hw_id = ST_LSM6DSR_ID,
> @@ -910,6 +911,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x3a,
>  				.mask = GENMASK(9, 0),
>  			},
> +			.max_size = 512,
>  			.th_wl = 1,
>  		},
>  		.ts_settings = {
> @@ -984,7 +986,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.addr = 0x12,
>  			.mask = BIT(6),
>  		},
> -		.max_fifo_size = 512,
>  		.id = {
>  			{
>  				.hw_id = ST_ASM330LHH_ID,
> @@ -1119,6 +1120,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x3a,
>  				.mask = GENMASK(9, 0),
>  			},
> +			.max_size = 512,
>  			.th_wl = 1,
>  		},
>  		.ts_settings = {
> @@ -1603,7 +1605,7 @@ int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	int err;
>  
> -	if (val < 1 || val > hw->settings->max_fifo_size)
> +	if (val < 1 || val > hw->settings->fifo_ops.max_size)
>  		return -EINVAL;
>  
>  	mutex_lock(&hw->conf_lock);

