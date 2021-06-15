Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA93A890D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jun 2021 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFOTDR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Jun 2021 15:03:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:61976 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhFOTDR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Jun 2021 15:03:17 -0400
IronPort-SDR: R7cWrsb04GQQFH/gv9KZhPaUWPyB+PAPImMtHR+0772MV+4ZKQkqYn8IYJn18tWDsv72lnVqHR
 +bdKvhLvKnHA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="227533806"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="227533806"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 12:01:11 -0700
IronPort-SDR: +XVHQDZgJ0MkKfFAZAc58KcJNTstMDkY50S5SV1xID9AVuk2dOse2QhTmVAb8pbmmulh3tz2b7
 HEk3GQOE/mBg==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="471739208"
Received: from scha1-mobl1.amr.corp.intel.com ([10.209.8.199])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 12:01:11 -0700
Message-ID: <2b575429da7b4194ece93b6444f34a10d28e20cf.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensors: Update header includes
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <jikos@kernel.org>
Date:   Tue, 15 Jun 2021 12:01:10 -0700
In-Reply-To: <20210608205510.4033887-1-jic23@kernel.org>
References: <20210608205510.4033887-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2021-06-08 at 21:55 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> General driver churn doesn't always include updates of header
> includes.
> Manual review of the output of the include-what-you-use checker lead
> to the
> following cleanup. Hopefuly this brings things back to a good state
> for the
> hid-sensor drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c                | 5 +----
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 6 ------
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c    | 5 +----
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.h    | 3 +++
>  drivers/iio/gyro/hid-sensor-gyro-3d.c                  | 5 +----
>  drivers/iio/humidity/hid-sensor-humidity.c             | 1 +
>  drivers/iio/light/hid-sensor-als.c                     | 5 +----
>  drivers/iio/light/hid-sensor-prox.c                    | 5 +----
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c          | 6 +-----
>  drivers/iio/orientation/hid-sensor-incl-3d.c           | 5 +----
>  drivers/iio/orientation/hid-sensor-rotation.c          | 4 +---
>  drivers/iio/position/hid-sensor-custom-intel-hinge.c   | 2 ++
>  drivers/iio/pressure/hid-sensor-press.c                | 5 +----
>  drivers/iio/temperature/hid-sensor-temperature.c       | 1 +
>  14 files changed, 16 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c
> b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 27f47e1c251e..b4fa53dc447a 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -6,13 +6,10 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
> -#include <linux/delay.h>
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index cb52b4fd6bf7..eb6a9012c899 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -3,18 +3,12 @@
>   * HID Sensors Driver
>   * Copyright (c) 2012, Intel Corporation.
>   */
> -#include <linux/device.h>
> -#include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
>  #include <linux/kernel.h>
> -#include <linux/slab.h>
>  #include <linux/time.h>
>  
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  
>  #define HZ_PER_MHZ	1000000L
>  
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index c06537e106e9..4918e2c8f6d5 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -6,16 +6,13 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/hid-sensor-hub.h>
> +#include <linux/workqueue.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
>  #include "hid-sensor-trigger.h"
>  
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> index bb45cc89e551..f94fca4f1edf 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> @@ -9,6 +9,9 @@
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  
> +struct hid_sensor_common;
> +struct iio_dev;
> +
>  extern const struct dev_pm_ops hid_sensor_pm_ops;
>  
>  int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char
> *name,
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index dad26ee4fd1f..a8f59ed802f4 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -6,13 +6,10 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
> -#include <linux/delay.h>
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c
> b/drivers/iio/humidity/hid-sensor-humidity.c
> index 74383abc0d44..64fe6752ec16 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -8,6 +8,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "hid-sensor-trigger.h"
> diff --git a/drivers/iio/light/hid-sensor-als.c
> b/drivers/iio/light/hid-sensor-als.c
> index 85c8a05b73cb..cddd8d448372 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -6,13 +6,10 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
> -#include <linux/delay.h>
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> diff --git a/drivers/iio/light/hid-sensor-prox.c
> b/drivers/iio/light/hid-sensor-prox.c
> index 17d167c3d595..e02cc6cdf44a 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -6,13 +6,10 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
> -#include <linux/delay.h>
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index b78691523dd4..e42352c3221d 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -6,13 +6,9 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/slab.h>
> -#include <linux/delay.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c
> b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index 7af48d336285..9a7fa7e07522 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -7,13 +7,10 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
> -#include <linux/delay.h>
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c
> b/drivers/iio/orientation/hid-sensor-rotation.c
> index cf7f57a47681..8c1cb63c754c 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -7,9 +7,7 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/slab.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> index 738b5f4626ce..8d90637ec1b6 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -7,6 +7,8 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> diff --git a/drivers/iio/pressure/hid-sensor-press.c
> b/drivers/iio/pressure/hid-sensor-press.c
> index c416d261e3e3..f30a26b8ab38 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -6,13 +6,10 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
> -#include <linux/delay.h>
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c
> b/drivers/iio/temperature/hid-sensor-temperature.c
> index dc534ed784c3..be102632c4ae 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -8,6 +8,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  
>  #include "../common/hid-sensors/hid-sensor-trigger.h"

