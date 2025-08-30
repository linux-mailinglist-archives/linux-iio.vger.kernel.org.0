Return-Path: <linux-iio+bounces-23419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE16B3C6B3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4062E7C335C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C281A9FA8;
	Sat, 30 Aug 2025 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m/NAS2dB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC5C2EF;
	Sat, 30 Aug 2025 00:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514755; cv=none; b=M3zcVvU1A5HRw36J0P7irRwBZHB1W2W6vo3kM06GBr8UEMxGy1DAmsKQP0YqAWY4oYTltGGGEV60DubIaEGFx/hDXTIFKoc9gyiIr7hqlW8NYRmWF6oAYrCTPdlr8GxYUQ9dD3sCdTRLhPdDwvUHR3/JZI9RAxoyjZ2JdJULJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514755; c=relaxed/simple;
	bh=TnouJmgMJ50Ev5m9ENqqUYzy/sHbiO1Ny3ViYoFd9ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJ8oFgJ04mXWP4rFNRhBWzjP4YRWCfreCn0pW7C0no0pORiNrN5lcX3165j0AuQwpi9J265xfixx4MALNwHDPI2r3SOE/dNvis4USE1aAWWJYzpDTztBEOM7RYRWgzidPQfTxeIeXovieO9P6hEm9Xfx88IfwEjUJWeL21yaKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m/NAS2dB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TJR8nk026885;
	Fri, 29 Aug 2025 20:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lCuqA
	fEnw8jBelaGiORNTfPiZ725h4Jqciydl/NBci4=; b=m/NAS2dBM53VMLDGVr5aA
	KeUsAwujbawnYugSHg/WahGxs70oC8o6HIIezGHeBST6vkPgS72eAaCzg96cVq0r
	kWx3XbxqeKZcubyLQMFmD1RvUdSQtQJP1tOW7v0xPD9+sMMz6HX/59fgvZ7Vcitw
	nH2E74Wmhmm3d34cnKIWm+zOGbGN/FB/Mp12BDQp6B8aBOF7EXS+me4k/qkR/rTh
	JThZ7cvh9KLSHaYzksYRHtaGlvY8h91pPue9JnWNaplwOSx02rvkd+/P/csbDGyo
	N1QWmYeb5bxGHSogsvvYfkEWUWL5gCRFHmql4glzcUVMxXTRLqlHpCG1dAhiwvAa
	A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqatajns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:45:49 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0fW3O007856;
	Fri, 29 Aug 2025 20:45:49 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqatajnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:45:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0jlRv018988
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:45:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 20:45:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:45:47 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0jVQL005057;
	Fri, 29 Aug 2025 20:45:33 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH 14/15] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
Date: Fri, 29 Aug 2025 21:45:30 -0300
Message-ID: <31584fd69731bf75967a0fa75302bd7402f6705f.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDAwMCBTYWx0ZWRfX+oGVcQSEflU9
 XgAD+W3zgvrMDF6V+0Zyw232FsiyHYtz22rktMqf/y3zeEB9bP/sbYLZc3M+ZFmgXvQS+OOoHT7
 vQtYK8tEu9c+uoZahq3syFDrMEDOhW5Fw8vT6HdQ9XVE6zWOKmsjxKJWNGlz/4pPgG4HGPIKWbH
 KOB/obOaaxlsJIL0VrQTHkeDYTLehkDtXYWJQ89NU57gx4zmj5cHd4/PPcFTPS0EoOkc3Dru4US
 34qiAF/O0VR4uLUVfRJ2AoFrTTij0QQ5e7n9ty8O/FHZ4GVIHgI8JYsC2k6JFdcsg1/7ZPOYMj9
 bxXi/W39GYYA8nHbvKZrcklZWHRitNFdl0oNuL9h2tBaR0rO+9GAqA63WMdAP9Ch0hMKRzLp+dq
 4m7Ke7DX
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68b249bd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=k9a_pPtenOqtW2HRTuAA:9
 a=UHLEkDqBE7be8kV_hx9V:22
X-Proofpoint-ORIG-GUID: 4dZk4ChpX6yRgc2O0mFXXqjlWhjTpSdZ
X-Proofpoint-GUID: La6hrZDHMmM0VBkc85ncP8bRz0rZqqrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270000

ADAQ4216 and ADAQ4224 are similar to AD4030 except ADAQ devices have a PGA
(programmable gain amplifier) that scales the input signal prior to it
reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
and A1) that set one of four possible signal gain.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
The PGA doc was inspired on ad7191 dt-binding and uses the same properies (but
with different values) to describe the hardware.

 .../bindings/iio/adc/adi,ad4030.yaml          | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 9adb60629631..36fd2aa51922 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -19,6 +19,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4216.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4224.pdf
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -31,6 +33,8 @@ properties:
       - adi,ad4630-24
       - adi,ad4632-16
       - adi,ad4632-24
+      - adi,adaq4216
+      - adi,adaq4224
 
   reg:
     maxItems: 1
@@ -64,6 +68,27 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pga-gpios:
+    description:
+      A0 and A1 pins for gain selection. For devices that have PGA configuration
+      input pins, pga-gpios should be defined if adi,gain-milli is absent.
+    minItems: 2
+    maxItems: 2
+
+  adi,pga-value:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Should be present if PGA control inputs are pin-strapped. The values
+      specify the gain per mille. For example, 333 means the input signal is
+      scaled by a 0.333 factor (i.e. attenuated to one third of it's original
+      magnitude). Possible values:
+      Gain 333 (A1=0, A0=0)
+      Gain 556 (A1=0, A0=1)
+      Gain 2222 (A1=1, A0=0)
+      Gain 6667 (A1=1, A0=1)
+      If defined, pga-gpios must be absent.
+    enum: [333, 556, 2222, 6667]
+
   pwms:
     description: PWM signal connected to the CNV pin.
     maxItems: 1
@@ -120,6 +145,20 @@ allOf:
     then:
       properties:
         adi,dual-data-rate: false
+  # ADAQ devices require a gain property to indicate how hardware PGA is set
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adaq4216
+              - adi,adaq4224
+    then:
+      oneOf:
+        - required:
+            - adi,pga-value
+        - required:
+            - pga-gpios
 
 unevaluatedProperties: false
 
-- 
2.39.2


