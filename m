Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E014E38DA
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 07:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiCVG0w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiCVG0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 02:26:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F45233349
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x2so1105335plm.7
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dvp5PLFFHZuIsQgWetyrsf4XNvoqvv0/5sQ2pDSkzC4=;
        b=b6lMgKv5Sw24Rt4XR5Ivbbja4czyGfu0gP7CcpgVxE4+T3WzKMKZn8pKGO5rASuILO
         LjZbEW2yLovrzHvDbc056juhC0Fr7PZURaX0QGZmhK/c24EIGm3/8Q/yRSEmNHn33uoM
         T+4j1Mo3g35YmQfbxFyNeJCZRfAT4NgPQYDzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dvp5PLFFHZuIsQgWetyrsf4XNvoqvv0/5sQ2pDSkzC4=;
        b=DLgO5YOGQ41XIfMx9eGfh5us+f3C5no5nVHSEI5HDFNBQJzoASVKY6CXySuM3bEOaM
         KF1roFgIALN1ES6bI82T4DobhCxAB+QG9L66XGDJLwE34Lo6oWbqG1gyQBxl+tOzi/du
         ZiplrRelANRgsm873BEQ0brJvN2GhrM61XXOJitcY+1DfODrXJiexR9OiBbSC6+Pusqh
         cIuMXUP3JL4wJl9YcfTnZJg6I6tUjXec797+/Z4naevsU8h2f0GDiGbXEwMK1e74Kko7
         cN5XN+2dWBTjMi4CzQaz4pdDhSAYKFKsP13KKw6Zre7nJitkaW8FAm3bS8yu61O7zMY3
         sR+w==
X-Gm-Message-State: AOAM533ukhKbFRHL3nTsxC46ErokJFVNMwDXEVchFYP7DG2IFFVezZTr
        K5nd+/WalCsOcZMdwunru5EgcQ==
X-Google-Smtp-Source: ABdhPJy9Q3kS0c782m03W2yRWveI5jwvz72UxXedRRzodo+D+nfPTeo9Ax0/jonDXCofcMmXQUl8TQ==
X-Received: by 2002:a17:90b:4a4b:b0:1c6:4398:523c with SMTP id lb11-20020a17090b4a4b00b001c64398523cmr3164773pjb.50.1647930309968;
        Mon, 21 Mar 2022 23:25:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c016:a147:e7e:6836])
        by smtp.gmail.com with UTF8SMTPSA id c34-20020a630d22000000b0034cb89e4695sm16329296pgl.28.2022.03.21.23.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:25:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/8] iio: sx9324: Fix default precharge internal resistance register
Date:   Mon, 21 Mar 2022 23:24:57 -0700
Message-Id: <20220322062504.1019504-2-gwendal@chromium.org>
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

Fix the default value for the register that set the resistance:
it has to be 0x10.

Fixes: 4c18a890dff8d ("iio:proximity:sx9324: Add SX9324 support")
Cc: stable@vger.kernel.org
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/sx9324.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 0d9bbbb50cb45..d50ce67aafdf2 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -70,7 +70,8 @@
 #define SX9324_REG_AFE_PH2		0x2a
 #define SX9324_REG_AFE_PH3		0x2b
 #define SX9324_REG_AFE_CTRL8		0x2c
-#define SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM 0x02
+#define SX9324_REG_AFE_CTRL8_RSVD	0x10
+#define SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM 0x02
 #define SX9324_REG_AFE_CTRL9		0x2d
 #define SX9324_REG_AFE_CTRL9_AGAIN_1	0x08
 
@@ -781,7 +782,8 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
 	{ SX9324_REG_AFE_PH2, 0x1a },
 	{ SX9324_REG_AFE_PH3, 0x16 },
 
-	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM },
+	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RSVD |
+		SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM },
 	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
 
 	{ SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL0_GAIN_1 |
-- 
2.35.1.894.gb6a874cedc-goog

