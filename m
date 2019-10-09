Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3AD0BA8
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2019 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfJIJpg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Oct 2019 05:45:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35109 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbfJIJpf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Oct 2019 05:45:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so1284278pfw.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Oct 2019 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TlxMmmyE8JkeV2ooiODQQmX/uuD09TXvS7GyX1ZOprY=;
        b=sF6fRa7qbH7zIKhrHhf3BGhBhB+zZF0wUayYlD8ALa4CERvlqmNWSEiI6/IHu74c5K
         PdNWEpD3nSN7wk3AfBFGkx8TcAOj5/yYB0NJ9kj8eSNqF7TgawIdUYLKsKwJ+qnFvwZg
         ekXZ07uTcP0yFRYgWif9XWrh6WidV+Qt3/Kpb9yMXtkAuecxBsoQjuCQAn29s0YNy7Kf
         esPjh67hjXB1CCBjAUx2pZiZyuYelktz7iumxSA0lHKG2kZO3UVW+LIIt+fjIeMJ81lM
         Hz3ehTJPzknn0YdZlSccw34TzdXIR0weyScWv2xxvf5p+XSJhbx1wyxPJ+XeyB6lXyU+
         GC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlxMmmyE8JkeV2ooiODQQmX/uuD09TXvS7GyX1ZOprY=;
        b=VjjcGHuEwRcJadTwyNu4PFmGwTz9DgJkcYjfHu0R/5b4oKGqQjLooqYD9pRNL3ExSI
         yD7suSsE68FTyFQIglFEw5cWJgDhjeF4ecu7VT2j1ykbbdb2HVpmj3wbSJCrkmxa6uTo
         DR74q6Ljpt6Lz+nbcC4zBBrfzBMzmM/C/GN2kKucSYbLFKIHbibQpgVx17V+Z2PG4ztX
         uGlPzxH0ppYZaC8nkeyoopXFy4FsOoOb1uxId9C4of0fUtkSTA07mr1fm7F1Sb6mKUOE
         WqXLquTFlf5TvTFff4JH/uNAuvcfEV2EIb64QQwztSMUUHWy0yq1Qs+FaQgbQl8yR9or
         3H7Q==
X-Gm-Message-State: APjAAAV8nnYo6PEmAFDvu+4r/LeqynGS83mGtLETHCX80EivjARg3AGU
        5jRqRYC4Ls6jcj7nolHCQ98m
X-Google-Smtp-Source: APXvYqyOg/U+trfPLP+BDi945VlsbVFXTSpeY45wIEXda52GydCUZ5+9LSRcc1rxJREwJAh4H+20/g==
X-Received: by 2002:a63:287:: with SMTP id 129mr3335661pgc.190.1570614333608;
        Wed, 09 Oct 2019 02:45:33 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([103.59.132.163])
        by smtp.gmail.com with ESMTPSA id 192sm3255090pfb.110.2019.10.09.02.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 02:45:32 -0700 (PDT)
Date:   Wed, 9 Oct 2019 15:15:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for ADUX1020 sensor
Message-ID: <20191009094524.GA17962@Mani-XPS-13-9360>
References: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
 <20191007101027.8383-3-manivannan.sadhasivam@linaro.org>
 <30c4a0f9aff5a40879d6839ad8a5ce40565f0923.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30c4a0f9aff5a40879d6839ad8a5ce40565f0923.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Ardelean,

Thanks for the quick review!

On Tue, Oct 08, 2019 at 06:52:50AM +0000, Ardelean, Alexandru wrote:
> On Mon, 2019-10-07 at 15:40 +0530, Manivannan Sadhasivam wrote:
> > [External]
> > 
> 
> Hey,
> 
> Comments inline.
> 
> I thought I sent an initial review, but seems to have gotten lost [maybe in
> my email client].
> Oh well. I managed to re-do it anyway.
> 
> I tried to group them this time.
> 
> The more prominent part is [3]; this driver needs a bit more error checking
> on regmap_() returns.
> 

Yes, agree. I forgot that I'm not working on memory mapped region ;-)

> Generally some notes:
> - Is there a need to implement the 32Khz or 32Mhz clock calibration
> routines on startup? Some drivers need this, some don't/

Calibration is required to have the precise reading but it is not a blocker.
We can add it later.

> - From the functional diagram, it looks like maybe the VREF would be needed
> to be hooked via a regulator framework; but this could be done later

Right but the reference board schematics is not very clear about VREF and
neither the sensor datasheet. That's why I intentionally left it. Will get
in touch with the board vendor to figure out what is the recommended VREF
voltage and submit a patch later.

> - Just curios here: there is gesture mode as well; will that be implemented
> later? Or will there be other modes implemented?

Currently only proximity mode is implemented. There are gesture and sample
modes and I left those as a TODO. But I'm not sure whether IIO is supporting
gesture mode properly or not.

> 
> If I remember anything else I may come back with a reply.
> 

Sure.

> Thanks
> Alex
> 
> > Add initial support for Analog Devices ADUX1020 Photometric sensor.
> > Only proximity mode has been enabled for now.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/iio/light/Kconfig    |  11 +
> >  drivers/iio/light/Makefile   |   1 +
> >  drivers/iio/light/adux1020.c | 783 +++++++++++++++++++++++++++++++++++
> 
> Does MAINTAINERS need updating as well?
> 

I don't prefer to have MAINTAINERS entry for small drivers like this.
Anyway, get_maintainers will return my mailing address based on the
commit signing.

> >  3 files changed, 795 insertions(+)
> >  create mode 100644 drivers/iio/light/adux1020.c
> > 
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 08d7e1ef2186..3f8c8689cd89 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -32,6 +32,17 @@ config ADJD_S311
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called adjd_s311.
> >  
> > +config ADUX1020
> > +	tristate "ADUX1020 photometric sensor"
> > +	select REGMAP_I2C
> > +	depends on I2C
> > +	help
> > +	 Say Y here if you want to build a driver for the Analog Devices
> > +	 ADUX1020 photometric sensor.
> > +
> > +	 To compile this driver as a module, choose M here: the
> > +	 module will be called adux1020.
> > +
> >  config AL3320A
> >  	tristate "AL3320A ambient light sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index 00d1f9b98f39..5d650ce46a40 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -6,6 +6,7 @@
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_ACPI_ALS)		+= acpi-als.o
> >  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
> > +obj-$(CONFIG_ADUX1020)		+= adux1020.o
> >  obj-$(CONFIG_AL3320A)		+= al3320a.o
> >  obj-$(CONFIG_APDS9300)		+= apds9300.o
> >  obj-$(CONFIG_APDS9960)		+= apds9960.o
> > diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> > new file mode 100644
> > index 000000000000..d0b76e5b44f1
> > --- /dev/null
> > +++ b/drivers/iio/light/adux1020.c
> > @@ -0,0 +1,783 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * adux1020.c - Support for Analog Devices ADUX1020 photometric sensor
> 
> Maybe drop the adux1020.c part?
> I think something like this should be sufficient:
> "Analog Devices ADUX1020 photometric sensor"
>

okay.

> > + *
> > + * Copyright (C) 2019 Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > + *
> > + * TODO: Triggered buffer support
> 
> Maybe drop the TODO?
> It's not needed for mainline.
>

It is not needed but it can be added. TODO is required to explicitly
mention what are all left in the driver which can be picked up by the
community. So I prefer to keep it.
 
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/events.h>
> > +
> > +#define ADUX1020_REGMAP_NAME		"adux1020_regmap"
> > +#define ADUX1020_DRV_NAME		"adux1020"
> > +
> > +/* System registers */
> > +#define ADUX1020_REG_CHIP_ID		0x08
> > +#define ADUX1020_REG_SLAVE_ADDRESS	0x09
> > +
> > +#define ADUX1020_REG_SW_RESET		0x0f
> > +#define ADUX1020_REG_INT_ENABLE		0x1c
> > +#define ADUX1020_REG_INT_POLARITY	0x1d
> > +#define ADUX1020_REG_PROX_TH_ON1	0x2a
> > +#define ADUX1020_REG_PROX_TH_OFF1	0x2b
> > +#define	ADUX1020_REG_PROX_TYPE		0x2f
> > +#define	ADUX1020_REG_TEST_MODES_3	0x32
> > +#define	ADUX1020_REG_FORCE_MODE		0x33
> > +#define	ADUX1020_REG_FREQUENCY		0x40
> > +#define ADUX1020_REG_LED_CURRENT	0x41
> > +#define	ADUX1020_REG_OP_MODE		0x45
> > +#define	ADUX1020_REG_INT_MASK		0x48
> > +#define	ADUX1020_REG_INT_STATUS		0x49
> > +#define	ADUX1020_REG_DATA_BUFFER	0x60
> > +
> > +/* Chip ID bits */
> > +#define ADUX1020_CHIP_ID_MASK		GENMASK(11, 0)
> > +#define ADUX1020_CHIP_ID		0x03fc
> > +
> > +#define ADUX1020_MODE_OUT_SHIFT		4
> 
> I'm seeing a few _SHIFT macros.
> Maybe use the FIELD_PREP() macro where possible? [1]
> 

okay.

> > +#define ADUX1020_MODE_OUT_PROX_I	1
> > +#define ADUX1020_MODE_OUT_PROX_XY	3
> > +
> > +#define ADUX1020_SW_RESET		BIT(1)
> > +#define ADUX1020_FIFO_FLUSH		BIT(15)
> > +#define ADUX1020_OP_MODE_MASK		GENMASK(3, 0)
> > +#define ADUX1020_DATA_OUT_MODE_MASK	GENMASK(7, 4)
> > +
> > +#define ADUX1020_MODE_INT_MASK		GENMASK(7, 0)
> > +#define ADUX1020_INT_ENABLE		0x2096
> > +#define ADUX1020_INT_DISABLE		0x2090
> > +#define ADUX1020_PROX_INT_ENABLE	0x00f0
> > +#define ADUX1020_PROX_ON1_INT		BIT(0)
> > +#define ADUX1020_PROX_OFF1_INT		BIT(1)
> > +#define ADUX1020_FIFO_INT_ENABLE	0x7f
> > +#define ADUX1020_MODE_INT_DISABLE	0xff
> > +#define ADUX1020_MODE_INT_STATUS_MASK	GENMASK(7, 0)
> > +#define ADUX1020_FIFO_STATUS_MASK	GENMASK(15, 8)
> > +#define ADUX1020_PROX_TYPE		BIT(15)
> > +
> > +#define ADUX1020_INT_PROX_ON1		BIT(0)
> > +#define ADUX1020_INT_PROX_OFF1		BIT(1)
> > +
> > +#define	ADUX1020_FORCE_CLOCK_ON		0x0f4f
> > +#define	ADUX1020_FORCE_CLOCK_RESET	0x0040
> 
> nitpick: indentation seems inconsistent here
> 

will fix it.

> > +#define ADUX1020_ACTIVE_4_STATE		0x0008
> > +
> > +#define ADUX1020_PROX_FREQ_MASK		GENMASK(7, 4)
> > +#define ADUX1020_PROX_FREQ_SHIFT	4
> 
> Same as [1]. Maybe use FIELD_PREP() together with ADUX1020_PROX_FREQ_MASK?
> See other examples, but we sometimes use them as:
> 
> #define ADUX_PROX_FREQ_SET(x)    FIELD_PREP(ADUX1020_PROX_FREQ_MASK, (x))
> 

okay.

> > +
> > +#define ADUX1020_LED_CURRENT_MASK	GENMASK(3, 0)
> > +#define ADUX1020_LED_PIREF_EN		BIT(12)
> > +
> > +/* Operating modes */
> > +enum adux1020_op_modes {
> > +	ADUX1020_MODE_STANDBY,
> > +	ADUX1020_MODE_PROX_I,
> > +	ADUX1020_MODE_PROX_XY,
> > +	ADUX1020_MODE_GEST,
> > +	ADUX1020_MODE_SAMPLE,
> > +	ADUX1020_MODE_FORCE = 0x0e,
> > +	ADUX1020_MODE_IDLE = 0x0f,
> > +};
> > +
> > +struct adux1020_data {
> > +	struct i2c_client *client;
> > +	struct iio_dev *indio_dev;
> > +	struct mutex lock;
> > +	struct regmap *regmap;
> > +};
> > +
> > +struct adux1020_mode_data {
> > +	u8 bytes;
> > +	u8 buf_len;
> > +	u16 int_en;
> > +};
> > +
> > +static const struct adux1020_mode_data adux1020_modes[] = {
> > +	[ADUX1020_MODE_PROX_I] = {
> > +		.bytes = 2,
> > +		.buf_len = 1,
> > +		.int_en = ADUX1020_PROX_INT_ENABLE,
> > +	},
> > +};
> > +
> > +static const struct regmap_config adux1020_regmap_config = {
> > +	.name = ADUX1020_REGMAP_NAME,
> > +	.reg_bits = 8,
> > +	.val_bits = 16,
> > +	.max_register = 0x6F,
> > +	.cache_type = REGCACHE_NONE,
> > +};
> > +
> > +static const int adux1020_def_conf[][2] = {
> 
> Maybe use "struct reg_sequence" here?[2]
> You could then use "regmap_multi_reg_write()"
> 

ack.

> > +	{ 0x000c, 0x000f },
> > +	{ 0x0010, 0x1010 },
> > +	{ 0x0011, 0x004c },
> > +	{ 0x0012, 0x5f0c },
> > +	{ 0x0013, 0xada5 },
> > +	{ 0x0014, 0x0080 },
> > +	{ 0x0015, 0x0000 },
> > +	{ 0x0016, 0x0600 },
> > +	{ 0x0017, 0x0000 },
> > +	{ 0x0018, 0x2693 },
> > +	{ 0x0019, 0x0004 },
> > +	{ 0x001a, 0x4280 },
> > +	{ 0x001b, 0x0060 },
> > +	{ 0x001c, 0x2094 },
> > +	{ 0x001d, 0x0020 },
> > +	{ 0x001e, 0x0001 },
> > +	{ 0x001f, 0x0100 },
> > +	{ 0x0020, 0x0320 },
> > +	{ 0x0021, 0x0A13 },
> > +	{ 0x0022, 0x0320 },
> > +	{ 0x0023, 0x0113 },
> > +	{ 0x0024, 0x0000 },
> > +	{ 0x0025, 0x2412 },
> > +	{ 0x0026, 0x2412 },
> > +	{ 0x0027, 0x0022 },
> > +	{ 0x0028, 0x0000 },
> > +	{ 0x0029, 0x0300 },
> > +	{ 0x002a, 0x0700 },
> > +	{ 0x002b, 0x0600 },
> > +	{ 0x002c, 0x6000 },
> > +	{ 0x002d, 0x4000 },
> > +	{ 0x002e, 0x0000 },
> > +	{ 0x002f, 0x0000 },
> > +	{ 0x0030, 0x0000 },
> > +	{ 0x0031, 0x0000 },
> > +	{ 0x0032, 0x0040 },
> > +	{ 0x0033, 0x0008 },
> > +	{ 0x0034, 0xE400 },
> > +	{ 0x0038, 0x8080 },
> > +	{ 0x0039, 0x8080 },
> > +	{ 0x003a, 0x2000 },
> > +	{ 0x003b, 0x1f00 },
> > +	{ 0x003c, 0x2000 },
> > +	{ 0x003d, 0x2000 },
> > +	{ 0x003e, 0x0000 },
> > +	{ 0x0040, 0x8069 },
> > +	{ 0x0041, 0x1f2f },
> > +	{ 0x0042, 0x4000 },
> > +	{ 0x0043, 0x0000 },
> > +	{ 0x0044, 0x0008 },
> > +	{ 0x0046, 0x0000 },
> > +	{ 0x0048, 0x00ef },
> > +	{ 0x0049, 0x0000 },
> > +	{ 0x0045, 0x0000 },
> > +};
> > +
> > +static const int adux1020_rate[][2] = {
> > +	{ 0, 100000 },
> > +	{ 0, 200000 },
> > +	{ 0, 500000 },
> > +	{ 1, 0 },
> > +	{ 2, 0 },
> > +	{ 5, 0 },
> > +	{ 10, 0 },
> > +	{ 20, 0 },
> > +	{ 50, 0 },
> > +	{ 100, 0 },
> > +	{ 190, 0 },
> > +	{ 450, 0 },
> > +	{ 820, 0 },
> > +	{ 1400, 0 },
> > +};
> > +
> > +static const int adux1020_led_current[][2] = {
> > +	{ 0, 25000 },
> > +	{ 0, 40000 },
> > +	{ 0, 55000 },
> > +	{ 0, 70000 },
> > +	{ 0, 85000 },
> > +	{ 0, 100000 },
> > +	{ 0, 115000 },
> > +	{ 0, 130000 },
> > +	{ 0, 145000 },
> > +	{ 0, 160000 },
> > +	{ 0, 175000 },
> > +	{ 0, 190000 },
> > +	{ 0, 205000 },
> > +	{ 0, 220000 },
> > +	{ 0, 235000 },
> > +	{ 0, 250000 },
> > +};
> > +
> > +static void adux1020_flush_fifo(struct adux1020_data *data)
> > +{
> > +	/* Force Idle mode */
> > +	regmap_write(data->regmap, ADUX1020_REG_FORCE_MODE,
> > +		     ADUX1020_ACTIVE_4_STATE);
> > +	regmap_update_bits(data->regmap, ADUX1020_REG_OP_MODE,
> > +			   ADUX1020_OP_MODE_MASK, ADUX1020_MODE_FORCE);
> > +	regmap_update_bits(data->regmap, ADUX1020_REG_OP_MODE,
> > +			   ADUX1020_OP_MODE_MASK, ADUX1020_MODE_IDLE);
> > +
> > +	/* Flush FIFO */
> > +	regmap_write(data->regmap, ADUX1020_REG_TEST_MODES_3,
> > +		     ADUX1020_FORCE_CLOCK_ON);
> > +	regmap_write(data->regmap, ADUX1020_REG_INT_STATUS,
> > +		     ADUX1020_FIFO_FLUSH);
> > +	regmap_write(data->regmap, ADUX1020_REG_TEST_MODES_3,
> > +		     ADUX1020_FORCE_CLOCK_RESET);
> 
> These bits could use with some minimal error checking.[3]
> Maybe also convert to return int and check errors.
> 

Yes, I will added error check in relevant places.

> > +}
> > +
> > +static int adux1020_read_fifo(struct adux1020_data *data, u16 *buf, u8
> > buf_len)
> > +{
> > +	int i, ret = -EINVAL;
> > +	unsigned int regval;
> > +
> > +	/* Enable 32MHz clock */
> > +	regmap_write(data->regmap, ADUX1020_REG_TEST_MODES_3,
> > +		     ADUX1020_FORCE_CLOCK_ON);
> 
> This looks weird [the FORCE_CLOCK_ON], but it is what the datasheet says.
> Also, related to [3]: some error checking this return would be useful.
> 

ack.

> > +
> > +	for (i = 0; i < buf_len; i++) {
> > +		ret = regmap_read(data->regmap, ADUX1020_REG_DATA_BUFFER,
> > +				      &regval);
> > +		if (ret < 0)
> > +			goto err_out;
> > +
> > +		buf[i] = regval;
> > +	}
> > +
> > +	/* Set 32MHz clock to be controlled by internal state machine */
> > +	regmap_write(data->regmap, ADUX1020_REG_TEST_MODES_3,
> > +		     ADUX1020_FORCE_CLOCK_RESET);
> > +
> > +err_out:
> > +	return ret;
> > +}
> > +
> > +static void adux1020_set_mode(struct adux1020_data *data,
> > +			      enum adux1020_op_modes mode)
> > +{
> > +	/* Switch to standby mode before changing the mode */
> > +	regmap_write(data->regmap, ADUX1020_REG_OP_MODE,
> > ADUX1020_MODE_STANDBY);
> 
> [3] error checking maybe? and maybe int return?
> 

ack.

> > +
> > +	/* Set data out and switch to the desired mode */
> > +	if (mode == ADUX1020_MODE_PROX_I) {
> 
> This could become a switch() statement, so that when/if other modes get
> added, the patch looks cleaner.
> 

okay.

> > +		regmap_update_bits(data->regmap, ADUX1020_REG_OP_MODE,
> > +			ADUX1020_DATA_OUT_MODE_MASK,
> > +			ADUX1020_MODE_OUT_PROX_I <<
> > ADUX1020_MODE_OUT_SHIFT);
> 
> Related to [1]: a FIELD_PREP() macro would be useful.
> 

okay.

> > +		regmap_update_bits(data->regmap, ADUX1020_REG_OP_MODE,
> > +			ADUX1020_OP_MODE_MASK, ADUX1020_MODE_PROX_I);
> > +	}
> > +}
> > +
> > +static int adux1020_measure(struct adux1020_data *data,
> > +			    enum adux1020_op_modes mode,
> > +			    u16 *val)
> > +{
> > +	int ret, tries = 50;
> > +	unsigned int status;
> > +
> > +	mutex_lock(&data->lock);
> 
> The scope of this lock looks like it would need to be extended a bit.
> See [4] on some more notes for this.
> 
> > +
> > +	/* Disable INT pin as polling is going to be used */
> > +	regmap_write(data->regmap, ADUX1020_REG_INT_ENABLE,
> > +		     ADUX1020_INT_DISABLE);
> > +
> > +	/* Enable mode interrupt */
> > +	regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
> > +			   ADUX1020_MODE_INT_MASK,
> > +			   adux1020_modes[mode].int_en);
> 
> [3] maybe some more error checking?
> 

ack.

> > +
> > +	while (tries--) {
> > +		ret = regmap_read(data->regmap, ADUX1020_REG_INT_STATUS,
> > +				  &status);
> > +		if (ret < 0)
> > +			goto fail;
> > +
> > +		status &= ADUX1020_FIFO_STATUS_MASK;
> > +		if (status >= adux1020_modes[mode].bytes)
> > +			break;
> > +		msleep(20);
> > +	}
> > +
> > +	if (tries < 0) {
> > +		ret = -EIO;
> > +		goto fail;
> > +	}
> > +
> 
> Regarding [8], the buffer is passed from adux1020_read_raw(), so maybe just
> move the buffer here, since the information about size is near the buffer
> definition.
> Then do *val = buf[0];
> 

I don't see any benefit from this. As said below, the buffer size is fixed
and is based on the maximum hardware FIFO size. It goes upto 6 bytes
(3-16bit words).

> > +	ret = adux1020_read_fifo(data, val, adux1020_modes[mode].buf_len);
> > +	if (ret < 0)
> > +		goto fail;
> > +
> > +	/* Clear mode interrupt */
> > +	regmap_write(data->regmap, ADUX1020_REG_INT_STATUS,
> > +			   (~adux1020_modes[mode].int_en));
> > +	/* Disable mode interrupts */
> > +	regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
> > +			   ADUX1020_MODE_INT_MASK,
> > ADUX1020_MODE_INT_DISABLE);
> > +
> > +fail:
> > +	mutex_unlock(&data->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int adux1020_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long mask)
> > +{
> > +	struct adux1020_data *data = iio_priv(indio_dev);
> > +	u16 buf[3];
> 
> This buffer looks a bit weird. [8]
> It's 3 elements-wide and passed without any information about size.
> And only the first element is used.
> So, maybe just convert u16 buf[3] -> u16 buf?
> 

The buffer declaration is based on the hardware buffer available. It
is 3 elements wide since the remaining 2 elements will be used by other
modes. The idea here is to reuse the adux1020_measure() API for all 3
modes (which has varying buffer sizes).

> > +	int ret = -EINVAL;
> > +	unsigned int regval;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
> > +			ret = adux1020_measure(data, ADUX1020_MODE_PROX_I,
> > buf);
> 
> Regarding [4]: I'm thinking that the lock could be extended to
> adux1020_{read,write}_raw() & adux1020_{read,write}_event_config()
> functions, especialy [or only in places] where functions seem to do
> consecutive R/W ops.
> 

okay.

> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			*val = buf[0];
> > +			ret = IIO_VAL_INT;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		switch (chan->type) {
> > +		case IIO_CURRENT:
> > +			ret = regmap_read(data->regmap,
> > +					  ADUX1020_REG_LED_CURRENT,
> > &regval);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			regval = regval & ADUX1020_LED_CURRENT_MASK;
> > +
> > +			*val = adux1020_led_current[regval][0];
> > +			*val2 = adux1020_led_current[regval][1];
> > +
> > +			ret = IIO_VAL_INT_PLUS_MICRO;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			ret = regmap_read(data->regmap,
> > ADUX1020_REG_FREQUENCY,
> > +					  &regval);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			regval = (regval & ADUX1020_PROX_FREQ_MASK) >>
> > +				  ADUX1020_PROX_FREQ_SHIFT;
> 
> Related to [1]: a FIELD_PREP() macro would be useful.
> 

ack.

> > +
> > +			*val = adux1020_rate[regval][0];
> > +			*val2 = adux1020_rate[regval][1];
> > +
> > +			ret = IIO_VAL_INT_PLUS_MICRO;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +};
> > +
> > +static int adux1020_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long mask)
> > +{
> > +	struct adux1020_data *data = iio_priv(indio_dev);
> > +	int i, ret = -EINVAL;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		if (chan->type == IIO_PROXIMITY) {
> > +			for (i = 0; i < ARRAY_SIZE(adux1020_rate); i++) {
> > +				if ((val == adux1020_rate[i][0]) &&
> > +				     (val2 == adux1020_rate[i][1])) {
> > +					ret = regmap_update_bits(data-
> > >regmap,
> > +						ADUX1020_REG_FREQUENCY,
> > +						ADUX1020_PROX_FREQ_MASK,
> > +						i <<
> > ADUX1020_PROX_FREQ_SHIFT);
> > +				}
> > +			}
> 
> [5] This looks as it has too many level of indentations.
> And could be reworked with either using the "find_closest()" macro, or at
> least split into a helper that finds the index in the "adux1020_rate" array
> based on val & val2.
> 
> Then you get something like:
> ------------------------------------------------------------
> i = adux1020_find_index(adux1020_rate, val, val2);
> if (i < 0)
>     return i;
> 
> return regmap_update_bits(data->regmap,
>                           ADUX1020_REG_FREQUENCY,
>                           ADUX1020_PROX_FREQ_SET(i));
> ------------------------------------------------------------
> 

good idea! will implement.

> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		if (chan->type == IIO_CURRENT) {
> > +			for (i = 0; i < ARRAY_SIZE(adux1020_led_current);
> > i++) {
> > +				if ((val == adux1020_led_current[i][0]) &&
> > +				     (val2 == adux1020_led_current[i][1]))
> > {
> > +					ret = regmap_update_bits(data-
> > >regmap,
> > +						ADUX1020_REG_LED_CURRENT,
> > +						ADUX1020_LED_CURRENT_MASK,
> > i);
> > +				}
> > +			}
> 
> Same comment as [5]
> 
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int adux1020_write_event_config(struct iio_dev *indio_dev,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir, int state)
> > +{
> > +	struct adux1020_data *data = iio_priv(indio_dev);
> > +
> > +	regmap_write(data->regmap, ADUX1020_REG_INT_ENABLE,
> > +		     ADUX1020_INT_ENABLE);
> > +
> 
> Regarding [4]: it looks like the lock could be useful here.
> Regarding [3]: more error checking could be useful.
> 
> 
> > +	regmap_write(data->regmap, ADUX1020_REG_INT_POLARITY, 0);
> > +
> > +	switch (chan->type) {
> > +	case IIO_PROXIMITY:
> > +		if (dir == IIO_EV_DIR_RISING) {
> > +			regmap_update_bits(data->regmap,
> > ADUX1020_REG_INT_MASK,
> > +					   ADUX1020_PROX_ON1_INT,
> > +					   state ? 0 :
> > ADUX1020_PROX_ON1_INT);
> > +		} else {
> > +			regmap_update_bits(data->regmap,
> > ADUX1020_REG_INT_MASK,
> > +					   ADUX1020_PROX_OFF1_INT,
> > +					   state ? 0 :
> > ADUX1020_PROX_OFF1_INT);
> > +		}
> 
> [6] More about style/preference.
> I like the part in adux1020_read_event_config(), where
> 
> -------------------------------------------------
>   if (dir == IIO_EV_DIR_RISING)
>       mask = ADUX1020_PROX_ON1_INT;
>   else
>       mask = ADUX1020_PROX_OFF1_INT;
> -------------------------------------------------
> 
> Then this could become:
> 
> -------------------------------------------------
> if (state)
>     state = mask;
> else
>     state = 0;
> 
> ret = regmap_update_bits(data->regmap,
>                          ADUX1020_REG_INT_MASK,
>                          mask, state);
> -------------------------------------------------
> 

looks good, will implement.

> 
> > +
> > +		/*
> > +		 * Trigger proximity interrupt when the intensity is above
> > +		 * or below threshold
> > +		 */
> > +		regmap_update_bits(data->regmap, ADUX1020_REG_PROX_TYPE,
> > +				   ADUX1020_PROX_TYPE, ADUX1020_PROX_TYPE);
> > +
> > +		/* Set proximity mode */
> > +		adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adux1020_read_event_config(struct iio_dev *indio_dev,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir)
> > +{
> > +	struct adux1020_data *data = iio_priv(indio_dev);
> > +	int ret, mask;
> > +	unsigned int regval;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PROXIMITY:
> > +		if (dir == IIO_EV_DIR_RISING)
> > +			mask = ADUX1020_PROX_ON1_INT;
> > +		else
> > +			mask = ADUX1020_PROX_OFF1_INT;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_read(data->regmap, ADUX1020_REG_INT_MASK, &regval);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return !(regval & mask);
> > +}
> > +
> > +static int adux1020_read_thresh(struct iio_dev *indio_dev,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir, enum iio_event_info info,
> > +		int *val, int *val2)
> > +{
> > +	struct adux1020_data *data = iio_priv(indio_dev);
> > +	u8 reg;
> > +	int ret;
> > +	unsigned int regval;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PROXIMITY:
> > +		if (dir == IIO_EV_DIR_RISING)
> > +			reg = ADUX1020_REG_PROX_TH_ON1;
> > +		else
> > +			reg = ADUX1020_REG_PROX_TH_OFF1;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_read(data->regmap, reg, &regval);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = regval;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int adux1020_write_thresh(struct iio_dev *indio_dev,
> > +		const struct iio_chan_spec *chan, enum iio_event_type type,
> > +		enum iio_event_direction dir, enum iio_event_info info,
> > +		int val, int val2)
> > +{
> > +	struct adux1020_data *data = iio_priv(indio_dev);
> > +	u8 reg;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PROXIMITY:
> > +		if (dir == IIO_EV_DIR_RISING)
> > +			reg = ADUX1020_REG_PROX_TH_ON1;
> > +		else
> > +			reg = ADUX1020_REG_PROX_TH_OFF1;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Full scale threshold value is 0-65535  */
> > +	if (val < 0 || val > 65535)
> > +		return -EINVAL;
> > +
> > +	return regmap_write(data->regmap, reg, val);
> > +}
> > +
> > +static const struct iio_event_spec adux1020_proximity_event[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_RISING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> > +			BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_FALLING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> > +			BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec adux1020_channels[] = {
> > +	{
> > +		.type = IIO_PROXIMITY,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.event_spec = adux1020_proximity_event,
> > +		.num_event_specs = ARRAY_SIZE(adux1020_proximity_event),
> > +	},
> > +	{
> > +		.type = IIO_CURRENT,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.extend_name = "led",
> > +	},
> > +};
> > +
> > +static IIO_CONST_ATTR(sampling_frequency_available,
> > +		      "0.1 0.2 0.5 1 2 5 10 20 50 100 190 450 820 1400");
> 
> This could re-use the IIO_CONST_ATTR_SAMP_FREQ_AVAIL() macro.
> 

ack.

> > +
> > +static struct attribute *adux1020_attributes[] = {
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group adux1020_attribute_group = {
> > +	.attrs = adux1020_attributes,
> > +};
> > +
> > +static const struct iio_info adux1020_info = {
> > +	.attrs = &adux1020_attribute_group,
> > +	.read_raw = adux1020_read_raw,
> > +	.write_raw = adux1020_write_raw,
> > +	.read_event_config = adux1020_read_event_config,
> > +	.write_event_config = adux1020_write_event_config,
> > +	.read_event_value = adux1020_read_thresh,
> > +	.write_event_value = adux1020_write_thresh,
> > +};
> > +
> > +static irqreturn_t adux1020_interrupt_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct adux1020_data *data = iio_priv(indio_dev);
> > +	int ret, status;
> > +
> > +	ret = regmap_read(data->regmap, ADUX1020_REG_INT_STATUS, &status);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	status &= ADUX1020_MODE_INT_STATUS_MASK;
> > +
> > +	if (status & ADUX1020_INT_PROX_ON1) {
> > +		iio_push_event(indio_dev,
> > +				IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> > +					IIO_EV_TYPE_THRESH,
> > +					IIO_EV_DIR_RISING),
> > +				iio_get_time_ns(indio_dev));
> > +	}
> > +
> > +	if (status & ADUX1020_INT_PROX_OFF1) {
> > +		iio_push_event(indio_dev,
> > +				IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> > +					IIO_EV_TYPE_THRESH,
> > +					IIO_EV_DIR_FALLING),
> > +				iio_get_time_ns(indio_dev));
> > +	}
> > +
> > +	regmap_update_bits(data->regmap, ADUX1020_REG_INT_STATUS,
> > +			   ADUX1020_MODE_INT_MASK, status);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int adux1020_chip_init(struct adux1020_data *data)
> > +{
> > +	struct i2c_client *client = data->client;
> > +	int ret, i;
> > +	unsigned int val;
> > +
> > +	ret = regmap_read(data->regmap, ADUX1020_REG_CHIP_ID, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	val &= ADUX1020_CHIP_ID_MASK;
> > +
> > +	if (val != ADUX1020_CHIP_ID) {
> > +		dev_err(&client->dev, "invalid chip id 0x%04x\n", val);
> > +		return -ENODEV;
> > +	};
> > +
> > +	dev_dbg(&client->dev, "Detected ADUX1020 with chip id: 0x%04x\n",
> > val);
> > +
> > +	/* Perform software reset */
> > +	regmap_update_bits(data->regmap, ADUX1020_REG_SW_RESET,
> > +			   ADUX1020_SW_RESET, ADUX1020_SW_RESET);
> > +
> > +	/* Load default configuration */
> > +	for (i = 0; i < ARRAY_SIZE(adux1020_def_conf); i++)
> > +		regmap_write(data->regmap, adux1020_def_conf[i][0],
> > +			     adux1020_def_conf[i][1]);
> > +
> > +	adux1020_flush_fifo(data);
> > +
> > +	/* Use LED_IREF for proximity mode */
> > +	regmap_update_bits(data->regmap, ADUX1020_REG_LED_CURRENT,
> > +			   ADUX1020_LED_PIREF_EN, 0);
> > +
> > +	/* Mask all interrupts */
> > +	regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
> > +			   ADUX1020_MODE_INT_MASK,
> > ADUX1020_MODE_INT_DISABLE);
> 
> Same as [3]: a bit more error checking here could be useful.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int adux1020_probe(struct i2c_client *client,
> > +			  const struct i2c_device_id *id)
> > +{
> > +	struct adux1020_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->info = &adux1020_info;
> > +	indio_dev->name = ADUX1020_DRV_NAME;
> > +	indio_dev->channels = adux1020_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(adux1020_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	data = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	data->regmap = devm_regmap_init_i2c(client,
> > &adux1020_regmap_config);
> > +	if (IS_ERR(data->regmap)) {
> > +		dev_err(&client->dev, "regmap initialization failed.\n");
> > +		return PTR_ERR(data->regmap);
> > +	}
> > +
> > +	data->client = client;
> > +	data->indio_dev = indio_dev;
> > +	mutex_init(&data->lock);
> > +
> > +	ret = adux1020_chip_init(data);
> > +	if (ret)
> > +		goto err_out;
> > +
> > +	if (client->irq) {
> > +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +				NULL, adux1020_interrupt_handler,
> > +				IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +				ADUX1020_DRV_NAME, indio_dev);
> > +		if (ret) {
> > +			dev_err(&client->dev, "irq request error %d\n",
> > -ret);
> > +			goto err_out;
> > +		}
> > +	}
> > +
> > +	ret = iio_device_register(indio_dev);
> 
> [7] Jonathan may correct me here.
> If this doesn't need to do anything more later, this could use
> devm_iio_device_register(), and then the  adux1020_remove() hook could be
> removed.
> 

right. will switch to devm_ API.

Thanks,
Mani

> > +	if (ret) {
> > +		dev_err(&client->dev, "Failed to register IIO device\n");
> > +		goto err_out;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_out:
> > +	return ret;
> > +}
> > +
> > +static int adux1020_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id adux1020_id[] = {
> > +	{ "adux1020", 0 },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, adux1020_id);
> > +
> > +static const struct of_device_id adux1020_of_match[] = {
> > +	{ .compatible = "adi,adux1020" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, adux1020_of_match);
> > +
> > +static struct i2c_driver adux1020_driver = {
> > +	.driver = {
> > +		.name	= ADUX1020_DRV_NAME,
> > +		.of_match_table = adux1020_of_match,
> > +	},
> > +	.probe		= adux1020_probe,
> > +	.remove		= adux1020_remove,
> > +	.id_table	= adux1020_id,
> > +};
> > +module_i2c_driver(adux1020_driver);
> > +
> > +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>"
> > );
> > +MODULE_DESCRIPTION("ADUX1020 photometric sensor");
> > +MODULE_LICENSE("GPL");
