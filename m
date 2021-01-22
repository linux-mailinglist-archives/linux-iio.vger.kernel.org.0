Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C50F300458
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 14:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbhAVNil (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 08:38:41 -0500
Received: from foss.arm.com ([217.140.110.172]:48220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbhAVNic (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Jan 2021 08:38:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC1911B3;
        Fri, 22 Jan 2021 05:37:44 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80D933F66E;
        Fri, 22 Jan 2021 05:37:42 -0800 (PST)
Date:   Fri, 22 Jan 2021 13:37:40 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        sudeep.holla@arm.com, egranata@google.com,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com,
        Peter.hilber@opensynergy.com, ankitarora@google.com
Subject: Re: [RFC PATCH v3 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210122133740.GB22231@e120937-lin>
References: <20210121232147.1849509-1-jbhayana@google.com>
 <20210121232147.1849509-2-jbhayana@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121232147.1849509-2-jbhayana@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jyoti,

a few remarks below.

On Thu, Jan 21, 2021 at 11:21:47PM +0000, Jyoti Bhayana wrote:
> This change provides ARM SCMI Protocol based IIO device.
> This driver provides support for Accelerometer and Gyroscope using
> new SCMI Sensor Protocol defined by the upcoming SCMIv3.0

I'd say:

new SCMI Sensor Protocol extension added by the upcoming SCMIv3.0

given that SCMI Sensor existed already in SCMIv2.0

> ARM specification
> 
> Signed-off-by: Jyoti Bhayana <jbhayana@google.com>
> ---
>  MAINTAINERS                                |   6 +
>  drivers/iio/common/Kconfig                 |   1 +
>  drivers/iio/common/Makefile                |   1 +
>  drivers/iio/common/scmi_sensors/Kconfig    |  18 +
>  drivers/iio/common/scmi_sensors/Makefile   |   5 +
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 736 +++++++++++++++++++++
>  6 files changed, 767 insertions(+)
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
> index 000000000000..3b76cc54511c
> --- /dev/null
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -0,0 +1,736 @@
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
> +#define ilog10(x) (ilog2(x) / const_ilog2(10))
> +#define UHZ_PER_HZ 1000000UL
> +#define ODR_EXPAND(odr, uodr) (((odr) * 1000000ULL) + (uodr))
> +#define MAX_NUM_OF_CHANNELS 4
> +#define H32(x) (((x) & 0xFFFFFFFF00000000LL) >> 32)
> +#define L32(x) ((x) & 0xFFFFFFFFLL)

Probaly you want to use GENMASK here to define the masks, and not sure
but maybe there are already similar macros in linux to extract
upper/lower 32 bits.

> +
> +struct scmi_iio_priv {
> +	struct scmi_handle *handle;
> +	const struct scmi_sensor_info *sensor_info;
> +	struct iio_dev *indio_dev;
> +	long long iio_buf[MAX_NUM_OF_CHANNELS];
> +	struct notifier_block sensor_update_nb;
> +	u32 *freq_avail;
> +	/*
> +	 * range_avail = [minRange resolution maxRange]
> +	 * with IIO val type as IIO_VAL_FRACTIONAL.
> +	 * Hence, array of size 6.
> +	 */
> +	int range_avail[6];
> +};
> +
> +static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
> +				     unsigned long event, void *data)
> +{
> +	struct scmi_sensor_update_report *sensor_update = data;
> +	struct iio_dev *scmi_iio_dev;
> +	struct scmi_iio_priv *sensor;
> +	s8 tstamp_scale;
> +	u64 time, time_ns;
> +	int i;
> +
> +	if (sensor_update->readings_count == 0)
> +		return NOTIFY_DONE;
> +
> +	sensor = container_of(nb, struct scmi_iio_priv, sensor_update_nb);
> +
> +	for (i = 0; i < sensor_update->readings_count; i++)
> +		sensor->iio_buf[i] = sensor_update->readings[i].value;
> +
> +	if (!sensor->sensor_info->timestamped) {
> +		time_ns = iio_get_time_ns(scmi_iio_dev);

This scmi_iio_dev is on the stack and still NOT initialized here right ?

Moreover, if this is meant to attach a timestamp of arrival also to
NON-timestamped sensor notifications, note that, if you want, scmi_sensor_update_report
contains a 'timestamp' (as all SCMI notif reports) ktime field (ns) which
represents the time (ns from boot with ktime_get_boottime()) of reception
of this notification taken by the SCMI core as soon as it arrives in the
RX ISR. (so in the OSPM Linux world)

If you grab the timestamp here with iio_get_time_ns() you are indeed
getting a timestamp inside the notification callback so at the end of
the notifications processing chain, i.e. in a deferred worker processing
this queue of events and in turn calling this function, so potentially
you're timestamping a lot later than when the event arrived really in
the OSPM world (especially on a loaded system); it is more the time of
arrival in IIO framework.

On the other side timestamped events handled in the else-branch down
below carry a timestamp set by the SCMI platform fw early on when the
event has been detected by the sensor in the real world.

Not sure how these values are used at the end, but just to let you know
this detail if it was not apparent.

> +	} else {
> +		/*
> +		 * All the axes are supposed to have the same value for timestamp.
> +		 *  We are just using the values from the Axis 0 here.
> +		 */
> +		time = sensor_update->readings[0].timestamp;
> +
> +		/*
> +		 *  Timestamp returned by SCMI is in seconds and is equal to
> +		 *  time * power-of-10 multiplier(tstamp_scale) seconds.
> +		 *  Converting the timestamp to nanoseconds below.
> +		 */
> +		tstamp_scale = sensor->sensor_info->tstamp_scale +
> +				  ilog10(NSEC_PER_SEC);
> +		if (tstamp_scale < 0)
> +			time_ns = div64_u64(time,
> +					    int_pow(10, abs(tstamp_scale)));
> +		else
> +			time_ns = time * int_pow(10, tstamp_scale);
> +	}
> +
> +	scmi_iio_dev = sensor->indio_dev;
> +	iio_push_to_buffers_with_timestamp(scmi_iio_dev, sensor->iio_buf,
> +					   time_ns);
> +	return NOTIFY_OK;
> +}
> +
> +static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	u32 sensor_id = sensor->sensor_info->id;
> +	u32 sensor_config;
> +	int err;
> +
> +	if (sensor->sensor_info->timestamped)
> +		sensor_config |= FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK,
> +					    SCMI_SENS_CFG_TSTAMP_ENABLE);

The initial  sensor_config ORed here is NOT initialized nor zeroed.
> +
> +	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +				    SCMI_SENS_CFG_SENSOR_ENABLE);
> +
> +	err = sensor->handle->notify_ops->register_event_notifier(sensor->handle,
> +			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> +			&sensor_id, &sensor->sensor_update_nb);
> +	if (err) {
> +		dev_err(&iio_dev->dev,
> +			"Error in registering sensor update notifier for sensor %s err %d",
> +			sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	err = sensor->handle->sensor_ops->config_set(sensor->handle,
> +			sensor->sensor_info->id, sensor_config);
> +	if (err)
> +		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
> +			sensor->sensor_info->name, err);

Here you do not unregister the notification above here when you fail
the config_set.
If you happen to retry this code path again you'll end up registering
the same notifier_block sensor_update_nb() in the same notification chain
(same event samme sensor_id), which is broken and probably triggers a WARN
from the core kernel notification chains machinery too.

In an upcoming series on SCMI core I'll introduce a devm_ variant for
SCMI notification registration, but as of now you have to properly unregister
on error paths.

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
> +	err = sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> +			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> +		&sensor_id, &sensor->sensor_update_nb);

This alignment here is a bit awkaward.

> +	if (err) {
> +		dev_err(&iio_dev->dev,
> +			"Error in unregistering sensor update notifier for sensor %s err %d",
> +			sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
> +						     sensor_config);
> +	if (err)
> +		dev_err(&iio_dev->dev,
> +			"Error in disabling sensor %s with err %d",
> +			sensor->sensor_info->name, err);
> +
> +	return err;
> +}
> +
> +static const struct iio_buffer_setup_ops scmi_iio_buffer_ops = {
> +	.preenable = scmi_iio_buffer_preenable,
> +	.postdisable = scmi_iio_buffer_postdisable,
> +};
> +

Being not so familiar with IIO, may I ask when annd ho wmuch frequently
these ops are called ? (given they include a register/unregister +
enable/disable every time)

> +static int scmi_iio_read_avail(struct iio_dev *iio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
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
> +	case IIO_CHAN_INFO_RAW:
> +		*vals = sensor->range_avail;
> +		*type = IIO_VAL_FRACTIONAL;
> +		*length = ARRAY_SIZE(sensor->range_avail);
> +		return IIO_AVAIL_RANGE;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	u64 sec, mult, uHz;
> +	u32 sensor_config;
> +
> +	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> +			sensor->sensor_info->id, &sensor_config);
> +	if (err) {
> +		dev_err(&iio_dev->dev,
> +			"Error in getting sensor config for sensor %s err %d",
> +			sensor->sensor_info->name, err);
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
> +	 */
> +	mult = ilog10(((u64)uHz * 0xFFFF) / UHZ_PER_HZ);
> +
> +	sec = div64_u64(int_pow(10, mult) * UHZ_PER_HZ, uHz);
> +	if (sec == 0) {
> +		dev_err(&iio_dev->dev,
> +			"Trying to set invalid sensor update value for sensor %s",
> +			sensor->sensor_info->name);
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
> +	sensor_config |=
> +		FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
> +
> +	err = sensor->handle->sensor_ops->config_set(sensor->handle,
> +			sensor->sensor_info->id, sensor_config);
> +	if (err)
> +		dev_err(&iio_dev->dev,
> +			"Error in setting sensor update interval for sensor %s value %u err %d",
> +			sensor->sensor_info->name, sensor_config, err);
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
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&iio_dev->mlock);
> +		err = scmi_iio_set_odr_val(iio_dev, val, val2);
> +		mutex_unlock(&iio_dev->mlock);
> +		return err;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static u64 scmi_iio_convert_interval_to_ns(u32 val)
> +{
> +	u64 sensor_update_interval =
> +		SCMI_SENS_INTVL_GET_SECS(val) * NSEC_PER_SEC;
> +	u64 sensor_interval_mult;
> +	int mult;
> +
> +	mult = SCMI_SENS_INTVL_GET_EXP(val);
> +	if (mult < 0) {
> +		sensor_interval_mult = int_pow(10, abs(mult));
> +		sensor_update_interval =
> +			sensor_update_interval / sensor_interval_mult;
> +	} else {
> +		sensor_interval_mult = int_pow(10, mult);
> +		sensor_update_interval =
> +			sensor_update_interval * sensor_interval_mult;
> +	}
> +	return sensor_update_interval;
> +}
> +
> +static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
> +{
> +	u64 rem;
> +
> +	*hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
> +	*uhz = (rem * 1000000UL) / interval_ns;
> +}
> +
> +static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
> +{
> +	u64 sensor_update_interval, sensor_interval_mult, hz, uhz;
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	u32 sensor_config;
> +	int mult;
> +
> +	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> +			sensor->sensor_info->id, &sensor_config);
> +	if (err) {
> +		dev_err(&iio_dev->dev,
> +			"Error in getting sensor config for sensor %s err %d",
> +			sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	sensor_update_interval =
> +		SCMI_SENS_CFG_GET_UPDATE_SECS(sensor_config) * NSEC_PER_SEC;
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
> +	convert_ns_to_freq(sensor_update_interval, &hz, &uhz);
> +	*val = hz;
> +	*val2 = uhz;
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
> +			*val = 1;
> +			*val2 = int_pow(10, abs(scale));
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
> +}
> +
> +static const struct iio_info scmi_iio_info = {
> +	.read_raw = scmi_iio_read_raw,
> +	.read_avail = scmi_iio_read_avail,
> +	.write_raw = scmi_iio_write_raw,
> +};
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
> +static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
> +				      enum iio_chan_type type,
> +				      enum iio_modifier mod, int scan_index)
> +{
> +	iio_chan->type = type;
> +	iio_chan->modified = 1;
> +	iio_chan->channel2 = mod;
> +	iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
> +	iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	iio_chan->info_mask_shared_by_type_available =
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) | BIT(IIO_CHAN_INFO_RAW);
> +	iio_chan->scan_index = scan_index;
> +	iio_chan->scan_type.sign = 's';
> +	iio_chan->scan_type.realbits = 64;
> +	iio_chan->scan_type.storagebits = 64;
> +	iio_chan->scan_type.endianness = IIO_LE;
> +}
> +
> +static int scmi_iio_get_chan_modifier(const char *name,
> +				      enum iio_modifier *modifier)
> +{

AFAIU this is called during IIO init and derives a modifier from the name
of the sensors which are passed by the platform fw with sensor descriptors,
so I would not trust them to be weell formed (:D) and try to be picky about
*name as it was user-input to validate.

> +	char *pch;
> +
> +	pch = strrchr(name, '_');

What happens if name is NULL ?

> +	if (!pch)
> +		return -EINVAL;
> +
> +	if (strcmp(pch + 1, "X") == 0) {
> +		*modifier = IIO_MOD_X;
> +		return 0;
> +	} else if (strcmp(pch + 1, "Y") == 0) {
> +		*modifier = IIO_MOD_Y;
> +		return 0;
> +	} else if (strcmp(pch + 1, "Z") == 0) {
> +		*modifier = IIO_MOD_Z;
> +		return 0;
> +	} else {
> +		return -EINVAL;
> +	}

Moroever, being a single char compare cannot this be done with a switch ?

	char mod = *(pch + 1);

	switch(mod) {
	case 'X':
		*modifier = IIO_MOD_X;
		break
	...

> +}
> +
> +static int scmi_iio_get_chan_type(u8 scmi_type, enum iio_chan_type *iio_type)
> +{
> +	switch (scmi_type) {
> +	case METERS_SEC_SQUARED:
> +		*iio_type = IIO_ACCEL;
> +		return 0;
why not a break to a final 'return ret;' (with ret properly set) ?

> +	case RADIANS_SEC:
> +		*iio_type = IIO_ANGL_VEL;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int scmi_iio_get_sensor_max_range(struct iio_dev *iio_dev, int *val,
> +					 int *val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int max_range_high, max_range_low;
> +	long long max_range;
> +
> +	/*
> +	 * All the axes are supposed to have the same value for max range.
> +	 * We are just using the values from the Axis 0 here.
> +	 */
> +	if (sensor->sensor_info->axis[0].extended_attrs) {
> +		max_range = sensor->sensor_info->axis[0].attrs.max_range;
> +		max_range_high = H32(max_range);
> +		max_range_low = L32(max_range);
> +
> +		/*
> +		 * As IIO Val types have no provision for 64 bit values,
> +		 * and currently there are no known sensors using 64 bit
> +		 * for the range, this driver only supports sensor with
> +		 * 32 bit range value.
> +		 */
> +		if (max_range_high != 0)
> +			return -EINVAL;
> +
> +		*val = max_range_low;
> +		*val2 = 1;
> +	}
> +	return 0;
> +}
> +
> +static void scmi_iio_get_sensor_resolution(struct iio_dev *iio_dev, int *val,
> +					   int *val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +
> +	/*
> +	 * All the axes are supposed to have the same value for resolution
> +	 * and exponent. We are just using the values from the Axis 0 here.
> +	 */
> +	if (sensor->sensor_info->axis[0].extended_attrs) {
> +		uint resolution = sensor->sensor_info->axis[0].resolution;
> +		s8 exponent = sensor->sensor_info->axis[0].exponent;
> +		s8 scale = sensor->sensor_info->axis[0].scale;
> +
> +		/*
> +		 * To provide the raw value for the resolution to the userspace,
> +		 * need to divide the resolution exponent by the sensor scale
> +		 */
> +		exponent = exponent - scale;
> +		if (exponent >= 0) {
> +			*val = resolution * int_pow(10, exponent);
> +			*val2 = 1;
> +		} else {
> +			*val = resolution;
> +			*val2 = int_pow(10, abs(exponent));
> +		}
> +	}
> +}
> +
> +static int scmi_iio_get_sensor_min_range(struct iio_dev *iio_dev, int *val,
> +					 int *val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int min_range_high, min_range_low;
> +	long long min_range;
> +
> +	/*
> +	 * All the axes are supposed to have the same value for min range.
> +	 * We are just using the values from the Axis 0 here.
> +	 */
> +	if (sensor->sensor_info->axis[0].extended_attrs) {
> +		min_range = sensor->sensor_info->axis[0].attrs.min_range;
> +		min_range_high = H32(min_range);
> +		min_range_low = L32(min_range);
> +
> +		/*
> +		 * As IIO Val types have no provision for 64 bit values,
> +		 * and currently there are no known sensors using 64 bit
> +		 * for the range, this driver only supports sensor with
> +		 * 32 bit range value.
> +		 */
> +		if (min_range_high != 0xFFFFFFFF)
> +			return -EINVAL;
> +
> +		*val = min_range_low;
> +		*val2 = 1;
> +	}
> +	return 0;
> +}
> +
> +static int scmi_iio_set_sensor_range_avail(struct iio_dev *iio_dev)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int ret;
> +
> +	ret = scmi_iio_get_sensor_min_range(iio_dev, &sensor->range_avail[0],
> +					    &sensor->range_avail[1]);
> +	if (ret)
> +		return ret;
> +
> +	scmi_iio_get_sensor_resolution(iio_dev, &sensor->range_avail[2],
> +				       &sensor->range_avail[3]);
> +	ret = scmi_iio_get_sensor_max_range(iio_dev, &sensor->range_avail[4],
> +					    &sensor->range_avail[5]);
> +	return ret;
> +}
> +
> +static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)
> +{
> +	u64 cur_interval_ns, low_interval_ns, high_interval_ns, step_size_ns,
> +		hz, uhz;
> +	unsigned int cur_interval, low_interval, high_interval, step_size;
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int i;
> +
> +	sensor->freq_avail = devm_kzalloc(&iio_dev->dev,
> +					  sizeof(u32) * (sensor->sensor_info->intervals.count * 2),
> +					  GFP_KERNEL);
> +	if (!sensor->freq_avail)
> +		return -ENOMEM;
> +
> +	if (sensor->sensor_info->intervals.segmented) {
> +		low_interval = sensor->sensor_info->intervals
> +				       .desc[SCMI_SENS_INTVL_SEGMENT_LOW];
> +		low_interval_ns = scmi_iio_convert_interval_to_ns(low_interval);
> +		convert_ns_to_freq(low_interval_ns, &hz, &uhz);
> +		sensor->freq_avail[0] = hz;
> +		sensor->freq_avail[1] = uhz;
> +
> +		step_size = sensor->sensor_info->intervals
> +				    .desc[SCMI_SENS_INTVL_SEGMENT_STEP];
> +		step_size_ns = scmi_iio_convert_interval_to_ns(step_size);
> +		convert_ns_to_freq(step_size_ns, &hz, &uhz);
> +		sensor->freq_avail[2] = hz;
> +		sensor->freq_avail[3] = uhz;
> +
> +		high_interval = sensor->sensor_info->intervals
> +					.desc[SCMI_SENS_INTVL_SEGMENT_HIGH];
> +		high_interval_ns =
> +			scmi_iio_convert_interval_to_ns(high_interval);
> +		convert_ns_to_freq(high_interval_ns, &hz, &uhz);
> +		sensor->freq_avail[4] = hz;
> +		sensor->freq_avail[5] = uhz;
> +	} else {
> +		for (i = 0; i < sensor->sensor_info->intervals.count; i++) {
> +			cur_interval = sensor->sensor_info->intervals.desc[i];
> +			cur_interval_ns = scmi_iio_convert_interval_to_ns(cur_interval);
> +			convert_ns_to_freq(cur_interval_ns, &hz, &uhz);
> +			sensor->freq_avail[i * 2] = hz;
> +			sensor->freq_avail[i * 2 + 1] = uhz;
> +		}
> +	}
> +	return 0;
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

Not familiar with IIO, but is it fine to setup ops and modes AFTER
having attached the buffer to the scmi_iiodev ?

Is is not 'racy-possible' that the buffer is already operational without
any ops immediately after being attached ?

> +	return 0;
> +}
> +
> +static int scmi_alloc_iiodev(struct device *dev, struct scmi_handle *handle,
> +			     const struct scmi_sensor_info *sensor_info,
> +			     struct iio_dev **scmi_iio_dev)
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
> +		return -ENOMEM;
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
> +		return -ENOMEM;
> +
> +	scmi_iio_set_sampling_freq_avail(iiodev);
> +
> +	ret = scmi_iio_set_sensor_range_avail(iiodev);
> +	if (ret) {
> +		dev_err(dev, "Error while setting the sensor %s range %d",
> +			sensor_info->name, ret);
> +		return ret;
> +	}
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
> +	*scmi_iio_dev = iiodev;
> +	return ret;
> +}
> +
> +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> +{
> +	const struct scmi_sensor_info *sensor_info;
> +	struct scmi_handle *handle = sdev->handle;
> +	struct device *dev = &sdev->dev;
> +	struct iio_dev *scmi_iio_dev;
> +	u16 nr_sensors;
> +	int err, i;
> +
> +	if (!handle || !handle->sensor_ops || !handle->sensor_ops->count_get ||
> +	    !handle->sensor_ops->info_get || !handle->sensor_ops->config_get ||
> +	    !handle->sensor_ops->config_set) {

In all other SCMI driver we just check for:

	!handle && !handle->sensor_ops

it should be enough, since all the ops are defined if the stack you are
using supports SCMIv3.0, if not this driver would not even compile since
some SCMIv3.0 Sensor Extension sensor_ops would be missing as a whole
inside the struct itself.

Thanks

Cristian

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
> +		if (err < 0) {
> +			dev_err(dev,
> +				"failed to allocate IIO device for sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
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
> -- 
> 2.30.0.280.ga3ce27912f-goog
> 
