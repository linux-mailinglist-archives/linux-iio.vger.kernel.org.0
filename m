Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6319F1D2B1F
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 11:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgENJSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 05:18:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36816 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbgENJSa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 05:18:30 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E9FWkg031581;
        Thu, 14 May 2020 05:18:13 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100x5xq2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:18:13 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04E9IBca057628
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 05:18:12 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 02:18:10 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 02:18:10 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04E9I7CS011829;
        Thu, 14 May 2020 05:18:07 -0400
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: dac: ad5421: Replace indio_dev->mlock with own device lock
Date:   Thu, 14 May 2020 12:17:53 +0300
Message-ID: <20200514091756.81425-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=873 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/dac/ad5421.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 63063e85cd0a..fec27764cea8 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -62,12 +62,14 @@
  * @current_range:	current range which the device is configured for
  * @data:		spi transfer buffers
  * @fault_mask:		software masking of events
+ * @lock	lock to protect the data buffer during SPI ops
  */
 struct ad5421_state {
 	struct spi_device		*spi;
 	unsigned int			ctrl;
 	enum ad5421_current_range	current_range;
 	unsigned int			fault_mask;
+	struct mutex			lock;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -142,11 +144,12 @@ static int ad5421_write_unlocked(struct iio_dev *indio_dev,
 static int ad5421_write(struct iio_dev *indio_dev, unsigned int reg,
 	unsigned int val)
 {
+	struct ad5421_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	ret = ad5421_write_unlocked(indio_dev, reg, val);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -166,7 +169,7 @@ static int ad5421_read(struct iio_dev *indio_dev, unsigned int reg)
 		},
 	};
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	st->data[0].d32 = cpu_to_be32((1 << 23) | (reg << 16));
 
@@ -174,7 +177,7 @@ static int ad5421_read(struct iio_dev *indio_dev, unsigned int reg)
 	if (ret >= 0)
 		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -185,14 +188,14 @@ static int ad5421_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	struct ad5421_state *st = iio_priv(indio_dev);
 	unsigned int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	st->ctrl &= ~clr;
 	st->ctrl |= set;
 
 	ret = ad5421_write_unlocked(indio_dev, AD5421_REG_CTRL, st->ctrl);
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -400,12 +403,12 @@ static int ad5421_write_event_config(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	if (state)
 		st->fault_mask |= mask;
 	else
 		st->fault_mask &= ~mask;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return 0;
 }
@@ -491,6 +494,8 @@ static int ad5421_probe(struct spi_device *spi)
 	indio_dev->channels = ad5421_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5421_channels);
 
+	mutex_init(&st->lock);
+
 	st->ctrl = AD5421_CTRL_WATCHDOG_DISABLE |
 			AD5421_CTRL_AUTO_FAULT_READBACK;
 
-- 
2.17.1

