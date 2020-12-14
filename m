Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC122D9CC9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 17:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgLNQfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 11:35:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2258 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgLNQfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 11:35:33 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cvn460FbYz67QJj;
        Tue, 15 Dec 2020 00:32:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 14 Dec 2020 17:34:51 +0100
Received: from localhost (10.47.77.193) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 14 Dec
 2020 16:34:51 +0000
Date:   Mon, 14 Dec 2020 16:34:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
Message-ID: <20201214163423.00005e6c@Huawei.com>
In-Reply-To: <e755c671-a212-e93c-427c-66ab031289c3@axentia.se>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
        <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
        <435ebb1b-431c-fdeb-023e-39c6f6102e22@axentia.se>
        <20201213121615.55a86f77@archlinux>
        <c34cc481-0244-a68e-8ae4-75e8e62b18bb@axentia.se>
        <20201214150728.00001fa7@Huawei.com>
        <e755c671-a212-e93c-427c-66ab031289c3@axentia.se>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.77.193]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Dec 2020 16:30:22 +0100
Peter Rosin <peda@axentia.se> wrote:

> On 2020-12-14 16:07, Jonathan Cameron wrote:
> > On Mon, 14 Dec 2020 09:34:40 +0100
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> On 2020-12-13 13:16, Jonathan Cameron wrote:  
> >>> On Sun, 13 Dec 2020 00:22:17 +0100
> >>> Peter Rosin <peda@axentia.se> wrote:
> >>>     
> >>>> On 2020-12-12 13:26, Linus Walleij wrote:    
> >>>>> On Mon, Nov 2, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >>>>>       
> >>>>>> It happens that an ADC will only provide raw or processed
> >>>>>> voltage conversion channels. (adc/ab8500-gpadc.c).
> >>>>>> On the Samsung GT-I9070 this is used for a light sensor
> >>>>>> and current sense amplifier so we need to think of something.
> >>>>>>
> >>>>>> The idea is to allow processed channels and scale them
> >>>>>> with 1/1 and then the rescaler can modify the result
> >>>>>> on top.
> >>>>>>
> >>>>>> Cc: Peter Rosin <peda@axentia.se>
> >>>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>      
> >>>>>
> >>>>> Did we reach any conclusion on this? I really need to use
> >>>>> the rescaler on an ADC that only handles processed channels...
> >>>>>
> >>>>> I'm sorry that I can't make this ADC disappear :D      
> >>>>
> >>>> Hi!
> >>>>
> >>>> My conclusion was that the patch is buggy since it presents inconsistent
> >>>> information. That needs to be fixed one way or the other. If the offending
> >>>> information cannot be filtered out for some reason, I don't know what to
> >>>> do. Details in my previous comment [1]. BTW, I still do not know the answer
> >>>> to the .read_avail question at the end of that message, and I don't have
> >>>> time to dig into it. Sorry.    
> >>>
> >>> Unless I'm missing something, I think it presents no information unless
> >>> we strangely have a driver providing read_avail for _RAW but only
> >>> _PROCESSED channels which is a bug.  I'm not that bothered about
> >>> missing information in this particular, somewhat obscure, corner case.
> >>>
> >>> So I think we should take the patch as it stands.  It's missed the
> >>> merge window now anyway unfortunately.  So Peter, I would suggest we
> >>> take this and perhaps revisit to tidy up loose corners when we all have
> >>> more time.    
> >>
> >> My concern was a driver with a raw channel, including read_avail, providing
> >> raw sample values but that no easy conversion existed to get from that to
> >> the processed values. One option for the driver in that case would be to
> >> provide these raw values, but then have no scaling info.  
> > 
> > Generally I resist this a lot. The reason is that it is impossible to write
> > generic userspace software against it. The one time we did let this happen
> > was with some of the heart rate sensors (pulse oximeters) where the algorithm
> > to derive the eventual value is both complex - based on published literature,
> > and proprietary (what was actually readily usable). What the measurement being
> > provided to userspace was is well documented, but not how on earth you get from
> > that to something useable for what the sensor is designed to measure.
> >   
> >> I.e. the way I see
> >> it, it is perfectly reasonable for a driver to provide raw with read_avail,
> >> no scaling but also processed values.  
> > 
> > Why?  What use would the raw values actually be?  There are a couple of historical
> > drivers where they evolved to this state, but it is not one we would normally accept.
> > We go to a lot of effort to try and avoid this.  
> 
> Drivers that have eveloved over time is exactly one such reason. E.g. a driver
> starts out by not caring about wrong measurements at one end of the spectrum
> because it is "linear enough" for the first use, someone comes along and fixes
> that. But by that time it's impossible to completely remove the raw channel
> because that would be a regression for some reason. And there you are. A
> driver with raw plus read_avail, no scaling but a processed channel. Or
> something like that...

Yup, that's pretty much what tends to happen.  I've gotten a lot stricter
on checking datasheets to try and stop this happening, but still possible more
will slip through (particularly as can't always get the datasheet)
> 
> >> And that gets transformed by the
> >> rescaler into the processed values being presented as raw, with rescaling
> >> added on top, but with the read_avail info for this new raw channel being
> >> completely wrong.
> >>
> >> For the intended driver (ab8500-gpadc) this is not the case (it has no
> >> read_avail for its raw channel). But it does have a raw channel, so adding
> >> read_avail seems easy and I can easily see other drivers already doing it.
> >> Haven't checked that though...  
> > 
> > Drat. I'd failed to register this is one of those corner cases.  
> 
> I'm not sure, I just browsed the code. Maybe I misread it?

It's doing both - you were right.  I think there are only a small number of
drivers that have that history.

Looks superficially like it's easy enough to catch this corner case and
block it - so lets do that.

Jonathan


> 
> Cheers,
> Peter
> 
> >> But if you say that this never happens, fine. Otherwise, since it's too
> >> late for the merge window anyway, the patch might as well be updated such
> >> that the rescaler blocks the read_avail channel in this situation, if it
> >> exists.  
> > 
> > That's fair enough.  A sanity check and then suitable warning message to explain
> > why it is blocked makes sense.  
> 

