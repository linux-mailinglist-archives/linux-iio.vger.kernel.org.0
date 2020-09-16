Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D6926C076
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 11:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgIPJZq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 05:25:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13944 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgIPJZp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 05:25:45 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08G9PiAh014169;
        Wed, 16 Sep 2020 05:25:44 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p61ujc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 05:25:43 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08G9PgsV049872
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 16 Sep 2020 05:25:42 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 16 Sep
 2020 02:25:49 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 16 Sep 2020 02:25:49 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08G9PZ7M022051;
        Wed, 16 Sep 2020 05:25:36 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ribalda@kernel.org>, <jic23@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: dac: ti-dac7612: Replace indio_dev->mlock with own device lock
Date:   Wed, 16 Sep 2020 12:25:35 +0300
Message-ID: <20200916092535.76527-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826064028.51540-1-alexandru.ardelean@analog.com>
References: <20200826064028.51540-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_02:2020-09-15,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=456
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160069
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state from potential concurrent write
accesses from userspace. The write operation requires an SPI write, then
toggling of a GPIO, so the lock aims to protect the sanity of the entire
sequence of operation.

This is part of a bigger cleanup.
Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/ti-dac7612.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
index 07c9f39d54f1..4c0f4b5e9ff4 100644
--- a/drivers/iio/dac/ti-dac7612.c
+++ b/drivers/iio/dac/ti-dac7612.c
@@ -22,6 +22,14 @@ struct dac7612 {
 	struct gpio_desc *loaddacs;
 	uint16_t cache[2];
 
+	/*
+	 * Lock to protect the state of the device from potential concurrent
+	 * write accesses from userspace. The write operation requires an
+	 * SPI write, then toggling of a GPIO, so the lock aims to protect
+	 * the sanity of the entire sequence of operation.
+	 */
+	struct mutex lock;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -101,9 +109,9 @@ static int dac7612_write_raw(struct iio_dev *iio_dev,
 	if (val == priv->cache[chan->channel])
 		return 0;
 
-	mutex_lock(&iio_dev->mlock);
+	mutex_lock(&priv->lock);
 	ret = dac7612_cmd_single(priv, chan->channel, val);
-	mutex_unlock(&iio_dev->mlock);
+	mutex_unlock(&priv->lock);
 
 	return ret;
 }
@@ -145,6 +153,8 @@ static int dac7612_probe(struct spi_device *spi)
 	iio_dev->num_channels = ARRAY_SIZE(priv->cache);
 	iio_dev->name = spi_get_device_id(spi)->name;
 
+	mutex_init(&priv->lock);
+
 	for (i = 0; i < ARRAY_SIZE(priv->cache); i++) {
 		ret = dac7612_cmd_single(priv, i, 0);
 		if (ret)
-- 
2.17.1

