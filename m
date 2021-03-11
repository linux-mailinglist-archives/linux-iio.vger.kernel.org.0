Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6937B336A5B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 04:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCKDGg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 22:06:36 -0500
Received: from mail-eopbgr70135.outbound.protection.outlook.com ([40.107.7.135]:39070
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229851AbhCKDGK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Mar 2021 22:06:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGYqCz38bzqC68beBrQgrtl4uT4tjUJhhXQ9dTwkXFiABmK4AtPV8boEuyLGZAqGSfYHQ4AOzphTP0jfGRRgJ5tMfsfsXG/XrbMwGCRGvXdNcewy1iOVzqO0T6O0vI4gfmiu2eGRKMj0ns4BZGclptMar19/YV0EjhbzNFWIyc9fDPNgmM0BVc7x9oI2WuNAYYn9q4qv/2bY5sV9DF8zCOk9BiDYyj8l+2izJ0h8XUjcZI5ijQ4bx2mAep8izQ0GsRS//FQxDmRw9Q82VCdD99FWbT+S6d49TG4R/btYeY+eQbEOqeL1sjX6VLxAIEJ20ZuBhJ7lB9K27flIsqzQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WucLbucGssu2cseOUOSUk9RLKiCrKkTfm4pspEQF1FE=;
 b=Cpr5Z69Clyldjfpc+O4PvWv77tTLRvwpkCNY48Dzx73jU70T3Ug1oEARddDyFG5n93ak/dVa/pE0uHLPZSgLVgWTCEGNQqXL0KIbR0KA8fvV/S/9u+qaGjDlm8d6b23wGdj9Ykh0/nlKOjrzefzJC8/t/BZsUphugaFUbmPYLB9xtnUNZ0Zq6Msi2/UNyekfdSHj26HJ6diyGcBAVl2bZyXPOKsurt6XWkFY6BIUjn+MXcOKor6Fs6UnEuSOMyEu4JTVG+bfuqQvxlYXPaMFRPtnNE5L1arJvYdxDTaoFJhLz5OfVW15o4gLtNXxvCc84fLXz6Ay8JeXwsQiUlawng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WucLbucGssu2cseOUOSUk9RLKiCrKkTfm4pspEQF1FE=;
 b=ZPiz08WaNb6XoHur+AsP1W4VS96CxK51Bcd+dDJm3yTiL1aSISFgGhASwgK7Ib5UCuLQk3rDUXKDTXdyetPoNiAmJe3kCusNJKT5FULqTMPmVyLGWMplEuY2aepr7k5lci4bEqKdZNKry+MOpZIR86kt5mDtPwfZEXFZJad1w3w=
Received: from AM7PR03CA0012.eurprd03.prod.outlook.com (2603:10a6:20b:130::22)
 by AM6PR06MB4359.eurprd06.prod.outlook.com (2603:10a6:20b:24::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Thu, 11 Mar
 2021 03:06:07 +0000
Received: from AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::b9) by AM7PR03CA0012.outlook.office365.com
 (2603:10a6:20b:130::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 11 Mar 2021 03:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 AM5EUR02FT056.mail.protection.outlook.com (10.152.9.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Thu, 11 Mar 2021 03:06:06 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V2 2/2] iio:magnetometer: Add Support for ST IIS2MDC
Date:   Thu, 11 Mar 2021 03:05:54 +0000
Message-Id: <20210311030554.6428-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311030554.6428-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210311030554.6428-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e9d6f00-1cc9-476d-5239-08d8e43a9d48
X-MS-TrafficTypeDiagnostic: AM6PR06MB4359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB4359B6519383E7E967AD9982D7909@AM6PR06MB4359.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bG7MoEFqyAWpQSeeoQnBAsMcXH2VASZNVK5dDtgOA2HBnlxxx1nfTUKh5tFffripSI8464qg8KXzOr0ZzQeMbr5V4tbWCOJiFfeVw4GLKc9mJkPgBYwwo64i+WVRxnu0g6lwQe4DrZMbkePEg0scn4wKBDxaoDN/hQczWT3TtvPuXQqqFHMGWNoELhSCUSYsE5WTfoeojaXpND2E3Jn5wlgJjh9zZ3kUTfZ+nZ0X4krgcbymgJwmZKmhs7eCSFSwzXl+/ArgLYEqEK5lVSsN3EAWXwPU1W8wCrXWlSbp4WBrSmYupCnCFqPhTEYqJ8+p1Jiz3ZmEq1rwLD7Fn+fnAWvuHSQ4BIcU+pBTPgPrlrMN6KT4xhp5hPhmQFLadATUhEZvxxtUK67se8/mtV3N0uS6w2CJ82BRVLHjuKjxLjZCTlRhK8UxSj4LhcmYPzWiHgmZ/Yj2AleyKqZWKWHsXBx3xpkFMHKM3+dnis7tuWqXaPRgFw3EwCg++T3L7C9GDRrTQwO2CHSRQ5GPAwwTg2nfB6HzBPxqo5KSUOP13mxd63EPILRKVKd8y3kX/LiSAyTXO/d0MkQVkzfu5iYCJQmKRqk7FPwzupUjAz7uQjFe9UZgO0rMDvhQts0Ik0h2A8EKR3RQhgXL32vUJKt4IKynbQe87/7QFJ6jhhYCIJZXK3LT5q5v4fFXIx3sbGMC
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(478600001)(4326008)(36860700001)(186003)(8936002)(6666004)(6506007)(8676002)(70586007)(107886003)(118246002)(36736006)(2906002)(70206006)(1076003)(6486002)(5660300002)(86362001)(356005)(81166007)(82740400003)(6512007)(47076005)(316002)(26005)(34020700004)(82310400003)(36756003)(2616005)(956004)(336012);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 03:06:06.8544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9d6f00-1cc9-476d-5239-08d8e43a9d48
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4359
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for ST magnetometer IIS2MDC,
an I2C/SPI interface 3-axis magnetometer.
The patch was tested on the instrument with IIS2MDC via I2C interface.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/magnetometer/st_magn.h      | 2 ++
 drivers/iio/magnetometer/st_magn_core.c | 1 +
 drivers/iio/magnetometer/st_magn_i2c.c  | 5 +++++
 drivers/iio/magnetometer/st_magn_spi.c  | 5 +++++
 4 files changed, 13 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 204b285725c8..912963441307 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -21,6 +21,8 @@
 #define LSM303AGR_MAGN_DEV_NAME		"lsm303agr_magn"
 #define LIS2MDL_MAGN_DEV_NAME		"lis2mdl"
 #define LSM9DS1_MAGN_DEV_NAME		"lsm9ds1_magn"
+#define IIS2MDC_MAGN_DEV_NAME		"iis2mdc"
+
 
 const struct st_sensor_settings *st_magn_get_settings(const char *name);
 int st_magn_common_probe(struct iio_dev *indio_dev);
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 79de721e6015..71faebd07feb 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -337,6 +337,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 		.sensors_supported = {
 			[0] = LSM303AGR_MAGN_DEV_NAME,
 			[1] = LIS2MDL_MAGN_DEV_NAME,
+			[2] = IIS2MDC_MAGN_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_magn_3_16bit_channels,
 		.odr = {
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index c6bb4ce77594..36f4e7b53b24 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -46,6 +46,10 @@ static const struct of_device_id st_magn_of_match[] = {
 		.compatible = "st,lsm9ds1-magn",
 		.data = LSM9DS1_MAGN_DEV_NAME,
 	},
+	{
+		.compatible = "st,iis2mdc",
+		.data = IIS2MDC_MAGN_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
@@ -101,6 +105,7 @@ static const struct i2c_device_id st_magn_id_table[] = {
 	{ LSM303AGR_MAGN_DEV_NAME },
 	{ LIS2MDL_MAGN_DEV_NAME },
 	{ LSM9DS1_MAGN_DEV_NAME },
+	{ IIS2MDC_MAGN_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 3d08d74c367d..0e2323dfc687 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -41,6 +41,10 @@ static const struct of_device_id st_magn_of_match[] = {
 		.compatible = "st,lsm9ds1-magn",
 		.data = LSM9DS1_MAGN_DEV_NAME,
 	},
+	{
+		.compatible = "st,iis2mdc",
+		.data = IIS2MDC_MAGN_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
@@ -92,6 +96,7 @@ static const struct spi_device_id st_magn_id_table[] = {
 	{ LSM303AGR_MAGN_DEV_NAME },
 	{ LIS2MDL_MAGN_DEV_NAME },
 	{ LSM9DS1_MAGN_DEV_NAME },
+	{ IIS2MDC_MAGN_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_magn_id_table);
-- 
2.17.1

