Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C41A9414
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 09:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441167AbgDOHUO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 03:20:14 -0400
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:35852 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441159AbgDOHUN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 03:20:13 -0400
X-Greylist: delayed 1429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 03:20:12 EDT
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id C32B31E0C65
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2020 00:56:19 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id Oby5jn46LrO3uOby7jTfSa; Wed, 15 Apr 2020 00:56:19 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=VY3Zwmh9 c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10:nop_charset_1 a=cl8xLZFz6L8A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=gEfo2CItAAAA:8 a=U4Au-FSsymrcop1UMgkA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=rsP06fVo5MYu2ilr0aT5:22 a=sptkURWiP4Gy88Gu7hUp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=X2B7aPP2kdHP7aujtR/egVU9s9GpCl7KgjeAdg09/e8=; b=WCImM79Pgj6n03ThsIO7QoGQ2A
        Pm6w2noBKICzBHtvCLS1cnYdAWDZTJboaIXUcAT7u6YAVQgk1GjU9RGKj5H3oFmdmuNzwWqLgVOPN
        3Mp23GldFh2FjWb2HaODkZ/uS3HTPv91a15sESouyTPGTuME7UFhMhvfVGZSVhQ8PkwYRG5Un4QoV
        jlX4erOR3vKuhcRHwLFC2Cb+spf6jKlh5/F3M9d03iO9KzkKFbbTBhZIhrmlzCZRnSvDuEm4EAVbW
        Jmo3wfDsWXxz/dstOxChzoHgsbjZhMqYdhkRz4W2RdXIeoZtn1TydW3zke9M2G1lKXcklOTeMHzHz
        QqDK8OgQ==;
Received: from p5b3f6ccc.dip0.t-ipconnect.de ([91.63.108.204]:49262 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <saravanan@linumiz.com>)
        id 1jOby3-0000eI-Sg; Wed, 15 Apr 2020 06:56:16 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, broonie@kernel.org,
        lgirdwood@gmail.com, saravanan@linumiz.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: iio: add document bindings for wsen-itds accel sensor
Date:   Wed, 15 Apr 2020 08:55:33 +0200
Message-Id: <20200415065535.7753-3-saravanan@linumiz.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415065535.7753-1-saravanan@linumiz.com>
References: <20200415065535.7753-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 91.63.108.204
X-Source-L: No
X-Exim-ID: 1jOby3-0000eI-Sg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p5b3f6ccc.dip0.t-ipconnect.de (localhost.localdomain) [91.63.108.204]:49262
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 21
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding information for wsen-itds accel sensor driver.

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 .../bindings/iio/accel/we,wsen-itds.yaml      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml b/Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
new file mode 100644
index 000000000000..165cdf71966d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/we,wsen-itds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Würth Elektronik WSEN-ITDS triaxial acceleration sensor
+
+maintainers:
+  - Saravanan Sekar <saravanan@linumiz.com>
+
+description: |
+  Acceleration and temperature iio sensors with an i2c interface.
+  The sensor provies additional application specific features like
+  tap detection, 6D Orinetation, Free-fall, Motion and Activity.
+
+properties:
+  compatible:
+    enum:
+      - we,wsen-itds
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: phandle to the regulator that provides power to the accelerometer
+
+  vddio-supply:
+    description: phandle to the regulator that provides power to the sensor's IO
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      accelerometer@18 {
+        compatible = "we,wsen-itds";
+        reg = <0x18>;
+        vdd-supply = <&vdd>;
+        vddio-supply = <&vddio>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
-- 
2.17.1

