Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66938166C
	for <lists+linux-iio@lfdr.de>; Sat, 15 May 2021 08:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhEOG7O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 May 2021 02:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhEOG7N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 May 2021 02:59:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF3C06174A
        for <linux-iio@vger.kernel.org>; Fri, 14 May 2021 23:58:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 10so1326680pfl.1
        for <linux-iio@vger.kernel.org>; Fri, 14 May 2021 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ea4l3fiV2Hnjj5tKEeDw+i9RSNS4B8mk++DM2iZYuv8=;
        b=YmVYkUfKN6WwHFcykEx/iwqALuPoTJFYPkpFAe931P/3vqcLFQijK4RXEJNYhAh1Bo
         nAOP/l2GOlsuEBPmGokFzsTv10Vd9pZ8t/eQLjZJZu4A4YHnkCqoRjjmOMEM7IlD5oCY
         OVReHCw9gwYXfzZP7c0entRkcbKOJDct9U5JwHrQbHqayo0pYe11m1TAM9/ZtCmg9SOA
         0WMJQv8DJfTziVnmbGxCR3ErrAUuBROi/F+jaByfz0IfbhT8UX2qqzhNtMibKFhhe1a4
         SD5LNmrgtx9H39lklcMJiMQLiA1YKFUXQj9+RavElZAeeKj8xPH0LnnEuQF3fR8eXo2W
         UC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ea4l3fiV2Hnjj5tKEeDw+i9RSNS4B8mk++DM2iZYuv8=;
        b=PLGK166G4GkxL052oChcjnd4VEYskAC2Jl56ylruh27a3BCu/LDpzmaMZsxy3f04rT
         w/rXPbICew2siv38fbyCB79MCe80YVTKfy4T/CL7iEN5nfbc5Vja5llhkQAFAPVj6a79
         7B+H7RyN+rmwTE6qr3/XLgUJprNM2UuNgUscnJOLU9CAACm7/Yx3dO9Jhn2OSVn6+ES1
         xAPKop/aQUHCt06+78gaQm4wQ1+RMnBD9qQq3sB2CRl0Glhnrlhi7NrSPs4uWi+Caryd
         j+UWP0lPMF6oIaPJadP6aqfzVj9NrLkEmH41nDkj0bMNO4J/+/g3FdJR2qM80ln7GiCD
         lNTQ==
X-Gm-Message-State: AOAM531lDALeREqG1cnlcdhyGXqxFvpAYB2glTdTa+fTYEZUCOW5geNb
        lsvFGyfk6ih2IQ6cz1kXR2N6AB9+t+llkbb3Th0=
X-Google-Smtp-Source: ABdhPJyr3kfOh1ObLlBw0++Gls5xJFpBADGz653IVGElaSi+3e5A+MLm1OnqyIMP2h1fFop/PxsRWl8M/RJrUgfEjas=
X-Received: by 2002:a63:1953:: with SMTP id 19mr35502290pgz.273.1621061880778;
 Fri, 14 May 2021 23:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210514195916.44232-1-hdegoede@redhat.com>
In-Reply-To: <20210514195916.44232-1-hdegoede@redhat.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 15 May 2021 09:57:49 +0300
Message-ID: <CA+U=DsqhkbSNDWvYH0O7gYFHZzj48BPpDt04=APm+fKTtyo14Q@mail.gmail.com>
Subject: Re: [PATCH] iio: core: Fix BUG() on rmmod of iio-drivers caused by
 double list_del()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 14, 2021 at 11:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Removing an iio-driver module (or unbinding the driver) causes a BUG() to
> trigger when the kernel is build with list-debugging enabled. This is
> caused by a double list_del() introduced by commit 8dedcc3eee3a ("iio:
> core: centralize ioctl() calls to the main chardev").
>
> This patch introduces an ioctl_handlers list to which ioctl handlers are
> added. The cleanup of these however happens twice.
>
> The 2 registration functions:
> iio_device_ioctl_handler_register()
> iio_device_register_eventset()
>
> Have matching unregister functions which do a list_del on the head added
> to the list; and iio_device_unregister() has:
>
>     list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
>         list_del(&h->entry);

This patch should already be in the fixes-togreg tree of IIO.
I am not sure when/if it went in next.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=901f84de0e16bde10a72d7eb2f2eb73fcde8fa1a

>
> This is a problem because iio_device_unregister() does this before calling
> iio_buffers_free_sysfs_and_mask() which calls
> iio_device_ioctl_handler_unregister() which calls list_del on the entry
> added by iio_buffers_alloc_sysfs_and_mask() a second time causing this:
>
> [root@fedora ~]# rmmod bmc150_accel_i2c
> Segmentation fault
>
> [  160.627546] ------------[ cut here ]------------
> [  160.627549] kernel BUG at lib/list_debug.c:45!
> [  160.629125] invalid opcode: 0000 [#1] SMP PTI
> [  160.629140] CPU: 0 PID: 1139 Comm: rmmod Tainted: G            E     5.13.0-rc1+ #341
> [  160.629146] Hardware name: LENOVO 80M1/Mini, BIOS C7CN31WW 08/05/2016
> [  160.629149] RIP: 0010:__list_del_entry_valid.cold+0xf/0x47
> ...
> [  160.629202] Call Trace:
> [  160.629209]  iio_device_ioctl_handler_unregister+0xe/0x90 [industrialio]
> [  160.629226]  iio_device_unregister_trigger_consumer+0x21d/0x2f0 [industrialio]
> [  160.629239]  bmc150_accel_core_remove+0x20/0xd0 [bmc150_accel_core]
> [  160.629246]  i2c_device_remove+0x25/0xb0
> [  160.629254]  __device_release_driver+0x180/0x240
> [  160.629261]  device_release_driver+0x26/0x40
> [  160.629267]  bus_remove_device+0xf2/0x160
> [  160.629272]  device_del+0x18c/0x3e0
> [  160.629280]  device_unregister+0x16/0x60
> ...
>
> Since iio_device_ioctl_handler_unregister/iio_device_unregister_eventset()
> already do the list_del() there is no need for the
> list_for_each_entry_safe() in iio_device_unregister() which also does the
> list_del(). Remove the list_for_each_entry_safe() to fix the double
> list_del() issue.
>
> Fixes: 8dedcc3eee3a ("iio: core: centralize ioctl() calls to the main chardev")
> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/iio/industrialio-core.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d92c58a94fe4..9e59f5da3d28 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1926,9 +1926,6 @@ EXPORT_SYMBOL(__iio_device_register);
>   **/
>  void iio_device_unregister(struct iio_dev *indio_dev)
>  {
> -       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -       struct iio_ioctl_handler *h, *t;
> -
>         cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>
>         mutex_lock(&indio_dev->info_exist_lock);
> @@ -1939,9 +1936,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>
>         indio_dev->info = NULL;
>
> -       list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
> -               list_del(&h->entry);
> -
>         iio_device_wakeup_eventset(indio_dev);
>         iio_buffer_wakeup_poll(indio_dev);
>
> --
> 2.31.1
>
