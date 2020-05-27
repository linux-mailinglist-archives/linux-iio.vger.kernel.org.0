Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A801E4535
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgE0OGN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 10:06:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:20537 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbgE0OGM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 May 2020 10:06:12 -0400
IronPort-SDR: nxnHDfu3fWcV+poCo+3u4Ztn4nO2RuN6lzVjEtmjhlbOcjn/k5TIgTIe0HHIrb9lsB/k9ieu7H
 eg0W2HSOm6zQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 07:06:12 -0700
IronPort-SDR: o+ggt5P5jsapQG25TIZQvKM9K6wbbrh3TnTZnUAkyR/C2oSWBqsRaiZDkTJF+0u2AeD43/3EJd
 0u7RwtACgFwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="468719626"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2020 07:06:10 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdwhB-009Eup-No; Wed, 27 May 2020 17:06:13 +0300
Date:   Wed, 27 May 2020 17:06:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
Message-ID: <20200527140613.GD1634618@smile.fi.intel.com>
References: <20200525170628.503283-20-jic23@kernel.org>
 <20200525175236.GG1634618@smile.fi.intel.com>
 <da67e0e4-5889-eb87-7bc0-fac07ae54e57@metafoo.de>
 <20200526091556.GN1634618@smile.fi.intel.com>
 <20200526174328.0000673d@Huawei.com>
 <20200526170612.GY1634618@smile.fi.intel.com>
 <E1CB2D23-5B37-47E7-8782-ACC296EE5712@jic23.retrosnub.co.uk>
 <20200526210313.GD1634618@smile.fi.intel.com>
 <20200527124107.00001386@Huawei.com>
 <20200527123713.GO1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527123713.GO1634618@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 27, 2020 at 03:37:13PM +0300, Andy Shevchenko wrote:
> On Wed, May 27, 2020 at 12:41:07PM +0100, Jonathan Cameron wrote:
> > On Wed, 27 May 2020 00:03:13 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

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

I meant here if __aligned() behaviour against POD inside the structure
is documented in GCC manuals / etc.

-- 
With Best Regards,
Andy Shevchenko


