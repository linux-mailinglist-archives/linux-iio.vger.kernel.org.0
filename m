Return-Path: <linux-iio+bounces-26442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDCDC82D04
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 00:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E4714E7161
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 23:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B42FABE7;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIFsg5/1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021E2550D5;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027324; cv=none; b=qPBYt42BE+qOZ1TwUww3uwz4gXW0meCZsMZN9gl9lxIVWLGa83WugPdVW7sI66EDiTeC7oxHjtM/vDwfgk/CRK6QNrGDkCtchg99LvLMmF+y+7aY5tK63RtpTuUx5sWaLrZNE+d1LabB10HAJrsO2WfyQIrnTac6zFrsI8v+Sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027324; c=relaxed/simple;
	bh=DOWNpn9zwiyXvYPX7PwLf+MWR5LFTvKq9m3rZeADCDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwHHHNLNtaLd7Z7WHgnfCmvmCHei9d46HM4IJRrqNU+DYz13+PN5DCJt0A946BY2OvULwLt62nnFQpw/aFSPWtriYOVwW58II8rKArajmlCAY0//EBH12BzQaztAE8xMpEfjat6dM9Kqw10ZamSHFtBe8nmlL6g8hU8/sxM61Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIFsg5/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB94EC19425;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764027323;
	bh=DOWNpn9zwiyXvYPX7PwLf+MWR5LFTvKq9m3rZeADCDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PIFsg5/1V1utYolEeUxJ1Jppkd9D5JFYa66HrVO928NSc0RsRYv7l9RFV1AiV4SjY
	 gK4VLX04BqP5jvfh51v4URAI7XZdxMfx8/Vq6iTr3VCw3vabS+4lao/JJ9GxsLMx8E
	 4cVv1yCW7m5zmBWVPr+g7z75Sc9SHGAwbaBNBL0NjIHbCfujQJ6imHcf6oEU7sS29X
	 5kp/sKWgTyp/mCI23VPAyyPGTkHaYWc2/Z9vmsd64SmulsfOGDpKQtui74NIQWVi/S
	 IPiy39xnGfhS3GPfQJK2Qn2xOzusVzbcsT1FwQrshyqgW67P6HnJFkLXnvq9AL/lUM
	 f7f0Y/o3VfBVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD00CFD369;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 24 Nov 2025 15:35:24 -0800
Subject: [PATCH v4 3/6] ARM: dts: qcom: msm8960: expressatt: Add NFC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-expressatt_nfc_accel_magn_light-v4-3-9c5686ad67e2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764027322; l=1820;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=rOtVB/zkRWn92j/Dp4B0g4zF8yGu78fQec4Jct5Q/Xk=;
 b=KkNe7n0hC/QuFvC6UK4PfFEqY1ZCNyiZcyLv9YzkQnZwBaWCYQ0ezB+4Z66dlps6ow2TBVW4h
 FoT9K3xUGIdCxsDmBk4hoinuZs2mWtL5iLTkJzQrPPwZXP/vAijBrxR
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Rudraksha Gupta <guptarud@gmail.com>

Add pn544 NFC chip

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 .../dts/qcom/qcom-msm8960-samsung-expressatt.dts   | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
index 8d75ebd7976c..4f9b59db7bc3 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
@@ -182,6 +182,22 @@ touchscreen: touchscreen-int-state {
 		bias-disable;
 		drive-strength = <2>;
 	};
+
+	nfc_default: nfc-default-state {
+		irq-pins {
+			pins = "gpio106";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		firmware-pins {
+			pins = "gpio92";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 };
 
 &pm8921 {
@@ -195,6 +211,14 @@ prox_sensor_int: prox-sensor-int-state {
 		input-enable;
 		bias-disable;
 	};
+
+	nfc_enable: nfc-enable-state {
+		pins = "gpio21";
+		function = "normal";
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		power-source = <PM8921_GPIO_S4>;
+	};
 };
 
 &rpm {
@@ -442,3 +466,24 @@ &usb1 {
 	dr_mode = "otg";
 	status = "okay";
 };
+
+&gsbi7 {
+	qcom,mode = <GSBI_PROT_I2C>;
+
+	status = "okay";
+};
+
+&gsbi7_i2c {
+	status = "okay";
+
+	nfc@2b {
+		compatible = "nxp,pn544-i2c";
+		reg = <0x2b>;
+		interrupts-extended = <&tlmm 106 IRQ_TYPE_EDGE_RISING>;
+		enable-gpios = <&pm8921_gpio 21 GPIO_ACTIVE_HIGH>;
+		firmware-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&nfc_default &nfc_enable>;
+		pinctrl-names = "default";
+	};
+};

-- 
2.52.0



