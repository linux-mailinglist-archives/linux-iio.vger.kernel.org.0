Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B146F5ED9
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 12:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfKIL60 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 06:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKIL60 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 06:58:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB90207FF;
        Sat,  9 Nov 2019 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573300704;
        bh=hZ1J6HrrnUGSjX4frS3+KSlokotKWdJcsrmQthRMfwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MvJyfp5WF6dBmwqmSe85Ih6DZuukmu0aXo+O/2PoMzcNpvlWJ6wOY4uuPOaGBP9aO
         2FSkTmhxkRwyReUlv/2SNSibH+0CqpxvkJH7tjrSOGb0/03dUBG5viVIpXrrQbqJSa
         RB4CkqCiHrYjBZBFqWrgFev8EDr5a2ICDXN6EU30=
Date:   Sat, 9 Nov 2019 11:58:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: ad7949: fix channels mixups
Message-ID: <20191109115819.4130dff5@archlinux>
In-Reply-To: <CAN8YU5NEaXrGJBGmDxZB5uxQQ5XoyUFLscgFAVKCCK3oKHwGQQ@mail.gmail.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
        <20190912144310.7458-5-andrea.merello@gmail.com>
        <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
        <CAN8YU5NLZhCDaocrQGUnb9TZauT-yPxY7ZQQQeYK=9696jmhCg@mail.gmail.com>
        <4a25469a-9fe6-a560-b1cb-e9b0af7209e9@essensium.com>
        <CAN8YU5ORoM69GDi4VVGf6iWb3A2S1ZjkiLmcV+_hUbG4446yXQ@mail.gmail.com>
        <20190921181253.43fa0071@archlinux>
        <CAN8YU5O5ouLXnpi=f1jHfbbVXGjtFOT00cG+fggWWbxDco111w@mail.gmail.com>
        <20191005105534.1a3f077f@archlinux>
        <CAN8YU5PRO5Y5EeEj2SZGm5XfuKSB1rtS7nKdu6wWxXYDOfexqw@mail.gmail.com>
        <20191022095621.6b4c550e@archlinux>
        <CAN8YU5NEaXrGJBGmDxZB5uxQQ5XoyUFLscgFAVKCCK3oKHwGQQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Nov 2019 15:12:09 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno mar 22 ott 2019 alle ore 10:56 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Fri, 18 Oct 2019 15:30:17 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > Il giorno sab 5 ott 2019 alle ore 11:55 Jonathan Cameron <jic23@kernel.org>
> > > ha scritto:  
> > > >
> > > > On Mon, 23 Sep 2019 10:21:49 +0200
> > > > Andrea Merello <andrea.merello@gmail.com> wrote:
> > > >  
> > > > > Il giorno sab 21 set 2019 alle ore 19:12 Jonathan Cameron
> > > > > <jic23@kernel.org> ha scritto:
> > > > >  
> > > > > > >
> > > > > > > If we skip the configuration rewrite when the channel doesn't  
> > > change -  
> > > > > > > as discussed above - then we actually _terminate_ the acquisition  
> > > when  
> > > > > > > the IIO read is triggered, that is we are converting the value  
> > > sampled  
> > > > > > > right before the IIO read.
> > > > > > >
> > > > > > > If this is OK then I'll go on, otherwise I think that we should  
> > > always  
> > > > > > > do the three cycles (so that triggering IIO read always waits also  
> > > for  
> > > > > > > a new acquisition phase)  
> > > > >
> > > > > I had a discussion about this with a HW engineer, he said that it's
> > > > > probably not necessary to perform a full extra cycle (i.e. SPI xfer +
> > > > > udelay(2)), rather, since the HW is already in acquisition, it should
> > > > > be enough to perform the udelay(2) to make sure the internal capacitor
> > > > > settles (if we change channel of course we need also the SPI xfer to
> > > > > update the CFG).
> > > > >
> > > > > So indeed it seems to me that:
> > > > > - if CFG (channel) changes: we need three full SPI xfer (actual SPI
> > > > > xfer + delay(2))
> > > > > - if CFG (channel) doesn't change: we need a delay(2) [*]- to
> > > > > guarantee the user sees a value sampled after the IIO read, as
> > > > > discussed - and two full SPI xfer (actual SPI xfer + delay(2))
> > > > >
> > > > > .. Indeed I also wonder if it would be enough to cycle the CS, without
> > > > > performing a full SPI xfer, in order to start the conversion.. But
> > > > > given that this whole thing seems to me a bit complicated and unclear,
> > > > > I would stick to the dummy cycle for now..
> > > > >  
> > > > > > An excellent point.  I agree and suspect we may have this wrong in  
> > > other  
> > > > > > sensors.  The question gets more interesting if running in buffered  
> > > mode  
> > > > > > as we have had systems using a trigger generated by an external  
> > > process.  
> > > > > > I suppose in that case we just have to deal with the offset in the  
> > > fifo  
> > > > > > etc in userspace.  
> > > > >
> > > > > Yes. I'm not familiar with IIO buffered mode, but for a streaming,
> > > > > continuous, read mode I guess that the user would expect some latency
> > > > > anyway (might be due to the ADC or the buffering mechanism itself or
> > > > > whatever).  
> > > >
> > > > There are a few ugly corners.
> > > > 1) They'd normally expect the timestamp to be as closely aligned as
> > > > possible with the reading in a given scan.  Perhaps we can think about
> > > > how to offset that if we know we are actually looking at the one before
> > > > last...  
> > >
> > > Maybe we could sample the timestamp whenever we start a conversion (end of
> > > SPI XFER), then we use this information for timestamping the value we'll
> > > read at the next SPI xfer (that is the outcome of the said conversion).
> > > Maybe we can also subtract, say, half of the acquisition time to each
> > > timestemp to better center it on the actual acquisition window..  
> >
> > I originally had a plan to 'accurately' describe time offsets so that
> > we could deal with the difference between devices that are self clocked
> > (the interrupt is after the samples are done) and devices that are
> > capture on demand.  It never got implemented though as it seems no one
> > ever cared :)
> >
> > As for shifting the timestamp to reflect and earlier triggered capture
> > (so running a small fifo for the timestamps), that seems like a
> > sensible approach to keeping timestamp and sample together.
> >  
> > >  
> > > > 2) There are tightly coupled setups where we are switching a mux in
> > > > front of the sensor and driving a trigger off that action.
> > > >                                                 _________
> > > >  _________           |--------MUX CNTRL--------|         |
> > > > |         |        __|__        ---TRIGGER-----|         |
> > > > | INPUT 1 |-------|     |     __|__            |         |
> > > > |_________|       |     |    |     |           |   HOST  |
> > > >  _________        | MUX |----| ADC |-----------|         |
> > > > |         |       |     |    |_____|           |         |
> > > > | INPUT 2 |-------|_____|                      |_________|
> > > > |_________|
> > > >
> > > > This gets represented as a single 'device' that is a consumer
> > > > of the ADC channel, and also provides the trigger and handles
> > > > the mux control.
> > > >
> > > > Once you have stitched it all together the expectation is that
> > > > for each 'scan':
> > > > 1. Set MUX
> > > > 2. Allow short settling time  
> > >
> > > Indeed my concern about begin vs end of acquisition window wrt switching
> > > time of the external mux could possibly be worked-around by just increasing
> > > settling time here. I also indeed agree wrt what you say below about sysfs
> > > [*].
> > >
> > > So probably we don't need to worry about this at all in the chip driver.
> > >  
> > > > 3. Trigger the ADC via gpio or SPI triggered read etc.
> > > > 4. ADC result comes back.
> > > > 5. Goto 1.
> > > >
> > > > The full set of inputs are sampled to make up one 'scan' in
> > > > the buffer of the container driver.
> > > >
> > > > Now in theory you could interleave the flows so that you know
> > > > the data is coming 2 scan's later, but there isn't currently
> > > > a way for the 'container' driver to know that is happening,
> > > > so the assumption it makes is that everything is 'direct'.
> > > >
> > > > We could add some means of reporting an offset from trigger
> > > > to sample into fifo as that would allow such a container
> > > > driver to adjust it's mux settings to take that into account.
> > > >
> > > > Note that out container driver also often has it's own
> > > > capture trigger coming in so it can get really fiddly as
> > > > we don't have any way of knowing if we are in a round robin
> > > > situation or just taking a single 'scan'. In single scan
> > > > case we want to drop the excess reads from the end, in round robin
> > > > we want to keep them as they are the start of the next scan.  
> > >
> > > Yes, that's what we want. But it seems we cannot easily distinguish the two
> > > cases.
> > >
> > > The only thing I can think about to handle this is to take into account the
> > > samples ageing, and use excess samples for the next scan vs throwing them
> > > away depending on that. But there's the problem of choosing a threshold..
> > >
> > > BTW Maybe if this is handled in the ADC driver then it may also adjust
> > > things so that all is transparent to upper layers, even getting rid of the
> > > offset.  
> >
> > It could be done in the ADC driver, but the cost would be that it would
> > have to run sufficient samples to ensure we are always 'fresh'.  That
> > is going to kill the sampling rate.   As things stand we have no way
> > of letting the ADC driver know that this is even desired.
> >  
> > >  
> > > > >
> > > > > I didn't look into this buffered thing to see how it works, but maybe
> > > > > we can skip the first udelay(2) [*] in the driver in case of buffered
> > > > > access?
> > > > >  
> > > > > > Maybe we should think about adding a note to be careful of that.  Not
> > > > > > really sure where we would note it though...  
> > > > >
> > > > > IMHO clarifying what the API guarantees and what it doesn't in IIO
> > > > > DocBook could be helpful (I didn't see it, but I might have missed
> > > > > it)..  
> > > > I agree we should clarify it, but I'm still not totally sure what the
> > > > preferred case is! Perhaps best plan is to put forward a patch to add
> > > > a description of one of the choices as we can push people to review
> > > > that closely as it may mean devices don't comply with the ABI.
> > > >
> > > > There is a 3rd option which is to add the option for devices to describe
> > > > what they are doing via a new sysfs attribute.  That may get us
> > > > around causing potential breakage in drivers that are already doing it
> > > > the 'wrong' way.  
> > >
> > > This would be implicit if we make them reporting the offset: a zero offset
> > > means they behave in the simple, plain, way..
> > >
> > > We might also want to be able to set it, so that if we do sparse single-shot
> > > scans we can ask the driver to provide data in the way we expect it.  
> >
> > Certainly a fiddly corner case.  If this had always been present we could
> > just have made it up to the consumer to deal with the offset.  If it wants
> > a single shot reading, it would just have to do N repeated readings to
> > flush out the ADC pipeline.   Too late for that though.  So we would have
> > to default to handling in the driver, and allow for it to be set to
> > an offset for high sampling rate users who know how to handle it.
> > (new userspace).
> >
> >  
> > >  
> > > > >
> > > > > So, we could state that a single shot read must return a value sampled
> > > > > after the read has been shot, and that on the other hand, when using
> > > > > buffered mode one should expect some latency.. But indeed, since you
> > > > > said that we might have a number of IIO drivers that actually behave
> > > > > in a different way, then I'm not sure that it's a good idea; maybe we
> > > > > could just drop this requirement and allow (and document) that a
> > > > > single shot IIO read could just _terminate_ the sampling and trigger
> > > > > the conversion on the current sampled signal? (so also in this driver
> > > > > we can just not care about this)..  
> > > >
> > > > I don't think we need to worry about the difference between a sample
> > > > window stopping vs one starting at the trigger.  Right now we don't
> > > > even say how long that window is, so a naive assumption would be that
> > > > we model it as instantaneous.  For single shot either model is
> > > > fine to my mind. We get the nearest practical signal to the point
> > > > of reading.  The sysfs interface is slow enough that any fine
> > > > grained control of timing is likely to be garbage anyway :)  
> > >
> > > [*]
> > >  
> > > > The only exception would be really slow sensors such as light sensors
> > > > where we might be talking 100s of msecs.  In those I'd argue
> > > > we do want the capture to start only after we ask.  I think we are
> > > > fine on existing drivers for those.  
> > >
> > > BTW Indeed the original patch tried to cover also another aspect of the
> > > thing: when I read e.g. in_voltage2_raw from sysfs, I guess I really want
> > > to be sure that I'm reading (rasonably fresh) data from channel number 2. I
> > > guess
> > > that if another process did read in_voltage3_raw before me, I still want to
> > > be sure I'm getting data from ch 2, not 3.
> > >
> > > IMO the offset thing make sense only on scans performed by buffered reads,
> > > in which you configure a scan sequence and you are somehow interested in
> > > getting data from all those channels (note: the driver targeted by the patch
> > > does support only raw_read()).  
> >
> > Absolutely agree.  This stuff only applies to more complex drivers doing
> > buffered mode in which we have some assumptions of 'continuous' sampling.
> >  
> > >
> > > Also, getting back to the former example, I don't know how the container
> > > driver accesses the ADC driver (buffered vs raw_read), but I bet that, as a
> > > consumer of one ADC channel, it really wants samples from the said channel
> > > (internal MUX), and not from another.  
> >
> > Uses buffered mode, which is why triggers are involved. However, if it had
> > the information, the consumer could basically pass through the delay to
> > userspace.  So if it gets the data 2 samples late, it would tell userspace that
> > it will provide it two samples late as well.  
> > >
> > > So making sure the internal MUX is adjusted at every raw_read() IMO seems
> > > still the right thing to do.. Still, I'm unsure if the whole thing of
> > > excess reads makes sense here, or if we can just optimize only buffered
> > > reads.  
> >
> > Definitely only optimize buffered reads.  The sysfs ones are slow anyway
> > so no need to be clever!  We just burn samples to get the right thing.
> >
> > I'm now completely lost on where we got to with the actual change in this
> > driver.  Seem's Charles wasn't convinced yet (or lost track of the thread).
> > Perhaps a repost with the example that you gave of the sequence you were
> > seeing?
> >
> > Definitely went down a rabbit hole here! :)  
> 
> Yes, Indeed I also got a bit out of focus here :) let me recap a bit:
> 
> The original patch aimed to just fix the sysfs read (the only thing
> this driver currently supports) so that the resulting value really
> belongs to the requested channel. On my board this was not the case,
> because to make the internal mux to switch I needed an extra cycle, so
> the patch made this happening.
> 
> As per my understanding (please correct me if I got something wrong)
> then the outcome of our discussions about this is that we don't have
> to care about i.e. start of acquisition window wrt end of the
> acquisition window; so, ensuring that we are converting from the right
> channel, and the data is reasonably fresh (i.e. it is not the outcome
> of an extra read performed in an undefined past) should be OK.
I don't think reasonably fresh is good enough.  It needs to occur
'after' the request is made to read it.   Thus userspace nasty controls
of an external mux could set the mux and then trigger the read, safe
in the assumption that if they leave the mux alone until they get
a value they are safe.

> 
> As you said, Charles reported that he didn't face this issue. As per
> your suggestion, I will repost with the example, to see if Charles or
> someone else can reproduce the bug.
That would be great.  Certainly curious that it's not repeating consistently.
> 
> Apart of this, I'd say that most of what we have discussed indeed
> don't apply to the current driver yet.
True enough ;)

Thanks,

Jonathan
> 
> > Jonathan  
> > >  
> > > > Thanks,
> > > >
> > > > Jonathan
> > > >  
> > > > >  
> > > > > > Thanks,
> > > > > >
> > > > > > Jonathan
> > > > > >
> > > > > >  
> > > >  
> >  

