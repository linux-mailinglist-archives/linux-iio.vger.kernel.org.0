Return-Path: <linux-iio+bounces-11977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32839C04B2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 12:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F9028415B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A320FAAA;
	Thu,  7 Nov 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="E1W78ZCe"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0920C316;
	Thu,  7 Nov 2024 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980078; cv=none; b=jdOnUmojd5thkNNvgGli51pwcjImFgYMHkZ2gfBvykcJglmAu930+3by0dYwg5cPEcWYRwoMvIauVfsHc957GdOAmi+eWqD8HtjPAcAoWQfzmqEP+zXHmAZY1Z0xOKWyg9doy2IC9vyMKuIcvlQxe2UiMd2b/225u3bZsnIW5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980078; c=relaxed/simple;
	bh=vkvMOSF4aNxkqQ3yhK2SSJFRPZkSaMMmDUMSAgTZd4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBgrmi5KkoEZg9rxrsvHnLgFEnVtRQbwacBMmPrOM1bo7cDbKXqtk3cW0EW7RFb4PCdWSN/3CuSoU+8dY1WGUb4azsEZQam+jKugHjZqB2XqnZ9mOLxNnOARgKaEp/ZcUve5dDDsA/ePn/bUWh/gZOwaAuUmb2b4E0N5vMJJ4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=E1W78ZCe; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9/h7WdzZG9vjrQc7OkWmpZJ7JRIc5Cq4to1XZ7bI6xI=; b=E1W78ZCeCgemPK0BsMm3lPTBvM
	kfXODipqL7t/BzoWn95KOdCT1wx4Y5qdj857R1BozY9A+3h/ol0/Ebom8AQsSlQ4MnSTm5JodrDu6
	aYfzS5CzEcBgdfmUiHh7wKCczn7HVVoTh91EFcq/yjIu4VcuiuCdNT0tEpMVoc2txQHENW4MHTFlq
	FP+Rbygfg3/0tKHAW+UuqTtv51KUBzair3NZDLlXeqi2syacrgi2fjXTnGBraKkTT/h2Ebwl3Hz7+
	elRiG/UqtIidFYdNF/0nMAFHILjl1ZjWAjFYF2xt7eRR2ku0tIBWNqwugpEPX1hmZ8fIyo2bbsyzT
	fR0q5K7Q==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t90z5-0005lF-DJ; Thu, 07 Nov 2024 12:47:31 +0100
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
	heiko@sntech.de
Subject: [PATCH v9 9/9] arm64: dts: rockchip: set hdd led labels on qnap-ts433
Date: Thu,  7 Nov 2024 12:47:12 +0100
Message-ID: <20241107114712.538976-10-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107114712.538976-1-heiko@sntech.de>
References: <20241107114712.538976-1-heiko@sntech.de>
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
2.45.2


