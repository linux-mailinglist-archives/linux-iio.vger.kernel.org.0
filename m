Return-Path: <linux-iio+bounces-6205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E845A90548B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 15:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877E42897A0
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7417FAB7;
	Wed, 12 Jun 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UKPUievi"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058917E464;
	Wed, 12 Jun 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200595; cv=none; b=m5GR3i1ZGu/sAlGyT7QQKYgWGq1he/WRF6ahRaeAwbLcj8NUZ+DAqgWT8siqkjpI1zSClwqnv4qoXOgueV1RkeD02nPJShWSs7JlTJf3fCs7JcilTwLEALoNPxAFpGzLVPLUbBmqLupoSvAk5nxaT1gIylmoZMb+VVZuDZvlZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200595; c=relaxed/simple;
	bh=LWOX+r7SThhVbtJD1bUMG+QHHjVnqdvBwOYlbpl0fRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pU3KcEI9roBzOo6zgrbvTbKtXJYs7AVMDMUqBGtwS80mIV5t/H1kzyzYm1QJaPH/TQERvHMV9nQ0Rs7flCjEtfl03NDr0YUrT/Lk6cpyyznPhcBnxeABB48lOfZZOnqkPotBKn+VMPfQvTHlNQHfLs7wpcQT6M7nYRJvF/8woyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UKPUievi; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtdPQ064429;
	Wed, 12 Jun 2024 08:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718200539;
	bh=sZhjjT6mYCzNLpND5LOJH3nVDScay6T/1TCsy8UFgLU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UKPUieviMimbmNYWbMP4HyiFCyPrGzswuFHeeRYH3STtLl0v1cefh+aLusVz2DSX6
	 zKbEQm1P73zzxJzOFyEXvu9pr0ErGg2PrvxNO0++ZEE2dW/AUrHMNI2Yuq1HGIcJR/
	 3Ny9lPu0fsFPzROQKQ28tVeNQoOEZdyUri9vCIWM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDtdYC101155
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:55:39 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:55:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:55:39 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtclW092708;
	Wed, 12 Jun 2024 08:55:39 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <wbg@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        David
 Lechner <david@lechnology.com>
Subject: [PATCH v5 7/8] arm64: dts: ti: k3-am64x-sk: Enable eQEP
Date: Wed, 12 Jun 2024 08:55:37 -0500
Message-ID: <20240612135538.2447938-8-jm@ti.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612135538.2447938-1-jm@ti.com>
References: <20240612135538.2447938-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

There are 3 instances of eQEP on AM64x. Only EQEP0 signals
can be routed to the user expansion so enable only EQEP0
in k3-am642-sk.dts.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v4:
- No change
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 5b028b3a3192f..1992444953745 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -357,6 +357,16 @@ main_ecap0_pins_default: main-ecap0-default-pins {
 			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
 		>;
 	};
+
+	main_eqep0_pins_default: main-eqep0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00a0, PIN_INPUT, 3) /* (N16) GPMC0_WPn.EQEP0_A */
+			AM64X_IOPAD(0x00a4, PIN_INPUT, 3) /* (N17) GPMC0_DIR.EQEP0_B */
+			AM64X_IOPAD(0x00ac, PIN_INPUT, 3) /* (R20) GPMC0_CSn1.EQEP0_I */
+			AM64X_IOPAD(0x00a8, PIN_INPUT, 3) /* (R19) GPMC0_CSn0.EQEP0_S */
+		>;
+	};
+
 	main_wlan_en_pins_default: main-wlan-en-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x00c4, PIN_OUTPUT_PULLUP, 7) /* (V8) GPIO0_48 */
@@ -672,3 +682,10 @@ &ecap0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_ecap0_pins_default>;
 };
+
+&eqep0 {
+	status = "okay";
+	/* EQEP0 A & B available on pins 18 & 22 of J4 header */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_eqep0_pins_default>;
+};
-- 
2.45.1


