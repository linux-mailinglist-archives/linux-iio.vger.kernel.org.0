Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB7F428837
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 09:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhJKIA4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 04:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhJKIA4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 04:00:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2901C061570;
        Mon, 11 Oct 2021 00:58:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x8so10722380plv.8;
        Mon, 11 Oct 2021 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVoxB0tyBEMpEXIJ8ortzrIvQhld/73RFrCUiwN1f2w=;
        b=HKz5lhkvazoDEockgyLAEkfkx4xl036zv5FdszSo/r7+QT+Q9YNcbm8I1nRJBX8oq2
         6kuY/SL9s0aWHQrpCZsnDZJ5i+qXrgG/fx9mJRWYHI7XgNk/34LAdhy7vDhMaDN0cR3L
         P0odwh7oKbPVyEF5G7GA31s7sfUhGga8sPM/b0FrGRjg4xp/MCnWOQnnMex46ZojqPZI
         JrAlYQb4ou+fiB8KjYeKcmgMA81Fk0drpsHfQyTszt8kMpI2ZI0hwuHM/y4eH6mKTqlm
         j/a8bRSlSmwUR+oBZ+dt7vnOsuhPh7VjfxVmDpUqRiAqtuPbBQoMzY2iKojTbIzfPx5J
         8h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVoxB0tyBEMpEXIJ8ortzrIvQhld/73RFrCUiwN1f2w=;
        b=4DIO+8WLuF14WbFTlBr81Yu8mHD+v9PcY+QqtoPN+nGJIS1+xZHzYLiG9BTPZquRJT
         jnl83rRHHgNgx43pkWyvfaNeK79ODH4YUMYRFD3X7b041tUtWg5mt3qqlVeGK18nCA9R
         ed9JK7R293I9VnHsmbh2YPDUwpz/UcXkm5nfMofhvQxETwbNYMpOHXAB88iuBSV5roT0
         KO5nmp6AObkVhpFQqCeSmP8QvWUWQjLl9P5pfQJTGnRzW/OIQ+saYBMZ6WPEOJLzTp30
         9A0q1+AhHKP7MU3OjLQBpd+2NWjq4x3w2TtqLmbTsQQAI/EYRERM4k+1t566w0++64gl
         rgjg==
X-Gm-Message-State: AOAM532y7YVDV4xoYA58pvy2xGIdKml/BcdioAGvOa7kUFTxDlfbI7t2
        65XQqrtNnGdlSpbHu479/Sz6/mAFd6Bthb/uyZ8=
X-Google-Smtp-Source: ABdhPJy3Dk/CfAxYBdpDuC4cJMlxYGAKWO3q56OX7QJGWAkgO5SCPSw4jrVfwBGP+CJL8YHh2LAfqwKcwN+NcdPCt5c=
X-Received: by 2002:a17:90a:5d8c:: with SMTP id t12mr26388533pji.98.1633939136042;
 Mon, 11 Oct 2021 00:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211009063935.3187803-1-yangyingliang@huawei.com>
In-Reply-To: <20211009063935.3187803-1-yangyingliang@huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 11 Oct 2021 10:58:44 +0300
Message-ID: <CA+U=Dsqm2DPusQkbWPeiZaMLGVTehknG6SPWyjrS6J2JRxd5QA@mail.gmail.com>
Subject: Re: [PATCH] iio: core: fix double free in iio_device_unregister_sysfs()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 9, 2021 at 9:32 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> I got the double free report:
>
> [   68.308365][  T359] BUG: KASAN: double-free or invalid-free in kfree+0xce/0x390
> [   68.309532][  T359]
> [   68.309886][  T359] CPU: 0 PID: 359 Comm: xrun Tainted: G        W         5.15.0-rc3-00109-g4dfd49fafc4d-dirty #474 523b7f3c65c42247635e2ac04a95f61f9f36678d
> [   68.312059][  T359] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   68.313566][  T359] Call Trace:
> [   68.314063][  T359]  dump_stack_lvl+0xe2/0x152
> [   68.314793][  T359]  print_address_description.constprop.7+0x21/0x150
> [   68.315842][  T359]  ? kfree+0xce/0x390
> [   68.316444][  T359]  kasan_report_invalid_free+0x6f/0xa0
> [   68.317289][  T359]  ? kfree+0xce/0x390
> [   68.317902][  T359]  __kasan_slab_free+0x125/0x140
> [   68.318660][  T359]  slab_free_freelist_hook+0x10d/0x240
> [   68.319497][  T359]  ? iio_device_unregister_sysfs+0x108/0x13b [industrialio]
> [   68.321179][  T359]  kfree+0xce/0x390
> [   68.321781][  T359]  iio_device_unregister_sysfs+0x108/0x13b [industrialio]
> [   68.323438][  T359]  iio_dev_release+0x9e/0x10e [industrialio]
> [   68.324902][  T359]  ? iio_device_unregister_sysfs+0x13b/0x13b [industrialio]
> [   68.326550][  T359]  device_release+0xa5/0x240
> [   68.327258][  T359]  kobject_put+0x1e5/0x540
> [   68.327954][  T359]  put_device+0x20/0x30
> [   68.328612][  T359]  devm_iio_device_release+0x21/0x30 [industrialio]
> [   68.330172][  T359]  release_nodes+0xc3/0x3b0
> [   68.330874][  T359]  ? __sanitizer_cov_trace_pc+0x1d/0x50
> [   68.331765][  T359]  ? _raw_spin_unlock_irqrestore+0x4b/0x5d
> [   68.332668][  T359]  ? trace_hardirqs_on+0x63/0x2d0
> [   68.333509][  T359]  devres_release_group+0x1da/0x2c0
> [   68.334325][  T359]  ? release_nodes+0x3b0/0x3b0
> [   68.335069][  T359]  ? __devm_iio_device_register+0x36/0x80 [industrialio]
> [   68.336721][  T359]  ? max517_probe+0x3df/0x6b0 [max517]
> [   68.338122][  T359]  i2c_device_probe+0x628/0xbb0
> [   68.338886][  T359]  ? i2c_device_match+0x110/0x110
> [   68.339674][  T359]  really_probe+0x285/0xc30
>
> If __iio_device_register() fails, iio_dev_opaque->groups will be freed
> in error path in iio_device_unregister_sysfs(), then iio_dev_release()
> will call iio_device_unregister_sysfs() again, it causes double free.
> Set iio_dev_opaque->groups to NULL when it's freed to fix this double free.
>

Thanks for catching this.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2dbb37e09b8c..2dc837db50f7 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1600,6 +1600,7 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
>         kfree(iio_dev_opaque->chan_attr_group.attrs);
>         iio_dev_opaque->chan_attr_group.attrs = NULL;
>         kfree(iio_dev_opaque->groups);
> +       iio_dev_opaque->groups = NULL;
>  }
>
>  static void iio_dev_release(struct device *device)
> --
> 2.25.1
>
