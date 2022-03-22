Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F84E38E3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 07:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiCVG0z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbiCVG0p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 02:26:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079E338BC8
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m22so14900112pja.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9k3rCozgrGymSdhye62YH957jC7tnolJq0Oa32pVRw=;
        b=kF4jU2CtaNf2Vz2zGLuVCxOlP4oIX5/J/zv2QANMM9Y/h+4pZ13lLTnlxyYumVmgJq
         AlIeaV5nffpxPVruYJRISsPMQW2zfX0M8vjfobgldCx1YUiGWfmPmF2rsjBb0BdT0/TU
         ZrCdspmkU4tL3iK0+ltYuYpep5X3hVbWGjntE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9k3rCozgrGymSdhye62YH957jC7tnolJq0Oa32pVRw=;
        b=XDzI+91kA0FuizwTDbGD+lXn/gaZS/qwYcVcDtpCulhRCbKSiCpvJRxv/24hUPmWwD
         e+UsBZ8jzPPgTxi+7GFAHlhCcr0Cn2XM9L61eJYo1Kre6+UNHCupx4rNdrt1/aoW/EqA
         meSUG2nqtHqBAXxsdowTfHjcNnX4r2cHBiF46wsm8uMyFuALnjvAtskEdVt2y+ZRgUqE
         /qRhde0KIpE6L0kTONykjyujSwrJhcYBnDod/R4e00uOUAthkW4zo7MB8jXmSm6FleNk
         PLh2//V9Qy/qBXExgaWWepkPc6MWhvljAAgWsXu8g5g85W9tDijm4P0a5MrWZ+UBYkjb
         C25w==
X-Gm-Message-State: AOAM532zUcl2Suf+nYmV0R052xQonb+aiiwdJ2O0YI32sM+myLIhdWRv
        /XEpssy9XE4/0gHfbuAWqIVWJzziyw01LA==
X-Google-Smtp-Source: ABdhPJx/Ug572bWM2cO5FlxvdLKfpEzF9UbVfJDiFdb8txm+0RSrtZ7WYAc/fCZFLj/Qhf/fHpktag==
X-Received: by 2002:a17:90b:1e04:b0:1c6:fb36:9d93 with SMTP id pg4-20020a17090b1e0400b001c6fb369d93mr3127978pjb.57.1647930313431;
        Mon, 21 Mar 2022 23:25:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c016:a147:e7e:6836])
        by smtp.gmail.com with UTF8SMTPSA id z130-20020a633388000000b003817671cb29sm1468201pgz.41.2022.03.21.23.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:25:12 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 4/8] iio: sx9324: Add precharge internal resistance setting
Date:   Mon, 21 Mar 2022 23:25:00 -0700
Message-Id: <20220322062504.1019504-5-gwendal@chromium.org>
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
Fix the default value for the register that set the resistance:
it has to be 0x10.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- Suffix field with kOhms unit.

 drivers/iio/proximity/sx9324.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 1dfa19426c210..95de5d9f8eacb 100644
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
+				"semtech,input-precharge-resistor-kohms",
+				&raw);
+		reg_def->def &= ~SX9324_REG_AFE_CTRL8_RESFILTIN_MASK;
+		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL8_RESFILTIN_MASK,
+					   raw / 2);
+		break;
+
 	case SX9324_REG_ADV_CTRL5:
 		ret = device_property_read_u32(dev, "semtech,startup-sensor",
 					       &start);
-- 
2.35.1.894.gb6a874cedc-goog

