Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0D3E2B67
	for <lists+linux-iio@lfdr.de>; Fri,  6 Aug 2021 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbhHFNbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 09:31:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:46349 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244356AbhHFNbg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Aug 2021 09:31:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="275414100"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="275414100"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 06:31:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="569751876"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 06:31:17 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mBzwN-005qAH-7G; Fri, 06 Aug 2021 16:31:11 +0300
Date:   Fri, 6 Aug 2021 16:31:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Jason M ." <jason@montleon.com>
Subject: Re: [PATCH v1 1/1] iio: cros_ec: Fix Kconfig dependency on
 CROS_EC_SENSORHUB
Message-ID: <YQ05nyWFHf5coFOw@smile.fi.intel.com>
References: <20210806130227.69473-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806130227.69473-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 06, 2021 at 04:02:27PM +0300, Andy Shevchenko wrote:
> When CONFIG_CROS_EC_SENSORHUB is set to m, the IIO_CROS_EC_SENSORS_CORE
> can't be built-in.

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213979

Looking again into .config actually puzzles me, there shouldn't be build
errors.

-- 
With Best Regards,
Andy Shevchenko


