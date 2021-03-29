Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1134D2E7
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhC2Oyj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 10:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231209AbhC2Oye (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 10:54:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE9A60C3D;
        Mon, 29 Mar 2021 14:54:31 +0000 (UTC)
Date:   Mon, 29 Mar 2021 15:54:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 07/10] platform/x86: toshiba_acpi: use device-managed
 functions for accelerometer
Message-ID: <20210329155437.65932679@jic23-huawei>
In-Reply-To: <20210324125548.45983-8-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-8-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:45 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change converts the IIO registration to use devm_iio_device_alloc()
> and devm_iio_device_register().
> With this change we can remove the manual deregistrations an freeing of the
> IIO data.
> 
> This also makes the deregistration symmetrical with the registration.
> 
> One side-effect (that is undesired), is that if devm_iio_device_register()
> fails, then the IIO object will not be free'd and will stick around until
> the parent object is free'd. This is because there is no
> devm_iio_device_free() function anymore in IIO.
> However, this is a pretty bad corner-case that should not happen under
> normal operation.

Hmm. The way this driver papers over failed elements is rather irritating,
though I'm sure there are reasons for it.  Indeed, I'd not worry about the
left over iio_dev structures
 
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/platform/x86/toshiba_acpi.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index e787c140eec2..12860ef60e4d 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2992,11 +2992,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  
>  	remove_toshiba_proc_entries(dev);
>  
> -	if (dev->accelerometer_supported && dev->indio_dev) {
> -		iio_device_unregister(dev->indio_dev);
> -		iio_device_free(dev->indio_dev);
> -	}
> -
>  	if (dev->sysfs_created)
>  		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
>  				   &toshiba_attr_group);
> @@ -3149,7 +3144,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  
>  	toshiba_accelerometer_available(dev);
>  	if (dev->accelerometer_supported) {
> -		dev->indio_dev = iio_device_alloc(&acpi_dev->dev, sizeof(*dev));
> +		dev->indio_dev = devm_iio_device_alloc(parent, sizeof(*dev));
>  		if (!dev->indio_dev) {
>  			pr_err("Unable to allocate iio device\n");
>  			goto iio_error;
> @@ -3164,10 +3159,10 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  		dev->indio_dev->num_channels =
>  					ARRAY_SIZE(toshiba_iio_accel_channels);
>  
> -		ret = iio_device_register(dev->indio_dev);
> +		ret = devm_iio_device_register(parent, dev->indio_dev);
>  		if (ret < 0) {
>  			pr_err("Unable to register iio device\n");
> -			iio_device_free(dev->indio_dev);
> +			dev->indio_dev = NULL;
>  		}
>  	}
>  iio_error:

