Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002474F6900
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbiDFSNd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 14:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiDFSNL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 14:13:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26377163E10
        for <linux-iio@vger.kernel.org>; Wed,  6 Apr 2022 09:50:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x16so2960075pfa.10
        for <linux-iio@vger.kernel.org>; Wed, 06 Apr 2022 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILuDkANZMc0VPh49kP2rw7U3VdF/Cux1eFEmm5f7NZo=;
        b=RTymHclKzIwHxBbRZ3wjjyu/OJ9qr7wvbTGDhnbypS8SWUZvJJFvNTGyGiNvOhN0nM
         rZVPhXodK2X4vptC/yYH34d8o98cQULNBssFx7FTG8JnABkGwvme9EtG3sLURxTA8rjP
         mRFvLUnck7JUPOwO1NoGXduZzQKFSPpjIlmAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILuDkANZMc0VPh49kP2rw7U3VdF/Cux1eFEmm5f7NZo=;
        b=Z58qpwSEJgRUYOiWLlVzfbsxTMDpvaeb3HVgG7pnbnWzBOqmg7EQLQUIpRaMJsvpsO
         I8LMBKSxh9K3O2DYxIhqYq74ikqPUqoNnYblkb+mmohZ8mpJQS0RQe0h3H92QD0kuHlz
         rVObXZmX2DGa63iLzaK9NyNATVSwHssNWFAmsT1JeNbYVpXpKMihWM58cdfPGyDUu/Fn
         B/7L1ePn1I55WdTpxS9BY0CB4xTkk3p4pDuv3ttLT3kMNPucvs0i185u2OGrp5HwGBEC
         q02ZiGy4RVq/29d4Z16iCfPbdc8lsEet0iqqzJImvoeUzkm2NE5tMiJTh4X+F1K0RTDk
         HoKQ==
X-Gm-Message-State: AOAM533ba0LcBVWdOb7+URtpO0+FBV21CTP1uE+lQVIWs/FHKBSqGpoW
        4Rnz3wuA628bHJ19F5vy50JsOQ==
X-Google-Smtp-Source: ABdhPJwMZXpSA5PcA7qhIlkx+9PQeQZdwuNPyEa5GqVR1r+P0B4s01HoM9Lc5sqHEizqRt3kP0pj1w==
X-Received: by 2002:a05:6a00:1a12:b0:4fd:a5b4:b4c0 with SMTP id g18-20020a056a001a1200b004fda5b4b4c0mr9663702pfv.16.1649263838627;
        Wed, 06 Apr 2022 09:50:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c9d3:469f:91e4:c022])
        by smtp.gmail.com with UTF8SMTPSA id h13-20020a056a00230d00b004f427ffd485sm22025915pfh.143.2022.04.06.09.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 09:50:38 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 6/8] iio: sx9324: Add Setting for internal compensation resistor
Date:   Wed,  6 Apr 2022 09:50:09 -0700
Message-Id: <20220406165011.10202-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220406165011.10202-1-gwendal@chromium.org>
References: <20220406165011.10202-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Based on device tree setting, set the internal compensation resistor.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v3:
- Use match_string() to prevent incorrect matching.

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/iio/proximity/sx9324.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 691700de0b9d4..2dcfac09644bd 100644
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
2.35.1.1094.g7c7d902a7c-goog

