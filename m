Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC75157AF
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381107AbiD2WFX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379096AbiD2WFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:05:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B4DC59A
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 15so7472250pgf.4
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZy9l9k4uZyTYOvy+bIc4en4lTtDW17uzkL7hL90S0o=;
        b=T9vDpGxGPNhFQtiNbNbEGU59lqujZtyQPOszurG5Mw6LQOA/30P7gr3tzq01SBy1od
         V6aXzZCCaT3QGLPMhhzxeA1/DRZcn0bB+O5sd3+VF5ZoHCFUSPI7cpO5wXSlQzDfCBdb
         WR/cIz3xVi1B7YQaTRrDqso9JdcepLJgWQAm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZy9l9k4uZyTYOvy+bIc4en4lTtDW17uzkL7hL90S0o=;
        b=h3DZbdrahlrOENI+ioJA7rIYw7KUPuCM001sQWgTvqBU8e/f4aev/hIzT9MyLCR6tD
         brFRBuis1emsWop0GXbzr+Y5xSXUOFB9ZFh8wg/6YBpyNPxkBAnq+zAzkqkh04iA9v1M
         6BBWAmOeh+XI9KYmL2lZLtSysFl1QcSZIW9WeENquYkdvf6fVBMf0vSAhRbx6CtcXPpH
         BtV/kj2TuZuLEbdxIGT94DqHnNHmhtrUg6stTNJJkmHaAq4ks2OCxaN+IPBq/Vnkjjyf
         Vd8XwSvkIY+oJTAxk42WPQ31OTh2A7B0o2BP+sXzPlAHrhAzgelBvGpA7Sp3WK/Z3NDD
         hivg==
X-Gm-Message-State: AOAM530V46dv8ARYGsrraB6UjCJYHVdZwQHA9QvRU5djMKlUZ+et9iq1
        soP00iZIdEqBmdC2h/friKzqig==
X-Google-Smtp-Source: ABdhPJxso9uP0uRrBNyXXfIfewY2zuevnr+5FrVTfNrU5RbDLr0oJnsJ2qF6oLgcJom/GEsgW3hVGw==
X-Received: by 2002:aa7:82d9:0:b0:4fa:2c7f:41e with SMTP id f25-20020aa782d9000000b004fa2c7f041emr1265913pfn.1.1651269718236;
        Fri, 29 Apr 2022 15:01:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6161:73ca:10a5:5383])
        by smtp.gmail.com with UTF8SMTPSA id u23-20020a170902a61700b0015e8d4eb2b9sm80881plq.259.2022.04.29.15.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:01:57 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 06/10] iio: sx9324: Add Setting for internal compensation resistor
Date:   Fri, 29 Apr 2022 15:01:40 -0700
Message-Id: <20220429220144.1476049-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220429220144.1476049-1-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Based on device tree setting, set the internal compensation resistor.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since v4:
- No changes.

Changes since v3:
- Use match_string() to prevent incorrect matching.

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/iio/proximity/sx9324.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 8eec73f7641ee..6806262eb1c92 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -52,6 +52,11 @@
 #define SX9324_REG_CLK_SPRD		0x15
 
 #define SX9324_REG_AFE_CTRL0		0x20
+#define SX9324_REG_AFE_CTRL0_RINT_SHIFT		6
+#define SX9324_REG_AFE_CTRL0_RINT_MASK \
+	GENMASK(SX9324_REG_AFE_CTRL0_RINT_SHIFT + 1, \
+		SX9324_REG_AFE_CTRL0_RINT_SHIFT)
+#define SX9324_REG_AFE_CTRL0_RINT_LOWEST	0x00
 #define SX9324_REG_AFE_CTRL1		0x21
 #define SX9324_REG_AFE_CTRL2		0x22
 #define SX9324_REG_AFE_CTRL3		0x23
@@ -769,7 +774,7 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
 	 */
 	{ SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL },
 
-	{ SX9324_REG_AFE_CTRL0, 0x00 },
+	{ SX9324_REG_AFE_CTRL0, SX9324_REG_AFE_CTRL0_RINT_LOWEST },
 	{ SX9324_REG_AFE_CTRL3, 0x00 },
 	{ SX9324_REG_AFE_CTRL4, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
 		SX9324_REG_AFE_CTRL4_RES_100 },
@@ -848,6 +853,8 @@ static const struct sx_common_reg_default *
 sx9324_get_default_reg(struct device *dev, int idx,
 		       struct sx_common_reg_default *reg_def)
 {
+	static const char * const sx9324_rints[] = { "lowest", "low", "high",
+		"highest" };
 #define SX9324_PIN_DEF "semtech,ph0-pin"
 #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
 #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
@@ -855,6 +862,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	char prop[] = SX9324_PROXRAW_DEF;
 	u32 start = 0, raw = 0, pos = 0;
 	int ret, count, ph, pin;
+	const char *res;
 
 	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
 	switch (reg_def->reg) {
@@ -875,6 +883,17 @@ sx9324_get_default_reg(struct device *dev, int idx,
 			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
 		reg_def->def = raw;
 		break;
+	case SX9324_REG_AFE_CTRL0:
+		ret = device_property_read_string(dev,
+				"semtech,int-comp-resistor", &res);
+		if (ret)
+			break;
+		ret = match_string(sx9324_rints, ARRAY_SIZE(sx9324_rints), res);
+		if (ret < 0)
+			break;
+		reg_def->def &= ~SX9324_REG_AFE_CTRL0_RINT_MASK;
+		reg_def->def |= ret << SX9324_REG_AFE_CTRL0_RINT_SHIFT;
+		break;
 	case SX9324_REG_AFE_CTRL4:
 	case SX9324_REG_AFE_CTRL7:
 		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
-- 
2.36.0.464.gb9c8b46e94-goog

