Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B519F34D35E
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhC2PLM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 11:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhC2PKs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 11:10:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EBC61964;
        Mon, 29 Mar 2021 15:10:45 +0000 (UTC)
Date:   Mon, 29 Mar 2021 16:10:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 10/10] platform/x86: toshiba_acpi: bind proc entries
 creation to parent
Message-ID: <20210329161051.3bc500cf@jic23-huawei>
In-Reply-To: <20210324125548.45983-11-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-11-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:48 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change binds the creation of the proc entries to the parent object,
> via the devm_add_action_or_reset() call.
> This way when the parent object's refcount goes to zero, the proc entries
> are removed in the reverse other in which they were created.
> 
> This is the last bit of the toshiba_acpi_remove() function, so in this
> change this function is removed.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm not 100% sure the series is worth the effort, but it does clean up
some of the ordering which definitely looks like a plus point.

Jonathan

> ---
>  drivers/platform/x86/toshiba_acpi.c | 45 ++++++++++++++---------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 8e8917979047..56ee5cd1e90c 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -1671,7 +1671,23 @@ static int __maybe_unused version_proc_show(struct seq_file *m, void *v)
>  
>  #define PROC_TOSHIBA		"toshiba"
>  
> -static void create_toshiba_proc_entries(struct toshiba_acpi_dev *dev)
> +static void remove_toshiba_proc_entries(void *data)
> +{
> +	struct toshiba_acpi_dev *dev = data;
> +
> +	if (dev->backlight_dev)
> +		remove_proc_entry("lcd", toshiba_proc_dir);
> +	if (dev->video_supported)
> +		remove_proc_entry("video", toshiba_proc_dir);
> +	if (dev->fan_supported)
> +		remove_proc_entry("fan", toshiba_proc_dir);
> +	if (dev->hotkey_dev)
> +		remove_proc_entry("keys", toshiba_proc_dir);
> +	remove_proc_entry("version", toshiba_proc_dir);
> +}
> +
> +static int create_toshiba_proc_entries(struct device *parent,
> +				       struct toshiba_acpi_dev *dev)
>  {
>  	if (dev->backlight_dev)
>  		proc_create_data("lcd", S_IRUGO | S_IWUSR, toshiba_proc_dir,
> @@ -1687,19 +1703,8 @@ static void create_toshiba_proc_entries(struct toshiba_acpi_dev *dev)
>  				 &keys_proc_ops, dev);
>  	proc_create_single_data("version", S_IRUGO, toshiba_proc_dir,
>  			version_proc_show, dev);
> -}
>  
> -static void remove_toshiba_proc_entries(struct toshiba_acpi_dev *dev)
> -{
> -	if (dev->backlight_dev)
> -		remove_proc_entry("lcd", toshiba_proc_dir);
> -	if (dev->video_supported)
> -		remove_proc_entry("video", toshiba_proc_dir);
> -	if (dev->fan_supported)
> -		remove_proc_entry("fan", toshiba_proc_dir);
> -	if (dev->hotkey_dev)
> -		remove_proc_entry("keys", toshiba_proc_dir);
> -	remove_proc_entry("version", toshiba_proc_dir);
> +	return devm_add_action_or_reset(parent, remove_toshiba_proc_entries, dev);
>  }
>  
>  static const struct backlight_ops toshiba_backlight_data = {
> @@ -3012,15 +3017,6 @@ static void print_supported_features(struct toshiba_acpi_dev *dev)
>  	pr_cont("\n");
>  }
>  
> -static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
> -{
> -	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
> -
> -	remove_toshiba_proc_entries(dev);
> -
> -	return 0;
> -}
> -
>  static const char *find_hci_method(acpi_handle handle)
>  {
>  	if (acpi_has_method(handle, "GHCI"))
> @@ -3230,7 +3226,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	if (ret)
>  		return ret;
>  
> -	create_toshiba_proc_entries(dev);
> +	ret = create_toshiba_proc_entries(parent, dev);
> +	if (ret)
> +		return ret;
>  
>  	toshiba_acpi = dev;
>  
> @@ -3340,7 +3338,6 @@ static struct acpi_driver toshiba_acpi_driver = {
>  	.flags	= ACPI_DRIVER_ALL_NOTIFY_EVENTS,
>  	.ops	= {
>  		.add		= toshiba_acpi_add,
> -		.remove		= toshiba_acpi_remove,
>  		.notify		= toshiba_acpi_notify,
>  	},
>  	.drv.pm	= &toshiba_acpi_pm,

