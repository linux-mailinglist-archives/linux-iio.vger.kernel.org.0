Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B192BC118
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 18:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgKURdf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 12:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbgKURdf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 12:33:35 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7B4221FC;
        Sat, 21 Nov 2020 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605980014;
        bh=LU5zxVHmcNwqc3zeelUfrSz7RLmz5VLKXsOofsxAqWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dpDMMZJlwBowguTkYMIfZ/Rxdy9Iwskb4j49CZfsZKk58je9+T7QyIeCWgtiGc2Gu
         w3N+aXWlnkD2EMlHgdFS/W+10HgNPKR4CeQTX1UzL64aM2/XL415OzF1jq8PRCq8Xl
         8/n7GbRuTFZ1Omvvyz6wxx9Iwd6Cyqf9uxNZmiuw=
Date:   Sat, 21 Nov 2020 17:33:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: hid-sensor-trigger: Use iio->trig instead
 trig field internal structure
Message-ID: <20201121173330.3afd1087@archlinux>
In-Reply-To: <20201119100331.2594-4-xiang.ye@intel.com>
References: <20201119100331.2594-1-xiang.ye@intel.com>
        <20201119100331.2594-4-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Nov 2020 18:03:30 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Use iio->trig instead of attrb->trig as parameter of iio_trigger_unregister
> and iio_trigger_free. This allows one HID sensor driver to create
> multiple iio devices. In this case common attributes are shared and
> there can be one instance for the structure containing common attributes
> for all iio devices.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
Whilst indio_dev->trig is set to the local trigger at startup,
I'm not seeing the validate callbacks that will be needed to ensure it 
is still set to that trigger when you remove the driver.

Specifically validate_trigger callback for all the hid sensor devices.

It is entirely possible that should be set and these devices can only
use the hid sensor trigger, but I don't think it currently is.

Thus this patch is going to cause some interesting crashes.
Note this is the reason all IIO drivers have to carry an extra copy
of the trig pointer.

So you'll have to do something a bit more interesting to pass that
trigger to the relevant devices that share it.

Arguably if they are actually sharing the trigger, then we shouldn't really
have separate IIO devices in the first place as we loose the
connection between the timing of the data across the different channels.

Jonathan

> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 30340abcbc8d..bb5e7c8ff15b 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -236,8 +236,8 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>  	pm_runtime_put_noidle(&attrb->pdev->dev);
>  
>  	cancel_work_sync(&attrb->work);
> -	iio_trigger_unregister(attrb->trigger);
> -	iio_trigger_free(attrb->trigger);
> +	iio_trigger_unregister(indio_dev->trig);
> +	iio_trigger_free(indio_dev->trig);

>  	iio_triggered_buffer_cleanup(indio_dev);
>  }
>  EXPORT_SYMBOL(hid_sensor_remove_trigger);

