Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A6811E79A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 17:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfLMQF0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 11:05:26 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:45468 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728094AbfLMQFZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 11:05:25 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDG0Psv025762;
        Fri, 13 Dec 2019 11:03:24 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wraew3hgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 11:03:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi7pA5LNr9grv2yVAq7w4kgrmyuilMIpg4paZ5kdJwHj9EoDwpuoC1Sze7Ex4k/RfdvVpAAvz/c7ZnYNRZ/zXnOUpTaLB2+Kt9Xck3kA+oAkSkPHgYD+cAkTIx8Hrxjw3ZUbbadf6dk7UJ8wzwY1CsDLT1Q8X68tbEC5ZRiGw1VBFPhBV8v/IqGKHetWdrk8SUWFDhlUb5vdRcsGhCH6V5jUVNwW+AsiYcUw+gGtGnB8eBBvWh//ImUgAlpmpndYwdKSR6Y4ocENVkkbXuuN5n9ywWbc4QloB66XQeJ5r56HLqTaVrNyI2/ZuWCIyEvG1vqKetbUyDfLmhQnesI0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+7IBJGR94W5w3XG6mqE3JXwHkLnJy1b5AgNhmEHcK0=;
 b=lw3fI7BvFbFTQpiZGlsTEM2MQWTNHKqAdHHgQqae1Kw8oMJ/L7KyHBCuGr3Wz0EAInQ4ONx3LclLnaAbNnNEsMj1jLy0pbyOsh16qzpkogDdEdAvHpT58kLc/C55bGHNqwApHnnhbe4rwmMdeM8XAZGhVGg33KoAhT5rg1yFn8d0jdSe0gPQQDO8yDveZxWsXCV5znR020nxbJhZTtbo5BESiaNq9tz/WQ9VlUaQtpwelYoHLnSrDxr6oybe0nUOYWcfHcwpJ43YfdXo6ogGeOTbrhkHMlR+DZ0lsE9eNheHtihaIAH63KRsqZ7HmWb9m4DSv4KQg2b/xW462y1IHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+7IBJGR94W5w3XG6mqE3JXwHkLnJy1b5AgNhmEHcK0=;
 b=gTHgC46pVdaGm5FR9c+3QaMBZZyFWqg5mFKD28tRmOMZp8IH4mGdcywHubC2uQyAySb4YET0IcLfPxEBCK7qQU9qUlQpWgvClBMjo88GIka0bLPcra1pyF8Y9h6evCnY8gcc5B6YGXQ5U8JZu4JH3Z6445rgiCnqvmqFZgtiI2s=
Received: from BN6PR03CA0017.namprd03.prod.outlook.com (2603:10b6:404:23::27)
 by MN2PR03MB4670.namprd03.prod.outlook.com (2603:10b6:208:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Fri, 13 Dec
 2019 16:03:23 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN6PR03CA0017.outlook.office365.com
 (2603:10b6:404:23::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Fri, 13 Dec 2019 16:03:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Fri, 13 Dec 2019 16:03:23 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBDG3MHV005479
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 13 Dec 2019 08:03:22 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.105) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 13 Dec 2019 11:03:21 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 13 Dec 2019 08:03:21 -0800
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBDG3JML015048;
        Fri, 13 Dec 2019 11:03:20 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 2/5] iio: imu: adis16400: construct adis data on probe vs static on driver
Date:   Fri, 13 Dec 2019 18:03:09 +0200
Message-ID: <20191213160312.1834-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160312.1834-1-alexandru.ardelean@analog.com>
References: <20191213160312.1834-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(4326008)(36756003)(110136005)(336012)(8676002)(86362001)(7636002)(26005)(54906003)(6666004)(7696005)(356004)(1076003)(107886003)(44832011)(70206006)(2616005)(5660300002)(70586007)(186003)(316002)(8936002)(246002)(478600001)(426003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4670;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6eb6e7b-0b96-402a-f058-08d77fe5fb00
X-MS-TrafficTypeDiagnostic: MN2PR03MB4670:
X-Microsoft-Antispam-PRVS: <MN2PR03MB4670E9F2430A6220F5FB3F34F9540@MN2PR03MB4670.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-Forefront-PRVS: 0250B840C1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzDoVXd/L+IDX1GMLMOZ/e/xSbqwmnIc5JUuQBcAzUwALlIKVXxSjogtjXo5k23Aye6XUx9T+DtCf07yvbEOa2FOjU4FyKE/LFxrhMNcGEUXx760c98Qg0/PfgDu9jTip6yLNoPpM8uyZ31pc00v6kNvsaGVPJrKqx4UwduEE9/W5MwdxnNeCijkw0pz6jfjRIGjYs3XKBMGeiLUsG5Z4qAoHkMqtoqJC2cxXYT2KueMbDD3xNmCzIskuP7yZ+PJ9NmpsAFn71HKxV11pD6SL/FfAIIQPozc823OLOdBm15aINNoL6AlxuXjHfBGOLGf4AnQkDv71YAZdl/shILx8prgZ3KTy0pekcvF32HbBwpKkUTMdQJOmu6F31dx+k7jX2qQI1Wfi2EozjUO4d0VMPW6uSkpnHOvSEHO90AvSrcSbVf4GOZ+HCT+7NSdHqJK
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:03:23.0464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6eb6e7b-0b96-402a-f058-08d77fe5fb00
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4670
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_05:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/iio/imu/adis16400.c | 71 +++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 662cb5367c11..d77bd6792437 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -1077,35 +1077,6 @@ static const char * const adis16400_status_error_msgs[] = {
 	[ADIS16400_DIAG_STAT_POWER_LOW] = "Power supply below 4.75V",
 };
 
-static const struct adis_data adis16400_data = {
-	.msc_ctrl_reg = ADIS16400_MSC_CTRL,
-	.glob_cmd_reg = ADIS16400_GLOB_CMD,
-	.diag_stat_reg = ADIS16400_DIAG_STAT,
-
-	.read_delay = 50,
-	.write_delay = 50,
-
-	.self_test_mask = ADIS16400_MSC_CTRL_MEM_TEST,
-	.startup_delay = ADIS16400_STARTUP_DELAY,
-
-	.status_error_msgs = adis16400_status_error_msgs,
-	.status_error_mask = BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_YACCL_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_XACCL_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_XGYRO_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_YGYRO_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_ZGYRO_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_ALARM2) |
-		BIT(ADIS16400_DIAG_STAT_ALARM1) |
-		BIT(ADIS16400_DIAG_STAT_FLASH_CHK) |
-		BIT(ADIS16400_DIAG_STAT_SELF_TEST) |
-		BIT(ADIS16400_DIAG_STAT_OVERFLOW) |
-		BIT(ADIS16400_DIAG_STAT_SPI_FAIL) |
-		BIT(ADIS16400_DIAG_STAT_FLASH_UPT) |
-		BIT(ADIS16400_DIAG_STAT_POWER_HIGH) |
-		BIT(ADIS16400_DIAG_STAT_POWER_LOW),
-};
-
 static void adis16400_setup_chan_mask(struct adis16400_state *st)
 {
 	const struct adis16400_chip_info *chip_info = st->variant;
@@ -1120,11 +1091,47 @@ static void adis16400_setup_chan_mask(struct adis16400_state *st)
 	}
 }
 
+static struct adis_data *adis16400_adis_data_alloc(struct adis16400_state *st,
+						   struct device *dev)
+{
+	struct adis_data *data;
+
+	data = devm_kzalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->msc_ctrl_reg = ADIS16400_MSC_CTRL;
+	data->glob_cmd_reg = ADIS16400_GLOB_CMD;
+	data->diag_stat_reg = ADIS16400_DIAG_STAT;
+	data->read_delay = 50;
+	data->write_delay = 50;
+	data->self_test_mask = ADIS16400_MSC_CTRL_MEM_TEST;
+	data->status_error_msgs = adis16400_status_error_msgs;
+	data->status_error_mask = BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |
+				BIT(ADIS16400_DIAG_STAT_YACCL_FAIL) |
+				BIT(ADIS16400_DIAG_STAT_XACCL_FAIL) |
+				BIT(ADIS16400_DIAG_STAT_XGYRO_FAIL) |
+				BIT(ADIS16400_DIAG_STAT_YGYRO_FAIL) |
+				BIT(ADIS16400_DIAG_STAT_ZGYRO_FAIL) |
+				BIT(ADIS16400_DIAG_STAT_ALARM2) |
+				BIT(ADIS16400_DIAG_STAT_ALARM1) |
+				BIT(ADIS16400_DIAG_STAT_FLASH_CHK) |
+				BIT(ADIS16400_DIAG_STAT_SELF_TEST) |
+				BIT(ADIS16400_DIAG_STAT_OVERFLOW) |
+				BIT(ADIS16400_DIAG_STAT_SPI_FAIL) |
+				BIT(ADIS16400_DIAG_STAT_FLASH_UPT) |
+				BIT(ADIS16400_DIAG_STAT_POWER_HIGH) |
+				BIT(ADIS16400_DIAG_STAT_POWER_LOW);
+
+	return data;
+}
+
 static int adis16400_probe(struct spi_device *spi)
 {
 	struct adis16400_state *st;
 	struct iio_dev *indio_dev;
 	int ret;
+	const struct adis_data *adis16400_data;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
@@ -1151,7 +1158,11 @@ static int adis16400_probe(struct spi_device *spi)
 			st->adis.burst->extra_len = sizeof(u16);
 	}
 
-	ret = adis_init(&st->adis, indio_dev, spi, &adis16400_data);
+	adis16400_data = adis16400_adis_data_alloc(st, &spi->dev);
+	if (IS_ERR(adis16400_data))
+		return PTR_ERR(adis16400_data);
+
+	ret = adis_init(&st->adis, indio_dev, spi, adis16400_data);
 	if (ret)
 		return ret;
 
-- 
2.20.1

