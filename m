Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8661F1B1B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgFHOf5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 10:35:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:51413 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgFHOf4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 10:35:56 -0400
IronPort-SDR: TmONOXZJHhNYugsfPlVyYp+667/zV+Vhgv0PoKbeeuO2JfQJIbAONvFvEVNm5WLP743pE4OyhG
 uFv+ACAQeUbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 07:35:56 -0700
IronPort-SDR: rtADVIHPfYBQbZQAFDNyXbTI8+MwRClkp41lW5oKYdCFJOtLM+GJ/NIUGVXqco/MZD9o0TLvkv
 MIli5JyueNBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="349186860"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 08 Jun 2020 07:35:54 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jiIsX-00BhTA-Ew; Mon, 08 Jun 2020 17:35:57 +0300
Date:   Mon, 8 Jun 2020 17:35:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 27/32] iio:adc:ti-ads124s08 Fix alignment and data leak
 issues.
Message-ID: <20200608143557.GV2428291@smile.fi.intel.com>
References: <20200607155408.958437-1-jic23@kernel.org>
 <20200607155408.958437-28-jic23@kernel.org>
 <20200608131458.GP2428291@smile.fi.intel.com>
 <20200608150640.000053a6@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608150640.000053a6@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 08, 2020 at 03:06:40PM +0100, Jonathan Cameron wrote:
> On Mon, 8 Jun 2020 16:14:58 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Sun, Jun 07, 2020 at 04:54:03PM +0100, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > One of a class of bugs pointed out by Lars in a recent review.
> > > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > > this driver which uses an array of smaller elements on the stack.
> > > As Lars also noted this anti pattern can involve a leak of data to
> > > userspace and that indeed can happen here.  We close both issues by
> > > moving to a suitable structure in the iio_priv() data with alignment
> > > explicitly requested.  This data is allocated with kzalloc so no
> > > data can leak apart from previous readings.  
> > 
> > > +	/*
> > > +	 * Used to correctly align data.
> > > +	 * Ensure timestamp is naturally aligned.
> > > +	 */  
> > 
> > > +	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);  
> > 
> > Can't you rather provide a struct as well?
> > 
> Not without giving a false impression of where the time stamp is in the resulting
> buffer.
> 
> I'm not keen to do that because it'll lead to people fundamentally misunderstanding
> the dynamic nature of IIO buffer packing.
> 
> Here it could start at byte 8, 16, 24, 32, 48, 64 I think.

I see, thanks for explanation!
Same for the other comment.

-- 
With Best Regards,
Andy Shevchenko


