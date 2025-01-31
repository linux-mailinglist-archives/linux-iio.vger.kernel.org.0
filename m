Return-Path: <linux-iio+bounces-14768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8089A242B4
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D721163773
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF651F238D;
	Fri, 31 Jan 2025 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VXqxeIYe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9741F2360
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348399; cv=none; b=NLgawGJPZF8DdSPuI2XypCg0gUSx1nRoPWs01jmAbW3UenDQPSvPuK6vn8qGaEM1RFcupTQceCv3atynSGRuwu/c4PycTDrDrf4MCrzXhmwfykC2mRLYLIxA8wXXkvfuHKDZMFrgXZS9NE2qIX+07ZZMZ/ZuhTFLSaAZwIs528U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348399; c=relaxed/simple;
	bh=d6rDMlg/UdmRiL4G1op8Gm48SC7k0jLl06CZ+wQEy1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxY9nynUZAVF0uoaDrAnUq9fKoCW9Xumaeug/84D09RUROwVHGXu+U/tYX9bGozSlQ0HEq7a2qazrWLxdpapT2pBt/zc5OmAVElPt7PcBF7/YVxn5pL9fBNhUPloYWnxzGGWJv5EUmxkUgKebZdIN2v/qExqjXc0EEiUfwcb76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VXqxeIYe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VC521V008273
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 18:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hb3HRWxx3g5
	/wkEWNItbeAvwROJGjyPNeskEhRoEpEg=; b=VXqxeIYepDfJhdOxT+mQfJQJYLi
	fGrXNHHQS6zS/cj+qGzbLD83Jm8QCWtT23Ju6/BtU9rSWvdExthNYfPrin1iN4jk
	WCrhcxwvMTmJjaIpoS7felp8X8VSQOvZTftaEJ0ZHND8YHgF//lBq4kdwhU5cEXd
	Kkd3vsdIC13S4N/noXlBvKxqKfjN/ha+c2JFb1l7UZcNACPiljqAH+SUtpmBE6UQ
	oqC+asEbGgGJR/C+luTB8OPEJDX0p2zKDSYV9q6nPmhqQfkpYPA4gf/UiQgLv+OD
	WKKG7cvR8kneiIykvZKGoK4kAiAJdlniXy4ekBItlkc8CnWGvupG7kQx9qw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gx76rvwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 18:33:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso6423879a91.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 10:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738348396; x=1738953196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb3HRWxx3g5/wkEWNItbeAvwROJGjyPNeskEhRoEpEg=;
        b=HGIXfIaNW8yRoaXiyrlcRH+gvzkO5kzGSCpUtLgZ/LsKLTCb8ImwNGr8eyLpkU2vQE
         IoLB5fh+0IWdsvwS/0VP5w3r6EQyqNCIVSku4NTddUA4h5HHYfH4tXQrwEc0kZTKyYnb
         ReX1hOEW8yhLmyNaFJWqokSBP+M+tV+x0tLZsmOvMcefGijR0lm0epN7eIw5NslO8U4q
         IrHnqZmTeFcZrU01zr5Wc0nS1OxqOUCqNF2QYbocjlGJQtinsCosMDxKRmP2bXXHux6t
         mbIVxPwAOjJi1S1HcRW09OM9NTMoLd14GPbJlLIF+ZXqxf1QnoRtxjy6QeaW5QRSQS8R
         0clg==
X-Forwarded-Encrypted: i=1; AJvYcCWum7Z8YiELjcvCd3Oyf+2pHaBkSMkG+V0Ez+/9+v2aAewy6DTcgq6AvATJI+o7L6Ck/xFSornnoEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyntWO1P9N+KfOpPkslKgjuZ4b+cnZLYuk79TVvXrCnTMtxhISW
	o4RY4FJLTwX/BPLplyFT/5hjdOzNbWVslQIo9oWZzmYqVotzsh/SAhll1oj5o/IOq7xD5EWYIbp
	O4cUgvzokGm3tXkjDKNkEh516yNH09AvXpIaC0uno1+IVRT4urqvYVNPJqL8=
X-Gm-Gg: ASbGncuH8nLzhAwM7SFarXDQ5PDDlha0APa3g9iyJnYTgnLZhjtQbUUu52DlVKiPtTe
	Br+vy+o7hf+0hfQS62TwHbD/JzsT2PzmQGyIng11QftaE3vbFQn2fjJyHuKga1yJNYqoh5NKCUe
	6oXnZq/rRieQrBM4J5G2lf+9IT0Ub8uHkz1Umn86XIoALCGpl9mwGSNvvjYemr/Dh6XIg7rDiai
	VdFbPHRwj4cYJwqJ4wCyzHUT5670r3+YfHobhEf7ADApK+OCZIh2uBbdjhK9N5FNTpXfe+wgi0D
	+BWaInx4NYznLq77d34gfxtAwwA1NocN92wZ33O+
X-Received: by 2002:a05:6a00:1386:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-72fe2d1f669mr15241617b3a.4.1738348396358;
        Fri, 31 Jan 2025 10:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKJWW4jgiCKHWmEPkgpgl32oqE6ZcWUGsd+Ay7kbBQSXaWoDsxt9OwRVM6yjHyDQDdhWmkUw==
X-Received: by 2002:a05:6a00:1386:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-72fe2d1f669mr15241557b3a.4.1738348395816;
        Fri, 31 Jan 2025 10:33:15 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ce9f4sm3714919b3a.146.2025.01.31.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 10:33:15 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        jishnu.prakash@oss.qualcomm.com, quic_skakitap@quicinc.com,
        neil.armstrong@linaro.org
Subject: [PATCH V5 2/5] dt-bindings: iio: adc: Split out QCOM VADC channel properties
Date: Sat,  1 Feb 2025 00:02:39 +0530
Message-Id: <20250131183242.3653595-3-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: a9QcF8nx9QkodiNJ9ICtRtjDAHjY98gC
X-Proofpoint-ORIG-GUID: a9QcF8nx9QkodiNJ9ICtRtjDAHjY98gC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2501310140

Split out the common channel properties for QCOM VADC devices into a
separate file so that it can be included as a reference for devices
using them. This will be needed for the upcoming ADC5 Gen3 binding
support patch, as ADC5 Gen3 also uses all of these common properties.

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


