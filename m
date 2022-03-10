Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8CB4D3E39
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 01:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiCJAfX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 19:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiCJAfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 19:35:23 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCC86EB26
        for <linux-iio@vger.kernel.org>; Wed,  9 Mar 2022 16:34:23 -0800 (PST)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 66528839B7;
        Thu, 10 Mar 2022 01:34:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1646872461;
        bh=Qg+vselVopqEu463isBvH33kVtb7T6tHbXWopg01o0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0GrQvhXEs+AKyFY0PHfzZt/IK+hQG7ISKzSawgSViqC+Rq4wrCHcTTyBLwWCjA/e+
         S4IM6QVwQiwKZXRM5jisK3spk2b5edU9rcBLCt6ArxZBjFBOgAreVrQG8e1ZK3xlWg
         y3wBe/LL3qx1RTy3EJlnL1NO9jNk6dfe4Yvv0xBa2MpPASxlu/H5pHBYQQxte0PZzT
         Aq8xJ51iY63V49GzGZ6yuCdeSH8CLzSn0ittCDqeTLIc7VatJ+X35KwwLt3kXBeEbq
         B+dQmFEoZyxiyefevD80wcYZc+QWHJCPpGtHWBHdPg7aUwFpfaFYrbFLZmEX1rOFiu
         9FvxV8YsDfO1Q==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/6] iio: adc: ti-ads1015: Make channel event_spec optional
Date:   Thu, 10 Mar 2022 01:34:01 +0100
Message-Id: <20220310003402.490478-5-marex@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310003402.490478-1-marex@denx.de>
References: <20220310003402.490478-1-marex@denx.de>
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.34.1

