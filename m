Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C355509B7D
	for <lists+linux-iio@lfdr.de>; Thu, 21 Apr 2022 11:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387256AbiDUJI0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 21 Apr 2022 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387267AbiDUJIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Apr 2022 05:08:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8B013F82
        for <linux-iio@vger.kernel.org>; Thu, 21 Apr 2022 02:05:34 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KkWkM6twmz686pS;
        Thu, 21 Apr 2022 17:01:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 11:05:31 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 10:05:31 +0100
Date:   Thu, 21 Apr 2022 10:05:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <catalin.marinas@arm.com>
Subject: Re: IIO: Ensuring DMA safe buffers.
Message-ID: <20220421100528.00006326@Huawei.com>
In-Reply-To: <bcb20a4bc1b877506596341aebfea28b628694b2.camel@gmail.com>
References: <20220419121241.00002e42@Huawei.com>
        <bcb20a4bc1b877506596341aebfea28b628694b2.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Apr 2022 14:30:36 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Tue, 2022-04-19 at 12:12 +0100, Jonathan Cameron wrote:
> > Hi All,
> > 
> > For a long time IIO has been making assumption that
> > ____cacheline_aligned
> > was sufficient to ensure buffers were in their own cacheline and
> > hence
> > DMA safe.  We generally needed this for all SPI device drivers as
> > many
> > SPI ABI calls can pass the buffer directly through to be used for
> > DMA.
> > Not that regmap doesn't currently do this but it might in future (and
> > did
> > in the past).  I can't remember the history of this well enough to
> > know
> > why we did it that way. I don't remember the pain of debugging random
> > corruption caused by getting it wrong however...
> > 
> > However it turns out via
> > https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@arm.com/
> >  
> > "[PATCH 00/10] mm, arm64: Reduce ARCH_KMALLOC_MINALIGN below the
> > cache line size"
> > discussion that there are platforms where this isn't true and need
> > 128 byte alignment despite a ____cacheline_size aligning to 64 bytes
> > on
> > all ARM64 platforms.
> >   
> 
> Oh boy... Here it goes my 5 cents on this

:)

> 
> > (I should probably have known that as the platform I support in my
> > day
> > job has 128 byte cachelines in L3 - however it's DMA coherent so
> > that's not a problem).
> > 
> > The above series also highlights that we can do much better anyway on
> > some platforms
> > using the new ARCH_DMA_MINALIGN (currently it's only defined for some
> > archs but
> > after that patch everyone gets it).  We should be safe to use that
> > everywhere
> > we currently force ___cachline_aligned and waste a little less space
> > on padding
> > which is always nice ;)
> >   
> 
> The above series actually made me go an try to have some more
> understanding on kmalloc. I might be completely wrong but AFAIU, for
> our typical case, this won't matter much. Typically we have something
> like:
> 
> struct something {
>     //typically we do have more parameters
>     int val;
>     u8 buffer[8] ____cacheline_aligned;
> };
> 
> I thing the idea is to replace this by the compile time annotation
> ARCH_DMA_MINALIGN which is 128 (for arm64). That means that
> kmalloc(sizeof(struct something)) will put us already in the kmalloc-
> 256 cache (right?) and then we will just get 256 aligned objects as
> this is a power of 2. The point is that as we normally do the compile
> time annotation we should still have the padding bytes as given by
> sizeof().
> 
> If I understood things correctly, the above series is way more
> beneficial for smaller kmalloc calls (without annotation) that won't
> need the 128 align constrain or for structures with zero length arrays
> (annotated with ARCH_DMA_MINALIGN) where kmalloc() calls end up in the
> kmalloc-192 cache.
> 
> Does the above make any sense?
If we keep the padding between iio_dev and iio_priv at ARCH_DMA_MINALIGN
then we should be fine because we get

0  iio_dev

128 start of iio_priv

256 start of aligned region (after changing to ARCH_DMA_MINALIGN as you say above.
383 end of potential DMA Safe region - so need to not have anything else
before this.

and I think we get in kmalloc-384 cache if it exists.  Which is fine.
> 
> That said, I think that we also need to be careful in
> iio_device_alloc(). Ideally, to save some space, we only align to a
> real cache line (padding between iio and private struct) and not
> ARCH_DMA_MINALIGN. Would it be enough?

For now I suggest stick to ARCH_DMA_MINALIGN but in future we may be able
to relax that.  We do however run into the same issue crypto does
of giving missleading information to the compiler (even it if it's
a non issue in reality) because the structures at iio_priv() will
still have compile time alignment markings to ARCH_DMA_MINALIGN
and if the padding of struct iio_dev doesn't bring us to that boundary
then the alignment isn't what he compiler thinks it is.
I'm not immediately sure how else to get that alignment as we don't
want to be hand adding padding to each driver..  We could do something
magic like introducing a second region with iio_priv2() but that
is horrible.

Walking through this.  If KMALLOC_MINALIGN
falls to a small enough number then we 'could get'

0                iio_Dev

x + delta        start of iio_priv
x + delta + 128  start of aligned region
x + delta + 256  end of aligned region.
-- any issue will occur because back end of this shares the min
dma aligned region with something else.

So at worst we get into the 384 size kmalloc cache and should be
fine anyway.

Note that we don't care that much about potential savings as there
is only one of these structures per driver instance so it'll be very
minor.

> 
> > Given we have no reports of a problem with 128 byte non DMA coherent
> > platforms
> > I don't propose to 'fix' this until we can make use of the new define
> > in the above patch set.  That is going to make a mess of backporting
> > the
> > fix however.  I'm wishing we did what crypto has done and had a
> > subsystem
> > specific define for this but such is life.  We will also want to be  
> 
> We do have IIO_ALIGN but as we just found out is wrongly defined and
> was never enforced. Maybe now is a good time for enforcing it :)

Agreed. I'll spin a series to change that to be inline with what crypto
does and use throughout the drivers.  Then we can move forwards from
there as Catalin's series moves forwards.

What fun :)

Jonathan

> >   
> 
> - Nuno Sá

