Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53732D9A9E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgLNPLq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 10:11:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2256 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgLNPLp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 10:11:45 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cvl9r4Q1yz67Mm3;
        Mon, 14 Dec 2020 23:07:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 14 Dec 2020 16:11:04 +0100
Received: from localhost (10.47.77.193) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 14 Dec
 2020 15:11:03 +0000
Date:   Mon, 14 Dec 2020 15:10:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: Re: IIO Driver for TMP117 Temperature sensor
Message-ID: <20201214151036.000015ee@Huawei.com>
In-Reply-To: <CANk7y0j1ujTDrxTKurs7EtRCmuP8s1V4Ueg6sDWzRbeP0zjvKA@mail.gmail.com>
References: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
        <CA+U=Dsr=SCdSsbsbdY++NwD4xQjr6PZuoOqa_Ctq6ig+GuvO=w@mail.gmail.com>
        <dd7f7015-aed4-8628-0f23-e144fdacc9e7@roeck-us.net>
        <20201213151253.059e541c@archlinux>
        <729575c9-317c-a2ae-9ded-8732f3cc481d@roeck-us.net>
        <20201213165003.5b7c1896@archlinux>
        <CANk7y0j1ujTDrxTKurs7EtRCmuP8s1V4Ueg6sDWzRbeP0zjvKA@mail.gmail.com>
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

On Mon, 14 Dec 2020 01:44:20 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> On Sun, Dec 13, 2020 at 10:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sun, 13 Dec 2020 08:08:26 -0800
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >  
> > > On 12/13/20 7:12 AM, Jonathan Cameron wrote:  
> > > > On Wed, 9 Dec 2020 11:48:40 -0800
> > > > Guenter Roeck <linux@roeck-us.net> wrote:
> > > >  
> > > >> On 12/9/20 12:11 AM, Alexandru Ardelean wrote:  
> > > >>> On Tue, Dec 8, 2020 at 6:10 PM Puranjay Mohan <puranjay12@gmail.com> wrote:  
> > > >>>>
> > > >>>> I have this TI's TMP117 sensor with me and I was thinking about writing an
> > > >>>> IIO driver for it as a hobby project. Is the IIO subsystem the correct
> > > >>>> place for this driver? if yes, can someone help me get started with this,
> > > >>>> I haven't written an IIO driver before. I have this sensor and also a
> > > >>>> raspberry pi with me for testing.  
> > > >>>
> > > >>> This could also fit into drivers/hwmon.
> > > >>> Looking at the HWMON subsystem there are more TMP drivers there
> > > >>> (TMP102/103/108/401/513).
> > > >>> The first 3 seem a bit more similar to TMP117 (in terms of register map).
> > > >>>  
> > > >>
> > > >> It would probably be better suited for hwmon (it has limit registers,
> > > >> suggesting a common use as hardware monitoring device).  
> > > > It is a curious part.  I suspect TI based their design for a medical grade
> > > > digital thermometer chip on an existing hwmon part.
> > > >
> > > > The limit registers are very simple so could be supported by IIO.
> > > > This sits somewhere in the middle of high end thermocouple chips which
> > > > tend to be in IIO and typically lower accuracy / range hwmon parts.
> > > >
> > > > It's in the fuzzy borderline region so I doubt anyone would raise strong
> > > > objections to which subsystem it was in.  Guenter has fallen on the
> > > > hwmon side of things and I'm fine with that.
> > > >  
> > >
> > > On the other side, it turns out that there is already tmp107 support
> > > in iio, and tmp107 is pretty much the spi equivalent of the same chip.
> > > So it really depends on the use case. If the user wants to use the iio
> > > subsystem, I am fine with it. We just need to remind people that this
> > > implies no or only limited hwmon support.
> > >
> > > [ I really need to spend the time to write a hwmon->iio bridge.
> > >   The iio->hwmon bridge is a bit limited - I have not been able to
> > >   figure out how to support limit registers (or event values)
> > >   and events, and I don't think it is possible. ]  
> >
> > So far IIO doesn't have an in kernel consumer interface for
> > events. It shouldn't be that hard to add one though and it
> > has been on the todo list for a very long time.  We've discussed
> > it a few times and concluded that there are some short cuts such
> > as sending all events to all consumers and relying on the receiver
> > to do any necessary filtering. It's a bit messy but it makes for
> > much simpler core code.
> >
> > Maybe I'll get bored enough over xmas to look at it...
> >  
> 
> Hi Jonathan,
> Where can I access this TODO list, I would like to do some tasks on it.
> I am a novice but I might be able to solve the easier tasks.

Sadly I'm rubbish at keeping an up to date list.  So this tends
to be scattered across numerous ancient discussions.

I do occasionally send out such a document, though I haven't done
so for some time.  I'll see if I can do a refresh sometime in next
month or so.

Thanks,

Jonathan

> 
> > Jonathan
> >  
> > >
> > > Guenter
> > >  
> > > > Jonathan
> > > >  
> > > >>  
> > > >>> Let's see what others have to add.
> > > >>> But, all-in-all whatever driver you end up writing, the easiest method
> > > >>> is to copy an existing similar driver and extend it.
> > > >>> Sometimes, a part can be added to an existing driver.
> > > >>> At a quick scan through existing drivers, it doesn't look like TMP117
> > > >>> is similar to existing drivers, so it may require a new driver
> > > >>> altogether.  
> > > >>
> > > >> I don't see an immediate match either, but the tmp102 hwmon driver
> > > >> might be a good start.
> > > >>
> > > >> Guenter
> > > >>  
> > > >>> I may have missed something though.
> > > >>>
> > > >>> Thanks
> > > >>> Alex
> > > >>>  
> > > >>>>
> > > >>>> --
> > > >>>> Thanks and Regards
> > > >>>>
> > > >>>> Yours Truly,
> > > >>>>
> > > >>>> Puranjay Mohan  
> > > >>  
> > > >  
> > >  
> >  
> 
> 

