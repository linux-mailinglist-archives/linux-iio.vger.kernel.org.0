Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB38543E332
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhJ1OOJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhJ1OOI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:14:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60274610CA;
        Thu, 28 Oct 2021 14:11:40 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:16:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: trigger: Fix reference counting
Message-ID: <20211028151607.7ccb0b6c@jic23-huawei>
In-Reply-To: <20211024092700.6844-2-lars@metafoo.de>
References: <20211024092700.6844-1-lars@metafoo.de>
        <20211024092700.6844-2-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Oct 2021 11:27:00 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> In viio_trigger_alloc() device_initialize() is used to set the initial
> reference count of the trigger to 1. Then another get_device() is called on
> trigger. This sets the reference count to 2 before the trigger is returned.
> 
> iio_trigger_free(), which is the matching API to viio_trigger_alloc(),
> calls put_device() which decreases the reference count by 1. But the second
> reference count acquired in viio_trigger_alloc() is never dropped.
> 
> As a result the iio_trigger_release() function is never called and the
> memory associated with the trigger is never freed.
> 
> Since there is no reason for the trigger to start its lifetime with two
> reference counts just remove the extra get_device() in
> viio_trigger_alloc().
> 
> Fixes: 5f9c035cae18 ("staging:iio:triggers. Add a reference get to the core for triggers.")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

I fully agree the current code is wrong, but we really should be using
device_put() in the error path after device_initialize() has been called.

There are multiple places where we currently do this wrong in IIO but this particular
one looks like a local fix would be safe.
Worth doing that in the same patch at this one given it's all about reference
counting logic being wrong?  If not, we can do it as a separate follow up patch.

Jonathan


> ---
> I'm a bit unsure about the fixes tag. I've looked at the IIO tree at the
> point when this was introduced and I believe it was incorrect even back
> then.
> 
> But we also had a few drivers that directly assigned the indio_dev->trig
> without getting an extra reference. So these two bugs, one in the core, one
> in the drivers sort of even out. Except that iio_trigger_get() also gets a
> reference to the drivers module and iio_trigger_put() releases it again. So
> with the missing iio_trigger_get() there is still the problem that, even
> though the device references balance out, there is a module reference count
> imbalance.
> ---
>  drivers/iio/industrialio-trigger.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index b23caa2f2aa1..93990ff1dfe3 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -556,7 +556,6 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  		irq_modify_status(trig->subirq_base + i,
>  				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
>  	}
> -	get_device(&trig->dev);
>  
>  	return trig;
>  

