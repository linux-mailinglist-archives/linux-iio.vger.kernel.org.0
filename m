Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12266142799
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgATJrk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:47:40 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:33682 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgATJrk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:47:40 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9TH3t026090;
        Mon, 20 Jan 2020 01:36:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=/5hRh3bqV5FuP/EiZShBt80tAOVBpvt6lGTGyj/Is1U=;
 b=bFnIGnGTMt+N9MYOTf6EC9epBrVeTf8AxRhU7G7tkJZtRBwrc7UHMCEhXGh+vv9Jafm1
 YWgR3vQe9arhrXXDdM0+DfSZgMdpHnd0pZL9LTKQZ+98SMkZCjDhc0fUhAU6oIiQEXb4
 5A2krvXKufSWCxWlMiMzEzX7ICN0GPuiNsEGgXGnHneZ8DLfbzJxZVUekSn2K1IBG+mp
 B0AEAjMNFXfHQdDADXIo620pqhe6FnDqRguqxp6b5jG9PahJs938RzYliIFnX8ZpgotP
 ciuxct9SIvRM+Y8TkjNDUd+zbyslZG41kQk8Hy59DTH8EDHHrgOgChloMmtzZezmkJlj hA== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0b-00328301.pphosted.com with ESMTP id 2xkxuu0mxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:36:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzExk3b/rF6X0ELt9tGDFjTSUxqBYOm7bxMnrIhWN41jEvqpyLC55um/gMGuupqkH6yMmDJYEvj5tBT/6N6JZZCsp2PQPaoyqAOLwFEGXlC10KFR0fa/JhGwOsNYg0Pmd3O9sBwKLtBpazVXksQFb3U2JLXm4ElASBLcONOgkGFaYtFQBVcSbqmBatBqMgyL0ahSrrHsf+9hIFLvzeC+DLKs4jE6FpfR0NLTZ672MtGOjTA7ipHroI0OqsLdiPeXvQsUG3GqmY6bCbq3CdBsE2q+alJSoJfLJMDTWSy0tSf5JxAwgYPw5v88ufMDqekm0LNztVwmEa/BsdjQ98vT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5hRh3bqV5FuP/EiZShBt80tAOVBpvt6lGTGyj/Is1U=;
 b=aLzDbo1yveqRb559MAimjm+ekpxT1jGWyRyCaxCFkzvPZ4XLwngPIyO05g35NB/6PGio4zFbczQMPPI0rTfmM+EkSv0A3oKkD6sG/2yBiBCJbXqARTxtBURQa6JOL+LXAKwRZrFHiCWZ3+ZL5FeRWE0u3YKmvj2XsBTsIc+22hpG8lqXyvdBBWr9St2g7mU88x86hVSSTcQqylp+Qs680lFa/OTDpQ+zyUl3AzlmlglMP4pSvpkHvnqq5p1zxrw9aklxBj+6bQnmv/UAQA4c3uX8Ve21ywiIOTQw7YQhoVQvCCrfPGMyFndmcF+1WwBE8WlOb+oVLXP5iCuLw1ffJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5hRh3bqV5FuP/EiZShBt80tAOVBpvt6lGTGyj/Is1U=;
 b=kOZzVrqXFEncTQ6J1X7sEH/HHZSikraBHXcRX3EknTfnBRB242De4IJmEEJ8Gl1z3JoyBK1/TiXQj79x3zMC1It+UvrmOXLdCbIgCO6xKalD6mQCEqoJfRd3C29e6F+R9VvpF0yzAvhZlmoHQZ7OjNWwsdFp2LHCQv7npdqYNjc=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3183.namprd12.prod.outlook.com (20.179.82.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 09:36:49 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:36:49 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 2/9] iio: imu: inv_mpu6050: cleanup spi support
Date:   Mon, 20 Jan 2020 10:36:13 +0100
Message-Id: <20200120093620.9681-3-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120093620.9681-1-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:36:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de6ac665-5dbe-4601-9f0b-08d79d8c4628
X-MS-TrafficTypeDiagnostic: MN2PR12MB3183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31833238336F540021EA34A4C4320@MN2PR12MB3183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(7696005)(52116002)(6666004)(8936002)(478600001)(186003)(16526019)(8676002)(86362001)(2906002)(26005)(316002)(81156014)(81166006)(54906003)(956004)(107886003)(2616005)(6486002)(1076003)(66946007)(36756003)(5660300002)(66556008)(4326008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3183;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3P8OjdeHi7RJlw59ZcV6xhD5zACxx3FeytrY1J6bsAbzUWxIImF9JjB+nvUE3WQE7eoOsUf9qJUF0rm0iESdtHi7YugOvHuaobr0CCYp3sbwTtGq5detposdwlzwvx6PrnEpgd9pytz8ICmpBhFvZjJQ4oqbgXy5cC3zRa2gDQaPaSdlnApnFNgCBIeqTC9Y9QIXau65D1M/Vz3AP62dZmmjmqjAbPqW/sKEMtSFkgB1hAKPw/+3UW3XAeBwWtVe4P118+o0L8oJiuqp5UO599b0YFchNh30TJv8SHQ6osR7L/+Wjgoq3q/8k37HE1Qwj+NlIzSg3sP+F/4W0WOtoU/5P/UdtBb/xHVeuJ9+ke3Fr99SE/ymc4s2wd/M+YDYCzOMSJZRblMm7dcyIbkZn08agmcWHHBW5V7x57aosu/gsze2UXyTqHSlY5nDOnk
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6ac665-5dbe-4601-9f0b-08d79d8c4628
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:36:49.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZv/qM+9jtO9aFaGVTAmeZ6KWF4/m5CHfo/HQqdo6JWPDdKLWiZW7rrEaSzVzc9eLXxGcy/BgpdRibj1o8EgCLdqmhZg076IOppUjeWoATo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3183
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing mpu6515 support and add of match table.
Reorganize Kconfig to display chips grouped by generations.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig       |  8 +++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 35 +++++++++++++++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 017bc0fcc365..003134734646 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -15,8 +15,8 @@ config INV_MPU6050_I2C
 	select INV_MPU6050_IIO
 	select REGMAP_I2C
 	help
-	  This driver supports the Invensense MPU6050/6500/6515,
-	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
+	  This driver supports the Invensense MPU6050/9150,
+	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
 	  over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
@@ -27,8 +27,8 @@ config INV_MPU6050_SPI
 	select INV_MPU6050_IIO
 	select REGMAP_SPI
 	help
-	  This driver supports the Invensense MPU6000/6500/6515,
-	  MPU9250/9255 and ICM20608/20602 motion tracking devices
+	  This driver supports the Invensense MPU6000,
+	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
 	  over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index ec102d5a5c77..f7276f9d83fc 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -74,6 +74,7 @@ static int inv_mpu_probe(struct spi_device *spi)
 static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu6000", INV_MPU6000},
 	{"mpu6500", INV_MPU6500},
+	{"mpu6515", INV_MPU6515},
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
@@ -83,6 +84,39 @@ static const struct spi_device_id inv_mpu_id[] = {
 
 MODULE_DEVICE_TABLE(spi, inv_mpu_id);
 
+static const struct of_device_id inv_of_match[] = {
+	{
+		.compatible = "invensense,mpu6000",
+		.data = (void *)INV_MPU6000
+	},
+	{
+		.compatible = "invensense,mpu6500",
+		.data = (void *)INV_MPU6500
+	},
+	{
+		.compatible = "invensense,mpu6515",
+		.data = (void *)INV_MPU6515
+	},
+	{
+		.compatible = "invensense,mpu9250",
+		.data = (void *)INV_MPU9250
+	},
+	{
+		.compatible = "invensense,mpu9255",
+		.data = (void *)INV_MPU9255
+	},
+	{
+		.compatible = "invensense,icm20608",
+		.data = (void *)INV_ICM20608
+	},
+	{
+		.compatible = "invensense,icm20602",
+		.data = (void *)INV_ICM20602
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_of_match);
+
 static const struct acpi_device_id inv_acpi_match[] = {
 	{"INVN6000", INV_MPU6000},
 	{ },
@@ -93,6 +127,7 @@ static struct spi_driver inv_mpu_driver = {
 	.probe		=	inv_mpu_probe,
 	.id_table	=	inv_mpu_id,
 	.driver = {
+		.of_match_table = inv_of_match,
 		.acpi_match_table = ACPI_PTR(inv_acpi_match),
 		.name	=	"inv-mpu6000-spi",
 		.pm     =       &inv_mpu_pmops,
-- 
2.17.1

