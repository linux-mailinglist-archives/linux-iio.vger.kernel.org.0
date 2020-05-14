Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236661D2ADA
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgENJC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 05:02:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19548 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgENJC2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 05:02:28 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E8xWkj000773;
        Thu, 14 May 2020 05:02:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100x5xnj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:02:09 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04E928Oc054935
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 05:02:08 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 05:02:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 05:02:07 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 05:02:07 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04E923xB011362;
        Thu, 14 May 2020 05:02:04 -0400
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: dac: ad5449: Replace indio_dev->mlock with own device lock
Date:   Thu, 14 May 2020 12:01:49 +0300
Message-ID: <20200514090152.80436-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=727 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140081
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/dac/ad5449.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index fed3ebaccac4..d739b10e5236 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -56,11 +56,13 @@ struct ad5449_chip_info {
  * @has_sdo:		whether the SDO line is connected
  * @dac_cache:		Cache for the DAC values
  * @data:		spi transfer buffers
+ * @lock		lock to protect the data buffer during SPI ops
  */
 struct ad5449 {
 	struct spi_device		*spi;
 	const struct ad5449_chip_info	*chip_info;
 	struct regulator_bulk_data	vref_reg[AD5449_MAX_VREFS];
+	struct mutex			lock;
 
 	bool has_sdo;
 	uint16_t dac_cache[AD5449_MAX_CHANNELS];
@@ -87,10 +89,10 @@ static int ad5449_write(struct iio_dev *indio_dev, unsigned int addr,
 	struct ad5449 *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->data[0] = cpu_to_be16((addr << 12) | val);
 	ret = spi_write(st->spi, st->data, 2);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -112,7 +114,7 @@ static int ad5449_read(struct iio_dev *indio_dev, unsigned int addr,
 		},
 	};
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->data[0] = cpu_to_be16(addr << 12);
 	st->data[1] = cpu_to_be16(AD5449_CMD_NOOP);
 
@@ -123,7 +125,7 @@ static int ad5449_read(struct iio_dev *indio_dev, unsigned int addr,
 	*val = be16_to_cpu(st->data[1]);
 
 out_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -302,6 +304,8 @@ static int ad5449_spi_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
+	mutex_init(&st->lock);
+
 	if (st->chip_info->has_ctrl) {
 		unsigned int ctrl = 0x00;
 		if (pdata) {
-- 
2.17.1

