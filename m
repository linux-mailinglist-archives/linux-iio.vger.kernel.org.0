Return-Path: <linux-iio+bounces-6206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853BE90548D
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 15:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDBA2898BE
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E05617FAC4;
	Wed, 12 Jun 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aT7XqjjJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9517D377;
	Wed, 12 Jun 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200595; cv=none; b=MKNcbdiHEJO+LwqD+NQ77GAsZbvXtgZfuQxG0AOdWJYIUZVawQ3qx2WFub45+DcRSOZ7i4IegjgFlRRT6M0kRhz/HLTiP2F6RUE1vFbBUszHxxMQaU42jHvwF2TgSMw/cjiJQuGihsGnxuMOn8SnO9NiK+oEPeUp135Gnr+z0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200595; c=relaxed/simple;
	bh=7LolFPbO1hTMMdKSlgj4lgHTXXs5+e4vcZPmXf+X2PQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKwemH+u4ZiJWVTZbSn5pun/GGgNIlqjnU6q7ICQ3b6F8nRzQc4ZYNYcv/LvwuPxSvaHf9W9sxJFgBDYF39J71IY30ySvR2tLPI0y5mRwMDwbTlFRtrAPm5TcESMa5w5k90zsIVeSdEWFd2FJg6yFnFPsW3/z/8z9+pzab6w4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aT7XqjjJ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtdEW119432;
	Wed, 12 Jun 2024 08:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718200539;
	bh=MJTQ6wU2tRfHsxb7YYfOMSHRUXUeBgzmXsMYDmJlqVI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aT7XqjjJK+tYrDgw215MtOSVloF3NqA1eOB/B9QTE646aEoiB+k/9Gr419iww60AL
	 pdZiCpvfJ35t/nSmPrfv+Q3GxUkRQbwLaeFfUznJ8M+uyxPceFa3hNtlxKMsn14dPw
	 n0wiRsi0SmYEBcmxCyJmLcJ5TuZ9wpienUus2rwo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDtdZ1112383
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:55:39 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:55:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:55:39 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDtclR092708;
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
Subject: [PATCH v5 2/8] counter/ti-eqep: Add new ti-am62-eqep compatible
Date: Wed, 12 Jun 2024 08:55:32 -0500
Message-ID: <20240612135538.2447938-3-jm@ti.com>
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

Add new compatible for ti-am62-eqep for TI K3 SoC's.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
Changes since v4:
- No change
---
 drivers/counter/ti-eqep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 072b11fd6b32e..cd50f267cf6fb 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -437,6 +437,7 @@ static void ti_eqep_remove(struct platform_device *pdev)
 
 static const struct of_device_id ti_eqep_of_match[] = {
 	{ .compatible = "ti,am3352-eqep", },
+	{ .compatible = "ti,am62-eqep", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ti_eqep_of_match);
-- 
2.45.1


