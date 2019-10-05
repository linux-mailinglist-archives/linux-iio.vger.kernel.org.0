Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42671CCADE
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfJEPlg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 11:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEPlg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 11:41:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FA520862;
        Sat,  5 Oct 2019 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570290094;
        bh=SjLjkhpvER2N5sBbiYQ/aqSoOGEvtzUJAHrOD6A6ajQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0+maFZMN4T1gaJnXpWInRMSHpnesZaaH6RK+wXSSTkamNUvvpkWvjHE81cxj5drRM
         tonvqbxAcpNQyL5Ve1yQ3/BwxqhY8wX5YDaxpVebdRHNTOS7YJj/y1ssFUMwYOZBpd
         vdB0NC4caavorQn6eH8kYVESDLDwz3KN4DPhbRI8=
Date:   Sat, 5 Oct 2019 16:41:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/13] platform/mfd:iio: cros_ec: Register sensor
 through sensorhub
Message-ID: <20191005164128.6e8ae456@archlinux>
In-Reply-To: <20190922175021.53449-4-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-4-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:11 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> - Add sensorhub include file
> - Remove duplicate code in mfd, since mfd just register
>   cros_ec_sensorhub if at least one sensor is present
> - Change iio cros_ec driver to get the pointer to the cros_ec_dev
>   through cros_ec_sensorhub.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Trivial comment inline.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c      |   4 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   4 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +-
>  drivers/iio/light/cros_ec_light_prox.c        |   6 +-
>  drivers/mfd/cros_ec_dev.c                     | 203 ++----------------
>  drivers/platform/chrome/cros_ec_sensorhub.c   |   2 +-
>  include/linux/platform_data/cros_ec_proto.h   |   8 -
>  .../linux/platform_data/cros_ec_sensorhub.h   |   8 +
>  8 files changed, 34 insertions(+), 205 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index fcc3f999e482..c9af6fa0670d 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -23,6 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_ec_sensorhub.h>
>  #include <linux/platform_device.h>
>  
>  #define DRV_NAME	"cros-ec-accel-legacy"
> @@ -163,7 +164,8 @@ static const struct iio_chan_spec cros_ec_accel_legacy_channels[] = {
>  static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
> +	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
> +	struct cros_ec_dev *ec = sensor_hub->ec;
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_sensors_core_state *state;
>  	int ret;
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index a6987726eeb8..5bd6f54afc42 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_ec_sensorhub.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> @@ -222,7 +223,8 @@ static const struct iio_info ec_sensors_info = {
>  static int cros_ec_sensors_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
> +	struct cros_ec_dev *ec_dev = sensor_hub->ec;
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_sensors_state *state;
>  	struct iio_chan_spec *channel;
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
> index c5263b563fc1..205effc1f404 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_data/cros_ec_sensorhub.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> @@ -169,13 +170,14 @@ static const struct iio_info cros_ec_light_prox_info = {
>  static int cros_ec_light_prox_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
> +	struct cros_ec_dev *ec = sensor_hub->ec;
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_light_prox_state *state;
>  	struct iio_chan_spec *channel;
>  	int ret;
>  
> -	if (!ec_dev || !ec_dev->ec_dev) {
> +	if (!ec || !ec->ec_dev) {
>  		dev_warn(dev, "No CROS EC device found.\n");
>  		return -EINVAL;
>  	}
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 3be80183ccaa..3a583d3503ca 100644
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
> @@ -208,192 +212,6 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
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
> @@ -449,11 +267,14 @@ static int ec_device_probe(struct platform_device *pdev)
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
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
> index 80688018ef66..01f11ed611fb 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -181,7 +181,7 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
>  	data->ec = ec;
>  	dev_set_drvdata(dev, data);
>  
> -	/* check whether this EC is a sensor hub. */
> +	/* Check whether this EC is a sensor hub. */

Change not related to this patches main purpose... 

>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
>  		ret = cros_ec_sensors_register(dev, ec);
>  	} else {
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index eab7036cda09..e91e3fcb0348 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -167,14 +167,6 @@ struct cros_ec_device {
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
> index a8b64ecf5b9b..9295eabb16f6 100644
> --- a/include/linux/platform_data/cros_ec_sensorhub.h
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -11,6 +11,14 @@
>  
>  #include <linux/platform_data/cros_ec_commands.h>
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
>   */

