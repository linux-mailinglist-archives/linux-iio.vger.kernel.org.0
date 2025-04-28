Return-Path: <linux-iio+bounces-18767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44EEA9EE57
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D19E17CCBB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A52262FC8;
	Mon, 28 Apr 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqtYcUy4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC631FC114;
	Mon, 28 Apr 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837434; cv=none; b=fxCidEKQLs0Kah7mETpmHtTanER6qqhsyhkmBd8B/vmRwIPK0+n35lGqncnUiU69gSWpBZXS6QecV/oLK1fj/8l3Pn4bMgPjX8PdsxaHYbMxL1Vb8bDTHCPNQFbxt7d59u4zKLEQdoP5yGY2CwptOdBcF99wS7ixazkaBpYg8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837434; c=relaxed/simple;
	bh=twpXuJB+cfsFJsY8tYMM4GKFf3+aZHniWnw6MjKaaZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFHJLMi7LcuKxgAokgQz+EHpB2u8rzn0JapWaNoayGBggaxjaPuOYeIGORoCSccqnITMhJRcdd+oIRk81rpQpa6oeFen2/o3VWbwPHOv1n2U0rKUncSS8soIFpWcY3tMfRHhd35BhahsA0eHxTq+HURkJ6baM/8E5FglNUmI0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqtYcUy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3384CC4CEED;
	Mon, 28 Apr 2025 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745837434;
	bh=twpXuJB+cfsFJsY8tYMM4GKFf3+aZHniWnw6MjKaaZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LqtYcUy4XKAvpzevlWJ5xkiFSoKl/VZsh4R0OLp7dk+IkLUJ/wDfI2JJ09Vy1Mwa5
	 wAMz+kKfHB8BS7ToUUY0Eo/1t/oCRMt4JgFSnDuN/3TXJ0K7ULqENsAamtpPiGntQX
	 bEkF/Dl/mEa3rXDTjS+3w22buNUBT8bDYfTKlSqxCjErHx9yk9LddTC0FSPt/I+MCu
	 l0nDzrMa/DksHKS/SJY0Hio/jJbN0PqyNmUvaN8c8dFfczG0E/mOZfreU/m5lvPeOu
	 3q6vbmrOGmPw2eGnYBrFl4NaxdoTxTr6U4hBx45QCH1Xv2VNMXIZShNDfZKryk6jGs
	 ecIRkPP7YT9CA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224F1C369D3;
	Mon, 28 Apr 2025 10:50:34 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Date: Mon, 28 Apr 2025 12:50:13 +0200
Subject: [PATCH 1/2] dt-bindings: iio: chemical: Document SEN0322
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-iio-chemical-sen0322-v1-1-9b18363ffe42@gmail.com>
References: <20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com>
In-Reply-To: <20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745837432; l=1418;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=0xoZK3utDzrQmadpl8iAFzEdDReFTnsvqPVnBKUfQhE=;
 b=gcjxH5FV6xoBddG8KX8yGpC+BYXKxA+r2MBnFPA0kEZ0bO/lhMjI2cyKcg286Is61lO2TMqLN
 yFi3gDFnqn3CG0ZtmO2pXR7YJqgdXtJL4qMWZEIj6POgdLliYXegYRd
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with
 auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: gomba007@gmail.com

From: Tóth János <gomba007@gmail.com>

Add documentation for the DFRobot SEN0322 oxygen sensor.

Signed-off-by: Tóth János <gomba007@gmail.com>
---
 .../bindings/iio/chemical/dfrobot,sen0322.yaml     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/chemical/dfrobot,sen0322.yaml b/Documentation/devicetree/bindings/iio/chemical/dfrobot,sen0322.yaml
new file mode 100644
index 000000000000..9410d04fb91d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/dfrobot,sen0322.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/dfrobot,sen0322.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DFRobot SEN0322 oxygen sensor
+
+maintainers:
+  - Tóth János <gomba007@gmail.com>
+
+description: >
+  DFRobot SEN0322 is an oxygen sensor. It supports I2C for communication.
+
+  Datasheet:
+    https://wiki.dfrobot.com/Gravity_I2C_Oxygen_Sensor_SKU_SEN0322
+
+properties:
+  compatible:
+    const: dfrobot,sen0322
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sen0322@73 {
+        compatible = "dfrobot,sen0322";
+        reg = <0x73>;
+      };
+    };

-- 
2.34.1



