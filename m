Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588263ECB65
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhHOVfM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 17:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhHOVfJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Aug 2021 17:35:09 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D33C0612AC;
        Sun, 15 Aug 2021 14:33:54 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id bu14so5388256qvb.1;
        Sun, 15 Aug 2021 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNzKP8T0fupOu0wKf6skw0WZlOhQs6pY6MrFU3VYV/M=;
        b=SXFy7NyGZNMs1cQmtp2QzI1SJ8JGHXWjjFZANU2X+uKPJzusXudyl3vmeq6WoqjL7r
         89H/7PVORfWLmr5/8gQDjeMavTUSs/JNLI39meOK4hNZRr8yksYZ0keBNsbVwCRaONCl
         9/MHMEXSVZFYh38DZXHYMBKyo4y7mbh30iQVX4/UAGC96xyGyO0F3j2TwjCNKnTgq5m4
         sKOiUKPexekzyQ6WNCpxB3PCaSeO9bgBUHLBrCyMI343PEShdul/o/iQgT3lJyzZccpz
         0GWUI5hvxlQb5ZYriWxQcsdvQk8L2th3cF5K2fzIu9ip7IZk/XspxHYqvVqCSvy5rTIK
         +2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNzKP8T0fupOu0wKf6skw0WZlOhQs6pY6MrFU3VYV/M=;
        b=DtMbVX5hf9hyFClcNK6jiYNY+yPDb5ZwLGkKBl5X4h/8F8/klQ5FypMAfYEaa+/X58
         h5EnJRNi3shcgNoh1l4CAH0VkCtEnCZM3sgJhj7ruYoIq7pmEveV7IF5PVaSW4Sw9bQL
         bLfy2ckE6nshXT3gZqzhHrwxs1qv+TdKZYKoOqAHjjDogsBDoGzgF4OGclL9I3br4F/m
         W5CkaYAUEofM+rkupDfXqxHEjtiA4AQkUm8URJI8Gy9S/7jWdUuPqK5RW/7N3X9Zx5gA
         QDClcWByL8hVMAGdFcJ67mZEbFgAG6QPi3OE3BBfXeiwL9CCE6QNhiqo0SOtmwAMKJRq
         G3PA==
X-Gm-Message-State: AOAM532KXy0ygdZJzl2zQ8GHMJCN63DLw/fit9sSxIzLxRRyKW4QTsgw
        rmGLaRVosijdtj9ND1qaXYg=
X-Google-Smtp-Source: ABdhPJwjHPqdT4jhlFCo3k+di3MdDJjoy53DK20nHgtjXx6Km6aXFMx3j5/eNG92Q8SHDeb/8ptnXQ==
X-Received: by 2002:a05:6214:3b1:: with SMTP id m17mr13322974qvy.60.1629063233409;
        Sun, 15 Aug 2021 14:33:53 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id u19sm3870988qtx.48.2021.08.15.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 14:33:53 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 1/5] iio: adc: ad7949: define and use bitfield names
Date:   Sun, 15 Aug 2021 17:33:05 -0400
Message-Id: <20210815213309.2847711-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210815213309.2847711-1-liambeguin@gmail.com>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 55 ++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 1b4b3203e428..adc4487a7d56 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -11,13 +11,39 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/bitfield.h>
 
-#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
-#define AD7949_MASK_TOTAL		GENMASK(13, 0)
-#define AD7949_OFFSET_CHANNEL_SEL	7
-#define AD7949_CFG_READ_BACK		0x1
+#define AD7949_CFG_MASK_TOTAL		GENMASK(13, 0)
 #define AD7949_CFG_REG_SIZE_BITS	14
 
+/* CFG: Configuration Update */
+#define AD7949_CFG_MASK_OVERWRITE	BIT(13)
+
+/* INCC: Input Channel Configuration */
+#define AD7949_CFG_MASK_INCC		GENMASK(12, 10)
+#define AD7949_CFG_VAL_INCC_UNIPOLAR_GND	7
+#define AD7949_CFG_VAL_INCC_UNIPOLAR_COMM	6
+#define AD7949_CFG_VAL_INCC_UNIPOLAR_DIFF	4
+#define AD7949_CFG_VAL_INCC_TEMP		3
+#define AD7949_CFG_VAL_INCC_BIPOLAR		2
+#define AD7949_CFG_VAL_INCC_BIPOLAR_DIFF	0
+
+/* INX: Input channel Selection in a binary fashion */
+#define AD7949_CFG_MASK_INX		GENMASK(9, 7)
+
+/* BW: select bandwidth for low-pass filter. Full or Quarter */
+#define AD7949_CFG_MASK_BW_FULL		BIT(6)
+
+/* REF: reference/buffer selection */
+#define AD7949_CFG_MASK_REF		GENMASK(5, 3)
+#define AD7949_CFG_VAL_REF_EXT_BUF		7
+
+/* SEQ: channel sequencer. Allows for scanning channels */
+#define AD7949_CFG_MASK_SEQ		GENMASK(2, 1)
+
+/* RB: Read back the CFG register */
+#define AD7949_CFG_MASK_RBN		BIT(0)
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
+					   FIELD_PREP(AD7949_CFG_MASK_INX, channel),
+					   AD7949_CFG_MASK_INX);
 		if (ret)
 			return ret;
 		if (channel == ad7949_adc->current_channel)
@@ -199,8 +225,8 @@ static int ad7949_spi_reg_access(struct iio_dev *indio_dev,
 	if (readval)
 		*readval = ad7949_adc->cfg;
 	else
-		ret = ad7949_spi_write_cfg(ad7949_adc,
-			writeval & AD7949_MASK_TOTAL, AD7949_MASK_TOTAL);
+		ret = ad7949_spi_write_cfg(ad7949_adc, writeval,
+					   AD7949_CFG_MASK_TOTAL);
 
 	return ret;
 }
@@ -214,10 +240,19 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 {
 	int ret;
 	int val;
+	u16 cfg;
 
-	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
 	ad7949_adc->current_channel = 0;
-	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
+
+	cfg = FIELD_PREP(AD7949_CFG_MASK_OVERWRITE, 1) |
+		FIELD_PREP(AD7949_CFG_MASK_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
+		FIELD_PREP(AD7949_CFG_MASK_INX, ad7949_adc->current_channel) |
+		FIELD_PREP(AD7949_CFG_MASK_BW_FULL, 1) |
+		FIELD_PREP(AD7949_CFG_MASK_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
+		FIELD_PREP(AD7949_CFG_MASK_SEQ, 0x0) |
+		FIELD_PREP(AD7949_CFG_MASK_RBN, 1);
+
+	ret = ad7949_spi_write_cfg(ad7949_adc, cfg, AD7949_CFG_MASK_TOTAL);
 
 	/*
 	 * Do two dummy conversions to apply the first configuration setting.
-- 
2.32.0.452.g940fe202adcb

