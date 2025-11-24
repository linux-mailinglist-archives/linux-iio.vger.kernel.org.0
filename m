Return-Path: <linux-iio+bounces-26440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1407C82CFD
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 00:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF2FF4E15E7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 23:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB42F8BC3;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4VGZMJa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171952BD11;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027324; cv=none; b=PSGxb4jGrkfTEA8GPFd/Bgn7usrEqjZJx1/5sUlUHgUTqek++Ak/8XkomSAEHf08/eLkHMhn1kbtdnBw2+HOcBAmnfllpDvLI4DhmI3CTgh56y6MPq27tgkiTPOD80maD6sMF02Hau7fdO8TchXeEdG7AtjymuxZioq5kSEnqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027324; c=relaxed/simple;
	bh=2+2D57vUBJDKAdDzoMNELJCQxPSzsQHTvkfFA03FK70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgn5y9BqBSuMF26yNypNRDuA74bLgQAC4Xq2+xVIw/oRoltuUDvjjeNIq+4OTO8UBbggVnkRxYFix3gDxfPhCJC+5VMB2EuRMPLM2Yq37DOX5+IDal7aRni/3qTLw04xMAjNv/XfElbWLsIeB6W+Kvt1afbVVPhAyExRTOM/tUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4VGZMJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A780C4CEFB;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764027323;
	bh=2+2D57vUBJDKAdDzoMNELJCQxPSzsQHTvkfFA03FK70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W4VGZMJaUPpad6rvmvN5u4dnW4+MEd1B+EUhdUY+Nz0sQQI5WmvYPqgRuO213GaRO
	 bE0AaZlHHglX+jxdLFiLM9pGTV6u2zu0t1kSW9+EWoxXUjd0G22/1F5ss4/MyUJFt2
	 qEIdkU/ZKjDOP/KzVE6slTwnbXJj8GOn3J1ubXF3jSrSgJPYwpRWRie4ZYZvPn2bkh
	 +Azj/0/bvYQRrZzfwgLG3a4ATGVXmA9eoCwLR9VBtSIftgEIhFPlh/DlCVAsqY1Q+I
	 b67SfZnPqomvuDc/d36J9KkgGhRvITpU2K1DlhrvPCl4rx05bGJKAD5F6urFzz/Be9
	 qw8sR3vgj1VRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5F5CFD367;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 24 Nov 2025 15:35:22 -0800
Subject: [PATCH v4 1/6] ARM: dts: qcom: msm8960: Add GSBI2 & GSBI7
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-expressatt_nfc_accel_magn_light-v4-1-9c5686ad67e2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764027322; l=3530;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=2ICK00hH1Y/N2rJ/MOOdERF0k2Q1yj8a78xAIbTZBmM=;
 b=w+Q1wXcA+pl4cElR8vnSs1pzXal1tF9gtXfSuCZto/zgui52WO97NN00bbml9YgVx8n+jHXUS
 V4EHh0hKs/+BkwZZnv3VGVHfhs943XOMRp5jOk8+DLqAC2J0efq8Vf6
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Rudraksha Gupta <guptarud@gmail.com>

Add the GSBI2 & GSBI7 Node, which is similar to the
other GSBI nodes in this file.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 96 ++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index 38bd4fd8dda5..fd28401cebb5 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -149,6 +149,24 @@ i2c1-pins {
 				};
 			};
 
+			i2c2_default_state: i2c2-default-state {
+				i2c2-pins {
+					pins = "gpio12", "gpio13";
+					function = "gsbi2";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			i2c2_sleep_state: i2c2-sleep-state {
+				i2c2-pins {
+					pins = "gpio12", "gpio13";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+			};
+
 			i2c3_default_state: i2c3-default-state {
 				i2c3-pins {
 					pins = "gpio16", "gpio17";
@@ -167,6 +185,24 @@ i2c3-pins {
 				};
 			};
 
+			i2c7_default_state: i2c7-default-state {
+				i2c7-pins {
+					pins = "gpio32", "gpio33";
+					function = "gsbi7";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			i2c7_sleep_state: i2c7-sleep-state {
+				i2c7-pins {
+					pins = "gpio32", "gpio33";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+			};
+
 			i2c8_default_state: i2c8-default-state {
 				i2c8-pins {
 					pins = "gpio36", "gpio37";
@@ -543,6 +579,36 @@ gsbi1_spi: spi@16080000 {
 			};
 		};
 
+		gsbi2: gsbi@16100000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			reg = <0x16100000 0x100>;
+			ranges;
+			cell-index = <2>;
+			clocks = <&gcc GSBI2_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			status = "disabled";
+
+			gsbi2_i2c: i2c@16180000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16180000 0x1000>;
+				pinctrl-0 = <&i2c2_default_state>;
+				pinctrl-1 = <&i2c2_sleep_state>;
+				pinctrl-names = "default", "sleep";
+				interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI2_QUP_CLK>,
+					 <&gcc GSBI2_H_CLK>;
+				clock-names = "core",
+					      "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+
 		gsbi3: gsbi@16200000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			reg = <0x16200000 0x100>;
@@ -600,6 +666,36 @@ gsbi5_serial: serial@16440000 {
 			};
 		};
 
+		gsbi7: gsbi@16600000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			reg = <0x16600000 0x100>;
+			ranges;
+			cell-index = <7>;
+			clocks = <&gcc GSBI7_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			status = "disabled";
+
+			gsbi7_i2c: i2c@16680000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16680000 0x1000>;
+				pinctrl-0 = <&i2c7_default_state>;
+				pinctrl-1 = <&i2c7_sleep_state>;
+				pinctrl-names = "default", "sleep";
+				interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI7_QUP_CLK>,
+					 <&gcc GSBI7_H_CLK>;
+				clock-names = "core",
+					      "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+
 		gsbi8: gsbi@1a000000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			reg = <0x1a000000 0x100>;

-- 
2.52.0



