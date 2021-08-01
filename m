Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719BC3DC98A
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 06:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhHAEE5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 00:04:57 -0400
Received: from gproxy6-pub.mail.unifiedlayer.com ([67.222.39.168]:40814 "EHLO
        gproxy6-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhHAEE4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 00:04:56 -0400
X-Greylist: delayed 1234 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Aug 2021 00:04:56 EDT
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by gproxy6.mail.unifiedlayer.com (Postfix) with ESMTP id 12B6A8028B73
        for <linux-iio@vger.kernel.org>; Sun,  1 Aug 2021 03:44:14 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id A2OZm1HqaEV4rA2Obm9SB0; Sun, 01 Aug 2021 03:44:14 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=LL6j/La9 c=1 sm=1 tr=0 ts=6106188e
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
        bh=/6ZBQoYXI8JJatNbjDef7ul9lkK5sk1BlHRVcmf31O4=; b=KBAmP0iYdC6hFKmPUMMdYbLBKE
        nk38aySCFIu/HCMzHqOvlPvmYZa6VIWWpJsPuyyCBTWh8cz18zDVTEn20nLRgb2nbcj2BJQa1nCb2
        WnyIAJ5zFCz237IbByWWAd0BQ0GfMN92rqBNFg7Z+UOF3SufY3qsTg7c4hvYkxCMqAtV60+4ROw2x
        mRqaSIl38dWE9pYzoKTQOTJ+UthxLDJKfXCTq1ZY7/tSSR56P6h96qJlV3ce11+PATxTRj5ONyRW2
        q1UUp6zd6LLd8G1D73dbhrER4L+ASYf6ncNqh8+kPxQdWp1NwfmF65LUU+ACxuNX7dvJnAUC1ZoaM
        rbhovpYA==;
Received: from [117.202.189.166] (port=53772 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <navin@linumiz.com>)
        id 1mA2OX-00466J-NP; Sun, 01 Aug 2021 03:44:09 +0000
From:   Navin Sankar Velliangiri <navin@linumiz.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        navin@linumiz.com
Subject: [PATCH v2 2/2] dt-bindings: iio: temperature: add MAXIM max31865 support
Date:   Sun,  1 Aug 2021 09:13:41 +0530
Message-Id: <20210801034341.67953-2-navin@linumiz.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801034341.67953-1-navin@linumiz.com>
References: <20210801034341.67953-1-navin@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 117.202.189.166
X-Source-L: No
X-Exim-ID: 1mA2OX-00466J-NP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [117.202.189.166]:53772
X-Source-Auth: linumcmc
X-Email-Count: 5
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add DT bindings for MAXIM max31865 RTD sensor.

Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>

Note: Changes in v2:
	-> Changed the name RTD to Resistance Temperature Detector
	-> renamed maxim,no-of-wires to 3-wire
	-> fixed code alignment for the example
---
 .../iio/temperature/maxim,max31865.yaml       | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
new file mode 100644
index 000000000000..13d288311cc6
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

