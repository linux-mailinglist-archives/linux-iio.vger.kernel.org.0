Return-Path: <linux-iio+bounces-12946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BE9E08D3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 17:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FC0B650A8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B28202F8C;
	Mon,  2 Dec 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hLRFzTPK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3CC203703;
	Mon,  2 Dec 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148494; cv=none; b=Wjo3fWaE9aZ/fOahomSwnA84/oQkTmTtNJZpOmovbl56HGeNwU6w3ZQWsAnMEE1gNRrEIm/oGWyxetGq+lDDm5raIaGIioy1ne5RYzUassBWrtcx6D9bpMc7gPV1d8rrpc3P6g6NbQAZQUfiiaYq3fF9E8In1BgIPHZkJPnBFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148494; c=relaxed/simple;
	bh=hn1CdasRQoZxfhC3DYTvsSo/nR9ZWyuxJv9kThx+yRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCABmtDQf/NMES5yTs3IPLzeRmI89M6LGFe5flfDB9I06L2oUP39zdsaRcE3ZgCYzVmXCHzFYXEGWCPY4u9nkN0wnQEVObAGcTLPGzijEm7qJRdxz/LRDfbKHsn6t7NZl3hA6IAKR8jWCztq4B8ZJYCG94jC/qG0T93Z1MMSV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hLRFzTPK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2D7VSB004470;
	Mon, 2 Dec 2024 09:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zMrGq
	gp6IykLTPXE3ArCzuNFXRX2GYAMtr+B663PBIQ=; b=hLRFzTPKTnJtVUflOayfI
	RvIfv4wL+xg85MO/ARYC7FLQnx2981gWXi7LNmQSFPZIt2777tYdrAbzBl0l5fPQ
	BL+SUGVQillyQ31M405k57nmaVhFljgOycsqPmQdGIyozmbjyyy/S1oB2POsAO+Z
	0aVJAdhK8qqWQhrmyXzDgnbb+vKBknVlRvL0tunon3RMIOAVOt4M/91vx29m8jBU
	sZtzxGq5Pci3T8IPa4yXW+og9d5/2EL2yfRocrZgYsm7LZMIiigrkwcjY3GwckBH
	YxyOwJmg7/xngCPPJNK8qiYOeM154xb+lRk5eqfkipgz6VQIqn+jginznvIzxLHc
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 437we78jp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 09:07:54 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4B2E7rgh006706
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 09:07:53 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 2 Dec 2024 09:07:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 2 Dec 2024 09:07:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 2 Dec 2024 09:07:53 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B2E7dKK027768;
	Mon, 2 Dec 2024 09:07:42 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Date: Mon, 2 Dec 2024 11:07:38 -0300
Message-ID: <cc05f1471c409ab38722cd0e80fd5857ff9ce5db.1733147444.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1733147443.git.marcelo.schmitt@analog.com>
References: <cover.1733147443.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: MTmdBRaSULaETUeNqOiaUOejSjoe8de2
X-Proofpoint-GUID: MTmdBRaSULaETUeNqOiaUOejSjoe8de2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020122

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
Change log v5 -> v6
- Made compatible property doc similar to other ADC dt-bindings.

This version has the documentation for the compatible property similar to
other ADC bindings under iio such as:
- adi,ad7923.yaml
- allwinner,sun20i-d1-gpadc.yaml
- mediatek,mt2701-auxadc.yaml
- samsung,exynos-adc.yaml
- ti,am3359-adc.yaml

If this still doesn't follow the preferred dt-binding style then please provide
an example that does. Documentation under Documentation/devicetree/bindings/
does not tell how to document fallback compatibles nor points to any example.

 .../bindings/iio/adc/adi,ad4000.yaml          | 75 +++++++++++++++----
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
index e413a9d8d2a2..96e01a97dd95 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
@@ -19,49 +19,82 @@ description: |
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
 
 properties:
   compatible:
     oneOf:
-      - const: adi,ad4000
+      - enum:
+          - adi,ad4000
+          - adi,ad4001
+          - adi,ad4002
+          - adi,ad4003
+          - adi,ad4020
+          - adi,adaq4001
+          - adi,adaq4003
+          - adi,ad7687
+          - adi,ad7691
+          - adi,ad7942
+          - adi,ad7946
+          - adi,ad7983
       - items:
           - enum:
               - adi,ad4004
               - adi,ad4008
           - const: adi,ad4000
-
-      - const: adi,ad4001
       - items:
           - enum:
               - adi,ad4005
           - const: adi,ad4001
-
-      - const: adi,ad4002
       - items:
           - enum:
               - adi,ad4006
               - adi,ad4010
           - const: adi,ad4002
-
-      - const: adi,ad4003
       - items:
           - enum:
               - adi,ad4007
               - adi,ad4011
           - const: adi,ad4003
-
-      - const: adi,ad4020
       - items:
           - enum:
               - adi,ad4021
               - adi,ad4022
           - const: adi,ad4020
-
-      - const: adi,adaq4001
-
-      - const: adi,adaq4003
+      - items:
+          - enum:
+              - adi,ad7685
+              - adi,ad7686
+              - adi,ad7980
+              - adi,ad7988-1
+              - adi,ad7988-5
+          - const: adi,ad7983
+      - items:
+          - enum:
+              - adi,ad7688
+              - adi,ad7693
+          - const: adi,ad7687
+      - items:
+          - enum:
+              - adi,ad7690
+              - adi,ad7982
+              - adi,ad7984
+          - const: adi,ad7691
 
   reg:
     maxItems: 1
@@ -133,6 +166,22 @@ required:
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


