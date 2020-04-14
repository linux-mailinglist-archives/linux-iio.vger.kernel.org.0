Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8181A8CD0
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 22:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633372AbgDNUsa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729251AbgDNUsT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 16:48:19 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4BC061A0C;
        Tue, 14 Apr 2020 13:48:19 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id f13so11377191qti.5;
        Tue, 14 Apr 2020 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BxjyGP367A1mWJT2MsjczSKf/D/JRPjVTEQaV25WuXM=;
        b=RODNPDjIuNDr7EyVn14vikNVU/i0d25FyviUox8bm4CGvl4fhMqdiOQpQ4goLIxy8Q
         TnwkuG6IwzbqX+yxMU6+BBPnJ0uDcoHPpwiEJ7YcUrcmu75L30UChoN1ojlIGmhRE7W8
         YLx4d3WdVnnSr/2fxvvkMo5eq7BqX2uS+Ax88DrawqLRjxH9VOekOLnPpiVMhxLd2fsN
         CPa+0yXpRv1N/ZouH9WK7PFJH4Uvg0SWhXm9kU/p87RJw7Y7L3b6p0p+VenQ5bDr0rb+
         OkFyG0roHroYdbg4k1LfvvIEbWp4Z8nIFcQwG+QQBhJU5sE0qLJu+0vU5Gk/5Ao8KMcr
         11IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BxjyGP367A1mWJT2MsjczSKf/D/JRPjVTEQaV25WuXM=;
        b=SF4qMPV5jKq+/i9BVvhFRYqnRHuoxFe33G63dp2UqvLWv1Zw5uWkQwyjK1uTiPPeId
         kV6n5ZAcYP35/lnrcNQ+jnymbelgPTvHWBDKqgdfCjlslXOO7OruqMWzpNSzvYks690U
         gIHMw3bKMR8EwThUc5U4h4Lyyn4FVpj5RXIeCzJEB3bE2Wmn9jx0dUDxWsK6kU7VryH5
         xK7B01uNGtvPqsqt9tTuNNs5CKmZOEIwk6RUDgI1q0pDwV1J+vsLsocRcpWFMQdnHJQO
         W9bwRG8fz/+as3vVJIOiLkAd4vHwC7tQWinOM1UKejQ81RwpOnADKT9UlH/csskiZGmq
         laFw==
X-Gm-Message-State: AGi0Pubj1tdy8DMR3ewExiSQ+kckkBb/Z+WSFEI4ZT5GIPExX9rQplfw
        Y51i5obvotxwtb0qxDs0jzd/rn5cKi4=
X-Google-Smtp-Source: APiQypIB7lr/sxnbtIv9ZMvYlOFz/us9gaqJrot7NpVXoii976myucprPy+c8oXpes//up3icaz4yQ==
X-Received: by 2002:ac8:7286:: with SMTP id v6mr18165876qto.299.1586897298298;
        Tue, 14 Apr 2020 13:48:18 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id s14sm8525963qts.70.2020.04.14.13.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:48:16 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:48:14 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, jic23@kernel.org,
        bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] drivers: counter: Add Cros EC Sync counter
Message-ID: <20200414204814.GH7347@icarus>
References: <20200413195514.192868-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline
In-Reply-To: <20200413195514.192868-1-gwendal@chromium.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2020 at 12:55:14PM -0700, Gwendal Grignou wrote:
> When the camera vsync pin is connected to the embedded controller (EC) of
> a chromebook, the EC reports a sensor with a counter that increases
> at each GPIO rising edge.
>=20
> The sensor is presented using the counter subsystem.
> In addition, it is also presented via the IIO subsystem with a timestamp,
> allowing synchronisation with sensors connected to the same EC, for
> image stabilisation or augmented reality applications.

Hi Gwendal,

Sorry for the delay. I have some changes requested below.

> To enable the counter:
> via counter ABI:
> echo "rising edge" > counterX/count0/signal_action
> via iio ABI
> echo 1 > iio:deviceY/en
>=20
> To disable the counter:
> via counter ABI:
> echo "none" > counterX/count0/signal_action
> via iio ABI
> echo 0 > iio:deviceY/en

Although in theory a user could manually disable the actions for a
Signal, this is a very roundabout way of actually disabling the Count.
It's better to expose an "enable" attribute to allow the users to
perform this functionality; for example:

echo 0 > counterX/count0/enable
echo 1 > counterX/count0/enable

>=20
> To read the current counter value:
> via counter ABI:
> cat counterX/count0/count
> via iio ABI
> cat iio:deviceY/in_count_raw

I know we discussed this in the last review but it's still the same as
before: IIO_COUNT interface is deprecated so new drivers won't be
allowed to use it. You'll have to remove the IIO_COUNT code in this
driver and replace it with Counter subsystem equivalents.

> We can also read the value through the IIO buffer:
> echo 1 > iio:deviceY/scan_elements/in_timestamp_en
> echo 1 > iio:deviceY/scan_elements/in_count_en
> echo 1 > iio:deviceY/buffer/enable
>=20
> and each time to counter increase, the following binary blob
> will be appended to dev/iio:deviceY:
> 000f 0000 0000 0000 dc66 816c 0071 0000
>  \   <-- padding -> <-- timestamp ---->
>   count
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v2:
> - fix license.
> - remove extra unlock.
>=20
>  drivers/counter/Kconfig                       |  11 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/cros_ec_sync.c                | 332 ++++++++++++++++++
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  15 +
>  drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
>  .../linux/iio/common/cros_ec_sensors_core.h   |   4 +-
>  6 files changed, 365 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/counter/cros_ec_sync.c
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index c80fa76bb5311..18fde918ff40b 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -29,6 +29,17 @@ config 104_QUAD_8
>  	  The base port addresses for the devices may be configured via the base
>  	  array module parameter.
> =20
> +config CROS_EC_SYNC
> +	tristate "ChromeOS EC Counter driver"
> +	depends on IIO_CROS_EC_SENSORS_CORE
> +	help
> +	  Module to handle synchronisation sensor presented by the ChromeOS EC
> +	  Sensor hub.
> +	  Synchronisation sensor sends event to the host when the camera
> +	  take a picture. It allows synchronisation with other MEMS sensor,
> +	  like gyroscope for image statbilization or augmented reality
> +	  application (AR).
> +
>  config STM32_TIMER_CNT
>  	tristate "STM32 Timer encoder counter driver"
>  	depends on MFD_STM32_TIMERS || COMPILE_TEST
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 55142d1f4c436..98378fca50ad6 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_COUNTER) +=3D counter.o
> =20
>  obj-$(CONFIG_104_QUAD_8)	+=3D 104-quad-8.o
> +obj-$(CONFIG_CROS_EC_SYNC)	+=3D cros_ec_sync.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+=3D stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+=3D stm32-lptimer-cnt.o
>  obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
> diff --git a/drivers/counter/cros_ec_sync.c b/drivers/counter/cros_ec_syn=
c.c
> new file mode 100644
> index 0000000000000..4e644d651fde6
> --- /dev/null
> +++ b/drivers/counter/cros_ec_sync.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for synchronisation sensor behind CrOS EC.
> + *
> + * Copyright 2020 Google LLC.
> + *
> + * This driver uses the cros-ec interface to communicate with the Chrome=
 OS
> + * EC about counter sensors. Counters are presented through
> + * iio sysfs.
> + */
> +
> +#include <linux/counter.h>
> +#include <linux/device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/cros_ec_sensors_core.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/*
> + * One channel for counter, the other for timestamp.
> + */
> +#define MAX_CHANNELS (1 + 1)
> +
> +/**
> + * struct cros_ec_sync_state - device structure
> + *
> + * @core: common structure for all cros_ec sensor.
> + *        Must be at the beggining.
> + * @channels: presented iio channels(2).
> + * @counter: counter data structure.
> + */
> +struct cros_ec_sync_state {
> +	struct cros_ec_sensors_core_state core;
> +	struct iio_chan_spec channels[MAX_CHANNELS];
> +	struct counter_device counter;
> +};
> +
> +/**
> + * cros_ec_sync_get_enable() - Check if the counter is enabled.
> + *
> + * @st:     core cros_ec sensor
> + * @val:    status: 0: disabled, 1 enabled.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +static int cros_ec_sync_get_enable(struct cros_ec_sensors_core_state *st,
> +				   int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd =3D MOTIONSENSE_CMD_SENSOR_ODR;
> +	st->param.sensor_odr.data =3D EC_MOTION_SENSE_NO_VALUE;
> +
> +	ret =3D cros_ec_motion_send_host_cmd(st, 0);
> +	mutex_unlock(&st->cmd_lock);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D !!st->resp->sensor_odr.ret;
> +	return 0;
> +}
> +
> +/**
> + * cros_ec_sync_set_enable() - Allow the counter to count.
> + *
> + * When enable, the counter will increase for each VSYNC rising edge
> + * and will produce an event in the iio buffer, if enabled.
> + *
> + * @st:     core cros_ec sensor
> + * @val:    0: disable, 1 enable.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +static int cros_ec_sync_set_enable(struct cros_ec_sensors_core_state *st,
> +				   int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->cmd_lock);
> +	st->param.cmd =3D MOTIONSENSE_CMD_SENSOR_ODR;
> +	st->param.sensor_odr.data =3D val;
> +	st->param.sensor_odr.roundup =3D 1;
> +
> +	ret =3D cros_ec_motion_send_host_cmd(st, 0);
> +	mutex_unlock(&st->cmd_lock);
> +	return ret;
> +}
> +
> +static int cros_ec_sync_iio_read(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	struct cros_ec_sensors_core_state *st =3D iio_priv(indio_dev);
> +	u16 data;
> +	int ret;
> +	int idx =3D chan->scan_index;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->cmd_lock);
> +		ret =3D cros_ec_sensors_read_cmd(indio_dev, 1 << idx, &data);
> +		mutex_unlock(&st->cmd_lock);
> +		if (ret < 0)
> +			break;
> +		ret =3D IIO_VAL_INT;
> +		*val =3D data;
> +		break;
> +	case IIO_CHAN_INFO_ENABLE:
> +		ret =3D cros_ec_sync_get_enable(st, val);
> +		if (ret < 0)
> +			break;
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int cros_ec_sync_iio_write(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int val, int val2, long mask)
> +{
> +	struct cros_ec_sensors_core_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		if (val < 0 || val > 1)
> +			return -EINVAL;
> +
> +		return cros_ec_sync_set_enable(st, val);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info cros_ec_sync_info =3D {
> +	.read_raw =3D &cros_ec_sync_iio_read,
> +	.write_raw =3D &cros_ec_sync_iio_write,
> +};
> +
> +/* The counter can only increase, so only one function present. */
> +static enum counter_count_function cros_ec_sync_functions[] =3D {
> +	COUNTER_COUNT_FUNCTION_INCREASE,
> +};
> +
> +/* 2 synapse actions allowed: count for each rising edge, or not. */
> +static enum counter_synapse_action cros_ec_sync_synapse_actions[] =3D {
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +};
> +
> +static int cros_ec_sync_read_count(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   unsigned long *val)
> +{
> +	struct cros_ec_sensors_core_state *st =3D counter->priv;
> +	u16 raw;
> +	int ret;
> +
> +	mutex_lock(&st->cmd_lock);
> +	ret =3D cros_ec_sensors_read_cmd(iio_priv_to_dev(st), 1, &raw);
> +	mutex_unlock(&st->cmd_lock);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D raw;
> +	return 0;
> +}
> +
> +static int cros_ec_sync_function_get(struct counter_device *counter,
> +				     struct counter_count *count,
> +				     size_t *function)
> +{
> +	*function =3D 0;

It's somewhat unclear at first glance which function correlates to index
position 0 here. Create an enum structure and use the enum constants to
set the index of the functions in cros_ec_sync_functions. Then you can
set *function to the corresponding enum constant here -- that should
make it clear which function is returned.

Take a look at the drivers/counter/ftm-quaddec.c file for a good example
of how it handles the function_get callback.

> +	return 0;
> +}
> +
> +static int cros_ec_sync_action_get(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   struct counter_synapse *synapse,
> +				   size_t *action)
> +{
> +	struct cros_ec_sensors_core_state *st =3D counter->priv;
> +	int ret;
> +	int raw;
> +
> +	ret =3D cros_ec_sync_get_enable(st, &raw);
> +	if (ret)
> +		return ret;
> +
> +	*action =3D !!raw;

For the same reason as the function_get callback above, I'd like for
*action to be explicitly set to a respective named constant.

> +	return 0;
> +}
> +
> +static int cros_ec_sync_action_set(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   struct counter_synapse *synapse,
> +				   size_t action)
> +{
> +	struct cros_ec_sensors_core_state *st =3D counter->priv;
> +
> +	return cros_ec_sync_set_enable(st, action);
> +}
> +
> +static const struct counter_ops cros_ec_sync_ops =3D {
> +	.count_read =3D cros_ec_sync_read_count,
> +	.function_get =3D cros_ec_sync_function_get,
> +	.action_get =3D cros_ec_sync_action_get,
> +	.action_set =3D cros_ec_sync_action_set,

It doesn't look like setting the action is actually a feature of this
device. I'd recommend just dropping the action_set callback all together
and instead implementing an "enable" attribute for your Count to handle
that functionality.

> +};
> +
> +static struct counter_signal cros_ec_sync_signals[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "vsync"
> +	}
> +};
> +
> +static struct counter_synapse cros_ec_sync_synapses[] =3D {
> +	{
> +		.actions_list =3D cros_ec_sync_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(cros_ec_sync_synapse_actions),
> +		.signal =3D cros_ec_sync_signals
> +	}
> +};
> +
> +static struct counter_count cros_ec_sync_counts[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "vsync",
> +		.functions_list =3D cros_ec_sync_functions,
> +		.num_functions =3D ARRAY_SIZE(cros_ec_sync_functions),
> +		.synapses =3D cros_ec_sync_synapses,
> +		.num_synapses =3D ARRAY_SIZE(cros_ec_sync_synapses),
> +	}
> +};
> +
> +static int cros_ec_sync_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct cros_ec_sync_state *state;
> +	struct iio_chan_spec *channel;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret =3D cros_ec_sensors_core_init(pdev, indio_dev, true,
> +					cros_ec_sensors_capture,
> +					cros_ec_sensors_push_data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info =3D &cros_ec_sync_info;
> +	state =3D iio_priv(indio_dev);
> +
> +	/* Initialize IIO device */
> +	channel =3D state->channels;
> +
> +	/* Counter channel */
> +	channel->type =3D IIO_COUNT;
> +	channel->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
> +	channel->info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_ENABLE);
> +	channel->scan_type.realbits =3D CROS_EC_SENSOR_BITS;
> +	channel->scan_type.storagebits =3D CROS_EC_SENSOR_BITS;
> +	channel->scan_type.shift =3D 0;
> +	channel->scan_index =3D 0;
> +	channel->ext_info =3D cros_ec_sensors_limited_info;
> +	channel->scan_type.sign =3D 'u';

As I mentioned earlier, this counter channel should be completely
removed. You'll need to reimplement the cros_ec_sensors_limited_info
attributes using the Counter subsystem. I'll explain this more below.

> +
> +	/* Timestamp channel */
> +	channel++;
> +	channel->type =3D IIO_TIMESTAMP;
> +	channel->channel =3D -1;
> +	channel->scan_index =3D 1;
> +	channel->scan_type.sign =3D 's';
> +	channel->scan_type.realbits =3D 64;
> +	channel->scan_type.storagebits =3D 64;
> +
> +	indio_dev->channels =3D state->channels;
> +	indio_dev->num_channels =3D MAX_CHANNELS;
> +
> +	state->core.read_ec_sensors_data =3D cros_ec_sensors_read_cmd;
> +
> +	/* Initialize Counter device */
> +	state->counter.name =3D dev_name(&pdev->dev);
> +	state->counter.parent =3D &pdev->dev;
> +	state->counter.ops =3D &cros_ec_sync_ops;
> +	state->counter.counts =3D cros_ec_sync_counts;
> +	state->counter.num_counts =3D ARRAY_SIZE(cros_ec_sync_counts);
> +	state->counter.signals =3D cros_ec_sync_signals;
> +	state->counter.num_signals =3D ARRAY_SIZE(cros_ec_sync_signals);
> +	state->counter.priv =3D state;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_counter_register(dev, &state->counter);
> +}
> +
> +static const struct platform_device_id cros_ec_sync_ids[] =3D {
> +	{
> +		.name =3D "cros-ec-sync",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_sync_ids);
> +
> +static struct platform_driver cros_ec_sync_platform_driver =3D {
> +	.driver =3D {
> +		.name	=3D "cros-ec-sync",
> +	},
> +	.probe		=3D cros_ec_sync_probe,
> +	.id_table	=3D cros_ec_sync_ids,
> +};
> +module_platform_driver(cros_ec_sync_platform_driver);
> +
> +MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
> +MODULE_DESCRIPTION("ChromeOS EC synchronisation sensor driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/=
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index c831915ca7e56..3a15094616710 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -31,6 +31,7 @@
>  static char *cros_ec_loc[] =3D {
>  	[MOTIONSENSE_LOC_BASE] =3D "base",
>  	[MOTIONSENSE_LOC_LID] =3D "lid",
> +	[MOTIONSENSE_LOC_CAMERA] =3D "camera",
>  	[MOTIONSENSE_LOC_MAX] =3D "unknown",
>  };
> =20
> @@ -467,6 +468,20 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_=
ext_info[] =3D {
>  };
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
> =20
> +const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[] =3D {
> +	{
> +		.name =3D "id",
> +		.shared =3D IIO_SHARED_BY_ALL,
> +		.read =3D cros_ec_sensors_id
> +	},
> +	{
> +		.name =3D "location",
> +		.shared =3D IIO_SHARED_BY_ALL,
> +		.read =3D cros_ec_sensors_loc
> +	},
> +	{ },
> +};

Instead of an iio_chan_spec_ext_info structure, you can reimplement this
as a counter_count_ext structure. It'll look something like this:

const struct counter_count_ext cros_ec_sensors_limited_info[] =3D {
	{
		.name =3D "id",
		.read =3D cros_ec_sensors_id
	},
	{
		.name =3D "location",
		.read =3D cros_ec_sensors_loc
	},
};

Note however that cros_ec_sensors_id and cros_ec_sensors_loc will need
to match expected function format for counter_count_ext read callbacks;
that means you'll need to implement proper versions of these two
functions.

William Breathitt Gray

> +EXPORT_SYMBOL_GPL(cros_ec_sensors_limited_info);
>  /**
>   * cros_ec_sensors_idx_to_reg - convert index into offset in shared memo=
ry
>   * @st:		pointer to state information for device
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platfo=
rm/chrome/cros_ec_sensorhub.c
> index b7f2c00db5e1e..e4ae0868d1e06 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -106,6 +106,9 @@ static int cros_ec_sensorhub_register(struct device *=
dev,
>  		case MOTIONSENSE_TYPE_ACTIVITY:
>  			name =3D "cros-ec-activity";
>  			break;
> +		case MOTIONSENSE_TYPE_SYNC:
> +			name =3D "cros-ec-sync";
> +			break;
>  		default:
>  			dev_warn(dev, "unknown type %d\n",
>  				 sensorhub->resp->info.type);
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/li=
nux/iio/common/cros_ec_sensors_core.h
> index 7bc961defa87e..e416b28cf24c7 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -114,7 +114,9 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors=
_core_state *st,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask);
> =20
> -/* List of extended channel specification for all sensors */
> +/* List of extended channel specification for all sensors. */
> +extern const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[=
];
> +/* Add calibration to set above. */
>  extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
>  extern const struct attribute *cros_ec_sensor_fifo_attributes[];
> =20
> --=20
> 2.26.0.110.g2183baf09c-goog
>=20

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6WIYIACgkQhvpINdm7
VJL9Qg/9G+KIucbQTGWk80QRFdH7meHjYRiIu5dfPE7MkYH0gwrxhv5uqrolXDdr
x1hD6iiyvOBETZULiFPgolEuWna8GhV0ADpD64N+tl1A9aggG0+mgZG1c6WUpFkv
ktt/iY+EpevKULmeHzPlfoZzwKTzyx+IHr8yuu0jaVe4/3MHISFkJcmLqLhOOfRV
3nsB7Sfh05xvThA0ZoF6XPDX0o9yj+bN1z00ffuA4+vcnNcfEUZLOA4lMMekLfaC
FZynWPdC4tY+o0YqSnMJQblMC7U3aRLfdwpT2JuUZJ+BfqBb+BzYhjJnafc1gmpS
QyBLz+DrI+gj0chdYban7UG0dvTgYeNlxbfrisfTl38x3zR8zVXBm/qaSeFQTdha
lP7BZElHdV1aeRU0tf0ZSLSWZLCVw6ACdOm92krU+gSyGDfFmh+y2HXkj90OL02H
/ChHqpWCdeQZF76R2VBTBndUA2bdOuD24KSyC58mdK6DUbADIurV3KFGKJ98B8UG
j9mJcpYX9FaC5zSpxrVPEUsy8mWZxh4J8XHDicfNMZhwytB8A00CoFThEdiIxEpc
YN6ymVOAeJMoQURPMuI6Ag2CCU0S4jY2d6nymrBnFIbeb927igFfQ95i6MHbkwDO
Z1rmPSpz2txE74MUrawfqkC25yuF451liYfU/ubXrRAVqhkxOZE=
=BOu6
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
