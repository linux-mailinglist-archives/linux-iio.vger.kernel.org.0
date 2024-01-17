Return-Path: <linux-iio+bounces-1729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8703583069E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAD1B22121
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E01EA95;
	Wed, 17 Jan 2024 13:08:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49D1F5E7
	for <linux-iio@vger.kernel.org>; Wed, 17 Jan 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496883; cv=none; b=ev2cYgyvYf1nzKcK2yKbRWPnXbK+puyCEOk2r0mMyGVh2lNaLpG/UIt9mVVc4Wfm2BoAddiZutJfFc9pUqZCcbG/rXrF1XuJ5slmFLEeIoo/rbpT9PlYi3tyXAGjk4e+btJYP/rprqL0mCgEt6fRvVYzoMY5tF/WSl8X0juvw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496883; c=relaxed/simple;
	bh=QBGe99KHP7hIM4Af343vWfD7ZswqgQ9VUsnJpX5OEH4=;
	h=Received:Received:Received:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=FL/Ss9aOJBxKmoSex9FDUcTSFAOZO2YUpT5Yrw1RXTs6kSvafsQW/VONbREK0ia+WQNPtwg3wfI2HuR0VLddSajGkPp2g6nu8NgatR0+WCCzqa8Zn86949WvzRJF1/SOIaEPNMPIOCnL0NEZ49TuVSAwz5VKkwJcu1UEVFuyi2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H9f7wT016135;
	Wed, 17 Jan 2024 08:07:48 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vnm166q3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:07:48 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 40HD7kQb030774
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 08:07:46 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 17 Jan
 2024 08:07:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 17 Jan 2024 08:07:45 -0500
Received: from [127.0.0.1] ([10.44.3.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40HD7ZCl030917;
	Wed, 17 Jan 2024 08:07:41 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 17 Jan 2024 14:10:50 +0100
Subject: [PATCH 2/3] iio: imu: adis16475: make use of
 irq_get_trigger_type()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240117-adis-improv-v1-2-7f90e9fad200@analog.com>
References: <20240117-adis-improv-v1-0-7f90e9fad200@analog.com>
In-Reply-To: <20240117-adis-improv-v1-0-7f90e9fad200@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705497049; l=1277;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=QBGe99KHP7hIM4Af343vWfD7ZswqgQ9VUsnJpX5OEH4=;
 b=JZ2kQQMfSl6Si2Q34PKVYnj/kxY3jt4qdMyGZLzmtAbRtul/NojZZ7YkPhGZ2k/R2N/07AZzf
 ZsB6fxIbW5CAVOXEQln8YtA/CrTbmlcDY0wsydwsVsY2nN4BNC27GOq
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: f0HtB8HpX53WfGeB3kFEXU7eS5L8vzez
X-Proofpoint-ORIG-GUID: f0HtB8HpX53WfGeB3kFEXU7eS5L8vzez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_07,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=683 phishscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170094

There's no need to call both irq_get_irq_data() and
irqd_get_trigger_type() as we already have an helper for that. This
allows for code simplification.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index b7cbe1565aee..7c5270f70b7b 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1363,22 +1363,16 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 static int adis16475_config_irq_pin(struct adis16475 *st)
 {
 	int ret;
-	struct irq_data *desc;
 	u32 irq_type;
 	u16 val = 0;
 	u8 polarity;
 	struct spi_device *spi = st->adis.spi;
 
-	desc = irq_get_irq_data(spi->irq);
-	if (!desc) {
-		dev_err(&spi->dev, "Could not find IRQ %d\n", spi->irq);
-		return -EINVAL;
-	}
 	/*
 	 * It is possible to configure the data ready polarity. Furthermore, we
 	 * need to update the adis struct if we want data ready as active low.
 	 */
-	irq_type = irqd_get_trigger_type(desc);
+	irq_type = irq_get_trigger_type(spi->irq);
 	if (irq_type == IRQ_TYPE_EDGE_RISING) {
 		polarity = 1;
 		st->adis.irq_flag = IRQF_TRIGGER_RISING;

-- 
2.43.0


