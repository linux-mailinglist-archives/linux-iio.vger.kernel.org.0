Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598B733A04E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 20:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhCMTV6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 14:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhCMTVz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 14:21:55 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD2A864ED1;
        Sat, 13 Mar 2021 19:21:53 +0000 (UTC)
Date:   Sat, 13 Mar 2021 19:21:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "to: Enrico Weigelt, metux IT consult" <info@metux.net>,
        Mugil Raj <dmugil2000@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: Re: GSoC IIO project: Mugil
Message-ID: <20210313192150.74c0a91b@archlinux>
In-Reply-To: <CA+U=DspeDi0uX3JYBt1Q0pCHhQ6bszg8siUPQ9HE4CJi7rpG_A@mail.gmail.com>
References: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
        <CA+U=DsqAcmQq2qPMfxVcuwLWJefus_qyM1wG+ioGyG8bej88pw@mail.gmail.com>
        <20210313152834.GA99671@mugil-Nitro-AN515-52>
        <CA+U=DspeDi0uX3JYBt1Q0pCHhQ6bszg8siUPQ9HE4CJi7rpG_A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 13 Mar 2021 20:43:33 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, Mar 13, 2021 at 5:28 PM Mugilraj <dmugil2000@gmail.com> wrote:
> >
> > On Thu, Mar 11, 2021 at 10:58:53AM +0200, Alexandru Ardelean wrote:  
> > > On Thu, Mar 11, 2021 at 9:03 AM Mugil Raj <dmugil2000@gmail.com> wrote:  
> > > >
> > > > Hi,
> > > > This is Mugilraj, an undergrad at NIT Trichy, India. I'm applying to
> > > > GSoC'21 for the project IIO driver. So, I need help from you guys with
> > > > the application process and finding the device to develop a driver.
> > > > I've done few exercises on patch submissions and completed a Linux
> > > > Foundations course, "A beginners guide to Linux kernel development
> > > > (LFD103)". I found this "https://kernelnewbies.org/IIO_tasks" task for
> > > > beginners, and now I'm doing that also If anyone suggests some fixes
> > > > to develop, that would be helpful for me.
> > > >  
> > >
> > >
> > > hey,
> > >
> > > i posted some ideas here:
> > > https://lore.kernel.org/linux-iio/CA+U=Dsp98caW89g9FbsV-+KQ-NjyOqd+KSkO+aaFp4qBb-hpMg@mail.gmail.com/T/#md6c49f2e457d66d922d3d22f1f6fdb54971e6b8a
> > >
> > > [a quick copy + paste from that email]
> > >
> > > One thing I've always wanted to do, is to convert the entire IIO
> > > subsystem to devm_ variants.
> > > Essentially getting rid of the iio_device_unregister() function in
> > > favor of using devm_iio_device_unregister() and similar.
> > >
> > > There's about ~217 uses of this function.
> > > The more complicated one is in the 'drivers/platform/x86/toshiba_acpi.c'
> > > I think reworking the Toshiba ACPI driver would also be interesting,
> > > but it is some work.
> > >
> > > Now, converting everything to devm_ variants can be considered a bit
> > > of an obsession [by some people].
> > > But I sometimes find potential memory leaks by doing this conversion.
> > > And chances are that we may never be able to fully convert the IIO API
> > > to be devm_ variant-only.
> > > But it is an interesting process [for me], just the cleanup itself.  
> > I've gone through docs and I hade a dout on devm_iio_device_register().
> > If we use this function it  will automatically unregistered on driver
> > detach. Then what is the use of devm_iio_device_unregister().  
> 
> I think you forgot to hit reply all.
> So, devm_iio_device_unregister() should no longer exist in a recent kernel.
> So, the docs you are reading are from an older kernel.
> I think 5.7 is the kernel where some IIO devm_ functions were removed.
> 
> But this is a general topic about why should there be a devm_init()
> and a devm_uninit()
> Especially if the resource allocated with devm_init() is known to be
> automatically free'd at driver unload.
> 
> The reasons why these existed in IIO [and other places] is because of
> the classic C model of "you write an allocation function, then you
> also write a deallocation function".

I can absolutely confirm that was how this particular function
came to be!  I wasn't thinking at the time. Oops ;)

> But if you use functions like devm_iio_device_unregister() then it's
> likely that the driver has some bad design.
> 
> Now there are some cases like  devm_k***alloc() and devm_kfree().
> In these cases, you sometimes need to free a resource during driver
> operation because it is allocated with devm_kalloc(), but you need to
> change the size of the allocated memory block.
> Example:
> 
> resoure_array = devm_kcalloc(n, m);
> devm_kfree(resoure_array)
> resoure_array = devm_kcalloc(n + 1, m);
> 
> If you were to use kfree() it would have caused a crash during driver
> unload, because it would try to free an already free'd block.
> Recently, a devm_krealloc() got introduced for this [in August 2020],
> but you will see that devm_kfree() is quite used in the kernel.
> I suspect it may be the most used  devm_<release_resource>() function
> in the kernel (probably because there was no devm_krealloc() before),
> because you need to do this run-time memory management for some driver
> logic, but you also want the neatness of it being unloaded at driver
> unload.
> 
> >
> > It may be a silly question sorry:).  
> 
> not a silly question;
> this is all kernel API stuff, which isn't obvious in the beginning

This particular question focuses on one of the most common things people
do wrong when first writing a driver (unnecessary cleanup of managed
functions)  I have to explain this at least 10 times a year!

If you spread out beyond IIO over time you'll find they don't all
start with devm_ for example pcim_ which is much more subtle to spot.
I'm glad we didn't go with iiom_* :)

Jonathan

> 
> > >
> > > Another one, that was interesting until 1-2 years ago, was the
> > > conversion of OF drivers to be a bit more ACPI friendly [as well].
> > > This is also a bit of work to convert drivers that use only
> > > of_property_read_xxxx()  functions to   device_property_read_xxx()
> > > functions.
> > > This isn't always straightforward in all drivers, but I do find it
> > > interesting to unify the OF & ACPI interfaces, so that all you have to
> > > do, is just switch the system from OF to ACPI underneath, and if the
> > > device-tree conversion to ACPI is done right, it just works.
> > >
> > > Then, there's the matter of moving fields [marked as [INTERN] )  from
> > > "struct iio_dev"  to "struct iio_dev_opaque".
> > > The value of this conversion is to reduce the review pain of having to
> > > tell people not-to-use [INTERN] fields [especially when older drivers
> > > do].
> > >
> > >  
> > > > Is there any IRC channel for IIO?
> > > >
> > > > Thanks,
> > > > Mugil  

