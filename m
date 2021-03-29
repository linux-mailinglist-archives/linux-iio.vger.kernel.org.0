Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8A34D271
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 16:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhC2OeW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 10:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhC2Odv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 10:33:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A7961922;
        Mon, 29 Mar 2021 14:33:48 +0000 (UTC)
Date:   Mon, 29 Mar 2021 15:33:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 03/10] platform/x86: toshiba_acpi: bind registration of
 miscdev object to parent
Message-ID: <20210329153356.1e817912@jic23-huawei>
In-Reply-To: <20210324125548.45983-4-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-4-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:41 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change moves the registration of the Toshiba ACPI miscdev to be
> handled by the devm_add_action_or_reset() hook. This way, the miscdev will
> be unregistered when the reference count of the parent device object goes
> to zero.
> 
> This also changes the order of cleanup in toshiba_acpi_remove(), where the
> miscdev was deregistered first. Now it will be deregistered right before
> the toshiba_acpi_dev object is free'd.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Reorder looks right to me, but maybe I'm missing something subtle.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One unrelated comment inline.

Jonathan

> ---
>  drivers/platform/x86/toshiba_acpi.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index c5284601bc2a..53ef565378ef 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2963,8 +2963,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  {
>  	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
>  
> -	misc_deregister(&dev->miscdev);
> -
>  	remove_toshiba_proc_entries(dev);
>  
>  	if (dev->accelerometer_supported && dev->indio_dev) {
> @@ -3014,6 +3012,13 @@ static void toshiba_acpi_singleton_clear(void *data)
>  	toshiba_acpi = NULL;
>  }
>  
> +static void toshiba_acpi_misc_deregister(void *data)
> +{
> +	struct miscdevice *miscdev = data;
> +
> +	misc_deregister(miscdev);
> +}
> +
>  static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  {
>  	struct device *parent = &acpi_dev->dev;
> @@ -3056,6 +3061,11 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(parent, toshiba_acpi_misc_deregister,
> +				       &dev->miscdev);
> +	if (ret)
> +		return ret;
> +
>  	acpi_dev->driver_data = dev;
>  	dev_set_drvdata(&acpi_dev->dev, dev);

Why are we carrying two copies of the same thing? (obviously unrelated
to your patch :)

>  

