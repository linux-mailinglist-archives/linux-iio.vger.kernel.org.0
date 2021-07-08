Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460843C1C46
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 01:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhGHX7U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 19:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHX7T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jul 2021 19:59:19 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65F7C061574;
        Thu,  8 Jul 2021 16:56:36 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id v17so3720361qvw.12;
        Thu, 08 Jul 2021 16:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuSZ3BR/evJA/FrHvqoUNYWit2iPKIVeOer6CmCvmrY=;
        b=kgvVZ3XHyeRdx7ESq8UOgMmL7yY9tX/o7CfCMHnUTLCYvWTkxn1Q02sgNlr7rtvR5z
         hZ2FeK2Ztg2HutgSf+wKqp78hKJAdJ3RT/NU0RmxDyRkizSDcpVl3usYkfOotGXjVrcN
         Z2IMCqhG98r2KppWjQljGEyXjQHhLFA3ulmPtEEY0NHLoanom1eDGa9eCob45yEIieEn
         QJdo7ef6mLNBwRYzv5AuLPjdjWbddwfYsOOxDYjSOw19KHgHZPEtN1e3ejTO6zs727BH
         6TtqqBEQtv1fCjcowMJ1qTfSThzRicR7SUEFTMLq6AlEMy7GY+pfMzfPP+bqjF953d3t
         5twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuSZ3BR/evJA/FrHvqoUNYWit2iPKIVeOer6CmCvmrY=;
        b=b1ZOjOpYRE8q64yXFSoOMddPAeYbFDMB90OK3cHf/b9MGDUES6tY41HlP57goLsCN2
         R3+CDQIBAXf0P5hENcPBMNWTZJbg+b/GahTZcgBWcGELuYJvRoBIQONp9n9HGJ+IigwY
         26sT8D7w3XKDNY53yCWhElg9UoKutXbJgAbX9a6oK414JxgX+ru5Va5sSaQY8xCT0R9I
         dpytBOsSzsJpKj2uQntEVedCohxWPUQ/Ue0BzT9iUrbhzn1Bt2Cl3S1V1bDCr/2wkUZF
         /lzZY+tu+JDqj/8NK7/5tflGNhCHSevGtSKbrTnUOuiy8paRtl5T4fjl4B+rivQMKy34
         celg==
X-Gm-Message-State: AOAM533nMQ+UpWJF8PQlePuwSwEK5za2x+t/nmbcy1za0LAatfKW95LR
        H/1t+oTCLLNLELJM077Vx9Y=
X-Google-Smtp-Source: ABdhPJws/Yu/VswnvAMqxJqhnsULKrtezgDhLITFzxcVEWwqVgfRnLgXdoGkrqhdYvgVBJnSMjr1dA==
X-Received: by 2002:a05:6214:207:: with SMTP id i7mr33253371qvt.10.1625788594280;
        Thu, 08 Jul 2021 16:56:34 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id m68sm1733234qkc.109.2021.07.08.16.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 16:56:33 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 1/4] iio: adc: ad7949: define and use bitfield names
Date:   Thu,  8 Jul 2021 19:56:15 -0400
Message-Id: <20210708235618.1541335-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210708235618.1541335-1-liambeguin@gmail.com>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 1b4b3203e428..93aacf4f680b 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -12,12 +12,27 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
-#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
 #define AD7949_MASK_TOTAL		GENMASK(13, 0)
-#define AD7949_OFFSET_CHANNEL_SEL	7
-#define AD7949_CFG_READ_BACK		0x1
 #define AD7949_CFG_REG_SIZE_BITS	14
 
+#define AD7949_CFG_BIT_CFG		BIT(13)
+#define AD7949_CFG_VAL_CFG_OVERWRITE		1
+#define AD7949_CFG_VAL_CFG_KEEP			0
+#define AD7949_CFG_BIT_INCC		GENMASK(12, 10)
+#define AD7949_CFG_VAL_INCC_UNIPOLAR_GND	7
+#define AD7949_CFG_VAL_INCC_UNIPOLAR_COMM	6
+#define AD7949_CFG_VAL_INCC_UNIPOLAR_DIFF	4
+#define AD7949_CFG_VAL_INCC_TEMP		3
+#define AD7949_CFG_VAL_INCC_BIPOLAR		2
+#define AD7949_CFG_VAL_INCC_BIPOLAR_DIFF	0
+#define AD7949_CFG_BIT_INX		GENMASK(9, 7)
+#define AD7949_CFG_BIT_BW		BIT(6)
+#define AD7949_CFG_VAL_BW_FULL			1
+#define AD7949_CFG_VAL_BW_QUARTER		0
+#define AD7949_CFG_BIT_REF		GENMASK(5, 3)
+#define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
+#define AD7949_CFG_BIT_RBN		BIT(0)
+
 enum {
 	ID_AD7949 = 0,
 	ID_AD7682,
@@ -109,8 +124,8 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
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
@@ -214,10 +229,19 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 {
 	int ret;
 	int val;
+	u16 cfg;
 
-	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
 	ad7949_adc->current_channel = 0;
-	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
+
+	cfg = FIELD_PREP(AD7949_CFG_BIT_CFG, AD7949_CFG_VAL_CFG_OVERWRITE) |
+		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
+		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
+		FIELD_PREP(AD7949_CFG_BIT_BW, AD7949_CFG_VAL_BW_FULL) |
+		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_REF_EXT_BUF) |
+		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
+		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
+
+	ret = ad7949_spi_write_cfg(ad7949_adc, cfg, AD7949_MASK_TOTAL);
 
 	/*
 	 * Do two dummy conversions to apply the first configuration setting.
-- 
2.30.1.489.g328c10930387

