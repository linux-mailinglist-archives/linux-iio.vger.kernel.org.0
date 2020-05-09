Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1551CC087
	for <lists+linux-iio@lfdr.de>; Sat,  9 May 2020 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgEIKte (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 May 2020 06:49:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:15822 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgEIKtd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 May 2020 06:49:33 -0400
IronPort-SDR: a38nMIxnJt6sz2tqqEpfg0PAhwY9grNGJZmZK2EU8F2suTx7/cDbETic93XmHhivzXKR7QvrFY
 XRoKOgK1iNVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2020 03:49:32 -0700
IronPort-SDR: rNLq0wHXl+tkXjXFZZsC8ZRPGt/+QjMqNPxo3DIZ06pq7eIyVKwSRdkO4pbBP4hcvSyUHGgh0t
 6kb9/PJSbFLg==
X-IronPort-AV: E=Sophos;i="5.73,371,1583222400"; 
   d="scan'208";a="285742016"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.77.143])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2020 03:49:32 -0700
Message-ID: <e29261c645c1f0d30bda74033bece7b50645fe60.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensors: move triggered buffer setup into
 hid_sensor_setup_trigger
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
Date:   Sat, 09 May 2020 03:49:31 -0700
In-Reply-To: <20200424043418.3579-1-alexandru.ardelean@analog.com>
References: <20200424043418.3579-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2020-04-24 at 07:34 +0300, Alexandru Ardelean wrote:
> The main intent here is to get rid of the iio_buffer_set_attrs()
> helper, or
> at least rework it's usage a bit.
> The problem with that helper is that it needs a pointer to the
> buffer,
> which makes supporting multiple buffers per IIO device a bit more
> cumbersome.
> 
> The hid_sensor_setup_trigger() is pretty much used in the same way:
> - iio_triggered_buffer_setup() gets called before
> - then hid_sensor_setup_trigger() and hid_sensor_setup_batch_mode()
> gets
>   called which may attach some fifo attributes
> 
> This change merges the 2 together under the
> hid_sensor_setup_trigger()
> function. Only the &iio_pollfunc_store_time is passed to all devices,
> so
> it's not even required to pass it explicitly outside of the common
> hid_sensor_setup_trigger() function.
> 
> Moving the devm_iio_triggered_buffer_setup/cleanup() calls into the
> common
> place code can help the rework of the buffer code, since it is in one
> place.
> 
> One detail of the change is that there are 2 drivers that use
> devm_iio_triggered_buffer_setup(). That function gets implicitly
> replaced with iio_triggered_buffer_setup()/cleanup(), but since all
> drivers
> call both hid_sensor_setup_trigger9) & hid_sensor_remove_trigger()
> trigger,
> the iio_triggered_buffer_cleanup() piggy backs on the
> hid_sensor_remove_trigger() call, which should cover the cleanup.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c        | 18 ++++----------
> ----
>  .../common/hid-sensors/hid-sensor-trigger.c    | 18 +++++++++++++++-
> --
>  .../common/hid-sensors/hid-sensor-trigger.h    |  3 ++-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c          | 18 ++++----------
> ----
>  drivers/iio/humidity/hid-sensor-humidity.c     | 12 +++---------
>  drivers/iio/light/hid-sensor-als.c             | 18 ++++----------
> ----
>  drivers/iio/light/hid-sensor-prox.c            | 18 ++++----------
> ----
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c  | 18 ++++----------
> ----
>  drivers/iio/orientation/hid-sensor-incl-3d.c   | 18 ++++----------
> ----
>  drivers/iio/orientation/hid-sensor-rotation.c  | 18 ++++----------
> ----
>  drivers/iio/pressure/hid-sensor-press.c        | 18 ++++----------
> ----
>  .../iio/temperature/hid-sensor-temperature.c   | 12 +++---------
>  12 files changed, 55 insertions(+), 134 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c
> b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 0d9e2def2b25..0ec0533448bc 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -14,8 +14,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
>  enum accel_3d_channel {
> @@ -391,18 +389,13 @@ static int hid_accel_3d_probe(struct
> platform_device *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> -		NULL, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to initialize trigger
> buffer\n");
> -		goto error_free_dev_mem;
> -	}
>  	atomic_set(&accel_state->common_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  					&accel_state-
> >common_attributes);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_unreg_buffer_funcs;
> +		goto error_free_dev_mem;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -426,9 +419,7 @@ static int hid_accel_3d_probe(struct
> platform_device *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&accel_state->common_attributes);
> -error_unreg_buffer_funcs:
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &accel_state-
> >common_attributes);
>  error_free_dev_mem:
>  	kfree(indio_dev->channels);
>  	return ret;
> @@ -443,8 +434,7 @@ static int hid_accel_3d_remove(struct
> platform_device *pdev)
>  
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(&accel_state->common_attributes);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &accel_state-
> >common_attributes);
>  	kfree(indio_dev->channels);
>  
>  	return 0;
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 906d87780419..ff375790b7e8 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -13,6 +13,8 @@
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
>  #include "hid-sensor-trigger.h"
> @@ -222,7 +224,8 @@ static int
> hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	return hid_sensor_power_state(iio_trigger_get_drvdata(trig),
> state);
>  }
>  
> -void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
> +void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> +			       struct hid_sensor_common *attrb)
>  {
>  	if (atomic_read(&attrb->runtime_pm_enable))
>  		pm_runtime_disable(&attrb->pdev->dev);
> @@ -233,6 +236,7 @@ void hid_sensor_remove_trigger(struct
> hid_sensor_common *attrb)
>  	cancel_work_sync(&attrb->work);
>  	iio_trigger_unregister(attrb->trigger);
>  	iio_trigger_free(attrb->trigger);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  }
>  EXPORT_SYMBOL(hid_sensor_remove_trigger);
>  
> @@ -246,11 +250,18 @@ int hid_sensor_setup_trigger(struct iio_dev
> *indio_dev, const char *name,
>  	int ret;
>  	struct iio_trigger *trig;
>  
> +	ret = iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> +					 NULL, NULL);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Triggered Buffer Setup
> Failed\n");
> +		return ret;
> +	}
> +
>  	trig = iio_trigger_alloc("%s-dev%d", name, indio_dev->id);
>  	if (trig == NULL) {
>  		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
>  		ret = -ENOMEM;
> -		goto error_ret;
> +		goto error_triggered_buffer_cleanup;
>  	}
>  
>  	trig->dev.parent = indio_dev->dev.parent;
> @@ -284,7 +295,8 @@ int hid_sensor_setup_trigger(struct iio_dev
> *indio_dev, const char *name,
>  	iio_trigger_unregister(trig);
>  error_free_trig:
>  	iio_trigger_free(trig);
> -error_ret:
> +error_triggered_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	return ret;
>  }
>  EXPORT_SYMBOL(hid_sensor_setup_trigger);
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> index f47b940ff170..bb45cc89e551 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> @@ -13,7 +13,8 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
>  
>  int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char
> *name,
>  				struct hid_sensor_common *attrb);
> -void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
> +void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> +			       struct hid_sensor_common *attrb);
>  int hid_sensor_power_state(struct hid_sensor_common *st, bool
> state);
>  
>  #endif
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 08cacbbf31e6..7f382aae1dfd 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -14,8 +14,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
>  enum gyro_3d_channel {
> @@ -326,18 +324,13 @@ static int hid_gyro_3d_probe(struct
> platform_device *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> -		NULL, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to initialize trigger
> buffer\n");
> -		goto error_free_dev_mem;
> -	}
>  	atomic_set(&gyro_state->common_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  					&gyro_state-
> >common_attributes);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_unreg_buffer_funcs;
> +		goto error_free_dev_mem;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -361,9 +354,7 @@ static int hid_gyro_3d_probe(struct
> platform_device *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&gyro_state->common_attributes);
> -error_unreg_buffer_funcs:
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &gyro_state-
> >common_attributes);
>  error_free_dev_mem:
>  	kfree(indio_dev->channels);
>  	return ret;
> @@ -378,8 +369,7 @@ static int hid_gyro_3d_remove(struct
> platform_device *pdev)
>  
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(&gyro_state->common_attributes);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &gyro_state-
> >common_attributes);
>  	kfree(indio_dev->channels);
>  
>  	return 0;
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c
> b/drivers/iio/humidity/hid-sensor-humidity.c
> index c99b54b0568d..d2318c4aab0f 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -7,8 +7,6 @@
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/triggered_buffer.h>
> -#include <linux/iio/trigger_consumer.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> @@ -233,12 +231,8 @@ static int hid_humidity_probe(struct
> platform_device *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev,
> -					&iio_pollfunc_store_time, NULL,
> NULL);
> -	if (ret)
> -		return ret;
> -
>  	atomic_set(&humid_st->common_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  				&humid_st->common_attributes);
>  	if (ret)
> @@ -261,7 +255,7 @@ static int hid_humidity_probe(struct
> platform_device *pdev)
>  error_remove_callback:
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&humid_st->common_attributes);
> +	hid_sensor_remove_trigger(indio_dev, &humid_st-
> >common_attributes);
>  	return ret;
>  }
>  
> @@ -274,7 +268,7 @@ static int hid_humidity_remove(struct
> platform_device *pdev)
>  
>  	iio_device_unregister(indio_dev);
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
> -	hid_sensor_remove_trigger(&humid_st->common_attributes);
> +	hid_sensor_remove_trigger(indio_dev, &humid_st-
> >common_attributes);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/light/hid-sensor-als.c
> b/drivers/iio/light/hid-sensor-als.c
> index b6cd299517d1..81fa2a422797 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -14,8 +14,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
>  enum {
> @@ -308,18 +306,13 @@ static int hid_als_probe(struct platform_device
> *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> -		NULL, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to initialize trigger
> buffer\n");
> -		goto error_free_dev_mem;
> -	}
>  	atomic_set(&als_state->common_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  				&als_state->common_attributes);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_unreg_buffer_funcs;
> +		goto error_free_dev_mem;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -343,9 +336,7 @@ static int hid_als_probe(struct platform_device
> *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&als_state->common_attributes);
> -error_unreg_buffer_funcs:
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &als_state-
> >common_attributes);
>  error_free_dev_mem:
>  	kfree(indio_dev->channels);
>  	return ret;
> @@ -360,8 +351,7 @@ static int hid_als_remove(struct platform_device
> *pdev)
>  
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(&als_state->common_attributes);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &als_state-
> >common_attributes);
>  	kfree(indio_dev->channels);
>  
>  	return 0;
> diff --git a/drivers/iio/light/hid-sensor-prox.c
> b/drivers/iio/light/hid-sensor-prox.c
> index 7e1030af9ba3..e9c04df07344 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -14,8 +14,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
>  #define CHANNEL_SCAN_INDEX_PRESENCE 0
> @@ -286,18 +284,13 @@ static int hid_prox_probe(struct
> platform_device *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> -		NULL, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to initialize trigger
> buffer\n");
> -		goto error_free_dev_mem;
> -	}
>  	atomic_set(&prox_state->common_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  				&prox_state->common_attributes);
>  	if (ret) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_unreg_buffer_funcs;
> +		goto error_free_dev_mem;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -321,9 +314,7 @@ static int hid_prox_probe(struct platform_device
> *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&prox_state->common_attributes);
> -error_unreg_buffer_funcs:
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &prox_state-
> >common_attributes);
>  error_free_dev_mem:
>  	kfree(indio_dev->channels);
>  	return ret;
> @@ -338,8 +329,7 @@ static int hid_prox_remove(struct platform_device
> *pdev)
>  
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(&prox_state->common_attributes);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &prox_state-
> >common_attributes);
>  	kfree(indio_dev->channels);
>  
>  	return 0;
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index 25e60b233e08..0c09daf87794 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -14,8 +14,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
>  enum magn_3d_channel {
> @@ -519,18 +517,13 @@ static int hid_magn_3d_probe(struct
> platform_device *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> -		NULL, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to initialize trigger
> buffer\n");
> -		return ret;
> -	}
>  	atomic_set(&magn_state->magn_flux_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  					&magn_state-
> >magn_flux_attributes);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_unreg_buffer_funcs;
> +		return ret;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -554,9 +547,7 @@ static int hid_magn_3d_probe(struct
> platform_device *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
> -error_unreg_buffer_funcs:
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &magn_state-
> >magn_flux_attributes);
>  	return ret;
>  }
>  
> @@ -569,8 +560,7 @@ static int hid_magn_3d_remove(struct
> platform_device *pdev)
>  
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &magn_state-
> >magn_flux_attributes);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c
> b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index 00af68764cda..6aac8bea233a 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -15,8 +15,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
>  enum incl_3d_channel {
> @@ -346,18 +344,13 @@ static int hid_incl_3d_probe(struct
> platform_device *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> -		NULL, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to initialize trigger
> buffer\n");
> -		goto error_free_dev_mem;
> -	}
>  	atomic_set(&incl_state->common_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  					&incl_state-
> >common_attributes);
>  	if (ret) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_unreg_buffer_funcs;
> +		goto error_free_dev_mem;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -382,9 +375,7 @@ static int hid_incl_3d_probe(struct
> platform_device *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&incl_state->common_attributes);
> -error_unreg_buffer_funcs:
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &incl_state-
> >common_attributes);
>  error_free_dev_mem:
>  	kfree(indio_dev->channels);
>  	return ret;
> @@ -399,8 +390,7 @@ static int hid_incl_3d_remove(struct
> platform_device *pdev)
>  
>  	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_INCLINOMETER_3D);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(&incl_state->common_attributes);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &incl_state-
> >common_attributes);
>  	kfree(indio_dev->channels);
>  
>  	return 0;
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c
> b/drivers/iio/orientation/hid-sensor-rotation.c
> index 64ae7d04a200..b99f41240e3e 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -14,8 +14,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
>  struct dev_rot_state {
> @@ -288,18 +286,13 @@ static int hid_dev_rot_probe(struct
> platform_device *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> -		NULL, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to initialize trigger
> buffer\n");
> -		return ret;
> -	}
>  	atomic_set(&rot_state->common_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  					&rot_state->common_attributes);
>  	if (ret) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_unreg_buffer_funcs;
> +		return ret;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -323,9 +316,7 @@ static int hid_dev_rot_probe(struct
> platform_device *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&rot_state->common_attributes);
> -error_unreg_buffer_funcs:
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &rot_state-
> >common_attributes);
>  	return ret;
>  }
>  
> @@ -338,8 +329,7 @@ static int hid_dev_rot_remove(struct
> platform_device *pdev)
>  
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(&rot_state->common_attributes);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &rot_state-
> >common_attributes);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/pressure/hid-sensor-press.c
> b/drivers/iio/pressure/hid-sensor-press.c
> index 953235052155..5e6663f757ae 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -14,8 +14,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
>  #define CHANNEL_SCAN_INDEX_PRESSURE 0
> @@ -290,18 +288,13 @@ static int hid_press_probe(struct
> platform_device *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> -		NULL, NULL);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to initialize trigger
> buffer\n");
> -		goto error_free_dev_mem;
> -	}
>  	atomic_set(&press_state->common_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  				&press_state->common_attributes);
>  	if (ret) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");
> -		goto error_unreg_buffer_funcs;
> +		goto error_free_dev_mem;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -325,9 +318,7 @@ static int hid_press_probe(struct platform_device
> *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&press_state->common_attributes);
> -error_unreg_buffer_funcs:
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &press_state-
> >common_attributes);
>  error_free_dev_mem:
>  	kfree(indio_dev->channels);
>  	return ret;
> @@ -342,8 +333,7 @@ static int hid_press_remove(struct
> platform_device *pdev)
>  
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(&press_state->common_attributes);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev, &press_state-
> >common_attributes);
>  	kfree(indio_dev->channels);
>  
>  	return 0;
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c
> b/drivers/iio/temperature/hid-sensor-temperature.c
> index eda55b9c1e9b..8d1f434f109d 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -7,8 +7,6 @@
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/triggered_buffer.h>
> -#include <linux/iio/trigger_consumer.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> @@ -230,12 +228,8 @@ static int hid_temperature_probe(struct
> platform_device *pdev)
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev,
> -					&iio_pollfunc_store_time, NULL,
> NULL);
> -	if (ret)
> -		return ret;
> -
>  	atomic_set(&temp_st->common_attributes.data_ready, 0);
> +
>  	ret = hid_sensor_setup_trigger(indio_dev, name,
>  				&temp_st->common_attributes);
>  	if (ret)
> @@ -258,7 +252,7 @@ static int hid_temperature_probe(struct
> platform_device *pdev)
>  error_remove_callback:
>  	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_TEMPERATURE);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(&temp_st->common_attributes);
> +	hid_sensor_remove_trigger(indio_dev, &temp_st-
> >common_attributes);
>  	return ret;
>  }
>  
> @@ -270,7 +264,7 @@ static int hid_temperature_remove(struct
> platform_device *pdev)
>  	struct temperature_state *temp_st = iio_priv(indio_dev);
>  
>  	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_TEMPERATURE);
> -	hid_sensor_remove_trigger(&temp_st->common_attributes);
> +	hid_sensor_remove_trigger(indio_dev, &temp_st-
> >common_attributes);
>  
>  	return 0;
>  }

