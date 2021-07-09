Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0EF3C271F
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhGIQBy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhGIQBx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 12:01:53 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B5DC0613E5;
        Fri,  9 Jul 2021 08:59:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t19so9750983qkg.7;
        Fri, 09 Jul 2021 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuSZ3BR/evJA/FrHvqoUNYWit2iPKIVeOer6CmCvmrY=;
        b=FrMK2AynVnPyRl1+WPObShJxStizYk2TOx77+T/i0Jh+/QKwqQ90BODnMNQveiUc1E
         2k/pTOsSY+4+VYTMjDWstOUb7U9gg2MUnCUPQQE7QzajMU3MKlVBln5U/HRs2OJCCwXw
         E2BvsJCqBkEGdDInV3vtlyX9loVkNrHlLDLiWqyAo5/Rc7epElPYv05dpZs+r7bG92vH
         1G2vD9T4wRURQTDhyx9u+XNOLSo40ky8mIrvwi2+5zuRbzsHcKhfBAnv6gKu1Yzm/idS
         LnQYt2fR4hGnG+EOfBKOb76E77zp8D082fpSu+vX2b0en31aurFuIF+/zMgDQYCAO3OV
         B8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuSZ3BR/evJA/FrHvqoUNYWit2iPKIVeOer6CmCvmrY=;
        b=aD8zRzCddy4anm2YKDl8KLuGKJUyL8ie4ChD6ccG9PXoKentPmjkIHsYfSPPpOiNFb
         xwURL5F1sMJdvHyaOmrxCCr+gSHaZFUNZ4WqlyA48NrCO6YDT+FiK/ie50xdstrlSE36
         nBy6B5GYiP3qX4KwXaotfRg4WVDR3A/J67+VMBMHnTIY5fsmVjqccY9gT5HPyZHg3W+q
         t3ZYnOJVI4Wre987KyEHHLd7anWhxCW/HF1ApQGiQVOhxEtgzvZSddGx2mZ6TwDjl5XN
         /3crqrl3D606pMKDrYHLRcqQix3Y2rOqHgBQz3z3M7SfOhQtMRU7zySEX1z1+DoIxuPs
         yAvQ==
X-Gm-Message-State: AOAM532tWDLWuxy9X6bSZ1794RPld7mFnC/QuwatDn1cVYz0ZnFHSrzk
        wr/T2g1O6iq8hnvCD0l6gW4=
X-Google-Smtp-Source: ABdhPJxCmEzj+H6GCxK8GxNyboNmiXe/w6pwkhRy/rmWS4nm3a6iGg4A/cI7PP/9mFwrTSsU7yH1kQ==
X-Received: by 2002:a37:b983:: with SMTP id j125mr24606125qkf.482.1625846348532;
        Fri, 09 Jul 2021 08:59:08 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x15sm2606071qkm.66.2021.07.09.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 08:59:08 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 1/4] iio: adc: ad7949: define and use bitfield names
Date:   Fri,  9 Jul 2021 11:58:53 -0400
Message-Id: <20210709155856.1732245-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210709155856.1732245-1-liambeguin@gmail.com>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
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

