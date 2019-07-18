Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B616C94D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 08:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfGRG2T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 02:28:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31728 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727787AbfGRG2T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 02:28:19 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I6OdB1018640;
        Thu, 18 Jul 2019 02:28:16 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tsf0g66w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 02:28:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUVTyEKIWKzLoF2XD+frQtBWL1PAVbkdUoxtO/dc0L9cbyCPwmKqRv9U98wgGENMbXdFSFAnJV/zMJerjePo5JLOvlLxYkl3ogEsUsuPhw2nBKHNHU+wJaFfwcsAUmrjtxjp3hB08ZFvCJgLPVe6/qgo5oFv1ti0zXU6krlLFhhNpsKEJgbYLahTp1Hnj5BL4USpNwuB5Zkab1cEFuETQG8939iWjDFWEjatXdggL/lz8GTMs0LffHVP1WTPKEfrVZFP/h3g9l+D5hBjzGSgcsZA3OW7fNRNftPD45a15HLVrdMEcNbRYYftUvtW+v0dj6GNRq0jB/BlkvG3DN0LJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ya2JbVne4s2xD77WZbAoCKmVVWNHM4pFd/rCPxz4Hg=;
 b=PRYjx2ma0femZRnv44CiQH77F7QcOp/5tiXPSZMiBhguo5givyKoF+748EKezA7yMtfrMB5kgEBev/3jvvGHEnvxOGWIokOUxoJqUFLJzM3DgpdroMNyVOhwEBTX01KMjnYF5XxGvNZn4MU2PKgg8OypUc7MMpF33OxZFfUKDDUA/egQ78r57qe8tWJKQyyfyIah6EL07kqSgSTH1RWOpFIlOqkurOjD+3HbEJKCHTj7j16i3ASqJ6ZuIH9dBQy++o7l5nm48JvDE6EvO4YF48YmCwWitZ3PRjLqJKlLK3csCqt+27AHvzoTiUuJgqA9nKQQ5xGBfMTnL7xpljURpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ya2JbVne4s2xD77WZbAoCKmVVWNHM4pFd/rCPxz4Hg=;
 b=aJYz3Us+A+UjiHpy/j3MTD31ARaorgYC/gJXK8MMD9gPv483wwAI1GgiF1gYj5f0M4EfFM3usQTMKGylKSHYpJM6UOvCLc08CIBe5duijj8s7Xo57FM4NkSYUTaloT1PJCobDmeI/4OrN8frtQCCmz4bftYS77DzGJ+SX73ccG8=
Received: from BN6PR03CA0003.namprd03.prod.outlook.com (2603:10b6:404:23::13)
 by BN8PR03MB4708.namprd03.prod.outlook.com (2603:10b6:408:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Thu, 18 Jul
 2019 06:28:14 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN6PR03CA0003.outlook.office365.com
 (2603:10b6:404:23::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.11 via Frontend
 Transport; Thu, 18 Jul 2019 06:28:14 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Thu, 18 Jul 2019 06:28:13 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6I6SChh015300
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 23:28:12 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Jul 2019 02:28:12 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 5/5] iio: adc: ad7606: Add debug mode for ad7616
Date:   Thu, 18 Jul 2019 09:27:34 +0300
Message-ID: <20190718062734.17306-5-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718062734.17306-1-beniamin.bia@analog.com>
References: <20190718062734.17306-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(199004)(189003)(5660300002)(54906003)(246002)(446003)(5820100001)(26005)(305945005)(86362001)(2616005)(2870700001)(8676002)(1076003)(336012)(426003)(7636002)(11346002)(2351001)(70586007)(70206006)(4326008)(478600001)(14444005)(44832011)(36756003)(6666004)(356004)(47776003)(8936002)(7696005)(476003)(2906002)(126002)(50466002)(106002)(316002)(107886003)(186003)(486006)(23676004)(76176011)(50226002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB4708;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ec50de-eaf3-4a06-ba1b-08d70b491c91
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN8PR03MB4708;
X-MS-TrafficTypeDiagnostic: BN8PR03MB4708:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4708283FE7BA128C9B9EDA5BF0C80@BN8PR03MB4708.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 01026E1310
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: SLWnLhFbz36+1tKK18qJQgXNnKHiAIlfGMABAKOTBNWxMt0IX9v4EwQ5Uh4o3zqyOarvryoc5ZVBDyCFpCyvIuZHNVJbZxN0pVX8O7AO2C1pLHpoFBThs0FsfHsYlWOwysEFJ0xcEokgdPd9IhWh7jsKd+YkpycIbn48xzfdpQpnK5FgOAbxd+nHk76BirPw13DI+J+HhRro4HedyQSP2lSdlNJ15ZQZLl6omc44OUP4DeZl/c7U7MuGJ+2u99/daTKDHU1LnuF0tCPrjWHOx8ddl20vMpQZiX6hYCnyglZ9wMN3LIvClYj7O+ii6NYyPCIZIGRzYj8zbZj4Kg5MiKxeGkervpSrI70YGtWkVXYZ4j6b6BQTInha0muWeDnV/mQ1WUNcpBgDfn6oIoNPKbrLk8PjxJwxrXQxUlmSEcQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2019 06:28:13.3162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ec50de-eaf3-4a06-ba1b-08d70b491c91
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4708
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Support for register access was added for devices which have software
mode.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
Changes in v2:
-nothing changed

 drivers/iio/adc/ad7606.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index be2330c8b277..ed2d08437e5d 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -60,6 +60,29 @@ static int ad7606_reset(struct ad7606_state *st)
 	return -ENODEV;
 }
 
+static int ad7606_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	if (readval) {
+		ret = st->bops->reg_read(st, reg);
+		if (ret < 0)
+			goto err_unlock;
+		*readval = ret;
+		ret = 0;
+	} else {
+		ret = st->bops->reg_write(st, reg, writeval);
+	}
+err_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
 static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels;
@@ -501,6 +524,14 @@ static const struct iio_info ad7606_info_os_and_range = {
 	.validate_trigger = &ad7606_validate_trigger,
 };
 
+static const struct iio_info ad7606_info_os_range_and_debug = {
+	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
+	.debugfs_reg_access = &ad7606_reg_access,
+	.attrs = &ad7606_attribute_group_os_and_range,
+	.validate_trigger = &ad7606_validate_trigger,
+};
+
 static const struct iio_info ad7606_info_os = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
@@ -617,7 +648,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 
 		/* After reset, in software mode, ±10 V is set by default */
 		memset32(st->range, 2, ARRAY_SIZE(st->range));
-		indio_dev->info = &ad7606_info_os_and_range;
+		indio_dev->info = &ad7606_info_os_range_and_debug;
 
 		ret = st->bops->sw_mode_config(indio_dev);
 		if (ret < 0)
-- 
2.17.1

