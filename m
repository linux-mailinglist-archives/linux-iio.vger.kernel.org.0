Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48B23D4965
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 21:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhGXSZO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGXSZB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 14:25:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C73C061575;
        Sat, 24 Jul 2021 12:05:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b128so2744294wmb.4;
        Sat, 24 Jul 2021 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CE42oTvnUW/ICeEUw/qu06y5Bh7gLGHxP818wCHu9ZI=;
        b=Mk98RsKgtx8fgh6/6N2TN1pQqI83pAQTpIiYgI/RF2pEILohyQmi0j5HZWijDjB+Oz
         8j634AlbzNZpkazgAYpSaUR1r6rGNJPgrAP9jKQZjrKMQrk2ZBt4ABvijxYGYisePIYM
         7DDcxXnjAzNqJ+blfl2SF2KsAAhSB1wajIe5yxKXCqDpA37TZcMyopFNTOBecmhbo+X9
         Jh10TFXWWZv8Wk5R8YfDw8Eaku2l3Sk4SqPllrca9hKhI+j+9ZYwIp7xSZCFAIQEefqA
         H7T/ZiomolCvlHZ2/lj6DqXy3HYd2egsJqx9xl/cABIQj1HmttxgEdcPgydQzw5bjCYw
         GFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CE42oTvnUW/ICeEUw/qu06y5Bh7gLGHxP818wCHu9ZI=;
        b=D5VHy0uKzwawXqhiq1n/wksWH/deA2LUaHWsd6mj5imBpU0DENmdyfv/mTVM3j/mNj
         y7ACgoVFgEj8IQ31Rcc5cNOHwHjfgnJUa7zpuHRPCotWeRH4zkLMKIUzA5Ic9ZYlMy0u
         0dVTTWntbOq910d/7eTIufxoum+ZxEsLz11jGEpCZRurkC3Qx1OUeFkOaBzesVHODq0O
         MYMATCV/Q3zjP05AE/RwlTbuKJa3cUBn5be4MHeOlGsN0aarTsVTevZbm3oAr2yf0mkt
         z0f9Mc/YjtOiW75jTdtSKhLZNrKzqzsK7w4qWMY+QbZPxb/icGzvfDpCIzqO29xNi6fT
         gKwg==
X-Gm-Message-State: AOAM5331QGZlLUkIKYM4L3qHov3WFY8aW1sFecktKnvtpbQhtkDrJRyb
        WWxdpG9z3t0Wh8AIPKJW7OI=
X-Google-Smtp-Source: ABdhPJykDBiE5RrChDh5kqaoxp/FTuQNEPvV4Rh5x18J6Pmw1B7bloCOXv/6+TwjXqchDtVFKH+0wQ==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr19345683wmh.8.1627153529906;
        Sat, 24 Jul 2021 12:05:29 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id j15sm1117798wms.20.2021.07.24.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 12:05:29 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v3 4/5] iio/adc: ingenic: add JZ4760B support to the sadc driver
Date:   Sat, 24 Jul 2021 21:04:48 +0200
Message-Id: <20210724190449.221894-5-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724190449.221894-1-cbranchereau@gmail.com>
References: <20210724190449.221894-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The JZ4760B variant differs slightly from the JZ4760: it has a bit called VBAT_SEL in the CFG register.

In order to correctly sample the battery voltage on existing handhelds using this SOC, the bit must be cleared.

We leave the possibility to set the bit, by using the "ingenic,use-internal-divider" in the devicetree.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 drivers/iio/adc/ingenic-adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 6b9af0530590..eaa8ab36183c 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -37,6 +37,7 @@
 #define JZ_ADC_REG_CFG_SAMPLE_NUM(n)	((n) << 10)
 #define JZ_ADC_REG_CFG_PULL_UP(n)	((n) << 16)
 #define JZ_ADC_REG_CFG_CMD_SEL		BIT(22)
+#define JZ_ADC_REG_CFG_VBAT_SEL		BIT(30)
 #define JZ_ADC_REG_CFG_TOUCH_OPS_MASK	(BIT(31) | GENMASK(23, 10))
 #define JZ_ADC_REG_ADCLK_CLKDIV_LSB	0
 #define JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB	16
@@ -879,6 +880,14 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	/* Put hardware in a known passive state. */
 	writeb(0x00, adc->base + JZ_ADC_REG_ENABLE);
 	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
+
+	/* JZ4760B specific */
+	if (device_property_present(dev, "ingenic,use-internal-divider"))
+		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL,
+					    JZ_ADC_REG_CFG_VBAT_SEL);
+	else
+		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL, 0);
+
 	usleep_range(2000, 3000); /* Must wait at least 2ms. */
 	clk_disable(adc->clk);
 
-- 
2.30.2

