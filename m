Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3987D3E37DC
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 03:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhHHB5w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 21:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhHHB5v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 21:57:51 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384EC0613CF;
        Sat,  7 Aug 2021 18:57:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a19so14484005qkg.2;
        Sat, 07 Aug 2021 18:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdv3BVYPa7slvr9DFE6GbAJc4qpzj6EiXQtId6AIGvo=;
        b=jynE6zjCH8AX7Z26sxDYXAAOglMipN2NqFPl/XlETswBp08WHZO01KTkWgTA58yXIe
         0wIbrk1Yw5G5/CkFX2dpHmsdieufXSy2ZPsxtwAaYrbgfu8PrhVDpke1O2OA2qhyD8YK
         ltqaJdVZuPW1r9VWqtC5P3//YDtANaWbBnFWm3sTDZnELTbLI5cp/AvBrmn4uVxPFkQ3
         2oIwxDlR2G9+22E4nwQ3fgGCxoeYR2YVj2pFTdUPJTWoxqX0oXIuh0l4DJzrGpWsTTEr
         5c7UVzfOA4oOHzd2T8Bzkozi+HeJGc9Xl+9vhmBuRUBeBEZJECVTmNNR6M2T7EZjIVRb
         4wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdv3BVYPa7slvr9DFE6GbAJc4qpzj6EiXQtId6AIGvo=;
        b=tpU8HJO6xSwsJSRuFat2sqb06PqheVh//meY5KUOKt+a1uHqmObUWqxLJ5f26XePNk
         eK9F5EZCx4T//+PjoAZRCDxuAcjImfXLVbI3n0KKB2lXgfkNdmVXFJrqgHz0TGBBGJqS
         ajZ+/5l8eVMuhEiaOHxk8tk0fH0jlihhtJ+FQYTdw4ZEPVwp2oB3WTg7hIRAwSc9Qjr1
         vuXo2ohDWEChiuJ8xWX12ajv/k+GPuRHdmUb32kyF8jDIsOP/77Msp3jWZAB6iSRIxCv
         mV1i5O4KLdv8lulJGNsVRUuGC54R6nS+0P4BqhHweUomLti01+PFLpNAeI0RK4j8oXAm
         ZAWg==
X-Gm-Message-State: AOAM531Q6NimqvmMdIAHDPC0ym52sFdEN0Gv6Ku42tYfb28BmRyPYoif
        pFULmLouqbsWfrqpqWFXO2c9T29EMhoJFw==
X-Google-Smtp-Source: ABdhPJzSEaAjVtVBbYg4DK0BzEWpvLvBsasnpIFycTI/5tzF7bSP+JFToZwBfOSH+UW0WiGCHBjIBg==
X-Received: by 2002:a37:46d0:: with SMTP id t199mr16675262qka.416.1628387851079;
        Sat, 07 Aug 2021 18:57:31 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id k24sm1569612qki.11.2021.08.07.18.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 18:57:30 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 1/5] iio: adc: ad7949: define and use bitfield names
Date:   Sat,  7 Aug 2021 21:56:55 -0400
Message-Id: <20210808015659.2955443-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210808015659.2955443-1-liambeguin@gmail.com>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 49 ++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 1b4b3203e428..937241ee2a22 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -11,13 +11,39 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/bitfield.h>
 
-#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
 #define AD7949_MASK_TOTAL		GENMASK(13, 0)
-#define AD7949_OFFSET_CHANNEL_SEL	7
-#define AD7949_CFG_READ_BACK		0x1
 #define AD7949_CFG_REG_SIZE_BITS	14
 
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
+
 enum {
 	ID_AD7949 = 0,
 	ID_AD7682,
@@ -109,8 +135,8 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
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
@@ -214,10 +240,19 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
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
2.32.0.452.g940fe202adcb

