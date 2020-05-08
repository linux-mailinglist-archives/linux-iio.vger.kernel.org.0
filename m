Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00B1CB1A7
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEHOWy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 10:22:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbgEHOWy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 10:22:54 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 52CC78E7FE0F72B49E69;
        Fri,  8 May 2020 15:22:52 +0100 (IST)
Received: from localhost (10.47.95.97) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 May 2020
 15:22:51 +0100
Date:   Fri, 8 May 2020 15:22:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <robh@kernel.org>,
        <mchehab+huawei@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/12] iio: imu: inv_icm42600: add device interrupt
 trigger
Message-ID: <20200508152229.00005de2@Huawei.com>
In-Reply-To: <20200507144222.20989-9-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-9-jmaneyrol@invensense.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.97]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 May 2020 16:42:18 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Add INT1 interrupt support and use it as an iio trigger.
> Support interrupt edge and level, active high or low.
> Push-pull configuration only.
> 
> Trigger enables FIFO and will be useful with buffer support.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

So it's an odd trigger... But you check its only used for the
device itself which stops that being visible to anyone.

The open question in my mind is why we need a trigger at all?
If there is no advantage we don't need to expose that.  Can just
directly call the buffer functions from the interrupt handler.

It's perfectly acceptable to not have a trigger exposed if:
* It would only be useful for the device providing it.
* You don't need to use it to select between various options.

For some of the other fifo devices IIRC we do support other
triggers but if you don't provide one the local fifo is used.

Here I don't think we actually support other triggers though we
don't prevent them being used? So even simpler.
With the complex interleaved fifo I suspect it would be hard
to support other triggers anyway except in a trivial poll like
mode so probably not of interest to anyone...

J 

> ---
>  drivers/iio/imu/inv_icm42600/Kconfig          |   1 +
>  drivers/iio/imu/inv_icm42600/Makefile         |   1 +
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   8 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  19 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |   2 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |   2 +-
>  .../imu/inv_icm42600/inv_icm42600_trigger.c   | 177 ++++++++++++++++++
>  7 files changed, 206 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c
> 
> diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_icm42600/Kconfig
> index 22390a72f0a3..7b3eaeb2aa4a 100644
> --- a/drivers/iio/imu/inv_icm42600/Kconfig
> +++ b/drivers/iio/imu/inv_icm42600/Kconfig
> @@ -2,6 +2,7 @@
>  
>  config INV_ICM42600
>  	tristate
> +	select IIO_TRIGGER
>  
>  config INV_ICM42600_I2C
>  	tristate "InvenSense ICM-426xx I2C driver"
> diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
> index 48965824f00c..e1f2aacbe888 100644
> --- a/drivers/iio/imu/inv_icm42600/Makefile
> +++ b/drivers/iio/imu/inv_icm42600/Makefile
> @@ -5,6 +5,7 @@ inv-icm42600-y += inv_icm42600_core.o
>  inv-icm42600-y += inv_icm42600_gyro.o
>  inv-icm42600-y += inv_icm42600_accel.o
>  inv-icm42600-y += inv_icm42600_temp.o
> +inv-icm42600-y += inv_icm42600_trigger.o
>  
>  obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
>  inv-icm42600-i2c-y += inv_icm42600_i2c.o
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index bc963b3d1800..175c1f67faee 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -13,6 +13,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
>  
>  enum inv_icm42600_chip {
>  	INV_CHIP_ICM42600,
> @@ -122,6 +123,7 @@ struct inv_icm42600_suspended {
>   *  @suspended:		suspended sensors configuration.
>   *  @indio_gyro:	gyroscope IIO device.
>   *  @indio_accel:	accelerometer IIO device.
> + *  @trigger:		device internal interrupt trigger
>   */
>  struct inv_icm42600_state {
>  	struct mutex lock;
> @@ -135,6 +137,7 @@ struct inv_icm42600_state {
>  	struct inv_icm42600_suspended suspended;
>  	struct iio_dev *indio_gyro;
>  	struct iio_dev *indio_accel;
> +	struct iio_trigger *trigger;
>  };
>  
>  /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
> @@ -370,11 +373,14 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
>  int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval);
>  
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip,
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
>  			    inv_icm42600_bus_setup bus_setup);
>  
>  int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
>  
>  int inv_icm42600_accel_init(struct inv_icm42600_state *st);
>  
> +int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,
> +			      int irq_type);
> +
>  #endif
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 4e33f263d3ea..1102c54396e3 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -447,11 +447,13 @@ static void inv_icm42600_disable_pm(void *_data)
>  	pm_runtime_disable(dev);
>  }
>  
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip,
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
>  			    inv_icm42600_bus_setup bus_setup)
>  {
>  	struct device *dev = regmap_get_device(regmap);
>  	struct inv_icm42600_state *st;
> +	struct irq_data *irq_desc;
> +	int irq_type;
>  	int ret;
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(inv_icm42600_hw) != INV_CHIP_NB);
> @@ -460,6 +462,16 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  		return -ENODEV;
>  	}
>  
> +	/* get irq data, set trigger falling by default */
> +	irq_desc = irq_get_irq_data(irq);
> +	if (!irq_desc) {
> +		dev_err(dev, "could not find IRQ %d\n", irq);
> +		return -EINVAL;
> +	}
> +	irq_type = irqd_get_trigger_type(irq_desc);
> +	if (!irq_type)
> +		irq_type = IRQF_TRIGGER_FALLING;
> +
>  	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
>  	if (!st)
>  		return -ENOMEM;
> @@ -503,6 +515,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  	if (ret)
>  		return ret;
>  
> +	/* setup interrupt trigger */
> +	ret = inv_icm42600_trigger_init(st, irq, irq_type);
> +	if (ret)
> +		return ret;
> +
>  	/* create and init gyroscope iio device */
>  	ret = inv_icm42600_gyro_init(st);
>  	if (ret)
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> index b61f993beacf..b1478ece43f6 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -70,7 +70,7 @@ static int inv_icm42600_probe(struct i2c_client *client,
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	return inv_icm42600_core_probe(regmap, chip,
> +	return inv_icm42600_core_probe(regmap, chip, client->irq,
>  				       inv_icm42600_i2c_bus_setup);
>  }
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> index 835ced68a3a3..ec784f9e3c2c 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> @@ -70,7 +70,7 @@ static int inv_icm42600_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	return inv_icm42600_core_probe(regmap, chip,
> +	return inv_icm42600_core_probe(regmap, chip, spi->irq,
>  				       inv_icm42600_spi_bus_setup);
>  }
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c
> new file mode 100644
> index 000000000000..7a5e76305f0b
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 Invensense, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#include "inv_icm42600.h"
> +
> +static irqreturn_t inv_icm42600_trigger_timestamp(int irq, void *_data)
> +{
> +	struct inv_icm42600_state *st = _data;
> +
> +	if (st->indio_gyro)
> +		iio_pollfunc_store_time(irq, st->indio_gyro->pollfunc);
> +	if (st->indio_accel)
> +		iio_pollfunc_store_time(irq, st->indio_accel->pollfunc);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t inv_icm42600_trigger_int_handler(int irq, void *_data)
> +{
> +	struct inv_icm42600_state *st = _data;
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int status;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &status);
> +	if (ret)
> +		goto out_unlock;
> +	dev_dbg(dev, "int_status = %#02x\n", status);
> +
> +	/* FIFO full */
> +	if (status & INV_ICM42600_INT_STATUS_FIFO_FULL)
> +		dev_warn(dev, "FIFO full data lost!\n");
> +
> +	/* FIFO threshold reached */
> +	if (status & INV_ICM42600_INT_STATUS_FIFO_THS)
> +		iio_trigger_poll_chained(st->trigger);
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static int inv_icm42600_trigger_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct inv_icm42600_state *st = iio_trigger_get_drvdata(trig);
> +	unsigned int val;
> +	uint16_t dummy;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	/*
> +	 * IIO buffers preenable and postdisable are managing power on/off.
> +	 * update_scan_mode is setting data FIFO enabled.
> +	 */
> +	if (state) {
> +		/* set FIFO threshold interrupt */
> +		val = INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN;
> +		ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
> +					 val, val);
> +		if (ret)
> +			goto out_unlock;

blank line after each block.  Makes it easier for my tired eyes to parse :)

> +		/* flush FIFO data */
> +		ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
> +				   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
> +		if (ret)
> +			goto out_unlock;

> +		/* set FIFO in streaming mode */
> +		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
> +				   INV_ICM42600_FIFO_CONFIG_STREAM);
> +		if (ret)
> +			goto out_unlock;

> +		/* workaround: dummy read of FIFO count */

Work around for what?

> +		ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT,
> +				       &dummy, sizeof(dummy));
> +	} else {
> +		/* set FIFO in bypass mode */
> +		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
> +				   INV_ICM42600_FIFO_CONFIG_BYPASS);
> +		if (ret)
> +			goto out_unlock;

> +		/* flush FIFO data */
> +		ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
> +				   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
> +		if (ret)
> +			goto out_unlock;

> +		/* disable FIFO threshold interrupt */
> +		val = INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN;
> +		ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
> +					 val, 0);
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static int inv_icm42600_trigger_validate(struct iio_trigger *trig,
> +					 struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42600_state *st = iio_trigger_get_drvdata(trig);
> +
> +	if (iio_device_get_drvdata(indio_dev) != st)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops inv_icm42600_trigger_ops = {
> +	.set_trigger_state = &inv_icm42600_trigger_set_state,
> +	.validate_device = &inv_icm42600_trigger_validate,
> +};
> +
> +int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,
> +			      int irq_type)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	st->trigger = devm_iio_trigger_alloc(dev, "%s-dev", st->name);
> +	if (!st->trigger)
> +		return -ENOMEM;
> +
> +	st->trigger->dev.parent = dev;
> +	st->trigger->ops = &inv_icm42600_trigger_ops;
> +	iio_trigger_set_drvdata(st->trigger, st);
> +
> +	/* configure INT1 with correct mode */
> +	/* falling or both-edge */
> +	if (irq_type & IRQF_TRIGGER_FALLING) {
> +		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW;
> +	} else if (irq_type == IRQF_TRIGGER_RISING) {
> +		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_HIGH;
> +	} else if (irq_type == IRQF_TRIGGER_LOW) {
> +		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW |
> +				INV_ICM42600_INT_CONFIG_INT1_LATCHED;
> +	} else if (irq_type == IRQF_TRIGGER_HIGH) {
> +		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW |
> +				INV_ICM42600_INT_CONFIG_INT1_LATCHED;
> +	} else {
> +		dev_err(dev, "invalid interrupt type %#x\n", irq_type);
> +		return -EINVAL;
> +	}
> +	val |= INV_ICM42600_INT_CONFIG_INT1_PUSH_PULL;
> +	ret = regmap_write(st->map, INV_ICM42600_REG_INT_CONFIG, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Deassert async reset for proper INT pin operation (cf datasheet) */
> +	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_CONFIG1,
> +				 INV_ICM42600_INT_CONFIG1_ASYNC_RESET, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(dev, irq,
> +					inv_icm42600_trigger_timestamp,
> +					inv_icm42600_trigger_int_handler,
> +					irq_type, "inv_icm42600", st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_trigger_register(dev, st->trigger);
> +}


