Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3728E770390
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjHDOv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjHDOvZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 10:51:25 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F26AC
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 07:51:23 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 374DG9As011488;
        Fri, 4 Aug 2023 10:51:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s8gfs64wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 10:51:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 374EpKr3038427
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 10:51:20 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 4 Aug 2023 10:51:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 4 Aug 2023 10:51:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Aug 2023 10:51:18 -0400
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 374Ep87j010508;
        Fri, 4 Aug 2023 10:51:14 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 3/3] iio: adc: adi-axi-adc: add based on new converter framework
Date:   Fri, 4 Aug 2023 16:53:41 +0200
Message-ID: <20230804145342.1600136-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804145342.1600136-1-nuno.sa@analog.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: fRYAJ2pksev9p7Is8mq4Ilx-f0WEMdGo
X-Proofpoint-GUID: fRYAJ2pksev9p7Is8mq4Ilx-f0WEMdGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308040133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc-new.c | 405 ++++++++++++++++++++++++++++++
 1 file changed, 405 insertions(+)
 create mode 100644 drivers/iio/adc/adi-axi-adc-new.c

diff --git a/drivers/iio/adc/adi-axi-adc-new.c b/drivers/iio/adc/adi-axi-adc-new.c
new file mode 100644
index 000000000000..7ee24f765d07
--- /dev/null
+++ b/drivers/iio/adc/adi-axi-adc-new.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices Generic AXI ADC IP core
+ * Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+ *
+ * Copyright 2012-2023 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/limits.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <linux/fpga/adi-axi-common.h>
+#include <linux/iio/addc/converter.h>
+
+/*
+ * Register definitions:
+ *   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip#register_map
+ */
+
+/* ADC systhesis configuration*/
+#define AXI_ADC_REG_CONFIG			0x000c
+#define   AXI_ADC_DATAFORMAT_DISABLE_MASK	BIT(2)
+
+/* ADC controls */
+#define AXI_ADC_REG_RSTN			0x0040
+#define   AXI_ADC_RSTN_RESET_MASK		GENMASK(1, 0)
+#define   AXI_ADC_RSTN_MMCM_RSTN		BIT(1)
+#define   AXI_ADC_RSTN_RSTN			BIT(0)
+
+#define AXI_ADC_REG_CTRL			0x0044
+#define    AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
+
+/* ADC Channel controls */
+#define AXI_ADC_REG_CHAN_CTRL(c)		(0x0400 + (c) * 0x40)
+#define   AXI_ADC_CHAN_CTRL_FMT_MASK		GENMASK(6, 4)
+#define   AXI_ADC_CHAN_CTRL_FMT_EN		BIT(0)
+#define   AXI_ADC_CHAN_CTRL_FMT_BIN_OFF		BIT(1)
+#define   AXI_ADC_CHAN_CTRL_FMT_SIGEXT		BIT(2)
+#define   AXI_ADC_CHAN_CTRL_EN_MASK		BIT(0)
+
+#define AXI_ADC_REG_CHAN_STATUS(c)		(0x0404 + (c) * 0x40)
+#define   AXI_ADC_CHAN_STAT_PN_MASK		GENMASK(2, 1)
+
+#define AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
+#define   AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
+
+/* IO Delays */
+#define AXI_ADC_REG_DELAY(l)			(0x0800 + (l) * 0x4)
+#define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
+
+enum {
+	AXI_ADC_PN9A,
+	AXI_ADC_PN23A,
+	AXI_ADC_PN7 = 0x4,
+	AXI_ADC_PN15,
+	AXI_ADC_PN23,
+	AXI_ADC_PN31,
+	AXI_ADC_PNX = 0x9,
+	AXI_ADC_RAMP_NIBBLE,
+	AXI_ADC_RAMP_16,
+};
+
+struct axi_adc_state {
+	struct regmap *regmap;
+	/* Protect against concurrent access to the device registers */
+	struct mutex lock;
+	struct device *dev;
+	u32 capabilities;
+};
+
+static int axi_adc_iodelay_set(struct converter_backend *conv,
+			       unsigned int num_lanes, unsigned int delay)
+{
+	struct axi_adc_state *st = converter_get_drvdata(conv);
+	unsigned int l;
+	u32 val;
+	int ret;
+
+	if (delay > FIELD_MAX(AXI_ADC_DELAY_CTRL_MASK))
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+	for (l = 0; l < num_lanes; l++) {
+		ret = regmap_update_bits(st->regmap, AXI_ADC_REG_DELAY(l),
+					 AXI_ADC_DELAY_CTRL_MASK, delay);
+		if (ret)
+			break;
+		/*
+		 * If a readback is ~0, that means there are issues with the
+		 * delay_clk
+		 */
+		ret = regmap_read(st->regmap, AXI_ADC_REG_DELAY(l), &val);
+		if (val == U32_MAX) {
+			ret = -EIO;
+			break;
+		}
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int axi_adc_ddr_edge_set(struct converter_backend *conv,
+				enum converter_edge edge)
+{
+	struct axi_adc_state *st = converter_get_drvdata(conv);
+
+	if (edge == CONVERTER_RISING_EDGE_SAMPLE)
+		return regmap_clear_bits(st->regmap, AXI_ADC_REG_CTRL,
+					 AXI_ADC_CTRL_DDR_EDGESEL_MASK);
+	if (edge == CONVERTER_FALLING_EDGE_SAMPLE)
+		return regmap_set_bits(st->regmap, AXI_ADC_REG_CTRL,
+				       AXI_ADC_CTRL_DDR_EDGESEL_MASK);
+
+	return -EINVAL;
+}
+
+static const struct converter_test_pattern_xlate axi_adc_test_pattern[] = {
+	{CONVERTER_PRBS_7, AXI_ADC_PN7},
+	{CONVERTER_PRBS_15, AXI_ADC_PN15},
+	{CONVERTER_PRBS_15, AXI_ADC_PN15},
+	{CONVERTER_PRBS_23, AXI_ADC_PN23},
+	{CONVERTER_PRBS_31, AXI_ADC_PN31},
+	{CONVERTER_ADI_PRBS_9A, AXI_ADC_PN9A},
+	{CONVERTER_ADI_PRBS_23A, AXI_ADC_PN23A},
+	{CONVERTER_ADI_PRBS_X, AXI_ADC_PNX},
+	{CONVERTER_RAMP_NIBBLE, AXI_ADC_RAMP_NIBBLE},
+	{CONVERTER_RAMP_16, AXI_ADC_RAMP_16},
+};
+
+static int axi_adc_test_pattern_set(struct converter_backend *conv,
+				    unsigned int chan,
+				    enum converter_test_pattern pattern)
+{
+	struct axi_adc_state *st = converter_get_drvdata(conv);
+	u32 val;
+
+	val = converter_test_pattern_xlate(pattern, axi_adc_test_pattern);
+	if (val < 0)
+		return val;
+
+	return regmap_update_bits(st->regmap, AXI_ADC_REG_CHAN_CTRL_3(chan),
+				  AXI_ADC_CHAN_PN_SEL_MASK,
+				  FIELD_PREP(AXI_ADC_CHAN_PN_SEL_MASK, val));
+}
+
+static int axi_adc_chan_status_get(struct converter_backend *conv,
+				   unsigned int chan,
+				   struct converter_chan_status *status)
+{
+	struct axi_adc_state *st = converter_get_drvdata(conv);
+	int ret;
+	u32 val;
+
+	mutex_lock(&st->lock);
+
+	/* reset test bits by setting them */
+	ret = regmap_set_bits(st->regmap, AXI_ADC_REG_CHAN_STATUS(chan),
+			      AXI_ADC_CHAN_STAT_PN_MASK);
+	if (ret)
+		goto out_unlock;
+
+	fsleep(5000);
+
+	ret = regmap_read(st->regmap, AXI_ADC_REG_CHAN_STATUS(chan), &val);
+	if (ret)
+		goto out_unlock;
+
+	mutex_unlock(&st->lock);
+
+	if (AXI_ADC_CHAN_STAT_PN_MASK & val)
+		status->errors = true;
+
+	return 0;
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int axi_adc_chan_enable(struct converter_backend *conv,
+			       unsigned int chan)
+{
+	struct axi_adc_state *st = converter_get_drvdata(conv);
+
+	return regmap_set_bits(st->regmap, AXI_ADC_REG_CHAN_CTRL(chan),
+			       AXI_ADC_CHAN_CTRL_EN_MASK);
+}
+
+static int axi_adc_chan_disable(struct converter_backend *conv,
+				unsigned int chan)
+{
+	struct axi_adc_state *st = converter_get_drvdata(conv);
+
+	return regmap_clear_bits(st->regmap, AXI_ADC_REG_CHAN_CTRL(chan),
+				 AXI_ADC_CHAN_CTRL_EN_MASK);
+}
+
+static int axi_adc_data_format_set(struct converter_backend *conv,
+				   unsigned int chan,
+				   const struct converter_data_fmt *data)
+{
+	struct axi_adc_state *st = converter_get_drvdata(conv);
+	u32 val = 0;
+
+	if (FIELD_GET(AXI_ADC_DATAFORMAT_DISABLE_MASK, st->capabilities))
+		/* data format not available */
+		return -ENOTSUPP;
+
+	if (!data->enable)
+		return regmap_clear_bits(st->regmap,
+					 AXI_ADC_REG_CHAN_CTRL(chan),
+					 AXI_ADC_CHAN_CTRL_FMT_MASK);
+
+	val = FIELD_PREP(AXI_ADC_CHAN_CTRL_FMT_MASK, AXI_ADC_CHAN_CTRL_FMT_EN);
+	if (data->sign_extend)
+		val |= FIELD_PREP(AXI_ADC_CHAN_CTRL_FMT_MASK,
+				  AXI_ADC_CHAN_CTRL_FMT_SIGEXT);
+
+	if (data->type == CONVERTER_OFFSET_BINARY)
+		val |= FIELD_PREP(AXI_ADC_CHAN_CTRL_FMT_MASK,
+				  AXI_ADC_CHAN_CTRL_FMT_BIN_OFF);
+
+	return regmap_update_bits(st->regmap, AXI_ADC_REG_CHAN_CTRL(chan),
+				  AXI_ADC_CHAN_CTRL_FMT_MASK, val);
+}
+
+static void __axi_adc_disable(const struct axi_adc_state *st)
+{
+	regmap_clear_bits(st->regmap, AXI_ADC_REG_RSTN,
+			  AXI_ADC_RSTN_RESET_MASK);
+}
+
+static int __axi_adc_enable(const struct axi_adc_state *st)
+{
+	return regmap_set_bits(st->regmap, AXI_ADC_REG_RSTN,
+			       AXI_ADC_RSTN_RESET_MASK);
+}
+
+static int axi_adc_enable(struct converter_backend *conv)
+{
+	return __axi_adc_enable(converter_get_drvdata(conv));
+}
+
+static void axi_adc_disable(struct converter_backend *conv)
+{
+	__axi_adc_disable(converter_get_drvdata(conv));
+}
+
+static int axi_adc_reset(struct axi_adc_state *st)
+{
+	int ret;
+
+	__axi_adc_disable(st);
+	fsleep(10);
+	ret = __axi_adc_enable(st);
+	if (ret)
+		return ret;
+
+	fsleep(10);
+	return 0;
+}
+
+static const struct regmap_config axi_adc_regmap_config = {
+	.val_bits = 32,
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x0800,
+};
+
+static int axi_adc_generic_init(struct converter_backend *conv,
+				struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	unsigned int ver, *expected_ver, ret;
+	struct axi_adc_state *st;
+	void __iomem *base;
+	struct clk *clk;
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->dev = dev;
+
+	expected_ver = (unsigned int *)device_get_match_data(dev);
+	if (!expected_ver)
+		return -ENODEV;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	st->regmap = devm_regmap_init_mmio(dev, base, &axi_adc_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	converter_set_drvdata(conv, st);
+	converter_set_regmap(conv, st->regmap);
+
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "clk_get failed with %ld\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	ret = axi_adc_reset(st);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, ADI_AXI_REG_VERSION, &ver);
+	if (ret)
+		return ret;
+
+	if (*expected_ver > ver) {
+		dev_err(&pdev->dev,
+			"IP core version is too old. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
+			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
+			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
+			ADI_AXI_PCORE_VER_MAJOR(ver),
+			ADI_AXI_PCORE_VER_MINOR(ver),
+			ADI_AXI_PCORE_VER_PATCH(ver));
+		return -ENODEV;
+	}
+
+	/* fetch synthesis capabilities */
+	ret = regmap_read(st->regmap, AXI_ADC_REG_CONFIG, &st->capabilities);
+	if (ret)
+		return ret;
+
+	dev_dbg(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) up\n",
+		ADI_AXI_PCORE_VER_MAJOR(ver),
+		ADI_AXI_PCORE_VER_MINOR(ver),
+		ADI_AXI_PCORE_VER_PATCH(ver));
+
+	/* up to the frontend to explicitly enable us */
+	__axi_adc_disable(st);
+	mutex_init(&st->lock);
+	return 0;
+}
+
+static const struct converter_ops adi_axi_adc_generic = {
+	.backend_init = axi_adc_generic_init,
+	.enable = axi_adc_enable,
+	.disable = axi_adc_disable,
+	.data_format_set = axi_adc_data_format_set,
+	.test_pattern_set = axi_adc_test_pattern_set,
+	.chan_enable = axi_adc_chan_enable,
+	.chan_disable = axi_adc_chan_disable,
+	.iodelay_set = axi_adc_iodelay_set,
+	.sample_edge_select = axi_adc_ddr_edge_set,
+	.chan_status = axi_adc_chan_status_get,
+};
+
+static int axi_adc_probe(struct platform_device *pdev)
+{
+	return converter_add(&pdev->dev, &adi_axi_adc_generic);
+}
+
+/*
+ * It actually matters to remove the converter in the .remove() hook. This means
+ * that the all the converters (an the frontend) will be tear down before running
+ * any specific devres cleanup (at the driver core level). What this all means is
+ * that we can use devm_ apis in .backend_init() and being sure those resources
+ * will be released before the frontend resources and before any devm_* used
+ * in .probe().
+ */
+static int axi_adc_remove(struct platform_device *pdev)
+{
+	converter_del(&pdev->dev);
+	return 0;
+}
+
+static unsigned int axi_adc_10_0_a = ADI_AXI_PCORE_VER(10, 0, 'a');
+
+/* Match table for of_platform binding */
+static const struct of_device_id axi_adc_of_match[] = {
+	{ .compatible = "adi,axi-adc-10.0.a-new", .data = &axi_adc_10_0_a },
+	{ /* end of list */ }
+};
+MODULE_DEVICE_TABLE(of, axi_adc_of_match);
+
+static struct platform_driver axi_adc_driver = {
+	.driver = {
+		.name = "axi-adc",
+		.of_match_table = axi_adc_of_match,
+	},
+	.probe = axi_adc_probe,
+	.remove = axi_adc_remove,
+};
+module_platform_driver(axi_adc_driver);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices Generic AXI ADC IP core driver");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONVERTER);
-- 
2.41.0

