Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3741F68DF
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 13:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKJMNd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 07:13:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfKJMNc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 07:13:32 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D9E20818;
        Sun, 10 Nov 2019 12:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573388011;
        bh=utZb4/Sy6YLPj95tMNVGwsfz/eCXo8DnOdwgz8smqMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ugFK5MB1fgxVGA3bXSuLsCLye2peWyfueN/F9IUmsJa5QcXuhrYF0qlHrffKJ2P03
         jRjdcyJt3ipK0+g9PoVdtbVAEIHf7tm3ynVphLoAHVlX6jWgxtdACzTqez4snPfXEq
         4m8kMp13fGTuTuYJRBWndyP7onvQsA9c7YiCD+lA=
Date:   Sun, 10 Nov 2019 12:13:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 03/17] platform/mfd:iio: cros_ec: Register sensor
 through sensorhub
Message-ID: <20191110121323.730d10a7@archlinux>
In-Reply-To: <20191105222652.70226-4-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
        <20191105222652.70226-4-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Nov 2019 14:26:38 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> - Remove duplicate code in mfd, since mfd just register
>   cros_ec_sensorhub if at least one sensor is present
> - Change iio cros_ec driver to get the pointer to the cros_ec_dev
>   through cros_ec_sensorhub.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Looks good to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> No changes in v4, v3.
> Changes in v2:
> - Remove unerelated changes.
> - Remove ec presence test in iio driver, done in cros_ec_sensorhub.
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      |   6 -
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   6 -
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +-
>  drivers/iio/light/cros_ec_light_prox.c        |   6 -
>  drivers/mfd/cros_ec_dev.c                     | 203 ++----------------
>  include/linux/platform_data/cros_ec_proto.h   |   8 -
>  .../linux/platform_data/cros_ec_sensorhub.h   |   8 +
>  7 files changed, 23 insertions(+), 218 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index fcc3f999e482..65f85faf6f31 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -163,16 +163,10 @@ static const struct iio_chan_spec cros_ec_accel_legacy_channels[] = {
>  static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_sensors_core_state *state;
>  	int ret;
>  
> -	if (!ec || !ec->ec_dev) {
> -		dev_warn(&pdev->dev, "No EC device found.\n");
> -		return -EINVAL;
> -	}
> -
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*state));
>  	if (!indio_dev)
>  		return -ENOMEM;
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index a6987726eeb8..7dce04473467 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -222,17 +222,11 @@ static const struct iio_info ec_sensors_info = {
>  static int cros_ec_sensors_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_sensors_state *state;
>  	struct iio_chan_spec *channel;
>  	int ret, i;
>  
> -	if (!ec_dev || !ec_dev->ec_dev) {
> -		dev_warn(&pdev->dev, "No CROS EC device found.\n");
> -		return -EINVAL;
> -	}
> -
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*state));
>  	if (!indio_dev)
>  		return -ENOMEM;
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index d2609e6feda4..81a7f692de2f 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_ec_sensorhub.h>
>  #include <linux/platform_device.h>
>  
>  static char *cros_ec_loc[] = {
> @@ -88,7 +89,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> -	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
> +	struct cros_ec_dev *ec = sensor_hub->ec;
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>  	u32 ver_mask;
>  	int ret, i;
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index c5263b563fc1..d85a391e50c5 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -169,17 +169,11 @@ static const struct iio_info cros_ec_light_prox_info = {
>  static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_light_prox_state *state;
>  	struct iio_chan_spec *channel;
>  	int ret;
>  
> -	if (!ec_dev || !ec_dev->ec_dev) {
> -		dev_warn(dev, "No CROS EC device found.\n");
> -		return -EINVAL;
> -	}
> -
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>  	if (!indio_dev)
>  		return -ENOMEM;
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index a35104e35cb4..c4b977a5dd96 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -78,6 +78,10 @@ static const struct mfd_cell cros_ec_rtc_cells[] = {
>  	{ .name = "cros-ec-rtc", },
>  };
>  
> +static const struct mfd_cell cros_ec_sensorhub_cells[] = {
> +	{ .name = "cros-ec-sensorhub", },
> +};
> +
>  static const struct mfd_cell cros_usbpd_charger_cells[] = {
>  	{ .name = "cros-usbpd-charger", },
>  	{ .name = "cros-usbpd-logger", },
> @@ -117,192 +121,6 @@ static void cros_ec_class_release(struct device *dev)
>  	kfree(to_cros_ec_dev(dev));
>  }
>  
> -static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> -{
> -	/*
> -	 * Issue a command to get the number of sensor reported.
> -	 * Build an array of sensors driver and register them all.
> -	 */
> -	int ret, i, id, sensor_num;
> -	struct mfd_cell *sensor_cells;
> -	struct cros_ec_sensor_platform *sensor_platforms;
> -	int sensor_type[MOTIONSENSE_TYPE_MAX];
> -	struct ec_params_motion_sense *params;
> -	struct ec_response_motion_sense *resp;
> -	struct cros_ec_command *msg;
> -
> -	msg = kzalloc(sizeof(struct cros_ec_command) +
> -		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
> -	if (msg == NULL)
> -		return;
> -
> -	msg->version = 2;
> -	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> -	msg->outsize = sizeof(*params);
> -	msg->insize = sizeof(*resp);
> -
> -	params = (struct ec_params_motion_sense *)msg->data;
> -	params->cmd = MOTIONSENSE_CMD_DUMP;
> -
> -	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> -	if (ret < 0) {
> -		dev_warn(ec->dev, "cannot get EC sensor information: %d/%d\n",
> -			 ret, msg->result);
> -		goto error;
> -	}
> -
> -	resp = (struct ec_response_motion_sense *)msg->data;
> -	sensor_num = resp->dump.sensor_count;
> -	/*
> -	 * Allocate 2 extra sensors if lid angle sensor and/or FIFO are needed.
> -	 */
> -	sensor_cells = kcalloc(sensor_num + 2, sizeof(struct mfd_cell),
> -			       GFP_KERNEL);
> -	if (sensor_cells == NULL)
> -		goto error;
> -
> -	sensor_platforms = kcalloc(sensor_num,
> -				   sizeof(struct cros_ec_sensor_platform),
> -				   GFP_KERNEL);
> -	if (sensor_platforms == NULL)
> -		goto error_platforms;
> -
> -	memset(sensor_type, 0, sizeof(sensor_type));
> -	id = 0;
> -	for (i = 0; i < sensor_num; i++) {
> -		params->cmd = MOTIONSENSE_CMD_INFO;
> -		params->info.sensor_num = i;
> -		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> -		if (ret < 0) {
> -			dev_warn(ec->dev, "no info for EC sensor %d : %d/%d\n",
> -				 i, ret, msg->result);
> -			continue;
> -		}
> -		switch (resp->info.type) {
> -		case MOTIONSENSE_TYPE_ACCEL:
> -			sensor_cells[id].name = "cros-ec-accel";
> -			break;
> -		case MOTIONSENSE_TYPE_BARO:
> -			sensor_cells[id].name = "cros-ec-baro";
> -			break;
> -		case MOTIONSENSE_TYPE_GYRO:
> -			sensor_cells[id].name = "cros-ec-gyro";
> -			break;
> -		case MOTIONSENSE_TYPE_MAG:
> -			sensor_cells[id].name = "cros-ec-mag";
> -			break;
> -		case MOTIONSENSE_TYPE_PROX:
> -			sensor_cells[id].name = "cros-ec-prox";
> -			break;
> -		case MOTIONSENSE_TYPE_LIGHT:
> -			sensor_cells[id].name = "cros-ec-light";
> -			break;
> -		case MOTIONSENSE_TYPE_ACTIVITY:
> -			sensor_cells[id].name = "cros-ec-activity";
> -			break;
> -		default:
> -			dev_warn(ec->dev, "unknown type %d\n", resp->info.type);
> -			continue;
> -		}
> -		sensor_platforms[id].sensor_num = i;
> -		sensor_cells[id].id = sensor_type[resp->info.type];
> -		sensor_cells[id].platform_data = &sensor_platforms[id];
> -		sensor_cells[id].pdata_size =
> -			sizeof(struct cros_ec_sensor_platform);
> -
> -		sensor_type[resp->info.type]++;
> -		id++;
> -	}
> -
> -	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
> -		ec->has_kb_wake_angle = true;
> -
> -	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> -		sensor_cells[id].name = "cros-ec-ring";
> -		id++;
> -	}
> -	if (cros_ec_check_features(ec,
> -				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> -		sensor_cells[id].name = "cros-ec-lid-angle";
> -		id++;
> -	}
> -
> -	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
> -			      NULL, 0, NULL);
> -	if (ret)
> -		dev_err(ec->dev, "failed to add EC sensors\n");
> -
> -	kfree(sensor_platforms);
> -error_platforms:
> -	kfree(sensor_cells);
> -error:
> -	kfree(msg);
> -}
> -
> -static struct cros_ec_sensor_platform sensor_platforms[] = {
> -	{ .sensor_num = 0 },
> -	{ .sensor_num = 1 }
> -};
> -
> -static const struct mfd_cell cros_ec_accel_legacy_cells[] = {
> -	{
> -		.name = "cros-ec-accel-legacy",
> -		.platform_data = &sensor_platforms[0],
> -		.pdata_size = sizeof(struct cros_ec_sensor_platform),
> -	},
> -	{
> -		.name = "cros-ec-accel-legacy",
> -		.platform_data = &sensor_platforms[1],
> -		.pdata_size = sizeof(struct cros_ec_sensor_platform),
> -	}
> -};
> -
> -static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
> -{
> -	struct cros_ec_device *ec_dev = ec->ec_dev;
> -	u8 status;
> -	int ret;
> -
> -	/*
> -	 * ECs that need legacy support are the main EC, directly connected to
> -	 * the AP.
> -	 */
> -	if (ec->cmd_offset != 0)
> -		return;
> -
> -	/*
> -	 * Check if EC supports direct memory reads and if EC has
> -	 * accelerometers.
> -	 */
> -	if (ec_dev->cmd_readmem) {
> -		ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS, 1,
> -					  &status);
> -		if (ret < 0) {
> -			dev_warn(ec->dev, "EC direct read error.\n");
> -			return;
> -		}
> -
> -		/* Check if EC has accelerometers. */
> -		if (!(status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
> -			dev_info(ec->dev, "EC does not have accelerometers.\n");
> -			return;
> -		}
> -	}
> -
> -	/*
> -	 * The device may still support accelerometers:
> -	 * it would be an older ARM based device that do not suppor the
> -	 * EC_CMD_GET_FEATURES command.
> -	 *
> -	 * Register 2 accelerometers, we will fail in the IIO driver if there
> -	 * are no sensors.
> -	 */
> -	ret = mfd_add_hotplug_devices(ec->dev, cros_ec_accel_legacy_cells,
> -				      ARRAY_SIZE(cros_ec_accel_legacy_cells));
> -	if (ret)
> -		dev_err(ec_dev->dev, "failed to add EC sensors\n");
> -}
> -
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>  	int retval = -ENOMEM;
> @@ -358,11 +176,14 @@ static int ec_device_probe(struct platform_device *pdev)
>  		goto failed;
>  
>  	/* check whether this EC is a sensor hub. */
> -	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
> -		cros_ec_sensors_register(ec);
> -	else
> -		/* Workaroud for older EC firmware */
> -		cros_ec_accel_legacy_register(ec);
> +	if (cros_ec_get_sensor_count(ec) > 0) {
> +		retval = mfd_add_hotplug_devices(ec->dev,
> +				cros_ec_sensorhub_cells,
> +				ARRAY_SIZE(cros_ec_sensorhub_cells));
> +		if (retval)
> +			dev_err(ec->dev, "failed to add %s subdevice: %d\n",
> +				cros_ec_sensorhub_cells->name, retval);
> +	}
>  
>  	/*
>  	 * The following subdevices can be detected by sending the
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index f3de0662135d..691f9e953a96 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -168,14 +168,6 @@ struct cros_ec_device {
>  	struct platform_device *pd;
>  };
>  
> -/**
> - * struct cros_ec_sensor_platform - ChromeOS EC sensor platform information.
> - * @sensor_num: Id of the sensor, as reported by the EC.
> - */
> -struct cros_ec_sensor_platform {
> -	u8 sensor_num;
> -};
> -
>  /**
>   * struct cros_ec_platform - ChromeOS EC platform information.
>   * @ec_name: Name of EC device (e.g. 'cros-ec', 'cros-pd', ...)
> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
> index da0ba1d201e4..2b5a4d81f65f 100644
> --- a/include/linux/platform_data/cros_ec_sensorhub.h
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -19,6 +19,14 @@
>   */
>  #define CROS_EC_SENSOR_PDEV_MAX (CROS_EC_SENSOR_MAX + 1)
>  
> +/**
> + * struct cros_ec_sensor_platform - ChromeOS EC sensor platform information.
> + * @sensor_num: Id of the sensor, as reported by the EC.
> + */
> +struct cros_ec_sensor_platform {
> +	u8 sensor_num;
> +};
> +
>  /**
>   * struct cros_ec_sensorhub - Sensor Hub device data.
>   *

