Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4F34FE5B0
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 18:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiDLQV5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 12 Apr 2022 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiDLQV4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 12:21:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B12B37AA8
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 09:19:38 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kd9qH0784z68737;
        Wed, 13 Apr 2022 00:17:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 12 Apr 2022 18:19:35 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 17:19:34 +0100
Date:   Tue, 12 Apr 2022 17:19:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hegbeli, Ciprian" <ciprian.hegbeli@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: GSoC Proposal 2022
Message-ID: <20220412171933.00002d1d@Huawei.com>
In-Reply-To: <a5f002afb956c96b20c5f5589c34ecaa1bdfadc6.camel@gmail.com>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
        <20220410182819.23967855@jic23-huawei>
        <YlNcQEAZVGYBkdy5@fedora>
        <20220411095219.000058a8@Huawei.com>
        <YlQpcZvwZuabMsz+@fedora>
        <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
        <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
        <YlVvhoBNap4Yip3O@fedora>
        <a5f002afb956c96b20c5f5589c34ecaa1bdfadc6.camel@gmail.com>
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

On Tue, 12 Apr 2022 16:23:55 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Tue, 2022-04-12 at 09:24 -0300, Maíra Canal wrote:
> > On 04/12, Nuno Sá wrote:  
> > > On Tue, 2022-04-12 at 11:48 +0300, Andy Shevchenko wrote:  
> > > > On Tue, Apr 12, 2022 at 10:43 AM Maíra Canal <maira.canal@usp.br>
> > > > wrote:  
> > > > > On 04/11, Jonathan Cameron wrote:  
> > > 
> > > The MAX31875 looks to be a fairly simple one (maybe a good
> > > candidate
> > > for a first driver) but, IMO, having it in IIO boils down to have
> > > support for continuos mode which would mean triggered buffer
> > > support.  
> > 
> > I took another look at the Maxim Integrated catalog and end up
> > finding
> > the MAX31889 Temperature Sensor.
> > 
> > I guess this sensor has an interesting challenge level with the need
> > to
> > implement FIFO and interrupts support. 
> > 
> > Have you guys some thoughts on this one?
Hmm. The fifo is interesting, but I'm somewhat doubtful that it's actually
much use when connected to a linux system.  The sampling rate is 1Hz.
At that rate even in busy systems or low power situations, there is
little reason not to just poll the device.

You 'could' wire up a PWM or similar to the gpio and have it operate
like a 'self clocked' device but with sampling rates so low it's a fairly
contrived situation.

Temperature sensors in general are often a bad fit for IIO precisely because
they are mostly designed for monitoring type purposes which HWMON covers.
The exceptions are high speed or high accuracy devices or weird ones like
infrared thermometers.

For the corner cases we have the option of the iio-hwmon bridge driver
but they need to be more obviously not suited to hwmon than this one to
justify their presence in IIO. In general hwmon drivers are simpler, so
if you can get away with it they are a better choice. (also some hwmon
specific features like multiple levels of even of the same type for
warning / critical detection).

Jonathan

> >   
> 
> At first glance, it looks like a better choice when compared with
> MAX31875...
> 
> - Nuno Sá
> >   
> > >   
> 

