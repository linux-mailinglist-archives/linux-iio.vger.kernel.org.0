Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972F3116F2B
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 15:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLIOjs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 09:39:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:38321 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfLIOjr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Dec 2019 09:39:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 06:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="414089974"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2019 06:39:46 -0800
Received: from andy by smile with local (Exim 4.93-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ieKCQ-0007Wm-3h; Mon, 09 Dec 2019 16:39:46 +0200
Date:   Mon, 9 Dec 2019 16:39:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1015: Make use of device property
 API
Message-ID: <20191209143946.GH32742@smile.fi.intel.com>
References: <20191205174637.47610-1-andriy.shevchenko@linux.intel.com>
 <20191205174637.47610-2-andriy.shevchenko@linux.intel.com>
 <20191207110937.6a0c1229@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207110937.6a0c1229@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 07, 2019 at 11:09:37AM +0000, Jonathan Cameron wrote:
> On Thu,  5 Dec 2019 19:46:37 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Make use of device property API in this driver so that both OF based
> > system and ACPI based system can use this driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Applied.

Thanks!


-- 
With Best Regards,
Andy Shevchenko


