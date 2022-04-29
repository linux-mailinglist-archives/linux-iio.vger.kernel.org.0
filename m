Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B05157B2
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381184AbiD2WF3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381153AbiD2WFY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:05:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A2DBD2D
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:02:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bd19-20020a17090b0b9300b001d98af6dcd1so11635507pjb.4
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hvam89OhrSHzgUmGzxLK+czpa+WBvjuZZyC7jpzzxzM=;
        b=Fiyln5642DNlT2hviPPk/cfEWYUrf836JGjtSDY9xBR7LeDnwlJ9o5Ob/2hHNHEgv+
         /M3+QBTDoAaVg3P7J8sbpVFhF0aofdys5+wKPInR6XDLdRtzjPDXqb4oARHVEJNa9pb3
         sZymztSGQou/jtiRNEL1T2zpaoP2xM5hMFkO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hvam89OhrSHzgUmGzxLK+czpa+WBvjuZZyC7jpzzxzM=;
        b=iyeRL+C04s0YrjnV3HJznzUdAiF5Vchl4Gh3boYqXv50e/BfPEY74TgwryrMyIdgo8
         cQue6ImtjwcKwSaqbQGcDqhwN91/IKsyj7MuYjnfNAyHrPsMGPMZ0qMQiOoyHBBxvIFb
         OfG7CAhTnjX9GYX0a2do3zdSywMrtSU3I0O7jefTlqv9xQF7s/CVRw/4ehmSAC61VXQQ
         VGPkDo5vOag8YIg4OGQpe51BO/9hr5TXGT+CPosbQHmYl/m2/M7X1vsOjmAzLABdwPPC
         02r6bK2eSWUH2j1PVE22RpFszhMaaD8VTxzilOM/8JH/D0nBCNjWWLfNTL3ZIEWrvUOT
         0mxQ==
X-Gm-Message-State: AOAM531qMQuxBjrlsluFHbBHJebOp4YtdwVG7oEnSXP1rqviNQVwXG0b
        8CkfTC1gNAWX+lgTWYzgtNz45w==
X-Google-Smtp-Source: ABdhPJwuKG96oD9IHm2c9thgq7K805GvetFK3RzMClXtEoHQWG0TNiQRj8d5iknzKRl9byw9m+cAlQ==
X-Received: by 2002:a17:903:208:b0:15c:7dd0:eb64 with SMTP id r8-20020a170903020800b0015c7dd0eb64mr1378995plh.40.1651269721638;
        Fri, 29 Apr 2022 15:02:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6161:73ca:10a5:5383])
        by smtp.gmail.com with UTF8SMTPSA id z21-20020a631915000000b003c14af5062dsm6225226pgl.69.2022.04.29.15.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:02:01 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 08/10] iio: sx9324: Add Setting for internal analog gain
Date:   Fri, 29 Apr 2022 15:01:42 -0700
Message-Id: <20220429220144.1476049-9-gwendal@chromium.org>
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

Based on device tree setting, set the internal analog gain.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
New in v5.

 drivers/iio/proximity/sx9324.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 6806262eb1c92..851f2ff0ae7e8 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -79,6 +79,7 @@
 #define SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM 0x02
 #define SX9324_REG_AFE_CTRL8_RESFILTIN_MASK GENMASK(3, 0)
 #define SX9324_REG_AFE_CTRL9		0x2d
+#define SX9324_REG_AFE_CTRL9_AGAIN_MASK			GENMASK(3, 0)
 #define SX9324_REG_AFE_CTRL9_AGAIN_1	0x08
 
 #define SX9324_REG_PROX_CTRL0		0x30
@@ -925,6 +926,27 @@ sx9324_get_default_reg(struct device *dev, int idx,
 					   raw / 2000);
 		break;
 
+	case SX9324_REG_AFE_CTRL9:
+		ret = device_property_read_u32(dev,
+				"semtech,input-analog-gain", &raw);
+		if (ret)
+			break;
+		/*
+		 * The analog gain has the following setting:
+		 * +---------+----------------+----------------+
+		 * | dt(raw) | physical value | register value |
+		 * +---------+----------------+----------------+
+		 * |  0      |      x1.247    |      6         |
+		 * |  1      |      x1        |      8         |
+		 * |  2      |      x0.768    |     11         |
+		 * |  3      |      x0.552    |     15         |
+		 * +---------+----------------+----------------+
+		 */
+		reg_def->def &= ~SX9324_REG_AFE_CTRL9_AGAIN_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL9_AGAIN_MASK,
+					   6 + raw * (raw + 3) / 2);
+		break;
+
 	case SX9324_REG_ADV_CTRL5:
 		ret = device_property_read_u32(dev, "semtech,startup-sensor",
 					       &start);
-- 
2.36.0.464.gb9c8b46e94-goog

