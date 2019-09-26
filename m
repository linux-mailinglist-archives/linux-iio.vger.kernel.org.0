Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7E1BF103
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfIZLSd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:18:33 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25870 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbfIZLSc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:32 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBI3uq028889;
        Thu, 26 Sep 2019 07:18:28 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2056.outbound.protection.outlook.com [104.47.49.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7eeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXqMi1fe59ZCReXKmHpCVGYGacfFBH1NIxVE1mUDg+diHZPf+9p5tl7zqagAjZfsKRkW4YRS2rU05yZrFd3Z5GTnOhdB+Lq1weZB55aYgphOlXtPnKrwz0b75i4yvN3uRJ1cCBIu/68oy7bYFzhjrKtv1n7XM2CxNNupwtwAL8xvki92g9tikxeO87lUCAmrRyuKmlCs3k4pzMbAnDT/88LUiMWGaueYVaKk5q20UHsDuFW8JDwxlg6cklVV2OLEwFStmS1bSzXXzolPeuyh+Mfq5LUNekEeAl0UDpj7woSeBq95guRdkoKL79TPLBsZVt/zv8sE+hCWWDfG11ljIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDA/Z60/uUUJVC0geVTVz6W6/3dTq0OEefkJpNSYIbM=;
 b=bko2sihIuCRsX3ftYiDIL5DDUTDKW/QfrYckNX2UukBXDkVQxtjDq8fap5mqaaiySIFapyYj1/mUV9Dlz/aszUSqbNOP9Lo6xMKqUbsY4qtgSIQNtUovvOQuLThiPd3T5xSZhCEBk19Sw6NoMKbpwEOMP54HB56yEyL+qn3oFJkxDexviFXDdgBY4x3O5RfzjbADKVt9NQYLQ0tTxSrupeEySVcK1pgvrd8Wtxs/KmxA7tNs0uh/9HMjnbiApaY5v2sT8H5WwgAWZwwxeTxkkNuMzRremNvCCFnY7A3u2Zk/iYHuyQHrOj7bI1GxxdBv9J94v5SX9MrhV/2THb+fEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDA/Z60/uUUJVC0geVTVz6W6/3dTq0OEefkJpNSYIbM=;
 b=nf8hNyArL4ea77PqG5MLZ9A9NVs1mWXUOXh1UZQZ+2bBPzXEI2W0VlX7oOtTeXkBwyDC5oPnl43at3NlmEQavG6HLiqxC0EHmKrgprXIavTTdXfsT02FiRDf+xq4wv4uxTzcrcWvpAI3cqM2+Obd47bJXT2AQvP87zzPqPSp6JY=
Received: from BN6PR03CA0067.namprd03.prod.outlook.com (2603:10b6:404:4c::29)
 by BN6PR03MB2801.namprd03.prod.outlook.com (2603:10b6:404:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 11:18:26 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR03CA0067.outlook.office365.com
 (2603:10b6:404:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.16 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 11:18:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBIKwA004147
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:20 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:25 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 01/10] iio: imu: adis: rename txrx_lock -> state_lock
Date:   Thu, 26 Sep 2019 14:18:03 +0300
Message-ID: <20190926111812.15957-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(199004)(189003)(48376002)(70586007)(70206006)(8676002)(305945005)(6666004)(356004)(246002)(50466002)(478600001)(54906003)(2870700001)(7636002)(107886003)(110136005)(1076003)(8936002)(4326008)(106002)(316002)(14444005)(47776003)(86362001)(336012)(26005)(36756003)(486006)(186003)(44832011)(11346002)(50226002)(126002)(476003)(5660300002)(2616005)(446003)(76176011)(51416003)(7696005)(2906002)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2801;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb448134-14dc-4c70-8188-08d742734042
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN6PR03MB2801;
X-MS-TrafficTypeDiagnostic: BN6PR03MB2801:
X-Microsoft-Antispam-PRVS: <BN6PR03MB2801D52275B18A302F138915F9860@BN6PR03MB2801.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: O+PIi0437dHjCNZOWm17E8q484zmo1NHJRuF1IbwdiEdBRaHzL7W4LWJ6RBtGt0d/vFulqjeRaNYHLG1OcMPHBZzvEZbrQxkNBrDX+uIb2LokJYcEZbrIegbbm5m7aiiwB48Vx9MQsS6wJZVw9M9QxDJRHJHB8YZg7xgEmhzKZ3g1qUPXQAHNzwPJgHSFlAK70gcpFq/ick3XCuxgRA2r45r5oiMiM9oQG2wFL1dcRePbGfNfAq/DUvncSUSKrtSaroDhXyfaYe+rtL37oQoySDGPyZpEemHYgaOU7qPsqsGqcQmU/jjMJ2SayT/NanyXO5LnB0Zf6Syep9F/ig92Rn0+9BwSnSwiUOAQSSXAfTFBRZ33KdIsmFdDf3kMRuQ4v9GDMj/237UBoykotP4+WA1S/vHTH7kGuTzEvN8Wqg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:26.2616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb448134-14dc-4c70-8188-08d742734042
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2801
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260108
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The lock can be extended a bit to protect other elements that are not
particular to just TX/RX. Another idea would have been to just add a new
`state_lock`, but that would mean 2 locks which would be redundant, and
probably cause more potential for dead-locks.

What will be done in the next patches, will be to add some unlocked
versions for read/write_reg functions.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c        | 10 +++++-----
 drivers/iio/imu/adis_buffer.c |  4 ++--
 include/linux/iio/imu/adis.h  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 1631c255deab..3c2d896e3a96 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -70,7 +70,7 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 		},
 	};
 
-	mutex_lock(&adis->txrx_lock);
+	mutex_lock(&adis->state_lock);
 
 	spi_message_init(&msg);
 
@@ -114,7 +114,7 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 	}
 
 out_unlock:
-	mutex_unlock(&adis->txrx_lock);
+	mutex_unlock(&adis->state_lock);
 
 	return ret;
 }
@@ -166,7 +166,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 		},
 	};
 
-	mutex_lock(&adis->txrx_lock);
+	mutex_lock(&adis->state_lock);
 	spi_message_init(&msg);
 
 	if (adis->current_page != page) {
@@ -211,7 +211,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 	}
 
 out_unlock:
-	mutex_unlock(&adis->txrx_lock);
+	mutex_unlock(&adis->state_lock);
 
 	return ret;
 }
@@ -437,7 +437,7 @@ EXPORT_SYMBOL_GPL(adis_single_conversion);
 int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct adis_data *data)
 {
-	mutex_init(&adis->txrx_lock);
+	mutex_init(&adis->state_lock);
 	adis->spi = spi;
 	adis->data = data;
 	iio_device_set_drvdata(indio_dev, adis);
diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 9ac8356d9a95..bf581a2c321d 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -123,7 +123,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 
 	if (adis->data->has_paging) {
-		mutex_lock(&adis->txrx_lock);
+		mutex_lock(&adis->state_lock);
 		if (adis->current_page != 0) {
 			adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
 			adis->tx[1] = 0;
@@ -138,7 +138,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 
 	if (adis->data->has_paging) {
 		adis->current_page = 0;
-		mutex_unlock(&adis->txrx_lock);
+		mutex_unlock(&adis->state_lock);
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 4c53815bb729..3ed5eceaac2d 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -61,7 +61,7 @@ struct adis {
 	const struct adis_data	*data;
 	struct adis_burst	*burst;
 
-	struct mutex		txrx_lock;
+	struct mutex		state_lock;
 	struct spi_message	msg;
 	struct spi_transfer	*xfer;
 	unsigned int		current_page;
-- 
2.20.1

