Return-Path: <linux-iio+bounces-6032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BC7900A5E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC0CB25288
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E219CCE2;
	Fri,  7 Jun 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e/Jzn+6V"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919119AD5F;
	Fri,  7 Jun 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777737; cv=none; b=LEba6nUrLwQnSNOo0LjFud0E2PX7X3PAEB0pgPpabY3waZNuSMHPHv9DqOHnTXt7JXu5uA0LVwYlUrTXmTp4MVY/6bZ41G6PhvorqJWs9LZ+ZHdBsEu5AKuQFW95iTWjJ3GEBAQw0dO7v2KeY8ejFgRczcWBPZSKbX1DMRbrYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777737; c=relaxed/simple;
	bh=LGYcD/GKncMY5oK8Nz3hBIpZWTX1l7ulfUh1j09n7V4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGqlkPx5d4DDsAz4PQubsyhlcfNVzw2hE3fiQJ8PopNUaP1sWeLwQzqnHtEIPHvYYX/aeeko8GFukCiQRO0GKQC34RLsTH9htstcxxTABuWQqWarWooDLU90YvgqzJ2o+QpueTTOoLIcGOfFTTFayRwKWtCgOzK+jGYMlIXAXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e/Jzn+6V; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457GRvjc025672;
	Fri, 7 Jun 2024 11:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717777677;
	bh=eCMwvUXMlOHh+kQoB/O+Bk+VnI6B6QKbo0H+hfHKoZo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=e/Jzn+6V6xPwJeK5wOiesxtGjkeWs3YVDrLXmvPkYXTUPZZaxgtpSWrdra8awMKzp
	 D0UtDKY3J2qvuDu0oinCei2aQRNBqExm+jIVxdwasAtpTUJMMfgF1Gwfh+uTfvNEyR
	 SSsHPOabO9CtzGJpw8lxnTX6Tx8W5i4j0VQ6KXgE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457GRv5g096188
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 11:27:57 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 11:27:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 11:27:56 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457GRt1o068019;
	Fri, 7 Jun 2024 11:27:56 -0500
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
Subject: [PATCH v3 8/8] counter: ti-eqep: Allow eQEP driver to be built for K3 devices
Date: Fri, 7 Jun 2024 11:27:55 -0500
Message-ID: <20240607162755.366144-9-jm@ti.com>
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

TI K3 SoC's support eQEP hardware, so add ARCH_K3 to the depends
so the TI eQEP driver can be built for K3 devices.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
Changes since v2:
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


