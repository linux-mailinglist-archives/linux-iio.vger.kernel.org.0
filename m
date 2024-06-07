Return-Path: <linux-iio+bounces-6025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AC2900A4A
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08217B23F55
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF9A19AA6E;
	Fri,  7 Jun 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nPvAcsM1"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333A19AA40;
	Fri,  7 Jun 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777735; cv=none; b=ub5LVt/YsanNqlkNwTrXMobRso2Ul+iJwhFcd7d4kc3SGE0JrXcij2SY76EuXVE9qkafY4Lv6FynJpYHxmXfIHzEo4HmrdN2VqQRtYK6SlLOHKeZ8++7UycZD1ainxEzBrXwJC/mNHqtnrz2l8I5CuN+gdU3y/0XcW2IlQvPeJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777735; c=relaxed/simple;
	bh=v5vfruB7l2v9qAe9ilwgL7QaEEjs5wPBoQ/14S5UB2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPcFL1L2G0Io34sG3xdvFoyVRRj8fJG5zMzcRCoULFUgfdDQ90x6Oupq1WV8Oo4NPidJwqMskKfqE19Xk2ViesC99HMaEokPhWLZcz4SpoIz9tKFSXo0nOhhSeGQj/7yBud7nNljVax84QH+wPpeU98zlERcjBcJpNPv7eQ3yNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nPvAcsM1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457GRvan025670;
	Fri, 7 Jun 2024 11:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717777677;
	bh=YFHPQL/G/uN01yS9rCCVaqefgaP5S3kCIPvNr4BAafA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nPvAcsM1TDHINr9dQGeBJV+5uvitTio0lQAnknK6xkjujpY+XQK5KBu1FX49uycNR
	 pZNSM06NTm7HUGgegj0vjb4zIrNjCTVspJdoFgvLvBzmSIqDQLLSnz1103hqWU6p4u
	 a7MfnIbKwQOdQ12PxJRQKPf3gH1Olkolbx8AK0Co=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457GRvDq096187
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 11:27:57 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 11:27:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 11:27:56 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457GRt1m068019;
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
Subject: [PATCH v3 6/8] arm64: dts: ti: k3-am64-main: Add eQEP nodes
Date: Fri, 7 Jun 2024 11:27:53 -0500
Message-ID: <20240607162755.366144-7-jm@ti.com>
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

Add eQEP device tree nodes 0-2 for AM642 SoC.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- No change
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 6f9aa5e02138f..6be710138dded 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1171,6 +1171,33 @@ ecap2: pwm@23120000 {
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
 	main_rti0: watchdog@e000000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0xe000000 0x00 0x100>;
-- 
2.45.1


