Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33360681758
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 18:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjA3RMX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 12:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbjA3RMW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 12:12:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C2D402D3
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 09:12:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5F4Q3Cm6z6J7Ln;
        Tue, 31 Jan 2023 01:08:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 17:12:19 +0000
Date:   Mon, 30 Jan 2023 17:12:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: ROHM ALS, integration time
Message-ID: <20230130171218.00007802@Huawei.com>
In-Reply-To: <9b3dcc7a-a0f8-38ee-4381-d330004d436f@fi.rohmeurope.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
        <20230130130231.000013b6@Huawei.com>
        <9b3dcc7a-a0f8-38ee-4381-d330004d436f@fi.rohmeurope.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Mon, 30 Jan 2023 13:42:27 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 1/30/23 15:02, Jonathan Cameron wrote:
> > On Mon, 30 Jan 2023 14:04:53 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:  
> 
> Hi Jonathan! Thanks for a _very fast_ response! It's nice "chatting" 
> with you again!
> 
> >>
> >> I hope this is all Ok from interface POV.  
> > 
> > This matches what I'd expect to see.  
> 
> Glad to hear :)
> 
> >> Now, finally, my dear persistent readers - the question:
> >> As mentioned, sensor allows setting the sampling time. I thought I'll
> >> map this to the IIO_CHAN_INFO_INT_TIME. This config is not per/channel
> >> in the hardware. Again, my lux-computing algorithm takes the integration
> >> time into account - and changing the time should not be reflected to the
> >> IIO_LIGHT channel values (other than accuracy). However, the values
> >> spilled from raw IIO_INTENSITY channels will change when integration
> >> time is changed. So, should I use the info_mask_shared_by_type =
> >> BIT(IIO_CHAN_INFO_INT_TIME) for IIO_INTENSITY channels?  
> > 
> > Ah. This problem. The mixture of two things that effectively map to scaling
> > of raw channels. As _scale must be applied by userspace to the _raw channel
> > that has to reflect both the result of integration time and a front end amplifier  
> 
> Ouch. I know that this makes perfectly sense. It indeed may not be clear 
> how the integration time impacts the scale. Thus, it is very reasonable 
> that the driver code should know this and not leave the burden to the 
> applications :/ Ouch because now I need to try inventing this logic in 
> driver myself ;)
> 
> > and is the control typical userspace expects to use to vary the sensitivity.  
> 
> Yes. Now that you wrote this it seems obvious.
> 
> > That makes it messy because it's not always totally obvious whether, when
> > trying to increase sensitivity, it is better to increase sample time or gain.
> > Usually you do sample time first as that tends to reduce noise and for light
> > sensors we rarely need particular quick answers.
> > 
> > So in the interests of keeping things easy to understand for userspace code
> > you would need to provide writeable _scale that then attempts to find the
> > best combination of amplifier gain and sampling time.   You can allow read
> > only access to allow a curious user to find out what was chosen:
> > INT_TIME for the integration time.  
> 
> Right. This still makes sense.
> 
> > Not really a good option for the amplifier gain though.  I don't like using
> > HARDWARE_GAIN for this though maybe we could stretch the ABI to cover this
> > as long as it was read only.  
> 
> Well, I don't (yet) have the need for this but it is good to keep on 
> mind :) It shouldn't be a big thing to add reading of (hardware)-gain.
> 
> >> Sorry for the long post. I do appreciate all help/pointers on my journey
> >> to writing my first light sensor drivers ;) And yes, my plan is to send
> >> out the patches - when I first get the sensor hardware at my hands ;)  
> > No problem. Light sensors tend to cause us more ABI headaches than almost
> > anything else  
> 
> Hm. This is the reason why I wanted to ask this right away. I realized 
> that we have a kernel<->user ABI once the sysfs starts spilling the 
> values from the driver. It wouldn't be such much fun 'fixing' this later on.
> 
>   (don't get me started on the ones used for blood oxygen level
> > measurement in which it's a light sensor and a controllable light source).  
> 
> Hmm... I think a colleague of mine did actually one such driver (AFAIR a 
> BH<add some numbers here>) not so many years ago ;) Not sure if it went 
> upstream though.
> 
> For an occasional contributor like me it could be helpful if the defines 
> like IIO_INTENSITY, IIO_LIGHT had documentation in headers explaining 
> for example the units. Maybe also some words about the 
> IIO_CHAN_INFO_INT_TIME and IIO_CHAN_INFO_SCALE as well ;) I guess I can 
> cook some doc - but only for couple of defines which I have discussed 
> with you this far. Do you think such comment docs would be welcome - 
> even if they covered only couple of defines? Maybe others would continue 
> from that.

I'd worry about the Docs disagreeing with the ABI docs
in Documentation/ABI/testing/sysfs-bus-iio
which needs to be the 'one true source' of this stuff.

So might be fine but would need careful consideration of that risk.

Jonathan
> 
> Yours,
> 	-- Matti
> 

