Return-Path: <linux-iio+bounces-5236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5417A8CDD6B
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 01:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39F61F2191F
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 23:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EBF128370;
	Thu, 23 May 2024 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rBc97HNN"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6122628D;
	Thu, 23 May 2024 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506180; cv=none; b=KiiyVfaww0eMkcnp4fKKdVncIrjUI3oTxBV9qS7FFwn2C3etVNb9iMJiXAr+wExkCa4m9vVvcfEzn7MHV1NcpqMiNVkoY6UGlzzUpqBe4lbv3xgkLQC2khiRzruhzQpbaVhAxze0OPS7RAx+qYDMLmVyyBt6LuH3I3QSAfDQrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506180; c=relaxed/simple;
	bh=RMvLc10WWkec9Bi31rmmFKbk2xAmd6fxCrUUK6JQnKY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BByClvYGaFDO9BOrE37tbVG4WB8hbNeNgg8c/L42zg9lziZp9SDA+sA5Bop+/7xXnko28CsMA79KcSK4OBCgCWoShOnLtDhVkvQOle53toltdYYryfbsrm7UDyk1Uzdhfw3hi4xoEUoq4ZjlLYkNa+YJDjf22enDzPFJW7XCJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rBc97HNN; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFGDH024880;
	Thu, 23 May 2024 18:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716506116;
	bh=qZ1DEGnaLNezLOzzeQrglFpvM2/JdS3Dq5AU/Q5NwRg=;
	h=From:To:CC:Subject:Date;
	b=rBc97HNNBmZj3M+HyXfTX/UITDf7MiizL6f6aj+cprIVXkE9cdh+ac1SHWFEUfpdx
	 HDRCqaUZM+VSrrwbG9GbV5NeBcVefcCuPnfNt4qXKiJHy7hdSxK6P2u9R5XuYSuYEq
	 cFezM4fZTjCsTnLhSHSedgiJ21Kz/0W97TYL1BcQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NNFGrl047687
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 18:15:16 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 18:15:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 18:15:16 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFGqK008143;
	Thu, 23 May 2024 18:15:16 -0500
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
Subject: [PATCH v2 0/8] Enable eQEP DT support for Sitara K3 platforms
Date: Thu, 23 May 2024 18:15:08 -0500
Message-ID: <20240523231516.545085-1-jm@ti.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch series adds eQEP DT nodes for K3 Sitara devices:
- AM62x
- AM62ax
- AM62px
- AM64x

Also enable eQEP to be built as a module for ARCH_k3.

Changes since v1:
- Add new compatible ti,am62-eqep
- Fix eqep binding for new compatible, require
 power-domains for new compatible
- Fix eQEP DT node to use new ti,am62-eqep compatible

Judith Mendez (8):
  counter/ti-eqep: Add new ti-am62-eqep compatible
  dt-bindings: counter: Add new ti,am62-eqep compatible
  arm64: dts: ti: k3-am62-main: Add eQEP nodes
  arm64: dts: ti: k3-am62a-main: Add eQEP nodes
  arm64: dts: ti: k3-am62p-main: Add eQEP nodes
  arm64: dts: ti: k3-am64-main: Add eQEP nodes
  counter: ti-eqep: Allow eQEP driver to be built for K3 devices
  arm64: defconfig: Enable TI eQEP Driver

 .../devicetree/bindings/counter/ti-eqep.yaml  | 53 +++++++++++++++++--
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 27 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 27 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 27 ++++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 27 ++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/counter/Kconfig                       |  2 +-
 drivers/counter/ti-eqep.c                     |  1 +
 8 files changed, 159 insertions(+), 6 deletions(-)


base-commit: 534ad093bb80f19c20b251a89f09ce1a0e3d4f2d
-- 
2.45.1


