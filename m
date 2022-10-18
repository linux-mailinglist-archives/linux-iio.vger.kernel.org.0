Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DA8602654
	for <lists+linux-iio@lfdr.de>; Tue, 18 Oct 2022 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiJRICI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Oct 2022 04:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiJRICE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2022 04:02:04 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C5844D6
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2022 01:01:57 -0700 (PDT)
Received: (Authenticated sender: kamel.bouhara@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6144EFF80F;
        Tue, 18 Oct 2022 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666080116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=welOLbT3ZpaoT8B3l5jN6gPn4wncpOQpCLvjvE83gnc=;
        b=XYt/uf7xr+1WOKUPPtZSIY4+cHfJxSClpg1gGSRHopquD4fDKKYFNtXcLyC0swQd2DuQKY
        E16E/2csLtxPp585CZuIbmIzLruTkwb4vCW8/G7UsvADezZwrG/xvP3o1Db8YRalzETEh/
        /CcH+F377z41Wc6xk1qmZXaESGvlH4BVfwCasQoR/8c6QxDAU9n3jyIr2wJg5NOXAUbWKY
        oan7tt+sEA8Ueu9CRvTIcrPFUKFtybcKny6krcH8oij6qkJDs3rVLlyd5MhTx7+PnSasBN
        UqXmpoDnTwM7bhrAh9oTz5lRsP7pzCkcUdFJA82Ydj6rGJ4DHj9oxZn9SRVOuw==
Date:   Tue, 18 Oct 2022 10:01:49 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: Handling Signal1 in microchip-tcb-capture
Message-ID: <Y05dbRPh9jNj61y+@kb-xps>
References: <Y0q7Gzh95nFdqdYK@fedora>
 <Y00nidri3TRYARiu@kb-xps>
 <Y01QPkE0E+HR7dat@fedora>
 <Y02Lkpu+NCaPo/ZF@kb-xps>
 <Y03P55QWFkDhtqt7@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y03P55QWFkDhtqt7@fedora>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 17, 2022 at 05:57:59PM -0400, William Breathitt Gray wrote:
> On Mon, Oct 17, 2022 at 07:06:26PM +0200, Kamel Bouhara wrote:
> > On Mon, Oct 17, 2022 at 08:53:18AM -0400, William Breathitt Gray wrote:
> > > On Mon, Oct 17, 2022 at 11:59:37AM +0200, Kamel Bouhara wrote:
> > > > On Sat, Oct 15, 2022 at 09:52:27AM -0400, William Breathitt Gray wrote:
> > > > > I was looking over the microchip-tcb-capture driver recently and noticed
> > > > > that the code doesn't seem to account for Signal1. In particular, it
> > > > > appears that mchp_tc_count_signal_read() and mchp_tc_count_action_read()
> > > > > don't check the Signal id at all and just assume they are handling
> > > > > Signal0. This creates a situation where the information returned for the
> > > > > Signal1 sysfs attributes are just duplicated reports of Signal0.
> > > > >
> > > > > What exactly is the relationship of Signal0 ("Channel A") and Signal1
> > > > > ("Channel B"); is SignalB only relevant when the counter device is
> > > > > configured for quadrature mode?
> > > >
> > > > Indeed both signals are required when in quadrature mode, where the
> > > > signal0 is representing the speed and signal1 the revolution or number
> > > > of rotation.
> > > >
> > > > We have described all availables modes in details in the following blog post: https://bootlin.com/blog/timer-counters-linux-microchip/
> > > >
> > > > Regards,
> > > > Kamel
> > >
> > > Thank you for the link, the block diagram helps illustrate how the
> > > signals correlate to the TCB channels.
> > >
> > > Let me check if I understand correctly. In microchip-tcb-capture.c,
> > > mchp_tc_count_signals[0] is TIOA0 while mchp_tc_count_signals[1] is
> > > TIOB0? In quadrature mode, are TIOA and TIOB the two phases of a
> > > quadrature encoder? You mentioned one signal is speed while the other is
> > > the number of rotations; does this mean one signal serves as the
> > > position incrementation from a rotary wheel while the other signal is
> > > the index (z-phase) indicate for each full rotation?
> > >
> >
> > IIRC this is indeed both signal edges (phase A and B) are accumulated on
> > channel 0 and channel 1 stores the revolution or number of rotation of
> > the qdec encoder.
>
> Ah, I think I understand now: Signal0 and Signal1 are TIOA and TIOB
> respectively; channel 0 and channel 1 are data registers; channel 0
> holds the Count0 count value; channel 1 holds the revolution value (but
> the microchip-tcb-capture driver does not expose it).

Exact, I assumed that in qdec mode only the position value is relevant.

>
> It might be nice to expose the channel 1 revolution value as Count1 at
> some point in the future. However, channel 1 seems unrelated to the
> current issue we're dicussing so we can avoid it for now.

OK do you suggest to read both count values in the same mchp_tc_count_read() ?

>
> > > In particular, I'm having trouble understanding
> > > mchp_tc_count_signal_read(). I suspect it is unintentionally always
> > > returning the signal status for TIOA::
> > >
> > >     regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], SR), &sr);
> > >
> > >     if (priv->trig_inverted)
> > >             sigstatus = (sr & ATMEL_TC_MTIOB);
> > >     else
> > >             sigstatus = (sr & ATMEL_TC_MTIOA);
> > >
> > >     *lvl = sigstatus ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
> > >
> > > Here we read the status register for channel 0, select between TIOA and
> > > TIOB based on priv->trig_inverted, and then return the signal level.
> > >
> > > I don't see priv->trig_inverted referenced anywhere else so it appears
> > > that priv->trig_inverted will always be 0, thus resulting in
> > > mchp_tc_count_signal_read() always returning the TIOA status. I think
> > > the intended behavior is to return the status of the selected signal::
> >
> > IIRC the trig_inverted shall be used when signals are inverted which
> > means we read position on TIOB and revolution on TIOA.
>
> Sure, that seems like a reasonable option to expose, but it does not
> appear that trig_inverted is being set or otherwise configured in the
> current code, unless I'm missing something. It might be best to remove
> trig_inverted if the functionality is not supported yet by this driver.
>

OK.

> > >
> > >     if (signal->id == 1)
> > >             sigstatus = (sr & ATMEL_TC_MTIOB);
> > >     else
> > >             sigstatus = (sr & ATMEL_TC_MTIOA);
> > >
> > > As for mchp_tc_count_action_read(), we have a similar problem: no
> > > distinction is made for the Synapse requested. The channel mode register
> > > for channel 0 is read and then masked against ATMEL_TC_ETRGEDG to
> > > determine the action mode. It appears that this code is always assuming
> > > the Synapse for TIOA is requested, but the Synapse for TIOB could be
> > > passed. You can determine which corresponding Signal you have by
> > > checking synapse->signal->id before deciding what action mode to return.
> > >
> >
> > That is indeed a good point as both signals are eligible to trigger the
> > TC for both modes (capture/qdec).
> >
> > > To clarify, in COUNTER_FUNCTION_INCREASE mode, does the Count value
> > > increment based on the edge of TIOA and not TIOB? In
> >
> > Yes, currently the driver only support TIOA.
> >
> > > COUNTER_FUNCTION_QUADRATURE_X4 mode, does the Count value increment
> > > based on both edges of TIOA and TIOB serving as quadrature encoding
> > > phase A and B signals?
> >
> > Yes as explained above.
>
> Okay this should be simple to resolve then: return -EINVAL if Synapse is
> for TIOB in mchp_tc_count_action_write(), and pass back
> COUNTER_SYNAPSE_ACTION_NONE for TIOB during non-quadrature mode in
> mchp_tc_counter_action_read().
>
> I'll submit a patch fixing these changes and the signal_read() callback
> mentioned previously.
>

That's clear, thanks.

> By the way, I suspect there are race conditions present in
> mcho_tc_count_function_write() that could be resolved by adding a lock
> to the mchp_tc_data structure and acquiring it before accessing the
> device state and registers. It's unrelated to the Signal1 issues so I
> haven't looked any further into it, but it's something you might want to
> investigate to make sure you don't get weird behavior from the driver.
>

You mean between function_write() and action_write() ?

> Thanks,
>
> William Breathitt Gray
--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
