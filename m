Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4761F1DB
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 12:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKGLaR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 06:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGLaQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 06:30:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F0CF3D
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 03:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667820615; x=1699356615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8k90hqxErRPdrA35hsk71QOt24S3cVmfO2dYDAaN6vY=;
  b=gig8GTGPmWjV4wxLOnlQWJ0QAz/EUHRSP2tzx61xAEcFnxJlU3P1SJmK
   UWqQyio6RFoMWYOb4jN7SZbP1I3y1nnzvJCWVVPz7jcDEbjsIkAO/nl1X
   2+RCEars2uqpsl859fyBhX6c0gFl2lM0vruutuGD4f3NMucBDnwzFxheU
   B3Zm47N7+c3EoV+7bsgNB+7uCbVHnFjXeJKRZTimAvbeBumrXOv0Ux4KF
   Hz5yTbmgj6Q4Y3oPqID86fvNiuLmrWqDNo2q70namrDNmN8RVkWmKBL89
   i1j+IA4q+mIrescowBf3DqDQeBLM40ZsQUAXO3aEo+0OOCK2PV6dVwPm0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="290111575"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="290111575"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:30:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="667140303"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="667140303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2022 03:30:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os0KQ-008bnw-2G;
        Mon, 07 Nov 2022 13:30:10 +0200
Date:   Mon, 7 Nov 2022 13:30:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        "Andrew F. Davis" <afd@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: health: afe4404: Fix oob read in
 afe4404_[read|write]_raw
Message-ID: <Y2jsQiD05EofwOWI@smile.fi.intel.com>
References: <20221107020425.72577-1-weiyongjun@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107020425.72577-1-weiyongjun@huaweicloud.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 07, 2022 at 02:04:25AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> KASAN report out-of-bounds read as follows:
> 
> BUG: KASAN: global-out-of-bounds in afe4404_read_raw+0x2ce/0x380 [afe4404]
> Read of size 4 at addr ffffffffc00e4658 by task cat/278
> 
> CPU: 1 PID: 278 Comm: cat Tainted: G
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  afe4404_read_raw+0x2ce/0x380 [afe4404]
>  iio_read_channel_info+0x249/0x2e0 [industrialio]
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
> RIP: 0033:0x7fe9c5ef6992
>  </TASK>

Read this
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
and update your commit message accordingly.

> The buggy address belongs to the variable:
>  afe4404_channel_leds+0x18/0xffffffffffffe9c0 [afe4404]
> 
> This issue can be reproduce by singe command:
> 
>  $ cat /sys/bus/i2c/devices/0-0058/iio\:device0/in_intensity6_raw
> 
> The array size of afe4404_channel_leds and afe4404_channel_offdacs
> are less than channels, so access with chan->address cause OOB read
> in afe4404_[read|write]_raw. Fix it by moving access before use them.

-- 
With Best Regards,
Andy Shevchenko


