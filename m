Return-Path: <linux-iio+bounces-26515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63649C8E89F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 14:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFA414E8CD3
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF732A3E7;
	Thu, 27 Nov 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O72+TC3q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AyrDV/sS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81531CA6A
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250923; cv=none; b=JrzBvHwHym2EsBr9tNhFamOoyWZFPO2I7LeraZKzH2T+R+m805JQ6CRx/3bDw6F0PAwNMq6OnoKRAZc9amfnP/hlCiyUro+OobCUYlZteoh+dYwC6G9bbnaT7D5YiVVYPRPOj1L/SwO9dNKrQlHl3tE+QPt4cXbR+Zenu6mPnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250923; c=relaxed/simple;
	bh=eFE5oWLaCjttfJkjsnfJp2+e8Nx+toCXMoj1KNKIbmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfwkSly6RVudaHY56BtLbX5G+PbhKjYKN5HRrAJJC0v1iYE4i1Kg9bO4/U7a2he3WYAKgGmkS+2z8pDClbJdT/qu9RdtQoDhfrPqNcAEUeRXEzNghc0gB+KTS5PPQFcGa01K0lowY8LNskTOgl6gxFLirytUsj/pZ44/l0ossG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O72+TC3q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AyrDV/sS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR9GCPB606831
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 13:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=T1eS4m0MlwX
	BImur1I1mcCoDy8vCqgpRl3bodsHm5Zg=; b=O72+TC3qRKOyUFCqmdWOfvi1wPP
	aEkcJujrVD/6fMaW/eEK0KT40a+7L5Z75Qhlb2qqr4Ju8/I84+0/Qbpoft6B7ERy
	hzLubGoeP9gHw2CLiuTb8TGaXkRJ99pe1f1hMLfsZCiHe2SS5lYfmCKzc2hrZCWm
	KM00lhAAg3AwWqFvsbWG/cm2vaNWXBbt3+D905PBZmQZk+kzy2u42tBW6hreu8+V
	YeY1WLPKwul3Umt6XNLqJQ4aCyOEuw8SI7VwAUgLVls/xe/dT1YbmNF9+YhyocHD
	yaZ7+20k0Lhyck6fYXW5BjO75Y1ihJzm4pPURNVffj+CAAUeFHCWCgmsMpw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apkv5gpat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 13:41:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297dfae179bso18674995ad.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 05:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764250919; x=1764855719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1eS4m0MlwXBImur1I1mcCoDy8vCqgpRl3bodsHm5Zg=;
        b=AyrDV/sSvBkp7QS6o42/YhlfMcEDitP6qsAuzNfY0YiFOgA5PHSPLABciXbVgyEK+A
         s9IWEqfFjba4ZH7xgXW1HphhPST8eZhJ77Wljv8/6WUH/XR7+hS6RwILHh1oIDKdBM44
         diEfZSFwumtITeCW8yLsjw6o9DypIwOPgYxZVQpJmIMYqyQBgZUsc+x+PT8Z3Q6YUAyY
         U6VnZO1B07lvBB3fnz4Kj0uC8TwUt8Tvl4XMHxPXtVqWdgvob7fgI7S+WtdC1hdJAU32
         yjUznGbHQBeeIt9AWgFELLvtRv6s4Jz5O2NZrdaswT+DJf8+dkh+rs3jnm1g5xRQ8UBA
         ELYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764250919; x=1764855719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T1eS4m0MlwXBImur1I1mcCoDy8vCqgpRl3bodsHm5Zg=;
        b=pzG++u/d+prWULkr+Km4saEJfHcRaOGNELPIn40XYdkypcZji74xOnYEgP4fmTtm/b
         cp4GG8tkah8yd2VUtXmgJrltYrLQotKPUGjWtiz54O90B9P+oPHCMb+l1eavpcJNOeHg
         eQN9DM5J1I8ISOHbisiJ+9dGI1+tkR0Qoz3o41YuSnjJsr441U6kb9tG7Tt6vhkz7+vV
         NwZObaR6wr99AQOiAxkIwZxqTjG+FU2j4RtUOxWKjcZpC6hpNJ2B0BTAMRrByOqGapcC
         SRCs0aezbR2rqahebzC37y+/Nh6V8Y1sxCbYZ/j8Jc7nhdtLMnr/dty4xhC1gQjQnEr9
         8DhA==
X-Forwarded-Encrypted: i=1; AJvYcCX1GMMA5Hsu/7ivvTQgD6vGHYK4F34S698B4V2NLoQBvj45eGcEexWTgnaVW9qETAQ2qouh2kxPwtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7i2N4SMqwaRpe7t42ipVRydFDpH9NWUxDF0DtT+87Wjn36ZY
	zcJvlPp1/lrwXTNfo1YQjWx7pWfRTQZVWpwCz8661HLeesQFpN+CXSGIZTEu+f/kyYfWsf1HeyE
	0D8/4NH6m5Fk9xvN841+CJ0ExXhBsx5dvlLPfbJIVTlsIRIaYgcOwtNMuaRydGfM=
X-Gm-Gg: ASbGncs91zot5McgX14vFAfqHSx1cl3YUp7PZ1tfRAGbdyvHdZRCgOjf7ruupv6ystS
	r4gYeou6VO+r2CXnUYpBjn6Q3ZaXmfO0ZgyAgDWLLbRpmcyD5tW/nQcbI+eBDYRRuCzRrtYp+qB
	I/0fj835oejXaRynMcs9FKEbZjaK0xgdtOn1EfCT5uHIcNqHA8rWZXdoB8ZXrt5Vy30N5S9HlzC
	ukZIIMX9eHv2f3s/DBTBa/T2zPgAShEfRz2m2o/HwBUAd3RKHEwKyLNwIwhi1Z8rBV0XxkhT+Cr
	rIJK7R6ofTGYhDg+XKWS3XOKnxcF/ngXoc8/VfnAUoxnT21INNetGugmGVavkswzSToQMHbQe7p
	4DXjEmyYyL8Sclog6d0FT88lS7RsZHkiMCt8ESwY8hlc1
X-Received: by 2002:a17:903:11cd:b0:298:68e:4057 with SMTP id d9443c01a7336-29b6bfadca0mr259173235ad.59.1764250918407;
        Thu, 27 Nov 2025 05:41:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF05bAL2WGJ3RPjoLWilaW3EGLd1bsTFOeSGz46NFDXFN0J+Zyo7+t/JY+Rcgfaz3hO72KCtg==
X-Received: by 2002:a17:903:11cd:b0:298:68e:4057 with SMTP id d9443c01a7336-29b6bfadca0mr259172745ad.59.1764250917754;
        Thu, 27 Nov 2025 05:41:57 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce441600sm18934875ad.29.2025.11.27.05.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:41:57 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
Subject: [PATCH V8 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring
Date: Thu, 27 Nov 2025 19:10:36 +0530
Message-Id: <20251127134036.209905-5-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BjJaQ5yWsmRVGfh49AnNmJVO9RfwzIPV
X-Authority-Analysis: v=2.4 cv=O8k0fR9W c=1 sm=1 tr=0 ts=69285527 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=osoZdi1E9HUM2AVx-jAA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwMSBTYWx0ZWRfX5VCXZUML3GlQ
 N6R48ACg3zlb8sUXDHkk2EJm7XXll3is/z0BYc325P1SCatrf7YZZMUb2MNOJLruXZw6TyCQ+pz
 0M5TGREulyfx2whJ7P8jGgMZxTLo+sdwEISJPSg1GV8CF9FQ4FQxnQX4qfl1eOxBLwQp3xYQeOy
 jfnbcpMfc7TNHNNVrnQ+xBhfZSAiCOdc0iFOm1/dZ0sYPD/dPy9gYbQivCnIHlW1TgFe7vJodag
 Fc+hSqhAzu8emP3SabCZJYzVj8ZDlZXosk9LLih2z557DvBnVkundEw56K6PfukW+m50LGTTF1K
 iX+V1vi5aeU3QolY7W75xX815pSOMsMfbrGeFmbMP6tAfo5sTuG0KbWjqugpa8vfLEJonKMNGNH
 G0lWQ5gOvgPbBajEnZa1dsB2n0uETg==
X-Proofpoint-GUID: BjJaQ5yWsmRVGfh49AnNmJVO9RfwzIPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270101

Add support for ADC_TM part of PMIC5 Gen3.

This is an auxiliary driver under the Gen3 ADC driver, which implements the
threshold setting and interrupt generating functionalities of QCOM ADC_TM
drivers, used to support thermal trip points.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v7:
- Addressed following comments from Jonathan:
  - Replaced {0} with { } in tm_handler_work()
  - Simplified logic for setting upper_set and lower_set into
    a single line each, in tm_handler_work()
  - Cleaned up local variable declarations and high/low threshold
    check in adc_tm5_gen3_configure()
  - Moved cleanup action to disable all ADC_TM channels to probe
    end and added comment to describe it.
  - Fixed { } formatting in adctm5_auxiliary_id_table[].

Changes since v6:
- Addressed following comments from Jonathan:
  - Added error check for devm_thermal_add_hwmon_sysfs() call.
  - Used local variable `dev` in multiple places in adc_tm5_probe().
    in place of `&aux_dev->dev` and `adc_tm5->dev`.
  - Added a comment to explain cleanup action calling adc5_gen3_clear_work()
    near probe end.
  - Fixed return statement at probe end to return last called API's
    return value directly.

Changes since v5:
- Addressed following comments from Jonathan:
  - Corrected all files to follow kernel-doc formatting fully.
  - Cleaned up formatting in struct definitions.
  - Used sizeof() to specify length in register read/write calls
    instead of using integers directly.
  - Added comments in adc_tm5_probe() for skipping first SDAM for
    IRQ request and for usage of auxiliary_set_drvdata().
  - Corrected line wrap length driver file.
  - Moved INIT_WORK() and auxiliary_set_drvdata() to earlier
    locations to ensure they are ready when needed.

Changes since v4:
- Fixed a compilation error and updated dependencies in config as suggested
  by Krzysztof.

 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 530 ++++++++++++++++++
 3 files changed, 540 insertions(+)
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index a6bb01082ec6..1acb11e4ac80 100644
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
index 000000000000..c6cc8ef76f7e
--- /dev/null
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
@@ -0,0 +1,530 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
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
+	int ret, sdam_num;
+	u8 tm_status[2];
+	u8 status, val;
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
+	u8 tm_status[2] = { };
+	u8 buf[16] = { };
+	int sdam_index = -1;
+	int i, ret;
+
+	for (i = 0; i < adc_tm5->nchannels; i++) {
+		bool upper_set, lower_set;
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
+		upper_set = ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en);
+		lower_set = ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en);
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
+#define ADC_TM5_GEN3_CONFIG_REGS 12
+
+static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
+				  int low_temp, int high_temp)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
+	u8 buf[ADC_TM5_GEN3_CONFIG_REGS];
+	u8 conv_req;
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
+	/* Select TM channel and indicate there is an actual conversion request */
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
+	prop->low_thr_en = (high_temp != INT_MAX);
+	if (prop->low_thr_en) {
+		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
+		put_unaligned_le16(adc_code, &buf[8]);
+	}
+
+	/* Low temperature corresponds to high voltage threshold */
+	prop->high_thr_en = (low_temp != -INT_MAX);
+	if (prop->high_thr_en) {
+		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
+		put_unaligned_le16(adc_code, &buf[10]);
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
+	int ret;
+
+	for (i = 0; i < adc_tm5->nchannels; i++) {
+		channel = ADC5_GEN3_V_CHAN(adc_tm5->chan_props[i].common_props);
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
+		ret = devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);
+		if (ret)
+			return ret;
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
+	adc_tm5 = devm_kzalloc(dev, sizeof(*adc_tm5), GFP_KERNEL);
+	if (!adc_tm5)
+		return -ENOMEM;
+
+	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper,
+				       aux_dev);
+
+	adc_tm5->dev = dev;
+	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
+	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
+	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
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
+	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);
+
+	/*
+	 * Skipping first SDAM IRQ as it is requested in parent driver.
+	 * If there is a TM violation on that IRQ, the parent driver calls
+	 * the notifier (tm_event_notify) exposed from this driver to handle it.
+	 */
+	for (i = 1; i < adc_tm5->dev_data->num_sdams; i++) {
+		ret = devm_request_threaded_irq(dev,
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
+	/*
+	 * This is to cancel any instances of tm_handler_work scheduled by
+	 * TM interrupt, at the time of module removal.
+	 */
+
+	ret = devm_add_action(dev, adc5_gen3_clear_work, adc_tm5);
+	if (ret)
+		return ret;
+
+	ret = adc_tm5_register_tzd(adc_tm5);
+	if (ret)
+		return ret;
+
+	/* This is to disable all ADC_TM channels in case of probe failure. */
+
+	return devm_add_action(dev, adc5_gen3_disable, adc_tm5);
+}
+
+static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
+	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
+	{ }
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


