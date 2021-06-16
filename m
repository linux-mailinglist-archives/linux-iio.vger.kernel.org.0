Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D53A9C6C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 15:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhFPNsb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 09:48:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:60945 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232912AbhFPNsb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 09:48:31 -0400
IronPort-SDR: p7ymB26uRPd7UuofSOzURNyfWrgQ9q/gej9XnaC1dLqtgiiNaaNTI59Mow63uIGFrUhEV37+8Q
 BstnS6y0ZEpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="185868573"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="185868573"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 06:46:25 -0700
IronPort-SDR: p7Ad9T7bHbZemPSWcyHV/DS0mfKq3fBNacIiSkKAXJptvHlYZX0wQa8GTpv7kQgLENHrhjU7ix
 IPkS3IwGB8OA==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="404573874"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 06:46:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ltVs3-002pYz-22; Wed, 16 Jun 2021 16:46:19 +0300
Date:   Wed, 16 Jun 2021 16:46:19 +0300
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
Message-ID: <YMoAq8knlE3FXb2f@smile.fi.intel.com>
References: <20210614162447.5392-1-andriy.shevchenko@linux.intel.com>
 <YMfDBhM52iyM0eFU@piout.net>
 <20210616134153.1007b5cf@jic23-huawei>
 <YMnzlGDQn2s1vuKz@smile.fi.intel.com>
 <20210616144108.3771d4b2@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616144108.3771d4b2@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 16, 2021 at 02:41:08PM +0100, Jonathan Cameron wrote:
> On Wed, 16 Jun 2021 15:50:28 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jun 16, 2021 at 01:41:53PM +0100, Jonathan Cameron wrote:
> > > On Mon, 14 Jun 2021 22:58:46 +0200
> > > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > > > On 14/06/2021 19:24:47+0300, Andy Shevchenko wrote:

...

> > > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > 
> > > Thanks,  applied to the togreg branch of iio.git and pushed out as
> > > testing for 0-day to poke at it
> > 
> > Thanks!
> > 
> > > and see if we missed anything.
> > 
> > Hopefully nothing in the code.
> > 
> > What I have missed is the Ack from Srinivas. Can you add it later on?

> Done which was easy because I hadn't pushed it out anywhere yet!

Thanks!

-- 
With Best Regards,
Andy Shevchenko


