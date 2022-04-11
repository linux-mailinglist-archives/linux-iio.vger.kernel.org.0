Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC04FB65F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Apr 2022 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiDKIyh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 11 Apr 2022 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiDKIyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2022 04:54:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A52DFE
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 01:52:23 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KcMxb5Vzvz6855X;
        Mon, 11 Apr 2022 16:50:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 10:52:21 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 09:52:20 +0100
Date:   Mon, 11 Apr 2022 09:52:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <dragos.bogdan@analog.com>
Subject: Re: GSoC Proposal 2022
Message-ID: <20220411095219.000058a8@Huawei.com>
In-Reply-To: <YlNcQEAZVGYBkdy5@fedora>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
        <20220410182819.23967855@jic23-huawei>
        <YlNcQEAZVGYBkdy5@fedora>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 Apr 2022 19:37:52 -0300
Maíra Canal <maira.canal@usp.br> wrote:

> On 04/10, Jonathan Cameron wrote:
> > On Thu, 7 Apr 2022 00:23:29 -0300
> > Maíra Canal <maira.canal@usp.br> wrote:
> >   
> > > Hi everyone, I am Maíra Canal an undergrad student at the University
> > > of São Paulo, Brazil, pursuing
> > > computer engineering. I wish to participate in the GSoC 2021 as a part
> > > of the Linux Foundation, IIO Project.  
> > 
> > Hi Maíra,
> > 
> > Nice to 'meet' you ;)
> >   
> > > 
> > > I have been contributing to the Linux kernel for a couple of months
> > > and have more than 20
> > > accepted patches in a couple of subsystems.
> > > 
> > > I started looking through the catalog of Analog Devices Inc. and I'm
> > > pretty interested in writing a driver for gyroscopes, inertial
> > > measurement units (IMUs), magnetometers, pressure sensors, proximity
> > > sensors, or temperature sensors. But, while looking through the
> > > catalog, I could not figure out a sensor that would be relevant to
> > > Linux Kernel. I mean, I would like to work on a sensor that would be
> > > relevant to the community and to Analog Devices Inc.
> > > 
> > > In that sense, I would like to know if anyone in the IIO community
> > > could recommend a sensor that would make sense for the company and the
> > > IIO community. Any suggestion is appreciated!  
> > 
> > I'm not going to recommend a particular sensor, but more offer some general
> > tips on what 'sort' of device makes a good target for a GSOC.
> > Finding a sensor means trawling datasheets and I'm tight on time today
> > + I've no real insight into what the ADI folk might like to see
> > supported!
> > 
> > The nature of a GSOC driver submission is often a little different to
> > how an experienced driver author might go about things, simply because you
> > will / should be looking for feedback at more stages of development and
> > hopefully to upstream things in multiple stages.  An old hand at IIO
> > drivers will often just jump directly to a driver supporting all the
> > features they wish to target.  As such, the 'perfect' device to target
> > should meet a few requirements that may not be true for the approach of jumping
> > straight to the end goal.  Note this is equally true for other people
> > starting out writing drivers - though they can often do very simple
> > devices first and that is not a good plan for a GSOC project where
> > you need to have a progression during the project.
> > 
> > Try to find something that offers some advanced features to provide
> > stretch goals but make sure the basic functionality will work with
> > a much simpler driver. So devices that provide straight forward
> > registers to access the latest channel value are great, whereas
> > those that only offer a streaming interfaces / fifo may be less suitable.
> > However if they offer both that is perfect as the fifo make a good
> > later feature for a GSOC project if things are going particularly
> > well!  For a real stretch goal, find a device with features that
> > we don't support at all today (perhaps new sensor types, or some
> > other new feature) as they'll give you the experience of defining
> > new ABI + possibly modifying the IIO core to meet some requirements.
> > 
> > Another thing to look at it is whether the part is sufficiently
> > different from those supported by existing drivers to justify a
> > separate driver. If not, you may find your GSOC project becomes
> > simply adding an ID! (then rapidly choosing a second device to
> > work on).
> > 
> > Hope that provides a few hints on what to look at.  Probably the best
> > way around is to suggest one or more parts you think look interesting
> > then we can give feedback on whether we think they'd be a good choice
> > or not.  
> 
> Hi Jonathan,
> 
> I really appreciate the answer. Thank you for your attention and time!
> 
> During the week, I ended up picking the ADXL375 accelerometer (although I am
> open to any change proposed by ADI or the IIO community). Based on that device,
> I wrote a proposal and I would appreciate if you provide some feedback on the
> device choice and proposal: https://pt.overleaf.com/read/xsmmdpvzqrhd.

Unfortunately that part hits the second to last paragraph above.

It's so nearly compatible with the ADXL345 that the driver already supports it:
https://elixir.bootlin.com/linux/v5.18-rc1/source/drivers/iio/accel/adxl345_i2c.c#L42
This is very common for these types of devices as there are often many similar
variants, usually with different ranges or with small additional features, or numbers
of interrupt pins etc.  Another fun one is parts with ratings for different applications
but identical software interfaces being given different part numbers.
I think in this case the two parts have different scaling, but are otherwise
identical.

So probably need to find another part.

Jonathan

> 
> Regards,
> Maíra
> 
> > 
> > Good luck!
> > 
> > Jonathan
> > 
> > 
> >   
> > > 
> > > Sincerely,
> > > Maíra Canal  
> >   

