Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECC913114E
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2020 12:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAFLTy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jan 2020 06:19:54 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:53277 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbgAFLTy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jan 2020 06:19:54 -0500
Received: from [192.168.2.10] ([62.249.185.68])
        by smtp-cloud9.xs4all.net with ESMTPA
        id oQQCiIkfRVPvpoQQFipFNl; Mon, 06 Jan 2020 12:19:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1578309590; bh=WTFPzLKpSyL8vX49R31hgwctxVYMXN6SXnBoQi7DhHo=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=AnlljTfJCWKQUISB3oJI2lnur5ekQnqe0l4113w0vl27ldR/df2b7wVjqVxbAFmS1
         /Ro2+8tnBOPioKqnyYWJ5uxfOdARpwMk+S9CAN50B5/848qx/x9GpLapg2JWi3yPrn
         3EJiszbyZcZvw6Ovjjq9BR7kCbvbr3fBHIbeFiDhMbfg7vw8cv96vJyCj/qoovNyYx
         wFv8wi8E9D7jUplemmTY4Q/nb/E/uW4FiFrMZ+IJ0muLofFtfkOBr8rkVbrYknylJJ
         EAy63oChSFKUiY/g6Mk9hO0lRgWElARDty4lWkBQLzxeYtFVGcuNHbexkY5LIlzwO4
         rADmwJ+yleWvg==
Subject: Re: [PATCH] cros_ec: treewide: Remove 'include/linux/mfd/cros_ec.h'
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-iio@vger.kernel.org, Nick Vaccaro <nvaccaro@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20191203145018.14015-1-enric.balletbo@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <01ec4d6c-b8a2-7d9c-051a-58d2d7803ca3@xs4all.nl>
Date:   Mon, 6 Jan 2020 12:19:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191203145018.14015-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKrABNQroSeG65k4kMShMrlHPkb33+jC29HXo1nz+LpRj9Zqqz+TYGMm4btc1kKOk+xEsLKQ6oP3LRz3ZXEC5Hkoi7Jsg03uYUW0HPecR8mhRJfUAdc9
 0Qp/Wtz1yoPUJRVzamyRrcnkiY5t8y+sT3TwoaqsTrvDr6SV2hzUwSRctNCMaNdxl77N71xQTqEucZVIwb8ldpYzqBfS0VWanQ5LucIwS2Yf/sAPfzej/7oF
 50D2+EwoCxpi4dtEKmEkEvTOukdNmRzUuAM7F3GkgeYcwXLxsUItcdvZnl4w73ifLpcZqv/mq28cbgoWxQ1WzT+drC38jt+HWEdExNGhTziVj7r0R1lTJPIf
 RaanPQ+nra5bXYTJDM/ltdL1CF3JIu4zbTlnVXrci+MsLqb4hVjB3YrUu87ig1pHQIGQmCje+zeWUxQwoOay0YP1sd1k/q68PO2zcJcHIMSqH9MjgnzO9Lb6
 GwHXff1tVxCicNJ8mjiJKQ5XgIQjywYbSo3G8a3zmnzbJ0WRtf9wLgN2H0lr1UHQHmEkX+iAVp2l64kCIaH7nvGrFc30TKGba/szQwI2sl/vUY8S/nVPinCI
 d+zNBBI0bRJT+GLxQaCUqZ0ymlJENLvnyMAaNzdP3NCqye5oyEKLEHeFT9++mRat36SvLgN2dOcchH/G9IS2y3t8vdIgrYexx6K4F1agKl3KfnrQhpsXwyqy
 6d+mw7yXsi4oFXcqyZ9xz2WSCKKwiPpka5mtyhD++PjAoHpxzgT3gBOS8OrQ35eGQt3p7x50tfFOfaSjDtgclkGasvah9E7ZmpCqZKJ8vQpn9C/ygpegL7LY
 Iy9APT37cXVL5hfwtlFSF1Og5ty5ThXwatJnlu0OWYjFwbmgYMW/4b2+YaAafkH2vcTizC0ua83SnblcX7AX9s2MdJhuILD72QEs9uLo+W6J/17+vr9tPjtl
 GCyCGBUN0BbsplQNkgK4wzodZlGK6CYYiUi9xTSL/p3bIGZcFZ5MgHFABqWcS+EQf+Azxo45/N+bQnIIKvZXQ+HIdcAVz0kfrwZ/ZJ2ZXr3gDDndowb5KXm0
 vng5DoUcyfZkiDpz+gm7a7VWIv5uI/GjdlQ=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/3/19 3:50 PM, Enric Balletbo i Serra wrote:
> This header file now only includes the cros_ec_dev struct, however, is the
> 'include/linux/platform_data/cros_ec_proto.h' who contains the definition of
> all the Chrome OS EC related structs. There is no reason to have a
> separate include for this struct so move to the place where other
> structs are defined. That way, we can remove the include itself, but also
> simplify the common pattern
> 
>     #include <linux/mfd/cros_ec.h>
>     #include <linux/platform_data/cros_ec_proto.h>
> 
> for a single include
> 
>     #include <linux/platform_data/cros_ec_proto.h>
> 
> The changes to remove the cros_ec.h include were generated with the
> following shell script:
> 
>     git grep -l "<linux/mfd/cros_ec.h>" | xargs sed -i '/<linux\/mfd\/cros_ec.h>/d'
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  1 -
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  1 -
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  1 -
>  drivers/iio/light/cros_ec_light_prox.c        |  1 -
>  drivers/iio/pressure/cros_ec_baro.c           |  1 -
>  .../media/platform/cros-ec-cec/cros-ec-cec.c  |  1 -

For the media change:

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

>  drivers/mfd/cros_ec_dev.c                     |  1 -
>  drivers/platform/chrome/cros_ec_chardev.c     |  1 -
>  drivers/platform/chrome/cros_ec_debugfs.c     |  1 -
>  drivers/platform/chrome/cros_ec_lightbar.c    |  1 -
>  drivers/platform/chrome/cros_ec_sensorhub.c   |  1 -
>  drivers/platform/chrome/cros_ec_sysfs.c       |  1 -
>  drivers/platform/chrome/cros_ec_vbc.c         |  1 -
>  drivers/platform/chrome/cros_usbpd_logger.c   |  1 -
>  drivers/power/supply/cros_usbpd-charger.c     |  1 -
>  drivers/rtc/rtc-cros-ec.c                     |  1 -
>  include/linux/mfd/cros_ec.h                   | 35 -------------------
>  include/linux/platform_data/cros_ec_proto.h   | 23 +++++++++++-
>  18 files changed, 22 insertions(+), 52 deletions(-)
>  delete mode 100644 include/linux/mfd/cros_ec.h
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 65f85faf6f31..68e847c6255e 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -18,7 +18,6 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 7dce04473467..576e45faafaf 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -16,7 +16,6 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 81a7f692de2f..d3a3626c7cd8 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -13,7 +13,6 @@
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/kernel.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index d85a391e50c5..7a838e2956f4 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -14,7 +14,6 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/kernel.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 2354302375de..d2a67dceb996 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -14,7 +14,6 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/kernel.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> diff --git a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
> index 4a3b3810fd89..72c70f123650 100644
> --- a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
> +++ b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
> @@ -14,7 +14,6 @@
>  #include <linux/cec.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <media/cec.h>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index c4b977a5dd96..8da4e4cef26f 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -6,7 +6,6 @@
>   */
>  
>  #include <linux/mfd/core.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/of_platform.h>
> diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
> index 74ded441bb50..c65e70bc168d 100644
> --- a/drivers/platform/chrome/cros_ec_chardev.c
> +++ b/drivers/platform/chrome/cros_ec_chardev.c
> @@ -13,7 +13,6 @@
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/fs.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 6ae484989d1f..ecfada00e6c5 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -7,7 +7,6 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index c0f2eec35a48..b4c110c5fee0 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -8,7 +8,6 @@
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/kobject.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
> index 04d8879689e9..79fefd3bb0fa 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -9,7 +9,6 @@
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_data/cros_ec_sensorhub.h>
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index 74d36b8d4f46..07dac97ad57c 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -8,7 +8,6 @@
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/kobject.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index f11a1283e5c8..8edae465105c 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -6,7 +6,6 @@
>  
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
> index 374cdd1e868a..7de3ea75ef46 100644
> --- a/drivers/platform/chrome/cros_usbpd_logger.c
> +++ b/drivers/platform/chrome/cros_usbpd_logger.c
> @@ -6,7 +6,6 @@
>   */
>  
>  #include <linux/ktime.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 6cc7c3910e09..0aca0da41cb7 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -5,7 +5,6 @@
>   * Copyright (c) 2014 - 2018 Google, Inc
>   */
>  
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
> index d043d30f05bc..f7343c289cab 100644
> --- a/drivers/rtc/rtc-cros-ec.c
> +++ b/drivers/rtc/rtc-cros-ec.c
> @@ -5,7 +5,6 @@
>  // Author: Stephen Barber <smbarber@chromium.org>
>  
>  #include <linux/kernel.h>
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> deleted file mode 100644
> index 61c2875c2a40..000000000000
> --- a/include/linux/mfd/cros_ec.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * ChromeOS EC multi-function device
> - *
> - * Copyright (C) 2012 Google, Inc
> - */
> -
> -#ifndef __LINUX_MFD_CROS_EC_H
> -#define __LINUX_MFD_CROS_EC_H
> -
> -#include <linux/device.h>
> -
> -/**
> - * struct cros_ec_dev - ChromeOS EC device entry point.
> - * @class_dev: Device structure used in sysfs.
> - * @ec_dev: cros_ec_device structure to talk to the physical device.
> - * @dev: Pointer to the platform device.
> - * @debug_info: cros_ec_debugfs structure for debugging information.
> - * @has_kb_wake_angle: True if at least 2 accelerometer are connected to the EC.
> - * @cmd_offset: Offset to apply for each command.
> - * @features: Features supported by the EC.
> - */
> -struct cros_ec_dev {
> -	struct device class_dev;
> -	struct cros_ec_device *ec_dev;
> -	struct device *dev;
> -	struct cros_ec_debugfs *debug_info;
> -	bool has_kb_wake_angle;
> -	u16 cmd_offset;
> -	u32 features[2];
> -};
> -
> -#define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
> -
> -#endif /* __LINUX_MFD_CROS_EC_H */
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 30098a551523..119b9951c055 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -12,7 +12,6 @@
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>  
> -#include <linux/mfd/cros_ec.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  
>  #define CROS_EC_DEV_NAME	"cros_ec"
> @@ -185,6 +184,28 @@ struct cros_ec_platform {
>  	u16 cmd_offset;
>  };
>  
> +/**
> + * struct cros_ec_dev - ChromeOS EC device entry point.
> + * @class_dev: Device structure used in sysfs.
> + * @ec_dev: cros_ec_device structure to talk to the physical device.
> + * @dev: Pointer to the platform device.
> + * @debug_info: cros_ec_debugfs structure for debugging information.
> + * @has_kb_wake_angle: True if at least 2 accelerometer are connected to the EC.
> + * @cmd_offset: Offset to apply for each command.
> + * @features: Features supported by the EC.
> + */
> +struct cros_ec_dev {
> +	struct device class_dev;
> +	struct cros_ec_device *ec_dev;
> +	struct device *dev;
> +	struct cros_ec_debugfs *debug_info;
> +	bool has_kb_wake_angle;
> +	u16 cmd_offset;
> +	u32 features[2];
> +};
> +
> +#define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
> +
>  int cros_ec_suspend(struct cros_ec_device *ec_dev);
>  
>  int cros_ec_resume(struct cros_ec_device *ec_dev);
> 

