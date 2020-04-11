Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C091A528C
	for <lists+linux-iio@lfdr.de>; Sat, 11 Apr 2020 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgDKPAu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Apr 2020 11:00:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44982 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDKPAu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2020 11:00:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id w24so3675268qts.11;
        Sat, 11 Apr 2020 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+PO2ufymKULW25Y9GlHx3SDNZpo+b01cmamcGndY0vA=;
        b=MysQpQvoYZS8LTGCjHl+NGruiahIAVnfm68yEiQmP8BQI0wuEBptSQ76psyZ5G/YNK
         HfHdYCpLP5tN0HXp8UHVj8xmwSPDdbvj7SuocsUi8vKCSEA0HY3KeeScc2TtvUo9xhgv
         Isne6gwaw3BguxTWLpAvzeed88Zt9aMjV2FcAlqFd2RxQG1HZzLzNQh7zIwgMz5TyW74
         0LHIc9WhxDJN0GO9baJOLtJzaeGfR5d/p9AaFVF6euHFSbe0zYvGAe5Dco2R+jNZfI2v
         tmpAcioRpjEb1JptJ2qkZRh+IxyORQozDMP+QW6J1J8dzxgtCJL45Y58zGTwJty/iokN
         JCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+PO2ufymKULW25Y9GlHx3SDNZpo+b01cmamcGndY0vA=;
        b=lia+6b7Vd3UxE7ITsPGJvo659eeKtfeF0v2FmjDQUQLV4J5umhf/K1JFeCo1r8Z8UE
         JqDq7RdUvJ+CvTyiwJ156z630RafNzXXiRkmcFLGs+xIUumiC/+3dLRZbbrhhEXIFX6E
         58uXKKGGMcbTU/AnayZSjjkift3DB0vtUjHnwxiRR/BoVKaFhkPo4pn0ER/WCf+mfJd6
         mvh8S7k8ZKISZpUTty82f2QJsl0HoR/D8QTNi2w3aj4p7hKE0Iv6LLeWTCSaHhleBmQI
         HX+UTciQmUNa5ness1U+4pCBZYrVk6IqpXz/DJ/jR/2V5GDdNDj+Pc5vH5iXhKg+ZoP8
         cKXA==
X-Gm-Message-State: AGi0PuYlX+nBJ89ry9/jnwMqQARFvYVUqdky6pd7V8INckTm/PPvMORM
        wtJGngtRBe531KGgDsnWSFE=
X-Google-Smtp-Source: APiQypIY2k9S1/Lqr0JAWfCn2IpcdxAC/FeDQSSsl73QenzM6oNs8NWCUZ8yZ91RIvcXqyZPpcGtSA==
X-Received: by 2002:ac8:19f5:: with SMTP id s50mr3997401qtk.186.1586617247247;
        Sat, 11 Apr 2020 08:00:47 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id o6sm3802541qkd.113.2020.04.11.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 08:00:46 -0700 (PDT)
Date:   Sat, 11 Apr 2020 11:00:32 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        jic23@kernel.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] drivers: counter: Add Cros EC Sync counter
Message-ID: <20200411150032.GA9011@icarus>
References: <20200408053655.99957-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20200408053655.99957-1-gwendal@chromium.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2020 at 10:36:55PM -0700, Gwendal Grignou wrote:
> When the camera vsync pin is connected to the embedded controller (EC) of
> a chromebook, the EC reports a sensor with a counter that increases
> at each GPIO rising edge.
>=20
> The sensor is presented using the counter subsystem.
> In addition, it is also presented via the IIO subsystem with a timestamp,
> allowing synchronisation with sensors connected to the same EC, for
> image stabilisation or augmented reality applications.
>=20
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
>=20
> To read the current counter value:
> via counter ABI:
> cat counterX/count0/count
> via iio ABI
> cat iio:deviceY/in_count_raw
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
> An initial version of the driver was presented few month ago at
> https://patchwork.kernel.org/patch/11037009/
>=20
>  drivers/counter/Kconfig                       |  11 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/cros_ec_sync.c                | 342 ++++++++++++++++++
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  15 +
>  drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
>  .../linux/iio/common/cros_ec_sensors_core.h   |   4 +-
>  6 files changed, 375 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/counter/cros_ec_sync.c

Hi Gwendal,

I'm getting some conflicts when I try to merge this patch, so it looks
like we're on different bases. Would you be able to rebase on the
current testing branch of the IIO tree and resubmit this patch?

Thanks,

William Breathitt Gray

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
> index 0000000000000..94b3ababab4bd
> --- /dev/null
> +++ b/drivers/counter/cros_ec_sync.c
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for synchronisation sensor behind CrOS EC.
> + *
> + * Copyright 2020 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
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
> +	mutex_unlock(&st->cmd_lock);
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

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6R24QACgkQhvpINdm7
VJJa4w//eoCsuFVZLo0hSXXLgQDKkeU+odwWe5wiBbtqJIQMMmcYFxSkFnTqg6YF
/+Z24zyu3NtD6YvoBxSwT3DhLbFvqZm6hJK/0Bv41XsS8uffgZHDrjutjzR55kjj
cKS/kLL1Sc0IGvbRsXOQWriEHHPzX4/Ms85XtMZNP6ZX8GFalO7yjJbOWLgHpfMJ
HyPZ+tJATU+kcfrg0caB2Vl2iHZAU5CHRkv84u+BFgOf7kF13RziG3wf8EBg2Eqz
TF5WOGY6IKZcUZHTtwXxeBiUDy0Ryf0bWIxPx8RXpTHhKsuvuM0Lta5Y/y4nT2+5
rYF6sTtbSQB/kFt3rd3FwKcT+HO+8eX1PZajZvvlEfYD6I0okykluFxB5LGmLT97
l0rVxBlTmhfR1Yi4At8kqQJQnjaqeNQg0nlHQXZuxeLer2eu7JhsmqY6eZTHsyhw
mQSui/52WPYKuWvYaB4LTHhVKKubKq6+/aHTcvVCwa9wKiywjdCq0CsmFlSZALMN
gzV/laZMIbYEjzsB2nFaCFiVOTP+q/xWY+VA1q2HMff2SeR1R2mTJ4CrNScEG9sP
3DBPVQoF6iuPZMENRUnpwY32X6fOdk/tctXR0DIcuKkSCODY0ypsqneSwTgXqKX0
+rnLZ/zMN9QrzrZEVZAkJrHvy23Am8MqWXlnhRnN5wzzYOe5/Nk=
=Xa0A
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
