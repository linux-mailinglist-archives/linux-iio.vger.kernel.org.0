Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2405A4DA13E
	for <lists+linux-iio@lfdr.de>; Tue, 15 Mar 2022 18:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350610AbiCORcR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Mar 2022 13:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350617AbiCORcQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2022 13:32:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BA158821
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 10:31:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s42so176821pfg.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7eW3HDMN0wbUhfZOlrB/UHkAA/ep0Bnn4nLF7HblS8M=;
        b=gd/vNi2S4GFo7YH2dFUU8s4jr+58VSeq7y2Cak+eXMxUrihBtvhjw2gaG84d4coP6S
         crPJKm3TtrZbUzdIQL0ANKCSUwOmFtKE8yeSoBKV87gPJRPJPU+yCSPNxsRlg2mleQVd
         yaczDBgi19RgBztJ9JWDGSWrFo86VZ88yl3Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7eW3HDMN0wbUhfZOlrB/UHkAA/ep0Bnn4nLF7HblS8M=;
        b=k+cUDGHqbjuBuM8dybCWH3PHGMJR3Wzh/Evtg6x4osBUjxeV1zhKON4vIQ0q0/wI/n
         z9GX+iVfHcBRyNncP1I/4EmY8JCKAfBzby3BX5tPtrNLAl4cp4VyL0SXKF7H4e2dGwUE
         3QWhRS/pMsDepYrUVOmFuBDo9aatC8VQKjjjVrvGN8AbK+WPoG32XvxeIEwRhbXhdJfo
         ATnelAXNjUCXc0Hrp0EXUewv0GSE+RPZFP6hfz/t1r+J5sAu28HcKC6bmDaVh1OIKGNs
         /tt2AlccNOz6mWvE8/WxWHsSQWEf4zW/XWvLYavjP9mJgHhKgkhsaEtDUR04B0/nUskO
         A4pA==
X-Gm-Message-State: AOAM532CblKjQllDGDt3xaAJU2E63RV2ez6Zl12fJuW4x08YuWpRdjwi
        67gaxbEoFAZfTlzzoWDS+d+sVA==
X-Google-Smtp-Source: ABdhPJzKYFoduhCvavj6CKA2LYYj0hWLqrLyCS3zgPGqQ9VgAcFxJAfxA/c5l/ss7BTvTlz3SRIRTg==
X-Received: by 2002:a05:6a00:b50:b0:4f7:9571:a877 with SMTP id p16-20020a056a000b5000b004f79571a877mr21266155pfo.30.1647365460033;
        Tue, 15 Mar 2022 10:31:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:53f9:5c35:428f:83a1])
        by smtp.gmail.com with UTF8SMTPSA id l2-20020a056a0016c200b004f7e3181a41sm8238925pfc.98.2022.03.15.10.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 10:30:59 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 5/7] iio: sx9324: Add Setting for internal compensation resistor
Date:   Tue, 15 Mar 2022 10:30:40 -0700
Message-Id: <20220315173042.1325858-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220315173042.1325858-1-gwendal@chromium.org>
References: <20220315173042.1325858-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/iio/proximity/sx9324.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 785af857b23a1..4a74513d029f5 100644
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
@@ -768,7 +773,7 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
 	 */
 	{ SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL },
 
-	{ SX9324_REG_AFE_CTRL0, 0x00 },
+	{ SX9324_REG_AFE_CTRL0, SX9324_REG_AFE_CTRL0_RINT_LOWEST },
 	{ SX9324_REG_AFE_CTRL3, 0x00 },
 	{ SX9324_REG_AFE_CTRL4, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
 		SX9324_REG_AFE_CTRL4_RES_100 },
@@ -853,6 +858,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	char prop[] = SX9324_PROXRAW_DEF;
 	u32 start = 0, raw = 0, pos = 0;
 	int ret, count, ph, pin;
+	const char *res;
 
 	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
 	switch (reg_def->reg) {
@@ -873,6 +879,22 @@ sx9324_get_default_reg(struct device *dev, int idx,
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
2.35.1.723.g4982287a31-goog

