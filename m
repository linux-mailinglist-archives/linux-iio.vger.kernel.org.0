Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B198030167C
	for <lists+linux-iio@lfdr.de>; Sat, 23 Jan 2021 16:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbhAWPu3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Jan 2021 10:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbhAWPu2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Jan 2021 10:50:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15F32231F;
        Sat, 23 Jan 2021 15:49:45 +0000 (UTC)
Date:   Sat, 23 Jan 2021 15:49:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
Message-ID: <20210123154941.5dd5fe00@archlinux>
In-Reply-To: <20210121155700.9267-2-mike.looijmans@topic.nl>
References: <20210121155700.9267-1-mike.looijmans@topic.nl>
        <20210121155700.9267-2-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 16:56:59 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 

..

> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> new file mode 100644
> index 000000000000..d7dc6f3e2fa6
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -0,0 +1,632 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
> + *  - BMI088
> + *
> + * Copyright (c) 2018-2021, Topic Embedded Products
> + */
> +
> +#include <asm/unaligned.h>

Ah.  I forgot to highlight this one.  Oddly convention is
to do alphabetical order, but in groups.  Generic first
(e.g. linux/*.h) and then specific (asm/*) and finally
as you have it, local headers.

Mind you it's not universal in the kernel, but I think this
is one of the more common patterns and it's definitely
preferred in IIO. 

> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include "bmi088-accel.h"
> +
...

> +static int bmi088_accel_set_power_state_on(struct bmi088_accel_data *data)

Linus Walleij's query in v6 needs addressing (it crossed with you posting v7 I think)

> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_set_power_state_off(struct bmi088_accel_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	ret = pm_runtime_put_autosuspend(dev);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +/*
> + * The register ACC_PWR_CTRL enables and disables the accelerometer and the
> + * temperature sensor.
> + */
> +static int bmi088_accel_enable(struct bmi088_accel_data *data, bool on_off)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int val = on_off ? 0x4 : 0x0;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL, val);
> +	if (ret) {
> +		dev_err(dev, "Error writing ACC_PWR_CTRL reg\n");
> +		return ret;
> +	}
> +	/* Datasheet recommends to wait at least 5ms before communication */
> +	usleep_range(5000, 6000);
> +
> +	return 0;
> +}
> +
> +/* In suspend mode, only the accelerometer is powered down. */
> +static int bmi088_accel_set_mode(struct bmi088_accel_data *data,
> +				enum bmi088_power_modes mode)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int val = mode == BMI088_ACCEL_MODE_SUSPEND ? 0x3 : 0x0;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CONF, val);
> +	if (ret) {
> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
...

> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
> +	int irq, const char *name, bool block_supported)
> +{
> +	struct bmi088_accel_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	data->regmap = regmap;
> +
> +	ret = bmi088_accel_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = data->chip_info->channels;
> +	indio_dev->num_channels = data->chip_info->num_channels;
> +	indio_dev->name = name ? name : data->chip_info->name;
> +	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &bmi088_accel_info;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, BMI088_AUTO_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		dev_err(dev, "Unable to register iio device\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(bmi088_accel_core_probe);
> +
> +static void bmi088_accel_suspend_impl(struct bmi088_accel_data *data)
> +{
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +	bmi088_accel_enable(data, false);
> +	mutex_unlock(&data->mutex);
> +}accel_supsn
> +
> +int bmi088_accel_core_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +	bmi088_accel_suspend_impl(data);
Sorry, did read your response to v6 review quick enough or I'd have
commented on it there.

Whilst it seems convenient I would rather you didn't use this shared
function.  It obscures what is going on a little so it's not obvious
which elements of probe this is undoing.

the accel_enable is buried in *chip_init() so I'd ideally like to
see an *chip_uninit() that undoes only what was done in chip_init()
(next to it so it's easy to check!)

The set_mode() bit is harder to identify in probe and actually makes
me a bit suspicious.  If we probe the driver and immediately read
I suspect the device may not actually be turned on?
 

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bmi088_accel_core_remove);
> +
> +/* When going into system sleep, put the chip in power down */
> +static int __maybe_unused bmi088_accel_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	bmi088_accel_suspend_impl(data);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused bmi088_accel_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_enable(data, true);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +/* For runtime PM put the chip in suspend mode */
> +static int __maybe_unused bmi088_accel_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	return bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +}
> +
> +static int __maybe_unused bmi088_accel_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(BMI088_ACCEL_MAX_STARTUP_TIME_US,
> +		     BMI088_ACCEL_MAX_STARTUP_TIME_US * 2);
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops bmi088_accel_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(bmi088_accel_suspend, bmi088_accel_resume)
> +	SET_RUNTIME_PM_OPS(bmi088_accel_runtime_suspend,
> +			   bmi088_accel_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_GPL(bmi088_accel_pm_ops);
> +
> +MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMI088 accelerometer driver (core)");

...
