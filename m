Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654F44E7C90
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiCYWKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 18:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiCYWKR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 18:10:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0AF1667D3
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j13so9598384plj.8
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMMjrrJY3lBiXSG25cQt8v0fu/OT/ANdwXDyrDx8fr4=;
        b=J2QpRsMq8BWZ2dqZ7wcB/KblotkDhATrfTEQRjLNfDwAliioj9PyqIFKQYMr1Rrns6
         isQmnYrDPErBygpB4ecF15Muavr0n+XpiB59LHpflMiQcniA+hH+v7GNvAi60mONB9VK
         +OLhMlHrBzhuK0/JPM4GUV5FK1XAqaABveQsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMMjrrJY3lBiXSG25cQt8v0fu/OT/ANdwXDyrDx8fr4=;
        b=qdu0/DTKecs3fV/bKLB+6q7Jh8aqD7HT8acpqqeofWeH3UqWwzLeMF0mZMqC1kRkt7
         n9hSLlDQ07vd3bDwxQLHwkiDv0jO7xKpfx5Xmt4cAVTSzyeigft6PIMc1qqPITxWuW64
         +xfSVFSWbPTC7svyVFIcg/BAIAjL/NTCupnWEf00J2+3VH2XFiRDgQq9lAD+M/kedXKg
         v2sCbKwl9X6GIsZnJImi76V68E/1sG5blVFMhbeNDPLtJ1AX85RhvqKhxFFiM8dZiZef
         dD1gJQfK5rTjq4BFn5jUjXU/8LP1U9SSaCW9mmxQjEJfVaFnZ4ar84VM7wrY1ljfjnPi
         K3kw==
X-Gm-Message-State: AOAM531Ay5wHwtXENpLLgg6GNPsSo5bBHJoZYuowNQ5hID6LV4Q9VxXC
        P/UQjENV7BnrcdK7EOx/Ajw5Lw==
X-Google-Smtp-Source: ABdhPJxLJ8TbGaKuzSq7jJVieEUNAN6Mx0cv1g6SIFedyQ6xre8QZTqPHOoK5/CP69tHqvh+zut+Bw==
X-Received: by 2002:a17:90a:306:b0:1c6:ff30:70da with SMTP id 6-20020a17090a030600b001c6ff3070damr26812768pje.117.1648246122043;
        Fri, 25 Mar 2022 15:08:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f21c:980b:7d64:94f9])
        by smtp.gmail.com with UTF8SMTPSA id 135-20020a62198d000000b004fa9a8f73casm7751457pfz.99.2022.03.25.15.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 15:08:41 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 8/8] iio: sx9360: Add pre-charge resistor setting
Date:   Fri, 25 Mar 2022 15:08:27 -0700
Message-Id: <20220325220827.3719273-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220325220827.3719273-1-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org>
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

Add ability to set the precharge internal resistance from the device
tree.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v2:
- Change kOhms into ohms.

Changes since v1:
- Suffix field with kOhms unit.

 drivers/iio/proximity/sx9360.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 3ebb30c8a4f61..21cade4358aeb 100644
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
+				"semtech,input-precharge-resistor-ohms",
+				&raw);
+		reg_def->def &= ~SX9360_REG_AFE_CTRL1_RESFILTIN_MASK;
+		reg_def->def |= FIELD_PREP(SX9360_REG_AFE_CTRL1_RESFILTIN_MASK,
+					   raw / 2000);
+		break;
 	case SX9360_REG_AFE_PARAM0_PHR:
 	case SX9360_REG_AFE_PARAM0_PHM:
 		ret = device_property_read_u32(dev, "semtech,resolution", &raw);
-- 
2.35.1.1021.g381101b075-goog

