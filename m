Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1761E1E74
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgEZJYP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:24:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:57525 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731673AbgEZJYP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 05:24:15 -0400
IronPort-SDR: 2dFyBS0b1BnAJC5pW6ADIZuOhChwI8UtGls/2NfRY8wq0b41Llxdz3xSKwWxCyJpN8iBVR64F/
 n5jeIPvqmcQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 02:24:14 -0700
IronPort-SDR: E8nnYfpbL9j82BvuYq2g7ZUUeV7OZZD4BqQfRnN9L16lL+FZRxQxPYxWCx32sMbcYwKiUcr1sW
 1fbFMBtv2efw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="468287195"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 26 May 2020 02:24:12 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdVol-008xhg-Go; Tue, 26 May 2020 12:24:15 +0300
Date:   Tue, 26 May 2020 12:24:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 07/25] iio:magnetometer:ak8975 Fix alignment and data
 leak issues.
Message-ID: <20200526092415.GO1634618@smile.fi.intel.com>
References: <20200525170628.503283-1-jic23@kernel.org>
 <20200525170628.503283-8-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525170628.503283-8-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 25, 2020 at 06:06:10PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data.

I'm not sure I understood the issue in full.

s16 members are aligned on 2 bytes at least. Unaligned access easily to fix by
moving from (int64_t *)... = ...; to put_unaligned(); in
iio_push_to_buffers_with_timestamp() once for all.

On stack the driver allocates proper amount of data with padding.

> This data is allocated with kzalloc so no data can leak apart from
> previous readings.
> 
> Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")

Unfortunately breaks as per other patch review :-)

-- 
With Best Regards,
Andy Shevchenko


