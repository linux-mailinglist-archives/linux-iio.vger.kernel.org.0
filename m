Return-Path: <linux-iio+bounces-19378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859EDAB11E8
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 13:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF35B506A73
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 11:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634A290BA3;
	Fri,  9 May 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wgg4UFS8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAF28FA96
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789071; cv=none; b=ixQ8adUY4/7UcX3wvDA/PXCOr58YDVMPZEIx0VgJHLhd8yyTCD/4YQGcYLjyaOjMl3eSPhayXwXS7aA/Z/1RKg899NgMQ7trSL8pUaJscx+uIUm8sZTxsp7Ee1R2Aa0mUjaxYBFRww8UPSMxLr+vKfwMGb7StdQlCrmEzORTofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789071; c=relaxed/simple;
	bh=Zx0wOXtMkfrwIApLZ4tsF4pJ8FVYyLhBcvXdwG8uJME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWz9bijh835hOjlARlVgwOrLrFgb0WX1rkTpXZLSFWoUMb0laIBwYW4BvCIUEoKd/9f7LHmptuPOvLmvRuc8NeYqj+J10JQyJ5uvWFTmP9c1A4RNO/gSgjLGW8rbqrj7YGLF/RVEGyrDG76g9j65IVT9s34UsYjY7ZDpBfhyCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wgg4UFS8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54930PoS016175
	for <linux-iio@vger.kernel.org>; Fri, 9 May 2025 11:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NLHyyXqAtEZ
	LwjQG57ijwdNYsJoWJt5X9LrU+gpPV+w=; b=Wgg4UFS8JEBgU1euasEWsmqUfOa
	3A9vplw7YHvNkeD3p2vc1dAFEK5KWMSoBVVOdJMSTSlEG878eQnJ525Rom5Gg0l/
	iWFEFKuD1ucejC/eitk+MdZrTTD0xlnbK9UTBmzJjVnTGjZhK4i2UThITSdlJOu/
	tJAo7g4NnmZ2yaNnqqTKUkkJO6UzsQTe5sg8abcHzs+RdBRIiYa3klTpBD1QwouF
	bSi7Vus1KScw7zzU7lxIWeNKGd4Pcq04VLIcoFckRPAceOSY5VAk5F1Kdw55gkva
	s+pQNVMxKF7rbiT2sn4HyOt6aFdBfOgtW/LSx+tERHEa1LTswdJIbBXTNoA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp8vd9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 11:11:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736c0306242so2902941b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 04:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746789066; x=1747393866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLHyyXqAtEZLwjQG57ijwdNYsJoWJt5X9LrU+gpPV+w=;
        b=tKRr5250E073QYXdcd0i90sFXdd7TImSOLG5McmxKCtnp0t0FOEMzqg31G0WhBCOqa
         WGAEZVOcJRlCS38bHOanFLBQWU9QlBfXo9oMBAAw5E54oGNmlxps44w2UpaV4SneCerN
         jH065a876RPtKhMjhmphFn2k8cP2FOq9pOlFxuc/QKATJ3DyE7wcQStwkSX04eZX5SYr
         IC+qZ7ukftDzjWyK+GB4z5qOEg6tuqJIXxzfu5IOYyG/CsvHIiWshnPnKd09SjXfcVgA
         8qXxAmR50VbNQZkXu94sNkz7zhsaG28VHwwGqfZuKgYdIcABKy9Mq5SKRk2rZcS+VbgL
         Ua+g==
X-Forwarded-Encrypted: i=1; AJvYcCXRmDKj0Mbbjt2ylxqx0UZcPlZuDsHKDg85CkXt2JVGYpi2q18IKAvSD9FVZKhRapgE5o5BHkHSUYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytN1Lu5v/A3Tdi387Hafbqvov9h4hilEGEeK6x0+F09SsGQK4m
	LvCMUbzASLcUVS7TmujPrjPjGqUUwF1sgkneZQnhYjqyAOS46hU+VD1oY1XQ6YiezWwXsh5wKhk
	T0r0MQFZ5dcMezarL/9a/6VoV5zuTadBtXwk04OIgQnq0sRqe/NaC4wdwQIA=
X-Gm-Gg: ASbGncsyS1VL3pwYgij6k546zIL7e/q6e2Fmt7OvG5aCvCLLOpSz+4SvKmqi14XQleX
	UGjHL1y5zqU4uPKHSifAXunZOP5xffTokUj6JqiIxIBo9wlDU4/GOSlHcrcXNbiHNRkJ8X0LyqS
	LunlGiUTDparYJ9cG9Fq2lxj4S1w2qdhZ8j/VWcUk8WqfnxjFJ1xvX/YLjKyd8p7US0B5+e5t4N
	DHtfRqdxFqu7ZLugqbaB0q6ojO/FUhnHjRqxXwHVQjdhqtDYGj0mKVUz9GCYAcVwMBDkdwgzAOD
	NaeEZhL3bQUDm8sSx/cw+G9jWTNx+OlpxSQ5rrT+H/qu9mU=
X-Received: by 2002:a05:6a00:2313:b0:740:9331:78f0 with SMTP id d2e1a72fcca58-7423c028cdamr3992479b3a.22.1746789065884;
        Fri, 09 May 2025 04:11:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAX2mmMKRxzeExol1iF/KAGKoBp4WFGTNE9575/UfRcEqGJO/0hgLXznwX339k82LLfb5DeA==
X-Received: by 2002:a05:6a00:2313:b0:740:9331:78f0 with SMTP id d2e1a72fcca58-7423c028cdamr3992413b3a.22.1746789065344;
        Fri, 09 May 2025 04:11:05 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237734c4asm1556223b3a.57.2025.05.09.04.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:11:05 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
Subject: [PATCH V6 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring
Date: Fri,  9 May 2025 16:39:59 +0530
Message-Id: <20250509110959.3384306-6-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GkXJYdF19sEXQG4Xb3BSa8NSaDwlGw4q
X-Proofpoint-ORIG-GUID: GkXJYdF19sEXQG4Xb3BSa8NSaDwlGw4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNyBTYWx0ZWRfX2b2ecaAVPPA8
 QAZuiftri6Y0E44LosmJR5Zi6MIW2KxIEthNiX1HsHtngwlFdDGjfg9X5+T6hgr2cpkNA2/jYVn
 UHdGpR2qHvyiTLBzU29tMfUVrjr5xZF5xj6OdpU91fqX+jniXjRWTj/rXlQgWPUjtji4YJWE6zE
 tbyG0ibWFGcOefwHcqp/J0NeNEwXBTEUzqHucGTHZpCOfZAlj2rauQxN/cjoW3aMo+BCtpZBp7L
 yrcsJvK48xNTZeqnvc5AyUeeK5PcAxmZiA0IUNsLe1sNYTBGYaAIkzBTaOZuPj6X9n3G9+RKPAH
 QBvsAhP7ShG1pni2wEMKsIdLL2GioZ//pQAYULa0iJ2W2cfD+OZT9OLMr13mmY/PzOM4xASvMOv
 oe4MpvXHU/kUrWhxNpM5IOUJ14Vzd6O75Md5j593w0KtC+pyKI+1kuFdaVuyEsl90jws0iHZ
X-Authority-Analysis: v=2.4 cv=e/4GSbp/ c=1 sm=1 tr=0 ts=681de2cb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=iZYsOS_XLf5MHG6y6EgA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090107

Add support for ADC_TM part of PMIC5 Gen3.

This is an auxiliary driver under the Gen3 ADC driver, which implements the
threshold setting and interrupt generating functionalities of QCOM ADC_TM
drivers, used to support thermal trip points.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v5:
- Addressed reviewer comments related to kernel-doc formatting and other changes.

Changes since v4:
- Fixed a compilation error and updated dependencies in config as suggested
  by reviewer.

 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 531 ++++++++++++++++++
 3 files changed, 541 insertions(+)
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26eb..f9baadbbf598 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -21,6 +21,15 @@ config QCOM_SPMI_ADC_TM5
 	  Thermal client sets threshold temperature for both warm and cool and
 	  gets updated when a threshold is reached.
 
+config QCOM_SPMI_ADC_TM5_GEN3
+	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5 Gen3"
+	depends on QCOM_SPMI_ADC5_GEN3
+	help
+	  This enables the auxiliary thermal driver for the ADC5 Gen3 thermal
+	  monitoring device. It shows up as a thermal zone with multiple trip points.
+	  Thermal client sets threshold temperature for both warm and cool and
+	  gets updated when a threshold is reached.
+
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
 	depends on OF && SPMI && IIO
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 0fa2512042e7..828d9e7bc797 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
 				   tsens-8960.o
 obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
+obj-$(CONFIG_QCOM_SPMI_ADC_TM5_GEN3)	+= qcom-spmi-adc-tm5-gen3.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_QCOM_LMH)		+= lmh.o
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
new file mode 100644
index 000000000000..c63822635f10
--- /dev/null
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/iio/adc/qcom-adc5-gen3-common.h>
+#include <linux/iio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+#include <linux/unaligned.h>
+
+#include "../thermal_hwmon.h"
+
+struct adc_tm5_gen3_chip;
+
+/**
+ * struct adc_tm5_gen3_channel_props - ADC_TM channel structure
+ * @timer: time period of recurring TM measurement.
+ * @tm_chan_index: TM channel number used (ranging from 1-7).
+ * @sdam_index: SDAM on which this TM channel lies.
+ * @common_props: structure withcommon  ADC channel properties.
+ * @high_thr_en: TM high threshold crossing detection enabled.
+ * @low_thr_en: TM low threshold crossing detection enabled.
+ * @chip: ADC TM device.
+ * @tzd: pointer to thermal device corresponding to TM channel.
+ * @last_temp: last temperature that caused threshold violation,
+ *	or a thermal TM channel.
+ * @last_temp_set: indicates if last_temp is stored.
+ */
+struct adc_tm5_gen3_channel_props {
+	unsigned int timer;
+	unsigned int tm_chan_index;
+	unsigned int sdam_index;
+	struct adc5_channel_common_prop common_props;
+	bool high_thr_en;
+	bool low_thr_en;
+	struct adc_tm5_gen3_chip *chip;
+	struct thermal_zone_device *tzd;
+	int last_temp;
+	bool last_temp_set;
+};
+
+/**
+ * struct adc_tm5_gen3_chip - ADC Thermal Monitoring device structure
+ * @dev_data: Top-level ADC device data.
+ * @chan_props: Array of ADC_TM channel structures.
+ * @nchannels: number of TM channels allocated
+ * @dev: SPMI ADC5 Gen3 device.
+ * @tm_handler_work: handler for TM interrupt for threshold violation.
+ */
+struct adc_tm5_gen3_chip {
+	struct adc5_device_data *dev_data;
+	struct adc_tm5_gen3_channel_props *chan_props;
+	unsigned int nchannels;
+	struct device *dev;
+	struct work_struct tm_handler_work;
+};
+
+static int get_sdam_from_irq(struct adc_tm5_gen3_chip *adc_tm5, int irq)
+{
+	int i;
+
+	for (i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
+		if (adc_tm5->dev_data->base[i].irq == irq)
+			return i;
+	}
+	return -ENOENT;
+}
+
+static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
+	u8 status, tm_status[2], val;
+	int ret, sdam_num;
+
+	sdam_num = get_sdam_from_irq(adc_tm5, irq);
+	if (sdam_num < 0) {
+		dev_err(adc_tm5->dev, "adc irq %d not associated with an sdam\n",
+			irq);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_STATUS1,
+			     &status, sizeof(status));
+	if (ret) {
+		dev_err(adc_tm5->dev, "adc read status1 failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
+		dev_err_ratelimited(adc_tm5->dev,
+				    "Unexpected conversion fault, status:%#x\n",
+				    status);
+		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
+		adc5_gen3_status_clear(adc_tm5->dev_data, sdam_num,
+				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_TM_HIGH_STS,
+			     tm_status, sizeof(tm_status));
+	if (ret) {
+		dev_err(adc_tm5->dev, "adc read TM status failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (tm_status[0] || tm_status[1])
+		schedule_work(&adc_tm5->tm_handler_work);
+
+	dev_dbg(adc_tm5->dev, "Interrupt status:%#x, high:%#x, low:%#x\n",
+		status, tm_status[0], tm_status[1]);
+
+	return IRQ_HANDLED;
+}
+
+static int adc5_gen3_tm_status_check(struct adc_tm5_gen3_chip *adc_tm5,
+				     int sdam_index, u8 *tm_status, u8 *buf)
+{
+	int ret;
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
+			     tm_status, 2);
+	if (ret) {
+		dev_err(adc_tm5->dev, "adc read TM status failed with %d\n", ret);
+		return ret;
+	}
+
+	ret = adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR,
+				     tm_status, 2);
+	if (ret) {
+		dev_err(adc_tm5->dev, "adc status clear conv_req failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_CH_DATA0(0),
+			     buf, 16);
+	if (ret)
+		dev_err(adc_tm5->dev, "adc read data failed with %d\n", ret);
+
+	return ret;
+}
+
+static void tm_handler_work(struct work_struct *work)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
+							 tm_handler_work);
+	struct adc_tm5_gen3_channel_props *chan_prop;
+	u8 tm_status[2] = {0};
+	u8 buf[16] = {0};
+	int i, ret = 0, sdam_index = -1;
+
+	for (i = 0; i < adc_tm5->nchannels; i++) {
+		bool upper_set = false, lower_set = false;
+		int temp, offset;
+		u16 code = 0;
+
+		chan_prop = &adc_tm5->chan_props[i];
+		offset = chan_prop->tm_chan_index;
+
+		adc5_gen3_mutex_lock(adc_tm5->dev);
+		if (chan_prop->sdam_index != sdam_index) {
+			sdam_index = chan_prop->sdam_index;
+			ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
+							tm_status, buf);
+			if (ret) {
+				adc5_gen3_mutex_unlock(adc_tm5->dev);
+				break;
+			}
+		}
+
+		if ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en)
+			upper_set = true;
+
+		if ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en)
+			lower_set = true;
+		adc5_gen3_mutex_unlock(adc_tm5->dev);
+
+		if (!(upper_set || lower_set))
+			continue;
+
+		code = get_unaligned_le16(&buf[2 * offset]);
+		pr_debug("ADC_TM threshold code:%#x\n", code);
+
+		ret = adc5_gen3_therm_code_to_temp(adc_tm5->dev,
+						   &chan_prop->common_props,
+						   code, &temp);
+		if (ret) {
+			dev_err(adc_tm5->dev,
+				"Invalid temperature reading, ret = %d, code=%#x\n",
+				ret, code);
+			continue;
+		}
+
+		chan_prop->last_temp = temp;
+		chan_prop->last_temp_set = true;
+		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
+	}
+}
+
+static int adc_tm5_gen3_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
+	struct adc_tm5_gen3_chip *adc_tm5;
+
+	if (!prop || !prop->chip)
+		return -EINVAL;
+
+	adc_tm5 = prop->chip;
+
+	if (prop->last_temp_set) {
+		pr_debug("last_temp: %d\n", prop->last_temp);
+		prop->last_temp_set = false;
+		*temp = prop->last_temp;
+		return 0;
+	}
+
+	return adc5_gen3_get_scaled_reading(adc_tm5->dev, &prop->common_props,
+					    temp);
+}
+
+static int _adc_tm5_gen3_disable_channel(struct adc_tm5_gen3_channel_props *prop)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
+	int ret;
+	u8 val;
+
+	prop->high_thr_en = false;
+	prop->low_thr_en = false;
+
+	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
+	if (ret)
+		return ret;
+
+	val = BIT(prop->tm_chan_index);
+	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			      ADC5_GEN3_TM_HIGH_STS_CLR, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	val = MEAS_INT_DISABLE;
+	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			      ADC5_GEN3_TIMER_SEL, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	/* To indicate there is an actual conversion request */
+	val = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
+	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			      ADC5_GEN3_PERPH_CH, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	val = ADC5_GEN3_CONV_REQ_REQ;
+	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			       ADC5_GEN3_CONV_REQ, &val, sizeof(val));
+}
+
+static int adc_tm5_gen3_disable_channel(struct adc_tm5_gen3_channel_props *prop)
+{
+	return _adc_tm5_gen3_disable_channel(prop);
+}
+
+# define ADC_TM5_GEN3_CONFIG_REGS 12
+
+static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
+				  int low_temp, int high_temp)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
+	u8 conv_req = 0, buf[ADC_TM5_GEN3_CONFIG_REGS];
+	u16 adc_code;
+	int ret;
+
+	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
+	if (ret < 0)
+		return ret;
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, prop->sdam_index,
+			     ADC5_GEN3_SID, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	/* Write SID */
+	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->common_props.sid);
+
+	/*
+	 * Select TM channel and indicate there is an actual
+	 * conversion request
+	 */
+	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
+
+	buf[2] = prop->timer;
+
+	/* Digital param selection */
+	adc5_gen3_update_dig_param(&prop->common_props, &buf[3]);
+
+	/* Update fast average sample value */
+	buf[4] &= ~ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK;
+	buf[4] |= prop->common_props.avg_samples | ADC5_GEN3_FAST_AVG_CTL_EN;
+
+	/* Select ADC channel */
+	buf[5] = prop->common_props.channel;
+
+	/* Select HW settle delay for channel */
+	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK,
+			    prop->common_props.hw_settle_time_us);
+
+	/* High temperature corresponds to low voltage threshold */
+	if (high_temp != INT_MAX) {
+		prop->low_thr_en = true;
+		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
+		put_unaligned_le16(adc_code, &buf[8]);
+	} else {
+		prop->low_thr_en = false;
+	}
+
+	/* Low temperature corresponds to high voltage threshold */
+	if (low_temp != -INT_MAX) {
+		prop->high_thr_en = true;
+		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
+		put_unaligned_le16(adc_code, &buf[10]);
+	} else {
+		prop->high_thr_en = false;
+	}
+
+	buf[7] = 0;
+	if (prop->high_thr_en)
+		buf[7] |= ADC5_GEN3_HIGH_THR_INT_EN;
+	if (prop->low_thr_en)
+		buf[7] |= ADC5_GEN3_LOW_THR_INT_EN;
+
+	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index, ADC5_GEN3_SID,
+			      buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	conv_req = ADC5_GEN3_CONV_REQ_REQ;
+	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			       ADC5_GEN3_CONV_REQ, &conv_req, sizeof(conv_req));
+}
+
+static int adc_tm5_gen3_set_trip_temp(struct thermal_zone_device *tz,
+				      int low_temp, int high_temp)
+{
+	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
+	struct adc_tm5_gen3_chip *adc_tm5;
+	int ret;
+
+	if (!prop || !prop->chip)
+		return -EINVAL;
+
+	adc_tm5 = prop->chip;
+
+	dev_dbg(adc_tm5->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
+		prop->common_props.label, low_temp, high_temp);
+
+	adc5_gen3_mutex_lock(adc_tm5->dev);
+	if (high_temp == INT_MAX && low_temp <= -INT_MAX)
+		ret = adc_tm5_gen3_disable_channel(prop);
+	else
+		ret = adc_tm5_gen3_configure(prop, low_temp, high_temp);
+	adc5_gen3_mutex_unlock(adc_tm5->dev);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops adc_tm_ops = {
+	.get_temp = adc_tm5_gen3_get_temp,
+	.set_trips = adc_tm5_gen3_set_trip_temp,
+};
+
+static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
+{
+	unsigned int i, channel;
+	struct thermal_zone_device *tzd;
+
+	for (i = 0; i < adc_tm5->nchannels; i++) {
+		channel = V_CHAN(adc_tm5->chan_props[i].common_props);
+		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
+						    &adc_tm5->chan_props[i],
+						    &adc_tm_ops);
+
+		if (IS_ERR(tzd)) {
+			if (PTR_ERR(tzd) == -ENODEV) {
+				dev_warn(adc_tm5->dev,
+					 "thermal sensor on channel %d is not used\n",
+					 channel);
+				continue;
+			}
+			return dev_err_probe(adc_tm5->dev, PTR_ERR(tzd),
+					     "Error registering TZ zone:%ld for channel:%d\n",
+					     PTR_ERR(tzd), channel);
+		}
+		adc_tm5->chan_props[i].tzd = tzd;
+		devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);
+	}
+	return 0;
+}
+
+static void adc5_gen3_clear_work(void *data)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = data;
+
+	cancel_work_sync(&adc_tm5->tm_handler_work);
+}
+
+static void adc5_gen3_disable(void *data)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = data;
+	int i;
+
+	adc5_gen3_mutex_lock(adc_tm5->dev);
+	/* Disable all available TM channels */
+	for (i = 0; i < adc_tm5->nchannels; i++)
+		_adc_tm5_gen3_disable_channel(&adc_tm5->chan_props[i]);
+
+	adc5_gen3_mutex_unlock(adc_tm5->dev);
+}
+
+static void adctm_event_handler(struct auxiliary_device *adev)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = auxiliary_get_drvdata(adev);
+
+	schedule_work(&adc_tm5->tm_handler_work);
+}
+
+static int adc_tm5_probe(struct auxiliary_device *aux_dev,
+			 const struct auxiliary_device_id *id)
+{
+	struct adc_tm5_gen3_chip *adc_tm5;
+	struct tm5_aux_dev_wrapper *aux_dev_wrapper;
+	struct device *dev = &aux_dev->dev;
+	int i, ret;
+
+	adc_tm5 = devm_kzalloc(&aux_dev->dev, sizeof(*adc_tm5), GFP_KERNEL);
+	if (!adc_tm5)
+		return -ENOMEM;
+
+	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper,
+				       aux_dev);
+
+	adc_tm5->dev = dev;
+	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
+	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
+	adc_tm5->chan_props = devm_kcalloc(adc_tm5->dev, aux_dev_wrapper->n_tm_channels,
+					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
+	if (!adc_tm5->chan_props)
+		return -ENOMEM;
+
+	for (i = 0; i < adc_tm5->nchannels; i++) {
+		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
+		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
+		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
+		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
+		adc_tm5->chan_props[i].chip = adc_tm5;
+	}
+
+	ret = devm_add_action_or_reset(adc_tm5->dev, adc5_gen3_disable, adc_tm5);
+	if (ret)
+		return ret;
+
+	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);
+
+	/*
+	 * Skipping first SDAM IRQ as it is requested in parent driver.
+	 * If there is a TM violation on that IRQ, the parent driver calls
+	 * the notifier (tm_event_notify) exposed from this driver to handle it.
+	 */
+	for (i = 1; i < adc_tm5->dev_data->num_sdams; i++) {
+		ret = devm_request_threaded_irq(adc_tm5->dev,
+						adc_tm5->dev_data->base[i].irq,
+						NULL, adctm5_gen3_isr, IRQF_ONESHOT,
+						adc_tm5->dev_data->base[i].irq_name,
+						adc_tm5);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * This drvdata is only used in the function (adctm_event_handler)
+	 * called by parent ADC driver in case of TM violation on the first SDAM.
+	 */
+	auxiliary_set_drvdata(aux_dev, adc_tm5);
+
+	ret = devm_add_action(adc_tm5->dev, adc5_gen3_clear_work, adc_tm5);
+	if (ret)
+		return ret;
+
+	ret = adc_tm5_register_tzd(adc_tm5);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
+	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(auxiliary, adctm5_auxiliary_id_table);
+
+static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
+	.adrv = {
+		.id_table = adctm5_auxiliary_id_table,
+		.probe = adc_tm5_probe,
+	},
+	.tm_event_notify = adctm_event_handler,
+};
+
+static int __init adctm5_init_module(void)
+{
+	return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
+}
+
+static void __exit adctm5_exit_module(void)
+{
+	auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
+}
+
+module_init(adctm5_init_module);
+module_exit(adctm5_exit_module);
+
+MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");
-- 
2.25.1


