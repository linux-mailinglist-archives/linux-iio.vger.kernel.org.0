Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D04434D265
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhC2ObJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 10:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhC2Oan (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 10:30:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C29EB61933;
        Mon, 29 Mar 2021 14:30:39 +0000 (UTC)
Date:   Mon, 29 Mar 2021 15:30:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 01/10] platform/x86: toshiba_acpi: bind life-time of
 toshiba_acpi_dev to parent
Message-ID: <20210329153047.57904ab4@jic23-huawei>
In-Reply-To: <20210324125548.45983-2-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-2-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:39 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> The 'toshiba_acpi_dev' object is allocated first and free'd last. We can
> bind it's life-time to the parent ACPI device object. This is a first step
> in using more device-managed allocated functions for this.
> 
> The main intent is to try to convert the IIO framework to export only
> device-managed functions (i.e. devm_iio_device_alloc() and
> devm_iio_device_register()). It's still not 100% sure that this is
> possible, but for now, this is the process of taking it slowly in that
> direction.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Might just be me, but naming anything dev that isn't a struct device *
is downright confusing?




> ---
>  drivers/platform/x86/toshiba_acpi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index fa7232ad8c39..6d298810b7bf 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2998,8 +2998,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  	if (toshiba_acpi)
>  		toshiba_acpi = NULL;
>  
> -	kfree(dev);
> -
>  	return 0;
>  }
>  
> @@ -3016,6 +3014,7 @@ static const char *find_hci_method(acpi_handle handle)
>  
>  static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  {
> +	struct device *parent = &acpi_dev->dev;
>  	struct toshiba_acpi_dev *dev;
>  	const char *hci_method;
>  	u32 dummy;
> @@ -3033,7 +3032,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  		return -ENODEV;
>  	}
>  
> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	dev = devm_kzalloc(parent, sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
>  		return -ENOMEM;
>  	dev->acpi_dev = acpi_dev;
> @@ -3045,7 +3044,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	ret = misc_register(&dev->miscdev);
>  	if (ret) {
>  		pr_err("Failed to register miscdevice\n");
> -		kfree(dev);
>  		return ret;
>  	}
>  

