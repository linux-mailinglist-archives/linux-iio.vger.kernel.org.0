Return-Path: <linux-iio+bounces-6161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B4902476
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 16:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F28283D18
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1BC13E035;
	Mon, 10 Jun 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kkBqWBCb"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D7132138;
	Mon, 10 Jun 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030850; cv=none; b=lomiCe/xP2GDvo+hvM6RdYS8NcP9EeIgv3EPt32NZ9VTQrYmngC2iiBZCRRd/a1RFAeUnxKetLOQYZdmoHYfJkAFCEE/nhEVAV31kDFKmuH/Q3aadFh4xs2X0okaFq4ydLswrThi6UBedvL8JYC3I0T4+5U9sTt8/iBio4mu9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030850; c=relaxed/simple;
	bh=INvt5l95qumTkI/F8SMugFIWy6fo69X/mHJg2UAp33Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUlJiCcCwlg10YByRzGJGWWu1hDjtyfvoffXq7zN9sJ+Zwwjr2wJXgDuaxPJ8OGRqkS1+RRQLnMGIRqNspMABH+QMWE1z3LI+BR8xIfrB4L39RCgvRlhtRnz9aBOTQQMIFLgyaBAnonvqDqCWK+BsJdRkQ5v3Bui3iSJNjxpdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kkBqWBCb; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkcUr106721;
	Mon, 10 Jun 2024 09:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718030798;
	bh=DpD2/zDPTilNgEBMr9afh35OQ1ozwEcy36ZHdGX4oNs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kkBqWBCb8yOLKgD+HOmLqYRtT/F98uRxRlmhxE4UCxUNt0hO7zJ0Y7VBtI3JtrmkJ
	 mN04pepsPiaXqKachIVOUMeVotZtA+LBJZw0D9FiG7jt5ZMgc4Vg5vRpiFcA8lDVR/
	 ScJVz8mxdIn3oNBSQXivwjUdr2uwM2YpTZissZeA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AEkc1u008180
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:46:38 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:46:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:46:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkbZv096515;
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
Subject: [PATCH v4 8/8] counter: ti-eqep: Allow eQEP driver to be built for K3 devices
Date: Mon, 10 Jun 2024 09:46:37 -0500
Message-ID: <20240610144637.477954-9-jm@ti.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240610144637.477954-1-jm@ti.com>
References: <20240610144637.477954-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI K3 SoC's support eQEP hardware, so add ARCH_K3 to the depends
so the TI eQEP driver can be built for K3 devices.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
Changes since v3:
- No change
---
 drivers/counter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 497bc05dca4df..d30d22dfe5774 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -138,7 +138,7 @@ config TI_ECAP_CAPTURE
 
 config TI_EQEP
 	tristate "TI eQEP counter driver"
-	depends on (SOC_AM33XX || COMPILE_TEST)
+	depends on SOC_AM33XX || ARCH_K3 || COMPILE_TEST
 	select REGMAP_MMIO
 	help
 	  Select this option to enable the Texas Instruments Enhanced Quadrature
-- 
2.45.1


