Return-Path: <linux-iio+bounces-5023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD88C483F
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 22:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E901F1C20E30
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 20:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5F7FBBF;
	Mon, 13 May 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vqyxiqow"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E51E4B3;
	Mon, 13 May 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632491; cv=none; b=QkTYjqutwF8e2QncthXkfN/3vxZMsxk+0cPadCwmx4tvKeJdq+4GYcGhnrsm77pywgeO/dFhVPjIfbPjDyIvGMten+Zu5FDzFdaiS5pgGuZhk41Lk2UAvHrnnLoWxjOQnHt4griC7Y6BXreKoMZzTggeOXyw1DvrrBk08fFhDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632491; c=relaxed/simple;
	bh=1FYaTNZmbmetPdDToWbnMaxuvHyPdQkR6OVxNbKy0uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZ+C+gK9diUIYKAh9offNAR1aL3GUwTgZbV9rIHM3B1/jSHn3nJyWwkTh8jiB3bZNVTB990eXT+yznfXlNuAnrNBK7AgDiyOYT/qvNdv9f6UAb8scyuNRLLugXqLeNaIP3f9egBqYDTKzj0FHX6gS6IuwZbw45oB9ae1SMq7zJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vqyxiqow; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DKIUGc024530;
	Mon, 13 May 2024 20:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=JSbc/8eA5xrI1SaFPGINdQ50BsHMllxXcq2iZ5yctfw=;
 b=VqyxiqowZbDyOT15WPPMVQu3gojdreUFeF6RgmwODXq8q+a80YE/Px2p22ZrGU6KCP3Q
 xL3Y8PPCiJRL7obsS1xAJtlOVpHgThz0Abr9+mZpIHRANzJZH6y0u7moNSVO8Pisz6RP
 C2TVyc8fUKIi2GcYRbbXvZTNiJfIDG3X+/Dmhy5tGf5OKn1drhs4+HXwMiBfV89HdZcX
 b8YiGgGx3w7u2wFANcPJVvtNtJ4HaeIim3HC5EL92lEH8zC9oKFx++G2B8+BCMcvfMyN
 zlTgpcLabYlJmyHMGoGY+nRKjw+hXETOoDoexEfKKHmuImGm/yHi4DLoyypTMKBROE8Y EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3ss9g1b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 20:34:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DKB1Qj019247;
	Mon, 13 May 2024 20:34:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r83vc9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 20:34:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44DKYVlA028454;
	Mon, 13 May 2024 20:34:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y3r83vc9c-1;
	Mon, 13 May 2024 20:34:31 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH  v2] iio: temperature: mlx90635: Fix ERR_PTR dereference in mlx90635_probe()
Date: Mon, 13 May 2024 13:34:27 -0700
Message-ID: <20240513203427.3208696-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130141
X-Proofpoint-GUID: WX5Xu_yCNJWIukO3q5l1yaFCI8-mRfPR
X-Proofpoint-ORIG-GUID: WX5Xu_yCNJWIukO3q5l1yaFCI8-mRfPR

When devm_regmap_init_i2c() fails, regmap_ee could be error pointer,
instead of checking for IS_ERR(regmap_ee), regmap is checked which looks
like a copy paste error.

Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is found using smatch, only compile tested.
v1->v2: Address Crt's comments.
---
 drivers/iio/temperature/mlx90635.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index 1f5c962c1818..f7f88498ba0e 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -947,9 +947,9 @@ static int mlx90635_probe(struct i2c_client *client)
 				     "failed to allocate regmap\n");
 
 	regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
-	if (IS_ERR(regmap))
-		return dev_err_probe(&client->dev, PTR_ERR(regmap),
-				     "failed to allocate regmap\n");
+	if (IS_ERR(regmap_ee))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
+				     "failed to allocate EEPROM regmap\n");
 
 	mlx90635 = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-- 
2.39.3


