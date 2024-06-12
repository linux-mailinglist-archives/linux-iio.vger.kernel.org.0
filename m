Return-Path: <linux-iio+bounces-6198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC89905479
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B1C1F26580
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611217F36E;
	Wed, 12 Jun 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pS9J9L7u"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD817DE06;
	Wed, 12 Jun 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200593; cv=none; b=gj6TWTP8J1bU5VoWk16i3WFM1x/3SmA7PlRYXQ3L3UvPFKNPDuW3MnANVyHTWzMU6rFsGXZTBHQ2BvQU7V2AVRQ+ClkDuU+yO+CvIcwfOjR4bIWNfUPsUeoF4qjJahjDPxymVb2lbxy+lRcvgQWBV4ElA3CEi1/mZw39SCykfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200593; c=relaxed/simple;
	bh=cOw6vd1kBFTfvnsbOIpMTpqMk/21EngxUqjT1KCjVL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUCaevyGC1TEaItbevWsG4sVWCf8NcenBBazbwHpDX45c5t7ftA40yCra6ZGbI6LHeKz3Fh1FpU60A/YBUFh8g3WwwHW1cgHsJZdoIGgfnDDK+GyIgjR1qPQBp2jPaecsTYMC8M3mkQ9dsnVqK8mBwMqiMmlsQq8NGZEV0XN7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pS9J9L7u; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtddp119436;
	Wed, 12 Jun 2024 08:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718200539;
	bh=O21/XJ8Nr9AECG/6mhfZ0SgG8q2eniPF3B8RDzRj66g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pS9J9L7uwE80zFEmwlaHOp+rGj39LRvUs0SbARRwDMfXSy5lCjjGOzfnCHg3Mm/pn
	 nxIVqNlCx1KRKmupxYdwIhrPi15ZadDO54IRlqkOqQlgyL6FzuTnyB70hYe90Zcbrp
	 0hqo+L1ZtlGiqzf2uI/gEr/szmfaH2J+FYeuNjYo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDtdmo023646
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:55:39 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:55:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:55:39 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtclX092708;
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
Subject: [PATCH v5 8/8] counter: ti-eqep: Allow eQEP driver to be built for K3 devices
Date: Wed, 12 Jun 2024 08:55:38 -0500
Message-ID: <20240612135538.2447938-9-jm@ti.com>
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

TI K3 SoC's support eQEP hardware, so add ARCH_K3 to the depends
so the TI eQEP driver can be built for K3 devices.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
Changes since v4:
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


