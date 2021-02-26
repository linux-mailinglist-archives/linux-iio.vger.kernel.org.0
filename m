Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE66B32627B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 13:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBZMPv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 07:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhBZMPm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2021 07:15:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E14C061756
        for <linux-iio@vger.kernel.org>; Fri, 26 Feb 2021 04:15:02 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lFc1I-0007Zi-G3; Fri, 26 Feb 2021 13:14:56 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lFc1H-0003c1-CP; Fri, 26 Feb 2021 13:14:55 +0100
Date:   Fri, 26 Feb 2021 13:14:55 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v7 2/2] counter: add IRQ or GPIO based counter
Message-ID: <20210226121455.t7kz4cxtganzt2xz@pengutronix.de>
References: <20210226090830.10927-1-o.rempel@pengutronix.de>
 <20210226090830.10927-3-o.rempel@pengutronix.de>
 <YDjDMBfWwdImiZxY@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDjDMBfWwdImiZxY@shinobu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:37:50 up 86 days, 44 min, 43 users,  load average: 0.12, 0.08,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Fri, Feb 26, 2021 at 06:45:20PM +0900, William Breathitt Gray wrote:
> On Fri, Feb 26, 2021 at 10:08:30AM +0100, Oleksij Rempel wrote:
> > Add simple IRQ or GPIO base counter. This device is used to measure
> > rotation speed of some agricultural devices, so no high frequency on the
> > counter pin is expected.
> > 
> > The maximal measurement frequency depends on the CPU and system load. On
> > the idle iMX6S I was able to measure up to 20kHz without count drops.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> Hi Oleksij,
> 
> We're almost there, but I spotted a couple of mistakes below.
> 
> > ---
> >  MAINTAINERS                     |   7 +
> >  drivers/counter/Kconfig         |  10 ++
> >  drivers/counter/Makefile        |   1 +
> >  drivers/counter/interrupt-cnt.c | 243 ++++++++++++++++++++++++++++++++
> >  4 files changed, 261 insertions(+)
> >  create mode 100644 drivers/counter/interrupt-cnt.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a50a543e3c81..ad0a4455afec 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9217,6 +9217,13 @@ F:	include/dt-bindings/interconnect/
> >  F:	include/linux/interconnect-provider.h
> >  F:	include/linux/interconnect.h
> >  
> > +INTERRUPT COUNTER DRIVER
> > +M:	Oleksij Rempel <o.rempel@pengutronix.de>
> > +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> > +L:	linux-iio@vger.kernel.org
> > +F:	Documentation/devicetree/bindings/counter/interrupt-counter.yaml
> > +F:	drivers/counter/interrupt-cnt.c
> > +
> >  INVENSENSE ICM-426xx IMU DRIVER
> >  M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> >  L:	linux-iio@vger.kernel.org
> > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > index 2de53ab0dd25..dcad13229134 100644
> > --- a/drivers/counter/Kconfig
> > +++ b/drivers/counter/Kconfig
> > @@ -29,6 +29,16 @@ config 104_QUAD_8
> >  	  The base port addresses for the devices may be configured via the base
> >  	  array module parameter.
> >  
> > +config INTERRUPT_CNT
> > +	tristate "Interrupt counter driver"
> > +	depends on GPIOLIB
> > +	help
> > +	  Select this option to enable interrupt counter driver. Any interrupt
> > +	  source can be used by this driver as the event source.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called interrupt-cnt.
> > +
> >  config STM32_TIMER_CNT
> >  	tristate "STM32 Timer encoder counter driver"
> >  	depends on MFD_STM32_TIMERS || COMPILE_TEST
> > diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> > index 0a393f71e481..cb646ed2f039 100644
> > --- a/drivers/counter/Makefile
> > +++ b/drivers/counter/Makefile
> > @@ -6,6 +6,7 @@
> >  obj-$(CONFIG_COUNTER) += counter.o
> >  
> >  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
> > +obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
> >  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
> >  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> >  obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
> > diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> > new file mode 100644
> > index 000000000000..550383b6b591
> > --- /dev/null
> > +++ b/drivers/counter/interrupt-cnt.c
> > @@ -0,0 +1,243 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
> > + */
> > +
> > +#include <linux/counter.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define INTERRUPT_CNT_NAME "interrupt-cnt"
> > +
> > +struct interrupt_cnt_priv {
> > +	atomic_t count;
> > +	struct counter_device counter;
> > +	struct gpio_desc *gpio;
> > +	int irq;
> > +	bool enabled;
> > +	struct counter_signal signals;
> > +	struct counter_synapse synapses;
> > +	struct counter_count cnts;
> > +};
> > +
> > +static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
> > +{
> > +	struct interrupt_cnt_priv *priv = dev_id;
> > +
> > +	atomic_inc(&priv->count);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static ssize_t interrupt_cnt_enable_read(struct counter_device *counter,
> > +					 struct counter_count *count,
> > +					 void *private, char *buf)
> > +{
> > +	struct interrupt_cnt_priv *priv = counter->priv;
> > +
> > +	return sysfs_emit(buf, "%d\n", priv->enabled);
> > +}
> > +
> > +static ssize_t interrupt_cnt_enable_write(struct counter_device *counter,
> > +					  struct counter_count *count,
> > +					  void *private, const char *buf,
> > +					  size_t len)
> > +{
> > +	struct interrupt_cnt_priv *priv = counter->priv;
> > +	bool enable;
> > +	ssize_t ret;
> > +
> > +	ret = kstrtobool(buf, &enable);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (priv->enabled == enable)
> > +		return len;
> > +
> > +	if (enable) {
> > +		priv->enabled = true;
> > +		enable_irq(priv->irq);
> > +	} else {
> > +		disable_irq(priv->irq);
> > +		priv->enabled = false;
> > +	}
> > +
> > +	return len;
> > +}
> > +
> > +static const struct counter_count_ext interrupt_cnt_ext[] = {
> > +	{
> > +		.name = "enable",
> > +		.read = interrupt_cnt_enable_read,
> > +		.write = interrupt_cnt_enable_write,
> > +	},
> > +};
> > +
> > +static enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
> > +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> > +};
> > +
> > +static int interrupt_cnt_action_get(struct counter_device *counter,
> > +				    struct counter_count *count,
> > +				    struct counter_synapse *synapse,
> > +				    size_t *action)
> > +{
> > +	*action = interrupt_cnt_synapse_actionss[0];
> 
> This needs to be set to the index of the element, not the value:
> 
> 	*action = 0;
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int interrupt_cnt_read(struct counter_device *counter,
> > +			      struct counter_count *count, unsigned long *val)
> > +{
> > +	struct interrupt_cnt_priv *priv = counter->priv;
> > +
> > +	*val = atomic_read(&priv->count);
> > +
> > +	return 0;
> > +}
> > +
> > +static int interrupt_cnt_write(struct counter_device *counter,
> > +			       struct counter_count *count,
> > +			       const unsigned long val)
> > +{
> > +	struct interrupt_cnt_priv *priv = counter->priv;
> > +
> > +	atomic_set(&priv->count, val);
> > +
> > +	return 0;
> > +}
> > +
> > +static enum counter_count_function interrupt_cnt_functions[] = {
> > +	COUNTER_COUNT_FUNCTION_INCREASE,
> > +};
> > +
> > +static int interrupt_cnt_function_get(struct counter_device *counter,
> > +				      struct counter_count *count,
> > +				      size_t *function)
> > +{
> > +	*function = interrupt_cnt_functions[0];
> 
> Same problem as action_get(); needs to be index, not value:
> 
> 	*function = 0;

ok

> > +
> > +	return 0;
> > +}
> > +
> > +static int interrupt_cnt_signal_read(struct counter_device *counter,
> > +				     struct counter_signal *signal,
> > +				     enum counter_signal_value *val)
> > +{
> > +	struct interrupt_cnt_priv *priv = counter->priv;
> > +	int ret;
> > +
> > +	ret = gpiod_get_value(priv->gpio);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = ret ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct counter_ops interrupt_cnt_ops = {
> > +	.action_get = interrupt_cnt_action_get,
> > +	.count_read = interrupt_cnt_read,
> > +	.count_write = interrupt_cnt_write,
> > +	.function_get = interrupt_cnt_function_get,
> > +	.signal_read  = interrupt_cnt_signal_read,
> > +};
> > +
> > +static int interrupt_cnt_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct interrupt_cnt_priv *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->irq = platform_get_irq_optional(pdev,  0);
> > +	if (priv->irq == -ENXIO)
> > +		priv->irq = 0;
> > +	else if (priv->irq < 0)
> > +		return dev_err_probe(dev, priv->irq, "failed to get IRQ\n");
> > +
> > +	priv->gpio = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
> > +	if (IS_ERR(priv->gpio))
> > +		return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get GPIO\n");
> > +
> > +	if (!priv->irq && !priv->gpio) {
> > +		dev_err(dev, "IRQ and GPIO are not found. At least one source should be provided\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (!priv->irq) {
> > +		int irq = gpiod_to_irq(priv->gpio);
> > +
> > +		if (irq < 0)
> > +			return dev_err_probe(dev, irq, "failed to get IRQ from GPIO\n");
> > +
> > +		priv->irq = irq;
> > +	}
> > +
> > +	if (priv->gpio) {
> 
> This if statement can be removed. There's no need to restrict this to
> just GPIO because we're always dealing with an IRQ, so allocate the
> "IRQ #" name unconditionally and set signals/num_signals.

Your previous suggestion was to no assign signals if there is no gpios.
What should I do?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
