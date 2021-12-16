Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662A647706C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 12:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhLPLjS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 06:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhLPLjR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 06:39:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62723C061574
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 03:39:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29DDEB8239D
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 11:39:16 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id E06D6C36AE4;
        Thu, 16 Dec 2021 11:39:13 +0000 (UTC)
Date:   Thu, 16 Dec 2021 11:44:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: iio_device_alloc(): Remove unnecessary self
 drvdata
Message-ID: <20211216114438.06507006@jic23-huawei>
In-Reply-To: <20211205125052.58030-1-lars@metafoo.de>
References: <20211205125052.58030-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 Dec 2021 13:50:52 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Drvdata is typically used by drivers to attach driver specific data to a
> device. It is used to retrieve driver specific information when only the
> device to which the data is attached is available.
> 
> In the IIO core in the `iio_device_alloc()` function we call
> `iio_device_set_drvdata(indio_dev, indio_dev)`. This sets the drvdata of
> the IIO device to itself.
> 
> This is rather unnecessary since if we have a pointer to the IIO device to
> call `iio_device_get_drvdata()` on it we don't need to call the function
> since we already have the pointer. If we only have a pointer to the `struct
> device` we can use `dev_to_iio_dev()` to get the IIO device from it.
> 
> Furthermore the drvdata is supposed to be reserved for drivers, so it
> should not be used by the IIO core in the first place.
> 
> The `set_drvdata()` has been around from the very beginning of the IIO
> framework and back then it was used in the IIO device sysfs attribute
> handling code. But that was subsequently replaced with a `dev_to_iio_dev()`
> in commit e53f5ac52ec1 ("iio: Use dev_to_iio_dev()") and other cleanups.
> 
> The self `set_drvdata()` is now no longer needed and can be removed.
> 
> Verified that there no longer any users by checking for potential users
> using the following two coccinelle scripts and reviewing that none of the
> matches are problematic code.
> 
> <smpl>
> @@
> struct iio_dev *iio_dev;
> expression dev;
> identifier fn !~ "(remove|resume|suspend)";
> @@
> fn(...)
> {
> ...
> *iio_dev = dev_get_drvdata(dev)
> ...
> }
> </smpl>
> 
> <smpl>
> @r1@
> position p;
> struct iio_dev *indio_dev;
> identifier dev_fn =~ "^dev_";
> identifier devm_fn =~ "^devm_";
> @@
> (
>  dev_fn
> |
>  devm_fn
> )
>  (&indio_dev@p->dev, ...)
> 
> @@
> struct iio_dev *indio_dev;
> position p != r1.p;
> @@
> *&indio_dev@p->dev</smpl>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke it.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 20d5178ca073..409c278a4c2c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1656,7 +1656,6 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  	indio_dev->dev.type = &iio_device_type;
>  	indio_dev->dev.bus = &iio_bus_type;
>  	device_initialize(&indio_dev->dev);
> -	iio_device_set_drvdata(indio_dev, (void *)indio_dev);
>  	mutex_init(&indio_dev->mlock);
>  	mutex_init(&iio_dev_opaque->info_exist_lock);
>  	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);

