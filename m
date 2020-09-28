Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52CF27AEE1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Sep 2020 15:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgI1NOV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Sep 2020 09:14:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24108 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726681AbgI1NOU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Sep 2020 09:14:20 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SD9Q3D011247;
        Mon, 28 Sep 2020 09:14:05 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg5ycef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 09:14:05 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08SDE3Ge065282
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 28 Sep 2020 09:14:04 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 28 Sep 2020 06:13:57 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 28 Sep 2020 06:13:59 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 28 Sep 2020 06:13:56 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08SDDuB4030926;
        Mon, 28 Sep 2020 09:13:57 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 1/5] iio: adc: spear_adc: Replace indio_dev->mlock with own device lock
Date:   Mon, 28 Sep 2020 16:13:29 +0300
Message-ID: <20200928131333.36646-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1011 mlxlogscore=607
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280104
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

This is part of a bigger cleanup.
Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/adc/spear_adc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 1bc986a7009d..d93e580b3dc5 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -75,6 +75,15 @@ struct spear_adc_state {
 	struct adc_regs_spear6xx __iomem *adc_base_spear6xx;
 	struct clk *clk;
 	struct completion completion;
+	/*
+	 * Lock to protect the device state during a potential concurrent
+	 * read access from userspace. Reading a raw value requires a sequence
+	 * of register writes, then a wait for a completion callback,
+	 * and finally a register read, during which userspace could issue
+	 * another read request. This lock protects a read access from
+	 * ocurring before another one has finished.
+	 */
+	struct mutex lock;
 	u32 current_clk;
 	u32 sampling_freq;
 	u32 avg_samples;
@@ -146,7 +155,7 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 
 		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
 			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
@@ -159,7 +168,7 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
 		wait_for_completion(&st->completion); /* set by ISR */
 		*val = st->value;
 
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 
 		return IIO_VAL_INT;
 
@@ -187,7 +196,7 @@ static int spear_adc_write_raw(struct iio_dev *indio_dev,
 	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	if ((val < SPEAR_ADC_CLK_MIN) ||
 	    (val > SPEAR_ADC_CLK_MAX) ||
@@ -199,7 +208,7 @@ static int spear_adc_write_raw(struct iio_dev *indio_dev,
 	spear_adc_set_clk(st, val);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -271,6 +280,9 @@ static int spear_adc_probe(struct platform_device *pdev)
 	}
 
 	st = iio_priv(indio_dev);
+
+	mutex_init(&st->lock);
+
 	st->np = np;
 
 	/*
-- 
2.25.1

