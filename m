Return-Path: <linux-iio+bounces-23684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF92B41E28
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 14:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D8F3B7C67
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303112F8BF1;
	Wed,  3 Sep 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="SESqPzoN"
X-Original-To: linux-iio@vger.kernel.org
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D92EC0AC;
	Wed,  3 Sep 2025 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900866; cv=none; b=RmUKGBhqwUHMz8zMq0ZZFG43JEe8IHliN1b+G4LhDo7Tt0xIztVfvMv4iQebW10ii1DSqMD6++/6N1otlD5PKqrhW/mayF5kzV7UoaDa0Bd1KXdi/o+GOXWoAlH3CNRwBk3L3NK3UNOXluV5kAR0Mw5CIJ5SagmVs9GNfcuwA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900866; c=relaxed/simple;
	bh=LYrr4fPnCxCnQubga6pk+f0CUrdMYZH4/FfkfeOVMGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TF2vWv5nqL4+hEEPIMfQUxhO12PKcOgkFal53eSR5hsMklWIhAU5mBTYUfRboT6CjSU2kCFANdB2ihEgNyAH3SAXy+D+TC6MZMcdIdouWNSYrUugl48dExO9TX4C5BQF7Dcaa82zz2wmuJWLOQ7YlgUY+FMZgulOQALK96R/PIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=SESqPzoN; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=L6hrEb4mgX5Mvff5n1A3e3PGtiUPufA/mp16ZKLUduI=; b=SESqPzoNzja2yHIA9DttFu4KeB
	P1rI6Rk88w3oln3CQcR7dXnup20dhDIBFzM0pqUDitW63iNDegbV6yUMolCCNxSMTzQWveIkB3xmH
	kYgEMa6eyUpMAx6mTo+4ujC8G5Sr54agjAWGGkIlIsl3FV/h2CXiGDAJzScAdD13WFYOO6QNCcPIc
	R6c334PfyTckpqKAnl9tN5piOdDyoeu53R3hKsW/QS1Rkck21cHPGVymIt2ne2efjxo5t19HJ+KZA
	lrDqM1/+pdDkZ76LwekTaTR2l5xh0A4pUjUE+vxGDYMC2zeWFxjh1anEH/CYmK+jcDYklkkV89H+P
	9hp5dyCw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52410 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1utlnU-000000034mQ-1vsS;
	Wed, 03 Sep 2025 13:37:02 +0200
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
Subject: [PATCH 2/2] arm64: dts: freescale: imx93-phyboard-nash: Current sense via iio-hwmon
Date: Wed,  3 Sep 2025 13:37:00 +0200
Message-Id: <20250903113700.3079626-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903113700.3079626-1-primoz.fiser@norik.com>
References: <20250903113700.3079626-1-primoz.fiser@norik.com>
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


