Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD8320B0E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 15:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhBUOrJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 09:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhBUOrE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 09:47:04 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED85C601FB;
        Sun, 21 Feb 2021 14:46:19 +0000 (UTC)
Date:   Sun, 21 Feb 2021 14:46:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210221144616.4eef6a79@archlinux>
In-Reply-To: <20210212172235.507028-2-jbhayana@google.com>
References: <20210212172235.507028-1-jbhayana@google.com>
        <20210212172235.507028-2-jbhayana@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 17:22:35 +0000
Jyoti Bhayana <jbhayana@google.com> wrote:

> This change provides ARM SCMI Protocol based IIO device.
> This driver provides support for Accelerometer and Gyroscope using
> SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM specification

Hi Joyti

A few things inline but nothing to require a v7.

1) Use of long long to get s64 - I can tidy that up whilst applying.
2) Going to have a clash with Alex's multi buffer rework of the core
   I'll sort that out when I apply this as well.

> 
> Reported-by: kernel test robot <lkp@intel.com>

For fixes within a larger patch as a result of the various build robots,
we should either only mention them in comments, or add a note after the
Reported-by to say what was fixed.  E.g something like

Reported-by: kernel test robot <lkp@intel.com> # off by 1 error

I can't remember what was actually reported for this one.

If you can reply with such a comment I'll add it on, if not I'll drop
the Reported-by as uninformative.   Right now it looks like the whole
patch is a fix for an issue that 0-day reported :)


> Signed-off-by: Jyoti Bhayana <jbhayana@google.com>
> ---
>  MAINTAINERS                                |   6 +
>  drivers/firmware/arm_scmi/driver.c         |   2 +-
>  drivers/iio/common/Kconfig                 |   1 +
>  drivers/iio/common/Makefile                |   1 +
>  drivers/iio/common/scmi_sensors/Kconfig    |  18 +
>  drivers/iio/common/scmi_sensors/Makefile   |   5 +
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 678 +++++++++++++++++++++
>  7 files changed, 710 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
>  create mode 100644 drivers/iio/common/scmi_sensors/Makefile
>  create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b516bb34a8d5..ccf37d43ab41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8567,6 +8567,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
>  F:	drivers/iio/multiplexer/iio-mux.c
>  
> +IIO SCMI BASED DRIVER
> +M:	Jyoti Bhayana <jbhayana@google.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/common/scmi_sensors/scmi_iio.c
> +

...

> diff --git a/drivers/iio/common/scmi_sensors/Makefile b/drivers/iio/common/scmi_sensors/Makefile
> new file mode 100644
> index 000000000000..f13140a2575a
> --- /dev/null
> +++ b/drivers/iio/common/scmi_sensors/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX - License - Identifier : GPL - 2.0 - only
> +#
> +# Makefile for the IIO over SCMI
> +#
> +obj-$(CONFIG_IIO_SCMI) += scmi_iio.o
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> new file mode 100644
> index 000000000000..31977c3bc600
> --- /dev/null
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -0,0 +1,678 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * System Control and Management Interface(SCMI) based IIO sensor driver
> + *
> + * Copyright (C) 2021 Google LLC
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#define SCMI_IIO_NUM_OF_AXIS 3
> +
> +struct scmi_iio_priv {
> +	struct scmi_handle *handle;
> +	const struct scmi_sensor_info *sensor_info;
> +	struct iio_dev *indio_dev;
> +	/* adding one additional channel for timestamp */
> +	long long iio_buf[SCMI_IIO_NUM_OF_AXIS + 1];

Missed this previously but we should probably be careful to
make this explicitly 64 bit rather than rely on long long being
that length. s64 iio_buf[SCMI_IIO_NUM_OF_AXIS + 1];

I can tidy this up whilst applying if that is fine with you.

> +	struct notifier_block sensor_update_nb;
> +	u32 *freq_avail;
> +};
> +

...

> +
> +static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
> +					  uintptr_t private,
> +					  const struct iio_chan_spec *chan,
> +					  char *buf)

Looks good.  Thanks for persevering with this!

> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	unsigned long long resolution, rem;
> +	long long min_range, max_range;
> +	s8 exponent, scale;
> +	int len = 0;
> +
> +	/*
> +	 * All the axes are supposed to have the same value for range and resolution.
> +	 * We are just using the values from the Axis 0 here.
> +	 */
> +	if (sensor->sensor_info->axis[0].extended_attrs) {
> +		min_range = sensor->sensor_info->axis[0].attrs.min_range;
> +		max_range = sensor->sensor_info->axis[0].attrs.max_range;
> +		resolution = sensor->sensor_info->axis[0].resolution;
> +		exponent = sensor->sensor_info->axis[0].exponent;
> +		scale = sensor->sensor_info->axis[0].scale;
> +
> +		/*
> +		 * To provide the raw value for the resolution to the userspace,
> +		 * need to divide the resolution exponent by the sensor scale
> +		 */
> +		exponent = exponent - scale;
> +		if (exponent < 0) {
> +			resolution = div64_u64_rem(resolution,
> +						   int_pow(10, abs(exponent)),
> +						   &rem);
> +			len = scnprintf(buf, PAGE_SIZE,
> +					"[%lld %llu.%llu %lld]\n", min_range,
> +					resolution, rem, max_range);
> +		} else {
> +			resolution = resolution * int_pow(10, exponent);
> +			len = scnprintf(buf, PAGE_SIZE, "[%lld %llu %lld]\n",
> +					min_range, resolution, max_range);
> +		}
> +	}
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info scmi_iio_ext_info[] = {
> +	{
> +		.name = "raw_available",
> +		.read = scmi_iio_get_raw_available,
> +		.shared = IIO_SHARED_BY_TYPE,
> +	},
> +	{},
> +};
> +
> +static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_chan,
> +					   int scan_index)

Not relevant to this patch!:  I wonder how many times
we now have this replicated in various drivers.  Feels like a good thing
to just have as a library function in the IIO core.
(about 8 copies of this from a quick grep)

> +{
> +	iio_chan->type = IIO_TIMESTAMP;
> +	iio_chan->channel = -1;
> +	iio_chan->scan_index = scan_index;
> +	iio_chan->scan_type.sign = 'u';
> +	iio_chan->scan_type.realbits = 64;
> +	iio_chan->scan_type.storagebits = 64;
> +}
> +

...

> +
> +static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)

Really trivial, but if you happen to be respinning for some reason, the
naming of this function is a little confusing.  My initial
thought is it would somehow specify the sampling frequencies that
the driver expects to be available, rather than the opposite where
it is the driver establishing what is available.

If _get_ is also ambiguous, perhaps _query_ or _format_ or _convert_
(to reflect you are converting values to expected form).

> +{
> +	u64 cur_interval_ns, low_interval_ns, high_interval_ns, step_size_ns,
> +		hz, uhz;
...

> +}
> +
> +static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> +{
> +	struct iio_buffer *buffer;
> +
> +	buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	iio_device_attach_buffer(scmi_iiodev, buffer);
> +	scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
> +	scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;

Ah.  This has now crossed with Alex's large rework of the buffer
registration in the core (to support multiple buffers).

Specifically it needs to flip over to using the function introduced
in https://lore.kernel.org/linux-iio/20210215104043.91251-3-alexandru.ardelean@analog.com/T/#u

This is going to make taking this via an immutable branch more fiddly.
Don't worry about it though; I'll figure it out once rc1 is out.
(either the merge of this tree will have to before Alex's series, or
I'll need to do a non trivial merge resolution).

The one thing we can't do is rebase this series as that would then delay
Cristian's work for a whole cycle (or require some usual tree management.)
What fun :)

> +	return 0;
> +}
> +
> +static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> +					 struct scmi_handle *handle,
> +					 const struct scmi_sensor_info *sensor_info)
> +{
> +	struct iio_chan_spec *iio_channels;
> +	struct scmi_iio_priv *sensor;
> +	enum iio_modifier modifier;
> +	enum iio_chan_type type;
> +	struct iio_dev *iiodev;
> +	int i, ret;
> +
> +	iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> +	if (!iiodev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	iiodev->modes = INDIO_DIRECT_MODE;
> +	iiodev->dev.parent = dev;
> +	sensor = iio_priv(iiodev);
> +	sensor->handle = handle;
> +	sensor->sensor_info = sensor_info;
> +	sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
> +	sensor->indio_dev = iiodev;
> +
> +	/* adding one additional channel for timestamp */
> +	iiodev->num_channels = sensor_info->num_axis + 1;
> +	iiodev->name = sensor_info->name;
> +	iiodev->info = &scmi_iio_info;
> +
> +	iio_channels =
> +		devm_kzalloc(dev,
> +			     sizeof(*iio_channels) * (iiodev->num_channels),
> +			     GFP_KERNEL);
> +	if (!iio_channels)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = scmi_iio_set_sampling_freq_avail(iiodev);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	for (i = 0; i < sensor_info->num_axis; i++) {
> +		ret = scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
> +		ret = scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
> +						 &modifier);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
> +		scmi_iio_set_data_channel(&iio_channels[i], type, modifier,
> +					  sensor_info->axis[i].id);
> +	}
> +
> +	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> +	iiodev->channels = iio_channels;
> +	return iiodev;
> +}
> +
> +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> +{
> +	const struct scmi_sensor_info *sensor_info;
> +	struct scmi_handle *handle = sdev->handle;
> +	struct device *dev = &sdev->dev;
> +	struct iio_dev *scmi_iio_dev;
> +	u16 nr_sensors;
> +	int err = -ENODEV, i;
> +
> +	if (!handle || !handle->sensor_ops) {
> +		dev_err(dev, "SCMI device has no sensor interface\n");
> +		return -EINVAL;
> +	}
> +
> +	nr_sensors = handle->sensor_ops->count_get(handle);
> +	if (!nr_sensors) {
> +		dev_dbg(dev, "0 sensors found via SCMI bus\n");
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < nr_sensors; i++) {
> +		sensor_info = handle->sensor_ops->info_get(handle, i);
> +		if (!sensor_info) {
> +			dev_err(dev, "SCMI sensor %d has missing info\n", i);
> +			return -EINVAL;
> +		}
> +
> +		/* This driver only supports 3-axis accel and gyro, skipping other sensors */
> +		if (sensor_info->num_axis != SCMI_IIO_NUM_OF_AXIS)
> +			continue;
> +
> +		/* This driver only supports 3-axis accel and gyro, skipping other sensors */
> +		if (sensor_info->axis[0].type != METERS_SEC_SQUARED &&
> +		    sensor_info->axis[0].type != RADIANS_SEC)
> +			continue;
> +
> +		scmi_iio_dev = scmi_alloc_iiodev(dev, handle, sensor_info);
> +		if (IS_ERR(scmi_iio_dev)) {
> +			dev_err(dev,
> +				"failed to allocate IIO device for sensor %s: %ld\n",
> +				sensor_info->name, PTR_ERR(scmi_iio_dev));
> +			return PTR_ERR(scmi_iio_dev);
> +		}
> +
> +		err = scmi_iio_buffers_setup(scmi_iio_dev);
> +		if (err < 0) {
> +			dev_err(dev,
> +				"IIO buffer setup error at sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
> +		}
> +
> +		err = devm_iio_device_register(dev, scmi_iio_dev);
> +		if (err) {
> +			dev_err(dev,
> +				"IIO device registration failed at sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
> +		}
> +	}
> +	return err;
> +}
