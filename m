Return-Path: <linux-iio+bounces-5341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E048D05E3
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BE928BD48
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AB15EFD3;
	Mon, 27 May 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5sLHUNo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36115A874;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822730; cv=none; b=JqmTyxapiMbuGJBSiv7rgrozu0QyISv6kHiYucEEbRS+kFkQCiaUCdRU8QUsLAsj6B+D9uHApAzaQisIm/ZMWW4043A5etwXmHz4RIKiuddlrlZdRy4TsdUV8qDSjZ4r+Ylo3Ug8dD/zi0LyxXqj2TYM1NYKu8/zNpYi5aPZQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822730; c=relaxed/simple;
	bh=GC9XwJrAOyXHE+HoaYDJfgAuuuYZrjvZbTpFwyHEE3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s8N/ut7L4oDT8fFVzQpcRKEaCOHVnOdVKlzb4+2m1vjaykrITyp3RkBx3YqALOxG/szo84qECmG15vCKDSClMejeRUpr3LB6uyBPToMw/VBd0mIV4jgm1rieV6fLlNc6p1w188gmKQBcYPx8+QiYRKMsIKk/a9C3ZGFMPjpHXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5sLHUNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E821C32789;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716822730;
	bh=GC9XwJrAOyXHE+HoaYDJfgAuuuYZrjvZbTpFwyHEE3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r5sLHUNo2y0BWPiPJp+UKv7TZYhiWWQUaWa3UY1uMsYIIt0XQDRUVN05nirFTKcKi
	 AGooTeABUWelhtPGEsg6ZlWJDvp4wF+QaqKeOq6eCV0ykun99OBFsQaL5fiHVhac5B
	 bQe8JbfWFhJvtcgMjr20pgZ53VW6vPl/g7DtatoYprAii/PMFqbaP/NbstPidqWDUL
	 7iBe9qDiw+l5T4nsTqNo64Ssa9c1+IxyOEuMm5f4Rbmcdk5J8PAfYCW3XKs2ZQVaba
	 Mr5c+VcAlHoK0gh1zW2Ysq60xM0yT4BoBaJSKf90Fd8TLHDT1IJkBvh3O1rOc15E7l
	 XYRDicSnFiN+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA47C27C42;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
From: Arthur Becker via B4 Relay <devnull+arthur.becker.sentec.com@kernel.org>
Date: Mon, 27 May 2024 17:12:09 +0200
Subject: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS
 bindings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
In-Reply-To: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Arthur Becker <arthur.becker@sentec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716822728; l=1571;
 i=arthur.becker@sentec.com; s=20240521; h=from:subject:message-id;
 bh=u0p4w65fUlznIRwbLv+oCbf01W5aOcq+erfwbBRKE9w=;
 b=zCjYc68+a0u7/fUR6r+IMPoQXLqxz9nMLelPqjfSZeibSwRIsayNYpLVecj3SxZ04uGnDNdds
 xHdNaM8x2ouCb9AywBmXkiBFbEgqbcvrUAYlYgiCst0uUGksoXqr+92
X-Developer-Key: i=arthur.becker@sentec.com; a=ed25519;
 pk=1GLsDBF6GZKt9oNFsvdnAB6sHyKKrSISlwM3AyWbx/k=
X-Endpoint-Received: by B4 Relay for arthur.becker@sentec.com/20240521 with
 auth_id=163
X-Original-From: Arthur Becker <arthur.becker@sentec.com>
Reply-To: arthur.becker@sentec.com

From: Arthur Becker <arthur.becker@sentec.com>

Device tree bindings for the vishay VEML6040 RGBW light sensor iio
driver

Signed-off-by: Arthur Becker <arthur.becker@sentec.com>
---
V1 -> V3: Addressed review comments (v1 of the dt-bindings was sent
along with v2 of the driver but not in a set)
---
 .../bindings/iio/light/vishay,veml6040.yaml        | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6040.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6040.yaml
new file mode 100644
index 000000000000..101c2cc6506e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6040.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/vishay,veml6040.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VEML6040 RGBW Light Sensor
+
+maintainers:
+  - Arthur Becker <arthur.becker@sentec.com>
+
+description:
+  Datasheet at https://www.vishay.com/docs/84276/veml6040.pdf
+
+properties:
+  compatible:
+    const: vishay,veml6040
+
+  reg:
+    enum:
+      - 0x10
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@10 {
+            compatible = "vishay,veml6040";
+            reg = <0x10>;
+            vdd-supply = <&vdd_reg>;
+        };
+    };
+...

-- 
2.34.1



