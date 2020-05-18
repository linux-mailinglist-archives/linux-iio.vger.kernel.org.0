Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520C41D7E84
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgERQa3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 18 May 2020 12:30:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbgERQa2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 May 2020 12:30:28 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D4239F39FD155421C674;
        Mon, 18 May 2020 17:30:22 +0100 (IST)
Received: from localhost (10.47.85.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 18 May
 2020 17:30:22 +0100
Date:   Mon, 18 May 2020 17:29:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
Message-ID: <20200518172954.00005fd8@Huawei.com>
In-Reply-To: <3136c4c7-b964-dce4-9e43-4cbbcc9187a1@metafoo.de>
References: <20200413082445.17324-1-nuno.sa@analog.com>
        <20200413082445.17324-6-nuno.sa@analog.com>
        <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
        <20200502184010.134eb8b5@archlinux>
        <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
        <df0f04296fafccfcf18b08b213bae20ff69c2384.camel@gmail.com>
        <20200503094751.633feda1@archlinux>
        <c7c6c4af-826a-d52a-3969-4ccccbff12e9@metafoo.de>
        <b7289aca-f393-faca-f512-a952a77c1e68@metafoo.de>
        <20200517171523.54fa6deb@archlinux>
        <3136c4c7-b964-dce4-9e43-4cbbcc9187a1@metafoo.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.85.42]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 21:07:45 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 5/17/20 6:15 PM, Jonathan Cameron wrote:
> > On Sun, 3 May 2020 11:12:34 +0200
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >  
> >> On 5/3/20 11:07 AM, Lars-Peter Clausen wrote:  
> >>> On 5/3/20 10:47 AM, Jonathan Cameron wrote:  
> >>>> On Sat, 02 May 2020 21:52:18 +0200
> >>>> Nuno Sá <noname.nuno@gmail.com> wrote:
> >>>>     
> >>>>> On Sat, 2020-05-02 at 20:01 +0200, Lars-Peter Clausen wrote:  
> >>>>>> On 5/2/20 7:40 PM, Jonathan Cameron wrote:  
> >>>>>>> On Mon, 27 Apr 2020 20:06:07 +0200
> >>>>>>> Lars-Peter Clausen <lars@metafoo.de> wrote:  
> >>>>>>>> On 4/13/20 10:24 AM, Nuno Sá wrote:  
> >>>>>>>>> [...]
> >>>>>>>>> +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> >>>>>>>>> +{
> >>>>>>>>> [...]
> >>>>>>>>> +    __be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
> >>>>>>>>> [...]
> >>>>>>>>> +
> >>>>>>>>> +    iio_push_to_buffers_with_timestamp(indio_dev, data, pf-  
> >>>>>>>>>> timestamp);  
> >>>>>>>> If the timestamp is enabled the IIO core might insert padding
> >>>>>>>> between
> >>>>>>>> the data channels and the timestamp. If that happens this will
> >>>>>>>> disclose
> >>>>>>>> kernel stack memory to userspace.
> >>>>>>>>
> >>>>>>>> This needs either a memset(data, 0x00, sizeof(data)) or maybe put
> >>>>>>>> data
> >>>>>>>> into the state struct and kzalloc it.  
> >>>>>>> Good spot. Could simply do __be16 data[ADI..] = {0}; rather than
> >>>>>>> explicit
> >>>>>>> memset, but some form of zeroization is needed.
> >>>>>>>
> >>>>>>> I've fixed up the applied patch with the above approach.  
> >>>>>> There is actually another issue. The stack data is not necessarily
> >>>>>> aligned to 64 bit, which causes issues if we try to put the 64-bit  
> >>>>> Oh, this is actually more problematic. Yes, since we have an array of
> >>>>> u16, that is not guaranteed to be 64bit aligned. Doing a quick search
> >>>>> of `iio_push_to_buffers_with_timestamp()` users and I could quickly
> >>>>> find 4/5 drivers with the same problem. I guess the API should clearly
> >>>>> state that `data` needs to be __at least__ 64 bits aligned (maybe a
> >>>>> future patch). Or we could even check the address and guarantee that it
> >>>>> is properly aligned before continuing (though Im guessing this will
> >>>>> break a lot of users...)  
> >>>>>> timestamp in it. I think data should really be in the state struct.  
> >>>>> Yes, with a proper __aligned(8) attribute... Or couldn't we just use
> >>>>> __aligned(8) on the stack variable?  
> >>>> Forcing alignment on the stack isn't terribly reliable, which is why
> >>>> we never do that for dma safe buffers.
> >>>>
> >>>> Probably better to just move it to the state structure.
> >>>> I'll fix it up to do that. Please sanity check what will shortly
> >>>> be in the testing branch.
> >>>>
> >>>> The moment Lars mentioned this I groaned. As you've noted a few other
> >>>> drivers have the same problem + the ABI doesn't clearly state
> >>>> or check this.
> >>>>
> >>>> We should certainly fix all the drivers that suffer this problem
> >>>> first then we can think about adding a runtime check.  
> >>> It looks like it is actually quite a few drivers, maybe we should
> >>> switch to put_unaligned(). We probably got lucky in most cases and the
> >>> buffer is naturally aligned to 64 bit.  
> > Just a quick update on this.  I've been taking a deeper look and there
> > are some 'interesting' cases in here so the put_unaligned is attractive
> > unfortunately I don't think we can go that way because it would be
> > reasonable for consumers of the buffer to expect it to be appropriately
> > aligned.   We need to rework many of these anyway to fix the related
> > data leak.
> >
> > I've done some of below and will post shortly - a few will take more
> > effort and probably need testing rather than just relying on review.
> >
> > So far the 'interesting ones' are mpu3050 and isl29501.  
> 
> isl29501 looks OK to me. mpu3050 is clearly broken, buffer is both 
> unaligned and too small!

isl29501 reads a pair of 8 bit registers, then writes them to a 32 bit value
for no particular reason and puts that in the first 32 bits of the buffer
having declared the channel to have a storage size of 16 bits.

So going to have some fun on one or other of the endian types...

J

> 


