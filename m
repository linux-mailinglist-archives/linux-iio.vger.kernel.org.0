Return-Path: <linux-iio+bounces-18740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9770A9E554
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 02:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265A23B980E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5274C4D599;
	Mon, 28 Apr 2025 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Nr1EHmm6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9CB4501A;
	Mon, 28 Apr 2025 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799194; cv=none; b=L0u3tdV0VPuKhRofmIdO5MCwJlCUwAZ019m56D1BGc7+50K716A2O3pPZdsZXUOXc48mN/6kFMBFPVnykNQPl9d3BydUvIBAKLSzgybFBNJb/SN+e/qHVoMkJiMlxPUrMVYH7QJISWXlZ0YGjLl5JgHyXgBwbjmgpDorzHdRClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799194; c=relaxed/simple;
	bh=1u2Qy+yfL0XNwcg1JwOUXV5irKiepNA+03eEBJ7lC3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8An2FRDIZpwo4QgoM4kRnoR+QEfPA/vg/U/0clBMRxmtAAoeCI9HrKheu0hJandDsTeIHb6kNo0VZNeKyEQKInkJ5QE/OAYJiPlnFluCnauHcLFpzIkpDwqa6ffk4hDj4svCJkXzHcPldkXKR4gg3CbNXPWZPkM6pXbICbCKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Nr1EHmm6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RLTG9f027668;
	Sun, 27 Apr 2025 20:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kTusN
	vISkcvb2x2u5tzWxYcSP/Ay0hpzNe89SY7NmcQ=; b=Nr1EHmm6/FIMOggmAj1oC
	ZJUr3fUlfWGZlEZ49DJVWu8C+xl3z94/tNIlBNGIAb0n7cd6WSMyQ5MwqzPhrm5b
	gEeW3Fd2Bm5/TZSH6wpv6gqhgO6PmddT3q5hoxbXVjzoK4bmGXVTsIOkBXWLqY/M
	YIb9kuZaSmAbWtNUVuJ80dfS+/uNEk5txhwOUE5QdzV8jOM2jJoegjmEOWNWyzC1
	lSnKXNl4ETN43zkui6EL5F56lgUIk8A/DhoHp5+mFQjANDYEU977u+6orHD/lzpB
	SnPPCNNebjcJptSwoxrv2T4lPzM6QzmWBQZ+50cjWUGkj9Gqf/DebDOeCm7XRV8t
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgcmcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Apr 2025 20:13:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53S0D4Tq028879
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Apr 2025 20:13:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sun, 27 Apr
 2025 20:13:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Apr 2025 20:13:04 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53S0CkSR014602;
	Sun, 27 Apr 2025 20:12:49 -0400
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
Subject: [PATCH v6 04/11] dt-bindings: iio: adc: ad7768-1: document regulator provider property
Date: Sun, 27 Apr 2025 21:12:46 -0300
Message-ID: <1122a27e8b467009733d36a5872ea817f6ce905f.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDIwMiBTYWx0ZWRfX2AQP5nWbay1f NB9Nc9lj0/+NfnKImJPnUKZkA1fWj5YkTlGilnoD0ZyMNc9Fa4XGMSVCOhmJFKGkQlB5kb1fz/R 2QUUXTLCwFp3SDKyvlg2CjUWIsPUgezofaXdr+tbEDwH14VRJE/wXHscXY2bpPHhIGezwwut/RJ
 Exu+zxRIOO1gbMmzfVupaAxmlHMzVFL0cwj+JbTUJHwiIXaV2ZmXElZnuWh6EQ4GfllFOb7Jpni hdFqyjwdGXf9csxAT+JilC891rcnwi3/QklP1yQOZT4G1rcisWN0K+xjIMgeU2LyikuPsQOuF8W qRHIgYBaueev3K9FionaASSmnG7iUWxq0vRmshVLYwEt320OH8b1vMOnJ+utAP2KA8SPWkHiOFU
 0gQ5Bmj4/jsizC458WsEhVbVFYvYjHDfUmkagZsPlj233Elanwd0fpTADNrNAJRn7AI7f59S
X-Proofpoint-ORIG-GUID: 04y4FBFcLDqTWv1QPRuhPK4-scezXdyW
X-Proofpoint-GUID: 04y4FBFcLDqTWv1QPRuhPK4-scezXdyW
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680ec811 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8 a=J1-tWBq05h-qFn0eaeUA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504270202

The AD7768-1 provides a buffered common-mode voltage output
on the VCM pin that can be used to bias analog input signals.

Add regulators property to enable the use of the VCM output,
referenced here as vcm-output, by any other device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
index 25d4995c63a5..5083ee7c0256 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -68,6 +68,19 @@ properties:
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
 
@@ -159,6 +172,12 @@ examples:
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


