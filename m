Return-Path: <linux-iio+bounces-5240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C108CDD7A
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 01:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CED61F21CE4
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 23:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E42129A93;
	Thu, 23 May 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xgkXqaD/"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978BC128365;
	Thu, 23 May 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506193; cv=none; b=qmn0x+olu6rTnb4Mk/xE+yLPqMXH3HyiwIeT89vQCqgTV9/BcM+u8ZZrpyY9SiuGkP8gpNAsCOY6DxmJY3T8BWzqI0PUHiVmElcn66Pz7Gu18fLg7xLu7I0Jj2Je5kA1oP0+nw0nInjFaqF3wsNsZAVrRlSLQ3pfMOWU/yJQJws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506193; c=relaxed/simple;
	bh=w3FVlpgXc9fXZpLX1ft6ZyAQ/mXCFoTSn6q6NYD5DM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRQfHTyRqKwVcEx/m2k+WuS7Ilih3kikmKl0+NtyvIFvLRDaUvzHz0hNmIatA9fQyTdKIPuAwMj9Et3UQFOi/cLrrCu2c4zxGOOOX32VIESJghDIOQ4/8rSXo7qPZyH5GQQcUKiszPvpnE0i/peZfG1E87x54FA2CP3troxzeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xgkXqaD/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFHvA035343;
	Thu, 23 May 2024 18:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716506117;
	bh=zME/Z2ylqO3L8pwSFiqVG5UTliz6kRk+vTJ9aaQMxSE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xgkXqaD/6FYNGuqF/X+Uw+ZdcimgUwgfEbXRvS33+ictaf/Aw4q8rVBNSZwdj0uVo
	 NucbbHRi8jSyXjjUnq2N/PBz+Leg4p5e8QFCOrw7cfIA6lG0tjKVGK4RuQIOI8z/uv
	 GSxxYuOAumEAsFkiZ6MwnhdkiFVM3R8sdYQgGP9M=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NNFH4L022516
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 18:15:17 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 18:15:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 18:15:16 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFGqR008143;
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
Subject: [PATCH v2 7/8] counter: ti-eqep: Allow eQEP driver to be built for K3 devices
Date: Thu, 23 May 2024 18:15:15 -0500
Message-ID: <20240523231516.545085-8-jm@ti.com>
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

TI K3 SoC's support eQEP hardware, so add ARCH_K3 to the depends
so the TI eQEP driver can be built for K3 devices.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
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


