Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5093517BA1
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 03:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiECBX2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 21:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiECBX1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 21:23:27 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70AC2E9DE
        for <linux-iio@vger.kernel.org>; Mon,  2 May 2022 18:19:56 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e2fa360f6dso15964722fac.2
        for <linux-iio@vger.kernel.org>; Mon, 02 May 2022 18:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nv/pSU+ZnWDELhz2wWC2INCxu/xtfe1TYKUv0ZzQucw=;
        b=SkVXXA94ffty5Mj2aWgSITnefdw4+ZrE8qSiePjbp7oHo9p4AVtJpl/Gk/HSyBfLe3
         3U6/cE8XNuzDetJ7BhMOVn7t4JgeZQOaEREfYgRLl8L2X8QuSwLDpCSqVLiv+fEWpIoq
         CrbYGst4DY2aRwIJIPspUfF6mvcmaba+HBuqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nv/pSU+ZnWDELhz2wWC2INCxu/xtfe1TYKUv0ZzQucw=;
        b=1obpXPW0lWcy/+2nNL0MtlL5B4E9QwQHcB9wczSag2X9oJ+nOUA1rzLs6FQHKwMxp0
         erKaSFHPTJnVZ/tkXHW0SrOx/YDEaEMhg5pv/23hDjoKowLJNFiOexdpQOpuWYyQfSII
         IB77MBaT0HK1MkyEm1jqtHSUuJUinimrN3HUddkrQhAzq1sA9MW5yKoVd42m72Vr3w5/
         2pdXLxWlHXIXfozUARTr+q+3HXAOzEQJJ0psDr/pBcV0dlru1QXUA9KdNkwEFPKJCd3w
         a34UG+6yNBGOTn9J2pPdM8Msu1wRdtgNAxMplpI3I67QyBWPReeP6oJltREjdMRJv24z
         MGug==
X-Gm-Message-State: AOAM532RqcHtv8i4p2T5or7LMMDbWihhFNZAaqn5jK4N0CE/IaJe9qhy
        UmkLmdH37Ey4v8S6TNmODFCeYHqZvTHh1A==
X-Google-Smtp-Source: ABdhPJz/hTWbt/I+UklgPRM/+6nN30JLRNTr2NxDCJCIBWJO3cx3gUrIinxBCPZLQnJkMWkFxuaaFQ==
X-Received: by 2002:a17:90a:ab81:b0:1ca:8a76:cdda with SMTP id n1-20020a17090aab8100b001ca8a76cddamr2016709pjq.26.1651538520161;
        Mon, 02 May 2022 17:42:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:15e:c760:9a04:7fbe])
        by smtp.gmail.com with ESMTPSA id i10-20020aa78b4a000000b0050dc7628177sm5258794pfd.81.2022.05.02.17.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 17:41:59 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH 2/2] iio: sx9324: Add setting for CS idle mode
Date:   Mon,  2 May 2022 17:41:56 -0700
Message-Id: <20220503004156.3559940-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220503004156.3559940-1-swboyd@chromium.org>
References: <20220503004156.3559940-1-swboyd@chromium.org>
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

Cc: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9324.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 7f367f63e362..79683f0d4e9a 100644
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
+	static const char * const sx9324_csidle[] = { "hz", "hz", "gnd",
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

