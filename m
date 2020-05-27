Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1481A1E4644
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 16:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbgE0OoX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 10:44:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388395AbgE0OoX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 May 2020 10:44:23 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6FDE3D37E52F5CDD50AD;
        Wed, 27 May 2020 15:44:21 +0100 (IST)
Received: from localhost (10.47.93.204) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 27 May
 2020 15:44:21 +0100
Date:   Wed, 27 May 2020 15:43:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
Message-ID: <20200527154349.00007f44@Huawei.com>
In-Reply-To: <20200527123713.GO1634618@smile.fi.intel.com>
References: <20200525170628.503283-1-jic23@kernel.org>
        <20200525170628.503283-20-jic23@kernel.org>
        <20200525175236.GG1634618@smile.fi.intel.com>
        <da67e0e4-5889-eb87-7bc0-fac07ae54e57@metafoo.de>
        <20200526091556.GN1634618@smile.fi.intel.com>
        <20200526174328.0000673d@Huawei.com>
        <20200526170612.GY1634618@smile.fi.intel.com>
        <E1CB2D23-5B37-47E7-8782-ACC296EE5712@jic23.retrosnub.co.uk>
        <20200526210313.GD1634618@smile.fi.intel.com>
        <20200527124107.00001386@Huawei.com>
        <20200527123713.GO1634618@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.204]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 May 2020 15:37:13 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, May 27, 2020 at 12:41:07PM +0100, Jonathan Cameron wrote:
> > On Wed, 27 May 2020 00:03:13 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Tue, May 26, 2020 at 08:17:11PM +0100, Jonathan Cameron wrote:  
> > > > On 26 May 2020 18:06:12 BST, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:    
> 
> > > > Might be easier to just align it though than explain this subtlety.     
> > > 
> > > The easiest one seems to move ts to be first member of the struct / buffer. Problem solved.  
> > 
> > Sort of, but it brings other problems.
> > 
> > 1) Breaks userspace ABI.  Yes, no one should be relying on the ordering of
> >    elements from a given sensor, but we all know someone will be.   As
> >    things currently stand note we only have one actual report of there
> >    being a case where the alignment stuff breaks down (before I broke it
> >    much more significantly with this patch set!)
> > 
> > 2) We have to rework all the drivers, including the majority that use a suitably
> >    aligned buffer anyway (typically ____cacheline_aligned for DMA safety).
> >    The structure thing doesn't work any more because the timestamp is optional,
> >    so we have to have the drivers do their alignment differently depending on whether
> >    it is there or not, so we are back to use using __aligned(8) for all the buffers. 
> >    At the end of the day, the iio_push_to_buffers_with_timestamp is only workable
> >    because the timestamp is at the end of the buffer.  
> 
> I see.
> 
> > At this point I'm thinking we just stick to u8, u16 etc arrays.  At that point
> > we either decide that we are happy to not backport past (IIRC) 4.19 where the minimum gcc
> > version was increased such that __aligned(8) works on the stack, or we move them into
> > the iio_priv() structure where __aligned(8) always worked and hence squash the issue
> > of kernel data leaking without a memset on each scan. The only remaining question is
> > whether we get extra clarity by using
> > 
> > struct {
> > 	s16 channels[2];
> > 	// I think we can actually drop the padding if marking the timestamp as
> > 	// __aligned(8)
> > 	u8 padding[4];
> > 	s64 timestamp __aligned(8);
> > } scan;
> > 
> > or 
> > 
> > s16 scan[8] __aligned(8);
> > 
> > 
> > For the __aligned part this from the gcc docs looks helpful:
> > 
> > https://gcc.gnu.org/onlinedocs/gcc-4.6.4/gcc/Type-Attributes.html
> > 
> > "Note that the alignment of any given struct or union type is
> > required by the ISO C standard to be at least a perfect multiple
> > of the lowest common multiple of the alignments of all of the
> > members of the struct or union in question. This means that you
> > can effectively adjust the alignment of a struct or union type by
> > attaching an aligned attribute to any one of the members of such a
> > type, but the notation illustrated in the example above is a more
> > obvious, intuitive, and readable way to request the compiler to
> > adjust the alignment of an entire struct or union type. "  
> 
> This means that
> 
> struct sx {
> 	u8 channel;
> 	s64 ts;
> };
> 
> struct sx y, *py = &y;
> 
> py will be always aligned to at least 8 bytes (per s64 type).
> It has no effect on the members themselves.

Ah. I cut too much out. 

"This attribute specifies a minimum alignment (in bytes) for variables of the specified type."

So taking...

struct sx {
	u8 channel;
	s64 ts __aligned(8);
};

So if ts is __aligned(8) it will be aligned to 8 bytes, but so will the structure containing it.
hence will will have 7 bytes of padding.

There are a few similar users of this in kernel.  For example

https://elixir.bootlin.com/linux/latest/source/include/linux/efi.h#L809

Which after digging in the UEFI spec is because all variables in UEFI are
defined to have natural alignment and the structures are aligned to the
largest size.  So effectively same case we have.

Lots of other cases, that one just had a convenient spec to point at.
They mostly exist in uapi headers presumably to allow stuff to consistent
across from x86_64 to x86_32 userspace.


> 
> > So I think that means we can safely do
> > 
> > struct {
> > 	u8 channel;
> > 	s64 ts __aligned(8);
> > };  
> 
> I don't know how this attribute will affect *a member* of the struct. Perhaps
> it's straightforward and GCC simple apply it to POD.
> 
> > and be guaranteed correct padding and alignment in what I think is
> > a fairly readable form.  It's also self documenting so I can
> > probably drop some of the explanatory comments.  
> 
> If it is documented, then I fully agree, otherwise will look
> like a (fragile) hack.
> 

Agreed.  It seems to be documented and I'm reassured by the bunch
of existing places this seems to be being used.
Also helps that they are mostly for uapi consistency which is
really want we are talking about here as well.

Will let this sit for a few days before I do anything about a v2
in the hope that someone will point out any more corner cases
I should have known about!

Jonathan






