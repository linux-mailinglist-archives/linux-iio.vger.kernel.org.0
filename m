Return-Path: <linux-iio+bounces-24832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FC9BC27BA
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 21:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A27AC4E6847
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 19:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3EE1DFD9A;
	Tue,  7 Oct 2025 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B34SGDLA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012035959;
	Tue,  7 Oct 2025 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864588; cv=none; b=ECtB+Ff9uCESRDLjcOeypWxNnl4HX4qcGAwqxNisCez+0Y0ilVfi5Q1IDL8WPy/qE7s6UHEs/lpp3Xb3fw1G5ZYVb2S7BR0Ap1iTARCE7FI89Ny1HeoLwPigT/vPs8MrDpJvGywkEGSZx0/RlESZigAosL/NrhTN8Fk7p9GUriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864588; c=relaxed/simple;
	bh=rWuv4J233SVf8IPzlie6eAfYs5hmfamNLtZ8uMQp60A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GX6XnQ2j3+NRVzOVzCRer/z15WRfkEz7rkrmkZxIqgQ+ax74UCnieOjb8a5i36s3iZxZoZSvwyQroogjK/3fbNYWygK00BBxwFNjlgn6nbI54fXBNbUSyXEGUlCvTLzJFvWI0kYgWQZqocxZGOVZGtTZ3qcwe8s8CzkCEoPsLDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B34SGDLA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597J9eaR008401;
	Tue, 7 Oct 2025 19:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GYfG1kgg9/yntJdgCTTMR+5QkuELjws7U3So4Irew
	Fc=; b=B34SGDLArXziyNyNXD0o4R3pENHl94haUo30igjnPv8FBoGKbS4iNlbo5
	YBBZJuLVDQZWUo66Bn81bLLPe7+CToeUM28/2u8q2z4l3jdBLD31tkaAiKTaBCdd
	rQMXjxE/2RcGlgsgHOdkuaoCcBF1JTpCxKjhCoqo4k6wsEA6uPjo/5WP4bpK8ccE
	EkR8xQI9nueWQhhR3O8G0hABtX4R3mEGaNZdLDWRnUN/XK2uJ+18SU7ISyDJcZM8
	OSwqPZQ2xK0pRQGZUqr9tkKKcF6sjnbsiVNixxhnZAgpa37Qm/8/a2OviJyhRTSR
	kUG+408FkCtOZH/9itrwKpeLCWzxg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jua993pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 19:16:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 597I1A2B021221;
	Tue, 7 Oct 2025 19:16:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kgm1cpau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 19:16:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 597JGKuf34144646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 19:16:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E43958043;
	Tue,  7 Oct 2025 19:16:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 874445805F;
	Tue,  7 Oct 2025 19:16:19 +0000 (GMT)
Received: from slate16 (unknown [9.61.136.99])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Oct 2025 19:16:19 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
        jic23@kernel.org, eajames@linux.ibm.com
Subject: [PATCH v9] dt-bindings: iio: Add Infineon DPS310 sensor documentation
Date: Tue,  7 Oct 2025 14:16:12 -0500
Message-ID: <20251007191612.80164-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7aw2Q09BQDCoqyxr08tjlazizFjVWU3-
X-Proofpoint-ORIG-GUID: 7aw2Q09BQDCoqyxr08tjlazizFjVWU3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfXwQ/CJcZ5vy8r
 fX54ioGgTmtUWvLTBqCxtp67Q6whtoi5SKkAUtOLQi7lIoE1dAKAARl17mmW2ko0MNluxKyoqAe
 f1AMQ4e/nEj8qCTGq+tIwtHCMJrS+fv0sY2D2HGAx+F++8dTh8JxwCLVF5fRgjP2tQ7H7loqVLH
 qcJqn2dlkyZub8QcRb0W8p6YeShnn8NNdRvbGBW9mtEfMj/KcMKLc+MFXiawRpp8iO3AHMgs4dp
 xdDFV9OvozqVNwOoJre8CfESOSCVz6NLegY3Cy2O3n85ab1phZ5Jy7e3DL+Xoac7dOM1rylsvmQ
 PYq76bJly7vGpUKivdKJUv44lw0Tcvg5yiaebwOZ4I4hK6QPPhNcOup9bm2REOpfkP5MdiO47P3
 zPulauTXrc+pfUhDWjQp18C7qprWUA==
X-Authority-Analysis: v=2.4 cv=QdBrf8bv c=1 sm=1 tr=0 ts=68e56706 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=lG3Z5ILtqDq3c0xvBIoA:9 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

The DPS310 is a barometric pressure and temperature sensor with
an I2C interface. Remove it from trivial-devices.yaml and add its
own documentation to allow for consumers of this device such as
the iio/hwmon bridge.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../iio/pressure/infineon,dps310.yaml         | 54 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 MAINTAINERS                                   |  1 +
 3 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
new file mode 100644
index 0000000000000..e5d1e6c489393
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/infineon,dps310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon DPS310 barometric pressure and temperature sensor
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  The DPS310 is a barometric pressure and temperature sensor with an I2C
+  interface.
+
+properties:
+  compatible:
+    enum:
+      - infineon,dps310
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 0
+
+  vdd-supply:
+    description:
+      Voltage supply for the chip's analog blocks.
+
+  vddio-supply:
+    description:
+      Digital voltage supply for the chip's digital blocks and I/O interface.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dps: pressure-sensor@76 {
+          compatible = "infineon,dps310";
+          reg = <0x76>;
+          #io-channel-cells = <0>;
+          vdd-supply = <&vref1>;
+          vddio-supply = <&vref2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 58ff948d93c96..a76c58f3b1de4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -127,8 +127,6 @@ properties:
           - ibm,cffps2
             # IBM On-Chip Controller hwmon device
           - ibm,p8-occ-hwmon
-            # Infineon barometric pressure and temperature sensor
-          - infineon,dps310
             # Infineon IR36021 digital POL buck controller
           - infineon,ir36021
             # Infineon IRPS5401 Voltage Regulator (PMIC)
diff --git a/MAINTAINERS b/MAINTAINERS
index 3773c74b31d6d..bde80ddb99e9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12217,6 +12217,7 @@ INFINEON DPS310 Driver
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 F:	drivers/iio/pressure/dps310.c
 
 INFINEON PEB2466 ASoC CODEC
-- 
2.51.0


