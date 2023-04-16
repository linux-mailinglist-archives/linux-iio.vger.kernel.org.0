Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D606E3905
	for <lists+linux-iio@lfdr.de>; Sun, 16 Apr 2023 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDPNwv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Apr 2023 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDPNwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Apr 2023 09:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6006F199E
        for <linux-iio@vger.kernel.org>; Sun, 16 Apr 2023 06:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF7B60D56
        for <linux-iio@vger.kernel.org>; Sun, 16 Apr 2023 13:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C92EC433EF;
        Sun, 16 Apr 2023 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681653167;
        bh=Tb1Q17TQCtrLJZXBHZknuXXc9MOCaKaDdp5S1ZDy5F4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OlWwsCim+hGIc7MbyhsvUBqse5dvjSHDZpitkNVXGxQq1Maf72KpiTFKdiJJDLFrH
         wg5uuGkk+4rtGg1wHfdyGVk0pu2Nmmv7ABM/JFwzHJmK1Mgk1MaZPnyG3tWbjHtYVU
         P7ziJylHp6X3KuMFT6PCVeElyxwUHqTFSbGhob0EvTk/GcwVlDw1nlsYQDFeymfEZp
         5a5DKorQP8laFvFhcYCYbc6JKoRzXVgHbRvqbpcOr/cFdy8vl943wyFnKEezkyRRNx
         LcD5LnsR8akCCvP09lTYustYCBHDnRS54z4oHG+TqZctDPP2fT+aUSyXe+ByS6e3sP
         to3I3bZPbiR+g==
Date:   Sun, 16 Apr 2023 14:52:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: ROHM BU27008 RGB sensor
Message-ID: <20230416145249.05d2d9c0@jic23-huawei>
In-Reply-To: <8e61fb87-2533-9a81-1682-2e5ee376389d@gmail.com>
References: <5942c0c2-3997-e10f-0872-30d201bc52ae@gmail.com>
        <20230410171654.66605efe@jic23-huawei>
        <8e61fb87-2533-9a81-1682-2e5ee376389d@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> > 
> > That's "novel".  Feel free to tell the Rohm hardware folk that I think they
> > are crazy in a really unhelpful way.  
> 
> As a ROHM employee, I should probably be a bit taken aback - but this 
> actually made me laugh. Well, I was on a vacation when I read this so 
> maybe it is Ok ;)
> 
> Well, ROHM hardware folks have a long history of making hardware, and 
> typically hardware for a specific customer and for a specific need. 
> They're actually truly novel at times - and they tend to solve pretty 
> impossible problems with pretty "out of the box" solutions (at times). 
> Unfortunately, these novel solutions which solved a specific problem for 
> a specific customer tend to be inherited to next products where these 
> 'hacks' may no longer have a purpose. Furthermore, (as far as I know) 
> for a long period of time, the software for ROHM ICs was also written 
> either by a customer, or by a subcontractor. The (driver) SW was written 
> for a specific project and it was not necessary to make it fit for 
> generic use-cases - hence, things like this 1X Vs 2X gain did not really 
> matter as SW could be tailored to just do the right thing for a specific 
> product. When the product was out the project was done.
> 
> This means that there has been no "feed-back" loop from SW engineers to 
> many of the ROHM HW colleagues. So, even though you hit to the spot with 
> the comment - there is a very understandable reasons behind things being 
> somewhat ... peculiar ;)
> 
> And yes, I have been and continue to be giving feed-back to hardware 
> colleagues. And even though I am very much tempted of using your quote 
> as my email signature, I guess it is more productive to try a bit more 
> gentle approach with the feed-back. XD

:) I'm fairly safe that the hardware engineers won't start reading kernel
mailing lists! (great though that would be) "Hi" to the few who do!

I fully appreciate the demands of custom requirements and the weird and
wonderful hardware that results.  It's great that you and
ROHM are now playing well and you can close the loop.
I wish you luck - in day job I tend to get less than half of what I ask
for changed in future hardware / specs.

A running joke when talking to my hardware colleagues is I moan at them
for giving me unnecessarily complex (often crazy) interfaces and they
reply with 'it's only software'.

> 
> >   
> >> I see two options:
> >>
> >> 1) Use fixed high bits which means supporting only 4X and 16X gains -
> >> for which changing the low selector bits is enough. In this case the
> >> RGBC would have own gain setting, IR would have own and there would be
> >> no shared bits.  
> > 
> > That's pretty nasty as I suspect the high bits are the useful ones.  
> 
> I kind of agree. So, while that would be the simplest thing, it would 
> also drop most of the gains the HW is capable of.
> 
> >>
> >> 2) Allow full range of supported gains to be set for RGBC - and disallow
> >> setting gain for IR. However, change the IR gain to have same selector
> >> as RGBC gain when RGBC gain is changed. (This prevents IR gain selector
> >> from changing to an unsupported value when RGBC gain is changed). This
> >> means that if user-space changes the gain for RGBC, it should also
> >> read-back the gain for IR to detect the change. I have no idea if
> >> existing user-space apps do this.  
> > 
> > We've had other cases where setting a gain affects a subset of channels
> > (shared gains for pairs of channels for instance). In those cases userspace
> > has to read back the values.  I suspect there are no userspace programs
> > that do anything more complex than setting gain to a value in a config
> > file.  So if that's valid then all is good.  
> 
> Oh, interesting. I don't know how userspace apps utilize these sensors. 
> Nor do I know what these RGB sensors are mostly used for. I however 
> thought userspace apps would be detecting saturation / measurement 
> values going close to zero, and did dynamically change scale based on 
> this. Config file sounds like most of the apps just use a static 
> settings - which indeed simplifies things.

I've heard of both happening.  If a sensor has a wide (ish) dynamic range
in one setting though that's often enough for 'generic' code.  Anything
that really cares about precision that you'll get from autoscaling is
likely to be fairly custom anyway so can cope with the slightly weird.

However those examples were ambient light sensors. I'm not sure what
software stack people use for RGB sensors.. Anyone reading this know?

> 
> >> I think that no matter if we select option 1) or option 2) - we must
> >> have own scale entries for all channels. This is needed for option 2)
> >> because of the 1X vs 2X difference mentioned above.
> >>
> >> I have currently implemented the option 2) because it supports wider
> >> variety of gains - but I am unsure if this is "the right thing to do".
> >>
> >> Any insight is appreciated!  
> > 
> > Hmm. Given the pairwise case I mention above requires that any write to
> > gain can change any other and there is no strong reason it must change it
> > to the same value as the one written.  So setting channel 1 scale to x2 might
> > result in channel 2 scale doubling from x2 to x4 (think of a fixed x2 multiplier
> > on channel 2 with a pga in front of it (this craziness happens on SoC ADCs
> > sometimes) I think you can be more generic about this.
> > 
> > Have all channels have their own scale + scale_available.  
> 
> Ok. My current draft did not have 'scale_available' for IR because 
> setting scale for IR was forbidden.
> 
> > A write to any of them changes the value with exception of when it affects only
> > the lower bits where you can separate off the IR channel.  If the change requires
> > changing the upper bits than fine it changes the IR gain as well.  
> 
> Thanks for the suggestion. In my head this felt too complex but now that 
> you wrote it down, it does not really be that complex. We can simply 
> compare the old and new values for high bits and set the lower bits for 
> other channels only when high bits change.
>

I'm not totally following.  Is the aim here to keep them as consistent as
possible?  I'm not sure that extra complexity is needed.  It might make things
easier to use I guess if I've understood what you mean correctly.
Maybe leave this as a question for the driver patch were we can look
at numeric examples.

> (I wrote it like this because 
> I am at the same time working with yet another RGB sensor model, with 
> yet another messy 'shared bits' gain setting. The other sensor has 
> individual 'low bits' for all channels, while having shared high bits...)

Ah. Oh for consistency :)

> 
> > Another option comes to mind.  Just have one scale value and don't allow the
> > lowest gain value.  That way you can always program the scales to the same value
> > by setting both registers.  So basically hid the oddity of that different
> > 1x vs 2x initial scale by not supporting it.  
> 
> Yes. That would be an option. Not supporting 1X makes the 'saturation 
> point' for RGBC to jump 4X lower though... I will see how the code looks 
> like when implementing the 'check if high bits changed' logic you 
> suggested. Well, thanks a LOT for the help! This means I will soon(ish) 
> pour some more patches to your review queue :) (Might be I do some PMIC 
> work before that though).

Any idea where these sensors tend to be used?  If its in consumer
applications where max is likely bright daylight, maybe see if it
saturates at that point. If it's for lighting control (think of
putting one in a lighting unit itself) then maybe that initial value
matters as light levels might be very high.

Jonathan


> 
> 
> Thanks,
> 	-- Matti
> 
> 

