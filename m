Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D7E4696A0
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 14:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbhLFNT0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 6 Dec 2021 08:19:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4208 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244147AbhLFNT0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 08:19:26 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J73jY1l57z67x1B;
        Mon,  6 Dec 2021 21:11:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 6 Dec 2021 14:15:55 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 13:15:55 +0000
Date:   Mon, 6 Dec 2021 13:15:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] LTC2688 support
Message-ID: <20211206131553.00006b68@Huawei.com>
In-Reply-To: <PH0PR03MB6786C1FB47402D1260A4A6C3996D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
        <20211112161437.60dbc872@jic23-huawei>
        <PH0PR03MB6366BFFE85F122FED1B72BB499989@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20211121121756.2297671a@jic23-huawei>
        <PH0PR03MB678687C50B21BD5E448E413699679@PH0PR03MB6786.namprd03.prod.outlook.com>
        <20211205180033.23eb58b9@jic23-huawei>
        <PH0PR03MB6786C1FB47402D1260A4A6C3996D9@PH0PR03MB6786.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Dec 2021 10:49:17 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, December 5, 2021 7:01 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio@vger.kernel.org
> > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > 
> > [External]
> > 
> > On Tue, 30 Nov 2021 14:43:25 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > 
> > Hi Nuno
> > 
> > Hopefully I've not lost the plot on this!  
> 
> Not really. I had some days off so this was also set on hold from
> my side.
> 
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Sunday, November 21, 2021 1:18 PM
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: linux-iio@vger.kernel.org
> > > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > > >
> > > > [External]
> > > >
> > > > On Mon, 15 Nov 2021 10:28:51 +0000
> > > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > > >  
> > > > > Hi Jonathan,
> > > > >
> > > > > Thanks for your inputs...
> > > > >  
> > > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > > Sent: Friday, November 12, 2021 5:15 PM
> > > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > > Cc: linux-iio@vger.kernel.org
> > > > > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > > > > >
> > > > > > [External]
> > > > > >
> > > > > > On Thu, 11 Nov 2021 12:00:42 +0100
> > > > > > Nuno Sá <nuno.sa@analog.com> wrote:
> > > > > >
> > > > > > Hi Nuno,
> > > > > >  
> > > > > > > The reason why this is a RFC is because I'm still waiting for  
> > proper  
> > > > HW  
> > > > > > > to test this thing. The reason why I'm sending this already is  
> > > > because  
> > > > > > > there's some non usual features which might require extra  
> > ABI.  
> > > > > > Hence,  
> > > > > > > while waiting I thought we could already speed up the  
> > process in  
> > > > > > regards  
> > > > > > > with the ABI.  
> > > > > >
> > > > > > Wise move as this is an unusual beast :)
> > > > > >  
> > > > > > >
> > > > > > > I still pushed the driver but the intent here is not really to  
> > review  
> > > > it.  
> > > > > > > Naturally, if someone already wants to give some feedback,  
> > > > that's  
> > > > > > very  
> > > > > > > much appreciated :)  
> > > > > >  
> > > > > > >
> > > > > > > Now, there are three main interfaces depending on the  
> > channel  
> > > > > > mode:  
> > > > > > >  1) default (no new ABI)
> > > > > > >  2) toggle mode
> > > > > > >  3) dither mode
> > > > > > >
> > > > > > > The channel mode will be a devicetree property as it does not  
> > > > really  
> > > > > > > make much sense to change between modes at runtime  
> > even  
> > > > more  
> > > > > > because the  
> > > > > > > piece of HW we might want to control with a channel might  
> > be  
> > > > > > different  
> > > > > > > depending on the selected mode (I'm fairly sure on this  
> > between  
> > > > > > toggle  
> > > > > > > and other modes but not so sure between dither and default  
> > > > mode).  
> > > > > >
> > > > > > I agree on toggle vs dither definitely being different, but normal  
> > > > you  
> > > > > > could implement either as software toggle, or dither with a 0
> > > > > > magnitude
> > > > > > sine wave.  So might not be worth implementing default mode  
> > at  
> > > > all.  
> > > > > > No harm in doing so though if there are advantages to having it.  
> > > > >
> > > > > My feeling is that we could probably have dither as the "default  
> > > > mode".  
> > > > > More on this below...
> > > > >  
> > > > > > >
> > > > > > > toggle mode special ABI:
> > > > > > >
> > > > > > >  * Toggle operation enables fast switching of a DAC output  
> > > > between  
> > > > > > two  
> > > > > > > different DAC codes without any SPI transaction. Two codes  
> > are  
> > > > set  
> > > > > > in  
> > > > > > > input_a and input_b and then the output switches according  
> > to  
> > > > an  
> > > > > > input  
> > > > > > > signal (input_a -> clk high; input_b -> clk low).
> > > > > > >
> > > > > > > out_voltageY_input_register
> > > > > > >  - selects between input_a and input_b. After selecting one  
> > > > register,  
> > > > > > we  
> > > > > > >    can write the dac code in out_voltageY_raw.
> > > > > > > out_voltageY_toggle_en
> > > > > > >  - Disable/Enable toggle mode. The reason why I think this  
> > one is  
> > > > > > >    important is because if we wanna change the 2 codes, we  
> > > > should  
> > > > > > first  
> > > > > > >    disable this, set the codes and only then enable the mode  
> > > > back...  
> > > > > > >    As I'm writing this, It kind of came to me that we can  
> > probably  
> > > > > > >    achieve this with out_voltageY_powerdown attr (maybe  
> > takes a  
> > > > bit  
> > > > > > more  
> > > > > > >    time to see the outputs but...)  
> > > > > >
> > > > > > Hmm. These corner cases always take a bit of figuring out.  
> > What  
> > > > you  
> > > > > > have
> > > > > > here is a bit 'device specific' for my liking.
> > > > > >
> > > > > > So there is precedence for ABI in this area, on the frequency  
> > > > devices  
> > > > > > but only
> > > > > > for devices we still haven't moved out of staging.  For those we
> > > > > > needed a means
> > > > > > to define selectable phases for PSK - where the selection was  
> > > > either  
> > > > > > software or,
> > > > > > much like here, a selection pin.
> > > > > >
> > > > > > out_altvotage0_phase0 etc
> > > > > >
> > > > > > so I guess the equivalent here would be
> > > > > > out_voltageY_raw0
> > > > > > out_voltageY_raw1
> > > > > > and the selection would be via something like
> > > > > > out_voltageY_symbol (0 or 1 in this case). - note this is only
> > > > > > relevant if you have the software toggle. Any enable needed  
> > for  
> > > > > > setting
> > > > > > can be done as part of the write sequence for the  raw0 / raw1  
> > and  
> > > > > > should
> > > > > > ideally not be exposed to userspace (controls that require  
> > manual  
> > > > > > sequencing
> > > > > > tend to be hard to use / document).  
> > > > >
> > > > > Yeah, I thought about that. I was even thinking in having  
> > something  
> > > > like  
> > > > > *_amplitude for dither mode. In some cases, where we might be  
> > left  
> > > > > in some non obvious state (eg: moved the select register to input  
> > b  
> > > > and  
> > > > > then we failed to set the code;), I prefer to leave things as  
> > flexible as  
> > > > > possible for userspace. But I agree it adds up more complexity  
> > and in  
> > > > > this case, I can just always go to 'input_a' when writing 'raw0'...
> > > > >  
> > > > > > However, I'm not 100% sure it really maps to this case.  What do  
> > > > you  
> > > > > > think?  
> > > > >
> > > > > I think it can work. Though out_voltageY_symbol probably needs  
> > to  
> > > > be  
> > > > > shared by type to be coherent with what we might have with  
> > TGPx.  
> > > >
> > > > That's fine.
> > > >  
> > > > > Note the sw_toggle register has a bit mask of the channels we  
> > want  
> > > > to  
> > > > > toggle which means we can toggle multiple channels at the same  
> > > > time.
> > > >
> > > > Using that wired up to buffer mode might make sense.  You'd  
> > provide  
> > > > multiple
> > > > buffers and allow channels to be selected into one of them at a  
> > time.  
> > > > Each
> > > > buffer is then tied to a different toggle (TGP0, TGP1, etc)
> > > >
> > > > The same could be true for the software toggle.  It'll get a bit fiddly
> > > > though.
> > > >
> > > > Perhaps this is an advanced feature to think about later...
> > > >  
> > > > > It works the same with TGPx if you map multiple channels to the  
> > > > same  
> > > > > pin.
> > > > >
> > > > > There's also the question on how to handle this if a TGPx is  
> > provided?  
> > > > > I guess it will just override the pin... But most likely having them  
> > both  
> > > > > at the same time will lead to non desired results (unless we have  
> > a  
> > > > > way to gate/ungate the clocks)...  
> > > > I don't follow this bit.  You mean TGPx and software toggle. As far  
> > as I  
> > > > can
> > > > tell it's an either/or thing per channel.
> > > >  
> > >
> > > Here I meant that if we have a TGPx pin bundled to some channel(s)  
> > we  
> > > do not want to also dance with the sw_toggle bit of that channel.  
> > Ultimately,  
> > > that's on the user responsibility but we could also add some guards I  
> > guess.  
> > > I'm not sure if it's an either/or thing per channel... IIUC, we spoke  
> > about  
> > > making dither and default mode the same. That might complicate  
> > things a bit  
> > > as:
> > >
> > > 1) We should not force a user to specify a TGPx pin for those  
> > channels (since  
> > > it can also work with dithering disabled).
> > > 2) Because of 1), we should also support sw_toggle for these  
> > channels since  
> > > someone might want to enable dither mode (at runtime) and the  
> > TGPx pin was  
> > > not given. Hence, we need to have a way to update the DAC using  
> > the sw_toggle.  
> > >
> > > Did I understood things wrong? One thing that comes to my mind, is  
> > to return  
> > > error (eg: EPERM or ENOTSUPP) if someone tries to enable dither  
> > mode and  
> > > no TGPx pin was selected for that channel? Hence, we do not need  
> > to add  
> > > the sw_toggle ABI  (out_voltage_symbol) for the default/dither  
> > mode. Or  
> > > maybe even better, we just expose the dither ABI if a TGPx pin is  
> > given over  
> > > dt (I try to explain the toggle/dither modes below; that might help  
> > you in  
> > > understanding my reasoning here)?
> > >
> > > Alternatively, we just keep the approach I have in this RFC and we  
> > keep the  
> > > 3 different modes (being mode a dt property; in the current state I'm  
> > using  
> > > a boolean to say a channel Is in toggle mode)... Maybe with the  
> > difference  
> > > that we allow sw_toggle for toggle enabled channels.  
> > 
> > The corner I'm not clear on is what we do if for example all TGPx pins
> > are
> > specified in DT.  Is the mapping from channel to TGPx things in toggle
> > mode
> > always a function of the external circuit or do we want to make it
> > runtime
> > controllable?
> > 
> > I'm absolutely fine if we just make it a dt property - particularly
> > as those TGPx pins may well not be visible to the host processor.
> > 
> > We probably do want to provide some options in dt for what they
> > might be
> > connnected to on the host.  I'm guessing potentially a gpio, or a clk?  
> 
> For each TGPx pin (from the point you bind it to some channel), I'm
> actually making it mandatory to have a clock (the reasoning being, if you 
> say some channel is controlled over TGPx [being for toggle or dither mode],
> you need to have some input at the pin).

I'm not really sure what the usecases behind toggle are...  Using a clock
with dither makes sense, but toggle might not be fixed frequency but
driven by some other type of event.

Still we don't have to support every usecase in an initial driver.
Stick to a clock and see what requests you get for other input types
later.

> 
> I might not be doing it in the way you're thinking but you can have a
> look in the actual series :) ...
> 

...



> > > > So conclusions.. Hmm. Not strong ones yet, but for dither mode at
> > > > least
> > > > I think you want to link particular channels to a TGPx choice
> > > >
> > > > out_voltage0_raw
> > > > out_voltage0_raw_available ( nice to have on DACs)  
> > >
> > > I guess here you mean 'IIO_AVAIL_RANGE'?  
> > 
> > No, I mean providing the read_avail() callback and setting
> > BIT(IIO_INFO_RAW) in info_mask_separate_available
> > 
> > That's how we provide range for a channel except in some unusual
> > corner cases and the internal interface for that is used when a DAC
> > is being used via the consumer interface (so some other driver wants
> > to set it's output).  
> 
> Yeah, I know :). I was just meaning 'IIO_AVAIL_RANGE' over 'IIO_AVAIL_LIST'.
> I guess that was already obvious to you :).

Ah.  Got you. I'd forgotten about that - indeed IIO_AVAIL_RANGE

> 
> > >  
> > > > out_voltage0_scale
> > > > out_voltage0_dither_raw
> > > > out_voltage0_dither_raw_available
> > > > out_voltage0_dither_frequency
> > > > out_voltage0_dither_frequency_available
> > > > out_voltage0_dither_phase
> > > > out_voltage0_dither_phase_available  
> > >  
> > > > Toggle mode is less clear to me but symbol approach plus TGPx in  
> > DT  
> > > > maybe works
> > > > You could allow for software override to set the symbol.  Interface  
> > to  
> > > > unset
> > > > it being to write an empty string to _symbol. Maybe leave that for
> > > > now.
> > > >
> > > > out_voltage0_raw0
> > > > out_voltage0_raw1
> > > > out_voltage0_scale
> > > > out_voltage0_symbol  
> > >
> > > Well, in short, I do agree with this ABI. And actually, for toggle mode,  
> > I think  
> > > this is more or less what we will have. For dither/default mode,  
> > there's still  
> > > the questions I raised above... Maybe, at the end, we will end up  
> > with 3 different  
> > > ABI's...  
> > 
> > Certainly possible.  Nice to avoid if we can, but not if it means
> > stretching
> > things too far.
> >   
> > >
> > > I would only add this to the ABI:
> > >  * out_voltage0_dither_en
> > >  * out_voltage0_toggle_en
> > >
> > > Because if someone wants to change, let's say the dither frequency,  
> > the best way  
> > > to update things is to first disable dithering, update all the stuff, and  
> > then enable  
> > > it again...  
> > 
> > I'll go with 'maybe' for these.  The use for changing things doesn't
> > make sense to me
> > unless we have multiple things to change at once.  If it's just the
> > frequency it
> > would be more intuitive to have a write to that attribute do the
> > disable, set value
> > and enable dithering again without needing to do a dance with the
> > interface.  
> 
> Yeah and that is something that can happen here (and probably the most
> likely situation). For dither mode, you disable it, then you might want to
> change all the parameters of your dither (amplitude, phase and frequency)
> and then enable it again.
> 
> For toggle mode, this means, disabling it, updating input_a and input_b and
> enable it again.
> 
> Anyways, I think we already have some discussion that enables me to send
> the first version of this and we can continue from there. If all goes well,
> it should be out by the end of the week.
> 
Great,

Jonathan

