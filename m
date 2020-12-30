Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1671E2E79BE
	for <lists+linux-iio@lfdr.de>; Wed, 30 Dec 2020 14:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL3Nlw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 08:41:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgL3Nlw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 08:41:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A71206A5;
        Wed, 30 Dec 2020 13:41:08 +0000 (UTC)
Date:   Wed, 30 Dec 2020 13:41:04 +0000
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
        ankitarora@google.com
Subject: Re: [RFC PATCH v2 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20201230134104.48d07ff5@archlinux>
In-Reply-To: <20201224031921.1547519-2-jbhayana@google.com>
References: <20201224031921.1547519-1-jbhayana@google.com>
        <20201224031921.1547519-2-jbhayana@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Dec 2020 03:19:21 +0000
Jyoti Bhayana <jbhayana@google.com> wrote:

> This change provides ARM SCMI Protocol based IIO device.
> This driver provides support for Accelerometer and Gyroscope using
> new SCMI Sensor Protocol defined by the upcoming SCMIv3.0
> ARM specification
> 
> Signed-off-by: Jyoti Bhayana <jbhayana@google.com>

Hi Jyoti,

There are a few things that still need thought it in here.  I've raised
various bits inline.  Note that some of them apply to whole driver
rather than just the specific instance I've mentioned.

Thanks,

Jonathan

> ---
>  MAINTAINERS                                |   6 +
>  drivers/iio/common/Kconfig                 |   1 +
>  drivers/iio/common/Makefile                |   1 +
>  drivers/iio/common/scmi_sensors/Kconfig    |  18 +
>  drivers/iio/common/scmi_sensors/Makefile   |   5 +
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 696 +++++++++++++++++++++
>  6 files changed, 727 insertions(+)
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
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
>  R:	Lars-Peter Clausen <lars@metafoo.de>
> diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
> index 2b9ee9161abd..0334b4954773 100644
> --- a/drivers/iio/common/Kconfig
> +++ b/drivers/iio/common/Kconfig
> @@ -6,5 +6,6 @@
>  source "drivers/iio/common/cros_ec_sensors/Kconfig"
>  source "drivers/iio/common/hid-sensors/Kconfig"
>  source "drivers/iio/common/ms_sensors/Kconfig"
> +source "drivers/iio/common/scmi_sensors/Kconfig"
>  source "drivers/iio/common/ssp_sensors/Kconfig"
>  source "drivers/iio/common/st_sensors/Kconfig"
> diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
> index 4bc30bb548e2..fad40e1e1718 100644
> --- a/drivers/iio/common/Makefile
> +++ b/drivers/iio/common/Makefile
> @@ -11,5 +11,6 @@
>  obj-y += cros_ec_sensors/
>  obj-y += hid-sensors/
>  obj-y += ms_sensors/
> +obj-y += scmi_sensors/
>  obj-y += ssp_sensors/
>  obj-y += st_sensors/
> diff --git a/drivers/iio/common/scmi_sensors/Kconfig b/drivers/iio/common/scmi_sensors/Kconfig
> new file mode 100644
> index 000000000000..67e084cbb1ab
> --- /dev/null
> +++ b/drivers/iio/common/scmi_sensors/Kconfig
> @@ -0,0 +1,18 @@
> +#
> +# IIO over SCMI
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "IIO SCMI Sensors"
> +
> +config IIO_SCMI
> +	tristate "IIO SCMI"
> +        depends on ARM_SCMI_PROTOCOL
> +        select IIO_BUFFER
> +        select IIO_KFIFO_BUF
> +	help
> +          Say yes here to build support for IIO SCMI Driver.
> +          This provides ARM SCMI Protocol based IIO device.
> +          This driver provides support for accelerometer and gyroscope
> +          sensors available on SCMI based platforms.
> +endmenu
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
> index 000000000000..2f5c884e22ab
> --- /dev/null
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -0,0 +1,696 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * System Control and Management Interface(SCMI) based IIO sensor driver
> + *
> + * Copyright (C) 2020 Google LLC
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
> +#define NSEC_MULT_POW_10 (const_ilog2(NSEC_PER_SEC) / const_ilog2(10))
> +#define UHZ_PER_HZ 1000000UL
> +#define ODR_EXPAND(odr, uodr) (((odr)*1000000ULL) + (uodr))
> +#define MAX_NUM_OF_CHANNELS 4
> +
> +struct scmi_iio_priv {
> +	struct scmi_handle *handle;
> +	const struct scmi_sensor_info *sensor_info;
> +	struct iio_dev *indio_dev;
> +	long long iio_buf[MAX_NUM_OF_CHANNELS];
> +	struct notifier_block sensor_update_nb;
> +	u32 *freq_avail;
> +};
> +
> +struct sensor_freq {
> +	u64 hz;
> +	u64 uhz;
> +};
> +
> +static int sensor_update_cb(struct notifier_block *nb, unsigned long event,
> +			    void *data)
> +{
> +	struct scmi_sensor_update_report *sensor_update = data;
> +	u64 time, time_ns;
> +	s64 sensor_value;
> +	struct iio_dev *scmi_iio_dev;
> +	s8 tstamp_scale_ns;
> +	int i;
> +	struct scmi_iio_priv *sensor =
> +		container_of(nb, struct scmi_iio_priv, sensor_update_nb);
> +
> +	scmi_iio_dev = sensor->indio_dev;
> +
> +	for (i = 0; i < sensor_update->readings_count; i++) {
> +		sensor_value = sensor_update->readings[i].value;
> +		time = sensor_update->readings[i].timestamp;

I'd like a comment for time.  I assume the assumption is that it's
the same for all the readings we get in a single call of this function?
Also better to only store it here if (sensor_info->timestamped) and
for that matter drop it out of the loop if they are all the same.

> +		sensor->iio_buf[i] = sensor_value;

Why the local variable for sensor_value?

		sensor->iio_buf[i] = sensor_update->readings[i].value;

> +	}
> +
> +	if (!sensor->sensor_info->timestamped) {
> +		time_ns = iio_get_time_ns(scmi_iio_dev);
> +	} else {
> +		tstamp_scale_ns =
> +			sensor->sensor_info->tstamp_scale + NSEC_MULT_POW_10;
> +		if (tstamp_scale_ns < 0) {
> +			tstamp_scale_ns = -1 * tstamp_scale_ns;

use absolute rather than -1 * as makes it explicit that result is unsigned.
Can do it inline in the line below.

> +			time_ns = div64_u64(time, int_pow(10, tstamp_scale_ns));
> +		} else {
> +			time_ns = time * int_pow(10, tstamp_scale_ns);
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(scmi_iio_dev, sensor->iio_buf,
> +					   time_ns);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int scmi_iio_buffer_preenable(struct iio_dev *dev)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(dev);
> +	u32 sensor_id = sensor->sensor_info->id;
> +	u32 sensor_config;
> +	int err;
> +
> +	if (sensor->sensor_info->timestamped)
> +		sensor_config |= FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,
> +					    SCMI_SENS_CFG_TSTAMP_ENABLE);
> +
> +	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +				    SCMI_SENS_CFG_SENSOR_ENABLE);
> +
> +	err = sensor->handle->notify_ops->register_event_notifier(
> +		sensor->handle, SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> +		&sensor_id, &sensor->sensor_update_nb);
> +	if (err) {
> +		pr_err("Error in registering sensor update notifier for sensor %s err %d",
> +		       sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	err = sensor->handle->sensor_ops->config_set(
> +		sensor->handle, sensor->sensor_info->id, sensor_config);
> +	if (err)
> +		pr_err("Error in enabling sensor %s err %d",
> +		       sensor->sensor_info->name, err);
> +
> +	return err;
> +}
> +
> +static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	u32 sensor_id = sensor->sensor_info->id;
> +	u32 sensor_config = 0;
> +	int err;
> +
> +	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +				    SCMI_SENS_CFG_SENSOR_DISABLE);
> +
> +	err = sensor->handle->notify_ops->unregister_event_notifier(
> +		sensor->handle, SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> +		&sensor_id, &sensor->sensor_update_nb);
> +	if (err) {
> +		pr_err("Error in unregistering sensor update notifier for sensor %s err %d",
> +		       sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
> +						     sensor_config);
> +	if (err)
> +		pr_err("Error in disabling sensor %s with err %d",
> +		       sensor->sensor_info->name, err);
> +
> +	return err;
> +}
> +
> +static const struct iio_buffer_setup_ops scmi_iio_buffer_ops = {
> +	.preenable = scmi_iio_buffer_preenable,
> +	.postdisable = scmi_iio_buffer_postdisable,
> +};
> +
> +static int scmi_iio_read_avail(struct iio_dev *iio_dev,
> +					 struct iio_chan_spec const *chan,
> +					 const int **vals,
> +					 int *type, int *length, long mask)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = sensor->freq_avail;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = sensor->sensor_info->intervals.count * 2;
> +		if (sensor->sensor_info->intervals.segmented)
> +			return IIO_AVAIL_RANGE;
> +		else
> +			return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	u32 sensor_config;
> +	u64 sec, mult, uHz;
> +	char buf[32];
> +
> +	int err = sensor->handle->sensor_ops->config_get(
> +		sensor->handle, sensor->sensor_info->id, &sensor_config);
> +	if (err) {
> +		pr_err("%s: Error in getting sensor config for sensor %s err %d",
> +		       __func__, sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	uHz = ODR_EXPAND(val, val2);
> +
> +	/*
> +	 * The seconds field in the sensor interval in SCMI is 16 bits long
> +	 * Therefore seconds  = 1/Hz <= 0xFFFF. As floating point calculations are
> +	 * discouraged in the kernel driver code, to calculate the scale factor (sf)
> +	 * (1* 1000000 * sf)/uHz <= 0xFFFF. Therefore, sf <= (uHz * 0xFFFF)/1000000
> +	 *  To calculate the multiplier,we convert the sf into char string  and
> +	 *  count the number of characters
> +	 */
> +
> +	mult = scnprintf(buf, 32, "%llu", ((u64)uHz * 0xFFFF) / UHZ_PER_HZ) - 1;

use sizeof(buf) instead of having 32 again.

> +
> +	sec = div64_u64(int_pow(10, mult) * UHZ_PER_HZ, uHz);
> +	if (sec == 0) {
> +		pr_err("Trying to set invalid sensor update value for sensor %s",
> +		       sensor->sensor_info->name);
> +		return -EINVAL;
> +	}
> +
> +	sensor_config &= ~SCMI_SENS_CFG_UPDATE_SECS_MASK;
> +	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_UPDATE_SECS_MASK, sec);
> +	sensor_config &= ~SCMI_SENS_CFG_UPDATE_EXP_MASK;
> +	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_UPDATE_EXP_MASK, -mult);
> +
> +	if (sensor->sensor_info->timestamped) {
> +		sensor_config &= ~SCMI_SENS_CFG_TSTAMP_ENABLED_MASK;
> +		sensor_config |= FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,
> +					    SCMI_SENS_CFG_TSTAMP_ENABLE);
> +	}
> +
> +	sensor_config &= ~SCMI_SENS_CFG_ROUND_MASK;
> +	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
> +
> +	err = sensor->handle->sensor_ops->config_set(
> +		sensor->handle, sensor->sensor_info->id, sensor_config);
> +	if (err)
> +		pr_err("Error in setting sensor update interval for sensor %s value %u err %d",
> +		       sensor->sensor_info->name, sensor_config, err);
> +
> +	return err;
> +}
> +
> +static int scmi_iio_write_raw(struct iio_dev *iio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	int err;
> +
> +	mutex_lock(&iio_dev->mlock);

Move the lock in to around the call that actually need protecting.
Will simplify the rest of the code somewhat.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		err = scmi_iio_set_odr_val(iio_dev, val, val2);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&iio_dev->mlock);
> +
> +	return err;
> +}
> +
> +static u64 convert_interval_to_ns(u32 val)
> +{
> +	u64 sensor_interval_mult;
> +	u64 sensor_update_interval = SCMI_SENS_INTVL_GET_SECS(val) * NSEC_PER_SEC;
> +
> +	int mult = SCMI_SENS_INTVL_GET_EXP(val);
> +
> +	if (mult < 0) {
> +		sensor_interval_mult = int_pow(10, abs(mult));
> +		sensor_update_interval =
> +			sensor_update_interval / sensor_interval_mult;
> +	} else {
> +		sensor_interval_mult = int_pow(10, mult);
> +		sensor_update_interval =
> +			sensor_update_interval * sensor_interval_mult;
> +	}
> +
> +	return sensor_update_interval;
> +}
> +
> +static void convert_ns_to_freq(u64 interval_ns, struct sensor_freq *freq)

Prefix with scmi_iio as that name is generic enough we might get a clash in the future.
Also seems like you might as well just pass in two integers instead of freq as you
always end up copying the values out to such integers anyway.

> +{
> +	u64 rem;
> +
> +	freq->hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
> +	freq->uhz = (rem * 1000000UL) / interval_ns;
> +}
> +
> +static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	u32 sensor_config;
> +	struct sensor_freq freq;
> +	u64 sensor_update_interval, sensor_interval_mult;

Probably worth doing reverse xmas tree ordering throughout the driver
where it doesn't hurt readability.

> +	int mult;
> +
> +	int err = sensor->handle->sensor_ops->config_get(
> +		sensor->handle, sensor->sensor_info->id, &sensor_config);
> +	if (err) {
> +		pr_err("%s: Error in getting sensor config for sensor %s err %d",
> +		       __func__, sensor->sensor_info->name, err);

Probably better to use dev_err where you can get an appropriate device,
That should result in a suitable name being printed.

Also no need to add __func__ etc to messages as I'm fairly sure that can be done
via dynamic debug if desired.


> +		return err;
> +	}
> +
> +	sensor_update_interval = SCMI_SENS_CFG_GET_UPDATE_SECS(sensor_config) * NSEC_PER_SEC;
> +
> +	mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
> +	if (mult < 0) {
> +		sensor_interval_mult = int_pow(10, abs(mult));
> +		sensor_update_interval =
> +			sensor_update_interval / sensor_interval_mult;
> +	} else {
> +		sensor_interval_mult = int_pow(10, mult);
> +		sensor_update_interval =
> +			sensor_update_interval * sensor_interval_mult;
> +	}
> +
> +	convert_ns_to_freq(sensor_update_interval, &freq);
> +	*val = freq.hz;
> +	*val2 = freq.uhz;
> +
> +	return 0;
> +}
> +
> +static int scmi_iio_read_raw(struct iio_dev *iio_dev,
> +			     struct iio_chan_spec const *ch, int *val,
> +			     int *val2, long mask)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	s8 scale;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		scale = sensor->sensor_info->axis[ch->scan_index].scale;
> +		if (scale < 0) {
> +			scale = -scale;
> +			*val = 1;
> +			*val2 = int_pow(10, scale);
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +		*val = int_pow(10, scale);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = scmi_iio_get_odr_val(iio_dev, val, val2);
> +		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +

Can't get here.  Check all your code for similar and make sure to clean them out.
One of the static analyzers will moan about this if not (I can't recall which right now).


> +	return 0;
> +}
> +
> +static ssize_t scmi_iio_get_sensor_power(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(dev_get_drvdata(dev));
> +	int len;
> +
> +	if (sensor->sensor_info->extended_scalar_attrs)
> +		len = scnprintf(buf, PAGE_SIZE, "%u\n",
> +				sensor->sensor_info->sensor_power);
> +
> +	return len;
> +}
> +
> +static ssize_t scmi_iio_get_sensor_max_range(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(dev_get_drvdata(dev));
> +	int i;
> +	s64 max_range = S64_MIN, max_range_axis;
> +
> +	for (i = 0; i < sensor->sensor_info->num_axis; i++) {
> +		if (sensor->sensor_info->axis[i].extended_attrs) {
> +			max_range_axis =
> +				sensor->sensor_info->axis[i].attrs.max_range;
> +			max_range = max(max_range, max_range_axis);
> +		}
> +	}
> +
> +	return scnprintf(buf, PAGE_SIZE, "%lld\n", max_range);

What are units of this?  From Android docs this would be expected to be a float.

> +}
> +
> +static ssize_t scmi_iio_get_sensor_resolution(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(dev_get_drvdata(dev));
> +	int len;
> +
> +	/*
> +	 * All the axes are supposed to have the same value for resolution
> +	 * and exponent. We are just using the values from the Axis 0 here.
> +	 */
> +
> +	if (sensor->sensor_info->axis[0].extended_attrs) {
> +		u32 resolution = sensor->sensor_info->axis[0].resolution;
> +		s8 exponent = sensor->sensor_info->axis[0].exponent;
> +		u32 multiplier = int_pow(10, abs(exponent));
> +
> +		if (exponent < 0) {
> +			int vals[] = { resolution, multiplier };
> +
> +			len = iio_format_value(buf, IIO_VAL_FRACTIONAL,
> +					       ARRAY_SIZE(vals), vals);
> +		} else {
> +			int vals[] = { resolution * multiplier };
> +
> +			len = iio_format_value(buf, IIO_VAL_INT,
> +					       ARRAY_SIZE(vals), vals);
> +		}
> +	}
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(sensor_power, 0444, scmi_iio_get_sensor_power, NULL, 0);
> +static IIO_DEVICE_ATTR(sensor_max_range, 0444, scmi_iio_get_sensor_max_range,
> +		       NULL, 0);
> +static IIO_DEVICE_ATTR(sensor_resolution, 0444, scmi_iio_get_sensor_resolution,
> +		       NULL, 0);
> +
> +static struct attribute *scmi_iio_attributes[] = {
> +	&iio_dev_attr_sensor_power.dev_attr.attr,
> +	&iio_dev_attr_sensor_max_range.dev_attr.attr,
> +	&iio_dev_attr_sensor_resolution.dev_attr.attr,

Replied to these in the cover letter.  I think resolution is _scale in IIO terms.
(multiplier of 1LSB needed to get to real world units)
max_range might be doable using the *_raw_avail or by setting realbits more precisely
for the buffered channels.

Power is an odd one.  As I mentioned I'm not keen to do something IIO specific
for that as it's nothing to do with it being an IIO driven device as such.
I'm not sure how much luck we'll have with defining a more general scheme
though.


> +	NULL,
> +};
> +
> +static const struct attribute_group scmi_iio_attribute_group = {
> +	.attrs = scmi_iio_attributes,
> +};
> +
> +static const struct iio_info scmi_iio_info = {
> +	.read_raw = scmi_iio_read_raw,
> +	.read_avail = scmi_iio_read_avail,
> +	.write_raw = scmi_iio_write_raw,
> +	.attrs = &scmi_iio_attribute_group,
> +};
> +
> +static int scmi_iio_get_chan_type(u8 scmi_type, enum iio_chan_type *iio_type)
> +{
> +	switch (scmi_type) {
> +	case METERS_SEC_SQUARED:
> +		*iio_type = IIO_ACCEL;
> +		return 0;
> +	case RADIANS_SEC:
> +		*iio_type = IIO_ANGL_VEL;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int scmi_iio_get_chan_modifier(const char *name,
> +				      enum iio_modifier *modifier)
> +{
> +	int ret;
> +	char *pch = strrchr(name, '_');
> +
> +	if (!pch)
> +		return -EINVAL;
> +
> +	if (strcmp(pch + 1, "X") == 0)
> +		*modifier = IIO_MOD_X;
> +	else if (strcmp(pch + 1, "Y") == 0)
> +		*modifier = IIO_MOD_Y;
> +	else if (strcmp(pch + 1, "Z") == 0)
> +		*modifier = IIO_MOD_Z;
> +	else
> +		return -EINVAL;
> +
> +	return ret;
In the good path, ret has never been set.
return 0;


> +}
> +
> +static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
> +				      enum iio_chan_type type,
> +				      enum iio_modifier mod, int scan_index)
> +{
> +	iio_chan->type = type;
> +	iio_chan->modified = 1;
> +	iio_chan->channel2 = mod;
> +	iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
> +	iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	iio_chan->info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	iio_chan->scan_index = scan_index;
> +	iio_chan->scan_type.sign = 's';
> +	iio_chan->scan_type.realbits = 64;
> +	iio_chan->scan_type.storagebits = 64;
> +	iio_chan->scan_type.endianness = IIO_LE;
> +}
> +
> +static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_chan,
> +					   int scan_index)
> +{
> +	iio_chan->type = IIO_TIMESTAMP;
> +	iio_chan->channel = -1;
> +	iio_chan->scan_index = scan_index;
> +	iio_chan->scan_type.sign = 'u';
> +	iio_chan->scan_type.realbits = 64;
> +	iio_chan->scan_type.storagebits = 64;
> +}
> +
> +static int set_sampling_freq_avail(struct iio_dev *iio_dev)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int i;
> +	struct sensor_freq freq;
> +	u64 cur_interval_ns, low_interval_ns, high_interval_ns, step_size_ns;
> +	unsigned int low_interval, high_interval, step_size;
> +
> +	sensor->freq_avail =  devm_kzalloc(&iio_dev->dev,
> +					sizeof(u32) * (sensor->sensor_info->intervals.count * 2),
> +					GFP_KERNEL);
> +	if (!sensor->freq_avail)
> +		return -ENOMEM;
> +
> +	if (sensor->sensor_info->intervals.segmented) {
> +		low_interval = sensor->sensor_info->intervals.desc[SCMI_SENS_INTVL_SEGMENT_LOW];
> +		low_interval_ns = convert_interval_to_ns(low_interval);
> +		convert_ns_to_freq(low_interval_ns, &freq);
> +		sensor->freq_avail[0] = freq.hz;
> +		sensor->freq_avail[1] = freq.uhz;
> +
> +		step_size = sensor->sensor_info->intervals.desc[SCMI_SENS_INTVL_SEGMENT_STEP];
> +		step_size_ns = convert_interval_to_ns(step_size);
> +		convert_ns_to_freq(step_size_ns, &freq);
> +		sensor->freq_avail[2] = freq.hz;
> +		sensor->freq_avail[3] = freq.uhz;
> +
> +		high_interval = sensor->sensor_info->intervals.desc[SCMI_SENS_INTVL_SEGMENT_HIGH];
> +		high_interval_ns = convert_interval_to_ns(high_interval);
> +		convert_ns_to_freq(high_interval_ns, &freq);
> +		sensor->freq_avail[4] = freq.hz;
> +		sensor->freq_avail[5] = freq.uhz;
> +	} else {
> +		for (i = 0; i < sensor->sensor_info->intervals.count; i++) {
> +			cur_interval_ns = convert_interval_to_ns
> +						(sensor->sensor_info->intervals.desc[i]);
> +			convert_ns_to_freq(cur_interval_ns, &freq);
> +			sensor->freq_avail[i*2] = freq.hz;
> +			sensor->freq_avail[i*2+1] = freq.uhz;

Spacing as per kernel style guide https://www.kernel.org/doc/html/v4.10/process/coding-style.html

[i * 2]
[i * 2 + 1] 

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> +{
> +	struct iio_buffer *buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
> +
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	iio_device_attach_buffer(scmi_iiodev, buffer);
> +	scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
> +	scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;
> +
> +	return 0;
> +}
> +
> +static int scmi_alloc_iiodev(struct device *dev, struct scmi_handle *handle,
> +			     const struct scmi_sensor_info *sensor_info,
> +			     struct iio_dev **scmi_iio_dev)
> +{
> +	struct scmi_iio_priv *sensor;
> +	struct iio_chan_spec *iio_channels;
> +	enum iio_chan_type type;
> +	enum iio_modifier modifier;
> +	struct iio_dev *iiodev;
> +	int i, ret;
> +
> +	iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> +	if (!iiodev)
> +		return -ENOMEM;
> +
> +	iiodev->modes = INDIO_DIRECT_MODE;
> +	iiodev->dev.parent = dev;
> +	sensor = iio_priv(iiodev);
> +	sensor->handle = handle;
> +	sensor->sensor_info = sensor_info;
> +	sensor->sensor_update_nb.notifier_call = sensor_update_cb;
> +	sensor->indio_dev = iiodev;
> +	iiodev->num_channels =
> +		sensor_info->num_axis +
> +		1; /* adding one additional channel for timestamp */

Perhaps move the comment to above the assignment then we can have
nicer looking indentation.
/* adding...
iiodev->num_channels = sensor_info->num_axis + 1;

> +	iiodev->name = sensor_info->name;
> +	iiodev->info = &scmi_iio_info;
> +
> +	iio_channels =
> +		devm_kzalloc(dev,
> +			     sizeof(*iio_channels) * (iiodev->num_channels),
> +			     GFP_KERNEL);
> +	if (!iio_channels)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < sensor_info->num_axis; i++) {
> +		ret = scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
> +						 &modifier);
> +		if (ret < 0)
> +			return ret;
> +
> +		scmi_iio_set_data_channel(&iio_channels[i], type, modifier,
> +					  sensor_info->axis[i].id);
> +	}
> +
> +	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> +	iiodev->channels = iio_channels;
> +
> +	ret = set_sampling_freq_avail(iiodev);
> +	if (ret < 0)
> +		return ret;
> +
> +	*scmi_iio_dev = iiodev;
> +
> +	return ret;
> +}
> +
> +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> +{
> +	struct iio_dev *scmi_iio_dev;
> +	const struct scmi_sensor_info *sensor_info;
> +	int err, i;
> +	u16 nr_sensors;
> +	struct device *dev = &sdev->dev;
> +	struct scmi_handle *handle = sdev->handle;
> +
> +	if (!handle || !handle->sensor_ops || !handle->sensor_ops->count_get ||
> +	    !handle->sensor_ops->info_get || !handle->sensor_ops->config_get ||
> +	    !handle->sensor_ops->config_set) {
> +		dev_err(dev, "SCMI device has no sensor interface\n");
> +		return -EINVAL;
> +	}
> +
> +	nr_sensors = handle->sensor_ops->count_get(handle);
> +	if (!nr_sensors) {
> +		dev_dbg(dev, "0 sensors found via SCMI bus\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "%d sensors found via SCMI bus\n", nr_sensors);
> +
> +	for (i = 0; i < nr_sensors; i++) {
> +		sensor_info = handle->sensor_ops->info_get(handle, i);
> +		if (!sensor_info) {
> +			dev_err(dev, "SCMI sensor %d has missing info\n", i);
> +			return -EINVAL;
> +		}
> +
> +		/* Skipping scalar sensor,as this driver only supports accel and gyro */
> +		if (sensor_info->num_axis == 0)
> +			continue;
> +
> +		err = scmi_alloc_iiodev(dev, handle, sensor_info,
> +					&scmi_iio_dev);

I think you are under 80 chars with the above on one line.

> +		if (err < 0) {
> +			dev_err(dev,
> +				"failed to allocate IIO device for sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
> +		}
> +		if (!scmi_iio_dev) {

Looks to me like you can't get here.  If there was an issue with lack of memory it
would also have reported an err < 0 and been caught above.

> +			dev_err(dev, "memory allocation failed at sensor %s\n",
> +				sensor_info->name);
> +			return -ENOMEM;
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
> +
> +	return err;
> +}
> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_SENSOR, "iiodev" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static struct scmi_driver scmi_iiodev_driver = {
> +	.name = "scmi-sensor-iiodev",
> +	.probe = scmi_iio_dev_probe,
> +	.id_table = scmi_id_table,
> +};
> +
> +module_scmi_driver(scmi_iiodev_driver);
> +
> +MODULE_AUTHOR("Jyoti Bhayana <jbhayana@google.com>");
> +MODULE_DESCRIPTION("SCMI IIO Driver");
> +MODULE_LICENSE("GPL v2");

