Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289C42D9A9D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 16:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgLNPMm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 10:12:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2257 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406692AbgLNPMe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 10:12:34 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CvlCh2qVlz67Q1l;
        Mon, 14 Dec 2020 23:09:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 14 Dec 2020 16:11:52 +0100
Received: from localhost (10.47.77.193) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 14 Dec
 2020 15:11:51 +0000
Date:   Mon, 14 Dec 2020 15:11:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: Re: IIO Driver for TMP117 Temperature sensor
Message-ID: <20201214151124.00007c55@Huawei.com>
In-Reply-To: <CANk7y0gaq9Qb6BBpv4PY8T50Xep19Vh=wEx3hBWG_jDcqGSZJg@mail.gmail.com>
References: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
        <CA+U=Dsr=SCdSsbsbdY++NwD4xQjr6PZuoOqa_Ctq6ig+GuvO=w@mail.gmail.com>
        <dd7f7015-aed4-8628-0f23-e144fdacc9e7@roeck-us.net>
        <20201213151253.059e541c@archlinux>
        <729575c9-317c-a2ae-9ded-8732f3cc481d@roeck-us.net>
        <CANk7y0gaq9Qb6BBpv4PY8T50Xep19Vh=wEx3hBWG_jDcqGSZJg@mail.gmail.com>
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

On Mon, 14 Dec 2020 01:40:32 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> On Sun, Dec 13, 2020 at 9:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 12/13/20 7:12 AM, Jonathan Cameron wrote:  
> > > On Wed, 9 Dec 2020 11:48:40 -0800
> > > Guenter Roeck <linux@roeck-us.net> wrote:
> > >  
> > >> On 12/9/20 12:11 AM, Alexandru Ardelean wrote:  
> > >>> On Tue, Dec 8, 2020 at 6:10 PM Puranjay Mohan <puranjay12@gmail.com> wrote:  
> > >>>>
> > >>>> I have this TI's TMP117 sensor with me and I was thinking about writing an
> > >>>> IIO driver for it as a hobby project. Is the IIO subsystem the correct
> > >>>> place for this driver? if yes, can someone help me get started with this,
> > >>>> I haven't written an IIO driver before. I have this sensor and also a
> > >>>> raspberry pi with me for testing.  
> > >>>
> > >>> This could also fit into drivers/hwmon.
> > >>> Looking at the HWMON subsystem there are more TMP drivers there
> > >>> (TMP102/103/108/401/513).
> > >>> The first 3 seem a bit more similar to TMP117 (in terms of register map).
> > >>>  
> > >>
> > >> It would probably be better suited for hwmon (it has limit registers,
> > >> suggesting a common use as hardware monitoring device).  
> > > It is a curious part.  I suspect TI based their design for a medical grade
> > > digital thermometer chip on an existing hwmon part.
> > >
> > > The limit registers are very simple so could be supported by IIO.
> > > This sits somewhere in the middle of high end thermocouple chips which
> > > tend to be in IIO and typically lower accuracy / range hwmon parts.
> > >
> > > It's in the fuzzy borderline region so I doubt anyone would raise strong
> > > objections to which subsystem it was in.  Guenter has fallen on the
> > > hwmon side of things and I'm fine with that.
> > >  
> >
> > On the other side, it turns out that there is already tmp107 support
> > in iio, and tmp107 is pretty much the spi equivalent of the same chip.  
> 
> Yes, you are right, tmp107 is very similar to tmp117, but it is less accurate
> and it doesn't include the OFFSET functionality. Actually, I had seen the
> tmp107 register in IIO and thought that tmp117 should go in IIO,
> hence, I wrote this email.
> 
> So, is it fine if I write the IIO driver for this sensor? Actually,
> this will just
> be a hobby project for me so It doesn't bother me if it goes in hwmon or IIO.

Sounds good to me.

Jonathan


> 
> > So it really depends on the use case. If the user wants to use the iio
> > subsystem, I am fine with it. We just need to remind people that this
> > implies no or only limited hwmon support.
> >
> > [ I really need to spend the time to write a hwmon->iio bridge.
> >   The iio->hwmon bridge is a bit limited - I have not been able to
> >   figure out how to support limit registers (or event values)
> >   and events, and I don't think it is possible. ]
> >
> > Guenter
> >  
> > > Jonathan
> > >  
> > >>  
> > >>> Let's see what others have to add.
> > >>> But, all-in-all whatever driver you end up writing, the easiest method
> > >>> is to copy an existing similar driver and extend it.
> > >>> Sometimes, a part can be added to an existing driver.
> > >>> At a quick scan through existing drivers, it doesn't look like TMP117
> > >>> is similar to existing drivers, so it may require a new driver
> > >>> altogether.  
> > >>
> > >> I don't see an immediate match either, but the tmp102 hwmon driver
> > >> might be a good start.
> > >>
> > >> Guenter
> > >>  
> > >>> I may have missed something though.
> > >>>
> > >>> Thanks
> > >>> Alex
> > >>>  
> > >>>>
> > >>>> --
> > >>>> Thanks and Regards
> > >>>>
> > >>>> Yours Truly,
> > >>>>
> > >>>> Puranjay Mohan  
> > >>  
> > >  
> >  
> 
> 

