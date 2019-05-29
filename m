Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD52DDA5
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2019 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfE2NBb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 May 2019 09:01:31 -0400
Received: from mail-eopbgr750050.outbound.protection.outlook.com ([40.107.75.50]:65028
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbfE2NBa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 May 2019 09:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44bGlHNejdWwdLILREpW4vbhuKEG2Th1FNQfEN2+YZU=;
 b=zC/yFTs03mn89tbs3rLJyWMNFe9Zj/464khaN2+P7/GybqPlWb5Ly3OPc73vAg6Nw9/3isyBBPQ5XF5K+a4XjBjtjZMMTNWWXCzSFf84+rCZ74ODj78re3yYMZiZzzOsmh9FJROwwkiRO9GAkrglZSM5agpJoZGCl7rkO8RDBPQ=
Received: from CY1PR03CA0020.namprd03.prod.outlook.com (2603:10b6:600::30) by
 BLUPR03MB549.namprd03.prod.outlook.com (2a01:111:e400:880::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Wed, 29 May 2019 13:01:27 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by CY1PR03CA0020.outlook.office365.com
 (2603:10b6:600::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.16 via Frontend
 Transport; Wed, 29 May 2019 13:01:27 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Wed, 29 May 2019 13:01:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4TD1QxE028134
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2019 06:01:26 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 29 May 2019
 09:01:25 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: st_accel: fix iio_triggered_buffer_{pre,post}enable positions
Date:   Wed, 29 May 2019 16:01:21 +0300
Message-ID: <20190529130121.30532-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(336012)(44832011)(1076003)(8676002)(51416003)(5024004)(47776003)(5660300002)(2351001)(53416004)(486006)(4326008)(126002)(7636002)(2616005)(48376002)(478600001)(476003)(70206006)(50466002)(70586007)(316002)(186003)(426003)(26005)(7696005)(2906002)(6916009)(246002)(86362001)(107886003)(50226002)(2870700001)(36756003)(305945005)(356004)(106002)(77096007)(8936002)(6666004)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB549;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b318e05-ff86-48cf-5b0c-08d6e435c2c6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:BLUPR03MB549;
X-MS-TrafficTypeDiagnostic: BLUPR03MB549:
X-Microsoft-Antispam-PRVS: <BLUPR03MB549430789800029E24BA7B3F91F0@BLUPR03MB549.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0052308DC6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: powSSe6+DBNj7NJgQHNXH1YhiYVR6ySk96CjI2/p1X74MSi9gcHUBmBngMgYGTyfGshrO3KjZw2+0ixjfuSyfC9VCzvI/beGEB1E9ngT9mIMHEnCxglE3weow2DbpxEEl/VRzL/MaNeOHbNFjjes/QJB5ljX4Wkp3brpkchGRIlvTJqdpseRsRwRThgbWZm4cEJa4+/3WpQIDVJZefmm6m5WORdrQGZYnaX8dxcQ61Cwbqn0yV+QOUGKDqjy+CetvnM7FMpfFPFVUR0r+oZGF5+/wTUSEzkJaJHqD/NU8mxwhlikV8YEd+CeVxkanPjF+RoXeFh5OEdzfQmgOOES1V8z/cRn7BXrmzOyWSq19/IdHJFSxAM+YgPzXT7EnnNRfZYmagJBVZzcKeDG/Ugj7VspDkv4UFg7/lwNtiNuvJU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2019 13:01:26.7819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b318e05-ff86-48cf-5b0c-08d6e435c2c6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB549
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

For the predisable hook, the disable code should occur before detaching
the poll func, and for the postenable hook, the poll func should be
attached before the enable code.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/st_accel_buffer.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 7fddc137e91e..58cc6305f66e 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -40,6 +40,10 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
+	err = iio_triggered_buffer_postenable(indio_dev);
+	if (err < 0)
+		return err;
+
 	adata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (adata->buffer_data == NULL) {
 		err = -ENOMEM;
@@ -51,15 +55,12 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_accel_buffer_postenable_error;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
-	if (err < 0)
-		goto st_accel_buffer_postenable_error;
-
 	return err;
 
 st_accel_buffer_postenable_error:
 	kfree(adata->buffer_data);
 allocate_memory_error:
+	iio_triggered_buffer_predisable(indio_dev);
 	return err;
 }
 
@@ -68,19 +69,17 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
-	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_accel_buffer_predisable_error;
-
 	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 	if (err < 0)
 		goto st_accel_buffer_predisable_error;
 
 	err = st_sensors_set_enable(indio_dev, false);
+	if (err < 0)
+		goto st_accel_buffer_predisable_error;
 
 st_accel_buffer_predisable_error:
 	kfree(adata->buffer_data);
-	return err;
+	return iio_triggered_buffer_predisable(indio_dev);
 }
 
 static const struct iio_buffer_setup_ops st_accel_buffer_setup_ops = {
-- 
2.20.1

