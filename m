Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAF23727C6
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhEDJGA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 4 May 2021 05:06:00 -0400
Received: from aposti.net ([89.234.176.197]:34686 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhEDJFy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 May 2021 05:05:54 -0400
Date:   Tue, 04 May 2021 10:04:24 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de,
        Linus Walleij <linus.walleij@linaro.org>,
        Nuno Sa <nuno.sa@analog.com>
Message-Id: <CVRKSQ.S9TXIAZ9W6262@crapouillou.net>
In-Reply-To: <20210503144350.7496-1-aardelean@deviqon.com>
References: <20210503144350.7496-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le lun., mai 3 2021 at 17:43:50 +0300, Alexandru Ardelean 
<aardelean@deviqon.com> a écrit :
> When the ioctl() mechanism was introduced in IIO core to centralize 
> the
> registration of all ioctls in one place via commit 8dedcc3eee3ac 
> ("iio:
> core: centralize ioctl() calls to the main chardev"), the return code 
> was
> changed from ENODEV to EINVAL, when the ioctl code isn't known.
> 
> This was done by accident.
> 
> This change reverts back to the old behavior, where if the ioctl() 
> code
> isn't known, ENODEV is returned (vs EINVAL).
> 
> This was brought into perspective by this patch:
>   
> https://lore.kernel.org/linux-iio/20210428150815.136150-1-paul@crapouillou.net/
> 
> Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the 
> main chardev")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Tested-by: Paul Cercueil <paul@crapouillou.net>

Thanks!
-Paul

> ---
>  drivers/iio/industrialio-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c 
> b/drivers/iio/industrialio-core.c
> index efb4cf91c9e4..9a3a83211a90 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1803,7 +1803,6 @@ static long iio_ioctl(struct file *filp, 
> unsigned int cmd, unsigned long arg)
>  	if (!indio_dev->info)
>  		goto out_unlock;
> 
> -	ret = -EINVAL;
>  	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
>  		ret = h->ioctl(indio_dev, filp, cmd, arg);
>  		if (ret != IIO_IOCTL_UNHANDLED)
> @@ -1811,7 +1810,7 @@ static long iio_ioctl(struct file *filp, 
> unsigned int cmd, unsigned long arg)
>  	}
> 
>  	if (ret == IIO_IOCTL_UNHANDLED)
> -		ret = -EINVAL;
> +		ret = -ENODEV;
> 
>  out_unlock:
>  	mutex_unlock(&iio_dev_opaque->info_exist_lock);
> --
> 2.31.1
> 


