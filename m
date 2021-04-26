Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA236AFD9
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhDZImy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 26 Apr 2021 04:42:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2914 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhDZImy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Apr 2021 04:42:54 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FTJ8w0dq1z6smKh
        for <linux-iio@vger.kernel.org>; Mon, 26 Apr 2021 16:34:24 +0800 (CST)
Received: from lhreml721-chm.china.huawei.com (10.201.108.72) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Apr 2021 10:42:05 +0200
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Apr 2021 09:42:05 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Mon, 26 Apr 2021 09:42:04 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: FW: ingenic-adc.c:undefined reference to `clk_get_parent'
Thread-Topic: ingenic-adc.c:undefined reference to `clk_get_parent'
Thread-Index: AQHXGnzO72eEKbQyu0OOb/wYw4s2YarGeH6AgABCHwA=
Date:   Mon, 26 Apr 2021 08:42:04 +0000
Message-ID: <8d72be21988d46c2ac8ad0de15689452@huawei.com>
References: <202103162301.oomY9NwI-lkp@intel.com>
 <ac51550d-c72e-4a85-ed0e-a4cddbf495be@infradead.org>
In-Reply-To: <ac51550d-c72e-4a85-ed0e-a4cddbf495be@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.52.122.238]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



-----Original Message-----
From: Randy Dunlap [mailto:rdunlap@infradead.org] 
Sent: 26 April 2021 06:44
To: kernel test robot <lkp@intel.com>; Jonathan Cameron <jonathan.cameron@huawei.com>; linux-clk@vger.kernel.org
Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Andy Shevchenko <andy.shevchenko@gmail.com>; Stephen Boyd <sboyd@kernel.org>; Michael Turquette <mturquette@baylibre.com>
Subject: Re: ingenic-adc.c:undefined reference to `clk_get_parent'

[add linux-clk + maintainers]

On 3/16/21 8:54 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1a4431a5db2bf800c647ee0ed87f2727b8d6c29c
> commit: a07a4fe5ff460e99293c0d682421920d54e31d7f iio:adc:ingenic: drop of_match_ptr protection and include mod_devicetable.h
> date:   8 months ago
> config: mips-randconfig-p001-20210316 (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a07a4fe5ff460e99293c0d682421920d54e31d7f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a07a4fe5ff460e99293c0d682421920d54e31d7f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross 
> ARCH=mips
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
>>> ingenic-adc.c:(.text+0x8c): undefined reference to `clk_get_parent'
>    mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
>    ingenic-adc.c:(.text+0x164): undefined reference to `clk_get_parent'

Hi,

My guess (analysis) suggests that this problem is due to a difference in when clk_get_parent() is available between <linux/clk.h> where it depends on CONFIG_HAVE_CLK and drivers/clk/clk.c, which is built iff CONFIG_COMMON_CLK.

Any comments/suggestions?

thanks.
--
~Randy

