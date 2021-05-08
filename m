Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65E377289
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 17:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhEHPQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 11:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhEHPQt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 11:16:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0B2613F2;
        Sat,  8 May 2021 15:15:45 +0000 (UTC)
Date:   Sat, 8 May 2021 16:16:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
Message-ID: <20210508161643.5990ec15@jic23-huawei>
In-Reply-To: <20210503144350.7496-1-aardelean@deviqon.com>
References: <20210503144350.7496-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 May 2021 17:43:50 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> When the ioctl() mechanism was introduced in IIO core to centralize the
> registration of all ioctls in one place via commit 8dedcc3eee3ac ("iio:
> core: centralize ioctl() calls to the main chardev"), the return code was
> changed from ENODEV to EINVAL, when the ioctl code isn't known.
> 
> This was done by accident.
> 
> This change reverts back to the old behavior, where if the ioctl() code
> isn't known, ENODEV is returned (vs EINVAL).
> 
> This was brought into perspective by this patch:
>   https://lore.kernel.org/linux-iio/20210428150815.136150-1-paul@crapouillou.net/
> 
> Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

This is going to be a little messy to apply as lots of churn in that file.
What I've done for now is pulled the fixes-togreg branch forwards onto
current staging/staging-linus but I'll do that again after
staging/staging-linus moves onto an rc1 or similar base.

Anyhow, applied to that tree which is going to have more than it's
normal share of rebases this cycle.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index efb4cf91c9e4..9a3a83211a90 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1803,7 +1803,6 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	if (!indio_dev->info)
>  		goto out_unlock;
>  
> -	ret = -EINVAL;
>  	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
>  		ret = h->ioctl(indio_dev, filp, cmd, arg);
>  		if (ret != IIO_IOCTL_UNHANDLED)
> @@ -1811,7 +1810,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	}
>  
>  	if (ret == IIO_IOCTL_UNHANDLED)
> -		ret = -EINVAL;
> +		ret = -ENODEV;
>  
>  out_unlock:
>  	mutex_unlock(&iio_dev_opaque->info_exist_lock);

