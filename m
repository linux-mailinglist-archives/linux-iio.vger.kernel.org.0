Return-Path: <linux-iio+bounces-13967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76DCA0442F
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA161665DD
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09991F239B;
	Tue,  7 Jan 2025 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VK4jRXOk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9C1E4929;
	Tue,  7 Jan 2025 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263489; cv=none; b=GSjPIaJ6fQmeKK8Eq87qd49L7l05uInA3n5R/J6Xw1UmDCg4JEK2B5KqFO1hy+Q10dQptEtORyJUrhSR9zdvW6UG9DC3KiM8vWHBY2sdwVT+d94X93dD1qnjY010/7lIifxfu1r8f9rJgt+GTYMGFcvQEORwsy7WBVHIyT8ESxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263489; c=relaxed/simple;
	bh=ie7s1vNiZe/RFclq+Su4ziAIq1XFF3Gd2g8z3Qdn1PY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fc7BYTT/2CH+d+KZn4tnkPkXuEYLilWT9SLsp+MSSQrCeAY3gaAm/iTrkQzFL8YtB8kAUBpp26M2khyq4Q0uqFMT6xCwNd4kcwNumSj0kAlOiql86lRlWwnLM9YBGMqAyYfH1m6Y4lfCClWYLqdQzwSIfWMMgcrwTNJKQwkDzqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VK4jRXOk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507FM9uB006101;
	Tue, 7 Jan 2025 10:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LrcxJ
	DnXnMfGoaos0n3S+zEBh5/uPOPIzFT5Xqr0974=; b=VK4jRXOkpbQulhj1yAwyL
	mdBoHNoAatEoDw9wo1rtd4YNku4EMA1XnQPe2qP2OUcCHl1TSakhEpdYO/qc4pcf
	nuC1Ifhl1hv5ZiFN6oFxXgLIiWWNiOAeX2pH41weMSZcgCMhQagjp9s/0GcAQFaT
	rbbb2VL31e+iqu3YG6xlziEiZc272/kN8wEJu6QssL8c5oGYWksrihNd2ALxr0xy
	TxknCLR1QJMXklZXaJkY483wkezYji0Aq39vWjtJTrmlj8ZM04+45Q3McmTc4SrZ
	rcsiZ/6RSerfAx8VFJF71U8+hAR1OI/BGZVTFz4aSic2x5P/i0g+VvtjKIQk1ACc
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4416uq007v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:24:31 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FOTxW033995
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:24:29 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:24:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:24:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:24:29 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FOIRD030245;
	Tue, 7 Jan 2025 10:24:20 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add synchronization over SPI property
Date: Tue, 7 Jan 2025 12:24:18 -0300
Message-ID: <bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GcvyIF9d3WEjJlgW3fwYz7Hsbrv4QkQB
X-Proofpoint-GUID: GcvyIF9d3WEjJlgW3fwYz7Hsbrv4QkQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070129

Add adi,sync-in-spi property to enable synchronization over SPI.
This should be used in the case when the GPIO cannot provide a
pulse synchronous with the base MCLK signal.

User can choose between SPI, GPIO synchronization or neither of them,
but only if a external pulse can be provided, for example, by another
device in a multidevice setup.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 3ce59d4d065f..55cec27bfe60 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -47,6 +47,15 @@ properties:
       in any way, for example if the filter decimation rate changes.
       As the line is active low, it should be marked GPIO_ACTIVE_LOW.
 
+  adi,sync-in-spi:
+    description:
+      Enables synchronization of multiple devices over SPI. This property is
+      used when a signal synchronous to the base MCLK signal cannot be provided
+      via GPIO. It requires the SYNC_OUT pin to be connected to the SYNC_IN pin
+      on the ADC. In the case of multiple devices, the SYNC_OUT pin of one device
+      should be routed to the SYNC_IN pins of the other devices.
+    type: boolean
+
   reset-gpios:
     maxItems: 1
 
@@ -65,7 +74,6 @@ required:
   - vref-supply
   - spi-cpol
   - spi-cpha
-  - adi,sync-in-gpios
 
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
@@ -89,6 +97,20 @@ patternProperties:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  # adi,sync-in-gpios and adi,sync-in-spi are mutually exclusive (neither is also valid)
+  - if:
+      required:
+        - adi,sync-in-gpios
+    then:
+      properties:
+        adi,sync-in-spi: false
+  - if:
+      required:
+        - adi,sync-in-spi
+    then:
+      properties:
+        adi,sync-in-gpios: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


