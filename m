Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF28B3D5577
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhGZHkQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhGZHkN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 03:40:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C304C061757;
        Mon, 26 Jul 2021 01:20:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j2so9967351wrx.9;
        Mon, 26 Jul 2021 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9dZqyliQpKLP2w29GI8yePIPKK8jaZnaqcXWjZczNc=;
        b=g48HbY9/5onABFAaz5EHuynXYjg+OVheTGDRto7d7Ygu9kz4WTZXM/lDfxPeElzA48
         ck2CpXL/FsxeIRf8j6QKJPJa9qvBEg0kpk1ERibtCVUNHzOfPV5Idre4JuufIzQWp3X/
         dIWQmXZzAePdHP37RZfdt3yVjiw8w/Shs6usbiKPa3yj3RPB4aSIWE4C1FeP74I44XzF
         zWtP9pA0THLY7LiP96kxmvUNKLb7hDvVc89sDWhr1uoru8j78sg81cdR0NDLl6ROCoJW
         GUweWV7SIkvttcjrq6z7Hw6Jo51NuBsqtEOsI5RJIByTItrRhU5p/hXIuP2Pk6Zecz9u
         naOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9dZqyliQpKLP2w29GI8yePIPKK8jaZnaqcXWjZczNc=;
        b=mNc4+5KZ9N+EhMlcZaiGCB0Wi6NYKVyJ4zpmlHmB5Hc45NTzXdZkzghW2NKrNLDwMv
         lL5LRxFlxfk/b72cYSlv8yd+97h2LLz3dPKyDBXpQTm21I0aXI29XeyKvDcl2/Ome85q
         kkcLONou+HTXhq45u9eqgffOP0TXQpB00sq/xhywGCsVbBd5DhHPuqxY5iQKcu2dRwNI
         UNPpuabdTqvxT0o5ugNMQZg8PqT9ApgO6R8sX3+n+8Q06tYw5qbmw6r3/9gA3I83ZKy1
         ZE7gg3S1VAMolTWBlA4FSMJ6WdH7TJ8+iaERbfsIfw72MNc47RvwAgwfa+rwJjD17SmE
         kAXQ==
X-Gm-Message-State: AOAM5320AOwxI+/Y+kdM9MHiAnUDW+OLUxa5hlRqnas3H5yTG+r+9+WL
        HrhMqtzfuHt//VukPngQfFY=
X-Google-Smtp-Source: ABdhPJzks3RZvScQSv9uy/m7sWNTA1IzKRKGiXlQ1XHw/jR7Ms3Nk3eKKBwYwMynU1+xL2XXITLIGw==
X-Received: by 2002:a5d:428d:: with SMTP id k13mr18103314wrq.269.1627287640762;
        Mon, 26 Jul 2021 01:20:40 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id w13sm4799464wru.72.2021.07.26.01.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:20:40 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v4 4/5] iio/adc: ingenic: add JZ4760B support to the sadc driver
Date:   Mon, 26 Jul 2021 10:20:32 +0200
Message-Id: <20210726082033.351533-5-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726082033.351533-1-cbranchereau@gmail.com>
References: <20210726082033.351533-1-cbranchereau@gmail.com>
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
 drivers/iio/adc/ingenic-adc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 6b9af0530590..2b3912c6ca6b 100644
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
 
@@ -906,6 +915,7 @@ static const struct of_device_id ingenic_adc_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
 	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
 	{ .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data, },
+	{ .compatible = "ingenic,jz4760b-adc", .data = &jz4760_adc_soc_data, },
 	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, },
 	{ },
 };
-- 
2.30.2

