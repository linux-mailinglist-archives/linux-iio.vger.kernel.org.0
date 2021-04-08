Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D457535843A
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhDHNKF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHNKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 09:10:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0638BC061761
        for <linux-iio@vger.kernel.org>; Thu,  8 Apr 2021 06:09:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f29so1368654pgm.8
        for <linux-iio@vger.kernel.org>; Thu, 08 Apr 2021 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hcl50LhJuH+uYrpvn/trW/t+kW0OQV+dOKCnzxMCwo=;
        b=mKCO3VdF7dA3/RDvkleD2pFHgR/1ZHue20azBhEW2w1Q1LrbUqwSSj1IOWWox5A+5q
         XaSyz0Okoczkrg2Z4cVru3XjIS7hJikY3ADmdk7f+bzRacm94x+R0eRGI3HU26/a3r55
         NRRs8Zyyk347dbGUWsuNf9g5wyKeJYVSx5NmXxShqrJy00VkFSXsVWwiyIrUgF1oWVLU
         xT5buqM2YOKwGum8CLdztKVuwAtm7Fvgh9PpOTWm444cc9RS9VC7oxmkFtAg3S/8WMpP
         YDiIMY0HWaONv8jtRTe+F8xECTSsrfFRc0RwukmRYQE8UWe25a+RKgVPWi3CX3ccZLhV
         NSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hcl50LhJuH+uYrpvn/trW/t+kW0OQV+dOKCnzxMCwo=;
        b=LCVjZlfBbhq5xyzSVZgGafkBZmzYGI802/fciiLl9VBUqXUVonUClvxOkk9UcoaN2j
         Drw8O6LTIpGj/R/LUGodp9gQD9mpj2bSb4MiCegbFrkRCTjrXI1XPn6Q4ecbC1Jr/Klz
         kY7NQSLrld2ya12nAvUtiERWQdbBGIb9U8iZtLOGznPXGfn9bP/kVvLLFRwFPlzv6LnJ
         vokI6QyvJXOFC3NjqR9mrhBFvIjTFKO4BoERIH8zl1cNh3KpwRAfpE4JznIDvBaTmqVL
         ZNiKiuTbh76ddb/scmLGJe/NxiDEnV2CcgGoMpXiI1krR8mNQDEJHvVinA6WzvBJt/af
         ENag==
X-Gm-Message-State: AOAM532IzituNH6c2GAvcXUGCObJPlWFUZqOzHeyhEI8f7vYHLgPRwjx
        WT/vGtLQ4cm/RCy/SepeZlauGybtqP4lfmsBZ+g=
X-Google-Smtp-Source: ABdhPJwNwFgWNs3E5S70GDBSf6rcKu9kBJHtxI0zfFAsCJ34CNqgp0UVrG8OwwpGLf8RYlhTq+uN5mvdg4GNR8OeHkw=
X-Received: by 2002:a05:6a00:7c5:b029:21d:2ea5:a684 with SMTP id
 n5-20020a056a0007c5b029021d2ea5a684mr7335977pfu.36.1617887393539; Thu, 08 Apr
 2021 06:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com> <1617881896-3164-6-git-send-email-yangyicong@hisilicon.com>
In-Reply-To: <1617881896-3164-6-git-send-email-yangyicong@hisilicon.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 8 Apr 2021 16:09:42 +0300
Message-ID: <CA+U=DspZCGVjFxB0YH7OAPBKhFAKz=a9Q=O7xW-Xu4BPZKC=pA@mail.gmail.com>
Subject: Re: [PATCH 5/7] iio: core: simplify some devm functions
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        prime.zeng@huawei.com, Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 8, 2021 at 2:41 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/iio/industrialio-core.c | 43 +++++++++++++++--------------------------
>  1 file changed, 16 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 7db761a..2dfbed3 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1627,9 +1627,9 @@ void iio_device_free(struct iio_dev *dev)
>  }
>  EXPORT_SYMBOL(iio_device_free);
>
> -static void devm_iio_device_release(struct device *dev, void *res)
> +static void devm_iio_device_release(void *iio_dev)
>  {
> -       iio_device_free(*(struct iio_dev **)res);
> +       iio_device_free(iio_dev);
>  }
>
>  /**
> @@ -1645,20 +1645,17 @@ static void devm_iio_device_release(struct device *dev, void *res)
>   */
>  struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv)
>  {
> -       struct iio_dev **ptr, *iio_dev;
> -
> -       ptr = devres_alloc(devm_iio_device_release, sizeof(*ptr),
> -                          GFP_KERNEL);
> -       if (!ptr)
> -               return NULL;
> +       struct iio_dev *iio_dev;
> +       int ret;
>
>         iio_dev = iio_device_alloc(parent, sizeof_priv);
> -       if (iio_dev) {
> -               *ptr = iio_dev;
> -               devres_add(parent, ptr);
> -       } else {
> -               devres_free(ptr);
> -       }
> +       if (!iio_dev)
> +               return iio_dev;

This is correct.
But the preference is usually:
        if (!iio_dev)
            return NULL;

> +
> +       ret = devm_add_action_or_reset(parent, devm_iio_device_release,
> +                                      iio_dev);
> +       if (ret)
> +               return ERR_PTR(ret);
>
>         return iio_dev;
>  }
> @@ -1889,29 +1886,21 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL(iio_device_unregister);
>
> -static void devm_iio_device_unreg(struct device *dev, void *res)
> +static void devm_iio_device_unreg(void *indio_dev)
>  {
> -       iio_device_unregister(*(struct iio_dev **)res);
> +       iio_device_unregister(indio_dev);
>  }
>
>  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>                                struct module *this_mod)
>  {
> -       struct iio_dev **ptr;
>         int ret;
>
> -       ptr = devres_alloc(devm_iio_device_unreg, sizeof(*ptr), GFP_KERNEL);
> -       if (!ptr)
> -               return -ENOMEM;
> -
> -       *ptr = indio_dev;
>         ret = __iio_device_register(indio_dev, this_mod);
> -       if (!ret)
> -               devres_add(dev, ptr);
> -       else
> -               devres_free(ptr);
> +       if (ret)
> +               return ret;
>
> -       return ret;
> +       return devm_add_action_or_reset(dev, devm_iio_device_unreg, indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>
> --
> 2.8.1
>
