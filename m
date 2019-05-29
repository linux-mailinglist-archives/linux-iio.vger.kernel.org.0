Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D959B2DF8B
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2019 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfE2OUs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 May 2019 10:20:48 -0400
Received: from mail-eopbgr770048.outbound.protection.outlook.com ([40.107.77.48]:29761
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfE2OUr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 May 2019 10:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwI8H0vuX/QHTBW8JvsG6/4EjsWlnhhgVQRIM7i5ghY=;
 b=sA7AX5vR2Hcrbn/3eXF4PW0OCVaVr8DVh7MRL+HuhWd9OpCRr8GffwFQiALwKvnvkQ/IKPlPxYpbFIlm87s9+Cji0yMqW9J2vR8jdAKjYKPunsSRBcLTs2ca+0zN8RMhgonOa/2U5xpmKwKredj2XYbIuAJUvDYszfj0CS501a4=
Received: from BN6PR03CA0114.namprd03.prod.outlook.com (2603:10b6:404:10::28)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.15; Wed, 29 May
 2019 14:20:45 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR03CA0114.outlook.office365.com
 (2603:10b6:404:10::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Wed, 29 May 2019 14:20:45 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Wed, 29 May 2019 14:20:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4TEKipf029987
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 29 May 2019 07:20:44 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 29 May 2019
 10:20:44 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: tcs3414: fix iio_triggered_buffer_{pre,post}enable positions
Date:   Wed, 29 May 2019 17:20:40 +0300
Message-ID: <20190529142040.7993-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(199004)(189003)(44832011)(48376002)(2616005)(126002)(54906003)(26005)(1076003)(476003)(50466002)(4326008)(486006)(7636002)(305945005)(36756003)(6916009)(5660300002)(53416004)(106002)(478600001)(7696005)(77096007)(186003)(50226002)(336012)(2351001)(426003)(356004)(6666004)(51416003)(246002)(8936002)(70586007)(70206006)(316002)(5024004)(2870700001)(2906002)(86362001)(8676002)(107886003)(47776003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 470bd11b-cd35-4ac7-9022-08d6e440d6c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Antispam-PRVS: <BL2PR03MB5458478102C8BBC16C22FE3F91F0@BL2PR03MB545.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0052308DC6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RlxfEcghyWMX550xOdZ6sinf3GhPtxZW4FkmKa+6xlou+krHvCrFAChAXCONe+LR1WaCocb2+arIjLsJcRqxmWDsKZfwGYtn9zn7vqGPCbVBVYX+j56PA5uF0eWMzeDJFUi2B1b1mrlRG45Xo1R/kzyRBCkCwzovMuE65bcnxVxA5sNSMSW03TkqiHphNMe8fHbtsMZ8T5X51lHMo1H/ObYBIS6pz33r7j8LqXJNS7yhxfF4jcx5gyMZSVWHXbfCTRLNVQxQelbj29BlldVsTKK+6fni5p8KrFkh+7v95+Qj70V+QOODFHPmxKAOIrmfK7ktvTRzKWZU20mfUNL+jiccAwhGOweizLJVwnzLdE8P/TEaN53G0YyURMXv776HHBVsBU/GsUku60IvNhVq2rZAr3dkAd3KyLmRMRRAbhI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2019 14:20:45.0622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470bd11b-cd35-4ac7-9022-08d6e440d6c1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

For the predisable hook, the disable code should occur before detaching
the poll func, and for the postenable hook, the poll func should be
attached before the enable code.

The driver was slightly reworked. The preenable hook was moved to the
postenable, to add some symmetry to the postenable/predisable part.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/light/tcs3414.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 205e5659ce6b..ae70bf89be70 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -243,32 +243,42 @@ static const struct iio_info tcs3414_info = {
 	.attrs = &tcs3414_attribute_group,
 };
 
-static int tcs3414_buffer_preenable(struct iio_dev *indio_dev)
+static int tcs3414_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct tcs3414_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
 
 	data->control |= TCS3414_CONTROL_ADC_EN;
-	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
+	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
+	if (ret)
+		iio_triggered_buffer_predisable(indio_dev);
+
+	return ret;
 }
 
 static int tcs3414_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct tcs3414_data *data = iio_priv(indio_dev);
-	int ret;
-
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		return ret;
+	int ret, ret2;
 
 	data->control &= ~TCS3414_CONTROL_ADC_EN;
-	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
+	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
+
+	ret2 = iio_triggered_buffer_predisable(indio_dev);
+	if (!ret)
+		ret = ret2;
+
+	return ret;
 }
 
 static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
-	.preenable = tcs3414_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
+	.postenable = tcs3414_buffer_postenable,
 	.predisable = tcs3414_buffer_predisable,
 };
 
-- 
2.20.1

