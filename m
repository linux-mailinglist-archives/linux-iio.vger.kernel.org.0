Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA62EC097
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfKAJfb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57596 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727270AbfKAJfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:30 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19XUxh003899;
        Fri, 1 Nov 2019 05:35:19 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2056.outbound.protection.outlook.com [104.47.46.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhjrw17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H78Llg+Q0nE/ZAY4OOahknXXBQdfPsjZBuxyTsXceTZqUuS9Xzu8DVHTG3tMUdGH9Nuyt0Y/ttsKm9VbOPTmLWhiuGdJIGj+lPMTD4OCFylXnyw8j0glW8qvBZoUpHBpPmRCIi6m1mFgkqDMR0LlydhRnk5pfyF1SO/WDKJbTK5A1KhkdeDHNcZrM1cmrdopDwjG9tpshQBJ0Ec6tLfKqW9ZuE0eZS0AjfkuvqXtk3FGAyyxkR067kkjcRgz8Pzxv38uxF8kXuI+MQC18Fpg8NevJwm+Wz8qjB49rPwxjsvbbRuURkms9gGSq6Lr2WeG2y6Qf8DA7XJn4OzA6bQL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G65wO7Q+8Wo/ReS6nFB4Ml8UlOgZXigBZFLRRrqW2g=;
 b=nUyVBEedT8cKm8P3caBmk3LHDJNxXnWRgY1WakHVN8FPAQWJnPHsOAHcJ8WLzbYP90IUyC5GqA7mjxzqGCvPp7Y5Ubctw6ldrP2GKxrWWmeaSv05bDYnpPRDgVhZAXTBKn7qXpod4Pdi8BvfcyhwiPSZmoH0dh26xTV01c4d28Or6mZw0T9yTHNiDOl9vD/i6hSkbeEGC7efhBpfj4WIOp8vYAQS3Sdqoq1glPBALMs7+evJIEokxaghYLTMvMo0Ysn2/ukKDwWCx75TJvcqJdb4wivc/bpSyWJfCm+ZTRNFXAgTswX4UuNoYgSwvmeooPbg+5cSegCdDdF6Ri1qfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G65wO7Q+8Wo/ReS6nFB4Ml8UlOgZXigBZFLRRrqW2g=;
 b=TtW/3VI7zTlhb1B8Wry5yxDaZgkBcWyqkiZx1ht+fGjCJmkDApdi6l/qCeGEvGd/X/Oxz8K4Saf1ttRwNnS8jmTC7uf7GZdB6l/P1/TWYzaqEAd7Tt/EWOyd6/+mJ5MT7WOkzuMVGG7X40OOnnJljHqhLc4xoxzgkEVmZJjfhfg=
Received: from BN6PR03CA0120.namprd03.prod.outlook.com (2603:10b6:404:10::34)
 by BYAPR03MB3477.namprd03.prod.outlook.com (2603:10b6:a02:b7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 09:35:15 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN6PR03CA0120.outlook.office365.com
 (2603:10b6:404:10::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:15 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19Z7EU024998
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:07 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:14 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 02/10] iio: imu: adis16400: check ret val for non-zero vs less-than-zero
Date:   Fri, 1 Nov 2019 11:34:57 +0200
Message-ID: <20191101093505.9408-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(305945005)(476003)(44832011)(7696005)(8676002)(51416003)(356004)(246002)(76176011)(126002)(6666004)(7636002)(26005)(36756003)(486006)(86362001)(1076003)(70586007)(50226002)(70206006)(8936002)(5660300002)(107886003)(50466002)(2870700001)(336012)(2906002)(186003)(446003)(106002)(47776003)(110136005)(316002)(2616005)(478600001)(54906003)(4326008)(426003)(48376002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3477;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06799c7f-73e8-4399-7e6e-08d75eaecd09
X-MS-TrafficTypeDiagnostic: BYAPR03MB3477:
X-Microsoft-Antispam-PRVS: <BYAPR03MB347706E14F805A2EF549B5F3F9620@BYAPR03MB3477.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuR47KlX5rvUsAbui7g31XAmz2q09IWrIzkoO0cF8ohsiXVpS6kMYNbGoqOK82klKLkebOyMm00sqOSHDOVO6XQWsSLVIfQdlHPi2uAw8Tee2BhGLZ6Rd/FTi2NnDaAVdQQxv/oyUsC8+aEZ95uTxezackbwy2VCcdYn9AX9jtgGmVstUbvvdU4pLWmT/27yQ94xLxV5WCxJXUsVznY5sHCvnR+MBSXLyylW1/5Fr49XbFlQPwr7Swm+eUKprhHhU3JHPW6YnerPFVuS7F8oztV9yOZk5WljVlIEhMxTYwCLXEPzoeLhGg0gYFU9dEOl/i7mFz3v7fdzrCJ2dISzHb4c+i6GfqCUh4zoHn8Rx0GMbRcGiTXaqif9OAfNfmR/3Xb79l05Rr6RJoT7zmlJg1Appkz9iRxOcZNrL0pBQqZeC/bPVsmIbq1O/dyM/e8v
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:15.3076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06799c7f-73e8-4399-7e6e-08d75eaecd09
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3477
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=966 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADIS library functions return zero on success, and negative values for
error. Positive values aren't returned, but we only care about the success
value (which is zero).

This change is mostly needed so that the compiler won't make any inferences
about some about values being potentially un-initialized. This only
triggers after making some functions inline, because the compiler can
better follow return paths.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16400.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 0575ff706bd4..44e46dc96e00 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -217,16 +217,16 @@ static ssize_t adis16400_show_serial_number(struct file *file,
 	int ret;
 
 	ret = adis_read_reg_16(&st->adis, ADIS16334_LOT_ID1, &lot1);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = adis_read_reg_16(&st->adis, ADIS16334_LOT_ID2, &lot2);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = adis_read_reg_16(&st->adis, ADIS16334_SERIAL_NUMBER,
 			&serial_number);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	len = snprintf(buf, sizeof(buf), "%.4x-%.4x-%.4x\n", lot1, lot2,
@@ -249,7 +249,7 @@ static int adis16400_show_product_id(void *arg, u64 *val)
 	int ret;
 
 	ret = adis_read_reg_16(&st->adis, ADIS16400_PRODUCT_ID, &prod_id);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = prod_id;
@@ -266,7 +266,7 @@ static int adis16400_show_flash_count(void *arg, u64 *val)
 	int ret;
 
 	ret = adis_read_reg_16(&st->adis, ADIS16400_FLASH_CNT, &flash_count);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = flash_count;
@@ -327,7 +327,7 @@ static int adis16334_get_freq(struct adis16400_state *st)
 	uint16_t t;
 
 	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	t >>= ADIS16334_RATE_DIV_SHIFT;
@@ -359,7 +359,7 @@ static int adis16400_get_freq(struct adis16400_state *st)
 	uint16_t t;
 
 	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	sps = (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 52851 : 1638404;
@@ -416,7 +416,7 @@ static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
 	}
 
 	ret = adis_read_reg_16(&st->adis, ADIS16400_SENS_AVG, &val16);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = adis_write_reg_16(&st->adis, ADIS16400_SENS_AVG,
@@ -615,7 +615,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(&st->adis,
 						ADIS16400_SENS_AVG,
 						&val16);
-		if (ret < 0) {
+		if (ret) {
 			mutex_unlock(&indio_dev->mlock);
 			return ret;
 		}
@@ -626,12 +626,12 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			*val2 = (ret % 1000) * 1000;
 		}
 		mutex_unlock(&indio_dev->mlock);
-		if (ret < 0)
+		if (ret)
 			return ret;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = st->variant->get_freq(st);
-		if (ret < 0)
+		if (ret)
 			return ret;
 		*val = ret / 1000;
 		*val2 = (ret % 1000) * 1000;
-- 
2.20.1

