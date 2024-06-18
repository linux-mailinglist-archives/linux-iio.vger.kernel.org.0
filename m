Return-Path: <linux-iio+bounces-6479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5C90D2CD
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947C4283F7E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA29714B97B;
	Tue, 18 Jun 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ANZ/vPVI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66413AD09
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717331; cv=none; b=fxlMWcemInoWhX4chIOH8j6nlCaZU6pGbbe6hVYin5jjU6zyvvCIEwQGQ3cY0SEPxSM3lWJGpqaQLfh/xC2BFPiVgzVrrq/CF25vetky0jh6eptesu7r5VqqyNHL61BEr9R8JoUBv/Ko4R5uJZqJzwcONYKgZSFtWatuoNL7gCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717331; c=relaxed/simple;
	bh=f57z8qMPdaTM4Ylv9IiiEshKA9/HobsUtwBDbBbI0O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KvmyzMA1ouFV+WrXDcVNCfkFFaZnqz9aMN3alkxqjxbwSKRIInJVSeboS+t+NKzzGjms90/Cf/AQebAcajQo/0U8Ju2UaCPl7RELJPmOUfagJioVHK1/MB5OlkAw4wTkXvsMJqwYMhk86/YFzJjAjBd2OUgmFLaqo9N4cUjyGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ANZ/vPVI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IAYRhw007465;
	Tue, 18 Jun 2024 09:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9UysL
	5PsSnGkUxQtd34TssQ27yBL4zFypbn8DXWBWHk=; b=ANZ/vPVIYTX8a9H+7T73p
	uLvRUI5yWjqOkxbTWsGxd6ofsLyk44mUfyu8ZkMTNy6zsoGoTW7smsohQe8LrmKi
	4w+X797iVVErpm6KrLaTHQXQO3XhZRY2H/NOZt3MgtGcrIVZoFA+7Se0afXSbaIE
	9mglX+FrwK8efubH4D1k+MQAHm4B4IVUFn8GaIPdDn2tB6iCqECc4G01X6U5Iets
	Vnx4tPzyD+gUp2/0xSec3av0g+NLlUUPdKt0U0yzJkJ82pnRpI0MYB/6sCa5Hhjn
	D9J/tm+UDAJPX2wE5AsZIpmJYMIYMU6KItWlk4EjvYiX8R7+KtxKqcLOcBH4E7h0
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ys7v32x7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSZhi023610
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:35 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:33 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWL025769;
	Tue, 18 Jun 2024 09:28:27 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 18 Jun 2024 15:32:04 +0200
Subject: [PATCH 1/9] iio: imu: adis_buffer: split trigger handling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-dev-iio-adis-cleanup-v1-1-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=2627;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=f57z8qMPdaTM4Ylv9IiiEshKA9/HobsUtwBDbBbI0O4=;
 b=ItIaT0y/+mrOqG14QlSbn4lPLefwbkYx9HVT0ImqBWsrsjr2+d8W14Qf6k8PXreHh1+ZazWS+
 CEQd5y7W3DmAwjPLx6pEPaj3T4orIGvEC3xAgBha78Puoylihp9NJ1w
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LpQ_iQyJ0K17SQ_Sc9XeBbrlT_2l0cyV
X-Proofpoint-GUID: LpQ_iQyJ0K17SQ_Sc9XeBbrlT_2l0cyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=829 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180100

Split trigger handling for devices that have paging and need to
select the correct page to get the data. Although this actually
introduces more LOC, it makes the code and the locking clear. It will
also make the following move to the cleanup magic cleaner.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c | 56 ++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 871b78b225e2..d1d1e4f512b9 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -126,6 +126,30 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_NS_GPL(adis_update_scan_mode, IIO_ADISLIB);
 
+static int adis_paging_trigger_handler(struct adis *adis)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	if (adis->current_page != 0) {
+		adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
+		adis->tx[1] = 0;
+		ret = spi_write(adis->spi, adis->tx, 2);
+		if (ret) {
+			dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
+			mutex_unlock(&adis->state_lock);
+			return ret;
+		}
+
+		adis->current_page = 0;
+	}
+
+	ret = spi_sync(adis->spi, &adis->msg);
+	mutex_unlock(&adis->state_lock);
+
+	return ret;
+}
+
 static irqreturn_t adis_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -133,34 +157,16 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	if (adis->data->has_paging) {
-		mutex_lock(&adis->state_lock);
-		if (adis->current_page != 0) {
-			adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
-			adis->tx[1] = 0;
-			ret = spi_write(adis->spi, adis->tx, 2);
-			if (ret) {
-				dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
-				mutex_unlock(&adis->state_lock);
-				goto irq_done;
-			}
-
-			adis->current_page = 0;
-		}
-	}
-
-	ret = spi_sync(adis->spi, &adis->msg);
 	if (adis->data->has_paging)
-		mutex_unlock(&adis->state_lock);
-	if (ret) {
+		ret = adis_paging_trigger_handler(adis);
+	else
+		ret = spi_sync(adis->spi, &adis->msg);
+	if (ret)
 		dev_err(&adis->spi->dev, "Failed to read data: %d", ret);
-		goto irq_done;
-	}
+	else
+		iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
+						   pf->timestamp);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
-					   pf->timestamp);
-
-irq_done:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

-- 
2.45.2


