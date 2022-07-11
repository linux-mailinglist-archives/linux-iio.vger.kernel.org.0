Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8117655E96A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348085AbiF1PPN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348073AbiF1PO4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 11:14:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8510B2F655;
        Tue, 28 Jun 2022 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429294; x=1687965294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pVUU3Lll8q0yc83LnCezFHBisGwIbc3sXpOah2Aea/Q=;
  b=QizY9tVnchRL+jCODboAwZATCrcduiOjYcVaSZRG5yzSe8BSU85n6yO7
   pHI0Y2zSZ6aoAc0PCe/GzU+SRsfHGQBeScs3EH2RJguW3EdrKM5GCSTAU
   mC4KOQRgTSIkYxa2D+NlVdD48S4eeFQGjFVRj0WrX2hNXdi7Bk0IzbApG
   NqvHYNhGdH1Npqo1XmyQDUDJJesb9g4dLeEImUwdm/+buWTaiKzGsUu/G
   7VW13QOjW9j45saqVejVvjeUvMdKK5okDY954H9yZzVOL8G900lw6URNQ
   0oJ+S9v+kt14CDzB0FO4wZQ3P3sdcwcR11Jo1cKd4e4xj0HuAS5yg2J0K
   A==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="162420969"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:14:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:14:50 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:14:47 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 11/19] iio: adc: at91-sama5d2_adc: add 64 and 256 oversampling ratio
Date:   Tue, 28 Jun 2022 18:16:23 +0300
Message-ID: <20220628151631.3116454-12-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add 64 and 256 oversampling ratio support. It is necessary for temperature
sensor.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 31 +++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index f12f46708f22..254c084f7198 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -142,6 +142,8 @@ struct at91_adc_reg_layout {
 #define AT91_SAMA5D2_EMR_OSR_1SAMPLES		0
 #define AT91_SAMA5D2_EMR_OSR_4SAMPLES		1
 #define AT91_SAMA5D2_EMR_OSR_16SAMPLES		2
+#define AT91_SAMA5D2_EMR_OSR_64SAMPLES		3
+#define AT91_SAMA5D2_EMR_OSR_256SAMPLES		4
 
 /* Extended Mode Register - Averaging on single trigger event */
 #define AT91_SAMA5D2_EMR_ASTE(V)		((V) << 20)
@@ -421,7 +423,7 @@ struct at91_adc_platform {
 	unsigned int				max_index;
 	unsigned int				hw_trig_cnt;
 	unsigned int				osr_mask;
-	unsigned int				oversampling_avail[3];
+	unsigned int				oversampling_avail[5];
 	unsigned int				oversampling_avail_no;
 	unsigned int				chan_realbits;
 };
@@ -642,8 +644,8 @@ static const struct at91_adc_platform sama7g5_platform = {
 #define AT91_SAMA7G5_HW_TRIG_CNT	3
 	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
 	.osr_mask = GENMASK(18, 16),
-	.oversampling_avail = { 1, 4, 16, },
-	.oversampling_avail_no = 3,
+	.oversampling_avail = { 1, 4, 16, 64, 256, },
+	.oversampling_avail_no = 5,
 	.chan_realbits = 16,
 };
 
@@ -749,6 +751,15 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 	/* configure the extended mode register */
 	unsigned int emr = at91_adc_readl(st, EMR);
 	unsigned int osr_mask = st->soc_info.platform->osr_mask;
+	int i;
+
+	/* Check against supported oversampling values. */
+	for (i = 0; i < st->soc_info.platform->oversampling_avail_no; i++) {
+		if (oversampling_ratio == st->soc_info.platform->oversampling_avail[i])
+			break;
+	}
+	if (i == st->soc_info.platform->oversampling_avail_no)
+		return -EINVAL;
 
 	/* select oversampling per single trigger event */
 	emr |= AT91_SAMA5D2_EMR_ASTE(1);
@@ -770,8 +781,14 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
 					    osr_mask);
 		break;
-	default:
-		return -EINVAL;
+	case 64:
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_64SAMPLES,
+					    osr_mask);
+		break;
+	case 256:
+		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_256SAMPLES,
+					    osr_mask);
+		break;
 	}
 
 	at91_adc_writel(st, EMR, emr);
@@ -789,6 +806,10 @@ static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
 		nbits = 13;
 	else if (st->oversampling_ratio == 16)
 		nbits = 14;
+	else if (st->oversampling_ratio == 64)
+		nbits = 15;
+	else if (st->oversampling_ratio == 256)
+		nbits = 16;
 
 	/*
 	 * We have nbits of real data and channel is registered as
-- 
2.34.1

