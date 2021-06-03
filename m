Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC61839A6A0
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 19:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFCRHG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 13:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFCRHF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 13:07:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5614613C9;
        Thu,  3 Jun 2021 17:05:17 +0000 (UTC)
Date:   Thu, 3 Jun 2021 18:07:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ye Xiang <xiang.ye@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: hid-sensors: lighten the exported symbols
 by introducing IIO_HID namespace
Message-ID: <20210603180700.3206eda0@jic23-huawei>
In-Reply-To: <20210525132119.21800-1-andriy.shevchenko@linux.intel.com>
References: <20210525132119.21800-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 May 2021 16:21:19 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> A namespace for exported symbols makes clear who is a provider and who is
> a consumer of the certain resources. Besides that, it doesn't pollute
> the common namespace.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'm fine with this, but looking for input from Srinivas and Jiri before
I apply it.

> ---
> 
> Jonothan et al. This is just a work against HID IIO sensor drivers, I think
> that entire IIO can gain from namespaces. But I leave it for you to decide and
> how to proceed / convert.

It's been on the todo list since Jon Corbetts recent LWN article pointing out
how underused this feature is which reminded me of it's existence.

I agree in principle with doing it, but that is going to be a rather big
single shot patch.  One for early in a cycle I think.

We have a lot of multi-module drivers as well where this might have benefits
and would be a rather more contained change.

Jonathan

> 
> Yes, due to nature of this (kind of) change it may not be split.
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       |  1 +
>  .../hid-sensors/hid-sensor-attributes.c       | 26 +++++++++----------
>  .../common/hid-sensors/hid-sensor-trigger.c   |  9 ++++---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         |  1 +
>  drivers/iio/humidity/hid-sensor-humidity.c    |  1 +
>  drivers/iio/light/hid-sensor-als.c            |  1 +
>  drivers/iio/light/hid-sensor-prox.c           |  1 +
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  1 +
>  drivers/iio/orientation/hid-sensor-incl-3d.c  |  1 +
>  drivers/iio/orientation/hid-sensor-rotation.c |  1 +
>  .../position/hid-sensor-custom-intel-hinge.c  |  1 +
>  drivers/iio/pressure/hid-sensor-press.c       |  1 +
>  .../iio/temperature/hid-sensor-temperature.c  |  1 +
>  13 files changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 27f47e1c251e..bcafca7b2eac 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -465,3 +465,4 @@ module_platform_driver(hid_accel_3d_platform_driver);
>  MODULE_DESCRIPTION("HID Sensor Accel 3D");
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index cb52b4fd6bf7..a81a0b206af6 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -176,7 +176,7 @@ s32 hid_sensor_read_poll_value(struct hid_sensor_common *st)
>  
>  	return value;
>  }
> -EXPORT_SYMBOL(hid_sensor_read_poll_value);
> +EXPORT_SYMBOL_NS(hid_sensor_read_poll_value, IIO_HID_ATTRIBUTES);
>  
>  int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
>  				int *val1, int *val2)
> @@ -203,7 +203,7 @@ int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
>  
>  	return IIO_VAL_INT_PLUS_MICRO;
>  }
> -EXPORT_SYMBOL(hid_sensor_read_samp_freq_value);
> +EXPORT_SYMBOL_NS(hid_sensor_read_samp_freq_value, IIO_HID);
>  
>  int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
>  				int val1, int val2)
> @@ -238,7 +238,7 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(hid_sensor_write_samp_freq_value);
> +EXPORT_SYMBOL_NS(hid_sensor_write_samp_freq_value, IIO_HID);
>  
>  int hid_sensor_read_raw_hyst_value(struct hid_sensor_common *st,
>  				int *val1, int *val2)
> @@ -261,7 +261,7 @@ int hid_sensor_read_raw_hyst_value(struct hid_sensor_common *st,
>  
>  	return IIO_VAL_INT_PLUS_MICRO;
>  }
> -EXPORT_SYMBOL(hid_sensor_read_raw_hyst_value);
> +EXPORT_SYMBOL_NS(hid_sensor_read_raw_hyst_value, IIO_HID);
>  
>  int hid_sensor_read_raw_hyst_rel_value(struct hid_sensor_common *st, int *val1,
>  				       int *val2)
> @@ -283,7 +283,7 @@ int hid_sensor_read_raw_hyst_rel_value(struct hid_sensor_common *st, int *val1,
>  
>  	return IIO_VAL_INT_PLUS_MICRO;
>  }
> -EXPORT_SYMBOL(hid_sensor_read_raw_hyst_rel_value);
> +EXPORT_SYMBOL_NS(hid_sensor_read_raw_hyst_rel_value, IIO_HID);
>  
>  
>  int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
> @@ -315,7 +315,7 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);
> +EXPORT_SYMBOL_NS(hid_sensor_write_raw_hyst_value, IIO_HID);
>  
>  int hid_sensor_write_raw_hyst_rel_value(struct hid_sensor_common *st,
>  					int val1, int val2)
> @@ -346,7 +346,7 @@ int hid_sensor_write_raw_hyst_rel_value(struct hid_sensor_common *st,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(hid_sensor_write_raw_hyst_rel_value);
> +EXPORT_SYMBOL_NS(hid_sensor_write_raw_hyst_rel_value, IIO_HID);
>  
>  /*
>   * This fuction applies the unit exponent to the scale.
> @@ -430,14 +430,14 @@ int hid_sensor_format_scale(u32 usage_id,
>  
>  	return IIO_VAL_INT_PLUS_NANO;
>  }
> -EXPORT_SYMBOL(hid_sensor_format_scale);
> +EXPORT_SYMBOL_NS(hid_sensor_format_scale, IIO_HID);
>  
>  int64_t hid_sensor_convert_timestamp(struct hid_sensor_common *st,
>  				     int64_t raw_value)
>  {
>  	return st->timestamp_ns_scale * raw_value;
>  }
> -EXPORT_SYMBOL(hid_sensor_convert_timestamp);
> +EXPORT_SYMBOL_NS(hid_sensor_convert_timestamp, IIO_HID);
>  
>  static
>  int hid_sensor_get_reporting_interval(struct hid_sensor_hub_device *hsdev,
> @@ -484,7 +484,7 @@ int hid_sensor_get_report_latency(struct hid_sensor_common *st)
>  
>  	return value;
>  }
> -EXPORT_SYMBOL(hid_sensor_get_report_latency);
> +EXPORT_SYMBOL_NS(hid_sensor_get_report_latency, IIO_HID_ATTRIBUTES);
>  
>  int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency_ms)
>  {
> @@ -492,13 +492,13 @@ int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency_ms)
>  				      st->report_latency.index,
>  				      sizeof(latency_ms), &latency_ms);
>  }
> -EXPORT_SYMBOL(hid_sensor_set_report_latency);
> +EXPORT_SYMBOL_NS(hid_sensor_set_report_latency, IIO_HID_ATTRIBUTES);
>  
>  bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st)
>  {
>  	return st->report_latency.index > 0 && st->report_latency.report_id > 0;
>  }
> -EXPORT_SYMBOL(hid_sensor_batch_mode_supported);
> +EXPORT_SYMBOL_NS(hid_sensor_batch_mode_supported, IIO_HID_ATTRIBUTES);
>  
>  int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  					u32 usage_id,
> @@ -590,7 +590,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(hid_sensor_parse_common_attributes);
> +EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, IIO_HID);
>  
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_DESCRIPTION("HID Sensor common attribute processing");
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index c06537e106e9..60e85d675387 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -150,7 +150,7 @@ static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(hid_sensor_power_state);
> +EXPORT_SYMBOL_NS(hid_sensor_power_state, IIO_HID);
>  
>  int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  {
> @@ -225,7 +225,7 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>  	iio_trigger_free(attrb->trigger);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  }
> -EXPORT_SYMBOL(hid_sensor_remove_trigger);
> +EXPORT_SYMBOL_NS(hid_sensor_remove_trigger, IIO_HID);
>  
>  static const struct iio_trigger_ops hid_sensor_trigger_ops = {
>  	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
> @@ -291,7 +291,7 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	return ret;
>  }
> -EXPORT_SYMBOL(hid_sensor_setup_trigger);
> +EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, IIO_HID);
>  
>  static int __maybe_unused hid_sensor_suspend(struct device *dev)
>  {
> @@ -321,8 +321,9 @@ const struct dev_pm_ops hid_sensor_pm_ops = {
>  	SET_RUNTIME_PM_OPS(hid_sensor_suspend,
>  			   hid_sensor_runtime_resume, NULL)
>  };
> -EXPORT_SYMBOL(hid_sensor_pm_ops);
> +EXPORT_SYMBOL_NS(hid_sensor_pm_ops, IIO_HID);
>  
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_DESCRIPTION("HID Sensor trigger processing");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID_ATTRIBUTES);
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index dad26ee4fd1f..2ed2a8effb86 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -400,3 +400,4 @@ module_platform_driver(hid_gyro_3d_platform_driver);
>  MODULE_DESCRIPTION("HID Sensor Gyroscope 3D");
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
> index 74383abc0d44..8a9091d71d2a 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -295,3 +295,4 @@ module_platform_driver(hid_humidity_platform_driver);
>  MODULE_DESCRIPTION("HID Environmental humidity sensor");
>  MODULE_AUTHOR("Song Hongyan <hongyan.song@intel.com>");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 85c8a05b73cb..a63d577493e2 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -392,3 +392,4 @@ module_platform_driver(hid_als_platform_driver);
>  MODULE_DESCRIPTION("HID Sensor ALS");
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 17d167c3d595..99de268563d6 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -350,3 +350,4 @@ module_platform_driver(hid_prox_platform_driver);
>  MODULE_DESCRIPTION("HID Sensor Proximity");
>  MODULE_AUTHOR("Archana Patni <archana.patni@intel.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index b78691523dd4..a66f9e933628 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -587,3 +587,4 @@ module_platform_driver(hid_magn_3d_platform_driver);
>  MODULE_DESCRIPTION("HID Sensor Magnetometer 3D");
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index 7af48d336285..cc905b0fa835 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -425,3 +425,4 @@ module_platform_driver(hid_incl_3d_platform_driver);
>  MODULE_DESCRIPTION("HID Sensor Inclinometer 3D");
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index cf7f57a47681..6570bfd22035 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -373,3 +373,4 @@ module_platform_driver(hid_dev_rot_platform_driver);
>  MODULE_DESCRIPTION("HID Sensor Device Rotation");
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> index 738b5f4626ce..4478ad9387c5 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -376,3 +376,4 @@ module_platform_driver(hid_hinge_platform_driver);
>  MODULE_DESCRIPTION("HID Sensor INTEL Hinge");
>  MODULE_AUTHOR("Ye Xiang <xiang.ye@intel.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index c416d261e3e3..79b3399e4095 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -357,3 +357,4 @@ module_platform_driver(hid_press_platform_driver);
>  MODULE_DESCRIPTION("HID Sensor Pressure");
>  MODULE_AUTHOR("Archana Patni <archana.patni@intel.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_HID);
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
> index dc534ed784c3..21aa952b9f6d 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -291,3 +291,4 @@ module_platform_driver(hid_temperature_platform_driver);
>  MODULE_DESCRIPTION("HID Environmental temperature sensor");
>  MODULE_AUTHOR("Song Hongyan <hongyan.song@intel.com>");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_HID);

