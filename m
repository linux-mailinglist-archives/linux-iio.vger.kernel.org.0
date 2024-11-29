Return-Path: <linux-iio+bounces-12806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916EB9DE70F
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 14:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96845B24005
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4519EEC2;
	Fri, 29 Nov 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ERY21CYp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9B19E7D0;
	Fri, 29 Nov 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886048; cv=none; b=f8342Uv1cpSbkbjXL2mJaFFNtmdiBFA7MDnYgeYrJMhxyAkZjOycAGqJAyNEa5ze1hsM2ksTLSLKdrpMfDxBPP/bQEzwSxXbCugsKi8TDeVSDdLsuF3q3FiQBg6DruShGFsgL6jpHiLSiwfLrkSuANXGXXv22aeNtV8no4q+M74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886048; c=relaxed/simple;
	bh=6V0Ls69h9XdMwLUlBWNSDVQL+Tbh+5Pg5QKy1oyZaq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0C55/evfAI/f20wOYC+JPDiBIvE4zU0A+2Hh0B5J0z26VEGHBxqlxtBts8hNTWcQ3u/t6Pp/YH2evYAf/jnSeCHpy5uySWGvi+yhHwWXjF461HcGDwWA6UThMylRJ++vUjm/yzJ/JTi6oOckUcYd8jQ7JeSHO8VU/KijHG15G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ERY21CYp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATAODNv014494;
	Fri, 29 Nov 2024 08:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qTVCY
	iqzE+64FuxVQEjH9PlZ+4vroAQLm0KFjOJfyzw=; b=ERY21CYpXAhBZjcAuhyM/
	haS8OMUpv+8Mr0AvTIBFzMOzrGfXo2V5OR347fuWqyzFwoR3sgTH4/OvhQgmf5KI
	7ozyZmFojdcyAO4YvTycWbZnpDIX/0llTOSqTZLTHAshXzqDk/WsyGxxxRSLzkLO
	Fq3RxZUTUX0Dl3Q1z8M2xiNrv+YPxlC6BIz0KboUVIbefGUO64N4jev0+haDZUPe
	nC/WZlSZc0xMXiZzuryncQpi9oWVNUnpdGUVNThMKKf/O/Ju8soD0cNw/68KqwL0
	AzgBV9fawXgLCaO5UTPYls6EBuZHuLoTlngHa7fLa+I5vknd5qlIacD5DrsBBlxw
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 436716t339-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:13:52 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4ATDDpia047469
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Nov 2024 08:13:51 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 29 Nov
 2024 08:13:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 29 Nov 2024 08:13:51 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ATDDbpb027161;
	Fri, 29 Nov 2024 08:13:40 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Date: Fri, 29 Nov 2024 10:13:35 -0300
Message-ID: <93f63a7b5973c8596cfc3216e833d0129d8c61a4.1732885470.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1732885470.git.marcelo.schmitt@analog.com>
References: <cover.1732885470.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: PjzL6Pxjx79klEGiR9elZyFILE3XCugf
X-Proofpoint-ORIG-GUID: PjzL6Pxjx79klEGiR9elZyFILE3XCugf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290108

Extend the AD4000 series device tree documentation to also describe
PulSAR devices.

The single-channel series of PulSAR devices is similar to the AD4000 series
except PulSAR devices sample at slower rates and don't have a
configuration register. Because PulSAR devices don't have a configuration
register, they don't support all features of AD4000 devices and thus fewer
interfaces are provided to user space. Also, while AD4000 may have their
SDI pin connected to SPI host MOSI line, PulSAR SDI pin is never connected
to MOSI.

Some devices within the PulSAR series are just faster versions of others.
From fastest to slowest, AD7980, AD7988-5, AD7686, AD7685, and AD7988-1 are
all 16-bit pseudo-differential pin-for-pin compatible ADCs. Devices that
only vary on the sample rate are documented with a common fallback
compatible.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Added const items for fallback compatibles.

 .../bindings/iio/adc/adi,ad4000.yaml          | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
index e413a9d8d2a2..5b6662f5f40f 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
@@ -19,6 +19,20 @@ description: |
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
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -63,6 +77,35 @@ properties:
 
       - const: adi,adaq4003
 
+      - const: adi,ad7983
+      - items:
+          - enum:
+              - adi,ad7685
+              - adi,ad7686
+              - adi,ad7980
+              - adi,ad7988-1
+              - adi,ad7988-5
+          - const: adi,ad7983
+
+      - const: adi,ad7687
+      - items:
+          - enum:
+              - adi,ad7688
+              - adi,ad7693
+          - const: adi,ad7687
+
+      - const: adi,ad7691
+      - items:
+          - enum:
+              - adi,ad7690
+              - adi,ad7982
+              - adi,ad7984
+          - const: adi,ad7691
+
+      - enum:
+          - adi,ad7942
+          - adi,ad7946
+
   reg:
     maxItems: 1
 
@@ -133,6 +176,22 @@ required:
   - ref-supply
 
 allOf:
+  # Single-channel PulSAR devices have SDI either tied to VIO, GND, or host CS.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7687
+              - adi,ad7691
+              - adi,ad7942
+              - adi,ad7946
+              - adi,ad7983
+    then:
+      properties:
+        adi,sdi-pin:
+          enum: [ high, low, cs ]
+          default: cs
   # The configuration register can only be accessed if SDI is connected to MOSI
   - if:
       required:
-- 
2.45.2


