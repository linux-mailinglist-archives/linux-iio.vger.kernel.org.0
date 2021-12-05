Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3453B468C86
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhLESB7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 5 Dec 2021 13:01:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58804 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbhLESB7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 13:01:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B436061124
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 17:58:31 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 5D64FC341C5;
        Sun,  5 Dec 2021 17:58:29 +0000 (UTC)
Date:   Sun, 5 Dec 2021 18:03:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] LTC2688 support
Message-ID: <20211205180339.1dfa83b9@jic23-huawei>
In-Reply-To: <PH0PR03MB6786AB0F1BE42523D0F2AC0299699@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
        <20211112161437.60dbc872@jic23-huawei>
        <PH0PR03MB6366BFFE85F122FED1B72BB499989@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20211121121756.2297671a@jic23-huawei>
        <PH0PR03MB678687C50B21BD5E448E413699679@PH0PR03MB6786.namprd03.prod.outlook.com>
        <PH0PR03MB6786AB0F1BE42523D0F2AC0299699@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2 Dec 2021 15:37:40 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Sa, Nuno <Nuno.Sa@analog.com>
> > Sent: Tuesday, November 30, 2021 3:43 PM
> > To: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio@vger.kernel.org
> > Subject: RE: [RFC PATCH 0/1] LTC2688 support
> > 
> > [External]
> > 
> > 
> >   
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, November 21, 2021 1:18 PM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: linux-iio@vger.kernel.org
> > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > >
> > > [External]
> > >
> > > On Mon, 15 Nov 2021 10:28:51 +0000
> > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > >  
> > > > Hi Jonathan,
> > > >
> > > > Thanks for your inputs...
> > > >  
> > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > Sent: Friday, November 12, 2021 5:15 PM
> > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > Cc: linux-iio@vger.kernel.org
> > > > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > > > >
> > > > > [External]
> > > > >
> > > > > On Thu, 11 Nov 2021 12:00:42 +0100
> > > > > Nuno Sá <nuno.sa@analog.com> wrote:
> > > > >
> > > > > Hi Nuno,
> > > > >  
> > > > > > The reason why this is a RFC is because I'm still waiting for  
> > proper  
> > > HW  
> > > > > > to test this thing. The reason why I'm sending this already is  
> > > because  
> > > > > > there's some non usual features which might require extra ABI.  
> > > > > Hence,  
> > > > > > while waiting I thought we could already speed up the process  
> > in  
> > > > > regards  
> > > > > > with the ABI.  
> > > > >
> > > > > Wise move as this is an unusual beast :)
> > > > >  
> > > > > >
> > > > > > I still pushed the driver but the intent here is not really to  
> > review  
> > > it.  
> > > > > > Naturally, if someone already wants to give some feedback,  
> > > that's  
> > > > > very  
> > > > > > much appreciated :)  
> > > > >  
> > > > > >
> > > > > > Now, there are three main interfaces depending on the  
> > channel  
> > > > > mode:  
> > > > > >  1) default (no new ABI)
> > > > > >  2) toggle mode
> > > > > >  3) dither mode
> > > > > >
> > > > > > The channel mode will be a devicetree property as it does not  
> > > really  
> > > > > > make much sense to change between modes at runtime even  
> > > more  
> > > > > because the  
> > > > > > piece of HW we might want to control with a channel might be  
> > > > > different  
> > > > > > depending on the selected mode (I'm fairly sure on this  
> > between  
> > > > > toggle  
> > > > > > and other modes but not so sure between dither and default  
> > > mode).  
> > > > >
> > > > > I agree on toggle vs dither definitely being different, but normal  
> > > you  
> > > > > could implement either as software toggle, or dither with a 0
> > > > > magnitude
> > > > > sine wave.  So might not be worth implementing default mode at  
> > > all.  
> > > > > No harm in doing so though if there are advantages to having it.  
> > > >
> > > > My feeling is that we could probably have dither as the "default  
> > > mode".  
> > > > More on this below...
> > > >  
> > > > > >
> > > > > > toggle mode special ABI:
> > > > > >
> > > > > >  * Toggle operation enables fast switching of a DAC output  
> > > between  
> > > > > two  
> > > > > > different DAC codes without any SPI transaction. Two codes are  
> > > set  
> > > > > in  
> > > > > > input_a and input_b and then the output switches according to  
> > > an  
> > > > > input  
> > > > > > signal (input_a -> clk high; input_b -> clk low).
> > > > > >
> > > > > > out_voltageY_input_register
> > > > > >  - selects between input_a and input_b. After selecting one  
> > > register,  
> > > > > we  
> > > > > >    can write the dac code in out_voltageY_raw.
> > > > > > out_voltageY_toggle_en
> > > > > >  - Disable/Enable toggle mode. The reason why I think this one  
> > is  
> > > > > >    important is because if we wanna change the 2 codes, we  
> > > should  
> > > > > first  
> > > > > >    disable this, set the codes and only then enable the mode  
> > > back...  
> > > > > >    As I'm writing this, It kind of came to me that we can probably
> > > > > >    achieve this with out_voltageY_powerdown attr (maybe  
> > takes a  
> > > bit  
> > > > > more  
> > > > > >    time to see the outputs but...)  
> > > > >
> > > > > Hmm. These corner cases always take a bit of figuring out.  What  
> > > you  
> > > > > have
> > > > > here is a bit 'device specific' for my liking.
> > > > >
> > > > > So there is precedence for ABI in this area, on the frequency  
> > > devices  
> > > > > but only
> > > > > for devices we still haven't moved out of staging.  For those we
> > > > > needed a means
> > > > > to define selectable phases for PSK - where the selection was  
> > > either  
> > > > > software or,
> > > > > much like here, a selection pin.
> > > > >
> > > > > out_altvotage0_phase0 etc
> > > > >
> > > > > so I guess the equivalent here would be
> > > > > out_voltageY_raw0
> > > > > out_voltageY_raw1
> > > > > and the selection would be via something like
> > > > > out_voltageY_symbol (0 or 1 in this case). - note this is only
> > > > > relevant if you have the software toggle. Any enable needed for
> > > > > setting
> > > > > can be done as part of the write sequence for the  raw0 / raw1  
> > and  
> > > > > should
> > > > > ideally not be exposed to userspace (controls that require  
> > manual  
> > > > > sequencing
> > > > > tend to be hard to use / document).  
> > > >
> > > > Yeah, I thought about that. I was even thinking in having something  
> > > like  
> > > > *_amplitude for dither mode. In some cases, where we might be  
> > left  
> > > > in some non obvious state (eg: moved the select register to input b  
> > > and  
> > > > then we failed to set the code;), I prefer to leave things as flexible  
> > as  
> > > > possible for userspace. But I agree it adds up more complexity and  
> > in  
> > > > this case, I can just always go to 'input_a' when writing 'raw0'...
> > > >  
> > > > > However, I'm not 100% sure it really maps to this case.  What do  
> > > you  
> > > > > think?  
> > > >
> > > > I think it can work. Though out_voltageY_symbol probably needs to  
> > > be  
> > > > shared by type to be coherent with what we might have with  
> > TGPx.  
> > >
> > > That's fine.
> > >  
> > > > Note the sw_toggle register has a bit mask of the channels we  
> > want  
> > > to  
> > > > toggle which means we can toggle multiple channels at the same  
> > > time.
> > >
> > > Using that wired up to buffer mode might make sense.  You'd  
> > provide  
> > > multiple
> > > buffers and allow channels to be selected into one of them at a time.
> > > Each
> > > buffer is then tied to a different toggle (TGP0, TGP1, etc)
> > >
> > > The same could be true for the software toggle.  It'll get a bit fiddly
> > > though.
> > >
> > > Perhaps this is an advanced feature to think about later...
> > >  
> > > > It works the same with TGPx if you map multiple channels to the  
> > > same  
> > > > pin.
> > > >
> > > > There's also the question on how to handle this if a TGPx is  
> > provided?  
> > > > I guess it will just override the pin... But most likely having them  
> > both  
> > > > at the same time will lead to non desired results (unless we have a
> > > > way to gate/ungate the clocks)...  
> > > I don't follow this bit.  You mean TGPx and software toggle. As far as I
> > > can
> > > tell it's an either/or thing per channel.
> > >  
> > 
> > Here I meant that if we have a TGPx pin bundled to some channel(s)
> > we
> > do not want to also dance with the sw_toggle bit of that channel.  
> 
> Just a note on this. After starting my tests with the device, I can actually
> say that if we have a TGPx set in the channel settings register, the device
> will pretty much ignore the sw_toggle settings for that channel. I could
> see that the output voltage was not toggling at all. As soon as I removed
> the TGPx setting, then dancing with the sw_toggle started to work. So, for
> the HW this is not really an issue as it just ignores the sw_toggle. On a SW
> perspective, I'm still not sure if I just ignore this and write whatever the
> user sets or if I return some error code in the case a user tries to toggle
> a channel with a binded TGPx. The first one is appealing as it makes the
> code much simpler while OTHO it might make sense to be verbose here
> otherwise the user might think something is happening when it isn't...

If we are in a static configuration (see below) then just don't expose the
software toggle control.  Not having a big red button to press is the best way to
tell userspace to not press the big red button...
> 
> Anyways, I would argue that if someone has a pin wired, it's highly unlikely
> that he cares about sw_toggling...

I'd agree if there was one to one mapping from TGPx to channel.  Given
it's highly configurable, they 'might' want to set the mapping differently
at runtime.  I'm fine if we don't support that option until someone asks
though.

Jonathan


> 
> - Nuno Sá
> 

