Return-Path: <linux-iio+bounces-2340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0031484F878
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7751F26CF1
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB0D7319C;
	Fri,  9 Feb 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ti5ocegu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F938388;
	Fri,  9 Feb 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492402; cv=none; b=qLo2Xsww0CfUh2Sjc5ZHmtjmQ4cZ/Y5x9v0NLlGdbWFEPitRtpCnVBNDCbKmjQd2et7rTtUTSt5cBbdUmpwUmrThGL56L3vjXCXL+8LL/QxWWaB/HDqwUNZGlBJw/tU5TRvEO8NIt9KB1WVgzWTPwwxSLMPI0uUpqaWLfQwW8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492402; c=relaxed/simple;
	bh=BNYirLxnGTOI/A1w2hu7+GFUDO+PsuDMfEgRy7j6TjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BGZeeUyhh98Mp95BtJ/amC0CKU7mbRjCxPQKd0ZkcMeHOPcNHIWvhOOmTuPQnPCBkmVO/bbyussCEgkEBkbFyc2lfLM8jXlhIWJXO4TwERRRMf4a5KwSImTALkX8fF9TYQ7T7vQjNbuFV8IdWtAh4NkjjJf5owE8t1Wtg1pjgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ti5ocegu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419E0amC013498;
	Fri, 9 Feb 2024 10:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=dv8K0yDPfokUk0Q/6ULPV/NvGuXshWHBQfmmGTk4J1g=; b=
	ti5ocegufzWhYKhd4z03Qy+SqrqAJFk4jcEoV1whBwvpRHxwts6T49rvj5eFCAgi
	0lszOHO3ULfGRPAtPEcF+iQ8Lq1sS9q+tsgXuRLUdZqDk24L4p/ksahR2XUK6/pO
	7Dxn2AwSms8uTFTEqlRtBCQMKq4e0qIt0g3u3d+lWIzSvzM7jjGoUmZvY7MIrIrO
	ZQ+t/PYUtRFignrWaXtXR9ykiCgGBzaNOqVL7Q/aqPr7yekoXItHM9auGTp6r6nf
	OVAe5mrGSOdB1OrARR+636k6XB5jCnEmN4HW19YBzZvhVjCU09RGx8LiLb5KQwkH
	y5ybij0voN2OCF8q1Zk8aQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w53423p95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 10:26:05 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 419FPoAn047834
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 10:25:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Feb 2024
 10:25:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Feb 2024 10:25:49 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 419FPVJ2013228;
	Fri, 9 Feb 2024 10:25:42 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 9 Feb 2024 16:28:52 +0100
Subject: [PATCH v10 2/7] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240209-iio-backend-v10-2-3ed842064318@analog.com>
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <andy.shevchenko@gmail.com>, Rob Herring
	<robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707492532; l=1738;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BNYirLxnGTOI/A1w2hu7+GFUDO+PsuDMfEgRy7j6TjM=;
 b=+OYTPkxq0GHifCk/g+ymCmTQ2bfcqjUtPt239r27MYRLPzbgyoskkbnjYgZz5iKmkEV85eGm1
 r5dvgVArcaiCxtWGhNj+1paJzy/+KLQEqSypamok3JpxC1dFuCtH6D/
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: IVnB9CmjDZBN92mRkmbJRG_sFoBhEXLA
X-Proofpoint-ORIG-GUID: IVnB9CmjDZBN92mRkmbJRG_sFoBhEXLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090114

'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
also remove it from being required.

The reason why it's being deprecated is because the axi-adc CORE is now
an IIO service provider hardware (IIO backends) for consumers to make use
of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
of consumer referencing other nodes/devices) and that proved to be wrong
and to not scale.

Now, IIO consumers of this hardware are expected to reference it using the
io-backends property. Hence, the new '#io-backend-cells' is being added
so the device is easily identified as a provider.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index 9996dd93f84b..3d49d21ad33d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -39,12 +39,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       A reference to a the actual ADC to which this FPGA ADC interfaces to.
+    deprecated: true
+
+  '#io-backend-cells':
+    const: 0
 
 required:
   - compatible
   - dmas
   - reg
-  - adi,adc-dev
 
 additionalProperties: false
 
@@ -55,7 +58,6 @@ examples:
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;
         dma-names = "rx";
-
-        adi,adc-dev = <&spi_adc>;
+        #io-backend-cells = <0>;
     };
 ...

-- 
2.43.0


