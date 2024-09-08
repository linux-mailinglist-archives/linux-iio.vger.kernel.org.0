Return-Path: <linux-iio+bounces-9349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD8C9709FC
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 23:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8911F21782
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 21:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5A183CD5;
	Sun,  8 Sep 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2uWcj+fS"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58417BB1E;
	Sun,  8 Sep 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725829800; cv=none; b=XlxuKMxDpSKBKxMqvvwz5aCp+amS9uaV650dgKFS4qrIAPpfgHgfjReRZnBk40Vr4LNk/FqdzsHYgN2SlT5TYGXdN3ezewK9zM18I3r3rZzgjt8mjIDmAriDIZAj/FLvrj76AG9DKExqUrnclERPWFVFieTh/NXRft1GCsrdXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725829800; c=relaxed/simple;
	bh=equbU9VBMIwdvGkqWk+AjPVcTc+O1BMZPBWXnDB1Dyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHqimKcnp5GjJpo4+eQgRSda1VoQcokfamvR2y7D/YtHACidx0Rvc4KOsjR23YaG1LNSfGZBXZQD+qN81Xqu9xhFbRygXPGMXq9pUvtwdA7yWZJogoa7II1mrhNNrdyJGjJLNUPB/b9rVFi9/j0jyutnRNiIjkDqZ8rY680mjCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2uWcj+fS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q1jpFbe8UJlfuFdvluwPG8fKnNdFZmBXVzuyZQAcBU0=; b=2uWcj+fSeC3gcEwnxueXgjo0si
	Z3hkjgc4JZ0ZdQi6FYCFmDU1+Nv/5yQK7ScViFakuhTZu+D2GzRMq0vg0xBtkw3tc/II49bUcg3df
	6f09+FSg4iDFa9dRssvhusUL3rsmNNEi/AUUj6EE0B9jsJtBUU2HfgUvff1l17LxvlnxQf2E1G8WN
	ZuJy3/T1KNISHP21A27l86XKZNYErHsyPPNsSYBILehyY34QrpWVKw+spe1kyq5K0HnUHLF8muwAQ
	ovVnCMHuVElR3a8PJzSN+Gaz/xlZ/K72xbZz8dx/L78piG/xDHe52h6YHTKEqwZKTD+fsqIAMRsSD
	rQcD5sNA==;
Received: from i5e8616cc.versanet.de ([94.134.22.204] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1snPA7-0003s9-U9; Sun, 08 Sep 2024 23:09:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	jikos@kernel.org,
	jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	pavel@ucw.cz,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 9/9] arm64: dts: rockchip: set hdd led labels on qnap-ts433
Date: Sun,  8 Sep 2024 23:08:03 +0200
Message-ID: <20240908210803.3339919-10-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908210803.3339919-1-heiko@sntech.de>
References: <20240908210803.3339919-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The automatically generated names for the LEDs from color and function
do not match nicely for the 4 hdds, so set them manually per the label
property to also match the LEDs generated from the MCU.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 4bc5f5691d45..7bd32d230ad2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -50,6 +50,7 @@ led-0 {
 			color = <LED_COLOR_ID_GREEN>;
 			function = LED_FUNCTION_DISK;
 			gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
+			label = "hdd1:green:disk";
 			linux,default-trigger = "disk-activity";
 			pinctrl-names = "default";
 			pinctrl-0 = <&hdd1_led_pin>;
@@ -59,6 +60,7 @@ led-1 {
 			color = <LED_COLOR_ID_GREEN>;
 			function = LED_FUNCTION_DISK;
 			gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
+			label = "hdd2:green:disk";
 			linux,default-trigger = "disk-activity";
 			pinctrl-names = "default";
 			pinctrl-0 = <&hdd2_led_pin>;
@@ -68,6 +70,7 @@ led-2 {
 			color = <LED_COLOR_ID_GREEN>;
 			function = LED_FUNCTION_DISK;
 			gpios = <&gpio1 RK_PD7 GPIO_ACTIVE_LOW>;
+			label = "hdd3:green:disk";
 			linux,default-trigger = "disk-activity";
 			pinctrl-names = "default";
 			pinctrl-0 = <&hdd3_led_pin>;
@@ -77,6 +80,7 @@ led-3 {
 			color = <LED_COLOR_ID_GREEN>;
 			function = LED_FUNCTION_DISK;
 			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
+			label = "hdd4:green:disk";
 			linux,default-trigger = "disk-activity";
 			pinctrl-names = "default";
 			pinctrl-0 = <&hdd4_led_pin>;
-- 
2.43.0


