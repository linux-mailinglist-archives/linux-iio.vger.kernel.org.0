Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952F53D3654
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 10:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhGWHfS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 03:35:18 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:29933 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhGWHfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 03:35:18 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16N7x5V2041949;
        Fri, 23 Jul 2021 15:59:05 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Jul
 2021 16:15:39 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v2 2/8] dt-bindings: iio: adc: Binding ast2600 adc.
Date:   Fri, 23 Jul 2021 16:16:15 +0800
Message-ID: <20210723081621.29477-3-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 16N7x5V2041949
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add more description about aspeed adc and add two property
for ast2600:
- vref: used to configure reference voltage.
- battery-sensing: used to enable battery sensing mode for last channel.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/iio/adc/aspeed,adc.yaml          | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
index 23f3da1ffca3..a562a7fbc30c 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
@@ -10,14 +10,26 @@ maintainers:
   - Joel Stanley <joel@jms.id.au>
 
 description:
-  This device is a 10-bit converter for 16 voltage channels.  All inputs are
-  single ended.
+  • 10-bits resolution for 16 voltage channels.
+  At ast2400/ast2500 the device has only one engine with 16 voltage channels.
+  At ast2600 the device split into two individual engine and each contains 8 voltage channels.
+  • Channel scanning can be non-continuous.
+  • Programmable ADC clock frequency.
+  • Programmable upper and lower bound for each channels.
+  • Interrupt when larger or less than bounds for each channels.
+  • Support hysteresis for each channels.
+  • Buildin a compensating method.
+  Additional feature at ast2600
+  • Internal or External reference voltage.
+  • Support 2 Internal reference voltage 1.2v or 2.5v.
+  • Integrate dividing circuit for battery sensing.
 
 properties:
   compatible:
     enum:
       - aspeed,ast2400-adc
       - aspeed,ast2500-adc
+      - aspeed,ast2600-adc
 
   reg:
     maxItems: 1
@@ -33,6 +45,18 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  vref:
+    minItems: 900
+    maxItems: 2700
+    default: 2500
+    description:
+      ADC Reference voltage in millivolts.
+
+  battery-sensing:
+    type: boolean
+    description:
+      Inform the driver that last channel will be used to sensor battery.
+
 required:
   - compatible
   - reg
-- 
2.25.1

