Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10242A36A
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhJLLjJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 07:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbhJLLjJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 07:39:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2571C061570;
        Tue, 12 Oct 2021 04:37:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so1663279pjb.1;
        Tue, 12 Oct 2021 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCKzsnWQrGuy+GoB4AipIdmem4eM9oZp/c1lqXnnmZc=;
        b=jzEqQUq7qkbv6bGh/qUJM6FKpmVepYYwP5n7iaOD+ViAWVQHLdyUoXgoyiItxfvGxQ
         1KNZN6IrMluZIXIZmZzOdhtAskxTD68VNShgFja49MWjjuBirvc/FMM9R3T55WQ8ZYvm
         x6OYHfc6XXog2Q6Kz5+sagYUWXt1d0q0286YW4rZlD8u8x88CDgDYrjUMc+Kv1Myiou9
         NaY14+9LaSZCUhbnBz2PELnyCwV5wy+iiuU51ev9dr6ThflBYwmcJCYic0hVV9EBSPS4
         dSl7+VVZXIKhLGyU7z5tUzmdvkOMXd1iDBlrmEubgB7JkjVeswJhKEtnh7xcnBmJRq2r
         wmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCKzsnWQrGuy+GoB4AipIdmem4eM9oZp/c1lqXnnmZc=;
        b=ERZPYAoAhdHQH3Qlc98KK2Od5ce0vbCiKapFsMWuvKrv++7IszonZym1jAc45yo9UU
         +nvDCm5szmZv3DezmUyGscXzrCrSQwhXZ7h+gfBpAb06pdqZmZQqE9DFmTbhRt1A4dHH
         6ospaMjsOB5DLmV5oStkaLgalNnEmZ3tRlH+erbaIvmwNaDF01yTcmTEfMwWWfkBtMc3
         vuCcwJK11MSkvZ8C7Qcj/AHccwRkFqYbmHkgYmM9YLTJ1sVPbhvn36KgqVBXRNoBGvje
         7zbMBw+UP/ACBlC1uvvrwI3psD3zvFPSPcip0NoLCA513zO20LQfynO7jGMFf/0xvx86
         6P/Q==
X-Gm-Message-State: AOAM530bn6BcndiuL/j7KKq0wMCrgQMuqFQmSeKUYx1fOuYxOvJkTigT
        8SGO0GwJnpWt4SLN7If09Z7OxPhyLxLeSIptcuA=
X-Google-Smtp-Source: ABdhPJwKJ9m5lXkGT/8CpdM5JK7H/Z3kNgE43JzWMeyOnb4h6T6DFR2bdkeoXcKbeqsMf/lKXp8z9KGwmDouu2fIoLw=
X-Received: by 2002:a17:90a:cd:: with SMTP id v13mr5397305pjd.81.1634038627231;
 Tue, 12 Oct 2021 04:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211012092513.1349295-1-yangyingliang@huawei.com>
In-Reply-To: <20211012092513.1349295-1-yangyingliang@huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 12 Oct 2021 14:36:55 +0300
Message-ID: <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 12, 2021 at 12:18 PM Yang Yingliang
<yangyingliang@huawei.com> wrote:
>
> When __iio_buffer_alloc_sysfs_and_mask() failed, 'unwind_idx' should be
> set to 'i - 1' to prevent double-free when cleanup resources.
>
> BUG: KASAN: double-free or invalid-free in __iio_buffer_free_sysfs_and_mask+0x32/0xb0 [industrialio]
> Call Trace:
>  kfree+0x117/0x4c0
>  __iio_buffer_free_sysfs_and_mask+0x32/0xb0 [industrialio]
>  iio_buffers_alloc_sysfs_and_mask+0x60d/0x1570 [industrialio]
>  __iio_device_register+0x483/0x1a30 [industrialio]
>  ina2xx_probe+0x625/0x980 [ina2xx_adc]
>

Makes sense.
Thanks for the catch.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: ee708e6baacd ("iio: buffer: introduce support for attaching more IIO buffers")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iio/industrialio-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index a95cc2da56be..5f4bd0b73d03 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1616,7 +1616,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>                 buffer = iio_dev_opaque->attached_buffers[i];
>                 ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
>                 if (ret) {
> -                       unwind_idx = i;
> +                       unwind_idx = i - 1;
>                         goto error_unwind_sysfs_and_mask;
>                 }
>         }
> --
> 2.25.1
>
