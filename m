Return-Path: <linux-iio+bounces-7614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B8930B06
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD7E281B8E
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020F13D28F;
	Sun, 14 Jul 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ansari.sh header.i=@ansari.sh header.b="ZodpNyFX"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005F13D276;
	Sun, 14 Jul 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720978546; cv=none; b=XYIfiJa83o0bJMQL6M7awLcHT2yignROtXPfg/oZXc9FEpxP1RXSYfabJuEdgLh/y9+bMH0JMQGuIekffuLe7ey4vTY46L5c8yzze6OnNRLgiHFeRZAJbRM3f8PMfXMERjp9deEjKmM8BGbDYbzdHUs6pnoBo+oXF8mikcby0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720978546; c=relaxed/simple;
	bh=VHWS+gj7xMlpAExhwSL6ooThV5hNxibaLYEH8aR1+Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tH2YpxbKR3RN1yx/UgMCGuBbtAGPLXkBYepITiwBrIw9nT5oahEVMrx8omtaX7aQ+7MmaGCM1gfgH9Dbn5I2e9g/0YoURVpui8E4EfYTWjGhM/zVninHFH0rAZGXgbcKQ5KsqkLhodAZbrE5svBaGBoDuyp+qXBKClmj4I7zdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ansari.sh; spf=pass smtp.mailfrom=ansari.sh; dkim=pass (1024-bit key) header.d=ansari.sh header.i=@ansari.sh header.b=ZodpNyFX; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ansari.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ansari.sh
X-Envelope-To: linux-arm-msm@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
	t=1720978543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdqvh6SMJ9Blh4+QG2t86TRm3VSmGkFDoB02sCBdXH8=;
	b=ZodpNyFXij4EaNyLMZEtyVasB7qgZXDO+xd159NYxFpx/kBfaZ4o7ltxlHOQTCKIIUysT7
	8xP+Y+UO6ThJ74M/+dF00pgXan6vx2FfX4cJChVXe4V6LN9M3wXwkmRxorNxZoCWgt9hni
	Hqjf8w4jb+o25j4BvIxTtP+0c5QTkLA=
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: rayyan@ansari.sh
X-Envelope-To: andy.shevchenko@gmail.com
X-Envelope-To: andersson@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: hdegoede@redhat.com
X-Envelope-To: jic23@kernel.org
X-Envelope-To: konrad.dybcio@linaro.org
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: decatf@gmail.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: sean@starlabs.systems
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Rayyan Ansari <rayyan@ansari.sh>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Rayyan Ansari <rayyan@ansari.sh>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org,
	Robert Yang <decatf@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>
Subject: [PATCH 3/3] ARM: dts: qcom: msm8226-microsoft-common: Add inertial sensors
Date: Sun, 14 Jul 2024 18:33:05 +0100
Message-ID: <20240714173431.54332-4-rayyan@ansari.sh>
In-Reply-To: <20240714173431.54332-1-rayyan@ansari.sh>
References: <20240714173431.54332-1-rayyan@ansari.sh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add nodes for the Asahi Kasei AK09911 magnetometer and the Kionix
KX022-1020 accelerometer, both of which are connected over i2c2, in the
common device tree for msm8x26 Lumias.

Moneypenny (Lumia 630) does not have a magnetometer, and so the node is
deleted.
Tesla's (Lumia 830's) magnetometer is currently unknown.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 .../qcom/qcom-msm8226-microsoft-common.dtsi   | 26 +++++++++++++++++++
 .../qcom-msm8226-microsoft-moneypenny.dts     |  3 +++
 .../dts/qcom/qcom-msm8926-microsoft-tesla.dts |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
index 8839b23fc693..ca76bf8af75e 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
@@ -84,6 +84,32 @@ smem_region: smem@fa00000 {
 	};
 };
 
+&blsp1_i2c2 {
+	status = "okay";
+
+	magnetometer: magnetometer@c {
+		compatible = "asahi-kasei,ak09911";
+		reg = <0x0c>;
+
+		vdd-supply = <&pm8226_l15>;
+		vid-supply = <&pm8226_l6>;
+	};
+
+	accelerometer: accelerometer@1e {
+		compatible = "kionix,kx022-1020";
+		reg = <0x1e>;
+
+		interrupts-extended = <&tlmm 63 IRQ_TYPE_EDGE_RISING>;
+
+		vdd-supply = <&pm8226_l15>;
+		vddio-supply = <&pm8226_l6>;
+
+		mount-matrix = "1",  "0",  "0",
+			       "0", "-1",  "0",
+			       "0",  "0",  "1";
+	};
+};
+
 &blsp1_i2c5 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-moneypenny.dts b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-moneypenny.dts
index 992b7115b5f8..a28a83cb5340 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-moneypenny.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-moneypenny.dts
@@ -10,6 +10,9 @@
 
 #include "qcom-msm8226-microsoft-common.dtsi"
 
+/* This device has no magnetometer */
+/delete-node/ &magnetometer;
+
 / {
 	model = "Nokia Lumia 630";
 	compatible = "microsoft,moneypenny", "qcom,msm8226";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-tesla.dts b/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-tesla.dts
index 53a6d4e85959..55077a5f2e34 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-tesla.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-tesla.dts
@@ -13,6 +13,9 @@
 /* This device has touchscreen on i2c1 instead */
 /delete-node/ &touchscreen;
 
+/* The magnetometer used on this device is currently unknown */
+/delete-node/ &magnetometer;
+
 / {
 	model = "Nokia Lumia 830";
 	compatible = "microsoft,tesla", "qcom,msm8926", "qcom,msm8226";
-- 
2.45.2


