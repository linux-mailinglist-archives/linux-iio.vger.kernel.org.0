Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C7D11E7A0
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfLMQFb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 11:05:31 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:53878 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728172AbfLMQFa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 11:05:30 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDG0hCE011889;
        Fri, 13 Dec 2019 11:03:29 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wragqkf5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 11:03:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1XIsgw9dCC91HYzaaJOV9zKCU9EmVHz/OLgCObyPAjuwvp2Ztxc7bTM34QUVrUXvagTQ0LDeajXnL7gtl+m0YeyoFQbgI8PuyWjR5/KOATvMeYdlGje0TZ8iMI/dCzLSRCzTaImVDvXC52zPXoauFwk7GkFzvRxAg330BhKU3LKceBIKGw+VfohioLsWBA8EjcQoxqOLGdrIoB7wZVcnKyYmnqxhP8kDjv/WXEtPEIzZ14ljI6ighuQ2Zsjfm27dFaVPbTe1XV/dqekPA0muDVB1Oirw2qtFqakBoznBslJ7PmxvvP7Epmql3X9xmu305vScjjceE254/xxI2Y5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OoQZ7IWzkCaJn/J+xd37kbaucdWT5PPX22Izt7dpsU=;
 b=kxYx9LWyNWstwvNaufsVvGhU2CKuDciD+AoqvDcbVyyzNFmgWByUemqt3xpHjZ1HQ20NKt1x7ldWDtZEyp/mKThnwXQ2iHWNNvxNLWBx+moswId1D2ap3JtZ4pS8SiUEP0OqBMt2dOlNsRIJ+IIxYg8yCBxT/nk+A4V2ZgTzFWXX/VwtnT1rcM4lIjg/JrOJrdBJSmwgLJ6PzdnH7rVGrZAvaVecI4R0OANKYGfkctF0CmdKLt6PYhbIYgu1HUDNkBSidmUFnud0NtPPC3ghG2Vr/Jf7uc5IesjYyaOWWBCB5au+UC9tjofxOZ0Fx+7YnkTuWF6I7ox+aEmHH9QxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OoQZ7IWzkCaJn/J+xd37kbaucdWT5PPX22Izt7dpsU=;
 b=IcLp6UNjTKA0CZoUITCz0JLM67KVMDSOL/kgyctxLeYA7L0O8UCLZvbcrYmi1yAFhkiMn0mwT0W/aws78k9W/UITtdr5yHCS49mlKiO5F8jBXxZ2BNTexHR/kq8AEJtlqeTLCBw1sGIoXJZZ1LZPw9MGhsbL1mcrW4SQ7L4UsRY=
Received: from BN6PR03CA0106.namprd03.prod.outlook.com (2603:10b6:404:10::20)
 by DM5PR03MB2795.namprd03.prod.outlook.com (2603:10b6:3:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Fri, 13 Dec
 2019 16:03:27 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN6PR03CA0106.outlook.office365.com
 (2603:10b6:404:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.17 via Frontend
 Transport; Fri, 13 Dec 2019 16:03:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Fri, 13 Dec 2019 16:03:26 +0000
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBDG3PGB005512
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 13 Dec 2019 08:03:25 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 13 Dec
 2019 11:03:25 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 13 Dec 2019 08:03:25 -0800
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBDG3JMO015048;
        Fri, 13 Dec 2019 11:03:24 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 5/5] iio: adis: Remove startup_delay
Date:   Fri, 13 Dec 2019 18:03:12 +0200
Message-ID: <20191213160312.1834-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160312.1834-1-alexandru.ardelean@analog.com>
References: <20191213160312.1834-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(189003)(199004)(36756003)(86362001)(2906002)(426003)(44832011)(5660300002)(8936002)(70206006)(70586007)(1076003)(336012)(7636002)(8676002)(186003)(26005)(246002)(2616005)(54906003)(498600001)(4326008)(6666004)(356004)(107886003)(110136005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2795;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 983647ab-0187-4671-20c5-08d77fe5fd38
X-MS-TrafficTypeDiagnostic: DM5PR03MB2795:
X-Microsoft-Antispam-PRVS: <DM5PR03MB2795B62B36CAD3B2D0A7771BF9540@DM5PR03MB2795.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-Forefront-PRVS: 0250B840C1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MryY3p/qgZ/mYJHNbxyl5H7TFZ+MlX2JSg/12Lt0tw2YyyZ+A59nNa8QXxiMEZjXV3wAJw//oydRvPYv+IlW7w1hK8iK0TravL+s9LtQTPb8deqhszML+UgOUj1RQCaVHntfAXljSP1hzRaQGd/N1uxTW+i5Zrf/zfWEvKjsKmdGyjtRwj4EQ9nvKj8uYAkJTp+XiWfHNNtE0s67UdPkC7hpRGetUanC1d667lFh/72hEb9xMDStbP9xjF0Wb9hthD4HtXz+57sUtQHLU2bOS4HIeaeP0IaeaBMlmqly5E3ful7+pI9mecVlEfRUWAgOgNmEGlk9Bf0bJKcN24M3xpAKITzopvLja1KyfwGbQSKxfVrOoVPmaAQvpBMdZYssLZx61gEzztaFd1FmdHINxS3fGSpTmuuUHUTyGq7bzuu5KQAoD+ygiHqNFv0T1Yii
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:03:26.7616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 983647ab-0187-4671-20c5-08d77fe5fd38
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2795
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

From: Nuno Sá <nuno.sa@analog.com>

All timeouts are now handled by a dedicated timeout struct. This
variable is no longer needed.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
(cherry picked from commit d4d0c7c2145504a1062d74be8436ce11cced61f4)
---
 drivers/iio/accel/adis16201.c         | 1 -
 drivers/iio/accel/adis16209.c         | 1 -
 drivers/iio/gyro/adis16260.c          | 1 -
 drivers/staging/iio/accel/adis16203.c | 1 -
 drivers/staging/iio/accel/adis16240.c | 1 -
 include/linux/iio/imu/adis.h          | 1 -
 6 files changed, 6 deletions(-)

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
index 9bba4238100f..8337a94018f4 100644
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

