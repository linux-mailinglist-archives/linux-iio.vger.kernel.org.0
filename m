Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97B32FC03
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFQmz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 11:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230461AbhCFQmW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 11:42:22 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8854C64FFD;
        Sat,  6 Mar 2021 16:42:20 +0000 (UTC)
Date:   Sat, 6 Mar 2021 16:42:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCH 2/2] iio:magnetometer: Support for ST magnetic sensors
Message-ID: <20210306164217.2d8166da@archlinux>
In-Reply-To: <20210305070536.2880-2-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210305070536.2880-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20210305070536.2880-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  5 Mar 2021 07:05:36 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Add support for STMicroelectronics digital magnetic sensors,
> LSM303AH,LSM303AGR,LIS2MDL,ISM303DAC,IIS2MDC.
> 
> The patch tested with IIS2MDC instrument.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

Hi,

Given that at least two parts in here is supported by the existing
driver in
iio/magnetometers/st_magn_*.c (lsm303agr) can you confirm that it
doesn't make sense to simply extend that driver to support the
other parts?  This is particularly true when the WHO AM I register
reads 0x40 for all these parts.

I've done a fairly superficial review whilst here, but please check
you can't just add the relevant entries to the existing driver.

Jonathan
	
+CC Lorenzo

> ---
>  drivers/iio/magnetometer/Kconfig           |  23 ++
>  drivers/iio/magnetometer/Makefile          |   4 +
>  drivers/iio/magnetometer/st_mag40_buffer.c | 191 +++++++++++
>  drivers/iio/magnetometer/st_mag40_core.c   | 371 +++++++++++++++++++++
>  drivers/iio/magnetometer/st_mag40_core.h   | 136 ++++++++
>  drivers/iio/magnetometer/st_mag40_i2c.c    | 180 ++++++++++
>  drivers/iio/magnetometer/st_mag40_spi.c    | 188 +++++++++++
>  7 files changed, 1093 insertions(+)
>  create mode 100644 drivers/iio/magnetometer/st_mag40_buffer.c
>  create mode 100644 drivers/iio/magnetometer/st_mag40_core.c
>  create mode 100644 drivers/iio/magnetometer/st_mag40_core.h
>  create mode 100644 drivers/iio/magnetometer/st_mag40_i2c.c
>  create mode 100644 drivers/iio/magnetometer/st_mag40_spi.c
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 1697a8c03506..bfd2866faa99 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -205,4 +205,27 @@ config SENSORS_RM3100_SPI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called rm3100-spi.
>  
> +config ST_MAG40_IIO
> +	tristate "STMicroelectronics LIS2MDL/LSM303AH/LSM303AGR/ISM303DAC/IIS2MDC sensor"
> +	depends on (I2C || SPI) && SYSFS
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select ST_MAG40_I2C_IIO if (I2C)
> +	select ST_MAG40_SPI_IIO if (SPI)
> +	help
> +	  Say yes here to build support for STMicroelectronics magnetometers:
> +	  LIS2MDL, LSM303AH, LSM303AGR, ISM303DAC, IIS2MDC.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called st_mag40.
> +
> +config ST_MAG40_I2C_IIO
> +	tristate
> +	depends on ST_MAG40_IIO
> +	depends on I2C
> +
> +config ST_MAG40_SPI_IIO
> +	tristate
> +	depends on ST_MAG40_IIO
> +	depends on SPI
>  endmenu
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index ba1bc34b82fa..b6b427cfc284 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -25,6 +25,10 @@ obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
>  obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
>  obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
>  
> +st_mag40-y += st_mag40_buffer.o st_mag40_core.o
> +obj-$(CONFIG_ST_MAG40_IIO) += st_mag40.o
> +obj-$(CONFIG_ST_MAG40_I2C_IIO) += st_mag40_i2c.o
> +obj-$(CONFIG_ST_MAG40_SPI_IIO) += st_mag40_spi.o
>  obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
>  obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
>  obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
> diff --git a/drivers/iio/magnetometer/st_mag40_buffer.c b/drivers/iio/magnetometer/st_mag40_buffer.c
> new file mode 100644
> index 000000000000..d2a67c9dae5e
> --- /dev/null
> +++ b/drivers/iio/magnetometer/st_mag40_buffer.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * STMicroelectronics st_mag40 driver
> + *
> + * Copyright 2016 STMicroelectronics Inc.
> + *
> + * Matteo Dameno <matteo.dameno@st.com>
> + * Armando Visconti <armando.visconti@st.com>
> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include "st_mag40_core.h"
> +
> +#define ST_MAG40_EWMA_DIV			128
> +static inline s64 st_mag40_ewma(s64 old, s64 new, int weight)
> +{
> +	s64 diff, incr;
> +
> +	diff = new - old;
> +	incr = div_s64((ST_MAG40_EWMA_DIV - weight) * diff,
> +			ST_MAG40_EWMA_DIV);
> +
> +	return old + incr;
> +}
> +
> +static irqreturn_t st_mag40_trigger_irq_handler(int irq, void *private)
> +{
> +	struct st_mag40_data *cdata = private;
> +	s64 ts;
> +	u8 weight = (cdata->odr >= 50) ? 96 : 0;
> +
> +	ts = st_mag40_get_timestamp();
> +	cdata->delta_ts = st_mag40_ewma(cdata->delta_ts, ts - cdata->ts_irq, weight);
> +	cdata->ts_irq = ts;
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t st_mag40_trigger_thread_handler(int irq, void *private)
> +{
> +	struct st_mag40_data *cdata = private;
> +	u8 status;
> +	int err;
> +
> +	err = cdata->tf->read(cdata, ST_MAG40_STATUS_ADDR,
> +			      sizeof(status), &status);
> +	if (err < 0)
> +		return IRQ_HANDLED;
> +
> +	if (!(status & ST_MAG40_AVL_DATA_MASK))
> +		return IRQ_NONE;
> +
> +	iio_trigger_poll_chained(cdata->iio_trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t st_mag40_buffer_thread_handler(int irq, void *p)
> +{
> +	u8 buffer[ALIGN(ST_MAG40_OUT_LEN, sizeof(s64)) + sizeof(s64)];

There are no guarantees on alignement of this structure and it needs
to be 8 byte aligned to ensure the timestamp can be naturally aligned
within the buffer.

> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio_dev = pf->indio_dev;
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +	int err;
> +
> +	err = cdata->tf->read(cdata, ST_MAG40_OUTX_L_ADDR,
> +			      ST_MAG40_OUT_LEN, buffer);
> +	if (err < 0)
> +		goto out;
> +
> +	/* discard samples generated during the turn-on time */
> +	if (cdata->samples_to_discard > 0) {
> +		cdata->samples_to_discard--;
> +		goto out;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(iio_dev, buffer, cdata->ts);
> +	cdata->ts += cdata->delta_ts;
> +
> +out:
> +	iio_trigger_notify_done(cdata->iio_trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int st_mag40_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct st_mag40_data *cdata = iio_priv(indio_dev);
> +
> +	return st_mag40_set_enable(cdata, true);
> +}
> +
> +static int st_mag40_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct st_mag40_data *cdata = iio_priv(indio_dev);
> +	int err;
> +
> +	err = st_mag40_set_enable(cdata, false);
> +
> +	return err < 0 ? err : 0;
> +}
> +
> +static const struct iio_buffer_setup_ops st_mag40_buffer_setup_ops = {
> +	.preenable = st_mag40_buffer_preenable,
> +	.postenable = iio_triggered_buffer_postenable,
> +	.predisable = iio_triggered_buffer_predisable,

The core should deal with these now if you are using the triggered_buffer setup
etc.

> +	.postdisable = st_mag40_buffer_postdisable,
> +};
> +
> +int st_mag40_trig_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct st_mag40_data *cdata = iio_priv(iio_trigger_get_drvdata(trig));
> +	int err;
> +
> +	err = st_mag40_write_register(cdata, ST_MAG40_INT_DRDY_ADDR,
> +				      ST_MAG40_INT_DRDY_MASK, state);
> +
> +	return err < 0 ? err : 0;
> +}
> +
> +int st_mag40_allocate_ring(struct iio_dev *iio_dev)
> +{
> +	return  iio_triggered_buffer_setup(iio_dev, NULL,
> +					   st_mag40_buffer_thread_handler,
> +					   &st_mag40_buffer_setup_ops);
> +}
> +
> +void st_mag40_deallocate_ring(struct iio_dev *iio_dev)
> +{
> +	iio_triggered_buffer_cleanup(iio_dev);
> +}
> +
> +static const struct iio_trigger_ops st_mag40_trigger_ops = {
> +	.set_trigger_state = st_mag40_trig_set_state,
> +};
> +
> +int st_mag40_allocate_trigger(struct iio_dev *iio_dev)
> +{
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +	int err;
> +
> +	err = devm_request_threaded_irq(cdata->dev, cdata->irq,
> +					st_mag40_trigger_irq_handler,
> +					st_mag40_trigger_thread_handler,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					cdata->name, cdata);
> +	if (err)
> +		return err;
> +
> +	cdata->iio_trig = devm_iio_trigger_alloc(cdata->dev, "%s-trigger",
> +						 iio_dev->name);
> +	if (!cdata->iio_trig) {
> +		dev_err(cdata->dev, "failed to allocate iio trigger.\n");
> +		return -ENOMEM;
> +	}
> +	iio_trigger_set_drvdata(cdata->iio_trig, iio_dev);
> +	cdata->iio_trig->ops = &st_mag40_trigger_ops;
> +	cdata->iio_trig->dev.parent = cdata->dev;
> +
> +	err = iio_trigger_register(cdata->iio_trig);

Why not devm_iio_trigger_register?

> +	if (err < 0) {
> +		dev_err(cdata->dev, "failed to register iio trigger.\n");
> +		return err;
> +	}
> +	iio_dev->trig = cdata->iio_trig;
> +
> +	return 0;
> +}
> +
> +void st_mag40_deallocate_trigger(struct st_mag40_data *cdata)
> +{
> +	iio_trigger_unregister(cdata->iio_trig);
> +}
> +
> +MODULE_DESCRIPTION("STMicroelectronics st_mag40 driver");
> +MODULE_AUTHOR("Armando Visconti <armando.visconti@st.com>");
> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/st_mag40_core.c b/drivers/iio/magnetometer/st_mag40_core.c
> new file mode 100644
> index 000000000000..3c5f2d91897b
> --- /dev/null
> +++ b/drivers/iio/magnetometer/st_mag40_core.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * STMicroelectronics st_mag40 driver
> + *
> + * Copyright 2016 STMicroelectronics Inc.
> + *
> + * Matteo Dameno <matteo.dameno@st.com>
> + * Armando Visconti <armando.visconti@st.com>
> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <linux/irq.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/delay.h>

alphabetical order within linux/
then more specific headers like asm/ after that.

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <asm/unaligned.h>
> +
> +#include "st_mag40_core.h"
> +
> +struct st_mag40_odr_reg {
> +	u32 hz;
> +	u8 value;
> +};
> +
> +#define ST_MAG40_ODR_TABLE_SIZE		4
> +static const struct st_mag40_odr_table_t {
> +	u8 addr;
> +	u8 mask;
> +	struct st_mag40_odr_reg odr_avl[ST_MAG40_ODR_TABLE_SIZE];
> +} st_mag40_odr_table = {
> +	.addr = ST_MAG40_ODR_ADDR,
> +	.mask = ST_MAG40_ODR_MASK,
> +	.odr_avl[0] = { .hz = 10, .value = ST_MAG40_CFG_REG_A_ODR_10Hz, },
> +	.odr_avl[1] = { .hz = 20, .value = ST_MAG40_CFG_REG_A_ODR_20Hz, },
> +	.odr_avl[2] = { .hz = 50, .value = ST_MAG40_CFG_REG_A_ODR_50Hz, },
> +	.odr_avl[3] = { .hz = 100, .value = ST_MAG40_CFG_REG_A_ODR_100Hz, },
> +};
> +
> +#define ST_MAG40_ADD_CHANNEL(device_type, modif, index, mod,	\
> +				endian, sbits, rbits, addr, s)	\
> +{								\
> +	.type = device_type,					\
> +	.modified = modif,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				BIT(IIO_CHAN_INFO_SCALE),	\
> +	.scan_index = index,					\
> +	.channel2 = mod,					\
> +	.address = addr,					\
> +	.scan_type = {						\
> +		.sign = s,					\
> +		.realbits = rbits,				\
> +		.shift = sbits - rbits,				\
> +		.storagebits = sbits,				\
> +		.endianness = endian,				\
> +	},							\
> +}
> +
> +static const struct iio_chan_spec st_mag40_channels[] = {
> +	ST_MAG40_ADD_CHANNEL(IIO_MAGN, 1, 0, IIO_MOD_X, IIO_LE, 16, 16,
> +				ST_MAG40_OUTX_L_ADDR, 's'),
> +	ST_MAG40_ADD_CHANNEL(IIO_MAGN, 1, 1, IIO_MOD_Y, IIO_LE, 16, 16,
> +				ST_MAG40_OUTY_L_ADDR, 's'),
> +	ST_MAG40_ADD_CHANNEL(IIO_MAGN, 1, 2, IIO_MOD_Z, IIO_LE, 16, 16,
> +				ST_MAG40_OUTZ_L_ADDR, 's'),

No point in having parameters for things that are always the same.

> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +int st_mag40_write_register(struct st_mag40_data *cdata, u8 reg_addr,
> +			    u8 mask, u8 data)
> +{
> +	int err;
> +	u8 val;
> +
> +	mutex_lock(&cdata->lock);
> +
> +	err = cdata->tf->read(cdata, reg_addr, sizeof(val), &val);
> +	if (err < 0)
> +		goto unlock;
> +
> +	val = ((val & ~mask) | ((data << __ffs(mask)) & mask));
> +
> +	err = cdata->tf->write(cdata, reg_addr, sizeof(val), &val);
> +
> +unlock:
> +	mutex_unlock(&cdata->lock);
> +
> +	return err < 0 ? err : 0;
> +}
> +
> +static int st_mag40_write_odr(struct st_mag40_data *cdata, uint32_t odr)
> +{
> +	int err, i;
> +
> +	for (i = 0; i < ST_MAG40_ODR_TABLE_SIZE; i++)
> +		if (st_mag40_odr_table.odr_avl[i].hz >= odr)
> +			break;
> +
> +	if (i == ST_MAG40_ODR_TABLE_SIZE)
> +		return -EINVAL;
> +
> +	err = st_mag40_write_register(cdata, st_mag40_odr_table.addr,
> +				      st_mag40_odr_table.mask,
> +				      st_mag40_odr_table.odr_avl[i].value);
> +	if (err < 0)
> +		return err;
> +
> +	cdata->odr = odr;
> +	cdata->samples_to_discard = ST_MAG40_TURNON_TIME_SAMPLES_NUM;
> +
> +	return 0;
> +}
> +
> +int st_mag40_set_enable(struct st_mag40_data *cdata, bool state)
> +{
> +	u8 mode;
> +
> +	mode = state ? ST_MAG40_CFG_REG_A_MD_CONT : ST_MAG40_CFG_REG_A_MD_IDLE;
> +
> +	if (state) {
> +		cdata->ts = cdata->ts_irq = st_mag40_get_timestamp();
> +		cdata->delta_ts = div_s64(1000000000LL, cdata->odr);
> +	}
> +
> +	return st_mag40_write_register(cdata, ST_MAG40_EN_ADDR,
> +				       ST_MAG40_EN_MASK, mode);
> +}
> +
> +int st_mag40_init_sensors(struct st_mag40_data *cdata)
> +{
> +	int err;
> +
> +	/*
> +	 * Enable block data update feature.
> +	 */
> +	err = st_mag40_write_register(cdata, ST_MAG40_CFG_REG_C_ADDR,
> +				      ST_MAG40_CFG_REG_C_BDU_MASK, 1);
> +	if (err < 0)
> +		return err;
> +
> +	/*
> +	 * Enable the temperature compensation feature
> +	 */
> +	err = st_mag40_write_register(cdata, ST_MAG40_CFG_REG_A_ADDR,
> +				      ST_MAG40_TEMP_COMP_EN, 1);
> +	if (err < 0)
> +		return err;
> +
> +	err = st_mag40_write_register(cdata, ST_MAG40_CFG_REG_B_ADDR,
> +				      ST_MAG40_CFG_REG_B_OFF_CANC_MASK, 1);
> +
> +	return err < 0 ? err : 0;
> +}
> +
> +static ssize_t st_mag40_get_sampling_frequency(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct st_mag40_data *cdata = iio_priv(dev_get_drvdata(dev));
> +
> +	return sprintf(buf, "%d\n", cdata->odr);
> +}
> +
> +static ssize_t st_mag40_set_sampling_frequency(struct device *dev,
> +						struct device_attribute *attr,
> +						const char *buf, size_t count)
> +{
> +	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +	unsigned int odr;
> +	int err;
> +
> +	err = kstrtoint(buf, 10, &odr);
> +	if (err < 0)
> +		return err;
> +
> +	err = st_mag40_write_odr(cdata, odr);
> +
> +	return err < 0 ? err : count;
> +}
> +
> +static ssize_t
> +st_mag40_get_sampling_frequency_avail(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	int i, len = 0;
> +
> +	for (i = 0; i < ST_MAG40_ODR_TABLE_SIZE; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +				 st_mag40_odr_table.odr_avl[i].hz);
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static int st_mag40_read_oneshot(struct st_mag40_data *cdata,
> +				 u8 addr, int *val)
> +{
> +	u8 data[2];
> +	int err;
> +
> +	err = st_mag40_set_enable(cdata, true);
> +	if (err < 0)
> +		return err;
> +
> +	msleep(40);
> +
> +	err = cdata->tf->read(cdata, addr, sizeof(data), data);
> +	if (err < 0)
> +		return err;
> +
> +	*val = (s16)get_unaligned_le16(data);
> +
> +	err = st_mag40_set_enable(cdata, false);

This look like it should be runtime pm managed so that we can
auto suspend after a period of no use, but save on the comms if
we are doing a bunch of readings close to each other.

> +
> +	return err < 0 ? err : IIO_VAL_INT;
> +}
> +
> +static int st_mag40_read_raw(struct iio_dev *iio_dev,
> +			     struct iio_chan_spec const *ch,
> +			     int *val, int *val2, long mask)
> +{
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +	int ret;
> +
> +	mutex_lock(&iio_dev->mlock);
> +
> +	if (iio_buffer_enabled(iio_dev)) {
> +		mutex_unlock(&iio_dev->mlock);
> +		return -EBUSY;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = st_mag40_read_oneshot(cdata, ch->address, val);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = 1500;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&iio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(0444,
> +			      st_mag40_get_sampling_frequency,
> +			      st_mag40_set_sampling_frequency);
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_mag40_get_sampling_frequency_avail);
> +
> +static struct attribute *st_mag40_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,

These are supported by the iio core, so we shouldn't need extra
attrs at all for this driver.

For the _avail you will need to provide relevant callback though.

> +	NULL,
> +};
> +
> +static const struct attribute_group st_mag40_attribute_group = {
> +	.attrs = st_mag40_attributes,
> +};
> +
> +static const struct iio_info st_mag40_info = {
> +	.attrs = &st_mag40_attribute_group,
> +	.read_raw = &st_mag40_read_raw,
> +};
> +
> +int st_mag40_common_probe(struct iio_dev *iio_dev)
> +{
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +	int32_t err;
> +	u8 wai;
> +
> +	mutex_init(&cdata->lock);
> +
> +	err = cdata->tf->read(cdata, ST_MAG40_WHO_AM_I_ADDR,
> +			      sizeof(wai), &wai);
> +	if (err < 0) {
> +		dev_err(cdata->dev, "failed to read Who-Am-I register.\n");
> +
> +		return err;
> +	}
> +
> +	if (wai != ST_MAG40_WHO_AM_I_DEF) {
> +		dev_err(cdata->dev, "Who-Am-I value not valid. (%02x)\n", wai);
> +		return -ENODEV;
> +	}
> +
> +	cdata->odr = st_mag40_odr_table.odr_avl[0].hz;
> +
> +	iio_dev->channels = st_mag40_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(st_mag40_channels);
> +	iio_dev->info = &st_mag40_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	err = st_mag40_init_sensors(cdata);
> +	if (err < 0)
> +		return err;
> +
> +	if (cdata->irq > 0) {
> +		err = st_mag40_allocate_ring(iio_dev);
> +		if (err < 0)
> +			return err;
> +
> +		err = st_mag40_allocate_trigger(iio_dev);
> +		if (err < 0)
> +			goto deallocate_ring;
> +	}
> +
> +	err = devm_iio_device_register(cdata->dev, iio_dev);
You shouldn't mix and match devm and non devm based cleanup.
That leads to hard to reason about race conditions.
The moment you have a non devm function that needs cleanup, everything
after that point should also not be devm based.

Note there is devm_add_action_or_reset() to allow easy definition
of custom cleanup.

> +	if (err)
> +		goto iio_trigger_deallocate;
> +
> +	return 0;
> +
> +iio_trigger_deallocate:
> +	st_mag40_deallocate_trigger(cdata);
> +
> +deallocate_ring:
> +	st_mag40_deallocate_ring(iio_dev);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(st_mag40_common_probe);
> +
> +void st_mag40_common_remove(struct iio_dev *iio_dev)
> +{
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +
> +	if (cdata->irq > 0) {
> +		st_mag40_deallocate_trigger(cdata);
> +		st_mag40_deallocate_ring(iio_dev);

This looks wrong given you are doing this before
the iio_device_unregister happens in the managed function cleanup.

> +	}
> +}
> +EXPORT_SYMBOL(st_mag40_common_remove);
> +
> +#ifdef CONFIG_PM
> +int st_mag40_common_suspend(struct st_mag40_data *cdata)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(st_mag40_common_suspend);
> +
> +int st_mag40_common_resume(struct st_mag40_data *cdata)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(st_mag40_common_resume);
> +#endif /* CONFIG_PM */
> +
> +MODULE_DESCRIPTION("STMicroelectronics st_mag40 driver");
> +MODULE_AUTHOR("Armando Visconti <armando.visconti@st.com>");
> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/st_mag40_core.h b/drivers/iio/magnetometer/st_mag40_core.h
> new file mode 100644
> index 000000000000..cc8e9cbf00ce
> --- /dev/null
> +++ b/drivers/iio/magnetometer/st_mag40_core.h
> @@ -0,0 +1,136 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * STMicroelectronics st_mag40 driver
> + *
> + * Copyright 2016 STMicroelectronics Inc.
> + *
> + * Matteo Dameno <matteo.dameno@st.com>
> + * Armando Visconti <armando.visconti@st.com>
> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> + *
> + */
> +
> +#ifndef __ST_MAG40_H
> +#define __ST_MAG40_H
> +
> +#include <linux/types.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#define ST_MAG40_DEV_NAME			"st_mag40"
> +#define LIS2MDL_DEV_NAME			"lis2mdl_magn"
> +#define LSM303AH_DEV_NAME			"lsm303ah_magn"
> +#define LSM303AGR_DEV_NAME			"lsm303agr_magn"
> +#define ISM303DAC_DEV_NAME			"ism303dac_magn"
> +#define IIS2MDC_DEV_NAME			"iis2mdc_magn"
> +
> +/* Power Modes */
> +enum {
> +	ST_MAG40_LWC_MODE = 0,
> +	ST_MAG40_NORMAL_MODE,
> +	ST_MAG40_MODE_COUNT,
> +};
> +
> +#define ST_MAG40_WHO_AM_I_ADDR				0x4f
> +#define ST_MAG40_WHO_AM_I_DEF				0x40
> +
> +/* Magnetometer control registers */
> +#define ST_MAG40_CFG_REG_A_ADDR				0x60
> +#define ST_MAG40_TEMP_COMP_EN				0x80
> +#define ST_MAG40_CFG_REG_A_ODR_MASK			0x0c
> +#define ST_MAG40_CFG_REG_A_ODR_10Hz			0x00
> +#define ST_MAG40_CFG_REG_A_ODR_20Hz			0x01
> +#define ST_MAG40_CFG_REG_A_ODR_50Hz			0x02
> +#define ST_MAG40_CFG_REG_A_ODR_100Hz			0x03
> +#define ST_MAG40_CFG_REG_A_ODR_COUNT			4
> +#define ST_MAG40_CFG_REG_A_MD_MASK			0x03
> +#define ST_MAG40_CFG_REG_A_MD_CONT			0x00
> +#define ST_MAG40_CFG_REG_A_MD_IDLE			0x03
> +
> +#define ST_MAG40_ODR_ADDR				ST_MAG40_CFG_REG_A_ADDR
> +#define ST_MAG40_ODR_MASK				ST_MAG40_CFG_REG_A_ODR_MASK
> +
> +#define ST_MAG40_EN_ADDR				ST_MAG40_CFG_REG_A_ADDR
> +#define ST_MAG40_EN_MASK				ST_MAG40_CFG_REG_A_MD_MASK
> +
> +#define ST_MAG40_CFG_REG_B_ADDR				0x61
> +#define ST_MAG40_CFG_REG_B_OFF_CANC_MASK		0x02
> +
> +#define ST_MAG40_CFG_REG_C_ADDR				0x62
> +#define ST_MAG40_CFG_REG_C_BDU_MASK			0x10
> +#define ST_MAG40_CFG_REG_C_INT_MASK			0x01
> +
> +#define ST_MAG40_INT_DRDY_ADDR				ST_MAG40_CFG_REG_C_ADDR
> +#define ST_MAG40_INT_DRDY_MASK				ST_MAG40_CFG_REG_C_INT_MASK
> +
> +#define ST_MAG40_STATUS_ADDR				0x67
> +#define ST_MAG40_AVL_DATA_MASK				0x7
> +
> +/* Magnetometer output registers */
> +#define ST_MAG40_OUTX_L_ADDR				0x68
> +#define ST_MAG40_OUTY_L_ADDR				0x6A
> +#define ST_MAG40_OUTZ_L_ADDR				0x6C
> +
> +#define ST_MAG40_BDU_ADDR				ST_MAG40_CTRL1_ADDR
> +#define ST_MAG40_BDU_MASK				0x02
> +
> +#define ST_MAG40_TURNON_TIME_SAMPLES_NUM	2
> +
> +/* 3 axis of 16 bit each */
> +#define ST_MAG40_OUT_LEN				6
> +
> +#define ST_MAG40_TX_MAX_LENGTH				16
> +#define ST_MAG40_RX_MAX_LENGTH				16
> +
> +struct st_mag40_transfer_buffer {
> +	u8 rx_buf[ST_MAG40_RX_MAX_LENGTH];
> +	u8 tx_buf[ST_MAG40_TX_MAX_LENGTH] ____cacheline_aligned;
> +};
> +
> +struct st_mag40_data;
> +
> +struct st_mag40_transfer_function {
> +	int (*write)(struct st_mag40_data *cdata, u8 reg_addr, int len, u8 *data);
> +	int (*read)(struct st_mag40_data *cdata, u8 reg_addr, int len, u8 *data);
> +};
> +
> +struct st_mag40_data {
> +	const char *name;
> +	struct mutex lock;
> +	u8 drdy_int_pin;
> +	int irq;
> +	s64 ts;
> +	s64 ts_irq;
> +	s64 delta_ts;
> +
> +	u16 odr;
> +	u8 samples_to_discard;
> +
> +	struct device *dev;
> +	struct iio_trigger *iio_trig;
> +	const struct st_mag40_transfer_function *tf;
> +	struct st_mag40_transfer_buffer tb;
> +};
> +
> +static inline s64 st_mag40_get_timestamp(void)
> +{

Why define own timestamp fetch function?  Depending
on usecase, either use the iio one that lets the clock be controlled
or call this directly where needed so it's obvious what is going on.

> +	return ktime_get_boottime_ns();
> +}
> +
> +int st_mag40_common_probe(struct iio_dev *iio_dev);
> +void st_mag40_common_remove(struct iio_dev *iio_dev);
> +
> +#ifdef CONFIG_PM

Just leave them in all the time, but mark __maybe_unused etc.

> +int st_mag40_common_suspend(struct st_mag40_data *cdata);
> +int st_mag40_common_resume(struct st_mag40_data *cdata);
> +#endif /* CONFIG_PM */
> +
> +int st_mag40_allocate_ring(struct iio_dev *iio_dev);
> +int st_mag40_allocate_trigger(struct iio_dev *iio_dev);
> +int st_mag40_trig_set_state(struct iio_trigger *trig, bool state);
> +int st_mag40_set_enable(struct st_mag40_data *cdata, bool enable);
> +void st_mag40_deallocate_ring(struct iio_dev *iio_dev);
> +void st_mag40_deallocate_trigger(struct st_mag40_data *cdata);
> +int st_mag40_write_register(struct st_mag40_data *cdata, u8 reg_addr, u8 mask, u8 data);
> +
> +#endif /* __ST_MAG40_H */
> diff --git a/drivers/iio/magnetometer/st_mag40_i2c.c b/drivers/iio/magnetometer/st_mag40_i2c.c
> new file mode 100644
> index 000000000000..8980972ad65e
> --- /dev/null
> +++ b/drivers/iio/magnetometer/st_mag40_i2c.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * STMicroelectronics st_mag40 driver
> + *
> + * Copyright 2016 STMicroelectronics Inc.
> + *
> + * Armando Visconti <armando.visconti@st.com>
> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/types.h>
> +
> +#include "st_mag40_core.h"
> +
> +#define I2C_AUTO_INCREMENT	0x80
> +
> +static int st_mag40_i2c_read(struct st_mag40_data *cdata, u8 reg_addr,
> +			     int len, u8 *data)
> +{
> +	struct i2c_client *client = to_i2c_client(cdata->dev);
> +	struct i2c_msg msg[2];
> +
> +	if (len > 1)
> +		reg_addr |= I2C_AUTO_INCREMENT;
> +
> +	msg[0].addr = client->addr;
> +	msg[0].flags = client->flags;
> +	msg[0].len = 1;
> +	msg[0].buf = &reg_addr;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].flags = client->flags | I2C_M_RD;
> +	msg[1].len = len;
> +	msg[1].buf = data;
> +
> +	return i2c_transfer(client->adapter, msg, 2);
> +}
> +
> +static int st_mag40_i2c_write(struct st_mag40_data *cdata, u8 reg_addr,
> +			      int len, u8 *data)
> +{
> +	struct i2c_client *client = to_i2c_client(cdata->dev);
> +	struct i2c_msg msg;
> +	u8 send[len + 1];
> +
> +	send[0] = reg_addr;
> +	memcpy(&send[1], data, len * sizeof(u8));
> +	len++;
> +
> +	msg.addr = client->addr;
> +	msg.flags = client->flags;
> +	msg.len = len;
> +	msg.buf = send;
> +
> +	return i2c_transfer(client->adapter, &msg, 1);

i2c_master_send()

> +}
> +
> +static const struct st_mag40_transfer_function st_mag40_tf_i2c = {
> +	.write = st_mag40_i2c_write,
> +	.read = st_mag40_i2c_read,
> +};
> +
> +static int st_mag40_i2c_probe(struct i2c_client *client,
> +			      const struct i2c_device_id *id)
> +{
> +	struct st_mag40_data *cdata;
> +	struct iio_dev *iio_dev;
> +
> +	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cdata));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, iio_dev);
> +	iio_dev->dev.parent = &client->dev;
> +	iio_dev->name = client->name;
> +
> +	cdata = iio_priv(iio_dev);
> +	cdata->dev = &client->dev;
> +	cdata->name = client->name;
> +	cdata->tf = &st_mag40_tf_i2c;
> +	cdata->irq = client->irq;
> +
> +	return st_mag40_common_probe(iio_dev);
> +}
> +
> +static int st_mag40_i2c_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *iio_dev = i2c_get_clientdata(client);
> +
> +	st_mag40_common_remove(iio_dev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int st_mag40_i2c_suspend(struct device *dev)
> +{
> +	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +
> +	return st_mag40_common_suspend(cdata);
> +}
> +
> +static int st_mag40_i2c_resume(struct device *dev)
> +{
> +	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +
> +	return st_mag40_common_resume(cdata);
> +}
> +
> +static const struct dev_pm_ops st_mag40_i2c_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(st_mag40_i2c_suspend, st_mag40_i2c_resume)
> +};
> +#endif /* CONFIG_PM */
> +
> +static const struct i2c_device_id st_mag40_ids[] = {
> +	{ LSM303AH_DEV_NAME, 0 },
> +	{ LSM303AGR_DEV_NAME, 0 },
> +	{ LIS2MDL_DEV_NAME, 0 },
> +	{ ISM303DAC_DEV_NAME, 0 },
> +	{ IIS2MDC_DEV_NAME, 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, st_mag40_ids);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id st_mag40_id_table[] = {
> +	{
> +		.compatible = "st,lsm303ah_magn",
> +		.data = LSM303AH_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,lsm303agr_magn",
> +		.data = LSM303AGR_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,lis2mdl_magn",
> +		.data = LSM303AGR_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,ism303dac_magn",
> +		.data = ISM303DAC_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,iis2mdc_magn",
> +		.data = IIS2MDC_DEV_NAME,
> +	},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, st_mag40_id_table);
> +#endif /* CONFIG_OF */
> +
> +static struct i2c_driver st_mag40_i2c_driver = {
> +	.driver = {
> +		   .owner = THIS_MODULE,
> +		   .name = ST_MAG40_DEV_NAME,
> +#ifdef CONFIG_PM
> +		   .pm = &st_mag40_i2c_pm_ops,
> +#endif
> +#ifdef CONFIG_OF
> +		   .of_match_table = st_mag40_id_table,
> +#endif /* CONFIG_OF */
> +		   },
> +	.probe = st_mag40_i2c_probe,
> +	.remove = st_mag40_i2c_remove,
> +	.id_table = st_mag40_ids,
> +};
> +module_i2c_driver(st_mag40_i2c_driver);
> +
> +MODULE_DESCRIPTION("STMicroelectronics st_mag40 i2c driver");
> +MODULE_AUTHOR("Armando Visconti <armando.visconti@st.com>");
> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/st_mag40_spi.c b/drivers/iio/magnetometer/st_mag40_spi.c
> new file mode 100644
> index 000000000000..7412dfbf7fa6
> --- /dev/null
> +++ b/drivers/iio/magnetometer/st_mag40_spi.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * STMicroelectronics st_mag40 driver
> + *
> + * Copyright 2016 STMicroelectronics Inc.
> + *
> + * Armando Visconti <armando.visconti@st.com>
> + * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +#include "st_mag40_core.h"
> +
> +#define ST_SENSORS_SPI_READ	0x80
> +
> +static int st_mag40_spi_read(struct st_mag40_data *cdata,
> +			     u8 reg_addr, int len, u8 *data)
> +{

I assume you ruled out using regmap to handle this?

> +	int err;
> +
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = cdata->tb.tx_buf,
> +			.bits_per_word = 8,
> +			.len = 1,
> +		},
> +		{
> +			.rx_buf = cdata->tb.rx_buf,
> +			.bits_per_word = 8,
> +			.len = len,
> +		}
> +	};
> +
> +	cdata->tb.tx_buf[0] = reg_addr | ST_SENSORS_SPI_READ;
> +
> +	err = spi_sync_transfer(to_spi_device(cdata->dev),
> +						xfers, ARRAY_SIZE(xfers));
> +	if (err)
> +		return err;
> +
> +	memcpy(data, cdata->tb.rx_buf, len*sizeof(u8));
> +
> +	return len;
> +}
> +
> +static int st_mag40_spi_write(struct st_mag40_data *cdata,
> +			      u8 reg_addr, int len, u8 *data)
> +{
> +	struct spi_transfer xfers = {
> +		.tx_buf = cdata->tb.tx_buf,
> +		.bits_per_word = 8,
> +		.len = len + 1,
> +	};
> +
> +	if (len >= ST_MAG40_RX_MAX_LENGTH)
> +		return -ENOMEM;
> +
> +	cdata->tb.tx_buf[0] = reg_addr;
> +
> +	memcpy(&cdata->tb.tx_buf[1], data, len);
> +
> +	return spi_sync_transfer(to_spi_device(cdata->dev), &xfers, 1);
> +}
> +
> +static const struct st_mag40_transfer_function st_mag40_tf_spi = {
> +	.write = st_mag40_spi_write,
> +	.read = st_mag40_spi_read,
> +};
> +
> +static int st_mag40_spi_probe(struct spi_device *spi)
> +{
> +	struct st_mag40_data *cdata;
> +	struct iio_dev *iio_dev;
> +
> +	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*cdata));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, iio_dev);
> +	iio_dev->dev.parent = &spi->dev;
> +	iio_dev->name = spi->modalias;

This name should reflect the particular part number.
I've not thought through what modalias will be set to here, but
please confirm it will be that.

> +
> +	cdata = iio_priv(iio_dev);
> +	cdata->dev = &spi->dev;
> +	cdata->name = spi->modalias;
> +	cdata->tf = &st_mag40_tf_spi;
> +	cdata->irq = spi->irq;

Some of these elements are things we want to keep available after probe,
but in other cases (such as irq) they are only used there. For those
I suggest passing them as additional parameters to the common probe
function and never storing them in the iio_priv() structure

> +
> +	return st_mag40_common_probe(iio_dev);
> +}
> +
> +static int st_mag40_spi_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *iio_dev = spi_get_drvdata(spi);
> +
> +	st_mag40_common_remove(iio_dev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int st_mag40_spi_suspend(struct device *dev)
> +{
> +	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +
> +	return st_mag40_common_suspend(cdata);
> +}
> +
> +static int st_mag40_spi_resume(struct device *dev)

Preferred option is to mark these __maybe_unused and
then drop the CONFIG_PM protections.  They go wrong far too often
and the compile process is more than capable of removing a few unused
functions for us.

> +{
> +	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +	struct st_mag40_data *cdata = iio_priv(iio_dev);
> +
> +	return st_mag40_common_resume(cdata);
> +}
> +
> +static const struct dev_pm_ops st_mag40_spi_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(st_mag40_spi_suspend, st_mag40_spi_resume)
> +};
> +#endif /* CONFIG_PM */
> +
> +static const struct spi_device_id st_mag40_ids[] = {
> +	{ LSM303AH_DEV_NAME, 0 },
> +	{ LSM303AGR_DEV_NAME, 0 },
> +	{ LIS2MDL_DEV_NAME, 0 },
> +	{ ISM303DAC_DEV_NAME, 0 },
> +	{ IIS2MDC_DEV_NAME, 0 },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(spi, st_mag40_ids);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id st_mag40_id_table[] = {
> +	{
> +		.compatible = "st,lsm303ah_magn",
> +		.data = LSM303AH_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,lsm303agr_magn",
> +		.data = LSM303AGR_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,lis2mdl_magn",
> +		.data = LSM303AGR_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,ism303dac_magn",
> +		.data = ISM303DAC_DEV_NAME,
> +	},
> +	{
> +		.compatible = "st,iis2mdc_magn",
> +		.data = IIS2MDC_DEV_NAME,
> +	},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, st_mag40_id_table);
> +#endif /* CONFIG_OF */

As below, drop the ifdef aroudn this.

> +
> +static struct spi_driver st_mag40_spi_driver = {
> +	.driver = {
> +		   .owner = THIS_MODULE,
> +		   .name = ST_MAG40_DEV_NAME,
> +#ifdef CONFIG_PM
> +		   .pm = &st_mag40_spi_pm_ops,
> +#endif /* CONFIG_PM */
> +#ifdef CONFIG_OF
> +		   .of_match_table = st_mag40_id_table,
> +#endif /* CONFIG_OF */

Drop these #ifdef blocks. We are better off ending up with
a slightly larger driver and not having this added complexity in
the code.

> +		   },
> +	.probe = st_mag40_spi_probe,
> +	.remove = st_mag40_spi_remove,
> +	.id_table = st_mag40_ids,
> +};
> +module_spi_driver(st_mag40_spi_driver);
> +
> +MODULE_DESCRIPTION("STMicroelectronics st_mag40 spi driver");
> +MODULE_AUTHOR("Armando Visconti <armando.visconti@st.com>");
> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> +MODULE_LICENSE("GPL v2");

