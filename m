Return-Path: <linux-iio+bounces-16151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D98A48802
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 19:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB763B5DA5
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF69626A0FD;
	Thu, 27 Feb 2025 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="NBqM4qid"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9825CC6E
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681695; cv=none; b=mgdlBEtFdgrZlVUmjRHU/WQlH75iMHxzyXp8cmh9ZiZtpTvPCrRvtPTEfgumMVF0Yiba9gJLQw9BUiaaPmfo3aLC2dNvU6LBVl+VaxB/Vw70iVQbLBtyjSM7RbAdCl88RhiwEgD6j/09eNG3zJ077w7h3b+fQ8yaf1w+LiayMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681695; c=relaxed/simple;
	bh=tapKa4ENwa3OBlIjhb4jmk2jsNXPicM6WS6wpGM88bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc6Gq1BEMt9Cbf7MsgPi8gSRojGUZLCIibMfP2zUpHAYd1vEQlshPX2FEvUj4M9YwL+LsWHP3B4Lwuy+gAO/Dz8QNnBdtZQ7qgW+00ojWvUn4i+UvRbxadHF0OLjtOUNPXUp9OY4X2/O9JgEaec7sInSLDN2xIVuZZwGR4it0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=NBqM4qid; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1740681693; bh=bnDwHn3VE/1QDoX5PmDpHlQdrc4Kek1m+Wmq70y11Yg=;
 b=NBqM4qidq/tKl1rLyHAw6yL8e40xXGp8JWxgtAaFpf3gbe9rTrCYfBVhcJa0+tf3u6evneI0j
 13OrUozS/vBmwjEJnUUiZOmdXUOOhAVMAX3UOzFTuARsyNkRz3cKTMOlwE0wm3Pe90eblUvf3Xu
 jA3tpNPUcNOjvBHSFCUUVLUROp3LHszgUa+6UEBQs8wE6LhGO+bHAVnTp79xnvgoY9+fTkZeEHV
 /HJDs8Q+ZEhrisx4h7nZrE0Eigfe7QZ1Opkzto8b5zXGkBlJatgaK2VKVx595BHTO8Uheuk7jpm
 63ju8ROa7hRGbJOInrWx9I5sMLNIxdpc6g4ecd6Jh4xA==
X-Forward-Email-ID: 67c0b1dabf572996e86214e5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/4] arm64: dts: rockchip: Add adc-keys node to Radxa E20C
Date: Thu, 27 Feb 2025 18:40:53 +0000
Message-ID: <20250227184058.2964204-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227184058.2964204-1-jonas@kwiboo.se>
References: <20250227184058.2964204-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Radxa E20C has two buttons, one SARADC maskrom button and one GPIO user
button.

Add support for the maskrom button using a adc-keys node, also add the
regulators used by SARADC controller.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
index d2cdb63d4a9d..dcc0b2584bbc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -6,6 +6,8 @@
  */
 
 /dts-v1/;
+
+#include <dt-bindings/input/input.h>
 #include "rk3528.dtsi"
 
 / {
@@ -15,6 +17,54 @@ / {
 	chosen {
 		stdout-path = "serial0:1500000n8";
 	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-maskrom {
+			label = "MASKROM";
+			linux,code = <KEY_SETUP>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	vcc_1v8: regulator-1v8-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc_3v3: regulator-3v3-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_sys: regulator-5v0-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
 };
 
 &uart0 {
-- 
2.48.1


