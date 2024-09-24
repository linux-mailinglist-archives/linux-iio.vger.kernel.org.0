Return-Path: <linux-iio+bounces-9764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFAC984D5D
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 00:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23711F24B08
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C681AB6E7;
	Tue, 24 Sep 2024 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sesD+Gbr"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CC14AD38;
	Tue, 24 Sep 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215680; cv=none; b=gAj3OJnBY9Dn15MjVmpHtNZFbmH4CZNk0SxS++8s4RbVehkkzGNIFaIDrbra/mdWn2XLGitTv4ZjlMBvbVa8clXUTXfQEDQaAUA5gpJ6OlTLIvrv5MPJuFOlIyG3cpb3JDj4s5teMhI9+EzPbFE2vAGb0ElqxVKx7F76Wm62OT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215680; c=relaxed/simple;
	bh=raSvKoA3ksmtugSdOUBrOfmdLCzIRBy6BsDy4q183tE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSL/NWZIgmwSxi9qCrzgclZTWkMzxy5PUlYla2KGkM77gx/Y0pPCP8jQQHVhy0JlKqz9iQa7duOf7lyT5Rx8xjTPZ3v13uiGCtc0+CM4fOxCbWZA1FXoQQzV6uI4D5Xyj280daDVxZVvWGJnR8Go37Te1wQ6Y85C00yEyRCAJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sesD+Gbr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48OM726n054742;
	Tue, 24 Sep 2024 17:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727215622;
	bh=ONaBeW9h8KgQVtHpNupMLiZgcPjn4X+YUwoYmMnYDP0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sesD+Gbr516aRXhD7eX4fDnjbViefafKE93FFhrFuZI5GtevTnjzbzbnhOZ+hUVR6
	 WIaHlxXSnutfXRqI9jnhQTmFTlXOCRm7PZ8OUwlcWc5340rC+LTd5RRoan2Ic37njk
	 m7PCaV37R+VdZq4wdSZd8Ymj5HytsET4i+cdH3Tc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48OM72Rl019426
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 17:07:02 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 17:07:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 17:07:02 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48OM72lS037639;
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
Subject: [PATCH v6 1/5] arm64: dts: ti: k3-am62-main: Add eQEP nodes
Date: Tue, 24 Sep 2024 17:06:56 -0500
Message-ID: <20240924220700.886313-2-jm@ti.com>
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

Add eQEP device tree nodes 0-2 for AM625 SoC.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v5:
- No change
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 5b92aef5b284..98ba75af8730 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -843,6 +843,33 @@ ecap2: pwm@23120000 {
 		status = "disabled";
 	};
 
+	eqep0: counter@23200000 {
+		compatible = "ti,am62-eqep";
+		reg = <0x00 0x23200000 0x00 0x100>;
+		power-domains = <&k3_pds 59 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 59 0>;
+		interrupts = <GIC_SPI 116 IRQ_TYPE_EDGE_RISING>;
+		status = "disabled";
+	};
+
+	eqep1: counter@23210000 {
+		compatible = "ti,am62-eqep";
+		reg = <0x00 0x23210000 0x00 0x100>;
+		power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 60 0>;
+		interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
+		status = "disabled";
+	};
+
+	eqep2: counter@23220000 {
+		compatible = "ti,am62-eqep";
+		reg = <0x00 0x23220000 0x00 0x100>;
+		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 62 0>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_EDGE_RISING>;
+		status = "disabled";
+	};
+
 	main_mcan0: can@20701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x20701000 0x00 0x200>,
-- 
2.46.0


