Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E149F42D89B
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJNL5U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 07:57:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:12485 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhJNL5T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Oct 2021 07:57:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227557121"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="227557121"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 04:55:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="442726077"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 04:55:13 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mb28I-000C7i-Py;
        Thu, 14 Oct 2021 17:54:58 +0300
Date:   Thu, 14 Oct 2021 17:54:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, jic23@kernel.org, hdegoede@redhat.com,
        ddvlad@gmail.com
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Fix possible memory leak in
 probe and remove
Message-ID: <YWhEwqdHbPTAfvto@smile.fi.intel.com>
References: <20211014035338.3750416-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014035338.3750416-1-yangyingliang@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 14, 2021 at 11:53:38AM +0800, Yang Yingliang wrote:
> When ACPI type is ACPI_SMO8500, the data->dready_trig will not be set, the
> memory allocated by iio_triggered_buffer_setup() will not be freed, and cause
> memory leak as follows:

It seems it's not first time I'm telling you to shrink the noise in the commit
message.  Can you please LEARN this once and forever?

> unreferenced object 0xffff888009551400 (size 512):
>   comm "i2c-SMO8500-125", pid 911, jiffies 4294911787 (age 83.852s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 20 e2 e5 c0 ff ff ff ff  ........ .......
>   backtrace:
>     [<0000000041ce75ee>] kmem_cache_alloc_trace+0x16d/0x360
>     [<000000000aeb17b0>] iio_kfifo_allocate+0x41/0x130 [kfifo_buf]
>     [<000000004b40c1f5>] iio_triggered_buffer_setup_ext+0x2c/0x210 [industrialio_triggered_buffer]
>     [<000000004375b15f>] kxcjk1013_probe+0x10c3/0x1d81 [kxcjk_1013]
>     [<0000000020115b9a>] i2c_device_probe+0xa31/0xbe0
>     [<00000000d9f581a6>] really_probe+0x299/0xc30
>     [<00000000c6c16cde>] __driver_probe_device+0x357/0x500
>     [<00000000909852a1>] driver_probe_device+0x4e/0x140
>     [<000000008419ba53>] __device_attach_driver+0x257/0x340
>     [<00000000533bb466>] bus_for_each_drv+0x166/0x1e0
>     [<000000005bf45d75>] __device_attach+0x272/0x420
>     [<0000000075220311>] bus_probe_device+0x1eb/0x2a0
>     [<0000000015587e85>] device_add+0xbf0/0x1f90
>     [<0000000086901b9e>] i2c_new_client_device+0x622/0xb20
>     [<000000000865ca18>] new_device_store+0x1fa/0x420
>     [<0000000059a3d183>] dev_attr_store+0x58/0x80

-- 
With Best Regards,
Andy Shevchenko


