Return-Path: <linux-iio+bounces-6200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E30C190547F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 15:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D8B21D89
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19917F392;
	Wed, 12 Jun 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wRXc0kO+"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053917DE04;
	Wed, 12 Jun 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200594; cv=none; b=Zh9SGzTMnrMNSWvWBiFuQeTKq5MJ8VPTxu0ULr+YjWH2opjWz1gFl6LgZD4wDizQe1HwTY6XRBvs7VuP28+F5J7fZRKc6Au31HlGY/toCAvLbpKR5QaRQ2wTRYgRs+u88zSqeWMpZylLJuruLxZPzgFit/pAHCAPzIrCgz4uyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200594; c=relaxed/simple;
	bh=SykKQMtWzLy8pGRrsXK4N9J9VCOWS92Z+FyxOGg0vyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pypzooOSJKS7wf69n3xijgZFhVjdnMdDlcwJKhYdRN3gEe3xxGY7lo5+ORnjYIAY61Lw3Nf1b8SerIuqP800X9v8oNcmeMEpiQmuMeizROLNZ/8t7lR0xuNsfYVLltKxUAwhTS577c2+VD8PbVJsdtS3x9E4piKdNH+GXJ969UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wRXc0kO+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtdlM064421;
	Wed, 12 Jun 2024 08:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718200539;
	bh=phRw86uY8cV8emkDsgG9EzaTMRWF0QIZYmAG4fjeGwo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wRXc0kO+vxIP0hLPKluzvObLrqapNLbro0IkQqXVQ3eukxLSvN1TYg6sR/XfOA94Z
	 l8p7Dlfagku/wR9mKLpeoBskj3xaUUX3onJep9HaEFWs25r9Q9hcHm/ooWNQZC9ORF
	 QzTnVzyZjyqhqfDea89aBOTkTp0W9jPwO3VF2aKE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDtdFk101150
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:55:39 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:55:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:55:39 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtclU092708;
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
Subject: [PATCH v5 5/8] arm64: dts: ti: k3-am62p-main: Add eQEP nodes
Date: Wed, 12 Jun 2024 08:55:35 -0500
Message-ID: <20240612135538.2447938-6-jm@ti.com>
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

Add eQEP device tree nodes 0-2 for AM62P5 SoC.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v4:
- No change
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 900d1f9530a2a..ede7351a4d864 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -857,6 +857,33 @@ ecap2: pwm@23120000 {
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
2.45.1


