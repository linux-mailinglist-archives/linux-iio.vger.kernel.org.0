Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BDB231B1A
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 10:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgG2IVb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 04:21:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:31526 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2IVa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Jul 2020 04:21:30 -0400
IronPort-SDR: MwdzB/w34CiaCF0gUuOTzkE3r3oWG/Ij5u7OYg51DJMMJlWjlybyKNUc0K0NZpNJBjHdMqDoDN
 T5Yxd2X1DJJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="148835781"
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="148835781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 01:21:30 -0700
IronPort-SDR: SEs+jTBkn098s/oKBdX68fNp6mTLX/8uCRzJpdQz0Y7FNdhnKeqweExv/oxzutMRN1J5zyV5et
 cPP8Fxu0FUOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="272562893"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2020 01:21:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0hL6-004eQA-1Z; Wed, 29 Jul 2020 11:21:28 +0300
Date:   Wed, 29 Jul 2020 11:21:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     bigunclemax@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1015: fix conversion when CONFIG_PM is
 not set
Message-ID: <20200729082128.GJ3703480@smile.fi.intel.com>
References: <20200729075908.10463-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729075908.10463-1-fido_max@inbox.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 29, 2020 at 10:59:07AM +0300, Maxim Kochetkov wrote:
> To stop conversion ads1015_set_power_state function use unimplemented
> function pm_runtime_put_autosuspend if CONFIG_PM is not set.
> If CONFIG_PM is disabled, there is no need to start/stop conversion.
> Fix it by adding return 0 function variant if CONFIG_PM is not set.

I'm wondering if you check the real code (assembly) for any difference.

All calls AFAICS are statically defined in !CONFIG_PM case and compiler/linker
should be clever enough to drop this completely. Isn't it the case?

-- 
With Best Regards,
Andy Shevchenko


