Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F306734D25D
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhC2O14 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 10:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhC2O1x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 10:27:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631CF6195B;
        Mon, 29 Mar 2021 14:27:50 +0000 (UTC)
Date:   Mon, 29 Mar 2021 15:27:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 02/10] platform/x86: toshiba_acpi: use
 devm_add_action_or_reset() for singleton clear
Message-ID: <20210329152756.2e698014@jic23-huawei>
In-Reply-To: <20210324125548.45983-3-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-3-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:40 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> The only reason to do this is to enforce the ordering of deinitialization,
> when the conversion of the device-managed functions is done.
> 
> The singleton object should be cleared right before it is free'd.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Whilst this might help get towards your goal, I'm curious to why
this singleton actually needs to exist in the first place.

It doesn't feel like it would be very hard to remove.
1) embed the kbd_bl_work in struct toshiba_acpi_dev with appropriate changes to it's init.
   use container_of() magic to get to that. 
2) For the toshiba_iio_accel_read_raw() stash a copy of the pointer in iio_priv(indio_dev)
   Note that I'm very suspicious of existing sizeing of the private region. 
3) For miscdevice handling you should be able to use container_of() to get to the
   toshiba_acpi_dev structure from file->private_data

There are a few places where the struct toshiba_acpi_dev will need passing into functions
that currently get it from the global, plus one place where I'm fairly sure an element
of that structure gets set twice in a row via different copies of the pointer.

Also nice to not use dev as the name for struct toshiba_acpi_dev * as that is
makes for some confusing code when we have a bunch of struct device * in use
as well.

So this is fine, but kind of feels like the code shouldn't be there in the first place!

Jonathan

> ---
>  drivers/platform/x86/toshiba_acpi.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 6d298810b7bf..c5284601bc2a 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2995,9 +2995,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  		rfkill_destroy(dev->wwan_rfk);
>  	}
>  
> -	if (toshiba_acpi)
> -		toshiba_acpi = NULL;
> -
>  	return 0;
>  }
>  
> @@ -3012,6 +3009,11 @@ static const char *find_hci_method(acpi_handle handle)
>  	return NULL;
>  }
>  
> +static void toshiba_acpi_singleton_clear(void *data)
> +{
> +	toshiba_acpi = NULL;
> +}
> +
>  static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  {
>  	struct device *parent = &acpi_dev->dev;
> @@ -3035,6 +3037,13 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	dev = devm_kzalloc(parent, sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
>  		return -ENOMEM;
> +
> +	ret = devm_add_action_or_reset(parent,
> +				       toshiba_acpi_singleton_clear,
> +				       NULL);
> +	if (ret)
> +		return ret;
> +
>  	dev->acpi_dev = acpi_dev;
>  	dev->method_hci = hci_method;
>  	dev->miscdev.minor = MISC_DYNAMIC_MINOR;

