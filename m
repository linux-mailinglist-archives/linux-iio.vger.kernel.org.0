Return-Path: <linux-iio+bounces-1732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3396B83069F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 14:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640731C22ECE
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5C1EB40;
	Wed, 17 Jan 2024 13:08:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B131EB38
	for <linux-iio@vger.kernel.org>; Wed, 17 Jan 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496886; cv=none; b=oJQM+4STu00z6ubV2q+DM1+zBW95myu0/HnFBx6n8Zsm6ZTvlTo8lVBoZ3aLwlH+nUTUIfNLFHHqDpNd1I/qpf3YmvhfB2EjhRvjGpYnNiXYR/dFCmaDXlR4+hdeKjm27zglgAECwpci1X8hHLVuWqpsAVW9xhivqc8h9lYdQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496886; c=relaxed/simple;
	bh=BVuuhLDo707JKOt+bdBwqZ6OPflzJFQ/eolM0xVT4H0=;
	h=Received:Received:Received:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=aSCyglIp1Qq2cBTtYkauSKnPEHQ0y+34Ork/AoOih8v3gs3uJZmhKFVi9qo1ech7cZu5Hd3LJPppG4vk1sjjft5+WRRCNzQy5sryJBWcHpTpA7d0I0Ncg0honm712G9TZQ4A6Zg41vqImBzPhUuZYAdGTCG6GV6pfDvQ+acs2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8JtTO018977;
	Wed, 17 Jan 2024 08:07:52 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vpb9mgxr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:07:51 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 40HD7olA032887
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 08:07:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 17 Jan
 2024 08:07:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 17 Jan 2024 08:07:49 -0500
Received: from [127.0.0.1] ([10.44.3.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40HD7ZCm030917;
	Wed, 17 Jan 2024 08:07:41 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 17 Jan 2024 14:10:51 +0100
Subject: [PATCH 3/3] iio: imu: adis16480: make use of
 irq_get_trigger_type()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240117-adis-improv-v1-3-7f90e9fad200@analog.com>
References: <20240117-adis-improv-v1-0-7f90e9fad200@analog.com>
In-Reply-To: <20240117-adis-improv-v1-0-7f90e9fad200@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705497049; l=1496;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BVuuhLDo707JKOt+bdBwqZ6OPflzJFQ/eolM0xVT4H0=;
 b=GE3x8ciebOYIQlKi5vP+jjln85ujBMmIMD9s7kf80gERjmjOcP8FaXOLgAG8AQBoLXYzC7VYC
 7/kBqbPF0vNBSojRHg8roz8tYOiw2aSQHYYvyP2+pTUkS8F99kOGOBL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: iTJwkcfoNhjoy-KJ5CQA9sObNoKAUDCC
X-Proofpoint-ORIG-GUID: iTJwkcfoNhjoy-KJ5CQA9sObNoKAUDCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_07,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=738 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170094

There's no need to call both irq_get_irq_data() and
irqd_get_trigger_type() as we already have an helper for that. This
allows for code simplification.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16480.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index fe520194a837..b40a55bba30c 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1246,18 +1246,11 @@ static int adis16480_config_irq_pin(struct adis16480 *st)
 {
 	struct device *dev = &st->adis.spi->dev;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
-	struct irq_data *desc;
 	enum adis16480_int_pin pin;
 	unsigned int irq_type;
 	uint16_t val;
 	int i, irq = 0;
 
-	desc = irq_get_irq_data(st->adis.spi->irq);
-	if (!desc) {
-		dev_err(dev, "Could not find IRQ %d\n", irq);
-		return -EINVAL;
-	}
-
 	/* Disable data ready since the default after reset is on */
 	val = ADIS16480_DRDY_EN(0);
 
@@ -1285,7 +1278,7 @@ static int adis16480_config_irq_pin(struct adis16480 *st)
 	 * configured as positive or negative, corresponding to
 	 * IRQ_TYPE_EDGE_RISING or IRQ_TYPE_EDGE_FALLING respectively.
 	 */
-	irq_type = irqd_get_trigger_type(desc);
+	irq_type = irq_get_trigger_type(st->adis.spi->irq);
 	if (irq_type == IRQ_TYPE_EDGE_RISING) { /* Default */
 		val |= ADIS16480_DRDY_POL(1);
 	} else if (irq_type == IRQ_TYPE_EDGE_FALLING) {

-- 
2.43.0


