Return-Path: <linux-iio+bounces-15378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A49A319BD
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDDC1622E5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF8A26A0FD;
	Tue, 11 Feb 2025 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="niUy9tz0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1426A0BA;
	Tue, 11 Feb 2025 23:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317666; cv=none; b=mZZaFegK8JqfXnCp8mpTmx/ItetnbSzH+1+MyGNg1zkvBLLynRL1D/NAZqAz2mdbrmkuTIFtq14tUX0y1ts3jv17YAfur+kMot+9XlbRg7E0J8/X1XI9kGM7GzrKj9ueMGRQa2jnjACNmcZMWF/1hldMzrqDSY/Kxnxtm9K35aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317666; c=relaxed/simple;
	bh=T3Y0CqcpuCH1sUhoXlnPnkdMUZWO3lk5BT1V1r5nnk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tU10ywgHOownyeLc+DF/8lzssOtjA30hB/r+1DSwh+YCH244Sk0TAC2DMf49/X+V+JMHmfCPVkwE5QAwVQhIPf63EBp/2z+cy8qQU00+6ljwyK8vV+GW3Si/uVRqQXapWQ/Z9NbGVKDxmjUWfKDzWvYljVESvhVwfuGjatf9Ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=niUy9tz0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BK0bDX014127;
	Tue, 11 Feb 2025 18:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=GFR1CULRNZ0vSKSYHuNnKDbDlt7
	Tscij1M+x+ohJk64=; b=niUy9tz0xLqBYO3PGqgXoRebbq8OVsddJFsOE9+xY8S
	X1pvP6TJcRrdwYlzx6QrBFDn9H5ifYz42D2bSNEiKHeDbHq2svLaqza2yJYaCiaK
	ZlAuMYUgLTxHI20DGT7Zwz7tLRxxivTSIViIEcMoIbG8ND7NUYGj+eT3DYjo6NY6
	DZeSKhZNvmPvEfqnnz4do8IwDdv3xEdnxuIZUGms4e3UG8e+s/7cpzVqbOZvxORz
	ei/hSfChKs9EgMorpd1JS15thmDuh3qmgF7Gsme38c/ri0j6yycJwzAjXci5oDPd
	P4BNOT69fAgqozdnd5KRhw2TfmaT/mYoz6/k7+r8rig==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p529y7sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:47:29 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BNlST8017029
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:47:28 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Feb
 2025 18:47:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:47:28 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNlHKO009883;
	Tue, 11 Feb 2025 18:47:19 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 05/17] dt-bindings: iio: adc: ad7768-1: document regulator provider property
Date: Tue, 11 Feb 2025 20:47:16 -0300
Message-ID: <20250211234717.1008325-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TBHJK0X-0owRqSRuma8MCtPWzPhZ3Ybp
X-Authority-Analysis: v=2.4 cv=FabNxI+6 c=1 sm=1 tr=0 ts=67abe191 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=J1-tWBq05h-qFn0eaeUA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: TBHJK0X-0owRqSRuma8MCtPWzPhZ3Ybp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

The AD7768-1 provides a buffered common-mode voltage output
on the VCM pin that can be used to bias analog input signals.

Add regulators property to enable the use of the VCM output,
referenced here as vcm_output, by any other device.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* VCM is now provided as a regulator within the device, instead of a 
  custom property.

v2 Changes:
* New patch in v2.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index e2f9782b5fc8..38f7bb0a0e20 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -59,6 +59,19 @@ properties:
       in any way, for example if the filter decimation rate changes.
       As the line is active low, it should be marked GPIO_ACTIVE_LOW.
 
+  regulators:
+    type: object
+    description:
+      list of regulators provided by this controller.
+
+    properties:
+      vcm_output:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
   reset-gpios:
     maxItems: 1
 
@@ -152,6 +165,14 @@ examples:
                 reg = <0>;
                 label = "channel_0";
             };
+
+            regulators {
+              vcm_reg: vcm_output {
+                regulator-name = "vcm_output";
+                regulator-min-microvolt = <900000>;
+                regulator-max-microvolt = <2500000>;
+              };
+            };
         };
     };
 ...
-- 
2.34.1


