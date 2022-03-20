Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646B44E1D59
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbiCTSQV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 14:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343496AbiCTSQU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 14:16:20 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7771A527FB
        for <linux-iio@vger.kernel.org>; Sun, 20 Mar 2022 11:14:57 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 233DC839C6;
        Sun, 20 Mar 2022 19:14:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647800095;
        bh=74L4yalKFirXowf2EjwALmZcDGdB8U1TbRww68ff9OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAlT4BkQAx1HpWLq1AEiT/ixoNzDtu2wMKCpsy/nghL/y8/0lRQFv9cPxyDTa/RuF
         aJH3P/jNaiTFGaHNb8qlCXVqXWN7gSPlzhOyyFiGKkQssSk/AyPjWpoM24LcMPJBO6
         wUY4StGJDk4RUaqD5cSE0iocLsYgoUtD3nWJms1kSMdD/aM1BnoZ5ZG+ow2E2sw09g
         Zj/NakrMVbDnjXcb2aKJVocEqJc9n7LvVnMxAmUySL9NedPP+Jqd5I06AJ3ttrOtgn
         VuiuHhCAiJWpfpiYRuyZOsA07vWCQLb1Nx3VqFcVu04GaykWfJYih870zhviWt0aGA
         Kw0Qir0vw2HKQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 04/10] iio: adc: ti-ads1015: Deduplicate channel macros
Date:   Sun, 20 Mar 2022 19:14:22 +0100
Message-Id: <20220320181428.168109-4-marex@denx.de>
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

These macros differ only in the number of valid bits of each ADC sample
and the shift of those bits, i.e. ADS1015 is 12bit ADC shifted by 4 left,
ADS1115 is 16bit ADC shifted by 0. No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V2: No change
V3: No change
---
 drivers/iio/adc/ti-ads1015.c | 86 +++++++++---------------------------
 1 file changed, 22 insertions(+), 64 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 85932b9dc166a..fc3381ff34710 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -134,7 +134,7 @@ static const struct iio_event_spec ads1015_events[] = {
 	},
 };
 
-#define ADS1015_V_CHAN(_chan, _addr) {				\
+#define ADS1015_V_CHAN(_chan, _addr, _realbits, _shift) {	\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
 	.address = _addr,					\
@@ -145,9 +145,9 @@ static const struct iio_event_spec ads1015_events[] = {
 	.scan_index = _addr,					\
 	.scan_type = {						\
 		.sign = 's',					\
-		.realbits = 12,					\
+		.realbits = (_realbits),			\
 		.storagebits = 16,				\
-		.shift = 4,					\
+		.shift = (_shift),				\
 		.endianness = IIO_CPU,				\
 	},							\
 	.event_spec = ads1015_events,				\
@@ -155,7 +155,7 @@ static const struct iio_event_spec ads1015_events[] = {
 	.datasheet_name = "AIN"#_chan,				\
 }
 
-#define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr) {		\
+#define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr, _realbits, _shift) { \
 	.type = IIO_VOLTAGE,					\
 	.differential = 1,					\
 	.indexed = 1,						\
@@ -168,51 +168,9 @@ static const struct iio_event_spec ads1015_events[] = {
 	.scan_index = _addr,					\
 	.scan_type = {						\
 		.sign = 's',					\
-		.realbits = 12,					\
-		.storagebits = 16,				\
-		.shift = 4,					\
-		.endianness = IIO_CPU,				\
-	},							\
-	.event_spec = ads1015_events,				\
-	.num_event_specs = ARRAY_SIZE(ads1015_events),		\
-	.datasheet_name = "AIN"#_chan"-AIN"#_chan2,		\
-}
-
-#define ADS1115_V_CHAN(_chan, _addr) {				\
-	.type = IIO_VOLTAGE,					\
-	.indexed = 1,						\
-	.address = _addr,					\
-	.channel = _chan,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
-				BIT(IIO_CHAN_INFO_SCALE) |	\
-				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
-	.scan_index = _addr,					\
-	.scan_type = {						\
-		.sign = 's',					\
-		.realbits = 16,					\
-		.storagebits = 16,				\
-		.endianness = IIO_CPU,				\
-	},							\
-	.event_spec = ads1015_events,				\
-	.num_event_specs = ARRAY_SIZE(ads1015_events),		\
-	.datasheet_name = "AIN"#_chan,				\
-}
-
-#define ADS1115_V_DIFF_CHAN(_chan, _chan2, _addr) {		\
-	.type = IIO_VOLTAGE,					\
-	.differential = 1,					\
-	.indexed = 1,						\
-	.address = _addr,					\
-	.channel = _chan,					\
-	.channel2 = _chan2,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
-				BIT(IIO_CHAN_INFO_SCALE) |	\
-				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
-	.scan_index = _addr,					\
-	.scan_type = {						\
-		.sign = 's',					\
-		.realbits = 16,					\
+		.realbits = (_realbits),			\
 		.storagebits = 16,				\
+		.shift = (_shift),				\
 		.endianness = IIO_CPU,				\
 	},							\
 	.event_spec = ads1015_events,				\
@@ -290,26 +248,26 @@ static const struct regmap_config ads1015_regmap_config = {
 };
 
 static const struct iio_chan_spec ads1015_channels[] = {
-	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1),
-	ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3),
-	ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3),
-	ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3),
-	ADS1015_V_CHAN(0, ADS1015_AIN0),
-	ADS1015_V_CHAN(1, ADS1015_AIN1),
-	ADS1015_V_CHAN(2, ADS1015_AIN2),
-	ADS1015_V_CHAN(3, ADS1015_AIN3),
+	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1, 12, 4),
+	ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3, 12, 4),
+	ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3, 12, 4),
+	ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3, 12, 4),
+	ADS1015_V_CHAN(0, ADS1015_AIN0, 12, 4),
+	ADS1015_V_CHAN(1, ADS1015_AIN1, 12, 4),
+	ADS1015_V_CHAN(2, ADS1015_AIN2, 12, 4),
+	ADS1015_V_CHAN(3, ADS1015_AIN3, 12, 4),
 	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
 };
 
 static const struct iio_chan_spec ads1115_channels[] = {
-	ADS1115_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1),
-	ADS1115_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3),
-	ADS1115_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3),
-	ADS1115_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3),
-	ADS1115_V_CHAN(0, ADS1015_AIN0),
-	ADS1115_V_CHAN(1, ADS1015_AIN1),
-	ADS1115_V_CHAN(2, ADS1015_AIN2),
-	ADS1115_V_CHAN(3, ADS1015_AIN3),
+	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1, 16, 0),
+	ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3, 16, 0),
+	ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3, 16, 0),
+	ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3, 16, 0),
+	ADS1015_V_CHAN(0, ADS1015_AIN0, 16, 0),
+	ADS1015_V_CHAN(1, ADS1015_AIN1, 16, 0),
+	ADS1015_V_CHAN(2, ADS1015_AIN2, 16, 0),
+	ADS1015_V_CHAN(3, ADS1015_AIN3, 16, 0),
 	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
 };
 
-- 
2.35.1

