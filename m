Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4283405639
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 15:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359236AbhIINSr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Sep 2021 09:18:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:7451 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344874AbhIINKF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Sep 2021 09:10:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200308534"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="200308534"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 06:03:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="525503166"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 06:03:05 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mOJhm-001crb-UK;
        Thu, 09 Sep 2021 16:03:02 +0300
Date:   Thu, 9 Sep 2021 16:03:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v5 3/4] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <YToGBqttqtEMIyNi@smile.fi.intel.com>
References: <20210909094537.218064-1-jacopo@jmondi.org>
 <20210909094537.218064-4-jacopo@jmondi.org>
 <YToFvPooJpCpqr28@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YToFvPooJpCpqr28@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 09, 2021 at 04:01:48PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 09, 2021 at 11:45:36AM +0200, Jacopo Mondi wrote:

> > +	struct i2c_client *client = context;
> > +	union i2c_smbus_data data;
> > +
> > +	/* Discard reg address from values count. */
> > +	if (count < 1)
> > +		return -EINVAL;
> > +	count--;
> 
> Wouldn't be more natural to decrement and then check against 0?

Ah, count is of size_t. Then comparison < 1 is equal to !count.

-- 
With Best Regards,
Andy Shevchenko


