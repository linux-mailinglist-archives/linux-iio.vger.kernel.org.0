Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF19128CA
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 09:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfECH2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 03:28:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfECH2j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 03:28:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so2318430pgl.5;
        Fri, 03 May 2019 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e+8X3jpzX2axqpodG5rv/zXjSeBjdMvSndQlz4t6nbo=;
        b=duUSP7MUL4/J85YW5hqaSOb87iG/NFCOT5u5XorwFhbcE5qeGEjVOQvHS/c/DNU3dQ
         RBSJCP5KHneS8mkIfw7ovpg3oosItY0y98eEWWqpbAXVYnE65MqFKxJ3ORABwrpS93mf
         Dn5h7SkIJJCcY0TRftWU+cW6oPHfc87XqK5XylRnZScjIrJ46AQJ+gNVX9uZOYiczz8G
         PHphuyQ5szjLzXk+yg/SZJ8by6vafhgZx9bIOM1oMbx52nj/Kz31FkOdSkpLwxzqnUH7
         7Ee5HmDGNW6d2bzrEsgV3/QFKNXi6+C5Nxzp5qXjsavSmDGRPidD+KVLyfx9hhJDAY5l
         wbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e+8X3jpzX2axqpodG5rv/zXjSeBjdMvSndQlz4t6nbo=;
        b=gRNtC5b4nDzZ9Zsvo5R/gamawmKg+Ko/cFihR4amOax1SHbVMfg5QlTYm3Kei55ZXu
         me1qjbenGzNB9dwjiZXOucok7UVmJQuVebkBszISKaMxeHOrd3fYM98P7LLH3Z2SlRQm
         sz4ddt1+cSkWvHIZAfhIroY4T/p7FYa6cdB0aC51CcJNs3ut9ZaxKVudM02uvYyFdFGR
         3ceYvV7CBXJ61IWQPSkUtP3QEohZgnv5lhhMV2ISfY1Wg2d0R8XM2VXSGN6aNUHTGK6m
         CmQ5aeiZRnMf2DDOWafHFPNvuDszCr195X82j6hxsxS0RmfBXpV+vxCI/Q12zmFnygtU
         74Fw==
X-Gm-Message-State: APjAAAUmj+mQb5kGOTLDnSWmPL5ADpbEoTXNVdOUBh0knwSLSK0hQSvZ
        PT2+rXC4/t7tqo+8BGNzvv0=
X-Google-Smtp-Source: APXvYqyo+FeWJtf/DfiX1DWQ9UwQWJKvX9mL2ppHGlZ846WHvAKvURFV+G/AL8NV+i2yfCxzm5pepQ==
X-Received: by 2002:a62:5542:: with SMTP id j63mr8768993pfb.34.1556868518500;
        Fri, 03 May 2019 00:28:38 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id k26sm1663560pfi.136.2019.05.03.00.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:28:37 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 6/7] iio: adc: sun4i-gpadc-iio: add support for H6 thermal sensor
Date:   Fri,  3 May 2019 03:28:12 -0400
Message-Id: <20190503072813.2719-7-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190503072813.2719-1-tiny.windzz@gmail.com>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds support for the H6 ths sensor.

TODO: calibrate thermal sensor by using information from sid.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 65 +++++++++++++++++++++++++++++++
 include/linux/mfd/sun4i-gpadc.h   |  9 +++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index f24eb76d65c0..9b6fc592f54c 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -120,6 +120,20 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
+static int sun50i_gpadc_disable(struct sun4i_gpadc_iio *info);
+static int sun50i_gpadc_enable(struct sun4i_gpadc_iio *info);
+
+static const struct gpadc_data sun50i_h6_gpadc_data = {
+	.temp_offset = -2809,
+	.temp_scale = -67,
+	.has_bus_clk = true,
+	.has_bus_rst = true,
+	.gpadc_enable = sun50i_gpadc_enable,
+	.gpadc_disable = sun50i_gpadc_disable,
+	.sensor_count = 2,
+	.temp_data_base = SUN50I_H6_GPADC_TEMP_DATA,
+};
+
 struct sun4i_sensor_tzd {
 	struct sun4i_gpadc_iio          *info;
 	struct thermal_zone_device      *tzd;
@@ -452,6 +466,53 @@ static int sun4i_gpadc_enable(struct sun4i_gpadc_iio *info)
 	return 0;
 }
 
+static int sun50i_gpadc_enable(struct sun4i_gpadc_iio *info)
+{
+	int ret, val;
+
+	ret = reset_control_deassert(info->reset);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(info->bus_clk);
+	if (ret)
+		goto assert_reset;
+
+	/*
+	 * clkin = 24MHz
+	 * T acquire = clkin / (SUN50I_GPADC_CTRL0_T_ACQ + 1)
+	 *           = 20us
+	 */
+	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
+		     SUN50I_GPADC_CTRL0_T_ACQ(479));
+	/* average over 4 samples */
+	regmap_write(info->regmap, SUN50I_H6_GPADC_CTRL3,
+		     SUN4I_GPADC_CTRL3_FILTER_EN |
+		     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
+	/* period = (SUN50I_GPADC_TPR_TEMP_PERIOD + 1) * 4096 / clkin; ~10ms */
+	regmap_write(info->regmap, SUN50I_GPADC_TPR,
+		     SUN50I_GPADC_TPR_TEMP_PERIOD(58));
+	/* TODO: calibrate ths */
+	/* enable sensor */
+	val = GENMASK(info->data->sensor_count - 1, 0);
+	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, val);
+
+	return 0;
+
+assert_reset:
+	reset_control_assert(info->reset);
+
+	return ret;
+}
+
+static int sun50i_gpadc_disable(struct sun4i_gpadc_iio *info)
+{
+	clk_disable_unprepare(info->bus_clk);
+	reset_control_assert(info->reset);
+
+	return 0;
+}
+
 static int sun4i_gpadc_runtime_suspend(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
@@ -546,6 +607,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
 		.compatible = "allwinner,sun8i-a33-ths",
 		.data = &sun8i_a33_gpadc_data,
 	},
+	{
+		.compatible = "allwinner,sun50i-h6-ths",
+		.data = &sun50i_h6_gpadc_data,
+	},
 	{ /* sentinel */ }
 };
 
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 139872c2e0fe..f505013e9c0d 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -19,6 +19,9 @@
 #define SUN4I_GPADC_CTRL0_FS_DIV(x)			((GENMASK(3, 0) & (x)) << 16)
 #define SUN4I_GPADC_CTRL0_T_ACQ(x)			(GENMASK(15, 0) & (x))
 
+/* TP_CTRL0 bits for sun50i SOCs */
+#define SUN50I_GPADC_CTRL0_T_ACQ(x)			((GENMASK(15, 0) & (x)) << 16)
+
 #define SUN4I_GPADC_CTRL1				0x04
 
 #define SUN4I_GPADC_CTRL1_STYLUS_UP_DEBOUNCE(x)		((GENMASK(7, 0) & (x)) << 12)
@@ -49,6 +52,9 @@
 #define SUN4I_GPADC_CTRL2_PRE_MEA_EN			BIT(24)
 #define SUN4I_GPADC_CTRL2_PRE_MEA_THRE_CNT(x)		(GENMASK(23, 0) & (x))
 
+#define SUN50I_GPADC_TPR				0x08
+#define SUN50I_GPADC_TPR_TEMP_PERIOD(x)			((GENMASK(19, 0) & (x)) << 12)
+
 #define SUN4I_GPADC_CTRL3				0x0c
 
 #define SUN4I_GPADC_CTRL3_FILTER_EN			BIT(2)
@@ -84,6 +90,9 @@
 #define SUN4I_GPADC_TEMP_DATA				0x20
 #define SUN4I_GPADC_DATA				0x24
 
+#define SUN50I_H6_GPADC_CTRL3				0x30
+#define SUN50I_H6_GPADC_TEMP_DATA			0xc0
+
 #define SUN4I_GPADC_IRQ_FIFO_DATA			0
 #define SUN4I_GPADC_IRQ_TEMP_DATA			1
 
-- 
2.17.1

