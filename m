Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB74FE57C
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbiDLQBy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 12 Apr 2022 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244547AbiDLQBy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 12:01:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD5275DB
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 08:59:34 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kd9Ll4NPdz67WPG;
        Tue, 12 Apr 2022 23:56:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 17:59:32 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 16:59:31 +0100
Date:   Tue, 12 Apr 2022 16:59:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "=?ISO-8859-1?Q?Ma=EDra?= Canal" <maira.canal@usp.br>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hegbeli, Ciprian" <ciprian.hegbeli@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: GSoC Proposal 2022
Message-ID: <20220412165926.000004c7@Huawei.com>
In-Reply-To: <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
        <20220410182819.23967855@jic23-huawei>
        <YlNcQEAZVGYBkdy5@fedora>
        <20220411095219.000058a8@Huawei.com>
        <YlQpcZvwZuabMsz+@fedora>
        <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
        <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
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

On Tue, 12 Apr 2022 14:06:21 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Tue, 2022-04-12 at 11:48 +0300, Andy Shevchenko wrote:
> > On Tue, Apr 12, 2022 at 10:43 AM Maíra Canal <maira.canal@usp.br>
> > wrote:  
> > > On 04/11, Jonathan Cameron wrote:  
> > 
> > ...
> >   
> > > I took another look at the Analog Devices Inc. catalog and choose
> > > another
> > > couple of options:
> > > 
> > >     - ADPD188BI and ADPD410x: are optical devices based on SPI/I2C.
> > > I guess they
> > >     might be too bold for a GSoC project.
> > >     - MAX31875: is a Temperature Sensor based on I2C. Different
> > > than the optical
> > >     devices, this one might be too simple.  
> >   
> > >     - LTC2499: is a multiplexed ADC sensor. For now, it is my best
> > > option.  
> > 
> > Have you checked if it has similarities to 2496 and 2497 variants? We
> > already have drivers for those, it makes sense to double check.
> >   
> 
> Yeah, after a quick look on the datasheet, they look very similar...
> 
> The MAX31875 looks to be a fairly simple one (maybe a good candidate
> for a first driver) but, IMO, having it in IIO boils down to have
> support for continuos mode which would mean triggered buffer support.
> 
> And this brings me to something that already crossed my mind...
> Jonathan, would it make sense to be able to change the trigger
> "sampling frequency" depending on some device configuration? In this
> case, if we want to have continous mode, I guess a hrtimer trigger
> would be, for example, one good candidate of a trigger to attach.
> And, as we can have different SPS, we would want to have the trigger
> fireing depending on that... This could also be an additional "task"
> for you (if it makes sense of course).

In this case what defines the SPS? 
Various things that sort of fit this description have come up.
* sensor self clocking but not providing an interrupt or similar, for these
  it is odd enough that you normally need a dedicated kernel thread to try
  and get the timing right.
* characteristic of configuration filters etc.  In theory you can
  grab readings from the device quicker than the filter supports, but
  you will run into issues with quality of the output.  For these
  we've traditionally made it a userspace problem...
* Sensor that has a 'specified' sample rate (perhaps due to some filtering
  or need for downtime between readings?)  For this I'd be tempted to
  provide the info to userspace and let that be responsible for not
  running a trigger faster.
* Sensor that runs flat out and we just want to trigger it repeatedly so
  we start a new capture after last one finishes.  For these we have the
  horibble hack which is the loop trigger (it's my hack ;)



> 
> All the above said, if we do not support continuous mode, this device
> also falls nicely in the hwmon domain (with all the hyst and over
> temperature stuff).

Agreed. It's fairly slow so can't really argue pushing the data through
a buffer is worthwhile and it's a low precision sensor.
So this one belongs in hwmon. Without reading datasheet I'm not
sure but I'd look at whether it's easy to bolt into the lm75 driver.


> 
> The ADPD188BI looks to be more complicated which might be too much for
> GSOC? Not sure here... That said, it looks like you can have some fun
> with it.
> 
> - Nuno Sá
> 

