Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CAF4055A4
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356081AbhIINMB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Sep 2021 09:12:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:21871 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354757AbhIINI1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Sep 2021 09:08:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="306350650"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="306350650"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 06:01:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="470076390"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 06:01:51 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mOJga-001cpi-9x;
        Thu, 09 Sep 2021 16:01:48 +0300
Date:   Thu, 9 Sep 2021 16:01:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v5 3/4] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <YToFvPooJpCpqr28@smile.fi.intel.com>
References: <20210909094537.218064-1-jacopo@jmondi.org>
 <20210909094537.218064-4-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909094537.218064-4-jacopo@jmondi.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 09, 2021 at 11:45:36AM +0200, Jacopo Mondi wrote:
> Add support for the Senseair Sunrise 006-0-0007 driver through the
> IIO subsystem.

...

> +	/*
> +	 * Wake up sensor by sending sensor address: START, sensor address,
> +	 * STOP. Sensor will not ACK this byte.
> +	 *
> +	 * The chip enters a low power state after 15msec without

msec --> ms (everybody understands 'ms' unit)

> +	 * communications or after a complete read/write sequence.
> +	 */

...

> +	struct i2c_client *client = context;
> +	union i2c_smbus_data data;
> +
> +	/* Discard reg address from values count. */
> +	if (count < 1)
> +		return -EINVAL;
> +	count--;

Wouldn't be more natural to decrement and then check against 0?

...

> +	memcpy(&data.block[1], (u8 *)val_buf + 1, count);

Not sure I understand why you need an explicit casting here.


...

> +	mutex_lock(&sunrise->lock);
> +	ret = sunrise_read_word(sunrise, SUNRISE_ERROR_STATUS_REG, &value);
> +	if (ret) {
> +		mutex_unlock(&sunrise->lock);

> +		return -EINVAL;

Why shadowing an actual error code?

> +	}

...

> +			/*
> +			 * / 10^4 to comply with IIO scale for CO2 (percentage).

"1 / 10^4"

> +			 * The chip CO2 reading range is [400 - 5000] ppm
> +			 * which corresponds to [0,004 - 0,5] %.
> +			 */

-- 
With Best Regards,
Andy Shevchenko


