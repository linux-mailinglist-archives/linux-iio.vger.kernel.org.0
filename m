Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3D12DF03
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2019 15:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfE2N64 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 May 2019 09:58:56 -0400
Received: from mail-eopbgr770048.outbound.protection.outlook.com ([40.107.77.48]:34190
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbfE2N6z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 May 2019 09:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhOiKPnjI6Q8VSUBXKt5IOf/3WeEPCUNoE716cNYcls=;
 b=t4JDeiUJSNAP3+nttc/Qig7xFGq5PX3jeFtQNXS1jq1u9F3IziOBcy4OJkXDria1mkVTGzbQsC/nBAzRoLQNLNMYKSbgBxQ6jsIMHqXYMepFUYwpdNZ1uyfrXl8xwjHuIj+m1tJiYzAOgxXuc6jxLjn/hu3Nw9j9+4JoS58BHdc=
Received: from BYAPR03CA0028.namprd03.prod.outlook.com (2603:10b6:a02:a8::41)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.15; Wed, 29 May
 2019 13:58:53 +0000
Received: from BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BYAPR03CA0028.outlook.office365.com
 (2603:10b6:a02:a8::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.18 via Frontend
 Transport; Wed, 29 May 2019 13:58:52 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT064.mail.protection.outlook.com (10.152.77.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Wed, 29 May 2019 13:58:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4TDwp78011605
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2019 06:58:51 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 29 May 2019
 09:58:51 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][V2] iio: st_accel: fix iio_triggered_buffer_{pre,post}enable positions
Date:   Wed, 29 May 2019 16:58:48 +0300
Message-ID: <20190529135848.11964-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529130121.30532-1-alexandru.ardelean@analog.com>
References: <20190529130121.30532-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(2980300002)(54534003)(189003)(199004)(70586007)(70206006)(8936002)(8676002)(47776003)(107886003)(2870700001)(316002)(5024004)(2906002)(86362001)(305945005)(7636002)(36756003)(1076003)(26005)(476003)(76176011)(48376002)(126002)(2616005)(44832011)(486006)(50466002)(4326008)(2351001)(446003)(11346002)(336012)(186003)(50226002)(246002)(51416003)(6666004)(356004)(426003)(53416004)(5660300002)(6916009)(7696005)(77096007)(478600001)(106002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32146ae2-8d59-4cef-9d78-08d6e43dc81c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Antispam-PRVS: <BL2PR03MB545F0636AC26725F1131D26F91F0@BL2PR03MB545.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0052308DC6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: k6DbK2MB1vL/Rv6ral0beE3Wsg8KEFh4FrIpfRYhc5Fejmg/AFGJHFDdqcF/kRsG0gPsl5zew7XEL1xiIYysccfO5tDvg9weeOsGX/lL9OgizLLl4ygG81cwuHLnTKBYQARcg9I0SWxPK2vpwCx/UMV9K/ajhCni4K+npHuQTeHuS5wo+bGCbV0sMkI9rweFfKsFsHg06M6BRDzpoz3yNt8QBNWRtj0JgBSz9dqSfzOEyF/iz7SsHyUihPe+KcQJdIb/AjHMHzndM6luCUqtRgmi6Lu8z65kLIewf7fw0XlgjSzfEsI6UyRxNwpvhpE39t48UuIU7cAPhQ5Mq87FX8sNyC7R3kDNkSUcXxiVgAsCLkVZJ9Gf4pi/ZMHAjMpoxsAOA78sEhg6f0Oq8sYS0udspamvDrPWNPnsDRkwbd8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2019 13:58:51.9929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32146ae2-8d59-4cef-9d78-08d6e43dc81c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
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

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
Changelog v1 -> v2:
* record the first error in st_accel_buffer_predisable() and return that 

 drivers/iio/accel/st_accel_buffer.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 7fddc137e91e..711ecd9bc898 100644
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
@@ -51,34 +55,33 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
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
 
 static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 {
-	int err;
+	int err, err2;
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
+	err2 = iio_triggered_buffer_predisable(indio_dev);
+	if (!err)
+		err = err2;
+
 	kfree(adata->buffer_data);
 	return err;
 }
-- 
2.20.1

