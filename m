Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980D81C0F66
	for <lists+linux-iio@lfdr.de>; Fri,  1 May 2020 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgEAIVW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 May 2020 04:21:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:3634 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgEAIVU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 May 2020 04:21:20 -0400
IronPort-SDR: aa9Ufm9iTi6VlAaaE3FPfY9C9J6z9ygfOfRAVPlmScpTYbXWMaoW5K8HILZXwjYL44WZaF6I/W
 hnnfO3oMpAsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 01:21:19 -0700
IronPort-SDR: h77IynNGJak8oRRpCu0/PkUFI8Q4PTPXFuZ2UUgOQ7BD+jdUT2aXj3GtymILU6WoX7nDj2vxcZ
 9fitF+xCkE5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,339,1583222400"; 
   d="scan'208";a="247445165"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 May 2020 01:21:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jUQv0-0008Y7-W1; Fri, 01 May 2020 16:21:10 +0800
Date:   Fri, 1 May 2020 16:20:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kbuild-all@lists.01.org, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, felipe.balbi@linux.intel.com,
        fabien.lahoudere@collabora.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/4] counter: Internalize sysfs interface code
Message-ID: <202005011619.Tn2f4rMl%lkp@intel.com>
References: <d84f0bb3258d1664e90da64d75f787829c50a9bd.1588176662.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d84f0bb3258d1664e90da64d75f787829c50a9bd.1588176662.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William,

I love your patch! Perhaps something to improve:

[auto build test WARNING on stm32/stm32-next]
[cannot apply to linus/master linux/master v5.7-rc3 next-20200430]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Introduce-the-Counter-character-device-interface/20200430-051734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/counter/104-quad-8.c:700:56: sparse: sparse: mixing different enum types:
>> drivers/counter/104-quad-8.c:700:56: sparse:    unsigned int enum counter_count_function
>> drivers/counter/104-quad-8.c:700:56: sparse:    unsigned int enum quad8_count_function
--
>> drivers/counter/stm32-lptimer-cnt.c:573:24: sparse: sparse: mixing different enum types:
>> drivers/counter/stm32-lptimer-cnt.c:573:24: sparse:    unsigned int enum counter_count_function
>> drivers/counter/stm32-lptimer-cnt.c:573:24: sparse:    unsigned int enum stm32_lptim_cnt_function

vim +700 drivers/counter/104-quad-8.c

   693	
   694	static int quad8_function_write(struct counter_device *counter,
   695					struct counter_count *count,
   696					enum counter_count_function function)
   697	{
   698		struct quad8_iio *const priv = counter->priv;
   699		const int id = count->id;
 > 700		const enum quad8_count_function cnt_function = function;
   701		unsigned int *const quadrature_mode = priv->quadrature_mode + id;
   702		unsigned int *const scale = priv->quadrature_scale + id;
   703		unsigned int mode_cfg = priv->count_mode[id] << 1;
   704		unsigned int *const synchronous_mode = priv->synchronous_mode + id;
   705		const unsigned int idr_cfg = priv->index_polarity[id] << 1;
   706		const int base_offset = priv->base + 2 * id + 1;
   707	
   708		if (cnt_function == QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
   709			*quadrature_mode = 0;
   710	
   711			/* Quadrature scaling only available in quadrature mode */
   712			*scale = 0;
   713	
   714			/* Synchronous function not supported in non-quadrature mode */
   715			if (*synchronous_mode) {
   716				*synchronous_mode = 0;
   717				/* Disable synchronous function mode */
   718				outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
   719			}
   720		} else {
   721			*quadrature_mode = 1;
   722	
   723			switch (cnt_function) {
   724			case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
   725				*scale = 0;
   726				mode_cfg |= QUAD8_CMR_QUADRATURE_X1;
   727				break;
   728			case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
   729				*scale = 1;
   730				mode_cfg |= QUAD8_CMR_QUADRATURE_X2;
   731				break;
   732			case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
   733				*scale = 2;
   734				mode_cfg |= QUAD8_CMR_QUADRATURE_X4;
   735				break;
   736			default: return -EINVAL;
   737			}
   738		}
   739	
   740		/* Load mode configuration to Counter Mode Register */
   741		outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
   742	
   743		return 0;
   744	}
   745	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
