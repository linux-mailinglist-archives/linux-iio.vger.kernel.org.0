Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C6468C7B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 18:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhLER6x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 5 Dec 2021 12:58:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57790 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhLER6x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:58:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D15446111B
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 17:55:25 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id EF7EAC00446;
        Sun,  5 Dec 2021 17:55:22 +0000 (UTC)
Date:   Sun, 5 Dec 2021 18:00:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] LTC2688 support
Message-ID: <20211205180033.23eb58b9@jic23-huawei>
In-Reply-To: <PH0PR03MB678687C50B21BD5E448E413699679@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
        <20211112161437.60dbc872@jic23-huawei>
        <PH0PR03MB6366BFFE85F122FED1B72BB499989@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20211121121756.2297671a@jic23-huawei>
        <PH0PR03MB678687C50B21BD5E448E413699679@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Nov 2021 14:43:25 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

Hi Nuno

Hopefully I've not lost the plot on this!

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, November 21, 2021 1:18 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio@vger.kernel.org
> > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > 
> > [External]
> > 
> > On Mon, 15 Nov 2021 10:28:51 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >   
> > > Hi Jonathan,
> > >
> > > Thanks for your inputs...
> > >  
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Friday, November 12, 2021 5:15 PM
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: linux-iio@vger.kernel.org
> > > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > > >
> > > > [External]
> > > >
> > > > On Thu, 11 Nov 2021 12:00:42 +0100
> > > > Nuno Sá <nuno.sa@analog.com> wrote:
> > > >
> > > > Hi Nuno,
> > > >  
> > > > > The reason why this is a RFC is because I'm still waiting for proper  
> > HW  
> > > > > to test this thing. The reason why I'm sending this already is  
> > because  
> > > > > there's some non usual features which might require extra ABI.  
> > > > Hence,  
> > > > > while waiting I thought we could already speed up the process in  
> > > > regards  
> > > > > with the ABI.  
> > > >
> > > > Wise move as this is an unusual beast :)
> > > >  
> > > > >
> > > > > I still pushed the driver but the intent here is not really to review  
> > it.  
> > > > > Naturally, if someone already wants to give some feedback,  
> > that's  
> > > > very  
> > > > > much appreciated :)  
> > > >  
> > > > >
> > > > > Now, there are three main interfaces depending on the channel  
> > > > mode:  
> > > > >  1) default (no new ABI)
> > > > >  2) toggle mode
> > > > >  3) dither mode
> > > > >
> > > > > The channel mode will be a devicetree property as it does not  
> > really  
> > > > > make much sense to change between modes at runtime even  
> > more  
> > > > because the  
> > > > > piece of HW we might want to control with a channel might be  
> > > > different  
> > > > > depending on the selected mode (I'm fairly sure on this between  
> > > > toggle  
> > > > > and other modes but not so sure between dither and default  
> > mode).  
> > > >
> > > > I agree on toggle vs dither definitely being different, but normal  
> > you  
> > > > could implement either as software toggle, or dither with a 0
> > > > magnitude
> > > > sine wave.  So might not be worth implementing default mode at  
> > all.  
> > > > No harm in doing so though if there are advantages to having it.  
> > >
> > > My feeling is that we could probably have dither as the "default  
> > mode".  
> > > More on this below...
> > >  
> > > > >
> > > > > toggle mode special ABI:
> > > > >
> > > > >  * Toggle operation enables fast switching of a DAC output  
> > between  
> > > > two  
> > > > > different DAC codes without any SPI transaction. Two codes are  
> > set  
> > > > in  
> > > > > input_a and input_b and then the output switches according to  
> > an  
> > > > input  
> > > > > signal (input_a -> clk high; input_b -> clk low).
> > > > >
> > > > > out_voltageY_input_register
> > > > >  - selects between input_a and input_b. After selecting one  
> > register,  
> > > > we  
> > > > >    can write the dac code in out_voltageY_raw.
> > > > > out_voltageY_toggle_en
> > > > >  - Disable/Enable toggle mode. The reason why I think this one is
> > > > >    important is because if we wanna change the 2 codes, we  
> > should  
> > > > first  
> > > > >    disable this, set the codes and only then enable the mode  
> > back...  
> > > > >    As I'm writing this, It kind of came to me that we can probably
> > > > >    achieve this with out_voltageY_powerdown attr (maybe takes a  
> > bit  
> > > > more  
> > > > >    time to see the outputs but...)  
> > > >
> > > > Hmm. These corner cases always take a bit of figuring out.  What  
> > you  
> > > > have
> > > > here is a bit 'device specific' for my liking.
> > > >
> > > > So there is precedence for ABI in this area, on the frequency  
> > devices  
> > > > but only
> > > > for devices we still haven't moved out of staging.  For those we
> > > > needed a means
> > > > to define selectable phases for PSK - where the selection was  
> > either  
> > > > software or,
> > > > much like here, a selection pin.
> > > >
> > > > out_altvotage0_phase0 etc
> > > >
> > > > so I guess the equivalent here would be
> > > > out_voltageY_raw0
> > > > out_voltageY_raw1
> > > > and the selection would be via something like
> > > > out_voltageY_symbol (0 or 1 in this case). - note this is only
> > > > relevant if you have the software toggle. Any enable needed for
> > > > setting
> > > > can be done as part of the write sequence for the  raw0 / raw1 and
> > > > should
> > > > ideally not be exposed to userspace (controls that require manual
> > > > sequencing
> > > > tend to be hard to use / document).  
> > >
> > > Yeah, I thought about that. I was even thinking in having something  
> > like  
> > > *_amplitude for dither mode. In some cases, where we might be left
> > > in some non obvious state (eg: moved the select register to input b  
> > and  
> > > then we failed to set the code;), I prefer to leave things as flexible as
> > > possible for userspace. But I agree it adds up more complexity and in
> > > this case, I can just always go to 'input_a' when writing 'raw0'...
> > >  
> > > > However, I'm not 100% sure it really maps to this case.  What do  
> > you  
> > > > think?  
> > >
> > > I think it can work. Though out_voltageY_symbol probably needs to  
> > be  
> > > shared by type to be coherent with what we might have with TGPx.  
> > 
> > That's fine.
> >   
> > > Note the sw_toggle register has a bit mask of the channels we want  
> > to  
> > > toggle which means we can toggle multiple channels at the same  
> > time.
> > 
> > Using that wired up to buffer mode might make sense.  You'd provide
> > multiple
> > buffers and allow channels to be selected into one of them at a time.
> > Each
> > buffer is then tied to a different toggle (TGP0, TGP1, etc)
> > 
> > The same could be true for the software toggle.  It'll get a bit fiddly
> > though.
> > 
> > Perhaps this is an advanced feature to think about later...
> >   
> > > It works the same with TGPx if you map multiple channels to the  
> > same  
> > > pin.
> > >
> > > There's also the question on how to handle this if a TGPx is provided?
> > > I guess it will just override the pin... But most likely having them both
> > > at the same time will lead to non desired results (unless we have a
> > > way to gate/ungate the clocks)...  
> > I don't follow this bit.  You mean TGPx and software toggle. As far as I
> > can
> > tell it's an either/or thing per channel.
> >   
> 
> Here I meant that if we have a TGPx pin bundled to some channel(s) we
> do not want to also dance with the sw_toggle bit of that channel. Ultimately,
> that's on the user responsibility but we could also add some guards I guess.
> I'm not sure if it's an either/or thing per channel... IIUC, we spoke about
> making dither and default mode the same. That might complicate things a bit
> as:
> 
> 1) We should not force a user to specify a TGPx pin for those channels (since
> it can also work with dithering disabled).
> 2) Because of 1), we should also support sw_toggle for these channels since
> someone might want to enable dither mode (at runtime) and the TGPx pin was
> not given. Hence, we need to have a way to update the DAC using the sw_toggle.
> 
> Did I understood things wrong? One thing that comes to my mind, is to return
> error (eg: EPERM or ENOTSUPP) if someone tries to enable dither mode and
> no TGPx pin was selected for that channel? Hence, we do not need to add
> the sw_toggle ABI  (out_voltage_symbol) for the default/dither mode. Or
> maybe even better, we just expose the dither ABI if a TGPx pin is given over
> dt (I try to explain the toggle/dither modes below; that might help you in
> understanding my reasoning here)?
> 
> Alternatively, we just keep the approach I have in this RFC and we keep the
> 3 different modes (being mode a dt property; in the current state I'm using
> a boolean to say a channel Is in toggle mode)... Maybe with the difference
> that we allow sw_toggle for toggle enabled channels.

The corner I'm not clear on is what we do if for example all TGPx pins are
specified in DT.  Is the mapping from channel to TGPx things in toggle mode
always a function of the external circuit or do we want to make it runtime
controllable?

I'm absolutely fine if we just make it a dt property - particularly
as those TGPx pins may well not be visible to the host processor.

We probably do want to provide some options in dt for what they might be
connnected to on the host.  I'm guessing potentially a gpio, or a clk?

You could also wire them to a non general purpose output pin - but that
would be really hard to describe in a generic fashion.

> 
> > >  
> > > > I'm not sure if whether a channel is in toggle mode is a circuit thing  
> > or  
> > > > not..
> > > > (and hence DT or userspace control?)  
> > >
> > > The only reason I can think off to have it as DT is that toggle mode  
> > seems  
> > > to be for more specific use cases so I guess the HW we want to  
> > control (  
> > > and connect to a toggle enabled channel) will be different.
> > >
> > > I'm also not seeing an use case for ping ponging between the modes  
> > mostly  
> > > because of the above...  
> > 
> > Only use I can see is to reduce traffic if you happen to be switching
> > between
> > two sets of DAC outputs repeatedly. If there wasn't an LDAC pin I'd
> > suspect
> > this was there to enable simultaneous updates but we have that
> > anyway.
> > Maybe if the LDAC isn't wired this could be used to provide similar
> > functionality?  If that's the case, we could just leave it as a possible
> > TODO if anyone wants it in future...
> > I think you could use the TGPx to provide controlled switching of
> > sets of channels.  Maybe that's something useful?  
> 
> Hmm, I think LDAC is something else. The LDAC pin updates all 16 channels
> with the value of the input register (which I assume is INPUT_A) independent
> of them being in dither/toggle mode. Honestly, I'm not even sure of how
> thing would work if someone plays with LDAC + channels in dither/toggle
> mode. I think extra care would be needed...

My guess was as that in toggle mode at least, LDAC would update the DACs to
reflect the 'current' toggle registers, but I'm not totally sure.

> 
> So, TGPx pins are indeed used to control set of channels. But note that these
> pins (as sw_toggle) are only meaningful if the channel is in dither or toggle
> mode (the channel bit in the toggle/dither enable register has to be set):

Agreed, though note that we could ensure we always were in one of these modes
if it made sense from software point of view.

> 
> * In toggle mode we have two set of input registers: INPUT_A and INPUT_B
> and we toggle between these two values. If we wire a TGPx pin and bundle
> it to a toggle enabled channel, when the input signal is high, we output INPUT_A
> and INPUT_B when the signal is low. We can mimic the same behavior by writing
> 1/0 to the sw_toggle register.

There are different ways you could use this facility if you assume the TGPx pins
are wired to the host processor rather than something out of our control.

You could use it for double buffering for example - so update INPUT_B, then toggle,
update INPUT_A then toggle etc.
Or you could assume it's for mass mode switching - so there are only two values
that will ever be set and these reflect something in the external circuits. We
might not even have software control / visibility of which state is active.

> * In dither mode, things are slightly different as INPUT_B is the value for the
> sinusoidal amplitude. And if we have an external signal on a TGPx pin, the dac
> channel is updated on the rising edge of the signal. Again, we can mimic the same
> behavior with the sw_toggle register.  
> 
> So, for dither mode, I'm not really seeing why someone would want to use the
> sw_toggle. Even for toggle mode, I have my doubts but I can more easily see it.

Does seem unlikely for dither mode as you'd need a huge amount of bus traffic
to basically provide a bad clock signal.  Toggle I can also sort of see
being useful with sw_toggle - but suspect real usecase for that is the one
where the host processor isn't controlling the toggle..

> 
> > >  
> > > > Can see that even in a case where you did want to use external
> > > > controls to
> > > > pick the values, you might also want to override from software...
> > > > Given there is a software toggle I guess we can use that as  
> > override.  
> > > > Actually that raises the question of what the point in having normal
> > > > mode is?
> > > > Can we just implement that as a software toggle toggle mode? One
> > > > less thing to
> > > > worry about if we can.  
> > >
> > > I did thought about the sw_toggle thing (it's something that is only  
> > valid  
> > > for channels in dither/toggle mode). My reasoning was that either
> > >
> > > 1) I did not supported it and made the TGPx selection mandatory (in  
> > case  
> > > dither/toggle mode enabled) or
> > > 2) I did support it  and hence the pins  are not really mandatory.
> > >
> > > I went with 1) because, honestly, I'm not seeing the point of having  
> > these  
> > > modes and use sw toggle (at least on a production system).  
> > However, if we  
> > > want to get rid of the default mode and have it as the dither mode, I  
> > agree  
> > > we need sw_toggle because If someone just wants to use the  
> > channel  
> > > without any dithering, we can't have an hard requirement to provide  
> > a  
> > > external TGPx. Moreover, if the default channel will be a dither  
> > capable  
> > > one, we need to provide full functionality and hence, sw_toggle.
> > >
> > > As I stated before, I'm just not sure on how to handle things if a TGPx  
> > is  
> > > also provided. Maybe they should be mutual exclusive? I mean, if  
> > someone  
> > > tries to toggle a channel with a mapped TGPx we return some error  
> > code?
> > 
> > Given the mapping of TGPx to channel is a software control I think
> > ultimately
> > you'd want to expose that - one way I can think of doing that is via
> > the buffer interface.
> > 
> > 4x buffers.  One of each TGP0,1,2 and SW toggle.  Enable the channels
> > you
> > want for a given 'buffer' and then they will switch together based on
> > the
> > data in the buffer.  If the buffer has a series of toggling values then
> > it's simple - if not then after each toggle the buffer would need to
> > preload
> > the next value.  The snag there is that you'd need to know a toggle
> > occurred
> > and if the toggle pins are wired to somewhere other than our host I'm
> > not sure
> > how you would know that in general? (could wire the same TGPx signal
> > to an
> > interrupt on the host controller but seems unlikely).  
> 
> Honestly I think that we would be probably over engineering things with
> this even though I get your point. OTOH, as you said, the triggering would
> be very hacky to handle and that might already tell us something :)

It may well make sense to only implement a subset but it is often useful
to walk through what a more sophisticated feature set might look like
as then we don't accidentally rule it out.

>  
> > Whether software toggle is worth bothering when we have LDAC to
> > control
> > simultaneous DAC updates isn't clear to me.  I guess it's fewer writes  
> 
> Hopefully I could make it clear that sw_toggle is something else than LDAC :)
> 
> > if we happen to be cycling between values.  Perhaps you are right and
> > that
> > feature is just for debug.
> >   
> > >  
> > > > There is also the question of whether selection of which toggle pin  
> > is  
> > > > used
> > > > should be a dt thing or a userspace control...  
> > >
> > > Well, this definitely means some HW wiring to have the external  
> > signals and  
> > > I'm not sure if there's any added valuable in being able to change the
> > > external signal at runtime?  
> > 
> > Whilst I can conjecture reasons to do this, you may well be right - real
> > usecases will know which signal groups they want to control together.
> >   
> > >  
> > > > >
> > > > > dither mode special ABI:
> > > > >
> > > > >  * Dither operation adds a small sinusoidal wave to the digital DAC
> > > > > signal path. Dithering is a signal processing technique that  
> > involves  
> > > > > the injection of ac noise to the signal path to reduce system
> > > > > nonlinearities.
> > > > >  
> > > >
> > > > This is a complex feature to describe as (if I read it correctly) we  
> > have  
> > > > a dither clocked from an external pin, or in theory from software.  
> > That  
> > > > clock
> > > > frequency must match the dither.  Realistically that means it is a  
> > clock  
> > > > in our control or we have to match the period below to the  
> > frequency  
> > > > of that
> > > > clock.  
> > >
> > > Yeah, the frequency  of the dither signal is fsig = fclk / N, where N can  
> > only  
> > > be: [4 8 16 32 64]. So, we kind of just have these available options for  
> > the  
> > > signal frequency and fclk is something we can control and know  
> > (assuming  
> > > we have TGPx mapping which I'm bundling with a clk).
> > >
> > > The only quirk with having this with frequency rather than raw N is
> > > to handle the sw_toggle where we have no idea about fclk? We  
> > could also  
> > > think of this attr as some kind of decimation...  
> > 
> > Does seems unlikely anyone would use dither with a sw toggle.
> > Perhaps best plan here is to not support that combination.  
> 
> Agree... But there are some subtleties that we need to settle 
> about the channel default mode as I raised in my previous comments.
> 
> > As to the clock, these are about controlling a sine wave frequency. I'm
> > not sure
> > decimation fits as a model. (figure 19)
> > 
> > Given you know the input clock, perhaps present this as something like
> > out_voltage0_dither_frequency
> > 
> > I don't thing dithers are always this simple, so probably want to be
> > specific its
> > a sine wave so maybe we need
> > out_voltage0_dither_type 'sine'
> > 
> > We used to have some DDS chips in staging but looks like they all got
> > dropped due
> > to end of time Those had various waveforms and IIRC all we came up
> > with was
> > descriptive terms + frequencies and magnitudes.
> > 
> >   
> > >  
> > > > > out_voltage0_dither_en
> > > > >  - Same as in toggle mode.
> > > > > out_voltage0_dither_period
> > > > > out_voltage0_dither_phase
> > > > >  - Period and phase of the signal. Only some values are valid so  
> > > > there's  
> > > > >    also *_available files for these. I'm not sure if we can use the  
> > more  
> > > > >    generic IIO_CHAN_INFO_PHASE and  
> > IIO_CHAN_INFO_FREQUENCY  
> > > > here as these  
> > > > >    parameters don't really apply to the channel output signal..  
> > > >
> > > > Possibly not helpful to do so, but you could describe the channel as  
> > an  
> > > > out_altvoltage channel that happens to have a significant offset  
> > (the  
> > > > DC
> > > > level) and phase, frequency etc as for a normal altvoltage channel.
> > > > That would hide the intention here though so perhaps not a good  
> > plan  
> > > > even if it ensures we end up with standard ABI.  
> > >
> > > I think altvoltage might not be optimal here  because the phase and  
> > frequency  
> > > are really not characteristics of the output signal of the channel.  
> > 
> > Well they kind of are if you set the magnitude high enough  - but I get
> > your
> > point.  That's not how they are intended to be used.
> >   
> > >  
> > > > > out_voltage0_input_register
> > > > >  - Same as in toggle mode. However in this mode the code set in  
> > the  
> > > > >    input_b register has a special meaning. It's the amplitude of the
> > > > >    dither signal.  
> > > > Don't do that - provide a direct attribute representing the value of
> > > > register_b and when it is written implicitly switch to the right  
> > register.  
> > > > Any ABI that requires a sequence of events is hard to use.  
> > >
> > > I guess we can just use the same raw1 attr here? Even though, in  
> > dither  
> > > mode this has special meaning (it is the amplitude)...  
> > 
> > I was thinking toggle mode here. This interface doesn't work for dither.
> > in that case there is just
> > out_voltage0_raw for the DC part and
> > out_voltage0_dither_raw for the dither amplitude.  Assumption being
> > same scaling
> > as I don't really want to support multiple scale factors if we can avoid it.  
> 
> I'm fairly sure it is the same scaling....

As long as it's a simple factor, just hit it with a 'small adjusting tool'
until it does have the same scaling.  We do that in a few similar cases
IIRC as sometimes things like this dither input have lower resolution.

If it's the same scaling then you won't have to hit it at all ;)

> 
> > 
> >   
> > >  
> > > >  
> > > > >
> > > > > One special mention to the dac scale. In this part this is something
> > > > > that can be purely controlled by SW so that I'm allowing  
> > userspace to  
> > > > > change it rather then having it in dts. The available scales are:
> > > > >
> > > > > * [0 5V] -> offset 0
> > > > > * [0 10V] -> offset 0
> > > > > * [-5 5V] -> offset -32678
> > > > > * [-10 10V] -> offset -32768
> > > > > * [-15 15V] -> offset -32768
> > > > >
> > > > > With the above, we also need to have the offset configurable  
> > and  
> > > > right  
> > > > > now I'm going to some trouble to make sure the scale + offset is
> > > > > something valid. Honestly, I think I'm overdoing it because things  
> > can  
> > > > > still go wrong with [0 10V] and [-5 5V] as the scales are the same
> > > > > here. Furthermore, there's no real arm that can be done to the  
> > HW.  
> > > > Is  
> > > > > just that the readings won't match with what someone might be  
> > > > expecting.  
> > > > > My plan is to just remove those checks and assume is up to  
> > > > userspace to  
> > > > > make it right and not have [-10 10V] scale with 0 offset for  
> > example.  
> > > >
> > > > So this is something we've debated a few times in the past.
> > > > There is a fairly strong argument for output devices that the range  
> > is  
> > > > a characteristic of the circuit.  At the very least it makes sense to
> > > > restrict it in DT even if we allow safe forms of tweaking in the  
> > driver.  
> > > > For an initial driver, I'd just have it in DT.
> > > >  
> > >
> > > No complaints against that and makes things way simpler to handle.  
> > Great.  
> > >
> > > - Nuno Sá
> > >  
> > So conclusions.. Hmm. Not strong ones yet, but for dither mode at
> > least
> > I think you want to link particular channels to a TGPx choice
> > 
> > out_voltage0_raw
> > out_voltage0_raw_available ( nice to have on DACs)  
> 
> I guess here you mean 'IIO_AVAIL_RANGE'?

No, I mean providing the read_avail() callback and setting
BIT(IIO_INFO_RAW) in info_mask_separate_available

That's how we provide range for a channel except in some unusual
corner cases and the internal interface for that is used when a DAC
is being used via the consumer interface (so some other driver wants
to set it's output).

> 
> > out_voltage0_scale
> > out_voltage0_dither_raw
> > out_voltage0_dither_raw_available
> > out_voltage0_dither_frequency
> > out_voltage0_dither_frequency_available
> > out_voltage0_dither_phase
> > out_voltage0_dither_phase_available  
> 
> > Toggle mode is less clear to me but symbol approach plus TGPx in DT
> > maybe works
> > You could allow for software override to set the symbol.  Interface to
> > unset
> > it being to write an empty string to _symbol. Maybe leave that for
> > now.
> > 
> > out_voltage0_raw0
> > out_voltage0_raw1
> > out_voltage0_scale
> > out_voltage0_symbol  
> 
> Well, in short, I do agree with this ABI. And actually, for toggle mode, I think
> this is more or less what we will have. For dither/default mode, there's still
> the questions I raised above... Maybe, at the end, we will end up with 3 different
> ABI's...

Certainly possible.  Nice to avoid if we can, but not if it means stretching
things too far.

> 
> I would only add this to the ABI:
>  * out_voltage0_dither_en
>  * out_voltage0_toggle_en
> 
> Because if someone wants to change, let's say the dither frequency, the best way
> to update things is to first disable dithering, update all the stuff, and then enable
> it again...

I'll go with 'maybe' for these.  The use for changing things doesn't make sense to me
unless we have multiple things to change at once.  If it's just the frequency it
would be more intuitive to have a write to that attribute do the disable, set value
and enable dithering again without needing to do a dance with the interface.

I'm not sure when updating needs to be done atomically across the various variables (so
would need to be done under a single disable / enable sequence.

> 
> - Nuno Sá

