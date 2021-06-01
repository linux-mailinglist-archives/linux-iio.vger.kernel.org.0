Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE37E397819
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhFAQdR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 12:33:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3125 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFAQdM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 12:33:12 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvcmW0lGjz6J8tv;
        Wed,  2 Jun 2021 00:19:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 18:31:29 +0200
Received: from localhost (10.52.121.71) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 17:31:28 +0100
Date:   Tue, 1 Jun 2021 17:31:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     Peter Rosin <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 4/9] iio: afe: rescale: add offset support
Message-ID: <20210601173122.0000616d@Huawei.com>
In-Reply-To: <CBRM73TM4R3Z.12A8GEYTETFNG@shaak>
References: <20210530005917.20953-1-liambeguin@gmail.com>
        <20210530005917.20953-5-liambeguin@gmail.com>
        <0769aaae-8925-d943-e57d-c787d560a8dc@axentia.se>
        <CBRGZCQWCG6S.676W3VCPMMUH@shaak>
        <01f8d320-05ae-1178-151a-d0d11a23bb55@axentia.se>
        <CBRIK3PI2AMD.3KUD7EI7NJ2EB@shaak>
        <ca30e3d2-7d9a-1c9d-9ae5-beefa2cd6492@axentia.se>
        <CBRM73TM4R3Z.12A8GEYTETFNG@shaak>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.71]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 May 2021 13:42:09 -0400
"Liam Beguin" <liambeguin@gmail.com> wrote:

> On Mon May 31, 2021 at 12:25 PM EDT, Peter Rosin wrote:
> > On 2021-05-31 16:51, Liam Beguin wrote:  
> > > On Mon May 31, 2021 at 10:08 AM EDT, Peter Rosin wrote:  
> > >> On 2021-05-31 15:36, Liam Beguin wrote:  
> > >>> Hi Peter,
> > >>>
> > >>> On Mon May 31, 2021 at 4:52 AM EDT, Peter Rosin wrote:  
> > >>>> Hi!
> > >>>>
> > >>>> Thanks for the patch!
> > >>>>
> > >>>> On 2021-05-30 02:59, Liam Beguin wrote:  
> > >>>>> From: Liam Beguin <lvb@xiphos.com>
> > >>>>>
> > >>>>> This is a preparatory change required for the addition of temperature
> > >>>>> sensing front ends.  
> > >>>>
> > >>>> I think this is too simplistic. I think that if the upstream iio-dev has
> > >>>> an offset, it should be dealt with (i.e. be rescaled). The rescale
> > >>>> driver
> > >>>> cannot ignore such an upstream offset and then throw in some other
> > >>>> unrelated offset of its own. That would be thoroughly confusing.  
> > >>>
> > >>> I'm not sure I fully understand. The upstream offset should be dealt
> > >>> with when calling iio_read_channel_processed().  That was my main
> > >>> motivation behind using the IIO core to get a processed value.  
> > >>
> > >> You can rescale a channel with an offset, but without using processed
> > >> values. I.e. the upstream channel provides raw values, a scale and an
> > >> offset. The current rescale code ignores the upstream offset. I did not
> > >> need that when I created the driver, and at a glace it felt "difficult".
> > >> So I punted.  
> > > 
> > > I understand what you meant now.
> > > 
> > > At first, I tried to apply the upstream offset from inside the rescaler.
> > > As you said it felt difficult and it felt like this must've been
> > > implemented somewhere else before.
> > > 
> > > After looking around, I noticed that the code to do that was already
> > > part of inkern.c and exposed through iio_read_channel_processed().
> > > If the upstream channel doesn't provide a processed value, the upstream
> > > offset and scale are automatically applied.
> > > 
> > > So with the changes in [3/9] the rescaler's raw value becomes the
> > > upstream channel's processed value.
> > > 
> > > This seems like an easier and probably cleaner way of adding offset
> > > support in the rescaler.
> > > 
> > > Does that make sense?  
> >
> > Yes, it does. Doing generic calculations like this efficiently with
> > integer math without losing precision is ... difficult.  
> 
> You're right, I realized it's more complicated that it seems working on
> this.

Yup, particularly given the processed version doesn't work because of
scale precision loss.  To avoid that mess you would have to do the
maths to rescale the offset.

If we assume offsets are integer (not always true, but often true for
ADCs) then it wouldn't be too bad, but you will need to handle all the
different ways scale can be specified (or support a subset perhaps).


> 
> >
> > I think that perhaps IF the upstream channel has an offset, the
> > rescaler could revert to always use the upstream processed channel in
> > preference of the raw channel. That would fix the missing support for
> > upstream offset and still not penalize the sweet case of no upstream
> > offset. Because the processed channel costs processing for each and
> > every sample and I think it should be avoided as much as possible.
> >
> > Does that make sense?  
> 
> Totally, I see what you're saying and will give it a try.
> 
> I still believe it would make sense to get the upstream scaling factor
> the same way, to avoid duplicating that code.
> 
> Also it might be confusing to have the raw value be the upstream raw
> value in some cases and the upstream processed value in others.
> 
> >
> > Or are a bunch of drivers adding an explicit zero offset "just because"?
> > That would be a nuisance.  
> 
> A quick search seems to indicate that this isn't the case.

We were pretty rigorous about this, though there are drivers that have
variable offsets where it will 'sometimes' be 0. 

It's an interesting corner, that we've been avoiding, but probably
not too bad to do at least the common combinations.

The fun will come when you are trying to sensible combine a scaled
offset and your new offset and need to do integer maths for.

A/(2**B) + C.D

There will probably be cases where we just take a decent stab at it
and assume precision might not be great.

Jonathan

> 
> Thanks for your time,
> Liam
> 
> >
> > Cheers,
> > Peter  
> 

