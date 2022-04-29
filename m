Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82335157B5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381097AbiD2WFO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381060AbiD2WFM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:05:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74152C7E8A
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so11633855pjb.5
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oulsZQUSai/GQqwCFE/sf/lZc5vm5lyYOo24OaUn+3s=;
        b=JhXrmz+vT1k8mmGi4h+6saa78JoxnphHESdlCnTKGGLHj1W1jBI4F+OTw8+P1Qhafd
         gh2W7nJU8VsW0TcOqdSmHvWkY6vXYJmsdx8fNumcu5WqUbdXB/pZ9m/M4yqI7Yg6DZ0P
         3D7BQE9Z4CtcpUIGdUGspvPgOihDPgqcOxjUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oulsZQUSai/GQqwCFE/sf/lZc5vm5lyYOo24OaUn+3s=;
        b=mxZaJyYPNs6kjAJXVzrdkvtoMNgV6rBlidux5Q7EkPdCvjOMy9e/rXxlWafSyO6ctw
         VXYKDiiNCBuN8U+wGfapYnctAO6W31R2ZE6pTrATxEqIDl+wn+OiBFyNli0yBVvg6SZq
         JibI7vE6T8S68MGzY+naQl2RgRdPhmPgvlbHU47ojNt2X15rGOer5dkPFRfFqh9ndLTu
         hFCfjw4oB+8A48HkomTspx9l5rknEtA24zTnqE8WA/gPk/Q8NFD0eKC9RwEuJ7WITT+9
         IpWWbWQkARYVFPN7iWDs29efGMFw8es3+8pOT0BfWOomIItoBeCwiZ5YKNR494xySf7q
         D0gQ==
X-Gm-Message-State: AOAM5321maG0UQQ51UkvwVqUzuVEwgPecamJKwfCB8gIgoDMnqM2CXPm
        gAfJFaYAkHlr8cxTTLBvY8HlQA==
X-Google-Smtp-Source: ABdhPJxX7fB0OdX/c5jbmuu/mY1SnL663+hUj7I5GdWpG7G4ozZU4FVx8K0oqixnF+QeuT5KYU+Tlg==
X-Received: by 2002:a17:90a:8d82:b0:1d8:a5a9:5489 with SMTP id d2-20020a17090a8d8200b001d8a5a95489mr1211122pjo.102.1651269710991;
        Fri, 29 Apr 2022 15:01:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6161:73ca:10a5:5383])
        by smtp.gmail.com with UTF8SMTPSA id n9-20020aa79049000000b0050dc762813bsm167705pfo.21.2022.04.29.15.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:01:50 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 01/10] iio: sx9324: Fix default precharge internal resistance register
Date:   Fri, 29 Apr 2022 15:01:35 -0700
Message-Id: <20220429220144.1476049-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220429220144.1476049-1-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the default value for the register that set the resistance:
it has to be 0x10 per datasheet.

Fixes: 4c18a890dff8d ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
No changes since v4, already targeted for stable kernels.
Changes since v3:
- Fix commit, use RESERVED instead of RSVD.
Changes since v2:
- no changes

Changes since v1:
- new patch.

 drivers/iio/proximity/sx9324.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 0d9bbbb50cb45..378c2a17bae6e 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -70,7 +70,8 @@
 #define SX9324_REG_AFE_PH2		0x2a
 #define SX9324_REG_AFE_PH3		0x2b
 #define SX9324_REG_AFE_CTRL8		0x2c
-#define SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM 0x02
+#define SX9324_REG_AFE_CTRL8_RESERVED	0x10
+#define SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM 0x02
 #define SX9324_REG_AFE_CTRL9		0x2d
 #define SX9324_REG_AFE_CTRL9_AGAIN_1	0x08
 
@@ -781,7 +782,8 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
 	{ SX9324_REG_AFE_PH2, 0x1a },
 	{ SX9324_REG_AFE_PH3, 0x16 },
 
-	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM },
+	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESERVED |
+		SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM },
 	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
 
 	{ SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL0_GAIN_1 |
-- 
2.36.0.464.gb9c8b46e94-goog

