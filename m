Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF411E79B
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 17:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfLMQF0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 11:05:26 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:44686 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728049AbfLMQF0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 11:05:26 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDG0Y6r011464;
        Fri, 13 Dec 2019 11:03:24 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wragqkf58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 11:03:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjC4O29mVmcK0jZHH/Ngmxc4VS8FrQnqvycMLl8Pmdy/cVwbjgX83OXlF4pJh4YDb3Efse7FFbMrPa+ExC0DrqQlGYbSUFPQDgVDHAmqrSkVKLz2nPhl1ezVvr2ZDjGWFBrPXqJuGllKoGXZfhrG/T824ZbIFEq1igViUHUx/7fqTZtI/NnszkicCYV2TkbbQMJuPDEDCASt7agTuZmcoNzEu16Q3PS3ITc91StVIcS4FddVQxumV1vScz5UQKwG2/8bDv2A87Z8UIV6nTl+rJMKnZVcXJgdW1+PmGyoxn/JyvOUbIqLk1T08bTEdfhXs8H74x5dcO3NChhQVjW4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVTl6v1q9XAoBuhKvROy1aYbnIjmWIHBuUV+lxW+Kys=;
 b=jqr3WLknoDlZYHdoZzq4xdxLCp+47W8zoSfcgPBldVyybM/mIai8xtEN4jL+jZlIyBSgtvlbdz6CAJgt753M+glcSAmAlRYSSIJsIJ/351NMbTsbgmK2wqS3ipZcWm5QfZmldsNSUu+x4HkSRZRp0Kz+DU55snPKM8n+jtDFThlVPj7Vl04c9+7ZKl4gS6+mRx2PO4pSmDpmjLM9lUH51IaIqboJDoWfPOYK9KUWu/OFi+oIxxf9WQZBib/yJYVM+RLLLmSPgpejdskxSvitf6mDDYsGWfI4Mee5nTVrViBvLJ5khgmcf9lWIgpZcp7w+Bj0kigirgXtFBdHRxaFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVTl6v1q9XAoBuhKvROy1aYbnIjmWIHBuUV+lxW+Kys=;
 b=2kHg9Ixa0gcRy/OeRE30idW8q/xgMNpDVUuMf4+V3Ia9KTv692BlGC9CXba0ihPcQMPN3wbVM+dbFoOJCmBedEpz2JwUNfOc7bL3KnCJO0WrzND445E3OXAwf71VP7kMm1Zr3vcEZ7JkscmZde+FVScv5y15F9pHqlVD2FXPGfI=
Received: from BN8PR03CA0015.namprd03.prod.outlook.com (2603:10b6:408:94::28)
 by BYAPR03MB4664.namprd03.prod.outlook.com (2603:10b6:a03:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Fri, 13 Dec
 2019 16:03:22 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN8PR03CA0015.outlook.office365.com
 (2603:10b6:408:94::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Fri, 13 Dec 2019 16:03:22 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Fri, 13 Dec 2019 16:03:22 +0000
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBDG3Ll4005464
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 13 Dec 2019 08:03:21 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 13 Dec
 2019 11:03:20 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 13 Dec 2019 11:03:20 -0500
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBDG3JMK015048;
        Fri, 13 Dec 2019 11:03:19 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 1/5] iio: gyro: adi16136: construct adis data on probe vs static on driver
Date:   Fri, 13 Dec 2019 18:03:08 +0200
Message-ID: <20191213160312.1834-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(478600001)(54906003)(26005)(8676002)(186003)(246002)(2616005)(316002)(7696005)(4326008)(110136005)(6666004)(356004)(107886003)(2906002)(426003)(36756003)(86362001)(336012)(7636002)(70206006)(70586007)(44832011)(5660300002)(8936002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4664;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b12106-e520-42d1-9137-08d77fe5fa7c
X-MS-TrafficTypeDiagnostic: BYAPR03MB4664:
X-Microsoft-Antispam-PRVS: <BYAPR03MB466492BBA532AB713EA1F619F9540@BYAPR03MB4664.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-Forefront-PRVS: 0250B840C1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUrYiK0ig3ALMKlZGzNJ52xqjfbIhFSeomXUKFasE5TOR552Qsn0qPBhGG/BLiE7Xs6Zf3qDbCGgnqyS8UCjfwPU3Yxf5P7ew/vZsxCfPlJKun20BwrNvot9OIa0/Wd316T8fc4psCSH+rkdaalxAXSCrm+vR15qrfgaHqZRH70CiHvbJMxXuYSdc2NIHNfPwcJwp2WWGUeyCCQRnS/MweRSpfghDLFzeKEAQ+3lbPUtq+ETu0vtn/mESs1U1ZGjsTHQpkm23ryHK+5FXzfszUMOdJZfdBOlgZr8VTSsIj+5TL+7aUm/sC+u0he2hnnSK27BFiQeO63KfUyjs3P9M8E4ybCdC3skEXnG6a11xa4XKXXkRekaKTVFhkL4xsG13IO62I2uApqby8gDqKhBfo0oOAYmgkJIFq6LU1LrD8zD6iMrPFtkTXs/eMoLNidS
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:03:22.1319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b12106-e520-42d1-9137-08d77fe5fa7c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4664
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_05:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change is done in preparation of adding an `struct adis_timeout` type.
Some ADIS drivers support multiple drivers, with various combinations of
timeouts. Creating static tables for each driver is possible, but that also
creates quite a lot of duplication.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/gyro/adis16136.c | 49 ++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index f10c4f173898..129de2bd5845 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -465,24 +465,6 @@ static const char * const adis16136_status_error_msgs[] = {
 	[ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL] = "Flash checksum error",
 };
 
-static const struct adis_data adis16136_data = {
-	.diag_stat_reg = ADIS16136_REG_DIAG_STAT,
-	.glob_cmd_reg = ADIS16136_REG_GLOB_CMD,
-	.msc_ctrl_reg = ADIS16136_REG_MSC_CTRL,
-
-	.self_test_mask = ADIS16136_MSC_CTRL_SELF_TEST,
-	.startup_delay = 80,
-
-	.read_delay = 10,
-	.write_delay = 10,
-
-	.status_error_msgs = adis16136_status_error_msgs,
-	.status_error_mask = BIT(ADIS16136_DIAG_STAT_FLASH_UPDATE_FAIL) |
-		BIT(ADIS16136_DIAG_STAT_SPI_FAIL) |
-		BIT(ADIS16136_DIAG_STAT_SELF_TEST_FAIL) |
-		BIT(ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL),
-};
-
 enum adis16136_id {
 	ID_ADIS16133,
 	ID_ADIS16135,
@@ -509,11 +491,36 @@ static const struct adis16136_chip_info adis16136_chip_info[] = {
 	},
 };
 
+static struct adis_data *adis16136_adis_data_alloc(struct adis16136 *st,
+						   struct device *dev)
+{
+	struct adis_data *data;
+
+	data = devm_kzalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->msc_ctrl_reg = ADIS16136_REG_MSC_CTRL;
+	data->glob_cmd_reg = ADIS16136_REG_GLOB_CMD;
+	data->diag_stat_reg = ADIS16136_REG_DIAG_STAT;
+	data->self_test_mask = ADIS16136_MSC_CTRL_SELF_TEST;
+	data->read_delay = 10;
+	data->write_delay = 10;
+	data->status_error_msgs = adis16136_status_error_msgs;
+	data->status_error_mask = BIT(ADIS16136_DIAG_STAT_FLASH_UPDATE_FAIL) |
+				BIT(ADIS16136_DIAG_STAT_SPI_FAIL) |
+				BIT(ADIS16136_DIAG_STAT_SELF_TEST_FAIL) |
+				BIT(ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL);
+
+	return data;
+}
+
 static int adis16136_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct adis16136 *adis16136;
 	struct iio_dev *indio_dev;
+	const struct adis_data *adis16136_data;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adis16136));
@@ -532,7 +539,11 @@ static int adis16136_probe(struct spi_device *spi)
 	indio_dev->info = &adis16136_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis_init(&adis16136->adis, indio_dev, spi, &adis16136_data);
+	adis16136_data = adis16136_adis_data_alloc(adis16136, &spi->dev);
+	if (IS_ERR(adis16136_data))
+		return PTR_ERR(adis16136_data);
+
+	ret = adis_init(&adis16136->adis, indio_dev, spi, adis16136_data);
 	if (ret)
 		return ret;
 
-- 
2.20.1

