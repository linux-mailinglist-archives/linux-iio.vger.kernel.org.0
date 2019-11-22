Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFBA10733D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfKVNae (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23224 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727935AbfKVNaJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:09 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDNBk4026854;
        Fri, 22 Nov 2019 08:30:07 -0500
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2059.outbound.protection.outlook.com [104.47.48.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2waew7wbpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:30:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxMZbPkefpGbOGbwRS43SQJ0ZMjU+TpQFGFYGAaQqPFYdqZWctx7InNui5VpLynrYsvy/9t+gJOMh4eW9QidXHiN+aPwfBSAxgtyUN/mPekE6J17QRHhdEl3v37icLgfeviOhWUdE5zOiHy1FSu5bmy+VukLWEqh0O69hb0O+cA32W5w6WbbUvmm/ZzhuvfjUNL4MRrmAPPuVZ6fSnAebVxku+qrDd2Ct8yylR4xkdzSMM1v1Zutxni1Qw/wlIkiIzLvokwj0z5QlXei5EKs6gf7O15bYiUp4KZOVHKJaMYWemlKW/uj2a0E2Y55ZHg0HJH6HbRaAlnOmQj137ps/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV3ckVyL26em++YG1RVNvdQ9xqdh7wLi1JEopRzYCO8=;
 b=gEcqGUUlUSJZCVVqPpquuu4hKAfr2LNlT+OH3xZ/MOVIPy52WFt0VPXqbVqbXi/R9LL8UsS17X2DGDQu9sLLqydm+sbnTF8EH2VwtYvgtWaHNnGkw8hxj4+i2t4iUAInFAhFzEKgrfEhaq+kuSSzOKz88WD0kn2VAM+0Xnvo+T8ee/Lv76I1TAAlULzwhnI0I1WB70K8/Cr/5wCa4/XJNBuI3ctf+r/2rx7S93xLXyAYhikqC+5hUHCfomGtNTFNBs2htryijHBpmVpQ449P91clWBI/g/lXazMB/t7jfGDtXxGzqth59B2bNKisQMLTrayLI+IP9AMIngFzXW79YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV3ckVyL26em++YG1RVNvdQ9xqdh7wLi1JEopRzYCO8=;
 b=gOFFOLXBL5E4r6ROzmNr5jekeOUpRKQfpMwyV55QyQpx7HyUSzUSm1YKMUuNJ6TbSiHO+SqR6aR04x0uBHr/UEL8ZIOj8LMxTaSXJKR7x/ZaBergir3scUfGJrJohmlxhT8kymZYyXkW+8EN0Ia0wEIifn3S4Rp1o+X5pSgqN5U=
Received: from CY1PR03CA0008.namprd03.prod.outlook.com (2603:10b6:600::18) by
 MN2PR03MB4781.namprd03.prod.outlook.com (2603:10b6:208:ae::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 22 Nov 2019 13:30:05 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CY1PR03CA0008.outlook.office365.com
 (2603:10b6:600::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Fri, 22 Nov 2019 13:30:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:30:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDTt38015836
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:55 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:30:03 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 08/11] iio: imu: adis16400: rework locks using ADIS library's state lock
Date:   Fri, 22 Nov 2019 15:24:18 +0200
Message-ID: <20191122132421.5500-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(336012)(70206006)(44832011)(478600001)(186003)(70586007)(426003)(76176011)(26005)(2616005)(51416003)(305945005)(11346002)(7696005)(446003)(1076003)(5660300002)(7636002)(36756003)(106002)(48376002)(316002)(50466002)(14444005)(107886003)(8676002)(110136005)(54906003)(2906002)(2870700001)(50226002)(8936002)(47776003)(246002)(86362001)(4326008)(356004)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4781;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 261d0b66-39cb-476f-c755-08d76f50159e
X-MS-TrafficTypeDiagnostic: MN2PR03MB4781:
X-Microsoft-Antispam-PRVS: <MN2PR03MB4781BD66C673D84FED8E493CF9490@MN2PR03MB4781.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8nbMp8753aLiJ9e+TEqNaKz7EOi78q94cZ6EgrLTxvsOFKJkZ25Q445fmVNZRstVIk4djD22u8ZbUJEkAJY+IyW6IYEhMm+wYNqpVTLooslLlpgVpY/9MFXl2R7e6n1Cq3YmqAU+DSllq6n8IObmo3Z39GbOQQ+1BM3afz8gV3D20JB6JplOGbrKz7fvqhhLnPknPUuntwOXDpzqbS5UsV62UTAcKl0gseCdr1iRlJCahQLOxKxBQdlNHTljPkXRm/MT+4fl22Scrv4daQi8NNZzqvhvE5lcJPXoyauWO5dbooC1JEQ9ELk8V0NSQqf49XJ/CmCNnfYKeMzCRHgEPOIJ4evPlooMWepwIPPbUNlO9xdV6K7Cf7b8axya4o96mgksD4BmL4WsTCRifTJqxBAYHWyLmeoKKUOmmNtBJBMcNsKzOaxDBDvd+Z9Juef
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:30:04.5867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 261d0b66-39cb-476f-c755-08d76f50159e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4781
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220119
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
index 44e46dc96e00..662cb5367c11 100644
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
 	if (ret)
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
 	if (ret)
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
 	if (ret)
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
 		if (ret) {
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
 		if (ret)
 			return ret;
+		ret /= adis16400_3db_divisors[val16 & 0x07];
+		*val = ret / 1000;
+		*val2 = (ret % 1000) * 1000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(slock);
 		ret = st->variant->get_freq(st);
+		mutex_unlock(slock);
 		if (ret)
 			return ret;
 		*val = ret / 1000;
-- 
2.20.1

