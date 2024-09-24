Return-Path: <linux-iio+bounces-9762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B62984D56
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 00:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660C51F24CA7
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C85155C96;
	Tue, 24 Sep 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b5UJcmth"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F5148318;
	Tue, 24 Sep 2024 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215679; cv=none; b=Rar7OdrQMY7gaLiTkNMnERYrIGEXDkE1O3xHWYX20WmcZiWcjzwhRVMRORkbElIIiVLQ46gsvWjaF5BFtuqzU1wFnds1VwCFADJnZWxzhDYmXLjRrOwxEUqHir/D8UPGj78AXbOtNPvl2Fso4Gsh04XMXNMsnmRYpPoNO8IFC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215679; c=relaxed/simple;
	bh=qyJXB6XtGsnhwAscLTJHdsYASer9Z8FVyGOAJPtx2Fs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ixQjKpCNo81jaFKNgTKfip/T9jSii0LWQTM64FSbVuukCPxsFxtKd7PqYv4XPRBVTXlzW5ewz6BT9Rr2PiDxRmTHyIBNKGRisYR/1bANruaqpK5XLKiPJJJO8gze9pqCqTG0co+liafApmSseZDxfwlcKBFx7wVlOtSqaD/88lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b5UJcmth; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48OM72Wl054734;
	Tue, 24 Sep 2024 17:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727215622;
	bh=BXKvnXDLj7jSM6JjMTT9Viqz6Jqilrg95I9/ydv1LQc=;
	h=From:To:CC:Subject:Date;
	b=b5UJcmth3e1ruxRlqhciXlGjOysTVlGIXfST8g6pcEv88J7XwzO6vbxQXFNdQAQJc
	 7EyWF8JZ+m99fXKq6f2v1XjziklVd/ifcoy1PhGDiBwYXf++DpI7rzZ3m4HDXQFz/2
	 DDYBDVylCBlC9QJPXRaHR5q5rKyHF/Cv0Rdg1YWg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48OM72g2019399
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 17:07:02 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 17:07:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 17:07:02 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48OM72lR037639;
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
Subject: [PATCH v6 0/5] Enable eQEP DT support for Sitara K3 platforms
Date: Tue, 24 Sep 2024 17:06:55 -0500
Message-ID: <20240924220700.886313-1-jm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Git rebased the series since due to merge conflicts, part of the
series was not merged. Also dropped the patches that were already
merged.

This patch series adds eQEP DT nodes for K3 Sitara devices:
- AM62x
- AM62ax
- AM62px
- AM64x

Changes since v5:
- Drop patch 1/8, 2/8, 8/8 since they have been merged

v5: https://lore.kernel.org/linux-devicetree/20240612135538.2447938-1-jm@ti.com/
v4: https://lore.kernel.org/linux-devicetree/20240610144637.477954-1-jm@ti.com/
v3: https://lore.kernel.org/linux-devicetree/20240607162755.366144-1-jm@ti.com/
v2: https://lore.kernel.org/linux-devicetree/20240523231516.545085-1-jm@ti.com/
v1: https://lore.kernel.org/linux-devicetree/20240418221417.1592787-1-jm@ti.com/

Judith Mendez (5):
  arm64: dts: ti: k3-am62-main: Add eQEP nodes
  arm64: dts: ti: k3-am62a-main: Add eQEP nodes
  arm64: dts: ti: k3-am62p-main: Add eQEP nodes
  arm64: dts: ti: k3-am64-main: Add eQEP nodes
  arm64: dts: ti: k3-am64x-sk: Enable eQEP

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 27 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 27 +++++++++++++++++++
 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 27 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 27 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 17 ++++++++++++
 5 files changed, 125 insertions(+)

-- 
2.46.0


