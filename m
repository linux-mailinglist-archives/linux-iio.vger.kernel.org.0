Return-Path: <linux-iio+bounces-6477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F3C90D31E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A67B22EDE
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8114AD0E;
	Tue, 18 Jun 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mfepwHPe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06113AD04
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717331; cv=none; b=GC+LGgE1zQc/J2Jq6VBGzRUNZPErJSh60ucecUrlRDkiC3OGN/qTimvEBAVwCPEDyxwNNC3844gDCuVrb9TqAbqT9djyAV34LXng1R/i1l32x4PxAeTGCQe207HgSOqgnPqcET4D5U9qAJNgXY2/qOvynPoFXDmZWftgqJzZUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717331; c=relaxed/simple;
	bh=bMY3FC4dsWSyXnZwKFEPTtztmF68uI09cpTygXnm7/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UZT3H24bAvrwceVkZm1nHyhii/PV6kPXiwD2dHr+ubjF0ECZoJuO8yiTJGCQhW0aVbPfmGWPPyiorhMtf2Z6E3Mw5INXXFvE7JyYRU6YJlYmJjKxfNKK92m0vq0FFzY6SGG/YFfsthTANj0VvfT7+BPissviaVkJsOkLmQtmeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mfepwHPe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IDBKmm006673;
	Tue, 18 Jun 2024 09:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=l+DnU
	WqMXCVk6+1bnjT20Zbxdl8weVb7XgMJMO5Vr4M=; b=mfepwHPeIbYOj0ps+876G
	FEMnbWNzEQ+qIKm4paOMSsVFT0Q1qNOVk1z2VCC/s4/4XgJIjeNBXezZ6olhSgXo
	8ggCKAfBEU/qEYEj8uNbG0qH2Da4NnutJgF21gAVxNAfxbMkYyLEiZdDb3y8x/n1
	BXViFEY6vhUlstEKyoq2c65/ic8ttaC/4tU29oKoVmasEUGoNStK+wxwB/QXQ9rT
	4RuandGIMT8lCPvlUeCcgxvKsDLxeoJpKRCc3lgmCHqWlUKENCDqzdTjftVKHpSR
	IuKUjxBFyZQZN8PpPwSRW6jp+8fgi5oPXTHY9ZT2TwI0vLAb0QlRVPrsA+RA2TPj
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ys4t33by2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSZXY062006
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 18 Jun
 2024 09:28:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:34 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWO025769;
	Tue, 18 Jun 2024 09:28:29 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 18 Jun 2024 15:32:07 +0200
Subject: [PATCH 4/9] iio: gyro: adis16260: make use of the new lock helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-dev-iio-adis-cleanup-v1-4-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=2370;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=bMY3FC4dsWSyXnZwKFEPTtztmF68uI09cpTygXnm7/A=;
 b=nZKjjgI4TTyYFMBJFVhocoM3IGkpgyxLcPYAO126JcVf5Ge4NMoxU8PXyHoq00NTVs8r+vix5
 /ihpWRmwxlhC+ZUBRqDdkPG6XPp3tOPM2w2ryEcAYt+E5w/RVjor07q
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: R1b_6WC_xTuCUuXJmjg8hVS-2C7Apd6y
X-Proofpoint-ORIG-GUID: R1b_6WC_xTuCUuXJmjg8hVS-2C7Apd6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=618 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180100

Use the new auto cleanup based locks so error paths are simpler.

While at it, turned a sprintf() call into sysfs_emit().

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/gyro/adis16136.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index c95cf41be34b..da83adc684d0 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -221,13 +221,12 @@ static ssize_t adis16136_read_frequency(struct device *dev,
 	unsigned int freq;
 	int ret;
 
-	adis_dev_lock(&adis16136->adis);
+	adis_dev_auto_lock(&adis16136->adis);
 	ret = __adis16136_get_freq(adis16136, &freq);
-	adis_dev_unlock(&adis16136->adis);
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", freq);
+	return sysfs_emit(buf, "%d\n", freq);
 }
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
@@ -251,21 +250,17 @@ static int adis16136_set_filter(struct iio_dev *indio_dev, int val)
 	unsigned int freq;
 	int i, ret;
 
-	adis_dev_lock(&adis16136->adis);
+	adis_dev_auto_lock(&adis16136->adis);
 	ret = __adis16136_get_freq(adis16136, &freq);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	for (i = ARRAY_SIZE(adis16136_3db_divisors) - 1; i >= 1; i--) {
 		if (freq / adis16136_3db_divisors[i] >= val)
 			break;
 	}
 
-	ret = __adis_write_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, i);
-out_unlock:
-	adis_dev_unlock(&adis16136->adis);
-
-	return ret;
+	return __adis_write_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, i);
 }
 
 static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
@@ -275,23 +270,20 @@ static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
 	uint16_t val16;
 	int ret;
 
-	adis_dev_lock(&adis16136->adis);
+	adis_dev_auto_lock(&adis16136->adis);
 
 	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT,
 				 &val16);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = __adis16136_get_freq(adis16136, &freq);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	*val = freq / adis16136_3db_divisors[val16 & 0x07];
 
-err_unlock:
-	adis_dev_unlock(&adis16136->adis);
-
-	return ret ? ret : IIO_VAL_INT;
+	return IIO_VAL_INT;
 }
 
 static int adis16136_read_raw(struct iio_dev *indio_dev,

-- 
2.45.2


