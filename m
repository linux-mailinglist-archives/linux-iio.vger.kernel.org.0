Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA792107337
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKVNaA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:00 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:52390 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727173AbfKVN37 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:29:59 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDN46u011404;
        Fri, 22 Nov 2019 08:29:54 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wbg0jtqxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:29:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTVXQ06FbcOl/lfuyRwzLouymIo3Z906dNUgZCYqyMd8EF4rmRK/AwQjoFlpqAGVXmnKvGSTzTgpMJ3clkFYIGx7uMo5qn3JYTULc8rCnZ8FQQTaox2V2w219eSnl7nnCFVvBjPn7w10oedxq8D/PSZGCDvly8RyOFbi/A9u8TrpMDaj821SskGLkYU5fzY8+k6grYfqBvCxpu2Z3g0b9WN2RA+dpNu1F12LUXBkeN6NGQB/ySGA4BFspbHoVBVyeLSBNyel/kPQeSJYWHlZ3aSWUiKqXmOMVzYTEjYca85m7zAqAej8pgIvyBqVuslNKry5PJkqcpxUEsCGnZ1+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCZPoMm18WIkEKVL5/ZcqMMR4sUhamwlg16Joyqjezs=;
 b=G0MnahXr8SYCE54VtalAbAHXBKuewophJ4jaIZb6meMbEEb4ERI26ZF1sWek0t51Glfy77uGRJxuJqv3x2Y5YRONnJdg6WsuQIQbAHumD+iBR7Xdl7WiRjMoRzzyBjS6+uc7uxARz1/cfdTuWdNMayDJSA7r7gqX5PRAxTX9QAH0js6pRki0JEYC0Ygpg0bY7CR5K+N0Q1nSwBPCYv2nSEwkT8rQk3W1mkAJj51v4ONNpDINY+NdY32Q70D+RqX48KQ3z/0lbXfptDm/NpioTL+ajnuMoeqq9GClSlGo9VKRTEhSSro2y9Ko91aI9Wf7A0Sz/IN66gGSpqcnDyXbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCZPoMm18WIkEKVL5/ZcqMMR4sUhamwlg16Joyqjezs=;
 b=6M2eK6S1WLoYg69FsbRMDpzJWbyCzcEMJEhD2M8aCq/H6fAPcM167aeaYCyzeOxxFd2KK/vHV1mDVTN/rMeD0DZ7cfHtaHVUQNOP8b4T6gGbe4Olf7j1Y6J3N2uOHnSTZ/CFeuBco4ZSHHFRkK6kch2owDTmQhZERd+VXpgf3/8=
Received: from BN3PR03CA0110.namprd03.prod.outlook.com (2603:10b6:400:4::28)
 by SN6PR03MB4253.namprd03.prod.outlook.com (2603:10b6:805:bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.29; Fri, 22 Nov
 2019 13:29:53 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN3PR03CA0110.outlook.office365.com
 (2603:10b6:400:4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Fri, 22 Nov 2019 13:29:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:29:52 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDThkq015750
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:43 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:29:52 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 01/11] iio: imu: adis: rename txrx_lock -> state_lock
Date:   Fri, 22 Nov 2019 15:24:11 +0200
Message-ID: <20191122132421.5500-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(44832011)(36756003)(70586007)(5660300002)(50466002)(2906002)(2870700001)(48376002)(107886003)(4326008)(70206006)(316002)(478600001)(106002)(26005)(186003)(110136005)(356004)(246002)(6666004)(7696005)(76176011)(51416003)(8936002)(47776003)(446003)(50226002)(7636002)(14444005)(8676002)(54906003)(426003)(2616005)(305945005)(1076003)(86362001)(336012)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4253;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 020d83df-a138-41fc-216f-08d76f500e83
X-MS-TrafficTypeDiagnostic: SN6PR03MB4253:
X-Microsoft-Antispam-PRVS: <SN6PR03MB4253133BE64E5CDD17F5F8C5F9490@SN6PR03MB4253.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SE2wT3d88ZtoT44fctTwvndlsZe7Xzzc6psnoQjXEy4shYHL8wQkaZB8lAh0f1as+VSGaAwP+s9YnZ0hcWt8Nv5kcm2sSjRb36ncqyRNTBxAmCGwjyxCyxk8ii0ZKj3iguaOnFRtdn52CgEDmLB1nNblgtJAoq4K4AlyN++JyjbM+IPMOtCVaSziKKA3hBAm5kCFImwnI5X0FrRE0Pm+HKu05UQAcs29guFE80RmC6QTv85LkfHK8N5POqcbEe3RzfJ2FOLifTHWUw7w1tjP1YMToINixyvmEhExqFdYxHxt3m8mqsrjgjzEBYRznePfSCzq5YjQaDpa6a2Wpky1U4dbdeq5LlUSCXbljMgTCn0iIIEebq06D+Z3zhJ1w84dgUqcSXTEq7DTTxPaVU5ezye6+88Nodv8XvkRCAQtj8uhKz7Xt1rt1pOU7+E9mz3
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:29:52.7335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020d83df-a138-41fc-216f-08d76f500e83
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4253
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220119
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
index 85de565a4e80..db562fec79b2 100644
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
@@ -438,7 +438,7 @@ EXPORT_SYMBOL_GPL(adis_single_conversion);
 int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct adis_data *data)
 {
-	mutex_init(&adis->txrx_lock);
+	mutex_init(&adis->state_lock);
 	adis->spi = spi;
 	adis->data = data;
 	iio_device_set_drvdata(indio_dev, adis);
diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 4998a89d083d..3f4dd5c00b03 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -129,7 +129,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 
 	if (adis->data->has_paging) {
-		mutex_lock(&adis->txrx_lock);
+		mutex_lock(&adis->state_lock);
 		if (adis->current_page != 0) {
 			adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
 			adis->tx[1] = 0;
@@ -144,7 +144,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
 
 	if (adis->data->has_paging) {
 		adis->current_page = 0;
-		mutex_unlock(&adis->txrx_lock);
+		mutex_unlock(&adis->state_lock);
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 92aae14593bf..100b5d1cebf1 100644
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

