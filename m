Return-Path: <linux-iio+bounces-6160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD9902473
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 16:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FBF2853D8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102A213D89D;
	Mon, 10 Jun 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jBmwMcZk"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3C13212C;
	Mon, 10 Jun 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030849; cv=none; b=mZ/2VGEzerFzhqSSkQ81pAXl4cpjZIqqJiqN0zM4u3kUua+mTsxgUaPGynQ/IirkxYotHqc/ofMntyeBMHdCzSifF9g9MfhhLGuUsob3+e1TaRj+gIdyLV1krqjDq6elvo0k/XLexhm7KpBDr9kCcwzWdXuZl6pK2ImDOhxeDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030849; c=relaxed/simple;
	bh=hWhqPeI83ll668C6diA9vxPkyoEe2TIimgWzyqt7eCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1xwwUMxbQrameBcHYlGL7wjCUGedo/t5NIKokVlHM1bEe1lVTJujjO/03dsled8js3y9uHHPCH8XHJ7SibNoTPN8DWa5ZR4NMaawLYhEYTKGBIQCRYk4So+M9n6kwmWftYae0+Zf4jIOTPRLkmxiTxtlm2bPg9x6O0IJowf/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jBmwMcZk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkcC2096200;
	Mon, 10 Jun 2024 09:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718030798;
	bh=/9Vg0psZYqvNaVCVsyz9sQm9tkFR2sfzuZKiSToTa8w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jBmwMcZkZxtutF43ZaMQGOUSGLQxVMul1ZxIZcE6eXqCkfnUs8IjtC8dKtOg3r0oD
	 kUNngGT3VkDWoniLnHM4ZkTFVb/Wty1EILf4HgiomRAbM7S+Jhllwt2JCvDiAjs/7f
	 TvPUdMj5IvUloLU9BiFmx5648PtuWRKDT+ZsuxIA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AEkc1t008180
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:46:38 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:46:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:46:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkbZu096515;
	Mon, 10 Jun 2024 09:46:37 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v4 7/8] arm64: dts: ti: k3-am64x-sk: Enable eQEP
Date: Mon, 10 Jun 2024 09:46:36 -0500
Message-ID: <20240610144637.477954-8-jm@ti.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240610144637.477954-1-jm@ti.com>
References: <20240610144637.477954-1-jm@ti.com>
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
Changes since v3:
- Fix pinmux label name
- Fix eQEP node comment
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


