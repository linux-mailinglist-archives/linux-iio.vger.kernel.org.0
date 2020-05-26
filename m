Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A209B1E30E9
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 23:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391539AbgEZVDN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 17:03:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:28269 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389600AbgEZVDN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 17:03:13 -0400
IronPort-SDR: uR0QjuLktDhtkSV8x4YuKMBPLAjy0p/EQB9q6GDKcgwQVyz3ukWLu2sbhVkx16t0oNC2YbC+ip
 0AzwNX2N5pxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 14:03:12 -0700
IronPort-SDR: +oPvapBd7xep/FsIIPbzPnsgceGasB4L294oGlPzMBG6BE1H+PPBNiVgSf7+luQfbaJF6k3eG7
 vQHu+L0q7nCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="270214893"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 26 May 2020 14:03:10 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdgjB-00950U-Sy; Wed, 27 May 2020 00:03:13 +0300
Date:   Wed, 27 May 2020 00:03:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
Message-ID: <20200526210313.GD1634618@smile.fi.intel.com>
References: <20200525170628.503283-1-jic23@kernel.org>
 <20200525170628.503283-20-jic23@kernel.org>
 <20200525175236.GG1634618@smile.fi.intel.com>
 <da67e0e4-5889-eb87-7bc0-fac07ae54e57@metafoo.de>
 <20200526091556.GN1634618@smile.fi.intel.com>
 <20200526174328.0000673d@Huawei.com>
 <20200526170612.GY1634618@smile.fi.intel.com>
 <E1CB2D23-5B37-47E7-8782-ACC296EE5712@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CB2D23-5B37-47E7-8782-ACC296EE5712@jic23.retrosnub.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 26, 2020 at 08:17:11PM +0100, Jonathan Cameron wrote:
> On 26 May 2020 18:06:12 BST, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Might be easier to just align it though than explain this subtlety. 

The easiest one seems to move ts to be first member of the struct / buffer. Problem solved.

-- 
With Best Regards,
Andy Shevchenko


