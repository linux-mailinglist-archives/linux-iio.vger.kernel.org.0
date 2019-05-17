Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69409219B2
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2019 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfEQOTq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 May 2019 10:19:46 -0400
Received: from mail-eopbgr700055.outbound.protection.outlook.com ([40.107.70.55]:42176
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728383AbfEQOTq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 May 2019 10:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO6tHdYFWd5z7opCnqGjesagGTQ3VR6VGXjffv2Hrck=;
 b=M4kIeVvVkHIONLPkGCV06aQB0FQY2G85VFmQ1MvD4hGbD3ZehniWd5sKAGih0m8VOKcSTIiT0Kxr3HkYQJVFaNK0HotcU9YXEjzjd0ueyXqsZ30j3JnBYAI9HmEv3oZgLVezw2kvI4hu1Y7ZN+DQUSZICvjJWa0Ha9B8QQ2yOTA=
Received: from BN6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:404:10::11)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.17; Fri, 17 May
 2019 14:19:43 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN6PR03CA0097.outlook.office365.com
 (2603:10b6:404:10::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Fri, 17 May 2019 14:19:42 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Fri, 17 May 2019 14:19:41 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4HEJevY024651
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2019 07:19:40 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Fri, 17 May 2019
 10:19:40 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: frequency: ad9523: add eeprom read/write verification
Date:   Fri, 17 May 2019 17:19:38 +0300
Message-ID: <20190517141938.10315-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(189003)(199004)(2351001)(7696005)(8936002)(51416003)(316002)(14444005)(356004)(86362001)(107886003)(48376002)(44832011)(5660300002)(486006)(16586007)(47776003)(8676002)(53416004)(50466002)(106002)(50226002)(54906003)(2616005)(426003)(336012)(15650500001)(70206006)(77096007)(126002)(36756003)(476003)(186003)(70586007)(2906002)(6916009)(7636002)(478600001)(26005)(246002)(1076003)(305945005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf79069-572a-402d-d12f-08d6dad2b461
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BY2PR03MB553;
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Antispam-PRVS: <BY2PR03MB553E2E0D1738254B921C19CF90B0@BY2PR03MB553.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0040126723
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 64ZBVOi0jl0omgvJYERS9x0v+PGmWHPDO3NHDapmOOpWclu7jD4fsKhQBvZ2RMyDrHoDQd2+iQjmsvDipgQ8yu8bHTnbp3lSAALdQJFOZ4FZV69QxDLPivYKE0bHCiQHtTu6Nn1HtFjMRJh4H+CUdpf2ykgA0WXAq+yLhlYZ5d+aYuQslXSfX517HOFr1N22uyfMME8hWBLnBQPJZpOIHI4LBGeggvHq5F7W4M2755K0YS06R5XC1Pt+FkWh4rYg8PpFLgJc94hIF5eIJJNWty5l2PE3ZqaAysJUPh//GEu8VQ7/GzveqR3oUHoV+aXuGx3zpVIaxZ34/2TkU5095+giPhB9umIndOTXG4+f3sgHktUxLZmCUJNT2jxbI5g3EAapsXjZRh5U9vRRWlVcucZo0ZuI4c6PfaaG1n9yMTY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2019 14:19:41.8106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf79069-572a-402d-d12f-08d6dad2b461
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This change adds a basic verification of the EEPROM by writing a known
value to the customer version ID register, and reading it back.

This validates that the EEPROM & SPI communication are functioning
properly, and the device is ready to use.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/frequency/ad9523.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 9b9eee27176c..dd159a1237f3 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -749,6 +749,30 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad9523_verify_eeprom(struct iio_dev *indio_dev)
+{
+	int ret, id;
+
+	id = ad9523_read(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID);
+	if (id < 0)
+		return id;
+
+	ret = ad9523_write(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID, 0xAD95);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9523_read(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID);
+	if (ret < 0)
+		return ret;
+
+	if (ret != 0xAD95) {
+		dev_err(&indio_dev->dev, "SPI Read Verify failed (0x%X)\n", ret);
+		return -EIO;
+	}
+
+	return ad9523_write(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID, id);
+}
+
 static const struct iio_info ad9523_info = {
 	.read_raw = &ad9523_read_raw,
 	.write_raw = &ad9523_write_raw,
@@ -780,6 +804,10 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
+	ret = ad9523_verify_eeprom(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * PLL1 Setup
 	 */
-- 
2.17.1

