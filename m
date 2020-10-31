Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D634B2A199E
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgJaSbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSbg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:31:36 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3219A20723;
        Sat, 31 Oct 2020 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604169095;
        bh=S+/kNmr/Ho0dwopTRNR3DWGY/LWhcjUUFL/C4x+AMPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHCyIRIwcupQ2GXWe/xc+CIm+SQ6yHFnMR7D+VJUPiCbTEQJg/Ri+yUVXiZIi8Yo9
         4U68zH4ZIo8N62g9j5xKusmJnct0sFGsk6D/Q83r24JmnBP54bUkJGLg+hTQPWlHc9
         ZAQxOqOM+PBYXVVcI/oJvU/r9g7PEaJnAF2CeRJs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 3/7] dt-bindings:iio:potentiometer:maxim,ds1803 move to trivial devices.
Date:   Sat, 31 Oct 2020 18:29:18 +0000
Message-Id: <20201031182922.743153-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182922.743153-1-jic23@kernel.org>
References: <20201031182922.743153-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding where there is no obvious benefit in maintaining a
separate file.  Hence document in trivial-devices.yaml and drop
the txt file.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Slawomir Stepien <sst@poczta.fm>
---
 .../bindings/iio/potentiometer/ds1803.txt     | 21 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  6 ++++++
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt b/Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
deleted file mode 100644
index df77bf552656..000000000000
--- a/Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Maxim Integrated DS1803 digital potentiometer driver
-
-The node for this driver must be a child node of a I2C controller, hence
-all mandatory properties for your controller must be specified. See directory:
-
-        Documentation/devicetree/bindings/i2c
-
-for more details.
-
-Required properties:
-	- compatible:  	Must be one of the following, depending on the
-			model:
-			"maxim,ds1803-010",
-			"maxim,ds1803-050",
-			"maxim,ds1803-100"
-
-Example:
-ds1803: ds1803@1 {
-	reg = <0x28>;
-	compatible = "maxim,ds1803-010";
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 10f0afd44684..695b1e379238 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -110,6 +110,12 @@ properties:
           - isil,isl68137
             # 5 Bit Programmable, Pulse-Width Modulator
           - maxim,ds1050
+            # 10 kOhm digital potentiometer with I2C interface
+          - maxim,ds1803-010
+            # 50 kOhm digital potentiometer with I2C interface
+          - maxim,ds1803-050
+            # 100 kOhm digital potentiometer with I2C interface
+          - maxim,ds1803-100
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
           - maxim,max1237
             # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
-- 
2.28.0

