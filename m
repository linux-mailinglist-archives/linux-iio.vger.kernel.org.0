Return-Path: <linux-iio+bounces-26444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DCBC82D12
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 00:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A61E348AAD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0472FD7B2;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzwoRwJy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E462F83AB;
	Mon, 24 Nov 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027324; cv=none; b=liBL5nQnfeDcqR08lNP379svOifiDEzWMlG/ztIbF7PlH+mkq0fCt5Pp2BHHuUcu3Wejiu6ai2Pun2/9sB8WK/q6NnifGm6vELvBBodLWkfZNIESVWrVDZ3u4OdGs7fDYj9tjZMZODP8m/c8Ou76b4XAup3fd2cwfIee5OSqupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027324; c=relaxed/simple;
	bh=4s39l/QafgDyne7Fk0MupeREU7/ycQbXTGHYHcfkGAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAKps9d6+KP84xRsWEJ6eZszaAA25VYX8RN4Cdoms5ZdiMBgZcKnp5yLisNLSDW2DdQIcdKhFZ/uZGZrlMNd8lc55IZIA7vX4gQey/o2JrjhLtgndfpqugH/oMLKCawmiE6qB9s514yTKtKeE6ji0UwtuKlEIZn30h5qZq4fns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzwoRwJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8837C2BCB0;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764027323;
	bh=4s39l/QafgDyne7Fk0MupeREU7/ycQbXTGHYHcfkGAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dzwoRwJyRIuwVAV9ki2N/QeAfGmeEZB+2oy32qTXOQDln6LRMiPWM+18H/yNKf7SU
	 yTmedX0oS3n/bBHUioxAeDh/nOQ/XtIQxzMUgkuhz5Zd/l+zSkMpnxg55aGJBclUbM
	 WHTIzNiY86QhZt00BiePmanNAM3wkBExQfRs4GV5Ol0KLD2QZ5mxWqQIFHmvS8FcYw
	 YfRGVK1YcmFnnrWTkaftHimMS1lIsyuz80so/6aohXPrSd5wqFVom3gHPC5C2iOnuS
	 IPIVuQq+nMXcJ9I18s/u3kGuyx3Y/VSwg8DlYgjOND0gH2pP2UNoYVhb4pu0Q9KmXt
	 kExYfd/Jxo6XQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FF7CFD36C;
	Mon, 24 Nov 2025 23:35:23 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 24 Nov 2025 15:35:25 -0800
Subject: [PATCH v4 4/6] ARM: dts: qcom: msm8960: expressatt: Add
 Magnetometer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-expressatt_nfc_accel_magn_light-v4-4-9c5686ad67e2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764027322; l=1006;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=7jrbiFxqBdAClrq/n9H3dJIomUxZ8Xc6QvLk/kgFMvE=;
 b=reakw873qQWdfmQwHHLrt2onXrvLUiqgp/jZu9RU6H70hA4ED0hQhMHEo7nM2IZ2vrRmvys1P
 hUvRikVVUw0D6V1iof74GtNrLmB2IJMlwAxnaaL7ZifQmMIAL79eph0
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Rudraksha Gupta <guptarud@gmail.com>

Add the Yamaha magnetometer. Mount Matrix is left as a TODO.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 .../boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
index 4f9b59db7bc3..d32461fc58e9 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
@@ -487,3 +487,22 @@ nfc@2b {
 		pinctrl-names = "default";
 	};
 };
+
+&gsbi12 {
+	qcom,mode = <GSBI_PROT_I2C>;
+
+	status = "okay";
+};
+
+&gsbi12_i2c {
+	status = "okay";
+
+	magnetometer@2e {
+		compatible = "yamaha,yas532";
+		reg = <0x2e>;
+		vdd-supply = <&pm8921_l9>;
+		iovdd-supply = <&pm8921_lvs4>;
+
+		/* TODO: Figure out Mount Matrix */
+	};
+};

-- 
2.52.0



