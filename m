Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B4F2578A9
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 13:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHaLtJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 07:49:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:61998 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaLtJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 07:49:09 -0400
IronPort-SDR: wxt1gnSr+X56Af47jL80l9VgW2sjS6+BYIliZStmVqVvzYA5xFScnkwoYSqLMrJCHy5377Lpfs
 vEVSwI6r5lTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="137005080"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="137005080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 04:49:08 -0700
IronPort-SDR: p5n0mXtTztVNSgj9OtQEcUwfQkjbiKskU5gEr7y7CU/DTBGAATy8jG/20w0h5kwsiLjiUsriNP
 BU45pgoqNL2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="330667689"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2020 04:49:06 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kCiJ6-00CzhD-NP; Mon, 31 Aug 2020 14:49:04 +0300
Date:   Mon, 31 Aug 2020 14:49:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/8] iio: accel: bma220: Fix returned codes from
 bma220_init(), bma220_deinit()
Message-ID: <20200831114904.GH1891694@smile.fi.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
 <20200831102145.0eaebb77@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831102145.0eaebb77@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 31, 2020 at 10:21:45AM +0100, Jonathan Cameron wrote:
> On Mon, 31 Aug 2020 12:08:06 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Potentially bma220_init() and bma220_deinit() may return positive codes.
> > Fix the logic to return proper error codes instead.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Hi Andy
> 
> A nice straight forward set and I suspect we aren't going to get any other
> reviews, hence...
> 
> Series applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to poke at it.

Thanks!

P.S. Consider this series as an example what can be done to many IIO drivers
in order to clean them up. My focus, of course, ACPI interaction:
 - use of ACPI_PTR / ifdeffery
 - inclusion of acpi.h
 - ...

-- 
With Best Regards,
Andy Shevchenko


