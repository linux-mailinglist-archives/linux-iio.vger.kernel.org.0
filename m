Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 741BFA9E6D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfIEJcM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 05:32:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731306AbfIEJcM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 05:32:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B84C92026F6A311B2065;
        Thu,  5 Sep 2019 17:32:09 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 17:32:05 +0800
Date:   Thu, 5 Sep 2019 10:08:46 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     kbuild test robot <lkp@intel.com>, <kbuild-all@01.org>,
        <devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>
Subject: Re: [staging:staging-testing 314/401]
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c:312: undefined
 reference to `__udivdi3'
Message-ID: <20190905100846.000045b4@huawei.com>
In-Reply-To: <20190904123711.GL2680@smile.fi.intel.com>
References: <201909041145.dxkxV8cJ%lkp@intel.com>
        <20190904123711.GL2680@smile.fi.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Sep 2019 15:37:11 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Sep 04, 2019 at 11:33:50AM +0800, kbuild test robot wrote:
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/staging.git staging-testing
> > head:   74eb9c06b1d722468db397595ac6834b9e4ac235
> > commit: 473d12f7638c93acbd9296a8cd455b203d5eb528 [314/401] iio: hid-sensor-attributes: Convert to use int_pow()
> > config: i386-randconfig-e004-201935 (attached as .config)
> > compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
> > reproduce:
> >         git checkout 473d12f7638c93acbd9296a8cd455b203d5eb528
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):  
> 
> So, as far as I understood it wasn't compiled on 32-bit before, so, it's not a
> new error and thus would (has to?) be fixed separately.

I'm not convinced.  My assumption is this is triggered because the local pow_10
function was returning int whereas generic int_pow is returning an int64.
Whilst I would imagine it is fairly easy to fix, I'll not have a chance to do
so until the weekend.  Perhaps we should just revert this patch and revisit
in the next cycle?

0-day people, any idea why the iio.git/testing branch isn't getting built any
more?  I got lazy and started relying on your infrastructure and not bothering
with 32 bit local builds.  Somewhere along the way you stopped building it
and I'm afraid I didn't really notice.

Thanks for you all your hard work on 0day btw as it used to catch a lot
of stuff my local few builds didn't!

Jonathan



> 
> >    ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o: in function `adjust_exponent_nano':  
> > >> drivers/iio/common/hid-sensors/hid-sensor-attributes.c:312: undefined reference to `__udivdi3'
> > >> ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.c:314: undefined reference to `__umoddi3'
> > >> ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.c:324: undefined reference to `__udivdi3'  
> >    ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.c:325: undefined reference to `__umoddi3'  
> 
> 


