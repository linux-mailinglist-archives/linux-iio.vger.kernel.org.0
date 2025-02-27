Return-Path: <linux-iio+bounces-16140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B267AA48524
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31086188D7CF
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E84D1B983F;
	Thu, 27 Feb 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="mwaKnHs8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE291B0424
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673734; cv=none; b=ipBqcQclFUKNmlRw1D5oeMFYLJMOPXLwS6e+oFsBPXEcqX2j8k1TYrD5HY7OdkMMXlziDpAYVLXnQTwBaaTQ1xiqF7NC7x/kfaGumgufMMJjVNMgP7UDpk2OoAl5jK1bIMv07Mq/zyWU4RZibY1tzpSzUtyYB9jqpyK9aRLQ2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673734; c=relaxed/simple;
	bh=J/9AlyKf6QeA8EQ6Tq+qlaPzyqFY4XBKkC7Q0CUlhM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBmCkBwV2R/XKVr1SHS02U+p0T4LrHquS3aiMNIRZUPCsIOtxqSZIgdybTv6s5s/8dLqB6uEgdbBfVzBn1i77Xm3RyY9Z2IZFgWGankV1HXPxr0QNfcZJr8e82KVnMmqy8I/41mZGZzBTWFZhJq4oUM3JM3/Ue/tZCvgbrAK5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=mwaKnHs8; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=P9RgmlVt0pqtpNyTVoMT8mhKdFD8tM/crE5krUry5E8=;
	b=mwaKnHs8ToCPKiB2FFZiEBzlYx5NGDpJ1MbxZzkbIgZSeWaWXoCnK8Sh80A+WYX92qUk+ekpKYqxZ
	 8IvLSC2yxIgMFSxkaioOdneehasH1/rDA8uIIHuDHXNzl0QSxHN3tBbwi+VYuTdVcHG47X9BkoKMKM
	 Ddy5vW9rb1o9ANtkxwKsYEs4sOm/aJRuxxAF0l+M4+8zvpkMWcbs2DfznIkEEApqaZgxEPy7YgGWHT
	 zqg8fI7XUIX2rr10f+T3OR1yxmFKFpIZQd4f2y4H7KgIjlHWmzok7WiN70OMCjbOaZdEb54xXKxkMd
	 5CTRYe6c03HymTT09p7qOdSIeXCg1RQ==
X-MSG-ID: ec02b208-f527-11ef-a399-00505681446f
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
Subject: [RFC PATCH 5/7] dt-bindings: motion: Add common motion device properties
Date: Thu, 27 Feb 2025 17:28:21 +0100
Message-ID: <20250227162823.3585810-6-david@protonic.nl>
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

Add device-tree binding documentation for common Linux Motion Control
device properties.

Signed-off-by: David Jander <david@protonic.nl>
---
 .../devicetree/bindings/motion/common.yaml    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/motion/common.yaml

diff --git a/Documentation/devicetree/bindings/motion/common.yaml b/Documentation/devicetree/bindings/motion/common.yaml
new file mode 100644
index 000000000000..e92b360a0698
--- /dev/null
+++ b/Documentation/devicetree/bindings/motion/common.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/motion/common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for motion control devices
+
+maintainers:
+  - David Jander <david@protonic.nl>
+
+description: |
+  This document defines device tree properties common to several motion control
+  devices. It doesn't constitute a device tree binding specification by itself but
+  is meant to be referenced by device tree bindings.
+
+  When referenced from motion device tree bindings the properties defined in this
+  document are defined as follows. The motion device tree bindings are responsible
+  for defining whether each property is required or optional.
+
+properties:
+  motion,speed-conv-mul:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
+    description: |
+      Numerator of a fractional representation of a speed conversion factor.
+      The speed conversion factor (represented by numerator and denominator)
+      is multiplied with the internal speed unit to obtain the physical speed
+      unit of the controller. For example, for a stepper motor controller, the
+      physical speed unit is microsteps/second (Hz).
+
+  motion,speed-conv-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
+    description: |
+      Denominator of fractional representation of a speed conversion factor.
+
+  motion,acceleration-conv-mul:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
+    description: |
+      Numerator of a fractional representation of an acceleration conversion
+      factor.
+
+  motion,acceleration-conv-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
+    description: |
+      Denominator of fractional representation of an acceleration conversion
+      factor.
+
+additionalProperties: true
-- 
2.47.2


