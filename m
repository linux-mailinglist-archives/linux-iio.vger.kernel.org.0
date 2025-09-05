Return-Path: <linux-iio+bounces-23737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F961B44E4E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04270586ABA
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 06:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D762D323F;
	Fri,  5 Sep 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="C+jZY1ZF"
X-Original-To: linux-iio@vger.kernel.org
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859082C3250;
	Fri,  5 Sep 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055316; cv=none; b=m8yeimNpCW+ivqqy4EFP4bOjirReXA0zTi5C8dvF4jhi9g5a6QD+3WJuRJXHZF2eD3duhTtcjINO2HOQjy7VAqittl5bKOicHW+NGFUBvgU1M1EoHO5lrTnjaNC22Pk/+LBqY40GKkA+zM5icne4Ork2YG049l4WS/zhEW+EWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055316; c=relaxed/simple;
	bh=SIF+hd9st7LrlE7sYu6XObkXQIzAEHXiuQrHff2qWH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RiNuYjcAICXzvE7w7ANuRECBUEWG5dQA4iQ5YiIziB0nJcBbsTwiEYFR/XCskLsNoIu5eun+MoiXmsa+UB0IZCOAT7yYwCrQ7I3W2nc4q8Xe/cvNc0ElNXWQSH56bUYFubAoID/l8hrmSVBJhplDcffBQajiYZTaHlLvTdDAPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=C+jZY1ZF; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vqzIvvFC+BrxEI6IGIMLmoy28OTKBIYxHR8NJC86crE=; b=C+jZY1ZFewpAbAWGnwrnijTis2
	ACB6tWcCzRIxqrCPI+PbkX03oZGKalheEEFaXqw4qM8w5sNn/oFwBrw/VdaM8V5MK7kZ5tqWTmQ1v
	Z3V7Ff6ygriGMEU5YbPaHiXXj/sa0xbs8A7egbZoh/9Dq80692MUFhZTHJ3lwdmZLUuD7qBpvL1lK
	3TkAtXqzU2z2Jg8Iu4krP3Urn/6S4AzniqQrnNo6HtEJO9a7mQ2vk3delJ3MSMm0KubnbdWLOPSAM
	XvN8r56geO/c436+galq0tXjlqwtKgiP2mjPpbTm8GhAiGk3pwbsr4XX6wRL0f6hXc4Lk2f5LxGQX
	b3XngPXQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:37248 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uuQLi-00000004eMg-2638;
	Fri, 05 Sep 2025 08:55:06 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 2/2] arm64: dts: freescale: imx93-phyboard-nash: Current sense via iio-hwmon
Date: Fri,  5 Sep 2025 08:55:03 +0200
Message-Id: <20250905065503.3022107-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905065503.3022107-1-primoz.fiser@norik.com>
References: <20250905065503.3022107-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Commit 21179eae56de ("arm64: dts: freescale: imx93-phyboard-nash: Add
current sense amplifier") added information about the current sensing
circuitry found on the board. Now, lets provide current sense reading
also via IIO-hwmon subsystem. This way, SoM current can be read directly
via sysfs property more conveniently for the customers. No need for them
to manually apply scaling factor calculations anymore.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:                                                                  
- no changes
            
Link to v1: https://lore.kernel.org/all/20250903113700.3079626-2-primoz.fiser@norik.com/

 arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
index 71a0e9f270af..d05645f25bba 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
@@ -27,8 +27,9 @@ chosen {
 		stdout-path = &lpuart1;
 	};
 
-	current-sense {
+	curr_sens: current-sense {
 		compatible = "current-sense-amplifier";
+		#io-channel-cells = <0>;
 		io-channels = <&adc1 1>;
 		sense-gain-div = <2>;
 		sense-gain-mult = <50>;
@@ -44,6 +45,11 @@ flexcan1_tc: can-phy0 {
 		standby-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&curr_sens 0>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


