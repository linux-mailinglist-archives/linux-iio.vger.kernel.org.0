Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A61E1E27
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgEZJPz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:15:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:13834 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731600AbgEZJPz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 05:15:55 -0400
IronPort-SDR: 4IZCxMpLy2oht/86Qt2fqTQxN7Y4EtKOJdyLxE7veFGmd88q6MunZxg05uWOm2v4srhr6XBGDr
 KYqkMpdUruZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 02:15:54 -0700
IronPort-SDR: O87iqakQ/xm2JIRQNTUI1kgP2mbHXX49IJxCmXoA3j5dMOj9rft2RWvs7vFStk8B5TKbayCiLs
 ehdOS0QqMBQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="442012951"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2020 02:15:53 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdVgi-008xdo-KE; Tue, 26 May 2020 12:15:56 +0300
Date:   Tue, 26 May 2020 12:15:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
Message-ID: <20200526091556.GN1634618@smile.fi.intel.com>
References: <20200525170628.503283-1-jic23@kernel.org>
 <20200525170628.503283-20-jic23@kernel.org>
 <20200525175236.GG1634618@smile.fi.intel.com>
 <da67e0e4-5889-eb87-7bc0-fac07ae54e57@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da67e0e4-5889-eb87-7bc0-fac07ae54e57@metafoo.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 26, 2020 at 10:11:44AM +0200, Lars-Peter Clausen wrote:
> On 5/25/20 7:52 PM, Andy Shevchenko wrote:
> > On Mon, May 25, 2020 at 06:06:22PM +0100, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

...

> > > -	s16 buf[8]; /* 1x s16 ADC val + 3x s16 padding +  4x s16 timestamp */
> > > +	/* Ensure natural alignment for buffer elements */
> > > +	struct {
> > > +		s16 channel;
> > > +		s64 ts;
> > > +	} scan;
> > Hmm... On x86_32 and x86_64 this will give different padding. Is it okay from
> > iio_push_to_buffers_with_timestamp() point of view?
> 
> No, this is terrible. IIO expects 64 bit words to be 64 bit aligned. Looks
> like we can't rely on implicit padding, but need to always explicitly
> specify it.
> 
> Or maybe we can typedef and IIO timestamp type with an explicit __aligned
> attribute. I wonder if that works... After having a quick look, the kernel
> already defines aligned_u64, so maybe using that is an option.

Another way is simple to provide offset of timestamp member as a parameter.
Though, if it's an ABI, then alas, we need to align it properly.

Also, wouldn't be better to explicitly show the padding?

	struct {
		s16 channel;
		s16 padding[3];
		s64 ts;
	} scan;

(matter of style though, just saying).

-- 
With Best Regards,
Andy Shevchenko


