Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844EA37A6E6
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 14:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhEKMjl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 08:39:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:2470 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhEKMjk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 May 2021 08:39:40 -0400
IronPort-SDR: /V3rRbQL5qS4lUyOg2RKkAgmvj8+5Ft8IlcQG09j7LwJEDm3eaaueSv3npMxE7hrJDJnSTYWVe
 wV+QtJ8B5hrA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199495462"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199495462"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:38:32 -0700
IronPort-SDR: FRwwxEHA3LJBodNCNuQ5179JAjm/wOZzoYFL76sLvj/bAba2sAei3aqGxtn8bv8fUZZdHDgR9x
 EOaHLlryZreg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="609470067"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2021 05:38:29 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgRee-0000hU-Ko; Tue, 11 May 2021 12:38:28 +0000
Date:   Tue, 11 May 2021 20:37:58 +0800
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
Subject: [RFC PATCH] iio: accel: kxcjk-1013: kxcjk1013_regs can be static
Message-ID: <20210511123758.GA70037@86ca4a2db576>
References: <20210511095409.9290-3-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511095409.9290-3-stephan@gerhold.net>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

drivers/iio/accel/kxcjk-1013.c:150:30: warning: symbol 'kxcjk1013_regs' was not declared. Should it be static?
drivers/iio/accel/kxcjk-1013.c:162:30: warning: symbol 'kxtf9_regs' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 kxcjk-1013.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 8800ebf47b5a7..492f576f97348 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -147,7 +147,7 @@ struct kx_chipset_regs {
 	u8 wake_thres;
 };
 
-const struct kx_chipset_regs kxcjk1013_regs = {
+static const struct kx_chipset_regs kxcjk1013_regs = {
 	.int_src1	= KXCJK1013_REG_INT_SRC1,
 	.int_src2	= KXCJK1013_REG_INT_SRC2,
 	.int_rel	= KXCJK1013_REG_INT_REL,
@@ -159,7 +159,7 @@ const struct kx_chipset_regs kxcjk1013_regs = {
 	.wake_thres	= KXCJK1013_REG_WAKE_THRES,
 };
 
-const struct kx_chipset_regs kxtf9_regs = {
+static const struct kx_chipset_regs kxtf9_regs = {
 	/* .int_src1 was moved to INT_SRC2 on KXTF9 */
 	.int_src1	= KXTF9_REG_INT_SRC2,
 	/* .int_src2 is not available */
