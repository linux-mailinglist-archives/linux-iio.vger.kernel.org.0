Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34117A32
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 15:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfEHNRx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 09:17:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:42061 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfEHNRx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 May 2019 09:17:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 06:17:52 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2019 06:17:50 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hOMSD-0000ml-Sq; Wed, 08 May 2019 16:17:49 +0300
Date:   Wed, 8 May 2019 16:17:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-scsi@vger.kernel.org, gregkh@linuxfoundation.org,
        jic23@kernel.org, lars@metafoo.de
Subject: Re: [PATCH 3/3][V3] iio: Handle enumerated properties with gaps
Message-ID: <20190508131749.GM9224@smile.fi.intel.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
 <20190508111913.7276-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508111913.7276-3-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 08, 2019 at 02:19:13PM +0300, Alexandru Ardelean wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Some enums might have gaps or reserved values in the middle of their value
> range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
> meaning, but 2 is a reserved value and can not be used.
> 
> Add support for such enums to the IIO enum helper functions. A reserved
> values is marked by setting its entry in the items array to NULL rather
> than the normal descriptive string value.
> 
> Also, `__sysfs_match_string()` now supports NULL gaps, so that doesn't
> require any changes.

> -	for (i = 0; i < e->num_items; ++i)
> +	for (i = 0; i < e->num_items; ++i) {
> +		if (!e->items[i])
> +			continue;
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
> +	}

The problem here that the user will have no clue where the gap is happened, to
solve this we need either bitmap of array, where set bits shows defined items,
or use comma-separated list of values. The latter would need another node since
we don't break user space.

-- 
With Best Regards,
Andy Shevchenko


