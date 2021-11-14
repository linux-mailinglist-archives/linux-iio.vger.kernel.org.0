Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1944F7F7
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 14:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhKNNF6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 08:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhKNNF4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 08:05:56 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DFFA600EF;
        Sun, 14 Nov 2021 13:02:59 +0000 (UTC)
Date:   Sun, 14 Nov 2021 13:07:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v5 2/2] drivers:iio:dac: Add AD3552R driver support
Message-ID: <20211114130745.6ba386a1@jic23-huawei>
In-Reply-To: <20211108082447.116663-3-mihail.chindris@analog.com>
References: <20211108082447.116663-1-mihail.chindris@analog.com>
        <20211108082447.116663-3-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Nov 2021 08:24:47 +0000
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

Main thing here is to give time for Rob and others to take a look at the dt-binding
but in meantime I thought I'd give the driver one last look and spotted a few minor things.

Jonathan

> ---
>  drivers/iio/dac/Kconfig   |   10 +
>  drivers/iio/dac/Makefile  |    1 +
>  drivers/iio/dac/ad3552r.c | 1199 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1210 insertions(+)
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
> index 000000000000..4a98fa734e8a
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -0,0 +1,1199 @@

...

> +
> +/* Useful defines */
> +#define AD3552R_NUM_CH					2
> +#define AD3552R_MASK_CH(ch)				BIT(ch)
> +#define AD3552R_MASK_ALL_CH				GENMASK(1, 0)
> +#define AD3552R_MAX_REG_SIZE				3
> +#define AD3552R_READ_BIT				(1 << 7)

BIT(7)?

> +#define AD3552R_ADDR_MASK				GENMASK(6, 0)
> +#define AD3552R_CRC_ENABLE_VALUE			(BIT(6) | BIT(1))
> +#define AD3552R_CRC_DISABLE_VALUE			GENMASK(1, 0)
> +#define AD3552R_CRC_POLY				0x07
> +#define AD3552R_CRC_SEED				0xA5
> +#define AD3552R_MASK_DAC_12B				0xFFF0
> +#define AD3552R_DEFAULT_CONFIG_B_VALUE			0x8
> +#define AD3552R_SCRATCH_PAD_TEST_VAL1			0x34
> +#define AD3552R_SCRATCH_PAD_TEST_VAL2			0xB2
> +#define AD3552R_GAIN_SCALE				1000
> +#define AD3552R_LDAC_PULSE_US				100
> +

> +
> +struct ad3552r_desc {
> +	/*
> +	 * Used to look the spi bus for atomic operations where needed and
> +	 * also protect access to buf_data below
> +	 */
> +	struct mutex		lock;
> +	struct gpio_desc	*gpio_reset;
> +	struct gpio_desc	*gpio_ldac;
> +	struct spi_device	*spi;
> +	struct ad3552r_ch_data	ch_data[AD3552R_NUM_CH];
> +	struct iio_chan_spec	channels[AD3552R_NUM_CH + 1];
> +	unsigned long		enabled_ch;
> +	unsigned int		num_ch;
> +	enum ad3542r_id		chip_id;
> +	/*
> +	 * The maximum spi transfer size consist 1 bytes (reg address)
> +	 * + 2 registers of 3 bytes + 1 reg of 1 byte (SW LDAC)
> +	 */
> +	u8 buf_data[8] ____cacheline_aligned;

As mentioned below - given how this is used as a bounce buffer, you could just use
spi_write_then_read() in all paths and avoid the complexity.

> +};
> +

...

> +/* 0 -> reg addr, 1->ch0 mask, 2->ch1 mask */
> +static const u16 addr_mask_map_ch[][3] = {
> +	[AD3552R_CH_DAC_POWERDOWN] = {
> +			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> +			AD3552R_MASK_CH_DAC_POWERDOWN(0),
> +			AD3552R_MASK_CH_DAC_POWERDOWN(1)
> +	},
> +	[AD3552R_CH_AMPLIFIER_POWERDOWN] = {
> +			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> +			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(0),
> +			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(1)
> +	},
> +	[AD3552R_CH_OUTPUT_RANGE_SEL] = {
> +			AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> +			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0),
> +			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1)
> +	},
> +	/*
> +	 * This attributes are update by the chip on 16B and 24B no matter to
> +	 * what register the write is done
> +	 */
> +	[AD3552R_CH_TRIGGER_SOFTWARE_LDAC] = {

Is this used?

> +			AD3552R_REG_ADDR_SW_LDAC_16B,
> +			AD3552R_MASK_CH(0),
> +			AD3552R_MASK_CH(1)
> +	},
> +	[AD3552R_CH_HW_LDAC_MASK] = {
> +			AD3552R_REG_ADDR_HW_LDAC_16B,
> +			AD3552R_MASK_CH(0),
> +			AD3552R_MASK_CH(1)
> +	},
> +	[AD3552R_CH_SELECT] = {
> +			AD3552R_REG_ADDR_CH_SELECT_16B,
> +			AD3552R_MASK_CH(0),
> +			AD3552R_MASK_CH(1)
> +	}
> +};
> +

> +
> +/* SPI transfer to device */
> +static int ad3552r_transfer(struct ad3552r_desc *dac, u8 addr, u32 len,
> +			    u8 *data, bool is_read)
> +{
> +	u8 instr;
> +
> +	instr = addr & AD3552R_ADDR_MASK;
> +	instr |= is_read ? AD3552R_READ_BIT : 0;
> +	if (is_read)
> +		return spi_write_then_read(dac->spi, &instr, 1, data, len);
> +
> +	dac->buf_data[0] = instr;
> +	memcpy(dac->buf_data + 1, data, len);
> +	return spi_write(dac->spi, dac->buf_data, len + 1);

If you are going to have to do a small memory copy anyway, you could just
use spi_write_then_read() with a 0 size read.  It ends up very similar
to what you are doing here.

> +}
> +

> +
> +/*
> + * Device type specific information.
> + */

Not sure this is a particularly useful comment - I'd drop it.

> +static const struct iio_info ad3552r_iio_info = {
> +	.read_raw = ad3552r_read_raw,
> +	.write_raw = ad3552r_write_raw
> +};
> +


...

> +static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
> +					 struct fwnode_handle *child,
> +					 u32 ch)
> +{
> +	struct device *dev = &dac->spi->dev;
> +	struct fwnode_handle *gain_child;
> +	u32 val;
> +	int err;
> +	u8 addr;
> +	u16 mask = 0, reg = 0, offset;
> +
> +	gain_child = fwnode_get_named_child_node(child,
> +						 "custom-output-range-config");
> +	if (IS_ERR(gain_child)) {
> +		dev_err(dev,
> +			"mandatory custom-output-range-config property missing\n");
> +		return PTR_ERR(gain_child);
> +	}
> +
> +	dac->ch_data[ch].range_override = 1;
> +	reg |= ad3552r_field_prep(1, AD3552R_MASK_CH_RANGE_OVERRIDE);
> +	mask |= AD3552R_MASK_CH_RANGE_OVERRIDE;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
> +	if (err) {
> +		dev_err(dev, "mandatory adi,gain-scaling-p property missing\n");
> +		goto put_child;
> +	}
> +	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_P);
> +	mask |= AD3552R_MASK_CH_GAIN_SCALING_P;
> +	dac->ch_data[ch].p = val;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
> +	if (err) {
> +		dev_err(dev, "mandatory adi,gain-scaling-n property missing\n");
> +		goto put_child;
> +	}
> +	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_N);
> +	mask |= AD3552R_MASK_CH_GAIN_SCALING_N;
> +	dac->ch_data[ch].n = val;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
> +	if (err) {
> +		dev_err(dev, "mandatory adi,rfb-ohms property missing\n");
> +		goto put_child;
> +	}
> +	dac->ch_data[ch].rfb = val;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
> +	if (err) {
> +		dev_err(dev, "mandatory adi,gain-offset property missing\n");
> +		goto put_child;
> +	}
> +	dac->ch_data[ch].gain_offset = val;
> +
> +	offset = abs((s32)val);
> +	reg |= ad3552r_field_prep((offset >> 8), AD3552R_MASK_CH_OFFSET_BIT_8);
> +	mask |= AD3552R_MASK_CH_OFFSET_BIT_8;
> +
> +	reg |= ad3552r_field_prep((s32)val < 0, AD3552R_MASK_CH_OFFSET_POLARITY);
> +	mask |= AD3552R_MASK_CH_OFFSET_POLARITY;

mask never used?  I'm guessing left over from before you introduced your
field_prep function.

> +	addr = AD3552R_REG_ADDR_CH_GAIN(ch);
> +	err = ad3552r_write_reg(dac, addr,
> +				offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
> +	if (err) {
> +		dev_err(dev, "Error writing register\n");
> +		goto put_child;
> +	}
> +
> +	err = ad3552r_write_reg(dac, addr, reg);
> +	if (err) {
> +		dev_err(dev, "Error writing register\n");
> +		goto put_child;
> +	}
> +
> +put_child:
> +	fwnode_handle_put(gain_child);
> +
> +	return err;
> +}
> +
> +static int ad3552r_configure_device(struct ad3552r_desc *dac)
> +{
> +	struct device *dev = &dac->spi->dev;
> +	struct fwnode_handle *child;
> +	struct regulator *vref;
> +	int err, cnt = 0, voltage, delta = 100000;
> +	u32 vals[2], val, ch;
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
Perhaps use an else branch for this so that we don't need to bother with
setting vref = NULL
	if (IS_ERR(vref)) {
		if (PTR_ERR(vref) != -ENODEV)
			return dev_err_probe(dev, PTR_ERR(vref),
					     "Error getting vref");
		if (device_property_read_bool(dev, "adi,vref-out-en"))
			val = AD3552R_INTERNAL_VREF_PIN_2P5V;
		else
			val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
	} else {

// Need to turn it on somewhere, so regulator_enable() + devm handler to turn it off again.

		voltage = regulator_get_voltage(vref);
		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
			dev_warn(dev, "vref-supply must be 2.5V");
			return -EINVAL;
		}
		val = AD3552R_EXTERNAL_VREF_PIN_INPUT;
	}
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
> +		if (val > 3) {
> +			dev_err(dev, "adi,sdo-drive-strength must be less than 4\n");
> +			return -EINVAL;
> +		}
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
> +	if (!dac->num_ch) {
> +		dev_err(dev, "No channels defined\n");
> +		return -ENODEV;
> +	}
> +
> +	device_for_each_child_node(dev, child) {
> +		err = fwnode_property_read_u32(child, "reg", &ch);
> +		if (err) {
> +			dev_err(dev, "mandatory reg property missing\n");
> +			goto put_child;
> +		}
> +		if (ch >= AD3552R_NUM_CH) {
> +			dev_err(dev, "reg must be less than %d\n",
> +				AD3552R_NUM_CH);
> +			err = -EINVAL;
> +			goto put_child;
> +		}
> +
> +		if (fwnode_property_present(child, "adi,output-range-microvolt")) {
> +			err = fwnode_property_read_u32_array(child,
> +							     "adi,output-range-microvolt",
> +							     vals,
> +							     2);
> +			if (err) {
> +				dev_err(dev,
> +					"mandatory adi,output-range-microvolt property missing\n");
> +				goto put_child;
> +			}
> +
> +			err = ad3552r_find_range(dac->chip_id, vals);
> +			if (err < 0) {
> +				dev_err(dev,
> +					"Invalid adi,output-range-microvolt value\n");
> +				goto put_child;
> +			}
> +			val = err;
> +			err = ad3552r_set_ch_value(dac,
> +						   AD3552R_CH_OUTPUT_RANGE_SEL,
> +						   ch, val);
> +			if (err)
> +				goto put_child;
> +
> +			dac->ch_data[ch].range = val;
> +		} else {
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
> +			goto put_child;
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

...

