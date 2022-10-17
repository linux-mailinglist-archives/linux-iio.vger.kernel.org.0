Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF6601446
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJQRGc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 13:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQRGb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 13:06:31 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D74E851
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 10:06:29 -0700 (PDT)
Received: (Authenticated sender: kamel.bouhara@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 14411100004;
        Mon, 17 Oct 2022 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666026388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kpNIdAz1588XyIs1IKXrVbeF6UQl3z3oJgLRUJ+9sWk=;
        b=Cmv7/OsKkBt6pn3P9946UjW4XsrKIoqSk7GiVbcG1iPhkOLFR63Rx40H6XRwOb8o8c0IRb
        AtB08+gCPuQWqQ4KJf2PYrO/N5KBt6rZY9h0X/6nwG6hRLfAqXAdu6yvsTWPKdNUmfnv7V
        a8sxLBUGlR/Wtn+z/A8QFw0syzhCnQbrMlZtxzlWmkY0S/C7CwQxbCO95I/d3/a9NXnRNW
        2VPfnsMeWVaBTTSgfm83ckqNzzQHWGbqyu4qcOU8Lbi5QIiDWVQgWzrSdSOXjrZ6oHHScx
        iXbpANL/qHYtB1DhKtMKtzOX5G1ofC25PKQvi6lONsYivoNcW/rhrp+6Y06TVQ==
Date:   Mon, 17 Oct 2022 19:06:26 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: Handling Signal1 in microchip-tcb-capture
Message-ID: <Y02Lkpu+NCaPo/ZF@kb-xps>
References: <Y0q7Gzh95nFdqdYK@fedora>
 <Y00nidri3TRYARiu@kb-xps>
 <Y01QPkE0E+HR7dat@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y01QPkE0E+HR7dat@fedora>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 17, 2022 at 08:53:18AM -0400, William Breathitt Gray wrote:
> On Mon, Oct 17, 2022 at 11:59:37AM +0200, Kamel Bouhara wrote:
> > On Sat, Oct 15, 2022 at 09:52:27AM -0400, William Breathitt Gray wrote:
> > > I was looking over the microchip-tcb-capture driver recently and noticed
> > > that the code doesn't seem to account for Signal1. In particular, it
> > > appears that mchp_tc_count_signal_read() and mchp_tc_count_action_read()
> > > don't check the Signal id at all and just assume they are handling
> > > Signal0. This creates a situation where the information returned for the
> > > Signal1 sysfs attributes are just duplicated reports of Signal0.
> > >
> > > What exactly is the relationship of Signal0 ("Channel A") and Signal1
> > > ("Channel B"); is SignalB only relevant when the counter device is
> > > configured for quadrature mode?
> >
> > Indeed both signals are required when in quadrature mode, where the
> > signal0 is representing the speed and signal1 the revolution or number
> > of rotation.
> >
> > We have described all availables modes in details in the following blog post: https://bootlin.com/blog/timer-counters-linux-microchip/
> >
> > Regards,
> > Kamel
>
> Thank you for the link, the block diagram helps illustrate how the
> signals correlate to the TCB channels.
>
> Let me check if I understand correctly. In microchip-tcb-capture.c,
> mchp_tc_count_signals[0] is TIOA0 while mchp_tc_count_signals[1] is
> TIOB0? In quadrature mode, are TIOA and TIOB the two phases of a
> quadrature encoder? You mentioned one signal is speed while the other is
> the number of rotations; does this mean one signal serves as the
> position incrementation from a rotary wheel while the other signal is
> the index (z-phase) indicate for each full rotation?
>

IIRC this is indeed both signal edges (phase A and B) are accumulated on
channel 0 and channel 1 stores the revolution or number of rotation of
the qdec encoder.

> In particular, I'm having trouble understanding
> mchp_tc_count_signal_read(). I suspect it is unintentionally always
> returning the signal status for TIOA::
>
>     regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], SR), &sr);
>
>     if (priv->trig_inverted)
>             sigstatus = (sr & ATMEL_TC_MTIOB);
>     else
>             sigstatus = (sr & ATMEL_TC_MTIOA);
>
>     *lvl = sigstatus ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
>
> Here we read the status register for channel 0, select between TIOA and
> TIOB based on priv->trig_inverted, and then return the signal level.
>
> I don't see priv->trig_inverted referenced anywhere else so it appears
> that priv->trig_inverted will always be 0, thus resulting in
> mchp_tc_count_signal_read() always returning the TIOA status. I think
> the intended behavior is to return the status of the selected signal::

IIRC the trig_inverted shall be used when signals are inverted which
means we read position on TIOB and revolution on TIOA.

>
>     if (signal->id == 1)
>             sigstatus = (sr & ATMEL_TC_MTIOB);
>     else
>             sigstatus = (sr & ATMEL_TC_MTIOA);
>
> As for mchp_tc_count_action_read(), we have a similar problem: no
> distinction is made for the Synapse requested. The channel mode register
> for channel 0 is read and then masked against ATMEL_TC_ETRGEDG to
> determine the action mode. It appears that this code is always assuming
> the Synapse for TIOA is requested, but the Synapse for TIOB could be
> passed. You can determine which corresponding Signal you have by
> checking synapse->signal->id before deciding what action mode to return.
>

That is indeed a good point as both signals are eligible to trigger the
TC for both modes (capture/qdec).

> To clarify, in COUNTER_FUNCTION_INCREASE mode, does the Count value
> increment based on the edge of TIOA and not TIOB? In

Yes, currently the driver only support TIOA.

> COUNTER_FUNCTION_QUADRATURE_X4 mode, does the Count value increment
> based on both edges of TIOA and TIOB serving as quadrature encoding
> phase A and B signals?

Yes as explained above.

>
> The fixes for this issue are trivial enough that I can submit a patch
> for them later, but I want to make sure I'm understanding the nature of
> these signals correctly before I do so.
>
> Thanks,
>
> William Breathitt Gray



--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
