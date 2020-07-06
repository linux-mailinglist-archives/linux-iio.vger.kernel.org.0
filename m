Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA3F2153A9
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jul 2020 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgGFIDL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jul 2020 04:03:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1510 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728169AbgGFIDK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2020 04:03:10 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06681bJh005600;
        Mon, 6 Jul 2020 04:03:09 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 322pp5dmft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 04:03:09 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0668382B016851
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 6 Jul 2020 04:03:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 6 Jul 2020
 04:03:07 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 6 Jul 2020 04:03:07 -0400
Received: from saturn.ad.analog.com ([10.48.65.100])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 066832Se010445;
        Mon, 6 Jul 2020 04:03:05 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3] iio: dac: ad5592r: localize locks only where needed in ad5592r_read_raw()
Date:   Mon, 6 Jul 2020 14:02:59 +0300
Message-ID: <20200706110259.23947-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706110259.23947-1-alexandru.ardelean@analog.com>
References: <20200706110259.23947-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_04:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 mlxlogscore=940 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007060064
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since there was a recently discovered issue with these locks, it probably
makes sense to cleanup the code a bit, to prevent it from being used as an
example/reference.

This change moves the lock only where it is explicitly needed to protect
resources from potential concurrent accesses.

It also reworks the switch statements to do direct returns vs caching the
return value on a variable.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/ad5592r-base.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 7ea79e9bfa1d..f697b20efb6e 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -380,32 +380,32 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
-
 		if (!chan->output) {
+			mutex_lock(&st->lock);
 			ret = st->ops->read_adc(st, chan->channel, &read_val);
+			mutex_unlock(&st->lock);
 			if (ret)
-				goto unlock;
+				return ret;
 
 			if ((read_val >> 12 & 0x7) != (chan->channel & 0x7)) {
 				dev_err(st->dev, "Error while reading channel %u\n",
 						chan->channel);
-				ret = -EIO;
-				goto unlock;
+				return -EIO;
 			}
 
 			read_val &= GENMASK(11, 0);
 
 		} else {
+			mutex_lock(&st->lock);
 			read_val = st->cached_dac[chan->channel];
+			mutex_unlock(&st->lock);
 		}
 
 		dev_dbg(st->dev, "Channel %u read: 0x%04hX\n",
 				chan->channel, read_val);
 
 		*val = (int) read_val;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = ad5592r_get_vref(st);
 
@@ -425,11 +425,13 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			mult = !!(st->cached_gp_ctrl &
 				AD5592R_REG_CTRL_ADC_RANGE);
 
+		mutex_unlock(&st->lock);
+
 		*val *= ++mult;
 
 		*val2 = chan->scan_type.realbits;
-		ret = IIO_VAL_FRACTIONAL_LOG2;
-		break;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
 		ret = ad5592r_get_vref(st);
 
@@ -439,15 +441,13 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			*val = (-34365 * 25) / ret;
 		else
 			*val = (-75365 * 25) / ret;
-		ret =  IIO_VAL_INT;
-		break;
+
+		mutex_unlock(&st->lock);
+
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
-
-unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static int ad5592r_write_raw_get_fmt(struct iio_dev *indio_dev,
-- 
2.25.1

