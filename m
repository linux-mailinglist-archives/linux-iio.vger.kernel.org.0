Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5669CCC9A1
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 13:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfJELba (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 07:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbfJELba (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 07:31:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC252133F;
        Sat,  5 Oct 2019 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570275088;
        bh=zsMUNsuyek0Y0ZS2CoC3K9tP8BPVBBhX+WObN+BN7lc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t/XpHzm8BN3M65CRPiazMmlMdhIXLD74NecJijp2cfBnx3T8oJhB1b96qR7Qbuui6
         iiTWzezdDXw8B+txNKEjGwXWi1cbKRpbmsGtS6klLY8JLf3K00pAl9EDtK6Clrr1+z
         ZjGOLnPtZzjKfXo5ER5tuBX8qvqWLukRAwUlxJQY=
Date:   Sat, 5 Oct 2019 12:31:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
Subject: Re: [PATCH v10 2/5] iio: imu: st_lsm6dsx: add motion events
Message-ID: <20191005123123.194567e7@archlinux>
In-Reply-To: <20190916135630.2211714-2-sean@geanix.com>
References: <20190916135630.2211714-1-sean@geanix.com>
        <20190916135630.2211714-2-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 15:56:27 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Add event channels that controls the creation of motion events.
> Tested on ISM330DLC
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

st_lsm6dsx_event_setup not declared.. Fixed up by adding static marking.

Applied

Thanks,

Jonathan


> ---
> Changes since v4:
>  * Added check for event support
>  * Added registers for more devices that support this event
> 
> Changes since v5:
>  * Moved wakeup_src masks to PATCH 5/6
> 
> Changes since v6:
>  * None
> 
> Changes since v7:
>  * None
> 
> Changes since v8:
>  * None
> 
> Changes since v10:
>  * enable_event changed to a u8
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  41 ++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 191 ++++++++++++++++++-
>  2 files changed, 228 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 21d14072d1c6..6b0ba48394eb 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -12,6 +12,7 @@
>  #define ST_LSM6DSX_H
>  
>  #include <linux/device.h>
> +#include <linux/iio/iio.h>
>  
>  #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
>  #define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
> @@ -54,6 +55,26 @@ enum st_lsm6dsx_hw_id {
>  					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
>  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
>  
> +#define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
> +{									\
> +	.type = chan_type,						\
> +	.address = addr,						\
> +	.modified = 1,							\
> +	.channel2 = mod,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = scan_idx,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 16,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_LE,					\
> +	},								\
> +	.event_spec = &st_lsm6dsx_event,				\
> +	.num_event_specs = 1,						\
> +}
> +
>  #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
>  {									\
>  	.type = chan_type,						\
> @@ -162,6 +183,11 @@ struct st_lsm6dsx_shub_settings {
>  	u8 batch_en;
>  };
>  
> +struct st_lsm6dsx_event_settings {
> +	struct st_lsm6dsx_reg enable_reg;
> +	struct st_lsm6dsx_reg wakeup_reg;
> +};
> +
>  enum st_lsm6dsx_ext_sensor_id {
>  	ST_LSM6DSX_ID_MAGN,
>  };
> @@ -225,6 +251,9 @@ struct st_lsm6dsx_settings {
>  	u8 wai;
>  	u8 int1_addr;
>  	u8 int2_addr;
> +	u8 int1_func_addr;
> +	u8 int2_func_addr;
> +	u8 int_func_mask;
>  	u8 reset_addr;
>  	u16 max_fifo_size;
>  	struct {
> @@ -244,6 +273,7 @@ struct st_lsm6dsx_settings {
>  	struct st_lsm6dsx_fifo_ops fifo_ops;
>  	struct st_lsm6dsx_hw_ts_settings ts_settings;
>  	struct st_lsm6dsx_shub_settings shub_settings;
> +	struct st_lsm6dsx_event_settings event_settings;
>  };
>  
>  enum st_lsm6dsx_sensor_id {
> @@ -324,6 +354,10 @@ struct st_lsm6dsx_hw {
>  	u8 ts_sip;
>  	u8 sip;
>  
> +	u8 event_threshold;
> +	u8 enable_event;
> +	struct st_lsm6dsx_reg irq_routing;
> +
>  	u8 *buff;
>  
>  	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
> @@ -331,6 +365,13 @@ struct st_lsm6dsx_hw {
>  	const struct st_lsm6dsx_settings *settings;
>  };
>  
> +static const struct iio_event_spec st_lsm6dsx_event = {
> +	.type = IIO_EV_TYPE_THRESH,
> +	.dir = IIO_EV_DIR_EITHER,
> +	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			 BIT(IIO_EV_INFO_ENABLE)
> +};
> +
>  static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
>  extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index ef838206b30f..4198ba263d03 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -73,9 +73,9 @@
>  #define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
>  
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
> -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
> +	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> +	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> +	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> @@ -168,6 +168,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.wai = 0x69,
>  		.int1_addr = 0x0d,
>  		.int2_addr = 0x0e,
> +		.int1_func_addr = 0x5e,
> +		.int2_func_addr = 0x5f,
> +		.int_func_mask = BIT(5),
>  		.reset_addr = 0x12,
>  		.max_fifo_size = 1365,
>  		.id = {
> @@ -279,11 +282,20 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = GENMASK(5, 3),
>  			},
>  		},
> +		.event_settings = {
> +			.wakeup_reg = {
> +				.addr = 0x5B,
> +				.mask = GENMASK(5, 0),
> +			},
> +		},
>  	},
>  	{
>  		.wai = 0x69,
>  		.int1_addr = 0x0d,
>  		.int2_addr = 0x0e,
> +		.int1_func_addr = 0x5e,
> +		.int2_func_addr = 0x5f,
> +		.int_func_mask = BIT(5),
>  		.reset_addr = 0x12,
>  		.max_fifo_size = 682,
>  		.id = {
> @@ -395,11 +407,20 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = GENMASK(5, 3),
>  			},
>  		},
> +		.event_settings = {
> +			.wakeup_reg = {
> +				.addr = 0x5B,
> +				.mask = GENMASK(5, 0),
> +			},
> +		},
>  	},
>  	{
>  		.wai = 0x6a,
>  		.int1_addr = 0x0d,
>  		.int2_addr = 0x0e,
> +		.int1_func_addr = 0x5e,
> +		.int2_func_addr = 0x5f,
> +		.int_func_mask = BIT(5),
>  		.reset_addr = 0x12,
>  		.max_fifo_size = 682,
>  		.id = {
> @@ -520,6 +541,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = GENMASK(5, 3),
>  			},
>  		},
> +		.event_settings = {
> +			.enable_reg = {
> +				.addr = 0x58,
> +				.mask = BIT(7),
> +			},
> +			.wakeup_reg = {
> +				.addr = 0x5B,
> +				.mask = GENMASK(5, 0),
> +			},
> +		},
>  	},
>  	{
>  		.wai = 0x6c,
> @@ -666,6 +697,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.wai = 0x6b,
>  		.int1_addr = 0x0d,
>  		.int2_addr = 0x0e,
> +		.int1_func_addr = 0x5e,
> +		.int2_func_addr = 0x5f,
> +		.int_func_mask = BIT(5),
>  		.reset_addr = 0x12,
>  		.max_fifo_size = 512,
>  		.id = {
> @@ -773,11 +807,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = GENMASK(7, 6),
>  			},
>  		},
> +		.event_settings = {
> +			.enable_reg = {
> +				.addr = 0x58,
> +				.mask = BIT(7),
> +			},
> +			.wakeup_reg = {
> +				.addr = 0x5B,
> +				.mask = GENMASK(5, 0),
> +			},
> +		},
>  	},
>  	{
>  		.wai = 0x6b,
>  		.int1_addr = 0x0d,
>  		.int2_addr = 0x0e,
> +		.int1_func_addr = 0x5e,
> +		.int2_func_addr = 0x5f,
> +		.int_func_mask = BIT(5),
>  		.reset_addr = 0x12,
>  		.max_fifo_size = 512,
>  		.id = {
> @@ -913,6 +960,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			.slv0_addr = 0x15,
>  			.dw_slv0_addr = 0x21,
>  			.batch_en = BIT(3),
> +		},
> +		.event_settings = {
> +			.enable_reg = {
> +				.addr = 0x58,
> +				.mask = BIT(7),
> +			},
> +			.wakeup_reg = {
> +				.addr = 0x5B,
> +				.mask = GENMASK(5, 0),
> +			},
>  		}
>  	},
>  };
> @@ -1119,7 +1176,8 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  	if (err < 0)
>  		return err;
>  
> -	st_lsm6dsx_sensor_set_enable(sensor, false);
> +	if (!hw->enable_event)
> +		st_lsm6dsx_sensor_set_enable(sensor, false);
>  
>  	*val = (s16)le16_to_cpu(data);
>  
> @@ -1192,6 +1250,123 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>  	return err;
>  }
>  
> +int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
> +{
> +	int err;
> +	u8 enable = 0;
> +
> +	if (!hw->settings->int1_func_addr)
> +		return -ENOTSUPP;
> +
> +	enable = state ? hw->settings->event_settings.enable_reg.mask : 0;
> +
> +	err = regmap_update_bits(hw->regmap,
> +				 hw->settings->event_settings.enable_reg.addr,
> +				 hw->settings->event_settings.enable_reg.mask,
> +				 enable);
> +	if (err < 0)
> +		return err;
> +
> +	enable = state ? hw->irq_routing.mask : 0;
> +
> +	/* Enable wakeup interrupt */
> +	return regmap_update_bits(hw->regmap, hw->irq_routing.addr,
> +				  hw->irq_routing.mask,
> +				  enable);
> +}
> +
> +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	*val2 = 0;
> +	*val = hw->event_threshold;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	int err;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	if (val < 0 || val > 31)
> +		return -EINVAL;
> +
> +	err = regmap_update_bits(hw->regmap,
> +				 hw->settings->event_settings.wakeup_reg.addr,
> +				 hw->settings->event_settings.wakeup_reg.mask,
> +				 val);
> +	if (err)
> +		return -EINVAL;
> +
> +	hw->event_threshold = val;
> +
> +	return 0;
> +}
> +
> +static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	return hw->enable_event;
> +}
> +
> +static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   enum iio_event_type type,
> +					   enum iio_event_direction dir,
> +					   int state)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	int err = 0;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	/* do not enable events if they are already enabled */
> +	if (state && hw->enable_event)
> +		return 0;
> +
> +	err = st_lsm6dsx_event_setup(hw, state);
> +	if (err < 0)
> +		return err;
> +
> +	err = st_lsm6dsx_sensor_set_enable(sensor, state);
> +	if (err < 0)
> +		return err;
> +
> +	hw->enable_event = state;
> +
> +	return 0;
> +}
> +
>  int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> @@ -1276,6 +1451,10 @@ static const struct iio_info st_lsm6dsx_acc_info = {
>  	.attrs = &st_lsm6dsx_acc_attribute_group,
>  	.read_raw = st_lsm6dsx_read_raw,
>  	.write_raw = st_lsm6dsx_write_raw,
> +	.read_event_value = st_lsm6dsx_read_event,
> +	.write_event_value = st_lsm6dsx_write_event,
> +	.read_event_config = st_lsm6dsx_read_event_config,
> +	.write_event_config = st_lsm6dsx_write_event_config,
>  	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
>  };
>  
> @@ -1321,9 +1500,13 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
>  	switch (drdy_pin) {
>  	case 1:
>  		*drdy_reg = hw->settings->int1_addr;
> +		hw->irq_routing.addr = hw->settings->int1_func_addr;
> +		hw->irq_routing.mask = hw->settings->int_func_mask;
>  		break;
>  	case 2:
>  		*drdy_reg = hw->settings->int2_addr;
> +		hw->irq_routing.addr = hw->settings->int2_func_addr;
> +		hw->irq_routing.mask = hw->settings->int_func_mask;
>  		break;
>  	default:
>  		dev_err(hw->dev, "unsupported data ready pin\n");

