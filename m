Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE83722F03
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jun 2023 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjFES4y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jun 2023 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjFES4m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jun 2023 14:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4FEC
        for <linux-iio@vger.kernel.org>; Mon,  5 Jun 2023 11:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC87A628BA
        for <linux-iio@vger.kernel.org>; Mon,  5 Jun 2023 18:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7886BC433D2;
        Mon,  5 Jun 2023 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685991400;
        bh=TUHYdS5cE1scLUvyJf91Aw8l+VCJAIBcf7dJ1sgY9hw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kHyBRx3qmQA56fL7pIRqIz3u5nKDb2T/Wv3X8FyWpTwdC0L3zdSmyYsSxypZphf3R
         139yGhPyCuohK6uT+o++in9rxZtijLkQSNznfVvNDh+ME9MowZeIuNh3Wy6hpUz7Iv
         SY0VJTokujEKs2L2MhHmxCapH1QRRHjA82FmYsu7bqXKVK3bfsLxX3mpKU6nvMDBnZ
         d0mMtiC463DKZ833Yl39vMvCjJBLXu0gKaCROPpIZ5NDir5uUuAxqOnfAS7ANqF7QZ
         /rL/AWxE+wqwDa1NJ2KTeNn0qAgvfE5ar5nzC1W8lyVx2VTNKTjEDmZwr9WkZnhyHA
         fLvzou4f7JgTQ==
Date:   Mon, 5 Jun 2023 19:56:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: ROHM BM1390 support
Message-ID: <20230605195638.7ca74937@jic23-huawei>
In-Reply-To: <ed1325f1-724a-139b-a3ae-c845ac4785bc@gmail.com>
References: <2e722c05-9548-f8da-2d72-1ba76a1e2508@gmail.com>
        <20230604142818.5cb35858@jic23-huawei>
        <ed1325f1-724a-139b-a3ae-c845ac4785bc@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Mon, 5 Jun 2023 09:56:36 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi dee Ho - and a big "Thank you" :)
> 
> On 6/4/23 16:28, Jonathan Cameron wrote:
> > On Tue, 30 May 2023 11:20:59 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> Hi dee Ho peeps,
> >>
> >> Once again I am trying to learn from more experienced sensor folks :)  
> > 
> > (Someone get Matti some nice simple devices to add support for - he needs
> > a rest!) :)  
> 
> I don't really mind technical challenges :) But what I would really like 
> to have in our company - and what I do really appreciate getting from 
> you - is someone who I can discuss with to clarify these things :)
> 
> >> I am currently working (also) on ROHM BM1390 pressure sensor. The sensor
> >> can measure pressure ranging 300 - 1300 hPa. Measurement times can be
> >> around 20 - 160 mS depending on the amount of samples being averaged.
> >> There is also an IIR filter included in sensor with 3 different settings
> >> titled as "weak", "middle" and "strong". Unfortunately the exact maths
> >> is not explained.  
> > 
> > Gah.  We all love this sort of dumbing down in datasheets.
> > There is a picture though... Hmm. Anyone remember enough about filter
> > design to tell me if you can go from a 63% point on a step response (in time domain)
> > to a 3DB in frequency?  I'd go with probably not but it's been far too many years
> > since I did any of this so I could be wrong.  
> 
> I haven't been dealing with this type of maths since my university 
> studies - and I think I participated last related courses somewhere 
> around 2003 or so. Whoah - I just realized that's 20 years ago! Where 
> did the time go? I did send a question about 3DB boundary frequencies to 
> the HQ though. I wouldn't bet on it but who knows, maybe I can get the 
> actual filter types and the frequencies from there.
> 
> > I'd kick this into the long grass - pressure sensors that aren't the type that you
> > connect to a pipe tend to be for measuring slow changes, so I'd just set it to
> > the middle value and not worry about making it configurable.  
> 
> I was considering just having the IIR disabled by default, but maybe the 
> "middle" setting would indeed be the best way to go.
> 
> > Can revisit later.
> >     
> >> Furthermore, the sensor can be configured to store
> >> maximum of 4 measured pressure samples in a HW FIFO.
> >>
> >> The sensor can also measure temperature and error for temperature
> >> measurement is told to be +/- 2C when temperature is in a range of 25 C
> >> - 85 C. On the other hand, operating temperature for the device is said
> >> to be -40 C - 85 C.  
> > 
> > Helpful to have a sensor with no defined precision in the range
> > in which the device is meant to operate. *sniggers*
> > I wonder if it's a typo as the operating range matches the storage range
> > which is unusual.  
> 
> I am not sure. The data-sheet does specifically mentions that the 
> temperature value is signed. It sounds like the sensor was really 
> designed to be used in negative temperatures (degrees C).
> 
> But yes, the error limit spec is indeed ...
> 
> Furthermore, the +/-2 C is (IMO) insane unless it means the error is 
> "systematic" and can be compensated to some extent after calibration. I 
> don't think the +/- 2 means it is "in spec" to have measurements jumping 
> up to 4 C in a range of 25 C - 85 C... Well, this is just my thinking 
> though.

If there are any suggested temp compensation algorithms for this sensor
you may get an idea of how much it matters. Sometimes the answer is not much
at all as the temperature dependence is pretty small so 20 degree changes
become significant but not +-5 or so.

> 
> >> Now, the temperature measurements are not stored in a FIFO.
> >>
> >> Here comes my question - what do you see as the typical use-cases for
> >> such a sensor? Or, to be more exact, do you think "quick" changes in
> >> temperature are expected to be measured with this type of sensor?  
> > 
> > My understanding of pressure sensors is a bit weak so the following might
> > not be accurate...
> > 
> > No. Temp stuff on pressure sensors is normally there for temperature compensation
> > algorithms.
> >   
> >> I am
> >> asking this because I would like to support using the hardware FIFO and
> >> I am wondering if reading the temperature at FIFO flush and populating
> >> also the temperature channel values corresponding to all (up to 4)
> >> pressure measurements would be the best approach?
> >>
> >> Other options is to not support using FIFO when temperature is scanned.  
> > 
> > A third is only let the temperature be read from sysfs.  That's fairly common
> > in devices like this where the temp sensor isn't expected to be read as often
> > as the others and maps to what we can actually control.  (scan_index == -1)  
> 
> I thought of this as well. It however gets somewhat "hairy" to allow 
> direct mode access when buffering is used - and I am not sure how 
> convenient it is for users to stop the pressure measurement when 
> temperature is measured.

Ah. Fair enough - some sensors separate this enough that it's straight
register read, so on those this approach ends up easy - not in this case
it seems.

> 
> The problem of allowing buffering pressure values when raw-reading 
> temperature values comes from the fact that:
> a) start/stop for temp/pressure measurement is common and
> b) if data-ready IRQ is not used we don't have any information about 
> when the temperature measurement is completed. Finally,
> c) the sensor must not be accessed when FIFO is read.

I'm guessing the dance of grabbing temperature after fifo watermark
events may still cause you some trouble.  Will be interesting to see
how this works out.

> 
> I guess all of these a), b), and c) could be worked around - but the 
> result might not be completely trivial. Thus, stuffing the temperatures 
> in buffer seem simpler for driver and user - although it does waste some 
> bytes. Well, since the sensor is not _really_ high speed thing the 
> memory consumption should still (probably) stay sane. So, if the 
> use-case is not such that temperature changes several degrees / second - 
> then I think I will just stuff the temperatures in buffer as well.

As long as userspace can opt out of capturing it, I'd not worry about the
overhead etc.

> 
> > IIRC some of the IMUs do this as again temp not expected to change much, but
> > it if has radically different stable values it will affect precision calibration.
> >   
> >>
> >> I have a gut feeling that the users who measure pressure are often also
> >> interested in getting the temperatures. Hence I would like to allow
> >> getting both. "Cheating" by using the same temperature value (measured
> >> when FIFO is flushed) should be Ok if temperature is not changing
> >> rapidly as even with the slowest measurement speed collecting 4 samples
> >> should finish in well under a second - and mentioned accuracy for the
> >> temperature sensor is such that small temperature changes are probably
> >> going unnoticed anyways.  
> > 
> > Fifo normally only of interest at high rates anyway, not that it makes much
> > practical difference when implementing the driver.
> >   
> >>
> >> Here I would love to have an opinion from more experienced IIO
> >> developers/users - and potentially a hint how similar sensors have been
> >> handled previously. (I would assume not storing some slowly changing
> >> values in a HW FIFO is quite common because HW FIFOs won't come without
> >> a cost).  
> > 
> > I don't really mind if you either go with
> > 1 - fill it copies of same temperature.
> > 2 - only have temp via sysfs (this I know we've done a bunch of times)  
> 
> So, I'll start with 1 :)
> 
> > 
> > The mess of switch between fifo and non fifo depending on whether the
> > temp sensor is in the scan strikes me as too fiddly to make sense.
> >   
> 
> Agree!
> 
> Thanks once again Jonathan, You're really helpful!

No problem,

Jonathan

> 
> Yours,
> 	-- Matti
> 

