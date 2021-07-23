Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E253D3738
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 10:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhGWISI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 04:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhGWISG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 04:18:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146DC061575;
        Fri, 23 Jul 2021 01:58:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z8-20020a1c4c080000b029022d4c6cfc37so3046745wmf.5;
        Fri, 23 Jul 2021 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUT5hAhyKrwqufI4qGLq+IhrpHzB3s2CLwASOs8ECoo=;
        b=HjlKBGSyQ66QkRaAdexb32ik11gLeL+KFvkDypJnJ334eKTr5LlRcCQ3nno9PNhR/z
         g8Dbvtfe80hjEQFZ/Fo+28071KHpbwZSeBUMGjm5NFIE0YtjbxvBPcz017p5AfFwisEM
         vdIrBzLPQ+wBZyO2y5IM3KHrAeAe/DmwQeITGt5vqOdQ/4kwI3ZDDEq5ZT9WXxPcN9ms
         bNVmsv/hSgX3OnNms0hsKKsVIr83V+qNdddNOrEf6QZ6q3mwidx7ZZ0fCWZtZf0Fx82u
         4hsT7R+FivuVJ06+MrpmyzQzUrOS+id+QEr7pdEd+xehfP4rUsHpRUuvLvIjoT2XVQfc
         q7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUT5hAhyKrwqufI4qGLq+IhrpHzB3s2CLwASOs8ECoo=;
        b=f1UWIMf03ZVqfEhubhnGN/VVbbaip/m3hNHpOwBkcJGM56wXaEMK6xElqNEndHVa+q
         OG0bStQ9LQMeG0rbFcXCSLUinCPzAB/uO4ZVe5oXOhEuydhso1RYFdLyjfwnV8rNpedq
         ebwh0G4L0JDiBB6LKciPVuzBPTzRLX3dMg5UIgY+9ZdJXH8zTMLhOoncpu0LwufJRouB
         GLE30NnfCyBM24UWRe+idEYO+XPNdcd/JU8c/ktIsLTW7ea0ta0O+8ohazxYg0t77u43
         4nLEYDdm/TW2tGK5Uk13cbEFMz8/QIkMbbC0ox44fJq1NoO9Ylu2qEcn/xfCpES8+Jxd
         QuWA==
X-Gm-Message-State: AOAM530qDB/qkHWG5KkecsWJPCdtNvatL3R5s9kjCr6aoZrBB5yaiBeF
        sbLqWytb8xW9Q5YBKUma4fk=
X-Google-Smtp-Source: ABdhPJwGF2V514xBlcfIsFT/jo9qw4cgDF+CJSAUC07OwTKiwJWLxDhdNUUD7XggUwwE4VE5l1tPUw==
X-Received: by 2002:a05:600c:19d3:: with SMTP id u19mr13566866wmq.115.1627030717716;
        Fri, 23 Jul 2021 01:58:37 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id l23sm17503607wme.22.2021.07.23.01.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:58:37 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH V2 4/5] iio/adc: ingenic: add JZ4760B support to the sadc driver
Date:   Fri, 23 Jul 2021 10:58:12 +0200
Message-Id: <20210723085813.1523934-5-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723085813.1523934-1-cbranchereau@gmail.com>
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
 <20210723085813.1523934-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The JZ4760B variant differs slightly from the JZ4760: it has a bit called 
VBAT_SEL in the CFG register.

In order to correctly sample the battery voltage on existing handhelds 
using this SOC, the bit must be cleared.

We leave the possibility to set the bit, by adding the 
"ingenic,use-internal-divider" property to a devicetree.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 drivers/iio/adc/ingenic-adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 6b9af0530590..09937c05d2af 100644
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
@@ -879,6 +880,12 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	/* Put hardware in a known passive state. */
 	writeb(0x00, adc->base + JZ_ADC_REG_ENABLE);
 	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
+
+	if (device_property_present(dev, "ingenic,use-internal-divider")) /* JZ4760B specific */
+		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL, JZ_ADC_REG_CFG_VBAT_SEL);
+	else
+		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL, 0);
+
 	usleep_range(2000, 3000); /* Must wait at least 2ms. */
 	clk_disable(adc->clk);
 
@@ -906,6 +913,7 @@ static const struct of_device_id ingenic_adc_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
 	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
 	{ .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data, },
+	{ .compatible = "ingenic,jz4760b-adc", .data = &jz4760_adc_soc_data, },
 	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, },
 	{ },
 };
-- 
2.30.2

