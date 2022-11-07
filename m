Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0158361F1DA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 12:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiKGL3r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 06:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiKGL3n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 06:29:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1513CF3D
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 03:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667820582; x=1699356582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rgVYCUffr/L8dPRumMbEtueGwldQm/llj8j25tH0hd8=;
  b=ONaO+qiDbg9NVMpUdAwbZMlIj4M0Nvrt8tRGqkJhmDZrlFCPMGBlw/fG
   PZEj2bAIIjaDb131q3q0CP4tuFHT2tXXptnEXHQQvj8YAgQG6eUkMJcyv
   OKiWZpH75P0NnB6jv5VhrPZ9KnwZsdAM8cyLQ2qf758f9l25wEZZtI/1U
   yWKY3rlbHjOMK5CUr8/K5bY0f4iZwIAkmJ3KOrXOAgDKlwe19FjeKX3dA
   7KKxhyjkmGTPxtU/IuoYxKTddKL/NLpd4PSrcI9l0fYh63vP+yzJ/6EBI
   uUW9BXU+FaAxvlje8oQK/51tHIh89cjaUmN6AWIAnV1xZ4yC7VRBa3ywq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="337107084"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="337107084"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:29:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="669106001"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="669106001"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2022 03:29:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os0Jr-008bmu-2s;
        Mon, 07 Nov 2022 13:29:35 +0200
Date:   Mon, 7 Nov 2022 13:29:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, "Andrew F. Davis" <afd@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: health: afe4403: Fix oob read in afe4403_read_raw
Message-ID: <Y2jsHz2eno/sSrmh@smile.fi.intel.com>
References: <20221107020413.68483-1-weiyongjun@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107020413.68483-1-weiyongjun@huaweicloud.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 07, 2022 at 02:04:13AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> KASAN report out-of-bounds read as follows:
> 
> BUG: KASAN: global-out-of-bounds in afe4403_read_raw+0x42e/0x4c0 [afe4403]
> Read of size 4 at addr ffffffffc02ac638 by task cat/279
> 
> CPU: 2 PID: 279 Comm: cat Tainted: G                 N
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  afe4403_read_raw+0x42e/0x4c0 [afe4403 141d77410f5466ef049ee2376f5136b77a168de0]
>  iio_read_channel_info+0x249/0x2e0 [industrialio d0627df60a92bbb9630e68c3e2f98d20dac889ef]
>  dev_attr_show+0x4b/0xa0 drivers/base/core.c:2195
>  sysfs_kf_seq_show+0x1ec/0x390 fs/sysfs/file.c:59
>  seq_read_iter+0x48d/0x10b0 fs/seq_file.c:230
>  kernfs_fop_read_iter+0x4e6/0x710 fs/kernfs/file.c:275
>  call_read_iter include/linux/fs.h:2153 [inline]
>  new_sync_read fs/read_write.c:389 [inline]
>  vfs_read+0x5f2/0x890 fs/read_write.c:470
>  ksys_read+0x106/0x220 fs/read_write.c:613
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xa0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fd8611cf992
>  </TASK>

Read this
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
and update the commit message accordingly.

> The buggy address belongs to the variable:
>  afe4403_channel_leds+0x18/0xffffffffffffe9e0 [afe4403]
> 
> This issue can be reproduced by singe command:
> 
>  $ cat /sys/bus/spi/devices/spi0.0/iio\:device0/in_intensity6_raw
> 
> The array size of afe4403_channel_leds is less than channels, so access
> with chan->address cause OOB read in afe4403_read_raw. Fix it by moving
> access before use it.

-- 
With Best Regards,
Andy Shevchenko


