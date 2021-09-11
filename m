Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C544079BC
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhIKRII (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 13:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhIKRII (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 13:08:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940C4611F0;
        Sat, 11 Sep 2021 17:06:54 +0000 (UTC)
Date:   Sat, 11 Sep 2021 18:10:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baptiste Mansuy <bmansuy@invensense.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: mpu6050: add watermark support for
 icm20602/20690
Message-ID: <20210911181024.0ce3e225@jic23-huawei>
In-Reply-To: <20210906123219.3084706-1-bmansuy@invensense.com>
References: <20210906123219.3084706-1-bmansuy@invensense.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  6 Sep 2021 12:32:19 +0000
Baptiste Mansuy <bmansuy@invensense.com> wrote:

> Add watermark support using FIFO interrupt for chips having this
> feature. This allows the use of the watermark interrupt with the
> posibility to change it's size. Change the timestamp computation
> to be used with the watermark.
> 
> Add the set_watermark and flush callbacks according to the iio
> description.
> 
> Signed-off-by: Baptiste Mansuy <bmansuy@invensense.com>

Hi,

A few comments inline.

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 104 +++++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  21 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 130 +++++++++++++-----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  24 +++-
>  4 files changed, 237 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 597768c..9cdec62 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -47,7 +47,9 @@ static const struct inv_mpu6050_reg_map reg_set_icm20602 = {
>  	.raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
>  	.temperature            = INV_MPU6050_REG_TEMPERATURE,
>  	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
> -	.int_status             = INV_MPU6050_REG_INT_STATUS,
> +	.int_status             = INV_ICM20602_REG_FIFO_WM_INT_STATUS,
> +	.wm_th_hb               = INV_ICM20602_FIFO_WM_TH_HB,
> +	.wm_th_lb               = INV_ICM20602_FIFO_WM_TH_LB,
>  	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
>  	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
>  	.int_pin_cfg            = INV_MPU6050_REG_INT_PIN_CFG,
> @@ -56,6 +58,31 @@ static const struct inv_mpu6050_reg_map reg_set_icm20602 = {
>  	.i2c_if                 = INV_ICM20602_REG_I2C_IF,
>  };
>  
> +static const struct inv_mpu6050_reg_map reg_set_icm20690 = {
> +	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
> +	.lpf                    = INV_MPU6050_REG_CONFIG,
> +	.accel_lpf              = INV_MPU6500_REG_ACCEL_CONFIG_2,
> +	.user_ctrl              = INV_MPU6050_REG_USER_CTRL,
> +	.fifo_en                = INV_MPU6050_REG_FIFO_EN,
> +	.gyro_config            = INV_MPU6050_REG_GYRO_CONFIG,
> +	.accl_config            = INV_MPU6050_REG_ACCEL_CONFIG,
> +	.fifo_count_h           = INV_MPU6050_REG_FIFO_COUNT_H,
> +	.fifo_r_w               = INV_MPU6050_REG_FIFO_R_W,
> +	.raw_gyro               = INV_MPU6050_REG_RAW_GYRO,
> +	.raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
> +	.temperature            = INV_MPU6050_REG_TEMPERATURE,
> +	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
> +	.int_status             = INV_ICM20602_REG_FIFO_WM_INT_STATUS,
> +	.wm_th_hb               = INV_ICM20690_FIFO_WM_TH_HB,
> +	.wm_th_lb               = INV_ICM20690_FIFO_WM_TH_LB,
> +	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
> +	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
> +	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
> +	.accl_offset		= INV_MPU6500_REG_ACCEL_OFFSET,
> +	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
> +	.i2c_if                 = 0,
> +};
> +
>  static const struct inv_mpu6050_reg_map reg_set_6500 = {
>  	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
>  	.lpf                    = INV_MPU6050_REG_CONFIG,
> @@ -115,6 +142,8 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
>  	.magn_fifo_enable = false,
>  	.accl_fs = INV_MPU6050_FS_02G,
>  	.user_ctrl = 0,
> +	.wm_val = 1,
> +	.wm_size = 0,

I don't think this is ever relevant to parts using this structure.

>  };
>  
>  static const struct inv_mpu6050_chip_config chip_config_6500 = {
> @@ -132,6 +161,8 @@ static const struct inv_mpu6050_chip_config chip_config_6500 = {
>  	.magn_fifo_enable = false,
>  	.accl_fs = INV_MPU6050_FS_02G,
>  	.user_ctrl = 0,
> +	.wm_val = 1,
> +	.wm_size = 0,

>  };
>  
>  /* Indexed by enum inv_devices */
> @@ -247,7 +278,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  	{
>  		.whoami = INV_ICM20690_WHOAMI_VALUE,
>  		.name = "ICM20690",
> -		.reg = &reg_set_6500,
> +		.reg = &reg_set_icm20690,
>  		.config = &chip_config_6500,
>  		.fifo_size = 1024,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> @@ -264,6 +295,38 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  	},
>  };
>  
> +int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsigned int val)
> +{
> +	unsigned int nb_byte, new_size_byte;
> +	int ret;
> +
> +	/* compute number of bytes inside FIFO */
> +	nb_byte = 0;
> +	if (st->chip_config.gyro_en)
> +		nb_byte += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> +	if (st->chip_config.accl_en)
> +		nb_byte += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> +	if (st->chip_config.magn_en)
> +		nb_byte += INV_MPU9X50_BYTES_MAGN;
> +	if (st->chip_config.temp_en)
> +		nb_byte += INV_MPU6050_BYTES_PER_TEMP_SENSOR;
> +
> +	/* compute watermark size, use a threshold to keep some data space for read latency */

Not following this comment.  If the intent is you are setting the watermark in hardware lower
because you think more data will have come in before we actually read it, please don't.
The sampling frequency could be very low meaning there isn't enough data available.

We are dealing with a fifo here, it doesn't matter if a few more samples are available when
we go to read than the level of the watermark.  That's normal.

> +	new_size_byte = val * nb_byte;
> +	if (new_size_byte > ((st->hw->fifo_size * 4) / 5)) {
> +		val = ((st->hw->fifo_size * 4) / 5) / nb_byte;
> +		new_size_byte = val * nb_byte;
> +	}
> +
> +	ret = inv_mpu6050_set_hw_watermark(st, new_size_byte);
> +	if (ret)
> +		return ret;
> +
> +	st->chip_config.wm_val = val;
> +
> +	return 0;
> +}
> +
>  static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
>  					int clock, int temp_dis)
>  {
> @@ -1290,6 +1353,39 @@ static int inv_mpu6050_reg_access(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int inv_mpu6050_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (st->chip_type) {
> +	case INV_ICM20602:
> +	case INV_ICM20690:
> +		mutex_lock(&st->lock);
> +		ret = inv_mpu6050_compute_hw_watermark(st, val);
> +		mutex_unlock(&st->lock);
> +		break;
> +	default:
> +		ret = 0;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int inv_mpu6050_hw_flush_to_buffer(struct iio_dev *indio_dev,
> +				      unsigned int count)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = inv_mpu6050_flush_fifo(indio_dev, 0, count);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
>  static const struct iio_info mpu_info = {
>  	.read_raw = &inv_mpu6050_read_raw,
>  	.write_raw = &inv_mpu6050_write_raw,
> @@ -1297,6 +1393,8 @@ static const struct iio_info mpu_info = {
>  	.attrs = &inv_attribute_group,
>  	.validate_trigger = inv_mpu6050_validate_trigger,
>  	.debugfs_reg_access = &inv_mpu6050_reg_access,
> +	.hwfifo_set_watermark = &inv_mpu6050_set_watermark,
> +	.hwfifo_flush_to_buffer = &inv_mpu6050_hw_flush_to_buffer,
>  };
>  
>  /*
> @@ -1618,7 +1716,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		 */
>  		result = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  							 iio_pollfunc_store_time,
> -							 inv_mpu6050_read_fifo,
> +							 inv_mpu6050_interrupt_handler,
>  							 NULL);
>  		if (result) {
>  			dev_err(dev, "configure buffer fail %d\n", result);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index c6aa36e..d925885 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -57,6 +57,8 @@ struct inv_mpu6050_reg_map {
>  	u8 temperature;
>  	u8 int_enable;
>  	u8 int_status;
> +	u8 wm_th_hb;
> +	u8 wm_th_lb;
>  	u8 pwr_mgmt_1;
>  	u8 pwr_mgmt_2;
>  	u8 int_pin_cfg;
> @@ -121,6 +123,8 @@ struct inv_mpu6050_chip_config {
>  	unsigned int magn_fifo_enable:1;
>  	u8 divider;
>  	u8 user_ctrl;
> +	unsigned int wm_val;
What are these two? Non obvious enough a comment would be good.

> +	unsigned int wm_size;
>  };
>  
>  /*
> @@ -264,8 +268,19 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
>  #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
>  
> +#define INV_ICM20602_REG_FIFO_WM_INT_STATUS 0x39
> +#define INV_ICM20602_BIT_FIFO_WM_INT        0x40
> +
>  #define INV_MPU6050_REG_EXT_SENS_DATA       0x49
>  
> +#define INV_ICM20602_FIFO_WM_TH_HB          0x60
> +#define INV_ICM20602_BITS_FIFO_WM_TH_HB     0x03
> +#define INV_ICM20602_FIFO_WM_TH_LB          0x61
> +
> +#define INV_ICM20690_FIFO_WM_TH_HB          0x5E
> +#define INV_ICM20690_BITS_FIFO_WM_TH_HB     0x03
> +#define INV_ICM20690_FIFO_WM_TH_LB          0x61
> +
>  /* I2C slaves data output from 0 to 3 */
>  #define INV_MPU6050_REG_I2C_SLV_DO(_x)      (0x63 + (_x))
>  
> @@ -338,7 +353,6 @@ struct inv_mpu6050_state {
>  #define INV_ICM20690_GYRO_STARTUP_TIME       80
>  #define INV_ICM20690_ACCEL_STARTUP_TIME      10
>  
> -
>  /* delay time in microseconds */
>  #define INV_MPU6050_REG_UP_TIME_MIN          5000
>  #define INV_MPU6050_REG_UP_TIME_MAX          10000
> @@ -457,7 +471,7 @@ enum inv_mpu6050_clock_sel_e {
>  	NUM_CLK
>  };
>  
> -irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
> +irqreturn_t inv_mpu6050_interrupt_handler(int irq, void *p);
>  int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type);
>  int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable);
>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
> @@ -468,5 +482,8 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
>  extern const struct dev_pm_ops inv_mpu_pmops;
> +int inv_mpu6050_set_hw_watermark(struct inv_mpu6050_state *st, unsigned int wm_size_byte);
> +int inv_mpu6050_compute_hw_watermark(struct inv_mpu6050_state *st, unsigned int wm_size_byte);
> +int inv_mpu6050_flush_fifo(struct iio_dev *indio_dev, s64 timestamp_val, unsigned int count);
>  
>  #endif
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 45c3752..d6e6246 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -40,15 +40,16 @@ static void inv_mpu6050_update_period(struct inv_mpu6050_state *st,
>  	if (st->it_timestamp == 0) {
>  		/* not initialized, forced to use it_timestamp */
>  		use_it_timestamp = true;
> -	} else if (nb == 1) {
> +	} else if (nb == st->chip_config.wm_val) {
>  		/*
>  		 * Validate the use of it timestamp by checking if interrupt
>  		 * has been delayed.
> -		 * nb > 1 means interrupt was delayed for more than 1 sample,
> +		 * nb > wm_val means interrupt was delayed for more than 1 sample,
>  		 * so it's obviously not good.
> +		 * If watermark does not exist for the chip, wm_val = 1.
>  		 * Compute the chip period between 2 interrupts for validating.
>  		 */
> -		delta = div_s64(timestamp - st->it_timestamp, divider);
> +		delta = div_s64(timestamp - st->it_timestamp, divider) / st->chip_config.wm_val;
>  		if (delta > period_min && delta < period_max) {
>  			/* update chip period and use it timestamp */
>  			st->chip_period = (st->chip_period + delta) / 2;
> @@ -89,6 +90,25 @@ static s64 inv_mpu6050_get_timestamp(struct inv_mpu6050_state *st)
>  	return ts;
>  }
>  
> +int inv_mpu6050_set_hw_watermark(struct inv_mpu6050_state *st, unsigned int size)
> +{
> +	int ret;
> +
> +	if (size == st->chip_config.wm_size)
> +		return 0;
> +
> +	ret = regmap_write(st->map, st->reg->wm_th_hb, (size >> 8) & 0xFF);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->map, st->reg->wm_th_lb, size & 0xFF);
> +	if (ret)
> +		return ret;
> +
> +	st->chip_config.wm_size = size;
> +	return 0;
> +}
> +
>  static int inv_reset_fifo(struct iio_dev *indio_dev)
>  {
>  	int result;
> @@ -104,43 +124,33 @@ static int inv_reset_fifo(struct iio_dev *indio_dev)
>  
>  reset_fifo_fail:
>  	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
> -	result = regmap_write(st->map, st->reg->int_enable,
> -			      INV_MPU6050_BIT_DATA_RDY_EN);
> -
> +	switch (st->chip_type) {
> +	case INV_ICM20602:
> +	case INV_ICM20690:
> +		result = inv_mpu6050_set_hw_watermark(st, st->chip_config.wm_size);
return inv_mpu...

> +		break;
> +	default:
> +		result = regmap_write(st->map, st->reg->int_enable,
> +				INV_MPU6050_BIT_DATA_RDY_EN);
return regmap_write(...

> +	}
>  	return result;
>  }
>  
> -/*
> - * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
> - */
> -irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)

Given the count parameter has a 'special' value of 0, please add some documentation
for this function.

> +int inv_mpu6050_flush_fifo(struct iio_dev *indio_dev,
> +				      s64 timestamp_val, unsigned int count)
>  {
> -	struct iio_poll_func *pf = p;
> -	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> -	size_t bytes_per_datum;
> -	int result;
>  	u16 fifo_count;
>  	s64 timestamp;
> -	int int_status;
> +	int result;
>  	size_t i, nb;
> -
> -	mutex_lock(&st->lock);
> -
> -	/* ack interrupt and check status */
> -	result = regmap_read(st->map, st->reg->int_status, &int_status);
> -	if (result) {
> -		dev_err(regmap_get_device(st->map),
> -			"failed to ack interrupt\n");
> -		goto flush_fifo;
> -	}
> -	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
> -		goto end_session;
> +	size_t bytes_per_datum;
>  
>  	if (!(st->chip_config.accl_fifo_enable |
>  		st->chip_config.gyro_fifo_enable |
>  		st->chip_config.magn_fifo_enable))
> -		goto end_session;
> +		return 0;
> +
>  	bytes_per_datum = 0;
>  	if (st->chip_config.accl_fifo_enable)
>  		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> @@ -161,7 +171,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	result = regmap_bulk_read(st->map, st->reg->fifo_count_h,
>  				  st->data, INV_MPU6050_FIFO_COUNT_BYTE);
>  	if (result)
> -		goto end_session;
> +		return 0;
>  	fifo_count = be16_to_cpup((__be16 *)&st->data[0]);
>  
>  	/*
> @@ -171,18 +181,31 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	 */
>  	nb = 3 * bytes_per_datum;
>  	if (fifo_count >= st->hw->fifo_size - nb) {
> -		dev_warn(regmap_get_device(st->map), "fifo overflow reset\n");
> -		goto flush_fifo;
> +		dev_warn(regmap_get_device(st->map), "fifo overflow\n");
> +		inv_reset_fifo(indio_dev);
> +		return -1;
>  	}
>  
>  	/* compute and process all complete datum */
>  	nb = fifo_count / bytes_per_datum;
> -	inv_mpu6050_update_period(st, pf->timestamp, nb);
> +	/*
> +	 * As fifo_size may differ according to the chip unsigned
> +	 * count = 0 is used to choose the max value for count
> +	 */

Add this to the function documentation as it's not obvious.

> +	if (count == 0)
> +		count = st->hw->fifo_size / bytes_per_datum;
> +	if (timestamp_val != 0)
> +		inv_mpu6050_update_period(st, timestamp_val, nb);
> +	if (nb > count)
> +		nb = count;

nb = min(nb, count);

>  	for (i = 0; i < nb; ++i) {
>  		result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
>  					   st->data, bytes_per_datum);
> -		if (result)
> -			goto flush_fifo;
> +		if (result) {
> +			inv_reset_fifo(indio_dev);
> +			return result;
> +		}
> +
>  		/* skip first samples if needed */
>  		if (st->skip_samples) {
>  			st->skip_samples--;
> @@ -192,6 +215,45 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  		iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
>  	}
>  
> +	return i;
> +}
> +
> +/*
> + * inv_mpu6050_interrupt_handler() - Transfer data from hardware FIFO to KFIFO.
> + */
> +irqreturn_t inv_mpu6050_interrupt_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	int result;
> +	int int_status;
> +	int int_status_bit;
> +
> +	mutex_lock(&st->lock);
> +
> +	/* ack interrupt and check status */
> +	result = regmap_read(st->map, st->reg->int_status, &int_status);
> +	if (result) {
> +		dev_err(regmap_get_device(st->map),
> +			"failed to ack interrupt\n");
> +		goto flush_fifo;
> +	}
> +
> +	switch (st->chip_type) {
> +	case INV_ICM20602:
> +	case INV_ICM20690:
> +		int_status_bit = INV_ICM20602_BIT_FIFO_WM_INT;
> +		break;
> +	default:
> +		int_status_bit = INV_MPU6050_BIT_RAW_DATA_RDY_INT;
> +		break;
> +	}
> +	if (!(int_status & int_status_bit))
> +		goto end_session;
> +
> +	inv_mpu6050_flush_fifo(indio_dev, pf->timestamp, 0);
> +
>  end_session:
>  	mutex_unlock(&st->lock);
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 8825468..c685ed4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -131,10 +131,28 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
>  		if (ret)
>  			return ret;
>  		/* enable interrupt */
> -		ret = regmap_write(st->map, st->reg->int_enable,
> -				   INV_MPU6050_BIT_DATA_RDY_EN);
> +		switch (st->chip_type) {
> +		case INV_ICM20602:
> +		case INV_ICM20690:
> +			/* watermark interrupt is enabled by setting the watermark value */
> +			ret = inv_mpu6050_compute_hw_watermark(st, st->chip_config.wm_val);
> +			break;
> +		default:
> +			ret = regmap_write(st->map, st->reg->int_enable,
> +					INV_MPU6050_BIT_DATA_RDY_EN);
> +			break;
> +		}
>  	} else {
> -		ret = regmap_write(st->map, st->reg->int_enable, 0);
> +		switch (st->chip_type) {
> +		case INV_ICM20602:
> +		case INV_ICM20690:
> +			/* watermark interrupt is disabled by setting the watermark value to 0 */
> +			ret = inv_mpu6050_set_hw_watermark(st, 0);
> +			break;
> +		default:
> +			ret = regmap_write(st->map, st->reg->int_enable, 0);
> +			break;
> +		}
>  		if (ret)
>  			return ret;
>  		ret = regmap_write(st->map, st->reg->fifo_en, 0);

