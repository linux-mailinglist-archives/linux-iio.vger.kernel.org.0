Return-Path: <linux-iio+bounces-6165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CBD902481
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45D228489E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E622142E7B;
	Mon, 10 Jun 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U8nfTTYI"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138813B5AB;
	Mon, 10 Jun 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030851; cv=none; b=HU6fTYbRaCV8kzvCTCFNc89eOUs17Y41AmupzqBSw9zFBWJgtE2st/XE+DX3JXVgfrV6WKZQpr30cpvMo31vXxmQdE1X2dpOCZ7n52bjTXBerbNSyk4s42qXGcYvco2Gi3T/VDxhmOKT6Q9QK5+I8vyw6xReQURTrGqqs0amOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030851; c=relaxed/simple;
	bh=N011t8Qbe74VSNivjs5jkiaGFCzdqpLyIFhuVzRw0Zc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QXCdHKS48KGyXPSczkG1K4Tvj2fktPcsZFoeluqpG3hz8/Wwl4HRTx+UjKK1uoQCUvKK49QLh73h1S7eTg8RBgQsD7e/93oqQ3cVeU0Ex5c3V8erU0qZaozvv+FEvFkvyjqxW6GlGs1UAplwoNq/MtxjjKHnA53i+7eZzpviKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U8nfTTYI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkb2Q106712;
	Mon, 10 Jun 2024 09:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718030797;
	bh=GNLw44HVQwjzsrCtDDejjLqQbOTo7IhMoacj1jEQPrU=;
	h=From:To:CC:Subject:Date;
	b=U8nfTTYI11J+oWVdl8g93I4bOGIlwh81OZi72w08Y58ueKhskB5+SVqKN8JlfDAwB
	 HcpqlKpkDyhK6GaK11l5wgIyOPB6POLssKmoYnr9HeMHFIV4UgxAz4JcAyFeAtbOab
	 qpq2D1hvVy5lnrLMGSwxk3Ac8wgbZVGBhrq0UU/4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AEkbL6008171
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:46:37 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:46:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:46:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkbZn096515;
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
Subject: [PATCH v4 0/8] Enable eQEP DT support for Sitara K3 platforms
Date: Mon, 10 Jun 2024 09:46:29 -0500
Message-ID: <20240610144637.477954-1-jm@ti.com>
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

The series also allows the eQEP driver to be built for K3
architecture.

Changes since v3:
- Fix pinmux label name
- Fix eQEP node comment

v3: https://lore.kernel.org/linux-devicetree/20240607162755.366144-1-jm@ti.com/
v2: https://lore.kernel.org/linux-devicetree/20240523231516.545085-1-jm@ti.com/
v1: https://lore.kernel.org/linux-devicetree/20240418221417.1592787-1-jm@ti.com/

Judith Mendez (8):
  dt-bindings: counter: Add new ti,am62-eqep compatible
  counter/ti-eqep: Add new ti-am62-eqep compatible
  arm64: dts: ti: k3-am62-main: Add eQEP nodes
  arm64: dts: ti: k3-am62a-main: Add eQEP nodes
  arm64: dts: ti: k3-am62p-main: Add eQEP nodes
  arm64: dts: ti: k3-am64-main: Add eQEP nodes
  arm64: dts: ti: k3-am64x-sk: Enable eQEP
  counter: ti-eqep: Allow eQEP driver to be built for K3 devices

 .../devicetree/bindings/counter/ti-eqep.yaml  | 44 ++++++++++++++++---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 27 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 27 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 27 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 27 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 17 +++++++
 drivers/counter/Kconfig                       |  2 +-
 drivers/counter/ti-eqep.c                     |  1 +
 8 files changed, 166 insertions(+), 6 deletions(-)

-- 
2.45.1


