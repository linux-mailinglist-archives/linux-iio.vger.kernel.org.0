Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52294DA131
	for <lists+linux-iio@lfdr.de>; Tue, 15 Mar 2022 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350601AbiCORcM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Mar 2022 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350611AbiCORcK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2022 13:32:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344A15882B
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 10:30:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f8so93211pfj.5
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OVHw4FMRix6/1vFaeCXhjJBzU9T7lPDEf8vcs78GDek=;
        b=bQTHUgEZuecTqo2HHUqWYxkppCFWk077qgGs2z6U/kCBfqjYgF4e3WeNmEm2eh34sT
         QWzAeXPlOyM7GiKKU22Znwk4GjvfD/95jLVOkNJCm8sxzQvFJ6+xDVYEm1N+CC8p38Xe
         ZtLEV3pHp3XpTUY92AqzUfTxfD6Jk37xzr/rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVHw4FMRix6/1vFaeCXhjJBzU9T7lPDEf8vcs78GDek=;
        b=gpzNdEhNrRp9bKF3sTdUiRU/UJzGjiM4hGzJZp7q1ChXeOuxAKOW7aLar1hgrjVF+f
         z12MzoM3XWYCHrrgX672Ds/wW9Jt4WtmFBsMG0nal6jl1amVXKiow0ZQOH6gEij5i/M+
         yvlVIzWnyaPH2LL+XWdJgYDHlqzaRLAUHSRPJ76KOGmW893DSEGvO5LwIrdvch4yMhQZ
         Awa/ML/cUP3LsFR8G3gn4x5duDZWtaSTziSRD90WwIY9KFCKiOEXKYwWYCE18NP9xPoj
         2aEkEb0lH/kpkzpHyHjNfHZYD7tVz7tB0Rp1chJuOwuRtoANFfvbS/wA7tVG/WoLNsnI
         lFQQ==
X-Gm-Message-State: AOAM533ZQIfZmRYZagMyNIVB8Kd0PGq8XvDoXVvhi6mZt+jVPCUbu4VE
        B/2rZ6JOmZCyvpl6jOqaliIP0g==
X-Google-Smtp-Source: ABdhPJyfEKc72dblYHJJuQRpa94C75jiedZC3nP6P8uFSy9tXkVO68uAH8xu9Tu+Q2m8HTTTOuYIaw==
X-Received: by 2002:a65:494b:0:b0:380:6517:cb32 with SMTP id q11-20020a65494b000000b003806517cb32mr25593619pgs.145.1647365457428;
        Tue, 15 Mar 2022 10:30:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:53f9:5c35:428f:83a1])
        by smtp.gmail.com with UTF8SMTPSA id s14-20020a056a0008ce00b004f66dcd4f1csm27389706pfu.32.2022.03.15.10.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 10:30:57 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 3/7] iio: sx9324: Add precharge internal resistance setting
Date:   Tue, 15 Mar 2022 10:30:38 -0700
Message-Id: <20220315173042.1325858-4-gwendal@chromium.org>
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

Add ability to set the precharge internal resistance from the device
tree.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9324.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 1bef16437aa84..785af857b23a1 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -70,7 +70,8 @@
 #define SX9324_REG_AFE_PH2		0x2a
 #define SX9324_REG_AFE_PH3		0x2b
 #define SX9324_REG_AFE_CTRL8		0x2c
-#define SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM 0x02
+#define SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM 0x02
+#define SX9324_REG_AFE_CTRL8_RESFILTIN_MASK GENMASK(3, 0)
 #define SX9324_REG_AFE_CTRL9		0x2d
 #define SX9324_REG_AFE_CTRL9_AGAIN_1	0x08
 
@@ -781,7 +782,7 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
 	{ SX9324_REG_AFE_PH2, 0x1a },
 	{ SX9324_REG_AFE_PH3, 0x16 },
 
-	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM },
+	{ SX9324_REG_AFE_CTRL8, 0x10 | SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM },
 	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
 
 	{ SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL0_GAIN_1 |
@@ -891,6 +892,15 @@ sx9324_get_default_reg(struct device *dev, int idx,
 		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
 					   raw);
 		break;
+	case SX9324_REG_AFE_CTRL8:
+		ret = device_property_read_u32(dev,
+				"semtech,input-precharge-resistor",
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
2.35.1.723.g4982287a31-goog

