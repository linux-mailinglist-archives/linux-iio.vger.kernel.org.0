Return-Path: <linux-iio+bounces-6203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5E905484
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B982892DC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA917F4FD;
	Wed, 12 Jun 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dEWCc4/6"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869C17D8BE;
	Wed, 12 Jun 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200594; cv=none; b=VykBqucvzYUjUWOpuLvfyfydWBpY9b2Sbf099bLdL0iXWNnt7fYyvl3WcbEyigZ9V65FoSI60z7bqeL5Gp+Af2TcmMJeSmMY3GOeF5kpmVCH+buI6QsFJoCDG1+NPgOKDttlRhjM1PCz8a3Z09S3csQEpRkg2TGYLZL5wQXzJvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200594; c=relaxed/simple;
	bh=FqtsYuppTS5u4cb+Sf3ViIlNwzPZPNBv+HyN97lzj0w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NwUbo7nBEhu0QWDzo3qRlgwlCI509AjI6Sfuzim2BKQYviMz7g3xNQtHa2b5cgknQH8nGcbapD1Vjr4OTba6lQoM8vGKucnoLXsqQObVpbEB6z4/+6CAGpErEJLpnZBehpFtPyAxDJFzq17439lzpNbqvThiqCi7kV8MkMYijqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dEWCc4/6; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtdN7064413;
	Wed, 12 Jun 2024 08:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718200539;
	bh=A/lBUPJPik8y3PYGDopVYEQHZdcuATAO+Xfzy0UsrIk=;
	h=From:To:CC:Subject:Date;
	b=dEWCc4/6q6XpCUX2a2LmzWwhw3m1BsBMtXzv//0pVQMfDZiU6MOKmZcC0BElAhUPy
	 LDdPoj5B09/Qid6L/pkQiyusgQ9dM0BosU71dCqqqFiaFsUbtgJSoKhjHWGFFN7hp2
	 jZvduxgYBCF0sT25Z0Zb2WakIELOuCT/D9pPlwJk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDtdO7112377
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:55:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:55:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:55:38 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtclP092708;
	Wed, 12 Jun 2024 08:55:38 -0500
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
Subject: [PATCH v5 0/8] Enable eQEP DT support for Sitara K3 platforms
Date: Wed, 12 Jun 2024 08:55:30 -0500
Message-ID: <20240612135538.2447938-1-jm@ti.com>
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
- Drop the new example from binding (patch 1/8)

v4: https://lore.kernel.org/linux-devicetree/20240610144637.477954-1-jm@ti.com/
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

 .../devicetree/bindings/counter/ti-eqep.yaml  | 27 +++++++++++++++----
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 27 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 27 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 27 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 27 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 17 ++++++++++++
 drivers/counter/Kconfig                       |  2 +-
 drivers/counter/ti-eqep.c                     |  1 +
 8 files changed, 149 insertions(+), 6 deletions(-)


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1


