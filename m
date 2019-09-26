Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0033BF10A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfIZLSv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:51 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29728 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfIZLSm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:42 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBI6OF003191;
        Thu, 26 Sep 2019 07:18:39 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2054.outbound.protection.outlook.com [104.47.32.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hjwya00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/6XBdaBgiXp5yeHxrDC+yYrP2NmoTsC0REMQzAnnc0lFe9UnEHjBuclJ8nY18dM0f6DBi+XTifoQFigyjP/z1zC/cajOpsLsmgtBywIMM3QCfnQDhfoHtfjARiS0X+M2wOrWFf/aZwtX9nseHG/dBTlzpuNJ8A34UXwtduniyTf2QK10rsHUDOxP39/dynw5T3Gtzdf2o/By7Vh7XB1TZwUbXSIo6PMDKIKerXp5r5akGVWGVj42FvkFGw9YSVlnEYrDOpV/HyW6EMn3rlc9BN1MwFFHYTFHq3e1S1l2ojJWvRxm+KKM8WJKnk+zu1A56+YOErNZhOPysG+HZfWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcdIUVCOGcoLSqT2gBklcnjlTHvaC4giJBZ5+DJTuTE=;
 b=OMeaZ47uep3NK+InlpKqISLZsxWQWjngIEo/eSTVSk5Zkjyq0RMCSg9JbZDBf9X+0dKvCKzKA7VVufPFfZhcoJ5UV+RuiZM5oastUmqJVLDqU2QsbSKnWut5UBofKVSAdxS3tvl/zHiqk0rs1YTbXTClGKkk/p8QQig0QNpY1jrxLM+Jbi2sRZbwnFZlNAgKamq6eUtlxQklDDwPxQE2b6e+cL6KNNxHO9hYO2Ts+vb0PCHl0joYg4yCR+L8Z04S1oR2erL6cOc9yB1EMbobMhZ5sWTWj4cCUwMFM6A5uJCHkHzQp0o0LjgZAc+TcX/k5Jf9S9FGNwLXizC3id6nFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcdIUVCOGcoLSqT2gBklcnjlTHvaC4giJBZ5+DJTuTE=;
 b=OPi2IgVONMmSMNHJ/nJKB+YSD9/4kv9lHGWFGWF2601RrUbQTiXQcnPyNrNaZih6UF6flKg+Lxvzr1Iy7707MmoMZif8/lOJ9v+MX64fEQo5uRE6AnYw+5doRY2ZgWTxgOog+Zf08/q2oz1obE63pyItWKskVYXvpprCrlMSlag=
Received: from BN3PR03CA0063.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::23) by CY4PR03MB3159.namprd03.prod.outlook.com
 (2603:10b6:910:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 11:18:37 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN3PR03CA0063.outlook.office365.com
 (2a01:111:e400:7a4d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:36 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 11:18:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBIUnC004192
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:30 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:35 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 08/10] iio: imu: adis16400: rework locks using ADIS library's state lock
Date:   Thu, 26 Sep 2019 14:18:10 +0300
Message-ID: <20190926111812.15957-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(106002)(6666004)(305945005)(86362001)(2616005)(26005)(11346002)(478600001)(50466002)(126002)(8676002)(486006)(316002)(110136005)(8936002)(50226002)(446003)(5660300002)(476003)(7636002)(44832011)(1076003)(51416003)(246002)(356004)(54906003)(186003)(70206006)(48376002)(4326008)(336012)(426003)(70586007)(14444005)(2870700001)(7696005)(107886003)(47776003)(36756003)(76176011)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3159;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac10fd9e-3df6-42ae-9525-08d742734650
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:CY4PR03MB3159;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3159:
X-Microsoft-Antispam-PRVS: <CY4PR03MB3159E69B875021E32B54E380F9860@CY4PR03MB3159.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 02q08vM9uc/1+UZLWqrq3RFs9ZhgnVdN7J6no9iJdIWtZB3CVy2N92c+daT+T5dlhT4+rz0EzZteUY/xfHgyOD26gic/aB23WXoAheiZmU++X+kOBoqnWA9cPALDV4ZMPPg5X4TFbyDcX3unSgGtr+CM61JlJWeS9Dyx+kfGn9jfbQTDsCmt4go3nZW6lJlMuNiAo3zsBM5G6WmcAhg1GHM6W2Dt+0QweRh1IqKb6dZ0A7odnaNTn0+4tuKp6ZTtvTry4GZG9zqTrUsqvRI0Dc7gCr4/GbEEl4RxmUWK9u7qXW19V9uG8ETidp9wy0B6ugZyWzpiyeRHQAl71W8ZDW0daiLFo5ZOoBdcPj1K4JWvZChXhdTe52KI6lVLK6m2/tdixE8avviJ23VDrhUWCpHaUIwc9fa87VgmLZBf4Ro=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:36.3542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac10fd9e-3df6-42ae-9525-08d742734650
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3159
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change removes the use of indio_dev's mlock in favor using the state
lock from the ADIS library.

The set_freq() & get_freq() hooks are unlocked, so they require specific
locking. That is because in some cases the get_freq() hook is used in
combination with adis16400_set_filter().

In cases where only one read/write is done, the functions that hold the
state lock are used.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16400.c | 51 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 0575ff706bd4..e042a2aabf6b 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -162,6 +162,7 @@ struct adis16400_chip_info {
 	unsigned int accel_scale_micro;
 	int temp_scale_nano;
 	int temp_offset;
+	/* set_freq() & get_freq() need to avoid using ADIS lib's state lock */
 	int (*set_freq)(struct adis16400_state *st, unsigned int freq);
 	int (*get_freq)(struct adis16400_state *st);
 };
@@ -326,7 +327,7 @@ static int adis16334_get_freq(struct adis16400_state *st)
 	int ret;
 	uint16_t t;
 
-	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
+	ret = __adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
 	if (ret < 0)
 		return ret;
 
@@ -350,7 +351,7 @@ static int adis16334_set_freq(struct adis16400_state *st, unsigned int freq)
 	t <<= ADIS16334_RATE_DIV_SHIFT;
 	t |= ADIS16334_RATE_INT_CLK;
 
-	return adis_write_reg_16(&st->adis, ADIS16400_SMPL_PRD, t);
+	return __adis_write_reg_16(&st->adis, ADIS16400_SMPL_PRD, t);
 }
 
 static int adis16400_get_freq(struct adis16400_state *st)
@@ -358,7 +359,7 @@ static int adis16400_get_freq(struct adis16400_state *st)
 	int sps, ret;
 	uint16_t t;
 
-	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
+	ret = __adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
 	if (ret < 0)
 		return ret;
 
@@ -390,7 +391,7 @@ static int adis16400_set_freq(struct adis16400_state *st, unsigned int freq)
 	else
 		st->adis.spi->max_speed_hz = ADIS16400_SPI_FAST;
 
-	return adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, val);
+	return __adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, val);
 }
 
 static const unsigned int adis16400_3db_divisors[] = {
@@ -404,7 +405,7 @@ static const unsigned int adis16400_3db_divisors[] = {
 	[7] = 200, /* Not a valid setting */
 };
 
-static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
+static int __adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
 	uint16_t val16;
@@ -415,11 +416,11 @@ static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
 			break;
 	}
 
-	ret = adis_read_reg_16(&st->adis, ADIS16400_SENS_AVG, &val16);
+	ret = __adis_read_reg_16(&st->adis, ADIS16400_SENS_AVG, &val16);
 	if (ret < 0)
 		return ret;
 
-	ret = adis_write_reg_16(&st->adis, ADIS16400_SENS_AVG,
+	ret = __adis_write_reg_16(&st->adis, ADIS16400_SENS_AVG,
 					 (val16 & ~0x07) | i);
 	return ret;
 }
@@ -507,32 +508,31 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long info)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
+	struct mutex *slock = &st->adis.state_lock;
 	int ret, sps;
 
 	switch (info) {
 	case IIO_CHAN_INFO_CALIBBIAS:
-		mutex_lock(&indio_dev->mlock);
 		ret = adis_write_reg_16(&st->adis,
 				adis16400_addresses[chan->scan_index], val);
-		mutex_unlock(&indio_dev->mlock);
 		return ret;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		/*
 		 * Need to cache values so we can update if the frequency
 		 * changes.
 		 */
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(slock);
 		st->filt_int = val;
 		/* Work out update to current value */
 		sps = st->variant->get_freq(st);
 		if (sps < 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(slock);
 			return sps;
 		}
 
-		ret = adis16400_set_filter(indio_dev, sps,
+		ret = __adis16400_set_filter(indio_dev, sps,
 			val * 1000 + val2 / 1000);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(slock);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		sps = val * 1000 + val2 / 1000;
@@ -540,9 +540,9 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 		if (sps <= 0)
 			return -EINVAL;
 
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(slock);
 		ret = st->variant->set_freq(st, sps);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(slock);
 		return ret;
 	default:
 		return -EINVAL;
@@ -553,6 +553,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long info)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
+	struct mutex *slock = &st->adis.state_lock;
 	int16_t val16;
 	int ret;
 
@@ -596,10 +597,8 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_CALIBBIAS:
-		mutex_lock(&indio_dev->mlock);
 		ret = adis_read_reg_16(&st->adis,
 				adis16400_addresses[chan->scan_index], &val16);
-		mutex_unlock(&indio_dev->mlock);
 		if (ret)
 			return ret;
 		val16 = sign_extend32(val16, 11);
@@ -610,27 +609,27 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		*val = st->variant->temp_offset;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(slock);
 		/* Need both the number of taps and the sampling frequency */
-		ret = adis_read_reg_16(&st->adis,
+		ret = __adis_read_reg_16(&st->adis,
 						ADIS16400_SENS_AVG,
 						&val16);
 		if (ret < 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(slock);
 			return ret;
 		}
 		ret = st->variant->get_freq(st);
-		if (ret >= 0) {
-			ret /= adis16400_3db_divisors[val16 & 0x07];
-			*val = ret / 1000;
-			*val2 = (ret % 1000) * 1000;
-		}
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(slock);
 		if (ret < 0)
 			return ret;
+		ret /= adis16400_3db_divisors[val16 & 0x07];
+		*val = ret / 1000;
+		*val2 = (ret % 1000) * 1000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(slock);
 		ret = st->variant->get_freq(st);
+		mutex_unlock(slock);
 		if (ret < 0)
 			return ret;
 		*val = ret / 1000;
-- 
2.20.1

