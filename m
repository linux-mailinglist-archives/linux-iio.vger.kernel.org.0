Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EA54E38EC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 07:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiCVG1Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 02:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiCVG0t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 02:26:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A685A2A273
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n15so14652759plh.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hikheyI0Nl+ipWdnweJSWsnrclofhtF+n/fKkrLyMFM=;
        b=TiV4uSre9LReQAaZ+o4zK4NCDqoZW5AC2CT8gkv5kcowRPQEHh7aKIgcH4ieFGaGq/
         gom/Q6cZtLtMsReWwqW50lLGTQ6OMfNVyeiQLsvqcI4H0VfarxNnxYAr3n6iSaDm2Dxt
         pEB9Mxm/CM+cqPDdJwuy3X71ULNP/N+K6izJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hikheyI0Nl+ipWdnweJSWsnrclofhtF+n/fKkrLyMFM=;
        b=qptjoiTTpoXJM9pzxPP6bl5ae2gmWlzz7COsIdLKO63Y0CuddabS9aEVVcB5VPUH9n
         ZSOdXQ7NkuItcjCP1HQfkkQgs7HZcAw14jK58xP1IofWrNmAvWfzdYC/FOnD16lMtF2W
         vTG8mMt4mnIWH40Q5cfcrIGa8ITpTSGNfD3Uz8HL8wBTM0yKQCwUNqmwFlP91G7qOXT/
         k4pvin/219C+2m2BmoFcctJyswAql+VrkYApFRwX4YNf9xodg2OlDuWsWbV+LnTXm4EO
         vS8TOuPUf/dlyaVP6GN077Bw7aOmpiA0Gd3NWJETiDGx3tIUQowzyK4J60ILhgY8esCG
         gpqw==
X-Gm-Message-State: AOAM532MxtHLM8UjjFelmUIThx0lJbLDH5VMozt404t9fxC+o2tROnpD
        APQ/eW79EEchKjK6mzljWwIppw==
X-Google-Smtp-Source: ABdhPJyK8P6TrbFnJDLZ0h/km0s1P+Qjz2PJ6CEy3m8HmmLxwFjE5QXjHV8mETAYZD1l9Zk/FDLHqQ==
X-Received: by 2002:a17:903:41cf:b0:154:25bf:7d0f with SMTP id u15-20020a17090341cf00b0015425bf7d0fmr16150921ple.41.1647930318211;
        Mon, 21 Mar 2022 23:25:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c016:a147:e7e:6836])
        by smtp.gmail.com with UTF8SMTPSA id g5-20020a056a001a0500b004def10341e5sm22139411pfv.22.2022.03.21.23.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:25:17 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 8/8] iio: sx9360: Add pre-charge resistor setting
Date:   Mon, 21 Mar 2022 23:25:04 -0700
Message-Id: <20220322062504.1019504-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220322062504.1019504-1-gwendal@chromium.org>
References: <20220322062504.1019504-1-gwendal@chromium.org>
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

Add ability to set the precharge internal resistance from the device
tree.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- Suffix field with kOhms unit.

 drivers/iio/proximity/sx9360.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 3ebb30c8a4f61..a70d2ad808f1a 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -51,6 +51,8 @@
 #define SX9360_REG_GNRL_REG_2_FREQ(_r)  (SX9360_FOSC_HZ / ((_r) * 8192))
 
 #define SX9360_REG_AFE_CTRL1		0x21
+#define SX9360_REG_AFE_CTRL1_RESFILTIN_MASK GENMASK(3, 0)
+#define SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS 0
 #define SX9360_REG_AFE_PARAM0_PHR	0x22
 #define SX9360_REG_AFE_PARAM1_PHR	0x23
 #define SX9360_REG_AFE_PARAM0_PHM	0x24
@@ -671,7 +673,7 @@ static const struct sx_common_reg_default sx9360_default_regs[] = {
 	{ SX9360_REG_GNRL_CTRL1, 0x00 },
 	{ SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS },
 
-	{ SX9360_REG_AFE_CTRL1, 0x00 },
+	{ SX9360_REG_AFE_CTRL1, SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS },
 	{ SX9360_REG_AFE_PARAM0_PHR, SX9360_REG_AFE_PARAM0_RSVD |
 		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
 	{ SX9360_REG_AFE_PARAM1_PHR, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
@@ -722,6 +724,14 @@ sx9360_get_default_reg(struct device *dev, int idx,
 
 	memcpy(reg_def, &sx9360_default_regs[idx], sizeof(*reg_def));
 	switch (reg_def->reg) {
+	case SX9360_REG_AFE_CTRL1:
+		ret = device_property_read_u32(dev,
+				"semtech,input-precharge-resistor-kohms",
+				&raw);
+		reg_def->def &= ~SX9360_REG_AFE_CTRL1_RESFILTIN_MASK;
+		reg_def->def |= FIELD_PREP(SX9360_REG_AFE_CTRL1_RESFILTIN_MASK,
+					   raw / 2);
+		break;
 	case SX9360_REG_AFE_PARAM0_PHR:
 	case SX9360_REG_AFE_PARAM0_PHM:
 		ret = device_property_read_u32(dev, "semtech,resolution", &raw);
-- 
2.35.1.894.gb6a874cedc-goog

