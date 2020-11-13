Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970002B2425
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 19:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKMS7L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 13:59:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2103 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKMS7L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 13:59:11 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CXnlT2H99z67K3g;
        Sat, 14 Nov 2020 02:57:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 13 Nov 2020 19:59:05 +0100
Received: from localhost (10.52.126.9) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 13 Nov
 2020 18:59:04 +0000
Date:   Fri, 13 Nov 2020 18:58:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jyoti Bhayana <jbhayana@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <cristian.marussi@arm.com>, <sudeep.holla@arm.com>,
        <egranata@google.com>, <mikhail.golubev@opensynergy.com>,
        <Igor.Skalkin@opensynergy.com>, <Peter.hilber@opensynergy.com>,
        <ankitarora@google.com>
Subject: Re: [RFC PATCH 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20201113185857.00002f75@Huawei.com>
In-Reply-To: <20201113170611.378887-2-jbhayana@google.com>
References: <20201113170611.378887-1-jbhayana@google.com>
        <20201113170611.378887-2-jbhayana@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.9]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 17:06:11 +0000
Jyoti Bhayana <jbhayana@google.com> wrote:

> This change provides ARM SCMI Protocol based IIO device.
> This driver provides support for Accelerometer and Gyroscope using
> new SCMI Sensor Protocol defined by the upcoming SCMIv3.0
> ARM specification
> 
> Signed-off-by: Jyoti Bhayana <jbhayana@google.com>

Hi Jyoti,

Just taken a quick initial look.  Various formatting things inline but
the bigger items we need to think about are:

1) New ABI.   That needs documentation before we can really consider it
   under Documentation/ABI/testings/sysfs-bus-iio-*
   Note that I'm very reluctant to add ABI unless we have a very strong
   reason for it (+ a known usecase).  In particular I have no idea what
   userspace would do with the power usage interface.

2) The fiddly data format stuff.  We always run into this when there is
   a software layer somewhere between the sensor and us.  They tend to
   require a lot more flexibility than any sensor every actually provides.
   I've seen worse though :)

I haven't looked too closely at the SCMI side of things.

Jonathan

> ---
>  MAINTAINERS                 |   6 +
>  drivers/iio/Kconfig         |   1 +
>  drivers/iio/Makefile        |   1 +
>  drivers/iio/scmi/Kconfig    |  18 +
>  drivers/iio/scmi/Makefile   |   5 +
>  drivers/iio/scmi/scmi_iio.c | 771 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 802 insertions(+)
>  create mode 100644 drivers/iio/scmi/Kconfig
>  create mode 100644 drivers/iio/scmi/Makefile
>  create mode 100644 drivers/iio/scmi/scmi_iio.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..11624961b13b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8477,6 +8477,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
>  F:	drivers/iio/multiplexer/iio-mux.c
>  
> +IIO SCMI BASED DRIVER
> +M:	Jyoti Bhayana <jbhayana@google.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/scmi/scmi_iio.c
> +
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
>  R:	Hartmut Knaack <knaack.h@gmx.de>
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index d5c073a8aa3e..d31e0ceb152e 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -94,6 +94,7 @@ source "drivers/iio/potentiostat/Kconfig"
>  source "drivers/iio/pressure/Kconfig"
>  source "drivers/iio/proximity/Kconfig"
>  source "drivers/iio/resolver/Kconfig"
> +source "drivers/iio/scmi/Kconfig"
>  source "drivers/iio/temperature/Kconfig"
>  
>  endif # IIO
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 1712011c0f4a..2da7907da608 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -37,5 +37,6 @@ obj-y += potentiostat/
>  obj-y += pressure/
>  obj-y += proximity/
>  obj-y += resolver/
> +obj-y += scmi/

Probably put it under common rather than a new directory.
It's not a perfect fit as normally that's library code and there is
a driver in each of the device types as well, but I definitely don't
want directories driven by interface.

>  obj-y += temperature/
>  obj-y += trigger/
> diff --git a/drivers/iio/scmi/Kconfig b/drivers/iio/scmi/Kconfig
> new file mode 100644
> index 000000000000..67e084cbb1ab
> --- /dev/null
> +++ b/drivers/iio/scmi/Kconfig
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
> diff --git a/drivers/iio/scmi/Makefile b/drivers/iio/scmi/Makefile
> new file mode 100644
> index 000000000000..f13140a2575a
> --- /dev/null
> +++ b/drivers/iio/scmi/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX - License - Identifier : GPL - 2.0 - only
> +#
> +# Makefile for the IIO over SCMI
> +#
> +obj-$(CONFIG_IIO_SCMI) += scmi_iio.o
> diff --git a/drivers/iio/scmi/scmi_iio.c b/drivers/iio/scmi/scmi_iio.c
> new file mode 100644
> index 000000000000..987c3a56abcf
> --- /dev/null
> +++ b/drivers/iio/scmi/scmi_iio.c
> @@ -0,0 +1,771 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +#define ODR_EXPAND(odr, uodr) (((odr) * 1000000ULL) + (uodr))
> +#define SCMI_SENS_CFG_SET_TSTAMP_ENABLED(x) ((x) | BIT(1))
> +#define SCMI_SENS_CFG_SET_ENABLE(x) ((x) | BIT(0))
> +#define SCMI_SENS_CFG_SET_DISABLE(x) ((x) & ~BIT(0))
> +#define SCMI_SENS_CFG_SET_UPDATE_SECS(x, v) ((x) | ((u32)(v) << 16))
> +#define SCMI_SENS_CFG_SET_UPDATE_MULTI(x, v)                                   \
> +	((x) | (((s16)(v) << 11) & GENMASK(15, 11)))
> +#define SCMI_SENS_CFG_SET_AUTO_ROUND_UP(x) ((x) | BIT(10))
> +
> +//one additional channel for timestamp
I'd rather see + 1 and comments in relevant places than it hidden
in something that made me think there might be lots of extra channels.
Sometimes 1 is just 1 and not a magic number :)

> +#define SCMI_IIO_EXTRA_CHANNELS 1
> +
> +struct scmi_iio_priv {
> +	struct scmi_handle *handle;
> +	const struct scmi_sensor_info *sensor_info;
> +	struct iio_dev *indio_dev;
> +	u8 *iio_buf;

why u8?  Looks like s64 throughout?

> +	struct notifier_block sensor_update_nb;
> +};
> +
> +struct sensor_freq {
> +	u64 hz;
> +	u64 uhz;
> +};
> +
> +static int scmi_iio_check_valid_sensor(struct scmi_iio_priv *sensor)
> +{
> +	if (!sensor || !sensor->handle || !sensor->sensor_info ||
> +	    !sensor->indio_dev)
> +		return -EINVAL;
> +	else
> +		return 0;
> +}
> +
> +static int sensor_update_cb(struct notifier_block *nb, unsigned long event,
> +			    void *data)
> +{
> +	struct scmi_sensor_update_report *sensor_update = data;
> +	u64 time, time_ns;
> +	s64 sensor_value;
> +	struct scmi_iio_priv *sensor =
> +		container_of(nb, struct scmi_iio_priv, sensor_update_nb);
> +	struct iio_dev *scmi_iio_dev;
> +	s8 tstamp_scale_ns;
> +	int i, err;
> +
> +	err = scmi_iio_check_valid_sensor(sensor);
> +

No blank line.

> +	if (err)
> +		return err;
> +
> +	scmi_iio_dev = sensor->indio_dev;
> +
> +	for (i = 0; i < sensor_update->readings_count; i++) {
> +		sensor_value = sensor_update->readings[i].value;
> +		time = sensor_update->readings[i].timestamp;
> +		memcpy(&sensor->iio_buf[i * sizeof(s64)], &sensor_value,
> +		       sizeof(s64));

Don't memcpy an s64 into an array of s64s.  Just set it directly (having
changed the type to be s64 *)

> +	}
> +
> +	if (!sensor->sensor_info->timestamped) {
> +		time_ns = iio_get_time_ns(scmi_iio_dev);
> +	} else {
> +		tstamp_scale_ns =
> +			sensor->sensor_info->tstamp_scale + NSEC_MULT_POW_10;
> +		if (tstamp_scale_ns < 0) {
> +			tstamp_scale_ns = -1 * tstamp_scale_ns;
> +			time_ns = div64_u64(time, int_pow(10, tstamp_scale_ns));
> +		} else {
> +			time_ns = time * int_pow(10, tstamp_scale_ns);

How are you ensuring the sensor timestamp is aligned with the system clock?

Otherwise, we tend to run into rather unexpected outcomes.

> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(scmi_iio_dev, sensor->iio_buf,
> +					   time_ns);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int scmi_iio_is_scalar_sensor(const struct scmi_sensor_info *sensor_info,
> +				     bool *scalar)
> +{
> +	if (!sensor_info || !scalar)
> +		return -EINVAL;
> +
> +	if (sensor_info->num_axis > 0)
> +		*scalar = false;
> +	else
> +		*scalar = true;

       *scalar = sensor_info->num_axis > 0;

Though I'd just use the num_axis test inline as it is nice and clear.
Also, I guess you can't have a 1 axis sensor?

> +
> +	return 0;
> +}
> +
> +static int scmi_iio_buffer_preenable(struct iio_dev *dev)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(dev);
> +	u32 sensor_config = 0;
> +	int err = scmi_iio_check_valid_sensor(sensor);
> +	u32 sensor_id = sensor->sensor_info->id;
> +
> +	if (err)
> +		return err;
> +
> +	if (sensor->sensor_info->timestamped)
> +		sensor_config = SCMI_SENS_CFG_SET_TSTAMP_ENABLED(sensor_config);
> +
> +	sensor_config = SCMI_SENS_CFG_SET_ENABLE(sensor_config);
> +
> +	err = sensor->handle->notify_ops->register_event_notifier(
> +		sensor->handle, SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> +		&sensor_id, &sensor->sensor_update_nb);
> +

no blank line.

> +	if (err) {
> +		pr_err("Error in registering sensor update notifier for sensor %s err %d",
> +		       sensor->sensor_info->name, err);
> +		return err;
> +	}

blank line

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
> +	u32 sensor_config = 0;
> +	int err = scmi_iio_check_valid_sensor(sensor);
> +	u32 sensor_id = sensor_id = sensor->sensor_info->id;
> +
> +	if (err)
> +		return err;

Same comment as below...  I'm reviewing backwards so won't repeat again
above this.

> +
> +	sensor_config = SCMI_SENS_CFG_SET_DISABLE(sensor_config);
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
> +	err = sensor->handle->sensor_ops->config_set(
> +		sensor->handle, sensor->sensor_info->id, sensor_config);
> +
> +	if (err)
> +		pr_err("Error in disabling sensor %s with err %d",
> +		       sensor->sensor_info->name, err);
> +
> +	return err;
> +}
> +
> +static u64 convert_interval_to_ns(u32 val)
> +{
> +	u64 sensor_update_interval, sensor_interval_mult;
> +	int mult;
> +
> +	mult = SCMI_SENS_INTVL_GET_EXP(val);
> +	sensor_update_interval = SCMI_SENS_INTVL_GET_SECS(val) * NSEC_PER_SEC;
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
> +static int convert_ns_to_freq(u64 interval_ns, struct sensor_freq *freq)
> +{
> +	u64 rem;
> +
> +	if (!freq)
> +		return -EINVAL;

Drop any checks that are never going to fail.

> +
> +	freq->hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
> +	freq->uhz = (rem * 1000000UL) / interval_ns;
> +
> +	return 0;
> +}
> +
> +static ssize_t scmi_iio_sysfs_sampling_freq_avail(struct device *dev,
> +						  struct device_attribute *attr,
> +						  char *buf)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(dev_get_drvdata(dev));
> +	int err = scmi_iio_check_valid_sensor(sensor);

As elsewhere please pull this down out of the definitions block.

> +	struct sensor_freq freq;
> +	u64 lowest_interval_ns, highest_interval_ns, cur_interval_ns,
> +		step_size_ns;
> +	unsigned int lowest_interval, highest_interval, step_size, cur_interval;
> +	int i, len = 0;
> +
> +	if (err)
> +		return err;
> +
> +	if (!sensor->sensor_info->intervals.segmented) {
> +		for (i = 0; i < sensor->sensor_info->intervals.count; i++) {
> +			cur_interval = sensor->sensor_info->intervals.desc[i];
> +			cur_interval_ns = convert_interval_to_ns(cur_interval);
> +			err = convert_ns_to_freq(cur_interval_ns, &freq);
> +			if (err)
> +				return 0;
> +			len += scnprintf(buf + len, PAGE_SIZE - len,
> +					 "%llu.%06llu ", freq.hz, freq.uhz);

So for this case, we have an explicit list. If we have this case you are probably
better off just doing a precise match for the set function below.

> +		}
> +	} else {
> +		// If the intervals are segmented, the intervals array is a triplet
> +		// which constitues a segment in the form of
> +		// [lowest_interval,highest_interval,step_size]
> +		if (sensor->sensor_info->intervals.count != 3) {
> +			pr_err("SCMI sensor %s has segmented update intervals count %d which is not a triplet",
> +			       sensor->sensor_info->name,
> +			       sensor->sensor_info->intervals.count);
> +			return len;
> +		}
> +		lowest_interval = sensor->sensor_info->intervals.desc[0];
> +		highest_interval = sensor->sensor_info->intervals.desc[1];
> +		step_size = sensor->sensor_info->intervals.desc[2];
> +		lowest_interval_ns = convert_interval_to_ns(lowest_interval);
> +		highest_interval_ns = convert_interval_to_ns(highest_interval);
> +		step_size_ns = convert_interval_to_ns(step_size);
> +		cur_interval_ns = lowest_interval_ns;
> +		while (cur_interval_ns <= highest_interval_ns) {
> +			err = convert_ns_to_freq(cur_interval_ns, &freq);
> +			if (err)
> +				return 0;
> +			len += scnprintf(buf + len, PAGE_SIZE - len,
> +					 "%llu.%06llu ", freq.hz, freq.uhz);

This seems rather likely to end up with a list long than a page when printed out
so it'll get truncated which isn't nice.

Our current _avail callback handling provides a format for roughly this but it
won't deal with the inverse here. [low interval high].

I guess we could think about extending that though I'm not sure it's actually all
that useful.  Mostly when you get a device that does this sort interval they are very
dense (it's clock cycles on some internal clock) so all userspace cares about
is max and min values.  We can approximate the steps between them.

> +			cur_interval_ns += step_size_ns;
> +		}
> +	}
> +
> +	if (len > 0)
> +		buf[len - 1] = '\n';
> +	return len;
> +}
> +
> +static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int err = scmi_iio_check_valid_sensor(sensor);
> +	u32 sensor_config = 0, cur_sensor_config;
> +	u64 sec, mult, uHz;
> +	char buf[32];
> +
> +	if (err)
> +		return err;
> +
> +	err = sensor->handle->sensor_ops->config_get(
> +		sensor->handle, sensor->sensor_info->id, &cur_sensor_config);
> +
> +	if (err) {
> +		pr_err("%s: Error in getting sensor config for sensor %s err %d",
> +		       __func__, sensor->sensor_info->name, err);
> +		return err;
> +	}
> +
> +	uHz = ODR_EXPAND(val, val2);
> +
> +	// The seconds field in the sensor interval in SCMI is 16 bits long
> +	// Therefore seconds  = 1/Hz <= 0xFFFF. As floating point calculations are
> +	// discouraged in the kernel driver code, to calculate the scale factor (sf)
> +	// (1* 1000000 * sf)/uHz <= 0xFFFF. Therefore, sf <= (uHz * 0xFFFF)/1000000
> +	//  To calculate the multiplier,we convert the sf into char string  and
> +	//  count the number of characters

Comment syntax + that's an 'unusual' way to handle things. Hmm. I'll have a think
about this.  Definitely feels like there should be 'something' more elegant but
maybe this is the best we can do.

> +
> +	mult = scnprintf(buf, 32, "%llu", ((u64)uHz * 0xFFFF) / UHZ_PER_HZ) - 1;
> +
> +	sec = div64_u64(int_pow(10, mult) * UHZ_PER_HZ, uHz);
> +	if (sec == 0) {
> +		pr_err("Trying to set invalid sensor update value for sensor %s",
> +		       sensor->sensor_info->name);
> +		return -EINVAL;
> +	}
> +
> +	// Not able to use cur_sensor_config to build/modify the sensor config with
> +	// new configuration as the SCMI macros below doesn't clear the old values
> +	// and executes bitwise operations over them. Therefore, building new sensor config
> +	// from scratch.

Better to define the masks necessary to only replace the bits you want.

> +	sensor_config = SCMI_SENS_CFG_SET_UPDATE_SECS(sensor_config, sec);
> +	sensor_config = SCMI_SENS_CFG_SET_UPDATE_MULTI(sensor_config, -mult);
> +	sensor_config = SCMI_SENS_CFG_SET_AUTO_ROUND_UP(sensor_config);


> +	if (sensor->sensor_info->timestamped)
> +		sensor_config = SCMI_SENS_CFG_SET_TSTAMP_ENABLED(sensor_config);
> +	if (SCMI_SENS_CFG_IS_ENABLED(cur_sensor_config))
> +		sensor_config = SCMI_SENS_CFG_SET_ENABLE(sensor_config);
> +	else
> +		sensor_config = SCMI_SENS_CFG_SET_DISABLE(sensor_config);
> +
> +	err = sensor->handle->sensor_ops->config_set(
> +		sensor->handle, sensor->sensor_info->id, sensor_config);
> +
> +	if (err)
> +		pr_err("Error in setting sensor update interval for sensor %s value %u err %d",
> +		       sensor->sensor_info->name, sensor_config, err);
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
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		err = scmi_iio_set_odr_val(iio_dev, val, val2);

If you can't read it back, then cache this in the driver so userspace can get
a value.

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
> +static int scmi_iio_read_raw(struct iio_dev *iio_dev,
> +			     struct iio_chan_spec const *ch, int *val,
> +			     int *val2, long mask)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int ret = scmi_iio_check_valid_sensor(sensor);

iio_priv is fine (it's just a macro) but this is less trivial
so don't do it in the declaration block.  I want to see it down next
to the related error handling.

> +	bool scalar_sensor;
> +	s8 scale;
> +
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:

Given we have channels that claim to support raw values and sampling frequency
I'd rather expected to see more here!

> +		ret = scmi_iio_is_scalar_sensor(sensor->sensor_info,
> +						&scalar_sensor);
> +		if (ret)
> +			return ret;
> +		if (!scalar_sensor) {
> +			if (!ch)
> +				return -EINVAL;
> +			scale = sensor->sensor_info->axis[ch->scan_index].scale;
> +			if (scale < 0) {
> +				scale = -scale;
> +				*val = 1;
> +				*val2 = int_pow(10, scale);
> +				ret = IIO_VAL_FRACTIONAL;
> +			} else {
> +				*val = int_pow(10, scale);
> +				ret = IIO_VAL_INT;
> +			}
> +		} else {
Always handle error case out of line and direct returns make it easy to see
there is nothing to be done on error paths.


		if (scalar_sensor)
			return -EINVAL;

		if (!ch) //note this can't happen so no need to check.
			return -EINVAL;
		scale = ...
		if (scale < 0) {
			...
			return IIO_VAL_FRACTIONAL;
		} else {
			...
> +			ret = -EINVAL;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
Direct returns if there is nos shared cleanup.
		return -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t scmi_iio_get_sensor_power(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(dev_get_drvdata(dev));
> +	int err = scmi_iio_check_valid_sensor(sensor);
> +	int len = 0;
> +
> +	if (err)
> +		return err;
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
> +	int err = scmi_iio_check_valid_sensor(sensor);
> +	int i;
> +	s64 max_range = S64_MIN, max_range_axis;
> +
> +	if (err)
> +		return err;
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
> +}
> +
> +static ssize_t scmi_iio_get_sensor_resolution(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(dev_get_drvdata(dev));
> +	bool scalar_sensor;
> +	int len = 0;
> +	int err = scmi_iio_check_valid_sensor(sensor);
> +
> +	if (err)
> +		return err;
> +
> +	err = scmi_iio_is_scalar_sensor(sensor->sensor_info, &scalar_sensor);
> +	if (err)
> +		return err;
> +
> +	if (!scalar_sensor) {
> +		// All the axes are supposed to have the same value for resolution
> +		// and exponent. We are just using the values from the Axis 0 here.

IIO uses c-style comments.
	 	/*
		 * All...
		 */

> +		if (sensor->sensor_info->axis[0].extended_attrs) {
> +			u32 resolution =
> +				sensor->sensor_info->axis[0].resolution;
> +			s8 exponent = sensor->sensor_info->axis[0].exponent;
> +			u32 multiplier = int_pow(10, abs(exponent));
> +
> +			if (exponent < 0) {
> +				int vals[] = { resolution, multiplier };
> +
> +				len = iio_format_value(buf, IIO_VAL_FRACTIONAL,
> +						       ARRAY_SIZE(vals), vals);
> +			} else {
> +				int vals[] = { resolution * multiplier };
> +
> +				len = iio_format_value(buf, IIO_VAL_INT,
> +						       ARRAY_SIZE(vals), vals);
> +			}
> +		}
> +	}
> +
> +	return len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(scmi_iio_sysfs_sampling_freq_avail);
> +static IIO_DEVICE_ATTR(sensor_power, 0444, scmi_iio_get_sensor_power, NULL, 0);
> +static IIO_DEVICE_ATTR(sensor_max_range, 0444, scmi_iio_get_sensor_max_range,
> +		       NULL, 0);
> +static IIO_DEVICE_ATTR(sensor_resolution, 0444, scmi_iio_get_sensor_resolution,
> +		       NULL, 0);
> +
> +static struct attribute *scmi_iio_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,

Preferred to use the _avail callbacks IIO provides.

> +	&iio_dev_attr_sensor_power.dev_attr.attr,
> +	&iio_dev_attr_sensor_max_range.dev_attr.attr,
> +	&iio_dev_attr_sensor_resolution.dev_attr.attr,

Non standard ABI always starts with docs.  Why do we need these?
I'll warn you now. It takes a really strong argument including
usecases to persuade us to add ABI.  Any new ABI has to be maintained
for ever after all and isn't used by existing software.


> +	NULL,
> +};
> +
> +static const struct attribute_group scmi_iio_attribute_group = {
> +	.attrs = scmi_iio_attributes,
> +};
> +
> +static const struct iio_info scmi_iio_info = {
> +	.read_raw = scmi_iio_read_raw,
> +	.write_raw = scmi_iio_write_raw,
> +	.attrs = &scmi_iio_attribute_group,
> +};
> +
> +static const struct iio_buffer_setup_ops scmi_iio_buffer_ops = {
> +	.preenable = scmi_iio_buffer_preenable,
> +	.postdisable = scmi_iio_buffer_postdisable,
> +};

Please reorganize the code to put this next to the implementations of the ops.

> +
> +static int scmi_iio_get_chan_type(u8 scmi_type, enum iio_chan_type *iio_type)
> +{
> +	int ret = 0;

Always set.

> +
> +	if (!iio_type)
> +		return -EINVAL;

No need to check.

> +
> +	switch (scmi_type) {
> +	case METERS_SEC_SQUARED:

Nice :)  A rare spec using SI units and not g (unlike most bare metal sensors)!

> +		*iio_type = IIO_ACCEL;
> +		break;
> +	case RADIANS_SEC:
> +		*iio_type = IIO_ANGL_VEL;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int scmi_iio_get_chan_modifier(const char *name,
> +				      enum iio_modifier *modifier)
> +{
> +	int ret = 0;
Always set so no need to init.

> +
> +	if (!name || !modifier)
> +		return -EINVAL;
> +
> +	if (strcasecmp(name, "X") == 0)

The spec doesn't specify the case? That's unusual but fair enough
if true.


> +		*modifier = IIO_MOD_X;
> +	else if (strcasecmp(name, "Y") == 0)
> +		*modifier = IIO_MOD_Y;
> +	else if (strcasecmp(name, "Z") == 0)
> +		*modifier = IIO_MOD_Z;
> +	else
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
> +				      enum iio_chan_type type,
> +				      enum iio_modifier mod, int scan_index)
> +{
> +	if (!iio_chan)
> +		return;

Don't check things a quick code inspection show can't happen.


> +
> +	iio_chan->type = type;
> +	iio_chan->modified = 1;
> +	iio_chan->channel2 = mod;
> +	iio_chan->info_mask_separate =
> +		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
> +	iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	iio_chan->scan_index = scan_index;
> +	iio_chan->scan_type.sign = 's';
> +	iio_chan->scan_type.realbits = 64;

I'm going to guess it doesn't really always supply 64 bit data.
Any way we can find out of the real depth is less?

> +	iio_chan->scan_type.storagebits = 64;
> +	iio_chan->scan_type.endianness = IIO_LE;
> +}
> +
> +static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_chan,
> +					   int scan_index)
> +{
> +	if (!iio_chan)
> +		return;

As in other cases, no need to check.

> +
> +	iio_chan->type = IIO_TIMESTAMP;
> +	iio_chan->channel = -1;
> +	iio_chan->scan_index = scan_index;
> +	iio_chan->scan_type.sign = 'u';
> +	iio_chan->scan_type.realbits = 64;
> +	iio_chan->scan_type.storagebits = 64;
> +}
> +
> +static int
> +scmi_iio_alloc_nonscalar_sensor(struct device *dev, struct scmi_handle *handle,
> +				const struct scmi_sensor_info *sensor_info,
> +				struct iio_dev **scmi_iio_dev)
> +{
> +	struct scmi_iio_priv *sensor;
> +	struct iio_chan_spec *iio_channels;
> +	enum iio_chan_type type;
> +	enum iio_modifier modifier;

As type and modifier only used in the loop I'd look to reduce their scope
and move them down there.

> +	struct iio_dev *iio_dev_temp;

I'd drop the _temp postfix.  Doesn't add much info and makes lines longer!

> +	int i, ret = 0;
> +
> +	if (!scmi_iio_dev)
> +		return -EINVAL;

No need to check this as easy to verify by code inspection.

> +
> +	iio_dev_temp = devm_iio_device_alloc(dev, sizeof(struct scmi_iio_priv));

sizeof(*sensor)

> +	if (!iio_dev_temp)
> +		return -ENOMEM;

blank line

> +	iio_dev_temp->modes = INDIO_DIRECT_MODE;
> +	iio_dev_temp->dev.parent = dev;
> +	sensor = iio_priv(iio_dev_temp);
> +	sensor->handle = handle;
> +	sensor->sensor_info = sensor_info;
> +	sensor->sensor_update_nb.notifier_call = sensor_update_cb;
> +	sensor->indio_dev = iio_dev_temp;
> +	iio_dev_temp->num_channels =
> +		sensor_info->num_axis + SCMI_IIO_EXTRA_CHANNELS;
> +	iio_dev_temp->name = sensor_info->name;
> +	iio_dev_temp->info = &scmi_iio_info;

blank line

> +	iio_channels = devm_kzalloc(dev,
> +				    sizeof(struct iio_chan_spec) *

sizeof(*iio_channels) 

> +					    (iio_dev_temp->num_channels),
> +				    GFP_KERNEL);
> +	if (!iio_channels)
> +		return -ENOMEM;

blank line

> +	for (i = 0; i < sensor_info->num_axis; i++) {
> +		ret = scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);
> +		if (ret < 0)
> +			return ret;

blank line.

> +		ret = scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
> +						 &modifier);
> +		if (ret < 0)
> +			return ret;

blank line

> +		scmi_iio_set_data_channel(&iio_channels[i], type, modifier,
> +					  sensor_info->axis[i].id);
> +	}
> +	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> +	iio_dev_temp->channels = iio_channels;
> +	*scmi_iio_dev = iio_dev_temp;
> +	return ret;
> +}
> +
> +static int scmi_alloc_iiodev(struct device *dev, struct scmi_handle *handle,
> +			     const struct scmi_sensor_info *sensor_info,
> +			     struct iio_dev **scmi_iio_dev)
> +{
> +	int ret = 0;

No need to init.

> +	bool scalar_sensor;
> +
> +	ret = scmi_iio_is_scalar_sensor(sensor_info, &scalar_sensor);
> +

nitpick: No blank line here (keep error check in same block of code as the source of the
error).

> +	if (ret)
> +		return ret;
> +
> +	if (!scalar_sensor)
> +		ret = scmi_iio_alloc_nonscalar_sensor(dev, handle, sensor_info,
> +						      scmi_iio_dev);
> +	else
> +		ret = -EINVAL;

Prefer this form.

        if (scalar_sensor)
		return -EINVAL;

	return scmi_iio_aloc ...

Lower indent and error path is clearly out of normal flow.

I'm not sure there is any reason to not have that nonscalar_sensor code inline
here.  Perhaps you have other patches to follow?


> +
> +	return ret;
> +}
> +
> +static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> +{
> +	struct iio_buffer *buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);

For a non trivial call (i.e. something that isn't just a lookup / macro etc,
please don't hide the in the definitions block.

Particularly true when we have two error handling paths not next to the function
calls they are dealing with.

> +	struct scmi_iio_priv *sensor = iio_priv(scmi_iiodev);
> +	int err = scmi_iio_check_valid_sensor(sensor);
> +
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	if (err)
> +		return err;
> +
> +	iio_device_attach_buffer(scmi_iiodev, buffer);
> +	scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
> +	scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;
> +	sensor->iio_buf =
> +		devm_kzalloc(&scmi_iiodev->dev,
> +			     sizeof(s64) * (scmi_iiodev->num_channels),
> +			     GFP_KERNEL);

Given we only ever have a max of 4 s64s we could embed this directly
in sensor->iio_buf and skip the extra allocation here.

> +	if (!sensor->iio_buf)
> +		return -ENOMEM;

blank line.

> +	return 0;
> +}
> +
> +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> +{
> +	struct scmi_handle *handle;
> +	u16 nr_sensors;
> +	struct iio_dev *scmi_iio_dev;

I'd take this down inside the loop to make it apparent the scope
is limited to that loop.

> +	const struct scmi_sensor_info *sensor_info;
> +	int err = 0, i;
> +	struct device *dev;
> +
> +	if (!sdev) {

Something very odd going on if this is remotely possible so I'd drop it.

> +		pr_err("scmi_iio_dev: missing SCMI device\n");
> +		return -ENODEV;
> +	}
> +
> +	dev = &sdev->dev;
Having dropped the above, you can do this as
struct device *dev = &sdev->dev;
Same with handle.

> +
> +	handle = sdev->handle;
> +	if (!handle || !handle->sensor_ops) {
> +		dev_err(dev, "SCMI device has no sensor interface\n");
> +		return -EINVAL;
> +	}
> +
> +	nr_sensors = handle->sensor_ops->count_get(handle);

Hmm. We are being very paranoid about whether sensor_ops is set but
not whether count_get are set?  Clearly there is only one implementation
at the moment, but I assume the ops flexibility is with the thought that
there may one day be more options. Does any code verify they are complete?

> +	if (!nr_sensors) {
> +		dev_warn(dev, "0 sensors found via SCMI bus\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_info(dev, "%d sensors found via SCMI bus\n", nr_sensors);

This is a bit noisy given it should be easy to establish this unless
something goes wrong later.  Perhaps dev_dbg?

> +
> +	for (i = 0; i < nr_sensors; i++) {

Given this code is a bit line length limited, perhaps it's better to
just pull out the per sensor part into a separate function?

> +		sensor_info = handle->sensor_ops->info_get(handle, i);
> +		if (!sensor_info) {
> +			dev_err(dev, "SCMI sensor %d has missing info\n", i);
> +			return -EINVAL;
> +		}

I'd prefer a blank line here to separate groups of action then error check
from each other. (nitpick!)

> +		err = scmi_alloc_iiodev(dev, handle, sensor_info,
> +					&scmi_iio_dev);
> +		if (err < 0) {
> +			dev_err(dev,
> +				"memory allocation error at sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
> +		}
> +		if (!scmi_iio_dev) {
> +			dev_err(dev, "memory allocation failed at sensor %s\n",
> +				sensor_info->name);
> +			return -ENOMEM;
> +		}

blank line.

> +		err = scmi_iio_buffers_setup(scmi_iio_dev);
> +		if (err < 0) {
> +			dev_err(dev,
> +				"IIO buffer setup error at sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
> +		}

blank line

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
> +static void scmi_iio_dev_remove(struct scmi_device *sdev)
> +{
> +	pr_debug("scmi_iio_drv_remove\n");

Drop remove().  Lots of other ways of finding out if it has gone
away.

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
> +	.remove = scmi_iio_dev_remove,
> +	.id_table = scmi_id_table,
> +};
> +
> +module_scmi_driver(scmi_iiodev_driver);
> +
> +MODULE_AUTHOR("Jyoti Bhayana <jbhayana@google.com>");
> +MODULE_DESCRIPTION("SCMI IIO Driver");
> +MODULE_LICENSE("GPL v2");

