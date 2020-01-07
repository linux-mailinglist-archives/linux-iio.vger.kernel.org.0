Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5B1324A5
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2020 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgAGLRT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jan 2020 06:17:19 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41096 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727273AbgAGLRT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jan 2020 06:17:19 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007BAJWn011405;
        Tue, 7 Jan 2020 06:17:17 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xaneaevf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 06:17:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyheT4uNotzQIzHhO9vcp0+fkab754MIguGgYcaYl5wcCxcrDhBF1jKLjvldp9VXG9+dLx6d4p1puRU0/sQ/OEQVJSy0KREUqrPkXdae6t84s+t230BzgC4m4SPAyTFSh5yyfF7tAJt1DXXe1YxYNioYDmkflpyJ8h2+s1Sy3Z1JQ4OF2JzhFWPgawdeVoNBjCCW91Byc4pHCcoFC8DMevnxvU3wgmXtTSVwcg30g7p7UV/+Eku4Y7MU4Ja5HC+6D2Lh7lAwBFWX4cbaNw1luM/v5L+8QK3Vfo39woL/9w/1Z8zSCg8AaMZjpayXvRHkRNefYwvqzHt7COGf+wlEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FGfTTWvMCy9AQ50LwoaIt83lCwxWGKPq6JWwCfl8cY=;
 b=BwxplkLNltuUBNfkNBwd9nrI4mjYdb8zvaJDvuOWZvNp5x0TN2ltOyi++/FgoSM7wrANE6wOdXJEz3LYr7yClDRUhwar0O+tXeCLdaidUSnan2rSA9mK2KS2wpVUiXa4vojZ6MgZIRgKEh0ko+cXPFjQPXoIDPhZEcEBtsL2W4ClxJp3crkAN1uyt1CIkbC66K0ObCzWMymgHnFEzVeV6EzDkxTV51ZDhrh3ppR41pm7XUqi0cUzynEkI2JwWmJN0Eow9yv7//EUXD2t6+j7JdEgTqLDd9ty9wRuJuxhWRx9yWVTJ4W++xV64f7s64fwyriqsL0nqwly4CrfJa3IAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FGfTTWvMCy9AQ50LwoaIt83lCwxWGKPq6JWwCfl8cY=;
 b=FbYzzw7pSeXWI08qQLnADSU9jUfC1zLKZVOfTFxAdKKM+o6RUfT8BcbW5zJoHurJhrz/9seSPuag172pr3KbG454JkTNpR91WnKBtKyjlr/YgkeSjMnZFBIZK1JiO8Iye2hwbQmOTC0eB5ShhmLjCw6HJNbEsxTkuX+YB+XPVpc=
Received: from DM6PR03CA0048.namprd03.prod.outlook.com (2603:10b6:5:100::25)
 by CY4PR03MB2789.namprd03.prod.outlook.com (2603:10b6:903:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15; Tue, 7 Jan
 2020 11:17:15 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by DM6PR03CA0048.outlook.office365.com
 (2603:10b6:5:100::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend
 Transport; Tue, 7 Jan 2020 11:17:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Tue, 7 Jan 2020 11:17:15 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 007BHEG1015771
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Jan 2020 03:17:14 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 7 Jan 2020
 03:17:12 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 7 Jan 2020 06:17:12 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 007BH7lx004312;
        Tue, 7 Jan 2020 06:17:09 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/2] iio: adis: Remove startup_delay
Date:   Tue, 7 Jan 2020 13:17:05 +0200
Message-ID: <20200107111705.24138-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107111705.24138-1-alexandru.ardelean@analog.com>
References: <20200107111705.24138-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(86362001)(1076003)(5660300002)(7636002)(110136005)(54906003)(246002)(8676002)(316002)(2906002)(7696005)(6666004)(8936002)(356004)(426003)(2616005)(36756003)(186003)(44832011)(4326008)(26005)(70206006)(70586007)(336012)(478600001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2789;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f51936f7-a04b-454a-a54a-08d793632669
X-MS-TrafficTypeDiagnostic: CY4PR03MB2789:
X-Microsoft-Antispam-PRVS: <CY4PR03MB2789774142ED721BEB1368F8F93F0@CY4PR03MB2789.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-Forefront-PRVS: 027578BB13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZfxOLCMOCkGrdHwUK0zF1OqayEN59E2Dr3z7TdA4GxAc3Mih2SuYhoNyEM5g8hkk7mZoaFs3k7esv05gYM5KucjszKGuJMqYM/nM8fh0Zvvj2kQGTbcJXnO14tivmYffnYFWCJ75fkzfz0/dqotjrooxFjTGSed1enoYTUf56KkwB3Nr3UCHyl2bw7Q/B0z4XANsKJu8LCLd9Xz4dHkut2OnH69QTHOmhQKaDc1CMRzH7qD0KaiuRJ28+R5WgfcUbdzMxRe7prv11d49QHotzueDIv/2ehOIs2443yR006/luxfrLsg7u+tYQ3Kl1CIPLblySndJ51Wz8YJGsk6YzM9JTqCdEJRz/sAoa/0mc/tcKYPkEGcwC2yX8xBBVCL9dXaDW2D5u03un7vf2ztvNZpxOkVSJN5dy9EXyRRH3nMr8yxEbirXEp+mTvFq4RG
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 11:17:15.1337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51936f7-a04b-454a-a54a-08d793632669
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2789
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070090
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Nuno Sá <nuno.sa@analog.com>

All timeouts are now handled by a dedicated timeout struct. This
variable is no longer needed.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adis16201.c         | 1 -
 drivers/iio/accel/adis16209.c         | 1 -
 drivers/iio/gyro/adis16136.c          | 1 -
 drivers/iio/gyro/adis16260.c          | 1 -
 drivers/iio/imu/adis16400.c           | 1 -
 drivers/staging/iio/accel/adis16203.c | 1 -
 drivers/staging/iio/accel/adis16240.c | 1 -
 include/linux/iio/imu/adis.h          | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index c92d22387b01..0f0f27a8184e 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -247,7 +247,6 @@ static const struct adis_data adis16201_data = {
 
 	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
 	.timeouts = &adis16201_timeouts,
 
 	.status_error_msgs = adis16201_status_error_msgs,
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index f5a78fc11919..c6dbd2424e10 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -257,7 +257,6 @@ static const struct adis_data adis16209_data = {
 
 	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
 	.timeouts = &adis16209_timeouts,
 
 	.status_error_msgs = adis16209_status_error_msgs,
diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index dc91d8df7697..d5e03a406d4a 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -472,7 +472,6 @@ static const struct adis_data adis16136_data = {
 	.msc_ctrl_reg = ADIS16136_REG_MSC_CTRL,
 
 	.self_test_mask = ADIS16136_MSC_CTRL_SELF_TEST,
-	.startup_delay = 80,
 
 	.read_delay = 10,
 	.write_delay = 10,
diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 0e3a66a7726d..be09b3e5910c 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -346,7 +346,6 @@ static const struct adis_data adis16260_data = {
 	.diag_stat_reg = ADIS16260_DIAG_STAT,
 
 	.self_test_mask = ADIS16260_MSC_CTRL_MEM_TEST,
-	.startup_delay = ADIS16260_STARTUP_DELAY,
 	.timeouts = &adis16260_timeouts,
 
 	.status_error_msgs = adis1620_status_error_msgs,
diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 51b1ec23b8ef..cfb1c19eb930 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -1126,7 +1126,6 @@ static const struct adis_data adis16400_data = {
 	.write_delay = 50,
 
 	.self_test_mask = ADIS16400_MSC_CTRL_MEM_TEST,
-	.startup_delay = ADIS16400_STARTUP_DELAY,
 
 	.status_error_msgs = adis16400_status_error_msgs,
 	.status_error_mask = BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 3d706ee02df0..39dfe3f7f254 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -251,7 +251,6 @@ static const struct adis_data adis16203_data = {
 
 	.self_test_mask = ADIS16203_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16203_STARTUP_DELAY,
 	.timeouts = &adis16203_timeouts,
 
 	.status_error_msgs = adis16203_status_error_msgs,
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index d4848ef78c75..39eb8364aa95 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -374,7 +374,6 @@ static const struct adis_data adis16240_data = {
 
 	.self_test_mask = ADIS16240_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16240_STARTUP_DELAY,
 	.timeouts = &adis16240_timeouts,
 
 	.status_error_msgs = adis16240_status_error_msgs,
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 853dc8c8365c..d2fcf45b4cef 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -56,7 +56,6 @@ struct adis_data {
 
 	unsigned int self_test_mask;
 	bool self_test_no_autoclear;
-	unsigned int startup_delay;
 	const struct adis_timeout *timeouts;
 
 	const char * const *status_error_msgs;
-- 
2.20.1

