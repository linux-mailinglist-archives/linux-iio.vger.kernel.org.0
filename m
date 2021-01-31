Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6530309C43
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhAaM7w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 07:59:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231866AbhAaMH3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 07:07:29 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD7EB64E1F;
        Sun, 31 Jan 2021 12:06:45 +0000 (UTC)
Date:   Sun, 31 Jan 2021 12:06:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 2/2] counter: add GPIO based pulse counters
Message-ID: <20210131120642.58bd62e5@archlinux>
In-Reply-To: <20210126080756.xi637l6ne3g4vgb7@pengutronix.de>
References: <20210122112434.27886-1-o.rempel@pengutronix.de>
        <20210122112434.27886-3-o.rempel@pengutronix.de>
        <20210124144737.7978d3c8@archlinux>
        <20210126080756.xi637l6ne3g4vgb7@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Jan 2021 09:07:57 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Jonathan,
> 
> On Sun, Jan 24, 2021 at 02:47:37PM +0000, Jonathan Cameron wrote:
> > On Fri, 22 Jan 2021 12:24:34 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >   
> > > Add simple GPIO base pulse counter. This device is used to measure
> > > rotation speed of some agricultural devices, so no high frequency on the
> > > counter pin is expected.
> > > 
> > > The maximal measurement frequency depends on the CPU and system load. On
> > > the idle iMX6S I was able to measure up to 20kHz without count drops.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>  
> > 
> > Hi Oleksij,
> > 
> > A few comments inline.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/counter/Kconfig          |   9 ++
> > >  drivers/counter/Makefile         |   1 +
> > >  drivers/counter/gpio-pulse-cnt.c | 244 +++++++++++++++++++++++++++++++
> > >  3 files changed, 254 insertions(+)
> > >  create mode 100644 drivers/counter/gpio-pulse-cnt.c
> > > 
> > > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > > index 2de53ab0dd25..9ad1d9d49dd1 100644
> > > --- a/drivers/counter/Kconfig
> > > +++ b/drivers/counter/Kconfig
> > > @@ -29,6 +29,15 @@ config 104_QUAD_8
> > >  	  The base port addresses for the devices may be configured via the base
> > >  	  array module parameter.
> > >  
> > > +config GPIO_PULSE_CNT
> > > +	tristate "GPIO pulse counter driver"
> > > +	depends on GPIOLIB
> > > +	help
> > > +	  Select this option to enable GPIO pulse counter driver.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called gpio-pulse-cnt.
> > > +
> > >  config STM32_TIMER_CNT
> > >  	tristate "STM32 Timer encoder counter driver"
> > >  	depends on MFD_STM32_TIMERS || COMPILE_TEST
> > > diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> > > index 0a393f71e481..6a5c3fc6f2a0 100644
> > > --- a/drivers/counter/Makefile
> > > +++ b/drivers/counter/Makefile
> > > @@ -6,6 +6,7 @@
> > >  obj-$(CONFIG_COUNTER) += counter.o
> > >  
> > >  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
> > > +obj-$(CONFIG_GPIO_PULSE_CNT)	+= gpio-pulse-cnt.o
> > >  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
> > >  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> > >  obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
> > > diff --git a/drivers/counter/gpio-pulse-cnt.c b/drivers/counter/gpio-pulse-cnt.c
> > > new file mode 100644
> > > index 000000000000..9454345c77ad
> > > --- /dev/null
> > > +++ b/drivers/counter/gpio-pulse-cnt.c
> > > @@ -0,0 +1,244 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
> > > + */
> > > +
> > > +#include <linux/counter.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>  
> > 
> > why of_device.h?  Probably want mod_devicetable.h instead.  
> 
> done
> 
> > > +#include <linux/platform_device.h>
> > > +
> > > +#define GPIO_PULSE_NAME		"gpio-pulse-counter"
> > > +
> > > +struct gpio_pulse_priv {
> > > +	struct counter_device counter;
> > > +	struct gpio_desc *gpio;
> > > +	int irq;
> > > +	bool enabled;
> > > +	atomic_t count;
> > > +};
> > > +
> > > +static irqreturn_t gpio_pulse_irq_isr(int irq, void *dev_id)
> > > +{
> > > +	struct gpio_pulse_priv *priv = dev_id;
> > > +
> > > +	if (!priv->enabled)
> > > +		return IRQ_NONE;
> > > +
> > > +	atomic_inc(&priv->count);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static ssize_t gpio_pulse_count_enable_read(struct counter_device *counter,
> > > +					    struct counter_count *count,
> > > +					    void *private, char *buf)
> > > +{
> > > +	struct gpio_pulse_priv *priv = counter->priv;
> > > +
> > > +	return sysfs_emit(buf, "%d\n", priv->enabled);
> > > +}
> > > +
> > > +static ssize_t gpio_pulse_count_enable_write(struct counter_device *counter,
> > > +					     struct counter_count *count,
> > > +					     void *private,
> > > +					     const char *buf, size_t len)
> > > +{
> > > +	struct gpio_pulse_priv *priv = counter->priv;
> > > +	bool enable;
> > > +	ssize_t ret;
> > > +
> > > +	ret = kstrtobool(buf, &enable);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (priv->enabled == enable)
> > > +		return len;
> > > +
> > > +	priv->enabled = enable;
> > > +
> > > +	if (enable)
> > > +		enable_irq(priv->irq);
> > > +	else
> > > +		disable_irq(priv->irq);  
> > 
> > As pointed out by Ahmad, this is all racy.
> > Personally I'd just let the race happen, and don't
> > bother with the priv->enabled at all.  
> 
> yes, i forgot about existence of IRQ_NOAUTOEN
> 
> > We aren't going to be dealing with shared interrupts
> > here so if we get a race, it's between userspace write
> > getting through to enable / disable the interrupt and
> > a pulse coming in.  The userspace part is so unpredictable on
> > timing etc the race isn't pretty meaningless (you might count
> > one extra, but then if userspace took a bit longer you might
> > do that anyway).
> > 
> >   
> > > +
> > > +	return len;
> > > +}
> > > +
> > > +static const struct counter_count_ext gpio_pulse_count_ext[] = {
> > > +	{
> > > +		.name = "enable",
> > > +		.read = gpio_pulse_count_enable_read,
> > > +		.write = gpio_pulse_count_enable_write,
> > > +	},
> > > +};
> > > +
> > > +static enum counter_synapse_action gpio_pulse_synapse_actions[] = {
> > > +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> > > +};
> > > +
> > > +static int gpio_pulse_action_get(struct counter_device *counter,
> > > +			    struct counter_count *count,
> > > +			    struct counter_synapse *synapse,
> > > +			    size_t *action)
> > > +{
> > > +	*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int gpio_pulse_count_read(struct counter_device *counter,
> > > +				 struct counter_count *count,
> > > +				 unsigned long *val)
> > > +{
> > > +	struct gpio_pulse_priv *priv = counter->priv;
> > > +
> > > +	*val = atomic_read(&priv->count);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int gpio_pulse_count_write(struct counter_device *counter,
> > > +				  struct counter_count *count,
> > > +				  const unsigned long val)
> > > +{
> > > +	struct gpio_pulse_priv *priv = counter->priv;
> > > +
> > > +	atomic_set(&priv->count, val);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int gpio_pulse_count_function_get(struct counter_device *counter,
> > > +					 struct counter_count *count,
> > > +					 size_t *function)
> > > +{
> > > +	*function = COUNTER_COUNT_FUNCTION_INCREASE;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int gpio_pulse_count_signal_read(struct counter_device *counter,
> > > +					struct counter_signal *signal,
> > > +					enum counter_signal_value *val)
> > > +{
> > > +	struct gpio_pulse_priv *priv = counter->priv;
> > > +	int ret;
> > > +
> > > +	ret = gpiod_get_value(priv->gpio);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*val = ret ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct counter_ops gpio_pulse_cnt_ops = {
> > > +	.action_get = gpio_pulse_action_get,
> > > +	.count_read = gpio_pulse_count_read,
> > > +	.count_write = gpio_pulse_count_write,
> > > +	.function_get = gpio_pulse_count_function_get,
> > > +	.signal_read  = gpio_pulse_count_signal_read,
> > > +};
> > > +
> > > +static struct counter_signal gpio_pulse_signals[] = {
> > > +	{
> > > +		.id = 0,
> > > +		.name = "Channel 0 signal",
> > > +	},
> > > +};
> > > +
> > > +static struct counter_synapse gpio_pulse_count_synapses[] = {
> > > +	{
> > > +		.actions_list = gpio_pulse_synapse_actions,
> > > +		.num_actions = ARRAY_SIZE(gpio_pulse_synapse_actions),
> > > +		.signal = &gpio_pulse_signals[0]
> > > +	},
> > > +};
> > > +
> > > +static enum counter_count_function gpio_pulse_count_functions[] = {
> > > +	COUNTER_COUNT_FUNCTION_INCREASE,
> > > +};
> > > +
> > > +static struct counter_count gpio_pulse_counts[] = {
> > > +	{
> > > +		.id = 0,
> > > +		.name = "Channel 1 Count",
> > > +		.functions_list = gpio_pulse_count_functions,
> > > +		.num_functions = ARRAY_SIZE(gpio_pulse_count_functions),
> > > +		.synapses = gpio_pulse_count_synapses,
> > > +		.num_synapses = ARRAY_SIZE(gpio_pulse_count_synapses),
> > > +		.ext = gpio_pulse_count_ext,
> > > +		.num_ext = ARRAY_SIZE(gpio_pulse_count_ext),
> > > +	},
> > > +};
> > > +
> > > +static int gpio_pulse_cnt_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct gpio_pulse_priv *priv;
> > > +	int ret;
> > > +
> > > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	if (gpiod_count(dev, NULL) != 1) {
> > > +		dev_err(dev, "Error, need exactly 1 gpio for device\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	priv->gpio = devm_gpiod_get(dev, NULL, GPIOD_IN);
> > > +	if (IS_ERR(priv->gpio))
> > > +		return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get gpio\n");  
> > 
> > My gut feeling here is that it probably makes sense to drop
> > the direct read of the signal level, and hence allow the driver
> > to be provided with an interrupt instead of a gpio.
> > 
> > Afterall, not all gpio lines are interrupt capable.  
> 
> Hm, .. I need to be able to sense GPIO level for diagnostic interface.
> So, in this case i'll need to get irq and gpio separately 

Perhaps support an either / or situation. If you get given an
irq by the firmware, then just don't provide the diagnostic interface.
If it's a gpio, then do it as you do here.

Jonathan

> 
> > > +
> > > +	priv->irq = gpiod_to_irq(priv->gpio);
> > > +	if (priv->irq < 0) {
> > > +		dev_err(dev, "failed to map GPIO to IRQ: %d\n", priv->irq);
> > > +		return priv->irq;
> > > +	}
> > > +
> > > +	priv->counter.name = dev_name(dev);
> > > +	priv->counter.parent = dev;
> > > +	priv->counter.ops = &gpio_pulse_cnt_ops;
> > > +	priv->counter.counts = gpio_pulse_counts;
> > > +	priv->counter.num_counts = ARRAY_SIZE(gpio_pulse_counts);
> > > +	priv->counter.signals = gpio_pulse_signals;
> > > +	priv->counter.num_signals = ARRAY_SIZE(gpio_pulse_signals);
> > > +	priv->counter.priv = priv;
> > > +
> > > +	ret = devm_request_irq(dev, priv->irq, gpio_pulse_irq_isr,
> > > +			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> > > +			       GPIO_PULSE_NAME, priv);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	disable_irq(priv->irq);  
> > 
> > Race condition here (messy at least) that we can close down.  
> 
> ACK
> 
> > Note there is ongoing work to try and do this in a nice generic
> > fashion, but in the meantime call
> >
> > irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);  
> 
> ^^ yes! this is what i was seeking! Thx.
> 
> > before the devm_request_irq()
> > 
> > https://lore.kernel.org/lkml/20210107223926.35284-2-song.bao.hua@hisilicon.com/  
> 
> Nice!
> 
> > There are a lot of cases that series will tidy up, but let us do the best
> > we can in the meantime!
> >    
> > > +
> > > +	platform_set_drvdata(pdev, priv);
> > > +
> > > +	return devm_counter_register(dev, &priv->counter);
> > > +}
> > > +
> > > +static const struct of_device_id gpio_pulse_cnt_of_match[] = {
> > > +	{ .compatible = "virtual,gpio-pulse-counter", },
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, gpio_pulse_cnt_of_match);
> > > +
> > > +static struct platform_driver gpio_pulse_cnt_driver = {
> > > +	.probe = gpio_pulse_cnt_probe,
> > > +	.driver = {
> > > +		.name = GPIO_PULSE_NAME,
> > > +		.of_match_table = gpio_pulse_cnt_of_match,
> > > +	},
> > > +};
> > > +module_platform_driver(gpio_pulse_cnt_driver);
> > > +
> > > +MODULE_ALIAS("platform:gpio-pulse-counter");
> > > +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> > > +MODULE_DESCRIPTION("GPIO pulse counter driver");
> > > +MODULE_LICENSE("GPL v2");  
> 
> Thank you.
> 
> Regards,
> Oleksij

