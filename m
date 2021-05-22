Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED638D6B9
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 19:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhEVRxh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 22 May 2021 13:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhEVRxh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 13:53:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17B761002;
        Sat, 22 May 2021 17:52:09 +0000 (UTC)
Date:   Sat, 22 May 2021 18:53:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH 7/8] iio: accel: bmc150: Add support for DUAL250E ACPI
 DSM for setting the hinge angle
Message-ID: <20210522185332.735d605d@jic23-huawei>
In-Reply-To: <20210521171418.393871-8-hdegoede@redhat.com>
References: <20210521171418.393871-1-hdegoede@redhat.com>
        <20210521171418.393871-8-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 May 2021 19:14:17 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
> to allow the OS to determine the angle between the display and the base
> of the device, so that the OS can determine if the 2-in-1 is in laptop
> or in tablet-mode.
> 
> On Windows both accelerometers are read (polled) by a special service
> and this service calls the DSM (Device Specific Method), which in turn
> translates the angles to one of laptop/tablet/tent/stand mode and then
> notifies the EC about the new mode and the EC then enables or disables
> the builtin keyboard and touchpad based in the mode.
> 
> When the 2-in-1 is powered-on or resumed folded in tablet mode the
> EC senses this independent of the DSM by using a HALL effect sensor
> which senses that the keyboard has been folded away behind the display.
> 
> At power-on or resume the EC disables the keyboard based on this and
> the only way to get the keyboard to work after this is to call the
> DSM to re-enable it.
> 
> Call the DSM on probe() and resume() to fix the keyboard not working
> when powered-on / resumed in tablet-mode.
> 
> This patch was developed and tested on a Lenovo Yoga 300-IBR.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Putting aside my general grumpiness at this stuff having to pollute
accelerometer drivers (and the broken DSM implementation on the hardware!)
this is a fairly clean implementation so I guess we can survive it.

Jonathan

> ---
>  drivers/iio/accel/bmc150-accel-core.c |   3 +
>  drivers/iio/accel/bmc150-accel-i2c.c  | 109 ++++++++++++++++++++++++++
>  drivers/iio/accel/bmc150-accel.h      |   3 +
>  3 files changed, 115 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 0291512648b2..932007895f18 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1803,6 +1803,9 @@ static int bmc150_accel_resume(struct device *dev)
>  	bmc150_accel_fifo_set_mode(data);
>  	mutex_unlock(&data->mutex);
>  
> +	if (data->resume_callback)
> +		data->resume_callback(dev);
> +
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index 1dd7b8a9a382..31256c32a33c 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -28,6 +28,107 @@ static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
>  	{ },
>  };
>  
> +/*
> + * The DUAL250E ACPI device for 360° hinges type 2-in-1s with 1 accelerometer
> + * in the display and 1 in the hinge has an ACPI-method (DSM) to tell the
> + * ACPI code about the angle between the 2 halves. This will make the ACPI
> + * code enable/disable the keyboard and touchpad. We need to call this to avoid
> + * the keyboard being disabled when the 2-in-1 is turned-on or resumed while
> + * fully folded into tablet mode (which gets detected with a HALL-sensor).
> + * If we don't call this then the keyboard won't work even when the 2-in-1 is
> + * changed to be used in laptop mode after the power-on / resume.
> + *
> + * This DSM takes 2 angles, selected by setting aux0 to 0 or 1, these presumably
> + * define the angle between the gravity vector measured by the accelerometer in
> + * the display (aux0=0) resp. the base (aux0=1) and some reference vector.
> + * The 2 angles get subtracted from each other so the reference vector does
> + * not matter and we can simply leave the second angle at 0.
> + */
> +
> +#define BMC150_DSM_GUID				"7681541e-8827-4239-8d9d-36be7fe12542"
> +#define DUAL250E_SET_ANGLE_FN_INDEX		3
> +
> +struct dual250e_set_angle_args {
> +	u32 aux0;
> +	u32 ang0;
> +	u32 rawx;
> +	u32 rawy;
> +	u32 rawz;
> +} __packed;
> +
> +static bool bmc150_acpi_set_angle_dsm(struct i2c_client *client, u32 aux0, u32 ang0)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
> +	struct dual250e_set_angle_args args = {
> +		.aux0 = aux0,
> +		.ang0 = ang0,
> +	};
> +	union acpi_object args_obj, *obj;
> +	guid_t guid;
> +
> +	if (strcmp(acpi_device_hid(adev), "DUAL250E"))
> +		return false;
> +
> +	guid_parse(BMC150_DSM_GUID, &guid);
> +
> +	if (!acpi_check_dsm(adev->handle, &guid, 0, BIT(DUAL250E_SET_ANGLE_FN_INDEX)))
> +		return false;
> +
> +	/*
> +	 * Note this triggers the following warning:
> +	 * "ACPI Warning: \_SB.PCI0.I2C2.ACC1._DSM: Argument #4 type mismatch -
> +	 *                Found [Buffer], ACPI requires [Package]"
> +	 * This is unavoidable since the _DSM implementation expects a "naked"
> +	 * buffer, so wrapping it in a package will _not_ work.

ouch.

> +	 */
> +	args_obj.type = ACPI_TYPE_BUFFER;
> +	args_obj.buffer.length = sizeof(args);
> +	args_obj.buffer.pointer = (u8 *)&args;
> +
> +	obj = acpi_evaluate_dsm(adev->handle, &guid, 0, DUAL250E_SET_ANGLE_FN_INDEX, &args_obj);
> +	if (!obj) {
> +		dev_err(&client->dev, "Failed to call DSM to enable keyboard and touchpad\n");
> +		return false;
> +	}
> +
> +	ACPI_FREE(obj);
> +	return true;
> +}
> +
> +static bool bmc150_acpi_enable_keyboard(struct i2c_client *client)
> +{
> +	/*
> +	 * The EC must see a change for it to re-enable the kbd, so first set the
> +	 * angle to 270° (tent/stand mode) and then change it to 90° (laptop mode).
> +	 */
> +	if (!bmc150_acpi_set_angle_dsm(client, 0, 270))
> +		return false;
> +
> +	/* The EC needs some time to notice the angle being changed */
> +	msleep(100);
> +
> +	return bmc150_acpi_set_angle_dsm(client, 0, 90);
> +}
> +
> +static void bmc150_acpi_resume_work(struct work_struct *work)
> +{
> +	struct bmc150_accel_data *data =
> +		container_of(work, struct bmc150_accel_data, resume_work.work);
> +
> +	bmc150_acpi_enable_keyboard(data->second_device);
> +}
> +
> +static void bmc150_acpi_resume_handler(struct device *dev)
> +{
> +	struct bmc150_accel_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	/*
> +	 * Delay the bmc150_acpi_enable_keyboard() call till after the system
> +	 * resume has completed, otherwise it will not work.
> +	 */
> +	schedule_delayed_work(&data->resume_work, msecs_to_jiffies(1000));
> +}
> +
>  /*
>   * Some acpi_devices describe 2 accelerometers in a single ACPI device, try instantiating
>   * a second i2c_client for an I2cSerialBusV2 ACPI resource with index 1.
> @@ -55,12 +156,20 @@ static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
>  	board_info.irq = acpi_dev_gpio_irq_get_by(adev, NULL, 1);
>  
>  	data->second_device = i2c_acpi_new_device(&client->dev, 1, &board_info);
> +
> +	if (!IS_ERR(data->second_device) && bmc150_acpi_enable_keyboard(data->second_device)) {
> +		INIT_DELAYED_WORK(&data->resume_work, bmc150_acpi_resume_work);
> +		data->resume_callback = bmc150_acpi_resume_handler;
> +	}
>  }
>  
>  static void bmc150_acpi_dual_accel_remove(struct i2c_client *client)
>  {
>  	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
>  
> +	if (data->resume_callback)
> +		cancel_delayed_work_sync(&data->resume_work);
> +
>  	i2c_unregister_device(data->second_device);
>  }
>  #else
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> index 5da6fd32bac5..d67d6ed6ae77 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -6,6 +6,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
>  
>  struct regmap;
>  struct i2c_client;
> @@ -62,6 +63,8 @@ struct bmc150_accel_data {
>  	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
>  	const struct bmc150_accel_chip_info *chip_info;
>  	struct i2c_client *second_device;
> +	void (*resume_callback)(struct device *dev);
> +	struct delayed_work resume_work;
>  	struct iio_mount_matrix orientation;
>  };
>  

