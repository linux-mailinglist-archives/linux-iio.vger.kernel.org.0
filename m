Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3722B38D59F
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 13:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhEVLbd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 07:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhEVLbc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 07:31:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7641E61182;
        Sat, 22 May 2021 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621683008;
        bh=VjGQuEiapZYkKNw9zeTWvdwTY/b9SyGcoE+nuNs40jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rb2VuzZpCCOGVusvoIMkOcguJs6helugHMXo0UUjbLaXL3q617bImfAqTDFoXooQj
         Ib9ODnJguxGw4HQYEMkHkp9g8XUVenbxLz9x5N0CXUHjBNYQ5IqO3la/nKGcSh4F7j
         Gkle/Gp2INgBFL7zOrHGIv/1wY60aAPT8wtSpFxpqFdFLVjjnAMW9u/gdFZiW8qyLN
         lwai+HfS9MLJ3cShfiPQOKGB0tYdrOsdRf61RkvlmOmXwJ3bbzKKSpk2tPuC8hbB3u
         znmX5zkrIslVahUTfX+Hv1O9uCzVe+wMx4fdm2o5+ZfSu8HuykmIk3r56cWnnvvjPh
         UMRWPj/Ws1jww==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Peter Rosin <peda@axentia.se>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/1] dt-bindings: iio: multiplexer: Convert io-channel-mux bindings to DT schema
Date:   Sat, 22 May 2021 12:29:07 +0100
Message-Id: <20210522112908.1611389-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522112908.1611389-1-jic23@kernel.org>
References: <20210522112908.1611389-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight conversion of the txt file using the mux-consumer.yaml
binding now that is available.

Dropped address-cells and size-cells because there are
not child nodes.  Also added mux-control-names as an optional parameter.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: Rob Herring <robh@kernel.org>
---
 .../iio/multiplexer/io-channel-mux.txt        | 39 ----------
 .../iio/multiplexer/io-channel-mux.yaml       | 71 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 72 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
deleted file mode 100644
index d2b3105dba67..000000000000
--- a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-I/O channel multiplexer bindings
-
-If a multiplexer is used to select which hardware signal is fed to
-e.g. an ADC channel, these bindings describe that situation.
-
-Required properties:
-- compatible : "io-channel-mux"
-- io-channels : Channel node of the parent channel that has multiplexed
-		input.
-- io-channel-names : Should be "parent".
-- #address-cells = <1>;
-- #size-cells = <0>;
-- mux-controls : Mux controller node to use for operating the mux
-- channels : List of strings, labeling the mux controller states.
-
-For each non-empty string in the channels property, an io-channel will
-be created. The number of this io-channel is the same as the index into
-the list of strings in the channels property, and also matches the mux
-controller state. The mux controller state is described in
-../mux/mux-controller.yaml
-
-Example:
-	mux: mux-controller {
-		compatible = "gpio-mux";
-		#mux-control-cells = <0>;
-
-		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
-			    <&pioA 1 GPIO_ACTIVE_HIGH>;
-	};
-
-	adc-mux {
-		compatible = "io-channel-mux";
-		io-channels = <&adc 0>;
-		io-channel-names = "parent";
-
-		mux-controls = <&mux>;
-
-		channels = "sync", "in", "system-regulator";
-	};
diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
new file mode 100644
index 000000000000..37382b85f2b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/multiplexer/io-channel-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I/O channel multiplexer bindings
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+description: |
+  If a multiplexer is used to select which hardware signal is fed to
+  e.g. an ADC channel, these bindings describe that situation.
+
+  For each non-empty string in the channels property, an io-channel will be
+  created. The number of this io-channel is the same as the index into the list
+  of strings in the channels property, and also matches the mux controller
+  state. The mux controller state is described in
+  Documentation/device-tree/bindings/mux/mux-controller.yaml
+
+properties:
+
+  compatible:
+    const: "io-channel-mux"
+
+  io-channels:
+    maxItems: 1
+    description: Channel node of the parent channel that has multiplexed input.
+
+  io-channel-names:
+    const: "parent"
+
+  mux-controls:
+    $ref: "../../mux/mux-consumer.yaml"
+  mux-control-names: true
+
+  channels:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      List of strings, labeling the mux controller states.
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+  - mux-controls
+  - channels
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    mux: mux-controller {
+      compatible = "gpio-mux";
+      #mux-control-cells = <0>;
+
+      mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+                  <&pioA 1 GPIO_ACTIVE_HIGH>;
+    };
+
+    adc-mux {
+      compatible = "io-channel-mux";
+      io-channels = <&adc 0>;
+      io-channel-names = "parent";
+
+      mux-controls = <&mux>;
+      channels = "sync", "in", "system-regulator";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fc771d2aacef..eba1687688a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8858,7 +8858,7 @@ IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
+F:	Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
 F:	drivers/iio/multiplexer/iio-mux.c
 
 IIO SCMI BASED DRIVER
-- 
2.31.1

