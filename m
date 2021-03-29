Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D005934D2DB
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhC2Ov7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 10:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhC2Ov6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 10:51:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14ED76192C;
        Mon, 29 Mar 2021 14:51:54 +0000 (UTC)
Date:   Mon, 29 Mar 2021 15:52:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 06/10] platform/x86: toshiba_acpi: use
 devm_led_classdev_register() for LEDs
Message-ID: <20210329155201.24e59897@jic23-huawei>
In-Reply-To: <20210324125548.45983-7-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-7-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:44 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> With this change the deregistration of the LED objects is made symmetrical
> (and in reverse) with the registration. We also can get rid of the calls
> to led_classdev_unregister(), because the LED objects will be cleaned up
> when the reference to the parent device object goes to zero.
> 
> This change also unifies the reference to the parent object from
> '&acpi_dev->dev' and '&dev->acpi_dev->dev' to 'parent', since it's the same
> reference, and makes the code-lines a bit shorter.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/platform/x86/toshiba_acpi.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index ada2a2d8c913..e787c140eec2 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -3001,10 +3001,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
>  				   &toshiba_attr_group);
>  
> -	led_classdev_unregister(&dev->led_dev);
> -	led_classdev_unregister(&dev->kbd_led);
> -	led_classdev_unregister(&dev->eco_led);
> -
>  	if (dev->wwan_rfk) {
>  		rfkill_unregister(dev->wwan_rfk);
>  		rfkill_destroy(dev->wwan_rfk);
> @@ -3114,7 +3110,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  		dev->led_dev.max_brightness = 1;
>  		dev->led_dev.brightness_set = toshiba_illumination_set;
>  		dev->led_dev.brightness_get = toshiba_illumination_get;
> -		led_classdev_register(&acpi_dev->dev, &dev->led_dev);
> +		ret = devm_led_classdev_register(parent, &dev->led_dev);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	toshiba_eco_mode_available(dev);
> @@ -3123,7 +3121,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  		dev->eco_led.max_brightness = 1;
>  		dev->eco_led.brightness_set = toshiba_eco_mode_set_status;
>  		dev->eco_led.brightness_get = toshiba_eco_mode_get_status;
> -		led_classdev_register(&dev->acpi_dev->dev, &dev->eco_led);
> +		ret = devm_led_classdev_register(parent, &dev->eco_led);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	toshiba_kbd_illum_available(dev);
> @@ -3139,7 +3139,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  		dev->kbd_led.max_brightness = 1;
>  		dev->kbd_led.brightness_set = toshiba_kbd_backlight_set;
>  		dev->kbd_led.brightness_get = toshiba_kbd_backlight_get;
> -		led_classdev_register(&dev->acpi_dev->dev, &dev->kbd_led);
> +		ret = devm_led_classdev_register(parent, &dev->kbd_led);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	ret = toshiba_touchpad_get(dev, &dummy);

