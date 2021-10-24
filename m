Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCA6438AB2
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJXQr3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 12:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhJXQr2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 12:47:28 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FAE76101D;
        Sun, 24 Oct 2021 16:45:05 +0000 (UTC)
Date:   Sun, 24 Oct 2021 17:49:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v4 2/2] drivers:iio:dac: Add AD3552R driver support
Message-ID: <20211024174927.6ac6c4e1@jic23-huawei>
In-Reply-To: <20211022120427.99516-3-mihail.chindris@analog.com>
References: <20211022120427.99516-1-mihail.chindris@analog.com>
        <20211022120427.99516-3-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Oct 2021 12:04:27 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> The AD3552R-16 is a low drift ultrafast, 16-bit accuracy,
> current output digital-to-analog converter (DAC) designed
> to generate multiple output voltage span ranges.
> The AD3552R-16 operates with a fixed 2.5V reference.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf

We got an oddly delayed 0-day response: 

All errors (new ones prefixed by >>):

   drivers/iio/dac/ad3552r.c: In function 'ad3552r_configure_device':
>> drivers/iio/dac/ad3552r.c:978:14: error: variable 'is_custom' set but not used [-Werror=unused-but-set-variable]  
     978 |         bool is_custom;
         |              ^~~~~~~~~
   cc1: all warnings being treated as errors

Needs fixing.

Otherwise one trivial request for an improved comment.

On process front, you seem to have forgotten to update the cover letter with the
changes since v2. 

This is looking very nice now.  Unfortunately timing is against us so this won't
go into mainline until next cycle now as IIO is effectively closed for the coming
merge window.

Thanks,

Jonathan


> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  drivers/iio/dac/Kconfig   |   10 +
>  drivers/iio/dac/Makefile  |    1 +
>  drivers/iio/dac/ad3552r.c | 1199 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1210 insertions(+)
>  create mode 100644 drivers/iio/dac/ad3552r.c

...

> +
> +struct ad3552r_desc {
> +	/* Used to look the spi bus for atomic operations where needed */

This comment should be slightly expanded upon. It's also protecting accesses
to buf_data below.

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
> +};
> +

...

> +
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
> +	bool is_custom;

Set but not used as per the 0-day warning that came in for v3 (after
you had already sent v4)

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
> +			is_custom = false;
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
> +

...
