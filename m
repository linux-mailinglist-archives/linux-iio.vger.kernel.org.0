Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6F1E27E5
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 19:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbgEZRGL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 13:06:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:9250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgEZRGK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 13:06:10 -0400
IronPort-SDR: ROoRGZ0GiNdncUK4e92MyE+5KabTDIJ+ePqY5AJF6SJLekbowtRC9xhqZXTrnUI/RUeZrbL4tP
 MtNoy6romdgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 10:06:10 -0700
IronPort-SDR: azjX+2o24VhGFB5KCVqaYfHxqqM8dBJJsXawqgLnWa6WT9AhycykgNpCu/P0h2qadEi/U6FWQZ
 VxQChmvQKZzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="255217651"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 26 May 2020 10:06:09 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdd1o-0092Ur-Hn; Tue, 26 May 2020 20:06:12 +0300
Date:   Tue, 26 May 2020 20:06:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
Message-ID: <20200526170612.GY1634618@smile.fi.intel.com>
References: <20200525170628.503283-1-jic23@kernel.org>
 <20200525170628.503283-20-jic23@kernel.org>
 <20200525175236.GG1634618@smile.fi.intel.com>
 <da67e0e4-5889-eb87-7bc0-fac07ae54e57@metafoo.de>
 <20200526091556.GN1634618@smile.fi.intel.com>
 <20200526174328.0000673d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526174328.0000673d@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 26, 2020 at 05:43:28PM +0100, Jonathan Cameron wrote:
> On Tue, 26 May 2020 12:15:56 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, May 26, 2020 at 10:11:44AM +0200, Lars-Peter Clausen wrote:
> > > On 5/25/20 7:52 PM, Andy Shevchenko wrote:  
> > > > On Mon, May 25, 2020 at 06:06:22PM +0100, Jonathan Cameron wrote:  
> > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>  

...

> > > > > +	struct {
> > > > > +		s16 channel;
> > > > > +		s64 ts;
> > > > > +	} scan;  
> > > > Hmm... On x86_32 and x86_64 this will give different padding. Is it okay from
> > > > iio_push_to_buffers_with_timestamp() point of view?  
> > > 
> > > No, this is terrible. IIO expects 64 bit words to be 64 bit aligned. Looks
> > > like we can't rely on implicit padding, but need to always explicitly
> > > specify it.
> > > 
> > > Or maybe we can typedef and IIO timestamp type with an explicit __aligned
> > > attribute. I wonder if that works... After having a quick look, the kernel
> > > already defines aligned_u64, so maybe using that is an option.  
> > 
> > Another way is simple to provide offset of timestamp member as a parameter.
> > Though, if it's an ABI, then alas, we need to align it properly.
> > 
> > Also, wouldn't be better to explicitly show the padding?
> > 
> > 	struct {
> > 		s16 channel;
> > 		s16 padding[3];
> > 		s64 ts;
> > 	} scan;
> > 
> > (matter of style though, just saying).
> > 
> 
> gah.  Thanks for pointing this out Andy.  I wanted to avoid explicitly
> calling out empty padding because it seemed to me to be more likely to
> be error prone than filling it in.
> 
> I was trying to avoid using __aligned on the stack as it only works for
> more recent kernels (due to gcc version changes) and some of these predate
> that point.
> 
> I guess we just do it explicitly in all these cases.
> 
> The two patches that have already gone to Greg both have sufficient
> data to ensure the structure is big enough (only 16 bytes padding in one and
> none in the other).
> 
> I think we are also fine for the original question as well as it won't
> matter if the whole structure is aligned to 4 bytes on x86_32 and
> similar as an 8 byte write will be fine.
> 
> So fun question - do we want to enforce 8 byte alignment of the whole
> structure, or simply the padding?
> 
> Maybe better to just do the padding explicitly as Andy suggested.

I have talked to colleague of mine, and we concluded (but without any
documentation proved evidence, one needs basically to read C standard followed
by ABI of all architectures supported by Linux) that the following will work.

Consider your patch, which introduces natural alignment via struct:

	struct scan {
		s16 ...;
		...
		s64 ts;
	};

When we access ts as struct member like scan->ts, compiler makes sure that
there will be no hardware exception (due to unaligned access). Now, we _assume_
that dereferencing like

	void *buf = &scan;
	(int64_t *)buf[ts_offset] = value;

will work flawlessly because above.

If it's indeed a case, what we simple need is to pass ts offset into
iio_push_to_buffers_with_timestamp().

If it's not the case, we _additionally_ will need to replace
	(int64_t *)buf[ts_offset] = value;
by
	put_unaligned(value, (int64_t *)...);

-- 
With Best Regards,
Andy Shevchenko


