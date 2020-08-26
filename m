Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F87252794
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 08:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgHZGnF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 02:43:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2790 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgHZGnF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 02:43:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07Q6UGXc026770;
        Wed, 26 Aug 2020 02:43:04 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 332w764kfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 02:43:04 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07Q6h2sU015706
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 26 Aug 2020 02:43:03 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 23:43:01 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Aug 2020 23:42:37 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Aug 2020 23:43:01 -0700
Received: from saturn.ad.analog.com ([10.48.65.100])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07Q6gwen018958;
        Wed, 26 Aug 2020 02:42:59 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: frequency: adf4350: Replace indio_dev->mlock with own device lock
Date:   Wed, 26 Aug 2020 09:42:57 +0300
Message-ID: <20200826064257.53475-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_03:2020-08-25,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=590 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008260050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock on the device's state structure.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/frequency/adf4350.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 409c9c47161e..3f37a57cd3c3 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -47,6 +47,7 @@ struct adf4350_state {
 	unsigned long			regs[6];
 	unsigned long			regs_hw[6];
 	unsigned long long		freq_req;
+	struct mutex			lock;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -99,7 +100,7 @@ static int adf4350_reg_access(struct iio_dev *indio_dev,
 	if (reg > ADF4350_REG5)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	if (readval == NULL) {
 		st->regs[reg] = writeval & ~(BIT(0) | BIT(1) | BIT(2));
 		ret = adf4350_sync_config(st);
@@ -107,7 +108,7 @@ static int adf4350_reg_access(struct iio_dev *indio_dev,
 		*readval =  st->regs_hw[reg];
 		ret = 0;
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -254,7 +255,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	switch ((u32)private) {
 	case ADF4350_FREQ:
 		ret = adf4350_set_freq(st, readin);
@@ -295,7 +296,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
 	default:
 		ret = -EINVAL;
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -309,7 +310,7 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
 	unsigned long long val;
 	int ret = 0;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	switch ((u32)private) {
 	case ADF4350_FREQ:
 		val = (u64)((st->r0_int * st->r1_mod) + st->r0_fract) *
@@ -338,7 +339,7 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 		val = 0;
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret < 0 ? ret : sprintf(buf, "%llu\n", val);
 }
@@ -539,6 +540,8 @@ static int adf4350_probe(struct spi_device *spi)
 	indio_dev->channels = &adf4350_chan;
 	indio_dev->num_channels = 1;
 
+	mutex_init(&st->lock);
+
 	st->chspc = pdata->channel_spacing;
 	if (clk) {
 		st->clk = clk;
-- 
2.25.1

