Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59E642DB03
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhJNOD3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 10:03:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:33309 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhJNOD1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Oct 2021 10:03:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="225139063"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="225139063"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 07:01:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="563769819"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 07:01:20 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mb46M-000E6j-Hi;
        Thu, 14 Oct 2021 20:01:06 +0300
Date:   Thu, 14 Oct 2021 20:01:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, jic23@kernel.org, hdegoede@redhat.com,
        ddvlad@gmail.com
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Fix possible memory leak in
 probe and remove
Message-ID: <YWhiUngyIdU0RiY/@smile.fi.intel.com>
References: <20211014035338.3750416-1-yangyingliang@huawei.com>
 <YWhEwqdHbPTAfvto@smile.fi.intel.com>
 <d4b9addc-1896-7e78-8a57-9ef0a8ab8f38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b9addc-1896-7e78-8a57-9ef0a8ab8f38@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 14, 2021 at 09:38:52PM +0800, Yang Yingliang wrote:
> On 2021/10/14 22:54, Andy Shevchenko wrote:
> > On Thu, Oct 14, 2021 at 11:53:38AM +0800, Yang Yingliang wrote:
> > > When ACPI type is ACPI_SMO8500, the data->dready_trig will not be set, the
> > > memory allocated by iio_triggered_buffer_setup() will not be freed, and cause
> > > memory leak as follows:
> > It seems it's not first time I'm telling you to shrink the noise in the commit
> > message.  Can you please LEARN this once and forever?
> Thanks for you advice, I searched the whole kernel source tree commit
> message to
> learn how to make the memory leak report, I found most of them using the
> whole
> backtrace, so I make the report like they did in this patch.

Some maintainers do not care about bloated sizes of the commit messages,
however there are several advantages to have them shorter:

1/ saving resources (followed by disk storages and energy around the world,
   means being environment friendly for real);

2/ when reading log, noise make it much harder to understand, besides the
   fact that reading itself will be time consuming;

3/ nowadays some people are tending to read or even discuss the changes on
   the mobile devices, where screen size is not so big;

4/ the copied'n'pasted backtrace means that the contributor probably
   haven't thought through it and the quality of the change is in doubt.

> I will shrink
> the noise in v2.
> How about shrink it like this:

Much better!

-- 
With Best Regards,
Andy Shevchenko


