Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0778711E7A4
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 17:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfLMQFb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 11:05:31 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30728 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbfLMQFa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 11:05:30 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDFvLJC021521;
        Fri, 13 Dec 2019 11:03:28 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wraq3tssb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 11:03:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfRqJ9nzHwqVLr1IQannFP7k7v7ZInY9qn+XBWsWsfMreUqg6lrP3d2djchduBNH+ke0LiHXbqOqAzG5mfpDNdw+1eTJu8Uj2Tynr0oEgMlXT26sfk3JRH8NRK1C/qf9Xu8LDzIARKM9PgDE1BC2V+AIMFzyKuieAnP4zsq3eSjF3aVTwnHIQL8OuOgqWhpx/etKVgGdiTslWw7q73hXc0eex39y+rf26NzzZow8FcEPv/Gh5yFWsRfkuAPum0iIgrmISEo6OmzfxaeSsKhi9W8uRxJ78eokP7XXcXX9hTKN+ufhf4RH+h1IwcwmZh6cGPJJ+rSOXFxx+O49NiaSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXbR78VS5I+HjQWiGmtjtuhs2Ryu8STqUJFpmahefwc=;
 b=D58JMZXP5chaX1mahEjcS2OqBx70xT7r4DUPTKxo2u4KO+lACyWwvNOBiN/8iZw9vXDloTZCvIzO0799pRXUYIyeITEETF1SOROuGx/L0TEoZjUeAQ6LGXm3gsB3wMz3QNGYhOvIDZ6ZT8woAmH9zQnUpYOEnU8C24p3LaTpvqQtVk7czNZRvh28zfJJLemPoKj4TQ2jZQi0jp1lnaL6zeuy7lvF8b87iuQUsVx1jQOjvhJcdCRH339P/gLCnL8r1xoA2rTjHSj2mo4/moYqQF1yqXciCTnqia7fgmlHacuBHZqqRpGRLovq/Dujdk3sUeMMS5gPBadchY0/9h22lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXbR78VS5I+HjQWiGmtjtuhs2Ryu8STqUJFpmahefwc=;
 b=O4YYlVo4o1kyzQFuo4w4CfnyWFSOx/QTtLUZJP/q2RhkBxluPnxeBzr4b1IP8hYXrdjvMiUQFrw2aBr93GhThrapGk60YtmYv4DADK9clAFS5VS8Od21bDG5kuccmfxBmidZzwUbdF6JHeNRrVLUOi9n9tohQ3Hg1zBbJKo69/o=
Received: from BN6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:404:10::15)
 by SN6PR03MB3614.namprd03.prod.outlook.com (2603:10b6:805:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.17; Fri, 13 Dec
 2019 16:03:25 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN6PR03CA0101.outlook.office365.com
 (2603:10b6:404:10::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Fri, 13 Dec 2019 16:03:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Fri, 13 Dec 2019 16:03:25 +0000
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBDG3OfL005501
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 13 Dec 2019 08:03:24 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 13 Dec
 2019 11:03:24 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 13 Dec 2019 08:03:24 -0800
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBDG3JMN015048;
        Fri, 13 Dec 2019 11:03:23 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/5] iio: adis: Introduce timeouts structure
Date:   Fri, 13 Dec 2019 18:03:11 +0200
Message-ID: <20191213160312.1834-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160312.1834-1-alexandru.ardelean@analog.com>
References: <20191213160312.1834-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(7636002)(107886003)(54906003)(316002)(70586007)(336012)(86362001)(70206006)(110136005)(2616005)(6666004)(246002)(356004)(186003)(1076003)(8676002)(426003)(26005)(36756003)(5660300002)(4326008)(8936002)(30864003)(2906002)(7696005)(478600001)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3614;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f907e13-319b-49d4-ec2d-08d77fe5fc7a
X-MS-TrafficTypeDiagnostic: SN6PR03MB3614:
X-Microsoft-Antispam-PRVS: <SN6PR03MB361468BEC4F64B848A9547C6F9540@SN6PR03MB3614.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0250B840C1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tcg1M+wKEb96QetSWQcoFXByv2jWctw7pt1nO3Zo9W35Bdjmt6nNO/5p3iTUL3Md8AYvHbvVF5FeEIfry8WOyOxxG60IZ+cjORqUyXg7c0P6uqvChLhI5UzSCsvfvLGgZT9l9IE3e9ELQjJNy4am5f7wz3wa+U2SuHuT9QL0RZP88OYRIcnS9+J1+vz4b0uuUAwmVwbq5CaZOpkWkocPd27P5/6shJH4hAa2bd20y4Vs+xZI6AfSlZq+7HkJ6JHI8fDIN73ILXEbSmqixePscBkRoxqe4JAWHoCOm1ofJLtFPO9/1ThW0zCzuT8WnU6p5K3bi823vKM6ZgRqVidGSbirF8fRX2KLbV29XPtWl9kL6C5vXXku3XQRZUE2Kq9PHy7vQ8yyTjNchXc1HEGFM0Zr75lbhFPQ2z7CObBKw3Q1asmFZ4E+yuxeJewPP+kj
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:03:25.5206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f907e13-319b-49d4-ec2d-08d77fe5fc7a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3614
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_05:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130129
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

The adis library only allows to define a `startup_delay` which for some
devices is enough. However, other devices define different timeouts with
significantly different timings which could lead to devices to not wait
enough time or to wait a lot more than necessary (which is not
efficient). This patch introduces a new timeout struct that must be
passed into `adis_init()`. There are mainly, for now, three timeouts
used. This is also an introductory patch with the goal of refactoring
`adis_initial_startup()`. New driver's (eg: adis16480, adis16460) are
replicating code for the device initial setup. With some changes (being
this the first one) we can pass this to `adis_initial_startup()`.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adis16201.c         |  7 +++++
 drivers/iio/accel/adis16209.c         |  7 +++++
 drivers/iio/gyro/adis16136.c          | 18 ++++++++++++
 drivers/iio/gyro/adis16260.c          |  7 +++++
 drivers/iio/imu/adis.c                | 18 +++++++++---
 drivers/iio/imu/adis16400.c           | 41 +++++++++++++++++++++++++++
 drivers/iio/imu/adis16460.c           |  7 +++++
 drivers/iio/imu/adis16480.c           | 36 +++++++++++++++++++++++
 drivers/staging/iio/accel/adis16203.c |  7 +++++
 drivers/staging/iio/accel/adis16240.c |  7 +++++
 include/linux/iio/imu/adis.h          | 13 +++++++++
 11 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index c4810c73b2a2..c92d22387b01 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -233,6 +233,12 @@ static const char * const adis16201_status_error_msgs[] = {
 	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
 };
 
+static const struct adis_timeout adis16201_timeouts = {
+	.reset_ms = ADIS16201_STARTUP_DELAY_MS,
+	.sw_reset_ms = ADIS16201_STARTUP_DELAY_MS,
+	.self_test_ms = ADIS16201_STARTUP_DELAY_MS,
+};
+
 static const struct adis_data adis16201_data = {
 	.read_delay = 20,
 	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
@@ -242,6 +248,7 @@ static const struct adis_data adis16201_data = {
 	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
 	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
+	.timeouts = &adis16201_timeouts,
 
 	.status_error_msgs = adis16201_status_error_msgs,
 	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index 98d77af8a2b0..f5a78fc11919 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -243,6 +243,12 @@ static const char * const adis16209_status_error_msgs[] = {
 	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
 };
 
+static const struct adis_timeout adis16209_timeouts = {
+	.reset_ms = ADIS16209_STARTUP_DELAY_MS,
+	.self_test_ms = ADIS16209_STARTUP_DELAY_MS,
+	.sw_reset_ms = ADIS16209_STARTUP_DELAY_MS,
+};
+
 static const struct adis_data adis16209_data = {
 	.read_delay = 30,
 	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
@@ -252,6 +258,7 @@ static const struct adis_data adis16209_data = {
 	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
 	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
+	.timeouts = &adis16209_timeouts,
 
 	.status_error_msgs = adis16209_status_error_msgs,
 	.status_error_mask = BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 129de2bd5845..f928a8b42869 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -59,6 +59,7 @@
 struct adis16136_chip_info {
 	unsigned int precision;
 	unsigned int fullscale;
+	const struct adis_timeout *timeouts;
 };
 
 struct adis16136 {
@@ -472,22 +473,38 @@ enum adis16136_id {
 	ID_ADIS16137,
 };
 
+static const struct adis_timeout adis16133_timeouts = {
+	.reset_ms = 75,
+	.sw_reset_ms = 75,
+	.self_test_ms = 50,
+};
+
+static const struct adis_timeout adis16136_timeouts = {
+	.reset_ms = 128,
+	.sw_reset_ms = 75,
+	.self_test_ms = 245,
+};
+
 static const struct adis16136_chip_info adis16136_chip_info[] = {
 	[ID_ADIS16133] = {
 		.precision = IIO_DEGREE_TO_RAD(1200),
 		.fullscale = 24000,
+		.timeouts = &adis16133_timeouts,
 	},
 	[ID_ADIS16135] = {
 		.precision = IIO_DEGREE_TO_RAD(300),
 		.fullscale = 24000,
+		.timeouts = &adis16133_timeouts,
 	},
 	[ID_ADIS16136] = {
 		.precision = IIO_DEGREE_TO_RAD(450),
 		.fullscale = 24623,
+		.timeouts = &adis16136_timeouts,
 	},
 	[ID_ADIS16137] = {
 		.precision = IIO_DEGREE_TO_RAD(1000),
 		.fullscale = 24609,
+		.timeouts = &adis16136_timeouts,
 	},
 };
 
@@ -511,6 +528,7 @@ static struct adis_data *adis16136_adis_data_alloc(struct adis16136 *st,
 				BIT(ADIS16136_DIAG_STAT_SPI_FAIL) |
 				BIT(ADIS16136_DIAG_STAT_SELF_TEST_FAIL) |
 				BIT(ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL);
+	data->timeouts = st->chip_info->timeouts;
 
 	return data;
 }
diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 726a0aa321a8..0e3a66a7726d 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -332,6 +332,12 @@ static const char * const adis1620_status_error_msgs[] = {
 	[ADIS16260_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 4.75",
 };
 
+static const struct adis_timeout adis16260_timeouts = {
+	.reset_ms = ADIS16260_STARTUP_DELAY,
+	.sw_reset_ms = ADIS16260_STARTUP_DELAY,
+	.self_test_ms = ADIS16260_STARTUP_DELAY,
+};
+
 static const struct adis_data adis16260_data = {
 	.write_delay = 30,
 	.read_delay = 30,
@@ -341,6 +347,7 @@ static const struct adis_data adis16260_data = {
 
 	.self_test_mask = ADIS16260_MSC_CTRL_MEM_TEST,
 	.startup_delay = ADIS16260_STARTUP_DELAY,
+	.timeouts = &adis16260_timeouts,
 
 	.status_error_msgs = adis1620_status_error_msgs,
 	.status_error_mask = BIT(ADIS16260_DIAG_STAT_FLASH_CHK_BIT) |
diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index c53f3ed3cb97..3e12ad4b71ba 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -317,19 +317,25 @@ EXPORT_SYMBOL_GPL(__adis_check_status);
 int __adis_reset(struct adis *adis)
 {
 	int ret;
+	const struct adis_timeout *timeouts = adis->data->timeouts;
 
 	ret = __adis_write_reg_8(adis, adis->data->glob_cmd_reg,
 			ADIS_GLOB_CMD_SW_RESET);
-	if (ret)
+	if (ret) {
 		dev_err(&adis->spi->dev, "Failed to reset device: %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	msleep(timeouts->sw_reset_ms);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(__adis_reset);
 
 static int adis_self_test(struct adis *adis)
 {
 	int ret;
+	const struct adis_timeout *timeouts = adis->data->timeouts;
 
 	ret = __adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
 			adis->data->self_test_mask);
@@ -339,7 +345,7 @@ static int adis_self_test(struct adis *adis)
 		return ret;
 	}
 
-	msleep(adis->data->startup_delay);
+	msleep(timeouts->self_test_ms);
 
 	ret = __adis_check_status(adis);
 
@@ -368,7 +374,6 @@ int adis_initial_startup(struct adis *adis)
 	if (ret) {
 		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
 		__adis_reset(adis);
-		msleep(adis->data->startup_delay);
 		ret = adis_self_test(adis);
 		if (ret) {
 			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
@@ -444,6 +449,11 @@ EXPORT_SYMBOL_GPL(adis_single_conversion);
 int adis_init(struct adis *adis, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct adis_data *data)
 {
+	if (!data || !data->timeouts) {
+		dev_err(&spi->dev, "No config data or timeouts not defined!\n");
+		return -EINVAL;
+	}
+
 	mutex_init(&adis->state_lock);
 	adis->spi = spi;
 	adis->data = data;
diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index d77bd6792437..29b28ebc5611 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -156,6 +156,7 @@ struct adis16400_state;
 
 struct adis16400_chip_info {
 	const struct iio_chan_spec *channels;
+	const struct adis_timeout *timeouts;
 	const int num_channels;
 	const long flags;
 	unsigned int gyro_scale_micro;
@@ -929,6 +930,36 @@ static const struct iio_chan_spec adis16334_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(ADIS16400_SCAN_TIMESTAMP),
 };
 
+static const struct adis_timeout adis16300_timeouts = {
+	.reset_ms = ADIS16400_STARTUP_DELAY,
+	.sw_reset_ms = ADIS16400_STARTUP_DELAY,
+	.self_test_ms = ADIS16400_STARTUP_DELAY,
+};
+
+static const struct adis_timeout adis16362_timeouts = {
+	.reset_ms = 130,
+	.sw_reset_ms = 130,
+	.self_test_ms = 12,
+};
+
+static const struct adis_timeout adis16400_timeouts = {
+	.reset_ms = 170,
+	.sw_reset_ms = 170,
+	.self_test_ms = 12,
+};
+
+static const struct adis_timeout adis16445_timeouts = {
+	.reset_ms = 55,
+	.sw_reset_ms = 55,
+	.self_test_ms = 16,
+};
+
+static const struct adis_timeout adis16448_timeouts = {
+	.reset_ms = 90,
+	.sw_reset_ms = 90,
+	.self_test_ms = 45,
+};
+
 static struct adis16400_chip_info adis16400_chips[] = {
 	[ADIS16300] = {
 		.channels = adis16300_channels,
@@ -941,6 +972,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
+		.timeouts = &adis16300_timeouts,
 	},
 	[ADIS16334] = {
 		.channels = adis16334_channels,
@@ -964,6 +996,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.flags = ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
+		.timeouts = &adis16300_timeouts,
 	},
 	[ADIS16360] = {
 		.channels = adis16350_channels,
@@ -976,6 +1009,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
+		.timeouts = &adis16300_timeouts,
 	},
 	[ADIS16362] = {
 		.channels = adis16350_channels,
@@ -988,6 +1022,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
+		.timeouts = &adis16362_timeouts,
 	},
 	[ADIS16364] = {
 		.channels = adis16350_channels,
@@ -1000,6 +1035,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
+		.timeouts = &adis16362_timeouts,
 	},
 	[ADIS16367] = {
 		.channels = adis16350_channels,
@@ -1012,6 +1048,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
+		.timeouts = &adis16300_timeouts,
 	},
 	[ADIS16400] = {
 		.channels = adis16400_channels,
@@ -1023,6 +1060,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
 		.set_freq = adis16400_set_freq,
 		.get_freq = adis16400_get_freq,
+		.timeouts = &adis16400_timeouts,
 	},
 	[ADIS16445] = {
 		.channels = adis16445_channels,
@@ -1036,6 +1074,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
 		.set_freq = adis16334_set_freq,
 		.get_freq = adis16334_get_freq,
+		.timeouts = &adis16445_timeouts,
 	},
 	[ADIS16448] = {
 		.channels = adis16448_channels,
@@ -1049,6 +1088,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
 		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
 		.set_freq = adis16334_set_freq,
 		.get_freq = adis16334_get_freq,
+		.timeouts = &adis16448_timeouts,
 	}
 };
 
@@ -1122,6 +1162,7 @@ static struct adis_data *adis16400_adis_data_alloc(struct adis16400_state *st,
 				BIT(ADIS16400_DIAG_STAT_FLASH_UPT) |
 				BIT(ADIS16400_DIAG_STAT_POWER_HIGH) |
 				BIT(ADIS16400_DIAG_STAT_POWER_LOW);
+	data->timeouts = st->variant->timeouts;
 
 	return data;
 }
diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index b55812521537..9539cfe4a259 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -383,6 +383,12 @@ static const char * const adis16460_status_error_msgs[] = {
 	[ADIS16460_DIAG_STAT_FLASH_UPT] = "Flash update failure",
 };
 
+static const struct adis_timeout adis16460_timeouts = {
+	.reset_ms = 225,
+	.sw_reset_ms = 225,
+	.self_test_ms = 10,
+};
+
 static const struct adis_data adis16460_data = {
 	.diag_stat_reg = ADIS16460_REG_DIAG_STAT,
 	.glob_cmd_reg = ADIS16460_REG_GLOB_CMD,
@@ -398,6 +404,7 @@ static const struct adis_data adis16460_data = {
 		BIT(ADIS16460_DIAG_STAT_SPI_COMM) |
 		BIT(ADIS16460_DIAG_STAT_FLASH_UPT),
 	.enable_irq = adis16460_enable_irq,
+	.timeouts = &adis16460_timeouts,
 };
 
 static int adis16460_probe(struct spi_device *spi)
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 1edfed83d480..d6adcd4a281b 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -138,6 +138,7 @@ struct adis16480_chip_info {
 	unsigned int max_dec_rate;
 	const unsigned int *filter_freqs;
 	bool has_pps_clk_mode;
+	const struct adis_timeout *timeouts;
 };
 
 enum adis16480_int_pin {
@@ -794,6 +795,30 @@ enum adis16480_variant {
 	ADIS16497_3,
 };
 
+static const struct adis_timeout adis16485_timeouts = {
+	.reset_ms = 560,
+	.sw_reset_ms = 120,
+	.self_test_ms = 12,
+};
+
+static const struct adis_timeout adis16480_timeouts = {
+	.reset_ms = 560,
+	.sw_reset_ms = 560,
+	.self_test_ms = 12,
+};
+
+static const struct adis_timeout adis16495_timeouts = {
+	.reset_ms = 170,
+	.sw_reset_ms = 130,
+	.self_test_ms = 40,
+};
+
+static const struct adis_timeout adis16495_1_timeouts = {
+	.reset_ms = 250,
+	.sw_reset_ms = 210,
+	.self_test_ms = 20,
+};
+
 static const struct adis16480_chip_info adis16480_chip_info[] = {
 	[ADIS16375] = {
 		.channels = adis16485_channels,
@@ -812,6 +837,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
+		.timeouts = &adis16485_timeouts,
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -824,6 +850,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
+		.timeouts = &adis16480_timeouts,
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -836,6 +863,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
+		.timeouts = &adis16485_timeouts,
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -848,6 +876,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 2460000,
 		.max_dec_rate = 2048,
 		.filter_freqs = adis16480_def_filter_freqs,
+		.timeouts = &adis16485_timeouts,
 	},
 	[ADIS16495_1] = {
 		.channels = adis16485_channels,
@@ -861,6 +890,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.timeouts = &adis16495_1_timeouts,
 	},
 	[ADIS16495_2] = {
 		.channels = adis16485_channels,
@@ -874,6 +904,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.timeouts = &adis16495_1_timeouts,
 	},
 	[ADIS16495_3] = {
 		.channels = adis16485_channels,
@@ -887,6 +918,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.timeouts = &adis16495_1_timeouts,
 	},
 	[ADIS16497_1] = {
 		.channels = adis16485_channels,
@@ -900,6 +932,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.timeouts = &adis16495_1_timeouts,
 	},
 	[ADIS16497_2] = {
 		.channels = adis16485_channels,
@@ -913,6 +946,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.timeouts = &adis16495_1_timeouts,
 	},
 	[ADIS16497_3] = {
 		.channels = adis16485_channels,
@@ -926,6 +960,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
+		.timeouts = &adis16495_1_timeouts,
 	},
 };
 
@@ -1199,6 +1234,7 @@ static struct adis_data *adis16480_adis_data_alloc(struct adis16480 *st,
 				BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |
 				BIT(ADIS16480_DIAG_STAT_BARO_FAIL);
 	data->enable_irq = adis16480_enable_irq;
+	data->timeouts = st->chip_info->timeouts;
 
 	return data;
 }
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 39687139a7d3..3d706ee02df0 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -237,6 +237,12 @@ static const char * const adis16203_status_error_msgs[] = {
 	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
 };
 
+static const struct adis_timeout adis16203_timeouts = {
+	.reset_ms = ADIS16203_STARTUP_DELAY,
+	.sw_reset_ms = ADIS16203_STARTUP_DELAY,
+	.self_test_ms = ADIS16203_STARTUP_DELAY
+};
+
 static const struct adis_data adis16203_data = {
 	.read_delay = 20,
 	.msc_ctrl_reg = ADIS16203_MSC_CTRL,
@@ -246,6 +252,7 @@ static const struct adis_data adis16203_data = {
 	.self_test_mask = ADIS16203_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
 	.startup_delay = ADIS16203_STARTUP_DELAY,
+	.timeouts = &adis16203_timeouts,
 
 	.status_error_msgs = adis16203_status_error_msgs,
 	.status_error_mask = BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index a480409090c0..9bba4238100f 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -359,6 +359,12 @@ static const char * const adis16240_status_error_msgs[] = {
 	[ADIS16240_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.225V",
 };
 
+static const struct adis_timeout adis16240_timeouts = {
+	.reset_ms = ADIS16240_STARTUP_DELAY,
+	.sw_reset_ms = ADIS16240_STARTUP_DELAY,
+	.self_test_ms = ADIS16240_STARTUP_DELAY,
+};
+
 static const struct adis_data adis16240_data = {
 	.write_delay = 35,
 	.read_delay = 35,
@@ -369,6 +375,7 @@ static const struct adis_data adis16240_data = {
 	.self_test_mask = ADIS16240_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
 	.startup_delay = ADIS16240_STARTUP_DELAY,
+	.timeouts = &adis16240_timeouts,
 
 	.status_error_msgs = adis16240_status_error_msgs,
 	.status_error_mask = BIT(ADIS16240_DIAG_STAT_PWRON_FAIL_BIT) |
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 4b5bc0e06e69..853dc8c8365c 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -22,6 +22,17 @@
 struct adis;
 struct adis_burst;
 
+/**
+ * struct adis_timeouts - ADIS chip variant timeouts
+ * @reset_ms - Wait time after rst pin goes inactive
+ * @sw_reset_ms - Wait time after sw reset command
+ * @self_test_ms - Wait time after self test command
+ */
+struct adis_timeout {
+	u16 reset_ms;
+	u16 sw_reset_ms;
+	u16 self_test_ms;
+};
 /**
  * struct adis_data - ADIS chip variant specific data
  * @read_delay: SPI delay for read operations in us
@@ -32,6 +43,7 @@ struct adis_burst;
  * @diag_stat_reg: Register address of the DIAG_STAT register
  * @status_error_msgs: Array of error messgaes
  * @status_error_mask:
+ * @timeouts: Chip specific delays
  */
 struct adis_data {
 	unsigned int read_delay;
@@ -45,6 +57,7 @@ struct adis_data {
 	unsigned int self_test_mask;
 	bool self_test_no_autoclear;
 	unsigned int startup_delay;
+	const struct adis_timeout *timeouts;
 
 	const char * const *status_error_msgs;
 	unsigned int status_error_mask;
-- 
2.20.1

