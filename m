Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0BE1C2742
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgEBRbH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 13:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgEBRbH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 13:31:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44DF6206B8;
        Sat,  2 May 2020 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588440666;
        bh=Un4jyA+lzOxIUevxBXaZkTNsi2B49jZeVzIglPjaOWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F5bje+/Vvao4S/KkOUBoaHA9PzSDhufrYZ7x2m4yEy2BP7QDg51ETS7WZOi4EBD0E
         FDEgm6tS/FJ3Lkm9zqxNeOTjCMhm3Pkhjm2P7MM9Hs/PvvKoJHxerNc05et3yFunJd
         gdTBAOpufbtC1k6JS6tr1sFQmVzevaS6xB7dSSps=
Date:   Sat, 2 May 2020 18:31:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>,
        "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: at91-sama5d2_adc: split
 at91_adc_current_chan_is_touch() helper
Message-ID: <20200502183102.4e916203@archlinux>
In-Reply-To: <b9ab676489de3575984dac5610fcf05fd8742a38.camel@analog.com>
References: <20200304084219.20810-1-alexandru.ardelean@analog.com>
        <20200413180556.20638f3b@archlinux>
        <9315e9a7-0703-b119-ca32-69f0c2fcc7de@microchip.com>
        <20200414184505.0cd39249@archlinux>
        <f13b4286c5f133e7461d59965d7f84af059c8e89.camel@analog.com>
        <208699ad-1302-aac1-c2e7-4f469e39a7eb@microchip.com>
        <b50961e86a536223be7e3df0f276e572a435f644.camel@analog.com>
        <be31bfcde7dc35b07855302d5cbf6db42bc7f634.camel@analog.com>
        <b9ab676489de3575984dac5610fcf05fd8742a38.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Apr 2020 08:10:29 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2020-04-30 at 07:30 +0000, Ardelean, Alexandru wrote:
> > On Mon, 2020-04-27 at 13:00 +0000, Ardelean, Alexandru wrote:  
> > > [External]
> > > 
> > > On Mon, 2020-04-27 at 12:20 +0000, Eugen.Hristev@microchip.com wrote:  
> > > > [External]
> > > > 
> > > > On 15.04.2020 09:33, Ardelean, Alexandru wrote:
> > > >   
> > > > > On Tue, 2020-04-14 at 18:45 +0100, Jonathan Cameron wrote:  
> > > > > > On Tue, 14 Apr 2020 12:22:45 +0000
> > > > > > <Eugen.Hristev@microchip.com> wrote:
> > > > > >   
> > > > > > > On 13.04.2020 20:05, Jonathan Cameron wrote:  
> > > > > > > > On Wed, 4 Mar 2020 10:42:18 +0200
> > > > > > > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > > > > > > >   
> > > > > > > > > This change moves the logic to check if the current channel is
> > > > > > > > > the
> > > > > > > > > touchscreen channel to a separate helper.
> > > > > > > > > This reduces some code duplication, but the main intent is to
> > > > > > > > > re-
> > > > > > > > > use
> > > > > > > > > this
> > > > > > > > > in the next patches.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com  
> > > > > > > > > >  
> > > > > > > > Eugen / Ludovic,
> > > > > > > > 
> > > > > > > > Have you had a chance to look at this series?  
> > > > > > > 
> > > > > > > Hi Jonathan,
> > > > > > > 
> > > > > > > Does the patch apply correctly for you ?  
> > > > > > 
> > > > > > I haven't tried yet :)
> > > > > >   
> > > > > 
> > > > > I've rebased this patchset on top of current iio/testing and it still
> > > > > applies.
> > > > >   
> > > > 
> > > > Hi Alex,
> > > > 
> > > > I tried this patch on top of my tree (however I am testing with an older 
> > > > kernel 5.4) , and I have issues starting the buffer after you moved my 
> > > > code to the preenable callback.
> > > > 
> > > > Namely, on the line:
> > > > 
> > > > if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> > > >                 return -EINVAL;  
> > 
> > In the meantime I found this patch:
> > https://urldefense.com/v3/__https://lore.kernel.org/linux-iio/1431525891-19285-5-git-send-email-lars@metafoo.de/__;!!A3Ni8CS0y2Y!ocQuNvFF_8rd-cCvMNXU0cTk9mLezpCPyzelQyhbxMGdKgFo0_JTgTD1q1VU-kj10aqxxA$ 
> > 
> > from about ~5 years ago;

Yup.  That started the transition to claim_direct_mode to avoid the locking
issues.   There are probably a few drivers that never got there but 
in theory moving the setting of this parameter earlier should now
be fine as the original race condition is closed (subject to a few
drivers that still have that race condition)


> > 
> > if this patch is a valid proposal, it could fix this case as well;
> > well, it might break others, so applying it [now] would need some general
> > review
> > of all pre/post enable/disable hooks
> >   
> 
> So, apologies if this will start to seem like spamming.
> I decided to do a bit of shell magic for this:
> 
> get_files() {
> git grep -w iio_buffer_setup_ops  | grep drivers | cut -d: -f1 | sort | uniq
> }
> 
> for file in $(get_files) ; do
>     if grep -q currentmode $file ; then
>         echo $file
>     fi
> done
> 
> It finds 4 drivers.
> Though, `get_files()` will return 56 files.
> 
> drivers/iio/accel/bmc150-accel-core.c
> drivers/iio/adc/at91-sama5d2_adc.c
> drivers/iio/adc/stm32-dfsdm-adc.c
> drivers/iio/magnetometer/rm3100-core.c
> 
> The rm3100 driver doesn't do any checks in the setup_ops for 'currentmode' as
> far as I could see.
> 
> So, Lars' patch could work nicely to fix this current case and not break others.
> 
> Semantically though, it would sound nicer to have a 'nextmode' parameter
> somewhere; maybe on the setup_ops(indio_dev, nextmode)?
> Though, only those 3 drivers would really ever use it; so doing it like that
> sounds like overkill.
> 
> So, we're left with Lars' patch or we could add an 'indio_dev->nextmode' field,
> that may be used in just these 3 drivers [which again: sounds overkill at this
> point in time].
> 
> Alternatively, this 'indio_dev->currentmode' could be removed from all these 3
> drivers somehow. But that needs testing and a thorough understanding of all 3
> drivers and what they're doing, to do properly.
> 
> @Jonathan: what do you think?

I think we are 'now' fine to apply what Lars originally suggested to solve
this issue.  There are still some difference between pre and post functions
but for many usecases they no longer matter (if curious just look at what
remains being called between them).

> 
> In any case, pending a reply, I'll send Lars' patch.
> Even if we come to a different conclusion we have something to start with.
> But, if the conclusion is that Lars' patch is a good solution now, it can be
> applied.
> 
> 
> > > Apologies for the breakage.
> > > 
> > > For the touch-part I don't see that code being executed.
> > > 
> > > But a question is: does the driver need to check for the currentmode?
> > > Or is that something that the IIO core should do?
> > >   
> > > > And with this , the preenable fails on my side, because the current mode 
> > > > is not yet switched to triggered.
> > > > 
> > > > I do remember adding this line with a specific reason. It may be related 
> > > > to touchscreen operations, but I have to retest the touch with and 
> > > > without this line and your patch.
> > > > 
> > > > Meanwhile, maybe you have any suggestions on how to fix the buffer ?   
> > > 
> > > Well, there was the question of whether iio_triggered_buffer_postenable()
> > > [to
> > > attach the pollfunc] makes sense to be called first/last in the old
> > > at91_adc_buffer_postenable(), and the answer was 'last'; so then one
> > > solution
> > > was to move things to preenable().
> > > 
> > > Going back to the old patch isn't ideal, as the idea was to make the
> > > position
> > > of
> > > iio_triggered_buffer_postenable() consistent across all drivers, so that it
> > > can
> > > be removed [and moved to the IIO core].
> > > 
> > > But if we need revert the patch, then I guess it's fine.
> > > The only solution I see right now [for going forward], is to remove that
> > > check
> > > for 'currrentmode'
> > >   
> > > > This check here makes any sense to you ?  
> > > 
> > > I think Jonathan may have to add some input here, but I think that in this
> > > current situation, checking 'currentmode' looks like is re-validating how
> > > the
> > > device was configured via the IIO framework.
> > > I am not sure if it's needed or not.
> > >   
> > > > Thanks,
> > > > Eugen
> > > >   
> > > > > > > I will try to test it , if I manage to apply it.
> > > > > > > I can only test the ADC though because at this moment I do not have
> > > > > > > a
> > > > > > > touchscreen at disposal.
> > > > > > > 
> > > > > > > Meanwhile, the code looks good for me,
> > > > > > > 
> > > > > > > Reviewed-by: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > > > 
> > > > > > > By the way, I do not know if my two pending patches on this driver
> > > > > > > will
> > > > > > > conflict or not.  
> > > > > > 
> > > > > > As this is a long term rework patch at heart, there isn't any
> > > > > > particular
> > > > > > rush as long as we don't loose it forever!
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > Jonathan
> > > > > >   
> > > > > > > Eugen
> > > > > > >   
> > > > > > > > Thanks,
> > > > > > > > 
> > > > > > > > Jonathan
> > > > > > > >   
> > > > > > > > > ---
> > > > > > > > > 
> > > > > > > > > This patchset continues discussion:
> > > > > > > > > 
> > > > > > > > > https://urldefense.com/v3/__https://lore.kernel.org/linux-iio/20191023082508.17583-1-alexandru.ardelean@analog.com/__;!!A3Ni8CS0y2Y!ql1bYiNMPFlz1twnCCAQpiEBvpzxR_VHAPL712rWFfwy2TSKjZ2UhGBoV7-29Syny6z0yg$
> > > > > > > > > 
> > > > > > > > > Apologies for the delay.
> > > > > > > > > 
> > > > > > > > > Changelog v1 -> v2:
> > > > > > > > > * added patch 'iio: at91-sama5d2_adc: split
> > > > > > > > > at91_adc_current_chan_is_touch()
> > > > > > > > >     helper'
> > > > > > > > > * renamed at91_adc_buffer_postenable() ->
> > > > > > > > > at91_adc_buffer_preenable()
> > > > > > > > >     - at91_adc_buffer_postenable() - now just calls
> > > > > > > > >       iio_triggered_buffer_postenable() if the channel isn't the
> > > > > > > > > touchscreen
> > > > > > > > >       channel
> > > > > > > > > * renamed at91_adc_buffer_predisable() ->
> > > > > > > > > at91_adc_buffer_postdisable()
> > > > > > > > >     - at91_adc_buffer_predisable() - now just calls
> > > > > > > > >       iio_triggered_buffer_predisable() if the channel isn't the
> > > > > > > > > touchscreen
> > > > > > > > >       channel
> > > > > > > > > 
> > > > > > > > >    drivers/iio/adc/at91-sama5d2_adc.c | 31 +++++++++++++++----
> > > > > > > > > ----
> > > > > > > > > -------
> > > > > > > > >    1 file changed, 15 insertions(+), 16 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c
> > > > > > > > > b/drivers/iio/adc/at91-
> > > > > > > > > sama5d2_adc.c
> > > > > > > > > index a5c7771227d5..f2a74c47c768 100644
> > > > > > > > > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > > > > > > > > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > > > > > > > > @@ -873,18 +873,24 @@ static int at91_adc_dma_start(struct
> > > > > > > > > iio_dev
> > > > > > > > > *indio_dev)
> > > > > > > > >         return 0;
> > > > > > > > >    }
> > > > > > > > > 
> > > > > > > > > +static bool at91_adc_current_chan_is_touch(struct iio_dev
> > > > > > > > > *indio_dev)
> > > > > > > > > +{
> > > > > > > > > +     struct at91_adc_state *st = iio_priv(indio_dev);
> > > > > > > > > +
> > > > > > > > > +     return !!bitmap_subset(indio_dev->active_scan_mask,
> > > > > > > > > +                            &st->touch_st.channels_bitmask,
> > > > > > > > > +                            AT91_SAMA5D2_MAX_CHAN_IDX + 1);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >    static int at91_adc_buffer_postenable(struct iio_dev
> > > > > > > > > *indio_dev)
> > > > > > > > >    {
> > > > > > > > >         int ret;
> > > > > > > > >         struct at91_adc_state *st = iio_priv(indio_dev);
> > > > > > > > > 
> > > > > > > > >         /* check if we are enabling triggered buffer or the
> > > > > > > > > touchscreen
> > > > > > > > > */
> > > > > > > > > -     if (bitmap_subset(indio_dev->active_scan_mask,
> > > > > > > > > -                       &st->touch_st.channels_bitmask,
> > > > > > > > > -                       AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
> > > > > > > > > -             /* touchscreen enabling */
> > > > > > > > > +     if (at91_adc_current_chan_is_touch(indio_dev))
> > > > > > > > >                 return at91_adc_configure_touch(st, true);
> > > > > > > > > -     }
> > > > > > > > > +
> > > > > > > > >         /* if we are not in triggered mode, we cannot enable the
> > > > > > > > > buffer.
> > > > > > > > > */
> > > > > > > > >         if (!(indio_dev->currentmode &
> > > > > > > > > INDIO_ALL_TRIGGERED_MODES))
> > > > > > > > >                 return -EINVAL;
> > > > > > > > > @@ -906,12 +912,9 @@ static int
> > > > > > > > > at91_adc_buffer_predisable(struct
> > > > > > > > > iio_dev *indio_dev)
> > > > > > > > >         u8 bit;
> > > > > > > > > 
> > > > > > > > >         /* check if we are disabling triggered buffer or the
> > > > > > > > > touchscreen
> > > > > > > > > */
> > > > > > > > > -     if (bitmap_subset(indio_dev->active_scan_mask,
> > > > > > > > > -                       &st->touch_st.channels_bitmask,
> > > > > > > > > -                       AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
> > > > > > > > > -             /* touchscreen disable */
> > > > > > > > > +     if (at91_adc_current_chan_is_touch(indio_dev))
> > > > > > > > >                 return at91_adc_configure_touch(st, false);
> > > > > > > > > -     }
> > > > > > > > > +
> > > > > > > > >         /* if we are not in triggered mode, nothing to do here
> > > > > > > > > */
> > > > > > > > >         if (!(indio_dev->currentmode &
> > > > > > > > > INDIO_ALL_TRIGGERED_MODES))
> > > > > > > > >                 return -EINVAL;
> > > > > > > > > @@ -1886,14 +1889,10 @@ static __maybe_unused int
> > > > > > > > > at91_adc_resume(struct
> > > > > > > > > device *dev)
> > > > > > > > >                 return 0;
> > > > > > > > > 
> > > > > > > > >         /* check if we are enabling triggered buffer or the
> > > > > > > > > touchscreen
> > > > > > > > > */
> > > > > > > > > -     if (bitmap_subset(indio_dev->active_scan_mask,
> > > > > > > > > -                       &st->touch_st.channels_bitmask,
> > > > > > > > > -                       AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
> > > > > > > > > -             /* touchscreen enabling */
> > > > > > > > > +     if (at91_adc_current_chan_is_touch(indio_dev))
> > > > > > > > >                 return at91_adc_configure_touch(st, true);
> > > > > > > > > -     } else {
> > > > > > > > > +     else
> > > > > > > > >                 return at91_adc_configure_trigger(st->trig,
> > > > > > > > > true);
> > > > > > > > > -     }
> > > > > > > > > 
> > > > > > > > >         /* not needed but more explicit */
> > > > > > > > >         return 0;  

