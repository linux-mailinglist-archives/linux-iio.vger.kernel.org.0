Return-Path: <linux-iio+bounces-11648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83169B6C80
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 20:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3684EB21F0F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4065E1D07A1;
	Wed, 30 Oct 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mxVEI0h2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214B1CFEDE;
	Wed, 30 Oct 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730314850; cv=none; b=oNhrFvEdo2zon0pY0JpEI3+nmuUSVE+4MjHqS88dYrggnBEX7NDmLkYOaqA2ZHHwntP3CQ29dcxS0SVnTxuVO5s49XLRGl713DEjr8aeDAo/9JcnfCdj7DsDU2LiZJyzlLcbGC6bKTNfl/j3L9P5crYL0gfL+X+v8w70T97Lsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730314850; c=relaxed/simple;
	bh=gmw1kDOkt6a+avY+RffAKk5mou+gg54UZn5bAy8/lNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzp/QxNkaSgwHzdxcenk0yvP69FKmeAOmmkhlW8OT/tHulFxBSuRr7cuDp89cULZcVQLS2aOxTlh7optcY3kqqt+Ur289PzRJn/Qc6POq2zH1xaFN7NtHHVhigor0IjgFwxVHMc8Kr4zX4bPVKlPvxXyZZZNLDy9EQb/7WBgkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mxVEI0h2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UDWOId004036;
	Wed, 30 Oct 2024 19:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jj/FBYAC3oGe0nOgIamtCPgsPiWO2tqBLr2TXuLo0CA=; b=mxVEI0h2hcl0tkb2
	hqQ27nAjVUgYXcCTn/f1vxXdYdHq0qr1ohQKAb/CPAHxZV1x8HTxMicWW0hyXGWO
	E9aLy7bJYmZf3fplUQkdC4LyR7rQNYk5EgjkwABGcTh5zCt3U0AWhqVgLjSo+ZXi
	a36p9YXXXxZ1CDpjd9B5siO1LMEyCbFvmCjlLSK/FBBNVv2rjewz9wwcNzS+FeuI
	6IQIYExptgxGJ+9u+GGcnKPyasclWoZqAztzYM32d7Ltu4nozsFEw4R7OY5LNJiM
	9hd3cL6LGRrSxmLRhLyOBx8YMgvIonveGDu05REak43B9u5i3pwKXR7vIpBOOy4c
	PIk+ZA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kns3gwch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 19:00:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UJ0B5d003327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 19:00:11 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 12:00:02 -0700
From: Jishnu Prakash <quic_jprakash@quicinc.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <daniel.lezcano@linaro.org>, <sboyd@kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
        <amitk@kernel.org>
CC: <lee@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <lars@metafoo.de>, <quic_skakitap@quicinc.com>,
        <neil.armstrong@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jishnu Prakash
	<quic_jprakash@quicinc.com>
Subject: [PATCH V4 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Date: Thu, 31 Oct 2024 00:28:53 +0530
Message-ID: <20241030185854.4015348-4-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Oc_P-kmx10_ZAh1XOK0vWuAYXB-iwmPg
X-Proofpoint-ORIG-GUID: Oc_P-kmx10_ZAh1XOK0vWuAYXB-iwmPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300150

The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
with all SW communication to ADC going through PMK8550 which
communicates with other PMICs through PBS.

One major difference is that the register interface used here is that
of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
There may be more than one SDAM used for ADC5 Gen3 and each has eight
channels, which may be used for either immediate reads (same functionality
as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
(same as ADC_TM functionality).

By convention, we reserve the first channel of the first SDAM for all
immediate reads and use the remaining channels across all SDAMs for
ADC_TM monitoring functionality.

Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
ADC_TM is implemented as an auxiliary thermal driver under this ADC
driver.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
Changes since v3:
- Split out TM functionality into auxiliary driver in separate patch and
  added required changes in main driver.
- Addressed other reviewer comments in main driver patch. 

Changes since v1:
- Removed datashet_name usage and implemented read_label() function
- In probe, updated channel property in iio_chan_spec from individual
  channel to virtual channel and set indexed property to 1, due to the
  above change.
- Updated order of checks in ISR
- Removed the driver remove callback and replaced with callbacks in a
  devm_add_action call in probe.
- Addressed other comments from reviewers.

 drivers/iio/adc/Kconfig                       |  25 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 724 ++++++++++++++++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 233 ++++++
 4 files changed, 983 insertions(+)
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..11f8cb1de085 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1165,6 +1165,31 @@ config QCOM_SPMI_ADC5
 	  To compile this driver as a module, choose M here: the module will
 	  be called qcom-spmi-adc5.
 
+config QCOM_SPMI_ADC5_GEN3
+	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
+	depends on SPMI && THERMAL
+	select REGMAP_SPMI
+	select QCOM_VADC_COMMON
+	help
+	  This is the IIO Voltage PMIC5 Gen3 ADC driver for Qualcomm Technologies Inc. PMICs.
+
+	  The driver supports reading multiple channels. The ADC is a 16-bit
+	  sigma-delta ADC. The hardware supports calibrated results for
+	  conversion requests and clients include reading phone power supply
+	  voltage, on board system thermistors connected to the PMIC ADC,
+	  PMIC die temperature, charger temperature, battery current, USB voltage
+	  input and voltage signals connected to supported PMIC GPIO pins. The
+	  hardware supports internal pull-up for thermistors and can choose between
+	  a 30k, 100k or 400k ohm pull up using the ADC channels.
+
+	  In addition, the same driver supports ADC thermal monitoring devices too.
+	  They appear as thermal zones with multiple trip points. A thermal client sets
+	  threshold temperature for both warm and cool trips and gets updated when a
+	  threshold is reached.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called qcom-spmi-adc5-gen3.
+
 config RCAR_GYRO_ADC
 	tristate "Renesas R-Car GyroADC driver"
 	depends on ARCH_RCAR_GEN2 || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ee19afba62b7..1f8a02e608dd 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_PAC1934) += pac1934.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
+obj-$(CONFIG_QCOM_SPMI_ADC5_GEN3) += qcom-spmi-adc5-gen3.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
 obj-$(CONFIG_QCOM_SPMI_RRADC) += qcom-spmi-rradc.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
new file mode 100644
index 000000000000..41f7f6534745
--- /dev/null
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -0,0 +1,724 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/iio/adc/qcom-adc5-gen3-common.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/unaligned.h>
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+#define ADC5_GEN3_VADC_SDAM			0x0
+
+struct adc5_chip;
+
+/**
+ * @adc_tm: indicates TM type if the channel is used for TM measurements.
+ * @chip: pointer to top-level ADC device structure.
+ */
+
+struct adc5_channel_prop {
+	struct adc5_channel_common_prop common_props;
+	int				adc_tm;
+	struct adc5_chip		*chip;
+};
+
+/**
+ * struct adc5_chip - ADC private structure.
+ * @dev: SPMI ADC5 Gen3 device.
+ * @num_sdams: number of SDAMs (Shared Direct Access Memory Module) being used.
+ * @nchannels: number of ADC channels.
+ * @chan_props: array of ADC channel properties.
+ * @iio_chans: array of IIO channels specification.
+ * @complete: ADC result notification after interrupt is received.
+ * @lock: ADC lock for access to the peripheral, to prevent concurrent
+ * requests from multiple clients.
+ * @n_tm_channels: number of ADC channels used for TM measurements.
+ * @data: software configuration data.
+ */
+struct adc5_chip {
+	struct device			*dev;
+	struct adc5_device_data	dev_data;
+	unsigned int			num_sdams;
+	unsigned int			nchannels;
+	struct adc5_channel_prop	*chan_props;
+	struct iio_chan_spec		*iio_chans;
+	struct completion		complete;
+	/*
+	 * lock for access to the peripheral, to prevent concurrent
+	 * requests from multiple clients.
+	 */
+	struct mutex			lock;
+	const struct adc5_data		*data;
+	unsigned int			n_tm_channels;
+	struct auxiliary_device		*tm_aux;
+};
+
+static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
+{
+	u8 rslt[2];
+	int ret;
+
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_CH_DATA0(0), rslt, 2);
+	if (ret)
+		return ret;
+
+	*data = get_unaligned_le16(rslt);
+
+	if (*data == ADC5_USR_DATA_CHECK) {
+		dev_err(adc->dev, "Invalid data:%#x\n", *data);
+		return -EINVAL;
+	}
+
+	dev_dbg(adc->dev, "voltage raw code:%#x\n", *data);
+
+	return 0;
+}
+
+#define ADC5_GEN3_READ_CONFIG_REGS 7
+
+static int adc5_gen3_configure(struct adc5_chip *adc, struct adc5_channel_common_prop *prop)
+{
+	u8 buf[ADC5_GEN3_READ_CONFIG_REGS];
+	u8 conv_req = 0;
+	int ret;
+
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_SID, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	/* Write SID */
+	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->sid);
+
+	/*
+	 * Use channel 0 by default for immediate conversion and
+	 * to indicate there is an actual conversion request
+	 */
+	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | 0;
+
+	buf[2] = ADC5_GEN3_TIME_IMMEDIATE;
+
+	/* Digital param selection */
+	adc5_gen3_update_dig_param(prop, &buf[3]);
+
+	/* Update fast average sample value */
+	buf[4] = FIELD_PREP(ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK, prop->avg_samples)
+			    | ADC5_GEN3_FAST_AVG_CTL_EN;
+
+	/* Select ADC channel */
+	buf[5] = prop->channel;
+
+	/* Select HW settle delay for channel */
+	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK, prop->hw_settle_time);
+
+	reinit_completion(&adc->complete);
+
+	ret = adc5_gen3_write(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_SID, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	conv_req = ADC5_GEN3_CONV_REQ_REQ;
+	return adc5_gen3_write(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_CONV_REQ, &conv_req,
+			       1);
+}
+
+/*
+ * Worst case delay from PBS for conversion time can be
+ * up to 500ms, when PBS has timed out twice, once for
+ * the initial attempt and once for a retry of the same
+ * transaction.
+ */
+
+#define ADC5_GEN3_CONV_TIMEOUT_MS	501
+
+static int adc5_gen3_do_conversion(struct adc5_chip *adc,
+				   struct adc5_channel_common_prop *prop, u16 *data_volt)
+{
+	unsigned long rc;
+	int ret;
+	u8 val;
+
+	guard(mutex)(&adc->lock);
+	ret = adc5_gen3_poll_wait_hs(&adc->dev_data, ADC5_GEN3_VADC_SDAM);
+	if (ret)
+		return ret;
+
+	ret = adc5_gen3_configure(adc, prop);
+	if (ret) {
+		dev_err(adc->dev, "ADC configure failed with %d\n", ret);
+		return ret;
+	}
+
+	/* No support for polling mode at present */
+	rc = wait_for_completion_timeout(&adc->complete,
+					 msecs_to_jiffies(ADC5_GEN3_CONV_TIMEOUT_MS));
+	if (!rc) {
+		dev_err(adc->dev, "Reading ADC channel %s timed out\n",
+			prop->label);
+		return -ETIMEDOUT;
+	}
+
+	ret = adc5_gen3_read_voltage_data(adc, data_volt);
+	if (ret)
+		return ret;
+
+	val = BIT(0);
+	return adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_EOC_CLR, &val,
+				      1);
+}
+
+static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
+{
+	u8 status, tm_status[2], eoc_status, val;
+	struct adc_tm5_auxiliary_drv *adrv_tm;
+	struct adc5_chip *adc = dev_id;
+	struct auxiliary_device *adev;
+	int ret;
+
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_STATUS1, &status, 1);
+	if (ret) {
+		dev_err(adc->dev, "adc read status1 failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_EOC_STS, &eoc_status,
+			     1);
+	if (ret) {
+		dev_err(adc->dev, "adc read eoc status failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
+		dev_err_ratelimited(adc->dev, "Unexpected conversion fault, status:%#x, eoc_status:%#x\n",
+				    status, eoc_status);
+		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
+		adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_CONV_ERR_CLR,
+				       &val, 1);
+		return IRQ_HANDLED;
+	}
+
+	/* CHAN0 is the preconfigured channel for immediate conversion */
+	if (eoc_status & ADC5_GEN3_EOC_CHAN_0)
+		complete(&adc->complete);
+
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_TM_HIGH_STS,
+			     tm_status, 2);
+	if (ret) {
+		dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (tm_status[0] || tm_status[1]) {
+		adev = adc->tm_aux;
+		if (!adev || !adev->dev.driver) {
+			dev_err(adc->dev, "adc_tm auxiliary device not initialized\n");
+			return IRQ_HANDLED;
+		}
+
+		adrv_tm = container_of(adev->dev.driver, struct adc_tm5_auxiliary_drv, adrv.driver);
+
+		if (adrv_tm && adrv_tm->tm_event_notify)
+			adrv_tm->tm_event_notify(adev);
+		else
+			dev_err(adc->dev, "adc_tm auxiliary driver not initialized\n");
+	}
+
+	dev_dbg(adc->dev, "Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
+		status, eoc_status, tm_status[0], tm_status[1]);
+
+	return IRQ_HANDLED;
+}
+
+static int adc5_gen3_fwnode_xlate(struct iio_dev *indio_dev,
+				  const struct fwnode_reference_args *iiospec)
+{
+	struct adc5_chip *adc = iio_priv(indio_dev);
+	int i, v_channel;
+
+	for (i = 0; i < adc->nchannels; i++) {
+		v_channel = V_CHAN(adc->chan_props[i].common_props);
+		if (v_channel == iiospec->args[0])
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int *val, int *val2,
+			      long mask)
+{
+	struct adc5_chip *adc = iio_priv(indio_dev);
+	struct adc5_channel_common_prop *prop;
+	u16 adc_code_volt;
+	int ret;
+
+	prop = &adc->chan_props[chan->address].common_props;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = adc5_gen3_do_conversion(adc, prop, &adc_code_volt);
+		if (ret)
+			return ret;
+
+		ret = qcom_adc5_hw_scale(prop->scale_fn_type, prop->prescale,
+					 adc->data, adc_code_volt, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		ret = adc5_gen3_do_conversion(adc, prop, &adc_code_volt);
+		if (ret)
+			return ret;
+		*val = (int)adc_code_volt;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adc5_gen3_read_label(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan, char *label)
+{
+	struct adc5_chip *adc = iio_priv(indio_dev);
+	struct adc5_channel_prop *prop;
+
+	prop = &adc->chan_props[chan->address];
+	return sprintf(label, "%s\n", prop->common_props.label);
+}
+
+static const struct iio_info adc5_gen3_info = {
+	.read_raw = adc5_gen3_read_raw,
+	.read_label = adc5_gen3_read_label,
+	.fwnode_xlate = adc5_gen3_fwnode_xlate,
+};
+
+struct adc5_channels {
+	unsigned int prescale_index;
+	enum iio_chan_type type;
+	long info_mask;
+	enum vadc_scale_fn_type scale_fn_type;
+};
+
+/* In these definitions, _pre refers to an index into adc5_prescale_ratios. */
+#define ADC5_CHAN(_type, _mask, _pre, _scale)	\
+	{						\
+		.prescale_index = _pre,			\
+		.type = _type,				\
+		.info_mask = _mask,			\
+		.scale_fn_type = _scale,		\
+	},						\
+
+#define ADC5_CHAN_TEMP(_pre, _scale)		\
+	ADC5_CHAN(IIO_TEMP, BIT(IIO_CHAN_INFO_PROCESSED), _pre, _scale)	\
+
+#define ADC5_CHAN_VOLT(_pre, _scale)		\
+	ADC5_CHAN(IIO_VOLTAGE, BIT(IIO_CHAN_INFO_PROCESSED), _pre, _scale)	\
+
+#define ADC5_CHAN_CUR(_pre, _scale)		\
+	ADC5_CHAN(IIO_CURRENT, BIT(IIO_CHAN_INFO_PROCESSED), _pre, _scale)	\
+
+static const struct adc5_channels adc5_gen3_chans_pmic[ADC5_MAX_CHANNEL] = {
+	[ADC5_GEN3_REF_GND]		= ADC5_CHAN_VOLT(0, SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN3_1P25VREF]		= ADC5_CHAN_VOLT(0, SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN3_VPH_PWR]		= ADC5_CHAN_VOLT(1, SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN3_VBAT_SNS_QBG]	= ADC5_CHAN_VOLT(1, SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN3_USB_SNS_V_16]	= ADC5_CHAN_TEMP(8, SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN3_VIN_DIV16_MUX]	= ADC5_CHAN_TEMP(8, SCALE_HW_CALIB_DEFAULT)
+	[ADC5_GEN3_DIE_TEMP]		= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_PMIC_THERM_PM7)
+	[ADC5_GEN3_TEMP_ALARM_LITE]	= ADC5_CHAN_TEMP(0,
+						SCALE_HW_CALIB_PMIC_THERM_PM7)
+	[ADC5_GEN3_AMUX1_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN3_AMUX2_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN3_AMUX3_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN3_AMUX4_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN3_AMUX5_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN3_AMUX6_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN3_AMUX1_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN3_AMUX2_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN3_AMUX3_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC5_GEN3_AMUX4_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+};
+
+static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
+					 struct adc5_channel_prop *prop,
+					 struct fwnode_handle *fwnode)
+{
+	const char *name = fwnode_get_name(fwnode);
+	const struct adc5_data *data = adc->data;
+	u32 chan, value, varr[2], sid = 0;
+	struct device *dev = adc->dev;
+	const char *channel_name;
+	int ret;
+
+	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "invalid channel number %s\n", name);
+
+	/*
+	 * Value read from "reg" is virtual channel number
+	 * virtual channel number = sid << 8 | channel number
+	 */
+	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
+	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
+
+	if (chan > ADC5_GEN3_OFFSET_EXT2)
+		return dev_err_probe(dev, -EINVAL, "%s invalid channel number %d\n", name, chan);
+
+	prop->common_props.channel = chan;
+	prop->common_props.sid = sid;
+
+	channel_name = name;
+	fwnode_property_read_string(fwnode, "label", &channel_name);
+	prop->common_props.label = channel_name;
+
+	value = data->decimation[ADC5_DECIMATION_DEFAULT];
+	fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
+	ret = qcom_adc5_decimation_from_dt(value, data->decimation);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "%#x invalid decimation %d\n",
+			chan, value);
+	prop->common_props.decimation = ret;
+
+	prop->common_props.prescale = adc->data->adc_chans[chan].prescale_index;
+	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
+	if (!ret) {
+		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%#x invalid pre-scaling <%d %d>\n",
+				chan, varr[0], varr[1]);
+		prop->common_props.prescale = ret;
+	}
+
+	value = data->hw_settle_1[VADC_DEF_HW_SETTLE_TIME];
+	fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
+	ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_1);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "%#x invalid hw-settle-time %d us\n",
+				chan, value);
+	prop->common_props.hw_settle_time = ret;
+
+	value = BIT(VADC_DEF_AVG_SAMPLES);
+	fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
+	ret = qcom_adc5_avg_samples_from_dt(value);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "%#x invalid avg-samples %d\n",
+			chan, value);
+	prop->common_props.avg_samples = ret;
+
+	if (fwnode_property_read_bool(fwnode, "qcom,ratiometric"))
+		prop->common_props.cal_method = ADC5_RATIOMETRIC_CAL;
+	else
+		prop->common_props.cal_method = ADC5_ABSOLUTE_CAL;
+
+	prop->adc_tm = fwnode_property_read_bool(fwnode, "qcom,adc-tm");
+	if (prop->adc_tm) {
+		adc->n_tm_channels++;
+		if (adc->n_tm_channels > ((adc->num_sdams * 8) - 1))
+			return dev_err_probe(dev, -EINVAL,
+				"Number of TM nodes %u greater than channels supported:%u\n",
+				adc->n_tm_channels, (adc->num_sdams * 8) - 1);
+	}
+
+	return 0;
+}
+
+static const struct adc5_data adc5_gen3_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.adc_chans = adc5_gen3_chans_pmic,
+	.info = &adc5_gen3_info,
+	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
+				{85, 340, 1360},
+	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
+				{15, 100, 200, 300, 400, 500, 600, 700,
+				1000, 2000, 4000, 8000, 16000, 32000,
+				64000, 128000},
+};
+
+static const struct of_device_id adc5_match_table[] = {
+	{
+		.compatible = "qcom,spmi-adc5-gen3",
+		.data = &adc5_gen3_data_pmic,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adc5_match_table);
+
+static int adc5_get_fw_data(struct adc5_chip *adc)
+{
+	const struct adc5_channels *adc_chan;
+	struct adc5_channel_prop *chan_props;
+	struct fwnode_handle *child = NULL;
+	struct iio_chan_spec *iio_chan;
+	unsigned int index = 0;
+	int ret;
+
+	adc->nchannels = device_get_child_node_count(adc->dev);
+	if (!adc->nchannels) {
+		dev_err(adc->dev, "No ADC channels found\n");
+		return -EINVAL;
+	}
+
+	adc->iio_chans = devm_kcalloc(adc->dev, adc->nchannels,
+				      sizeof(*adc->iio_chans), GFP_KERNEL);
+	if (!adc->iio_chans)
+		return -ENOMEM;
+
+	adc->chan_props = devm_kcalloc(adc->dev, adc->nchannels,
+				       sizeof(*adc->chan_props), GFP_KERNEL);
+	if (!adc->chan_props)
+		return -ENOMEM;
+
+	chan_props = adc->chan_props;
+	adc->n_tm_channels = 0;
+	iio_chan = adc->iio_chans;
+	adc->data = device_get_match_data(adc->dev);
+
+	device_for_each_child_node(adc->dev, child) {
+		ret = adc5_gen3_get_fw_channel_data(adc, chan_props, child);
+		if (ret < 0)
+			return ret;
+
+		chan_props->chip = adc;
+		adc_chan = &adc->data->adc_chans[chan_props->common_props.channel];
+		chan_props->common_props.scale_fn_type = adc_chan->scale_fn_type;
+
+		iio_chan->channel = V_CHAN(chan_props->common_props);
+		iio_chan->info_mask_separate = adc_chan->info_mask;
+		iio_chan->type = adc_chan->type;
+		iio_chan->address = index;
+		iio_chan->indexed = 1;
+		iio_chan++;
+		chan_props++;
+		index++;
+	}
+
+	return 0;
+}
+
+static void adc5_gen3_uninit_aux(void *data)
+{
+	auxiliary_device_uninit(data);
+}
+
+static void adc5_gen3_delete_aux(void *data)
+{
+	auxiliary_device_delete(data);
+}
+
+static void adc5_gen3_aux_device_release(struct device *dev)
+{
+	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device, dev);
+
+	kfree(aux);
+}
+
+static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
+{
+	struct tm5_aux_dev_wrapper *aux_device;
+	int i, ret, i_tm = 0;
+
+	aux_device = devm_kzalloc(adc->dev, sizeof(*aux_device), GFP_KERNEL);
+	if (!aux_device)
+		return -ENOMEM;
+
+	aux_device->aux_dev.name = "adc5_tm_gen3";
+	aux_device->aux_dev.dev.parent = adc->dev;
+	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
+
+	aux_device->tm_props = devm_kcalloc(adc->dev, adc->n_tm_channels,
+					    sizeof(*aux_device->tm_props), GFP_KERNEL);
+	if (!aux_device->tm_props)
+		return -ENOMEM;
+
+	aux_device->dev_data = &adc->dev_data;
+
+	for (i = 0; i < adc->nchannels; i++) {
+		if (!adc->chan_props[i].adc_tm)
+			continue;
+		aux_device->tm_props[i_tm] = adc->chan_props[i].common_props;
+		i_tm++;
+	}
+
+	device_set_of_node_from_dev(&aux_device->aux_dev.dev, adc->dev);
+
+	aux_device->n_tm_channels = adc->n_tm_channels;
+
+	ret = auxiliary_device_init(&aux_device->aux_dev);
+	if (ret) {
+		kfree(&aux_device->aux_dev);
+		return ret;
+	}
+	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux, &aux_device->aux_dev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(&aux_device->aux_dev);
+	if (ret)
+		return ret;
+	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux, &aux_device->aux_dev);
+	if (!ret)
+		adc->tm_aux = &aux_device->aux_dev;
+
+	return ret;
+}
+
+void adc5_take_mutex_lock(struct device *dev, bool lock)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
+	struct adc5_chip *adc = iio_priv(indio_dev);
+
+	if (lock)
+		mutex_lock(&adc->lock);
+	else
+		mutex_unlock(&adc->lock);
+}
+EXPORT_SYMBOL_NS_GPL(adc5_take_mutex_lock, IIO_ADC5_GEN3);
+
+int adc5_gen3_get_scaled_reading(struct device *dev, struct adc5_channel_common_prop *common_props,
+				 int *val)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
+	struct adc5_chip *adc = iio_priv(indio_dev);
+	u16 adc_code_volt;
+	int ret;
+
+	ret = adc5_gen3_do_conversion(adc, common_props, &adc_code_volt);
+	if (ret)
+		return ret;
+
+	return qcom_adc5_hw_scale(common_props->scale_fn_type, common_props->prescale,
+		adc->data, adc_code_volt, val);
+}
+EXPORT_SYMBOL_NS_GPL(adc5_gen3_get_scaled_reading, IIO_ADC5_GEN3);
+
+int adc5_gen3_therm_code_to_temp(struct device *dev, struct adc5_channel_common_prop *common_props,
+				 u16 code, int *val)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
+	struct adc5_chip *adc = iio_priv(indio_dev);
+
+	return qcom_adc5_hw_scale(common_props->scale_fn_type, common_props->prescale,
+		adc->data, code, val);
+}
+EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, IIO_ADC5_GEN3);
+
+static int adc5_gen3_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct adc5_chip *adc;
+	struct regmap *regmap;
+	int ret, i;
+	u32 *reg;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->dev_data.regmap = regmap;
+	adc->dev = dev;
+
+	ret = device_property_count_u32(dev, "reg");
+	if (ret < 0)
+		return ret;
+
+	adc->num_sdams = ret;
+	adc->dev_data.num_sdams = adc->num_sdams;
+
+	reg = devm_kcalloc(dev, adc->num_sdams, sizeof(u32), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	ret = device_property_read_u32_array(dev, "reg", reg, adc->num_sdams);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read reg property, ret = %d\n", ret);
+
+	adc->dev_data.base = devm_kcalloc(dev, adc->num_sdams, sizeof(*adc->dev_data.base),
+					  GFP_KERNEL);
+	if (!adc->dev_data.base)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, indio_dev);
+	init_completion(&adc->complete);
+	mutex_init(&adc->lock);
+
+	for (i = 0; i < adc->num_sdams; i++) {
+		adc->dev_data.base[i].base_addr = reg[i];
+
+		adc->dev_data.base[i].irq_name = devm_kasprintf(dev, GFP_KERNEL, "adc-sdam%d", i);
+		if (!adc->dev_data.base[i].irq_name)
+			return -ENOMEM;
+
+		ret = platform_get_irq_byname(pdev, adc->dev_data.base[i].irq_name);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Getting IRQ %d by name failed, ret = %d\n",
+					adc->dev_data.base[i].irq, ret);
+		adc->dev_data.base[i].irq = ret;
+	}
+
+	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq, adc5_gen3_isr,
+			       0, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name, adc);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to request SDAM%d irq, ret = %d\n",
+				ADC5_GEN3_VADC_SDAM, ret);
+
+	ret = adc5_get_fw_data(adc);
+	if (ret < 0)
+		return ret;
+
+	if (adc->n_tm_channels > 0)
+		adc5_gen3_add_aux_tm_device(adc);
+
+	indio_dev->name = pdev->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &adc5_gen3_info;
+	indio_dev->channels = adc->iio_chans;
+	indio_dev->num_channels = adc->nchannels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct platform_driver adc5_gen3_driver = {
+	.driver = {
+		.name = "qcom-spmi-adc5-gen3",
+		.of_match_table = adc5_match_table,
+	},
+	.probe = adc5_gen3_probe,
+};
+module_platform_driver(adc5_gen3_driver);
+
+MODULE_DESCRIPTION("Qualcomm Technologies Inc. PMIC5 Gen3 ADC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
new file mode 100644
index 000000000000..785669d62caf
--- /dev/null
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
+ * of type ADC5 Gen3.
+ */
+
+#ifndef QCOM_ADC5_GEN3_COMMON_H
+#define QCOM_ADC5_GEN3_COMMON_H
+
+#include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
+
+#define ADC5_GEN3_HS				0x45
+#define ADC5_GEN3_HS_BUSY			BIT(7)
+#define ADC5_GEN3_HS_READY			BIT(0)
+
+#define ADC5_GEN3_STATUS1			0x46
+#define ADC5_GEN3_STATUS1_CONV_FAULT		BIT(7)
+#define ADC5_GEN3_STATUS1_THR_CROSS		BIT(6)
+#define ADC5_GEN3_STATUS1_EOC			BIT(0)
+
+#define ADC5_GEN3_TM_EN_STS			0x47
+#define ADC5_GEN3_TM_HIGH_STS			0x48
+#define ADC5_GEN3_TM_LOW_STS			0x49
+
+#define ADC5_GEN3_EOC_STS			0x4a
+#define ADC5_GEN3_EOC_CHAN_0			BIT(0)
+
+#define ADC5_GEN3_EOC_CLR			0x4b
+#define ADC5_GEN3_TM_HIGH_STS_CLR		0x4c
+#define ADC5_GEN3_TM_LOW_STS_CLR		0x4d
+#define ADC5_GEN3_CONV_ERR_CLR			0x4e
+#define ADC5_GEN3_CONV_ERR_CLR_REQ		BIT(0)
+
+#define ADC5_GEN3_SID				0x4f
+#define ADC5_GEN3_SID_MASK			GENMASK(3, 0)
+
+#define ADC5_GEN3_PERPH_CH			0x50
+#define ADC5_GEN3_CHAN_CONV_REQ			BIT(7)
+
+#define ADC5_GEN3_TIMER_SEL			0x51
+#define ADC5_GEN3_TIME_IMMEDIATE		0x1
+
+#define ADC5_GEN3_DIG_PARAM			0x52
+#define ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK	GENMASK(5, 4)
+#define ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK	GENMASK(3, 2)
+
+#define ADC5_GEN3_FAST_AVG			0x53
+#define ADC5_GEN3_FAST_AVG_CTL_EN		BIT(7)
+#define ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK	GENMASK(2, 0)
+
+#define ADC5_GEN3_ADC_CH_SEL_CTL		0x54
+#define ADC5_GEN3_DELAY_CTL			0x55
+#define ADC5_GEN3_HW_SETTLE_DELAY_MASK		GENMASK(3, 0)
+
+#define ADC5_GEN3_CH_EN				0x56
+#define ADC5_GEN3_HIGH_THR_INT_EN		BIT(1)
+#define ADC5_GEN3_LOW_THR_INT_EN		BIT(0)
+
+#define ADC5_GEN3_LOW_THR0			0x57
+#define ADC5_GEN3_LOW_THR1			0x58
+#define ADC5_GEN3_HIGH_THR0			0x59
+#define ADC5_GEN3_HIGH_THR1			0x5a
+
+#define ADC5_GEN3_CH_DATA0(channel)	(0x5c + (channel) * 2)
+#define ADC5_GEN3_CH_DATA1(channel)	(0x5d + (channel) * 2)
+
+#define ADC5_GEN3_CONV_REQ			0xe5
+#define ADC5_GEN3_CONV_REQ_REQ			BIT(0)
+
+#define ADC5_GEN3_VIRTUAL_SID_MASK			GENMASK(15, 8)
+#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
+#define V_CHAN(x)		\
+	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)	\
+
+enum adc5_cal_method {
+	ADC5_NO_CAL = 0,
+	ADC5_RATIOMETRIC_CAL,
+	ADC5_ABSOLUTE_CAL
+};
+
+enum adc5_time_select {
+	MEAS_INT_DISABLE = 0,
+	MEAS_INT_IMMEDIATE,
+	MEAS_INT_50MS,
+	MEAS_INT_100MS,
+	MEAS_INT_1S,
+	MEAS_INT_NONE,
+};
+
+struct adc5_sdam_data {
+	u16			base_addr;
+	const char		*irq_name;
+	int			irq;
+};
+
+struct adc5_device_data {
+	struct regmap			*regmap;
+	struct adc5_sdam_data		*base;
+	int				num_sdams;
+};
+
+/**
+ * struct adc5_channel_prop - ADC channel property.
+ * @channel: channel number, refer to the channel list.
+ * @cal_method: calibration method.
+ * @decimation: sampling rate supported for the channel.
+ * @sid: slave id of PMIC owning the channel.
+ * @label: Channel name used in device tree.
+ * @prescale: channel scaling performed on the input signal.
+ * @hw_settle_time: the time between AMUX being configured and the
+ *	start of conversion.
+ * @avg_samples: ability to provide single result from the ADC
+ *	that is an average of multiple measurements.
+ * @scale_fn_type: Represents the scaling function to convert voltage
+ *	physical units desired by the client for the channel.
+ */
+struct adc5_channel_common_prop {
+	unsigned int			channel;
+	enum adc5_cal_method		cal_method;
+	unsigned int			decimation;
+	unsigned int			sid;
+	const char			*label;
+	unsigned int			prescale;
+	unsigned int			hw_settle_time;
+	unsigned int			avg_samples;
+	enum vadc_scale_fn_type		scale_fn_type;
+};
+
+struct tm5_aux_dev_wrapper {
+	struct auxiliary_device aux_dev;
+	struct adc5_device_data *dev_data;
+	struct adc5_channel_common_prop *tm_props;
+	unsigned int			n_tm_channels;
+};
+
+struct adc_tm5_auxiliary_drv {
+	struct auxiliary_driver adrv;
+	void (*tm_event_notify)(struct auxiliary_device *adev);
+};
+
+static int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
+			  u16 offset, u8 *data, int len)
+{
+	return regmap_bulk_read(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
+}
+
+static int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
+			   u16 offset, u8 *data, int len)
+{
+	return regmap_bulk_write(adc->regmap, adc->base[sdam_index].base_addr + offset, data, len);
+}
+
+/*
+ * Worst case delay from PBS in readying handshake bit
+ * can be up to 15ms, when PBS is busy running other
+ * simultaneous transactions, while in the best case, it is
+ * already ready at this point. Assigning polling delay and
+ * retry count accordingly.
+ */
+
+#define ADC5_GEN3_HS_DELAY_MIN_US		100
+#define ADC5_GEN3_HS_DELAY_MAX_US		110
+#define ADC5_GEN3_HS_RETRY_COUNT		150
+
+static int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
+				  unsigned int sdam_index)
+{
+	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
+	int ret, count;
+	u8 status = 0;
+
+	for (count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
+		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, 1);
+		if (ret)
+			return ret;
+
+		if (status == ADC5_GEN3_HS_READY) {
+			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
+					     &conv_req, 1);
+			if (ret)
+				return ret;
+
+			if (!conv_req)
+				return 0;
+		}
+
+		usleep_range(ADC5_GEN3_HS_DELAY_MIN_US, ADC5_GEN3_HS_DELAY_MAX_US);
+	}
+
+	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n", sdam_index, status);
+	return -ETIMEDOUT;
+}
+
+static void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data)
+{
+	/* Update calibration select and decimation ratio select */
+	*data &= ~(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK | ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK);
+	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
+	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK, prop->decimation);
+}
+
+static int adc5_gen3_status_clear(struct adc5_device_data *adc,
+				  int sdam_index, u16 offset, u8 *val, int len)
+{
+	u8 value;
+	int ret;
+
+	ret = adc5_gen3_write(adc, sdam_index, offset, val, len);
+	if (ret)
+		return ret;
+
+	/* To indicate conversion request is only to clear a status */
+	value = 0;
+	ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &value, 1);
+	if (ret)
+		return ret;
+
+	value = ADC5_GEN3_CONV_REQ_REQ;
+	return adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &value, 1);
+}
+
+void adc5_take_mutex_lock(struct device *dev, bool lock);
+int adc5_gen3_get_scaled_reading(struct device *dev, struct adc5_channel_common_prop *common_props,
+				 int *val);
+int adc5_gen3_therm_code_to_temp(struct device *dev, struct adc5_channel_common_prop *common_props,
+				 u16 code, int *val);
+
+#endif /* QCOM_VADC5_GEN3_COMMON_H */
-- 
2.25.1


