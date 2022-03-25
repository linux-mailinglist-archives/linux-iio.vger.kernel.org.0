Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBE4E7B84
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiCYWKP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 18:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiCYWKO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 18:10:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B10166671
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u22so7591884pfg.6
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l98A4PNT9yRJjDO0lTIQbjMRwoPNVoAjqrcGwahNQ0U=;
        b=m0aqV6+DxvfENOsDf/vAN7uTs2V26xAaCIqes8qJ3+fyPF+/pw469P5ueBSSiBgX7n
         uXWkqXbSPZUDxSj83/F8nPRCMBNorjfRwN+2502PSgNj1WSz1IdnUusNiAgzCOq8QXGr
         L1zuwO8j8nY+a7OOpwPIup949JNFdvsxrDtCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l98A4PNT9yRJjDO0lTIQbjMRwoPNVoAjqrcGwahNQ0U=;
        b=yNG7dy4Zit1T4JXr8Pd//b89QTVJ4DFWGrC7VzrOT6tWn9CBQj0vXUlBHnbVjvXhyb
         POstZZD19jI1ilPiBbSULfcjRUPGmFzpm07XqdcGQb4spEhe6Cgp5F20LDdlDl4MTiqf
         3zevrGqUuwYq41w+sZHoIZdjObJmUjFdP/39l6NmoM/VP8MLUOaAzXiPVbo4IQcPv9Tq
         EIJJS4Gk2pavCKt7401UBCszVLuHz6a+RS16Ocw1PeSBdZnhgTcpkfUE9rU82Xdg5P4h
         84MgQwnuDkBqx2Yn3qiWhBquFLztRS+TPfKbMsuiqFZxdMRsuRXjK7rQCivmiI1Lv0j2
         nAZA==
X-Gm-Message-State: AOAM530490p+NCmRODuwrNGntoTzbAmTiNJbLcXJYRBHmnLtu6Rw9weY
        yB3Z8StyJOurNMccZQiO7YQbdA==
X-Google-Smtp-Source: ABdhPJxKy1JgbsWnuseG13j2sQc5BR7i0UafZcVClms+W9xzwnhjmKakpMxa3fUFfmjPxguX6E/QTA==
X-Received: by 2002:aa7:81c1:0:b0:4f7:6ba1:553b with SMTP id c1-20020aa781c1000000b004f76ba1553bmr12357364pfn.45.1648246119245;
        Fri, 25 Mar 2022 15:08:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f21c:980b:7d64:94f9])
        by smtp.gmail.com with UTF8SMTPSA id k17-20020a056a00135100b004fa9df39517sm8342482pfu.198.2022.03.25.15.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 15:08:38 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 6/8] iio: sx9324: Add Setting for internal compensation resistor
Date:   Fri, 25 Mar 2022 15:08:25 -0700
Message-Id: <20220325220827.3719273-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220325220827.3719273-1-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/iio/proximity/sx9324.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 3f229dffd5380..38dfdc6dc86ad 100644
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
2.35.1.1021.g381101b075-goog

