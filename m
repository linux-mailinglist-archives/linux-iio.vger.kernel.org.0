Return-Path: <linux-iio+bounces-13970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4953A04439
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE061665A2
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E51F2C5B;
	Tue,  7 Jan 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MReJhyLJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7571F190C;
	Tue,  7 Jan 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263537; cv=none; b=hmx2MQNyzG2NXSFUDzataLJDceMbs+s+HryZZQrapRGzbvMNOy7YYQtnzwNn2LeuowupuuKXhtiIMEu2z2hn4ZUdoXS8182hX6/SyK7CYR2Pykhk4VO0SDEjfsVA01FpX7MP9dTCr96USag9i9X5yqRECIFs7PD4R/WXGNSORLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263537; c=relaxed/simple;
	bh=Kw078kzBGNu7Jju8WKIlmnmhYssbPZrYDyz+1MTU3D4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHNOzIg84tpPd1qXMmIBHVZ4emaoEWoHqW+/815dPrWRv9CTSx+Y+4loDvnmfAZ+D2b3j2iAusJj983w+WGLwOjCL/LqnlztXHV9XuYq+TQx/Ek+p59Y+k4+sDGKJDF2wHJR+DpCQY5b4hA1jda+ptYtUwdqNuGgcG+LZHFt/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MReJhyLJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvCRt008001;
	Tue, 7 Jan 2025 10:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=J6m//
	d/p1YcNxUHPwYL3dL09kXVts6gkeYAthGBthkA=; b=MReJhyLJTqRhgvY/nnK8j
	q46N/kkeZjhO1N/IPUDDV4DHu34Iv5PEK9OekkPQq1li8C0tQUiFKxx9mpATx4Wt
	ABSBggiQaFXlwenlZiISusA811SORceeoQohKFYhAwDijCkn2adyhdyhZmvFbtgW
	qXxkRYWlhFn5zKuuTIfuJAHpEEgK/WOKOIP/HyX+vqCTLnuLHR2c36Hp+neLK21J
	zaKysHPvvN+OpU6yoLfchVHgc7r+pPXeYjZAVaWR+E8x198XJp2xZVCOY7Ht7g3v
	05WcvFG+CmyCtE0iuraIRG9VquzKh3ymlWrgzLNIYSfnkPcwdGVYOMMLRuw5/P+S
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4410d0sr47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:25:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FPIMf034039
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:25:18 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:25:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:25:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:25:18 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FP7qD030300;
	Tue, 7 Jan 2025 10:25:10 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 04/15] iio: adc: ad7768-1: Fix conversion result sign
Date: Tue, 7 Jan 2025 12:25:07 -0300
Message-ID: <e521bb5cb60d413edbcd1ea582fd81073218eaf5.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: PMijzN3brPbiQqtfpXxYpesdclUjUwkf
X-Proofpoint-GUID: PMijzN3brPbiQqtfpXxYpesdclUjUwkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070129

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

The ad7768-1 is a fully differential ADC, meaning that the voltage
conversion result is a signed value. Since the value is a 24 bit one,
stored in a 32 bit variable, the sign should be extended in order to get
the correct representation.

Also the channel description has been updated to signed representation,
to match the ADC specifications.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 113703fb7245..c3cf04311c40 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.channel = 0,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 24,
 			.storagebits = 32,
 			.shift = 8,
@@ -371,7 +371,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
 		ret = ad7768_scan_direct(indio_dev);
 		if (ret >= 0)
-			*val = ret;
+			*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
-- 
2.34.1


