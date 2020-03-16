Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A107218716F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 18:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbgCPRq0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 13:46:26 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54054 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731715AbgCPRq0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 13:46:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D83F8FB07;
        Mon, 16 Mar 2020 18:46:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 46RZyJU6HEyS; Mon, 16 Mar 2020 18:46:21 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D6CBE40D82; Mon, 16 Mar 2020 18:46:20 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: iio: light: vcnl4000: Add near-level
Date:   Mon, 16 Mar 2020 18:46:18 +0100
Message-Id: <65e1007c48f24c44fba0c12b1d5d31af2b5d3a1a.1584380360.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1584380360.git.agx@sigxcpu.org>
References: <cover.1584380360.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This value indicates when userspace should consider an object
near to the sensor/device.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 Documentation/devicetree/bindings/iio/light/vcnl4000.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
index 74d53cfbeb85..fc24800f530a 100644
--- a/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
@@ -25,6 +25,13 @@ properties:
   reg:
     maxItems: 1
 
+  near-level:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Raw proximity values equal or above this level should be
+      considered 'near' to the device (an object is near to the
+      sensor).
+
 required:
   - compatible
   - reg
@@ -40,6 +47,7 @@ examples:
       light-sensor@51 {
               compatible = "vishay,vcnl4200";
               reg = <0x51>;
+              near-level = <220>;
       };
   };
 ...
-- 
2.23.0

