Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1CD4010DD
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbhIEQ0w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 12:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231847AbhIEQ0w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 12:26:52 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F053360EE6;
        Sun,  5 Sep 2021 16:25:45 +0000 (UTC)
Date:   Sun, 5 Sep 2021 17:29:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 2/2] iio: accel: adxl355: Add triggered buffer
 support
Message-ID: <20210905172858.10aa7b48@jic23-huawei>
In-Reply-To: <20210903184312.21009-3-puranjay12@gmail.com>
References: <20210903184312.21009-1-puranjay12@gmail.com>
        <20210903184312.21009-3-puranjay12@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  4 Sep 2021 00:13:12 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Provide a way for continuous data capture by setting up buffer support. The
> data ready signal exposed at the DRDY pin of the ADXL355 is exploited as
> a hardware interrupt which triggers to fill the buffer.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

A few things inline that were so minor I've just tidied them up along with the
the various obvious if (ret < 0) in previous patch.

Note some of these tell me you are working on an old tree and need to rebase.

Let me know if any of the following is wrong.   The state ? 0 : 1 is a bit
annoying, but without it we get a warning.

Anyhow, series applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see what else we missed.

Thanks,

Jonathan


diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 71d79d2dcf7d..4f485909f459 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -210,7 +210,7 @@ static int adxl355_data_rdy_trigger_set_state(struct iio_trigger *trig,
        ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
                                 ADXL355_POWER_CTL_DRDY_MSK,
                                 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK,
-                                           !state));
+                                           state ? 0 : 1));
        mutex_unlock(&data->lock);
 
        return ret;
@@ -682,7 +682,7 @@ static int adxl355_probe_trigger(struct iio_dev *indio_dev, int irq)
 
        data->dready_trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
                                                   indio_dev->name,
-                                                  indio_dev->id);
+                                                  iio_device_id(indio_dev));
        if (!data->dready_trig)
                return -ENOMEM;
 
@@ -741,18 +741,20 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
        ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
                                              &iio_pollfunc_store_time,
                                              &adxl355_trigger_handler, NULL);
-       if (ret)
-               return dev_err_probe(dev, ret,
-                                    "iio triggered buffer setup failed\n");
+       if (ret) {
+               dev_err(dev, "iio triggered buffer setup failed\n");
+               return ret;
+       }
 
        /*
         * TODO: Would be good to move it to the generic version.
         */
        irq = of_irq_get_byname(dev->of_node, "DRDY");
-       if (irq > 0)
+       if (irq > 0) {
                ret = adxl355_probe_trigger(indio_dev, irq);
-       if (ret)
-               return ret;
+               if (ret)
+                       return ret;
+       }
 
        return devm_iio_device_register(dev, indio_dev);
 }


> ---
>  drivers/iio/accel/Kconfig        |   4 +
>  drivers/iio/accel/adxl355_core.c | 153 ++++++++++++++++++++++++++++++-
>  2 files changed, 156 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index d0c45c809..9c16c1841 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -69,6 +69,8 @@ config ADXL355_I2C
>  	depends on I2C
>  	select ADXL355
>  	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here if you want to build i2c support for the Analog Devices
>  	  ADXL355 3-axis digital accelerometer.
> @@ -82,6 +84,8 @@ config ADXL355_SPI
>  	depends on SPI
>  	select ADXL355
>  	select REGMAP_SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here if you want to build spi support for the Analog Devices
>  	  ADXL355 3-axis digital accelerometer.
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index 0b9996c17..4c561315f 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -9,11 +9,16 @@
>  
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  #include <linux/limits.h>
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of_irq.h>
>  #include <linux/regmap.h>
>  #include <asm/unaligned.h>
>  
> @@ -46,6 +51,7 @@
>  #define ADXL355_RANGE_REG		0x2C
>  #define ADXL355_POWER_CTL_REG		0x2D
>  #define  ADXL355_POWER_CTL_MODE_MSK	GENMASK(1, 0)
> +#define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
>  #define ADXL355_SELF_TEST_REG		0x2E
>  #define ADXL355_RESET_REG		0x2F
>  
> @@ -165,7 +171,14 @@ struct adxl355_data {
>  	enum adxl355_hpf_3db hpf_3db;
>  	int calibbias[3];
>  	int adxl355_hpf_3db_table[7][2];
> -	u8 transf_buf[3] ____cacheline_aligned;
> +	struct iio_trigger *dready_trig;
> +	union {
> +		u8 transf_buf[3];
> +		struct {
> +			u8 buf[14];
> +			s64 ts;
> +		} buffer;
> +	} ____cacheline_aligned;
>  };
>  
>  static int adxl355_set_op_mode(struct adxl355_data *data,
> @@ -186,6 +199,23 @@ static int adxl355_set_op_mode(struct adxl355_data *data,
>  	return ret;
>  }
>  
> +static int adxl355_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					      bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct adxl355_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
> +				 ADXL355_POWER_CTL_DRDY_MSK,
> +				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK,
> +					    !state));
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
>  static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
>  {
>  	u32 multiplier;
> @@ -246,6 +276,12 @@ static int adxl355_setup(struct adxl355_data *data)
>  	if (ret)
>  		return ret;
>  
> +	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
> +				 ADXL355_POWER_CTL_DRDY_MSK,
> +				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));
> +	if (ret)
> +		return ret;
> +
>  	adxl355_fill_3db_frequency_table(data);
>  
>  	return adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> @@ -499,12 +535,74 @@ static int adxl355_read_avail(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static const unsigned long adxl355_avail_scan_masks[] = {
> +	GENMASK(3, 0),
> +	0
> +};
> +
>  static const struct iio_info adxl355_info = {
>  	.read_raw	= adxl355_read_raw,
>  	.write_raw	= adxl355_write_raw,
>  	.read_avail	= &adxl355_read_avail,
>  };
>  
> +static const struct iio_trigger_ops adxl355_trigger_ops = {
> +	.set_trigger_state = &adxl355_data_rdy_trigger_set_state,
> +	.validate_device = &iio_trigger_validate_own_device,
> +};
> +
> +static irqreturn_t adxl355_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adxl355_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	/*
> +	 * data->buffer is used both for triggered buffer support
> +	 * and read/write_raw(), hence, it has to be zeroed here before usage.
> +	 */
> +	data->buffer.buf[0] = 0;
> +
> +	/*
> +	 * The acceleration data is 24 bits and big endian. It has to be saved
> +	 * in 32 bits, hence, it is saved in the 2nd byte of the 4 byte buffer.
> +	 * The buf array is 14 bytes as it includes 3x4=12 bytes for
> +	 * accelaration data of x, y, and z axis. It also includes 2 bytes for
> +	 * temperature data.
> +	 */
> +	ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,
> +			       &data->buffer.buf[1], 3);
> +	if (ret)
> +		goto out_unlock_notify;
> +
> +	ret = regmap_bulk_read(data->regmap, ADXL355_YDATA3_REG,
> +			       &data->buffer.buf[5], 3);
> +	if (ret)
> +		goto out_unlock_notify;
> +
> +	ret = regmap_bulk_read(data->regmap, ADXL355_ZDATA3_REG,
> +			       &data->buffer.buf[9], 3);
> +	if (ret)
> +		goto out_unlock_notify;
> +
> +	ret = regmap_bulk_read(data->regmap, ADXL355_TEMP2_REG,
> +			       &data->buffer.buf[12], 2);
> +	if (ret)
> +		goto out_unlock_notify;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> +					   pf->timestamp);
> +
> +out_unlock_notify:
> +	mutex_unlock(&data->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  #define ADXL355_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
>  	.address = reg,							\
> @@ -518,6 +616,7 @@ static const struct iio_info adxl355_info = {
>  	.info_mask_shared_by_type_available =				\
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
>  		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
> +	.scan_index = index,						\
>  	.scan_type = {							\
>  		.sign = 's',						\
>  		.realbits = 20,						\
> @@ -537,6 +636,7 @@ static const struct iio_chan_spec adxl355_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = 3,
>  		.scan_type = {
>  			.sign = 's',
>  			.realbits = 12,
> @@ -544,14 +644,48 @@ static const struct iio_chan_spec adxl355_channels[] = {
>  			.endianness = IIO_BE,
>  		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
> +static int adxl355_probe_trigger(struct iio_dev *indio_dev, int irq)
> +{
> +	struct adxl355_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	data->dready_trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> +						   indio_dev->name,
> +						   indio_dev->id);
> +	if (!data->dready_trig)
> +		return -ENOMEM;
> +
> +	data->dready_trig->ops = &adxl355_trigger_ops;
> +	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> +
> +	ret = devm_request_irq(data->dev, irq,
> +			       &iio_trigger_generic_data_rdy_poll,
> +			       IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
> +				     irq);
> +
> +	ret = devm_iio_trigger_register(data->dev, data->dready_trig);
> +	if (ret) {
> +		dev_err(data->dev, "iio trigger register failed\n");
> +		return ret;
> +	}
> +
> +	indio_dev->trig = iio_trigger_get(data->dready_trig);
> +
> +	return 0;
> +}
> +
>  int adxl355_core_probe(struct device *dev, struct regmap *regmap,
>  		       const char *name)
>  {
>  	struct adxl355_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	int irq;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -568,6 +702,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl355_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
> +	indio_dev->available_scan_masks = adxl355_avail_scan_masks;
>  
>  	ret = adxl355_setup(data);
>  	if (ret) {
> @@ -575,6 +710,22 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
>  		return ret;
>  	}
>  
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &adxl355_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "iio triggered buffer setup failed\n");

What could cause this particular function to return that it needs to defer the
probe?  IIRC it's not dependent on any other drivers being loaded (interrupt controllers
or regulators or similar.)
Probably just 
	if (ret) {
		dev_err();
		return ret;
	}
in this case


> +
> +	/*
> +	 * TODO: Would be good to move it to the generic version.
> +	 */
> +	irq = of_irq_get_byname(dev->of_node, "DRDY");

Trivial but...

> +	if (irq > 0)
	if (irq> 0) {
> +		ret = adxl355_probe_trigger(indio_dev, irq);
> +	if (ret)
		if (ret)
			return ret;
	}

No point in checking a ret that hasn't changed value since we last checked it.

> +		return ret;
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(adxl355_core_probe);

