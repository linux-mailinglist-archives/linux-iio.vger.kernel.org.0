Return-Path: <linux-iio+bounces-10572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD699CFF8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 16:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C914A283D59
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69381AAE02;
	Mon, 14 Oct 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I7CsopYE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373181749
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917854; cv=none; b=bRL9uRywqKzDqs3LxRPOVSd2Yvy8eMYKGorwQy7NginbXrHGLMviSrxieMSOZqcbyaaq/ILy22NNmPuoRld580toWZGP2NfCP8AwMhSOTy/y8SWkfPInker8XznhR+/m9Fu7/z8YH7t1+bp2oCmyVR0xL44fa9FJnH5D1U96bTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917854; c=relaxed/simple;
	bh=M6VxP1EuMYjmb/ssGDzifk9u0dcpMe6KBO+lgXoThos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=CGImQPMADEqg7bNOLSHxNK2fpr+keFqIPKW7o2NvTk2B/r8i4d8p3fTrvBzNBUvn+dZytzf1O/yTHPfDA8SACXWSnFr3ll8hBebPXEN3Mh9iV5b+jZyutqnUGfQYH7uVe5gFDWvqI7EIHVoP59Wsis3vvaPUSOd1JBJENFwv+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I7CsopYE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAsOb2007462;
	Mon, 14 Oct 2024 10:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=y+qVLmyE2oLIbAPg6v1orBy4MBG
	ssJ276x2zEo5ySzo=; b=I7CsopYErClmc/LaUOdpRVjXnVLrGRkaEeMo1pCx4gl
	8/mjK19RSC4jTqitUmIsWkO632EGAB7GjnUPMjrg2p3vR+Kc9ZvK/vGt+U15Gmwv
	Zl+/Fzbv45h0CYQt9qPPr1I1+AX6dY8/WJ9rYCzbo2y2YBzTNbWehPow9+3FBHlE
	h7Q+e811kMIu7dEYufvs8xkaKK1m7uBU6P9eYhdudB6yWjO6M1ERzw5ITyXFwmoF
	uClLUW8tXoz8WJUJDGs0BprCADJVQfJJm6zqysoeO9hF/pggrn87sI96S9zCb0Me
	l6MTHtj6LoUEmzpCcYUXIlujCaHy/iG2RAcLSLe7QNQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 427p137fs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 10:57:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49EEvHwA053453
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 10:57:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 14 Oct
 2024 10:57:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 14 Oct 2024 10:57:17 -0400
Received: from [127.0.0.1] ([10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49EEv6TS015212;
	Mon, 14 Oct 2024 10:57:08 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Mon, 14 Oct 2024 17:01:21 +0200
Subject: [PATCH] iio: adc: ad7192: properly check
 spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20241014-fix-error-check-v1-1-089e1003d12f@analog.com>
X-B4-Tracking: v=1; b=H4sIAEAyDWcC/x2MWwqAIBAArxL73YKa0OMq0YfomktgsUIE0t2TP
 gdmpkIhYSqwdBWEbi585ga678Anl3dCDo3BKGO10hYjP0gip6BP5A8Mg42B5nFSzkCrLqGm/Md
 1e98PprDSTmEAAAA=
X-Change-ID: 20241014-fix-error-check-d34fde9780a2
To: <linux-iio@vger.kernel.org>
CC: Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728918083; l=930;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=M6VxP1EuMYjmb/ssGDzifk9u0dcpMe6KBO+lgXoThos=;
 b=Ni/LoJcr1qHOD29XS/RIZDIo6oXHtJPjKXGeL8JEpMCDk395//Ny+GGSUUQej9CRXlIbHFn5s
 NNka4zTqm7LB6M3nB25GzQdDWH0Bbc2ltTmxKx5ar7VM0GXmo6h8m3Z
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ykus9tdfwFrXIPwJ5G_F2vel5GU8lbH7
X-Proofpoint-GUID: ykus9tdfwFrXIPwJ5G_F2vel5GU8lbH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=806
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140108

spi_get_device_match_data() can return a NULL pointer. Hence, let's
check for it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7192.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7042ddfdfc03ee5ea58ca07fb1943feb6538175b..955e9eff0099e5c91491ca5b1f836534ac0db2f9 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1394,6 +1394,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODEV;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;

---
base-commit: 465644ac29536d10178b5ca4684d0b84765b9fa4
change-id: 20241014-fix-error-check-d34fde9780a2
--

Thanks!
- Nuno Sá


