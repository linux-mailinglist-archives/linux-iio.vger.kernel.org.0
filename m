Return-Path: <linux-iio+bounces-18131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C7EA89DE1
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 14:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C718189FE68
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F452296D18;
	Tue, 15 Apr 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xROH9WJJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B54296D12;
	Tue, 15 Apr 2025 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719717; cv=none; b=TKSPig+7ajbEfNlihADgp5jJoitQDpRos2zZbJLtMt3EVGESzUSScMH5AQFnyiZcKt4KVuTA/iyRheEt6eUslJ3IGfhTtnZrYJMyYdWb3DS1yQzGyoE+6a5uDrr2jMZMfwUpyKBxP+KAL6acz3YaMFvtG2YTwo1U1daDDqJ7918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719717; c=relaxed/simple;
	bh=IELIMLjBjaGBaSjoaaPlcfY2mtZY+fdV73O+G80GU4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j/vI919acNYmcUOB+AQO6i8bWdHJmnAvxjwE+WL7HlBVdqguQamMCgV99MG6kRKyPMqVE/aqVBdRi/6uYwXKYcORKP9bcqHw0S/JFRgm2i9E0S4dkDfpeN5OYIZ0p7SNyF5IPOXFAVxmcDL94+vNm9/FXYThZJKRgTyQ7pjB/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=fail smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xROH9WJJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBXnUu007590;
	Tue, 15 Apr 2025 08:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=pVJOZFhDVjnDo6D1R6xX4H51lpe
	3Ag2BzfnILzseXcg=; b=xROH9WJJYCBKVVXqSxvsP22Jxcv0F2bTEWpjoHCnlZh
	tRslK62sgy7SxvkAp12NUZUc7o4dLfZcl0TK6uLwNUvfCbnQFpNxN0RSMD3h6iJ0
	1lM9rUBuIEwpXibV5B//y6pBH4sUq6knwYrFe5+UJT4Hiv4MLDN6qvQCwIWmII9D
	WZQfkycspkttEQoe3Pnow1VwJpHKW00p7TlP+E589+Qwa4YBt5dMGsU7D7Gi7/m1
	Z5wXTBIGRle8dMErVeishw3UHMdX55Gxcgm3K4HlrhpNVAhXPBmab//GFN0BKYH/
	FmZD0YBwabfxLM2E7gYJ8xQdk8fdcLlgn2+JvKWkBhA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45yn37es15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 08:21:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53FCLVLY003466
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Apr 2025 08:21:31 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 15 Apr 2025 08:21:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 15 Apr 2025 08:21:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 15 Apr 2025 08:21:31 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53FCLG4e013198;
	Tue, 15 Apr 2025 08:21:18 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <marcelo.schmitt@analog.com>,
        <marcelo.schmitt1@gmail.com>, David Lechner <dlechner@baylibre.com>
Subject: [PATCH] iio: adc: ad4000: Avoid potential double data word read
Date: Tue, 15 Apr 2025 09:21:10 -0300
Message-ID: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=FogF/3rq c=1 sm=1 tr=0 ts=67fe4f4c cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=XKF0PoAx1WVWLetZYlMA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: IuknmNQqfNYk8iVCtX9hxO0Zb92r1m5T
X-Proofpoint-ORIG-GUID: IuknmNQqfNYk8iVCtX9hxO0Zb92r1m5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150087

Currently, SPI-Engine offload module always sends 32-bit data elements to
DMA engine. Appropriately, when set for SPI offloading, the IIO driver uses
32 storagebits for IIO ADC channel buffer elements. However, setting SPI
transfer length according to storagebits (32-bits in case of offload) can
lead to unnecessarily long transfers for ADCs that are 16-bit or less
precision. Adjust AD4000 single-shot read to run transfers of 2 bytes when
that is enough to get all ADC data bits.

Fixes: d0dba3df842f ("iio: adc: ad4000: Add support for SPI offload")
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
After enough sleep and some time not looking at this driver I finally realize
the potential issue David was talking about. Although I didn't see any clearly
wrong reading when testing it last week, I'm adding the fixes tag since it's
probably easier to drop the tag than to go fetch the commit log.
Also adding a suggested-by tag.

Thanks,
Marcelo

 drivers/iio/adc/ad4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index e69a9d2a3e8c..5813db28510d 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -941,7 +941,7 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
 	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &st->scan.data;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
 
 	/*
 	 * If the device is set up for SPI offloading, IIO channel scan_type is

base-commit: 1c2409fe38d5c19015d69851d15ba543d1911932
-- 
2.47.2


