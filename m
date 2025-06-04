Return-Path: <linux-iio+bounces-20219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1D6ACE4EF
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FCB173E27
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA639213235;
	Wed,  4 Jun 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yEn+nd1F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436420D4F2;
	Wed,  4 Jun 2025 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065804; cv=none; b=RJHEsYxK9XnCPAXF32VGVbhwTchFXy6QfQHYrti+A9seX7nxQZYGw7n12CCpTjeqFYfE/fWdVvMhUW4Btw3h9sj3dRTNHpx4J832yAqUfgZ9ZAtHEpaCCwIWgMUy+J/nUkCKVhulnVwx4guJafR1zGxrZR8aRJzhniLhl/VGl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065804; c=relaxed/simple;
	bh=carsVHT7Iu109hSZt4IFG7axVkW0yVXqeQoJDpjAp0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GN1YsB7NK814bDkXs5WJZqfKEzl9dKc8WMdVW2FLmGcZzbnrs4urvTbWsR5eXR8ojWZBqHEeT9F//PPkVeLvzQyOXH4uk5nBWXqzDzRhrN6yWfSm6TLUZ2QdZwEuPxHQ999Z9Fw3itUqPJH+iTGH9tK+hQuooOa+cvUB0OvWWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yEn+nd1F; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554FpAUx029642;
	Wed, 4 Jun 2025 15:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NjMXN
	kQh1BDk8Rk/1+Zsx/9pLn0hTsdz/QMkvCOj8g0=; b=yEn+nd1F6vHZ7xeKv7Gh9
	uqJnh9R2CBJuoN4zghOty9G2VQLSwfT2USm3pJPhPGIe14BttJuaoraUkmEebGHL
	qbBp3/e8+u8SQuSfEHfAqWm3He4YtlnCNuH7yuOmZwHMtYNnkVk5bq+x4ipaWn9a
	O8cpegVTForsv+KQRdDTMWWki83MPw9FOd8vkGElOabMbQN6D03CveX0Ki1BNupN
	8QgQh1xCLWVWhJCo8ePvvuQr+JK5pY2NWVvI3QQyBR7EGOH5bCjtvgCuZxuc/4/U
	TbWpLQdQIE0ja1ZloBDJ2CiAY9DZ53FIl8DSx1eIZKpRJD+fRHZOnxZhE/VtO9K/
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 472p2vhvvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:36:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 554JaXY4043972
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:36:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Jun
 2025 15:36:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:36:33 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554JaG5n014320;
	Wed, 4 Jun 2025 15:36:19 -0400
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
        Conor
 Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 05/12] dt-bindings: iio: adc: ad7768-1: document regulator provider property
Date: Wed, 4 Jun 2025 16:36:16 -0300
Message-ID: <88c2e811eb91c02d75e314dae4c20a314f8e0571.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749063024.git.Jonathan.Santos@analog.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfXyYUw7caQASm2
 5lxcfOl0W9cQRZq8ASi086S+zDa1y3Cxn7EBvgmOkZfenQyEwB0VCqMT2bmUYfNBvja4zR+z8aN
 9iMOSwAozK2H6T+k4LLF5r2VtquF7qfDcTPEIKONGoh+3qpr1XVct2Eu7O3x9jeZ9tizGaQdAPI
 8O8sxEfyV2vWvvE02WV7qZ0nbh/Sry+RHfCywb4IsCnsXn0M18c5rq5ntC4TmsBy5ZDQjFSu7LI
 pmoT/Tvmnjfh+ULqKDuQx0Ea0WmX71pcObP6McFLN4m8gk0CS8Xp0ZLuVz8fFt3KUUlOVbnNFLU
 etM0FhOPce5EdIP9o4Fi+4N4ASnNUdU3/JmAjMOagEonjbLGzxVib7ScL15QwRuGaVPPblNc5HS
 rE4WCZ6ywVMeBo0WoceZZO5qXuUtk/O9K8QhJdAR3qaJ2zdbFdtKdamgzkew1JJEJcMpem9M
X-Proofpoint-GUID: iiQa8aVYhlXraMX637UdRWzpsGOeaJM1
X-Proofpoint-ORIG-GUID: iiQa8aVYhlXraMX637UdRWzpsGOeaJM1
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=6840a042 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=J1-tWBq05h-qFn0eaeUA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040155

The AD7768-1 provides a buffered common-mode voltage output
on the VCM pin that can be used to bias analog input signals.

Add regulators property to enable the use of the VCM output,
referenced here as vcm-output, by any other device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v10 Changes:
* none.

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


