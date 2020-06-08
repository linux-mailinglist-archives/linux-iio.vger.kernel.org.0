Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DCB1F19C4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgFHNRQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 09:17:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:7537 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbgFHNRQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 09:17:16 -0400
IronPort-SDR: osrbZ7MX2R5LhUJAHtUNeDIJ2REFXCQKL4MhUFajsmcSLnzsxyemF75I8mA+53trezPnsT7s9l
 nXpbNDzOdlyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 06:17:15 -0700
IronPort-SDR: EDZisSNlnqWQGknYnyxgc7eQLggSLdye5KHL+uxUpYCzGqCvul7CNXIh3/7IgwebGk3ozzrtxU
 qW9zHN+vFjLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="305818270"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2020 06:17:10 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jiHeK-00Bgem-NA; Mon, 08 Jun 2020 16:17:12 +0300
Date:   Mon, 8 Jun 2020 16:17:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 18/32] iio:imu:bmi160 Fix alignment and data leak issues
Message-ID: <20200608131712.GQ2428291@smile.fi.intel.com>
References: <20200607155408.958437-1-jic23@kernel.org>
 <20200607155408.958437-19-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607155408.958437-19-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 07, 2020 at 04:53:54PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable array in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak apart from previous readings.

> +	/* Ensure natural alignment for timestamp if present */
> +	__le16 buf[16] __aligned(8);

Perhaps struct in all such cases, like

 struct scan {
	 __le16 buf[3 * 3]; // 3 axis per 3 sensors
	 s64 ts; __aligned(8);
 };

?

-- 
With Best Regards,
Andy Shevchenko


