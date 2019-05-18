Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F365F222CC
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfERJx5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 05:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbfERJx4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 05:53:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A432087B;
        Sat, 18 May 2019 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558173235;
        bh=nH8wG+AgfE3SgR+gYOli6KTyIiNzg9AL+R98lfDrjcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RfeNW9OvSTNL2xYwdJ3GHeRfIu6QWUo/nbEN21niTl/qUpHAnJ1XhzZ1XmUS6lNP5
         ycgwf7w+jMFdKdOZTivW2EYnjSui91pQ5UqPLb+qYO51UGAeIETLYumI+PTaDNsZhh
         5/QbyshfLjr2KLhvKp0gzxHeZpIu9oLNu2+kJa4c=
Date:   Sat, 18 May 2019 10:53:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: cros_ec: Add lid angle driver
Message-ID: <20190518105350.1a863bfd@archlinux>
In-Reply-To: <20190517233856.155793-3-gwendal@chromium.org>
References: <20190517233856.155793-1-gwendal@chromium.org>
        <20190517233856.155793-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 May 2019 16:38:56 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add a IIO driver that reports the angle between the lid and the base for
> ChromeOS convertible device.
> 
> Tested on eve with ToT EC firmware.
> Check driver is loaded and lid angle is correct.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Hi Gwendal.

Please do list dependencies in patches.  I think this one is still
dependent on the larger set of MFD changes. 

For my reference

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Please do poke if this seems to have gotten lost once the precursors
are upstream.

Thanks,

Jonathan

> ---
> Changes in v7:
> - Split patch in two: This is the IIO section.
> 
> Changes in v6:
> - Fix lock held in an error path error.
> 
> Changes in v5:
> - Remove unnecessary define.
> - v4 was the wrong patch file
> 
> Changes in v3:
> - Use static channel array, simplify code because index is always 0.
> 
> Changes in v2:
> - Fix license, remove driver_module field.
> 
>  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
>  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
>  .../cros_ec_sensors/cros_ec_lid_angle.c       | 139 ++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> index 135f6825903f..aacc2ab9c34f 100644
> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
>  	  Accelerometers, Gyroscope and Magnetometer that are
>  	  presented by the ChromeOS EC Sensor hub.
>  	  Creates an IIO device for each functions.
> +
> +config IIO_CROS_EC_SENSORS_LID_ANGLE
> +	tristate "ChromeOS EC Sensor for lid angle"
> +	depends on IIO_CROS_EC_SENSORS_CORE
> +	help
> +	  Module to report the angle between lid and base for some
> +	  convertible devices.
> +	  This module is loaded when the EC can calculate the angle between the base
> +	  and the lid.
> diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
> index ec716ff2a775..a35ee232ac07 100644
> --- a/drivers/iio/common/cros_ec_sensors/Makefile
> +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> @@ -4,3 +4,4 @@
>  
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
> +obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> new file mode 100644
> index 000000000000..876dfd176b0e
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
> + *
> + * Copyright 2018 Google, Inc
> + *
> + * This driver uses the cros-ec interface to communicate with the Chrome OS
> + * EC about counter sensors. Counters are presented through
> + * iio sysfs.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/cros_ec_sensors_core.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DRV_NAME "cros-ec-lid-angle"
> +
> +/*
> + * One channel for the lid angle, the other for timestamp.
> + */
> +static const struct iio_chan_spec cros_ec_lid_angle_channels[] = {
> +	{
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_type.realbits = CROS_EC_SENSOR_BITS,
> +		.scan_type.storagebits = CROS_EC_SENSOR_BITS,
> +		.scan_type.sign = 'u',
> +		.type = IIO_ANGL
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1)
> +};
> +
> +/* State data for ec_sensors iio driver. */
> +struct cros_ec_lid_angle_state {
> +	/* Shared by all sensors */
> +	struct cros_ec_sensors_core_state core;
> +};
> +
> +static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
> +					  unsigned long scan_mask, s16 *data)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
> +	ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
> +	if (ret) {
> +		dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
> +		return ret;
> +	}
> +
> +	*data = st->resp->lid_angle.value;
> +	return 0;
> +}
> +
> +static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    int *val, int *val2, long mask)
> +{
> +	struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
> +	s16 data;
> +	int ret;
> +
> +	mutex_lock(&st->core.cmd_lock);
> +	ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
> +	if (ret == 0) {
> +		*val = data;
> +		ret = IIO_VAL_INT;
> +	}
> +	mutex_unlock(&st->core.cmd_lock);
> +	return ret;
> +}
> +
> +static const struct iio_info cros_ec_lid_angle_info = {
> +	.read_raw = &cros_ec_lid_angle_read,
> +};
> +
> +static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct cros_ec_lid_angle_state *state;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &cros_ec_lid_angle_info;
> +	state = iio_priv(indio_dev);
> +	indio_dev->channels = cros_ec_lid_angle_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
> +
> +	state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +			cros_ec_sensors_capture, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> +	{
> +		.name = DRV_NAME,
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
> +
> +static struct platform_driver cros_ec_lid_angle_platform_driver = {
> +	.driver = {
> +		.name	= DRV_NAME,
> +		.pm	= &cros_ec_sensors_pm_ops,
> +	},
> +	.probe		= cros_ec_lid_angle_probe,
> +	.id_table	= cros_ec_lid_angle_ids,
> +};
> +module_platform_driver(cros_ec_lid_angle_platform_driver);
> +
> +MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
> +MODULE_LICENSE("GPL v2");

