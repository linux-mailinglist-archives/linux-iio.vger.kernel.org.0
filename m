Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACADA4F68FF
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiDFSNd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 14:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbiDFSNM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 14:13:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B237676
        for <linux-iio@vger.kernel.org>; Wed,  6 Apr 2022 09:50:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n8so2482691plh.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Apr 2022 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=53sX0CQ0dSON0UrxsaG2RHL4F5xS2YOFLLPeADqFZXc=;
        b=nJOnU3mFPmzMNMMWYADu/x5bs+vys214sWEUHjki9biwd0uDPdNyflMt3p4loIxQoD
         YYR98iSr4RI1SteBsjtXI2quY1Ofbx4sMmMZLOpRJ7i8SDYJ8O+I7qJCQJOxI+hvkkL8
         fH9Th5Rl7MuBOcLdIoW96IV58FXjFfOit7foY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=53sX0CQ0dSON0UrxsaG2RHL4F5xS2YOFLLPeADqFZXc=;
        b=okjBtCIzlOK3Zm48e9UFhntBZZ6VqqT7RdfOOw4g0+a2mmpR+IeoJWSpomru1hgxiM
         PvfewBEDCe6zi8HUmhl8KSZ9juVa1Beb4iyqMX0vkPe7g3hyxMSQtDOKy7z6sO0eSnj3
         q2GJg8uA2LQ8OFiYzutFmqdMEU+2fGAKOskhhzjuH5jztPoHANozLoBTSyxJcsiP3LZV
         qq7OhWYRxQ1vUiCrXRkvcKj7uAtuWvvvzMzXe19hoFTh+HLzylgrDsQyyMGpCnNNSee0
         4DNXNmyhXZnxocdzbRrs/abl/rU2YoQP0Na8ZR5lHVwCHyyFet8wll2yS/BHlH0+LTi9
         DRtQ==
X-Gm-Message-State: AOAM532jgY5I07KnmttWm7QibfO2x0XKj9YsDUuzBnM3RLQg0VX8Wefm
        20vg/XFAKgaJjDoAJ7eFSvXKPQ==
X-Google-Smtp-Source: ABdhPJzDtKK4ffie+FK5FYkGI38BvdFWKS60/cXQ0DEADdP15hgakmPadlbxTklI6kRa6OcmBgxfbg==
X-Received: by 2002:a17:90b:4a47:b0:1c6:42c6:fef2 with SMTP id lb7-20020a17090b4a4700b001c642c6fef2mr10717342pjb.147.1649263841428;
        Wed, 06 Apr 2022 09:50:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c9d3:469f:91e4:c022])
        by smtp.gmail.com with UTF8SMTPSA id s3-20020a056a00194300b004f6da3a1a3bsm22030709pfk.8.2022.04.06.09.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 09:50:41 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 8/8] iio: sx9360: Add pre-charge resistor setting
Date:   Wed,  6 Apr 2022 09:50:11 -0700
Message-Id: <20220406165011.10202-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220406165011.10202-1-gwendal@chromium.org>
References: <20220406165011.10202-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since v3:
- Added Review tags.

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
2.35.1.1094.g7c7d902a7c-goog

