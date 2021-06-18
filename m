Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F83AD0D3
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jun 2021 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFRRB4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Jun 2021 13:01:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:45736 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhFRRB4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Jun 2021 13:01:56 -0400
IronPort-SDR: mt1bUqdGvuaawjdUtaR/2f4Hl392k4rJsSTtoZYKd+Uz6tcKw0YV09uiLm3BNP/tOj1WWV+3Oc
 EUTaIq7VAwfA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="186277871"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="186277871"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:59:46 -0700
IronPort-SDR: Ve4kXqUB54zYU7EiOPuCf/LyDItuWJd1I+nKIx2INVKQa4XQHq3NcyFQx2CqVXukEtm8otCmAW
 NhNqWx/CQGBQ==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="453206785"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:59:45 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1luHqI-003dml-Kn; Fri, 18 Jun 2021 19:59:42 +0300
Date:   Fri, 18 Jun 2021 19:59:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [BUILD SUCCESS WITH WARNING] LAST PATCH: [PATCH v1 1/1]
 kernel.h: Split out kstrtox() and simple_strtox() to a separate header
Message-ID: <YMzQ/i0k0FqbUKPq@smile.fi.intel.com>
References: <60ca9d95.dsuYBSgiVnYDvfis%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ca9d95.dsuYBSgiVnYDvfis%lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

JFYI

On Thu, Jun 17, 2021 at 08:55:49AM +0800, kernel test robot wrote:
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/kernel-h-Split-out-kstrtox-and-simple_strtox-to-a-separate-header/20210616-203318
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> 
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> 
> Warning ids grouped by kconfigs:
> 
> clang_recent_errors
> `-- x86_64-randconfig-b001-20210616
>     `-- drivers-iio-chemical-scd30_core.c:iwyu:warning:superfluous-include-linux-string.h

-- 
With Best Regards,
Andy Shevchenko


