Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA32791AA8
	for <lists+linux-iio@lfdr.de>; Mon,  4 Sep 2023 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjIDPbX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 4 Sep 2023 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjIDPbW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2023 11:31:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8872CC3
        for <linux-iio@vger.kernel.org>; Mon,  4 Sep 2023 08:31:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfXYP11sBz67cSL;
        Mon,  4 Sep 2023 23:26:49 +0800 (CST)
Received: from localhost (10.48.153.57) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 16:31:15 +0100
Date:   Mon, 4 Sep 2023 16:31:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] iio: addac: add new converter framework
Message-ID: <20230904163114.0000681c@Huawei.com>
In-Reply-To: <08793b1b73d7789b595def9afd8652e2f36f8e28.camel@gmail.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
        <20230804145342.1600136-2-nuno.sa@analog.com>
        <20230830180234.00007437@Huawei.com>
        <aaed9bdef386f77a4211f6010f96cfaa92e70515.camel@gmail.com>
        <20230903115653.5bb8c0e8@jic23-huawei>
        <08793b1b73d7789b595def9afd8652e2f36f8e28.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.48.153.57]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 04 Sep 2023 16:14:17 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Sun, 2023-09-03 at 11:56 +0100, Jonathan Cameron wrote:
> > On Thu, 31 Aug 2023 11:32:54 +0200
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> >   
> > > On Wed, 2023-08-30 at 18:02 +0100, Jonathan Cameron wrote:  
> > > > On Fri, 4 Aug 2023 16:53:39 +0200
> > > > Nuno Sa <nuno.sa@analog.com> wrote:
> > > >     
> > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>    
> > > > 
> > > > Hi Nuno,
> > > >     
> > > 
> > > Hi Jonathan,
> > > 
> > > Thanks for the initial review...
> > >   
> > > > 
> > > > One general comment is that you could have stripped this back a fair bit
> > > > for ease of understanding.  At this stage we don't care about things
> > > > like debug or control of test patterns.  Bring those in as extra patches.
> > > >     
> > > 
> > > Agreed... As I mentioned (I think) in the cover, I made the RFC bigger than
> > > needed to
> > > kind of showcase how we can properly configure the hdl core to support
> > > things
> > > (interface calibration) that were very hard to do with the current
> > > implementation.
> > > I'll make sure to add the minimum needed API to accommodate what we have
> > > right now.
> > >   
> > > > I haven't fully gotten my head around the ordering constraints on removal.
> > > > Are there other users of the component framework that have similar
> > > > problems?
> > > >     
> > > 
> > > My understanding on the component API is that one should do all the tear
> > > down in the
> > > .unbind() callback. As usual, I can see some drivers not really doing that.
> > >   
> > > > Also, I don't yet understand how a multiple front end, single backend
> > > > setup
> > > > would work.  Or indeed single front end, multiple backend...  Maybe we
> > > > don't
> > > > need those cases, but if we want this to be useful beyond adi-axi we
> > > > probably at least want an outline of how they work.
> > > >     
> > > 
> > > Indeed we can have multiple (and we have it out of tree) backends on one
> > > frontend.
> > > Think on an ADC/DAC with fairly complex data path with more than one
> > > channel/interface (CMOS, LVDS, etc). Typically, in those case, each of the
> > > interface
> > > will be connected to an instance of the hdl core (the backend).  
> > 
> > That might work out for your case, but not the stm32 one where I think we can
> > end
> > up with interleaved data from two front ends in the same buffer...
> >   
> 
> Not sure I'm following this one. But wouldn't that be something specific for
> each system (through devicetree)? I haven't tried but I think the same backend
> could be used in different frontend devices (using the component API). That is
> not really a usecase for me but definitely something that could be supported (if
> we need to start doing things like keep enable/disable counters and so on) if it
> is a usecase for stm32.

If we are going to support both usecases, we just need to figure out what composite
devices with N-M backend - frontend look like and make sure that doesn't
cause problems.  I'd expect the separation between backend instances might
reflect data storage on capture but then again that might end up like the many
IIO devices for many buffers mess we had before the multiple buffer support
was added. 

Might need enable /disable counters as you say - I'm not quite sure without
trying it!
> > > > > +        * than having to tear everything down in .frontend_close() and
> > > > > +        * .backend_close()    
> > > > 
> > > > That last bit is nasty and will be non obvious to driver authors.
> > > > 
> > > > I wonder if we can come up with some means to make it hard to do.
> > > >     
> > > 
> > > Yeah, I agree. The alternative is to always bring everything down in
> > > .frontend_close() and .backend_close(). But that can also be prone to subtle
> > > bugs
> > > because it's easy to mess up the ordering when not using devres.
> > > 
> > > So, at this point, I cannot really think on a perfect solution rather than
> > > keeping
> > > some rules like (assuming we keep the logic we have now):
> > > 
> > > * Using devres on frontend|backend_init() only when .remove() is provided on
> > > the
> > > driver.
> > > * No mixes of devres and .frontend|backend_close()
> > > 
> > > But yeah, would be nice if we could come up with something to make it more
> > > obvious to
> > > driver authors.  
> >   
> > > 
> > > We might be able to detect that converter_backend_del() and
> > > converter_frontend_del()
> > > are under devres while no .frontend|backend_close() is being given. I guess
> > > that
> > > could be a valid indicator of likely misusage.
> > > 
> > > Or even better (but I'm not sure it's doable with the current devres API),
> > > detecting
> > > that converter_backend_del() or converter_frontend_del() are under devres
> > > while more
> > > resources are also allocated in our specific opened groups. That would
> > > always be a
> > > problem (I think) because the only way for the _del() functions to be under
> > > devres is
> > > if someone added them (from .probe) with devm_add_action() which means that
> > > tearing
> > > down the aggregate will happen after some resources (which were allocated in
> > > the
> > > _init() function) are already freed (as even with new groups, devres will
> > > remove
> > > things on the reverse order). And that would defenitely be problematic. And,
> > > in fact,
> > > is the whole reason why I have the .del() functions on .remove() (so,
> > > tearing down
> > > the aggregate device is the first thing to happen and resources are freed in
> > > the
> > > reverse order they were allocated).
> > >   
> >   
> 
> This would actually be very messy and hard to do properly. Concurrency between
> the aggregate probing (at the component level) and unbinding (at driver core
> level) would be very tricky if doable at all. On top that, we do have
> devres_find() but no way to tell if a devres group has resources or not. It
> would be easy to add one new API but likely not worth it just for this usecase.
> 
> I also thought about an helper macro to wrap every devm_ call but your below
> suggestion is way better and transparent to users.
> 
> > I couldn't work out how to do anything easily and would need some experiments.
> > Maybe some 'hidden' devres callbacks and a state flag somewhere.  If we
> > register
> > that very late we can perhaps detect that we entered devres cleanup before
> > calling
> > expected manual cleanup.  I'm thinking have the setup path register a flag
> > checking
> > callback and the cleanup path set a flag (devres now safe).  Then we can at
> > least
> > make it scream if we end up doing things in wrong way.
> >   
> 
> Hmm, that might actually be a good idea and something to try. It likely means
> having a mutex (I was happy not to have one for now :) but likely inevitable
> somewhere down the road) for the flag but it might work. At least we'll be able
> to dump a WARN or something if we suspect something is wrong.

Careful ordering an atomic might work. 

> 
> > > Other thought would be some generic helper macros to use in these type of
> > > drivers so
> > > a .remove() callback is always added to remove the components.   
> > I wondered if that could work but it's an ugly macro because needs to deal
> > with
> > different bus types.
> > 
> >   
> 
> We could have a macro per bus type. I'm not really seeing anything different
> than platform, spi and i2c. But even like this, it could easily start to get
> ugly because of accepted parameters (and any deviation would again mean a
> different version per bus type). Another thing that crossed my mind was wrappers
> to module_spi_driver() and friends. Maybe that could work. Anyways, as you said
> in one of your replies, this is in kernel interface that we can easily
> add/change. So, I will defer this to a later point in time.

Makes sense

J
> 
> - Nuno Sá
> 

