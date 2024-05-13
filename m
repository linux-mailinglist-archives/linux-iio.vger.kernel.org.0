Return-Path: <linux-iio+bounces-5015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB88C4720
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 20:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA4228199B
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCA3BBF2;
	Mon, 13 May 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cj9/Cz8c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875492EAF9;
	Mon, 13 May 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626040; cv=none; b=KbyotiAG55rq+kNPh9NQ8oRukyXaRb17hZrumGGu+ANqmb7mpSnjEjwcMlLzBFYwzm9y9VOP8Yys9J+tYqP487LJ1w9SUO5HRl02r9jgd5u/0qiU1SiZDNDA54xlOIILt3dLIjfd8pNVx8fEQwc5DTB49htC/lKHDLwcQGusEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626040; c=relaxed/simple;
	bh=vLa9r7gEYQHbvTWv5xGb15CT21heekDIFFUmT7aBdq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOl5jBjfpAFj8dcgafqi1VEq28Fe2z5HTbJvIsLUYfDJdTE11bSlMZmFeSFrMF55z8xd2dIwtBuxWhKG6YmmyvrxzQ0J42BHP+xPGrBmb9h+hKOfwRMPOCr0Qi63VOOd1CjyODcRU/1SjPBMdS75omkv/543wzi+JdeBhKtMLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cj9/Cz8c; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DHhYQA014344;
	Mon, 13 May 2024 18:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=ivk+y8EJmO2v0vPw4T0GwAz5Cxuq4eW7Wwl86rwxKb0=;
 b=Cj9/Cz8cvtJTx1jUC1UsFHuKMtSyEbFS5trLOQHTrcQtEch8MKWJc1IZnohCEqhKx9pB
 W43OIRAlZoSFZJGx776k0vuBsmieh2vgeNTX0hIcBn6sfrr5tLsuRLlxRIRfXvrA7UAS
 a4WTpArbWS0xxFh2zlomHL20VF+ePZGBKVJh1G2QHgkHJGsfamXOhvJXobBhqpzOzb7C
 JT1kbF+DmF4QBukc8x+mkJm4kvXeADhaA/9iTGXoM4VtN+10xRrA4McWQL8eIzUy5tW4
 DADVoIsv36uYw/6Tk0kC+54La/+zxgxkJ5x8VOD02pXhycHZeJuzqgGxJQJ/RXWlHR4x wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3qgv051t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 18:47:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DI1lbr038367;
	Mon, 13 May 2024 18:45:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24pv149k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 18:45:18 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44DIjISH027732;
	Mon, 13 May 2024 18:45:18 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y24pv148x-1;
	Mon, 13 May 2024 18:45:18 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] iio: temperature: mlx90635: Fix ERR_PTR dereference in mlx90635_probe()
Date: Mon, 13 May 2024 11:45:14 -0700
Message-ID: <20240513184514.3200222-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_13,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405130126
X-Proofpoint-GUID: bFDzWDMJpvIAmwyimUriWtgSZuMJkb_5
X-Proofpoint-ORIG-GUID: bFDzWDMJpvIAmwyimUriWtgSZuMJkb_5

When devm_regmap_init_i2c() fails, ragmap_ee could be error pointer,
instead of checking for IS_ERR(ragmap_ee), regmap is checked which looks
like a copy paste error.

Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is found using smatch, only compile tested.
---
 drivers/iio/temperature/mlx90635.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index 1f5c962c1818..2b61489d5ee0 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -947,8 +947,8 @@ static int mlx90635_probe(struct i2c_client *client)
 				     "failed to allocate regmap\n");
 
 	regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
-	if (IS_ERR(regmap))
-		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+	if (IS_ERR(regmap_ee))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
 				     "failed to allocate regmap\n");
 
 	mlx90635 = iio_priv(indio_dev);
-- 
2.39.3


