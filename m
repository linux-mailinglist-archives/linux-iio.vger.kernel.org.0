Return-Path: <linux-iio+bounces-7540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8105C92FA8A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024581F22D50
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2967517164B;
	Fri, 12 Jul 2024 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QGyfSoVO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091316F848;
	Fri, 12 Jul 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788300; cv=none; b=FK/h4UWQQcNGDLcI//UAkU+qq5AmCTAXxKWwknxBK/Q12TQtk5ekBATzVU5AyTes5ppWhh2xcjJ4TGaU3X1KTHbiI4dyLX4B6uW1OKlss4PLR4Y96MmhdDymdmBdt0AfYj5Pgi8m2TTfklmUxWCzB6V2RlUQgtvq9LF8w1lZ28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788300; c=relaxed/simple;
	bh=XED/XmFhc1Ds7+nd2W8muR54svIrPQy95BDqvx3Nea4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ptTIZBC6FcW04ayRB6X1F/npai8Vwh9A/qDAG1ioeylNhkUEEZn1S+VKQNHxbtKhh5FuIZ4VYuRltrOyG2rMeILSeBa6nCF/y3/+yPbRl2yzyGf3E8H3A24McKV9FRkqGDcq/e0E6WY3SHUeqLgZa2yxyhx/xm/TvsjHcPkcS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QGyfSoVO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C3LLht011628;
	Fri, 12 Jul 2024 12:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IsGU/rjkxMDFyd56KUf32egz0v6vp7eWZC1Rr57iv5A=; b=QGyfSoVOx9qwO80O
	N6XjYg3faCum13aLReRJtIt9GNwMfenWX5VbClYQB2iwAvjsxT6st1A6xRtRaFk1
	y1+fQ5uhlYWtdmHDc2bFpssqbtZorQOJ40V2WgGFm5EkGI1Spnspbk1EjurekFeV
	/LQc7AUC6li/sZgLAaMAUFE0zi/tnA97RlpmriVwbPgYAuezvO8A9DvtV0K1v4YT
	eeveGzMkc4Ngyl9p7UBzNtIB7WGts3h1Yw9VMHaRuURSbLFIKl6/W/o8Z0v1OOeC
	l0z4Lo4T9keaUnKejLUvNhnwCOb1OJqD/d2PNDUUlWcOkPLX44UUwAJUQdVh56g3
	hl1D3w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwy8yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46CCidal028031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 12:44:39 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Jul 2024 05:44:32 -0700
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Fri, 12 Jul 2024 18:13:30 +0530
Subject: [PATCH 3/5] thermal: qcom: Add support for MBG Temp monitor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240712-mbg-tm-support-v1-3-7d78bec920ca@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
In-Reply-To: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Thara
 Gopinath" <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Kamal Wadhwa <quic_kamalw@quicinc.com>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fIuBoHZpjo_oqHlzSkSitOBB-eFRpaJy
X-Proofpoint-ORIG-GUID: fIuBoHZpjo_oqHlzSkSitOBB-eFRpaJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120086

Add driver for the MBG thermal monitoring device. It monitors
the die temperature, and when there is a level 1 upper threshold
violation, it receives an interrupt over spmi. The driver reads
the fault status register and notifies thermal accordingly.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 drivers/thermal/qcom/Kconfig            |  11 ++
 drivers/thermal/qcom/Makefile           |   1 +
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 269 ++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26eb..46045094020c 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -21,6 +21,17 @@ config QCOM_SPMI_ADC_TM5
 	  Thermal client sets threshold temperature for both warm and cool and
 	  gets updated when a threshold is reached.
 
+config QCOM_SPMI_MBG_TM
+	tristate "Qualcomm Technologies, Inc. SPMI PMIC MBG Temperature monitor"
+	depends on OF && SPMI && IIO
+	select REGMAP_SPMI
+	help
+	 This enables a thermal driver for the MBG thermal monitoring device.
+	 It shows up in sysfs as a thermal sensor with two trip points.
+	 It notifies the thermal framework when level 1 high threshold is
+	 violated. The temperature reported by the thermal sensor reflects
+	 the real time die temperature through ADC channel.
+
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
 	depends on OF && SPMI && IIO
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 0fa2512042e7..bc18e08ee3e2 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
 				   tsens-8960.o
 obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
+obj-$(CONFIG_QCOM_SPMI_MBG_TM)	+= qcom-spmi-mbg-tm.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_QCOM_LMH)		+= lmh.o
diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
new file mode 100644
index 000000000000..70964ea5a48d
--- /dev/null
+++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+#include <linux/iio/consumer.h>
+
+#include "../thermal_core.h"
+
+#define MBG_TEMP_MON_MM_MON2_FAULT_STATUS	0x50
+
+#define MON_FAULT_STATUS_MASK			GENMASK(7, 6)
+#define MON_FAULT_STATUS_SHIFT			6
+#define MON2_LVL1_ERR				0x1
+
+#define MON2_LVL1_UP_THRESH			0x59
+
+#define MBG_TEMP_MON_MM_MON2_MISC_CFG		0x5f
+#define UP_THRESH_EN				BIT(1)
+
+#define STEP_MV					8
+#define MBG_DEFAULT_TEMP_MV			600
+#define MBG_TEMP_CONSTANT			1000
+#define MIN_TRIP_TEMP				25000
+#define MAX_SUPPORTED_TEMP			160000
+
+struct mbg_tm_chip {
+	struct regmap			*map;
+	struct device			*dev;
+	struct thermal_zone_device	*tz_dev;
+	struct mutex                    lock;
+	unsigned int			base;
+	int				irq;
+	int				last_temp;
+	bool				last_temp_set;
+	struct iio_channel		*adc;
+};
+
+struct mbg_map_table {
+	int min_temp;
+	int vtemp0;
+	int tc;
+};
+
+static const struct mbg_map_table map_table[] = {
+	/* minT	vtemp0	tc */
+	{ -60000, 4337, 1967 },
+	{ -40000, 4731, 1964 },
+	{ -20000, 5124, 1957  },
+	{ 0,      5515, 1949 },
+	{ 20000,  5905, 1940 },
+	{ 40000,  6293, 1930 },
+	{ 60000,  6679, 1921 },
+	{ 80000,  7064, 1910 },
+	{ 100000, 7446, 1896 },
+	{ 120000, 7825, 1878 },
+	{ 140000, 8201, 1859 },
+};
+
+static int mbg_tm_read(struct mbg_tm_chip *chip, u16 addr, int *data)
+{
+	return regmap_read(chip->map, chip->base + addr, data);
+}
+
+static int mbg_tm_write(struct mbg_tm_chip *chip, u16 addr, int data)
+{
+	return regmap_write(chip->map, chip->base + addr, data);
+}
+
+static int mbg_tm_reg_update(struct mbg_tm_chip *chip, u16 addr, u8 mask, u8 val)
+{
+	return regmap_write_bits(chip->map, chip->base + addr, mask, val);
+}
+
+static int mbg_tm_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
+	int ret, milli_celsius;
+
+	if (!temp)
+		return -EINVAL;
+
+	if (chip->last_temp_set) {
+		pr_debug("last_temp: %d\n", chip->last_temp);
+		chip->last_temp_set = false;
+		*temp = chip->last_temp;
+		return 0;
+	}
+
+	ret = iio_read_channel_processed(chip->adc, &milli_celsius);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to read iio channel %d\n", ret);
+		return ret;
+	}
+
+	*temp = milli_celsius;
+
+	return 0;
+}
+
+static int temp_to_vtemp(int temp)
+{
+
+	int idx, vtemp, tc = 0, t0 = 0, vtemp0 = 0;
+
+	if (temp > MAX_SUPPORTED_TEMP)
+		temp = MAX_SUPPORTED_TEMP - MBG_TEMP_CONSTANT;
+
+	for (idx = 0; idx < ARRAY_SIZE(map_table); idx++)
+		if (temp >= map_table[idx].min_temp &&
+				temp < (map_table[idx].min_temp + 20000)) {
+			tc = map_table[idx].tc;
+			t0 = map_table[idx].min_temp;
+			vtemp0 = map_table[idx].vtemp0;
+			break;
+		}
+
+	/*
+	 * Formula to calculate vtemp(mV) from a given temp
+	 * vtemp = (temp - minT) * tc + vtemp0
+	 * tc, t0 and vtemp0 values are mentioned in the map_table array.
+	 */
+	vtemp = ((temp - t0) * tc + vtemp0 * 100000) / 1000000;
+
+	return abs(vtemp - MBG_DEFAULT_TEMP_MV) / STEP_MV;
+}
+
+static int mbg_tm_set_trip_temp(struct thermal_zone_device *tz, int low_temp,
+						int temp)
+{
+	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
+	int ret = 0, vtemp = 0;
+
+	mutex_lock(&chip->lock);
+
+	/* The HW has a limitation that the trip set must be above 25C */
+	if (temp > MIN_TRIP_TEMP && temp < INT_MAX) {
+		mbg_tm_reg_update(chip, MBG_TEMP_MON_MM_MON2_MISC_CFG,
+					 UP_THRESH_EN, UP_THRESH_EN);
+		vtemp = temp_to_vtemp(temp);
+		ret = mbg_tm_write(chip, MON2_LVL1_UP_THRESH, vtemp);
+		if (ret < 0) {
+			mutex_unlock(&chip->lock);
+			return ret;
+		}
+	} else {
+		dev_dbg(chip->dev, "Setting %d failed, set trip between 25C and INT_MAX\n", temp);
+		mbg_tm_reg_update(chip, MBG_TEMP_MON_MM_MON2_MISC_CFG,
+					UP_THRESH_EN, 0);
+	}
+
+	mutex_unlock(&chip->lock);
+
+	/*
+	 * Configure the last_temp one degree higher, to ensure the
+	 * violated temp is returned to thermal framework when it reads
+	 * temperature for the first time after the violation happens.
+	 * This is needed to account for the inaccuracy in the conversion
+	 * formula used which leads to the thermal framework setting back
+	 * the same thresholds in case the temperature it reads does not
+	 * show violation.
+	 */
+	chip->last_temp = temp + MBG_TEMP_CONSTANT;
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops mbg_tm_ops = {
+	.get_temp = mbg_tm_get_temp,
+	.set_trips = mbg_tm_set_trip_temp,
+};
+
+static irqreturn_t mbg_tm_isr(int irq, void *data)
+{
+	struct mbg_tm_chip *chip = data;
+	int ret;
+	int val = 0;
+
+	mutex_lock(&chip->lock);
+
+	ret = mbg_tm_read(chip, MBG_TEMP_MON_MM_MON2_FAULT_STATUS, &val);
+
+	mutex_unlock(&chip->lock);
+
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	val &= MON_FAULT_STATUS_MASK;
+	if ((val >> MON_FAULT_STATUS_SHIFT) & MON2_LVL1_ERR) {
+		chip->last_temp_set = true;
+		thermal_zone_device_update(chip->tz_dev,
+					THERMAL_TRIP_VIOLATED);
+		dev_dbg(chip->dev, "Notifying Thermal, fault status=%d\n", val);
+	} else {
+		dev_dbg(chip->dev, "Lvl 1 upper threshold not violated, ignoring interrupt\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int mbg_tm_probe(struct platform_device *pdev)
+{
+	struct mbg_tm_chip *chip;
+	struct device_node *node = pdev->dev.of_node;
+	u32 res;
+	int ret = 0;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &pdev->dev;
+
+	mutex_init(&chip->lock);
+
+	chip->map = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!chip->map)
+		return -ENXIO;
+
+	ret = of_property_read_u32(node, "reg", &res);
+	if (ret < 0)
+		return ret;
+
+	chip->base = res;
+
+	chip->irq = platform_get_irq(pdev, 0);
+	if (chip->irq < 0)
+		return chip->irq;
+
+	chip->adc = devm_iio_channel_get(&pdev->dev, "thermal");
+	if (IS_ERR(chip->adc))
+		return PTR_ERR(chip->adc);
+
+	chip->tz_dev = devm_thermal_of_zone_register(&pdev->dev,
+				 0, chip, &mbg_tm_ops);
+	if (IS_ERR(chip->tz_dev)) {
+		dev_err(&pdev->dev, "failed to register sensor\n");
+		return PTR_ERR(chip->tz_dev);
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, NULL,
+			mbg_tm_isr, IRQF_ONESHOT, node->name, chip);
+
+	return ret;
+}
+
+static const struct of_device_id mbg_tm_match_table[] = {
+	{ .compatible = "qcom,spmi-mbg-tm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mbg_tm_match_table);
+
+static struct platform_driver mbg_tm_driver = {
+	.driver = {
+		.name = "qcom-spmi-mbg-tm",
+		.of_match_table = mbg_tm_match_table,
+	},
+	.probe  = mbg_tm_probe,
+};
+module_platform_driver(mbg_tm_driver);
+
+MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
+MODULE_LICENSE("GPL");

-- 
2.25.1


