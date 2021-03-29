Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3490134D2B7
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhC2Osq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 10:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhC2OsV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 10:48:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBCB661864;
        Mon, 29 Mar 2021 14:48:17 +0000 (UTC)
Date:   Mon, 29 Mar 2021 15:48:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 04/10] platform/x86: toshiba_acpi: use device-managed
 functions for input device
Message-ID: <20210329154822.7ef8ee88@jic23-huawei>
In-Reply-To: <20210324125548.45983-5-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-5-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:42 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change uses device managed functions to handle the deregistration of
> the keyboard resources when the refcount of the parent device goes to zero.
> 
> For the input device devm_input_allocate_device() must be used, and after
> that it will be bound also for auto-deregistration when
> input_device_register() is called.
> 
> The work object is registered for uninit with devm_add_action(), which will
> be called on device unregister only.
> 
> The i8042 filter is registered with devm_add_action() as well, but it is
> done last in the toshiba_acpi_setup_keyboard() function. This is a little
> quirky, because this relies on the fact that there can a single
> toshiba_acpi_dev object.

I think this is the wrong approach here.  Given function can fail
without probe() returning an error, go up one level and treat this whole
function as something to be device managed.  That way you can register
the unwind function only if the call in probe succeeds.

Jonathan


> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>  drivers/platform/x86/toshiba_acpi.c | 55 +++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 53ef565378ef..556f2cc99bad 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -186,7 +186,6 @@ struct toshiba_acpi_dev {
>  	unsigned int video_supported:1;
>  	unsigned int fan_supported:1;
>  	unsigned int system_event_supported:1;
> -	unsigned int ntfy_supported:1;
>  	unsigned int info_supported:1;
>  	unsigned int tr_backlight_supported:1;
>  	unsigned int kbd_illum_supported:1;
> @@ -2756,9 +2755,23 @@ static void toshiba_acpi_process_hotkeys(struct toshiba_acpi_dev *dev)
>  	}
>  }
>  
> -static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
> +static void toshiba_acpi_cancel_hotkey_work(void *data)
> +{
> +	struct work_struct *hotkey_work = data;
> +
> +	cancel_work_sync(hotkey_work);
> +}
> +
> +static void toshiba_acpi_i8042_remove_filter(void *data)
> +{
> +	i8042_remove_filter(toshiba_acpi_i8042_filter);
> +}
> +
> +static int toshiba_acpi_setup_keyboard(struct device *parent,
> +				       struct toshiba_acpi_dev *dev)
>  {
>  	const struct key_entry *keymap = toshiba_acpi_keymap;
> +	bool ntfy_supported = false;
>  	acpi_handle ec_handle;
>  	int error;
>  
> @@ -2779,7 +2792,7 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
>  	if (toshiba_hotkey_event_type_get(dev, &dev->hotkey_event_type))
>  		pr_notice("Unable to query Hotkey Event Type\n");
>  
> -	dev->hotkey_dev = input_allocate_device();
> +	dev->hotkey_dev = devm_input_allocate_device(parent);

Hmm. Doing this within a function that can fail without resulting in driver probe failure
is rather messy.  I think you should call a manual free so this isn't left around until
driver remove.

Or decide this function is too complex and do the devm_ management one layer out using
a devm_add_action_or_reset(dev, toshiba_acpi_unsetup_keyboard, *) or similar to do
it in one go.  That would only be registered if this function succeeded in the first place.

>  	if (!dev->hotkey_dev)
>  		return -ENOMEM;
>  
> @@ -2798,7 +2811,7 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
>  			dev->hotkey_event_type);
>  	error = sparse_keymap_setup(dev->hotkey_dev, keymap, NULL);
>  	if (error)
> -		goto err_free_dev;
> +		goto err_null_dev;
>  
>  	/*
>  	 * For some machines the SCI responsible for providing hotkey
> @@ -2811,13 +2824,19 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
>  	if (ec_handle && acpi_has_method(ec_handle, "NTFY")) {
>  		INIT_WORK(&dev->hotkey_work, toshiba_acpi_hotkey_work);
>  
> +		error = devm_add_action(parent,
> +					toshiba_acpi_cancel_hotkey_work,
> +					&dev->hotkey_work);
> +		if (error)
> +			return error;
> +
>  		error = i8042_install_filter(toshiba_acpi_i8042_filter);
>  		if (error) {
>  			pr_err("Error installing key filter\n");
> -			goto err_free_dev;
> +			return error;

Does this not want to do goto err_null_dev?
Same with the one above.

>  		}
>  
> -		dev->ntfy_supported = 1;
> +		ntfy_supported = true;
>  	}
>  
>  	/*
> @@ -2840,13 +2859,19 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
>  		goto err_remove_filter;
>  	}
>  
> +	if (ntfy_supported) {
> +		error = devm_add_action(parent,
> +					toshiba_acpi_i8042_remove_filter,
> +					NULL);


> +		goto err_remove_filter;
> +	}
> +
>  	return 0;
>  
> - err_remove_filter:
> -	if (dev->ntfy_supported)
> +err_remove_filter:
> +	if (ntfy_supported)
>  		i8042_remove_filter(toshiba_acpi_i8042_filter);
> - err_free_dev:
> -	input_free_device(dev->hotkey_dev);
> +err_null_dev:
>  	dev->hotkey_dev = NULL;

How about, having  a local hotkey_dev variable and only setting
it in the good path just before returning?  That way we can return
directly above and have a cleaner flow.

>  	return error;
>  }
> @@ -2974,14 +2999,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
>  				   &toshiba_attr_group);
>  
> -	if (dev->ntfy_supported) {
> -		i8042_remove_filter(toshiba_acpi_i8042_filter);
> -		cancel_work_sync(&dev->hotkey_work);
> -	}
> -
> -	if (dev->hotkey_dev)
> -		input_unregister_device(dev->hotkey_dev);
> -
>  	backlight_device_unregister(dev->backlight_dev);
>  
>  	led_classdev_unregister(&dev->led_dev);
> @@ -3080,7 +3097,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	dev->kbd_function_keys_supported = !ret;
>  
>  	dev->hotkey_event_type = 0;
> -	if (toshiba_acpi_setup_keyboard(dev))
> +	if (toshiba_acpi_setup_keyboard(parent, dev))
>  		pr_info("Unable to activate hotkeys\n");
>  
>  	/* Determine whether or not BIOS supports transflective backlight */

