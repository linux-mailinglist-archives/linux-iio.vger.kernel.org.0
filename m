Return-Path: <linux-iio+bounces-14946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76000A2635C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 20:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6453E3A1EDD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E0F209F5B;
	Mon,  3 Feb 2025 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Pb4UUamF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B23205E15;
	Mon,  3 Feb 2025 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609920; cv=none; b=gU/3Eddsu+cSAUakhAyr96kITT2x4EmddZL00QBbQIqL2jCPdNfA411QYFF68FxGw8g2cQaT85fKRqk4MSNDRAtFoXEICmiJ0AhkvCPvFhWjiqFeXuYtJ/iIryA1qegHX8bYnJnzoTMz4IDZviIDaJMx3wtWxyrMcUa5sbpT684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609920; c=relaxed/simple;
	bh=VW9v+32A4V+R6FTwFdPoa8MNN0YAVmBh0YiDkN3vZZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epfBqQJfseozQ03VDO/CUOaD+HGkiz9JKvLuFPVklg7eAnRYiABci2DspWwiRC6YQOkp/Ultzhg/thpZmct8t1hkxz66BfMHvollnbAY4gReWdVDLddk0dSxt0RGYrbVg76nEtI7TEs7Ns1B5301UE6Ef9giBPbnTq64SBuPprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Pb4UUamF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513I2RAa029879;
	Mon, 3 Feb 2025 14:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hVu+F
	KpEj9uW4OF0rlJFjYvggVKgEk8BPNbk0KaN1kc=; b=Pb4UUamFQwJeaN8A2YGH0
	k1YGvw7ApiVjohulQUUnEkuH38Ru7YUZ0piVW6nU88xEvkVSZYYDCOKATg3whAt8
	hgD9lRnADwTJSDDAJoDV9/tnV/Tx2kxbXP1iw8fiGZEfyvQMp7PfNX1Rnqmo0LVp
	sv1AK+5rNU3PHeDHuUghL0v5bYQ0ec9QJdKMk8IGdxgpzAQ/eG29eiVd76lIfiO9
	WgE02d8j/JmfSBrwIuO4OF583pPQXFdwrYbzG67xxOCaXl/nTZdcBo9U/waHFrs/
	/WARqKP8Jm+MH50ac3CzPzV4hn16VAFl40GyJtXI6N9+OOxPHoMjbw8AtECyC6lD
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44k2qtr8dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:11:45 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 513JBiKJ052055
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Feb 2025 14:11:44 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Feb 2025 14:11:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Feb 2025 14:11:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Feb 2025 14:11:43 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 513JBSL9026395;
	Mon, 3 Feb 2025 14:11:31 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 2/3] iio: adc: ad4130: Add filter_type attributes
Date: Mon, 3 Feb 2025 16:11:27 -0300
Message-ID: <77e5eb540e5d425016ea77a641e16cd31a2a761a.1738608986.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1738608986.git.marcelo.schmitt@analog.com>
References: <cover.1738608986.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: DewKYvn7Rg-yvAfhLx_tZLsAlsYyW2EF
X-Proofpoint-ORIG-GUID: DewKYvn7Rg-yvAfhLx_tZLsAlsYyW2EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030139

Make filter control also available through filter_type attributes which are
now standardized in main IIO ABI documentation.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Hi David, I forgot to ask if you wanted it, but I've added a suggested-by tag
for your advice on v2.

Thanks,
Marcelo

 drivers/iio/adc/ad4130.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index de32cc9d18c5..66097ff65740 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -942,6 +942,9 @@ static const struct iio_chan_spec_ext_info ad4130_filter_mode_ext_info[] = {
 	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_mode_enum),
 	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_TYPE,
 			   &ad4130_filter_mode_enum),
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4130_filter_mode_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
+			   &ad4130_filter_mode_enum),
 	{ }
 };
 
-- 
2.47.2


