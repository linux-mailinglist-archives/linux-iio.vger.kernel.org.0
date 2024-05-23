Return-Path: <linux-iio+bounces-5239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F068CDD74
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 01:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3BE283AC5
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 23:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF7F129A6F;
	Thu, 23 May 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RhD3ufVC"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8542127E1F;
	Thu, 23 May 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506192; cv=none; b=Q322F/p+/3fTIdrfDfYfhb9GC/2kwfmAQDATRwads4W/OVfWjAADUMmVYJ+2PGLHTJmu+61i6lju7WUBJjvc7K3BaZf2bxBXbD7jFMiq8HiimbFBhndupo7Y2eVeXYQxyeXV1vKP7aAIPjZ0HCq/LTNMPf7WR+yAqDEqeVuiyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506192; c=relaxed/simple;
	bh=7w2a51UaKxarzqzM7pJtSiUaDkAWGTvnUINgHqdFuV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQj41tRPD8c+WU6zzPD7HQodvObfHAVXGqKgeHR89kJGGPvbhdsSmKMTG57VcUV2Km4bTH8+MQ2c+w9O57+kSH4WxYvU9f4c1hbg0mPO2kJvTIED78LDClFJzwwjlp5qY33KbeWpvsSq86WW0SpKjrc+Qx5gE3t1fWa1MURLNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RhD3ufVC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFGFD117071;
	Thu, 23 May 2024 18:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716506116;
	bh=q19jeaCQFXtosVWBpMk1pGxAbpQGyV41IyPxtR7L6rc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RhD3ufVCDsdqfDn0EqxPGgyO5xcCBlL/KTzJDbRM71H7dNDHBy0JljGF6qPtt9wIM
	 y+efku/eZ1EjpM7g19Wd9CLbNeEzsNAQbJ2SeKWKS2hWLpXIyf96js3NhxjOQHPH+j
	 0erQNuPsxuCmdlemqIXk+HPlXL47w0b4fpdk9g54=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NNFG4Q111066
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 18:15:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 18:15:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 18:15:16 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFGqL008143;
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
Subject: [PATCH v2 1/8] counter/ti-eqep: Add new ti-am62-eqep compatible
Date: Thu, 23 May 2024 18:15:09 -0500
Message-ID: <20240523231516.545085-2-jm@ti.com>
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

Add new compatible for ti-am62-eqep for TI K3 SoC's.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Add new compatible ti,am62-eqep
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


