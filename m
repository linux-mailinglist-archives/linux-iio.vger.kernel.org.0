Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0CC2B6D34
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 19:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKQSXP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 13:23:15 -0500
Received: from foss.arm.com ([217.140.110.172]:34450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgKQSXP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Nov 2020 13:23:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AF78101E;
        Tue, 17 Nov 2020 10:23:13 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA9D3F70D;
        Tue, 17 Nov 2020 10:23:10 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:23:08 +0000
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
Subject: Re: [RFC PATCH 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20201117182308.GD30029@e120937-lin>
References: <20201113170611.378887-1-jbhayana@google.com>
 <20201113170611.378887-2-jbhayana@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113170611.378887-2-jbhayana@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jyoti,

just some initial feedback down below.
I'll get back to this series again next days.

On Fri, Nov 13, 2020 at 05:06:11PM +0000, Jyoti Bhayana wrote:
> This change provides ARM SCMI Protocol based IIO device.
> This driver provides support for Accelerometer and Gyroscope using
> new SCMI Sensor Protocol defined by the upcoming SCMIv3.0
> ARM specification
> 
> Signed-off-by: Jyoti Bhayana <jbhayana@google.com>
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

I removed this kind of SET macros from the last series of SCMIv3.0 Sensors
that you are using because I fully converted to use bitfield.h facilities
and so I tried to stick to the usage pattern described in the comment at
the start of include/linux/bitfield.h:

/*
 * Bitfield access macros
 *
 * FIELD_{GET,PREP} macros take as first parameter shifted mask                                          
 * from which they extract the base mask and shift amount.
 * Mask must be a compilation time constant.                                                             
 *                                                                                                       
 * Example:                                                                                              
 *
 *  #define REG_FIELD_A  GENMASK(6, 0)                                                                   
 *  #define REG_FIELD_B  BIT(7)                                                                          
 *  #define REG_FIELD_C  GENMASK(15, 8)
 *  #define REG_FIELD_D  GENMASK(31, 16)
 *
 * Get:
 *  a = FIELD_GET(REG_FIELD_A, reg);
 *  b = FIELD_GET(REG_FIELD_B, reg);
 *
 * Set:
 *  reg = FIELD_PREP(REG_FIELD_A, 1) |
 *        FIELD_PREP(REG_FIELD_B, 0) |
 *        FIELD_PREP(REG_FIELD_C, c) |
 *        FIELD_PREP(REG_FIELD_D, 0x40);
 *
 * Modify:
 *  reg &= ~REG_FIELD_C;
 *  reg |= FIELD_PREP(REG_FIELD_C, c);                                                                   
 */


and also because (I could be wrong) it seemed to me that were a bit
ambiguos in fact in their behaviour of modifying one of its argument.
(without clearing multibiot field in advance as you noted below)

Down below I reported a few usage example using just bitfield.h style
and the available MASK fields in scmi_protocol.h.

Let me know what you think about this.

> +
> +//one additional channel for timestamp

This C++ style comment should have been reported by checkpatch.

> +#define SCMI_IIO_EXTRA_CHANNELS 1
> +
> +struct scmi_iio_priv {
> +	struct scmi_handle *handle;
> +	const struct scmi_sensor_info *sensor_info;
> +	struct iio_dev *indio_dev;
> +	u8 *iio_buf;
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

Maybe inline ?

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
> +
> +	return 0;
> +}
> +

Haven't you checked already in probe() that all the sensor_info that you
process are NON null ?

So that the inner check abpve is not needed and this helper could be simple:

static bool scmi_iio_is_scalar_sensor(const struct scmi_sensor_info *sensor_info)

or better a macro something like:

IS_SCALAR_SENSOR(s)	((s)->num_axis == 0)

but I could have missed something.

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

		sensor_config |=
			FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK, 1);
> +
> +	sensor_config = SCMI_SENS_CFG_SET_ENABLE(sensor_config);
> +
		sensor_config |=
			FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK, 1);

> +	err = sensor->handle->notify_ops->register_event_notifier(
> +		sensor->handle, SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> +		&sensor_id, &sensor->sensor_update_nb);
> +
> +	if (err) {
> +		pr_err("Error in registering sensor update notifier for sensor %s err %d",
> +		       sensor->sensor_info->name, err);
> +		return err;
> +	}
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
> +
> +	sensor_config = SCMI_SENS_CFG_SET_DISABLE(sensor_config);

	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK, 0);
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

I'm handling this in SCMI Sensors now, so you should not even see any
NON null sensors_info with segmented intervals non in a single triplet.
And it's probably better tp add in scmi_protocol.h trivial common defines
to map LOW, HIGH STEP without using 0,1,2

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
> +

C++ comment

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
> +	sensor_config = SCMI_SENS_CFG_SET_UPDATE_SECS(sensor_config, sec);

	cur_sensor_config &= ~SCMI_SENS_CFG_UPDATE_SECS_MASK;
	cur_sensor_config |=
		FIELD_PREP(SCMI_SENS_CFG_UPDATE_SECS_MASK, sec);

> +	sensor_config = SCMI_SENS_CFG_SET_UPDATE_MULTI(sensor_config, -mult);

	cur_sensor_config &= ~SCMI_SENS_CFG_UPDATE_EXP_MASK;
	cur_sensor_config |=
		FIELD_PREP(SCMI_SENS_CFG_UPDATE_EXP_MASK, -multi);

> +	sensor_config = SCMI_SENS_CFG_SET_AUTO_ROUND_UP(sensor_config);

	cur_sensor_config &= ~SCMI_SENS_CFG_ROUND_MASK;
	cur_sensor_config |=
		FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);

> +	if (sensor->sensor_info->timestamped)
> +		sensor_config = SCMI_SENS_CFG_SET_TSTAMP_ENABLED(sensor_config);

		cur_sensor_config |=
			FIELD_PREP(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK, 1);

> +	if (SCMI_SENS_CFG_IS_ENABLED(cur_sensor_config))
> +		sensor_config = SCMI_SENS_CFG_SET_ENABLE(sensor_config);

		cur_sensor_config |=
			FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK, 1);

> +	else
> +		sensor_config = SCMI_SENS_CFG_SET_DISABLE(sensor_config);

		cur_sensor_config |=
			FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK, 0);
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
> +	bool scalar_sensor;
> +	s8 scale;
> +
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
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
> +			ret = -EINVAL;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +

Two things here:

- if you are not going to handle any SCALAR sensor couldn't you just
  remove from your list of sensors at probe time ? or fail is NO such
  sensor can exist as Accel or Gyro. 

- not sure if being a generic SCMI IIODEV driver which supports some set
  of Accel and Gyro you can just ignore scalar sensors (if they could
  exists)

Thanks

Cristian

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
> +	&iio_dev_attr_sensor_power.dev_attr.attr,
> +	&iio_dev_attr_sensor_max_range.dev_attr.attr,
> +	&iio_dev_attr_sensor_resolution.dev_attr.attr,
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
> +
> +static int scmi_iio_get_chan_type(u8 scmi_type, enum iio_chan_type *iio_type)
> +{
> +	int ret = 0;
> +
> +	if (!iio_type)
> +		return -EINVAL;
> +
> +	switch (scmi_type) {
> +	case METERS_SEC_SQUARED:
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
> +
> +	if (!name || !modifier)
> +		return -EINVAL;
> +
> +	if (strcasecmp(name, "X") == 0)
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
> +	iio_chan->scan_type.storagebits = 64;
> +	iio_chan->scan_type.endianness = IIO_LE;
> +}
> +
> +static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_chan,
> +					   int scan_index)
> +{
> +	if (!iio_chan)
> +		return;
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
> +	struct iio_dev *iio_dev_temp;
> +	int i, ret = 0;
> +
> +	if (!scmi_iio_dev)
> +		return -EINVAL;
> +
> +	iio_dev_temp = devm_iio_device_alloc(dev, sizeof(struct scmi_iio_priv));
> +	if (!iio_dev_temp)
> +		return -ENOMEM;
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
> +	iio_channels = devm_kzalloc(dev,
> +				    sizeof(struct iio_chan_spec) *
> +					    (iio_dev_temp->num_channels),
> +				    GFP_KERNEL);
> +	if (!iio_channels)
> +		return -ENOMEM;
> +	for (i = 0; i < sensor_info->num_axis; i++) {
> +		ret = scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);
> +		if (ret < 0)
> +			return ret;
> +		ret = scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
> +						 &modifier);
> +		if (ret < 0)
> +			return ret;
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
> +	bool scalar_sensor;
> +
> +	ret = scmi_iio_is_scalar_sensor(sensor_info, &scalar_sensor);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!scalar_sensor)
> +		ret = scmi_iio_alloc_nonscalar_sensor(dev, handle, sensor_info,
> +						      scmi_iio_dev);
> +	else
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> +{
> +	struct iio_buffer *buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
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
> +	if (!sensor->iio_buf)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> +{
> +	struct scmi_handle *handle;
> +	u16 nr_sensors;
> +	struct iio_dev *scmi_iio_dev;
> +	const struct scmi_sensor_info *sensor_info;
> +	int err = 0, i;
> +	struct device *dev;
> +
> +	if (!sdev) {
> +		pr_err("scmi_iio_dev: missing SCMI device\n");
> +		return -ENODEV;
> +	}
> +
> +	dev = &sdev->dev;
> +
> +	handle = sdev->handle;
> +	if (!handle || !handle->sensor_ops) {
> +		dev_err(dev, "SCMI device has no sensor interface\n");
> +		return -EINVAL;
> +	}
> +
> +	nr_sensors = handle->sensor_ops->count_get(handle);
> +	if (!nr_sensors) {
> +		dev_warn(dev, "0 sensors found via SCMI bus\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_info(dev, "%d sensors found via SCMI bus\n", nr_sensors);
> +
> +	for (i = 0; i < nr_sensors; i++) {
> +		sensor_info = handle->sensor_ops->info_get(handle, i);
> +		if (!sensor_info) {
> +			dev_err(dev, "SCMI sensor %d has missing info\n", i);
> +			return -EINVAL;
> +		}
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
> +		err = scmi_iio_buffers_setup(scmi_iio_dev);
> +		if (err < 0) {
> +			dev_err(dev,
> +				"IIO buffer setup error at sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
> +		}
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
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
