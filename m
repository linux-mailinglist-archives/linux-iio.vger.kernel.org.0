Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D584319EBA8
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgDENul (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 09:50:41 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44798 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgDENul (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 09:50:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7A411FB02;
        Sun,  5 Apr 2020 15:50:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j5w2Lyh6w43K; Sun,  5 Apr 2020 15:50:34 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 01863414D8; Sun,  5 Apr 2020 15:50:32 +0200 (CEST)
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
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v4 2/5] dt-bindings: iio: Introduce common properties for iio sensors
Date:   Sun,  5 Apr 2020 15:50:29 +0200
Message-Id: <8b91f0b7fa76ca4b2f3cdc251411829f71f8d810.1586094535.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1586094535.git.agx@sigxcpu.org>
References: <cover.1586094535.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce a file for common properties of iio sensors. So far this
contains the new proximity-near-level property for proximity sensors
that indicates when an object should be considered near.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../devicetree/bindings/iio/common.yaml       | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/common.yaml

diff --git a/Documentation/devicetree/bindings/iio/common.yaml b/Documentation/devicetree/bindings/iio/common.yaml
new file mode 100644
index 000000000000..97ffcb77043d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/common.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for iio sensors
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+  - Guido Günther <agx@sigxcpu.org>
+
+description: |
+  This document defines device tree properties common to several iio
+  sensors. It doesn't constitue a device tree binding specification by itself but
+  is meant to be referenced by device tree bindings.
+
+  When referenced from sensor tree bindings the properties defined in this
+  document are defined as follows. The sensor tree bindings are responsible for
+  defining whether each property is required or optional.
+
+properties:
+  proximity-near-level:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      For proximity sensors whether an object can be considered near to the
+      device depends on parameters like sensor position, covering glass and
+      aperture. This value gives an indication to userspace for which
+      sensor readings this is the case.
+
+      Raw proximity values equal or above this level should be
+      considered 'near' to the device (an object is near to the
+      sensor).
+
+...
-- 
2.23.0

