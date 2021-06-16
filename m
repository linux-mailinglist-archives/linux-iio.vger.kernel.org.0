Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4861B3A9B03
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhFPMwl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 08:52:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:1040 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232692AbhFPMwk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 08:52:40 -0400
IronPort-SDR: ImAEQJLhdOgxP1bMUMlxMJXX5AZ+iZYdgtcnSxTrpmoHIp9CIfHG0guQtVlinmjwS0rpsO5OxT
 e/cA5wFZ59tw==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="204339799"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="204339799"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 05:50:34 -0700
IronPort-SDR: HwJf+vV63t00TlEUgHbCL3CI0lQdDgwcTwERqMANkTrhvwFJkSJ3GCnk00QrMKyfCgKcDm6e3v
 a7o0loZlJKdg==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="554798230"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 05:50:32 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ltV00-002oiw-At; Wed, 16 Jun 2021 15:50:28 +0300
Date:   Wed, 16 Jun 2021 15:50:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ye Xiang <xiang.ye@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v2 1/1] iio: hid-sensors: lighten exported symbols by
 moving to IIO_HID namespace
Message-ID: <YMnzlGDQn2s1vuKz@smile.fi.intel.com>
References: <20210614162447.5392-1-andriy.shevchenko@linux.intel.com>
 <YMfDBhM52iyM0eFU@piout.net>
 <20210616134153.1007b5cf@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616134153.1007b5cf@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 16, 2021 at 01:41:53PM +0100, Jonathan Cameron wrote:
> On Mon, 14 Jun 2021 22:58:46 +0200
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > On 14/06/2021 19:24:47+0300, Andy Shevchenko wrote:
> > > A namespace for exported symbols makes clear who is a provider
> > > and who is a consumer of the certain resources. Besides that,
> > > it doesn't pollute the common namespace.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Thanks,  applied to the togreg branch of iio.git and pushed out as
> testing for 0-day to poke at it

Thanks!

> and see if we missed anything.

Hopefully nothing in the code.

What I have missed is the Ack from Srinivas. Can you add it later on?


-- 
With Best Regards,
Andy Shevchenko


