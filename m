Return-Path: <linux-iio+bounces-5238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2F68CDD72
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 01:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5811C2104E
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 23:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713712881C;
	Thu, 23 May 2024 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d1YwV1wa"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F282D83;
	Thu, 23 May 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506192; cv=none; b=VEj7GFtsjT+tSjFQfwCgtg8z30km5cxmIHD0iJciW84v4BRxFLSa+//ydhFtO/kgQ+ANJBF2Il9hWNq8O4fwPFFEsFRZaj2vNllOZ/ZZQ4OHwPApgYK84gNB9zuDt0nzGFpiGIbrkNuFXEGWxpDYb8tS6bMmLLvwmefQOSk1AEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506192; c=relaxed/simple;
	bh=cLErUw8qY59WfzNbSCseF2h9TWh1n1R9lbqIIBgcRKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuYTEm7qXWNK7P1FVVfn//QGiMcHqBA4UIiIaJnaA5Aqhx1rRcxmQywNUTei4HwQWzgT6ulOq9z7zautKq2wYWz3R6RqKcucTkrU8kj8OhCQWbv36S0so4rvP17RddwMxG4EYPTuBZas8dHBBs7jVT7Q9qvGPEf0MCLM1Y8Oai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d1YwV1wa; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFH7r117079;
	Thu, 23 May 2024 18:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716506117;
	bh=AWN/I0yky+1/CkoEwQUxLaCCwtG1xFx236NM/NCPa0w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=d1YwV1wauDVJPaoLqG6Ypmb/AK8ZOk9nsLYo1Ukv9Jf/vrRrYhMzAekMrq/mH6YMT
	 ASBe71XtLPaG7LXoraH+rlEjoWdgHlFFLcNC63eBZp/y0VCLSEB9TBqPcbLOYmQa3O
	 +jH01ryXp3gvFKkgcWoP1fUDxJTWWtfepdCZNLus=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NNFHLo116686
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 18:15:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 18:15:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 18:15:16 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFGqS008143;
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
Subject: [PATCH v2 8/8] arm64: defconfig: Enable TI eQEP Driver
Date: Thu, 23 May 2024 18:15:16 -0500
Message-ID: <20240523231516.545085-9-jm@ti.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523231516.545085-1-jm@ti.com>
References: <20240523231516.545085-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI K3 SoC's support eQEP hardware, so enable TI eQEP driver
to be built as a module.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- No change
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e1802..23d11a1b20195 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1593,6 +1593,7 @@ CONFIG_INTERCONNECT_QCOM_SM8550=y
 CONFIG_INTERCONNECT_QCOM_SM8650=y
 CONFIG_INTERCONNECT_QCOM_X1E80100=y
 CONFIG_COUNTER=m
+CONFIG_TI_EQEP=m
 CONFIG_RZ_MTU3_CNT=m
 CONFIG_HTE=y
 CONFIG_HTE_TEGRA194=y
-- 
2.45.1


