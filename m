Return-Path: <linux-iio+bounces-24817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDAEBC11C7
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 13:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327943B7D7B
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB502D9ED8;
	Tue,  7 Oct 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="R1sipLqg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C92D9499;
	Tue,  7 Oct 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835761; cv=none; b=E7zRbPzWkfLNhDbUYK5dsxTavgTsYDO3//MQZCYR/e/RuvBQdlziOJowm8c4iNYSZ47/SHFUcBeA/lZklii3+/UfUWtBhfods5u+3P33in1vBHLer/B4X+wHvMVFRVISBrri/5aFOZPVr4eoTr/jBKve09yN2voP1zGOnGP2j0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835761; c=relaxed/simple;
	bh=IKhGS0A/e8TFGR5npPvfz4zq1/53BcIbt/+BZAsjjUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQXfl59filZpskl4sUC4hooZsQg4H5azJ4SzgJycI2DGEXO4MkJfRNikUHO7bmgzYv1tGsf8B69Bpj/uJSvyDCI1yWVIM13loly2QIDOokdbK8JqOzoL/c+mpWL6vpiS3+YIYupzAF4I/ZH/nKN//fMoFZU5bpJjAtvKp39QIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=R1sipLqg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5978d0RM006443;
	Tue, 7 Oct 2025 07:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xoOo7
	WBzjUwhhy1qcVrjGlR8R0wYQnRehdi8XFOqcMA=; b=R1sipLqgwG/BN5UrvMl4s
	1/o833nV07G2lWmCobMKSR44KcNqxIPG5zE0UhR/08GkCpIsaYZqKct1y+dWstWC
	a7Rmg1qXKSvQV5Yz/EvsEgTgd3pZSaIgpi0Ml6wYw+54Zun2vZ66APu/yrmE87RI
	b1LrbRHpViLc71EHnPDKxQcP7ZeMRQCOVZ6ngGdlCtFagk6AeJJpR5E/k0Rp+Lcw
	Ogbd+Qh5JLx9YGneJ6zX6GumY1CLkFmFB+/kVULXTQmFQQFByDRFIkXy7iALkt67
	/G51ymXnXtG7w/j9MiefH1HCgA5fPLD7EaaT/ssevdnh7r/MlAWqGFKzvOqivCoc
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49myhq8qe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 07:15:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 597BFu0t058182
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 07:15:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 7 Oct
 2025 07:15:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 7 Oct 2025 07:15:56 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 597BFftS006224;
	Tue, 7 Oct 2025 07:15:50 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 1/6] iio: adc: ad4080: fix chip identification
Date: Tue, 7 Oct 2025 11:15:20 +0000
Message-ID: <20251007111525.25711-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007111525.25711-1-antoniu.miclaus@analog.com>
References: <20251007111525.25711-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA2OCBTYWx0ZWRfXwq84fCBtT3qz
 QoYzz6DDC+rNGmKr7sDZ/ruAaCICSemwbbR+dOIsnSZxFO2fa+s8cBOVIwuoaiXGOHDX4DoHfa+
 llBP9uHX3/hwEIYm6Ku5imKPZKs44Bvz9TY/RUyBGNxQbpvYIgDQwsxXTadBede/T6oLOkVXU9k
 HYZwcKjuwt8UHeX04WqBcm5TeCn24sc/8mgax8Hmy/yunwUhOjyhsPlF6ghPag1mrDvGxPXJXCc
 +fe7waT3dm288tP1rTW0PM/p9cwHxVoOQ0ZgSvrGjY3He6tme/twMMf8RreOAb7CGJui4Qd1lkG
 5DINDol8qZAIuC860l1DEjJKFFLUzdfE67Hj14zuIPuvV7Fb5KzxAmfLSjVnfkgYpOHTRY9EWPV
 PU4HN4BCYCooyTRnqNPRXIEzBoj4rQ==
X-Authority-Analysis: v=2.4 cv=IdOKmGqa c=1 sm=1 tr=0 ts=68e4f66d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=91vjMLyKW-Pj1BGKmtEA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: LDvMijKMqHwi52RIej0LxKW-7HqoW6n9
X-Proofpoint-ORIG-GUID: LDvMijKMqHwi52RIej0LxKW-7HqoW6n9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070068

Fix AD4080 chip identification by using the correct 16-bit product ID
(0x0050) instead of GENMASK(2, 0). Update the chip reading logic to
use regmap_bulk_read to read both PRODUCT_ID_L and PRODUCT_ID_H
registers and combine them into a 16-bit value.

The original implementation was incorrectly reading only 3 bits,
which would not correctly identify the AD4080 chip.

Fixes: 6b31ba1811b6 ("iio: adc: ad4080: add driver support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - use le16_to_cpu to convert the read little-endian value to CPU endianness
 drivers/iio/adc/ad4080.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 6e61787ed321..ae5a975a47a5 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -125,7 +125,7 @@
 
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
-#define AD4080_CHIP_ID						GENMASK(2, 0)
+#define AD4080_CHIP_ID						0x0050
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -445,7 +445,8 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->regmap);
-	unsigned int id;
+	__le16 id_le;
+	u16 id;
 	int ret;
 
 	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
@@ -458,10 +459,11 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
+	ret = regmap_bulk_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id_le, 2);
 	if (ret)
 		return ret;
 
+	id = le16_to_cpu(id_le);
 	if (id != AD4080_CHIP_ID)
 		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
 
-- 
2.43.0


