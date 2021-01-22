Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE93001FF
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 12:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbhAVLvu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 06:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbhAVLvp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 06:51:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D52C0613D6
        for <linux-iio@vger.kernel.org>; Fri, 22 Jan 2021 03:51:05 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l2uxv-0003eZ-Eu; Fri, 22 Jan 2021 12:50:59 +0100
Subject: Re: [PATCH v3 2/2] counter: add GPIO based pulse counters
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
References: <20210122112434.27886-1-o.rempel@pengutronix.de>
 <20210122112434.27886-3-o.rempel@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <0105e99c-f6f7-2e2d-94e6-b67395808670@pengutronix.de>
Date:   Fri, 22 Jan 2021 12:50:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210122112434.27886-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

On 22.01.21 12:24, Oleksij Rempel wrote:
> Add simple GPIO base pulse counter. This device is used to measure
> rotation speed of some agricultural devices, so no high frequency on the
> counter pin is expected.
> 
> The maximal measurement frequency depends on the CPU and system load. On
> the idle iMX6S I was able to measure up to 20kHz without count drops.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/counter/Kconfig          |   9 ++
>  drivers/counter/Makefile         |   1 +
>  drivers/counter/gpio-pulse-cnt.c | 244 +++++++++++++++++++++++++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 drivers/counter/gpio-pulse-cnt.c
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2de53ab0dd25..9ad1d9d49dd1 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -29,6 +29,15 @@ config 104_QUAD_8
>  	  The base port addresses for the devices may be configured via the base
>  	  array module parameter.
>  
> +config GPIO_PULSE_CNT
> +	tristate "GPIO pulse counter driver"
> +	depends on GPIOLIB
> +	help
> +	  Select this option to enable GPIO pulse counter driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gpio-pulse-cnt.
> +
>  config STM32_TIMER_CNT
>  	tristate "STM32 Timer encoder counter driver"
>  	depends on MFD_STM32_TIMERS || COMPILE_TEST
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 0a393f71e481..6a5c3fc6f2a0 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_COUNTER) += counter.o
>  
>  obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
> +obj-$(CONFIG_GPIO_PULSE_CNT)	+= gpio-pulse-cnt.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
>  obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
> diff --git a/drivers/counter/gpio-pulse-cnt.c b/drivers/counter/gpio-pulse-cnt.c
> new file mode 100644
> index 000000000000..9454345c77ad
> --- /dev/null
> +++ b/drivers/counter/gpio-pulse-cnt.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
> + */
> +
> +#include <linux/counter.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#define GPIO_PULSE_NAME		"gpio-pulse-counter"
> +
> +struct gpio_pulse_priv {
> +	struct counter_device counter;
> +	struct gpio_desc *gpio;
> +	int irq;
> +	bool enabled;
> +	atomic_t count;
> +};
> +
> +static irqreturn_t gpio_pulse_irq_isr(int irq, void *dev_id)
> +{
> +	struct gpio_pulse_priv *priv = dev_id;
> +
> +	if (!priv->enabled)

Sorry, didn't look too closely first time.

- User sets ->enable = 0
- IRQ raised before disabling
- you return IRQ_NONE, kernel logs a spurious IRQ

I'd say that's a bug. Instead:

 - Can we ask whether an irq is enabled? If so, you can drop ->enabled
 - Otherwise, you should set ->enabled while irqs are off. So after disable
   and before enable. You also need READ_ONCE/WRITE_ONCE.

With this addressed, for the non-counter-framework-specific parts:
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> +		return IRQ_NONE;
> +
> +	atomic_inc(&priv->count);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static ssize_t gpio_pulse_count_enable_read(struct counter_device *counter,
> +					    struct counter_count *count,
> +					    void *private, char *buf)
> +{
> +	struct gpio_pulse_priv *priv = counter->priv;
> +
> +	return sysfs_emit(buf, "%d\n", priv->enabled);
> +}
> +
> +static ssize_t gpio_pulse_count_enable_write(struct counter_device *counter,
> +					     struct counter_count *count,
> +					     void *private,
> +					     const char *buf, size_t len)
> +{
> +	struct gpio_pulse_priv *priv = counter->priv;
> +	bool enable;
> +	ssize_t ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->enabled == enable)
> +		return len;
> +
> +	priv->enabled = enable;
> +
> +	if (enable)
> +		enable_irq(priv->irq);
> +	else
> +		disable_irq(priv->irq);
> +
> +	return len;
> +}
> +
> +static const struct counter_count_ext gpio_pulse_count_ext[] = {
> +	{
> +		.name = "enable",
> +		.read = gpio_pulse_count_enable_read,
> +		.write = gpio_pulse_count_enable_write,
> +	},
> +};
> +
> +static enum counter_synapse_action gpio_pulse_synapse_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +};
> +
> +static int gpio_pulse_action_get(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    struct counter_synapse *synapse,
> +			    size_t *action)
> +{
> +	*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +
> +	return 0;
> +}
> +
> +static int gpio_pulse_count_read(struct counter_device *counter,
> +				 struct counter_count *count,
> +				 unsigned long *val)
> +{
> +	struct gpio_pulse_priv *priv = counter->priv;
> +
> +	*val = atomic_read(&priv->count);
> +
> +	return 0;
> +}
> +
> +static int gpio_pulse_count_write(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  const unsigned long val)
> +{
> +	struct gpio_pulse_priv *priv = counter->priv;
> +
> +	atomic_set(&priv->count, val);
> +
> +	return 0;
> +}
> +
> +static int gpio_pulse_count_function_get(struct counter_device *counter,
> +					 struct counter_count *count,
> +					 size_t *function)
> +{
> +	*function = COUNTER_COUNT_FUNCTION_INCREASE;
> +
> +	return 0;
> +}
> +
> +static int gpio_pulse_count_signal_read(struct counter_device *counter,
> +					struct counter_signal *signal,
> +					enum counter_signal_value *val)
> +{
> +	struct gpio_pulse_priv *priv = counter->priv;
> +	int ret;
> +
> +	ret = gpiod_get_value(priv->gpio);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> +
> +	return 0;
> +}
> +
> +static const struct counter_ops gpio_pulse_cnt_ops = {
> +	.action_get = gpio_pulse_action_get,
> +	.count_read = gpio_pulse_count_read,
> +	.count_write = gpio_pulse_count_write,
> +	.function_get = gpio_pulse_count_function_get,
> +	.signal_read  = gpio_pulse_count_signal_read,
> +};
> +
> +static struct counter_signal gpio_pulse_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "Channel 0 signal",
> +	},
> +};
> +
> +static struct counter_synapse gpio_pulse_count_synapses[] = {
> +	{
> +		.actions_list = gpio_pulse_synapse_actions,
> +		.num_actions = ARRAY_SIZE(gpio_pulse_synapse_actions),
> +		.signal = &gpio_pulse_signals[0]
> +	},
> +};
> +
> +static enum counter_count_function gpio_pulse_count_functions[] = {
> +	COUNTER_COUNT_FUNCTION_INCREASE,
> +};
> +
> +static struct counter_count gpio_pulse_counts[] = {
> +	{
> +		.id = 0,
> +		.name = "Channel 1 Count",
> +		.functions_list = gpio_pulse_count_functions,
> +		.num_functions = ARRAY_SIZE(gpio_pulse_count_functions),
> +		.synapses = gpio_pulse_count_synapses,
> +		.num_synapses = ARRAY_SIZE(gpio_pulse_count_synapses),
> +		.ext = gpio_pulse_count_ext,
> +		.num_ext = ARRAY_SIZE(gpio_pulse_count_ext),
> +	},
> +};
> +
> +static int gpio_pulse_cnt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gpio_pulse_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (gpiod_count(dev, NULL) != 1) {
> +		dev_err(dev, "Error, need exactly 1 gpio for device\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->gpio = devm_gpiod_get(dev, NULL, GPIOD_IN);
> +	if (IS_ERR(priv->gpio))
> +		return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get gpio\n");
> +
> +	priv->irq = gpiod_to_irq(priv->gpio);
> +	if (priv->irq < 0) {
> +		dev_err(dev, "failed to map GPIO to IRQ: %d\n", priv->irq);
> +		return priv->irq;
> +	}
> +
> +	priv->counter.name = dev_name(dev);
> +	priv->counter.parent = dev;
> +	priv->counter.ops = &gpio_pulse_cnt_ops;
> +	priv->counter.counts = gpio_pulse_counts;
> +	priv->counter.num_counts = ARRAY_SIZE(gpio_pulse_counts);
> +	priv->counter.signals = gpio_pulse_signals;
> +	priv->counter.num_signals = ARRAY_SIZE(gpio_pulse_signals);
> +	priv->counter.priv = priv;
> +
> +	ret = devm_request_irq(dev, priv->irq, gpio_pulse_irq_isr,
> +			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> +			       GPIO_PULSE_NAME, priv);
> +	if (ret)
> +		return ret;
> +
> +	disable_irq(priv->irq);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return devm_counter_register(dev, &priv->counter);
> +}
> +
> +static const struct of_device_id gpio_pulse_cnt_of_match[] = {
> +	{ .compatible = "virtual,gpio-pulse-counter", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, gpio_pulse_cnt_of_match);
> +
> +static struct platform_driver gpio_pulse_cnt_driver = {
> +	.probe = gpio_pulse_cnt_probe,
> +	.driver = {
> +		.name = GPIO_PULSE_NAME,
> +		.of_match_table = gpio_pulse_cnt_of_match,
> +	},
> +};
> +module_platform_driver(gpio_pulse_cnt_driver);
> +
> +MODULE_ALIAS("platform:gpio-pulse-counter");
> +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> +MODULE_DESCRIPTION("GPIO pulse counter driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
