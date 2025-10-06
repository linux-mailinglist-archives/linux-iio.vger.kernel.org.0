Return-Path: <linux-iio+bounces-24788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A345BBEE43
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9673A05EE
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 18:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39522765D2;
	Mon,  6 Oct 2025 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H47PG8JT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185E17DFE7;
	Mon,  6 Oct 2025 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774257; cv=none; b=gza9QD2yR4ce7EMkmKzuxkUJ0Mn1FqJo3VyCnVgI2P68gzgGVIJz8Izrg9m66VdRcS5iEfE/YbqCSh3aqqOAby79i0HODF7Iy5yHF5qhVEoZQu/p4jbnll8CEPRsJQgbG5goFugGN0/2c1yVej/WHsKPWh7qQH6Yre/Q8od8O1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774257; c=relaxed/simple;
	bh=bFlVusYledbzV6kZzMCqdHFUerESt+ciTv2aOWN2M9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rX9A1oQ+ewA5Ie7kJb9OzATh3hhHG3OKfl9HlhP1f+64CBoWwyrKm5JOaz0tpMEIFNH8w5q2OnJnkOMLbRiQr+f06qY5ecVCTMPSpQmSt0ZAJT71K0Efa6FrvvjM0O5hnAAucd7ctJyBaiH8EJ5t9u5+HCTRzdV0h7urXlblD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H47PG8JT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596DS4kT006249;
	Mon, 6 Oct 2025 18:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rbzSosSP831aQq0DTGiJxDg+xxTE0zSTAmTTY47AE
	kA=; b=H47PG8JTpegbfS/Tf0m7VwVRYD0kyqKVre46BXKFWWTaiXhmBux5K240+
	vgQ+BWX+lWVNGSwgS8Smv63c1k5iaNW0M4vz1mu8KayqHj8TnO83MKXyAqsLctxd
	4pb44tuWe4aEOMtX7xkzAplxx9ViIrRwILGtFoH43mLQbfcjABI7dhmfXTF7VXrq
	noaRXN+iDw7IFO/tcWpOFy+4VzFAlGY2q1Q3SZM/J/Bzs9C48ilzzA0sVYMum4d7
	5b46dzHKn7oM5myDi8fyWk5yCoowqAfKz/d596tkEmO7tnBqG8slXRTIizr0aPQ5
	KZCHDliDsQJvA+aIlEFHczWRzLUag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gu0va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 18:10:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596GXi9i028410;
	Mon, 6 Oct 2025 18:10:48 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kewmydu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 18:10:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 596IAlkZ25821800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Oct 2025 18:10:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD5558061;
	Mon,  6 Oct 2025 18:10:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD55F58059;
	Mon,  6 Oct 2025 18:10:46 +0000 (GMT)
Received: from slate16 (unknown [9.61.74.248])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Oct 2025 18:10:46 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
        jic23@kernel.org, eajames@linux.ibm.com
Subject: [PATCH v8] dt-bindings: iio: Add Infineon DPS310 sensor documentation
Date: Mon,  6 Oct 2025 13:10:40 -0500
Message-ID: <20251006181040.25845-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX7HJyPlMaCDMV
 vjP7FT8O2l82BIqU3Mtpl62P8y1J1oYHncM1xYEavU/KUxsRelUd3Ynu4dhae1+QsAbUtDPP4xe
 iszzKy1/Std3c4LUU8/xNZgONUqOb/R6FywlXjDol4A/gVAMBct9QWEMNrRMNwO3SOg67q+N0go
 L9sDCDV0F3caI8QPN7SD5E8bQLXJVtT1gXt3iYiZrxrCdQ/ZjHkpgJk7gU9+1VHH55sm7Y9egq+
 20QEdn+1gB1IDaK7byso8GXhoHRAfbDIWsgdxkBC/1nV7oSW3DciXUPNisNLHK/PueQ+k1Loxey
 m5VymkZq5b0qFUizxr3HHmub47QQDPCBcjGktSQr4iCSbfytWmvuXo15v7LwGSWdEEhIrYUkX3q
 KKLkbqLNutyLSc5PNdQ9sPD7eYC+Pw==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e40629 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=lG3Z5ILtqDq3c0xvBIoA:9 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6I9M5AfC7YbFFug4Vi_X7qBdwjj81TkN
X-Proofpoint-ORIG-GUID: 6I9M5AfC7YbFFug4Vi_X7qBdwjj81TkN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018

The DPS310 is a barometric pressure and temperature sensor with
an I2C interface. Remove it from trivial-devices.yaml and add its
own documentation, with a hwmon iio channel consumer example.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes since v7:
 - Add consumer example and update commit message slightly

 .../iio/pressure/infineon,dps310.yaml         | 48 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 MAINTAINERS                                   |  1 +
 3 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
new file mode 100644
index 0000000000000..f35ef2ce74d6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -0,0 +1,48 @@
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
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    iio-hwmon {
+      compatible = "iio-hwmon";
+      io-channels = <&dps 0>;
+    };
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dps: pressure-sensor@76 {
+          compatible = "infineon,dps310";
+          reg = <0x76>;
+          #io-channel-cells = <0>;
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


