Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E7115D7BB
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 13:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBNMzm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 07:55:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgBNMzm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 07:55:42 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93D9F2168B;
        Fri, 14 Feb 2020 12:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581684940;
        bh=1GEtlZcPusHgpheYjO6eXta3ti5O2KH72iMqwMv+C94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tYA3Be3jqULTel0Z6w4tubVMtQIuDtwYfvywgH5azavkaCycrdU4EgwSTfBkINbbd
         GyZBupqgcMw5J78g0FExBCpIvEIsJg+BUD5c2uOyUAJIF6kkDfhhIsx0+qLIa0SKCQ
         hEupABNd+FnfS9JcNBn9OvwJWEwGJBRR9PW4kpqE=
Date:   Fri, 14 Feb 2020 12:55:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v2 1/3] iio: adc: rn5t618: Add ADC driver for
 RN5T618/RC5T619
Message-ID: <20200214125535.211efa0d@archlinux>
In-Reply-To: <20200211172033.6094878c@kemnade.info>
References: <20200120212056.28806-1-andreas@kemnade.info>
        <20200120212056.28806-2-andreas@kemnade.info>
        <20200202173355.1b949a37@archlinux>
        <20200211172033.6094878c@kemnade.info>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 17:24:50 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> On Sun, 2 Feb 2020 17:33:55 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 20 Jan 2020 22:20:54 +0100
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> >   
> > > Both chips have an A/D converter capable of measuring
> > > things like VBAT, VUSB and analog inputs.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>    
> > Sorry I missed one bigger thing in here around PROCESSED vs RAW.
> > See inline.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > > Changes in v2:
> > > - enum for channels
> > > - bulk read instead of single byte read for conversion
> > >   result
> > > - fix get_virq error handling
> > > - use devm for registering device and requesting IRQ
> > > 
> > >  drivers/iio/adc/Kconfig       |  10 ++
> > >  drivers/iio/adc/Makefile      |   1 +
> > >  drivers/iio/adc/rn5t618-adc.c | 253 ++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 264 insertions(+)
> > >  create mode 100644 drivers/iio/adc/rn5t618-adc.c
> > > 
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index f0af3a42f53c..9ea9489e3f0a 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -735,6 +735,16 @@ config RCAR_GYRO_ADC
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called rcar-gyroadc.
> > >  
> > > +config RN5T618_ADC
> > > +	tristate "ADC for the RN5T618/RC5T619 family of chips"
> > > +	depends on MFD_RN5T618
> > > +	help
> > > +	  Say yes here to build support for the integrated ADC inside the
> > > +	  RN5T618/619 series PMICs:    
> > Why :?  
> > > +
> > > +	  This driver can also be built as a module. If so, the module
> > > +	  will be called rn5t618-adc.
> > > +
> > >  config ROCKCHIP_SARADC
> > >  	tristate "Rockchip SARADC driver"
> > >  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index ef9cc485fb67..2aea70556ed0 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -69,6 +69,7 @@ obj-$(CONFIG_QCOM_VADC_COMMON) += qcom-vadc-common.o
> > >  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
> > >  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
> > >  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
> > > +obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
> > >  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> > >  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
> > >  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
> > > diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
> > > new file mode 100644
> > > index 000000000000..667bd814569d
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/rn5t618-adc.c
> > > @@ -0,0 +1,253 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * ADC driver for the RICOH RN5T618 power management chip family
> > > + *
> > > + * Copyright (C) 2019 Andreas Kemnade
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/device.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/init.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mfd/rn5t618.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/irqdomain.h>    
> > I may be missing something, but I'm not immediately seeing any irq_domain*
> > calls?  I suspect the only call is via stuff buried in regmap so we probably
> > don't need the header here.
> >   
> > > +
> > > +#define RN5T618_ADC_CONVERSION_TIMEOUT   (msecs_to_jiffies(500))
> > > +#define REFERENCE_VOLT 2500    
> > 
> > Please prefix these defines
> > RN5T618_* 
> >   
> Does that also apply for the defines below?

yes. It's easier to just prefix all driver specific defines than think
carefully about which ones might 'clash' and which ones are very unlikely
to do so.

> 
> > It avoids potential clashes in future with things defined in headers.
> >   
> > > +
> > > +/* mask for selecting channels for single conversion */
> > > +#define ADCCNT3_CHANNEL_MASK 0x7
> > > +/* average 4-time conversion mode */
> > > +#define ADCCNT3_AVG BIT(3)
> > > +/* set for starting a single conversion, gets cleared by hw when done */
> > > +#define ADCCNT3_GODONE BIT(4)
> > > +/* automatic conversion, period is in ADCCNT2, selected channels are
> > > + * in ADCCNT1
> > > + */
> > > +#define ADCCNT3_AUTO BIT(5)
> > > +#define ADCEND_IRQ BIT(0)
> > > +
> > > +struct rn5t618_adc_data {
> > > +	struct device *dev;
> > > +	struct rn5t618 *rn5t618;
> > > +	struct completion conv_completion;
> > > +	int irq;
> > > +};
> > > +
> > > +struct rn5t618_channel_ratios {
> > > +	u16 numerator;
> > > +	u16 denominator;
> > > +};
> > > +
> > > +enum rn5t618_channels {
> > > +	LIMMON = 0,
> > > +	VBAT,
> > > +	VADP,
> > > +	VUSB,
> > > +	VSYS,
> > > +	VTHM,
> > > +	AIN1,
> > > +	AIN0
> > > +};
> > > +
> > > +static const struct rn5t618_channel_ratios rn5t618_ratios[8] = {
> > > +	[LIMMON] = {50, 32}, /* measured across 20mOhm, amplified by 32 */
> > > +	[VBAT] = {2, 1},
> > > +	[VADP] = {3, 1},
> > > +	[VUSB] = {3, 1},
> > > +	[VSYS] = {3, 1},
> > > +	[VTHM] = {1, 1},
> > > +	[AIN1] = {1, 1},
> > > +	[AIN0] = {1, 1},
> > > +};
> > > +
> > > +static int rn5t618_read_adc_reg(struct rn5t618 *rn5t618, int reg, u16 *val)
> > > +{
> > > +	u8 data[2];
> > > +	int ret;
> > > +
> > > +	ret = regmap_bulk_read(rn5t618->regmap, reg, data, sizeof(data));
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*val = (data[0] << 4) | (data[1] & 0xF);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static irqreturn_t rn5t618_adc_irq(int irq, void *data)
> > > +{
> > > +	struct rn5t618_adc_data *adc = data;
> > > +	unsigned int r = 0;
> > > +	int ret;
> > > +
> > > +	/* clear low & high threshold irqs */
> > > +	regmap_write(adc->rn5t618->regmap, RN5T618_IR_ADC1, 0);
> > > +	regmap_write(adc->rn5t618->regmap, RN5T618_IR_ADC2, 0);
> > > +
> > > +	ret = regmap_read(adc->rn5t618->regmap, RN5T618_IR_ADC3, &r);
> > > +	if (ret < 0)
> > > +		dev_err(adc->dev, "failed to read IRQ status: %d\n", ret);
> > > +
> > > +	regmap_write(adc->rn5t618->regmap, RN5T618_IR_ADC3, 0);
> > > +
> > > +	if (r & ADCEND_IRQ)
> > > +		complete(&adc->conv_completion);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int rn5t618_adc_read(struct iio_dev *iio_dev,
> > > +			    const struct iio_chan_spec *chan,
> > > +			    int *val, int *val2, long mask)
> > > +{
> > > +	struct rn5t618_adc_data *adc = iio_priv(iio_dev);
> > > +	u16 raw;
> > > +	int ret;
> > > +
> > > +	/* select channel */
> > > +	ret = regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
> > > +				 ADCCNT3_CHANNEL_MASK,
> > > +				 chan->channel);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = regmap_write(adc->rn5t618->regmap, RN5T618_EN_ADCIR3, ADCEND_IRQ);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
> > > +				 ADCCNT3_AVG,
> > > +				 mask == IIO_CHAN_INFO_AVERAGE_RAW ?
> > > +				 ADCCNT3_AVG : 0);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	init_completion(&adc->conv_completion);
> > > +	/* single conversion */
> > > +	ret = regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
> > > +				 ADCCNT3_GODONE, ADCCNT3_GODONE);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret = wait_for_completion_timeout(&adc->conv_completion,
> > > +					  RN5T618_ADC_CONVERSION_TIMEOUT);
> > > +	if (ret == 0) {
> > > +		dev_warn(adc->dev, "timeout waiting for adc result\n");
> > > +		return -ETIMEDOUT;
> > > +	}
> > > +
> > > +	ret = rn5t618_read_adc_reg(adc->rn5t618,
> > > +				   RN5T618_ILIMDATAH + 2 * chan->channel,
> > > +				   &raw);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*val = raw;
> > > +	if (mask == IIO_CHAN_INFO_PROCESSED)
> > > +		*val = *val * REFERENCE_VOLT *
> > > +		       rn5t618_ratios[chan->channel].numerator /
> > > +		       rn5t618_ratios[chan->channel].denominator / 4095;    
> > 
> > This info should be provided as scale so that userspace can do the maths if
> > it wants to rather than handling it in kernel.
> >   
> can do as has to do? So I guess any simple shell script then cannot simply
> read out values from sysfs.

Takes a little more complexity if you want them in base units, but
not much.  The reason for this preference for just _raw where possible
is to align with what gets packed into the buffers when using
the chrdev route.  In that case you want tight packing and that is
normally much easier if you stick to whatever format the data came
off the device in.



> Hmm, how is scale defined here?
> processed in mV = raw * scale (which can be IIO_VAL_FRACTIONAL)?
Yes.  Should all be documented in the ABI docs.

Documentation/ABI/testing/sysfs-bus-iio*

> 
> > > +
> > > +	return IIO_VAL_INT;
> > > +}
> > > +
> > > +static const struct iio_info rn5t618_adc_iio_info = {
> > > +	.read_raw = &rn5t618_adc_read,
> > > +};
> > > +
> > > +#define RN5T618_ADC_CHANNEL(_channel, _type, _name) { \
> > > +	.type = _type, \
> > > +	.channel = _channel, \
> > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> > > +			      BIT(IIO_CHAN_INFO_AVERAGE_RAW) | \
> > > +			      BIT(IIO_CHAN_INFO_PROCESSED), \    
> > 
> > Sorry, I missed this before. 
> > 
> > As a general rule it makes no sense to expose both RAW and PROCESSED values.
> > It should be possible to work one out from the other if the relationship is
> > linear and scale is provided.
> >   
> hmm, the other adc drivers, I get in touch with, expose both RAW and PROCESSED.
> like twl4030_madc. So you want to not have that for new drivers and from the
> previous comment you prefer to have PROCESSED dropped here?

We can't drop it for existing drivers and normally there is some history
to how we ended up with both.  Most commonly it is because the conversion
is non linear so we don't have a good way to represent it (often odd
calibration stuff that was added after the initial driver).  Sometimes
it was just something we missed in review, particularly in older drivers.

We can't fix it there because there may be custom userspace code relying on
it.  All the remotely standard code will happily take either option.

Jonathan

> 
> Regards,
> Andreas

