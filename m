Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD6435F12
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJUKeX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 06:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJUKeX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 06:34:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2777560E54;
        Thu, 21 Oct 2021 10:32:04 +0000 (UTC)
Date:   Thu, 21 Oct 2021 11:36:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 2/2] drivers:iio:dac: Add AD3552R driver support
Message-ID: <20211021113622.4f317e4a@jic23-huawei>
In-Reply-To: <20211021070924.18626-3-mihail.chindris@analog.com>
References: <20211021070924.18626-1-mihail.chindris@analog.com>
        <20211021070924.18626-3-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Oct 2021 07:09:26 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> The AD3552R-16 is a low drift ultrafast, 16-bit accuracy,
> current output digital-to-analog converter (DAC) designed
> to generate multiple output voltage span ranges.
> The AD3552R-16 operates with a fixed 2.5V reference.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>

Hi Mihail,

I have a feeling you will end up revisiting the decision to use the
device IDs rather than an enum + lookup into a structure table to
handle the different chip variants.  Current solution doesn't scale
well as we add more parts. However there is nothing wrong with how you
have it today so no need to change it yet!

You should also look at what dev_err_probe() is for. It's not for all
errors during probe, but rather just for those that might result in
a deferred probe.  So stuff dependent on other drivers having loaded such
as regulators, gpios and clocks.

As normal (unfortunately) I missed some stuff in previous reviews.
In particular I'm unconvinced that it makes sense to present the channels
in the kfifo to userspace as be16.  We do that to minimise conversions, but
in this case we end up always converting it at least once anyway so might
as well make the u16 and the code simpler.


> ---
>  drivers/iio/dac/Kconfig   |   10 +
>  drivers/iio/dac/Makefile  |    1 +
>  drivers/iio/dac/ad3552r.c | 1208 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1219 insertions(+)
>  create mode 100644 drivers/iio/dac/ad3552r.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 75e1f2b48638..ced6428f2c92 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -6,6 +6,16 @@
>  
>  menu "Digital to analog converters"
>  
> +config AD3552R
> +	tristate "Analog Devices AD3552R DAC driver"
> +	depends on SPI_MASTER
> +	help
> +	  Say yes here to build support for Analog Devices AD3552R
> +	  Digital to Analog Converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad3552r.
> +
>  config AD5064
>  	tristate "Analog Devices AD5064 and similar multi-channel DAC driver"
>  	depends on (SPI_MASTER && I2C!=m) || I2C
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 33e16f14902a..dffe36efd8ff 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AD3552R) += ad3552r.o
>  obj-$(CONFIG_AD5360) += ad5360.o
>  obj-$(CONFIG_AD5380) += ad5380.o
>  obj-$(CONFIG_AD5421) += ad5421.o
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> new file mode 100644
> index 000000000000..fd70883c692e
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -0,0 +1,1208 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD3552R
> + * Digital to Analog converter driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +#include <asm/unaligned.h>
> +#include <linux/device.h>
> +#include <linux/iio/trigger.h>

I doubt you need trigger.h as that is normally only needed for drivers implementing
their own trigger.

> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

...

> +
> +static int ad3552r_write_and_trigger(struct ad3552r_desc *dac, u8 addr, u16 val,
> +				     u32 mask)
Hmm. Whilst it would be a little more code, I'd pull the gpio write in here as well
+ duplicate it for the one path that doesn't use this function.  Otherwise we have
a function that 'might trigger' which is a little confusing.

> +{
> +	int err;
> +
> +	err = ad3552r_write_reg(dac, addr, val);
> +	if (err)
> +		return err;
> +
> +	if (!dac->gpio_ldac) {
> +		err = ad3552r_write_reg(dac, AD3552R_REG_ADDR_SW_LDAC_24B,
> +					mask);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad3552r_write_codes(struct ad3552r_desc *dac, u32 mask, u8 *data)
> +{
> +	int err, ch, len;
> +	u8 addr, buff[AD3552R_NUM_CH * AD3552R_MAX_REG_SIZE + 1];
> +	u16 val1, val2;
> +
> +	val1 = be16_to_cpu(*((u16 *)data));
> +	if (mask == AD3552R_MASK_ALL_CH) {
> +		val2 = be16_to_cpu(*((u16 *)(data + 2)));

At least locally it's not obvious that this is aligned. So you should
use get_unaligned_be16()

Bounce backwards and forwards from big endian to cpu endian is a bit
messy and rather defeats the point of having it big endian in the kfifo.

If you can keep it in big endian all the way through that would be better
if that doesn't make sense, then make the buffer cpu endian and do the
put_unaligned_be16 in the few places it will be needed.



> +		if (val1 == val2) {
Should work fine for __be16 as well..

> +			err = ad3552r_write_and_trigger(dac,
> +							AD3552R_REG_ADDR_INPUT_PAGE_MASK_24B,
> +							val1,

This would need to take a __be16.

> +							AD3552R_MASK_ALL_CH);
> +			if (err)
> +				return err;
> +		} else {
> +			addr = AD3552R_REG_ADDR_CH_INPUT_24B(1);
> +			/* CH1 */
> +			buff[0] = data[2];
> +			buff[1] = data[3];

These should be probably be memcpy, or potentially use a packed struct to allow you to just
do assignment.  Given I'm suggesting above that you should use cpu endian for the channel
type anyway, you will just end with these being put_unaligned_be16()


> +			buff[2] = 0;
> +			/* CH0 */
> +			buff[3] = data[0];
> +			buff[4] = data[1];
> +			buff[5] = 0;
> +			len = 6;
> +			if (!dac->gpio_ldac) {
> +				/* Software LDAC */
> +				buff[6] = AD3552R_MASK_ALL_CH;
> +				++len;
> +			}
> +			err = ad3552r_transfer(dac, addr, len, buff, false);
> +			if (err)
> +				return err;
> +		}
> +	} else {
> +		ch = __ffs(mask);
> +		err = ad3552r_write_and_trigger(dac,
> +						AD3552R_REG_ADDR_CH_INPUT_24B(ch),
> +						val1,
> +						mask);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (dac->gpio_ldac) {
> +		gpiod_set_value_cansleep(dac->gpio_ldac, 0);
> +		usleep_range(AD3552R_LDAC_PULSE_US, AD3552R_LDAC_PULSE_US + 10);
> +		gpiod_set_value_cansleep(dac->gpio_ldac, 1);
> +	}
> +
> +	return 0;
> +}
> +

> +> +static irqreturn_t ad3552r_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func	*pf = p;
> +	struct iio_dev		*indio_dev = pf->indio_dev;
> +	struct iio_buffer	*buf = indio_dev->buffer;
> +	struct ad3552r_desc	*dac = iio_priv(indio_dev);
> +	char			buff[AD3552R_NUM_CH * AD3552R_MAX_REG_SIZE];

Why this size? Also u8 for consistency.

> +	int			err;
> +
> +	memset(buff, 0, sizeof(buff));
> +	err = iio_pop_from_buffer(buf, buff);
> +	if (err)
> +		goto end;
> +
> +	mutex_lock(&dac->lock);
> +	ad3552r_write_codes(dac, *indio_dev->active_scan_mask, buff);
> +	mutex_unlock(&dac->lock);
> +end:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

> +static int ad3552r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	struct ad3552r_desc *dac = iio_priv(indio_dev);
> +	u16 tmp_val;
> +	int err;
> +	u8 ch = chan->channel;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&dac->lock);
> +		err = ad3552r_read_reg(dac, AD3552R_REG_ADDR_CH_DAC_24B(ch),
> +				       &tmp_val);
> +		if (err < 0) {
> +			mutex_unlock(&dac->lock);
> +			return err;
> +		}
> +		*val = tmp_val;

I don't thing this assignment needs to be under the lock.  Moving it out allows for
this common pattern used when we need to release a lock whether or not there was an error.
Same applies to similar cases elsewhere.

		mutex_lock(&dac->lock);
		err = ad3552r_read_reg();
		muteX_unlock(&dac->lock)
		if (err < 0)
			return err;

		*val = tmp_val;
		return IIO_VAL_INT;		
> +		mutex_unlock(&dac->lock);

> +		break;
> +	case IIO_CHAN_INFO_ENABLE:
> +		mutex_lock(&dac->lock);
> +		err = ad3552r_read_reg(dac, AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> +				       &tmp_val);
> +		if (err < 0) {
> +			mutex_unlock(&dac->lock);
> +			return err;
> +		}
> +		*val = !((tmp_val & AD3552R_MASK_CH_DAC_POWERDOWN(ch)) >>
> +			  __ffs(AD3552R_MASK_CH_DAC_POWERDOWN(ch)));
> +		mutex_unlock(&dac->lock);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = dac->ch_data[ch].scale_int;
> +		*val2 = dac->ch_data[ch].scale_dec;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = dac->ch_data[ch].offset_int;
> +		*val2 = dac->ch_data[ch].offset_dec;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;

Better to return from all switch cases as that puts the type near where the
data is set.

> +}

> +
> +static u16 ad3552r_read_reg_wrapper(struct reg_addr_pool *addr)
> +{
> +	int err;
> +	u16 val = 0;

The compiler should have visibility enough to tell that there is
not path in which we use an unassigned val.  Unless you are getting warnings
I would prefer you remove that assignment to make it clear we never actually
use it.  If the compiler is being fussy - add a comment that this is warning
suppression.

> +
> +	err = ad3552r_read_reg(addr->dac, addr->addr, &val);
> +	if (err)
> +		return err;
> +
> +	return val;

I think this function needs to return an integer (See below)

> +}
> +
> +static int ad3552r_reset(struct ad3552r_desc *dac)
> +{
> +	struct reg_addr_pool addr;
> +	int ret;
> +	u16 val;
> +
> +	dac->gpio_reset = devm_gpiod_get_optional(&dac->spi->dev, "reset",
> +						  GPIOD_OUT_LOW);
> +	if (IS_ERR(dac->gpio_reset))
> +		return dev_err_probe(&dac->spi->dev, PTR_ERR(dac->gpio_reset),
> +				     "Error while getting gpio reset");
> +
> +	if (dac->gpio_reset) {
> +		/* Perform hardware reset */
> +		usleep_range(10, 20);
> +		gpiod_set_value_cansleep(dac->gpio_reset, 1);
> +	} else {
> +		/* Perform software reset if no GPIO provided */
> +		ret = ad3552r_update_reg_field(dac,
> +					       AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> +					       AD3552R_MASK_SOFTWARE_RESET,
> +					       AD3552R_MASK_SOFTWARE_RESET);
> +		if (ret < 0)
> +			return ret;
> +
> +	}
> +
> +	addr.dac = dac;
> +	addr.addr = AD3552R_REG_ADDR_INTERFACE_CONFIG_B;
> +	ret = readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
> +				 val == AD3552R_DEFAULT_CONFIG_B_VALUE ||
> +				 val < 0,
> +				 5000, 50000);
> +	if (val < 0)
> +		ret = val;
> +	if (ret)
> +		return dev_err_probe(&dac->spi->dev, ret,
> +				     "Error while resetting");
> +
> +	ret = readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
> +				 !(val & AD3552R_MASK_INTERFACE_NOT_READY) ||
> +				 val < 0,

Won't happen as val is u16.

> +				 5000, 50000);
> +	if (val < 0)
> +		ret = val;
> +	if (ret)
> +		return dev_err_probe(&dac->spi->dev, ret, "Error while reseting");
> +
> +	return ad3552r_update_reg_field(dac,
> +					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
> +					addr_mask_map[AD3552R_ADDR_ASCENSION][1],
> +					val);
> +}


> +static int ad3552r_configure_device(struct ad3552r_desc *dac)
> +{
> +	struct device *dev = &dac->spi->dev;
> +	struct fwnode_handle *child;
> +	struct regulator *vref;
> +	int err, cnt = 0, voltage, delta = 100000;
> +	u32 vals[2], val, ch;
> +	bool is_custom;
> +
> +	dac->gpio_ldac = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
> +	if (IS_ERR(dac->gpio_ldac))
> +		return dev_err_probe(dev, PTR_ERR(dac->gpio_ldac),
> +				     "Error getting gpio ldac");
> +
> +	vref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(vref)) {
> +		if (PTR_ERR(vref) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(vref),
> +					     "Error getting vref");
> +		vref = NULL;
> +	}
> +	if (vref) {
> +		voltage = regulator_get_voltage(vref);
> +		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
> +			dev_warn(dev, "vref-supply must be 2.5V");
> +			return -EINVAL;
> +		}
> +		val = AD3552R_EXTERNAL_VREF_PIN_INPUT;
> +	} else {
> +		if (device_property_read_bool(dev, "adi,vref-out-en"))
> +			val = AD3552R_INTERNAL_VREF_PIN_2P5V;
> +		else
> +			val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
> +	}
> +	err = ad3552r_update_reg_field(dac,
> +				       addr_mask_map[AD3552R_VREF_SELECT][0],
> +				       addr_mask_map[AD3552R_VREF_SELECT][1],
> +				       val);
> +	if (err)
> +		return err;
> +
> +	err = device_property_read_u32(dev, "adi,sdo-drive-strength", &val);
> +	if (!err) {
> +		if (val > 3)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "adi,sdo-drive-strength must be less than 4\n");
> +
> +		err = ad3552r_update_reg_field(dac,
> +					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][0],
> +					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][1],
> +					       val);
> +		if (err)
> +			return err;
> +	}
> +
> +	dac->num_ch = device_get_child_node_count(dev);
> +	if (!dac->num_ch)
> +		return dev_err_probe(dev, -ENODEV, "No channels defined\n");
> +
> +	device_for_each_child_node(dev, child) {
> +		err = fwnode_property_read_u32(child, "reg", &ch);
> +		if (err) {
> +			dev_err_probe(dev, err,
> +				      "mandatory reg property missing\n");
> +			goto put_child;
> +		}
> +		if (ch >= AD3552R_NUM_CH) {
> +			dev_err_probe(dev, err, "reg must be less than %d\n",
> +				      AD3552R_NUM_CH);
> +			err = -EINVAL;
> +			goto put_child;
> +		}
> +
> +		if (fwnode_property_present(child, "adi,output-range-microvolt")) {
> +			is_custom = false;
> +			err = fwnode_property_read_u32_array(child,
> +							     "adi,output-range-microvolt",
> +							     vals,
> +							     2);
> +			if (err) {
> +				dev_err_probe(dev, err,
> +					      "mandatory adi,output-range-microvolt property missing\n");
> +				goto put_child;
> +			}
> +
> +			val = ad3552r_find_range(dac->chip_id, vals);
> +			if ((s32)val < 0) {

return value is an int, so use something like
			err = ad3552r_...
			if (err < 0) {
				...
			}

			val = err;

> +				err = -EINVAL;
> +				dev_err_probe(dev, err,
> +					      "Invalid adi,output-range-microvolt value\n");
> +				goto put_child;
> +			}
> +			err = ad3552r_set_ch_value(dac,
> +						   AD3552R_CH_OUTPUT_RANGE_SEL,
> +						   ch, val);
> +			if (err)
> +				goto put_child;
> +
> +			dac->ch_data[ch].range = val;
> +		} else {
> +			is_custom = true;
> +			err = ad3552r_configure_custom_gain(dac, child, ch);
> +			if (err)
> +				goto put_child;
> +		}
> +
> +		ad3552r_calc_gain_and_offset(dac, ch);
> +		dac->enabled_ch |= BIT(ch);
> +
> +		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
> +		if (err < 0)

goto put_child?

> +			return err;
> +
> +		dac->channels[cnt] = AD3552R_CH_DAC(ch);
> +		++cnt;
> +
> +	}
> +
> +	/* Disable unused channels */
> +	for_each_clear_bit(ch, &dac->enabled_ch, AD3552R_NUM_CH) {
> +		err = ad3552r_set_ch_value(dac, AD3552R_CH_AMPLIFIER_POWERDOWN,
> +					   ch, 0);
> +		if (err)
> +			return err;
> +	}
> +
> +	dac->num_ch = cnt;
> +
> +	return 0;
> +put_child:
> +	fwnode_handle_put(child);
> +
> +	return err;
> +}
> +
> +static int ad3552r_init(struct ad3552r_desc *dac)
> +{
> +	int err;
> +	u16 val, id;
> +
> +	err = ad3552r_reset(dac);
> +	if (err)
> +		return dev_err_probe(&dac->spi->dev, err, "Reset failed\n");
> +
> +	err = ad3552r_check_scratch_pad(dac);
> +	if (err)
> +		return dev_err_probe(&dac->spi->dev, err,

These should not be dev_err_probe as they can't (I think) ever return
that the probe is deferred.

> +				     "Scratch pad test failed\n");
> +
> +	err = ad3552r_read_reg(dac, AD3552R_REG_ADDR_PRODUCT_ID_L, &val);
> +	if (err)
> +		return dev_err_probe(&dac->spi->dev, err,
> +				     "Fail read PRODUCT_ID_L\n");
> +
> +	id = val;
> +	err = ad3552r_read_reg(dac, AD3552R_REG_ADDR_PRODUCT_ID_H, &val);
> +	if (err)
> +		return dev_err_probe(&dac->spi->dev, err,
> +				     "Fail read PRODUCT_ID_H\n");
> +
> +	id |= val << 8;
> +	if (id != dac->chip_id)
> +		return dev_err_probe(&dac->spi->dev, -ENODEV,
> +				     "Product id not matching\n");
> +
> +	return ad3552r_configure_device(dac);
> +}
> +

...

