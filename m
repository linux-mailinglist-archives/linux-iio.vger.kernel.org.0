Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB2A33A009
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 19:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhCMSn7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 13:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCMSnt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Mar 2021 13:43:49 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3F7C061574
        for <linux-iio@vger.kernel.org>; Sat, 13 Mar 2021 10:43:45 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id r7so5729352ilb.0
        for <linux-iio@vger.kernel.org>; Sat, 13 Mar 2021 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fXXmSnXERyR77QDTIuo0kEYhmKyNHGbTPlplB7dGsCg=;
        b=DfwdX1+JG/H4S91ZEhgB4jfE+v0CSCKpgvunsn8K2TyHKYy65bCxbr2cGDLKRqxnhP
         aC9tsCHG6u2K2nFK5dUfrLBsVMB7Ik+MCZYcVlmbfsXi2h17dg8L1fV19a2yV8V0oVO+
         WIeRqqSNajtGYI0ACmVrlGruDmYmwuUkNjsSYCrxo4tE3dt7t9Eirz9UpoE2orZsKKj2
         To6mf2nPGG8XCl3n5MZOTIDyrDV4WUPZQhchrilOqH3FBb6Rd3ODC0ayXN7MsxZ77HoK
         7NIi9kgRdF8UZYKHOqYdIuuqk6AWk2mwppkethbYgrQ2VaTOtimB4PsRigU4q31ovM6Z
         wo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fXXmSnXERyR77QDTIuo0kEYhmKyNHGbTPlplB7dGsCg=;
        b=D/kSzM085CWwpbPZtE2fdMa+J0TFgjRQlIxa+nbjUrSsG7WIJoVzKbnJkK4rTe8Cgz
         pb6tKhHFnBJE4MkhcE80FCzjlb+S0RSeV4s0AfxzvFpSUnbNWy5cQnK4iimAUiptdFw7
         9h/cDkpDSLoXQT3GIdu5LqHxBcD6Wc9wkyJbhsJcBOdE9DVsHTpuTlO9U55XheohGWw2
         GiKL25SL1uYAf3YSzSqV09Q2C/HUEIHTM7LyldRz02S3qKbtrDj8f1X0lr0VbunjaB++
         0xrOLzruAKArFBKfY+UlmJiAZsZXWaymLq/8uaGFK1r4OlgfzuHrsPjQLpahb2E/+NK0
         re2Q==
X-Gm-Message-State: AOAM531x0syQJ2XmOSYrElkvlugPhlbsqR50AkIzIAJwBlAoK6xV+ziN
        lLtJQmfXnjjmnjF3bL0yhmvVbRpr5fkxWmgaTxM=
X-Google-Smtp-Source: ABdhPJxwrgWJ7wQw8OabcA56XwNx1pe7JheUK+zduTtfyalntB4CtBf4j5okH7iHQ0VWCfvmRNfAyYq7cGI+Mx8R/Sc=
X-Received: by 2002:a92:3652:: with SMTP id d18mr7068370ilf.100.1615661025031;
 Sat, 13 Mar 2021 10:43:45 -0800 (PST)
MIME-Version: 1.0
References: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
 <CA+U=DsqAcmQq2qPMfxVcuwLWJefus_qyM1wG+ioGyG8bej88pw@mail.gmail.com> <20210313152834.GA99671@mugil-Nitro-AN515-52>
In-Reply-To: <20210313152834.GA99671@mugil-Nitro-AN515-52>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 13 Mar 2021 20:43:33 +0200
Message-ID: <CA+U=DspeDi0uX3JYBt1Q0pCHhQ6bszg8siUPQ9HE4CJi7rpG_A@mail.gmail.com>
Subject: Re: GSoC IIO project: Mugil
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "to: Enrico Weigelt, metux IT consult" <info@metux.net>,
        Mugil Raj <dmugil2000@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Utkarsh Verma <utkarshverma294@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 13, 2021 at 5:28 PM Mugilraj <dmugil2000@gmail.com> wrote:
>
> On Thu, Mar 11, 2021 at 10:58:53AM +0200, Alexandru Ardelean wrote:
> > On Thu, Mar 11, 2021 at 9:03 AM Mugil Raj <dmugil2000@gmail.com> wrote:
> > >
> > > Hi,
> > > This is Mugilraj, an undergrad at NIT Trichy, India. I'm applying to
> > > GSoC'21 for the project IIO driver. So, I need help from you guys with
> > > the application process and finding the device to develop a driver.
> > > I've done few exercises on patch submissions and completed a Linux
> > > Foundations course, "A beginners guide to Linux kernel development
> > > (LFD103)". I found this "https://kernelnewbies.org/IIO_tasks" task for
> > > beginners, and now I'm doing that also If anyone suggests some fixes
> > > to develop, that would be helpful for me.
> > >
> >
> >
> > hey,
> >
> > i posted some ideas here:
> > https://lore.kernel.org/linux-iio/CA+U=Dsp98caW89g9FbsV-+KQ-NjyOqd+KSkO+aaFp4qBb-hpMg@mail.gmail.com/T/#md6c49f2e457d66d922d3d22f1f6fdb54971e6b8a
> >
> > [a quick copy + paste from that email]
> >
> > One thing I've always wanted to do, is to convert the entire IIO
> > subsystem to devm_ variants.
> > Essentially getting rid of the iio_device_unregister() function in
> > favor of using devm_iio_device_unregister() and similar.
> >
> > There's about ~217 uses of this function.
> > The more complicated one is in the 'drivers/platform/x86/toshiba_acpi.c'
> > I think reworking the Toshiba ACPI driver would also be interesting,
> > but it is some work.
> >
> > Now, converting everything to devm_ variants can be considered a bit
> > of an obsession [by some people].
> > But I sometimes find potential memory leaks by doing this conversion.
> > And chances are that we may never be able to fully convert the IIO API
> > to be devm_ variant-only.
> > But it is an interesting process [for me], just the cleanup itself.
> I've gone through docs and I hade a dout on devm_iio_device_register().
> If we use this function it  will automatically unregistered on driver
> detach. Then what is the use of devm_iio_device_unregister().

I think you forgot to hit reply all.
So, devm_iio_device_unregister() should no longer exist in a recent kernel.
So, the docs you are reading are from an older kernel.
I think 5.7 is the kernel where some IIO devm_ functions were removed.

But this is a general topic about why should there be a devm_init()
and a devm_uninit()
Especially if the resource allocated with devm_init() is known to be
automatically free'd at driver unload.

The reasons why these existed in IIO [and other places] is because of
the classic C model of "you write an allocation function, then you
also write a deallocation function".
But if you use functions like devm_iio_device_unregister() then it's
likely that the driver has some bad design.

Now there are some cases like  devm_k***alloc() and devm_kfree().
In these cases, you sometimes need to free a resource during driver
operation because it is allocated with devm_kalloc(), but you need to
change the size of the allocated memory block.
Example:

resoure_array = devm_kcalloc(n, m);
devm_kfree(resoure_array)
resoure_array = devm_kcalloc(n + 1, m);

If you were to use kfree() it would have caused a crash during driver
unload, because it would try to free an already free'd block.
Recently, a devm_krealloc() got introduced for this [in August 2020],
but you will see that devm_kfree() is quite used in the kernel.
I suspect it may be the most used  devm_<release_resource>() function
in the kernel (probably because there was no devm_krealloc() before),
because you need to do this run-time memory management for some driver
logic, but you also want the neatness of it being unloaded at driver
unload.

>
> It may be a silly question sorry:).

not a silly question;
this is all kernel API stuff, which isn't obvious in the beginning

> >
> > Another one, that was interesting until 1-2 years ago, was the
> > conversion of OF drivers to be a bit more ACPI friendly [as well].
> > This is also a bit of work to convert drivers that use only
> > of_property_read_xxxx()  functions to   device_property_read_xxx()
> > functions.
> > This isn't always straightforward in all drivers, but I do find it
> > interesting to unify the OF & ACPI interfaces, so that all you have to
> > do, is just switch the system from OF to ACPI underneath, and if the
> > device-tree conversion to ACPI is done right, it just works.
> >
> > Then, there's the matter of moving fields [marked as [INTERN] )  from
> > "struct iio_dev"  to "struct iio_dev_opaque".
> > The value of this conversion is to reduce the review pain of having to
> > tell people not-to-use [INTERN] fields [especially when older drivers
> > do].
> >
> >
> > > Is there any IRC channel for IIO?
> > >
> > > Thanks,
> > > Mugil
