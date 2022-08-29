Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC8D5A4A9A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Aug 2022 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiH2Loh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Aug 2022 07:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiH2LoL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2022 07:44:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EBD8673C;
        Mon, 29 Aug 2022 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661772497; x=1693308497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ufkiE0vbKX694dOg2orxNPFkPt51JYh25gzaZuabvzE=;
  b=dHbNpi70Ntr0UJ3B2eUrivXdIaSWJ56Er+3hEPPJ4eC4tch4SY+t0z5T
   zIRYvRlbrJpZcVzrZCRdpRgSOYygEunAGu8btC24FR0q/DJU1GKg0Q24k
   4AR+6kkVdWJLZ4MWM5CwF8HpHh8m0aiL+K1pbc/Z3Exy6chDEVlnQHC8r
   fuwD5C2ij4q/8XVyToTKChZpgYyq8CJtTwhdepy2XkY6SzxFZ9w43GvvI
   y4YcY72+4afVXvidFwhISNKSzKVJEp84xjvsj2mTDbCpb5aTG77iK6dv8
   lnCTvBrzvJihAQm1JAhnjuWVa2roEetWZYXszyAWoif/0WzouN0eTph/e
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="294879422"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="294879422"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 04:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="562188844"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2022 04:23:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6C6EA45; Mon, 29 Aug 2022 14:24:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/4] iio: magnetometer: yamaha-yas530: Make strings const in chip info
Date:   Mon, 29 Aug 2022 14:24:05 +0300
Message-Id: <20220829112407.74917-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
References: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For better compiler coverage mark strings consts in the chip info.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 03e0525e6364..8cfe1ef9c5b4 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -189,8 +189,8 @@ struct yas5xx;
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
-	char *product_name;
-	char *version_names[2];
+	const char *product_name;
+	const char *version_names[2];
 	const int *volatile_reg;
 	int volatile_reg_qty;
 	u32 scaling_val2;
-- 
2.35.1

