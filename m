Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474B41F19B7
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 15:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgFHNO6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 09:14:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:50330 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgFHNO6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 09:14:58 -0400
IronPort-SDR: wuXBHYpvrgjipBGAQUUhsinOsNcvjvWd2/OMmCW9vxS5CkqIu3pVRavRT1B9eZVM+rZF1jjlvc
 AHA4I6pQL64g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 06:14:57 -0700
IronPort-SDR: G9pebWYHsjpl8zsILwrFJHaOQOU8GxtlCCwX1DC5L8jq2WYpxfbfHQ9lbZxTCiSM1i+gyaFgnG
 hylY96HugLsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="274219010"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2020 06:14:55 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jiHcA-00BgdG-OH; Mon, 08 Jun 2020 16:14:58 +0300
Date:   Mon, 8 Jun 2020 16:14:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 27/32] iio:adc:ti-ads124s08 Fix alignment and data leak
 issues.
Message-ID: <20200608131458.GP2428291@smile.fi.intel.com>
References: <20200607155408.958437-1-jic23@kernel.org>
 <20200607155408.958437-28-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607155408.958437-28-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 07, 2020 at 04:54:03PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak apart from previous readings.

> +	/*
> +	 * Used to correctly align data.
> +	 * Ensure timestamp is naturally aligned.
> +	 */

> +	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);

Can't you rather provide a struct as well?

-- 
With Best Regards,
Andy Shevchenko


