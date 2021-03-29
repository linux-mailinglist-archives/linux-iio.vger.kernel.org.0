Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4544434D2EF
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 16:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC2O5V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 10:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhC2O5K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 10:57:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68CAF60C3D;
        Mon, 29 Mar 2021 14:57:07 +0000 (UTC)
Date:   Mon, 29 Mar 2021 15:57:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Subject: Re: [PATCH 08/10] platform/x86: toshiba_acpi: use device-managed
 for wwan_rfkill management
Message-ID: <20210329155713.3c19c0d1@jic23-huawei>
In-Reply-To: <20210324125548.45983-9-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
        <20210324125548.45983-9-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 14:55:46 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change converts the wwan_rfkill object to be free'd automatically when
> the parent refcount goes to zero.
> There are 2 cleanup operations required: rfkill_unregister() and
> rfkill_destroy(). Since they don't have any devm_ variants, they are hooked
> via devm_add_action_or_reset().
> 
> The main reason to do this is to enforce ordering on cleanup, when the
> Toshiba ACPI device is cleaned up.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Superficially looks fine to me though I don't know much about rfkill.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/platform/x86/toshiba_acpi.c | 40 ++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 12860ef60e4d..a1249f6dde9a 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2591,7 +2591,22 @@ static const struct rfkill_ops wwan_rfk_ops = {
>  	.poll = toshiba_acpi_wwan_poll,
>  };
>  
> -static int toshiba_acpi_setup_wwan_rfkill(struct toshiba_acpi_dev *dev)
> +static void toshiba_acpi_rfkill_destroy(void *data)
> +{
> +	struct rfkill *wwan_rfk = data;
> +
> +	rfkill_destroy(wwan_rfk);
> +}
> +
> +static void toshiba_acpi_rfkill_unreg(void *data)
> +{
> +	struct rfkill *wwan_rfk = data;
> +
> +	rfkill_unregister(wwan_rfk);
> +}
> +
> +static int toshiba_acpi_setup_wwan_rfkill(struct device *parent,
> +					  struct toshiba_acpi_dev *dev)
>  {
>  	int ret = toshiba_wireless_status(dev);
>  
> @@ -2608,15 +2623,27 @@ static int toshiba_acpi_setup_wwan_rfkill(struct toshiba_acpi_dev *dev)
>  		return -ENOMEM;
>  	}
>  
> +	ret = devm_add_action_or_reset(parent, toshiba_acpi_rfkill_destroy,
> +				       dev->wwan_rfk);
> +	if (ret)
> +		return ret;
> +
>  	rfkill_set_hw_state(dev->wwan_rfk, !dev->killswitch);
>  
>  	ret = rfkill_register(dev->wwan_rfk);
>  	if (ret) {
>  		pr_err("Unable to register WWAN rfkill device\n");
> -		rfkill_destroy(dev->wwan_rfk);
> +		return ret;
>  	}
>  
> -	return ret;
> +	ret = devm_add_action_or_reset(parent, toshiba_acpi_rfkill_unreg,
> +				       dev->wwan_rfk);
> +	if (ret) {
> +		dev->wwan_rfk = NULL;
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  /*
> @@ -2996,11 +3023,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
>  		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
>  				   &toshiba_attr_group);
>  
> -	if (dev->wwan_rfk) {
> -		rfkill_unregister(dev->wwan_rfk);
> -		rfkill_destroy(dev->wwan_rfk);
> -	}
> -
>  	return 0;
>  }
>  
> @@ -3189,7 +3211,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  
>  	toshiba_wwan_available(dev);
>  	if (dev->wwan_supported)
> -		toshiba_acpi_setup_wwan_rfkill(dev);
> +		toshiba_acpi_setup_wwan_rfkill(parent, dev);
>  
>  	toshiba_cooling_method_available(dev);
>  

