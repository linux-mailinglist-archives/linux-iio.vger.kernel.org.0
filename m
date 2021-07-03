Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EDF3BA83D
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 12:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhGCK0p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 06:26:45 -0400
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:34978 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229965AbhGCK0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 06:26:44 -0400
X-Greylist: delayed 1486 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jul 2021 06:26:44 EDT
Received: from cmgw14.mail.unifiedlayer.com (unknown [10.0.90.129])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 3A9F98033E24
        for <linux-iio@vger.kernel.org>; Sat,  3 Jul 2021 09:59:24 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id zcQjl2YUNsrflzcQlldjBd; Sat, 03 Jul 2021 09:59:24 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=OM3iYQWB c=1 sm=1 tr=0 ts=60e034fc
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=e_q4qTt1xDgA:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=gEfo2CItAAAA:8 a=jtbBNqsHAAAA:8 a=-5KMCkUntxd5Z1t9gYsA:9
 a=rsP06fVo5MYu2ilr0aT5:22 a=sptkURWiP4Gy88Gu7hUp:22 a=RWaeYqt-Cn-VcsFsiLGo:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=q1eL5e0dj2hDZqoVwjwQkknpc8SAwpNuZaB0C/ysF6s=; b=gqUfz98qL5EPi8D667JoKqOL8C
        SQxMEcXg/qnIXE+RGbLdKJnddw+kfdagQIQ8B4pPIzX1C3ANK1kRtyRORkpSRTnYNkIN6SjdZ27vv
        +jtll/L1x3wrjpHeta3aeqgQbcYIDx5NF7tA7ghg2Td1ZUBT9eVaZf4skQf+9t201p5P/TDz31FFa
        ajIjv7bdPpwt4od2TIAUWfvdJjyvVvx6QldehgSXX6Lzs1t9lKe6txbA6LbTKGmAYPQXEScP3j6zA
        YqmYaMz9E3B9pFBUO4mlvtm4lu08f69p5/NNT2SMsOCz9NDv3JHF1ImqBJYk3PkFzyJXhiMBcTtd1
        mSYcPwqg==;
Received: from [117.202.189.80] (port=49188 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <navin@linumiz.com>)
        id 1lzcQj-002Z2P-AX; Sat, 03 Jul 2021 09:59:21 +0000
From:   Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, navin@linumiz.com
Subject: [PATCH 2/2] dt-bindings: iio: temperature: add MAXIM max31865 support
Date:   Sat,  3 Jul 2021 15:29:54 +0530
Message-Id: <20210703095954.221281-1-navin@linumiz.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 117.202.189.80
X-Source-L: No
X-Exim-ID: 1lzcQj-002Z2P-AX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [117.202.189.80]:49188
X-Source-Auth: linumcmc
X-Email-Count: 5
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add DT bindings for MAXIM max31865 RTD sensor.

Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
---
 .../iio/temperature/maxim,max31865.yaml       | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
new file mode 100644
index 000000000000..9efadea514e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/maxim,max31865.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX31865 RTD-to-Digital Converter.
+
+maintainers:
+  - Navin Sankar Velliangiri <navin@linumiz.com>
+
+description: |
+  https://datasheets.maximintegrated.com/en/ds/MAX31865.pdf
+
+properties:
+  compatible:
+    const: maxim,max31865
+
+  reg:
+    maxItems: 1
+
+  maxim,no-of-wires:
+    description:
+      Setting this property enables 3-wire config. Else
+      2-wire or 4-wire.
+    type: boolean
+
+  spi-max-frequency: true
+  spi-cpha: true
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	temp_sensor@0 {
+		compatible = "maxim,max31865";
+		reg = <0>;
+		spi-max-frequency = <400000>;
+		spi-cpha;
+		maxim,no-of-wires;
+	};
+    };
+...
-- 
2.32.0

