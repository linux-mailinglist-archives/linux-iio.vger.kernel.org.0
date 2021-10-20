Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1AC435156
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 19:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJTRfk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 13:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhJTRfk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Oct 2021 13:35:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5204D61038;
        Wed, 20 Oct 2021 17:33:22 +0000 (UTC)
Date:   Wed, 20 Oct 2021 18:37:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-realtek-soc@lists.infradead.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>, nic_swsd@realtek.com,
        Derek Fang <derek.fang@realtek.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Kailang Yang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        LKML <linux-kernel@vger.kernel.org>, info@ayaneo.com
Subject: Re: BMI160 accelerometer on AyaNeo tablet
Message-ID: <20211020183739.6a045ccc@jic23-huawei>
In-Reply-To: <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com>
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
        <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
        <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
        <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
        <YW3ErLKGtmyhSFd3@smile.fi.intel.com>
        <CACAwPwYrxxFstQgYHhPOhMwUz_5RprSuoPNHL7m9ft1i-N2icQ@mail.gmail.com>
        <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Oct 2021 12:58:53 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Oct 18, 2021 at 11:42 PM Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> > On Mon, Oct 18, 2021 at 10:02 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:  
> > > On Mon, Oct 18, 2021 at 09:02:40PM +0300, Maxim Levitsky wrote:  
> 
> ...
> 
> > > Thank you for sharing. Seems they indeed used (deliberately or not) the wrong
> > > ID. So there are questions I have:
> > > - Is the firmware available in the wild?  
> >
> > Likely so. It looks Aya team only released a single windows driver which
> > works on all revisions of their device including the Founder Edition,
> > which was released more that a year ago.
> >
> > It is likely that all 3 revisions that they sold carry this ACPI ID.
> > (The founder edition, first batch of IndieGoGo orders which had a
> > redesigned shell,
> > and 2nd batch (which I have) which has a new wifi card, a bit better
> > controller,
> > among other changes).
> >
> >  
> > > - Do they plan to update firmware to fix this?
> > > - Can we make sure that guys got their mistake and will be more careful
> > >   in the future?  
> >
> > I CCed them, hoping that they would hear us. I can also raise this on their
> > discord when I find time to look there.  
> 
> I expect to have confirmation from them that they have got it and
> promise to fix the firmware (ACPI tables) for supported and future
> products.Can it be achieved? (Note, Hans already told what the HID
> should be used there)
> 
> > > Realtek probably should make this ID marked somehow broken and not use
> > > in their products in case the answer to the first of the above question
> > > is "yes". (Of course in case the ID will be used for solely PCI enumerated
> > > product there will be no conflict, I just propose to be on the safest side,
> > > but remark should be made somewhere).  
> 
> Any comments from Realtek, please?
> 
> > > > BTW, I also notice a rotation matrix embedded in DSTD, but the linux's
> > > > BMI160 driver doesn't recognize it.  
> > >
> > > This is done by the commit 8a0672003421 ("iio: accel: bmc150: Get
> > > mount-matrix from ACPI") which needs to be amended to take care about
> > > more devices, somewhere in drivers/iio/industialio-acpi.c ? Jonathan,
> > > Hans, what do you think?  
> >
> > If you like to, I can probably volunteer to prepare a patch for this myself next
> > weekend, using this pointer as a reference.  

Hmm. This isn't part of the ACPI spec but seems to be a microsoft addition.
The webpage google feeds me says this is windows 10 mobile specific...
https://docs.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
	
Whilst I haven't been paying particularly close attention, I haven't noticed
any attempt to add this to a future ACPI spec. If anyone happens to have
convenient Microsoft contacts to verify the status of this method that would
be a good step before we in any way imply it is standard.  Until then my inclination
is to keep this in the few drivers in which we know it is useful.

Jonathan

> 
> The best is to cooperate with Hans as he is much more involved in the
> topic of how these sensors are programmed and used in the Linux
> kernel. My job here is to fix ACPI HID and
> make every stakeholder be aware now and in the future.
> 
> ...
> 
> > I will prepare a patch with a better commit description this weekend.  
> 
> Thanks, but let's not be in such a hurry, I really want to hear from
> both vendors. I guess a couple of weeks would be a reasonable time to
> settle this down.
> 

