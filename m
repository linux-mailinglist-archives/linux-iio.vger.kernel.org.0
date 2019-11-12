Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F1F985C
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 19:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLSRh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 13:17:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39856 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfKLSRh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 13:17:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so13922177pfo.6;
        Tue, 12 Nov 2019 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qMsQt0jcDhpztgofcGsc5bCoKZDYwQPkmUyjgoLGTTY=;
        b=UsorXKwFTDchu+rJDaooN1/flhg3fQm1zt3MLjVuCwJrMc/E1PNVL+CbbX0rvQQvTn
         IQP03tY5FZtUJT0uqNRTD3nrjIQ2b2ghTVzKMESvxcuMMf3RGlm6xdSGB80chSvpgWHy
         nku96ThKfF4R7ud3KftdrlH9yVtBXGE22WMnKRLaSsucPm0Uw0ICD9CyxFGCdBvHoD1V
         zxUcyhUEv5AvldPYpmzmZQV35bAJWF+HDY0D92XJNQZhBwt1FSbS2CdbIe7xjK6sIPUb
         9B9F4QQqHe6//h3yX+mnhzoDl5nef2RL79NcU8Kh3760uf7lOopIsXSamd440mS07SbL
         CCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMsQt0jcDhpztgofcGsc5bCoKZDYwQPkmUyjgoLGTTY=;
        b=EtKAv4c472iZKyWSTX8tqyFaz8fTMDC8n3aWRtk0DLBQ9Al1r0z5xMxEp8PQ1U4Gbc
         5XywgGL6RhnVK5caTx+pnC5MJD1znzS9XeicZE8c57Y1Mtr+VjKVONoa/xx+XyLLRdeM
         khoIYqrananJhqsqME36RjkJ/GFb35Bljkw2rt9tta2f5vxaijfvkcMooRFw96mQcj6r
         YO3ND0Y9/hpwSe/MBGC+W1WusXnUtlnYqqb21kiNfxHIR5UQkLchfUWZziuDYcLmiKP9
         /icC1jyRg94I7myYrOBSwXif1ldTByHMRmyQSUJFz/wp1QiBO2ebVeHsl5HUJkFiOWA2
         qwwA==
X-Gm-Message-State: APjAAAXybVGyXUzceFNZ1zSndiSNDnMkzcGWKi4y7kQ5hG9YTwXdtN7F
        dMK8URIZUY2Rar85+OXiW+Q=
X-Google-Smtp-Source: APXvYqzWFl0fwfnP5V9iELX1LF8mgG8uUdjNjfApZBKEYqpEHOJNl1I3aU34lWcuJ3CDwogqiU5SKw==
X-Received: by 2002:a62:7b0e:: with SMTP id w14mr33280676pfc.177.1573582656395;
        Tue, 12 Nov 2019 10:17:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j126sm22387615pfg.4.2019.11.12.10.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 10:17:35 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:17:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Beniamin Bia <beniamin.bia@analog.com>, jic23@kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, paulmck@linux.ibm.com,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, biabeniamin@outlook.com,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 1/3] iio: Add ADM1177 Hot Swap Controller and Digital
 Power Monitor driver
Message-ID: <20191112181734.GA30127@roeck-us.net>
References: <20191112153552.27431-1-beniamin.bia@analog.com>
 <20191112173757.0000075b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112173757.0000075b@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 12, 2019 at 05:37:57PM +0000, Jonathan Cameron wrote:
> On Tue, 12 Nov 2019 17:35:50 +0200
> Beniamin Bia <beniamin.bia@analog.com> wrote:
> 
> > From: Michael Hennerich <michael.hennerich@analog.com>
> > 
> > ADM1177 is a Hot Swap Controller and Digital Power Monitor with
> > Soft Start Pin.
> > 
> > Datasheet:
> > Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> > 
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
> > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> 
> Hi Beniamin,
> 
> A couple immediate thoughts.
> 
> 1. That cc list has some rather non obvious people on it.  Unless something
>    fairly surprising is going on, probably better to cut it back a bit.
> 
> 2. Why IIO?  Not entirely obvious to me.  From first glance this is definitely
>    doing hardware monitoring.  If there is a reason there should be a clear
>    statement here on why.
> 

I don't see why this is implemented as iio driver. I think it should be implemented
as hardware monitoring driver.

Some more comments below.

Guenter

> +CC Guenter and Jean as hwmon maintainers.
> 
> Whilst I'm here, a very quick review below.
> 
> > ---
> >  drivers/iio/adc/Kconfig   |  12 ++
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/adm1177.c | 257 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 270 insertions(+)
> >  create mode 100644 drivers/iio/adc/adm1177.c
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 9554890a3200..4db8c6dcb595 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -228,6 +228,18 @@ config ASPEED_ADC
> >  	  To compile this driver as a module, choose M here: the module will be
> >  	  called aspeed_adc.
> >  
> > +config ADM1177
> > +	tristate "Analog Devices ADM1177 Digital Power Monitor driver"
> > +	depends on I2C
> > +	help
> > +	  Say yes here to build support for Analog Devices:
> > +	  ADM1177 Hot Swap Controller and Digital Power Monitor
> > +	  with Soft Start Pin. Provides direct access
> > +	  via sysfs.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called adm1177.
> > +
> >  config AT91_ADC
> >  	tristate "Atmel AT91 ADC"
> >  	depends on ARCH_AT91
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 5ecc481c2967..7899d6a158f3 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -24,6 +24,7 @@ obj-$(CONFIG_AD7887) += ad7887.o
> >  obj-$(CONFIG_AD7949) += ad7949.o
> >  obj-$(CONFIG_AD799X) += ad799x.o
> >  obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
> > +obj-$(CONFIG_ADM1177) += adm1177.o
> >  obj-$(CONFIG_AT91_ADC) += at91_adc.o
> >  obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
> >  obj-$(CONFIG_AXP20X_ADC) += axp20x_adc.o
> > diff --git a/drivers/iio/adc/adm1177.c b/drivers/iio/adc/adm1177.c
> > new file mode 100644
> > index 000000000000..daec34566a65
> > --- /dev/null
> > +++ b/drivers/iio/adc/adm1177.c
> > @@ -0,0 +1,257 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ADM1177 Hot Swap Controller and Digital Power Monitor with Soft Start Pin
> > + *
> > + * Copyright 2015-2019 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/events.h>
> > +
> > +/*  Command Byte Operations */
> > +#define ADM1177_CMD_V_CONT	BIT(0)
> > +#define ADM1177_CMD_V_ONCE	BIT(1)
> > +#define ADM1177_CMD_I_CONT	BIT(2)
> > +#define ADM1177_CMD_I_ONCE	BIT(3)
> > +#define ADM1177_CMD_VRANGE	BIT(4)
> > +#define ADM1177_CMD_STATUS_RD	BIT(6)
> > +
> > +/* Extended Register */
> > +#define ADM1177_REG_ALERT_EN	1
> > +#define ADM1177_REG_ALERT_TH	2
> > +#define ADM1177_REG_CONTROL	3
> > +
> > +/* ADM1177_REG_ALERT_EN */
> > +#define ADM1177_EN_ADC_OC1	BIT(0)
> > +#define ADM1177_EN_ADC_OC4	BIT(1)
> > +#define ADM1177_EN_HS_ALERT	BIT(2)
> > +#define ADM1177_EN_OFF_ALERT	BIT(3)
> > +#define ADM1177_CLEAR		BIT(4)
> > +
> > +/* ADM1177_REG_CONTROL */
> > +#define ADM1177_SWOFF		BIT(0)
> > +
> > +#define ADM1177_BITS		12
> > +
> > +/**
> > + * struct adm1177_state - driver instance specific data
> > + * @client		pointer to i2c client
> > + * @reg			regulator info for the the power supply of the device
> > + * @command		internal control register
> > + * @r_sense_uohm	current sense resistor value
> > + * @alert_threshold_ua	current limit for shutdown
> > + * @vrange_high		internal voltage divider
> > + */
> > +struct adm1177_state {
> > +	struct i2c_client	*client;
> > +	struct regulator	*reg;
> > +	u8			command;
> > +	u32			r_sense_uohm;
> > +	u32			alert_threshold_ua;
> > +	bool			vrange_high;
> > +};
> > +
> > +static int adm1177_read(struct adm1177_state *st, u8 num, u8 *data)
> > +{
> > +	struct i2c_client *client = st->client;
> > +	int ret = 0;
> > +
> > +	ret = i2c_master_recv(client, data, num);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "I2C read error\n");

Seems a bit noisy (and inconsistent). It would make much more sense to
report the error to userspace instead of ignoring it and reporting a random
value (ie the stack content).

> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adm1177_write_cmd(struct adm1177_state *st, u8 cmd)
> > +{
> > +	st->command = cmd;
> > +	return i2c_smbus_write_byte(st->client, cmd);
> > +}
> > +
> > +static int adm1177_write_reg(struct adm1177_state *st, u8 reg, u8 val)
> > +{
> > +	return i2c_smbus_write_byte_data(st->client, reg, val);
> 
> These wrappers don't really add anything.  I'd just make the i2c
> calls directly inline. They will be self explanatory.
> 

Plus, their return value is never checked.

> > +}
> > +
> > +static int adm1177_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val,
> > +			   int *val2,
> > +			   long mask)
> > +{
> > +	struct adm1177_state *st = iio_priv(indio_dev);
> > +	u8 data[3];
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		adm1177_read(st, 3, data);
> > +		switch (chan->type) {
> > +		case IIO_VOLTAGE:
> > +			*val = (data[0] << 4) | (data[2] >> 4);
> > +			return IIO_VAL_INT;
> > +		case IIO_CURRENT:
> > +			*val = (data[1] << 4) | (data[2] & 0xF);
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_VOLTAGE:
> > +			if (st->command & ADM1177_CMD_VRANGE)
> > +				*val = 6650;
> > +			else
> > +				*val = 26350;
> > +
> > +			*val2 = ADM1177_BITS;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
> > +		case IIO_CURRENT:
> > +			*val = 105840 / st->r_sense_uohm;
> > +
> > +			*val2 = ADM1177_BITS;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_chan_spec adm1177_channels[] = {
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.indexed = 1,
> > +		.channel = 0,
> > +	},
> > +	{
> > +		.type = IIO_CURRENT,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.indexed = 1,
> > +		.channel = 0,
> > +	},
> > +};
> > +
> > +static const struct iio_info adm1177_info = {
> > +	.read_raw = &adm1177_read_raw,
> > +};
> 
> blank line here.
> 
> > +static void adm1177_remove(void *data)
> > +{
> > +	struct adm1177_state *st = data;
> > +
> > +	if (st->reg)
> > +		regulator_disable(st->reg);
> 
> Probe and remove should be mirror images of each other.
> As you have a mixture of managed and non managed calls that
> isn't the case here.
> 
> devm_add_action_or_reset will sort this out for you if
> used to turn off the regulator at the right point on removal.
> 

On top of that, this function is added with devm_add_action_or_reset(),
and it is only ever called if st->reg is not NULL.

> > +}
> > +
> > +static int adm1177_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	int ret;
> > +	struct device_node *np;
> > +	struct adm1177_state *st;
> > +	struct iio_dev *indio_dev;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	st->client = client;
> > +
> > +	np = client->dev.of_node;
> > +
> > +	st->reg = devm_regulator_get_optional(&client->dev, "vref");
> > +	if (IS_ERR(st->reg)) {
> > +		if (PTR_ERR(st->reg) == EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +
> > +		st->reg = NULL;
> > +	} else {
> > +		ret = regulator_enable(st->reg);
> > +		if (ret)
> > +			return ret;
> > +		ret = devm_add_action_or_reset(&client->dev, adm1177_remove,
> > +					       st);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	of_property_read_u32(np, "adi,r-sense-micro-ohms", &st->r_sense_uohm);

shunt-resistor-micro-ohms

> > +	of_property_read_u32(np, "adi,shutdown-threshold-microamp",
> > +			     &st->alert_threshold_ua);
> > +	st->vrange_high = of_property_read_bool(np,
> > +				"adi,vrange-high-enable");
> > +	if (st->alert_threshold_ua) {
> > +		unsigned int val;
> > +
> > +		val = (st->alert_threshold_ua * st->r_sense_uohm * 0xFF);
> > +		val /= 105840000U;
> > +		if (val > 0xFF) {
> > +			dev_err(&client->dev,
> > +				"Requested shutdown current %d uA above limit\n",
> > +				st->alert_threshold_ua);
> > +
> > +			val = 0xFF;
> > +		}
> > +		adm1177_write_reg(st, ADM1177_REG_ALERT_TH, val);
> > +	}
> > +
> > +	adm1177_write_cmd(st, ADM1177_CMD_V_CONT |
> > +			      ADM1177_CMD_I_CONT |
> > +			      (st->vrange_high ? 0 : ADM1177_CMD_VRANGE));
> > +
> > +	indio_dev->name = id->name;
> > +	indio_dev->channels = adm1177_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(adm1177_channels);
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->info = &adm1177_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static const struct i2c_device_id adm1177_ids[] = {
> > +	{ "adm1177", 0 },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, adm1177_ids);
> > +
> > +static const struct of_device_id adm1177_dt_ids[] = {
> > +	{ .compatible = "adi,adm1177" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, adm1177_dt_ids);
> > +
> > +static struct i2c_driver adm1177_driver = {
> > +	.driver = {
> > +		.name = "adm1177",
> > +		.of_match_table = adm1177_dt_ids,
> > +	},
> > +	.probe = adm1177_probe,
> > +	.id_table = adm1177_ids,
> > +};
> > +module_i2c_driver(adm1177_driver);
> > +
> > +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> > +MODULE_DESCRIPTION("Analog Devices ADM1177 ADC driver");
> > +MODULE_LICENSE("GPL v2");
> 
> 
