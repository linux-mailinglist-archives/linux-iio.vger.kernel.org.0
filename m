Return-Path: <linux-iio+bounces-27977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B2D3B3D5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4230030066F6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D604329388;
	Mon, 19 Jan 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlkDOD+V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E88322557;
	Mon, 19 Jan 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843159; cv=none; b=Ahgwm5IIaLMcnLad35S/WeR5yFZvGaudTolydQnxeydvyhpjEBAvU41D9Q/mTPY5A1bddMgnRnpLPWGdhKTY9JdYxIt4N0HA3WwZffguOKhSB8UArF36C+Ji4hhvBjH6WuybkjFiW5TXma3ZjwSUxu8WYgCkdwRi7cFwP4VFR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843159; c=relaxed/simple;
	bh=V3C1yvRX6bb7a06RtadQrxrf/kE11eVwt9lTWF0EcrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjJFmOsKKtp73bnbdjve3fzWFdV6qgWhEga6JuGjUHo98/+/Gk4PoJvs+JqMDGBRvEPqgh9BEGwUSZjF2vIbTF2OxD4DpyvZbgkjR421Ly9A9UxtpEHeXqefr66j9iBRm2xnEWGTyeADwZvbmBiEQ4v4fcUUy4IMXByc4wNGJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlkDOD+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0991BC2BCB0;
	Mon, 19 Jan 2026 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843159;
	bh=V3C1yvRX6bb7a06RtadQrxrf/kE11eVwt9lTWF0EcrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FlkDOD+VQF6a6b45l1G0N/lMZjzr/Yb8XvQG8Hi+tajSKklCqv0T57NTwiZQ48iAZ
	 adkSF+ev5oCGmhVGTvFVl0i2yXVpB8OWYYqQQHzl1h6XQmKayniC8kD9Yio/DIBbYt
	 q/qhIXVAn0tdCYLSGe+3JbJ8G9uB4a9lBSM7yukviBlzPSX9iGIYcAdWOezLvcr+cM
	 qsM1XxAXWRyFDQBMz2206UragoRBT3Gd/8vZOdnbFV+W8d5yPfSDTghHXTGX3wFnY0
	 vU/Grx4qvOU7dyT2RBb3vRN3OmMdgq7BMcQjR09oDBlDB+lWSvlKb9TYgIW4hvzkOE
	 eHnSfPVYihJ1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21C3D29C32;
	Mon, 19 Jan 2026 17:19:18 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Mon, 19 Jan 2026 18:19:08 +0100
Subject: [PATCH 3/3] sdm845: tama: Add AMS TCS3400 ambient light sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-tsc3400-v1-3-82a65c5417aa@protonmail.com>
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
In-Reply-To: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768843157; l=1617;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=Q9E7GuxhgZ08JdbgPbICgzjn1Hy4d+2NDwK0eFbzpK4=;
 b=IPlvfSzMaVogNzIyBJOL3YLmXBH9HaRoJaSrYSVDZl1JUNZ1qdR+DMyeh2pkmnMzL6g6XE2I+
 f3+Rw8osNwoBtlto0Ayw/blcLYEr3Cmn59eFeMOVU0lSKayRCyUfKK8
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
Reply-To: petr.hodina@protonmail.com

From: Petr Hodina <petr.hodina@protonmail.com>

Add device tree node for TCS3400 ambient light sensor with
power supplies, interrupt on GPIO11, and pinctrl states.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     | 36 +++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 7dc9349eedfd..15d56d6831c5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -485,7 +485,23 @@ &i2c14 {
 	clock-frequency = <400000>;
 
 	/* SONY ToF sensor @ 52 */
-	/* AMS TCS3490 RGB+IR color sensor @ 72 */
+
+	tcs3400_sensor: tcs3400_sensor@39 {
+		compatible = "ams,tcs3400";
+		reg = <0x39>;
+
+		interrupts-extended = <&tlmm 11 IRQ_TYPE_EDGE_FALLING>;
+
+		vdd-supply = <&vreg_l22a_2p8>;
+		vio-supply = <&cam_vio_vreg>;
+
+		pinctrl-0 = <&ams_sensor_default>;
+		pinctrl-1 = <&ams_sensor_sleep>;
+
+		ams,rgbcir-vdd-supply = <1>;
+		ams,rgbcir-gpio-vdd = <0>;
+		ams,rgbcir-vio-supply = <1>;
+	};
 };
 
 &ibb {
@@ -751,6 +767,24 @@ int-pins {
 			bias-pull-down;
 		};
 	};
+
+	ams_sensor_default: ams-sensor-default-state {
+		int-pins {
+			pins = "gpio11";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	ams_sensor_sleep: ams_sensor-sleep-state {
+		int-pins {
+			pins = "gpio11";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
 };
 
 &uart6 {

-- 
2.52.0



