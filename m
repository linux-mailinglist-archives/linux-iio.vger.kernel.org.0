Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E141C1A8E
	for <lists+linux-iio@lfdr.de>; Fri,  1 May 2020 18:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgEAQ1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 May 2020 12:27:11 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32418 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728947AbgEAQ1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 May 2020 12:27:11 -0400
X-IronPort-AV: E=Sophos;i="5.73,340,1583190000"; 
   d="scan'208";a="447806228"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2020 18:27:07 +0200
Date:   Fri, 1 May 2020 18:27:07 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabien.lahoudere@collabora.com, felipe.balbi@linux.intel.com,
        david@lechnology.com, alexandre.belloni@bootlin.com,
        gwendal@chromium.org, kamel.bouhara@bootlin.com, jic23@kernel.org,
        kbuild-all@lists.01.org
Subject: Re: [PATCH 1/4] counter: Internalize sysfs interface code (fwd)
Message-ID: <alpine.DEB.2.21.2005011825030.2504@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Normally, the argument of kfree should not start with &.

julia

---------- Forwarded message ----------
Date: Fri, 1 May 2020 06:07:26 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/4] counter: Internalize sysfs interface code

CC: kbuild-all@lists.01.org
In-Reply-To: <d84f0bb3258d1664e90da64d75f787829c50a9bd.1588176662.git.vilhelm.gray@gmail.com>
References: <d84f0bb3258d1664e90da64d75f787829c50a9bd.1588176662.git.vilhelm.gray@gmail.com>
TO: William Breathitt Gray <vilhelm.gray@gmail.com>
TO: jic23@kernel.org
CC: kamel.bouhara@bootlin.com
CC: gwendal@chromium.org
CC: alexandre.belloni@bootlin.com
CC: david@lechnology.com
CC: felipe.balbi@linux.intel.com
CC: fabien.lahoudere@collabora.com
CC: linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-stm32@st-md-mailman.stormreply.com

Hi William,

I love your patch! Perhaps something to improve:

[auto build test WARNING on stm32/stm32-next]
[cannot apply to linus/master linux/master v5.7-rc3 next-20200430]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Introduce-the-Counter-character-device-interface/20200430-051734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
:::::: branch date: 25 hours ago
:::::: commit date: 25 hours ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/counter/counter-core.c:26:1-6: ERROR: invalid free of structure field

# https://github.com/0day-ci/linux/commit/bdd9a6aa70c61f16dacaf057f0ce70fc210b5ec9
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout bdd9a6aa70c61f16dacaf057f0ce70fc210b5ec9
vim +26 drivers/counter/counter-core.c

bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29  20
bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29  21  static void counter_device_release(struct device *dev)
bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29  22  {
bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29  23  	struct counter_device *const counter = dev_get_drvdata(dev);
bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29  24
bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29  25  	counter_sysfs_free(counter);
bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29 @26  	kfree(&counter->dev);
bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29  27  	ida_simple_remove(&counter_ida, counter->id);
bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29  28  }
bdd9a6aa70c61f1 William Breathitt Gray 2020-04-29  29

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
