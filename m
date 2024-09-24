Return-Path: <linux-iio+bounces-9765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BACD984D60
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 00:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DAA1F24692
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 22:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713101AC88E;
	Tue, 24 Sep 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tGzg0TIx"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681914D290;
	Tue, 24 Sep 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215681; cv=none; b=Y5fuJf7uwPMX2WJagAS08eaI6DkoR7ucCh1wQoxI5w3t6yFQqIoS4xEztRJqJzk2mDM9P5vycS3yF0amK3WahmrP3jZ2jNpGuzGkyqqoJB50OrnRZFXshf82bawL5me01w7nc5rkrig4vW7LLoi768lRYFSoJHb4SHLtfs2FP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215681; c=relaxed/simple;
	bh=96tCrm9njad6b6PBI7E/wWAqn4rwOO8KZwmwSrlayPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHHZg9BqsVKHK+vwXwuaj7VLBRjyt9tAQjE+eMgwwd4rxepnEnITIxM76llMxGSqqOJt6LMV9/QtKTAr3DhYgPEmkpHRiqCGmr/uiMUnHOivKzyqL+uagAI1wJj3DZNzjP+9ZAZocNTJRULTQmpeXLpvx7rN407KxdKfaY3PqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tGzg0TIx; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48OM72FC054738;
	Tue, 24 Sep 2024 17:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727215622;
	bh=4h53RmnxU7gpILaf3yHrv+tcrbJnvBSStCmsQx4E+QM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tGzg0TIxL3x7WT9trsK/QBnnh61XHnkmm4NKPf6n3j6CfO48MfHxAtVHcBMo0MdRr
	 CiJ5hFHtR4FgANRfI7JMAkz4tGdT8vi7Pvazcl8NYhpA9lriZGMS2LrnicWJkq1alV
	 T8P/5TUfHKvZEsCI/kF39dAsHQohRlaRd/4vRKxE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48OM729W036385
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 17:07:02 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 17:07:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 17:07:02 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48OM72lW037639;
	Tue, 24 Sep 2024 17:07:02 -0500
From: Judith Mendez <jm@ti.com>
To: William Breathitt Gray <wbg@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, David Lechner
	<david@lechnology.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
        Judith Mendez <jm@ti.com>
Subject: [PATCH v6 5/5] arm64: dts: ti: k3-am64x-sk: Enable eQEP
Date: Tue, 24 Sep 2024 17:07:00 -0500
Message-ID: <20240924220700.886313-6-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924220700.886313-1-jm@ti.com>
References: <20240924220700.886313-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

There are 3 instances of eQEP on AM64x. Only EQEP0 signals
can be routed to the user expansion so enable only EQEP0
in k3-am642-sk.dts.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v5:
- No change
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 86369525259c..47b351067bb8 100644
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
@@ -687,3 +697,10 @@ &ecap0 {
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
2.46.0


