Return-Path: <linux-iio+bounces-26443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F274DC82D03
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 00:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739E63AD62C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 23:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896FB2FAC1C;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOVOQk+3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055725F7A4;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027324; cv=none; b=pss9agHbhk0v05gNex3be1DhNNGQXdS77MMf+RLyd42LhARETCRaHlP2RbDVYlNz2eGGEl7u4Z1FkSSQlobHLXIxKgiUvdVzANy1NOTw+vn2KZdEIcy5xN7bVja/Sn3esY6VHJlcp2HeMwpC4LlQtnp6QynByglaYSsZzvlolw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027324; c=relaxed/simple;
	bh=u9aqNiA6Nwt1ajTqNsGO/hPjY+Fe7Gxd2kkZFH/hsZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snK7Ab+wq7hCkhALdNswjin3CsdkN5byoYvW7gentOQNf2SOtZkCHoxXdjKHVw2hbXBArpegm5gDMphHnR4WSvcKt0/dssSP/r9AJMQ8tx95umoy0DqDjeTB1FeVFoOj4uO5bOPdG/uHhznYoQ8yxUE3ThrwhnGlg6rKeoJgv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOVOQk+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A90DFC116D0;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764027323;
	bh=u9aqNiA6Nwt1ajTqNsGO/hPjY+Fe7Gxd2kkZFH/hsZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NOVOQk+3z99qZ8n17ov4+EF8Rt+G1K67VXfmqJtIe0mRRyxqPT+zdMZegMfTF+Vb/
	 MpcMfjz/dsIV9peiDY0Jrs17JPq8sJ8BL/B6zUJvDl7kKVRF+Vzm+Se7R88zVNdQwD
	 jx3NLw1HRpaUtK9EruvBXKhUx+zUik7tS/NrvM7zQlSYo4t5sxV3JlZ/thDES3ehQZ
	 z+VyPX82yfd2MuIRMmspG4D1L39vJZ/bhtYvl11UM/Ft7FLwL4kfBZg5Czbgh+DeTF
	 9omTxK11eO2o3Kk1I+RC6g2t+Oq4FitLBYJpbXXpGfwuri+z29gceJUjRwOXQtP7Yh
	 ZZpzsPZKHTOXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B079CFD360;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 24 Nov 2025 15:35:23 -0800
Subject: [PATCH v4 2/6] ARM: dts: qcom: msm8960: expressatt: Add
 Light/Proximity Sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-expressatt_nfc_accel_magn_light-v4-2-9c5686ad67e2@gmail.com>
References: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
In-Reply-To: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764027322; l=1637;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=yZG1sZBCe3vOBZ7yKg0s6tW7F4POpCoTYx3Ig3XEUjI=;
 b=qSQ/BzuXX2x20sp0Y1qc8/8p9k11aGCyUtH0TUWT5dyHPPKz43FdS3Ax5hT+L0RWtY2caF7SN
 iT1UFWEGuuIDLro1mbI84S5vI37PcbmHQJBbtQjY0I8mZWsnHlHSng/
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Rudraksha Gupta <guptarud@gmail.com>

Currently the Proximity Sensor doesn't work, but light sensor does.
Left the proximity sensor as a TODO for later.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 .../dts/qcom/qcom-msm8960-samsung-expressatt.dts   | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
index 5ee919dce75b..8d75ebd7976c 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
@@ -54,6 +54,31 @@ key-volume-down {
 	};
 };
 
+&gsbi2 {
+	qcom,mode = <GSBI_PROT_I2C>;
+
+	status = "okay";
+};
+
+&gsbi2_i2c {
+	status = "okay";
+
+	light-sensor@39 {
+		compatible = "amstaos,tmd2772";
+		reg = <0x39>;
+		interrupts-extended = <&pm8921_gpio 6 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8921_l9>;
+		vddio-supply = <&pm8921_lvs4>;
+
+		/* TODO: Proximity doesn't work */
+		amstaos,proximity-diodes = <0>;
+		led-max-microamp = <100000>;
+
+		pinctrl-0 = <&prox_sensor_int>;
+		pinctrl-names = "default";
+	};
+};
+
 &gsbi5 {
 	qcom,mode = <GSBI_PROT_I2C_UART>;
 	status = "okay";
@@ -163,6 +188,15 @@ &pm8921 {
 	interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
 };
 
+&pm8921_gpio {
+	prox_sensor_int: prox-sensor-int-state {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-disable;
+	};
+};
+
 &rpm {
 	regulators {
 		compatible = "qcom,rpm-pm8921-regulators";

-- 
2.52.0



