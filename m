Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C244332FC23
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 18:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhCFRCL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 12:02:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhCFRBl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 12:01:41 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442AC64E22;
        Sat,  6 Mar 2021 17:01:39 +0000 (UTC)
Date:   Sat, 6 Mar 2021 17:01:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: convert to regmap
Message-ID: <20210306170134.703f63e0@archlinux>
In-Reply-To: <20210303124725.2884341-1-sean@geanix.com>
References: <20210303124725.2884341-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  3 Mar 2021 13:47:24 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> It will be easier to configure various device registers.
What do you mean by this?  I'm not against regmap, but I think
a stronger rational for the change is needed.

A few specific comments inline, but nothing major.

Jonathan

> 
> No functional change.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 291 +++++++++++++++++++-----------------
>  1 file changed, 156 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 33f0c419d8ff..fc29a6e16428 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -32,6 +32,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
>  
>  #define MMA8452_STATUS				0x00
>  #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
> @@ -102,7 +103,8 @@
>  #define MMA8452_AUTO_SUSPEND_DELAY_MS		2000
>  
>  struct mma8452_data {
> -	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct device *dev;
>  	struct mutex lock;
>  	u8 ctrl_reg1;
>  	u8 data_cfg;
> @@ -163,6 +165,11 @@ static const struct mma8452_event_regs trans_ev_regs = {
>  	.ev_count = MMA8452_TRANSIENT_COUNT,
>  };
>  
> +static const struct regmap_config mma8452_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
>  /**
>   * struct mma_chip_info - chip specific data
>   * @chip_id:			WHO_AM_I register's value
> @@ -194,13 +201,14 @@ enum {
>  static int mma8452_drdy(struct mma8452_data *data)
>  {
>  	int tries = 150;
> +	unsigned int reg;
>  
>  	while (tries-- > 0) {
> -		int ret = i2c_smbus_read_byte_data(data->client,
> -			MMA8452_STATUS);
> +		int ret = regmap_read(data->regmap, MMA8452_STATUS, &reg);
>  		if (ret < 0)
>  			return ret;
> -		if ((ret & MMA8452_STATUS_DRDY) == MMA8452_STATUS_DRDY)
> +
> +		if ((reg & MMA8452_STATUS_DRDY) == MMA8452_STATUS_DRDY)
>  			return 0;
>  
>  		if (data->sleep_val <= 20)
> @@ -210,28 +218,28 @@ static int mma8452_drdy(struct mma8452_data *data)
>  			msleep(20);
>  	}
>  
> -	dev_err(&data->client->dev, "data not ready\n");
> +	dev_err(data->dev, "data not ready\n");
>  
>  	return -EIO;
>  }
>  
> -static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
> +static int mma8452_set_runtime_pm_state(struct device *dev, bool on)
>  {
>  #ifdef CONFIG_PM
>  	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(&client->dev);
> +		ret = pm_runtime_get_sync(dev);
>  	} else {
> -		pm_runtime_mark_last_busy(&client->dev);
> -		ret = pm_runtime_put_autosuspend(&client->dev);
> +		pm_runtime_mark_last_busy(dev);
> +		ret = pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	if (ret < 0) {
> -		dev_err(&client->dev,
> +		dev_err(dev,
>  			"failed to change power state to %d\n", on);
>  		if (on)
> -			pm_runtime_put_noidle(&client->dev);
> +			pm_runtime_put_noidle(dev);
>  
>  		return ret;
>  	}
> @@ -247,14 +255,17 @@ static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, true);
> +	ret = mma8452_set_runtime_pm_state(data->dev, true);
>  	if (ret)
>  		return ret;
>  
> -	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
> -					    3 * sizeof(__be16), (u8 *)buf);
> +	ret = regmap_bulk_read(data->regmap, MMA8452_OUT_X, (u8 *)buf, 3 * sizeof(__be16));
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read axes\n");
> +		return ret;
> +	}
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, false);
> +	ret = mma8452_set_runtime_pm_state(data->dev, false);
>  
>  	return ret;
>  }
> @@ -358,12 +369,12 @@ static const u16 mma8452_os_ratio[4][8] = {
>  
>  static int mma8452_get_power_mode(struct mma8452_data *data)
>  {
> -	int reg;
> +	int ret;
> +	unsigned int reg;
>  
> -	reg = i2c_smbus_read_byte_data(data->client,
> -				       MMA8452_CTRL_REG2);
> -	if (reg < 0)
> -		return reg;
> +	ret = regmap_read(data->regmap, MMA8452_CTRL_REG2, &reg);
> +	if (ret < 0)
> +		return ret;
>  
>  	return ((reg & MMA8452_CTRL_REG2_MODS_MASK) >>
>  		MMA8452_CTRL_REG2_MODS_SHIFT);
> @@ -468,8 +479,9 @@ static int mma8452_get_hp_filter_index(struct mma8452_data *data,
>  static int mma8452_read_hp_filter(struct mma8452_data *data, int *hz, int *uHz)
>  {
>  	int j, i, ret;
> +	unsigned int reg;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, MMA8452_HP_FILTER_CUTOFF);
> +	ret = regmap_read(data->regmap, MMA8452_HP_FILTER_CUTOFF, &reg);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -479,8 +491,8 @@ static int mma8452_read_hp_filter(struct mma8452_data *data, int *hz, int *uHz)
>  		return j;
>  
>  	ret &= MMA8452_HP_FILTER_CUTOFF_SEL_MASK;
> -	*hz = mma8452_hp_filter_cutoff[j][i][ret][0];
> -	*uHz = mma8452_hp_filter_cutoff[j][i][ret][1];
> +	*hz = mma8452_hp_filter_cutoff[j][i][reg][0];
> +	*uHz = mma8452_hp_filter_cutoff[j][i][reg][1];
>  
>  	return 0;
>  }
> @@ -491,6 +503,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	__be16 buffer[3];
> +	unsigned int reg;
>  	int i, ret;
>  
>  	switch (mask) {
> @@ -524,13 +537,11 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		ret = i2c_smbus_read_byte_data(data->client,
> -					       MMA8452_OFF_X +
> -					       chan->scan_index);
> +		ret = regmap_read(data->regmap, MMA8452_OFF_X + chan->scan_index, &reg);
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = sign_extend32(ret, 7);
> +		*val = sign_extend32(reg, 7);
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> @@ -572,24 +583,25 @@ static int mma8452_calculate_sleep(struct mma8452_data *data)
>  
>  static int mma8452_standby(struct mma8452_data *data)
>  {
> -	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
> -					data->ctrl_reg1 & ~MMA8452_CTRL_ACTIVE);
> +	return regmap_write(data->regmap, MMA8452_CTRL_REG1,
> +			    data->ctrl_reg1 & ~MMA8452_CTRL_ACTIVE);
>  }
>  
>  static int mma8452_active(struct mma8452_data *data)
>  {
> -	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
> -					 data->ctrl_reg1);
> +	return regmap_write(data->regmap, MMA8452_CTRL_REG1,
> +			    data->ctrl_reg1);
>  }
>  
>  /* returns >0 if active, 0 if in standby and <0 on error */
>  static int mma8452_is_active(struct mma8452_data *data)
>  {
> -	int reg;
> +	unsigned int reg;
> +	int ret;
>  
> -	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG1);
> -	if (reg < 0)
> -		return reg;
> +	ret = regmap_read(data->regmap, MMA8452_CTRL_REG1, &reg);
> +	if (ret < 0)
> +		return ret;
>  
>  	return reg & MMA8452_CTRL_ACTIVE;
>  }
> @@ -614,7 +626,7 @@ static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
>  			goto fail;
>  	}
>  
> -	ret = i2c_smbus_write_byte_data(data->client, reg, val);
> +	ret = regmap_write(data->regmap, reg, val);
>  	if (ret < 0)
>  		goto fail;
>  
> @@ -633,12 +645,12 @@ static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
>  
>  static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
>  {
> -	int reg;
> +	int ret;
> +	unsigned int reg;
>  
> -	reg = i2c_smbus_read_byte_data(data->client,
> -				       MMA8452_CTRL_REG2);
> -	if (reg < 0)
> -		return reg;
> +	ret = regmap_read(data->regmap, MMA8452_CTRL_REG2, &reg);
> +	if (ret < 0)
> +		return ret;
>  
>  	reg &= ~MMA8452_CTRL_REG2_MODS_MASK;
>  	reg |= mode << MMA8452_CTRL_REG2_MODS_SHIFT;
> @@ -649,55 +661,57 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
>  /* returns >0 if in freefall mode, 0 if not or <0 if an error occurred */
>  static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>  {
> -	int val;
> +	int ret;
> +	unsigned int reg;
>  
> -	val = i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG);
> -	if (val < 0)
> -		return val;
> +	ret = regmap_read(data->regmap, MMA8452_FF_MT_CFG, &reg);
> +	if (ret < 0)
> +		return ret;
>  
> -	return !(val & MMA8452_FF_MT_CFG_OAE);
> +	return !(reg & MMA8452_FF_MT_CFG_OAE);
>  }
>  
>  static int mma8452_set_freefall_mode(struct mma8452_data *data, bool state)
>  {
> -	int val;
> +	int ret;
> +	unsigned int reg;
>  
>  	if ((state && mma8452_freefall_mode_enabled(data)) ||
>  	    (!state && !(mma8452_freefall_mode_enabled(data))))
>  		return 0;
>  
> -	val = i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG);
> -	if (val < 0)
> -		return val;
> +	ret = regmap_read(data->regmap, MMA8452_FF_MT_CFG, &reg);
> +	if (ret < 0)
> +		return ret;
>  
>  	if (state) {
> -		val |= BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
> -		val |= BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
> -		val |= BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
> -		val &= ~MMA8452_FF_MT_CFG_OAE;
> +		reg |= BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
> +		reg |= BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
> +		reg |= BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
> +		reg &= ~MMA8452_FF_MT_CFG_OAE;
>  	} else {
> -		val &= ~BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
> -		val &= ~BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
> -		val &= ~BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
> -		val |= MMA8452_FF_MT_CFG_OAE;
> +		reg &= ~BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
> +		reg &= ~BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
> +		reg &= ~BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
> +		reg |= MMA8452_FF_MT_CFG_OAE;
>  	}
>  
> -	return mma8452_change_config(data, MMA8452_FF_MT_CFG, val);
> +	return mma8452_change_config(data, MMA8452_FF_MT_CFG, reg);
>  }
>  
>  static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
>  					   int val, int val2)
>  {
> -	int i, reg;
> +	unsigned int reg;
> +	int i, ret;
>  
>  	i = mma8452_get_hp_filter_index(data, val, val2);
>  	if (i < 0)
>  		return i;
>  
> -	reg = i2c_smbus_read_byte_data(data->client,
> -				       MMA8452_HP_FILTER_CUTOFF);
> -	if (reg < 0)
> -		return reg;
> +	ret = regmap_read(data->regmap, MMA8452_HP_FILTER_CUTOFF, &reg);
> +	if (ret < 0)
> +		return ret;
>  
>  	reg &= ~MMA8452_HP_FILTER_CUTOFF_SEL_MASK;
>  	reg |= i;
> @@ -827,6 +841,7 @@ static int mma8452_read_event_value(struct iio_dev *indio_dev,
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	int ret, us, power_mode;
> +	unsigned int reg;
>  	const struct mma8452_event_regs *ev_regs;
>  
>  	ret = mma8452_get_event_regs(data, chan, dir, &ev_regs);
> @@ -835,16 +850,16 @@ static int mma8452_read_event_value(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> -		ret = i2c_smbus_read_byte_data(data->client, ev_regs->ev_ths);
> +		ret = regmap_read(data->regmap, ev_regs->ev_ths, &reg);
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = ret & ev_regs->ev_ths_mask;
> +		*val = reg & ev_regs->ev_ths_mask;
>  
>  		return IIO_VAL_INT;
>  
>  	case IIO_EV_INFO_PERIOD:
> -		ret = i2c_smbus_read_byte_data(data->client, ev_regs->ev_count);
> +		ret = regmap_read(data->regmap, ev_regs->ev_count, &reg);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -852,7 +867,7 @@ static int mma8452_read_event_value(struct iio_dev *indio_dev,
>  		if (power_mode < 0)
>  			return power_mode;
>  
> -		us = ret * mma8452_time_step_us[power_mode][
> +		us = reg * mma8452_time_step_us[power_mode][
>  				mma8452_get_odr_index(data)];
>  		*val = us / USEC_PER_SEC;
>  		*val2 = us % USEC_PER_SEC;
> @@ -860,12 +875,11 @@ static int mma8452_read_event_value(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_MICRO;
>  
>  	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
> -		ret = i2c_smbus_read_byte_data(data->client,
> -					       MMA8452_TRANSIENT_CFG);
> +		ret = regmap_read(data->regmap, MMA8452_TRANSIENT_CFG, &reg);
>  		if (ret < 0)
>  			return ret;
>  
> -		if (ret & MMA8452_TRANSIENT_CFG_HPF_BYP) {
> +		if (reg & MMA8452_TRANSIENT_CFG_HPF_BYP) {
>  			*val = 0;
>  			*val2 = 0;
>  		} else {
> @@ -918,10 +932,9 @@ static int mma8452_write_event_value(struct iio_dev *indio_dev,
>  		return mma8452_change_config(data, ev_regs->ev_count, steps);
>  
>  	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
> -		reg = i2c_smbus_read_byte_data(data->client,
> -					       MMA8452_TRANSIENT_CFG);
> -		if (reg < 0)
> -			return reg;
> +		ret = regmap_read(data->regmap, MMA8452_TRANSIENT_CFG, &reg);
> +		if (ret < 0)
> +			return ret;
>  
>  		if (val == 0 && val2 == 0) {
>  			reg |= MMA8452_TRANSIENT_CFG_HPF_BYP;
> @@ -945,6 +958,7 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
>  				     enum iio_event_direction dir)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	unsigned int reg;
>  	int ret;
>  	const struct mma8452_event_regs *ev_regs;
>  
> @@ -956,12 +970,11 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
>  	case IIO_EV_DIR_FALLING:
>  		return mma8452_freefall_mode_enabled(data);
>  	case IIO_EV_DIR_RISING:
> -		ret = i2c_smbus_read_byte_data(data->client,
> -				ev_regs->ev_cfg);
> +		ret = regmap_read(data->regmap, ev_regs->ev_cfg, &reg);
>  		if (ret < 0)
>  			return ret;
>  
> -		return !!(ret & BIT(chan->scan_index +
> +		return !!(reg & BIT(chan->scan_index +
>  				ev_regs->ev_cfg_chan_shift));
>  	default:
>  		return -EINVAL;
> @@ -975,14 +988,15 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  				      int state)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	int val, ret;
> +	unsigned int reg;
> +	int ret;
>  	const struct mma8452_event_regs *ev_regs;
>  
>  	ret = mma8452_get_event_regs(data, chan, dir, &ev_regs);
>  	if (ret)
>  		return ret;
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, state);
> +	ret = mma8452_set_runtime_pm_state(data->dev, state);
>  	if (ret)
>  		return ret;
>  
> @@ -990,30 +1004,30 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  	case IIO_EV_DIR_FALLING:
>  		return mma8452_set_freefall_mode(data, state);
>  	case IIO_EV_DIR_RISING:
> -		val = i2c_smbus_read_byte_data(data->client, ev_regs->ev_cfg);
> -		if (val < 0)
> -			return val;
> +		ret = regmap_read(data->regmap, ev_regs->ev_cfg, &reg);
> +		if (ret < 0)
> +			return ret;
>  
>  		if (state) {
>  			if (mma8452_freefall_mode_enabled(data)) {
> -				val &= ~BIT(idx_x + ev_regs->ev_cfg_chan_shift);
> -				val &= ~BIT(idx_y + ev_regs->ev_cfg_chan_shift);
> -				val &= ~BIT(idx_z + ev_regs->ev_cfg_chan_shift);
> -				val |= MMA8452_FF_MT_CFG_OAE;
> +				reg &= ~BIT(idx_x + ev_regs->ev_cfg_chan_shift);
> +				reg &= ~BIT(idx_y + ev_regs->ev_cfg_chan_shift);
> +				reg &= ~BIT(idx_z + ev_regs->ev_cfg_chan_shift);
> +				reg |= MMA8452_FF_MT_CFG_OAE;
>  			}
> -			val |= BIT(chan->scan_index +
> +			reg |= BIT(chan->scan_index +
>  					ev_regs->ev_cfg_chan_shift);
>  		} else {
>  			if (mma8452_freefall_mode_enabled(data))
>  				return 0;
>  
> -			val &= ~BIT(chan->scan_index +
> +			reg &= ~BIT(chan->scan_index +
>  					ev_regs->ev_cfg_chan_shift);
>  		}
>  
> -		val |= ev_regs->ev_cfg_ele;
> +		reg |= ev_regs->ev_cfg_ele;
>  
> -		return mma8452_change_config(data, ev_regs->ev_cfg, val);
> +		return mma8452_change_config(data, ev_regs->ev_cfg, reg);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1023,27 +1037,28 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	s64 ts = iio_get_time_ns(indio_dev);
> -	int src;
> +	unsigned int reg;
> +	int ret;
>  
> -	src = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_SRC);
> -	if (src < 0)
> +	ret = regmap_read(data->regmap, MMA8452_TRANSIENT_SRC, &reg);
> +	if (ret < 0)
>  		return;
>  
> -	if (src & MMA8452_TRANSIENT_SRC_XTRANSE)
> +	if (reg & MMA8452_TRANSIENT_SRC_XTRANSE)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
>  						  IIO_EV_TYPE_MAG,
>  						  IIO_EV_DIR_RISING),
>  			       ts);
>  
> -	if (src & MMA8452_TRANSIENT_SRC_YTRANSE)
> +	if (reg & MMA8452_TRANSIENT_SRC_YTRANSE)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
>  						  IIO_EV_TYPE_MAG,
>  						  IIO_EV_DIR_RISING),
>  			       ts);
>  
> -	if (src & MMA8452_TRANSIENT_SRC_ZTRANSE)
> +	if (reg & MMA8452_TRANSIENT_SRC_ZTRANSE)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
>  						  IIO_EV_TYPE_MAG,
> @@ -1055,22 +1070,22 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>  {
>  	struct iio_dev *indio_dev = p;
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	int ret = IRQ_NONE;
> -	int src;
> +	int rc, ret = IRQ_NONE;
> +	unsigned int reg;

renaming src to reg is I suppose consistent with the rest of the
driver but it does result in a fair bit of churn in here.
I suppose it doesn't really matter though as easy enough to check.

>  
> -	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
> -	if (src < 0)
> -		return IRQ_NONE;
> +	rc = regmap_read(data->regmap, MMA8452_INT_SRC, &reg);
> +	if (rc < 0)
> +		return ret;

Keep this as IRQ_NONE as it makes it easy to check rather than having to
go see what ret is set to above.

>  
> -	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
> -		return IRQ_NONE;
> +	if (!(reg & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
> +		return ret;

Same here

>  
> -	if (src & MMA8452_INT_DRDY) {
> +	if (reg & MMA8452_INT_DRDY) {
>  		iio_trigger_poll_chained(indio_dev->trig);
>  		ret = IRQ_HANDLED;
>  	}
>  
> -	if (src & MMA8452_INT_FF_MT) {
> +	if (reg & MMA8452_INT_FF_MT) {
>  		if (mma8452_freefall_mode_enabled(data)) {
>  			s64 ts = iio_get_time_ns(indio_dev);
>  
> @@ -1084,7 +1099,7 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>  		ret = IRQ_HANDLED;
>  	}
>  
> -	if (src & MMA8452_INT_TRANS) {
> +	if (reg & MMA8452_INT_TRANS) {
>  		mma8452_transient_interrupt(indio_dev);
>  		ret = IRQ_HANDLED;
>  	}
> @@ -1125,12 +1140,10 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
>  	if (!readval)
>  		return mma8452_change_config(data, reg, writeval);
>  
> -	ret = i2c_smbus_read_byte_data(data->client, reg);
> +	ret = regmap_read(data->regmap, reg, readval);
>  	if (ret < 0)
>  		return ret;
>  
> -	*readval = ret;
> -
>  	return 0;
>  }
>  
> @@ -1430,15 +1443,16 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	int reg, ret;
> +	unsigned int reg;
> +	int ret;
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, state);
> +	ret = mma8452_set_runtime_pm_state(data->dev, state);
>  	if (ret)
>  		return ret;
>  
> -	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
> -	if (reg < 0)
> -		return reg;
> +	ret = regmap_read(data->regmap, MMA8452_CTRL_REG4, &reg);
> +	if (ret < 0)
> +		return ret;
>  
>  	if (state)
>  		reg |= MMA8452_INT_DRDY;
> @@ -1459,13 +1473,13 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
>  	struct iio_trigger *trig;
>  	int ret;
>  
> -	trig = devm_iio_trigger_alloc(&data->client->dev, "%s-dev%d",
> +	trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
>  				      indio_dev->name,
>  				      indio_dev->id);
>  	if (!trig)
>  		return -ENOMEM;
>  
> -	trig->dev.parent = &data->client->dev;
> +	trig->dev.parent = data->dev;
>  	trig->ops = &mma8452_trigger_ops;
>  	iio_trigger_set_drvdata(trig, indio_dev);
>  
> @@ -1524,6 +1538,8 @@ static int mma8452_probe(struct i2c_client *client,
>  {
>  	struct mma8452_data *data;
>  	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	unsigned int reg;
>  	int ret;
>  	const struct of_device_id *match;
>  
> @@ -1537,10 +1553,18 @@ static int mma8452_probe(struct i2c_client *client,
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	regmap = devm_regmap_init_i2c(client, &mma8452_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "failed to initialize regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
>  	data = iio_priv(indio_dev);
> -	data->client = client;
> +	i2c_set_clientdata(client, indio_dev);

The move of this feels unrelated, but maybe I'm missing something.

> +	data->dev = &client->dev;
>  	mutex_init(&data->lock);
>  	data->chip_info = match->data;
> +	data->regmap = regmap;
>  
>  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(data->vdd_reg))
> @@ -1564,18 +1588,18 @@ static int mma8452_probe(struct i2c_client *client,
>  		goto disable_regulator_vdd;
>  	}
>  
> -	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
> +	ret = regmap_read(data->regmap, MMA8452_WHO_AM_I, &reg);
>  	if (ret < 0)
>  		goto disable_regulators;
>  
> -	switch (ret) {
> +	switch (reg) {
>  	case MMA8451_DEVICE_ID:
>  	case MMA8452_DEVICE_ID:
>  	case MMA8453_DEVICE_ID:
>  	case MMA8652_DEVICE_ID:
>  	case MMA8653_DEVICE_ID:
>  	case FXLS8471_DEVICE_ID:
> -		if (ret == data->chip_info->chip_id)
> +		if (reg == data->chip_info->chip_id)
>  			break;
>  		fallthrough;
>  	default:
> @@ -1586,7 +1610,6 @@ static int mma8452_probe(struct i2c_client *client,
>  	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
>  		 match->compatible, data->chip_info->chip_id);
>  
> -	i2c_set_clientdata(client, indio_dev);
>  	indio_dev->info = &mma8452_info;
>  	indio_dev->name = id->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1599,8 +1622,8 @@ static int mma8452_probe(struct i2c_client *client,
>  		goto disable_regulators;
>  
>  	data->data_cfg = MMA8452_DATA_CFG_FS_2G;
> -	ret = i2c_smbus_write_byte_data(client, MMA8452_DATA_CFG,
> -					data->data_cfg);
> +	ret = regmap_write(data->regmap, MMA8452_DATA_CFG,
> +			   data->data_cfg);
>  	if (ret < 0)
>  		goto disable_regulators;
>  
> @@ -1608,8 +1631,8 @@ static int mma8452_probe(struct i2c_client *client,
>  	 * By default set transient threshold to max to avoid events if
>  	 * enabling without configuring threshold.
>  	 */
> -	ret = i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS,
> -					MMA8452_TRANSIENT_THS_MASK);
> +	ret = regmap_write(data->regmap, MMA8452_TRANSIENT_THS,
> +			   MMA8452_TRANSIENT_THS_MASK);
>  	if (ret < 0)
>  		goto disable_regulators;
>  
> @@ -1621,18 +1644,16 @@ static int mma8452_probe(struct i2c_client *client,
>  		if (irq2 == client->irq) {
>  			dev_dbg(&client->dev, "using interrupt line INT2\n");
>  		} else {
> -			ret = i2c_smbus_write_byte_data(client,
> -						MMA8452_CTRL_REG5,
> -						data->chip_info->all_events);
> +			ret = regmap_write(data->regmap, MMA8452_CTRL_REG5,
> +					   data->chip_info->all_events);
>  			if (ret < 0)
>  				goto disable_regulators;
>  
>  			dev_dbg(&client->dev, "using interrupt line INT1\n");
>  		}
>  
> -		ret = i2c_smbus_write_byte_data(client,
> -					MMA8452_CTRL_REG4,
> -					data->chip_info->enabled_events);
> +		ret = regmap_write(data->regmap, MMA8452_CTRL_REG4,
> +				   data->chip_info->enabled_events);
>  		if (ret < 0)
>  			goto disable_regulators;
>  
> @@ -1646,8 +1667,8 @@ static int mma8452_probe(struct i2c_client *client,
>  
>  	data->sleep_val = mma8452_calculate_sleep(data);
>  
> -	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
> -					data->ctrl_reg1);
> +	ret = regmap_write(data->regmap, MMA8452_CTRL_REG1,
> +			   data->ctrl_reg1);

Can drop the line break here.

>  	if (ret < 0)
>  		goto trigger_cleanup;
>  
> @@ -1735,7 +1756,7 @@ static int mma8452_runtime_suspend(struct device *dev)
>  	ret = mma8452_standby(data);
>  	mutex_unlock(&data->lock);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "powering off device failed\n");
> +		dev_err(data->dev, "powering off device failed\n");
>  		return -EAGAIN;
>  	}
>  

