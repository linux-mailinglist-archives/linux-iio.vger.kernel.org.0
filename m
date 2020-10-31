Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B22A199F
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgJaSbi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSbh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:31:37 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BE9206E5;
        Sat, 31 Oct 2020 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604169097;
        bh=njRV/xbty5XX+bMrv4J0ryswpYSLyvWQAp3BZTs0XPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZ5NeD8x3evSbC69M4hUjPrAjL1yVxgjdK3Y28e8kBXM1F5J2yKk4tj423LivVmTb
         jvFjDe7L/jTIj2ei8I6Upy+nPziqc58mS4gmw/TD7+nGkNuZWEeetaLkOXm7J3mBRM
         DDxOdFLH+ceFg7BzuZJRP6f8g6ttMeTT9t0STUgA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maury Anderson <maury.anderson@rockwellcollins.com>,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 4/7] dt-bindings:iio:potentiometer:maxim,max5481 move to trivial devices
Date:   Sat, 31 Oct 2020 18:29:19 +0000
Message-Id: <20201031182922.743153-5-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182922.743153-1-jic23@kernel.org>
References: <20201031182922.743153-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple SPI binding that doesn't need a separate file.
During conversion I looked up the individual part number descriptions
in the datasheet so that we could give slightly more detail in
trivial-device.yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Maury Anderson <maury.anderson@rockwellcollins.com>
Cc: Matthew Weber <matthew.weber@rockwellcollins.com>
Cc: Slawomir Stepien <sst@poczta.fm>
---
 .../bindings/iio/potentiometer/max5481.txt    | 23 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  8 +++++++
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt b/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
deleted file mode 100644
index 6a91b106e076..000000000000
--- a/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Maxim Linear-Taper Digital Potentiometer MAX5481-MAX5484
-
-The node for this driver must be a child node of a SPI controller, hence
-all mandatory properties described in
-
-        Documentation/devicetree/bindings/spi/spi-bus.txt
-
-must be specified.
-
-Required properties:
-	- compatible:  	Must be one of the following, depending on the
-			model:
-			"maxim,max5481"
-			"maxim,max5482"
-			"maxim,max5483"
-			"maxim,max5484"
-
-Example:
-max548x: max548x@0 {
-	compatible = "maxim,max5482";
-	spi-max-frequency = <7000000>;
-	reg = <0>; /* chip-select */
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 695b1e379238..3182d5b5a0b4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -118,6 +118,14 @@ properties:
           - maxim,ds1803-100
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
           - maxim,max1237
+            # 10-bit 10 kOhm linear programable voltage divider
+          - maxim,max5481
+            # 10-bit 50 kOhm linear programable voltage divider
+          - maxim,max5482
+            # 10-bit 10 kOhm linear programable variable resistor
+          - maxim,max5483
+            # 10-bit 50 kOhm linear programable variable resistor
+          - maxim,max5484
             # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
           - maxim,max6621
             # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
-- 
2.28.0

