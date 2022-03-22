Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1BD4E38E6
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 07:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiCVG1P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbiCVG0t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 02:26:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BCA3B29C
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w8so14615639pll.10
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoxMhq+bC/cTSPLUvKT6PG4EeSJOwiuaNwjOtxm2JDw=;
        b=h4m/5pCBipNoMzaqO+2K6vD+wlf35d28atsfAgGm1b1DSBrGBDsIL7ZcJlFcB76fVr
         8+JY0JJGBIVGsPhb6UYHFwPZE0Yium1BmYuPRfC0CgOu1ACMHSVgXbbd5L6bM7q0KVnP
         detw4g3d6FNwj96rv2rhycQjxhCC9cl6pHx3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoxMhq+bC/cTSPLUvKT6PG4EeSJOwiuaNwjOtxm2JDw=;
        b=8Q2vaoF93cpOMVTRIKjnWQ1FKkFT6PsSIhIhtoMIPcC1eC9TWEUgnOIGgH92fXOsIW
         rnoCg90wjxYPpApe2S9M5Tr1aWhN/yWGHO8WpNN7G5N0vWW7etX5oXa8OkiEMBSFAsOM
         sVM9XSgr7Jr3U4Z6vDmSKEaXW0V44wN3luR62aCSSPKsqjsTA7ekHZTbANyBUb+BxIpU
         UlTCNy4a3iPl4l+RSI70spP3kG1StBkJIM/n5+HtlU6uYmEzTFzq3GajObm7w0zy/tr5
         oYvCJ90/9PH1TEX5iy0hRg1PT0FFNTjZkIYiu49ohbB1jczD9HCNYBVi+4VmIlTiJRHF
         TYYg==
X-Gm-Message-State: AOAM533SajsOjqqTG0kuF95fQ7oGWEML0PWGhCx+FE6T5TLOn4Gj0cZN
        3Lkj5IdweSvi3Kki94wR+YadOQ==
X-Google-Smtp-Source: ABdhPJyv4KqbGWWuHAIJWsw3DOAKs2f64SL8EMpeP1dI4mYX9Bv/6VEof5aAX0Dfwhf6NQkyQoUQcQ==
X-Received: by 2002:a17:90b:4c8e:b0:1c6:d1ed:f6b2 with SMTP id my14-20020a17090b4c8e00b001c6d1edf6b2mr3154838pjb.166.1647930315838;
        Mon, 21 Mar 2022 23:25:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c016:a147:e7e:6836])
        by smtp.gmail.com with UTF8SMTPSA id h6-20020a636c06000000b00363a2533b17sm16292929pgc.8.2022.03.21.23.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:25:15 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 6/8] iio: sx9324: Add Setting for internal compensation resistor
Date:   Mon, 21 Mar 2022 23:25:02 -0700
Message-Id: <20220322062504.1019504-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220322062504.1019504-1-gwendal@chromium.org>
References: <20220322062504.1019504-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Based on device tree setting, set the internal compensation resistor.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- No changes.

 drivers/iio/proximity/sx9324.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 95de5d9f8eacb..31179e1925624 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -52,6 +52,11 @@
 #define SX9324_REG_CLK_SPRD		0x15
 
 #define SX9324_REG_AFE_CTRL0		0x20
+#define SX9324_REG_AFE_CTRL0_RINT_MASK GENMASK(7, 6)
+#define SX9324_REG_AFE_CTRL0_RINT_LOWEST	0x00
+#define SX9324_REG_AFE_CTRL0_RINT_LOW		0x40
+#define SX9324_REG_AFE_CTRL0_RINT_HIGH		0x80
+#define SX9324_REG_AFE_CTRL0_RINT_HIGHEST	0xc0
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
@@ -855,6 +860,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	char prop[] = SX9324_PROXRAW_DEF;
 	u32 start = 0, raw = 0, pos = 0;
 	int ret, count, ph, pin;
+	const char *res;
 
 	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
 	switch (reg_def->reg) {
@@ -875,6 +881,22 @@ sx9324_get_default_reg(struct device *dev, int idx,
 			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
 		reg_def->def = raw;
 		break;
+	case SX9324_REG_AFE_CTRL0:
+		ret = device_property_read_string(dev,
+				"semtech,int-comp-resistor", &res);
+		if (ret)
+			break;
+		reg_def->def &= ~SX9324_REG_AFE_CTRL0_RINT_MASK;
+		if (!strcmp(res, "lowest"))
+			reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_LOWEST;
+		else if (!strcmp(res, "low"))
+			reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_LOW;
+		else if (!strcmp(res, "high"))
+			reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_HIGH;
+		else if (!strcmp(res, "highest"))
+			reg_def->def |= SX9324_REG_AFE_CTRL0_RINT_HIGHEST;
+
+		break;
 	case SX9324_REG_AFE_CTRL4:
 	case SX9324_REG_AFE_CTRL7:
 		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
-- 
2.35.1.894.gb6a874cedc-goog

