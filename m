Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6064E7CC7
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiCYWKM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 18:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiCYWKL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 18:10:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC940166675
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t13so6254483pgn.8
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNLkn36+WdikLcYtD8d4p99FZ3awOSvlGNb/3GiGF18=;
        b=h4Aff1GaUCddfZcUl+gGSlaaN4Juokcg5IzDSfCXXne6IHahZJQ16dJ9OAB3Q43oX5
         JXHy7xIdTJe6T9h3TlGv8LN6Qzj0KuLW4qFiey7kv/ozVcke+tXWSrZbPAqpyALS6FwW
         C4BtkuF88cdftQFbi/XAbPZAqzJdoH9DYD7sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNLkn36+WdikLcYtD8d4p99FZ3awOSvlGNb/3GiGF18=;
        b=10Yg+WXol+RibUEhZKkSSKYzy0wcS0e91li2pIfXD5u5yZRrXnBgZXJYS9a2ZrO+If
         TC0gL+4ThTu+EQdJCjvQViFXJmPm+d75gsBA1n1UuqPEwMxvin8HZOYXvz4YrwLux4v0
         3o9ogEdET2ooRb934DGmlvjYc4rRTC3nG2UxSsdnR7fzXoc6FtosE2ASGGuE/gZ8l1Xx
         S62o2Q6Dsl6tAgSLzvsg1p1MIA5/q1M1RMCSS8SWFxm58Qu+FhHbYVdHpsd/OpghX0uW
         ed6mXCRMCls1tsoFh6yCUUjXgA5et0bTUKuaGww2/KBWj1yyXe7f2sCQunt7DMP7+h/A
         GyUQ==
X-Gm-Message-State: AOAM5330KrdCBOMUCZFIN6kDwUiCLZtDfb1N2LM4Be4mwGZ2IT8lOROd
        BljJklzgRiGIc0DiB2+FcpZgO8ti7FP+6g==
X-Google-Smtp-Source: ABdhPJyOfT4uoSEG1gduAQ0uWIYmGtj6pr0QlIHm1QjyU/eHHJ4A43lDGSLJ6i5suiOMP/jZ0qF7VQ==
X-Received: by 2002:a05:6a00:18a4:b0:4fa:ee98:87bb with SMTP id x36-20020a056a0018a400b004faee9887bbmr10104532pfh.2.1648246116369;
        Fri, 25 Mar 2022 15:08:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f21c:980b:7d64:94f9])
        by smtp.gmail.com with UTF8SMTPSA id 75-20020a62144e000000b004fae56c42a0sm7335243pfu.211.2022.03.25.15.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 15:08:36 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 4/8] iio: sx9324: Add precharge internal resistance setting
Date:   Fri, 25 Mar 2022 15:08:23 -0700
Message-Id: <20220325220827.3719273-5-gwendal@chromium.org>
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

Add ability to set the precharge internal resistance from the device
tree.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v2:
- Change kOhms into ohms.

Changes since v1:
- Suffix field with kOhms unit.
- Split patch in 2.

 drivers/iio/proximity/sx9324.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 1dfa19426c210..3f229dffd5380 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -72,6 +72,7 @@
 #define SX9324_REG_AFE_CTRL8		0x2c
 #define SX9324_REG_AFE_CTRL8_RSVD	0x10
 #define SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM 0x02
+#define SX9324_REG_AFE_CTRL8_RESFILTIN_MASK GENMASK(3, 0)
 #define SX9324_REG_AFE_CTRL9		0x2d
 #define SX9324_REG_AFE_CTRL9_AGAIN_1	0x08
 
@@ -893,6 +894,15 @@ sx9324_get_default_reg(struct device *dev, int idx,
 		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
 					   raw);
 		break;
+	case SX9324_REG_AFE_CTRL8:
+		ret = device_property_read_u32(dev,
+				"semtech,input-precharge-resistor-ohms",
+				&raw);
+		reg_def->def &= ~SX9324_REG_AFE_CTRL8_RESFILTIN_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL8_RESFILTIN_MASK,
+					   raw / 2000);
+		break;
+
 	case SX9324_REG_ADV_CTRL5:
 		ret = device_property_read_u32(dev, "semtech,startup-sensor",
 					       &start);
-- 
2.35.1.1021.g381101b075-goog

