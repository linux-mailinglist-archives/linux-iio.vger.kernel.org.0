Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CBA4E48D1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 23:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiCVWEF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbiCVWEE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 18:04:04 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBD46F4BB
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 15:02:35 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 11AA583B67;
        Tue, 22 Mar 2022 23:02:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647986553;
        bh=hUMHb2sEIquNdo5dd5RkbrsKKqHVkKIweNJR8I3WEjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOcyRno/UQx/Xh1rZL+7n14EO6Ct78TQwBrek+O0GsOOd1B6YADCyaJDRTL9U4zHF
         QKiAVkRlH73Go2NJi6NMkQDT9vQ7c3w0ijP09ApVMI4lBfabh0w6LkntgR+DH7uYwL
         7YNhbGut4cO1o39WBk6qK/UDebY/BuiB+4KtgS9f11XL6qmYhjB8YEyRFc3AcX/hyB
         ZT5xZBu1NNcJAPVCSXvi8pXHjkKlXDCaW5XzJGy21iYjA6HWUSWtIpMF2M8KBbV7ni
         7DsdWt54BW+ymasNuPLqEMNBKnHSjuXfBZb/vmX/mDpYir7SmRTxyYhRIchkY0icdd
         Tg3PoMxvCoSyw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 07/10] iio: adc: ti-ads1015: Add static assert to test if shifted realbits fit into storagebits
Date:   Tue, 22 Mar 2022 23:02:07 +0100
Message-Id: <20220322220210.207454-7-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322220210.207454-1-marex@denx.de>
References: <20220322220210.207454-1-marex@denx.de>
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
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V2: New patch
V3: No change
V4: No change
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

