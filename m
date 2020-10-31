Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35E2A19A1
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgJaSbj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSbj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:31:39 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940282072C;
        Sat, 31 Oct 2020 18:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604169098;
        bh=uGcyi0TG6jNWmzUZ6iJtldOhs147do1KNZLZ4N/Bw7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6lGzDeeFYZbALskZ+baatJnp6d1XPMNyhptBSjEPgHmklRXfdDwRQWWHi3PstV5L
         +fdznE/6KAnnAkbzci83utTDRLjBJT/roIbFwgilvg7wZt8gilWHZlF2UzH2pUuF5D
         V/ZCEZB7n4imJKU8bB+6qXTXaPjIp158wmU7EGFA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 5/7] dt-bindings:iio:light:renesas,isl29501: Move to trivial devices.
Date:   Sat, 31 Oct 2020 18:29:20 +0000
Message-Id: <20201031182922.743153-6-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182922.743153-1-jic23@kernel.org>
References: <20201031182922.743153-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This binding is so simple there is no obvious advantage in maintaining
a separate binding doc file for it. As such, move it to trivial-devices.yaml

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/iio/light/renesas,isl29501.txt         | 13 -------------
 .../devicetree/bindings/trivial-devices.yaml        |  2 ++
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt b/Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt
deleted file mode 100644
index 46957997fee3..000000000000
--- a/Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-* ISL29501 Time-of-flight sensor.
-
-Required properties:
-
-  - compatible : should be "renesas,isl29501"
-  - reg : the I2C address of the sensor
-
-Example:
-
-isl29501@57 {
-	compatible = "renesas,isl29501";
-	reg = <0x57>;
-};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 3182d5b5a0b4..015905312a0f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -226,6 +226,8 @@ properties:
           - plx,pex8648
             # Pulsedlight LIDAR range-finding sensor
           - pulsedlight,lidar-lite-v2
+            # Renesas ISL29501 time-of-flight sensor
+          - renesas,isl29501
             # S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
           - samsung,24ad0xd1
             # Sensirion low power multi-pixel gas sensor with I2C interface
-- 
2.28.0

