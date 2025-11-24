Return-Path: <linux-iio+bounces-26445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C923CC82D1E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 00:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 879AB4E7A9C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 23:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33E313E0F;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHhVrjqJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B72F99A3;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027324; cv=none; b=iwFUtGUHDHxby2XzT6FE7R5dbOLEW0kGqKOvqoXmqtW9WF6VCaljcWqZjFhf4Kf5MNU3eiYlH//TxWzND0Y2C3r9LF2oeQzeoFXHfsrRm1DySnVR69d6hzKZEPlW67prk5QxdJkixcFVWO9tHPWX8GvX3qYQlU72lWgFzpdaOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027324; c=relaxed/simple;
	bh=q3meXTXtsVW4mUeYvPaWad8ZUVulXIlzub5OzKQPlZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=obDBH80KuoObV2z9qaFphpW6nkhUOHkQIjkBYrg+jfIpn+/YXY0X1H0ft9PvMw8lV4AjKDs2QvFTILpgNa9Sxbd9Mz8+YSKvy4u4gAgvsQCSSxIJxdPnpCQIfU0va8TK9mQV+/5lhlE0YrlAsiHYUv7iRdB4bgj8M2PSfutp84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHhVrjqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4185C2BC87;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764027323;
	bh=q3meXTXtsVW4mUeYvPaWad8ZUVulXIlzub5OzKQPlZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NHhVrjqJKq+B6rCnz6FErsBfHZqF22dnN1cSlK30KC5uQ4dpnTH2mfx65GY5LfFdY
	 69aukn1RjH/nthcxbl5lNwtlod02URd/Hitoy9NFdLfb4Aaz/FrCoMkUHf6JTbpT8e
	 hFx4ag884/jVr774Us1QB2i3MHwQ53nrCT5wh+9n0bL/od5RsgnYOnZ0F4EI1Q0i/W
	 e83nFi74D8apj2Q6D98UeVoSablfmABQ0jiAOXQXrlCS6bzcF5SaQyeOe+/rg0z2OX
	 JvVQdV095PQGR+nrRkXzsTRj+aPJiARwR3rd7bPdrzg8fEXj2wztrWfZBU1pmtoez/
	 EQ4zVFmn6uqyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB121CFD369;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 24 Nov 2025 15:35:27 -0800
Subject: [PATCH v4 6/6] ARM: dts: qcom: msm8960: expressatt: Add
 Accelerometer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-expressatt_nfc_accel_magn_light-v4-6-9c5686ad67e2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764027322; l=964;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=dKXKMkVKjf56BlmeyijR32PuIauhgvlaM3EWEdUBB0E=;
 b=n5zAvflHZnzTNoHbN+46IeWgqQrcusBhwDS5I0yDtfHPJCM7AaOuRc594HFOxuzyatiPI4kv1
 9upVjkgYTjtDUj1u0Z6n7dsX4It5TSFLpqhMbD3ZLO0lLOznwbfTWuw
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Rudraksha Gupta <guptarud@gmail.com>

Add the Bosch Accelerometer.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
index d32461fc58e9..5a39abd6f3ce 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
@@ -497,6 +497,17 @@ &gsbi12 {
 &gsbi12_i2c {
 	status = "okay";
 
+	accelerometer@18 {
+		compatible = "bosch,bma254";
+		reg = <0x18>;
+		vdd-supply = <&pm8921_l9>;
+		vddio-supply = <&pm8921_lvs4>;
+
+		mount-matrix =  "-1", "0", "0",
+				"0",  "-1", "0",
+				"0",  "0", "1";
+	};
+
 	magnetometer@2e {
 		compatible = "yamaha,yas532";
 		reg = <0x2e>;

-- 
2.52.0



