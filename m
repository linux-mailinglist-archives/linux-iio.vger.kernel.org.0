Return-Path: <linux-iio+bounces-12716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647139D9F78
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 00:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6D0168A3C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 23:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACD31DE2CE;
	Tue, 26 Nov 2024 23:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nIhXZ8Bn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C44199935;
	Tue, 26 Nov 2024 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732662938; cv=none; b=c6OlFX9UK++pTmkD23pG2pFB6He/nxxugoBZabRnDA39FMnpUDvNjhtdTRMW26KLgzdwHOTCalWn9lS2eSLDtovl8KF3cPIlv0KIrLyawXydGbGmg52YfyVtMioCs7Kh6MHBTsk8Se78z2dfBhdL0tuPIELdJp6mHh7I28p/2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732662938; c=relaxed/simple;
	bh=iY/Knmgd+T9lZnFhfWMnieGLUHLgrGd9wTEcikePfHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7QOh23NoSlDFUdwtE1KQXp9iaw/0ApbbNdFKG6McswplQrOmj27jT53Houd0FgUgHoAC+g9OVMAILiKeveIfobO5s7VfDzn0MOi1ahVQmaJ1SxpxZpnPNLN4OZtF7O1Cqgme2sE/6SFbkEYdfmQpWgioifqJSFAachze9j1fC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nIhXZ8Bn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQJwUp4014757;
	Tue, 26 Nov 2024 18:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=09kVF
	gi3vwjRzokajQMe1DYNd+SySHgePPAr9FZ4qz8=; b=nIhXZ8Bnycv4e/G9EwZsZ
	JNMZ2t3bzRpcnG2ak1Bf8P7cSetjvGwHN7ir8PrJ0JIjdYjyLYbAYTw1EHGK60tz
	GRNU16CIAV+SAp/h1pi6W8S3ORCeN4QwXsUH9rH8Vx0Tx+Oa/87fjLR1rmoJZ5kf
	8FgpW7MrQ/K1G19mDqaoYvT+nEyWf8RjBQjbJqPIMeSAi0nR26P35QFOZenpaJT1
	dDu3Qd0Ua+ScEMtQHIwwQ/CQogn/PUKQO8Q3rf3Jw2ezy+4nuVzD9/6JnvI//zja
	zETx0H7KhXdnZqj/GEzC/2wVN1lQECiUYg8n15B/ztesSWokcDkrGev4DK/Pio0S
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 434pbd9gsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 18:15:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AQNFLnG037064
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Nov 2024 18:15:21 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 26 Nov 2024 18:15:21 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 26 Nov 2024 18:15:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 26 Nov 2024 18:15:20 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AQNF73E017889;
	Tue, 26 Nov 2024 18:15:10 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Date: Tue, 26 Nov 2024 20:15:05 -0300
Message-ID: <227873de1e9aa249504639da2241915541d089d5.1732660478.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1732660478.git.marcelo.schmitt@analog.com>
References: <cover.1732660478.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: B6svGxM2Yod5uezzcYFn0fPCXnxF31LF
X-Proofpoint-ORIG-GUID: B6svGxM2Yod5uezzcYFn0fPCXnxF31LF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260186

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
Change log v3 -> v4
- Sorted compatible strings in alphabetical order.
- Left only fallback compatibles in allOf check list for adi,sdi-pin property.
- Improved patch description with explanation about how the AD4000 and PulSAR
  devices are different.

Well, I didn't manage to get a dtbs_check message for all the cases I was
expecting to cover, yet. I trust the test done by maintainers while I don't
figure out what's wrong with my setup.

FWIW, here's what I tried:

Cloned dt-binding tree from git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
Fetched and checked out dt/next branch.
Applied AD4000/PulSAR patches.
- <62dd96ac9cd> ("iio: adc: ad4000: fix reading unsigned data")
- <8ebfd0925521> ("iio: adc: ad4000: Check for error code from devm_mutex_init() call")
- the patches from this patch series

Cloned dtc from git://git.kernel.org/pub/scm/utils/dtc/dtc.git into a directory
at the same level of linux kernel source dir.

Cloned dt-schema from https://github.com/devicetree-org/dt-schema.git into a
directory at the same level of linux kernel source dir.
Within dt-schema, 
mkdir venv
python3 -m venv venv/
source venv/bin/activate
python3 -m ensurepip --default-pip
python3 -m pip install --upgrade pip setuptools wheel
pip install yamllint
pip install dtschema --upgrade
pip install -e .

export ARCH=arm; export CROSS_COMPILE=arm-linux-gnueabi-
Ran `./scripts/dtc/update-dtc-source.sh` from the top level of Linux source tree.
make defconfig
Added zynq-coraz7s-ad7685.dts to arch/arm/boot/dts/xilinx/.
Added zynq-coraz7s-ad7685.dtb to arch/arm/boot/dts/xilinx/Makefile.
make -j4 dtbs_check # but it didn't print anything about adi,sdi-pin value.
Changed the compatible from "adi,ad7685" to "adi,ad7687" and dtbs_check prints
arch/arm/boot/dts/xilinx/zynq-coraz7s-ad7685.dtb: adc@0: adi,sdi-pin:0: 'sdi' is not one of ['high', 'low', 'cs']

-zynq-coraz7s-ad7685.dts file {
// SPDX-License-Identifier: GPL-2.0

/dts-v1/;
#include "zynq-7000.dtsi"

/ {
	adc_vref: regulator-vref {
		compatible = "regulator-fixed";
		regulator-name = "EVAL 5V Vref";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-always-on;
	};

	adc_vdd: regulator-vdd {
		compatible = "regulator-fixed";
		regulator-name = "Eval VDD supply";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-always-on;
	};

	adc_vio: regulator-vio {
		compatible = "regulator-fixed";
		regulator-name = "Eval VIO supply";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		regulator-always-on;
	};
};

&spi0 {
	adc@0 {
		compatible = "adi,ad7685";
		reg = <0>;
		spi-max-frequency = <40000000>;
		vdd-supply = <&adc_vdd>;
		vio-supply = <&adc_vio>;
		ref-supply = <&adc_vref>;
		adi,sdi-pin = "sdi";
	};
};
-} zynq-coraz7s-ad7685.dts file

 .../bindings/iio/adc/adi,ad4000.yaml          | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
index e413a9d8d2a2..3c1171c7f0e1 100644
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
 
@@ -63,6 +77,32 @@ properties:
 
       - const: adi,adaq4003
 
+      - items:
+          - enum:
+              - adi,ad7685
+              - adi,ad7686
+              - adi,ad7980
+              - adi,ad7988-1
+              - adi,ad7988-5
+          - const: adi,ad7983
+
+      - items:
+          - enum:
+              - adi,ad7688
+              - adi,ad7693
+          - const: adi,ad7687
+
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
 
@@ -133,6 +173,22 @@ required:
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


