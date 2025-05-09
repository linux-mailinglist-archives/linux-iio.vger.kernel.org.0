Return-Path: <linux-iio+bounces-19377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F129AB11D8
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 13:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F99188017B
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322442900AC;
	Fri,  9 May 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgqVWqZr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE36290096
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789063; cv=none; b=emmyb0k1rpHMephv7Yy+huiDDEnv96PmTBAwwSbq78fOiWwhzWMY8qIq6ow4rHCp3ZjaVxa4UbYrGAgVEgWub6K0otXK40E4Hl2U3L8Yy4D+g+tnnFsem7/yzr6PYxC08JqQI2HPqIXUhzUQMOPoOY8r522YYe9lbexcJlNEc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789063; c=relaxed/simple;
	bh=pZtSTCURff1lyLNgqsh8gwHmUvgCVphKV070slmC9xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uj9bMBL7BBkDiw187RcItAZEZlGLimg6BPfOgawaAnvzyrbG8DGcbZufDEj1A8qqzhaoQc6H9C9iWTzn6zCxeUr1YNcwXOAlmIbRHOVCiCxzf84tkFUEZW8cq7TsQALdYhMbO2RTZT4RRk2DXjCEBwRO3CLdT2vAdODoMTWYtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LgqVWqZr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5492cSfl009191
	for <linux-iio@vger.kernel.org>; Fri, 9 May 2025 11:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CuhXK4bd+6q
	ZVAho1tvV0ws2xedyla5eCudKj4wMiAc=; b=LgqVWqZr+9o3kDczhRZWsrevERP
	dhkiSfviDxCibl+xZKXCX9zgWBPh6MXq96U6UkJTKyibzlea3wWDYP5vUe5yaCw0
	NRdPfjepv6Qti4xHwbh3Ybaa0zce/E/YBsh/nI+cY23z4IzQdY/S8DLc3GaTVjdO
	ShuRGnRGePIZ3hMQ2LDBEdemIlhp6RyyLKeLcyOALy36wqsxsjc7MGkl/I5wIcWQ
	7qQRm32my1yYqRKBLsITLDSGCPb6Fp77JKr7tZpvWAL0o1eZzLf0oEKlToKBJnzw
	wP9+8WbN975bDwYoEhsOmNz90S1G9KY6Aj2pkzXAxYpII9ZVkvbgStuVggQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnpevbdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 11:10:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736fff82264so1707649b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 04:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746789058; x=1747393858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuhXK4bd+6qZVAho1tvV0ws2xedyla5eCudKj4wMiAc=;
        b=ewkhOOWDA5bm+/hyRxL+C6yR8AVdREz+zte52JyjRGiS4XorDy+KFuILg9OLlvE2Dj
         inDwQcj0yzawEbXwWrm2UEuiR8hphGt2rPjFdbn7SiAvWnYkl3Y0AqphH/WpRw4fsAfK
         HUu+T8IxVHvlxFu1Kr2q/uNI6mRmOZCdwHC3UR/Pw2auy2peIv/a9U3xO4rwIZ127nNv
         b9GBgIQ2njAKGXsuGmAmDd5P6UM0VJdhZRZ9DwsnbVD3SkZpkpvqthxPehUJmATON9eU
         pkrxWawws0Mgp4vrZvRuRwjNNUZZbhfYQxAB+nE2zNccVfL7FqPT2/0CCacn9BzfDVDv
         Lxsw==
X-Forwarded-Encrypted: i=1; AJvYcCWoQUMhul4egDzuL6XAcu9dTBfgP8UkstQTVaRFK8EEneAzwe4TNysiyeyxGzjGdNiSrOOVUzQeZtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDf0sUR61y+PbkLwQYmQyNQGemucC0gcy7K5bsvkt1g57Xlv7
	qj3DHWmuqeov6SNXmlQtQ4z8+DCdwJRHHXkEw3ZqSaH4SuFKff51O15UxudQLk0Zzyv4lVRWlZs
	L9XimFLIOPU5y0gNwC2OCPAoTMKYRquLkaGjgaCZuur5o11mn6NXQXsZnIOc=
X-Gm-Gg: ASbGnctApwhl2qJdCnZz2UFa3YAfMO4iNEL90ZMNQNuC8cDAYYnKtf+Gk3UFefIlxAK
	8zIKyGsbmmJejK9ivVZnHfC2dIM1deig7L3vXNSAS5r6dei9MHniSDps+KnUBWUT2ovGrbjbY03
	JnUf5QFpuhAHyEvMl06z1Ihfx6Jcs1rfpzUqKJbdVQKSkTV3tHgN+XF+CCHj+M4uH+zO1FXoy0P
	7gLpe+fY2htJpUeOI3tjKqlpzDIwewuUEwXW7wk9eb5pgdh5en0SzW9tIegNuxZ/Q7/cdVbAf24
	Whps7asXBGQAs+pTcwZmM2ZmFLYKZbiRgjpt1QM+QiB6orU=
X-Received: by 2002:a05:6a00:35cc:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-740a94f8e34mr11298901b3a.11.1746789057191;
        Fri, 09 May 2025 04:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9bEBeiPvZvjogc0bfQ61u0TbRhe33gbI/jCT1p/Dwe1cOAhK9a+omJMd3l78oIHyj9zHxRw==
X-Received: by 2002:a05:6a00:35cc:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-740a94f8e34mr11298821b3a.11.1746789056559;
        Fri, 09 May 2025 04:10:56 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237734c4asm1556223b3a.57.2025.05.09.04.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:10:56 -0700 (PDT)
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
Subject: [PATCH V6 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Date: Fri,  9 May 2025 16:39:58 +0530
Message-Id: <20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNyBTYWx0ZWRfXzlLJsoCmDana
 CHMJMvrv5un86b7+takL/xxlZvLcFX1VBm0eJ+fiAMdlSHNbihxC73q3faJfMPipf6RQliYuVPE
 bAfUR4OQ4XCvUPh87g0IASL79P+E0KptyyL4Psd4ruoiJFVgWkDIyCeB6XLbgAqXx6lj0s4XgUL
 NfTra0py4qydBLn3VNGKMKZS01etrKQ8ujTCMvXIoCVVf7xgxF3flfvonPanDMPyEnLyTeEE8P4
 WRILvMUTF0iAkfL5L/JeKHHcxpmSQItSybOywPBQpYkobsn6uALdte8j6UZiacMWYvfoLtEScQA
 WqjUxTVDShHjkyobx0sxzBbSWEZZ4vI3LRTdAM+/DDnMTs1Yy0kf82+KDjKmaAiQLrxRRj7sTIL
 OIKUhUEhwg3PsZVAC33TkR/PI7GAZzAmZyn3FNHievAC4qsntX+EoKD77774LGJr5E9b4Zly
X-Proofpoint-ORIG-GUID: nn88gvKG_rGET8MEACvqEAZESyZg9Gym
X-Proofpoint-GUID: nn88gvKG_rGET8MEACvqEAZESyZg9Gym
X-Authority-Analysis: v=2.4 cv=Yt4PR5YX c=1 sm=1 tr=0 ts=681de2c3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=rXiB4E7PiHHiVjPQOqUA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090107

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

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v5:
- Split mutex function exported to ADC_TM driver into separate functions
  for acquiring and releasing mutex.
- Updated logic for acquiring IRQ numbers to account for removing
  "interrupt-names" DT property.
- Addressed other reviewer comments related to kernel-doc formatting and
  other changes.

Changes since v4:
- Moved out common funtions from newly added .h file into a separate .c
  file to avoid duplicating them. Updated interrupt name as suggested
  by reviewer. Updated namespace export symbol statement to have a string
  as second argument to follow framework change.

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

 drivers/iio/adc/Kconfig                       |  30 +
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/qcom-adc5-gen3-common.c       | 104 +++
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 763 ++++++++++++++++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 193 +++++
 5 files changed, 1092 insertions(+)
 create mode 100644 drivers/iio/adc/qcom-adc5-gen3-common.c
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ad06cf556785..f2f1ee15b3da 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1220,6 +1220,36 @@ config QCOM_SPMI_ADC5
 	  To compile this driver as a module, choose M here: the module will
 	  be called qcom-spmi-adc5.
 
+config QCOM_ADC5_GEN3_COMMON
+	tristate
+
+config QCOM_SPMI_ADC5_GEN3
+	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
+	depends on SPMI && THERMAL
+	select REGMAP_SPMI
+	select QCOM_VADC_COMMON
+	select QCOM_ADC5_GEN3_COMMON
+	select AUXILIARY_BUS
+	help
+	  IIO Voltage PMIC5 Gen3 ADC driver for Qualcomm Technologies Inc.
+
+	  The driver supports reading multiple channels. The ADC is a 16-bit
+	  sigma-delta ADC. The hardware supports calibrated results for
+	  conversion requests and clients include reading phone power supply
+	  voltage, on board system thermistors connected to the PMIC ADC,
+	  PMIC die temperature, charger temperature, battery current, USB
+	  voltage input and voltage signals connected to supported PMIC GPIO
+	  pins. The hardware supports internal pull-up for thermistors and can
+	  choose between a 30k, 100k or 400k ohm pull up using the ADC channels.
+
+	  In addition, the same driver supports ADC thermal monitoring devices
+	  too. They appear as thermal zones with multiple trip points. A thermal
+	  client sets threshold temperature for both warm and cool trips and
+	  gets updated when a threshold is reached.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called qcom-spmi-adc5-gen3.
+
 config RCAR_GYRO_ADC
 	tristate "Renesas R-Car GyroADC driver"
 	depends on ARCH_RCAR_GEN2 || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 07d4b832c42e..8adbb5f42285 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -103,8 +103,10 @@ obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
 obj-$(CONFIG_PAC1921) += pac1921.o
 obj-$(CONFIG_PAC1934) += pac1934.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
+obj-$(CONFIG_QCOM_ADC5_GEN3_COMMON) += qcom-adc5-gen3-common.o
 obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
+obj-$(CONFIG_QCOM_SPMI_ADC5_GEN3) += qcom-spmi-adc5-gen3.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
 obj-$(CONFIG_QCOM_SPMI_RRADC) += qcom-spmi-rradc.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
diff --git a/drivers/iio/adc/qcom-adc5-gen3-common.c b/drivers/iio/adc/qcom-adc5-gen3-common.c
new file mode 100644
index 000000000000..edd618b0d39f
--- /dev/null
+++ b/drivers/iio/adc/qcom-adc5-gen3-common.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
+ * of type ADC5 Gen3.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/iio/adc/qcom-adc5-gen3-common.h>
+
+int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
+		   u16 offset, u8 *data, int len)
+{
+	return regmap_bulk_read(adc->regmap,
+				adc->base[sdam_index].base_addr + offset,
+				data, len);
+}
+EXPORT_SYMBOL(adc5_gen3_read);
+
+int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
+		    u16 offset, u8 *data, int len)
+{
+	return regmap_bulk_write(adc->regmap,
+				 adc->base[sdam_index].base_addr + offset,
+				 data, len);
+}
+EXPORT_SYMBOL(adc5_gen3_write);
+
+/*
+ * Worst case delay from PBS in readying handshake bit
+ * can be up to 15ms, when PBS is busy running other
+ * simultaneous transactions, while in the best case, it is
+ * already ready at this point. Assigning polling delay and
+ * retry count accordingly.
+ */
+
+#define ADC5_GEN3_HS_DELAY_US			100
+#define ADC5_GEN3_HS_RETRY_COUNT		150
+
+int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
+			   unsigned int sdam_index)
+{
+	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
+	int ret, count;
+	u8 status = 0;
+
+	for (count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
+		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, sizeof(status));
+		if (ret)
+			return ret;
+
+		if (status == ADC5_GEN3_HS_READY) {
+			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
+					     &conv_req, sizeof(conv_req));
+			if (ret)
+				return ret;
+
+			if (!conv_req)
+				return 0;
+		}
+
+		fsleep(ADC5_GEN3_HS_DELAY_US);
+	}
+
+	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n",
+	       sdam_index, status);
+	return -ETIMEDOUT;
+}
+EXPORT_SYMBOL(adc5_gen3_poll_wait_hs);
+
+void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data)
+{
+	/* Update calibration select and decimation ratio select */
+	*data &= ~(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK | ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK);
+	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
+	*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK, prop->decimation);
+}
+EXPORT_SYMBOL(adc5_gen3_update_dig_param);
+
+int adc5_gen3_status_clear(struct adc5_device_data *adc,
+			   int sdam_index, u16 offset, u8 *val, int len)
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
+	ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &value, sizeof(value));
+	if (ret)
+		return ret;
+
+	value = ADC5_GEN3_CONV_REQ_REQ;
+	return adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &value, sizeof(value));
+}
+EXPORT_SYMBOL(adc5_gen3_status_clear);
+
+MODULE_DESCRIPTION("Qualcomm ADC5 Gen3 common functionality");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
new file mode 100644
index 000000000000..25b58b9be3b7
--- /dev/null
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -0,0 +1,763 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
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
+ * struct adc5_channel_prop - ADC channel structure
+ * @common_props: structure with ADC channel properties (common to TM usage).
+ * @adc_tm: indicates TM type if the channel is used for TM measurements.
+ * @chip: pointer to top-level ADC device structure.
+ */
+struct adc5_channel_prop {
+	struct adc5_channel_common_prop common_props;
+	int adc_tm;
+	struct adc5_chip *chip;
+};
+
+/**
+ * struct adc5_chip - ADC private structure.
+ * @dev: SPMI ADC5 Gen3 device.
+ * @dev_data: Top-level ADC device data.
+ * @nchannels: number of ADC channels.
+ * @chan_props: array of ADC channel properties.
+ * @iio_chans: array of IIO channels specification.
+ * @complete: ADC result notification after interrupt is received.
+ * @lock: ADC lock for access to the peripheral, to prevent concurrent
+ * requests from multiple clients.
+ * @data: software configuration data.
+ * @n_tm_channels: number of ADC channels used for TM measurements.
+ * @tm_aux: pointer to auxiliary TM device.
+ */
+struct adc5_chip {
+	struct device *dev;
+	struct adc5_device_data dev_data;
+	unsigned int nchannels;
+	struct adc5_channel_prop *chan_props;
+	struct iio_chan_spec *iio_chans;
+	struct completion complete;
+	/*
+	 * lock for access to the peripheral, to prevent concurrent
+	 * requests from multiple clients.
+	 */
+	struct mutex lock;
+	const struct adc5_data *data;
+	unsigned int n_tm_channels;
+	struct auxiliary_device *tm_aux;
+};
+
+static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data)
+{
+	u8 rslt[2];
+	int ret;
+
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
+			     ADC5_GEN3_CH_DATA0(0), rslt, sizeof(rslt));
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
+static int adc5_gen3_configure(struct adc5_chip *adc,
+			       struct adc5_channel_common_prop *prop)
+{
+	u8 buf[ADC5_GEN3_READ_CONFIG_REGS];
+	u8 conv_req = 0;
+	int ret;
+
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_SID,
+			     buf, sizeof(buf));
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
+	buf[4] = FIELD_PREP(ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK,
+			    prop->avg_samples) | ADC5_GEN3_FAST_AVG_CTL_EN;
+
+	/* Select ADC channel */
+	buf[5] = prop->channel;
+
+	/* Select HW settle delay for channel */
+	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK,
+			    prop->hw_settle_time_us);
+
+	reinit_completion(&adc->complete);
+
+	ret = adc5_gen3_write(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_SID,
+			      buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	conv_req = ADC5_GEN3_CONV_REQ_REQ;
+	return adc5_gen3_write(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
+			       ADC5_GEN3_CONV_REQ, &conv_req, sizeof(conv_req));
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
+				   struct adc5_channel_common_prop *prop,
+				   u16 *data_volt)
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
+	return adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
+				      ADC5_GEN3_EOC_CLR, &val, 1);
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
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
+			     ADC5_GEN3_STATUS1, &status, sizeof(status));
+	if (ret) {
+		dev_err(adc->dev, "adc read status1 failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
+			     ADC5_GEN3_EOC_STS, &eoc_status, sizeof(eoc_status));
+	if (ret) {
+		dev_err(adc->dev, "adc read eoc status failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
+		dev_err_ratelimited(adc->dev,
+				    "Unexpected conversion fault, status:%#x, eoc_status:%#x\n",
+				    status, eoc_status);
+		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
+		adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
+				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
+		return IRQ_HANDLED;
+	}
+
+	/* CHAN0 is the preconfigured channel for immediate conversion */
+	if (eoc_status & ADC5_GEN3_EOC_CHAN_0)
+		complete(&adc->complete);
+
+	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
+			     ADC5_GEN3_TM_HIGH_STS, tm_status, sizeof(tm_status));
+	if (ret) {
+		dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (tm_status[0] || tm_status[1]) {
+		adev = adc->tm_aux;
+		if (!adev || !adev->dev.driver) {
+			dev_err(adc->dev,
+				"adc_tm auxiliary device not initialized\n");
+			return IRQ_HANDLED;
+		}
+
+		adrv_tm = container_of(adev->dev.driver,
+				       struct adc_tm5_auxiliary_drv,
+				       adrv.driver);
+
+		if (adrv_tm && adrv_tm->tm_event_notify)
+			adrv_tm->tm_event_notify(adev);
+		else
+			dev_err(adc->dev,
+				"adc_tm auxiliary driver not initialized\n");
+	}
+
+	dev_dbg(adc->dev,
+		"Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
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
+			      struct iio_chan_spec const *chan, int *val,
+			      int *val2, long mask)
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
+		return dev_err_probe(dev, ret, "invalid channel number %s\n",
+				     name);
+
+	/*
+	 * Value read from "reg" is virtual channel number
+	 * virtual channel number = sid << 8 | channel number
+	 */
+	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
+	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
+
+	if (chan > ADC5_GEN3_OFFSET_EXT2)
+		return dev_err_probe(dev, -EINVAL,
+				     "%s invalid channel number %d\n",
+				     name, chan);
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
+				     chan, value);
+	prop->common_props.decimation = ret;
+
+	prop->common_props.prescale = adc->data->adc_chans[chan].prescale_index;
+	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
+	if (!ret) {
+		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "%#x invalid pre-scaling <%d %d>\n",
+				chan, varr[0], varr[1]);
+		prop->common_props.prescale = ret;
+	}
+
+	value = data->hw_settle_1[VADC_DEF_HW_SETTLE_TIME];
+	fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
+	ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_1);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "%#x invalid hw-settle-time %d us\n",
+				     chan, value);
+	prop->common_props.hw_settle_time_us = ret;
+
+	value = BIT(VADC_DEF_AVG_SAMPLES);
+	fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
+	ret = qcom_adc5_avg_samples_from_dt(value);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "%#x invalid avg-samples %d\n",
+				     chan, value);
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
+		if (adc->n_tm_channels > ((adc->dev_data.num_sdams * 8) - 1))
+			return dev_err_probe(dev, -EINVAL,
+					     "Number of TM nodes %u greater than channels supported:%u\n",
+					     adc->n_tm_channels,
+					     (adc->dev_data.num_sdams * 8) - 1);
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
+				{ 15, 100, 200, 300, 400, 500, 600, 700,
+				  1000, 2000, 4000, 8000, 16000, 32000,
+				  64000, 128000 },
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
+	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device,
+						    dev);
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
+					    sizeof(*aux_device->tm_props),
+					    GFP_KERNEL);
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
+	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
+				       &aux_device->aux_dev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(&aux_device->aux_dev);
+	if (ret)
+		return ret;
+	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux,
+				       &aux_device->aux_dev);
+	if (ret)
+		return ret;
+
+	adc->tm_aux = &aux_device->aux_dev;
+
+	return 0;
+}
+
+void adc5_gen3_mutex_lock(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
+	struct adc5_chip *adc = iio_priv(indio_dev);
+
+	mutex_lock(&adc->lock);
+}
+EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_lock, "QCOM_SPMI_ADC5_GEN3");
+
+void adc5_gen3_mutex_unlock(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
+	struct adc5_chip *adc = iio_priv(indio_dev);
+
+	mutex_unlock(&adc->lock);
+}
+EXPORT_SYMBOL_NS_GPL(adc5_gen3_mutex_unlock, "QCOM_SPMI_ADC5_GEN3");
+
+int adc5_gen3_get_scaled_reading(struct device *dev,
+				 struct adc5_channel_common_prop *common_props,
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
+	return qcom_adc5_hw_scale(common_props->scale_fn_type,
+				  common_props->prescale,
+				  adc->data, adc_code_volt, val);
+}
+EXPORT_SYMBOL_NS_GPL(adc5_gen3_get_scaled_reading, "QCOM_SPMI_ADC5_GEN3");
+
+int adc5_gen3_therm_code_to_temp(struct device *dev,
+				 struct adc5_channel_common_prop *common_props,
+				 u16 code, int *val)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
+	struct adc5_chip *adc = iio_priv(indio_dev);
+
+	return qcom_adc5_hw_scale(common_props->scale_fn_type,
+				  common_props->prescale,
+				  adc->data, code, val);
+}
+EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, "QCOM_SPMI_ADC5_GEN3");
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
+	adc->dev_data.num_sdams = ret;
+
+	reg = devm_kcalloc(dev, adc->dev_data.num_sdams, sizeof(u32),
+			   GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	ret = device_property_read_u32_array(dev, "reg", reg,
+					     adc->dev_data.num_sdams);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read reg property\n");
+
+	adc->dev_data.base = devm_kcalloc(dev, adc->dev_data.num_sdams,
+					  sizeof(*adc->dev_data.base),
+					  GFP_KERNEL);
+	if (!adc->dev_data.base)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, indio_dev);
+	init_completion(&adc->complete);
+	mutex_init(&adc->lock);
+
+	for (i = 0; i < adc->dev_data.num_sdams; i++) {
+		adc->dev_data.base[i].base_addr = reg[i];
+
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Getting IRQ %d failed\n",
+					     adc->dev_data.base[i].irq);
+
+		adc->dev_data.base[i].irq = ret;
+
+		adc->dev_data.base[i].irq_name = devm_kasprintf(dev, GFP_KERNEL,
+								"sdam%d", i);
+		if (!adc->dev_data.base[i].irq_name)
+			return -ENOMEM;
+	}
+
+	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
+			       adc5_gen3_isr, 0,
+			       adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
+			       adc);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to request SDAM%d irq\n",
+				     ADC5_GEN3_VADC_SDAM);
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
index 000000000000..4f476cd77b37
--- /dev/null
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
+ * of type ADC5 Gen3.
+ */
+
+#ifndef QCOM_ADC5_GEN3_COMMON_H
+#define QCOM_ADC5_GEN3_COMMON_H
+
+#include <linux/auxiliary_bus.h>
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
+	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)
+
+enum adc5_cal_method {
+	ADC5_NO_CAL = 0,
+	ADC5_RATIOMETRIC_CAL,
+	ADC5_ABSOLUTE_CAL,
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
+/**
+ * struct adc5_sdam_data - data per SDAM allocated for adc usage
+ * @base_addr: base address for the ADC SDAM peripheral.
+ * @irq_name: ADC IRQ name.
+ * @irq: ADC IRQ number.
+ */
+struct adc5_sdam_data {
+	u16 base_addr;
+	const char *irq_name;
+	int irq;
+};
+
+/**
+ * struct adc5_device_data - Top-level ADC device data
+ * @regmap: ADC peripheral register map field.
+ * @base: array of SDAM data.
+ * @num_sdams: number of ADC SDAM peripherals.
+ */
+struct adc5_device_data {
+	struct regmap *regmap;
+	struct adc5_sdam_data *base;
+	int num_sdams;
+};
+
+/**
+ * struct adc5_channel_common_prop - ADC channel properties (common to ADC and TM).
+ * @channel: channel number, refer to the channel list.
+ * @cal_method: calibration method.
+ * @decimation: sampling rate supported for the channel.
+ * @sid: ID of PMIC owning the channel.
+ * @label: Channel name used in device tree.
+ * @prescale: channel scaling performed on the input signal.
+ * @hw_settle_time_us: the time between AMUX being configured and the
+ *	start of conversion in uS.
+ * @avg_samples: ability to provide single result from the ADC
+ *	that is an average of multiple measurements.
+ * @scale_fn_type: Represents the scaling function to convert voltage
+ *	physical units desired by the client for the channel.
+ */
+struct adc5_channel_common_prop {
+	unsigned int channel;
+	enum adc5_cal_method cal_method;
+	unsigned int decimation;
+	unsigned int sid;
+	const char *label;
+	unsigned int prescale;
+	unsigned int hw_settle_time_us;
+	unsigned int avg_samples;
+	enum vadc_scale_fn_type scale_fn_type;
+};
+
+/**
+ * struct tm5_aux_dev_wrapper - wrapper structure around TM auxiliary device
+ * @aux_dev: TM auxiliary device structure.
+ * @dev_data: Top-level ADC device data.
+ * @tm_props: Array of common ADC channel properties for TM channels.
+ * @n_tm_channels: number of TM channels.
+ */
+struct tm5_aux_dev_wrapper {
+	struct auxiliary_device aux_dev;
+	struct adc5_device_data *dev_data;
+	struct adc5_channel_common_prop *tm_props;
+	unsigned int n_tm_channels;
+};
+
+/**
+ * struct tm5_aux_dev_wrapper - wrapper structure around TM auxiliary driver
+ * @adrv: TM auxiliary driver structure.
+ * @tm_event_notify: TM callback to be called by parent driver.
+ */
+struct adc_tm5_auxiliary_drv {
+	struct auxiliary_driver adrv;
+	void (*tm_event_notify)(struct auxiliary_device *adev);
+};
+
+int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
+		   u16 offset, u8 *data, int len);
+
+int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
+		    u16 offset, u8 *data, int len);
+
+int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
+			   unsigned int sdam_index);
+
+void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop,
+				u8 *data);
+
+int adc5_gen3_status_clear(struct adc5_device_data *adc,
+			   int sdam_index, u16 offset, u8 *val, int len);
+
+void adc5_gen3_mutex_lock(struct device *dev);
+void adc5_gen3_mutex_unlock(struct device *dev);
+int adc5_gen3_get_scaled_reading(struct device *dev,
+				 struct adc5_channel_common_prop *common_props,
+				 int *val);
+int adc5_gen3_therm_code_to_temp(struct device *dev,
+				 struct adc5_channel_common_prop *common_props,
+				 u16 code, int *val);
+
+#endif /* QCOM_ADC5_GEN3_COMMON_H */
-- 
2.25.1


