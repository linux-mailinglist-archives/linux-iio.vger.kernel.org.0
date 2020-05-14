Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA12E1D2B06
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 11:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgENJMs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 05:12:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46738 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgENJMr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 05:12:47 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E99c4n002908;
        Thu, 14 May 2020 05:12:30 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100x5xpkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:12:30 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04E9CTEK003195
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 05:12:29 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 14 May
 2020 02:12:27 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 02:12:27 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04E9CPuJ011728;
        Thu, 14 May 2020 05:12:25 -0400
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: dac: ad5764: Replace indio_dev->mlock with own device lock
Date:   Thu, 14 May 2020 12:12:12 +0300
Message-ID: <20200514091215.80958-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=753 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/dac/ad5764.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index f7ab211604a1..5b0f0fe354f6 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -46,6 +46,7 @@ struct ad5764_chip_info {
  * @spi:		spi_device
  * @chip_info:		chip info
  * @vref_reg:		vref supply regulators
+ * @lock		lock to protect the data buffer during SPI ops
  * @data:		spi transfer buffers
  */
 
@@ -53,6 +54,7 @@ struct ad5764_state {
 	struct spi_device		*spi;
 	const struct ad5764_chip_info	*chip_info;
 	struct regulator_bulk_data	vref_reg[2];
+	struct mutex			lock;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -126,11 +128,11 @@ static int ad5764_write(struct iio_dev *indio_dev, unsigned int reg,
 	struct ad5764_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->data[0].d32 = cpu_to_be32((reg << 16) | val);
 
 	ret = spi_write(st->spi, &st->data[0].d8[1], 3);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -151,7 +153,7 @@ static int ad5764_read(struct iio_dev *indio_dev, unsigned int reg,
 		},
 	};
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	st->data[0].d32 = cpu_to_be32((1 << 23) | (reg << 16));
 
@@ -159,7 +161,7 @@ static int ad5764_read(struct iio_dev *indio_dev, unsigned int reg,
 	if (ret >= 0)
 		*val = be32_to_cpu(st->data[1].d32) & 0xffff;
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -295,6 +297,8 @@ static int ad5764_probe(struct spi_device *spi)
 	indio_dev->num_channels = AD5764_NUM_CHANNELS;
 	indio_dev->channels = st->chip_info->channels;
 
+	mutex_init(&st->lock);
+
 	if (st->chip_info->int_vref == 0) {
 		st->vref_reg[0].supply = "vrefAB";
 		st->vref_reg[1].supply = "vrefCD";
-- 
2.17.1

