Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04294BF10D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfIZLTC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:19:02 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:27048 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbfIZLSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:18:33 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QBIVNk029004;
        Thu, 26 Sep 2019 07:18:31 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2058.outbound.protection.outlook.com [104.47.32.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7eed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:18:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5EJZAJs1eqDGh/JgUX8H5/VE189kc4apNVEpEi1Wi11NuNofORqaFI7dCnhqS/Qu1FKt6tMslrEi7iGipEu7YuQVjmgvd7ph7rR9cot0BdsDWcGpgtkTbdrwZchN19nY1XRap3UFNwWvN2i3AnZbkmumKuI71PhLAtWfYEXq4KULoIM+BO/j0SqrVBkXlVym1EWqPuu1KoMde0ThVL1AionXjrlPDZkYKEOrMFAcr+oXKmZ+kytD+LIFqT6td06WBsVTSs51iAPOVoWqhDKtPKWSFgx1NPELJOBQfN1oG1yiEbUcEUZMv74PlkN5ZZPTJWlsqnNRpMmXhVQd6CE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iszD8jf9mRIgGriZqGy80dWCPf23Q8n6vEzqGK4a98=;
 b=lVCxFKgyfj5D5avl8qN7L88awNX2MKu8dONT12a1JUpv1cmVUQPW0UwQz3+EHJXJOmXXTfF03nVbTRkCe4zeqr5sV9pzR3dPa+gpzgZBbWhr+LD8pJmmOoXTr2gdhVyvWb41s41FvjxKwgxJYhunWhrRWCbWoG61sStJ8WfQ/2lFKy2Gl5ygsRnq+4R9i1/Qu2czF0YjlMCtOnb0XBDZkJlrlbwnE0ARf9Tl+92ctlCxnb2B6hAm7p50PDJCqhj22Sby8dbgxKGa/e5qhqSijoI8xIgEe+LSJ8vQE77Lvv5Aw/ydBKa6dF9WFRj4TFLvgKIUbHutla0ReHlJbM/NoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iszD8jf9mRIgGriZqGy80dWCPf23Q8n6vEzqGK4a98=;
 b=LAkLoWrM/bb9AtokFv5CeCP7208DNW6TVpk8cPNVJeFJczBlBl4se6nsR0FkgPrgAYxWKcpFypfjBhbnXU29jwVSqqWsj6Zdp/QiJI/VJZ3M0vJ+4llythvYKGgUWwP8Vl+/mxkSETxyLZIjZSegAKHrvmJAdixPqfzL6mH6to4=
Received: from CY4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:903:33::30)
 by DM6PR03MB3755.namprd03.prod.outlook.com (2603:10b6:5:50::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Thu, 26 Sep
 2019 11:18:29 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by CY4PR03CA0020.outlook.office365.com
 (2603:10b6:903:33::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 11:18:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 11:18:29 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8QBINSM004159
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 04:18:23 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 07:18:28 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 03/10] iio: imu: adis[16480]: group RW into a single lock in adis_enable_irq()
Date:   Thu, 26 Sep 2019 14:18:05 +0300
Message-ID: <20190926111812.15957-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926111812.15957-1-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(189003)(199004)(50226002)(6666004)(106002)(107886003)(26005)(7696005)(2906002)(486006)(478600001)(2616005)(47776003)(14444005)(186003)(86362001)(316002)(126002)(336012)(48376002)(476003)(50466002)(2870700001)(44832011)(426003)(51416003)(5660300002)(246002)(11346002)(1076003)(305945005)(54906003)(8676002)(76176011)(36756003)(446003)(70206006)(8936002)(70586007)(110136005)(7636002)(4326008)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3755;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45cab940-850a-4eb7-fb56-08d742734204
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR03MB3755;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3755:
X-Microsoft-Antispam-PRVS: <DM6PR03MB375571CEBD63367793CFD579F9860@DM6PR03MB3755.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: pavBEz371f9bEZ+mzT3HgUxhsDuErnOf2ez3KOBfmLZ3A8wkyxSaXfZ+Uh/g8lUtIfjtogbZfk3XKZzf0QgwR3iuK/e8gN+eZqXAMVUlFCO7WwuT/SOw0wDZdm8MPiLRiB0N6pNlAXCb+IFUEFTZ7Lb7EWueXLTVd7DK6TtlwZvUGZJqimLina3DCF3SaVuTF2DjoHtERWbkhZTi29GwXYoL6BR9xXoo7b+IHvF+xjNo//tibwHDOHAbV9IwQDkGbDgY3k4QkyBskBJl5FU+C0M6fI4e9R5bJpx6O6D7KC5DTy+aqccP97vRTZjTfVdVBzi7HTNzYCrUT+n6V6+lAQ9pATGM9ari2yoxvgqYjKlPTyf3NxdZlWra0yiKmHf31LfOR3gvYY5BYNIQ1P20sKgRB9EIOd8M0PkK9II/eQw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 11:18:29.2049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cab940-850a-4eb7-fb56-08d742734204
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3755
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=702 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260108
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
index 4f3be011c898..dc30f70d36f3 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -250,12 +250,16 @@ int adis_enable_irq(struct adis *adis, bool enable)
 	int ret = 0;
 	uint16_t msc;
 
-	if (adis->data->enable_irq)
-		return adis->data->enable_irq(adis, enable);
+	mutex_lock(&adis->state_lock);
+
+	if (adis->data->enable_irq) {
+		ret = adis->data->enable_irq(adis, enable);
+		goto out_unlock;
+	}
 
-	ret = adis_read_reg_16(adis, adis->data->msc_ctrl_reg, &msc);
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
index b99d73887c9f..dc13d8a33612 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -936,14 +936,14 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
 	uint16_t val;
 	int ret;
 
-	ret = adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
+	ret = __adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
 	if (ret < 0)
 		return ret;
 
 	val &= ~ADIS16480_DRDY_EN_MSK;
 	val |= ADIS16480_DRDY_EN(enable);
 
-	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
+	return __adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
 static int adis16480_initial_setup(struct iio_dev *indio_dev)
-- 
2.20.1

