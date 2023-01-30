Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836CC680E5E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 14:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbjA3NCg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 08:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjA3NCf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 08:02:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58123172B
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 05:02:34 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P57Xx4vX3z6H7Q6;
        Mon, 30 Jan 2023 20:58:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 13:02:32 +0000
Date:   Mon, 30 Jan 2023 13:02:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: ROHM ALS, integration time
Message-ID: <20230130130231.000013b6@Huawei.com>
In-Reply-To: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Jan 2023 14:04:53 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi deee Ho peeps,
> 
> I am currently writing drivers for couple of ROHM light sensors. At 
> least two RGBC+IR and one ALS. I have some difficulties deciding how 
> some of the IIO API values should be mapped to the sensor configs. (So, 
> not missing much, right? Basically just THE THING any IIO driver is 
> expected to do XD).
> 
> Okay, that's for the intro. I'll ask about the ALS first.
> 
> === The Hardware:
> 
> The sensor gets the data from 3 photo-diodes - values from each are 
> readable via own channel (say, data0, data1, data2).
> 
> data0 and data1 have the sensitivity peaks around 500 and 600 nm - which 
> is visible light but channels are not really R/G/B. The data2 is 
> probably IR - but I am not really 100% sure so I plan to skip it at first.

Ah.  The color type interface has always been a big 'clunky'.
We have in the past discussed adding some ABI to describe actual sensitive
ranges but it's tricky as these curves are often complex.  I'm open
to suggestions on how to do this though (as long as you also add it
to a few existing drivers as examples!)

> 
> The channel gain can be set individually,. The sampling time can be set 
> globally for all channels.
> 
> 
> === The driver draft I'm working with
> 
> I have some kind of formula for converting the channel0 and channel1 
> data to lux. So, I thought I'll provide 3 channels from driver - one 
> IIO_CHAN_INFO_PROCESSED IIO_LIGHT channel spilling out luxes (with 
> appropriate scale) - and two IIO_INTENSITY channels spilling out the raw 
> register values so that if greater accuracy is needed one can do better 
> algorithms to user-space.
> 
> Q1 - does this sound like reasonable option?
> 
> Then, I thought I'll support setting the GAIN for channels using the 
> IIO_CHAN_INFO_SCALE. Straightforward division / multiplication (I hope).
> 
> Eg, for the IIO_INTENSITY channels I though I'll just implement 
> raw_write/raw_read for scale so, that raw_read returns 
> IIO_VAL_INT_PLUS_NANO - and then for example gain 4x would be
> val = 0, val2 = 250 MEGA, 8x would be 0, 1 * GIGA / 8 ...
> Eg, val2 for gain values > 1 would be GIGA/gain using IIO_VAL_INT_PLUS_NANO.
> 
> I hope this makes sense :)
> 
> Well, currently my "not-yet-implemented using C w/o floats" - algorithm 
> takes the scale into account and always returns luxes (for 
> IIO_CHAN_INFO_PROCESSED IIO_LIGHT - channel). However, the IIO_INTENSITY 
> channels return raw data from registers - so setting GAIN (scale) has 
> direct impact to the INTENSITY values. I guess this is Ok as the 
> IIO_CHAN_INFO_SCALE is only set in .info_mask_separate for the 
> IIO_INTENSITY type channels - not for the IIO_CHAN_INFO_PROCESSED 
> IIO_LIGHT channel. [Even though I decided to go this route I am still 
> somewhat unsure if this is the right thing to do(tm). My problem is that 
> in HW level, setting the GAIN does also impact the data based on which 
> the IIO_LIGHT values are computed. The scale just is not visible in 
> computed values as it is taken into account by the equation. 
> Furthermore, setting GAIN(or scale) for IIO_LIGHT would not be 
> unambiguous as the IIO_LIGHT is composed from two channels, both having 
> own gain settings.]
> 
> I hope this is all Ok from interface POV.

This matches what I'd expect to see.  

> 
> Now, finally, my dear persistent readers - the question:
> As mentioned, sensor allows setting the sampling time. I thought I'll 
> map this to the IIO_CHAN_INFO_INT_TIME. This config is not per/channel 
> in the hardware. Again, my lux-computing algorithm takes the integration 
> time into account - and changing the time should not be reflected to the 
> IIO_LIGHT channel values (other than accuracy). However, the values 
> spilled from raw IIO_INTENSITY channels will change when integration 
> time is changed. So, should I use the info_mask_shared_by_type = 
> BIT(IIO_CHAN_INFO_INT_TIME) for IIO_INTENSITY channels?

Ah. This problem. The mixture of two things that effectively map to scaling
of raw channels. As _scale must be applied by userspace to the _raw channel
that has to reflect both the result of integration time and a front end amplifier
and is the control typical userspace expects to use to vary the sensitivity.

That makes it messy because it's not always totally obvious whether, when
trying to increase sensitivity, it is better to increase sample time or gain.
Usually you do sample time first as that tends to reduce noise and for light
sensors we rarely need particular quick answers.

So in the interests of keeping things easy to understand for userspace code
you would need to provide writeable _scale that then attempts to find the
best combination of amplifier gain and sampling time.   You can allow read
only access to allow a curious user to find out what was chosen:
INT_TIME for the integration time.
Not really a good option for the amplifier gain though.  I don't like using
HARDWARE_GAIN for this though maybe we could stretch the ABI to cover this
as long as it was read only.

> 
> Sorry for the long post. I do appreciate all help/pointers on my journey 
> to writing my first light sensor drivers ;) And yes, my plan is to send 
> out the patches - when I first get the sensor hardware at my hands ;)
No problem. Light sensors tend to cause us more ABI headaches than almost
anything else (don't get me started on the ones used for blood oxygen level
measurement in which it's a light sensor and a controllable light source).

Jonathan

> 
> Yours,
> 	-- Matti
> 

