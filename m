Return-Path: <linux-iio+bounces-12242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C079C8797
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CE81F21058
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351581F7097;
	Thu, 14 Nov 2024 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZJukTb2O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A11DFE28;
	Thu, 14 Nov 2024 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580081; cv=none; b=Ls1vmbP0TtyDpoOjq+hImBS/xIoULjIRb+0yPJFt8I47cF23JtY8xh70SnvOlRs+Kyv8zekhv7ffqvNcJJ/ArqpoWXFmD2KfywMAAnb3UWrnOtqlRl0Tl0iSn4hTU5++vKNxWm9loYP074pezBcyRNHtp7HMJ494Zpa+agf7LUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580081; c=relaxed/simple;
	bh=jLJs8CwQOwELsO9XTQy5DE6dRpuwI0PxDLdNbN2siyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QreCC4+CA11+FaazXNQk52+w1Nuli8PAKwUde8u7pNIHjmIbLLHpt6kqqHi0DOiVjwOfrEB6yqbXX/RybHou1f603B8vt8up1X8+aJ1ub9C2jK/04tr126051cFpuUNe5wjYOpHcG5Uye+ZBKM6rgGos+UyBoKKzhPp/1vBBx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZJukTb2O; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE5jwNC016652;
	Thu, 14 Nov 2024 11:27:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=7MbnE8ms6zYSIbpQhA3TMj
	1iM72Lewm6wm7M7VcisaY=; b=ZJukTb2OEWCMoCvRWZwh75QtRm1O0SCRqkwOzW
	9wFlBALJ3Zx4vYu+qf+vAh80ujPAak9qvnEr/4MmKVYQbrWrhkktFCPX7rdkQI9i
	ZQaXem7W53Gu4TWHS1J5feYoCYetyvKo0BZRiEbDPO74ax20dW1Fz1FE3vq1rhFP
	8Hd4YYSCAJgj+BqoA6oCAN6Gf6gRsf7HcSBg73JEJpY5WD1s6ruz+396KIWjIzzg
	meWbxokrGYOYZBDyOkSpc24hW3tKi95HEqk2iIM9eK50x0wiDSqfgtbACbbFcyva
	P8pyjR1pDxsIlXOduJG7szNapmeqpn2FyyF8/z9M3GKMdCAw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42syggxh32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 11:27:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D9E5A4002D;
	Thu, 14 Nov 2024 11:26:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60E1F23F998;
	Thu, 14 Nov 2024 11:25:16 +0100 (CET)
Received: from localhost (10.252.20.241) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 14 Nov
 2024 11:25:16 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: stm32-dfsdm: handle label as an optional property
Date: Thu, 14 Nov 2024 11:24:59 +0100
Message-ID: <20241114102459.2497178-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

The label property is defined as optional in the DFSDM binding.
Parse the label property only when it is defined in the device tree.

Fixes: 3208fa0cd919 ("iio: adc: stm32-dfsdm: adopt generic channels bindings")
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 2037f73426d4..e304e3714020 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -691,11 +691,14 @@ static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
 		return -EINVAL;
 	}
 
-	ret = fwnode_property_read_string(node, "label", &ch->datasheet_name);
-	if (ret < 0) {
-		dev_err(&indio_dev->dev,
-			" Error parsing 'label' for idx %d\n", ch->channel);
-		return ret;
+	if (fwnode_property_present(node, "label")) {
+		/* label is optional */
+		ret = fwnode_property_read_string(node, "label", &ch->datasheet_name);
+		if (ret < 0) {
+			dev_err(&indio_dev->dev,
+				" Error parsing 'label' for idx %d\n", ch->channel);
+			return ret;
+		}
 	}
 
 	df_ch =  &dfsdm->ch_list[ch->channel];
-- 
2.25.1


