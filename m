Return-Path: <linux-iio+bounces-19563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40482AB9152
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 23:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A6E1C00680
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7B29B8C0;
	Thu, 15 May 2025 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MdstIznZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174729B797;
	Thu, 15 May 2025 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343612; cv=none; b=d1yqtmzzD4GhABmmfJPsrDSyPnCp2SRttPsX4FZO5rr7alixkrYumIE4DPs5slbFcEcPP6kl406vWQJNrDclgvNlTFwRhZBU2BhbN9NlI7cliPOj57Rpz3DHSEanpcNOO9mhsrphL5ZnyUSBjS2qzy/JsZooifp7nuiA+0ITf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343612; c=relaxed/simple;
	bh=RjVHGhNEiRT9m3+BixP6azpGeN9ShzDl5np5/0pgM4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjGju0N34tl2To5/PPiqnBuKuUdyMKruqIR75MS2RfJDAkaMe++fFGMHk3/uZ/tK6MG0kKw2mLK6RnD6IyGIcHZyk3sOfcaUEmybUJYLqbqR+s+AQ3wZ7+rDwPvUFSzjcGM3cYpNTjcO2HLcQ2Qsz/vekDB/qitbZC99aI/Q/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MdstIznZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FH5EQY009232;
	Thu, 15 May 2025 17:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4OJeH
	dYEpr0079ZyprVPvVBuxKIviAg9kbcSLzLLsFo=; b=MdstIznZhuOxWkLmeg1op
	sbdyq1ewgTcMx9v6bl5IX1+H6fDz8fhScEnWDq0y+dT/hHa78Phcd5AS6oIJzvzv
	zf4v11KD3OleqC2b4FE/kO81OshQRhfUgBobm3ASFlpRk/U9LCtTJLG/jNNjnDhA
	jCO4qB6MoCYgXr4j9ojgTjN2j93vMgh/l+ghBMpPmbp3InUhasYm5jnefusV5uwk
	F8qpvMKkF994lDgMTxWOx/F8c9BrAqilxSZ6FLji9UmAcJj8LDLHn0NvvSKzqTiU
	lYeFRfFZMPYVFe1L/rXAkTpZhuOaI6xwCi14XY///JFJDIqK41ojsfNaZ1C+GpEe
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ngknj9v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:13:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54FLDN0U025044
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 May 2025 17:13:23 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 15 May 2025 17:13:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 15 May 2025 17:13:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 15 May 2025 17:13:22 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54FLD4rA018851;
	Thu, 15 May 2025 17:13:06 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v8 04/11] dt-bindings: iio: adc: ad7768-1: document regulator provider property
Date: Thu, 15 May 2025 18:13:03 -0300
Message-ID: <98c737309303d7a3e4188a85083ca1b520966ca6.1747175187.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747175187.git.Jonathan.Santos@analog.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDIwNyBTYWx0ZWRfX1YbTf7MoTEYl
 Ss/ClJdjksQt7D/30RBV+Sbg/KJlrE/ka77hA14lM0sIs+YVSOAcqSYPs5dXSuF4WLk3qAK1mjn
 aKVjc5z2oQf24QWuHTdnz9G1aLpAuL7dkRCxrvAsABbAFZMGQMopJTzHwyJdiLT55NQ4zwg2Wxj
 YstpYVeLcAeR9WkNCtJrvHaeaOeQ04x1OTZDqN565EdZIwLQQ4lNCLrZteHe0hAnstRZmAUqhYo
 wQdVT0EI7zWxTcGF2IW/u5LRr8MQX4+m8GSLW9UXy6HejHILb4+Mbcp0TZJnM+DueSNbA4Cjud7
 d3WsJX/5VcmoeSqA8crC1NjfluCyZW5YyU0hiMys2SLLpB8qVxw8r+agqZdRMJ+nnH0kzqRFKK3
 bw25pZe5w6JiJsmcLgow7UA1r6E7bHkayJKBTLIR3c0DdxNXktXkL0pd79UkLs0shvDgCK8q
X-Authority-Analysis: v=2.4 cv=B5u50PtM c=1 sm=1 tr=0 ts=682658f4 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=J1-tWBq05h-qFn0eaeUA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: KPG92pXfGDavWfm_ZSCS_KtyjHwxJaOP
X-Proofpoint-ORIG-GUID: KPG92pXfGDavWfm_ZSCS_KtyjHwxJaOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_09,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150207

The AD7768-1 provides a buffered common-mode voltage output
on the VCM pin that can be used to bias analog input signals.

Add regulators property to enable the use of the VCM output,
referenced here as vcm-output, by any other device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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


