Return-Path: <linux-iio+bounces-16150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDE1A487FE
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 19:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5356165F26
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EED200111;
	Thu, 27 Feb 2025 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="fJNR3S8i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE3229B2C
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681690; cv=none; b=XE49dkPYU+ewqTQ3Oi9/KtA3jXYA6VXx/QJgTKa/ocpeBJ/tQfe7wAseQAXSyjibvGsf+sBs4mSBW10BP4QxHsl6xUv32RAzn4pEriO/Ff9yrHPkFRvS7kwyR4brKhij0EsMeSXVaYZLpKKfmGHKxS5u8UuysmSugtnRyDGSCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681690; c=relaxed/simple;
	bh=5Kv7J/sWHXxwPy91WTGyz3nV2kVraScLqXgw9CRkNHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUHkLmHt/sUw301PgBoXkxPQthaTB1cewlGipL7r22ES94UzEXcrgrQLheaP9HwwBkDp90WjbfExb+pJ7doowZ3Su4JHdUwB+6airGIeYjTfY2ihvoGkBoZ+GVWoxzKrKANmtdoNaKM5EFsIQr1erekmfb5PstGIQFOdQG8aqHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=fJNR3S8i; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1740681688; bh=3nn1xUu8T7htvWtlrcfnf3CgZu7iBFZUrInzdEheFlw=;
 b=fJNR3S8iXkAhWfq4vOEDVTLkgc+FvVFb3Y0mhCiNEDhG61uIZ/vWW3EmSLugH/yTkWIJXFLh1
 iXOiSQh+MbOJa/BylxDgEt2h1lAkNx4D/GwO2L3Cl/hZ5t4fwShPknnNDtq5uJcIZyaD5U/rtSX
 W0ALh5mvYeHOj9RRCv3+AVuPLxLnUaBv/KGVW5t+CmkabVr8YVGnneqBpqDkR0i3KAseOec+KFQ
 Rt24IVXNd8pOuKro/Ksa6E5OwAA2yE2eTM0SP3QdpMRyDfD0PlnbuHwJc0ffLeONF5uzoPiRYB+
 aaSSxBKllVLzuPruOKd9Ps1aP7o+VlxgiVO5qc9GNgmA==
X-Forward-Email-ID: 67c0b1d6bf572996e86214ae
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
Subject: [PATCH 3/4] arm64: dts: rockchip: Add SARADC node for RK3528
Date: Thu, 27 Feb 2025 18:40:52 +0000
Message-ID: <20250227184058.2964204-4-jonas@kwiboo.se>
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

Add a device tree node for the SARADC controller used by RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 5b334690356a..0fb90f5c291c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/rockchip,rk3528-cru.h>
+#include <dt-bindings/reset/rockchip,rk3528-cru.h>
 
 / {
 	compatible = "rockchip,rk3528";
@@ -251,5 +252,17 @@ uart7: serial@ffa28000 {
 			reg-shift = <2>;
 			status = "disabled";
 		};
+
+		saradc: adc@ffae0000 {
+			compatible = "rockchip,rk3528-saradc";
+			reg = <0x0 0xffae0000 0x0 0x10000>;
+			clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
+			clock-names = "saradc", "apb_pclk";
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&cru SRST_P_SARADC>;
+			reset-names = "saradc-apb";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.48.1


