Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1CF4310B9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 08:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhJRGne (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 02:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhJRGnd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 02:43:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79693C06161C;
        Sun, 17 Oct 2021 23:41:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gn3so5989758pjb.0;
        Sun, 17 Oct 2021 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=548A5p6CPnegHzoCqWNsQfgmAjX9V1jYwmKRO97IXn4=;
        b=Ka5d3RLuEaYABIb7ydkWUIhUNhu94sJhtfnO7zAxa/LvbSWfV7xi4qM3div0n2bt75
         cmc9yW47oyMsgASKGxMicCS2mc4nIC03O2znRhkKj8rpLxwtohncu6bMWXjrIv8sgN3w
         NHO2M8gJIjmo9mp18M0kI6XURs2qxlunpIxzpGavasz1DM5HwQ13OmH9IpFxUgYzoLAo
         rnftB0sTax0b8xlyQGclcdjVBJ5yO1aT3I4F43tKywDUjxKdr15sVgqC4sWKFFEcEOX/
         XO049GZTSAjr4HFOK6V26XrdjnWErs2sQPzzZwY6FDFNXzKt/dEDQ6NLheufLaZUuoET
         IXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=548A5p6CPnegHzoCqWNsQfgmAjX9V1jYwmKRO97IXn4=;
        b=d8++0BL/BlaVMTAgtA6B077wbUpuucKNYIF+V0htR8fNdrsxxdSUGnShVYC3WyPoBn
         iDGJHsPGF7AZVw9UW9lOJG2vvhNThIqyAAlSD7slb1ojm9fqIxuzqlSn0A+kb1LRn4Dd
         0Qr10wuCaw+Z7nFbehpb7pHNcT5xW4wcA09A2OQ6gUJxTWZH540lbVtka4GO1BlQ0NQy
         QDWBVNe5bavwEaoOlfMglfbdkqIHpLVxbZ1ka0/VJwAapqsKg0FFHFA5bPi5omO+922Y
         vi+oMSnaTk50coW0v4L/vIR3gneDq1XeMhCkQPgGZ3DO8tJa+4g4OiH/HRU77I9H95hZ
         iKyQ==
X-Gm-Message-State: AOAM533oITkws9+mc+q9Lc6z0csZ4vwER1G2/rOYItb23EpoPsiNJM1W
        +1MIN8Vrjq4XC7bZbHZcQggg9Xgl/Gf5J0CKC9HUiIj6
X-Google-Smtp-Source: ABdhPJzXXYiw/rYsvzA8pdSvCbPpa4XicNtZftiQOMlN5DT6GQzFufWL4EaP5VWJ7CSOYLQyP8dqOrOWpNZnf0pu5z0=
X-Received: by 2002:a17:90a:cd:: with SMTP id v13mr46103733pjd.81.1634539281809;
 Sun, 17 Oct 2021 23:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211018063718.1971240-1-yangyingliang@huawei.com>
In-Reply-To: <20211018063718.1971240-1-yangyingliang@huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 18 Oct 2021 09:41:10 +0300
Message-ID: <CA+U=DsorPFMpz3QS=dYrV4_UmeyeZXbS2Afpt7UHCkwo3JEABA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: buffer: Fix memory leak in iio_buffers_alloc_sysfs_and_mask()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 18, 2021 at 9:29 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> When 'iio_dev_opaque->buffer_ioctl_handler' alloc fails in
> iio_buffers_alloc_sysfs_and_mask(), the 'attrs' allocated in
> iio_buffer_register_legacy_sysfs_groups() will be leaked:
>
> unreferenced object 0xffff888108568d00 (size 128):
>   comm "88", pid 2014, jiffies 4294963294 (age 26.920s)
>   hex dump (first 32 bytes):
>     80 3e da 02 80 88 ff ff 00 3a da 02 80 88 ff ff  .>.......:......
>     00 35 da 02 80 88 ff ff 00 38 da 02 80 88 ff ff  .5.......8......
>   backtrace:
>     [<0000000095a9e51e>] __kmalloc+0x1a3/0x2f0
>     [<00000000faa3735e>] iio_buffers_alloc_sysfs_and_mask+0xfa3/0x1480 [industrialio]
>     [<00000000a46384dc>] __iio_device_register+0x52e/0x1b40 [industrialio]
>     [<00000000210af05e>] __devm_iio_device_register+0x22/0x80 [industrialio]
>     [<00000000730d7b41>] adjd_s311_probe+0x195/0x200 [adjd_s311]
>     [<00000000c0f70eb9>] i2c_device_probe+0xa07/0xbb0
>
> The iio_buffer_register_legacy_sysfs_groups() is
> called in __iio_buffer_alloc_sysfs_and_mask(),
> so move the iio_buffer_unregister_legacy_sysfs_groups()
> into __iio_buffer_free_sysfs_and_mask(), then the memory
> will be freed.
>

Reviewed- by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: d9a625744ed0 ("iio: core: merge buffer/ & scan_elements/ attributes")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>   move iio_buffer_unregister_legacy_sysfs_groups() into
>   __iio_buffer_free_sysfs_and_mask()
> ---
>  drivers/iio/industrialio-buffer.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index a95cc2da56be..b29d105a75fe 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1583,8 +1583,12 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>         return ret;
>  }
>
> -static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> +static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer,
> +                                            struct iio_dev *indio_dev,
> +                                            int index)
>  {
> +       if (index == 0)
> +               iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
>         bitmap_free(buffer->scan_mask);
>         kfree(buffer->buffer_group.name);
>         kfree(buffer->buffer_group.attrs);
> @@ -1638,7 +1642,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  error_unwind_sysfs_and_mask:
>         for (; unwind_idx >= 0; unwind_idx--) {
>                 buffer = iio_dev_opaque->attached_buffers[unwind_idx];
> -               __iio_buffer_free_sysfs_and_mask(buffer);
> +               __iio_buffer_free_sysfs_and_mask(buffer, indio_dev, unwind_idx);
>         }
>         return ret;
>  }
> @@ -1655,11 +1659,9 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
>         iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
>         kfree(iio_dev_opaque->buffer_ioctl_handler);
>
> -       iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
> -
>         for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
>                 buffer = iio_dev_opaque->attached_buffers[i];
> -               __iio_buffer_free_sysfs_and_mask(buffer);
> +               __iio_buffer_free_sysfs_and_mask(buffer, indio_dev, i);
>         }
>  }
>
> --
> 2.25.1
>
