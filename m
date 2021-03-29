Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B689F34D2D2
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhC2Ouz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 10:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231479AbhC2Oun (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 10:50:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A138F61932;
        Mon, 29 Mar 2021 14:50:40 +0000 (UTC)
Date:   Mon, 29 Mar 2021 15:50:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 05/10] platform/x86: toshiba_acpi: register backlight
 with device-managed variant
Message-ID: <20210329155046.125641ac@jic23-huawei>
In-Reply-To: <20210324125548.45983-6-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-6-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:43 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change converts the registration of the backlight data with the
> devm_backlight_device_register() function.
> This way, the backlight_device_unregister() call is no longer required, and
> the order of deregistration is made to be more symmetrical with the
> registration order.
> 

This one looks fine to me.

> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/platform/x86/toshiba_acpi.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 556f2cc99bad..ada2a2d8c913 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2876,7 +2876,8 @@ static int toshiba_acpi_setup_keyboard(struct device *parent,
>  	return error;
>  }
>  
> -static int toshiba_acpi_setup_backlight(struct toshiba_acpi_dev *dev)
> +static int toshiba_acpi_setup_backlight(struct device *parent,
> +					struct toshiba_acpi_dev *dev)
>  {
>  	struct backlight_properties props;
>  	int brightness;
> @@ -2924,11 +2925,12 @@ static int toshiba_acpi_setup_backlight(struct toshiba_acpi_dev *dev)
>  	if (dev->tr_backlight_supported)
>  		props.max_brightness++;
>  
> -	dev->backlight_dev = backlight_device_register("toshiba",
> -						       &dev->acpi_dev->dev,
> -						       dev,
> -						       &toshiba_backlight_data,
> -						       &props);
> +	dev->backlight_dev = devm_backlight_device_register(parent,
> +							    "toshiba",
> +							    &dev->acpi_dev->dev,
> +							    dev,
> +							    &toshiba_backlight_data,
> +							    &props);
>  	if (IS_ERR(dev->backlight_dev)) {
>  		ret = PTR_ERR(dev->backlight_dev);
>  		pr_err("Could not register toshiba backlight device\n");
> @@ -2999,8 +3001,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
>  				   &toshiba_attr_group);
>  
> -	backlight_device_unregister(dev->backlight_dev);
> -
>  	led_classdev_unregister(&dev->led_dev);
>  	led_classdev_unregister(&dev->kbd_led);
>  	led_classdev_unregister(&dev->eco_led);
> @@ -3104,9 +3104,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	ret = get_tr_backlight_status(dev, &dummy);
>  	dev->tr_backlight_supported = !ret;
>  
> -	ret = toshiba_acpi_setup_backlight(dev);
> +	ret = toshiba_acpi_setup_backlight(parent, dev);
>  	if (ret)
> -		goto error;
> +		return ret;
>  
>  	toshiba_illumination_available(dev);
>  	if (dev->illumination_supported) {

