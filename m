Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAFB3F932A
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 05:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbhH0DtM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 23:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbhH0DtL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Aug 2021 23:49:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B5C061757;
        Thu, 26 Aug 2021 20:48:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e16so4127231pfc.6;
        Thu, 26 Aug 2021 20:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBoYGyBiTNoAvtIS6d3/4JvR5xP0NBcEY2yL+79p2+4=;
        b=IKvI3Xk6wcnJEsbj1ToKZV3yCQZ4JXDWX2afKN88MDwgvUrlFJE02x9JAH+OtTy4Gh
         SpFsM2lUbWTtLwz1ktES0Rh3tickoWHRYf7h9zCLzt2dukiiftidOqKUDdC3c3ivqmwk
         3belztgEeWDqQh6KC5qfSi8BiJTLI2uLcw1SnUWHj8Wnh0CaIYklRAZ5wrBSbBTPIm+P
         LjTDkKdheHTJ2vOpV3s/TvF2FF6kLmLalwI+7QlO+2+0+DGreRExm9jstq4DcI8sweXp
         QJTfef0e/uA0A75g6VQYwgpdX9Dk3BOOQwbRdb0ySJZWw0PTZT1P8QVzFM6lhk2gn0DU
         JaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBoYGyBiTNoAvtIS6d3/4JvR5xP0NBcEY2yL+79p2+4=;
        b=bWyufF8Ww8zuCj9o7b/XY8XwwpxHO/8apU/SjAt3muwRbNJQIe5X2nPkBxJBe5bEEc
         4gII7prxAkjIa4cthAqrFSfcYVXO73Ko6cLTG0Wgob6mcCgdUib7UdVYTV/X02m5aJJl
         StNHmFHiYj/1FFnkkymViXUJoCmg7mD9tOc9zqbLrHLR7S7OIZShg4R5vBObCinVj2mh
         UGrQI/9JruYcYq8iSDMDTowYUKpaUxCMMuwAgbwE7f/PyTLZJl53F/9T18TzA6uAdc21
         x+llUSmAn34b5cCft+l6Jn5pcdrA+Q97+ZtOJn8v6u9YoH6wjoc1d73UPDmjcrKrIa8T
         +E6w==
X-Gm-Message-State: AOAM530vgC7+loi9ww/pef8zISGstDJuSnPWqF1G29UeyGXc2GQ7K1+8
        xFw6vQnycJhMHL0RSJil4gE=
X-Google-Smtp-Source: ABdhPJyQg43G+SVpT+iI0BtVFx1OBxsqKuosP0AlvzVxqk7QBS1SyoH7MVnnN5QuYoLD9O9GQ9EfMQ==
X-Received: by 2002:a05:6a00:a85:b0:3eb:1934:de53 with SMTP id b5-20020a056a000a8500b003eb1934de53mr6862089pfl.71.1630036103419;
        Thu, 26 Aug 2021 20:48:23 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o6sm4364693pjk.4.2021.08.26.20.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:48:23 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v16 02/14] counter: stm32-timer-cnt: Provide defines for slave mode selection
Date:   Fri, 27 Aug 2021 12:47:46 +0900
Message-Id: <ad3d9cd7af580d586316d368f74964cbc394f981.1630031207.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630031207.git.vilhelm.gray@gmail.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The STM32 timer permits configuration of the counter encoder mode via
the slave mode control register (SMCR) slave mode selection (SMS) bits.
This patch provides preprocessor defines for the supported encoder
modes.

Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 16 ++++++++--------
 include/linux/mfd/stm32-timers.h  |  4 ++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 3fb0debd7425..1fbc46f4ee66 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -93,16 +93,16 @@ static int stm32_count_function_get(struct counter_device *counter,
 	regmap_read(priv->regmap, TIM_SMCR, &smcr);
 
 	switch (smcr & TIM_SMCR_SMS) {
-	case 0:
+	case TIM_SMCR_SMS_SLAVE_MODE_DISABLED:
 		*function = STM32_COUNT_SLAVE_MODE_DISABLED;
 		return 0;
-	case 1:
+	case TIM_SMCR_SMS_ENCODER_MODE_1:
 		*function = STM32_COUNT_ENCODER_MODE_1;
 		return 0;
-	case 2:
+	case TIM_SMCR_SMS_ENCODER_MODE_2:
 		*function = STM32_COUNT_ENCODER_MODE_2;
 		return 0;
-	case 3:
+	case TIM_SMCR_SMS_ENCODER_MODE_3:
 		*function = STM32_COUNT_ENCODER_MODE_3;
 		return 0;
 	default:
@@ -119,16 +119,16 @@ static int stm32_count_function_set(struct counter_device *counter,
 
 	switch (function) {
 	case STM32_COUNT_SLAVE_MODE_DISABLED:
-		sms = 0;
+		sms = TIM_SMCR_SMS_SLAVE_MODE_DISABLED;
 		break;
 	case STM32_COUNT_ENCODER_MODE_1:
-		sms = 1;
+		sms = TIM_SMCR_SMS_ENCODER_MODE_1;
 		break;
 	case STM32_COUNT_ENCODER_MODE_2:
-		sms = 2;
+		sms = TIM_SMCR_SMS_ENCODER_MODE_2;
 		break;
 	case STM32_COUNT_ENCODER_MODE_3:
-		sms = 3;
+		sms = TIM_SMCR_SMS_ENCODER_MODE_3;
 		break;
 	default:
 		return -EINVAL;
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index f8db83aedb2b..5f5c43fd69dd 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -82,6 +82,10 @@
 #define MAX_TIM_ICPSC		0x3
 #define TIM_CR2_MMS_SHIFT	4
 #define TIM_CR2_MMS2_SHIFT	20
+#define TIM_SMCR_SMS_SLAVE_MODE_DISABLED	0 /* counts on internal clock when CEN=1 */
+#define TIM_SMCR_SMS_ENCODER_MODE_1		1 /* counts TI1FP1 edges, depending on TI2FP2 level */
+#define TIM_SMCR_SMS_ENCODER_MODE_2		2 /* counts TI2FP2 edges, depending on TI1FP1 level */
+#define TIM_SMCR_SMS_ENCODER_MODE_3		3 /* counts on both TI1FP1 and TI2FP2 edges */
 #define TIM_SMCR_TS_SHIFT	4
 #define TIM_BDTR_BKF_MASK	0xF
 #define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)
-- 
2.32.0

