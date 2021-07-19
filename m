Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD393CCFD2
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhGSIVj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:21:39 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:51414 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbhGSIVi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 04:21:38 -0400
X-Greylist: delayed 709 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jul 2021 04:21:37 EDT
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 16J7oVkX015578
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 15:50:31 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16J7nQKL015321;
        Mon, 19 Jul 2021 15:49:26 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 16:05:48 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <raltherr@google.com>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v1 2/7] dt-bindings: iio: adc: Binding ast2600 adc.
Date:   Mon, 19 Jul 2021 16:06:02 +0800
Message-ID: <20210719080607.28712-3-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
References: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 16J7nQKL015321
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add more description about aspeed adc and add vref property
for ast2600 to configure it reference voltage.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/iio/adc/aspeed,adc.yaml          | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
index 7f534a933e92..67ff0b5c7ef2 100644
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
@@ -33,6 +45,13 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  vref:
+    minItems: 900
+    maxItems: 2700
+    default: 2500
+    description:
+      ADC Reference voltage in millivolts (only work at ast2600)
+
 required:
   - compatible
   - reg
-- 
2.25.1

