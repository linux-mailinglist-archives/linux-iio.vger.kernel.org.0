Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7EB2A19A5
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgJaSbm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSbm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:31:42 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E06220739;
        Sat, 31 Oct 2020 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604169101;
        bh=n2+ZW3AwcEhm5TUqzArYrmmuod7diIgJmvvLHMPcKpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4GpLGhgI/t/iqIpFZJnyqSF+eBXVKGX10jHcLsf3MfRuBHK7Mu3A3UqhN/voP7Eq
         uz0F08DRymAF7Nbs85VrquebGAG4QGOoe0Tj9DBk1vzkgebX5XswfRG4VCuqUVWcTD
         1JKp2gQfGRHDv5mwB86NB4vlReaEve8rxu02G4pE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/7] dt-bindings:iio:accel:domintech,dmard06: Move to trivial-devices.yaml
Date:   Sat, 31 Oct 2020 18:29:22 +0000
Message-Id: <20201031182922.743153-8-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182922.743153-1-jic23@kernel.org>
References: <20201031182922.743153-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

No need to maintain a separate document for such a simple binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/accel/dmard06.txt | 19 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  6 ++++++
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/dmard06.txt b/Documentation/devicetree/bindings/iio/accel/dmard06.txt
deleted file mode 100644
index ce105a12c645..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/dmard06.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Device tree bindings for Domintech DMARD05, DMARD06, DMARD07 accelerometers
-
-Required properties:
- - compatible		: Should be "domintech,dmard05"
-				 or "domintech,dmard06"
-				 or "domintech,dmard07"
- - reg			: I2C address of the chip. Should be 0x1c
-
-Example:
-	&i2c1 {
-		/* ... */
-
-		accelerometer@1c {
-			compatible = "domintech,dmard06";
-			reg = <0x1c>;
-		};
-
-		/* ... */
-	};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 172bf7e19401..91a101ef03fb 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -72,6 +72,12 @@ properties:
           - dlg,da9053
             # DA9063: system PMIC for quad-core application processors
           - dlg,da9063
+            # DMARD05: 3-axis I2C Accelerometer
+          - domintech,dmard05
+            # DMARD06: 3-axis I2C Accelerometer
+          - domintech,dmard06
+            # DMARD05: 3-axis I2C Accelerometer
+          - domintech,dmard07
             # DMARD09: 3-axis Accelerometer
           - domintech,dmard09
             # DMARD10: 3-axis Accelerometer
-- 
2.28.0

