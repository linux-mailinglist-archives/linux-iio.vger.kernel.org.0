Return-Path: <linux-iio+bounces-91-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EEE7EDA1F
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 04:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377EE1F23113
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 03:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F258C14;
	Thu, 16 Nov 2023 03:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SaGR6M/Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF44C19B;
	Wed, 15 Nov 2023 19:26:20 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFNgUL9014504;
	Thu, 16 Nov 2023 03:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=VTI/9uwHcNkV17TzrV9s/BWIg1bxZ5lNUYXNNH2gbJk=;
 b=SaGR6M/Yx5VXte0T30CcBs7FZlF1i/HSXK8Fze7uE8Jzmg8ief1KgqDfWaMY0EZ2DMTT
 XMnbgHUgEAjzrGTiAqQBEIvuZG4s2rD+gIo/TokRMoV7J5wQKNO2hsz/ptMsYLObyGeV
 vDU4b6zAO5wckFFFNB+ss3nEzyr6Viku0cu8j7wnd7CUiQNbYRuYGaiq9biyY+QpcBUg
 29Q7ducb68r2i1WIReoIS5uwZGwIwssNd3GXv8XAZTV2qRMI9U/dK9zJibla4p+sMj+1
 3m5t6bXtSt0jrJx+MfSFkC/2EO+mv+bJcvO5RaDUCP/bDenigVsmRLlPCzr+4BQeEQel IA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud7b8rdx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 03:25:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG3Pxe3012313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 03:25:59 GMT
Received: from hu-jprakash-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 19:25:47 -0800
From: Jishnu Prakash <quic_jprakash@quicinc.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <daniel.lezcano@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linus.walleij@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marijn.suijten@somainline.org>
CC: <lars@metafoo.de>, <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <lee@kernel.org>, <rafael@kernel.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <cros-qcom-dts-watchers@chromium.org>,
        <sboyd@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <kernel@quicinc.com>,
        Jishnu Prakash
	<quic_jprakash@quicinc.com>
Subject: [PATCH V2 0/3] iio: adc: Add support for QCOM SPMI PMIC5 Gen3 ADC
Date: Thu, 16 Nov 2023 08:55:27 +0530
Message-ID: <20231116032530.753192-1-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vrV0z_b0dM8_XPPRK5pRLazJWrCDLWj9
X-Proofpoint-GUID: vrV0z_b0dM8_XPPRK5pRLazJWrCDLWj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=922 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160025

PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
with all SW communication to ADC going through PMK8550 which
communicates with other PMICs through PBS. The major difference is
that the register interface used here is that of an SDAM present on
PMK8550, rather than a dedicated ADC peripheral. There may be more than one
SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
be used for either immediate reads (same functionality as previous PMIC5 and
PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
combined into the same driver.

Patches 1 adds bindings for ADC5 Gen3 peripheral.

Patches 2 adds driver support for ADC5 Gen3.

Patch 3 is a cleanup, to move the QCOM ADC dt-bindings files from
dt-bindings/iio to dt-bindings/iio/adc folder, as they are
specifically for ADC devices. It also fixes all compilation errors
with this change in driver and devicetree files and similar errors
in documentation for dtbinding check.

Changes since v1:
- Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
- Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
- Combined patches 8-11 into a single patch as requested by reviewers to make
  the change clearer and made all fixes required in same patch.

Jishnu Prakash (3):
  dt-bindings: iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
  iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder

 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  185 ++-
 .../bindings/mfd/qcom,spmi-pmic.yaml          |    2 +-
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml |    2 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |    6 +-
 arch/arm64/boot/dts/qcom/pm2250.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm6125.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi           |    2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8950.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8953.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pmi632.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |    2 +-
 arch/arm64/boot/dts/qcom/pmp8074.dtsi         |    2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi          |    2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |    2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |    2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |    4 +-
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |    2 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |    6 +-
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |    2 +-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |    8 +-
 drivers/iio/adc/Kconfig                       |   25 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 1189 +++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c              |    2 +-
 drivers/iio/adc/qcom-spmi-vadc.c              |    2 +-
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |   50 +
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |   89 ++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |   22 +
 .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |   56 +
 .../iio/{ => adc}/qcom,spmi-adc7-pm8350.h     |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    |    2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    |    0
 .../iio/{ => adc}/qcom,spmi-vadc.h            |   81 ++
 46 files changed, 1725 insertions(+), 61 deletions(-)
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (100%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (77%)

-- 
2.25.1


