Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67494E1D5B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbiCTSQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbiCTSQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 14:16:22 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A9527EC
        for <linux-iio@vger.kernel.org>; Sun, 20 Mar 2022 11:14:58 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3740583AA6;
        Sun, 20 Mar 2022 19:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647800096;
        bh=QinkbOhZRrGTMF8a2Q7PQC6llyJLixMVxRTiOTo0xZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r//ZF5Wd1Sh/TDmGbd4rAzN9Bfta6S7XddVwzp7tRO+M91cI32s62A7kS7x5Cv2qb
         qKQVpOSMyLjDQCTTso9Y9HTLuxEYmncpnLHjoYcq2OeM8R4FIS3mh32x42dkTmaqLX
         XMyW7ecCY/BVqycfSl6Uz4+W/72hNSWbl9DKLLvZ9ENhHYBFF5mNMomtcidOVsu65d
         mEoHNj3hSynQuyFZqRxPItcaC0yttMLYbsmsyeC/k9Cb+ow13BnKtiON5Bdzy3Ob2i
         /HkVEW2AJrb+rLd90BDW4Mc4XbOfpCMTUPZCF+DZA/xgSUorp7b9/W0LG5sQUGcwOG
         +jujIQWlABn6g==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 07/10] iio: adc: ti-ads1015: Add static assert to test if shifted realbits fit into storagebits
Date:   Sun, 20 Mar 2022 19:14:25 +0100
Message-Id: <20220320181428.168109-7-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320181428.168109-1-marex@denx.de>
References: <20220320181428.168109-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add compile-time static_assert wrapper to verify that shifted realbits
fit into storagebits. The macro is implemented in a more generic way so
it can be used to verify other values if required.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V2: New patch
V3: No change
---
 drivers/iio/adc/ti-ads1015.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 51ab8bb3d9f1d..73d848804a12d 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -135,6 +135,28 @@ static const struct iio_event_spec ads1015_events[] = {
 	},
 };
 
+/*
+ * Compile-time check whether _fitbits can accommodate up to _testbits
+ * bits. Returns _fitbits on success, fails to compile otherwise.
+ *
+ * The test works such that it multiplies constant _fitbits by constant
+ * double-negation of size of a non-empty structure, i.e. it multiplies
+ * constant _fitbits by constant 1 in each successful compilation case.
+ * The non-empty structure may contain C11 _Static_assert(), make use of
+ * this and place the kernel variant of static assert in there, so that
+ * it performs the compile-time check for _testbits <= _fitbits. Note
+ * that it is not possible to directly use static_assert in compound
+ * statements, hence this convoluted construct.
+ */
+#define FIT_CHECK(_testbits, _fitbits)					\
+	(								\
+		(_fitbits) *						\
+		!!sizeof(struct {					\
+			static_assert((_testbits) <= (_fitbits));	\
+			int pad;					\
+		})							\
+	)
+
 #define ADS1015_V_CHAN(_chan, _addr, _realbits, _shift, _event_spec, _num_event_specs) { \
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
@@ -147,7 +169,7 @@ static const struct iio_event_spec ads1015_events[] = {
 	.scan_type = {						\
 		.sign = 's',					\
 		.realbits = (_realbits),			\
-		.storagebits = 16,				\
+		.storagebits = FIT_CHECK((_realbits) + (_shift), 16),	\
 		.shift = (_shift),				\
 		.endianness = IIO_CPU,				\
 	},							\
@@ -170,7 +192,7 @@ static const struct iio_event_spec ads1015_events[] = {
 	.scan_type = {						\
 		.sign = 's',					\
 		.realbits = (_realbits),			\
-		.storagebits = 16,				\
+		.storagebits = FIT_CHECK((_realbits) + (_shift), 16),	\
 		.shift = (_shift),				\
 		.endianness = IIO_CPU,				\
 	},							\
-- 
2.35.1

