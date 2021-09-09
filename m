Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185904055A3
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356061AbhIINMA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Sep 2021 09:12:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:16567 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358541AbhIINHk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Sep 2021 09:07:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200983497"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="200983497"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 06:05:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="466487379"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 06:05:44 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mOJkL-001cuH-Fe;
        Thu, 09 Sep 2021 16:05:41 +0300
Date:   Thu, 9 Sep 2021 16:05:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: ABI: Document in_concentration_co2_scale
Message-ID: <YToGpTR0aJ97GxG0@smile.fi.intel.com>
References: <20210909094537.218064-1-jacopo@jmondi.org>
 <20210909094537.218064-5-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909094537.218064-5-jacopo@jmondi.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 09, 2021 at 11:45:37AM +0200, Jacopo Mondi wrote:
> Document the 'in_concentration_co2_scale' standard IIO attribute.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale

I don't know the history of the discussion about this attribute but it seems
too specific to have in list of kinda generic ones.

Shouldn't be rather air / gas / etc used instead of CO2?

-- 
With Best Regards,
Andy Shevchenko


