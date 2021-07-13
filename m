Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98D33C6966
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 06:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhGMEh0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 00:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhGMEhZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 00:37:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874AEC0613DD;
        Mon, 12 Jul 2021 21:34:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g8so3799410qtj.1;
        Mon, 12 Jul 2021 21:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZvGxca2T5yVy2NGNqrtVScB3QVnEfEEyh0E6AQOPKc=;
        b=LitkUp5sZBZo3984BGL89K6YY3jH04iKA+jdWGrtMGPddu9rcLG84ZBpAFf5IsohQI
         QwR+RAXLGStPqtKbYRc016ieWZUkm76RaTSwS8PnjxgxQ6tL52Dj473K2wwp8EhzRnQP
         UgJ+yjWY7p041b+YGo5Nk2jxYpHgfS+EXcGjrRneR4EFhEVewORyzigKzM88jhXQlfTP
         wyKqJpoZxRrxjhBW2xjKxNEdGhG21wozZPwqFjJ3S3WUEdM1rPHO18E/1HANqQLi03j5
         S6RXau//drHwx0UnU/5LG3L0nlUFXBoEuQ1dJvm7aczjCGx/am5WYwMHg7jqp5GW1nvZ
         xI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZvGxca2T5yVy2NGNqrtVScB3QVnEfEEyh0E6AQOPKc=;
        b=QWOMoOw/vpur9VSPZ7PY5Jc9RBp6PkidrN/IMZ91xzhjXndsFlycmEgAUkgrkgGnTm
         hWMau0TJjKSMLOHrpmhvpDXYWzJ2TUfxsh2bclNl8FZ8qRmdhePyYTLTssTVmPACBFDa
         72qYgFnOL/k7rGtTdisQiGxV4XgV8EvQ68anNu25MCw7SmpeS3NIdLCdb0yPbXcEAHD3
         ztFA9Ct0IOGH7zFpWCusMKVBhkslAtAZkfvUKfHDUHXhw9BopdkcpykN1Xz+fBe6VhfL
         OHGHpkN/msEwXgY+PKehbzJPJ2RGBcw95Go6vmbsJXjDc3YaiaVy2Kbnu0tRRHAGVqbX
         6LKQ==
X-Gm-Message-State: AOAM5307r58mteWPB91fz3pNhgfWOLVUMqFqNiPivDiAsfGpCpXo6X94
        HBycVF+2xrV9fOQ+UVZIbB0=
X-Google-Smtp-Source: ABdhPJyu4avkkoJpdjTedxiqxAXTDU1cmd7UZhhPqZitxB2JJIuZesq1g9KEbpNPbLmCfNYBroWv1w==
X-Received: by 2002:ac8:4703:: with SMTP id f3mr2143401qtp.345.1626150875684;
        Mon, 12 Jul 2021 21:34:35 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x16sm7311455qkn.130.2021.07.12.21.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 21:34:35 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 1/4] iio: adc: ad7949: define and use bitfield names
Date:   Tue, 13 Jul 2021 00:34:22 -0400
Message-Id: <20210713043425.3321230-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210713043425.3321230-1-liambeguin@gmail.com>
References: <20210713043425.3321230-1-liambeguin@gmail.com>
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

