Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE118D40C0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfJKNNe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 09:13:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44667 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbfJKNNe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 09:13:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so1791820pgd.11
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AhU/pNgvjmzcA5MROaFDvW3sRLrh+j7YWtKewVs2Sko=;
        b=RxHOGNSGbeqsPQoTKS+c/LZtPHAcn8uaXjg3CCG0x5Ob42YZpzFRsHMdvOW8m8Jaje
         HQxkvNlm4O/uWH28dXhg2mvDRgy3h0b67XETjMxSETkwZRYyxSIzWco2mtqflKhF5xHw
         vEk0Rz5YleCNRBs8tqzrQEwVG5mvEoTHEOzb47N85WnTMEsXYdgW1mK2GPtUjNApZnk7
         alz9yicWUde4q+87YvLD4UBU1ydOQGvnHEgNd38SXVJ1e/IkzJIyge7ielkgaduKiWv0
         l2kRJfTW5Z5AB0Mqjdkbd/0bbsEa4MXxNLoHYkNMAVXzD7ed/g56NhBQztKId1t2eKrF
         +plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AhU/pNgvjmzcA5MROaFDvW3sRLrh+j7YWtKewVs2Sko=;
        b=rDbOqrh89QC34YNl5mHaamTU5scqSv+E+aP7SgZoWuGdTBy5QldmUHtRtF0iGgSd6l
         4x5sSxcpqRGeFbPoF+piGbLZdUztiVAUb+rc3ZqIOsXcniX4IUCA8hDHB4VAvytBjayY
         2WP0EwLvsCo/IJh5jV6EWAIwq8cZH2avQMoJ6JCGbHrH5qk59jjlHlOGlR7Ry7hiFMZz
         Ax516qOKq6Nuxx783QiJc3DOZw9MLz5TlKlPU/Ov8C0E+76NGtQOk673yl4YAgb4U8eK
         5TcHFouWVO05r+yL+t+LXs9QvjTlPyHFi40xgJ04xX5BftpEZG6DhPGQ8ntvMwHbbHF4
         f9rQ==
X-Gm-Message-State: APjAAAXtFJcomKqkt+0yT3V93+uQyjK7RLVaET4AxfHKXxYM1MuGUtzx
        Lsr0/CMWz2phbeVJ2tglrQM=
X-Google-Smtp-Source: APXvYqwleX/wUWSHA5zKfx4C9VQ1NKkOKdpqK8og6ZzPhqhLVRiIXwKu1hiZXPpGNiw4e0D7n/dZ0g==
X-Received: by 2002:a62:8305:: with SMTP id h5mr15953648pfe.190.1570799613466;
        Fri, 11 Oct 2019 06:13:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p190sm11328313pfb.160.2019.10.11.06.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 06:13:31 -0700 (PDT)
Subject: Re: [PATCH 4/7 v4] hwmon: ab8500: convert to IIO ADC
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
 <20191011071805.5554-5-linus.walleij@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b192d50a-3bcf-6d4b-f2f5-2d6276601cf4@roeck-us.net>
Date:   Fri, 11 Oct 2019 06:13:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011071805.5554-5-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/11/19 12:18 AM, Linus Walleij wrote:
> This switches the AB8500 hardware monitor driver to using
> the standard IIO ADC channel lookup and conversion routines.
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - No changes just resending
> ChangeLog v2->v3:
> - Depend on (IIO = y) since we are bool and need it compiled
>    in.
> - Rebased on v5.4-rc1
> ChangeLog v1->v2:
> - Collected ACKs.
> - Rebased on v5.3-rc5
> - Add a Kconfig dependency on IIO
> - Fix some whitespace issues
> 
> This should not be applied to the hwmon tree right now, it
> will be applied along with the other changes in ARM SoC.

I assume this is still true ?

Guenter

> ---
>   drivers/hwmon/Kconfig  |  3 +-
>   drivers/hwmon/ab8500.c | 65 ++++++++++++++++++++++++++----------------
>   2 files changed, 43 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 13a6b4afb4b3..5308c59d7001 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -40,7 +40,8 @@ comment "Native drivers"
>   
>   config SENSORS_AB8500
>   	tristate "AB8500 thermal monitoring"
> -	depends on AB8500_GPADC && AB8500_BM
> +	depends on AB8500_GPADC && AB8500_BM && (IIO = y)
> +	default n
>   	help
>   	  If you say yes here you get support for the thermal sensor part
>   	  of the AB8500 chip. The driver includes thermal management for
> diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
> index 207f77f85a40..53f3379d799d 100644
> --- a/drivers/hwmon/ab8500.c
> +++ b/drivers/hwmon/ab8500.c
> @@ -17,20 +17,24 @@
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/mfd/abx500.h>
>   #include <linux/mfd/abx500/ab8500-bm.h>
> -#include <linux/mfd/abx500/ab8500-gpadc.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/power/ab8500.h>
>   #include <linux/reboot.h>
>   #include <linux/slab.h>
>   #include <linux/sysfs.h>
> +#include <linux/iio/consumer.h>
>   #include "abx500.h"
>   
>   #define DEFAULT_POWER_OFF_DELAY	(HZ * 10)
>   #define THERMAL_VCC		1800
>   #define PULL_UP_RESISTOR	47000
> -/* Number of monitored sensors should not greater than NUM_SENSORS */
> -#define NUM_MONITORED_SENSORS	4
> +
> +#define AB8500_SENSOR_AUX1		0
> +#define AB8500_SENSOR_AUX2		1
> +#define AB8500_SENSOR_BTEMP_BALL	2
> +#define AB8500_SENSOR_BAT_CTRL		3
> +#define NUM_MONITORED_SENSORS		4
>   
>   struct ab8500_gpadc_cfg {
>   	const struct abx500_res_to_temp *temp_tbl;
> @@ -40,7 +44,8 @@ struct ab8500_gpadc_cfg {
>   };
>   
>   struct ab8500_temp {
> -	struct ab8500_gpadc *gpadc;
> +	struct iio_channel *aux1;
> +	struct iio_channel *aux2;
>   	struct ab8500_btemp *btemp;
>   	struct delayed_work power_off_work;
>   	struct ab8500_gpadc_cfg cfg;
> @@ -82,15 +87,21 @@ static int ab8500_read_sensor(struct abx500_temp *data, u8 sensor, int *temp)
>   	int voltage, ret;
>   	struct ab8500_temp *ab8500_data = data->plat_data;
>   
> -	if (sensor == BAT_CTRL) {
> -		*temp = ab8500_btemp_get_batctrl_temp(ab8500_data->btemp);
> -	} else if (sensor == BTEMP_BALL) {
> +	if (sensor == AB8500_SENSOR_BTEMP_BALL) {
>   		*temp = ab8500_btemp_get_temp(ab8500_data->btemp);
> -	} else {
> -		voltage = ab8500_gpadc_convert(ab8500_data->gpadc, sensor);
> -		if (voltage < 0)
> -			return voltage;
> -
> +	} else if (sensor == AB8500_SENSOR_BAT_CTRL) {
> +		*temp = ab8500_btemp_get_batctrl_temp(ab8500_data->btemp);
> +	} else if (sensor == AB8500_SENSOR_AUX1) {
> +		ret = iio_read_channel_processed(ab8500_data->aux1, &voltage);
> +		if (ret < 0)
> +			return ret;
> +		ret = ab8500_voltage_to_temp(&ab8500_data->cfg, voltage, temp);
> +		if (ret < 0)
> +			return ret;
> +	} else if (sensor == AB8500_SENSOR_AUX2) {
> +		ret = iio_read_channel_processed(ab8500_data->aux2, &voltage);
> +		if (ret < 0)
> +			return ret;
>   		ret = ab8500_voltage_to_temp(&ab8500_data->cfg, voltage, temp);
>   		if (ret < 0)
>   			return ret;
> @@ -164,10 +175,6 @@ int abx500_hwmon_init(struct abx500_temp *data)
>   	if (!ab8500_data)
>   		return -ENOMEM;
>   
> -	ab8500_data->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> -	if (IS_ERR(ab8500_data->gpadc))
> -		return PTR_ERR(ab8500_data->gpadc);
> -
>   	ab8500_data->btemp = ab8500_btemp_get();
>   	if (IS_ERR(ab8500_data->btemp))
>   		return PTR_ERR(ab8500_data->btemp);
> @@ -181,15 +188,25 @@ int abx500_hwmon_init(struct abx500_temp *data)
>   	ab8500_data->cfg.tbl_sz = ab8500_temp_tbl_a_size;
>   
>   	data->plat_data = ab8500_data;
> +	ab8500_data->aux1 = devm_iio_channel_get(&data->pdev->dev, "aux1");
> +	if (IS_ERR(ab8500_data->aux1)) {
> +		if (PTR_ERR(ab8500_data->aux1) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		dev_err(&data->pdev->dev, "failed to get AUX1 ADC channel\n");
> +		return PTR_ERR(ab8500_data->aux1);
> +	}
> +	ab8500_data->aux2 = devm_iio_channel_get(&data->pdev->dev, "aux2");
> +	if (IS_ERR(ab8500_data->aux2)) {
> +		if (PTR_ERR(ab8500_data->aux2) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		dev_err(&data->pdev->dev, "failed to get AUX2 ADC channel\n");
> +		return PTR_ERR(ab8500_data->aux2);
> +	}
>   
> -	/*
> -	 * ADC_AUX1 and ADC_AUX2, connected to external NTC
> -	 * BTEMP_BALL and BAT_CTRL, fixed usage
> -	 */
> -	data->gpadc_addr[0] = ADC_AUX1;
> -	data->gpadc_addr[1] = ADC_AUX2;
> -	data->gpadc_addr[2] = BTEMP_BALL;
> -	data->gpadc_addr[3] = BAT_CTRL;
> +	data->gpadc_addr[0] = AB8500_SENSOR_AUX1;
> +	data->gpadc_addr[1] = AB8500_SENSOR_AUX2;
> +	data->gpadc_addr[2] = AB8500_SENSOR_BTEMP_BALL;
> +	data->gpadc_addr[3] = AB8500_SENSOR_BAT_CTRL;
>   	data->monitored_sensors = NUM_MONITORED_SENSORS;
>   
>   	data->ops.read_sensor = ab8500_read_sensor;
> 

