Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B862726FD72
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgIRMsS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 08:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgIRMsS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 08:48:18 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A40C061352
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 05:48:14 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x69so6831186oia.8
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtbYc0k6fTskL2rn/K1Jdz08H16PlGk3d/fS1ZDz394=;
        b=rlGL3Dun+UXoZ4Y+kO0+i33HjJ00VV71frbRHm/dbGztS8BxUKumtTk6oSrZpy1l3D
         rMJObSWZX/rJFU9BWbjdoResdH82rlqqVtYgplfTTsAZu16YqHhKunEy/eaobmiRBaYC
         Qc0qWh8LGqtkYasg0f+6zDVYKOcDrHD9b05e63/eVNp27mm/WRSGKee8dxNbJS06wjwX
         JT2607XeLNEMbuTEy/WU3F+9tPOuu8nNuA4fFZ2B1hzOF88U96Tz85aZKT5IL43vpo4L
         o6T7ESq37FDo137MQWJVKWNhW1XzBWBf4wjT8MeMkWusT2fy0O1DUhi2s5L/vcGCwxV/
         3sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtbYc0k6fTskL2rn/K1Jdz08H16PlGk3d/fS1ZDz394=;
        b=uMKZJ3OIlASTmMsDM0arI/+57l1zx/VFxKB/vEtkD5aMsT0h8Au/j23UrhlPIAGmQZ
         w7Ttn37uR4oPBLOhTqcKU6ghbqGlmCQWuU8Blk4fB+6XVVuwMome4FXoq32hcbsIM/g4
         Mt0d4npP5ZpRiYAsVWU2oYKZLTL0fp2qbrLWymbdPlSmTP6EaBr/04i6YMhDSGDSz62B
         ORc7X2iMQY0I9XTGkjE53HsetXfyhqg2/9IDeNdvOcN3IqJy/rhE+zFXBsvg2J0YUHQA
         23TVfXyjT9uFH8hvN4zXAtVb03aMgLzi9a04PmUaYSUkuMrpS70GEEwxbATVuvqh/e/v
         2azg==
X-Gm-Message-State: AOAM530GX8mEI4FR8CoY4ekygoaG7Lzb/wh0549ITBYR4+ISjU81pqSe
        1LofnwpzvcZK+lyaz3J+Pp6UCz3wv1x2xwa7wXU=
X-Google-Smtp-Source: ABdhPJzadUbaiw0qyg4F3RJ79/jfnPF0wdR0V/W9DUzYGC/y7+PaMpbxbCz+vkWWaC0S9WTDTIlcMjitApU4kGtQPsI=
X-Received: by 2002:a05:6808:56f:: with SMTP id j15mr9417589oig.140.1600433293285;
 Fri, 18 Sep 2020 05:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200913132115.800131-1-jic23@kernel.org> <20200913132115.800131-4-jic23@kernel.org>
In-Reply-To: <20200913132115.800131-4-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 18 Sep 2020 15:48:02 +0300
Message-ID: <CA+U=Dsq1p00bS=dr2jjPTQZ-sbubp79oeGoB8FgzYx_Ccnc2yQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio:core: Tidy up kernel-doc.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 13, 2020 at 4:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One comment isn't kernel-doc at all, but starts with /** and another
> is simply missing a parameter that was introduced recently.
>

Apologies for missing this earlier.

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 8ddc6dfc8ed4..6e388293c828 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -170,7 +170,7 @@ static const char * const iio_chan_info_postfix[] = {
>  };
>
>  #if defined(CONFIG_DEBUG_FS)
> -/**
> +/*
>   * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
>   * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is undefined
>   */
> @@ -1525,6 +1525,7 @@ struct device_type iio_device_type = {
>
>  /**
>   * iio_device_alloc() - allocate an iio_dev from a driver
> + * @parent:            Parent device.
>   * @sizeof_priv:       Space to allocate for private structure.
>   **/
>  struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
> --
> 2.28.0
>
