Return-Path: <linux-iio+bounces-6027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B610900A52
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B3D2B24342
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B370B19AD9E;
	Fri,  7 Jun 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k/hr2GX+"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E943AA1;
	Fri,  7 Jun 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777736; cv=none; b=bCr96jayjloixkyV9IvUR+bEsisYZ0qlg30rgKVcA6WAr8MhnsmRFKW8Dl+1GQmo2GfM/FwWX282DyYSd2aFCpjqRWdvAeXVC4zN9+414hcZ1lbgJ7SjHHfSHQRYQkOSuxHVO07I24tUbjJNFCMioviWy/Ruw5SN/HfQUv1URDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777736; c=relaxed/simple;
	bh=MEasLV+/E7mjn9Yx2J7UaBnX7TW0OsQRjgP21ugEnAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/j6kXclGs/mIko1opy+Kyp6nNA6l70c9twtF4OS/CbIy95aWyGb74/57y/fnpuxEkfACmuf8IsdN4QjOyu9CyPNlB3UDDK/v+gqsKUO3zMCfe2YYUbiuXk70XbyFQ3mzJjoQrDaBoul7d8eJjH4yG01jtTMs9GgXUdiy6IpuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k/hr2GX+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457GRvBw076008;
	Fri, 7 Jun 2024 11:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717777677;
	bh=j5iV2dg8nzrCJJLdyYys3qP0vGgUbyu9YRqCtbbAz4M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=k/hr2GX+FnPYmGucAicSC4r4y9KYqn3IJ0Yp5DFKjAWo8F5ahds0Xkcjf6n59Pjwf
	 b3xPqrtPA0SKkV1qHT4tu6/mdzV76yjNPvvUt90Qv1cZG+nhRC8LjhRpzOCCkw5dlO
	 RP5BLq8MqLJnNnXPwnTHGSlu5B6hcd9aUKWz6YiY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457GRvVU058836
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 11:27:57 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 11:27:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 11:27:56 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457GRt1n068019;
	Fri, 7 Jun 2024 11:27:56 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 7/8] arm64: dts: ti: k3-am64x-sk: Enable eQEP
Date: Fri, 7 Jun 2024 11:27:54 -0500
Message-ID: <20240607162755.366144-8-jm@ti.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607162755.366144-1-jm@ti.com>
References: <20240607162755.366144-1-jm@ti.com>
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
Changes since v2:
- Enable eQEP0 in k3-am64 SK board
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 5b028b3a3192f..1987da60672a2 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -357,6 +357,16 @@ main_ecap0_pins_default: main-ecap0-default-pins {
 			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
 		>;
 	};
+
+	main_eqep0_pins_default: main-eqep0-pins-default {
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
@@ -672,3 +682,11 @@ &ecap0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_ecap0_pins_default>;
 };
+
+&eqep0 {
+	/* EQEP0_A is available on Pin 18 of header J4 */
+	/* EQEP0_B is available on Pin 22 of header J4 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_eqep0_pins_default>;
+};
-- 
2.45.1


