Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB535C514
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbhDLL1z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 07:27:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:56892 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237626AbhDLL1z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Apr 2021 07:27:55 -0400
IronPort-SDR: J5/fLA2NsczlZff4atvcrCja+VGX409iHpffDnHkfU8qKsn7PXYOTFCiLJv5zjUsnfefnAbz97
 7CRTr8wC0Skw==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="181293881"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="181293881"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 04:27:37 -0700
IronPort-SDR: aswK7XKjWdoQB6r4BQSk2/Gv/84j423RzHVIBNtd4l604LJXidSChCkNVPKLyQRo5rBjg7NFX5
 wbujGC7wV/Bg==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="417346713"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 04:27:32 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lVuj1-003RK7-TB; Mon, 12 Apr 2021 14:27:27 +0300
Date:   Mon, 12 Apr 2021 14:27:27 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7768-1: Keep fwnode reference count
 balanced
Message-ID: <YHQun1VyDLEZfijm@smile.fi.intel.com>
References: <20210412101904.2054406-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412101904.2054406-1-andy.shevchenko@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 12, 2021 at 01:19:04PM +0300, Andy Shevchenko wrote:
> The commit 75ed0be7200d ("iio: adc: ad7768-1: Add channel labels.")
> missed the point that loop counter should be put after use. Otherwise
> the reference count of it will become unbalanced.

Scratch this, I might be not slept enough.

-- 
With Best Regards,
Andy Shevchenko


