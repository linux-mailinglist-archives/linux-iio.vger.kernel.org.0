Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF7196693
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgC1OMz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:12:55 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:46764 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1OMz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 10:12:55 -0400
Date:   Sat, 28 Mar 2020 16:17:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1585404773;
        bh=wkMu0cbfORvwDvWsBYmDZLq1+Ly8mo0CBkKV4U3IjpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EypJS3+828KRRsHoS5z7V3ITXY4gfzRJMLJ7jB01nSEiORXDMcRLxr0XtLgkB+969
         MDRZu2IF0ha91K8hTNOyw6zT55PKPZFHlZCPTPaZummx4JGYW/5TrZ1YnBn7e8jM5B
         2QaTaOloafsyYS3gusCZgJkRKi+fCigC+Z3l5YtWSZEprqi/fdtG24rhrPcQslgTis
         vvq0MUZFbQgZZYRzf6jf0ktrRnBWDmoPNyeeMhWFoFtqa6bgcB8MLGt0/gpb7rGT1R
         /53ImWHEzBy2cxCOrHP0h0Dr4/DReqcynpRoajYDXF8uGVdMn2a4YYgZUGutnsvmCY
         TWK0CDH21pfdA==
From:   Alexandru Lazar <alazar@startmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v5 2/2] iio: adc: Add MAX1241 driver
Message-ID: <20200328141746.GA9793@leena.republic>
References: <20200322140237.211347-1-alazar@startmail.com>
 <20200322140237.211347-3-alazar@startmail.com>
 <20200328133434.0f99dc93@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328133434.0f99dc93@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Minor issue inline.  I can fix that up when applying.
> However, I'd like to give more time for Rob to take a look at the
> dt binding.  I've made too many mistakes on those recently :(

Ooh, yes! Right! Sorry, my brain is still not wired correctly for these
fancy new callback thingies.

It's actually less minor than it looks because disable_reg_action
actually tries to turn *both* regulators off. No way that's gonna go
well, and I'm not sure why I my alarm didn't go off when I tested the
damn thing, either.

I'll fix it on Monday and post a v6, don't worry about it, you've got a
whole tree to tend to. We got plenty of time anyway (and, like I said,
I'm really in no rush at all :-) ).

Thanks,
Alex

> 
> Reality is we've missed the coming merge window with this anyway
> so we have plenty of time.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/Kconfig   |  10 ++
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/max1241.c | 213 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 224 insertions(+)
> >  create mode 100644 drivers/iio/adc/max1241.c
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 5d8540b7b427..55f6462cd93f 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -566,6 +566,16 @@ config MAX1118
> >  	  To compile this driver as a module, choose M here: the module will be
> >  	  called max1118.
> >  
> > +config MAX1241
> > +	tristate "Maxim max1241 ADC driver"
> > +	depends on SPI_MASTER
> > +	help
> > +	  Say yes here to build support for Maxim max1241 12-bit, single-channel
> > +	  ADC.
> > +
> > +	  To compile this driver as a module, choose M here: the module will be
> > +	  called max1241.
> > +
> >  config MAX1363
> >  	tristate "Maxim max1363 ADC driver"
> >  	depends on I2C
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index a1f1fbec0f87..37d6f17559dc 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -54,6 +54,7 @@ obj-$(CONFIG_LTC2497) += ltc2497.o
> >  obj-$(CONFIG_MAX1027) += max1027.o
> >  obj-$(CONFIG_MAX11100) += max11100.o
> >  obj-$(CONFIG_MAX1118) += max1118.o
> > +obj-$(CONFIG_MAX1241) += max1241.o
> >  obj-$(CONFIG_MAX1363) += max1363.o
> >  obj-$(CONFIG_MAX9611) += max9611.o
> >  obj-$(CONFIG_MCP320X) += mcp320x.o
> > diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
> > new file mode 100644
> > index 000000000000..33ea61305f27
> > --- /dev/null
> > +++ b/drivers/iio/adc/max1241.c
> > @@ -0,0 +1,213 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * MAX1241 low-power, 12-bit serial ADC
> > + *
> > + * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define MAX1241_VAL_MASK GENMASK(11, 0)
> > +#define MAX1241_SHDN_DELAY_USEC 4
> > +
> > +enum max1241_id {
> > +	max1241,
> > +};
> > +
> > +struct max1241 {
> > +	struct spi_device *spi;
> > +	struct mutex lock;
> > +	struct regulator *vdd;
> > +	struct regulator *vref;
> > +	struct gpio_desc *shdn;
> > +
> > +	__be16 data ____cacheline_aligned;
> > +};
> > +
> > +static const struct iio_chan_spec max1241_channels[] = {
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.indexed = 1,
> > +		.channel = 0,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				BIT(IIO_CHAN_INFO_SCALE),
> > +	},
> > +};
> > +
> > +static int max1241_read(struct max1241 *adc)
> > +{
> > +	struct spi_transfer xfers[] = {
> > +		/*
> > +		 * Begin conversion by bringing /CS low for at least
> > +		 * tconv us.
> > +		 */
> > +		{
> > +			.len = 0,
> > +			.delay.value = 8,
> > +			.delay.unit = SPI_DELAY_UNIT_USECS,
> > +		},
> > +		/*
> > +		 * Then read two bytes of data in our RX buffer.
> > +		 */
> > +		{
> > +			.rx_buf = &adc->data,
> > +			.len = 2,
> > +		},
> > +	};
> > +
> > +	return spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
> > +}
> > +
> > +static int max1241_read_raw(struct iio_dev *indio_dev,
> > +			struct iio_chan_spec const *chan,
> > +			int *val, int *val2, long mask)
> > +{
> > +	int ret, vref_uV;
> > +	struct max1241 *adc = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&adc->lock);
> > +
> > +		if (adc->shdn) {
> > +			gpiod_set_value(adc->shdn, 0);
> > +			udelay(MAX1241_SHDN_DELAY_USEC);
> > +			ret = max1241_read(adc);
> > +			gpiod_set_value(adc->shdn, 1);
> > +		} else
> > +			ret = max1241_read(adc);
> > +
> > +		if (ret) {
> > +			mutex_unlock(&adc->lock);
> > +			return ret;
> > +		}
> > +
> > +		*val = (be16_to_cpu(adc->data) >> 3) & MAX1241_VAL_MASK;
> > +
> > +		mutex_unlock(&adc->lock);
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		vref_uV = regulator_get_voltage(adc->vref);
> > +
> > +		if (vref_uV < 0)
> > +			return vref_uV;
> > +
> > +		*val = vref_uV / 1000;
> > +		*val2 = 12;
> > +
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info max1241_info = {
> > +	.read_raw = max1241_read_raw,
> > +};
> > +
> > +static void max1241_disable_reg_action(void *data)
> > +{
> > +	struct max1241 *adc = data;
> > +	struct device *dev = &adc->spi->dev;
> > +	int err;
> > +
> > +	err = regulator_disable(adc->vref);
> > +	if (err)
> > +		dev_err(dev, "could not disable vref regulator.\n");
> > +
> > +	err = regulator_disable(adc->vdd);
> > +	if (err)
> > +		dev_err(dev, "could not disable vdd regulator.\n");
> > +}
> > +
> > +static int max1241_probe(struct spi_device *spi)
> > +{
> > +	struct device *dev = &spi->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct max1241 *adc;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	adc = iio_priv(indio_dev);
> > +	adc->spi = spi;
> > +	mutex_init(&adc->lock);
> > +
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	adc->vdd = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(adc->vdd)) {
> > +		dev_err(dev, "failed to get vdd regulator\n");
> > +		return PTR_ERR(adc->vdd);
> > +	}
> > +
> > +	ret = regulator_enable(adc->vdd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	adc->vref = devm_regulator_get(dev, "vref");
> > +	if (IS_ERR(adc->vref)) {
> 
> If this returns an error you have left the vref regulator on.
> 
> Unfortunately to keep things simple you'll need to have two
> separate callbacks for devm_add_action_or_reset, one for each
> of the regulators.
> 
> > +		dev_err(dev, "failed to get vref regulator\n");
> > +		return PTR_ERR(adc->vref);
> > +	}
> > +
> > +	ret = regulator_enable(adc->vref);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_add_action_or_reset(dev, max1241_disable_reg_action, adc);
> > +	if (ret) {
> > +		dev_err(dev, "could not set up regulator cleanup action!\n");
> > +		return ret;
> > +	}
> > +
> > +	adc->shdn = devm_gpiod_get_optional(dev, "shdn", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(adc->shdn))
> > +		return PTR_ERR(adc->shdn);
> > +
> > +	if (adc->shdn)
> > +		dev_dbg(dev, "shdn pin passed, low-power mode enabled");
> > +	else
> > +		dev_dbg(dev, "no shdn pin passed, low-power mode disabled");
> > +
> > +	indio_dev->name = spi_get_device_id(spi)->name;
> > +	indio_dev->dev.parent = dev;
> > +	indio_dev->info = &max1241_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = max1241_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(max1241_channels);
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static const struct spi_device_id max1241_id[] = {
> > +	{ "max1241", max1241 },
> > +	{}
> > +};
> > +
> > +static const struct of_device_id max1241_dt_ids[] = {
> > +	{ .compatible = "maxim,max1241" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, max1241_dt_ids);
> > +
> > +static struct spi_driver max1241_spi_driver = {
> > +	.driver = {
> > +		.name = "max1241",
> > +		.of_match_table = max1241_dt_ids,
> > +	},
> > +	.probe = max1241_probe,
> > +	.id_table = max1241_id,
> > +};
> > +module_spi_driver(max1241_spi_driver);
> > +
> > +MODULE_AUTHOR("Alexandru Lazar <alazar@startmail.com>");
> > +MODULE_DESCRIPTION("MAX1241 ADC driver");
> > +MODULE_LICENSE("GPL v2");
> 
