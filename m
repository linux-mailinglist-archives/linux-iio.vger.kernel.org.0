Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9057F68DB
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 13:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfKJMKO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 07:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfKJMKN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 07:10:13 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F0B20818;
        Sun, 10 Nov 2019 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573387812;
        bh=JxULpGgtjsrLTTRw33GnhZjuZB1QzCuSehwzjm45W0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=beT5XNp+TfByyZBKvsunzpT1vQ+VQq+bqAsN5xx3yk2Nzl6H5Rt64cvOo/cNqKuqv
         Gb58VwgG0jO65Qg7+Q3Q5Rh4ddbIlDSx0Q/oeuuJAAPOK5vlIXrfHYkUHxvhNN96s0
         srMUabdvjYsA09EDniSayMrw0B5tTe/iG/PyPiW8=
Date:   Sun, 10 Nov 2019 12:10:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 02/17] platform: cros_ec: Add cros_ec_sensor_hub
 driver
Message-ID: <20191110121004.0167542e@archlinux>
In-Reply-To: <20191105222652.70226-3-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
        <20191105222652.70226-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Nov 2019 14:26:37 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Similar to HID sensor stack, the new driver sits between cros_ec_dev
> and the iio device drivers:
>=20
> EC based iio device topology would be:
> iio:device1 ->
> ...0/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.6.auto/
>                                          cros-ec-sensorhub.7.auto/
>                                          cros-ec-accel.15.auto/
>                                          iio:device1
>=20
> It will be expanded to control EC sensor FIFO.
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Random suggestion for a possible cleanup...

Would a devm_platform_device_register_data make sense?  Drops a
fair bit of boilerplate in here.  If its not a common enough
pattern, could use the devm_add_action_or_reset route
to do the same thing.

I would suggest this as a possible future element, but you
have some other issues around that area that this would cleanup
nicely for you.  See inline.


Thanks,

Jonathan



> ---
> Changes in v4:
> - Use platform_device_register_data in children registration.
> - Free registered pdev children at remove time.
> - Remove useless includes
> - Check patch with --strict option
>     Use sizeof(*obj) instead of sizeof(struct ...obj)
>     Alignement
> - Describe cros_ec_sensorhub in kernel-doc format.
> Changes in v3:
> - Fix doxygen comments
> - Fix use of ret |=3D
> - Remove unncessary goto.
> Changes in v2:
> - Remove unerelated changes.
> - Fix spelling.
> - Use !x instead of x =3D=3D NULL
> - Use platform_ API directly to register IIO sensors from
>   cros_ec_sensorhub.
>=20
>  drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
>  drivers/platform/chrome/Kconfig               |  12 +
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/cros_ec_sensorhub.c   | 223 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_sensorhub.h   |  33 +++
>  5 files changed, 270 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
>  create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h
>=20
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/com=
mon/cros_ec_sensors/Kconfig
> index cdbb29cfb907..fefad9572790 100644
> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  config IIO_CROS_EC_SENSORS_CORE
>  	tristate "ChromeOS EC Sensors Core"
> -	depends on SYSFS && CROS_EC
> +	depends on SYSFS && CROS_EC_SENSORHUB
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kc=
onfig
> index ee5f08ea57b6..56a25317a6be 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -190,6 +190,18 @@ config CROS_EC_DEBUGFS
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_ec_debugfs.
> =20
> +config CROS_EC_SENSORHUB
> +	tristate "ChromeOS EC MEMS Sensor Hub"
> +	depends on CROS_EC && IIO

Could relax the IIO dependency I think...  Get you more build coverage.

> +	help
> +	  Allow loading IIO sensors. This driver is loaded by MFD and will in
> +	  turn query the EC and register the sensors.
> +	  It also spreads the sensor data coming from the EC to the IIO sensor
> +	  object.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cros_ec_sensorhub.
> +
>  config CROS_EC_SYSFS
>  	tristate "ChromeOS EC control and information through sysfs"
>  	depends on MFD_CROS_EC_DEV && SYSFS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/M=
akefile
> index 477ec3d1d1c9..a164c40dc099 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_CROS_EC_PROTO)		+=3D cros_ec_proto.o cros_=
ec_trace.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+=3D cros_kbd_led_backlight.o
>  obj-$(CONFIG_CROS_EC_CHARDEV)		+=3D cros_ec_chardev.o
>  obj-$(CONFIG_CROS_EC_LIGHTBAR)		+=3D cros_ec_lightbar.o
> +obj-$(CONFIG_CROS_EC_SENSORHUB)		+=3D cros_ec_sensorhub.o
>  obj-$(CONFIG_CROS_EC_VBC)		+=3D cros_ec_vbc.o
>  obj-$(CONFIG_CROS_EC_DEBUGFS)		+=3D cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_SYSFS)		+=3D cros_ec_sysfs.o
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platfo=
rm/chrome/cros_ec_sensorhub.c
> new file mode 100644
> index 000000000000..6a0aa84cf092
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SensorHub: driver that discover sensors behind
> + * a ChromeOS Embedded controller.
> + *
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_ec_sensorhub.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DRV_NAME		"cros-ec-sensorhub"
> +
> +static struct platform_device *cros_ec_sensorhub_allocate_single_sensor(
> +		struct device *parent,
> +		char *sensor_name,
> +		int sensor_num)
> +{
> +	struct cros_ec_sensor_platform sensor_platforms =3D {
> +		.sensor_num =3D sensor_num,
> +	};
> +
> +	return platform_device_register_data(parent, sensor_name,
> +				PLATFORM_DEVID_AUTO,
> +				&sensor_platforms,
> +				sizeof(sensor_platforms));
> +}
> +
> +static int cros_ec_sensorhub_register(struct device *dev,
> +				      struct cros_ec_sensorhub *sensorhub)

As noted below, I'd be happier if this function did it's own cleanup on
error rather than leaving that for the caller.

> +{
> +	int ret, i, id, sensor_num;
> +	struct cros_ec_dev *ec =3D sensorhub->ec;
> +	int sensor_type[MOTIONSENSE_TYPE_MAX] =3D { 0 };
> +	struct ec_params_motion_sense *params;
> +	struct ec_response_motion_sense *resp;
> +	struct cros_ec_command *msg;
> +	struct platform_device *pdev;
> +	char *name;
> +
> +	sensor_num =3D cros_ec_get_sensor_count(ec);
> +	if (sensor_num < 0) {
> +		dev_err(dev,
> +			"Unable to retrieve sensor information (err:%d)\n",
> +			sensor_num);
> +		return sensor_num;
> +	}
> +
> +	if (sensor_num =3D=3D 0) {
> +		dev_err(dev, "Zero sensors reported.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Prepare a message to send INFO command to each sensor. */
> +	msg =3D kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
> +		      GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version =3D 1;
> +	msg->command =3D EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> +	msg->outsize =3D sizeof(*params);
> +	msg->insize =3D sizeof(*resp);
> +	params =3D (struct ec_params_motion_sense *)msg->data;
> +	resp =3D (struct ec_response_motion_sense *)msg->data;
> +
> +	id =3D 0;
> +	for (i =3D 0; i < sensor_num; i++) {
> +		params->cmd =3D MOTIONSENSE_CMD_INFO;
> +		params->info.sensor_num =3D i;
> +		ret =3D cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> +		if (ret < 0) {
> +			dev_warn(dev, "no info for EC sensor %d : %d/%d\n",
> +				 i, ret, msg->result);
> +			continue;
> +		}
> +		switch (resp->info.type) {
> +		case MOTIONSENSE_TYPE_ACCEL:
> +			name =3D "cros-ec-accel";
> +			break;
> +		case MOTIONSENSE_TYPE_BARO:
> +			name =3D "cros-ec-baro";
> +			break;
> +		case MOTIONSENSE_TYPE_GYRO:
> +			name =3D "cros-ec-gyro";
> +			break;
> +		case MOTIONSENSE_TYPE_MAG:
> +			name =3D "cros-ec-mag";
> +			break;
> +		case MOTIONSENSE_TYPE_PROX:
> +			name =3D "cros-ec-prox";
> +			break;
> +		case MOTIONSENSE_TYPE_LIGHT:
> +			name =3D "cros-ec-light";
> +			break;
> +		case MOTIONSENSE_TYPE_ACTIVITY:
> +			name =3D "cros-ec-activity";
> +			break;
> +		default:
> +			dev_warn(dev, "unknown type %d\n", resp->info.type);
> +			continue;
> +		}
> +		pdev =3D cros_ec_sensorhub_allocate_single_sensor(dev, name, i);
> +		if (IS_ERR(pdev)) {
> +			ret =3D IS_ERR(pdev);
> +			goto error;
> +		}
> +		sensorhub->sensor_pdev[id++] =3D pdev;
> +		sensor_type[resp->info.type]++;
> +	}
> +
> +	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >=3D 2)
> +		ec->has_kb_wake_angle =3D true;
> +
> +	if (cros_ec_check_features(ec,
> +				   EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> +		pdev =3D cros_ec_sensorhub_allocate_single_sensor(dev,
> +							"cros-ec-lid-angle", 0);
> +		if (IS_ERR(pdev)) {
> +			ret =3D IS_ERR(pdev);
> +			goto error;
> +		}
> +		sensorhub->sensor_pdev[id++] =3D pdev;
> +	}
> +
> +error:
> +	kfree(msg);
> +	return ret;
> +}
> +
> +static int cros_ec_sensorhub_probe(struct platform_device *sensorhub_pde=
v)
> +{
> +	struct device *dev =3D &sensorhub_pdev->dev;
> +	struct cros_ec_dev *ec =3D dev_get_drvdata(dev->parent);
> +	int ret, i;
> +	struct platform_device *pdev;
> +	struct cros_ec_sensorhub *data =3D
> +		kzalloc(sizeof(struct cros_ec_sensorhub), GFP_KERNEL);

Do we free this anywhere?  Could just use devm_kzalloc to do it
automatically.

> +
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ec =3D ec;
> +	dev_set_drvdata(dev, data);
> +
> +	/* Check whether this EC is a sensor hub. */
> +	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
> +		ret =3D cros_ec_sensorhub_register(dev, data);
> +		if (ret) {
> +			dev_err(dev, "Register failed %d\n", ret);
> +			goto unregister_sensors;

=46rom a code structure point of view, cros_ec_sensorhub_register
should have done any cleanup necessary if it returns an error.  Hence
we should be fine doing a direct return here (other than the memory
not being freed comment above.

This may seem an overly restrictive request, but that sort of rule
makes code a lot easier to review as we don't have to go look
to see where the error handling occurs and check for multiple paths
etc.  Note that if you use managed functions then there is no
cleanup to do anyway ;)

> +		}
> +	} else {
> +		/*
> +		 * If the device has sensors but does not claim to
> +		 * be a sensor hub, we are in legacy mode.
> +		 */
> +		for (i =3D 0; i < 2; i++) {
> +			pdev =3D cros_ec_sensorhub_allocate_single_sensor(dev,
> +						"cros-ec-accel-legacy", i);
> +			if (IS_ERR(pdev)) {
> +				ret =3D IS_ERR(pdev);
> +				dev_err(dev, "Legacy %d failed %d\n", i, ret);
> +				goto unregister_sensors;
> +			} else {
> +				data->sensor_pdev[i] =3D pdev;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +
> +unregister_sensors:
> +	/*
> +	 * Given the probe has failed, we need to unregister all the sensors,
> +	 * not jutst the one that did not work: this device will be
> +	 * de-allocated.
> +	 */
> +	for (i =3D 0; i < CROS_EC_SENSOR_PDEV_MAX; i++) {
> +		pdev =3D data->sensor_pdev[i];
> +		if (pdev)
> +			platform_device_unregister(pdev);
> +	}
> +	return ret;
> +}
> +
> +static int cros_ec_sensorhub_remove(struct platform_device *sensorhub_pd=
ev)
> +{
> +	struct cros_ec_sensorhub *sensorhub =3D
> +		platform_get_drvdata(sensorhub_pdev);
> +	struct platform_device *pdev;
> +	int i;
> +
> +	for (i =3D 0; i < CROS_EC_SENSOR_PDEV_MAX; i++) {
> +		pdev =3D sensorhub->sensor_pdev[i];
> +		if (pdev)
> +			platform_device_unregister(pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_ec_sensorhub_driver =3D {
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +	},
> +	.probe =3D cros_ec_sensorhub_probe,
> +	.remove =3D cros_ec_sensorhub_remove,
> +};
> +
> +module_platform_driver(cros_ec_sensorhub_driver);
> +
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
> +MODULE_DESCRIPTION("ChromeOS EC MEMS Sensor Hub Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/li=
nux/platform_data/cros_ec_sensorhub.h
> new file mode 100644
> index 000000000000..da0ba1d201e4
> --- /dev/null
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * cros_ec_sensorhub- Chrome OS EC MEMS Sensor Hub driver.
> + *
> + * Copyright (C) 2019 Google, Inc
> + */
> +
> +#ifndef __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
> +#define __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
> +
> +#include <linux/platform_data/cros_ec_commands.h>
> +
> +/* Maximal number of sensors supported by the EC. */
> +#define CROS_EC_SENSOR_MAX 16
> +
> +/*
> + * Maximal number of sensors supported by the hub:
> + * We add one for the lid angle inclinometer sensor.
> + */
> +#define CROS_EC_SENSOR_PDEV_MAX (CROS_EC_SENSOR_MAX + 1)
> +
> +/**
> + * struct cros_ec_sensorhub - Sensor Hub device data.
> + *
> + * @ec:           Embedded Controller where the hub is located.
> + * @sensor_pdev:  Array of platform_device, one per sensor.
> + */
> +struct cros_ec_sensorhub {
> +	struct cros_ec_dev *ec;
> +	struct platform_device *sensor_pdev[CROS_EC_SENSOR_PDEV_MAX];
> +};
> +
> +#endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */

