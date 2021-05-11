Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D49A37A75A
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 15:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhEKNPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 09:15:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:57715 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhEKNPn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 May 2021 09:15:43 -0400
IronPort-SDR: 8rf1XAHqSOsITkLOpIw5ND9sJoNiIv6Xtuwo7GwisZunPR+XVRY7hFH6BRiwMjYyyJoMB5/X+7
 JmQ8wmael+pg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199488739"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199488739"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 06:14:35 -0700
IronPort-SDR: IFqboA5SRJgcv0vgocHVMwr1gogTVvzA8YrPWlZOKLz0uc7NbjwQkiQle9EZMmVLre9MbWDgnU
 aBVkv32yy4hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="609485461"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2021 06:14:32 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgSDX-0000iM-Lb; Tue, 11 May 2021 13:14:31 +0000
Date:   Tue, 11 May 2021 21:14:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     kbuild-all@lists.01.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [RFC PATCH] iio: accel: kxcjk-1013: kx0231025_regs can be static
Message-ID: <20210511131422.GA31783@86ca4a2db576>
References: <20210511095409.9290-4-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511095409.9290-4-stephan@gerhold.net>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

drivers/iio/accel/kxcjk-1013.c:224:30: warning: symbol 'kx0231025_regs' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 kxcjk-1013.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 5aa2a1cb2309d..1e5e241f2bcdf 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -221,7 +221,7 @@ const struct kx_chipset_regs kxtf9_regs = {
 };
 
 /* The registers have totally different names but the bits are compatible */
-const struct kx_chipset_regs kx0231025_regs = {
+static const struct kx_chipset_regs kx0231025_regs = {
 	.int_src1	= KX023_REG_INS2,
 	.int_src2	= KX023_REG_INS3,
 	.int_rel	= KX023_REG_INT_REL,
