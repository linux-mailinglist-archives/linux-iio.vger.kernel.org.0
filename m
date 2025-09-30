Return-Path: <linux-iio+bounces-24573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F69BAC84A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 12:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BD1188C46C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 10:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E62FB0BE;
	Tue, 30 Sep 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F3j030sb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B282F5473;
	Tue, 30 Sep 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228380; cv=none; b=W+AQiD1/kqTEIpCzigjm3BhBheAVg7XNEdJSphLlGHQahS/Iq06z0n4+Dd4Rj6zjETzEXrZ2T0PR9TMeWQgzmgBwJEH1cBFwUcXkENNs/qoFXlRr/d9t+LafiBHmOlzR2s+W/pdwta3nvu207XdlIBy04QMSpV7MmocozNoBGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228380; c=relaxed/simple;
	bh=9duiM8gswFJie7vpR8z51ToeGkTtCOicnlTUgffqUmw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nD9nybRA+WvYj20hrCB+KofwNoBkyNqfV/VAA4MqBsfhWXmK1EfLGmg8pccTR+dd2sJnwhlYiu541pD7VmyLP53Emz1+nlkF1caXe8Ppr6J464mRqrMgQkN/CmzG5+anf7sO0YgcIKg2OYO//A/jeGbMeV4D1pJbFHjkpjgzd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F3j030sb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U8FgKH026774;
	Tue, 30 Sep 2025 06:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=zVyXd3AeZtulnXimJJjnFYDldqM
	Ss0yb0u4/1hoikqE=; b=F3j030sbfoJgfpKbh7/62M9fBnKL8AKWKt+AP9K8TxS
	O7+//2oWXs7Of4cqd0bamZRCrwtiLMX3sE16KW27PokAaF8peIqEGCCDq6rU4kxw
	c8kTlhUKPLCKB4RBkOwAEJvL2+Nc+q2TSAZ1H+wpIKjmpDFgi2sBWoCctu3lhg1p
	7V6/2N3N2LX6INQwK+Nb6ee7hRirWLebIyceT2AWhduwND3VMteivMm1hwjdl9bV
	Mh70GwGRNRxaZAP9amK5LKLcyUfKvaD4g5zImN6k7Ge/jAKZIp9zP/LlCvMpW/3p
	Dkz7/niIHbqJsHXePigTyQt8QSSIUVdiEotRC9Own/Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49g7sjhwnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:32:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58UAWsQE027466
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 06:32:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 30 Sep
 2025 06:32:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 06:32:54 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58UAWipT025133;
	Tue, 30 Sep 2025 06:32:46 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/6] iio: adc: ad4080: fix chip identification
Date: Tue, 30 Sep 2025 10:32:24 +0000
Message-ID: <20250930103229.28696-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: oXu39g-Pz72QFBUy43-6nGGp71bT3E6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDAzMyBTYWx0ZWRfX/9a3FwFz+Nbs
 ev+3cHwCqqT9WH6KQd5deQcrdjdDdonOtfGjRqTREyVVH4oRGcSSovTmH4tnwCdfBwe19Xp9cD6
 N/bHIDiAHtDG5Ng60MavKXovL6nRoRrkSG4GF+ThOUKN84o0UQytU3Bgieyq8oxnfVvBD4brNu+
 4CM55kJuN1LNByssiC9UiC2Sk4CaUT51Dk5t/YPbXFLPVV7GobzSIXbH0ONpwnDCpVqu3LIhC9g
 GUmm3g/jH4VyQr6e4n6JySTzScdZP3cBsCdpJvN5o+sjG3pp7gvenYpRTkyqxKyHB0BI71/qClv
 20jQVoIBlQrCnaTZd2TNVfuPU9v2lh5h6SGlwvAeWNcqMMA3B0bvKIO6cjJJGUp0tqmohigD1h8
 +/vNJz1Usmo9kyHC9l0lxn1z+m+ZJA==
X-Proofpoint-GUID: oXu39g-Pz72QFBUy43-6nGGp71bT3E6d
X-Authority-Analysis: v=2.4 cv=U/CfzOru c=1 sm=1 tr=0 ts=68dbb1d7 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=zeqpHnekm0If4bNfZloA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509300033

Fix AD4080 chip identification by using the correct 16-bit product ID
(0x0050) instead of GENMASK(2, 0). Update the chip reading logic to
use regmap_bulk_read to read both PRODUCT_ID_L and PRODUCT_ID_H
registers and combine them into a 16-bit value.

The original implementation was incorrectly reading only 3 bits,
which would not correctly identify the AD4080 chip.

Fixes: 6b31ba1811b6 ("iio: adc: ad4080: add driver support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - add the chip id handling into a separate commit.
 - use regmap_bulk_read.
 drivers/iio/adc/ad4080.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 6e61787ed321..b80560aebe2d 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -125,7 +125,7 @@
 
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
-#define AD4080_CHIP_ID						GENMASK(2, 0)
+#define AD4080_CHIP_ID						0x0050
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -458,10 +458,11 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
+	ret = regmap_bulk_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id, 2);
 	if (ret)
 		return ret;
 
+	id = get_unaligned_le16(&id);
 	if (id != AD4080_CHIP_ID)
 		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
 
-- 
2.43.0


