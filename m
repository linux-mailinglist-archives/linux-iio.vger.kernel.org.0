Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9F5157A6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380939AbiD2WFW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381090AbiD2WFP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:05:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33014CB016
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so8266831plg.5
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzVP4SoLbvQ+2ClFFIC9xNs5B07CxGDHrnHqSGpSLAw=;
        b=j703hKi4kLCYjRuePWv3gyccqnWaFPRL+bVpATi2Z6o3yS3NKQS7rBNVG7Vr7N0NVQ
         rSd6m73Evjv+6brlhS48SedG19ShvjiUlLy1X2wExzPpdJFK94IjcYuzstG/zne63Nn5
         m4RQugC391JJAoblTCfNUXSLjYeONNK6fV370=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzVP4SoLbvQ+2ClFFIC9xNs5B07CxGDHrnHqSGpSLAw=;
        b=z9kX0ZtKw2dDqovlxH4/vAdrkL0vhuFE1fTSz1NK91EoTRX5AJF5U5ES/f6/IbCaFh
         +fnbKxopnD72VopzQGJJTO2ibAiko5IES7xIrkHt20QF9vd+qqxSjZ09ZvZBC7sPcEVo
         E/DnVSYCFvi8UDr0v/ai1H4AiZAs9F8TW81Ov1ak8rJHWA6xvipKbi9482Y08/PbhknW
         6+/b5YN/fHmLySBt8RnjBK8vG6pf2dWJIrdwGOUU3zsPyzPsW5b83m9+6GpdFIS4DPSa
         Oe03PH3/OIgdeW9y0DfJ06tnJCpLXVJwKQ760SQYoHxKtvavB/RfLlHLLHrOpYd48++e
         iOSg==
X-Gm-Message-State: AOAM533iqRQD1diDQo3rl39QgSq3YziIy52veRUpmsV7FEIvAgp5/2eQ
        DEao5w8iFWGHbjhSZ3EM2T4i1A==
X-Google-Smtp-Source: ABdhPJx4h/jMuR0p2TEJd/JaZpQFc1tZVnOzZ8+0mM/JFDEnM6yE/7TuUzQ+NA7lEzFi1X5CWmo7zg==
X-Received: by 2002:a17:90a:ba15:b0:1c6:7873:b192 with SMTP id s21-20020a17090aba1500b001c67873b192mr1237925pjr.76.1651269715379;
        Fri, 29 Apr 2022 15:01:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6161:73ca:10a5:5383])
        by smtp.gmail.com with UTF8SMTPSA id a14-20020a1709027e4e00b0015e8d4eb1easm80425pln.52.2022.04.29.15.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:01:55 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 04/10] iio: sx9324: Add precharge internal resistance setting
Date:   Fri, 29 Apr 2022 15:01:38 -0700
Message-Id: <20220429220144.1476049-5-gwendal@chromium.org>
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

Add ability to set the precharge internal resistance from the device
tree.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since v4:
- Added missing tests when property is not found.

Changes since v3:
- Added Review tags.

Changes since v2:
- Change kOhms into ohms.

Changes since v1:
- Suffix field with kOhms unit.
- Split patch in 2.

 drivers/iio/proximity/sx9324.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index a7d9a53692a6d..8eec73f7641ee 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -72,6 +72,7 @@
 #define SX9324_REG_AFE_CTRL8		0x2c
 #define SX9324_REG_AFE_CTRL8_RESERVED	0x10
 #define SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM 0x02
+#define SX9324_REG_AFE_CTRL8_RESFILTIN_MASK GENMASK(3, 0)
 #define SX9324_REG_AFE_CTRL9		0x2d
 #define SX9324_REG_AFE_CTRL9_AGAIN_1	0x08
 
@@ -893,6 +894,18 @@ sx9324_get_default_reg(struct device *dev, int idx,
 		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
 					   raw);
 		break;
+	case SX9324_REG_AFE_CTRL8:
+		ret = device_property_read_u32(dev,
+				"semtech,input-precharge-resistor-ohms",
+				&raw);
+		if (ret)
+			break;
+
+		reg_def->def &= ~SX9324_REG_AFE_CTRL8_RESFILTIN_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL8_RESFILTIN_MASK,
+					   raw / 2000);
+		break;
+
 	case SX9324_REG_ADV_CTRL5:
 		ret = device_property_read_u32(dev, "semtech,startup-sensor",
 					       &start);
-- 
2.36.0.464.gb9c8b46e94-goog

