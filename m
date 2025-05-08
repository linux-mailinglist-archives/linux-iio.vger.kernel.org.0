Return-Path: <linux-iio+bounces-19323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E256DAB00EC
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44931C04169
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E622857CF;
	Thu,  8 May 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="R+2uRi9z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525027EC97;
	Thu,  8 May 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723868; cv=none; b=kkxguXjQsg1LkbQwU8V31WIR3eo3ujzJLt5Bf8CPKyL9vMzQQC8fQWuwADDpF/uMsgaczEbpPZYDC64f9zetS5cox3BvNaYW3R/i0lUieSnInND+SlyvPZqh1xM8kkuhO8cTNEJqI6MxyDtEmlBGy3YVYVrBBdF1RfG1XiAkzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723868; c=relaxed/simple;
	bh=QUx4DkfRGNvgTQEGfSV3o7rJVu41RqTvUh+gXUHUmI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4xyjdIPx+9VoQFfob+XVh3xnXF2GSoCtzgfxj8Dmjl55Hs1g9+woNMxdRe1dmcNP9rvmYY0uNpa7fqx+tkN/NFOhEgh7uTGNFicalgUoFtyy8nMFOMdaO93mUKdpzKJppVw0/dQg4XpCSjJnTpaE4uxipRqWjgvD49Ara4NwMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=R+2uRi9z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548FSacc000730;
	Thu, 8 May 2025 13:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2cP5F
	VzGyD6F84yq+AftavMjlbUCQBvGasgEENghFQQ=; b=R+2uRi9zOW/hN9QeaCxOF
	HKE6mOHVCBRkgczezkjd4BIb9XdFZk5vhNXuHYPIQ5t1EtcQQXwjocbsCCIxfUjz
	s7f+tOAqA40zk0CVTGZ4C/dOX5IJ6hagPNUVGJBsFb9IVVPIz7b5uni3L1yEWVpg
	j3eA3CDz/gPfD5sNDxr1lXyS2CH4xEnopEEPlVIabTZpZhpii2RKK1IvaVTN8/lS
	Iyz7oECQYA0ga+p0hP34+9VHlcxTUAtrJvY+oYAcBx4JDQXRY+pN6tqiguGkiY77
	AzcMpoD+yZj9FcHhmlHWlPqUTyue5Ds4WjwCYGhZ4N5VSmkjbpziDIalvnJIDoPo
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46gy9q8d7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:04:17 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 548H4GEi022758
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:04:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 May 2025
 13:04:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:04:16 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H3xcB015885;
	Thu, 8 May 2025 13:04:02 -0400
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
Subject: [PATCH v7 05/12] dt-bindings: iio: adc: ad7768-1: document regulator provider property
Date: Thu, 8 May 2025 14:03:59 -0300
Message-ID: <c99c45f3c3cfc1937e80ac155342cd3e72c25904.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 5MKn3SDCtthx4Yar1O74cbw1OZ6jXVRk
X-Authority-Analysis: v=2.4 cv=f/ZIBPyM c=1 sm=1 tr=0 ts=681ce411 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=J1-tWBq05h-qFn0eaeUA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: 5MKn3SDCtthx4Yar1O74cbw1OZ6jXVRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfXyIxgBmjrEjB9
 vKgakGVyYs6rneoEYkFPJQw2MuqcOrpRPgKqwJwslYDsZfJvp2Fm78Gn2AA5Kcob6UO1T1J+fLh
 nIYW6gLEyjkvgBVgxUMA6Tsj7vP7kQfOcw9jpZadDYcD4z2k8U4nj3yOWOCbRejCFeMyAJ0fFVA
 v3RVhtTm+qO5+CnSTdMw0jPSw/OFk4gFXESdeRR64zdExo/sNbsg/SMJmtimXFc0hHKn2StbFk+
 T/pYWmzG7xOe+li6YR114Bg8OxCnipl7gBA/QqPYYJj0W2hFx9U7vlcEiXQGNOruJbljCnKtgDq
 lj6Z74yYJuWsrzj0o4vjqxyi4BOLtbSS5JV/Pp8iDBYTqLC0pY32GkMeDFab7GsrY5rICDRx4VW
 Uq1YPENdrz76NZnK4/2cuXken+kxqqW1zyvFGsZgPDvQ9PFAUxr0Dya/oQM1fTNRRQjuNUqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080149

The AD7768-1 provides a buffered common-mode voltage output
on the VCM pin that can be used to bias analog input signals.

Add regulators property to enable the use of the VCM output,
referenced here as vcm-output, by any other device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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


