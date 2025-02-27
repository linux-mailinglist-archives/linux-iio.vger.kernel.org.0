Return-Path: <linux-iio+bounces-16139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16568A4850C
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 17:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421913AAFC3
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006A71B85D1;
	Thu, 27 Feb 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="cM/dQPBY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE41B042D
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673734; cv=none; b=ULtvFlfXZrKOama6owksLWScfi6G7+Zn5oBdvKBu7X+SWgRd5zBfMT+aQLjK9F00RpsetM87ixmWxTZLmBa6DmzcRfluHKo3DM6rfz1yTMwTrdfmRd3FBo/0zzvn8j0D3wXbzLertMVNNDyIFSiXjVqGlwjUXccpWOFxucdrcsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673734; c=relaxed/simple;
	bh=udAh7uDuLY+cGyax5YTE+YVj8sAyIac+90OuDug+grE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckZr37u6Vz2NdkpaGS8qTMxn0guf0rHFYHuAYjKVq9nwZ6xeA2kN4fYxRK+BzHKk2xhWp+AJvyFljx7Pfqq9SAjuMI3IvznLVjf/O4W4QDB4BGtlEz7b9JUo6QtEsBMq2jy6J2Qatlx4Gb7gktoS3SUr3VfVfYO5lFDIJGMbpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=cM/dQPBY; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=s5vthmxohoyHnfh+ogQVgGD+RRR49Exo+/K1z/i8mW4=;
	b=cM/dQPBYG0QIsB0KC7lBK1gMYT84ULTFE88W3UC02Cvp7EK4fp29j7NUZmzhO3XClWlmS9Txm7P7M
	 mpzfescQd3S9WcBw7SNPYNLot8dvgQoYl4bJgYcqo+MDWGKaSaoQpr340oDsV7AXULUFQb3//hgzln
	 FavsXmbuRU0mitvKTTmNxscp6ErYpGVphXH0eavBv9GxOrSz7nEFWEMeFAJ6lW4oCcR9gXQOD8bBrL
	 kSaFwMcm8LFOgzzRC0hrsL22Cs56c7QFq0OVUBpz8406DXInHXCJWHC+zZj+0eCrT8E8olRCtSagtk
	 aHU5Nni7ZDEgpq7lE0ZNuWL8ZSshF6Q==
X-MSG-ID: ed44f6a5-f527-11ef-a399-00505681446f
From: David Jander <david@protonic.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	David Jander <david@protonic.nl>
Subject: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm bindings
Date: Thu, 27 Feb 2025 17:28:23 +0100
Message-ID: <20250227162823.3585810-8-david@protonic.nl>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227162823.3585810-1-david@protonic.nl>
References: <20250227162823.3585810-1-david@protonic.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device-tree bindings for simple Linux Motion Control devices that
are based on 1 or 2 PWM outputs.

Signed-off-by: David Jander <david@protonic.nl>
---
 .../bindings/motion/motion-simple-pwm.yaml    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml

diff --git a/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml b/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
new file mode 100644
index 000000000000..409e3aef6f3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/motion/motion-simple-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple PWM based motor controller
+
+maintainers:
+  - David Jander <david@protonic>
+
+description: |
+   Simple motor control device based on 1 or 2 PWM outputs
+
+properties:
+  compatible:
+    enum:
+      - motion-simple-pwm
+
+  pwms:
+    maxItems: 2
+
+  pwm-names:
+    maxItems: 2
+
+  motion,pwm-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present, this flag indicates that the PWM signal should be inverted.
+      The duty-cycle will be scaled from 100% down to 0% instead 0% to 100%.
+
+required:
+  - compatible
+  - pwms
+
+allOf:
+  - $ref: /schemas/motion/common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // This example shows how to use the TI DRV8873 or similar motor controllers
+    // with this driver
+    motion-simple-pwm0 {
+      compatible = "motion-simple-pwm";
+      pwms = <&hpdcm0_pwm 0 50000 0>,
+             <&hpdcm0_pwm 1 50000 0>;
+      pwm-names = "left", "right";
+      motion,pwm-inverted;
+      motion,speed-conv-mul = <3600>;
+      motion,speed-conv-div = <100000>;
+      motion,acceleration-conv-mul = <3600>;
+      motion,acceleration-conv-div = <100000>;
+    };
-- 
2.47.2


