Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1205BF108
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfIZLSu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:50 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30292 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726206AbfIZLSm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:42 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBI8Xp014586;
        Thu, 26 Sep 2019 07:18:40 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hj96t5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=argy5xUAO7xQS3yifgZM9XsE2M7wt38kZ+UYjBFrfO5dmrS1nvGqM9K1WA4kYFWogOUzeDHjaMDUDSravFY+zDIA43vWi+ms8wzhX+o6vhD+SC5CQg4osvrgEguqWJ84t/TV42aErgPf0LDqXYNjI3QiN5HMcAchQ02JAo6StWHn/ouOEwmgi0dFN3iOzTUbdlEI9/Np+C8x6MAFGMyX1thJlJ5WlNSLhutN3F6G0Awn9iSiHzFORBVES9Q1Rq6d5/1VtqhLdzRUyN+DtNH9DH0OCAcY+7Bqv1TezY7clDl4qWgHs/3lqcS/A3vPbW0qvmNgJBzCr/IQVxgbndVZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLOk3w7WdcoVWiQm4iPTxPv7wYsgV2TkKKznHWaJo14=;
 b=JI/eWkhnUyFiIA8e4e0b0/g9U1u1QJo/DZSlsOGBep3RymaS1VnLB77dXyqpZ5MlVHUkbIqHyAJp//RG8wipw9Jw4ZDa92Q5kz2WJa7b5jK58ArCeaXl0rknJR40iv6j6A22SVUg8Bd2b9uIl95+LbBqkzcm2FeadsuDSHN4mLKLVc+nMIW7AVlJk56k3tQ+fl56+E+XOTHiJzggB4iZGAoI8b+xh1UtDmXdJp5yUJAo+xaFlK7FRHTga0jyzCgP86ajXwdhjKDXXTIpuM21rRta+lNx7drqzleDGezTyXRx8HL2DkGU58gwPREPclnMV4znIBByBN436TtGkh1ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLOk3w7WdcoVWiQm4iPTxPv7wYsgV2TkKKznHWaJo14=;
 b=kXmUh9s65CceLNQvuOID9uog2nDuEuTHN77rChvxu7xSZdZexAyPsYy3gahujBMPL1kzJrw0OJl9V/b/GwlXmfq32ILF3Fssj41mg43+RiHG5bxREQ4vP77eXzSE5V4G/oDTiVtb/MKP2kabHcHlAPAEqnlMbvZRDFB3DKZscTE=
Received: from BN6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:404:4c::34)
 by BYAPR03MB4104.namprd03.prod.outlook.com (2603:10b6:a03:7a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15; Thu, 26 Sep
 2019 11:18:38 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN6PR03CA0072.outlook.office365.com
 (2603:10b6:404:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:38 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Thu, 26 Sep 2019 11:18:38 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBIVOx004195
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:31 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:36 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 09/10] iio: gyro: adis16136: rework locks using ADIS library's state lock
Date:   Thu, 26 Sep 2019 14:18:11 +0300
Message-ID: <20190926111812.15957-10-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(5660300002)(11346002)(305945005)(476003)(110136005)(106002)(54906003)(7636002)(316002)(50466002)(70586007)(36756003)(70206006)(86362001)(48376002)(4326008)(478600001)(446003)(76176011)(246002)(14444005)(186003)(2906002)(7696005)(51416003)(8676002)(2870700001)(50226002)(8936002)(44832011)(26005)(486006)(47776003)(1076003)(336012)(2616005)(126002)(426003)(107886003)(356004)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4104;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eac09175-450f-430b-d098-08d74273474f
X-MS-TrafficTypeDiagnostic: BYAPR03MB4104:
X-Microsoft-Antispam-PRVS: <BYAPR03MB410477E7D64DEA7CD97CACDAF9860@BYAPR03MB4104.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBa+wUZwf2wEOIFG0STsxekRnsj1kHc5kI/0PyxX8HzOO5NAV/PTZzQEydPD5Qjc3CI4zbe1IZ+2/CHozC2vbmqKNKg4R5615PT4W1U9aG1vvGt2IfJvI9bX/qvQ7hwUuc6gTdxjXRAKNzCkYVPAUucQy1F9WXGTViWv/Rtyh7gtqi/bcNAvl7z5DQy36A/l7oN0bhOeVLDA91/l+9zaXw+8VzKhXbAljXHfAXKAPPwBdIQKpczrunZdo+zizYQ7UG99scof+A+vR740pMpAzT1d1A58lMJFP6xJhE/SlvZtr94uTw09G47JMWNkQ56ObL8so+6yR4ITAkQ2hgc2969H1/bM2IZIylwMnrPE8kInAz+S3dKOU5ZUZIaXnAXRUyvWS1z/mRcqkc33UzHfi65Cubo2NWMtAKH+sySqNvM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:38.0259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac09175-450f-430b-d098-08d74273474f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4104
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909260108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This replaces indio_dev's mlock with the state lock/mutex from the ADIS
library.

The __adis16136_get_freq() function has been prefixed to mark it as
unlocked. The adis16136_{set,get}_filter() functions now hold the state
lock for all the ops that they do.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/gyro/adis16136.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 5bec7ad53d8b..2d2c48f0b996 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -185,12 +185,12 @@ static int adis16136_set_freq(struct adis16136 *adis16136, unsigned int freq)
 	return adis_write_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, t);
 }
 
-static int adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
+static int __adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
 {
 	uint16_t t;
 	int ret;
 
-	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
+	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
 	if (ret < 0)
 		return ret;
 
@@ -224,10 +224,13 @@ static ssize_t adis16136_read_frequency(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
+	struct mutex *slock = &adis16136->adis.state_lock;
 	unsigned int freq;
 	int ret;
 
-	ret = adis16136_get_freq(adis16136, &freq);
+	mutex_lock(slock);
+	ret = __adis16136_get_freq(adis16136, &freq);
+	mutex_unlock(slock);
 	if (ret < 0)
 		return ret;
 
@@ -252,42 +255,50 @@ static const unsigned adis16136_3db_divisors[] = {
 static int adis16136_set_filter(struct iio_dev *indio_dev, int val)
 {
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
+	struct mutex *slock = &adis16136->adis.state_lock;
 	unsigned int freq;
 	int i, ret;
 
-	ret = adis16136_get_freq(adis16136, &freq);
+	mutex_lock(slock);
+	ret = __adis16136_get_freq(adis16136, &freq);
 	if (ret < 0)
-		return ret;
+		goto out_unlock;
 
 	for (i = ARRAY_SIZE(adis16136_3db_divisors) - 1; i >= 1; i--) {
 		if (freq / adis16136_3db_divisors[i] >= val)
 			break;
 	}
 
-	return adis_write_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, i);
+	ret = __adis_write_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, i);
+out_unlock:
+	mutex_unlock(slock);
+
+	return ret;
 }
 
 static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
 {
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
+	struct mutex *slock = &adis16136->adis.state_lock;
 	unsigned int freq;
 	uint16_t val16;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(slock);
 
-	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, &val16);
+	ret = __adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT,
+				 &val16);
 	if (ret < 0)
 		goto err_unlock;
 
-	ret = adis16136_get_freq(adis16136, &freq);
+	ret = __adis16136_get_freq(adis16136, &freq);
 	if (ret < 0)
 		goto err_unlock;
 
 	*val = freq / adis16136_3db_divisors[val16 & 0x07];
 
 err_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(slock);
 
 	return ret ? ret : IIO_VAL_INT;
 }
-- 
2.20.1

