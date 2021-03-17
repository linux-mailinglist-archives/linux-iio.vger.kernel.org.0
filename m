Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541C833E9E6
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 07:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCQGjd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 02:39:33 -0400
Received: from mail-vi1eur05on2093.outbound.protection.outlook.com ([40.107.21.93]:62176
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230227AbhCQGjN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Mar 2021 02:39:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+bks1Huf2JRsGWkfOqVmQhQOA1e/ZSAD3Hfd5faBfDxt7qE/SF1a+L7wPQJDDrEYewaB4eMVW9Zbl/W7vcdKqNm8yPQfMNRGqV2gSBzMOVUjO4NsJXHwLwZd8XmDXlzYlEQ7MvNIS7AlBkUIucYez0wA/88P+LPqIX3MCNJlGK6ApI/8KEz5aV07d5aKsKxMK5A2NAhMiA3AO3RzKwikEo4q2yeR9yHEBaNzsgw236h8daIRV9f8iwgPNmCdt6j0zV33kBQ9jAOhBWm1RIu7SLwMi/88vNfSlWDg5CQ8m9MkTirCoQCYkE/kz0uz5NYxqfvhe2DR061HK5HsxlH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UamZbRvTo5QsVShDn24V3tzUphVzoncacvTSgb5pLzM=;
 b=IOrX5nMu3XKdzy0zxQxqDlC36vfHQScQiDpapfZtusDWzejwcII/US1kM7/fn9Yo4W6j8ZdsyC5AMSF20d2cBqHOWZeTbtgXC8b+tpMPOeY6Y6VGv3hMjNtpM9k6P6Lal1FNrUE9Z6QvKAFM4so9I8L07KBVm36lnfaxlYkVs4IrpiFo+9z2Bqqr7no2YKMYy5ni9stbx9N0fY0JZkSg7HKsxXyN6JfODrBblm3PHQVaZqtR+tIvYaKq8+OaczmFDhOeuKdZcirOLm4EeGGBUt3Sq006yB3yeEvb+oNyF1xmxBd7IfPP40K608bmInVnWII5wCtv4fjyKKRjGQMrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UamZbRvTo5QsVShDn24V3tzUphVzoncacvTSgb5pLzM=;
 b=e7S1sn09XV52GMWQPjMa7HUE46KxIl8zTa0aYj5GEhn5mSmHZORngoOb5jF4KYG+d9nGlwVwicX2QjvYJI4ZfXHxbcp0j/F+x+PqT2tx2dbhrqw7x0MMR518ZK+2pKegLXGXkH0uPFUH6RbMNSiLh6I9c++lSIRoq4jcPU0QnHM=
Received: from AM6P193CA0066.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::43)
 by AM9PR06MB7827.eurprd06.prod.outlook.com (2603:10a6:20b:3a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 06:39:11 +0000
Received: from VE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::99) by AM6P193CA0066.outlook.office365.com
 (2603:10a6:209:8e::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 06:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 VE1EUR02FT041.mail.protection.outlook.com (10.152.13.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Wed, 17 Mar 2021 06:39:11 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V3 2/2] iio:magnetometer: Add Support for ST IIS2MDC
Date:   Wed, 17 Mar 2021 06:39:02 +0000
Message-Id: <20210317063902.19300-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210317063902.19300-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210317063902.19300-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4658bda2-ed60-4278-888c-08d8e90f5fda
X-MS-TrafficTypeDiagnostic: AM9PR06MB7827:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR06MB7827C95A24CF51315AEFA410D76A9@AM9PR06MB7827.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYeFltj04i7HDqnVVPRDFbdQbD9uOrIieusgCzUaY48Nz3aonI3KZF+MuOB0TGHcSUkb9o1RwFPKTH1tVTQC1Rq9tmfk4Z4QQW4gx1UwFpxGxOnGfQp2N2v1qJ9C0uRe1ZNYtdtvnq/vXj/cL4u9KamiuCPmWyH/1HTMAKxG/H0fXy/efyiWOXetbqU09pM5HCB237pHZomrSC18+U5egtfc6rZ1QsNHhY65PjGY3N+dpuRW1+MoV2Xecy60MFgjlmVe87aouLwqVsoVThu1PaIkDS2F0gu600c1fb7qkgQLIY42OQR/7eHnuJKbEeixk3ZXTxlpUsFcLNv48FTLxs8gKqy5VfUPHf6FR+92t+Mi8P3rrIK/lBTrbnyq48gd0mhSZbIuaosAqNTboUsei0tq7e7xoil78pUb5THTQVaVAPlwaiQOsE432rRhYnZKdoyl20i0FIRI3QE/j9T6bSXMBQj4cKf0dprpVmYhvFs5cNiqx1BNfEyy8TWIvMLgCWUT3K2Ovi+vJXQMgzvbt1IBkm30Tw5gvBhq3JAITCcRijZVNVkHYnvKxgZzn7TmKOwNtZzr15ze9khMWBabBglwBKy0WopKhtXw5dGC++c06WX2S4iwEO5o5H5Uyxm5PqXHjvoqPMrgNqhMKi4iYQ==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(82740400003)(316002)(36736006)(6486002)(8676002)(2616005)(36756003)(26005)(107886003)(36860700001)(70206006)(186003)(356005)(81166007)(1076003)(6512007)(4326008)(47076005)(956004)(82310400003)(478600001)(86362001)(118246002)(5660300002)(336012)(6506007)(8936002)(2906002)(6666004)(70586007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 06:39:11.2233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4658bda2-ed60-4278-888c-08d8e90f5fda
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7827
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for ST magnetometer IIS2MDC,
an I2C/SPI interface 3-axis magnetometer.
The patch was tested on the instrument with IIS2MDC via I2C interface.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/magnetometer/st_magn.h      | 1 +
 drivers/iio/magnetometer/st_magn_core.c | 1 +
 drivers/iio/magnetometer/st_magn_i2c.c  | 5 +++++
 drivers/iio/magnetometer/st_magn_spi.c  | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 204b285725c8..7ba6a6ba5c58 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -21,6 +21,7 @@
 #define LSM303AGR_MAGN_DEV_NAME		"lsm303agr_magn"
 #define LIS2MDL_MAGN_DEV_NAME		"lis2mdl"
 #define LSM9DS1_MAGN_DEV_NAME		"lsm9ds1_magn"
+#define IIS2MDC_MAGN_DEV_NAME		"iis2mdc"
 
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

