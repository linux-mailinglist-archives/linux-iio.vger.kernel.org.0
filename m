Return-Path: <linux-iio+bounces-9761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5EF984D55
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 00:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E01B2138B
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB71448DF;
	Tue, 24 Sep 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fV+KWLSO"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842342A8F;
	Tue, 24 Sep 2024 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215675; cv=none; b=gDrxT0jsoFBO+fyL/ArXkNbfQk2xNvnokD+mVA8uGuLfxTm9/0liQnsGyyfyMrDAZ1oTbQ9CzqjojnkvSYnPPpZMVJtHpyGq6WfoOq1x0U7ISBQU3hdizHfx2O//HzmgjYkMI+eJc94ZvvRrzlJxcBFT236tCATMDlkZLK0qFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215675; c=relaxed/simple;
	bh=OEsZlL28t6ljfz8fnmFkCuS4GL68Hylplw9Z++0KTL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8Mog62yCgR8qRJuCd0w0rhovhwOXl9QgCs3Cls/Er/Rdfqj8rb90Cb2uwpCLXGx4U6N4yZtqTv5N87irwW6k+8AACAYD3fyEJ0OLs3uUYCEp7akTsnjaLtkRHn6QIvRxARnprddeSG69iKkh7rLcg/v+3X2Cz67ubS7dzipPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fV+KWLSO; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48OM721A075118;
	Tue, 24 Sep 2024 17:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727215623;
	bh=FcKDVO/ernx5jW4HFCuPYGGehp3bOmlb7zjPFCcNZbo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fV+KWLSOslrQj7rb0oEEd/RkF5NhAp3MS2xlf67QC484+2T50gC2hm/hwwba2HzaO
	 jsCuuNBgH3SgmdGglM8BYk5T2W5UheI3Ht5QQ9kL5SkhRDWLXFhL4/PB56VCaTidx6
	 vmKMD4+V9n/je4vAT1g0Omhq2/8c5/3jRMOYLDDI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48OM72Rn019426
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 17:07:02 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 17:07:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 17:07:02 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48OM72lV037639;
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
Subject: [PATCH v6 4/5] arm64: dts: ti: k3-am64-main: Add eQEP nodes
Date: Tue, 24 Sep 2024 17:06:59 -0500
Message-ID: <20240924220700.886313-5-jm@ti.com>
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

Add eQEP device tree nodes 0-2 for AM642 SoC.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v5:
- No change
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 7eae18399caa..f96cb19fb3f1 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1175,6 +1175,33 @@ ecap2: pwm@23120000 {
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
2.46.0


