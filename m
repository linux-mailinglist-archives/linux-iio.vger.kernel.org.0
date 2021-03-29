Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1047E34D357
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhC2PJg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 11:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhC2PJZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 11:09:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E956187E;
        Mon, 29 Mar 2021 15:09:21 +0000 (UTC)
Date:   Mon, 29 Mar 2021 16:09:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 09/10] platform/x86: toshiba_acpi: use device-managed
 for sysfs removal
Message-ID: <20210329160928.0f8d6b44@jic23-huawei>
In-Reply-To: <20210324125548.45983-10-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-10-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:47 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change moves the creation of the Toshiba ACPI group to be
> automatically removed when the parent refcount goes to zero.
> 
> The main reason to do this, is to also enforce that the order of removal is
> mirroring the order of initialization.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Hmm. The manual handling of the sysfs_create_group() is unfortunate (as opposed
to just setting a groups pointer) but there doesn't seem to be an easy way to fix
that with the current architecture.  Ah well

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/platform/x86/toshiba_acpi.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index a1249f6dde9a..8e8917979047 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -200,7 +200,6 @@ struct toshiba_acpi_dev {
>  	unsigned int usb_three_supported:1;
>  	unsigned int wwan_supported:1;
>  	unsigned int cooling_method_supported:1;
> -	unsigned int sysfs_created:1;
>  	unsigned int special_functions;
>  
>  	bool kbd_event_generated;
> @@ -3019,10 +3018,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  
>  	remove_toshiba_proc_entries(dev);
>  
> -	if (dev->sysfs_created)
> -		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
> -				   &toshiba_attr_group);
> -
>  	return 0;
>  }
>  
> @@ -3049,6 +3044,13 @@ static void toshiba_acpi_misc_deregister(void *data)
>  	misc_deregister(miscdev);
>  }
>  
> +static void toshiba_acpi_sysfs_remove(void *data)
> +{
> +	struct kobject *kobj = data;
> +
> +	sysfs_remove_group(kobj, &toshiba_attr_group);
> +}
> +
>  static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  {
>  	struct device *parent = &acpi_dev->dev;
> @@ -3219,21 +3221,20 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  
>  	ret = sysfs_create_group(&dev->acpi_dev->dev.kobj,
>  				 &toshiba_attr_group);
> -	if (ret) {
> -		dev->sysfs_created = 0;
> -		goto error;
> -	}
> -	dev->sysfs_created = !ret;
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(parent,
> +				       toshiba_acpi_sysfs_remove,
> +				       &dev->acpi_dev->dev.kobj);
> +	if (ret)
> +		return ret;
>  
>  	create_toshiba_proc_entries(dev);
>  
>  	toshiba_acpi = dev;
>  
>  	return 0;
> -
> -error:
> -	toshiba_acpi_remove(acpi_dev);
> -	return ret;
>  }
>  
>  static void toshiba_acpi_notify(struct acpi_device *acpi_dev, u32 event)

