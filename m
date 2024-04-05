Return-Path: <linux-iio+bounces-4091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F5F89A05D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1440A1C21252
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D9F16F820;
	Fri,  5 Apr 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b2wDUVav"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36B16F8FB;
	Fri,  5 Apr 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329041; cv=none; b=IEoxuSQJATxVQW9oGUTIucRQ9AxtouLRx3930wBBWiT/5ljPtzfdvpGYLxP1MpJnX2mjaaYGWdsfWcD0kHmtoq4t2ulNoLqmxetBcKzthy6PswmAVq0JdDQRljdGGDlFIE5bJ0bBgcGvH2uEnjdsLH+Z4yO1Qa3M3ugraIdCcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329041; c=relaxed/simple;
	bh=B2qMkoUgAlkgc3cNW1Xw7aSSW3o+WuhtW/o0unorG3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q/oXjb9VQUGuvIzySzVErIjc7sZx8N7RWDlMHKaY+gA+vroloGnPqxWOB52foCopP+tPRdtcLu1ITs8Kxe0r+vb6AyNZYYmUxg03gPwWQ/GDTCMBZOQRXt1lFIuqqpi1g8Vp1Hu8riRy5XjkKV2BfnauawJfAMfJHik8C1e4Bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b2wDUVav; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435EeTG3002554;
	Fri, 5 Apr 2024 10:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=zTjweR/mTBqFzQYh7nukwDTSA88Hm/9szvBR12+kqv4=; b=
	b2wDUVavmSvelPte3r3KaiLnYg3qgHXUTGcbnfl8Xh0h8XizwAmv3BM0uW8CxViU
	PkTVWDp486p5wRCCTucIuorBmvbuPOoeBwq1Wu3k8UFSOXp+iW+aAU2i3I0+ctXL
	2Zim7roSDpKpVMVSlAnVWe7lvm7VaUn4DVBBafCishFsx+8pRkSK6Y3l8D9z2WKV
	sDQAPdU2yWBW9J/eK8O7J81mSUIrNPhbszHKpRZ0srlnHOTnBzb36tnNygMQ3L/e
	KsI7zbonTV1+TLyLqLIluiIfFBzRvoqkZ1ldDJ4Cq9MnVzXeYLlPLLW1ljSvUsmW
	01eUHgCTWoFgj18SJfQA+g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xak96r2k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:56:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 435EuuEQ022817
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 10:56:56 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 5 Apr 2024 10:56:55 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 435EuSI5019011;
	Fri, 5 Apr 2024 10:56:48 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 5 Apr 2024 17:00:05 +0200
Subject: [PATCH v2 07/11] dt-bindings: iio: dac: add docs for AD9739A
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-iio-backend-axi-dac-v2-7-293bab7d5552@analog.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
In-Reply-To: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Dragos Bogdan <dragos.bogdan@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712329201; l=3317;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=B2qMkoUgAlkgc3cNW1Xw7aSSW3o+WuhtW/o0unorG3s=;
 b=nmxqIMC/RsyU9UnP+vyDCIUUwd9iyU7V/p9bK6Q6AxnAM3vfnVOEDNaR/xqFH01P0kYIocZ3Y
 2Pf4F/ijK2DCfKdm46qncgUzAafpkvKBrWyTLWbGdjPvldpRjFCUiMq
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: s9iQrtyBm_Je0OXUH2ihv6WWIHq_UKxD
X-Proofpoint-GUID: s9iQrtyBm_Je0OXUH2ihv6WWIHq_UKxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050106

This adds the bindings documentation for the 14 bit
RF Digital-to-Analog converter.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   | 94 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++
 2 files changed, 102 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
new file mode 100644
index 000000000000..4ef66fe9d61b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad9739a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD9739A RF DAC
+
+maintainers:
+  - Dragos Bogdan <dragos.bogdan@analog.com>
+  - Nuno Sa <nuno.sa@analog.com>
+
+description: |
+  The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are capable
+  of synthesizing wideband signals from dc up to 3 GHz.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad9737a_9739a.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad9739a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-3p3-supply:
+    description: 3.3V Digital input supply.
+
+  vdd-supply:
+    description: 1.8V Digital input supply.
+
+  vdda-supply:
+    description: 3.3V Analog input supply.
+
+  vddc-supply:
+    description: 1.8V Clock input supply.
+
+  vref-supply:
+    description: Input/Output reference supply.
+
+  io-backends:
+    maxItems: 1
+
+  adi,full-scale-microamp:
+    description: This property represents the DAC full scale current.
+    minimum: 8700
+    maximum: 31700
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - io-backends
+  - vdd-3p3-supply
+  - vdd-supply
+  - vdda-supply
+  - vddc-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad9739a";
+            reg = <0>;
+
+            clocks = <&dac_clk>;
+
+            io-backends = <&iio_backend>;
+
+            vdd-3p3-supply = <&vdd_3_3>;
+            vdd-supply = <&vdd>;
+            vdda-supply = <&vdd_3_3>;
+            vddc-supply = <&vdd>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2137eb452376..76e872e320d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1234,6 +1234,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD9739a DRIVER
+M:	Nuno Sa <nuno.sa@analog.com>
+M:	Dragos Bogdan <dragos.bogdan@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
+
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.44.0


