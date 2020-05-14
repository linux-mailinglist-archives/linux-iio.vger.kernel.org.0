Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E481D2A6E
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 10:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgENIk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 04:40:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42632 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgENIk2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 04:40:28 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E8bowu002503;
        Thu, 14 May 2020 04:39:52 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100y96fub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 04:39:52 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04E8dpSn060813
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 04:39:51 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 04:39:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 04:39:50 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 04:39:50 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04E8dkWE009877;
        Thu, 14 May 2020 04:39:47 -0400
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: dac: ad5360: Replace indio_dev->mlock with own device lock
Date:   Thu, 14 May 2020 11:39:19 +0300
Message-ID: <20200514083921.51966-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 cotscore=-2147483648
 phishscore=0 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 mlxlogscore=783 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.
This also changes some internal functions to pass the pointer to the
state-struct vs a ref to indio_dev just to access the state-struct again.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/dac/ad5360.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 2ac428b957e3..3e0c9e84e8da 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -67,6 +67,7 @@ struct ad5360_chip_info {
  * @chip_info:		chip model specific constants, available modes etc
  * @vref_reg:		vref supply regulators
  * @ctrl:		control register cache
+ * @lock		lock to protect the data buffer during SPI ops
  * @data:		spi transfer buffers
  */
 
@@ -75,6 +76,7 @@ struct ad5360_state {
 	const struct ad5360_chip_info	*chip_info;
 	struct regulator_bulk_data	vref_reg[3];
 	unsigned int			ctrl;
+	struct mutex			lock;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -205,10 +207,11 @@ static int ad5360_write(struct iio_dev *indio_dev, unsigned int cmd,
 	unsigned int addr, unsigned int val, unsigned int shift)
 {
 	int ret;
+	struct ad5360_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -229,7 +232,7 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
 		},
 	};
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	st->data[0].d32 = cpu_to_be32(AD5360_CMD(AD5360_CMD_SPECIAL_FUNCTION) |
 		AD5360_ADDR(AD5360_REG_SF_READBACK) |
@@ -240,7 +243,7 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
 	if (ret >= 0)
 		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -261,7 +264,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	struct ad5360_state *st = iio_priv(indio_dev);
 	unsigned int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	st->ctrl |= set;
 	st->ctrl &= ~clr;
@@ -269,7 +272,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	ret = ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
 			AD5360_REG_SF_CTRL, st->ctrl, 0);
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -479,6 +482,8 @@ static int ad5360_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
+	mutex_init(&st->lock);
+
 	ret = ad5360_alloc_channels(indio_dev);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to allocate channel spec: %d\n", ret);
-- 
2.17.1

