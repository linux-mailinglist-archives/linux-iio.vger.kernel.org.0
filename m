Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB121DAA85
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 08:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgETGTJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 02:19:09 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8290 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbgETGTI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 02:19:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04K6H7tq010214;
        Wed, 20 May 2020 02:18:49 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 312d35vb9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 02:18:49 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04K6IldW042165
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 20 May 2020 02:18:48 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 19 May
 2020 23:18:46 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 19 May 2020 23:18:46 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04K6IhC3024736;
        Wed, 20 May 2020 02:18:43 -0400
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: dac: ad5592r-base: Replace indio_dev->mlock with own device lock
Date:   Wed, 20 May 2020 09:18:13 +0300
Message-ID: <20200520061819.29056-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_02:2020-05-19,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=743
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/dac/ad5592r-base.c | 28 +++++++++++++++-------------
 drivers/iio/dac/ad5592r-base.h |  1 +
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index e2110113e884..10109eb81db2 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -166,10 +166,10 @@ static int ad5592r_reset(struct ad5592r_state *st)
 		udelay(1);
 		gpiod_set_value(gpio, 1);
 	} else {
-		mutex_lock(&iio_dev->mlock);
+		mutex_lock(&st->lock);
 		/* Writing this magic value resets the device */
 		st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
-		mutex_unlock(&iio_dev->mlock);
+		mutex_unlock(&st->lock);
 	}
 
 	udelay(250);
@@ -247,7 +247,7 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
 		}
 	}
 
-	mutex_lock(&iio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	/* Pull down unused pins to GND */
 	ret = ops->reg_write(st, AD5592R_REG_PULLDOWN, pulldown);
@@ -285,7 +285,7 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
 		ret = -EIO;
 
 err_unlock:
-	mutex_unlock(&iio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -314,11 +314,11 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 		if (!chan->output)
 			return -EINVAL;
 
-		mutex_lock(&iio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = st->ops->write_dac(st, chan->channel, val);
 		if (!ret)
 			st->cached_dac[chan->channel] = val;
-		mutex_unlock(&iio_dev->mlock);
+		mutex_unlock(&st->lock);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_VOLTAGE) {
@@ -333,12 +333,12 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 			else
 				return -EINVAL;
 
-			mutex_lock(&iio_dev->mlock);
+			mutex_lock(&st->lock);
 
 			ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
 						&st->cached_gp_ctrl);
 			if (ret < 0) {
-				mutex_unlock(&iio_dev->mlock);
+				mutex_unlock(&st->lock);
 				return ret;
 			}
 
@@ -360,7 +360,7 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 
 			ret = st->ops->reg_write(st, AD5592R_REG_CTRL,
 						 st->cached_gp_ctrl);
-			mutex_unlock(&iio_dev->mlock);
+			mutex_unlock(&st->lock);
 
 			return ret;
 		}
@@ -382,7 +382,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&iio_dev->mlock);
+		mutex_lock(&st->lock);
 
 		if (!chan->output) {
 			ret = st->ops->read_adc(st, chan->channel, &read_val);
@@ -419,7 +419,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 		} else {
 			int mult;
 
-			mutex_lock(&iio_dev->mlock);
+			mutex_lock(&st->lock);
 
 			if (chan->output)
 				mult = !!(st->cached_gp_ctrl &
@@ -437,7 +437,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		ret = ad5592r_get_vref(st);
 
-		mutex_lock(&iio_dev->mlock);
+		mutex_lock(&st->lock);
 
 		if (st->cached_gp_ctrl & AD5592R_REG_CTRL_ADC_RANGE)
 			*val = (-34365 * 25) / ret;
@@ -450,7 +450,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 	}
 
 unlock:
-	mutex_unlock(&iio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -625,6 +625,8 @@ int ad5592r_probe(struct device *dev, const char *name,
 	iio_dev->info = &ad5592r_info;
 	iio_dev->modes = INDIO_DIRECT_MODE;
 
+	mutex_init(&st->lock);
+
 	ad5592r_init_scales(st, ad5592r_get_vref(st));
 
 	ret = ad5592r_reset(st);
diff --git a/drivers/iio/dac/ad5592r-base.h b/drivers/iio/dac/ad5592r-base.h
index 4774e4cd9c11..23dac2f1ff8a 100644
--- a/drivers/iio/dac/ad5592r-base.h
+++ b/drivers/iio/dac/ad5592r-base.h
@@ -52,6 +52,7 @@ struct ad5592r_state {
 	struct regulator *reg;
 	struct gpio_chip gpiochip;
 	struct mutex gpio_lock;	/* Protect cached gpio_out, gpio_val, etc. */
+	struct mutex lock;
 	unsigned int num_channels;
 	const struct ad5592r_rw_ops *ops;
 	int scale_avail[2][2];
-- 
2.17.1

