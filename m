Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED701E426D
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 14:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgE0MhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 08:37:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:6660 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbgE0MhM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 May 2020 08:37:12 -0400
IronPort-SDR: mfPwKB1qIZEqMXA06Yyy60T1sRcoRN/yrzTQ+r6cEEoPrpAcDA2X1TrJpsyPJW3Dy3udhaWLky
 wvOn1utV5AyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 05:37:11 -0700
IronPort-SDR: T2K7pwBqS4XYNLzXgVRG7OdgkX7jP74W5GdcEOBCYc47i2t4qTejHwnD1hGe8Nj46AlNiI+/kU
 7OguLBBYUQyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="468695087"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2020 05:37:10 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdvJ3-009DXS-3O; Wed, 27 May 2020 15:37:13 +0300
Date:   Wed, 27 May 2020 15:37:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
Message-ID: <20200527123713.GO1634618@smile.fi.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527124107.00001386@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 27, 2020 at 12:41:07PM +0100, Jonathan Cameron wrote:
> On Wed, 27 May 2020 00:03:13 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, May 26, 2020 at 08:17:11PM +0100, Jonathan Cameron wrote:
> > > On 26 May 2020 18:06:12 BST, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  

> > > Might be easier to just align it though than explain this subtlety.   
> > 
> > The easiest one seems to move ts to be first member of the struct / buffer. Problem solved.
> 
> Sort of, but it brings other problems.
> 
> 1) Breaks userspace ABI.  Yes, no one should be relying on the ordering of
>    elements from a given sensor, but we all know someone will be.   As
>    things currently stand note we only have one actual report of there
>    being a case where the alignment stuff breaks down (before I broke it
>    much more significantly with this patch set!)
> 
> 2) We have to rework all the drivers, including the majority that use a suitably
>    aligned buffer anyway (typically ____cacheline_aligned for DMA safety).
>    The structure thing doesn't work any more because the timestamp is optional,
>    so we have to have the drivers do their alignment differently depending on whether
>    it is there or not, so we are back to use using __aligned(8) for all the buffers. 
>    At the end of the day, the iio_push_to_buffers_with_timestamp is only workable
>    because the timestamp is at the end of the buffer.

I see.

> At this point I'm thinking we just stick to u8, u16 etc arrays.  At that point
> we either decide that we are happy to not backport past (IIRC) 4.19 where the minimum gcc
> version was increased such that __aligned(8) works on the stack, or we move them into
> the iio_priv() structure where __aligned(8) always worked and hence squash the issue
> of kernel data leaking without a memset on each scan. The only remaining question is
> whether we get extra clarity by using
> 
> struct {
> 	s16 channels[2];
> 	// I think we can actually drop the padding if marking the timestamp as
> 	// __aligned(8)
> 	u8 padding[4];
> 	s64 timestamp __aligned(8);
> } scan;
> 
> or 
> 
> s16 scan[8] __aligned(8);
> 
> 
> For the __aligned part this from the gcc docs looks helpful:
> 
> https://gcc.gnu.org/onlinedocs/gcc-4.6.4/gcc/Type-Attributes.html
> 
> "Note that the alignment of any given struct or union type is
> required by the ISO C standard to be at least a perfect multiple
> of the lowest common multiple of the alignments of all of the
> members of the struct or union in question. This means that you
> can effectively adjust the alignment of a struct or union type by
> attaching an aligned attribute to any one of the members of such a
> type, but the notation illustrated in the example above is a more
> obvious, intuitive, and readable way to request the compiler to
> adjust the alignment of an entire struct or union type. "

This means that

struct sx {
	u8 channel;
	s64 ts;
};

struct sx y, *py = &y;

py will be always aligned to at least 8 bytes (per s64 type).
It has no effect on the members themselves.

> So I think that means we can safely do
> 
> struct {
> 	u8 channel;
> 	s64 ts __aligned(8);
> };

I don't know how this attribute will affect *a member* of the struct. Perhaps
it's straightforward and GCC simple apply it to POD.

> and be guaranteed correct padding and alignment in what I think is
> a fairly readable form.  It's also self documenting so I can
> probably drop some of the explanatory comments.

If it is documented, then I fully agree, otherwise will look
like a (fragile) hack.

-- 
With Best Regards,
Andy Shevchenko


