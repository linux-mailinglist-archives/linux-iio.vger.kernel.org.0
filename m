Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31C11E2752
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgEZQoD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 12:44:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727941AbgEZQoD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 12:44:03 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4F66368452202A89566F;
        Tue, 26 May 2020 17:43:59 +0100 (IST)
Received: from localhost (10.47.89.183) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 26 May
 2020 17:43:58 +0100
Date:   Tue, 26 May 2020 17:43:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
Message-ID: <20200526174328.0000673d@Huawei.com>
In-Reply-To: <20200526091556.GN1634618@smile.fi.intel.com>
References: <20200525170628.503283-1-jic23@kernel.org>
        <20200525170628.503283-20-jic23@kernel.org>
        <20200525175236.GG1634618@smile.fi.intel.com>
        <da67e0e4-5889-eb87-7bc0-fac07ae54e57@metafoo.de>
        <20200526091556.GN1634618@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.89.183]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 12:15:56 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, May 26, 2020 at 10:11:44AM +0200, Lars-Peter Clausen wrote:
> > On 5/25/20 7:52 PM, Andy Shevchenko wrote:  
> > > On Mon, May 25, 2020 at 06:06:22PM +0100, Jonathan Cameron wrote:  
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> ...
> 
> > > > -	s16 buf[8]; /* 1x s16 ADC val + 3x s16 padding +  4x s16 timestamp */
> > > > +	/* Ensure natural alignment for buffer elements */
> > > > +	struct {
> > > > +		s16 channel;
> > > > +		s64 ts;
> > > > +	} scan;  
> > > Hmm... On x86_32 and x86_64 this will give different padding. Is it okay from
> > > iio_push_to_buffers_with_timestamp() point of view?  
> > 
> > No, this is terrible. IIO expects 64 bit words to be 64 bit aligned. Looks
> > like we can't rely on implicit padding, but need to always explicitly
> > specify it.
> > 
> > Or maybe we can typedef and IIO timestamp type with an explicit __aligned
> > attribute. I wonder if that works... After having a quick look, the kernel
> > already defines aligned_u64, so maybe using that is an option.  
> 
> Another way is simple to provide offset of timestamp member as a parameter.
> Though, if it's an ABI, then alas, we need to align it properly.
> 
> Also, wouldn't be better to explicitly show the padding?
> 
> 	struct {
> 		s16 channel;
> 		s16 padding[3];
> 		s64 ts;
> 	} scan;
> 
> (matter of style though, just saying).
> 

gah.  Thanks for pointing this out Andy.  I wanted to avoid explicitly
calling out empty padding because it seemed to me to be more likely to
be error prone than filling it in.

I was trying to avoid using __aligned on the stack as it only works for
more recent kernels (due to gcc version changes) and some of these predate
that point.

I guess we just do it explicitly in all these cases.

The two patches that have already gone to Greg both have sufficient
data to ensure the structure is big enough (only 16 bytes padding in one and
none in the other).

I think we are also fine for the original question as well as it won't
matter if the whole structure is aligned to 4 bytes on x86_32 and
similar as an 8 byte write will be fine.

So fun question - do we want to enforce 8 byte alignment of the whole
structure, or simply the padding?

Maybe better to just do the padding explicitly as Andy suggested.

Jonathan





