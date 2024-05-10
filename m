Return-Path: <linux-iio+bounces-4918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F78C1E41
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 08:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2385F1F22F2C
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 06:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274B715E7F2;
	Fri, 10 May 2024 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rdLZ8G5b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733715747E;
	Fri, 10 May 2024 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323320; cv=none; b=lPYmKuiZDIiuv6r2De3LSRbpGhNVvyME6UiMhD01jUpNkVr6bG2TIrgA/Y/5E+7q43qS6qSq+HJTtYp0txXKGX+Ow2aXkylq5/tqio8uTU8Hj/xR2mMVwdzboG4itUoz9aO5Qor2hnLqhV0H1ekKFHkTrDwBcmqfHrDTx8f3Q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323320; c=relaxed/simple;
	bh=ZfAOhPB+WPMtqwsiPP5G+nxFGuB1kiJSjFaKHdqUeuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLPGILAC/pOAZg6wMK1ff4BJmB7lgnkl6WhxkVhgMiUTlglUqnGVXWSpH9Wdi6JhZO+zQj1jWWb6+NRW/OTME0egO7Ybnvyq5tCzlrxrOrzxuO6iJE7NSqku+zoQwlck5GzgxDUljqdLn+cclJDEJleNhMxKUyEsLmnhXzXVTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rdLZ8G5b; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A4cOQp006187;
	Fri, 10 May 2024 02:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=ME3+WgSdh0SM63JNyF0RfaXy+zhBSEUNQZnIzSSkRBU=; b=rdLZ8G5b6bt9
	xlx47//pS9JX10tKox9TFNxr6FhDS+iZA/dq1K6SE/l+HVMsiAs3QTArd4IIYnGb
	JcV2lyFWF4UmUu44p5DxDB4z3j8+VuGg6vQ6lnjNGxawM/zCouo2/Y/tjrPsu9hc
	Y4BWA2GjPrs8aTzGn426fQkH7yO2RVmN4LlMTNeAbNd4F8sHRAbTE11EvI2WGFvw
	Zl2Sl4+XEK58pepH4bSyDGBz0veY4wI69K+MGClVmuTbmYzOCbnNAfLjFiGPy+3p
	YdWoxf4DBbTOzxi7RcTaw43L3w+qQEmykbq2Me8rzhJ2D2RGcN/2u65u0/CR2dC4
	Mz6XYeYqDw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3y16xt1c5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:41:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44A6fLdW051500
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 May 2024 02:41:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 May 2024 02:41:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 May 2024 02:41:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 May 2024 02:41:20 -0400
Received: from MTINACO-L03.ad.analog.com (MTINACO-L03.ad.analog.com [10.117.116.80])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44A6ewwc001379;
	Fri, 10 May 2024 02:41:09 -0400
From: Mariel Tinaco <Mariel.Tinaco@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] dt-bindings: iio: dac: add docs for ad8460
Date: Fri, 10 May 2024 14:40:52 +0800
Message-ID: <20240510064053.278257-2-Mariel.Tinaco@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jAPSjpVQUZcxYvrrESh6bJTUJWBhCY1p
X-Proofpoint-ORIG-GUID: jAPSjpVQUZcxYvrrESh6bJTUJWBhCY1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100046

This adds the bindings documentation for the 14-bit
High Voltage, High Current, Waveform Generator
Digital-to-Analog converter.

Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
---
 .../bindings/iio/dac/adi,ad8460.yaml          | 67 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
new file mode 100644
index 000000000..924f76209
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad8460.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD8460 DAC
+
+maintainers:
+  - Mariel Tinaco <mariel.tinaco@analog.com>
+
+description: |
+  Analog Devices AD8460 110 V High Voltage, 1 A High Current,
+  Arbitrary Waveform Generator with Integrated 14-Bit High Speed DAC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad8460.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad8460
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  vref-supply:
+    description: Drive voltage in the range of 1.2V maximum to as low as
+      low as 0.12V through the REF_IO pin to adjust full scale output span
+
+  clocks:
+    description: The clock for the DAC. This is the sync clock
+
+  adi,rset-ohms:
+    description: Specify value of external resistor connected to FS_ADJ pin
+      to establish internal HVDAC's reference current I_REF
+    minimum: 2000
+    maximum: 20000
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+
+    spi {
+        dac@0 {
+            compatible = "adi,ad8460";
+            reg = <0>;
+            spi-max-frequency = <8000000>;
+            adi,rset-ohms = <2000>;
+
+            vref-supply = <&vrefio>;
+            clocks = <&sync_ext_clk>;
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 758c202ec..dae93df2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1234,6 +1234,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD8460 DRIVER
+M:	Mariel Tinaco <Mariel.Tinaco@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
+
 ANALOG DEVICES INC AD9739a DRIVER
 M:	Nuno Sa <nuno.sa@analog.com>
 M:	Dragos Bogdan <dragos.bogdan@analog.com>
-- 
2.34.1


