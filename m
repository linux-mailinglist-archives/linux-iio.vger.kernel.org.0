Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99BB252787
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHZGkj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 02:40:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10748 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgHZGkj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 02:40:39 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07Q6WGMF020652;
        Wed, 26 Aug 2020 02:40:38 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3330954eya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 02:40:38 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07Q6ea6p015258
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 26 Aug 2020 02:40:36 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 23:40:35 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 23:40:35 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Aug 2020 23:40:34 -0700
Received: from saturn.ad.analog.com ([10.48.65.100])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07Q6eV7p018895;
        Wed, 26 Aug 2020 02:40:31 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ribalda@kernel.org>, <jic23@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: dac: ti-dac7612: Replace indio_dev->mlock with own device lock
Date:   Wed, 26 Aug 2020 09:40:28 +0300
Message-ID: <20200826064028.51540-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_03:2020-08-25,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=496 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/ti-dac7612.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
index 07c9f39d54f1..34c2aec204ef 100644
--- a/drivers/iio/dac/ti-dac7612.c
+++ b/drivers/iio/dac/ti-dac7612.c
@@ -21,6 +21,7 @@ struct dac7612 {
 	struct spi_device *spi;
 	struct gpio_desc *loaddacs;
 	uint16_t cache[2];
+	struct mutex lock;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -101,9 +102,9 @@ static int dac7612_write_raw(struct iio_dev *iio_dev,
 	if (val == priv->cache[chan->channel])
 		return 0;
 
-	mutex_lock(&iio_dev->mlock);
+	mutex_lock(&priv->lock);
 	ret = dac7612_cmd_single(priv, chan->channel, val);
-	mutex_unlock(&iio_dev->mlock);
+	mutex_unlock(&priv->lock);
 
 	return ret;
 }
@@ -145,6 +146,8 @@ static int dac7612_probe(struct spi_device *spi)
 	iio_dev->num_channels = ARRAY_SIZE(priv->cache);
 	iio_dev->name = spi_get_device_id(spi)->name;
 
+	mutex_init(&priv->lock);
+
 	for (i = 0; i < ARRAY_SIZE(priv->cache); i++) {
 		ret = dac7612_cmd_single(priv, i, 0);
 		if (ret)
-- 
2.25.1

