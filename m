Return-Path: <linux-iio+bounces-7138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19A92419F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AFA28261C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E061BB684;
	Tue,  2 Jul 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEVeuHSF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5E19AD86;
	Tue,  2 Jul 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932378; cv=none; b=Q2hynMNh/NVEbkmdljo5ez4TvpoEe/i2IfFRf+V8XzxFlOki9OaVv/vjbjKvTIHcIvpGKwrc4g38/wM/HZskClH9oACoXc4jmZnNfUNlgAZYPMe/MDqXinMN0LLhlQ9AfgRAcIFyByP+UIuwmERKHGq0OSOOMGfwH9tMKNgN1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932378; c=relaxed/simple;
	bh=dkorTy+58bfVEvufEZFta/WzQHU8n3qeeuk5Klash3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AsOkKojestUY5Yk6+7wOdQ0n9YZlfjqA8BmDo0MkLb6m9alSr72ZD3XJSRcxtbNiXwhxdp7Re5Jusf561sB5l+WaAMj/GCA0GejodyiWdWLV7qgI+UgqwPw55bXo71abOGu8zm9zeVB0ysTQ829ww+3ZiJpYVQ+5sVU1PwTqito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEVeuHSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8BA7C2BD10;
	Tue,  2 Jul 2024 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932378;
	bh=dkorTy+58bfVEvufEZFta/WzQHU8n3qeeuk5Klash3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IEVeuHSFAEVE79RMUngIHRvjqSSp9pFsgm6RikxEgKz4GDpl365SyAtaEfMmj5aRf
	 vmPdtWIanhST1wYwUFkZmz/IhTo9M/CZYnkmmegtZC5CYK5juUebehPjr2n0PXlSOi
	 Z9JVL0+MHFMI0r5iGY9yfWCuQ1IzPSirSrao20OeS6dlUepAUXY6rwOUGvdG/UMzf6
	 RD846mhd1G0oKEbTA0hdUszt1v0TmfLbgfDeJI0B6vOOiRNzvTWSKo30EAjMyoP7b4
	 P/XW9zEuWYfRLDbLpB5Znw6/gnEny6490r34KPcj3DzxJZ3Zagn5ovyBlM3o2w1Ta5
	 LWeyItFhisZqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEDC30658;
	Tue,  2 Jul 2024 14:59:37 +0000 (UTC)
From: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Date: Tue, 02 Jul 2024 16:59:08 +0200
Subject: [PATCH v3 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com>
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
In-Reply-To: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petar Stoykov <pd.pstoykov@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719932376; l=1616;
 i=pd.pstoykov@gmail.com; s=20240702; h=from:subject:message-id;
 bh=co7y2IA3A8lUnRV2yOyd68cdyraGpDiPDlleT9qTLEs=;
 b=OdN36Pkms9PAOJLXPbrQ9jHayJKTbixUhL6AwCVekRyssELGGFA2KesB50+m15TS0231TbyYz
 Nr/uKxvNgMqDj7iSHDCNUnbk5PKXaIaoU33ZgVIQanvebgrM2nWFefB
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
 .../bindings/iio/pressure/sensirion,sdp500.yaml    | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
new file mode 100644
index 000000000000..6b3e54def367
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#
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
+    enum:
+      - sensirion,sdp500
+      - sensirion,sdp510
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
+      pressure@40 {
+        compatible = "sensirion,sdp500";
+        reg = <0x40>;
+        vdd-supply = <&foo>;
+      };
+    };

-- 
2.39.2



