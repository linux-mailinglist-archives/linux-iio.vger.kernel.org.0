Return-Path: <linux-iio+bounces-7465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8292B63D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9F91F23C7E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB115821A;
	Tue,  9 Jul 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mVxH0ARf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AEC158205
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523496; cv=none; b=GzXB0mICTRq7CFl9e9A1bCaodIaERhxCJW3ctPgnOnTY88tsZVjgBVE7OR/9kOqnDVqz1hZfyoXZ6aHCHRnhXUvdq1elXFX7d8CUMkHwVe5Fi9jO/WHVAZCQDi818WzJF7qR3BLvbCx5hrcRfRN4yaNNl9SH6du0mB7Lg6iKZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523496; c=relaxed/simple;
	bh=ORQVhXl18L7QpqOhlMxALCTW9W1adG0MCwa3NMU5bf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lUntcsmuQZ6BbCCoRhObyBVvNb4rTiGlcAQ5re6VHMlBDMjIOHE+HlOwFonfPTi2XDqTer3d2Wdctx8kaEayFZcgUqYo+sfrJMqXamK4QcL4qew8ejUq6lIUs3B2kfvfQqrwM21Zw2B3jKjlhhnEpTX+jOj8kEnkCcA5MvnmDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mVxH0ARf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469B5ab9004256;
	Tue, 9 Jul 2024 07:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=adlDQ
	ZJma+BSIfS1p4KIv2RQDb0Bz2C7Cf3eGvlL+hg=; b=mVxH0ARfwj2XGqQhzKwVf
	1fiC6GfTZ/Ouu2C6Lyfat6TsSfF0vNTZGnpGU3708KfdmE+aVZ4xxKpgKvQ3n//O
	l5+Tx6rGfb8r0T5kEJRObXE7As4AaNtD6liqb3eVmUeFPtYlzb8MLPyDrkZwbezI
	Fax+NYUkK93uocvq5vSh+Wp9z/FjLYIs45aDlKoqoSIkBuWANPnPGDhFlO3PRbRq
	TX3WHOiVxUTxJzcO1m9N/lvSQ5vCSQAHcMvtCxHdby7pl9+6nJjaZincHLuXTIl0
	btXDRscXnwrzo77QMLoMSrFehN0MwsQdykoDF/F5WGS4Uo3Jn24Kh3jrFFr2eH8W
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 408y9291nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 469BB7UC055150
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:06 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgr032387;
	Tue, 9 Jul 2024 07:11:01 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jul 2024 13:14:35 +0200
Subject: [PATCH 8/9] iio: adc: ad9467: add backend test mode helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-8-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523683; l=3095;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ORQVhXl18L7QpqOhlMxALCTW9W1adG0MCwa3NMU5bf8=;
 b=j6dtuRPPRnYdBTUSwUutagNGyYthRSdzUBwdB0YyS242wmfVPG/lWlRE82wFrh2R9S+TF1u56
 c5yFQc40cKNC72yguZRz+mAVOtMMWQWkjlI5x0MFedM7KVpA6yLAvCX
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: QFq2LFsQHPpXzkmndIOx-tLvzitS2bpr
X-Proofpoint-ORIG-GUID: QFq2LFsQHPpXzkmndIOx-tLvzitS2bpr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=725 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077

Group the backend configurations to be done in preparing and stopping
calibration in two new helpers analogous to ad9467_testmode_set(). This
is in preparation for adding support for debugFS test_mode where
we need similar configurations as in the calibration process.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 67 ++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 557d98ca2f25..2f4bbbd5611c 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -494,11 +494,49 @@ static int ad9467_testmode_set(struct ad9467_state *st, unsigned int chan,
 				AN877_ADC_TRANSFER_SYNC);
 }
 
-static int ad9647_calibrate_prepare(struct ad9467_state *st)
+static int ad9467_backend_testmode_on(struct ad9467_state *st,
+				      unsigned int chan,
+				      enum iio_backend_test_pattern pattern)
 {
 	struct iio_backend_data_fmt data = {
 		.enable = false,
 	};
+	int ret;
+
+	ret = iio_backend_data_format_set(st->back, chan, &data);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_test_pattern_set(st->back, chan, pattern);
+	if (ret)
+		return ret;
+
+	return iio_backend_chan_enable(st->back, chan);
+}
+
+static int ad9467_backend_testmode_off(struct ad9467_state *st,
+				       unsigned int chan)
+{
+	struct iio_backend_data_fmt data = {
+		.enable = true,
+		.sign_extend = true,
+	};
+	int ret;
+
+	ret = iio_backend_chan_disable(st->back, chan);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_test_pattern_set(st->back, chan,
+					   IIO_BACKEND_NO_TEST_PATTERN);
+	if (ret)
+		return ret;
+
+	return iio_backend_data_format_set(st->back, chan, &data);
+}
+
+static int ad9647_calibrate_prepare(struct ad9467_state *st)
+{
 	unsigned int c;
 	int ret;
 
@@ -511,16 +549,8 @@ static int ad9647_calibrate_prepare(struct ad9467_state *st)
 		if (ret)
 			return ret;
 
-		ret = iio_backend_data_format_set(st->back, c, &data);
-		if (ret)
-			return ret;
-
-		ret = iio_backend_test_pattern_set(st->back, c,
-						   IIO_BACKEND_ADI_PRBS_9A);
-		if (ret)
-			return ret;
-
-		ret = iio_backend_chan_enable(st->back, c);
+		ret = ad9467_backend_testmode_on(st, c,
+						 IIO_BACKEND_ADI_PRBS_9A);
 		if (ret)
 			return ret;
 	}
@@ -601,24 +631,11 @@ static int ad9467_calibrate_apply(struct ad9467_state *st, unsigned int val)
 
 static int ad9647_calibrate_stop(struct ad9467_state *st)
 {
-	struct iio_backend_data_fmt data = {
-		.sign_extend = true,
-		.enable = true,
-	};
 	unsigned int c, mode;
 	int ret;
 
 	for (c = 0; c < st->info->num_channels; c++) {
-		ret = iio_backend_chan_disable(st->back, c);
-		if (ret)
-			return ret;
-
-		ret = iio_backend_test_pattern_set(st->back, c,
-						   IIO_BACKEND_NO_TEST_PATTERN);
-		if (ret)
-			return ret;
-
-		ret = iio_backend_data_format_set(st->back, c, &data);
+		ret = ad9467_backend_testmode_off(st, c);
 		if (ret)
 			return ret;
 

-- 
2.45.2


