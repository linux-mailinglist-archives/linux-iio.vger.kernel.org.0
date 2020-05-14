Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16F1D2B0B
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgENJNq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 05:13:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21726 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENJNq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 05:13:46 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E9Bmgr021706;
        Thu, 14 May 2020 05:13:30 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100y96juj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:13:30 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04E9DSoA003337
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 05:13:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 05:13:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 05:13:27 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 05:13:27 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04E9DM9P011742;
        Thu, 14 May 2020 05:13:23 -0400
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: dac: ad5380: Replace indio_dev->mlock with own device lock
Date:   Thu, 14 May 2020 12:13:11 +0300
Message-ID: <20200514091312.81032-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 cotscore=-2147483648
 phishscore=0 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxlogscore=750 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/dac/ad5380.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 2ebe08326048..b37e5675f716 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -51,6 +51,7 @@ struct ad5380_chip_info {
  * @vref_reg:		vref supply regulator
  * @vref:		actual reference voltage used in uA
  * @pwr_down:		whether the chip is currently in power down mode
+ * @lock		lock to protect the data buffer during regmap ops
  */
 
 struct ad5380_state {
@@ -59,6 +60,7 @@ struct ad5380_state {
 	struct regulator		*vref_reg;
 	int				vref;
 	bool				pwr_down;
+	struct mutex			lock;
 };
 
 enum ad5380_type {
@@ -98,7 +100,7 @@ static ssize_t ad5380_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	if (pwr_down)
 		ret = regmap_write(st->regmap, AD5380_REG_SF_PWR_DOWN, 0);
@@ -107,7 +109,7 @@ static ssize_t ad5380_write_dac_powerdown(struct iio_dev *indio_dev,
 
 	st->pwr_down = pwr_down;
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -390,6 +392,8 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
+	mutex_init(&st->lock);
+
 	ret = ad5380_alloc_channels(indio_dev);
 	if (ret) {
 		dev_err(dev, "Failed to allocate channel spec: %d\n", ret);
-- 
2.17.1

