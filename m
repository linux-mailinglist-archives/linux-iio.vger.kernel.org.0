Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE645ADB
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 12:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFNKre (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 06:47:34 -0400
Received: from mail-eopbgr800081.outbound.protection.outlook.com ([40.107.80.81]:34690
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfFNKre (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Jun 2019 06:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHKVc8EM3cJ5zaCNxHNZkC6SjoQF2s2SWcQ2848B6Hc=;
 b=vnuo7DT5mI49tFPGlDfSsAtW/rMiUXAarg2Rsp5Lzp2Ojxy9IqpSLnSTmfb8Qhabfa5tOizmUmYSSI7CSABjtn2ngyN1fW8sf85HHGK9gaeAnMTBz8Y3sL/mouMp93g71VFMjO9sujIm65LbiEBN2FuOlWlJ+vQ0mzDwEU5FaFY=
Received: from DM6PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:100::39)
 by MWHPR03MB3135.namprd03.prod.outlook.com (2603:10b6:301:3c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.17; Fri, 14 Jun
 2019 10:47:31 +0000
Received: from BL2NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by DM6PR03CA0062.outlook.office365.com
 (2603:10b6:5:100::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.12 via Frontend
 Transport; Fri, 14 Jun 2019 10:47:31 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT005.mail.protection.outlook.com (10.152.76.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Fri, 14 Jun 2019 10:47:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5EAlUeL008447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Fri, 14 Jun 2019 03:47:30 -0700
Received: from saturn.ad.analog.com (10.48.65.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Jun 2019 06:47:30 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][V3] iio: st_accel: fix iio_triggered_buffer_{pre,post}enable positions
Date:   Fri, 14 Jun 2019 13:47:25 +0300
Message-ID: <20190614104725.4535-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529135848.11964-1-alexandru.ardelean@analog.com>
References: <20190529135848.11964-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(54534003)(189003)(199004)(1076003)(8936002)(4326008)(478600001)(86362001)(8676002)(6916009)(246002)(106002)(5660300002)(47776003)(50466002)(44832011)(11346002)(77096007)(26005)(7636002)(446003)(7696005)(48376002)(51416003)(5024004)(2870700001)(486006)(76176011)(36756003)(336012)(305945005)(107886003)(50226002)(316002)(70586007)(70206006)(476003)(186003)(2351001)(2616005)(2906002)(356004)(6666004)(426003)(126002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3135;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30d77e50-1ade-4c5e-f35a-08d6f0b5b392
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MWHPR03MB3135;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3135:
X-Microsoft-Antispam-PRVS: <MWHPR03MB313569B29578B16CFC853771F9EE0@MWHPR03MB3135.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0068C7E410
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7PqljSS8Jzl4zqMBVJxUZ3wB0O1CYzQ7rFOzqPHPOhYFJvS2dNKi0XjyMVfdyR+xqa9chJk1vnvRrACdlMiG8gSHlWMk4hDlN3eYafTBtK95jOPevxIOdkB0U1PbopTk1A8MxWkjuZBMwdqz8HYnCpoiyjVcCZWDXjiI4CtsmGN+iJcf73FSKgo2oDHCOhuXJD97JjzMwHwlMJH6vuzcFWM4oQCc2qIZiD2xNaLgdiByKml2e2+gh+he0YXU9Q1T/hQvCYbBRl4vwgabh7L14w3qdQc+DBJ9rnaacOqw0tW3YU3kTsU7N4Ldrp48CgreRdKoJ9fyaCdwm80q+Qx5UYHWw6OMya+SOjLZ/XhvLdQWzvN2umAhZ7lFxoFizyvJvUgDaulPnRMBoI/YBwCitOqbRfop0XkJW94rn4BhmjQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2019 10:47:31.1052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d77e50-1ade-4c5e-f35a-08d6f0b5b392
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3135
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

Changelog v2 -> v3:
* move iio_triggered_buffer_postenable() after the allocation, but before
  `st_sensors_set_axis_enable()` based on comment from
  `Denis Ciocca <denis.ciocca@st.com>`

 drivers/iio/accel/st_accel_buffer.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 7fddc137e91e..802ab7d2d93f 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -46,17 +46,19 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 		goto allocate_memory_error;
 	}
 
-	err = st_sensors_set_axis_enable(indio_dev,
-					(u8)indio_dev->active_scan_mask[0]);
+	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
 		goto st_accel_buffer_postenable_error;
 
-	err = iio_triggered_buffer_postenable(indio_dev);
+	err = st_sensors_set_axis_enable(indio_dev,
+					(u8)indio_dev->active_scan_mask[0]);
 	if (err < 0)
-		goto st_accel_buffer_postenable_error;
+		goto st_sensors_set_axis_enable_error;
 
 	return err;
 
+st_sensors_set_axis_enable_error:
+	iio_triggered_buffer_predisable(indio_dev);
 st_accel_buffer_postenable_error:
 	kfree(adata->buffer_data);
 allocate_memory_error:
@@ -65,20 +67,22 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 
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

