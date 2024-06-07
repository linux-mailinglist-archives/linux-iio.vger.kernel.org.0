Return-Path: <linux-iio+bounces-6028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CA900A54
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B32CB249B8
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9A619ADBF;
	Fri,  7 Jun 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QPEqrBqc"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2219AA46;
	Fri,  7 Jun 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777736; cv=none; b=FBKt5iVFDgyrzHqm/BTHX7zSeVsWHtTV3SJC6iLFPsc83NYXUXp1IFlhzkRVPc4LeuvtIqHQvOrBhXxSUFb/AzPUoVXfJdesqF3TmfIKb77Rrkf2qUToJXsF9/fVhCGAHrWbxXLxmxd5Vpz31/IKqkwrTLd+2Z/Bd0gIxn/9McA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777736; c=relaxed/simple;
	bh=XTWHkqWIyDe91hgNfhXt2jRfvS33k3nyN4qbDENL2hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXitSfSYrT7KRsCBOQDmLRlkDk5A0L9GxkGwoBU7Jcf6Vf7kYddE8nUstB3aPOTvOxbI5WiPHJ2vO24TeuJ267Q1LZOKMWVZ3ml78iY+Pa8yw8FrH74MjbWeUv98N4InXHjFGFtjs6X6pqpscuHr5drdSVLfMsUCnw98QX1dyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QPEqrBqc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457GRupJ025665;
	Fri, 7 Jun 2024 11:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717777676;
	bh=qq+KuYT7G30cKRziBmhag3H0joWnmY4ry28xoGzNFIg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QPEqrBqcX8t0tmEq6PXPjXU2d+tAkDhfBDw3gFj9Gx+KSy4lT+XmPU2n3XGvGDKpr
	 w4xULJxiUdDVUSSTFGInCEU/C3DglkKXaUCFvvW9wbcjoxGXOWqognstXVsK508E8a
	 374Swl9ruQaUazHcA7VzZZSdyp3V8/D+jhnZ3viQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457GRuRH058789
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 11:27:56 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 11:27:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 11:27:56 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457GRt1i068019;
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
Subject: [PATCH v3 2/8] counter/ti-eqep: Add new ti-am62-eqep compatible
Date: Fri, 7 Jun 2024 11:27:49 -0500
Message-ID: <20240607162755.366144-3-jm@ti.com>
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

Add new compatible for ti-am62-eqep for TI K3 SoC's.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
Changes since v2:
- No change
---
 drivers/counter/ti-eqep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index b0f24cf3e891d..f6850e142ddff 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -439,6 +439,7 @@ static int ti_eqep_remove(struct platform_device *pdev)
 
 static const struct of_device_id ti_eqep_of_match[] = {
 	{ .compatible = "ti,am3352-eqep", },
+	{ .compatible = "ti,am62-eqep", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ti_eqep_of_match);
-- 
2.45.1


