Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871724E38E4
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 07:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbiCVG0y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiCVG0p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 02:26:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125437A37
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so1283485pjp.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjgJJVcsve1n7Z5mXv4kDR9lNutzLAA9Ze2+yi6SXPQ=;
        b=m5fHtMApZNLn0Pq+xH7xFGnEq+6CJyOvh10vbCdYNEpjBtFDEh+AIfekMynjdVJifb
         nuYQevh8sZklmcuK/kL7QSBgFvmnVBJehy8mvHqLnYUHTeUSZHPNmxfExUkjsdnP0mdj
         9w2disc9YMwOyZthrXwMZyWnorfLFvsJipb8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjgJJVcsve1n7Z5mXv4kDR9lNutzLAA9Ze2+yi6SXPQ=;
        b=1pB1rEbLGlHMnwVAzXmAOeq5VARE7mPZuiewbcoyduefImyfhRsquxsCEVuFGnxB3E
         lDlkg2NRPBQ3UPpPBdtAOw1pnBODp1DyljgoS7vNaH7diCOMooqEcrQgnzay5Ib3rryd
         luVXSGShHPFcFK0Lf9uQVVu8rJAys7PaJf/pryDaA1JigIikRGvOhRoa2hJcwjGbbFze
         sVxT2zzXYA7mJ8TwcouvecRo9yhB/e+VKzFFXCDMBD9Lgvd39xWpWlWIV8/JkPjArNul
         Lz+h1t7eCCTCgL8uQlHojqVVwo4NTcW3VqxmSxrRZVITrmF6kCk4yZlY2k+3L7hkK+KS
         0PXQ==
X-Gm-Message-State: AOAM530yCI7MdH/UDT//xJaeo+H2M39TwOra4KvN9saW9cbcU6Bljkhs
        0lPKOue4MS8tz+YdhdV7p1AQxw==
X-Google-Smtp-Source: ABdhPJwI9AeZASfiGcfQx10S97lEhWB4gh5C7xVA2RSBYEH6fVb50qcvHIDWPaiPahuV4eDKCMFgFg==
X-Received: by 2002:a17:902:8306:b0:14f:a386:6a44 with SMTP id bd6-20020a170902830600b0014fa3866a44mr16149333plb.140.1647930311019;
        Mon, 21 Mar 2022 23:25:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c016:a147:e7e:6836])
        by smtp.gmail.com with UTF8SMTPSA id s20-20020a056a00179400b004f709998d13sm22672619pfg.10.2022.03.21.23.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:25:10 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/8] iio: sx9324: Fix register field spelling
Date:   Mon, 21 Mar 2022 23:24:58 -0700
Message-Id: <20220322062504.1019504-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220322062504.1019504-1-gwendal@chromium.org>
References: <20220322062504.1019504-1-gwendal@chromium.org>
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

Field for PROX_CTRL4 should contain PROX_CTRL4.

Fixes: 4c18a890dff8d ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- Add Fixes keyword in commit message.

 drivers/iio/proximity/sx9324.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index d50ce67aafdf2..1dfa19426c210 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -90,7 +90,7 @@
 #define SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK	GENMASK(5, 3)
 #define SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 0x08
 #define SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK	GENMASK(2, 0)
-#define SX9324_REG_PROX_CTRL3_AVGPOS_FILT_256 0x04
+#define SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256 0x04
 #define SX9324_REG_PROX_CTRL5		0x35
 #define SX9324_REG_PROX_CTRL5_HYST_MASK			GENMASK(5, 4)
 #define SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK	GENMASK(3, 2)
@@ -794,7 +794,7 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
 	{ SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
 		SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K },
 	{ SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 |
-		SX9324_REG_PROX_CTRL3_AVGPOS_FILT_256 },
+		SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256 },
 	{ SX9324_REG_PROX_CTRL5, 0x00 },
 	{ SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
 	{ SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
-- 
2.35.1.894.gb6a874cedc-goog

