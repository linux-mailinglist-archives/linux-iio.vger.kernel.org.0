Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB4F12A4
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfKFJrh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 04:47:37 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25388 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbfKFJrg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 04:47:36 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69h3dh002926;
        Wed, 6 Nov 2019 04:47:33 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75qp7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 04:47:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft4H2V9lOlGjlQ/QYcRug439wwiZXhwkUTKxWpOUvvDwzFFxR3uVCs1ls/eQp7lCjDQh/S05ZwxITWvqziVqgItxCrLhf0tnbf+TGp5/mKmh4Wd727LXAA8kY/AaETuyOXza9RlcX/8l2bbZ/qQ4qDggS3B+p7rEu1JzIs4Hw+4Z1LYUiOT215pCTTgwbdoLVo/TUF42/sCESacDvOZDAh6RO6I2FKwScnn3ViXyNkvhRIZtzhFDlDhQ9bqqqESRewTsl+kCD4t+BuMy3ZLO9POVzVG+wFVQZ0QkqEM+x7BXgzaHuV3BgkD9CqebF2+9ZwhaNmeCvB8/FA0nyF+01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iOwyXyizmEB62CU3JrgkKXqAO1nW5dMKnlkgeG/jhw=;
 b=Ikd2ISIpyqzttn9CoaeveONPOyUKPiXCRE5h54NhsxZzvN6dwJv3KDqOBa8nlRuYaM8KgXxLWS1LWP2OBz50+VSE4akgDXOVl2ndxduPRmBhP9/RjZQaF2mcNlLFn1u3JLn8JQi5adx+s4vDfgsK2HcPAqEsEjK4pWrORNiRsB3fCF73dQkF6jgVCRxF8VvhU5nzAIeicSwFonjA9EcTWPv+W8FjiZjJfwrAZdr5+iDGYFmMfWNJaYWZEf+UM5HRmdU5t7K5ZyadQYgSwITgSCGc+MTXNUdfoRvb6gPIvtCaOS+lxchGs02vTtCrRN0WeMKfAFGPx9IOE/I8mNP/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iOwyXyizmEB62CU3JrgkKXqAO1nW5dMKnlkgeG/jhw=;
 b=FlSZ9bMAieh28wHEkNuOm8brqHqegKWqX1xqB8A4WHMjwLm41K2c+hgN79eUUlFk+Yxh8EwmO55rLGXTlcYtU9NUpRlyWfz3s0VCK6R0pKO4PoIBU8UU0KCuxxekNG74Z84m14bV9yr2gch+Yb/D2GXnHVdkEJRNQah5ExuvXTU=
Received: from BN8PR03CA0003.namprd03.prod.outlook.com (2603:10b6:408:94::16)
 by DM5PR03MB2650.namprd03.prod.outlook.com (2603:10b6:3:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Wed, 6 Nov
 2019 09:47:30 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN8PR03CA0003.outlook.office365.com
 (2603:10b6:408:94::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 09:47:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Wed, 6 Nov 2019 09:47:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xA69lT9F013052
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 6 Nov 2019 01:47:29 -0800
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Nov 2019 04:47:29 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: dac: ad5446: Add support for new AD5600 DAC
Date:   Wed, 6 Nov 2019 11:47:21 +0200
Message-ID: <20191106094721.25575-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(47776003)(26005)(44832011)(486006)(356004)(36756003)(6666004)(106002)(7696005)(50466002)(110136005)(336012)(186003)(51416003)(2616005)(476003)(126002)(54906003)(70206006)(70586007)(48376002)(316002)(426003)(478600001)(966005)(6306002)(2906002)(107886003)(305945005)(4326008)(7636002)(246002)(8936002)(8676002)(50226002)(1076003)(86362001)(2870700001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2650;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd840b6-2c88-434c-8c9f-08d7629e572c
X-MS-TrafficTypeDiagnostic: DM5PR03MB2650:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR03MB26508C02DACF89968E3D2A46F9790@DM5PR03MB2650.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8B3JXw/PbItTJC3LsTCjojo8Dq6cMGqyohgDPINgLWMg90F7ofnkshkoPVPjXflFPPkjuJhBz0XRab9cSaY1uraMRs1neM7HdC1oZ4g2icplXHHc3xNzeQN/uSnTN37+qsNMYbWZxMmdCY6S41BqnIrmRrv+CUxXIo14wLm1BLXhq4f4ETvxib0zo5rfOiYDw06PirPCM03fYN687bp5QfuHnFBNmYNuoDuvol7GJl59NGV9kequmK11n10Ay9E2XcrAhTTwtG6Sh2UXXK9W/aE9+4zWevuYnoel6X5XbaPAEr4ypLobOaec0pbKlHpko5ZuH/fwgJPMVdU4zRDhvmjoch4MulJX50yMIpbOaixkUCmqNL7oxAqxFBwqsiICdamg4SJo+R2Owq1fS8ZX1zUiIEsiQ1bQLUUUqzdKOKTajnDal4qDhz18vslDnIJ0U0R5ptFQT3VTNyQT0ihfgKZwdHwv0ViLgty7VRnsiYM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 09:47:30.1975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd840b6-2c88-434c-8c9f-08d7629e572c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2650
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911060100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

The AD5600 is a single channel, 16-bit resolution, voltage output digital
to analog converter (DAC). The AD5600 uses a 3-wire SPI interface. It is
part of the AD5541 family of DACs.

The ad5446 IIO driver implements support for some of these DACs (in the
AD5441 family), so the change is a simple entry in this driver.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5600.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/Kconfig  | 4 ++--
 drivers/iio/dac/ad5446.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cc42219a64f7..979070196da9 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -60,8 +60,8 @@ config AD5446
 	help
 	  Say yes here to build support for Analog Devices AD5300, AD5301, AD5310,
 	  AD5311, AD5320, AD5321, AD5444, AD5446, AD5450, AD5451, AD5452, AD5453,
-	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5601, AD5602, AD5611, AD5612,
-	  AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs
+	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5600, AD5601, AD5602, AD5611,
+	  AD5612, AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs
 	  as well as Texas Instruments DAC081S101, DAC101S101, DAC121S101.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 7df8b4cc295d..61c670f7fc5f 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -327,6 +327,7 @@ enum ad5446_supported_spi_device_ids {
 	ID_AD5541A,
 	ID_AD5512A,
 	ID_AD5553,
+	ID_AD5600,
 	ID_AD5601,
 	ID_AD5611,
 	ID_AD5621,
@@ -381,6 +382,10 @@ static const struct ad5446_chip_info ad5446_spi_chip_info[] = {
 		.channel = AD5446_CHANNEL(14, 16, 0),
 		.write = ad5446_write,
 	},
+	[ID_AD5600] = {
+		.channel = AD5446_CHANNEL(16, 16, 0),
+		.write = ad5446_write,
+	},
 	[ID_AD5601] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
 		.write = ad5446_write,
@@ -448,6 +453,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
 	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
 	{"ad5553", ID_AD5553},
+	{"ad5600", ID_AD5600},
 	{"ad5601", ID_AD5601},
 	{"ad5611", ID_AD5611},
 	{"ad5621", ID_AD5621},
-- 
2.20.1

