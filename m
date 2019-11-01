Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEBEEC096
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKAJf3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55686 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727270AbfKAJf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:28 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19XUxf003899;
        Fri, 1 Nov 2019 05:35:16 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhjrw13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3m+9NQBxhx2KxGlzFTi83xpVr3qiXZpYbZRtBMAjlJxDsLu+UGUUW7YJssyllr1PGOEQir7nh8E92H9YCAmNlwyvCvkE76Qq4AC++s6rFBuVtCCePLKqOoS0FtDqxQVkiHTMk9SK1UOdYyeV22CMThtezfbsDWoEB/6MPWyVYF1M9cK2N3N1HDUKR2BfCbaO2qdFEDI0HsvwHTuo5WvVfOTezR+EZWgHyoWi5yIhWIh0L3esx2JCnNTQ/PefljOJBidQWQNEeZYYmw6EOe43JpuBN2sdwt4NE9sXq9tkmQXAm3uMr8qjtlwzdfPhsgL6rVGl3dLk+XeaObvaA8SNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je9+9pGOzDXkfWuRqa3QHNdnv44LmOlGvLG4UXexLx0=;
 b=QnRix/z2+SQVuWaXAb2C6LfxNbjI4euL27peEAz4HrgmT6E0rj52HKJViGowH+Q55/Dby+z+3YWN9GEoU8Aa3BUtdpu1itroug6nmcBWr9BB9ELEwT9U/VENi0w+Gr9Qn6nPL3JZDyPjJQL/l6fTY14Cwed1wPz+oFEjnaMpBEccpoSL167c8LWL495bp0Rf2JWMh5rjL6DrJrMsd3xfmNE+K5lmzh0bpr3/2eDhXs5SoNz4iJ03zmfRS3MOMUqhYI4ZTxOf31M93Fp65FqNPeIEFA8g6VJjJH42OumH8SR57+BuO3X5hJXSTq5fQFiOsZknxUn5G3MDtQqdkSL2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je9+9pGOzDXkfWuRqa3QHNdnv44LmOlGvLG4UXexLx0=;
 b=ALkl0GAi4q3bRj0iW8ORR5gYzmvn6Z25cYS8rJbb6Z5fJtgRijVF2Xx7W/aTEv6J/xseRixiWfj972EUJijX5Rh2IRDkp0Wp2xdmg0r/pUWxd1LSuNtzF/urJiVvshkGwz7VAfls2x8S8HpXGwMZZIqaMhmmjl88pCw654B8dNY=
Received: from CH2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:59::13)
 by BN6PR03MB2451.namprd03.prod.outlook.com (2603:10b6:404:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 09:35:14 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by CH2PR03CA0003.outlook.office365.com
 (2603:10b6:610:59::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:13 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19Z5IX024992
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:05 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:12 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 01/10] iio: gyro: adis16136: check ret val for non-zero vs less-than-zero
Date:   Fri, 1 Nov 2019 11:34:56 +0200
Message-ID: <20191101093505.9408-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(7696005)(305945005)(70206006)(8936002)(26005)(50226002)(7636002)(8676002)(426003)(44832011)(76176011)(4326008)(1076003)(14444005)(336012)(70586007)(186003)(51416003)(36756003)(486006)(246002)(6666004)(107886003)(50466002)(47776003)(2870700001)(356004)(316002)(54906003)(106002)(5660300002)(110136005)(478600001)(476003)(48376002)(86362001)(2616005)(126002)(11346002)(446003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2451;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b0f40d6-24cf-42dc-5096-08d75eaecbfc
X-MS-TrafficTypeDiagnostic: BN6PR03MB2451:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2451F3B1B3FF08DB76902C98F9620@BN6PR03MB2451.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Zi7XrweeFfw+6XzPgS/yGKIxrEhnTMWteNXrbbJUWSjXhJuc3b/GrITlf8pvpGRX6uicpaeL32PSH/zd0stBVdB2k5WhZ7uYPfLPzB5HxdkAIGm5tciEWSOgZDjRLmvQiWKdM5fgJ/Sdqr4TOQncA7Gdkkq0dtxbnNwqHrWWwmm4ogOre1wqYE0S35uHNHmLfFoBA9TqPbQrlrTXBjvvwtW6JVQSzFo8trndXzDS8MSIFoZCy8inGqtDgcERLMBxlIbSOXaljnep9smMOeK9NUAp1BSWZAVLfNHGgU2XDgn3LnnzL0XfIQVS+OP+wGiozoWSmiNT4fWYF6v0JEf1P66BFR6bHYkviakMr/AQ4HwJrD7PV8zbbGVs4+Z0yYZ+tTQXt6B4VjCW29u7l/WYVtvQnA5pz1b9JmILVTyaoAzL9QPXh4zykLBPocy4UH8
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:13.5365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0f40d6-24cf-42dc-5096-08d75eaecbfc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2451
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=947 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
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
 drivers/iio/gyro/adis16136.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 5bec7ad53d8b..d637d52d051a 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -80,19 +80,19 @@ static ssize_t adis16136_show_serial(struct file *file,
 
 	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SERIAL_NUM,
 		&serial);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_LOT1, &lot1);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_LOT2, &lot2);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_LOT3, &lot3);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	len = snprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
@@ -116,7 +116,7 @@ static int adis16136_show_product_id(void *arg, u64 *val)
 
 	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_PROD_ID,
 		&prod_id);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = prod_id;
@@ -134,7 +134,7 @@ static int adis16136_show_flash_count(void *arg, u64 *val)
 
 	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_FLASH_CNT,
 		&flash_count);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = flash_count;
@@ -191,7 +191,7 @@ static int adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
 	int ret;
 
 	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*freq = 32768 / (t + 1);
@@ -228,7 +228,7 @@ static ssize_t adis16136_read_frequency(struct device *dev,
 	int ret;
 
 	ret = adis16136_get_freq(adis16136, &freq);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	return sprintf(buf, "%d\n", freq);
@@ -256,7 +256,7 @@ static int adis16136_set_filter(struct iio_dev *indio_dev, int val)
 	int i, ret;
 
 	ret = adis16136_get_freq(adis16136, &freq);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	for (i = ARRAY_SIZE(adis16136_3db_divisors) - 1; i >= 1; i--) {
@@ -277,11 +277,11 @@ static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
 	mutex_lock(&indio_dev->mlock);
 
 	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, &val16);
-	if (ret < 0)
+	if (ret)
 		goto err_unlock;
 
 	ret = adis16136_get_freq(adis16136, &freq);
-	if (ret < 0)
+	if (ret)
 		goto err_unlock;
 
 	*val = freq / adis16136_3db_divisors[val16 & 0x07];
@@ -318,7 +318,7 @@ static int adis16136_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = adis_read_reg_32(&adis16136->adis,
 			ADIS16136_REG_GYRO_OFF2, &val32);
-		if (ret < 0)
+		if (ret)
 			return ret;
 
 		*val = sign_extend32(val32, 31);
-- 
2.20.1

