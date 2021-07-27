Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE713D83FB
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 01:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhG0X31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 19:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhG0X3Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 19:29:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17620C061760;
        Tue, 27 Jul 2021 16:29:23 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t68so471203qkf.8;
        Tue, 27 Jul 2021 16:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZvGxca2T5yVy2NGNqrtVScB3QVnEfEEyh0E6AQOPKc=;
        b=T4bSUjbJmH2p0gAddGlgvEhJtTNXR2Mea0clf+LifO7K6E9IsyhSggGWlDMliWKbPL
         zsJCbkPquUoc10yXignRvGwtpT11Y9K00F8UeEw6uWTbQgQu5lwUKgqLblEthdLVMVb4
         TanawNWbPhUBHW5jrAC4awpiUqWYcElneL56ZjRWFj9JaF5lr1an/9u0v7GwbrINvHMu
         pHT9QC+Nw5Youio1sLMabINgBbpvmZLG5o6jT0ml1bT6wa5uq3XWoIU/bFkHKt1pG26b
         tgltoTCISuMZDhEQmPcY7Ajc2iMCnm8EiPoNUjUhK9XEhaI7J8jLMji2FzV9QRNDS0S8
         G+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZvGxca2T5yVy2NGNqrtVScB3QVnEfEEyh0E6AQOPKc=;
        b=IvBx43l73y4vIczoi8Nj8Mr0Ccrhjy6pPGk4qaMmpboFD4SLDLy52Ug6d1mqAa/FeO
         wS1WU0Cu3b9++DHbEZvLOe/VbJ1F6LTKfEcLAHH+N8jB8FcRoKkweJJUczhCp6r5Iol6
         d1S/bma/MQJKNx9HRKcGM++Lg6dEdjMtDWfmqeEffcjGMeotcH/aQZFCspP17/NrmRlb
         69qiVl6FIBBdCIR2zvTLJIbnsJ06TsnIa2XLVHtaaTRd3JkCrltZVrcKyDsvJDvnu2x7
         f5HZ5T8FRasELOpbFnYYQnxYPsIpBdnq+tKMGSNhd4TwYgLBuObmnWVV2fiftO3WSvfc
         qHhw==
X-Gm-Message-State: AOAM530oOg7ChIzMa2ds2o7t5HR6RS2iKdKpCnUr7v6g3MMtjtDJQKA2
        qr5hN+DKvPA6+zhpjM4zBc4=
X-Google-Smtp-Source: ABdhPJySfU4EXVnLjVIgS2AmEhizcSCLA1KLOkkpQq34H/w73fwonxyoFsjzX2SrUijd0I6D02NG6Q==
X-Received: by 2002:a37:ef05:: with SMTP id j5mr110877qkk.175.1627428562310;
        Tue, 27 Jul 2021 16:29:22 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p188sm2380514qka.114.2021.07.27.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:29:21 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 1/5] iio: adc: ad7949: define and use bitfield names
Date:   Tue, 27 Jul 2021 19:29:02 -0400
Message-Id: <20210727232906.980769-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210727232906.980769-1-liambeguin@gmail.com>
References: <20210727232906.980769-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Replace raw configuration register values by using FIELD_PREP and
defines to improve readability.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/adc/ad7949.c | 50 +++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 1b4b3203e428..0b549b8bd7a9 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -11,12 +11,37 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/bitfield.h>
 
-#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
 #define AD7949_MASK_TOTAL		GENMASK(13, 0)
-#define AD7949_OFFSET_CHANNEL_SEL	7
-#define AD7949_CFG_READ_BACK		0x1
-#define AD7949_CFG_REG_SIZE_BITS	14
+
+/* CFG: Configuration Update */
+#define AD7949_CFG_BIT_OVERWRITE	BIT(13)
+
+/* INCC: Input Channel Configuration */
+#define AD7949_CFG_BIT_INCC		GENMASK(12, 10)
+#define AD7949_CFG_VAL_INCC_UNIPOLAR_GND	7
+#define AD7949_CFG_VAL_INCC_UNIPOLAR_COMM	6
+#define AD7949_CFG_VAL_INCC_UNIPOLAR_DIFF	4
+#define AD7949_CFG_VAL_INCC_TEMP		3
+#define AD7949_CFG_VAL_INCC_BIPOLAR		2
+#define AD7949_CFG_VAL_INCC_BIPOLAR_DIFF	0
+
+/* INX: Input channel Selection in a binary fashion */
+#define AD7949_CFG_BIT_INX		GENMASK(9, 7)
+
+/* BW: select bandwidth for low-pass filter. Full or Quarter */
+#define AD7949_CFG_BIT_BW_FULL			BIT(6)
+
+/* REF: reference/buffer selection */
+#define AD7949_CFG_BIT_REF		GENMASK(5, 3)
+#define AD7949_CFG_VAL_REF_EXT_BUF		7
+
+/* SEQ: channel sequencer. Allows for scanning channels */
+#define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
+
+/* RB: Read back the CFG register */
+#define AD7949_CFG_BIT_RBN		BIT(0)
 
 enum {
 	ID_AD7949 = 0,
@@ -109,8 +134,8 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	 */
 	for (i = 0; i < 2; i++) {
 		ret = ad7949_spi_write_cfg(ad7949_adc,
-					   channel << AD7949_OFFSET_CHANNEL_SEL,
-					   AD7949_MASK_CHANNEL_SEL);
+					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
+					   AD7949_CFG_BIT_INX);
 		if (ret)
 			return ret;
 		if (channel == ad7949_adc->current_channel)
@@ -214,10 +239,19 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 {
 	int ret;
 	int val;
+	u16 cfg;
 
-	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
 	ad7949_adc->current_channel = 0;
-	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
+
+	cfg = FIELD_PREP(AD7949_CFG_BIT_OVERWRITE, 1) |
+		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
+		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
+		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
+		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
+		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
+		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
+
+	ret = ad7949_spi_write_cfg(ad7949_adc, cfg, AD7949_MASK_TOTAL);
 
 	/*
 	 * Do two dummy conversions to apply the first configuration setting.
-- 
2.30.1.489.g328c10930387

