Return-Path: <linux-iio+bounces-15462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE25A32E54
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DEC161254
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DE5260A2C;
	Wed, 12 Feb 2025 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pTFKGVis"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A0260A29;
	Wed, 12 Feb 2025 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384226; cv=none; b=IVwwI372/rzLh1FuD65PhiWyOE+PStKC6cPgbn1xmZmaneiRTpggGS1L4JUp+sVhjPm7f6Xchy2YupGds43gxS3ShTZ4tBVIy20fAM4zG9yhzk3bwpDZG3ukx0qZP03X2UPyH9SlQSnrYH7eIhTQis2lW2epR+PyePKQ6kBNZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384226; c=relaxed/simple;
	bh=T3Y0CqcpuCH1sUhoXlnPnkdMUZWO3lk5BT1V1r5nnk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIqS8BxM/KShM81KCT5N9aYio37kMwJ7aQgSYLX3KY6SjRAy+Ro7XTx0w+MEip16dhj8csAc45+8KwEucP0FOKygiypJfiWFsHGnJ4cfQwKuwUTuHifX3avl52GiQcTsuGFwd3FBQe2Br6ZEBO6Lb44Wt8UelruR374eG+6qKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pTFKGVis; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CH5JpM014127;
	Wed, 12 Feb 2025 13:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GFR1C
	ULRNZ0vSKSYHuNnKDbDlt7Tscij1M+x+ohJk64=; b=pTFKGVismhYJiIOg4DDmf
	vfpV3XmjC4YWkGuSGgTbv9Aizphp7mn4yPQ2LdtEw+frXD0s4XwsPHtmrjBLQQ3d
	Tc/DBGZfW26XlAmlV37/E9kRFoCIm6d8sqUdLUVom8pfUQasxNxRKIIhy26Jha1D
	1e1Y7/Qtzn3TYMAGzeA/vtWJIAyGaT+Vu4auxv3wR6iH/h13d8TaU1tRnQrkJWKg
	PKfyTsXnDXsAaRu86lc/nbR6R0hxNFbiHZUaVbAcFSuV49XBQ2pGlkc5w1IyUg/F
	IpWojLE6pOPzGzvEwxqt1LOK8CyIoWVpcL1qGakSA4b+0JZL1llwXblAqygkcblI
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p52a3n6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:16:50 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51CIGng9046439
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:16:49 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Feb
 2025 13:16:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:16:49 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIGZLE017460;
	Wed, 12 Feb 2025 13:16:38 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 05/17] dt-bindings: iio: adc: ad7768-1: document regulator provider property
Date: Wed, 12 Feb 2025 15:16:35 -0300
Message-ID: <78c7d5d139d6c158423804f0e6c81cbfe9717b1b.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vFqKpD9BzPiN9L5ZUQW7Li5QzryQRe4C
X-Authority-Analysis: v=2.4 cv=FabNxI+6 c=1 sm=1 tr=0 ts=67ace592 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=J1-tWBq05h-qFn0eaeUA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: vFqKpD9BzPiN9L5ZUQW7Li5QzryQRe4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

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


