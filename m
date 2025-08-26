Return-Path: <linux-iio+bounces-23287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD6B35740
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA821B63F58
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CF52FDC31;
	Tue, 26 Aug 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drGdDo5k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE42FE575
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197452; cv=none; b=FBbz5+czQ/AA6mRprrcVUPnl2DMGkDer8jD9OBYaqYcmToLBcEsu+4c4Pr6vxyGeB55O9X6m5UmBvvR66D3sSRam78V5fPyt4hdy5x33tb788KFkZr1lWa4uj6TjaH8Vv5+HYMW0jWCAcnQZlNXBcdcEz9ZTVBXd+ldLLBnS9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197452; c=relaxed/simple;
	bh=ZlAQ2PmUBo3Nu4YF8y0u/CGafLXF6Q6N67s6YfEtYXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZ1tva99HNak9ePzrB0NZuf6Z9+xV1s1P1jYXGvMAAy7DjGwxdzkWDA5t9eEAWt23jUwSpYHLulQYL5VM9phJJ2z3rBBXXnnNMmCbnnjmdKIn2WXjJe1czq9TgLFKWku4P3UgcVmIcA5/wd1C7bIY/SeF183XcEUmqtYRUnjGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drGdDo5k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PMp922030036
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 08:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2r8iE3mffOt
	EEE74EjEXqvQmMXI97bIxGHeh+QyYSN0=; b=drGdDo5k/weDwc4vIv71ffbyOSx
	HSP/ypdec72cQUHsAczAizltV0X90AJv8T1jSsKCQGhb73Jv4j4Pd66jjSKpLg54
	1ZKNt1zYBpZwj8IuvXuXjXsBBlMbXJ2QHix1R03fwR4F23aD/Iqv03+0+ziHCEty
	7mSNO1fgBU/eYTj4e+qMN+6z9tGDBAUxx3nIcS7Etsgi9SVn2MyPNm9hf7cmPL5H
	/k8/Wj7sZx3P4tb7HqIOmnSXwx1lR+Lt3tjUotABBNyI2vfaPh5yZ1+YnoSYbE2r
	OUokh1Zdp42a6cimldlAVq5wyOkST+rYFI3t98R+kFjckV4M15N9whjQkuA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5fx0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 08:37:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244570600a1so60514545ad.1
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 01:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756197448; x=1756802248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2r8iE3mffOtEEE74EjEXqvQmMXI97bIxGHeh+QyYSN0=;
        b=RxkxnqhWAFzSML4CZdHZ2wmqq+HxF3RKDmpswRbppjW/oP4TTQQ+A/QywqJlVIeeNB
         AUvfccDuQ5qtT5egvObtoNOr+0MMMeRw9POkhD/4UEN+YfR2FELEdxI5gTr/IdAZICWT
         1YtWngxdWDlSs8ObssUNB4n9xbEkLQEfT0+GMVIEvrvuiGw1T17kdWN7MKjKQO/3ZiVW
         h95fKHoxo5NO6akynQA4ev/j0+kIcqEAI59ui2wU0u4k+wRX/acSsDJpInQZhTxaYv0s
         DH2kq6WstJDxm8loyGEOVSAvYsW3i6g6yoi6rqPoYsWdgtc4E4HrzCPXHomct8GDljf+
         YJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVGUtwMtl4iEGnI81LNgFmdutSqwqynK+doOBIRBqf9F2u5S+B9ii5pnOA8CyNJ8NKMZ541B4brlJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ZOx+Ss4OqPbPbOGnSa16vqdrzI7iy9zuskXoduGjdLJRz+3n
	bAduk1W27xx7w4bP2KFH0lwy5IulF2Z68ZdYQFw/C8cnrQ9jSQuXrqmXhHzNjixVmI8sTAoa06O
	hTjV4oUSnCjfMUYpv5ajSVkGgIG0gZWplC5aLMZkOQMoyHEl7UCAqout3RZxpEh0=
X-Gm-Gg: ASbGncs6A/U0RjWisA06Q4kwnHW4OMuCRaUZuwud7gkNclCtqfdg7oNWbO3+/8PGwA+
	khJcDxc+aKCF4apZUFhcDsrBBQm1bilFcJk/3w29dsB+28T/eu553Gzgk+C+SreUduZIKLdAj2A
	j6PfaigITeSj5LtDrHs5GLZog+xId7vIZEEhQY54RJ99+ADjUG1dnm+0HRpt6fSEWsJo55XfesL
	Tfs2kwmGpBJXhzR3k8TqyzA3m4IONWvz2yd/nvY8onTN++RjnYDSrqllDDDcI5Ue4O+6wHKhCG7
	UyAPBE1H34i7F5qRO+QXoXPOQUfvY6NNiMqeLez2tytUe8FUANpfJJr8f2WuAjTGAP88Nxzznbc
	=
X-Received: by 2002:a17:902:c947:b0:246:50c0:ae8b with SMTP id d9443c01a7336-248753a2457mr8293655ad.0.1756197447637;
        Tue, 26 Aug 2025 01:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcsvanQQhVTqAj+3WpxmpEJxea1foazHjAxs5RPzZAL5wRL/q9M+jNuyC6x5ISWJOuSgidVg==
X-Received: by 2002:a17:902:c947:b0:246:50c0:ae8b with SMTP id d9443c01a7336-248753a2457mr8293215ad.0.1756197447048;
        Tue, 26 Aug 2025 01:37:27 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246ed91ee20sm36924785ad.136.2025.08.26.01.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:37:26 -0700 (PDT)
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
        stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH V7 2/5] dt-bindings: iio: adc: Split out QCOM VADC channel properties
Date: Tue, 26 Aug 2025 14:06:54 +0530
Message-Id: <20250826083657.4005727-3-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXwsjV8yTnyKl+
 ey+eEn1qqL6YQ5HC9SsylhTeRrEERStDvgsxVaBSXMR6uAYhKUjDodgoRwDK8LPTq/x5D9kF9Jb
 0YTqH5jpqMFOhSwSGagFQ3XTNgIm4gjZoLhcdrnhyHfgDB+j2UH1CuNzw4ioEg4OQC5cNy8wa/4
 JRW/g7t6ds6OIfPJDeFsgPvS5HkXAcjwOmYezdJgzeRIXB3OesOHjA8klUAqZKQDvvWUlUeF7Nl
 Fk7ivHEGZUuh6UZEtFefQyTIDvR3n/6tSPE8cp550bgszPqyz2JbmQPB7TvjzXQGz5Zi/xsxXh4
 z+69oMy5NJT4EKWj9Pf/Y0yNJbZSNclB73ilGlT/hTgby7hQM34R0EMUMfLE0/dX0eA1bb1fb+s
 eFwmTCGb
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68ad7249 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=i0EeH86SAAAA:8
 a=EUspDBNiAAAA:8 a=oDDNj9Hd53LkpBrnXyAA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tXhvjNM_x8OWMVC3y3qlNIjjHVtmukCy
X-Proofpoint-ORIG-GUID: tXhvjNM_x8OWMVC3y3qlNIjjHVtmukCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Split out the common channel properties for QCOM VADC devices into a
separate file so that it can be included as a reference for devices
using them. This will be needed for the upcoming ADC5 Gen3 binding
support patch, as ADC5 Gen3 also uses all of these common properties.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index bc3f8ccde536..cf6f6ed2a378 100644
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


