Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32DD1D2AD8
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 11:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgENJB2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 05:01:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26590 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgENJB1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 05:01:27 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E8xW3H000770;
        Thu, 14 May 2020 05:01:10 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100x5xnen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:01:10 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04E918Q2000361
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 05:01:09 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 02:01:07 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 02:01:07 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 02:01:07 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04E914YC011323;
        Thu, 14 May 2020 05:01:04 -0400
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: dac: ad5446: Replace indio_dev->mlock with own device lock
Date:   Thu, 14 May 2020 12:00:42 +0300
Message-ID: <20200514090048.80359-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=689 phishscore=0 priorityscore=1501
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
 drivers/iio/dac/ad5446.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 9884e29b19b7..8f8afc8999bc 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -33,6 +33,7 @@
  * @chip_info:		chip model specific constants, available modes etc
  * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
+ * @lock		lock to protect the data buffer during write ops
  */
 
 struct ad5446_state {
@@ -43,6 +44,7 @@ struct ad5446_state {
 	unsigned			cached_val;
 	unsigned			pwr_down_mode;
 	unsigned			pwr_down;
+	struct mutex			lock;
 };
 
 /**
@@ -112,7 +114,7 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->pwr_down = powerdown;
 
 	if (st->pwr_down) {
@@ -123,7 +125,7 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 	}
 
 	ret = st->chip_info->write(st, val);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -197,11 +199,11 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		val <<= chan->scan_type.shift;
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		st->cached_val = val;
 		if (!st->pwr_down)
 			ret = st->chip_info->write(st, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 		break;
 	default:
 		ret = -EINVAL;
@@ -256,6 +258,8 @@ static int ad5446_probe(struct device *dev, const char *name,
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 
+	mutex_init(&st->lock);
+
 	st->pwr_down_mode = MODE_PWRDWN_1k;
 
 	if (st->chip_info->int_vref_mv)
-- 
2.17.1

