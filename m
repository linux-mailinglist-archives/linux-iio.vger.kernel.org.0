Return-Path: <linux-iio+bounces-6031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BED900A5A
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 18:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72F51F22200
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B08719B599;
	Fri,  7 Jun 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VNIx7AMT"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7119AD46;
	Fri,  7 Jun 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777737; cv=none; b=IOu/JGTMMQUe1PHuoELxqkcDD+G5tXPp+9alzbrzBvOZySAeLiTdqFIcEWBcR2yR2yNOWkP4VKnyohGNxRo1N3Ssclkim7KqcEs+Gu8XPysrQNzW56F9Y7k2LwHfh/kKoPekVKK7OyOYrHqMiajsqFajuTqmCf9UXpGJfWN8E28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777737; c=relaxed/simple;
	bh=9r1L8vpxZoxo2+rCjavv5ZRVk3uQ698rdzteAhQsQXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oN7qR4Ue/SlYb/SWB1uvUdL3k0LPNOsjhaKM0AjTQMTtPLqzXuqLKG0560nhtRYj7I7ZXGs+lVmSK+Z6fIYWHVD4jcAiL1ZB7/PkmhyewJ6dfBbcxrGmcF+YsxAtdLXXcsV27waC7IekoixANh1XZ6aZnW6uHmj7bkZkQq1040M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VNIx7AMT; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457GRuu2075995;
	Fri, 7 Jun 2024 11:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717777676;
	bh=kno6ACLOq8Y9n1TpA0E35jfWU5eoBQgLbX+JqdbSDCA=;
	h=From:To:CC:Subject:Date;
	b=VNIx7AMT27XFAmnO7PMzAreOl+ioVwJzyQFCwWNDxzudb/PxOgbew0YBI2SaTp9dw
	 xzazxmENrODeARNwb/Umgy+YOVUr0l83DP8VF80yFxbYEX1I02DfHkwHTwVJrqymBa
	 T1dYjYxYngEdywuIxHUEBgdm45hjMpP+eIv7E4P4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457GRuxj016585
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 11:27:56 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 11:27:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 11:27:55 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457GRt1g068019;
	Fri, 7 Jun 2024 11:27:55 -0500
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
Subject: [PATCH v3 0/8] Enable eQEP DT support for Sitara K3 platforms
Date: Fri, 7 Jun 2024 11:27:47 -0500
Message-ID: <20240607162755.366144-1-jm@ti.com>
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

Changes since v2:
- Drop patch 8/8 ("Enable TI eQEP Driver")
- Enable eQEP0 in k3-am64 SK board
- Make clock-name optional for ti,am3352-eqep compatible
 and do not allow for ti,am62-eqep compatible

Link to v2: https://lore.kernel.org/linux-devicetree/20240523231516.545085-1-jm@ti.com/
Link to v1: https://lore.kernel.org/linux-devicetree/20240418221417.1592787-1-jm@ti.com/

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
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 18 ++++++++
 drivers/counter/Kconfig                       |  2 +-
 drivers/counter/ti-eqep.c                     |  1 +
 8 files changed, 167 insertions(+), 6 deletions(-)

-- 
2.45.1


