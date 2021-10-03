Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417A0420288
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhJCQCW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 12:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhJCQCW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 12:02:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58A961215;
        Sun,  3 Oct 2021 16:00:33 +0000 (UTC)
Date:   Sun, 3 Oct 2021 17:04:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] iio: cros_ec: Update header includes
Message-ID: <20211003170431.00dab6bc@jic23-huawei>
In-Reply-To: <20210608212834.4046618-1-jic23@kernel.org>
References: <20210608212834.4046618-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  8 Jun 2021 22:28:34 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> General driver churn doesn't always include updates of header includes.
> Manual review of the output of the include-what-you-use checker lead to the
> following cleanup. Hopefuly this brings things back to a good state for the
> cros_ec sensor drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
I've sent a new version of this (at least partly because I'd forgotten I'd
done it before and no reply to this since posting in June :(

Anyhow, that version only deals with IIO headers so is smaller and easier
to consider in isolation.  If people prefer this one I'm happy as well.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c                  | 7 +------
>  drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c    | 8 ++------
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 7 ++-----
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 6 ++++--
>  drivers/iio/light/cros_ec_light_prox.c                    | 8 ++------
>  drivers/iio/pressure/cros_ec_baro.c                       | 7 ++-----
>  6 files changed, 13 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index b6f3471b62dc..5b24b762b2dd 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -9,17 +9,12 @@
>   * Accelerometer access is presented through iio sysfs.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/kfifo_buf.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/slab.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> index af801e203623..497deaf9d96a 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> @@ -10,20 +10,16 @@
>   * iio sysfs.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/kfifo_buf.h>
> -#include <linux/iio/trigger.h>
>  #include <linux/iio/triggered_buffer.h>
> -#include <linux/iio/trigger_consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_device.h>
> -#include <linux/slab.h>
>  
>  #define DRV_NAME "cros-ec-lid-angle"
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 376a5b30010a..de8b01501cc5 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -9,18 +9,15 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/kfifo_buf.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
> -#include <linux/slab.h>
>  
>  #define CROS_EC_SENSORS_MAX_CHANNELS 4
>  
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 28bde13003b7..370d1017b533 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -12,12 +12,14 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/irqreturn.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/time.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_data/cros_ec_sensorhub.h>
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index de472f23d1cb..062e02adac65 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -6,19 +6,15 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/kfifo_buf.h>
> -#include <linux/iio/trigger.h>
> -#include <linux/iio/triggered_buffer.h>
> -#include <linux/iio/trigger_consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
> -#include <linux/slab.h>
>  
>  /*
>   * We only represent one entry for light or proximity. EC is merging different
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 2f882e109423..5a0d9dd1e78a 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -6,16 +6,13 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>
>  #include <linux/iio/iio.h>
> -#include <linux/iio/kfifo_buf.h>
> -#include <linux/iio/trigger.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/slab.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>

