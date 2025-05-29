Return-Path: <linux-iio+bounces-20023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4608EAC848B
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 00:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E371BA4CE3
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54363224227;
	Thu, 29 May 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="n5I5lR0G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A81220F27;
	Thu, 29 May 2025 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748558996; cv=none; b=fZvpGU60an3AoEhi4ZHBUADPbOmaYcaoPby10Tvluz01FrH+SwTRUQmUbAeq5Z2CKrpTSdHM4p5mFX9ygml+693S7KaqTXmWgCSyNdDpZkw5FKBi2PKDsGql7Olz6vj1Eu16tqFdC4zLw2CbvqoeOAtYcQCpXJZ2zLBovnGW78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748558996; c=relaxed/simple;
	bh=BmFBDpcPkXdLAeGROtmE8VBnB0zHPqa895+fAgITnIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imyKyrU3BTJV1TLGp8++JbubjPoA9MDQRqXSUp8Wo1ayJu/LGOSfE5Pljrf3v2tpk4+dCvoZN24MKZKutRzDy2NHERjtrq7vjUzNPCSHb9vVHibdtSuxRtM7DDgIs6UrorKadV0Setys62m+36YpxeWQRyiqzz5fOFVZ+zLGXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=n5I5lR0G; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TJJLVY030306;
	Thu, 29 May 2025 18:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tbCzy
	5Msgj6QBvJn+ySoOQ+TDEXp11KEyQdefkZFTk0=; b=n5I5lR0G8/qUD8IKV7wSS
	DBHWVFlDWJMOlR9wsRGc4ebZAabqHPufD9BQI7OPhNtL97KnGxPcNbl+HNCA4F3D
	vIInHA8GX/MkExe6Y1B0qvcNegSTXpQ8lOTaLaZGu2Ifak2abm20w6A60dVII0IX
	+nKfrBOspdsKIppJWlnnklnptOe/azuPIe8c0atYgr43R+eeGYJm4an7F+1SjOA+
	d+UVPwJV/zMIT0tSc7CAhN4OEL/W2ddfKWTfXNHybwA2upI9orRYaLnT+Zv6z+8j
	62F34PkuCh6cN44eZ76dNGOcqzMSq+iH0vc/Y3R5H5GToR5dNf58UwlLrlNmmLzW
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46xth6hs0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:49:47 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54TMnkZx008614
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 May 2025 18:49:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 29 May
 2025 18:49:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 May 2025 18:49:46 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54TMnPuK017149;
	Thu, 29 May 2025 18:49:27 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        <andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
        <djrscally@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 05/12] dt-bindings: iio: adc: ad7768-1: document regulator provider property
Date: Thu, 29 May 2025 19:49:25 -0300
Message-ID: <0b6045763b847f07448028fa028a71789cb2b291.1748447035.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1748447035.git.Jonathan.Santos@analog.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=CccI5Krl c=1 sm=1 tr=0 ts=6838e48b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=J1-tWBq05h-qFn0eaeUA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: t3bl4_mwq2aJOrjuEyx02i1ssKQ7EnJM
X-Proofpoint-GUID: t3bl4_mwq2aJOrjuEyx02i1ssKQ7EnJM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIyMiBTYWx0ZWRfX/GUTeCPwLfzZ
 y/AO0MFGCvtLZyaNKmVTyzCVgWDR//pOMGhoqc+sXZIljQ/sEKT7UoifhdaRGue6nW2ofmo8T+7
 UrvEo5ChzxUWh4WeqTIUeqPjt5V9hQFX99EyFZu65XvZn3RzTKkBCc6Af55n5E0UyS9KRrhpwRB
 uW0T9FMX2QSPxiydklY2+hovR1N91eriF+LOLaJOMblTuwEthnw9BqQCCqUJNNwh8+ZENJUVIMQ
 0CF2ZTmECyWPztJnZ9otfziH1C3uhtake6dcVDjt8RBuGyNxY/jlldmx8fNgCBIE4AOBsL5MI5m
 dsaZ0+iFL1GJizOpMAhdVWsKlIsFjWnnxKVTzqceDdR1TZWulHuPpVjXfuVUI5wSfklh9Resv5X
 ETe5pHYGbzJcKGpI6UR9H72k7MUHX7s2KX0wttpEG7kFRgzFCTpDBanW6/RJitDDoq68pnzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_10,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290222

The AD7768-1 provides a buffered common-mode voltage output
on the VCM pin that can be used to bias analog input signals.

Add regulators property to enable the use of the VCM output,
referenced here as vcm-output, by any other device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v9 Changes:
* none.

v8 Changes:
* none.

v7 Changes:
* none.

v6 Changes:
* None.

v5 Changes:
* removed `regulator-min-microvolt` and `regulator-max-microvolt`. 

v4 Changes:
* replace "vcm_output" property name for "vcm-output". 

v3 Changes:
* VCM is now provided as a regulator within the device, instead of a 
  custom property.

v2 Changes:
* New patch in v2.
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 18f93586fcdf..c06d0fc791d3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -66,6 +66,19 @@ properties:
       in any way, for example if the filter decimation rate changes.
       As the line is active low, it should be marked GPIO_ACTIVE_LOW.
 
+  regulators:
+    type: object
+    description:
+      list of regulators provided by this controller.
+
+    properties:
+      vcm-output:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
   reset-gpios:
     maxItems: 1
 
@@ -167,6 +180,12 @@ examples:
                 reg = <0>;
                 label = "channel_0";
             };
+
+            regulators {
+              vcm_reg: vcm-output {
+                regulator-name = "ad7768-1-vcm";
+              };
+            };
         };
     };
 ...
-- 
2.34.1


