Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE9C10732B
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKVNaG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:06 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:57802 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbfKVNaF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:05 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDN8Os011422;
        Fri, 22 Nov 2019 08:30:00 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wbg0jtqy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:30:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgoDqz/ykGFLRu2RMJmvc8X03TAX+WVpERhDFqzkJBsOEemWJDYb34OgjH1OZ7c0ay6+tfjtCOsBNnOpoknYPOIxoTevB1Ce+rAsuxgG7nIJVXoWzdvEI9dpq6kre6wu8JYo094S/vbIpgHxThxynAbZs/qr4zlhBwS/l3u6kRD2aBYAIs7NUQb9GzRgAJx4j7cmITblKJSj+PUJaObz6M6DvIum3d6hfTOuAZq25bIcCPMDzs/ghHF5D4GOVuCTlnqOTlnK0woi65Z5KHcwlUbz2C0jnnnzd8IN/r1HE5Z358xinA4/yR5NMVqWUjZnjnpRo+2BK6qEn88grm+UeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/QPqvuTd3HtlORKfK6M523QuiYQzniF5kSVn1qcg08=;
 b=UoXVVfQQhOwYfxt/hi9xHjDyaLOk+WtR1bOG3zmsTs/oOG1SKIJvlomRQAzJIrWTBhKTnS7ZiCdGwNW07f6j1ZCcpu+NbQXr4iVALW2MnTbvIEK6tnLRzSqfBIWAcxk6TrDH0H/A+Q6/amJxe62gLDFbwadSXHvPuIdsCmJzPoWuUbwgBXhmwFITxSFQ5jhF4WsH6fj8bL9oR9eJOw8l36Qh7wfoEZQyV+ybxt4oC3W7hS/ZyI2GOT0uXSP8Wqimk7+1ObGCOC8aH/bek6SQ+OYheDsLkVvvEyODmzusa7Io6MW3OACnYIl3d+FL+Hb9rj4fCSv+Nw9f0EGbH5Hh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/QPqvuTd3HtlORKfK6M523QuiYQzniF5kSVn1qcg08=;
 b=567VBQ5cpAVEDFoZYArpeUYtW9T8Gm+2hTcHkkPJgl4OaQ5UAlaBY8ulZ5MqBxrrCWRoSmZyVZCMCN5PqAKO1e5Qm+Xk7Ue7rObYwakl2qTo3Q1MXTBPrbuI3t2k/PV7r+X0IzlUMbgoh1cuJ4LfBYHFQNT+LwEMVpYkEJMXUTw=
Received: from DM3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:0:50::27) by
 BY5PR03MB5219.namprd03.prod.outlook.com (2603:10b6:a03:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18; Fri, 22 Nov
 2019 13:29:59 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM3PR03CA0017.outlook.office365.com
 (2603:10b6:0:50::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Fri, 22 Nov 2019 13:29:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:29:58 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDTkKq015766
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:47 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:29:55 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 03/11] iio: imu: adis[16480]: group RW into a single lock in adis_enable_irq()
Date:   Fri, 22 Nov 2019 15:24:13 +0200
Message-ID: <20191122132421.5500-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(305945005)(70206006)(478600001)(2616005)(8936002)(2870700001)(2906002)(47776003)(50226002)(70586007)(246002)(86362001)(8676002)(26005)(7636002)(5660300002)(186003)(1076003)(50466002)(48376002)(11346002)(446003)(76176011)(356004)(51416003)(7696005)(336012)(36756003)(54906003)(106002)(44832011)(316002)(4326008)(107886003)(14444005)(426003)(110136005)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5219;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ffc3214-28f9-48b2-a825-08d76f5011ea
X-MS-TrafficTypeDiagnostic: BY5PR03MB5219:
X-Microsoft-Antispam-PRVS: <BY5PR03MB5219430733B06A0A1A29899BF9490@BY5PR03MB5219.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nF/U/eNlFTTRmyUuTlItKTQ7/sCdCbjk2GtbVjKEFllaya22P10OylVxzG4qP6K7vXLVQLHj7l7kD7IoHf9qPnm4K+sOAmRyA52/cf3izM/hMwjEGupdo2f+Er/GenpbMuXOOfWLlQvW5F+VpDgpsIPMtMdbJ0D+t6p/vIpC8nveu2EKdA7QnMrnQMoP2g5BQJhDWBgZMQDAczCPwZWgfAmEPzeRHhefuvmF3k7laGYv49CeNDbiY7EFwhHsBXzojuQ2zalveD2rYvBfSA2MsB6ldZVD7ZR5ygUZ58hLxGtDeZ/Y9AWs0HGvKWRoqX8gZuoWuMMGZctKbQlaPoXYz94k7hBAU0s8PcdcsariqsYnLeCcccjD6iCZt7UT+cOx1fCL1wK32U0EYkuWVJL1FINEC5exisO/W7SqIxGaFLSXChEY4n3EtwxsjhywsODJ
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:29:58.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffc3214-28f9-48b2-a825-08d76f5011ea
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5219
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=672 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The adis_enable_irq() does a read & a write. This change keeps a lock for
the duration of both operations vs for each op.

The change is also needed in adis16480, since that has it's own
implementation for adis_enable_irq().

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c      | 17 +++++++++++------
 drivers/iio/imu/adis16480.c |  4 ++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 2f518e6c727d..5cf7a15be6ee 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -250,12 +250,16 @@ int adis_enable_irq(struct adis *adis, bool enable)
 	int ret = 0;
 	uint16_t msc;
 
-	if (adis->data->enable_irq)
-		return adis->data->enable_irq(adis, enable);
+	mutex_lock(&adis->state_lock);
 
-	ret = adis_read_reg_16(adis, adis->data->msc_ctrl_reg, &msc);
+	if (adis->data->enable_irq) {
+		ret = adis->data->enable_irq(adis, enable);
+		goto out_unlock;
+	}
+
+	ret = __adis_read_reg_16(adis, adis->data->msc_ctrl_reg, &msc);
 	if (ret)
-		goto error_ret;
+		goto out_unlock;
 
 	msc |= ADIS_MSC_CTRL_DATA_RDY_POL_HIGH;
 	msc &= ~ADIS_MSC_CTRL_DATA_RDY_DIO2;
@@ -264,9 +268,10 @@ int adis_enable_irq(struct adis *adis, bool enable)
 	else
 		msc &= ~ADIS_MSC_CTRL_DATA_RDY_EN;
 
-	ret = adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
+	ret = __adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
 
-error_ret:
+out_unlock:
+	mutex_unlock(&adis->state_lock);
 	return ret;
 }
 EXPORT_SYMBOL(adis_enable_irq);
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 748f8bbf184d..e943039c3f98 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -947,14 +947,14 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
 	uint16_t val;
 	int ret;
 
-	ret = adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
+	ret = __adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
 	if (ret)
 		return ret;
 
 	val &= ~ADIS16480_DRDY_EN_MSK;
 	val |= ADIS16480_DRDY_EN(enable);
 
-	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
+	return __adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
 static int adis16480_initial_setup(struct iio_dev *indio_dev)
-- 
2.20.1

