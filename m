Return-Path: <linux-iio+bounces-10753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 215899A4A29
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 01:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB8B22C18
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 23:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0591922ED;
	Fri, 18 Oct 2024 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="DjoInp1p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+/vzWEg"
X-Original-To: linux-iio@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E8191F7A;
	Fri, 18 Oct 2024 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294718; cv=none; b=D7p9F9ZxWE6GrCFCLwLN6kjvoDpwuQCpYIDwa83VSPLppZPjp52pOis/NbMDwbEd6eOgMAQpGEttSllhWeDHEyCYqvIEzpow0IbnBpIB7ZrpwBT5+p2R6A2sbbIWXNIjciXnSN4Y7yg5UofxVBNzTvsmajbSFm5IIqqf0cUg4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294718; c=relaxed/simple;
	bh=/W9FGWS2rn2hVxrPOJYydbV38Tzx81yvg95cOMZh0KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdNs5diFzpdPUveAnIP4bDdV/U63mhlCZbj/jF1ZOT30HISBrNaD31Kbk4ZLrVkl2KAhdRMTPxHddmuBqiUJN/PHeA1EBqdUytdJNJM2kWPemasWQVR+j7Pfgw2TFMi+TXxbRPkxhEXk4Ze3K0G/BHJXfLUaTuOu9sHL9FS3vi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=DjoInp1p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+/vzWEg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0ACB61140193;
	Fri, 18 Oct 2024 19:38:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 18 Oct 2024 19:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729294715; x=
	1729381115; bh=oa9cgVMycUuHRIX2mC52gb2eRMUx9qVL+xj6GNcI2Jw=; b=D
	joInp1pzYZxGFEPQ2Rlnwbm/i/6m8BhPM2der/Zd8QQV056YZ+zefJos2hye3VvG
	GEIokk8XN56/xzM5XqxKe8sUTsPFuOEDpcgLO2rg7BxJUlVhPvLOwmuunNNGqpEC
	71rTC9ZVDnQEinRDNVgNs0rxQoBnFQvvealwOQXKNb4ImAXInWVQq9NHCWxM8Dse
	gj4BAx7NZo26Y6Z+k0RNioLw3Uw4SHvAxdTa9+KuusJUYJH9aKqgnkyrq49rDJ6S
	I8AqQ7GMjfN4wgTJ5Aih5f5cbwB5eP6L5VF/fdiQIgUpQbIKAkmbh3+VkzLBBvJ/
	orinX3DtIfWrHQsOlEpKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729294715; x=
	1729381115; bh=oa9cgVMycUuHRIX2mC52gb2eRMUx9qVL+xj6GNcI2Jw=; b=U
	+/vzWEgGTxVIy+Gh/6iN/abYhdm1ucR4mPd2XYdvsy1dYCNF3K77ZsrYZMSrxS3I
	AS/5sVtjN6/2TVdr6+pbMI57Pd4KbrDTHYKJaa4mgE4ZpMaVwZ6JQkqMPCGOt55N
	/7nM6ihLDrZnszPdJamUm7LiZ39XX1IzjzAIcU6pf83buYdIM6e99dBnnIKrTz06
	TzRISHSxWXWdR/gZJv/mFs6Qqa/yTOuSkoiWLdGrI6qHORyTbMhZIPu0nepGCltA
	ojzUY5Ow/wfjYByauOmNA3n7bKo3KOpbfNS6TV1RgVz6CubQ3LD4PDh9si/39ULr
	CoE19VIqkXB0H8sKB3eFg==
X-ME-Sender: <xms:evESZ1Lkn-prIrBOA_ld9bUNGjTvxntcinafNAZp2lJc994ArHFhlg>
    <xme:evESZxL_w2y57cnFu2a8rOlb-q_LRYZfQ23jTuvuaEvT7OfxvStKt_t4C6DQYkSUf
    HuAAUtcd7FoG7GZrw>
X-ME-Received: <xmr:evESZ9selh662s2ehb1hmamAsKGryMcZmICE3XB2p24Zt3ci2pDgkafRVMvLnjFqfpTzz57OKRmjscHmGISRPQWnzrfmA1VRfRtkiqu_Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeltdelfefgleetjeeuteehudejledt
    gedujeeutdeuledtgeejvdehhfeileegtdenucffohhmrghinhepuggvvhhitggvthhrvg
    gvrdhorhhgpdgsohhstghhqdhsvghnshhorhhtvggtrdgtohhmnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhushhtihhnsehjuhhsthhinh
    ifvghishhsrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhgrnhiirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhhssehmvght
    rghfohhordguvgdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomhdprhgtphhtthhopehlihhnuhigqdhiihhosehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:evESZ2ZRa4Z4NuX-juC_6Uie0Y_8dAYPT1vcvvNnVrLXf2G4IyMiNg>
    <xmx:evESZ8YQH2EMsEOnccC8pRRtUk2OHFXA7UkcWKwsbtjQ-9omtjTrzA>
    <xmx:evESZ6Ckuu7Rh3NH8uVAlXNXK8de7C1NdxnsZ_ABTFoBMMmOG1qtUw>
    <xmx:evESZ6ZpfUvtLBVhYRLva_qsHmDj5-lE0Dlcr4xto5YzhbXGCKvK_g>
    <xmx:e_ESZ4Qfj-siTNM3rREaiH46yY9IbPq3ikRSs-CHaJ3oyvex2tqmyIL->
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:38:33 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v2 3/6] dt-bindings: iio: imu: Add Bosch BMI260
Date: Fri, 18 Oct 2024 16:36:09 -0700
Message-ID: <20241018233723.28757-4-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018233723.28757-1-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree description document for Bosch BMI260, a 6-Axis IMU.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 .../bindings/iio/imu/bosch,bmi260.yaml        | 77 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
new file mode 100644
index 000000000000..6786b5e4d0fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bmi260.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMI260 6-Axis IMU
+
+maintainers:
+  - Justin Weiss <justin@justinweiss.com>
+
+description: |
+  BMI260 is a 6-axis inertial measurement unit that can measure acceleration and
+  angular velocity. The sensor also supports configurable interrupt events such
+  as motion detection and step counting. The sensor can communicate over
+  I2C or SPI.
+  https://www.bosch-sensortec.com/products/motion-sensors/imus/bmi260/
+
+properties:
+  compatible:
+    const: bosch,bmi260
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    description:
+      set if the specified interrupt pins should be configured as
+      open drain. If not set, defaults to push-pull.
+
+  mount-matrix:
+    description:
+      an optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@68 {
+            compatible = "bosch,bmi260";
+            reg = <0x68>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <16 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6011af70c12e..73b6b7721dd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4047,6 +4047,7 @@ BOSCH SENSORTEC BMI270 IMU IIO DRIVER
 M:	Alex Lanzano <lanzano.alex@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
 F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
 F:	drivers/iio/imu/bmi270/
 
-- 
2.47.0


