Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A06DC8ED
	for <lists+linux-iio@lfdr.de>; Mon, 10 Apr 2023 18:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjDJQB6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Apr 2023 12:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjDJQBw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2023 12:01:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192951718
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 09:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B36161359
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 16:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC1EC433D2;
        Mon, 10 Apr 2023 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681142494;
        bh=FJeWT+C+euJtFT9e+IQ4o+S5unA3jy0XfT9LzpVwFJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gbZQ4Wri4YaFwT30inHZTOxeACKDglnCBdhzbAFBNdM6e8MvNxrQcPpcjePGQi8+q
         32hsru0RDnuwhvxe1ytchA9k+djDNUudW5hULUjYHcrtbTO+kM+VHWRHVisRYVZMAv
         hvLf22YUzNInBj9e7ux01/IJ39Hyc38cYmazR0YmGqw9oUdvq0lOnLyoz9wimt04Iv
         LoqQFlmS2GoUNAuj13OA1Udro+W2rL6uLhg9CZIjvV8uGuOzLVFwWQTZXYxpwmEwHq
         /wk1jRgW2fZENuOZdRn3PJC1xwwVS8hDCNI/7MJOKxus3O8mAxHXunQKwaRPVkgPOl
         s95DTPgzkkWtg==
Date:   Mon, 10 Apr 2023 17:16:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: ROHM BU27008 RGB sensor
Message-ID: <20230410171654.66605efe@jic23-huawei>
In-Reply-To: <5942c0c2-3997-e10f-0872-30d201bc52ae@gmail.com>
References: <5942c0c2-3997-e10f-0872-30d201bc52ae@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Apr 2023 15:04:38 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi deeee Ho peeps,
> 
> The ROHM BU27034 work seems to be slowly converging :) So, it is a good 
> time to start working with the next sensor sitting on my table.
> 
> This time I am dealing with an RGB+c+IR sensor, which once again has 
> some peculiarities. I would again be very grateful for any and all 
> pointers so I could head to the right direction.
> 
> The IC has 4 data channels. First two being always RED and GREEN. Third 
> can be configured to BLUE or CLEAR and fourth can be set to CLEAR or IR.

Guessing games, but are we talking a case where we are effectively
looking at a pair of two way muxes on the last two channels?
Or is this a case of one big mux and an oddly designed sequencer?
Doesn't actually make any difference. This is just odd enough that I'm curious.

> 
> I think I have the basic driver done. I expose all of the RGBC and IR as 
> own channels. Raw read is supported for all, and channels 3 and 4 are 
> configured for the read depending on channel to be read being B, C or IR.

Sounds good.

> 
> The device has a "data ready" IRQ, which is used for a trigger. 
> Triggered buffer is supported and channel configuration is written at 
> buffer enable, based on the active_scan_mask. The available_scan_masks 
> field is populated to prevent enabling all of the B, C and IR at same 
> time (because only 2 of them can be measured at same time as only 2 
> channels can be configured for B, C and IR).
> 
Sounds good.
	
> 
> I have following questions:
> 
> 1) I have no good knowledge as to what units the register values 
> represent. I know the greater value informs greater color intensity - 
> but that's about it. I currently just send out the raw register values 
> via IIO_INTENSITY raw channel - but I don't know if this is usual or if 
> typical user-space would expect the values to be some how 'normalized'? 

Given these colour curves are normally devices specific, it's often very hard
to give them any units that can be compared across devices.  There are standard
colour spaces, (CIE 1931 RGB for example) but basic sensors tend not to be matched
to these. Sometimes there are documented approximate conversion calculations
(similar to the ones you get for illuminance calculations).  In some cases
these are highly non linear with different approximations for different parts
of the colour space.

> With the current setup user-space needs to either just compare the 
> different channel values to each other to decide which colour dominates 
> - or perform some manual calibration using known light sources. I have 
> no idea if this is usual approach with RGB sensors? 
> It seems to me that 
> for example the adjd_s311.c just returns raw register values - but I 
> don't know what the format is. Any insight on if the values should 
> represent some 'units' or if they can really just be 'register values 
> proportional to intensity of measured colour'.

There isn't usually a way of measuring which colour dominates.  That depends
on all sorts of things that affect human perception of colour. All you can
measure is that the intensity of a particular colour is itself increasing
or decreasing. 

> 
> 2) The gain setting is once again ... eh ... complicated. The RGB and C 
> channels are sharing gain setting. There are a few supported gain values 
> - ranging from 1X to 1024X. The IR channel _shares_ again the high bits 
> of GAIN setting with the RGBC channels. Two lowest bits can be set 
> independently - but again, quite a few gain 'selector' field values are 
> marked as forbidden.
> 
> To make it worse, the IR gain values matching the selector field are 
> same as for RGBC - except the first selector. The sel 0 equals to gain 
> 1X on RGBC, but gain 2X for IR. (1X is not supported for IR). So, 
> changing gain selector from 0 => 1 will cause gain to jump from 1X => 4X 
> for RGBC but from 2X => 4X for IR channel.
> 

That's "novel".  Feel free to tell the Rohm hardware folk that I think they
are crazy in a really unhelpful way.

> I see two options:
> 
> 1) Use fixed high bits which means supporting only 4X and 16X gains - 
> for which changing the low selector bits is enough. In this case the 
> RGBC would have own gain setting, IR would have own and there would be 
> no shared bits.

That's pretty nasty as I suspect the high bits are the useful ones.

> 
> 2) Allow full range of supported gains to be set for RGBC - and disallow 
> setting gain for IR. However, change the IR gain to have same selector 
> as RGBC gain when RGBC gain is changed. (This prevents IR gain selector 
> from changing to an unsupported value when RGBC gain is changed). This 
> means that if user-space changes the gain for RGBC, it should also 
> read-back the gain for IR to detect the change. I have no idea if 
> existing user-space apps do this.

We've had other cases where setting a gain affects a subset of channels
(shared gains for pairs of channels for instance). In those cases userspace
has to read back the values.  I suspect there are no userspace programs
that do anything more complex than setting gain to a value in a config
file.  So if that's valid then all is good.

> 
> I think that no matter if we select option 1) or option 2) - we must 
> have own scale entries for all channels. This is needed for option 2) 
> because of the 1X vs 2X difference mentioned above.
> 
> I have currently implemented the option 2) because it supports wider 
> variety of gains - but I am unsure if this is "the right thing to do".
> 
> Any insight is appreciated!

Hmm. Given the pairwise case I mention above requires that any write to
gain can change any other and there is no strong reason it must change it
to the same value as the one written.  So setting channel 1 scale to x2 might
result in channel 2 scale doubling from x2 to x4 (think of a fixed x2 multiplier
on channel 2 with a pga in front of it (this craziness happens on SoC ADCs
sometimes) I think you can be more generic about this.

Have all channels have their own scale + scale_available.
A write to any of them changes the value with exception of when it affects only
the lower bits where you can separate off the IR channel.  If the change requires
changing the upper bits than fine it changes the IR gain as well.

Another option comes to mind.  Just have one scale value and don't allow the
lowest gain value.  That way you can always program the scales to the same value
by setting both registers.  So basically hid the oddity of that different
1x vs 2x initial scale by not supporting it.

Jonathan


> 
> Yours,
> 	-- Matti
> 

