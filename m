Return-Path: <linux-iio+bounces-12385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333549D1873
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 19:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F9A1F237C3
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280A1E2825;
	Mon, 18 Nov 2024 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ebg5+ppz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A213B2B6;
	Mon, 18 Nov 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955985; cv=none; b=fI8nUB1Vbp9h0seX6N8Z7V6vIETATFKxFegw8omIp5zL3eyiWK+4XZGWcfXxg9xbyBJjKjVN46YddFJ4/cGGMHc4RWL26NxP9yic8o1Z3z3XYiLaDpFKIa+YghmAVgcKmDffp3sLpzbyY9mSUVrrGnu93TbUC2xi6TfTzyusy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955985; c=relaxed/simple;
	bh=mQPpVX1ii5nEaRzbZho2Fash2vHBJXygqIjjfYsgyb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCdrRLod975QFvydCZVh114EUATOUQqZHtBFD1mcF/+wDYF+NVNykuzTRKDKepDoOHEuHodCWr+2VOUEcmVi49Mge4ejpeMyh1yapcY8JcUmq0satUxC94NtKpsBbYJS8fNXp7izeH9VbTHKq7ex+AeKBN4kvmxWvffIvB8Jp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ebg5+ppz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIH9Df9031074;
	Mon, 18 Nov 2024 13:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=By8v1
	wyraTVwOgre8y77EXn983YPMZqSKpChocECxK0=; b=Ebg5+ppzeoZHIatwM6uAx
	6mgE96tOzTb9FL2kkzrjbe7LRinNjoap/7qBSQRvS4Orj4sQTYCVo7kflDMUqC6k
	AU6Jqmam2GSz2Vs008AfotdDV2nT3UZlvsCqLjBZcRp/PdWuAzJYxtxLnt72CYvF
	QOeHYdHmsUDRvuRuOyMTiJgIQK4yAV08+02EaVgZGeRMM+6HuFXx+bs0CzYQCJGJ
	bwmqw7mLE1pprU56HpWtMurhaWcrOzFYV+sPMgUOWUr7oFnXtQQiTuSI9a8y/mpY
	NpmRwJs8bVTdzyuLCebHzMp5FIyIupyxakhEPG3b3stRUUP8XeYPx/c8CiRdbk/2
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4309qt0cbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 13:52:49 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4AIIqmGU063959
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Nov 2024 13:52:48 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 18 Nov 2024 13:52:48 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 18 Nov 2024 13:52:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 18 Nov 2024 13:52:48 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AIIqZEJ010373;
	Mon, 18 Nov 2024 13:52:37 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Date: Mon, 18 Nov 2024 15:52:33 -0300
Message-ID: <f2829559be51bb7b0bad015236efdba12a2bc63e.1731953012.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1731953012.git.marcelo.schmitt@analog.com>
References: <cover.1731953012.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 4veCtguKVdTMikESGIENR0q7VI7mtHqz
X-Proofpoint-ORIG-GUID: 4veCtguKVdTMikESGIENR0q7VI7mtHqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411180155

Extend the AD4000 series device tree documentation to also describe
PulSAR devices.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Changes v1 -> v2
- Made "cs" the default adi,sdi-pin value for PulSAR devices.
- Dropped AD7694 and the related vio pin checks.

I forgot the ad4000 driver fails if VIO is not provided so I was wrong when I
said AD7694 was software compatible with the other ADCs.
I see now AD7694 also doesn't have SDI pin.
Aside from the VIO and SDI pins, AD7694 is similar to AD7685 both being 16-bit
precision 250kSPS pseudo-differential ADCs.
The AD7683 part mentioned in v1 discussion is similar to AD7988-1, both 16-bit
pseudo-differential 100kSPS.
To avoid complicating things, I dropped support for AD7694.
AD7685 and AD7988-1 are the parts with features similar to AD7694 and AD7683,
respectively.

 .../bindings/iio/adc/adi,ad4000.yaml          | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
index e413a9d8d2a2..4dbb3d2876f9 100644
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
 
@@ -63,6 +77,37 @@ properties:
 
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
 
@@ -133,6 +178,32 @@ required:
   - ref-supply
 
 allOf:
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
+          default: cs
   # The configuration register can only be accessed if SDI is connected to MOSI
   - if:
       required:
-- 
2.45.2


