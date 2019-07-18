Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60DEE6CA8B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbfGRIBg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 04:01:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40751 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389321AbfGRIBf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 04:01:35 -0400
X-UUID: 4512913e817a4a958b64f5ef79152754-20190718
X-UUID: 4512913e817a4a958b64f5ef79152754-20190718
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 556583377; Thu, 18 Jul 2019 16:01:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Jul 2019 16:01:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Jul 2019 16:01:25 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <jg_poxu@mediatek.com>, <sj.huang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
        <erin.lo@mediatek.com>, <eddie.huang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v1 2/2] auxadc: mediatek: support efuse calibration in auxadc driver
Date:   Thu, 18 Jul 2019 16:01:19 +0800
Message-ID: <20190718080119.30707-3-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20190718080119.30707-1-zhiyong.tao@mediatek.com>
References: <20190718080119.30707-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch support efuse calibration in auxadc driver

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: jg_poxu <jg_poxu@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 71 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 95d76abb64ec..e30d9736b1a5 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -17,12 +17,14 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/iopoll.h>
 #include <linux/io.h>
 #include <linux/iio/iio.h>
+#include <linux/slab.h>
 
 /* Register definitions */
 #define MT6577_AUXADC_CON0                    0x00
@@ -42,6 +44,13 @@
 #define MT6577_AUXADC_POWER_READY_MS          1
 #define MT6577_AUXADC_SAMPLE_READY_US         25
 
+#define ADC_GE_A_SHIFT      10
+#define ADC_GE_A_MASK       (0x3ff << ADC_GE_A_SHIFT)
+#define ADC_OE_A_SHIFT      0
+#define ADC_OE_A_MASK       (0x3ff << ADC_OE_A_SHIFT)
+#define ADC_CALI_EN_A_SHIFT 20
+#define ADC_CALI_EN_A_MASK  (0x1 << ADC_CALI_EN_A_SHIFT)
+
 struct mt6577_auxadc_device {
 	void __iomem *reg_base;
 	struct clk *adc_clk;
@@ -74,6 +83,64 @@ static const struct iio_chan_spec mt6577_auxadc_iio_channels[] = {
 	MT6577_AUXADC_CHANNEL(15),
 };
 
+s32 cali_oe;
+s32 cali_ge;
+struct adc_cali_info {
+	u32 cali_ge_a;
+	u32 cali_oe_a;
+	u32 gain;
+};
+static struct adc_cali_info adc_cali;
+
+static int mt6577_auxadc_update_cali(struct device *dev)
+{
+	struct nvmem_cell *cell;
+	u32 *buf;
+	size_t len;
+	int ret = 0;
+
+	cali_oe = 0;
+	cali_ge = 0;
+
+	cell = nvmem_cell_get(dev, "calibration-data");
+	if (IS_ERR(cell)) {
+		if (PTR_ERR(cell) == -EPROBE_DEFER)
+			return PTR_ERR(cell);
+		return 0;
+	}
+
+	buf = (u32 *)nvmem_cell_read(cell, &len);
+
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (len < sizeof(u32)) {
+		dev_warn(dev, "invalid calibration data\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (((buf[0] & ADC_CALI_EN_A_MASK) >> ADC_CALI_EN_A_SHIFT) != 0) {
+		adc_cali.cali_oe_a =
+			(buf[0] & ADC_OE_A_MASK) >> ADC_OE_A_SHIFT;
+		adc_cali.cali_ge_a =
+			((buf[0] & ADC_GE_A_MASK) >> ADC_GE_A_SHIFT);
+
+		cali_ge = adc_cali.cali_ge_a - 512;
+		cali_oe = adc_cali.cali_oe_a - 512;
+		adc_cali.gain = 1 + cali_ge;
+	}  else {
+		dev_info(dev, "Device not calibrated, using default calibration values\n");
+	}
+
+out:
+	kfree(buf);
+
+	return ret;
+}
+
 static inline void mt6577_auxadc_mod_reg(void __iomem *reg,
 					 u32 or_mask, u32 and_mask)
 {
@@ -274,6 +341,10 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 		goto err_power_off;
 	}
 
+	ret = mt6577_auxadc_update_cali(&pdev->dev);
+	if (ret)
+		return ret;
+
 	return 0;
 
 err_power_off:
-- 
2.12.5

