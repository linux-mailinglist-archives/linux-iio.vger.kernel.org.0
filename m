Return-Path: <linux-iio+bounces-9766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885A7984D63
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 00:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B921C20B27
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1541AC8BB;
	Tue, 24 Sep 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wispDvV3"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CE1AB519;
	Tue, 24 Sep 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215681; cv=none; b=N6NCuA/QnfKxDCYAJtshrli/5npkguoMhIAMVZjBtEZG4+lC7WtTrVpK03t5L55XsK5yhFFcsJ6MLX+tgBZ9PisCMG4Ek9D+YllaT7Gt3ea7FiTWaTEr8mUSxfRKG3bHTrhcBppH4ufVd/wTW/wo6svaUxSbB9Z/VJY7Aa+Hz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215681; c=relaxed/simple;
	bh=Lm4eEehHmGZ56HFJ1rm8sdQ2HFVye/tnWeXbh92iEr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R479PjDo8UJ8SLE3rTvs1wEnbrP5IghRFex9O0BVMguDHbAVi6FRcPvFOsOeNxeehg6FmXUrv+K01wqHghNzK1O+3B3n5btCztFXM3qIRa9tDfqLR8ozlUx1C1cK59jKiQpbBlLz4SGSERyD+pU/TPjeaMFehjgCfP6lNUbrwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wispDvV3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48OM72Gw082927;
	Tue, 24 Sep 2024 17:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727215622;
	bh=1M2n6m+75pbsYposN1bAhoWmo9g+O2FkqiGVf/F7xdc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wispDvV3xWKAqC5BMq3OM/8u5OOzmDU93RhfZY/WPIODlz+UTZDjgeckseDLYyEHc
	 C36oI7dpMoby27XPr9KcckeZlvfHQn5wRaZktfCvdZervyhOpjQvBnUPf6NeLr9JI3
	 YonIWNK8KCvdEsr5Qe6g/EgVDEPZ/J8KKCkbEfVA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48OM72Rf019415
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 17:07:02 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 17:07:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 17:07:02 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48OM72lT037639;
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
Subject: [PATCH v6 2/5] arm64: dts: ti: k3-am62a-main: Add eQEP nodes
Date: Tue, 24 Sep 2024 17:06:57 -0500
Message-ID: <20240924220700.886313-3-jm@ti.com>
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

Add eQEP device tree nodes 0-2 for AM62A7 SoC.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v5:
- No change
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 16a578ae2b41..a93e2cd7b8c7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -943,6 +943,33 @@ ecap2: pwm@23120000 {
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
 	mcasp0: audio-controller@2b00000 {
 		compatible = "ti,am33xx-mcasp-audio";
 		reg = <0x00 0x02b00000 0x00 0x2000>,
-- 
2.46.0


