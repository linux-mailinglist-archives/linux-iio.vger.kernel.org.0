Return-Path: <linux-iio+bounces-7466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A4892B641
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63BE283CFC
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5E1586F3;
	Tue,  9 Jul 2024 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iL0FbmcR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D815747F
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523497; cv=none; b=iKP5YuOdC5XaG0+xZ45VlfXiwQrhj3N6OAekAi8fARTojUOJzNYmPTNuHgwA3O8TtQsKMuFw8DljAPirLhYLs6rjRbRwQZGyzRYiW5/7G36Hc2tqKHZj6lsppdkLbqGgOvOJ6gbsRTHG/wKjK0LQ+6pGMzJjW49szrFURG2zJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523497; c=relaxed/simple;
	bh=NoqNQ9VgQrHbv9NQVFmgb43v3d4fB2Ho/WZ9p6zySP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c05H1Nkv5OVeRG+SPzID5MCokqOS28oqhjOfsXzMHlqtLVHPKLs7xL5ntsqqPNSFAaNmbKBfCberA+8akhoaBr+/66JKD8wXBSdM59pTrwToz/y4EU3HfVtATMog1YKIHFLqrK8MqrROCuq9xXQ68/bVqtbkEW+mENUbj592u5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iL0FbmcR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469B6395004305;
	Tue, 9 Jul 2024 07:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7n/i7
	fMcq4vQdDlnhdr8Ww84yQs70bRCY9EAgw8RqyE=; b=iL0FbmcR9fRusDRDvJ7FC
	ZjUVivmTA5YXmAQSL5zgH7Xil2xx64rBw4FUOMvOfvYMERvZo+Be88lKp1iTQXsp
	5ZyUbDsqXraYV8Q6t2RGDoYoCCOZjZtsS4zBRKAxH/iS6lgE5U5b0TPBcUJ1/7UA
	Ijxgm789H4bVQrgUXA/rF3v/rNFMmoN/Fm11indaMxGg+caQALPSWjOOFXkr2247
	nCmqUQ8wgd/hLyNmYNUIGxLW/+P+9zX8X25PaDYgy37vI7SKoihwqpXlOL+BBfej
	320brM/dWnTmE4AGbI7L0gwwURbIUHVBRVEn4xLvaDmu6/9L6IOSBb5wSayvS32b
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 408y9291nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 469BB8a0046293
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 9 Jul 2024
 07:11:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:07 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgp032387;
	Tue, 9 Jul 2024 07:10:59 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jul 2024 13:14:33 +0200
Subject: [PATCH 6/9] iio: adc: adi-axi-adc: split axi_adc_chan_status()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-6-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523682; l=1692;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=NoqNQ9VgQrHbv9NQVFmgb43v3d4fB2Ho/WZ9p6zySP4=;
 b=y9KOZnyLP4ZLR1/AeWSzUCLb5M5937hT1KgA+6wUfHDInRe21yo1LVaDlzeCJiX6/6/mdUVc9
 Ft+yroRh+DHAf4ZW+dP0Fz4aOqh45ZYUsvl3avZqL6C3Zg4zKMycGjS
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 2gxGTZa-AR8TCGCI6s5ZfaYdqjIJ_p8q
X-Proofpoint-ORIG-GUID: 2gxGTZa-AR8TCGCI6s5ZfaYdqjIJ_p8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=907 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077

Add a new axi_adc_read_chan_status() helper so we get the raw register
value out of it.

This is in preparation of a future change where we really want to look
into dedicated bits of the register.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 54499653d888..12e0e6350a38 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -208,12 +208,10 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
 	}
 }
 
-static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
-			       bool *error)
+static int axi_adc_read_chan_status(struct adi_axi_adc_state *st, unsigned int chan,
+				    unsigned int *status)
 {
-	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 	int ret;
-	u32 val;
 
 	guard(mutex)(&st->lock);
 	/* reset test bits by setting them */
@@ -225,7 +223,18 @@ static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
 	/* let's give enough time to validate or erroring the incoming pattern */
 	fsleep(1000);
 
-	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_CHAN_STATUS(chan), &val);
+	return regmap_read(st->regmap, ADI_AXI_ADC_REG_CHAN_STATUS(chan),
+			   status);
+}
+
+static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
+			       bool *error)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 val;
+	int ret;
+
+	ret = axi_adc_read_chan_status(st, chan, &val);
 	if (ret)
 		return ret;
 

-- 
2.45.2


