Return-Path: <linux-iio+bounces-12292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 109949C966C
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689A5B22AC3
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4011B372C;
	Thu, 14 Nov 2024 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pZzrjT/v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2B374CC;
	Thu, 14 Nov 2024 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628267; cv=none; b=ePgxlX6zuvwePHsSZ5k+YE3ifnjAv/WWS7pZufivymFI8wCsOuWTDJS3VqYHeZJmgOlI3729y3WZFOY68LjRH0xGW03NEIkTm3JUwvt15oA6Rd/IgIR0RillPoxiIKNXMC2ebiQFvqKudPRjefUMXQo4bMbAhAbey2zdHLpVXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628267; c=relaxed/simple;
	bh=aIjjTQtxIKAmnkI0eKXQWu4BI73ImPqGRXr7b1dsDwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ml2SG2RQeh6/DKdK0C/QfbUIvJ1ol4KP5UOZuKnimSnibzcPEpDxvaORLSsKjOhtnhu6GZEuOyuFNl0NKSmFmD2+Ere3bz494OJag0tTBpEZKk42f/wT1CK+HiYZxkTwJWBAcEcp9BO90SX/2dH/33CV3HEf4iUAExCfeFgX/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pZzrjT/v; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJ243K002859;
	Thu, 14 Nov 2024 18:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5AGn4
	YUM26Qe6AlqDQWfUKkWPijIQH6bYdZZWqWNayY=; b=pZzrjT/v0uTrUotfuKNbD
	XJYaqBQyiimW/cGFd+nj74MUocIiGKarOhOiB3+uNtBh1D9GB2O83N/QimUj13w3
	bbu8lLz2ZwTz7apL4nKbk8n1bKl38FpG6wRgMdY85Y9hGWdufcsbV6HIPaDrLXNj
	rmaovkbaUJyleDY1YD8qWuo36d+V2n1hJ5lvKzxZxsqo2kteO/EfnQDDq+KsgkGE
	bcNtKPieS2UeMpKjFhrhDmjbx9yryw2+DD1fZxjAP5eWHavFaHW8uJ6Mo/FpYo2+
	XIXzmDrKF/ahddZ15R2zQqWMOgi7ZDrkSPbeDHlQbNkMFCjyBE/q9Gen2oGk9E9J
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42wq0sh4qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 18:50:52 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AENooES006625
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Nov 2024 18:50:50 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 14 Nov 2024 18:50:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 14 Nov 2024 18:50:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 14 Nov 2024 18:50:50 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AENobD3028813;
	Thu, 14 Nov 2024 18:50:39 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Date: Thu, 14 Nov 2024 20:50:35 -0300
Message-ID: <a155d0d0fb1d9b5eece86099af9b5c0fb76dcac2.1731626099.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1731626099.git.marcelo.schmitt@analog.com>
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: b20sFGXgb31xx5GaxXNZb5IqXMdyT_yL
X-Proofpoint-ORIG-GUID: b20sFGXgb31xx5GaxXNZb5IqXMdyT_yL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140189

Extend the AD4000 series device tree documentation to also describe
PulSAR devices.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad4000.yaml          | 115 +++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
index e413a9d8d2a2..35049071a9de 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
@@ -19,6 +19,21 @@ description: |
     https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7694.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -63,6 +78,38 @@ properties:
 
       - const: adi,adaq4003
 
+      - const: adi,ad7946
+      - items:
+          - enum:
+              - adi,ad7942
+          - const: adi,ad7946
+
+      - const: adi,ad7983
+      - items:
+          - enum:
+              - adi,ad7980
+              - adi,ad7988-5
+              - adi,ad7686
+              - adi,ad7685
+              - adi,ad7694
+              - adi,ad7988-1
+          - const: adi,ad7983
+
+      - const: adi,ad7688
+      - items:
+          - enum:
+              - adi,ad7693
+              - adi,ad7687
+          - const: adi,ad7688
+
+      - const: adi,ad7984
+      - items:
+          - enum:
+              - adi,ad7982
+              - adi,ad7690
+              - adi,ad7691
+          - const: adi,ad7984
+
   reg:
     maxItems: 1
 
@@ -129,10 +176,76 @@ required:
   - compatible
   - reg
   - vdd-supply
-  - vio-supply
   - ref-supply
 
 allOf:
+  # AD7694 doesn't have a VIO pin
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad4000
+              - adi,ad4001
+              - adi,ad4002
+              - adi,ad4003
+              - adi,ad4004
+              - adi,ad4005
+              - adi,ad4006
+              - adi,ad4007
+              - adi,ad4008
+              - adi,ad4010
+              - adi,ad4011
+              - adi,ad4020
+              - adi,ad4021
+              - adi,ad4022
+              - adi,adaq4001
+              - adi,adaq4003
+              - adi,ad7685
+              - adi,ad7686
+              - adi,ad7687
+              - adi,ad7688
+              - adi,ad7690
+              - adi,ad7691
+              - adi,ad7693
+              - adi,ad7942
+              - adi,ad7946
+              - adi,ad7980
+              - adi,ad7982
+              - adi,ad7983
+              - adi,ad7984
+              - adi,ad7988-1
+              - adi,ad7988-5
+    then:
+      required:
+        - vio-supply
+  # Single-channel PulSAR devices have SDI either tied to VIO, GND, or host CS.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7685
+              - adi,ad7686
+              - adi,ad7687
+              - adi,ad7688
+              - adi,ad7690
+              - adi,ad7691
+              - adi,ad7693
+              - adi,ad7694
+              - adi,ad7942
+              - adi,ad7946
+              - adi,ad7980
+              - adi,ad7982
+              - adi,ad7983
+              - adi,ad7984
+              - adi,ad7988-1
+              - adi,ad7988-5
+    then:
+      properties:
+        adi,sdi-pin:
+          enum: [ high, low, cs ]
+          default: high
   # The configuration register can only be accessed if SDI is connected to MOSI
   - if:
       required:
-- 
2.45.2


