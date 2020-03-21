Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7CC18E412
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 20:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCUTtA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 15:49:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:7383 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgCUTtA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 15:49:00 -0400
IronPort-SDR: 6i/rPGYNnbWGOGjb/ps1c62OgdgruvcTYdV9xY7rnruR62shtOzmgvuWTaw4qKlGJZXjuoCkfe
 YO0mKDcYbCxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 12:48:58 -0700
IronPort-SDR: 58PRJpKjg/S7hTESavS/0HL1iKGKThJ41VGrdxbxJiDlhzAFI2V2UTUGnvHVKCiDXIXCFnB/mj
 S0P6/JW4DcZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,289,1580803200"; 
   d="scan'208";a="237566218"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 21 Mar 2020 12:48:56 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jFk79-00Bo2H-1O; Sat, 21 Mar 2020 21:48:59 +0200
Date:   Sat, 21 Mar 2020 21:48:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] MAINTAINERS: remove Stefan Popa's email
Message-ID: <20200321194859.GA2813896@smile.fi.intel.com>
References: <20200317143336.6098-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317143336.6098-1-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 17, 2020 at 04:33:36PM +0200, Alexandru Ardelean wrote:
> The email is no longer active. This change removes Stefan's email from the
> MAINTAINERS list and replaces it with Michael Hennerich's.
> 

Are you planning to fix entries as parse-maintainers.pl does?
(Maybe in a separate change, but also why not here)


-- 
With Best Regards,
Andy Shevchenko


