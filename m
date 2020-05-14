Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03A1D2AE4
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 11:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgENJGs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 05:06:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:43556 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgENJGs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 05:06:48 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E8xWl6000773;
        Thu, 14 May 2020 05:06:29 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100x5xp18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:06:29 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04E96RtU055911
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 05:06:28 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 14 May
 2020 02:06:26 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 02:06:26 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04E96MJm011444;
        Thu, 14 May 2020 05:06:22 -0400
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: dac: ad5755: Replace indio_dev->mlock with own device lock
Date:   Thu, 14 May 2020 12:06:05 +0300
Message-ID: <20200514090608.80521-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=577 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140081
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
 drivers/iio/dac/ad5755.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 388ddd14bfd0..7723bd313fc6 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -82,6 +82,7 @@ struct ad5755_chip_info {
  * @pwr_down:	bitmask which contains  hether a channel is powered down or not
  * @ctrl:	software shadow of the channel ctrl registers
  * @channels:	iio channel spec for the device
+ * @lock	lock to protect the data buffer during SPI ops
  * @data:	spi transfer buffers
  */
 struct ad5755_state {
@@ -90,6 +91,7 @@ struct ad5755_state {
 	unsigned int			pwr_down;
 	unsigned int			ctrl[AD5755_NUM_CHANNELS];
 	struct iio_chan_spec		channels[AD5755_NUM_CHANNELS];
+	struct mutex			lock;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -174,11 +176,12 @@ static int ad5755_write_ctrl_unlocked(struct iio_dev *indio_dev,
 static int ad5755_write(struct iio_dev *indio_dev, unsigned int reg,
 	unsigned int val)
 {
+	struct ad5755_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad5755_write_unlocked(indio_dev, reg, val);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -186,11 +189,12 @@ static int ad5755_write(struct iio_dev *indio_dev, unsigned int reg,
 static int ad5755_write_ctrl(struct iio_dev *indio_dev, unsigned int channel,
 	unsigned int reg, unsigned int val)
 {
+	struct ad5755_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad5755_write_ctrl_unlocked(indio_dev, channel, reg, val);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -211,7 +215,7 @@ static int ad5755_read(struct iio_dev *indio_dev, unsigned int addr)
 		},
 	};
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	st->data[0].d32 = cpu_to_be32(AD5755_READ_FLAG | (addr << 16));
 	st->data[1].d32 = cpu_to_be32(AD5755_NOOP);
@@ -220,7 +224,7 @@ static int ad5755_read(struct iio_dev *indio_dev, unsigned int addr)
 	if (ret >= 0)
 		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -246,7 +250,7 @@ static int ad5755_set_channel_pwr_down(struct iio_dev *indio_dev,
 	struct ad5755_state *st = iio_priv(indio_dev);
 	unsigned int mask = BIT(channel);
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	if ((bool)(st->pwr_down & mask) == pwr_down)
 		goto out_unlock;
@@ -266,7 +270,7 @@ static int ad5755_set_channel_pwr_down(struct iio_dev *indio_dev,
 	}
 
 out_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return 0;
 }
@@ -746,6 +750,8 @@ static int ad5755_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = AD5755_NUM_CHANNELS;
 
+	mutex_init(&st->lock);
+
 	if (spi->dev.of_node)
 		pdata = ad5755_parse_dt(&spi->dev);
 	else
-- 
2.17.1

