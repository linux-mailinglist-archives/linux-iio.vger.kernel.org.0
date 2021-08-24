Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1106B3F579D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 07:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhHXFd6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 01:33:58 -0400
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:51557 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229885AbhHXFd5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 01:33:57 -0400
X-Greylist: delayed 1486 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 01:33:57 EDT
Received: from cmgw13.mail.unifiedlayer.com (unknown [10.0.90.128])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id AA12A802BF33
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 05:08:24 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id IOfemsF5joTT8IOffmLrKS; Tue, 24 Aug 2021 05:08:24 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=LMCj/La9 c=1 sm=1 tr=0 ts=61247ec8
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=MhDmnRu9jo8A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=gEfo2CItAAAA:8 a=jtbBNqsHAAAA:8 a=-5KMCkUntxd5Z1t9gYsA:9
 a=rsP06fVo5MYu2ilr0aT5:22 a=sptkURWiP4Gy88Gu7hUp:22 a=RWaeYqt-Cn-VcsFsiLGo:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W/AymKeoHSfLUuRKlptGcYxIuqB0gsHM2oq89IBZLKg=; b=P6UsbKfnPihTPc85sKE2/oaeAr
        pbsDFxoda/d4uALhLOb5BeSEbRcTPFxQJZkYU0M7cXTmk8N+1zI57q/YiVvRmX5JFydbRSTX3vSrF
        Nh051VKoCbly8hND5hua/4VmD2+4iwgN4SZR+bxmF8nj29O9UpbEwQKXL4+Ntl/sLRUS4V1XYXANJ
        fHL6dbskrk4/Mk93MrsDTybSJLbnyi/90R6GmJY6z2f+u3wXJsnDHCjotQt/TPg/qbSAQoRhe9Csy
        WNcjH8qZ0l+eqd8zosNsq8Y1bpNFeT1ToTBOY2R+8EGx5FzIjMxYhxDtNp4tr8ricklqVIoqkBPLC
        9fwPH6Vw==;
Received: from [117.193.211.180] (port=56148 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <navin@linumiz.com>)
        id 1mIOfd-000R5G-Hn; Tue, 24 Aug 2021 05:08:21 +0000
From:   Navin Sankar Velliangiri <navin@linumiz.com>
To:     jic23@kernel.org
Cc:     navin@linumiz.com, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, ardeleanalex@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: iio: temperature: add MAXIM max31865 support
Date:   Tue, 24 Aug 2021 10:36:50 +0530
Message-Id: <20210824050650.72619-1-navin@linumiz.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 117.193.211.180
X-Source-L: No
X-Exim-ID: 1mIOfd-000R5G-Hn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [117.193.211.180]:56148
X-Source-Auth: linumcmc
X-Email-Count: 9
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add DT bindings for MAXIM max31865 RTD sensor.

Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>

---
Note:
Changes in v2:
	-> Changed the name RTD to Resistance Temperature Detector
	-> renamed maxim,no-of-wires to 3-wire
	-> fixed code alignment for the example

Changes in v3:
	-> Added more information about 3 wire RTD connection
---
 .../iio/temperature/maxim,max31865.yaml       | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
new file mode 100644
index 000000000000..aafb33b16549
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/maxim,max31865.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX31865 Resistance Temperature Detector.
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
+  maxim,3-wire:
+    description:
+      Identifies the number of wires used by the RTD. Setting this property
+      enables 3-wire RTD connection. Else 2-wire or 4-wire RTD connection.
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
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       temp_sensor@0 {
+         compatible = "maxim,max31865";
+         reg = <0>;
+         spi-max-frequency = <400000>;
+         spi-cpha;
+         maxim,3-wire;
+       };
+    };
+...
-- 
2.32.0

