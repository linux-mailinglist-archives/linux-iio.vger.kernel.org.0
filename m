Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17EC6A331E
	for <lists+linux-iio@lfdr.de>; Sun, 26 Feb 2023 18:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBZRM1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Feb 2023 12:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBZRMT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Feb 2023 12:12:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3B4FF2B
        for <linux-iio@vger.kernel.org>; Sun, 26 Feb 2023 09:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E3260C3D
        for <linux-iio@vger.kernel.org>; Sun, 26 Feb 2023 17:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4985C433EF;
        Sun, 26 Feb 2023 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677431535;
        bh=EhF8dPtrt6jNkC5fbTpS19q2MOhI5JIBO5PFeoB8GZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mXOwHifs2vMNHQ9T/3x21DB4ZnGSPMlwC+6n7ph1zYETPT3RAdOYCeuvmZQE+q60X
         RAaswedO9tdz8nyPIs3RUVnErfjnOdBz1QzWoOIjzKxH6Mdowc8hQv1kL0oIzvFfGe
         jQbak8nVV8z5OIT32GSwfpbIw86rLwqvlAikOGK3TXAxiQYaGb2nxaqOC1a3VIgiDM
         GjrVchFINL5697kwOXZJ+Fd3GVUIICpwsPjIibhzvGTAI+zQWXbTlY4joAy8bCnjQf
         h8BM6PhisjYEJLyuVw2ODWRYpRcnfSZhPaKNsOFC3XKPlaUmmz28EAw3mYHf+1/00+
         swaWHrHsUzDPQ==
Date:   Sun, 26 Feb 2023 17:26:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: ROHM ALS, integration time
Message-ID: <20230226172640.40e9accc@jic23-huawei>
In-Reply-To: <18a6709b-4d26-2672-b056-669750b4828c@gmail.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
        <20230130130231.000013b6@Huawei.com>
        <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
        <20230202165714.0a1c37ac@jic23-huawei>
        <11722ea9-7149-0305-5593-7a66dc1d73f0@fi.rohmeurope.com>
        <20230218172052.12c44aa5@jic23-huawei>
        <18a6709b-4d26-2672-b056-669750b4828c@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Feb 2023 20:08:10 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Thanks a lot Jonathan,
> 
> You have been super helpful :) Thanks!
> 
> On 2/18/23 19:20, Jonathan Cameron wrote:
> >>>> such it can't compensate the scale change.  
> >>
> >> Regarding the scale:
> >>
> >> When scale is changed by user, the driver attempts to maintain
> >> integration time and perform only the gain change. If requested scale
> >> can not be supported by any available gain using the current integration
> >> time, then the driver attempts to change both the gain and integration
> >> time to achieve requested scale. (If this also fails, then an error is
> >> returned).
> >>
> >> I guess this is what is expected to happen in "normal mode".  
> > 
> > Interesting. I was actually thinking prefer to change integration time
> > but your way may make more sense.
> >   
> >>
> >> As I mentioned earlier, this does not allow a great control over the
> >> integration time for users who (may?) wish to have shorter time with
> >> gain bigger than 1x.
> >>
> >> Hence the writeable integration time.
> >> Now, an user may request different integration time by writing the
> >> integration time. I assumed this is also normal operation assuming this
> >> does not cause a scale change?  
> > 
> > If magic mode write hasn't happened, then integration time should reject
> > writes. Interface is too complex otherwise because if a user writes the
> > integration time then the scale, they'll expect that their integration
> > time has not changed.  
> 
> I agree that changing the integration time set by the user could be 
> unexpected. OTOH, if we take the approach I explained above (Eg. try 
> keeping integration time intact when scale is changed and only change 
> int-time if gain alone can't provide requested scale), then the 
> integration time would not change is user asks for scale we can support 
> with the set integration time.
> 
> There is few bumps on the road though... I am not exactly sure how to 
> decide available scales to advertise. Nor am I sure how to deal with the 
> scale settings when requested scale can't be met with gain change alone 
> but where scale is also not at the one of the extreme ends (which could 
> clearly warrant the integration time change) - but is somewhere in the 
> mid-range. This can happen because the supported gains have "jumps". 1x 
> to 4x (skipping 2x), to 16x (skipping 8x) to 32, 64, and then to 256 
> (skip 128), 512, 1024, 2048 and 4096.
> 
> Integration times are 50, 100, 200, 400 - which means that some of the 
> 'mid range' scales can be only supported by some integration times.

Tricky corner indeed. I'd be tempted to say don't always give people what
they request.  Generally speaking (ignore the complexity of your case)
the aim is to increase scale to the maximum that can be done without saturating
for the range people care about.  It is rarely a problem if we undershoot a little
in order to map to something that works on the hardware.  That freedom might help
you a little in this case.

> 
> I will try to cook an RFC next week to show what I have drafted if there 
> is no big surprizes on the road..
> 
> Yours,
> 	-- Matti
> 

