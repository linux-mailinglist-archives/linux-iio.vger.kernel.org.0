Return-Path: <linux-iio+bounces-24472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C752ABA51C6
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE0B1C024BF
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D0285CA9;
	Fri, 26 Sep 2025 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CHABoGmU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A0223DD0;
	Fri, 26 Sep 2025 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919401; cv=none; b=YR9JrU4aAxJF++34nKvv6rzCjs8FMs37AmMfVhQdnKRjt5oduWoPa4QpkwVDmXf+voD1M5iIL0F73xgeuojaCersk8CdywADf1fYie1UYJs/AXXykvQx4lM//CP2m8u4TupN39c1fpmSi25bTyNfRRmEPyWgd1e9GsjRx9BK09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919401; c=relaxed/simple;
	bh=m5E/ar1iI66LBonBQHssQCGT/BHgI9ftuEyoILSByT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRhWrZR5BxkWHxHbaaw140tH+pK4XT3ihFTY/vrf0D8NKq8IJOn/dL7o0iU/OB0+rZ0XYfCaNsh+HBMI8ECEAxqlwP50KlYsNbn6tZf0zAY56yHHG9mL43qDbSgVV6jyBUXJLyQ+Gm0rSc5MxOubnv4zo4UtEFTyrKpG1YI5ZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CHABoGmU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QGlwRb004699;
	Fri, 26 Sep 2025 16:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ilHnG
	JPnJPd1D3BZs1aoAJgV8ws5Qo87dcsmTshic+s=; b=CHABoGmUQHe0mtenXRv/P
	2Roh2pLKqIXc6UuinbyHxLngLzF84SSYTGeZdRmeK7zyTFDPx95iXRtxvpyAQgIc
	6OOmIBqHDTFror1YKMKxFgJ7J3xpYy1cnpnfFe8bdFPvgdP2tG/4yGnb9m0QXwFG
	Z65mYjnFhVpZMaaqT1rxxSgc6xAdS+eIyI/zGKnE9oGA7JhaA8ldty/Bp7NUN7T6
	zhyK9rD52XoaSheKU+HN+TdpeVEtXcS/blYI/709vZOJ/lQKj00R14j52n2dXN9a
	abFWAcGJngtPDJAx0M6M8OZS3LWymZ5qhxPPF9lE3Pi8AYohfd0w65ommQ+yCbww
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49db3qy9eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:43:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 58QKhBcG006706
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Sep 2025 16:43:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 26 Sep
 2025 16:43:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 16:43:11 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58QKelho010382;
	Fri, 26 Sep 2025 16:40:50 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
Date: Fri, 26 Sep 2025 17:40:47 -0300
Message-ID: <5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BetdMEkPYE7aMkmPxow0dzNJjjRUXH59
X-Authority-Analysis: v=2.4 cv=HY0ZjyE8 c=1 sm=1 tr=0 ts=68d6fae1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=8pif782wAAAA:8 a=SocUgK8qXDOvutMQcesA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX1oh6me/BzABi
 t4HTgZ6sjbKVmGVzCOVfNAtRXYeyExB3MlUK1Sj99MOd2JO1Q8zT3pMPAWNRozeTfUqBnF2PGQY
 irnu2EXb9VuKonr6dOGHp2GJxYo9S8zVrTd9G3Jouh/yrCBEsqnhjSYX8R3RjjN8kyU1fVRhcF9
 L0/0rLxiPX4T3NPcNRR4Kny4vI+dFUToxjkw2GXk2AjY7KOyIK6fqUONjGA2v/qejnahMhbIso4
 QSRfv28Vz7trREeGI/zPhkN7ZZ/IqdUrkNAeS88WvjtiaAVHs7IAF6EPpisi0Y9fBPthiP/E3gI
 oqS4UKFZe4wJWih466rrkPTIUj9PR58b3sSUzJZdX+K2CEWvWqT2yVB6cRI3FwEWjy8r9og38jc
 SQOpd79Ew73LFGAIBiKqZ4CnwZmuvg==
X-Proofpoint-GUID: BetdMEkPYE7aMkmPxow0dzNJjjRUXH59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
PGA (programmable gain amplifier) that scales the input signal prior to it
reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
and A1) that set one of four possible signal gain configurations.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3
- PGA gain now described in decibels.

The PGA gain is not going to fit well as a channel property because it may
affect more than one channel as in AD7191.
https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf

I consulted a very trustworthy source [1, 2] and learned that describing signal
gains in decibels is a common practice. I now think it would be ideal to describe
these PGA and PGA-like gains with properties in decibel units and this patch
is an attempt of doing so. The only problem with this approach is that we end up
with negative values when the gain is lower than 1 (the signal is attenuated)
and device tree specification doesn't support signed integer types. As the
docs being proposed fail dt_binding_check, I guess I have to nack the patch myself.
Any chance of dt specification eventually support signed integers?
Any suggestions appreciated.

[1] https://en.wikipedia.org/wiki/Decibel
[2] https://en.wikipedia.org/wiki/Gain_(electronics)

Thanks,
Marcelo

 .../bindings/iio/adc/adi,ad4030.yaml          | 84 +++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 564b6f67a96e..20462fa6c39d 100644
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
@@ -54,6 +58,14 @@ properties:
     description:
       Internal buffered Reference. Used when ref-supply is not connected.
 
+  vddh-supply:
+    description:
+      PGIA Positive Power Supply.
+
+  vdd-fda-supply:
+    description:
+      FDA Positive Power Supply.
+
   cnv-gpios:
     description:
       The Convert Input (CNV). It initiates the sampling conversions.
@@ -64,6 +76,26 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pga-gpios:
+    description:
+      A0 and A1 pins for gain selection. For devices that have PGA configuration
+      input pins, pga-gpios should be defined if adi,gain-milli is absent.
+    minItems: 2
+    maxItems: 2
+
+  adi,pga-gain-db:
+    description: |
+      Should be present if PGA control inputs are pin-strapped. The values
+      specify the rounded decibel gain calculated from the voltage gain.
+      Possible values:
+      -10 (A1=0, A0=0), (1/3 V/V gain)
+      -5 (A1=0, A0=1), (5/9 V/V gain)
+      7 (A1=1, A0=0), (20/9 V/V gain)
+      16 (A1=1, A0=1), (20/3 V/V gain)
+      If defined, pga-gpios must be absent.
+    enum: [-10, -5, 7, 16]
+    default: -10
+
   pwms:
     description: PWM signal connected to the CNV pin.
     maxItems: 1
@@ -86,11 +118,33 @@ required:
   - vio-supply
   - cnv-gpios
 
-oneOf:
-  - required:
-      - ref-supply
-  - required:
-      - refin-supply
+allOf:
+  - oneOf:
+      - required:
+          - ref-supply
+      - required:
+          - refin-supply
+  # ADAQ devices require a gain property to indicate how hardware PGA is set
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: ^adi,adaq
+    then:
+      allOf:
+        - required: [vddh-supply, vdd-fda-supply]
+          properties:
+            ref-supply: false
+        - oneOf:
+            - required:
+                - adi,pga-value
+            - required:
+                - pga-gpios
+    else:
+      properties:
+        adi,pga-value: false
+        pga-gpios: false
+
 
 unevaluatedProperties: false
 
@@ -114,3 +168,23 @@ examples:
             reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,adaq4216";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+            adi,pga-gain-db = <-5>;
+        };
+    };
+...
-- 
2.39.2


