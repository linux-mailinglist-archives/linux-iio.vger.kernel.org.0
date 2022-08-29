Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8AD5A4AA5
	for <lists+linux-iio@lfdr.de>; Mon, 29 Aug 2022 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiH2LpW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Aug 2022 07:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiH2Loe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2022 07:44:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F03DFC3;
        Mon, 29 Aug 2022 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661772522; x=1693308522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RMIzbw3S0NjAnyKRGZ1yrKelR3otHClPHqNHMk9KieA=;
  b=NrFJZ7b+66GeuKfsLn8qUwjYzDyGZTF9/KOgYdbS0jBX3yAPZxfkp0nJ
   8FBgbWZWtNo9UrMY46kH3S7SKZnyNRIq0Qs0EnD8DkGj+FbR7g5TLAGN8
   wMKXqp4W4LkD7uj1d/YXxW49r+WvlA14m7Vkd/XTw8nzztdMVVylTqrSP
   V5umwFieUrtVHyqYVu7Dcx4ywHD29ocq/cHzfAhcAorVcxXhr1VHcASi/
   m2WjUWnf8d08y6Z3NUzRPRVAkPUYrYXgCLOpmo1cvAxtSYRaxc5KKM46i
   LLMglk9vwia/K7+mw4Bk3VmQoEKCd+wHl1r6FK1+SxBylycjCkwq5U5A2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="275273872"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="275273872"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 04:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="714830573"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2022 04:23:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F0BA174; Mon, 29 Aug 2022 14:24:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 4/4] iio: magnetometer: yamaha-yas530: Use dev_err_probe()
Date:   Mon, 29 Aug 2022 14:24:07 +0300
Message-Id: <20220829112407.74917-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
References: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Unify error message format by using dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index bacd2b783113..63bb743dc4f6 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -1420,10 +1420,8 @@ static int yas5xx_probe(struct i2c_client *i2c)
 		return dev_err_probe(dev, ret, "cannot get regulators\n");
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(yas5xx->regs), yas5xx->regs);
-	if (ret) {
-		dev_err(dev, "cannot enable regulators\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot enable regulators\n");
 
 	/* See comment in runtime resume callback */
 	usleep_range(31000, 40000);
@@ -1431,15 +1429,13 @@ static int yas5xx_probe(struct i2c_client *i2c)
 	/* This will take the device out of reset if need be */
 	yas5xx->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(yas5xx->reset)) {
-		ret = dev_err_probe(dev, PTR_ERR(yas5xx->reset),
-				    "failed to get reset line\n");
+		ret = dev_err_probe(dev, PTR_ERR(yas5xx->reset), "failed to get reset line\n");
 		goto reg_off;
 	}
 
 	yas5xx->map = devm_regmap_init_i2c(i2c, &yas5xx_regmap_config);
 	if (IS_ERR(yas5xx->map)) {
-		dev_err(dev, "failed to allocate register map\n");
-		ret = PTR_ERR(yas5xx->map);
+		ret = dev_err_probe(dev, PTR_ERR(yas5xx->map), "failed to allocate register map\n");
 		goto assert_reset;
 	}
 
@@ -1487,13 +1483,13 @@ static int yas5xx_probe(struct i2c_client *i2c)
 					 yas5xx_handle_trigger,
 					 NULL);
 	if (ret) {
-		dev_err(dev, "triggered buffer setup failed\n");
+		dev_err_probe(dev, ret, "triggered buffer setup failed\n");
 		goto assert_reset;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(dev, "device register failed\n");
+		dev_err_probe(dev, ret, "device register failed\n");
 		goto cleanup_buffer;
 	}
 
-- 
2.35.1

