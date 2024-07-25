Return-Path: <linux-iio+bounces-7889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCF93C6A3
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 17:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45611C222C8
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018D19D8B3;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI1EcAkW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B019D890;
	Thu, 25 Jul 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921967; cv=none; b=SfdVuXPOxGE1l31fkflXXhiUL8MrUV0q1PxtYM0VuQwLQIUWHrb4ZEthNM4/PQ0WqdoxIX7QQIp8hxROeoacUWffqmU8T5sHW6YDYRHwL9o+8Mmhzb268g5k0CmaJbgegFZjUf+TDpZ6Qoqw82Gwh/FV6+ZWa3F5wpjAlc4/va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921967; c=relaxed/simple;
	bh=/wBRLebwG31hM1unaHmj6E0Gz+snstWvcgj51ocAYQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KeneB+AT3/SwM/hHftmc3vklOj+Dh1FwShGE4jfpljyjtMGipacs8UUop5AIVELDYPvaUiDJXi+m3QlE6a9vdGqH7HyL13cbIXTILaBeanXkklT/zahbPHiMSsaP/pjCoSjl4e3kwc/TEUWwiW+rNKaC1YetbEsLsGA+CY9TwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI1EcAkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9743C4AF07;
	Thu, 25 Jul 2024 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921967;
	bh=/wBRLebwG31hM1unaHmj6E0Gz+snstWvcgj51ocAYQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rI1EcAkW8BZQLVLZ5HmeYdGozf4DmtfoiOSKKVuOKy91OQ7+/2TvnS3R8OgRQ1MGT
	 DxEZl3zeVL9ix76LAMzbzeMPkTXdbKPO/678s3K05cQJvTtIuL729OsO4V9wpXKJ3u
	 q3wtdUgSqylLcCcCx1bRf1/m+TWzrsCD9m10+FfWiOoAt+ok6VpSJ6pXP6EfPuTx7e
	 bWlSQNym1eK8f42D7Jq2CONKYQqo9rqU3tmhLRDgLpmAoGfALx9zcItvEQRNzd7lbE
	 1WObtXtHXIO36RBNC1AL2t2uYFR1rO3ayuABu18nkfGdGtAa47IUxwjTFLyAThWFJ/
	 1Ux03I9py/v2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E80C3DA5D;
	Thu, 25 Jul 2024 15:39:26 +0000 (UTC)
From: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Date: Thu, 25 Jul 2024 17:37:27 +0200
Subject: [PATCH v4 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-mainline_sdp500-v4-1-ea2f5b189958@gmail.com>
References: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
In-Reply-To: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petar Stoykov <pd.pstoykov@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721921965; l=1741;
 i=pd.pstoykov@gmail.com; s=20240702; h=from:subject:message-id;
 bh=cENh+/xF32OA/T3EWLu9J0STlExFqa0Gg1TOizqGn2k=;
 b=iI57uw6+stMrgYDIPBqiB1P+4gMO6pVCpRLFNu1ExAf2Bkqauqioz+oInk5S+HHU1OBm/rBvx
 zCNSdyhzfhLBrTqnqnfTr2VV1m1dAtsggXiOLy1xgHVdAEAMbIAS+th
X-Developer-Key: i=pd.pstoykov@gmail.com; a=ed25519;
 pk=oxcGqcVV5O6wqlTh+39SbOwfbpD763i5x4TavUAHiCg=
X-Endpoint-Received: by B4 Relay for pd.pstoykov@gmail.com/20240702 with
 auth_id=179
X-Original-From: Petar Stoykov <pd.pstoykov@gmail.com>
Reply-To: pd.pstoykov@gmail.com

From: Petar Stoykov <pd.pstoykov@gmail.com>

Sensirion SDP500 is a digital differential pressure sensor. It provides
a digital I2C output. Add devicetree bindings requiring the compatible
string and I2C slave address (reg).

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
 .../bindings/iio/pressure/sensirion,sdp500.yaml    | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
new file mode 100644
index 000000000000..813239f6879a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/sensirion,sdp500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: sdp500/sdp510 pressure sensor with I2C bus interface
+
+maintainers:
+  - Petar Stoykov <petar.stoykov@prodrive-technologies.com>
+
+description: |
+  Pressure sensor from Sensirion with I2C bus interface.
+  There is no software difference between sdp500 and sdp510.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: sensirion,sdp510
+          - const: sensirion,sdp500
+      - const: sensirion,sdp500
+
+  reg:
+    maxItems: 1
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pressure@40 {
+        compatible = "sensirion,sdp500";
+        reg = <0x40>;
+        vdd-supply = <&foo>;
+      };
+    };

-- 
2.39.2



