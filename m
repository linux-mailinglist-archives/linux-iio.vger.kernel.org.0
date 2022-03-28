Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E580E4EA076
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 21:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbiC1Tvb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345656AbiC1TuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 15:50:04 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCFC19
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 12:47:45 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C700083F84;
        Mon, 28 Mar 2022 21:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648496864;
        bh=FDRhEvSejfdDdAU9jt9jON60Y9IvJkPgAeLL4qVKqZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSuKEEi01XgpCT+R1ezE8iXf5uYksH4lffEG04My/KspoAgb1YHuPek5K5xLkTT0R
         oRnYyW0lmNpx/6FApUOvgFI8Z/3nwxCK1tmDBWh1K+L8kPMe2xGx/O8/kCghx3aErf
         bNhVVzkD+PMPYvH9yMn9otSjcSG8toD56SeAbNZhRZkCqW+KqT+J27dlig3Q3bVcRx
         X5TY0UhELGcre6eGLxP+o5YpJNnDIGEGC2TxMTovfiRI1sS1yDRDuKfHfAMXk6Gp18
         wHCoKzOvace/JJC9xR1Po3tLEnU+MEaE+uig37jQlxsNlyJ6j9p+ravdlVl6dhB7dK
         dxYA9wLCZSCDQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 05/10] iio: adc: ti-ads1015: Make channel event_spec optional
Date:   Mon, 28 Mar 2022 21:47:20 +0200
Message-Id: <20220328194725.149150-5-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328194725.149150-1-marex@denx.de>
References: <20220328194725.149150-1-marex@denx.de>
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

Pass event_spec and num_event_specs to ADS1015_V_CHAN and ADS1015_V_DIFF_CHAN
macros, to make it possible to pass no event_spec at all for chips which have
no comparator and thus no events. No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V2: No change
V3: No change
V4: No change
V5: No change
---
 drivers/iio/adc/ti-ads1015.c | 60 +++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index fc3381ff34710..7d0c0552f425c 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -134,7 +134,7 @@ static const struct iio_event_spec ads1015_events[] = {
 	},
 };
 
-#define ADS1015_V_CHAN(_chan, _addr, _realbits, _shift) {	\
+#define ADS1015_V_CHAN(_chan, _addr, _realbits, _shift, _event_spec, _num_event_specs) { \
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
 	.address = _addr,					\
@@ -150,12 +150,12 @@ static const struct iio_event_spec ads1015_events[] = {
 		.shift = (_shift),				\
 		.endianness = IIO_CPU,				\
 	},							\
-	.event_spec = ads1015_events,				\
-	.num_event_specs = ARRAY_SIZE(ads1015_events),		\
+	.event_spec = (_event_spec),				\
+	.num_event_specs = (_num_event_specs),			\
 	.datasheet_name = "AIN"#_chan,				\
 }
 
-#define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr, _realbits, _shift) { \
+#define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr, _realbits, _shift, _event_spec, _num_event_specs) { \
 	.type = IIO_VOLTAGE,					\
 	.differential = 1,					\
 	.indexed = 1,						\
@@ -173,8 +173,8 @@ static const struct iio_event_spec ads1015_events[] = {
 		.shift = (_shift),				\
 		.endianness = IIO_CPU,				\
 	},							\
-	.event_spec = ads1015_events,				\
-	.num_event_specs = ARRAY_SIZE(ads1015_events),		\
+	.event_spec = (_event_spec),				\
+	.num_event_specs = (_num_event_specs),			\
 	.datasheet_name = "AIN"#_chan"-AIN"#_chan2,		\
 }
 
@@ -248,26 +248,42 @@ static const struct regmap_config ads1015_regmap_config = {
 };
 
 static const struct iio_chan_spec ads1015_channels[] = {
-	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1, 12, 4),
-	ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3, 12, 4),
-	ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3, 12, 4),
-	ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3, 12, 4),
-	ADS1015_V_CHAN(0, ADS1015_AIN0, 12, 4),
-	ADS1015_V_CHAN(1, ADS1015_AIN1, 12, 4),
-	ADS1015_V_CHAN(2, ADS1015_AIN2, 12, 4),
-	ADS1015_V_CHAN(3, ADS1015_AIN3, 12, 4),
+	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1, 12, 4,
+			    ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3, 12, 4,
+			    ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3, 12, 4,
+			    ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3, 12, 4,
+			    ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_CHAN(0, ADS1015_AIN0, 12, 4,
+		       ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_CHAN(1, ADS1015_AIN1, 12, 4,
+		       ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_CHAN(2, ADS1015_AIN2, 12, 4,
+		       ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_CHAN(3, ADS1015_AIN3, 12, 4,
+		       ads1015_events, ARRAY_SIZE(ads1015_events)),
 	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
 };
 
 static const struct iio_chan_spec ads1115_channels[] = {
-	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1, 16, 0),
-	ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3, 16, 0),
-	ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3, 16, 0),
-	ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3, 16, 0),
-	ADS1015_V_CHAN(0, ADS1015_AIN0, 16, 0),
-	ADS1015_V_CHAN(1, ADS1015_AIN1, 16, 0),
-	ADS1015_V_CHAN(2, ADS1015_AIN2, 16, 0),
-	ADS1015_V_CHAN(3, ADS1015_AIN3, 16, 0),
+	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1, 16, 0,
+			    ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3, 16, 0,
+			    ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3, 16, 0,
+			    ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3, 16, 0,
+			    ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_CHAN(0, ADS1015_AIN0, 16, 0,
+		       ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_CHAN(1, ADS1015_AIN1, 16, 0,
+		       ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_CHAN(2, ADS1015_AIN2, 16, 0,
+		       ads1015_events, ARRAY_SIZE(ads1015_events)),
+	ADS1015_V_CHAN(3, ADS1015_AIN3, 16, 0,
+		       ads1015_events, ARRAY_SIZE(ads1015_events)),
 	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
 };
 
-- 
2.35.1

