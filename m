Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 365D91295E6
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 13:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLWMRk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 07:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLWMRk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 07:17:40 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581802063A;
        Mon, 23 Dec 2019 12:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577103459;
        bh=xjCjQdzvRJ5zNA32DqIdJjJF5xCIjCLnY3npcX8PgDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QqGGlWTVwgQmb8tZx/+t0rH2TD74i+fDsWaqG9CSqMdKjWHqRjrxE6ZvIbsD+cM/Q
         Vaig0u6nGYzcSbrh+//fZXq36AIkECIucBkwSsuN/Em7tYiKkZS+8dcDWOZvIBqB3R
         fY2HmyKULv1blmXS/D11fBzV32us1cDKHa/aT48g=
Date:   Mon, 23 Dec 2019 12:17:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 05/10] iio: trigger: at91-rtc-trigger: introduce at91
 rtc adc trigger driver
Message-ID: <20191223121734.2fb2581b@archlinux>
In-Reply-To: <1576686157-11939-6-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
        <1576686157-11939-6-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Dec 2019 16:24:01 +0000
<Eugen.Hristev@microchip.com> wrote:

> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> The AT91 RTC ADC trigger driver registers a trigger into the iio subsystem,
> which can be associated with at91_sama5d2-adc compatible drivers.
> The SAMA5D2 SoC contains a hardware link between the RTC block and the ADC
> block that will allow the RTC to trigger the ADC to perform conversions.
> The at91-rtc-trigger will allow the customisation of the trigger frequency
> from sysfs:
> trigger_frequency_hz_available will display possible frequencies in Hz
> trigger_frequency_hz will allow configuring this frequency.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

A few things inline.  Be careful in particular of mixing managed
and unmanaged calls.  Here you didn't actually need to, but they can cause
some really nasty and hard to debug races.

Simple rule of thumb. The first time you hit a non managed function stop
using any other managed functions after that point.  Here you sort
of did that with the devm_add_action_or_reset, but it needs to be step
wise to guarantee the ordering is all correct and you lumped two different
functions together and didn't take into account the _or_reset element
of the above.

Jonathan

> ---
>  drivers/iio/trigger/Kconfig            |  10 ++
>  drivers/iio/trigger/Makefile           |   1 +
>  drivers/iio/trigger/at91-rtc-trigger.c | 213 +++++++++++++++++++++++++++++++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 drivers/iio/trigger/at91-rtc-trigger.c
> 
> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
> index 8cef2f7..dc7e6f4 100644
> --- a/drivers/iio/trigger/Kconfig
> +++ b/drivers/iio/trigger/Kconfig
> @@ -68,4 +68,14 @@ config IIO_SYSFS_TRIGGER
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called iio-trig-sysfs.
>  
> +config IIO_AT91_RTC_TRIGGER
> +	tristate "AT91 RTC trigger"
> +	help
> +	  Provides support for using AT91 RTC IP block to generate trigger
> +	  events for ADC devices.
> +	  If unsure, say N (but it's safe to say "Y").
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called at91-rtc-trigger.
> +
>  endmenu
> diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
> index f3d11ac..6512436 100644
> --- a/drivers/iio/trigger/Makefile
> +++ b/drivers/iio/trigger/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_IIO_STM32_LPTIMER_TRIGGER) += stm32-lptimer-trigger.o
>  obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) += stm32-timer-trigger.o
>  obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
>  obj-$(CONFIG_IIO_TIGHTLOOP_TRIGGER) += iio-trig-loop.o
> +obj-$(CONFIG_IIO_AT91_RTC_TRIGGER) += at91-rtc-trigger.o
> diff --git a/drivers/iio/trigger/at91-rtc-trigger.c b/drivers/iio/trigger/at91-rtc-trigger.c
> new file mode 100644
> index 0000000..8cdcfeb
> --- /dev/null
> +++ b/drivers/iio/trigger/at91-rtc-trigger.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2019 Microchip Technology, Inc. and its subsidiaries
> + *
> + * Author: Eugen Hristev <eugen.hristev@microchip.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/irq_work.h>

Check your headers :)  irq_work is a somewhat obscure so it
stood out as rather an odd entry.

> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +
> +#define at91_adc_readl(t, reg)		readl_relaxed((t)->base + (reg))
> +#define at91_adc_writel(t, reg, val)	writel_relaxed(val, (t)->base + (reg))

Given these are only used in one place each, probably better to just
put the code inline.

> +
> +#define AT91_RTC_MR		0x4
> +#define AT91_RTC_OUT0_MASK	GENMASK(18, 16)
> +#define AT91_RTC_OUT0_NO_WAVE	(0x0 << 16)
> +#define AT91_RTC_OUT0_1HZ	(0x1 << 16)
> +#define AT91_RTC_OUT0_32HZ	(0x2 << 16)
> +#define AT91_RTC_OUT0_64HZ	(0x3 << 16)
> +#define AT91_RTC_OUT0_512HZ	(0x4 << 16)

This might be better done as a an enum and FIELD_PREP 
define

> +
> +/* attribute pack list */
> +#define AT91_RTC_1HZ		1
> +#define AT91_RTC_32HZ		32
> +#define AT91_RTC_64HZ		64
> +#define AT91_RTC_512HZ		512

I'm not keen on defines that match the thing in them.
Just use the values directly.

> +
> +struct at91_rtc_adc_trig {
> +	struct iio_trigger	*trig;
> +	void __iomem		*base;
> +	unsigned int		hz_config;
> +};
> +
> +static int at91_hz_config_sysfs_to_reg(unsigned int hz_config)
> +{
> +	switch (hz_config) {
> +	case AT91_RTC_1HZ:
> +		return AT91_RTC_OUT0_1HZ;
> +	case AT91_RTC_32HZ:
> +		return AT91_RTC_OUT0_32HZ;
> +	case AT91_RTC_64HZ:
> +		return AT91_RTC_OUT0_64HZ;
> +	case AT91_RTC_512HZ:
> +		return AT91_RTC_OUT0_512HZ;
> +	}
> +	return AT91_RTC_OUT0_1HZ;
> +}
> +
> +static int at91_configure_trigger(struct iio_trigger *trig, bool state)
> +{
> +	struct at91_rtc_adc_trig *t = iio_trigger_get_drvdata(trig);
> +	u32 mr = at91_adc_readl(t, AT91_RTC_MR);
> +
> +	mr &= ~AT91_RTC_OUT0_MASK;
> +
> +	if (state)
> +		mr |= at91_hz_config_sysfs_to_reg(t->hz_config);
> +
> +	at91_adc_writel(t, AT91_RTC_MR, mr);
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops at91_rtc_adc_trigger_ops = {
> +	.set_trigger_state = &at91_configure_trigger,
> +};
> +
> +static ssize_t at91_rtc_trigger_frequency_get(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	struct at91_rtc_adc_trig *t = iio_trigger_get_drvdata(trig);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", t->hz_config);
> +}
> +
> +static ssize_t at91_rtc_trigger_frequency_set(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t count)
> +{
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	struct at91_rtc_adc_trig *t = iio_trigger_get_drvdata(trig);
> +	int ret;
> +	unsigned int val;
> +
> +	ret = kstrtou32(buf, 10, &val);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (val != AT91_RTC_1HZ && val != AT91_RTC_32HZ &&
> +	    val != AT91_RTC_64HZ && val != AT91_RTC_512HZ)
> +		return -EINVAL;
> +
> +	t->hz_config = val;
> +
> +	return count;
> +}
> +
> +static IIO_DEVICE_ATTR(trigger_frequency_hz, 0644,
There is some convention for this we should keep to.
ht-timer-trigger uses

"sampling_frequency" which seems to make sense here.

> +		       at91_rtc_trigger_frequency_get,
> +		       at91_rtc_trigger_frequency_set, 0);
> +
> +static IIO_CONST_ATTR(trigger_frequency_hz_available,
> +		      __stringify(AT91_RTC_1HZ) " "
> +		      __stringify(AT91_RTC_32HZ) " "
> +		      __stringify(AT91_RTC_64HZ) " "
> +		      __stringify(AT91_RTC_512HZ));
> +
> +static struct attribute *at91_rtc_adc_trigger_attributes[] = {
> +	&iio_const_attr_trigger_frequency_hz_available.dev_attr.attr,
> +	&iio_dev_attr_trigger_frequency_hz.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group at91_rtc_adc_trigger_attribute_group = {
> +	.attrs = at91_rtc_adc_trigger_attributes,
> +};
> +
> +static const struct attribute_group *at91_rtc_adc_trigger_attr_groups[] = {
> +	&at91_rtc_adc_trigger_attribute_group,
> +	NULL
> +};
> +
> +static void at91_rtc_adc_trigger_remove(void *priv)
> +{
> +	struct at91_rtc_adc_trig *t = priv;
> +
> +	iio_trigger_unregister(t->trig);
> +	iio_trigger_free(t->trig);

> +}
> +
> +static int at91_rtc_adc_trigger_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource	*res;
> +	struct at91_rtc_adc_trig *t;
> +	int ret = 0;
> +
> +	t = devm_kzalloc(dev, sizeof(*t), GFP_KERNEL);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	t->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(t->base))
> +		return PTR_ERR(t->base);
> +
> +	t->trig = iio_trigger_alloc("%x.at91_rtc_adc", res->start);
> +	if (!t->trig) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +
> +	t->hz_config = AT91_RTC_1HZ;
> +
> +	t->trig->ops = &at91_rtc_adc_trigger_ops;
> +	t->trig->dev.parent = dev;
> +	t->trig->dev.groups = at91_rtc_adc_trigger_attr_groups;
> +
> +	iio_trigger_set_drvdata(t->trig, t);
> +
> +	ret = iio_trigger_register(t->trig);
> +	if (ret) {
> +		dev_err(dev, "failed to register trigger.\n");
> +		goto at91_rtc_adc_trigger_probe_fail_register;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, at91_rtc_adc_trigger_remove, t);
> +	if (ret) {
This rings alarm bells.  There should definitely never be anything 
to do in an error handler for a call to devm_add_action_or_reset.

The remove order should be in the inverse of probe.  Hence if I see a devm
function called after something that needs to be unwound by hand it
screams race condition of bug.  Now there may not actually be one, but
it fails the obviously correct test so I'm not going to spend time working
out if there is ;)

However, both the things that can unwound are undoing things I'm
fairly sure have managed forms.

devm_iio_trigger_register
devm_iio_trigger_alloc

Use them and it will all work fine I think.

Note that the trigger_remove function gets called on any error
in devm_add_action_or_reset so you'd have had a double free here
if you ever hit this path.

> +		dev_err(dev, "failed to add disable action.\n");
> +		goto at91_rtc_adc_trigger_probe_fail_add_action;
> +	}
> +
> +	return 0;
> +
> +at91_rtc_adc_trigger_probe_fail_add_action:
> +	iio_trigger_unregister(t->trig);
> +at91_rtc_adc_trigger_probe_fail_register:
> +	iio_trigger_free(t->trig);
> +	return ret;
> +}
> +
> +static const struct of_device_id at91_rtc_adc_trigger_of_match[] = {
> +	{
> +		.compatible = "microchip,rtc-adc-trigger",
> +	},
> +	{ /* end node */ },
> +};
> +MODULE_DEVICE_TABLE(of, at91_rtc_adc_trigger_of_match);
> +
> +static struct platform_driver at91_rtc_adc_trigger_driver = {
> +	.probe = at91_rtc_adc_trigger_probe,
> +	.driver = {
> +		.name = "at91-rtc-adc-trigger",
> +		.of_match_table = at91_rtc_adc_trigger_of_match,
> +	},
> +};
> +module_platform_driver(at91_rtc_adc_trigger_driver);
> +
> +MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
> +MODULE_DESCRIPTION("AT91 RTC ADC trigger driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:iio-at91-rtc-trigger");

