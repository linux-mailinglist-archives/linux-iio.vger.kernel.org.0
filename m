Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D3D3BA9AB
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhGCRKx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 13:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCRKw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 13:10:52 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 966E961930;
        Sat,  3 Jul 2021 17:08:16 +0000 (UTC)
Date:   Sat, 3 Jul 2021 18:10:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jikos@kernel.org
Subject: Re: [PATCH] iio: hid-sensors: bind IIO channels alloc to device
 object
Message-ID: <20210703181039.2e468029@jic23-huawei>
In-Reply-To: <20210630123029.759609-1-aardelean@deviqon.com>
References: <20210630123029.759609-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 15:30:29 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> Some HID drivers use devm_kmemdup() already to clone the template IIO
> channels information and update it.
> However, there are still some drivers that kmemdup() and kfree() the
> channels.
> 
> This change converts them to use devm_kmemdup() and bind the life-time of
> this allocated object to the parent device object (in these drivers).
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

All look good to me, plus it's the same thing already done in hid-sensors-magn-3d
so should be fine :)

Srinivas, if you have time to sanity check that would be great. No huge
rush given we are in the merge window.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c      | 10 ++++------
>  drivers/iio/gyro/hid-sensor-gyro-3d.c        | 11 ++++-------
>  drivers/iio/light/hid-sensor-als.c           | 11 ++++-------
>  drivers/iio/light/hid-sensor-prox.c          | 11 ++++-------
>  drivers/iio/orientation/hid-sensor-incl-3d.c | 11 ++++-------
>  drivers/iio/pressure/hid-sensor-press.c      | 11 ++++-------
>  6 files changed, 24 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 55cdca818b3b..a2def6f9380a 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -367,7 +367,8 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "failed to setup common attributes\n");
>  		return ret;
>  	}
> -	indio_dev->channels = kmemdup(channel_spec, channel_size, GFP_KERNEL);
> +	indio_dev->channels = devm_kmemdup(&pdev->dev, channel_spec,
> +					   channel_size, GFP_KERNEL);
>  
>  	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
> @@ -378,7 +379,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  				hsdev->usage, accel_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	indio_dev->info = &accel_3d_info;
> @@ -391,7 +392,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  					&accel_state->common_attributes);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -416,8 +417,6 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
> -error_free_dev_mem:
> -	kfree(indio_dev->channels);
>  	return ret;
>  }
>  
> @@ -431,7 +430,6 @@ static int hid_accel_3d_remove(struct platform_device *pdev)
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
> -	kfree(indio_dev->channels);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index bc63c2a34c5e..8f0ad022c7f1 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -303,8 +303,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->channels = kmemdup(gyro_3d_channels,
> -				      sizeof(gyro_3d_channels), GFP_KERNEL);
> +	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
> +					   sizeof(gyro_3d_channels), GFP_KERNEL);
>  	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>  		return -ENOMEM;
> @@ -315,7 +315,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	indio_dev->num_channels = ARRAY_SIZE(gyro_3d_channels);
> @@ -329,7 +329,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  					&gyro_state->common_attributes);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -354,8 +354,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
> -error_free_dev_mem:
> -	kfree(indio_dev->channels);
>  	return ret;
>  }
>  
> @@ -369,7 +367,6 @@ static int hid_gyro_3d_remove(struct platform_device *pdev)
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
> -	kfree(indio_dev->channels);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 2ff252c75c03..5a1a625d8d16 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -294,8 +294,8 @@ static int hid_als_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->channels = kmemdup(als_channels,
> -				      sizeof(als_channels), GFP_KERNEL);
> +	indio_dev->channels = devm_kmemdup(&pdev->dev, als_channels,
> +					   sizeof(als_channels), GFP_KERNEL);
>  	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>  		return -ENOMEM;
> @@ -306,7 +306,7 @@ static int hid_als_probe(struct platform_device *pdev)
>  			       HID_USAGE_SENSOR_ALS, als_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	indio_dev->num_channels =
> @@ -321,7 +321,7 @@ static int hid_als_probe(struct platform_device *pdev)
>  				&als_state->common_attributes);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -346,8 +346,6 @@ static int hid_als_probe(struct platform_device *pdev)
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
> -error_free_dev_mem:
> -	kfree(indio_dev->channels);
>  	return ret;
>  }
>  
> @@ -361,7 +359,6 @@ static int hid_als_remove(struct platform_device *pdev)
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
> -	kfree(indio_dev->channels);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 1621530f5f61..f10fa2abfe72 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -253,8 +253,8 @@ static int hid_prox_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->channels = kmemdup(prox_channels, sizeof(prox_channels),
> -				      GFP_KERNEL);
> +	indio_dev->channels = devm_kmemdup(&pdev->dev, prox_channels,
> +					   sizeof(prox_channels), GFP_KERNEL);
>  	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>  		return -ENOMEM;
> @@ -265,7 +265,7 @@ static int hid_prox_probe(struct platform_device *pdev)
>  				HID_USAGE_SENSOR_PROX, prox_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	indio_dev->num_channels = ARRAY_SIZE(prox_channels);
> @@ -279,7 +279,7 @@ static int hid_prox_probe(struct platform_device *pdev)
>  				&prox_state->common_attributes);
>  	if (ret) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -304,8 +304,6 @@ static int hid_prox_probe(struct platform_device *pdev)
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
> -error_free_dev_mem:
> -	kfree(indio_dev->channels);
>  	return ret;
>  }
>  
> @@ -319,7 +317,6 @@ static int hid_prox_remove(struct platform_device *pdev)
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
> -	kfree(indio_dev->channels);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index c0079e2c8807..ba5b581d5b25 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -326,8 +326,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->channels = kmemdup(incl_3d_channels,
> -				      sizeof(incl_3d_channels), GFP_KERNEL);
> +	indio_dev->channels = devm_kmemdup(&pdev->dev, incl_3d_channels,
> +					   sizeof(incl_3d_channels), GFP_KERNEL);
>  	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>  		return -ENOMEM;
> @@ -339,7 +339,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
>  				   incl_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	indio_dev->num_channels = ARRAY_SIZE(incl_3d_channels);
> @@ -353,7 +353,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
>  					&incl_state->common_attributes);
>  	if (ret) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -379,8 +379,6 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
> -error_free_dev_mem:
> -	kfree(indio_dev->channels);
>  	return ret;
>  }
>  
> @@ -394,7 +392,6 @@ static int hid_incl_3d_remove(struct platform_device *pdev)
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
> -	kfree(indio_dev->channels);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index 10c52b8df2ba..dcd593c426b4 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -259,8 +259,8 @@ static int hid_press_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->channels = kmemdup(press_channels, sizeof(press_channels),
> -				      GFP_KERNEL);
> +	indio_dev->channels = devm_kmemdup(&pdev->dev, press_channels,
> +					   sizeof(press_channels), GFP_KERNEL);
>  	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>  		return -ENOMEM;
> @@ -271,7 +271,7 @@ static int hid_press_probe(struct platform_device *pdev)
>  				 HID_USAGE_SENSOR_PRESSURE, press_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	indio_dev->num_channels =
> @@ -286,7 +286,7 @@ static int hid_press_probe(struct platform_device *pdev)
>  				&press_state->common_attributes);
>  	if (ret) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_free_dev_mem;
> +		return ret;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -311,8 +311,6 @@ static int hid_press_probe(struct platform_device *pdev)
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
> -error_free_dev_mem:
> -	kfree(indio_dev->channels);
>  	return ret;
>  }
>  
> @@ -326,7 +324,6 @@ static int hid_press_remove(struct platform_device *pdev)
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
> -	kfree(indio_dev->channels);
>  
>  	return 0;
>  }

