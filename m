Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF50B518D44
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 21:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiECTnR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 15:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbiECTnQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 15:43:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B72E081
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 12:39:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a11so15556750pff.1
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2022 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68lFLMzdFWYn9TeG84Yby4hphKM/OE0fXGXg6JYNJHo=;
        b=agSMD0mYwrZLWQyFktPHTmNxr53miZI5xh2A9CFUj0Az4lEqJsxLWnRfcf1ufjt+je
         Zucdf6ioUwE19NKX9ek1d7dHI8J5djCxnSjKovvFKd9LFWUGxd3shtjXIgIfyxSo3Iup
         ABMsV/xz75KORtZpf4o9dpjoIbuxouEpDtrKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68lFLMzdFWYn9TeG84Yby4hphKM/OE0fXGXg6JYNJHo=;
        b=6spaWN9p97NWF+sntlZ8+qLG6uS5/YUu3Bir60MHlf/35SSNkKTEXmcXpXcdMUnWNV
         C9RxWNPp37mq7bW4aNEEhzNLL9iVxfsQkQ8g5yQP8phYFki6WPz7wKkEcB2jFoq9lRQ4
         jip8WsExpqbaZSWJui5B/jZmVpjlo8Q+11N5/30V01WLCYjS7/Sg4OuYUKOckdpUPNJE
         v3KYalymzUKfhuAAUmNFFOPksu0922Uedjzkqlb3X1bgbYOUN/2e6hAgIf+fG8EGw4l8
         w5zP83vPHcMaySgqL5az2LFKllX4KYChZNDaRhFuAaxTrCC+emeKX47aUXeBZNXr75wD
         8x3w==
X-Gm-Message-State: AOAM533lervSwFloYzFbRifc1qpSjZfGO/pzvMATffkVoiMLozsmm8o5
        mh8IONc5uFs6LfiFKm2WkLe+AA==
X-Google-Smtp-Source: ABdhPJwFb7VzKWz+rdPmAaYShya3oSzctVjAj8WRQ+y2WP3ynoKaRoLCqu7NRGV+8xoWFiqDNGLFPA==
X-Received: by 2002:a63:5551:0:b0:3ab:84c3:1a0 with SMTP id f17-20020a635551000000b003ab84c301a0mr15295935pgm.604.1651606783136;
        Tue, 03 May 2022 12:39:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:15e:c760:9a04:7fbe])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78c59000000b0050dc7628154sm6680804pfd.46.2022.05.03.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:39:42 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH v2 2/2] iio: sx9324: Add setting for CS idle mode
Date:   Tue,  3 May 2022 12:39:37 -0700
Message-Id: <20220503193937.3794477-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220503193937.3794477-1-swboyd@chromium.org>
References: <20220503193937.3794477-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Based on device tree setting, set the CS idle mode.

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9324.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 7f367f63e362..c7fc75f7badc 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -57,6 +57,11 @@
 	GENMASK(SX9324_REG_AFE_CTRL0_RINT_SHIFT + 1, \
 		SX9324_REG_AFE_CTRL0_RINT_SHIFT)
 #define SX9324_REG_AFE_CTRL0_RINT_LOWEST	0x00
+#define SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT	4
+#define SX9324_REG_AFE_CTRL0_CSIDLE_MASK \
+	GENMASK(SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT + 1, \
+		SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT)
+#define SX9324_REG_AFE_CTRL0_RINT_LOWEST	0x00
 #define SX9324_REG_AFE_CTRL1		0x21
 #define SX9324_REG_AFE_CTRL2		0x22
 #define SX9324_REG_AFE_CTRL3		0x23
@@ -872,6 +877,8 @@ sx9324_get_default_reg(struct device *dev, int idx,
 {
 	static const char * const sx9324_rints[] = { "lowest", "low", "high",
 		"highest" };
+	static const char * const sx9324_csidle[] = { "hi-z", "hi-z", "gnd",
+		"vdd" };
 #define SX9324_PIN_DEF "semtech,ph0-pin"
 #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
 #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
@@ -901,6 +908,15 @@ sx9324_get_default_reg(struct device *dev, int idx,
 		reg_def->def = raw;
 		break;
 	case SX9324_REG_AFE_CTRL0:
+		ret = device_property_read_string(dev,
+				"semtech,cs-idle-sleep", &res);
+		if (!ret)
+			ret = match_string(sx9324_csidle, ARRAY_SIZE(sx9324_csidle), res);
+		if (ret >= 0) {
+			reg_def->def &= ~SX9324_REG_AFE_CTRL0_CSIDLE_MASK;
+			reg_def->def |= ret << SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT;
+		}
+
 		ret = device_property_read_string(dev,
 				"semtech,int-comp-resistor", &res);
 		if (ret)
-- 
https://chromeos.dev

