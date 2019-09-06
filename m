Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EABA7AB47B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392800AbfIFI65 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 04:58:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:54594 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbfIFI65 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Sep 2019 04:58:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 01:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="195384167"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.15]) ([10.255.28.15])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2019 01:58:53 -0700
Subject: Re: [kbuild-all] [staging:staging-testing 314/401]
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c:312: undefined
 reference to `__udivdi3'
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org
References: <201909041145.dxkxV8cJ%lkp@intel.com>
 <20190904123711.GL2680@smile.fi.intel.com>
 <20190905100846.000045b4@huawei.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <3ecfa3de-5f8c-3606-b72a-f767cf646d56@intel.com>
Date:   Fri, 6 Sep 2019 16:58:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905100846.000045b4@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 9/5/2019 5:08 PM, Jonathan Cameron wrote:
> On Wed, 4 Sep 2019 15:37:11 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> On Wed, Sep 04, 2019 at 11:33:50AM +0800, kbuild test robot wrote:
>>> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/staging.git staging-testing
>>> head:   74eb9c06b1d722468db397595ac6834b9e4ac235
>>> commit: 473d12f7638c93acbd9296a8cd455b203d5eb528 [314/401] iio: hid-sensor-attributes: Convert to use int_pow()
>>> config: i386-randconfig-e004-201935 (attached as .config)
>>> compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
>>> reproduce:
>>>          git checkout 473d12f7638c93acbd9296a8cd455b203d5eb528
>>>          # save the attached .config to linux build tree
>>>          make ARCH=i386
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>> So, as far as I understood it wasn't compiled on 32-bit before, so, it's not a
>> new error and thus would (has to?) be fixed separately.
> I'm not convinced.  My assumption is this is triggered because the local pow_10
> function was returning int whereas generic int_pow is returning an int64.
> Whilst I would imagine it is fairly easy to fix, I'll not have a chance to do
> so until the weekend.  Perhaps we should just revert this patch and revisit
> in the next cycle?
>
> 0-day people, any idea why the iio.git/testing branch isn't getting built any
> more?  I got lazy and started relying on your infrastructure and not bothering
> with 32 bit local builds.  Somewhere along the way you stopped building it
> and I'm afraid I didn't really notice.
>
> Thanks for you all your hard work on 0day btw as it used to catch a lot
> of stuff my local few builds didn't!
>
> Jonathan

Hi Jonathan,

Sorry for the inconvenience, we updated the git url to 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/jic23/iio.git 
recently,
but it seems the branches are not updated, so we switch to use 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git now.

Best Regards,
Rong Chen


>
>
>
>>>     ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o: in function `adjust_exponent_nano':
>>>>> drivers/iio/common/hid-sensors/hid-sensor-attributes.c:312: undefined reference to `__udivdi3'
>>>>> ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.c:314: undefined reference to `__umoddi3'
>>>>> ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.c:324: undefined reference to `__udivdi3'
>>>     ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.c:325: undefined reference to `__umoddi3'
>>
>
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all

