Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C614AAB0C
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 19:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381008AbiBESte (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 13:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348137AbiBEStd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2022 13:49:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E63C061348
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 10:49:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2780B8076E
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 18:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2263AC340E8;
        Sat,  5 Feb 2022 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644086969;
        bh=0osy3LA9Q9fspP/Sec2yxR3K/g3GVDK4B1npw6wTWqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uPCo1n1LZbWvDXWwP1CypM3sTI9uKNy/VmrymD6SZ5BUhWvnJrxHD1pnzZRwZFdZa
         a7ZS564g/sO5JIzxy0fR071x9jSBdqhbbb+7QB4LPKDSJ0va1XJoi8umMlt43jX+N6
         oEfMLcd8+xIU7Ba3OntLPy/UAT3mO/NMUTkkVVVacT6np9Nk0rnplt0X5B09um7+wA
         IhUHN9aroH4gv+uihc5dJqhA2ZPlCh4E4M7J4ei/oVbZz0njK+MKBxwpof+4YOiLTI
         nJxw7GCHpSJIG7g0QVrKNeSjybdDG9s9Li6Kxc/Ixo7wfj7kw962TrIkkywI4qbkOr
         ZPsQOySQF+Yeg==
Date:   Sat, 5 Feb 2022 18:56:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 10/10] iio: core: Clarify the modes
Message-ID: <20220205185600.14085748@jic23-huawei>
In-Reply-To: <20220202144635.35748521@xps13>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-11-miquel.raynal@bootlin.com>
        <20220115173050.3501e20c@jic23-huawei>
        <20220202144635.35748521@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Feb 2022 14:46:35 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
> 
> jic23@kernel.org wrote on Sat, 15 Jan 2022 17:30:50 +0000:
> 
> > On Wed, 15 Dec 2021 16:13:44 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > As part of a previous discussion with Jonathan Cameron [1], it appeared
> > > necessary to clarify the meaning of each mode so that new developers
> > > could understand better what they should use or not use and when.
> > > 
> > > The idea of renaming these modes as been let aside because naming is a
> > > big deal and requires a lot of thinking. So for now let's focus on
> > > correctly explaining what each mode implies.
> > > 
> > > [1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4@jic23-huawei/
> > > 
> > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  include/linux/iio/iio.h | 40 +++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 39 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index d04ab89fa0c2..75b561fd63d0 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -314,7 +314,45 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
> > >  s64 iio_get_time_ns(const struct iio_dev *indio_dev);
> > >  unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
> > >  
> > > -/* Device operating modes */
> > > +/**
> > > + * Device operating modes
> > > + * @INDIO_DIRECT_MODE: There is an access to the last single value available.    
> > 
> > I'd avoid 'last' as not obvious wrt to what time point.  Perhaps use something
> > horrible like "timely"?  
> 
> I don't feel a big difference between the two, besides timely being far
> from easy to understand IMHO, but I'll use it if you think it's best.
timely is deliberately slightly vague.  An alternative would be to lay it out
in detail

There is an access to either:
a) The last single value available for devices that do not provide on demand
   reads.
b) A read of a new value is performed on demand.

> 
> > > + * On most devices, this is a single-shot read. On some devices with data
> > > + * streams without an 'on-demand' function, this might also be the 'last value'
> > > + * feature. Above all, this mode internally means that we are not in any of the
> > > + * other modes, and sysfs reads will definitely work.    
> > 
> > Should work ;)  They might fail for a wide variety of other reasons.  
> 
> Right.
> 
> > > + * Device drivers are pleased to inquire the core about this mode.    
> > Not totally sure what you mean here.  Perhaps
> > Device drivers should inform the core if they support this mode.  
> 
> Ok.
> 
> > > + * @INDIO_BUFFER_TRIGGERED: Most common mode when dealing with kfifo buffers.    
> > 
> > Avoid "common". That may well change in future as fifos are become increasingly
> > common on devices over time.  Perhaps just drop this first sentence.  
> 
> I don't think dropping this sentence is a good idea. My first goal here
> is to make it easier for newcomers to understand these modes. Here it
> clearly states "if you're dealing with a kfifo, keep reading, otherwise
> just check out the next mode". Of course this might evolve over time
> and if it is the case we can later update the documentation.
> 
> I've dropped the "Most" instead, to still indicate this is fairly
> common but should not be read like something almost automatic.
That works.

> 
> > > + * It indicates that there is an explicit trigger that must be used. This    
> > 
> > Indicates that an explicit trigger is required. (subtle difference from what you
> > wrote in that you kind of imply there is only one possible choice)  
> 
> Fair enough.
> 
> > > + * requests the core to attach a poll function when enabling the buffer, which
> > > + * is indicated by the _TRIGGERED suffix.
> > > + * The core will ensure this mode is set when registering a triggered buffer.    
> > 
> > I'd call out the function name (mostly to be inline with below where you need
> > to because there isn't a particularly good way to describe what it is doing).  
> 
> Done.
> 
> >   
> > > + * @INDIO_BUFFER_SOFTWARE: Another kfifo buffer mode, but not event triggered.
> > > + * No poll function can be attached because there is no triggered infrastructure
> > > + * we can use to cause capture. There is a kfifo that the hardware will fill,
> > > + * but not "one scan at a time", just like in a continuous stream.    
> > 
> > No real relationship to a continuous stream that I can see.  Perhaps something like
> > "Typically hardware will have a buffer that can hold multiple scans. Software may
> >  read one or more scans at a single time and push the available data to a Kfifo."  
> 
> Added.
> 
> >   
> > > This means
> > > + * the core will not attach any poll function when enabling the buffer.
> > > + * The core will ensure this mode is set when registering a simple kfifo buffer.    
> > 
> > I'd call out the function name here.  The above registers a kfifo as well which is
> > pretty simple...  
> 
> Sure.
> 
> >   
> > > + * @INDIO_BUFFER_HARDWARE: For specific hardware, if unsure do not use this mode.
> > > + * Same as above but this time the buffer is not a kfifo where we have direct
> > > + * access to the data. Instead, the consumer driver must access the data through
> > > + * side-channels     
> > What do you mean by side-channels here?  That term gets over used - perhaps
> > "non software visible channels"  
> 
> Clear.
> 
> > 
> >  + (or DMA when there is no demux possible in software).  
> > > + * The core will ensure this mode is set when registering a dmaengine buffer.    
> >   
> > > + * @INDIO_EVENT_TRIGGERED: Very specific, do not use this mode.    
> > 
> > :) That's harsh..  
> 
> Looks like you changed your mind, that's almost what you proposed back
> in September ;)

I'm inconsistent :)

> 
> > If you happen to be supporting hardware that works this way
> > it's a valid setting.  Perhaps we'd be safe to say:
> > "Very unusual."
> >   
> > > + * Triggers usually refer to an external event which will start data capture.
> > > + * Here it is kind of the opposite as, a particular state of the data might
> > > + * produce an event which can be considered as an event. We don't necessarily
> > > + * have access to the data itself, but to the event produced. For example, this
> > > + * can be a threshold detector. The internal path of this mode is very close to
> > > + * the INDIO_BUFFER_TRIGGERED mode.
> > > + * The core will ensure this mode is set when registering a triggered event.
> > > + * @INDIO_HARDWARE_TRIGGERED: STM32 specific mode, do not use it.    
> > 
> > I'd avoid that comment because it'll rot when some other hardware needs something
> > like this.  Again, perhaps "Very rare / unusual." will be enough to put people
> > off using it.  
> 
> As you prefer.
> 
> > > + * Here, triggers can result in data capture and can be routed to multiple
> > > + * hardware components, which make them close to regular triggers in the way
> > > + * they must be managed by the core, but without the entire interrupts/poll
> > > + * functions burden. All of this is irrelevant as it is all hardware mediated
> > > + * and distributed.    
> > 
> > "All this" is not totally clear.  Interrupts are irrelevant as the data flow
> > is hardware mediated and distributed.  
> 
> Thanks for the alternative.
> 
> > 
> > Nice descriptions in general.  Nature of these things is without a straw man
> > to poke holes in I'd never get around to documenting this very much
> > appreciated that you took the time to figure all the weird corners out and
> > write this up.
> >   
> 
> I'm happy if this can be useful!
> 
> V2 finally coming soon.
You beat me replying but I don't think any of the above replies will greatly influence things.

This wordy stuff always takes more thought that code so yet again you end
up at the end of my review queue with these on the basis of too hard - I'll
do it later :)

Jonathan
