Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A5657B2D5
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jul 2022 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGTIZc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jul 2022 04:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGTIZc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2022 04:25:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D456BBA
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 01:25:29 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lnpct65Ccz67F4F;
        Wed, 20 Jul 2022 16:23:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 10:25:27 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 09:25:26 +0100
Date:   Wed, 20 Jul 2022 09:25:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Morgan <macromorgan@hotmail.com>
CC:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        "Chris Morgan" <macroalpha82@gmail.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>
Subject: Re: [RFC] iio: multiplexer: Copy scan_type details from parent to
 child
Message-ID: <20220720092523.00006b66@Huawei.com>
In-Reply-To: <SN6PR06MB53423F1D1D1891C5E7BB9DB5A58F9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220718184312.11840-1-macroalpha82@gmail.com>
        <20220719095116.3dc46f3a@jic23-huawei>
        <f845f910-fb46-e38e-b4e2-709ae4da006b@axentia.se>
        <20220719151901.000020cf@Huawei.com>
        <SN6PR06MB534291E524FB941356E32D9BA58F9@SN6PR06MB5342.namprd06.prod.outlook.com>
        <c7994aeb-8b22-625c-a468-c74ca60943ab@axentia.se>
        <SN6PR06MB53423F1D1D1891C5E7BB9DB5A58F9@SN6PR06MB5342.namprd06.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.121]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Jul 2022 14:22:48 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Tue, Jul 19, 2022 at 07:54:18PM +0200, Peter Rosin wrote:
> > 
> > 
> > 2022-07-19 at 16:44, Chris Morgan wrote:  
> > > On Tue, Jul 19, 2022 at 03:19:01PM +0100, Jonathan Cameron wrote:  
> > >> On Tue, 19 Jul 2022 15:27:24 +0200
> > >> Peter Rosin <peda@axentia.se> wrote:
> > >>  
> > >>> Hi!
> > >>>
> > >>> 2022-07-19 at 10:51, Jonathan Cameron wrote:  
> > >>>> On Mon, 18 Jul 2022 13:43:12 -0500
> > >>>> Chris Morgan <macroalpha82@gmail.com> wrote:
> > >>>>     
> > >>>>> From: Chris Morgan <macromorgan@hotmail.com>
> > >>>>>
> > >>>>> Copy the scan_type details from the parent iio channel to the child.
> > >>>>> The scan_type is otherwise empty and things like the storagebits are
> > >>>>> zero (which causes a problem for the adc-joystick driver which
> > >>>>> validates the storagebits when used through a mux). I'm submitting this
> > >>>>> as an RFC because I'm not sure if this is the correct way to handle
> > >>>>> this scenario (a driver that checks the storagebits used with the iio
> > >>>>> multiplexer).
> > >>>>>
> > >>>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>    
> > >>>> Seems sensible to me. Though Peter is expert on this one.    
> > >>>
> > >>> I really doubt that it is this simple. I'm no expert on buffered channels,
> > >>> but after a quick look it certainly looks like adc-joystick requires
> > >>> buffered channels. And iio-multiplexer does not support that at all. I
> > >>> think it could be supported, but in that case the only obvious support
> > >>> would be to support buffered channels one at a time, and the way I
> > >>> read adc-joystick it expects to get one sample for each axes in one
> > >>> go (i.e. the way "normal" ADCs deliver multiple parallel samples). See
> > >>> e.g. the call to iio_channel_get_all_cb in adc-joystick, which dives
> > >>> right into the buffered iio department.
> > >>>
> > >>> So, the stuff in scan_type (along with scan_index, which is highly
> > >>> related) is only relevant for buffered channels, and iio_multiplexer is
> > >>> currently limited by its
> > >>>
> > >>> 	indio_dev->modes = INDIO_DIRECT_MODE;
> > >>>
> > >>> which is ... not buffered. :-(
> > >>>
> > >>> The simplest way forward is probably to lift the requirement of buffered
> > >>> channels from adc-joystick, but that might be a hard sell as that driver
> > >>> would then probably be a lot bigger and more complex.
> > >>>  
> > >>
> > >> Got it in one ;)  
> > 
> > I guess I'm old and can therefore allow myself to blather :-)
> >   
> > >> There is a recent series from Chris adding polled support to adc_joystick (not yet merged)
> > >> https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220705190354.69263-1-macromorgan%40hotmail.com%2F&amp;data=05%7C01%7C%7Ccb22e6634f844f68126e08da69afae8c%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637938500513929763%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=00HdVZvnHQNbQ1wFEON%2F9i%2B5b%2BicYb6gRhAJuKooZlA%3D&amp;reserved=0
> > >> That just reads the channels one at a time via same interfaces used for
> > >> sysfs reads so would work with the iio-mux I think.
> > >>
> > >> Jonathan  
> > > 
> > > Right, correct that these two "work" together. Honestly the main thing
> > > is that the adc-joystick driver checks for the storagebits, and that's
> > > failing for me in this case when I use a mux. I added a one-liner to
> > > the multiplexer code which added the parent information and that fixed
> > > it. It's also possible that I could change the adc-joystick driver to
> > > either not look for the storagebits or to change it to only look when
> > > not doing polling mode. I just assumed that a missing scan_type was
> > > an issue, so I added it and marked the patch as RFC because I wasn't
> > > sure. If you want me to relax the adc-joystick check instead for polled
> > > devices, I can.  
> > 
> > Ah, ok, there's been new development. Nice!
> > 
> > As I said, I'm by no means a iio-buffer expert. On the contrary, I'm a
> > total noob. So, be sure to take the following with a good pinch of salt,
> > but I think that the adc-joystick driver in a mode that does not use
> > iio-buffers should not then have artificial requirement on the buffer
> > layout (scan_type). Don't forget the salt... :-)  
> 
> This sounds like it makes the most sense to me now, since I wasn't aware
> of the "scan_type" being associated with a buffer. I'll modify the
> joystick driver and we can disregard this then.  Thank you.


Agreed. It shouldn't be using this.  If there is a necessity to know the
'range' then the ADC should provide _raw_available and the adc-joystick driver
should query that in polled mode rather than anything from scan_type.
We have a bunch of DACs that do this for consumer usecases but not sure we have
many ADCs providing it yet. However, easy to add to a given driver when it's
needed!

J
> 
> >   
> > > Note that the adc-joystick driver does work perfectly fine with a mux,
> > > I'm in the very early stages of upstreaming some devices which use it
> > > in such a manner (the Anbernic RG353, Anbernic RG503, Odroid Go Super
> > > are example devices that use the adc-joystick with a mux downstream).  
> > 
> > Cool!
> > 
> > Cheers,
> > Peter  

