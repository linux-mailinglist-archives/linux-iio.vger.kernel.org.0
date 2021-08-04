Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2460B3E049A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 17:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhHDPoX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 11:44:23 -0400
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:50728 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239299AbhHDPoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 11:44:22 -0400
Received: from cmgw14.mail.unifiedlayer.com (unknown [10.0.90.129])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 4C02F8032ED9
        for <linux-iio@vger.kernel.org>; Wed,  4 Aug 2021 15:44:08 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id BJ3tm67HwNjg4BJ3vmmOqf; Wed, 04 Aug 2021 15:44:08 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=EZkN/NqC c=1 sm=1 tr=0 ts=610ab5c8
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=MhDmnRu9jo8A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=gEfo2CItAAAA:8 a=jtbBNqsHAAAA:8 a=-5KMCkUntxd5Z1t9gYsA:9
 a=rsP06fVo5MYu2ilr0aT5:22 a=sptkURWiP4Gy88Gu7hUp:22 a=RWaeYqt-Cn-VcsFsiLGo:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=B4DB/RfNhTmLKxpgmqs5/VamF7cPfi9EtDBoBVb5Jqc=; b=XNZfd+6J7yaucx1a1XvxsHlh92
        6wWN285da1jwuoCAP/WJS1kez8nDNuzQjDM14dfsFouq4Vl5ANf1BiLLyWw1BEKNHHWlpaq9ltBcg
        0WCdPTnM5HewsX78L7fqLqkq4iqAdvsRMFPDstXPygd0u0wHkwGkU48NEU7lYVnsxvtOrETWrOH9n
        zUKDOb/6A+P79GxTzFIKevWWPkGbw4RSI5QLxWJp0Lwnwn9pyfvapNOACm0zZX/yBgc6T1LhdE/dP
        QyIGgJf9iEFsvX8E2uXU/YsdU5e/KUyQfklHmyT5OZc2ZHfuYLqDBfk8Yv5hd9BbIKUQYx4MS8TKe
        W9bJdXlQ==;
Received: from [117.193.211.230] (port=50072 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <navin@linumiz.com>)
        id 1mBJ3t-0041Rh-1D; Wed, 04 Aug 2021 15:44:05 +0000
From:   Navin Sankar Velliangiri <navin@linumiz.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        ardeleanalex@gmail.com, navin@linumiz.com
Subject: [PATCH v3 2/2] dt-bindings: iio: temperature: add MAXIM max31865 support
Date:   Wed,  4 Aug 2021 21:12:54 +0530
Message-Id: <20210804154254.241118-2-navin@linumiz.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804154254.241118-1-navin@linumiz.com>
References: <20210804154254.241118-1-navin@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 117.193.211.230
X-Source-L: No
X-Exim-ID: 1mBJ3t-0041Rh-1D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [117.193.211.230]:50072
X-Source-Auth: linumcmc
X-Email-Count: 10
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

