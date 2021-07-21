Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB13D0DCE
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbhGUKxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbhGUKNV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 06:13:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2443CC061787;
        Wed, 21 Jul 2021 03:53:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso721894wmj.4;
        Wed, 21 Jul 2021 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7v97uOlBwT4OrFzYVbsPPOFedr+R7QC0/QmK3MubLWQ=;
        b=fOWeBQZVIV2VIeb/neqJb5lr+1h0+stsZqwAeARF+m9+ucVNv7om6aAvVJcLBp/G9B
         RobTIwDVhqHIU/smrxWmFSdv6nclXgULq95IM2IpXubkUkQEU0s6xEenegb6+JfD63+z
         xggJw9+qtLTvKXvttEvV93PJikWL8irBX3X6pFUhM4bLQzFeOzrse7LP1BsQ5MYweFZs
         P3kPYvIaSU2v0Q62kh8KwiqDB2fwmB14pDpKzH7MsO5BltOo65A9Y/KaqV4GafsnhImB
         5S6E7FsLW7oA0rpYadO38oyo+hwcpygm6RIw0YhxtTvKGanA87Tv9qBKF2gykOFZm8I6
         OqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7v97uOlBwT4OrFzYVbsPPOFedr+R7QC0/QmK3MubLWQ=;
        b=nVQLQFIrMtOs0PsYz8pVPgvxChaH7EtLeEtWD2XcVe4KbMET6nEak8ITzhTBAmWi2y
         UMUJSk7rD+vSi6liQLbVEOcxFH6xcyDPvZDf1iUeIyz7WFi9xEiC51vtLg93B3xqjT0h
         3IrZhUj0+4b5AY0RczsyXyQWzZgzKZ70qWfYn+4byG00Lf0PR1umndOnXQ6aiTcgWtd0
         xGutQKsFMvl82DW7T/sf2zjnJGzK9XfwjHHBQ76Qny3nTrP1AhH5/EHc0ORMiut/8V/T
         xkVmfB1j2TMPVx0SdDd5xUTF9duZrJZTJtQrvwB1oJf7vH74RqEbit8JN38Rvzcpscm2
         PW2g==
X-Gm-Message-State: AOAM533b/Ke2lmTHipzNLvjGcia2haXbCJUra6qhqIbCt1h6Uv8CyCv2
        kuOYhpx3QcskVQYllNbTg/0=
X-Google-Smtp-Source: ABdhPJzfVEY7ySStwrrenmzYYXnKVTxpAVUnOQEflE57uaUMmbhvQL32C5PODbunmSTeeFgokODHEw==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr3370724wmk.97.1626864815676;
        Wed, 21 Jul 2021 03:53:35 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id o14sm26933641wrj.66.2021.07.21.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:53:35 -0700 (PDT)
From:   citral23 <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, citral23 <cbranchereau@gmail.com>
Subject: [PATCH 4/6] iio/adc: ingenic: add JZ4760B support to the sadc driver
Date:   Wed, 21 Jul 2021 12:53:15 +0200
Message-Id: <20210721105317.36742-5-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721105317.36742-1-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The JZ4760B variant differs slightly from the JZ4760, in that it has a bit called VBAT_SEL
in the CFG register. In order to correctly sample the battery voltage on existing handhelds
using this SOC, the bit must be cleared.

We leave the possibility to set the bit, by using the "ingenic,use-internal-divider" in the devicetree.

Signed-off-by: citral23 <cbranchereau@gmail.com>
---
 drivers/iio/adc/ingenic-adc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 285e7aa8e37a..618150475421 100644
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
@@ -869,6 +870,10 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	/* Put hardware in a known passive state. */
 	writeb(0x00, adc->base + JZ_ADC_REG_ENABLE);
 	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
+
+	if (!device_property_present(dev, "ingenic,use-internal-divider")) /* JZ4760B specific */
+		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_VBAT_SEL, 0);
+
 	usleep_range(2000, 3000); /* Must wait at least 2ms. */
 	clk_disable(adc->clk);
 
@@ -896,6 +901,7 @@ static const struct of_device_id ingenic_adc_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
 	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
 	{ .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data, },
+	{ .compatible = "ingenic,jz4760b-adc", .data = &jz4760_adc_soc_data, },
 	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, },
 	{ },
 };
-- 
2.30.2

