Return-Path: <linux-iio+bounces-24633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5940BB0C8D
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 16:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086224A21D9
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0EC2FDC59;
	Wed,  1 Oct 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c1XjaAQs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A92BEFF9;
	Wed,  1 Oct 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329925; cv=none; b=UgBBTEDt+jqr80uGzYmYyuQR1BQbqztOgbV2iCEUTeRdK25NffcLIUpKHnzHHVul2uktCPBp0iI/84LaYIsHzXNPfT81H100m+oCwv1VEy890hkYKbOK6QXHP+os81LHCRpagwegpHc8CZMBvAaja2Kj2vNCp7L3Utr92OAO4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329925; c=relaxed/simple;
	bh=f15FdHbP980uqvurM/kSyJm/LN+b9ORSwFGwJ5J73bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfCKavP9uNJwwXxq+2dlAh57c3ZPhWcU6Om7GkQUvh79yRbrpqwejO8FBzsIDyrQRfsSd503Rq0jXss2t8EsZCA2dYo1PS3+QwtiSip6U7xo+CeEVaQyr+MZie5hKyM+1NXTVr+KSJI8QDDTZEz1oh0On+xks6Qjlo6Z69IJDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c1XjaAQs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918og7M006384;
	Wed, 1 Oct 2025 14:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cKED4uPJ+TKBOyEa5
	CsEPNGDx3w/XuHzMmE8+Sv4n+8=; b=c1XjaAQsvd45apDkDinZky+QmdPBBGP6N
	yDxVSU+yxFNaq89mQYSZTafeLQ4ugABxXxI6Y0+qq05eYHamyUXoBvWw6W8jmXjV
	+Skhe/MFvrDqVZVvM5m0EzpuQmZdPZyCACMBqi0NktOqiYv1anMvkV5B6viW6g0l
	eQ9Z9NjQkdq3udARC4VxLWxfxEegLCwnVcIVIGvY/h+aCxmyj7QzqFAPId5D9wCI
	rviB8rknXr3f67vHuWWBBnEtvVt4YsLwi9An2qIwedTq8Jp6d0wsSG6S4LxA9wJ9
	uelkju8OC4sWS0chEqzCMz0UPuzh+rVFRWRk+M5TmJXhfUVMAWUwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e7g5h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591C0XUp003926;
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmy1dh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 14:44:49 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591Ein9T27918994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 14:44:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C1E258043;
	Wed,  1 Oct 2025 14:44:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B06125805E;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
Received: from slate16 (unknown [9.61.71.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 14:44:48 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        linux@roeck-us.net, chanh@os.amperecomputing.com, jic23@kernel.org,
        dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v7 RESEND 3/7] dt-bindings: iio: Add Infineon DPS310 sensor documentation
Date: Wed,  1 Oct 2025 09:44:37 -0500
Message-ID: <20251001144441.310950-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001144441.310950-1-eajames@linux.ibm.com>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MnXhhf8F0LHLxM82cNCsf94UcxR5g3Ea
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfXzeXJhmB0zPJe
 PryFPv6akgxDtQ56v9XHVzfpX/WNR5mBdoeWJSWhB40JU/G9+5OjgIv1pMa4cL4RwYbUWawyp2H
 1aXcBn6bvGMKI66BKs/CAC8Misj1XzL0+3of1OmsbEgeVh6vpAyETnzq4pfu3CZ3MvJUcBPXRzO
 RNJg+ZndbL00ZlYrGWgg4jTwsNsgBM5A8bzxrfOgR0HMq33NiOd0+6HConRiSHiLfKWl5DWW/Vt
 mBhvdCKDdnD1gNSYxfQcrmjilO5YPywiFgNCy2Cr4zduoKw8kRQ0/pspWnOR1B//punsCYbsrE6
 qaQs4PbRSdTlTWOcKZY7ZHU9SGaR6/mc8uleJnvVuv/89+Tj1vEaMDXQZpKaWSNv8G8P+NH0agZ
 7+55A73jG6Vicz+9XumbVn7aJJdhiA==
X-Proofpoint-GUID: MnXhhf8F0LHLxM82cNCsf94UcxR5g3Ea
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68dd3e63 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=nPmG1HaLeDTRtUTItIQA:9 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020

The DPS310 is a barometric pressure and temperature sensor with
an I2C interface. Remove it from trivial-devices.yaml and add its
own documentation.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../iio/pressure/infineon,dps310.yaml         | 44 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 MAINTAINERS                                   |  1 +
 3 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
new file mode 100644
index 0000000000000..7c0782e2a821b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -0,0 +1,44 @@
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure-sensor@76 {
+          compatible = "infineon,dps310";
+          reg = <0x76>;
+          #io-channel-cells = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7609acaa752d5..a72b7fabc7034 100644
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
index 0c8281ea4cc64..92b9854a0e07d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12191,6 +12191,7 @@ INFINEON DPS310 Driver
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
 F:	drivers/iio/pressure/dps310.c
 
 INFINEON PEB2466 ASoC CODEC
-- 
2.51.0


