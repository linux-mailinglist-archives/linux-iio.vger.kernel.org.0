Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88EE3C3B82
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhGKK2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 06:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhGKK2l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 06:28:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E7B611CC;
        Sun, 11 Jul 2021 10:25:52 +0000 (UTC)
Date:   Sun, 11 Jul 2021 11:28:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Navin Sankar <navin@linumiz.com>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: temperature: Add MAX31865 RTD Support
Message-ID: <20210711112807.5cf5d062@jic23-huawei>
In-Reply-To: <602bf836-d8a5-316c-3a08-29ab47d6d090@linumiz.com>
References: <20210703095806.220880-1-navin@linumiz.com>
        <20210703164826.5b97ba27@jic23-huawei>
        <602bf836-d8a5-316c-3a08-29ab47d6d090@linumiz.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Jul 2021 20:43:13 +0530
Navin Sankar <navin@linumiz.com> wrote:

> On 03/07/21 9:18 pm, Jonathan Cameron wrote:
> > On Sat,  3 Jul 2021 15:28:06 +0530
> > Navin Sankar Velliangiri <navin@linumiz.com> wrote:
> >  
> >> This patch adds support for Maxim MAX31865 RTD temperature
> >> sensor support.
> >>
> >> More information can be found in:
> >> https://datasheets.maximintegrated.com/en/ds/MAX31865.pdf
> >>
> >> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>  
> > Hi Navin,
> >
> > Biggest comment here is that userspace ABI needs documentation.
> > You define a few new things in here, and it is tricky to review that
> > without the docs.  As such, we may well have more comments on those once
> > those Docs are available.
> >
> > Otherwise, various minor comments inline.  
> 
> Hi Jonathan,
> 	Thanks for the comments & suggestion. I will fix the code and submit v2 patch.
> But I didn't get the point documentation. Where I want to create and place the
> documentation?

Kernel tree at the path mentioned.  Whether it fits in the general documentation,
Documentation/ABI/testing/sysfs-bus-iio or is more specific governs which exact
file it goes in.  That's a decision for you to make when proposing the docs.

Jonathan

> 
> Regards,
> Navin Sankar.
> 
> > ---  
> >>   drivers/iio/temperature/Kconfig    |  10 +
> >>   drivers/iio/temperature/Makefile   |   1 +
> >>   drivers/iio/temperature/max31865.c | 325 +++++++++++++++++++++++++++++
> >>   3 files changed, 336 insertions(+)
> >>   create mode 100644 drivers/iio/temperature/max31865.c
> >>
> >> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> >> index 4df60082c1fa..c9412abca069 100644
> >> --- a/drivers/iio/temperature/Kconfig
> >> +++ b/drivers/iio/temperature/Kconfig
> >> @@ -128,4 +128,14 @@ config MAX31856
> >>   	  This driver can also be built as a module.  If so, the module
> >>   	  will be called max31856.
> >>   
> >> +config MAX31865
> >> +	tristate "MAX31865 RTD to Digital converter"
> >> +	depends on SPI
> >> +	help
> >> +	  If you say yes here you get support for MAX31865
> >> +	  thermocouple sensor chip connected via SPI.
> >> +
> >> +	  This driver can also be build as a module. If so, the module
> >> +	  will be called max31865.
> >> +
> >>   endmenu
> >> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> >> index 90c113115422..a8f3187258dc 100644
> >> --- a/drivers/iio/temperature/Makefile
> >> +++ b/drivers/iio/temperature/Makefile
> >> @@ -8,6 +8,7 @@ obj-$(CONFIG_LTC2983) += ltc2983.o
> >>   obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
> >>   obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> >>   obj-$(CONFIG_MAX31856) += max31856.o
> >> +obj-$(CONFIG_MAX31865) += max31865.o
> >>   obj-$(CONFIG_MLX90614) += mlx90614.o
> >>   obj-$(CONFIG_MLX90632) += mlx90632.o
> >>   obj-$(CONFIG_TMP006) += tmp006.o
> >> diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
> >> new file mode 100644
> >> index 000000000000..581c46b12eee
> >> --- /dev/null
> >> +++ b/drivers/iio/temperature/max31865.c
> >> @@ -0,0 +1,325 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +
> >> +/*
> >> + * Copyright (c) Linumiz 2021
> >> + *
> >> + * max31865.c - Maxim MAX31865 RTD-to-Digital Converter sensor driver
> >> + *
> >> + * Author: Navin Sankar Velliangiri <navin@linumiz.com>
> >> + */
> >> +
> >> +#include <linux/ctype.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/err.h>
> >> +#include <linux/init.h>
> >> +#include <linux/module.h>
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/sysfs.h>
> >> +#include <linux/spi/spi.h>
> >> +#include <linux/util_macros.h>  
> > why?  Check the others are used.
> >  
> >> +#include <asm/unaligned.h>
> >> +
> >> +/*
> >> + * The MSB of the register value determines whether the following byte will
> >> + * be written or read. If it is 0, read will follow and if it is 1, write
> >> + * will follow.
> >> + */
> >> +#define MAX31865_RD_WR_BIT			BIT(7)
> >> +
> >> +#define MAX31865_CFG_VBIAS			BIT(7)
> >> +#define MAX31865_CFG_1SHOT			BIT(5)
> >> +#define MAX31865_3WIRE_RTD			BIT(4)
> >> +#define MAX31865_FAULT_STATUS_CLEAR		BIT(1)
> >> +#define MAX31865_FILTER_50HZ			BIT(0)
> >> +
> >> +/* The MAX31865 registers */
> >> +#define MAX31865_CFG_REG			0x00
> >> +#define MAX31865_RTD_MSB			0x01
> >> +#define MAX31865_FAULT_STATUS			0x07
> >> +
> >> +#define MAX31865_FAULT_OVUV			BIT(2)
> >> +
> >> +static const struct iio_chan_spec max31865_channels[] = {
> >> +	{	/* RTD Temperature */
> >> +		.type = IIO_TEMP,
> >> +		.info_mask_separate =
> >> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
> >> +	},
> >> +};
> >> +
> >> +struct max31865_data {
> >> +	struct spi_device *spi;
> >> +	bool filter_50hz;
> >> +	bool no_of_wires;
> >> +};
> >> +
> >> +static int max31865_read(struct max31865_data *data, u8 reg,
> >> +			 u8 val[], unsigned int read_size)
> >> +{
> >> +	return spi_write_then_read(data->spi, &reg, 1, val, read_size);
> >> +}
> >> +
> >> +static int max31865_write(struct max31865_data *data, u8 reg,
> >> +			  unsigned int val)
> >> +{
> >> +	u8 buf[2];
> >> +
> >> +	buf[0] = reg | (MAX31865_RD_WR_BIT);  
> > Brackets not needed.
> >
> > Also can just have it as...
> >
> > 	u8 buf[2] = {
> > 		reg | MAX...,
> > 		val
> > };  
> >> +	buf[1] = val;
> >> +
> >> +	return spi_write(data->spi, buf, 2);  
> > spi_write() directly calls spi_sync_transfer() which in turn calls spi_sync() and
> > that requires dma safe buffers.  For a buffer to dma safe it need to be in a
> > cacheline not shared with other data.  That basically means you can use a buffer
> > on the stack.
> >
> > Take a look at the use of __cacheline_aligned in IIO drivers to allow
> > us to put this in the iio_priv() structure
> > (we go through a dance in the core to ensure that space is itself always
> > aligned to a cacheline).
> >
> > Another fairly clean way around this is to call spi_write_then_read with 0 length
> > read.  That function uses bounce buffers to avoid any DMA issues.
> >
> > Wolfram gave a good talk on this a few years back:
> > https://www.youtube.com/watch?v=JDwaMClvV-s
> >
> > Having once run into this problem it is extremely hard to debug as we all love
> > extremely rare data corruption!
> >  
> >> +}
> >> +
> >> +static int enable_bias(struct max31865_data *data, bool enable)  
> > prefix all functions with max31865 as it makes it obvious what is driver
> > local an what is a generic call.
> >
> > Also, a function that has an enable parameter should have a name that
> > reflects that.
> >
> > 	max31865_set_bias_enable or something like that.
> >  
> >> +{
> >> +	u8 cfg;
> >> +	int ret;
> >> +
> >> +	ret = max31865_read(data, MAX31865_CFG_REG, &cfg, sizeof(cfg));  
> > As below, feels like a cache definitely makes sense for this!
> >  
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (enable)
> >> +		cfg |= MAX31865_CFG_VBIAS;
> >> +	else
> >> +		cfg &= ~MAX31865_CFG_VBIAS;
> >> +
> >> +	ret = max31865_write(data, MAX31865_CFG_REG, cfg);  
> > return max...
> >  
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int max31865_rtd_read(struct max31865_data *data, int *val)
> >> +{
> >> +	int ret;
> >> +	u8 cfg, rtd_val[2];
> >> +
> >> +	/* Enable BIAS to start the conversion */
> >> +	ret = enable_bias(data, true);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* wait 10.5ms before initiating the conversion */
> >> +	msleep(11);  
> > No need for first version of this driver, but perhaps consider doing runtime
> > pm for this as a future patch.  That way we can avoid the sleep if
> > we are doing repeated reads (perhaps to do oversampling) but still get the
> > power benefit if we are reading at lower frequency.
> > If it doesn't matter for your application, then we can wait until someone
> > else cares (if ever!)
> >  
> >> +
> >> +	ret = max31865_read(data, MAX31865_CFG_REG, &cfg, sizeof(cfg));  
> > Seems like something we should probably be caching? Nice to cut down on
> > transfers in the one remotely hot path in the driver.
> > One option would be to use regmap, but if this is the only register where
> > that makes sense, then perhaps just implement a cache for it in this driver.
> > Superficially it feels like you can build the content of cfg from things
> > you are already caching anyway.
> >  
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	cfg |= MAX31865_CFG_1SHOT | MAX31865_FAULT_STATUS_CLEAR;
> >> +
> >> +	ret = max31865_write(data, MAX31865_CFG_REG, cfg);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (data->filter_50hz) {
> >> +		/* 50Hz filter mode requires 62.5ms to complete */
> >> +		msleep(63);
> >> +	} else {
> >> +		/* 60Hz filter mode requires 52ms to complete */
> >> +		msleep(52);
> >> +	}
> >> +
> >> +	ret = max31865_read(data, MAX31865_RTD_MSB, rtd_val, sizeof(rtd_val));
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	*val = (rtd_val[0] << 8 | rtd_val[1]) >> 1;  
> > *val = be16_to_cpup(rtd_val) >> 1;
> >  
> >> +
> >> +	/* disable bias */  
> > Name function such that this is obvious and drop the comment.
> > Comment bit rot in a way that well named functions don't :)
> >  
> >> +	ret = enable_bias(data, false);  
> > return enable_bias(data, false)
> >  
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int max31865_read_raw(struct iio_dev *indio_dev,
> >> +			     struct iio_chan_spec const *chan,
> >> +			     int *val, int *val2, long mask)
> >> +{
> >> +	struct max31865_data *data = iio_priv(indio_dev);
> >> +	int ret = 0;  
> > Always set so no need to initialize.
> >  
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		ret = max31865_rtd_read(data, val);  
> > Nothing stops multiple simultaneous reads of the sysfs attribute.
> > As such, I think you need a mutex to protect the device state
> > when doing reads.
> >  
> >> +		if (ret)
> >> +			return ret;
> >> +		return IIO_VAL_INT;
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		/* Temp. Data resolution is 0.03125 */  
> > give a unit "degrees centigrade"
> >  
> >> +		*val = 31;
> >> +		*val2 = 250000; /* 1000 * 0.03125 */
> >> +		return IIO_VAL_INT_PLUS_MICRO;
> >> +	default:
> >> +		ret = -EINVAL;  
> > 		return -EINVAL; and drop the return below as
> > we won't be able to get to it.
> >  
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int max31865_init(struct max31865_data *data)
> >> +{
> >> +	int ret;
> >> +	u8 cfg = 0;
> >> +
> >> +	if (data->no_of_wires)
> >> +		/* 3-wire RTD connection */
> >> +		cfg |= MAX31865_3WIRE_RTD;
> >> +
> >> +	if (data->filter_50hz)
> >> +		/* 50Hz noise rejection filter */
> >> +		cfg |= MAX31865_FILTER_50HZ;  
> > filter_50hz is controlled from userspace, yet this init is only
> > called on probe.  Hence I can't see how changing this to 60Hz via
> > sysfs has any impact.
> >  
> >> +
> >> +	ret = max31865_write(data, MAX31865_CFG_REG, cfg);  
> > return max31865_....
> >  
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
> >> +{
> >> +	int ret;
> >> +	bool fault;
> >> +	u8 reg_val;
> >> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >> +	struct max31865_data *data = iio_priv(indio_dev);
> >> +
> >> +	ret = max31865_read(data, MAX31865_FAULT_STATUS, &reg_val, 1);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	fault = reg_val & faultbit;
> >> +
> >> +	return sprintf(buf, "%d\n", fault);
> >> +}
> >> +
> >> +static ssize_t show_fault_ovuv(struct device *dev,
> >> +			      struct device_attribute *attr,
> >> +			      char *buf)
> >> +{
> >> +	return show_fault(dev, MAX31865_FAULT_OVUV, buf);
> >> +}
> >> +
> >> +static ssize_t show_filter(struct device *dev,
> >> +			   struct device_attribute *attr,
> >> +			   char *buf)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >> +	struct max31865_data *data = iio_priv(indio_dev);
> >> +
> >> +	return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
> >> +}
> >> +
> >> +static ssize_t set_filter(struct device *dev,
> >> +			  struct device_attribute *attr,
> >> +			  const char *buf,
> >> +			  size_t len)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >> +	struct max31865_data *data = iio_priv(indio_dev);
> >> +	unsigned int freq;
> >> +	int ret;
> >> +
> >> +	ret = kstrtouint(buf, 10, &freq);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	switch (freq) {
> >> +	case 50:
> >> +		data->filter_50hz = true;
> >> +		break;
> >> +	case 60:
> >> +		data->filter_50hz = false;
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return len;
> >> +}
> >> +
> >> +static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> >> +static IIO_DEVICE_ATTR(in_temp_filter_notch_frequency, 0644,
> >> +		    show_filter, set_filter, 0);
> >> +
> >> +static struct attribute *max31865_attributes[] = {
> >> +	&iio_dev_attr_fault_ovuv.dev_attr.attr,
> >> +	&iio_dev_attr_in_temp_filter_notch_frequency.dev_attr.attr,  
> > This defines new ABI.  All ABI must be documented in
> > Documentation/ABI/testing/sysfs-bus-iio-*
> >
> > It will make it a lot easier to discuss if we have docs on what
> > these are.  Notch frequency is fine to support and indeed is
> > a sensible thing to add to the IIO core. The naming you have
> > also fits well with the existing filter ABI.
> > I would like to see an _available though.
> >
> > So could you define a new entry in iio_chan_info_enum include/linux/iio/types.h
> > and provide relevant strings in places where those are looked up.
> > Do that as a precursor patch to this one, then use that new infrastructure
> > to implement this.
> >
> > The fault one is a bit more controversial.  Fault conditions tend to
> > be annoyingly device specific, so we've never really defined a universal
> > ABI for them.
> >
> > Where possible, mapping to IIO events at least keeps things within the
> > defined ABI, but I'm not sure if that can be sensibly done here.
> >  
> >> +	NULL,
> >> +};
> >> +
> >> +static const struct attribute_group max31865_group = {
> >> +	.attrs = max31865_attributes,
> >> +};
> >> +
> >> +static const struct iio_info max31865_info = {
> >> +	.read_raw = max31865_read_raw,
> >> +	.attrs = &max31865_group,
> >> +};
> >> +
> >> +static int max31865_probe(struct spi_device *spi)
> >> +{
> >> +	const struct spi_device_id *id = spi_get_device_id(spi);
> >> +	struct iio_dev *indio_dev;
> >> +	struct max31865_data *data;
> >> +	int ret;
> >> +
> >> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	data = iio_priv(indio_dev);
> >> +	data->spi = spi;
> >> +	data->filter_50hz = false;
> >> +	data->no_of_wires = 0;  
> > Rename that variable, as 0 wires is unlikely to make much sense.
> > Also, given it's a choice between two values, it would be
> > more intuitive to set this in an if/else statement below.
> >  
> >> +
> >> +	spi_set_drvdata(spi, indio_dev);  
> > Not used so drop this.
> >  
> >> +
> >> +	indio_dev->info = &max31865_info;
> >> +	indio_dev->name = id->name;
> >> +	indio_dev->modes = INDIO_DIRECT_MODE;
> >> +	indio_dev->channels = max31865_channels;
> >> +	indio_dev->num_channels = ARRAY_SIZE(max31865_channels);
> >> +
> >> +	if (of_property_read_bool(spi->dev.of_node, "maxim,no-of-wires"))
> >> +		data->no_of_wires = 1;
> >> +
> >> +	ret = max31865_init(data);
> >> +	if (ret) {
> >> +		dev_err(&spi->dev, "error: Failed to configure max31865\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	return devm_iio_device_register(&spi->dev, indio_dev);
> >> +}
> >> +
> >> +static const struct spi_device_id max31865_id[] = {
> >> +	{ "max31865", 0 },
> >> +	{ }
> >> +};
> >> +MODULE_DEVICE_TABLE(spi, max31865_id);
> >> +
> >> +static const struct of_device_id max31865_of_match[] = {
> >> +	{ .compatible = "maxim,max31865" },
> >> +	{ }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, max31865_of_match);
> >> +
> >> +static struct spi_driver max31865_driver = {
> >> +	.driver = {
> >> +		.name	= "max31865",
> >> +		.of_match_table = max31865_of_match,
> >> +	},
> >> +	.probe = max31865_probe,
> >> +	.id_table = max31865_id,
> >> +};
> >> +module_spi_driver(max31865_driver);
> >> +
> >> +MODULE_AUTHOR("Navin Sankar Velliangiri <navin@linumiz.com>");
> >> +MODULE_DESCRIPTION("Maxim MAX31865 RTD-to-Digital Converter sensor driver");
> >> +MODULE_LICENSE("GPL v2");  

