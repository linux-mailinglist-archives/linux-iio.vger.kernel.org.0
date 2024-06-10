Return-Path: <linux-iio+bounces-6163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F0D902479
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0911C2133D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5F13FD84;
	Mon, 10 Jun 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tKvpp2Xw"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0925135A6E;
	Mon, 10 Jun 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030850; cv=none; b=l9C8DE6i0UDN+nC37azAoplYETRps1r4VxauyhBa57kvMpv94dEhHVHDclig6CqnlWCkXTdg4innkEtA3THU1JCIS3CBNEV8m8TMiqs9BH+vuOehSwMtD0ylo9S2zIe1hBfXuoe419l0TOh8SZFRNNHdPIZmFLN16Zs9JB08HXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030850; c=relaxed/simple;
	bh=uNnDgO5xLq51LKRnelJAsvnC4MM5syjGqt6BU4XLpT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaH44DcW2iRyXVzC33z4SdkQoE+2dR2JQ7TYgQ3Y9yDV6kOfcnJOPmZtQpWab7VZoWwnf9Hi76MelsB7YD0YrRYY805BGDGkqPN9KLn1h+CecIE50p0vHs7nshxkJW46g/ULq5AD4BtvtxzeB0/eVa3YZnDEqolA2sPa073+Bco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tKvpp2Xw; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkbmY004256;
	Mon, 10 Jun 2024 09:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718030797;
	bh=XmOWBSSAoFFFH7KsCf/zF8wl2rZPgic4q0jLDBGONrM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tKvpp2XwAwBkV7PpM2fEb6mAnxzAYqo4yif49c5fyy+/35gjCaUYq2P3mRskrgz9J
	 DVhyL2WjexCV0tB8pTmK77RUJ6ZB/fhOJOiVNHHc0B8t2DexeMS5AdCeevsC1ISEeC
	 WchvwezHA5PkEIknDnufy0vfFpaAVl67+eCfqyis=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AEkbT9125165
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:46:37 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:46:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:46:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkbZp096515;
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
Subject: [PATCH v4 2/8] counter/ti-eqep: Add new ti-am62-eqep compatible
Date: Mon, 10 Jun 2024 09:46:31 -0500
Message-ID: <20240610144637.477954-3-jm@ti.com>
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

Add new compatible for ti-am62-eqep for TI K3 SoC's.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
Changes since v3:
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


