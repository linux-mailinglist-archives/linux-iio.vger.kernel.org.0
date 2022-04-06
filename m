Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A3C4F6951
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 20:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbiDFSNc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiDFSNL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 14:13:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E2515EDC0
        for <linux-iio@vger.kernel.org>; Wed,  6 Apr 2022 09:50:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n9so2467724plc.4
        for <linux-iio@vger.kernel.org>; Wed, 06 Apr 2022 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4P7e/QTs8wn6qj47LPpoe55zLRy/s7mxgSDGXvObcso=;
        b=mosDJgMTbuAEeGWSBBOJVYKHWb+uy+JM0xVt0xBaBGIyKSVcTL4B/LYGbiituFQk1x
         B/F1GzKThGl5xysLEVBANk8L4+eCtzcma7L8E5YKFAhOeiplWVp0xTV2T6kya+7/6jLF
         t0iCM4WIgF06f08W+OJk4uiPrRN+8nROUxPp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4P7e/QTs8wn6qj47LPpoe55zLRy/s7mxgSDGXvObcso=;
        b=7w+V+SdkZCJjmM0lr/zeZkwD9JnHEseAqVwaou7KsYKQX1lT1/90zf/0sryq4A3uFx
         EviBwVqCz+rkXJ1d+amDdvX2I0zhnbOVKs+Ci/rqUN0CjAWW20N87tHSCRNRj5lr+kf0
         s6Aplj5ySgq3RuShNsvzU3u7gmb514tQOP3c0PN4mYJ8wDXxl3rhPvmgH3qfl3V11+ht
         i8tCztI1f2/+123akf4uH525ue7A66g61yr34gKbNf4+KI6A9pPXCYLEdCe0wXDzW9M+
         4/t3901aGOqcMDh6p6X0vJHN3muzZ3vVzj9IponsKqMtj63BbH0JGZ6+aud7xFf/Acwv
         eS4A==
X-Gm-Message-State: AOAM533sJOMlPfYFm4G5U4JLPASz4iQpktb+FSZQV4Ojm65z2TsE5gg4
        mT2+it4WqKgghHkHNVfvdeawGA==
X-Google-Smtp-Source: ABdhPJwe8dCFzb9OfeXN77GAVr2XjO9CyDChxHb1+7waxxZhuqHrqJ/ujHDyCYBYqIQLV8Ms1c1KqA==
X-Received: by 2002:a17:902:da90:b0:154:1510:acc7 with SMTP id j16-20020a170902da9000b001541510acc7mr9517536plx.103.1649263835520;
        Wed, 06 Apr 2022 09:50:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c9d3:469f:91e4:c022])
        by smtp.gmail.com with UTF8SMTPSA id q203-20020a632ad4000000b003987c421eb2sm17122321pgq.34.2022.04.06.09.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 09:50:35 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 4/8] iio: sx9324: Add precharge internal resistance setting
Date:   Wed,  6 Apr 2022 09:50:07 -0700
Message-Id: <20220406165011.10202-5-gwendal@chromium.org>
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
- Split patch in 2.

 drivers/iio/proximity/sx9324.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index a7d9a53692a6d..691700de0b9d4 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -72,6 +72,7 @@
 #define SX9324_REG_AFE_CTRL8		0x2c
 #define SX9324_REG_AFE_CTRL8_RESERVED	0x10
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
2.35.1.1094.g7c7d902a7c-goog

