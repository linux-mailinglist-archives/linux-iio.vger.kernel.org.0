Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B247550
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfFPOwT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 10:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfFPOwT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 10:52:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 152C0216FD;
        Sun, 16 Jun 2019 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560696737;
        bh=nw6QCwBWzQmU4itaV3x4ca6qrF8NBF2ByXX4ETYE1nw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B+Yg+0B6nNUPMXxt4p/YNpxiy4fyh9prmDfJIMxRSchmOYxK8ajoGNCkW3qdd4Ky0
         nKzUYThbbXVN76CHy4jO1AVEAi8DSdImnONkqFSKE/wyej9Pv+fkIZWP1ABJU+dMhW
         1rhhPAaJrKxCP/cHvFh9BUhJaJh98uaW4sCl5wSI=
Date:   Sun, 16 Jun 2019 15:52:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ronald =?UTF-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: apple-ib-als: Add driver for ALS on
 iBridge chip.
Message-ID: <20190616155212.7b5b488c@archlinux>
In-Reply-To: <20190612083400.1015-4-ronald@innovation.ch>
References: <20190612083400.1015-1-ronald@innovation.ch>
        <20190612083400.1015-4-ronald@innovation.ch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Jun 2019 01:34:00 -0700
Ronald Tschal=C3=A4r <ronald@innovation.ch> wrote:

> On 2016/2017 MacBook Pro's with a Touch Bar the ALS is attached to,
> and exposed via the iBridge device. This provides the driver for that
> sensor.
>=20
> Signed-off-by: Ronald Tschal=C3=A4r <ronald@innovation.ch>
Hi Ronald,

One thing that we should perhaps document more clearly in IIO is that
it is acceptable to not have triggers if they don't make any sense.
In this particular case, you have one basically to give a way of saying
to move into a more continuous sampling mode from a polled one (I think).
For that just use the buffer enable callbacks.

It'll be much cleaner without the trigger.

A few other suggestions inline.  In particularly I'm not that keen on the
appleals_device having a pointer to the iio device which then has
a pointer back again.  I 'think' you can just reorder things a bit and
embed the appleals_device structure in the iio_dev private field directly
and avoid the dance between the different structures.

Thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig        |  12 +
>  drivers/iio/light/Makefile       |   1 +
>  drivers/iio/light/apple-ib-als.c | 607 +++++++++++++++++++++++++++++++
>  3 files changed, 620 insertions(+)
>  create mode 100644 drivers/iio/light/apple-ib-als.c
>=20
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 5190eacfeb0a..b477aa5d2024 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -64,6 +64,18 @@ config APDS9960
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called apds9960
> =20
> +config APPLE_IBRIDGE_ALS
> +	tristate "Apple iBridge ambient light sensor"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	depends on HID_APPLE_IBRIDGE
> +	help
> +	  Say Y here to build the driver for the Apple iBridge ALS
> +	  sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called apple-ib-als.
> +
>  config BH1750
>  	tristate "ROHM BH1750 ambient light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index e40794fbb435..cd6cd5ba6da5 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_ADJD_S311)		+=3D adjd_s311.o
>  obj-$(CONFIG_AL3320A)		+=3D al3320a.o
>  obj-$(CONFIG_APDS9300)		+=3D apds9300.o
>  obj-$(CONFIG_APDS9960)		+=3D apds9960.o
> +obj-$(CONFIG_APPLE_IBRIDGE_ALS)	+=3D apple-ib-als.o
>  obj-$(CONFIG_BH1750)		+=3D bh1750.o
>  obj-$(CONFIG_BH1780)		+=3D bh1780.o
>  obj-$(CONFIG_CM32181)		+=3D cm32181.o
> diff --git a/drivers/iio/light/apple-ib-als.c b/drivers/iio/light/apple-i=
b-als.c
> new file mode 100644
> index 000000000000..b84be0076e0f
> --- /dev/null
> +++ b/drivers/iio/light/apple-ib-als.c
> @@ -0,0 +1,607 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple Ambient Light Sensor Driver
> + *
> + * Copyright (c) 2017-2018 Ronald Tschal=C3=A4r
> + */
> +
> +/*
> + * MacBookPro models with an iBridge chip (13,[23] and 14,[23]) have an
> + * ambient light sensor that is exposed via one of the USB interfaces on
> + * the iBridge as a standard HID light sensor. However, we cannot use the
> + * existing hid-sensor-als driver, for two reasons:
> + *
> + * 1. The hid-sensor-als driver is part of the hid-sensor-hub which in t=
urn
> + *    is a hid driver, but you can't have more than one hid driver per h=
id
> + *    device, which is a problem because the touch bar also needs to
> + *    register as a driver for this hid device.
> + *
> + * 2. While the hid-sensors-als driver stores sensor readings received v=
ia
> + *    interrupt in an iio buffer, reads on the sysfs
> + *    .../iio:deviceX/in_illuminance_YYY attribute result in a get of the
> + *    feature report; however, in the case of this sensor here the
> + *    illuminance field of that report is always 0. Instead, the input
> + *    report needs to be requested.
> + */
> +
> +#define dev_fmt(fmt) "als: " fmt
> +
> +#include <linux/apple-ibridge.h>
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/hid-sensor-ids.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#define APPLEALS_DYN_SENS		0	/* our dynamic sensitivity */
> +#define APPLEALS_DEF_CHANGE_SENS	APPLEALS_DYN_SENS
> +
> +struct appleals_device {
> +	struct hid_device	*hid_dev;
> +	struct hid_report	*cfg_report;
> +	struct hid_field	*illum_field;
> +	struct iio_dev		*iio_dev;
> +	int			cur_sensitivity;
> +	int			cur_hysteresis;
> +	bool			events_enabled;
> +};
> +
> +static struct hid_driver appleals_hid_driver;
> +
> +/*
> + * This is a primitive way to get a relative sensitivity, one where we g=
et
> + * notified when the value changes by a certain percentage rather than s=
ome
> + * absolute value. MacOS somehow manages to configure the sensor to work=
 this
> + * way (with a 15% relative sensitivity), but I haven't been able to fig=
ure
> + * out how so far. So until we do, this provides a less-than-perfect
> + * simulation.
> + *
> + * When the brightness value is within one of the ranges, the sensitivit=
y is
> + * set to that range's sensitivity. But in order to reduce flapping when=
 the
> + * brightness is right on the border between two ranges, the ranges over=
lap
> + * somewhat (by at least one sensitivity), and sensitivity is only chang=
ed if
> + * the value leaves the current sensitivity's range.
> + *
> + * The values chosen for the map are somewhat arbitrary: a compromise of=
 not
> + * too many ranges (and hence changing the sensitivity) but not too smal=
l or
> + * large of a percentage of the min and max values in the range (current=
ly
> + * from 7.5% to 30%, i.e. within a factor of 2 of 15%), as well as just =
plain
> + * "this feels reasonable to me".
> + */
> +struct appleals_sensitivity_map {
> +	int	sensitivity;
> +	int	illum_low;
> +	int	illum_high;
> +};
> +
> +static const struct appleals_sensitivity_map appleals_sensitivity_map[] =
=3D {
> +	{   1,    0,   14 },
> +	{   3,   10,   40 },
> +	{   9,   30,  120 },
> +	{  27,   90,  360 },
> +	{  81,  270, 1080 },
> +	{ 243,  810, 3240 },
> +	{ 729, 2430, 9720 },
> +};
> +
> +static int appleals_compute_sensitivity(int cur_illum, int cur_sens)
> +{
> +	const struct appleals_sensitivity_map *entry;
> +	int i;
> +
> +	/* see if we're still in current range */
> +	for (i =3D 0; i < ARRAY_SIZE(appleals_sensitivity_map); i++) {
> +		entry =3D &appleals_sensitivity_map[i];
> +
> +		if (entry->sensitivity =3D=3D cur_sens &&
> +		    entry->illum_low <=3D cur_illum &&
> +		    entry->illum_high >=3D cur_illum)
> +			return cur_sens;
> +		else if (entry->sensitivity > cur_sens)
> +			break;
> +	}
> +
> +	/* not in current range, so find new sensitivity */
> +	for (i =3D 0; i < ARRAY_SIZE(appleals_sensitivity_map); i++) {
> +		entry =3D &appleals_sensitivity_map[i];
> +
> +		if (entry->illum_low <=3D cur_illum &&
> +		    entry->illum_high >=3D cur_illum)
> +			return entry->sensitivity;
> +	}
> +
> +	/* hmm, not in table, so assume we are above highest range */
> +	i =3D ARRAY_SIZE(appleals_sensitivity_map) - 1;
> +	return appleals_sensitivity_map[i].sensitivity;
> +}
> +
> +static int appleals_get_field_value_for_usage(struct hid_field *field,
> +					      unsigned int usage)
> +{
> +	int u;
> +
> +	if (!field)
> +		return -1;
> +
> +	for (u =3D 0; u < field->maxusage; u++) {
> +		if (field->usage[u].hid =3D=3D usage)
> +			return u + field->logical_minimum;
> +	}
> +
> +	return -1;
> +}
> +
> +static __s32 appleals_get_field_value(struct appleals_device *als_dev,
> +				      struct hid_field *field)
> +{
> +	bool powered_on =3D !hid_hw_power(als_dev->hid_dev, PM_HINT_FULLON);
> +
> +	hid_hw_request(als_dev->hid_dev, field->report, HID_REQ_GET_REPORT);
> +	hid_hw_wait(als_dev->hid_dev);
> +
> +	if (powered_on)
> +		hid_hw_power(als_dev->hid_dev, PM_HINT_NORMAL);
> +
> +	return field->value[0];
> +}
> +
> +static void appleals_set_field_value(struct appleals_device *als_dev,
> +				     struct hid_field *field, __s32 value)
> +{
> +	hid_set_field(field, 0, value);
> +	hid_hw_request(als_dev->hid_dev, field->report, HID_REQ_SET_REPORT);
> +}
> +
> +static int appleals_get_config(struct appleals_device *als_dev,
> +			       unsigned int field_usage, __s32 *value)
> +{
> +	struct hid_field *field;
> +
> +	field =3D appleib_find_report_field(als_dev->cfg_report, field_usage);
> +	if (!field)
> +		return -EINVAL;
> +
> +	*value =3D appleals_get_field_value(als_dev, field);
> +
> +	return 0;
> +}
> +
> +static int appleals_set_config(struct appleals_device *als_dev,
> +			       unsigned int field_usage, __s32 value)
> +{
> +	struct hid_field *field;
> +
> +	field =3D appleib_find_report_field(als_dev->cfg_report, field_usage);
> +	if (!field)
> +		return -EINVAL;
> +
> +	appleals_set_field_value(als_dev, field, value);
> +
> +	return 0;
> +}
> +
> +static int appleals_set_enum_config(struct appleals_device *als_dev,
> +				    unsigned int field_usage,
> +				    unsigned int value_usage)
> +{
> +	struct hid_field *field;
> +	int value;
> +
> +	field =3D appleib_find_report_field(als_dev->cfg_report, field_usage);
> +	if (!field)
> +		return -EINVAL;
> +
> +	value =3D appleals_get_field_value_for_usage(field, value_usage);
> +	if (value >=3D 0)
> +		appleals_set_field_value(als_dev, field, value);
> +
> +	return 0;
> +}
> +
> +static void appleals_update_dyn_sensitivity(struct appleals_device *als_=
dev,
> +					    __s32 value)
> +{
> +	int new_sens;
> +	int rc;
> +
> +	new_sens =3D appleals_compute_sensitivity(value,
> +						als_dev->cur_sensitivity);
> +	if (new_sens !=3D als_dev->cur_sensitivity) {
> +		rc =3D appleals_set_config(als_dev,
> +			HID_USAGE_SENSOR_LIGHT_ILLUM |
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS,
> +			new_sens);
> +		if (!rc)
> +			als_dev->cur_sensitivity =3D new_sens;
> +	}
> +}
> +
> +static void appleals_push_new_value(struct appleals_device *als_dev,
> +				    __s32 value)
> +{
> +	__s32 buf[2] =3D { value, value };
> +
> +	iio_push_to_buffers(als_dev->iio_dev, buf);
> +
> +	if (als_dev->cur_hysteresis =3D=3D APPLEALS_DYN_SENS)
> +		appleals_update_dyn_sensitivity(als_dev, value);
> +}
> +
> +static int appleals_hid_event(struct hid_device *hdev, struct hid_field =
*field,
> +			      struct hid_usage *usage, __s32 value)
> +{
> +	struct appleals_device *als_dev =3D hid_get_drvdata(hdev);
> +	int rc =3D 0;
> +
> +	if ((usage->hid & HID_USAGE_PAGE) !=3D HID_UP_SENSOR)
> +		return 0;
> +
> +	if (usage->hid =3D=3D HID_USAGE_SENSOR_LIGHT_ILLUM) {
> +		appleals_push_new_value(als_dev, value);
> +		rc =3D 1;
Direct return here would be more readable, then return 0 below.
> +	}
> +
> +	return rc;
> +}
> +
> +static int appleals_enable_events(struct iio_trigger *trig, bool enable)
> +{
> +	struct appleals_device *als_dev =3D iio_trigger_get_drvdata(trig);
> +	int value;
> +
> +	appleals_set_enum_config(als_dev, HID_USAGE_SENSOR_PROP_REPORT_STATE,
> +		enable ? HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM :
> +			 HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM);
> +	als_dev->events_enabled =3D enable;
> +
> +	/* if the sensor was enabled, push an initial value */
> +	if (enable) {
> +		value =3D appleals_get_field_value(als_dev, als_dev->illum_field);
> +		appleals_push_new_value(als_dev, value);
> +	}
> +
> +	return 0;
> +}
> +
> +static int appleals_read_raw(struct iio_dev *iio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct appleals_device **priv =3D iio_priv(iio_dev);
> +	struct appleals_device *als_dev =3D *priv;
> +	__s32 value;
> +	int rc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		*val =3D appleals_get_field_value(als_dev, als_dev->illum_field);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rc =3D appleals_get_config(als_dev,
> +					 HID_USAGE_SENSOR_PROP_REPORT_INTERVAL,
> +					 &value);
> +		if (rc)
> +			return rc;
> +
> +		/* interval is in ms; val is in HZ, val2 in =C2=B5HZ */
> +		value =3D 1000000000 / value;
> +		*val =3D value / 1000000;
> +		*val2 =3D value - (*val * 1000000);
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		if (als_dev->cur_hysteresis =3D=3D APPLEALS_DYN_SENS) {
> +			*val =3D als_dev->cur_hysteresis;
> +			return IIO_VAL_INT;
> +		}
> +
> +		rc =3D appleals_get_config(als_dev,
> +			HID_USAGE_SENSOR_LIGHT_ILLUM |
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS,
> +			val);
> +		if (!rc) {
> +			als_dev->cur_sensitivity =3D *val;
> +			als_dev->cur_hysteresis =3D *val;
> +		}
> +		return rc ? rc : IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int appleals_write_raw(struct iio_dev *iio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct appleals_device **priv =3D iio_priv(iio_dev);
> +	struct appleals_device *als_dev =3D *priv;
> +	__s32 illum;
> +	int rc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rc =3D appleals_set_config(als_dev,
> +					 HID_USAGE_SENSOR_PROP_REPORT_INTERVAL,
> +					 1000000000 / (val * 1000000 + val2));
> +		return rc;
> +
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		if (val =3D=3D APPLEALS_DYN_SENS) {

Hysteresis normally takes a value, this looks like a magic number being
pushed through the interface?

> +			if (als_dev->cur_hysteresis !=3D APPLEALS_DYN_SENS) {
> +				als_dev->cur_hysteresis =3D val;
> +				illum =3D appleals_get_field_value(als_dev,
> +							als_dev->illum_field);
> +				appleals_update_dyn_sensitivity(als_dev, illum);
> +			}
> +
> +			return 0;
> +		}
> +
> +		rc =3D appleals_set_config(als_dev,
> +			HID_USAGE_SENSOR_LIGHT_ILLUM |
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS,
> +			val);
> +		if (!rc) {
> +			als_dev->cur_sensitivity =3D val;
> +			als_dev->cur_hysteresis =3D val;
> +		}
> +
> +		return rc;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec appleals_channels[] =3D {
> +	{
> +		.type =3D IIO_INTENSITY,
> +		.modified =3D 1,
> +		.channel2 =3D IIO_MOD_LIGHT_BOTH,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),

This would be unusual.  What are the units of this intensity measurement?
Mostly these are the values prior to a proprietary algorithm and have no
particular assigned units that are documented anywhere.  As such for
most light sensors this is raw.

> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 32,
> +			.storagebits =3D 32,
> +		},
> +		.scan_index =3D 0,
> +	},
> +	{
> +		.type =3D IIO_LIGHT,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.scan_type =3D {
> +			.sign =3D 'u',
> +			.realbits =3D 32,
> +			.storagebits =3D 32,
> +		},
> +		.scan_index =3D 1,
> +	}
> +};
> +
> +static const struct iio_trigger_ops appleals_trigger_ops =3D {
> +	.set_trigger_state =3D &appleals_enable_events,
> +};
> +
> +static const struct iio_info appleals_info =3D {
> +	.read_raw =3D &appleals_read_raw,
> +	.write_raw =3D &appleals_write_raw,
> +};
> +
> +static void appleals_config_sensor(struct appleals_device *als_dev,
> +				   bool events_enabled, int sensitivity)
> +{
> +	struct hid_field *field;
> +	bool powered_on;
> +	__s32 val;
> +
> +	powered_on =3D !hid_hw_power(als_dev->hid_dev, PM_HINT_FULLON);
> +
> +	hid_hw_request(als_dev->hid_dev, als_dev->cfg_report,
> +		       HID_REQ_GET_REPORT);
> +	hid_hw_wait(als_dev->hid_dev);
> +
> +	field =3D appleib_find_report_field(als_dev->cfg_report,
> +					  HID_USAGE_SENSOR_PROY_POWER_STATE);
> +	val =3D appleals_get_field_value_for_usage(field,
> +			HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM);
> +	if (val >=3D 0)
> +		hid_set_field(field, 0, val);
> +
> +	field =3D appleib_find_report_field(als_dev->cfg_report,
> +					  HID_USAGE_SENSOR_PROP_REPORT_STATE);
> +	val =3D appleals_get_field_value_for_usage(field,
> +		events_enabled ?
> +			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM :
> +			HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM);
> +	if (val >=3D 0)
> +		hid_set_field(field, 0, val);
> +
> +	field =3D appleib_find_report_field(als_dev->cfg_report,
> +					 HID_USAGE_SENSOR_PROP_REPORT_INTERVAL);
> +	hid_set_field(field, 0, field->logical_minimum);
> +
> +	/*
> +	 * Set initial change sensitivity; if dynamic, enabling trigger will set
> +	 * it instead.
> +	 */
> +	if (sensitivity !=3D APPLEALS_DYN_SENS) {
> +		field =3D appleib_find_report_field(als_dev->cfg_report,
> +			HID_USAGE_SENSOR_LIGHT_ILLUM |
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS);
> +
> +		hid_set_field(field, 0, sensitivity);
> +	}
> +
> +	hid_hw_request(als_dev->hid_dev, als_dev->cfg_report,
> +		       HID_REQ_SET_REPORT);
> +
> +	if (powered_on)
> +		hid_hw_power(als_dev->hid_dev, PM_HINT_NORMAL);
> +}
> +
> +static int appleals_config_iio(struct appleals_device *als_dev)
> +{
> +	struct iio_dev *iio_dev;
> +	struct iio_trigger *iio_trig;
> +	struct appleals_device **priv;
> +	struct device *parent =3D &als_dev->hid_dev->dev;
> +	int rc;
> +
> +	iio_dev =3D devm_iio_device_alloc(parent, sizeof(als_dev));
> +	if (!iio_dev)
> +		return -ENOMEM;

Hmm. So we are using the private space of the iio device to just
hold a pointer...
Normally we try to avoid this if at all possible as we end
up with loops of pointers that normally indicate a someone
convoluted driver structure.  I've not checked all the paths
here to be sure if we can just embed the actual als_dev
structure in here and always have the iio_dev available in
any callbacks etc.

> +
> +	priv =3D iio_priv(iio_dev);
> +	*priv =3D als_dev;
> +
> +	iio_dev->channels =3D appleals_channels;
> +	iio_dev->num_channels =3D ARRAY_SIZE(appleals_channels);
> +	iio_dev->dev.parent =3D parent;
> +	iio_dev->info =3D &appleals_info;
> +	iio_dev->name =3D "als";
Whilst I suppose not many people will have additional ALS devices connected
to these laptops, we normally try to give a slightly more specific name
than this.

> +	iio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	rc =3D devm_iio_triggered_buffer_setup(parent, iio_dev,
> +					     &iio_pollfunc_store_time, NULL,
This is unusual.  You have registered all the infrastructure for a triggered
buffer, but then didn't actually provide a function to put any data in it.

It is perfectly acceptable to just skip the trigger if it doesn't make sense
for a given device. If you are doing that, then register the buffer directly
not using this helper.

> +					     NULL);
> +	if (rc) {
> +		hid_err(als_dev->hid_dev,
> +			"Failed to set up iio triggered buffer: %d\n", rc);
> +		return rc;
> +	}
> +
> +	iio_trig =3D devm_iio_trigger_alloc(parent, "%s-dev%d", iio_dev->name,
> +					  iio_dev->id);
> +	if (!iio_trig)
> +		return -ENOMEM;
> +
> +	iio_trig->dev.parent =3D parent;
> +	iio_trig->ops =3D &appleals_trigger_ops;
> +	iio_trigger_set_drvdata(iio_trig, als_dev);
> +
> +	rc =3D devm_iio_trigger_register(parent, iio_trig);
> +	if (rc) {
> +		hid_err(als_dev->hid_dev,
> +			"Failed to register iio trigger: %d\n",
> +			rc);
> +		return rc;
> +	}

What is the purpose of this trigger? It doesn't seem to 'do' anything. There
is no function calling iio_trigger_poll* so it's not acting as a trigger.

> +
> +	rc =3D devm_iio_device_register(parent, iio_dev);
> +	if (rc) {
> +		hid_err(als_dev->hid_dev, "Failed to register iio device: %d\n",
> +			rc);
> +		return rc;
> +	}
> +
> +	als_dev->iio_dev =3D iio_dev;
> +
> +	return 0;
> +}
> +
> +static int appleals_probe(struct hid_device *hdev,
> +			  const struct hid_device_id *id)
> +{
> +	struct appleals_device *als_dev;
> +	struct hid_field *state_field;
> +	struct hid_field *illum_field;
> +	int rc;
> +
> +	/* find als fields and reports */
> +	rc =3D hid_parse(hdev);
> +	if (rc) {
> +		hid_err(hdev, "als: hid parse failed (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	state_field =3D appleib_find_hid_field(hdev, HID_USAGE_SENSOR_ALS,
> +					    HID_USAGE_SENSOR_PROP_REPORT_STATE);
> +	illum_field =3D appleib_find_hid_field(hdev, HID_USAGE_SENSOR_ALS,
> +					     HID_USAGE_SENSOR_LIGHT_ILLUM);
> +	if (!state_field || !illum_field)
> +		return -ENODEV;
> +
> +	hid_dbg(hdev, "Found ambient light sensor\n");
> +
> +	/* initialize device */
> +	als_dev =3D devm_kzalloc(&hdev->dev, sizeof(*als_dev), GFP_KERNEL);
> +	if (!als_dev)
> +		return -ENOMEM;
> +
> +	als_dev->hid_dev =3D hdev;
> +	als_dev->cfg_report =3D state_field->report;
> +	als_dev->illum_field =3D illum_field;
> +
> +	als_dev->cur_hysteresis =3D APPLEALS_DEF_CHANGE_SENS;
> +	als_dev->cur_sensitivity =3D APPLEALS_DEF_CHANGE_SENS;
> +
> +	hid_set_drvdata(hdev, als_dev);
> +
> +	rc =3D hid_hw_start(hdev, HID_CONNECT_DRIVER);
> +	if (rc) {
> +		hid_err(hdev, "als: hw start failed (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	hid_device_io_start(hdev);
> +	appleals_config_sensor(als_dev, false, als_dev->cur_sensitivity);
> +	hid_device_io_stop(hdev);
> +
> +	rc =3D appleals_config_iio(als_dev);
> +	if (rc)
> +		return rc;
> +
> +	return hid_hw_open(hdev);
> +}
> +
> +#ifdef CONFIG_PM
> +static int appleals_reset_resume(struct hid_device *hdev)
> +{
> +	struct appleals_device *als_dev =3D hid_get_drvdata(hdev);
> +	__s32 illum;
> +
> +	appleals_config_sensor(als_dev, als_dev->events_enabled,
> +			       als_dev->cur_sensitivity);
> +
> +	illum =3D appleals_get_field_value(als_dev, als_dev->illum_field);
> +	appleals_push_new_value(als_dev, illum);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct hid_device_id appleals_hid_ids[] =3D {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LINUX_FOUNDATION,
> +			 USB_DEVICE_ID_IBRIDGE_ALS) },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(hid, appleals_hid_ids);
> +
> +static struct hid_driver appleals_hid_driver =3D {
> +	.name =3D "apple-ib-als",
> +	.id_table =3D appleals_hid_ids,
> +	.probe =3D appleals_probe,
> +	.event =3D appleals_hid_event,
> +#ifdef CONFIG_PM
> +	.reset_resume =3D appleals_reset_resume,
> +#endif
> +};
> +
> +module_hid_driver(appleals_hid_driver);
> +
> +MODULE_AUTHOR("Ronald Tschal=C3=A4r");
> +MODULE_DESCRIPTION("Apple iBridge ALS driver");
> +MODULE_LICENSE("GPL v2");

