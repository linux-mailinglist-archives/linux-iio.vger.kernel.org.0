Return-Path: <linux-iio+bounces-19375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3CAB11BB
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 13:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FED01C06100
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050928FFC0;
	Fri,  9 May 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WDy3g69Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77F28FAB3
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789043; cv=none; b=PY/IITVmbyTXrCbix1cvHmI3nzwNJea+5yyEZZx4wIdQuY9AH8mhXeL7IuMI7hGmLfONnr5ow7PntDE4hyDlNtTcLqUrSji/oOGEoIRIJtCkQHF0sN6HbATG9xS6IqZx2Qn6cJ858gvWiiAct5lkBOifxGqdl0kCLkL23uJxoGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789043; c=relaxed/simple;
	bh=tbQ+99I4RjkwIFC9AH8ORLe9WzoDdsHe2enRXjBMsEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojPowWDWfjU5H+EIWkn6/ATZ3+ppXxtLOaKJTeqY0haQ2W5BfHQVrkMNKb48i+5v0/ZPFLqpj3y09mexRrktDqr5HFH4hYMF0Q6Ka4NCRg6RFeQRU1xfI1Ad9Cby4UE7ekKovty9GYsBgCZSFMZQOPP8Ga5Gc6yWPGmjr6HW6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WDy3g69Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54930vc8011683
	for <linux-iio@vger.kernel.org>; Fri, 9 May 2025 11:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xqpeow/6xs4
	HD3Z9g+9bGocUxKBcIuilj+ZOsa9hyaU=; b=WDy3g69Zen2jF44xuzoPn7eRdvh
	qDiPykA/0xaKGOqBUROiJ8Z3jmwZa9Uj3JiFDhl1ZYtbAwTAnsxKHw9w1NZxaskA
	yOIPJHbMjsDT7e3m6ybU/14LxmnuP3z1zTK+xrzu90047m7eJmTbzK4BUwetToLH
	vtEw6KUFzNgzMdGKPlQNPwECyYUVxPJ2ilXTv+6Re8S11lazcil/K4DHunXXrE3/
	/L4r/QhgHG5pb2yXGKg0pgRYJKI6P2KqFrkzylmUM3fcEidZoqP+YLNcWVvNDSYw
	eJShroq4O0Q+e/2mesVBiIC4qS6GKxzxorFs/X+b5eI0XA1IeclzGPNDEyA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnpmmeha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 11:10:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7377139d8b1so1787676b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 04:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746789039; x=1747393839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqpeow/6xs4HD3Z9g+9bGocUxKBcIuilj+ZOsa9hyaU=;
        b=dJQhW1Z5qL7xLlUjyPGa5W0bTuAG1ruUfvFp+YUrI0ZjtWdAzsdpQ3qpg4iYRz4oko
         SnAd0k9/f3RSUCtbd9WOA49jM/j7wje26dkYUYrXA2Q/vs3v8hYkk5vZJ8Pjczw3LMAP
         UKf96+HVXcEsMcJBCV55SSBaf6XUIcbU/qtUOg271q6qDoxzq8CpB9+wGUe1dPr6MT9O
         pBdxbHczLt2TL3jTKOLrLPS/bptO6/PtFPl563kSxyHFXltUzZGw9yUVKQ1hEZeyzS1L
         PCebyFPrINdd2lIMXQnk0MkpHT68nLSVjivf+Gw5RqjYzEXJ+62u8UP1BYCl0SFa6SZ/
         JCsA==
X-Forwarded-Encrypted: i=1; AJvYcCVL70grJMIAQCWV58j2V0goJFlpZjRtrmBWxn56+YhCZQ4d8f8PHhSbmAdUCpeyRIZ0ofSAwYQrKsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+l0xfYPpvEnabdQVxehA8PVg2c2nCYr3/wL6g3d34syf2uu+
	+kpk2kJWgFlwgd3r1ZI7tS8W5nO0TJKYOW4PVYRT+g4+c8QW9MCt5ADfSbScK4e8JQ7Lx+rI6+5
	c59hUrcPBUPICO3XH6NDS4E6WhwldcaEE4Lqh6NXdkKk48CV+pdyJmwF9KfI=
X-Gm-Gg: ASbGncvFbj1wwDiVqThCZoVFLjnvE7G78YsksgTSGIBugpKC5pDbb1UhlKcif65f+y9
	Q/fpSm/4jaVpAkFXN1mhg87TU0SAcJV3LVW6F97dGoEAu40BLGB6EbBQQP5L3W3F8MHPWCJv/Na
	0+gBk+t5VDefkTVzzZZzN4y1oyuGtCaQvs53n1DXuQE7apw0ha7HEbdC0qMEr95UjUxxZMxFzuY
	CigZYupxQjKjRFAkImzHYHeAaSkCTTiAF7YX0rzYaf/DGq2N4nDSWihyYi8eWqMS4YUibH589Wr
	56c0u+/Y0ZoIjcudiSKSFtsP8uDc1xa2t3AQdurQPOVrD+I=
X-Received: by 2002:a05:6a00:9286:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7423c032792mr4295510b3a.19.1746789039201;
        Fri, 09 May 2025 04:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/wI7uCYsY/x83V3jRCPNFwkYhSRcQuLXYD15pEfm/Yd4Ai5M/oyqMM+jpQvTOcubEHQWBqQ==
X-Received: by 2002:a05:6a00:9286:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7423c032792mr4295439b3a.19.1746789038611;
        Fri, 09 May 2025 04:10:38 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237734c4asm1556223b3a.57.2025.05.09.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:10:38 -0700 (PDT)
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
Subject: [PATCH V6 2/5] dt-bindings: iio: adc: Split out QCOM VADC channel properties
Date: Fri,  9 May 2025 16:39:56 +0530
Message-Id: <20250509110959.3384306-3-jishnu.prakash@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=TpjmhCXh c=1 sm=1 tr=0 ts=681de2b0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=oDDNj9Hd53LkpBrnXyAA:9 a=OpyuDcXvxspvyRM73sMx:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dNP1Qb5wViPdwKQRrzx79g-UBaOJ-cx_
X-Proofpoint-GUID: dNP1Qb5wViPdwKQRrzx79g-UBaOJ-cx_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNyBTYWx0ZWRfX2/M0ckYW3i2i
 edbboQDbFz3tVDxmflMKGFC4OhNPjQk5JxDNVs3F6FB+1++/ZFahL55j805wQY/brRawp/7iP+c
 y2oLO8Ky5oo9mGmkwIzWklL0Io4NwrFc5WqUTn+IY6Tqp+rfEgDoaoeu4/raXMSdtgb34WGKk79
 KpFT1mJrMjdIlsKGvVncTiejfxzLHuxPICmS/P1v1AQYym0WWCsyLrW2sLlYa8pzAuH5VhoFw1i
 sE9OoRHCjFQpCuzIUR50wfohHDj45hD5QsisbvS+2Fxv9jSumg3bZI4wszxr8MofM3z36l04wGy
 iDltA2tcEU5d0Km+y0DAEEXcxc5T6ggQR9HvIA+0lkpxm72pYk0JkmZSgA0ijVLdUoY2cl49aEM
 sU4yKHl/6hbw3zh7UU2Ge5ux+O3+eBpas8GRGGnXJL2XhhVPEBOA0IUogqOOAtavDmGRGroq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090107

Split out the common channel properties for QCOM VADC devices into a
separate file so that it can be included as a reference for devices
using them. This will be needed for the upcoming ADC5 Gen3 binding
support patch, as ADC5 Gen3 also uses all of these common properties.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 .../iio/adc/qcom,spmi-vadc-common.yaml        | 87 +++++++++++++++++++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 75 +---------------
 2 files changed, 89 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
new file mode 100644
index 000000000000..cd087911ee88
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-vadc-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SPMI PMIC ADC channels
+
+maintainers:
+  - Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
+
+description:
+  This defines the common properties used to define Qualcomm VADC channels.
+
+properties:
+  reg:
+    description:
+      ADC channel number.
+      See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
+      For PMIC7 ADC, the channel numbers are specified separately per PMIC
+      in the PMIC-specific files in include/dt-bindings/iio/adc.
+    maxItems: 1
+
+  label:
+    description:
+      ADC input of the platform as seen in the schematics.
+      For thermistor inputs connected to generic AMUX or GPIO inputs
+      these can vary across platform for the same pins. Hence select
+      the platform schematics name for this channel.
+
+  qcom,decimation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This parameter is used to decrease ADC sampling rate.
+      Quicker measurements can be made by reducing decimation ratio.
+
+  qcom,pre-scaling:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Used for scaling the channel input signal before the signal is
+      fed to VADC. The configuration for this node is to know the
+      pre-determined ratio and use it for post scaling. It is a pair of
+      integers, denoting the numerator and denominator of the fraction by which
+      input signal is multiplied. For example, <1 3> indicates the signal is scaled
+      down to 1/3 of its value before ADC measurement.
+      If property is not found default value depending on chip will be used.
+    oneOf:
+      - items:
+          - const: 1
+          - enum: [ 1, 3, 4, 6, 20, 8, 10, 16 ]
+      - items:
+          - const: 10
+          - const: 81
+
+  qcom,ratiometric:
+    type: boolean
+    description: |
+      Channel calibration type.
+      - For compatible property "qcom,spmi-vadc", if this property is
+        specified VADC will use the VDD reference (1.8V) and GND for
+        channel calibration. If property is not found, channel will be
+        calibrated with 0.625V and 1.25V reference channels, also
+        known as absolute calibration.
+      - For other compatible properties, if this property is specified
+        VADC will use the VDD reference (1.875V) and GND for channel
+        calibration. If property is not found, channel will be calibrated
+        with 0V and 1.25V reference channels, also known as absolute calibration.
+
+  qcom,hw-settle-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Time between AMUX getting configured and the ADC starting
+      conversion. The 'hw_settle_time' is an index used from valid values
+      and programmed in hardware to achieve the hardware settling delay.
+
+  qcom,avg-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Number of samples to be used for measurement.
+      Averaging provides the option to obtain a single measurement
+      from the ADC that is an average of multiple samples. The value
+      selected is 2^(value).
+
+required:
+  - reg
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index a4f72c0c1ec6..b0ccad00c1a6 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -56,7 +56,7 @@ required:
 patternProperties:
   "^channel@[0-9a-f]+$":
     type: object
-    additionalProperties: false
+    unevaluatedProperties: false
     description: |
       Represents the external channels which are connected to the ADC.
       For compatible property "qcom,spmi-vadc" following channels, also known as
@@ -64,79 +64,8 @@ patternProperties:
       configuration nodes should be defined:
       VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
       VADC_GND_REF and VADC_VDD_VADC.
+    $ref: /schemas/iio/adc/qcom,spmi-vadc-common.yaml
 
-    properties:
-      reg:
-        maxItems: 1
-        description: |
-          ADC channel number.
-          See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
-          For PMIC7 ADC, the channel numbers are specified separately per PMIC
-          in the PMIC-specific files in include/dt-bindings/iio/adc.
-
-      label:
-        description: |
-            ADC input of the platform as seen in the schematics.
-            For thermistor inputs connected to generic AMUX or GPIO inputs
-            these can vary across platform for the same pins. Hence select
-            the platform schematics name for this channel.
-
-      qcom,decimation:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: |
-            This parameter is used to decrease ADC sampling rate.
-            Quicker measurements can be made by reducing decimation ratio.
-
-      qcom,pre-scaling:
-        description: |
-            Used for scaling the channel input signal before the signal is
-            fed to VADC. The configuration for this node is to know the
-            pre-determined ratio and use it for post scaling. It is a pair of
-            integers, denoting the numerator and denominator of the fraction by which
-            input signal is multiplied. For example, <1 3> indicates the signal is scaled
-            down to 1/3 of its value before ADC measurement.
-            If property is not found default value depending on chip will be used.
-        $ref: /schemas/types.yaml#/definitions/uint32-array
-        oneOf:
-          - items:
-              - const: 1
-              - enum: [ 1, 3, 4, 6, 20, 8, 10, 16 ]
-          - items:
-              - const: 10
-              - const: 81
-
-      qcom,ratiometric:
-        description: |
-            Channel calibration type.
-            - For compatible property "qcom,spmi-vadc", if this property is
-              specified VADC will use the VDD reference (1.8V) and GND for
-              channel calibration. If property is not found, channel will be
-              calibrated with 0.625V and 1.25V reference channels, also
-              known as absolute calibration.
-            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
-              "qcom,spmi-adc-rev2", if this property is specified VADC will use
-              the VDD reference (1.875V) and GND for channel calibration. If
-              property is not found, channel will be calibrated with 0V and 1.25V
-              reference channels, also known as absolute calibration.
-        type: boolean
-
-      qcom,hw-settle-time:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: |
-            Time between AMUX getting configured and the ADC starting
-            conversion. The 'hw_settle_time' is an index used from valid values
-            and programmed in hardware to achieve the hardware settling delay.
-
-      qcom,avg-samples:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: |
-            Number of samples to be used for measurement.
-            Averaging provides the option to obtain a single measurement
-            from the ADC that is an average of multiple samples. The value
-            selected is 2^(value).
-
-    required:
-      - reg
 
 allOf:
   - if:
-- 
2.25.1


