Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE72D176A4
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfEHLTw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 07:19:52 -0400
Received: from mail-eopbgr750078.outbound.protection.outlook.com ([40.107.75.78]:14252
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbfEHLTv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 May 2019 07:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olDzzuypgQcrx2LT2HXtL+wN6aHOlC70Oa+Knk6YDdY=;
 b=AHwuNWgDmdKDE5Y9jwhSyHPdIoSLkpjXlJevIcs6e4kQrvxjv/54koBLnSseP1KUoApYFCGXmL5P3wo94BkylhJxoCZl0CaPd4sl8HuuEUObQqjjqMBUDa/2N/MOYo1FYVuMdg6Kq9btdixHhPi7UoZ4o9Ubblm0HZkjwn9n9us=
Received: from CY4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:903:33::24)
 by MWHPR03MB3133.namprd03.prod.outlook.com (2603:10b6:301:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.11; Wed, 8 May
 2019 11:19:48 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by CY4PR03CA0014.outlook.office365.com
 (2603:10b6:903:33::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Wed, 8 May 2019 11:19:48 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 8 May 2019 11:19:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x48BJl3Y020832
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 8 May 2019 04:19:47 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 8 May 2019
 07:19:47 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <andriy.shevchenko@linux.intel.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3][V3] scsi: sd: remove sysfs_match_string() dense array comment
Date:   Wed, 8 May 2019 14:19:12 +0300
Message-ID: <20190508111913.7276-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508111913.7276-1-alexandru.ardelean@analog.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(199004)(54534003)(189003)(4744005)(47776003)(4326008)(51416003)(6666004)(356004)(305945005)(77096007)(2616005)(26005)(8936002)(186003)(2201001)(7636002)(44832011)(126002)(476003)(486006)(2906002)(107886003)(8676002)(48376002)(5660300002)(86362001)(50466002)(70206006)(70586007)(426003)(16586007)(50226002)(7696005)(316002)(1076003)(76176011)(246002)(478600001)(36756003)(54906003)(446003)(53416004)(11346002)(106002)(110136005)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3133;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69215c09-c241-4e00-106a-08d6d3a714bc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:MWHPR03MB3133;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3133:
X-Microsoft-Antispam-PRVS: <MWHPR03MB3133CB70347068AA51310516F9320@MWHPR03MB3133.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-Forefront-PRVS: 0031A0FFAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qx3sYVB0+bZLOrjZnhAu3bBksIZLgBvLT/eSIbjknw2/EOJfOLw2qIOStJGaDAYlignJYYqeqjINWKnAcxBeRN7dfYb1BoMpgT2QLheBKaYgZGTjhZ4BRfQnLa7geLDp11k86JTbTbGI2zxpmw9l8E2Z9EGIuN9Y5F9pWRN00o7H/UOyUN8+/UshEUUC91nlfvnioHKnOW+cExpA28PZyrrnZNc6S8WdjA5pK9c4MDHFWIJZWnc/5HmVKII+inl1mMIdn8jj5xZvtrisJFAdZGsz4jTxAQ4643xTCHtFJUM4vqWiSssDW2jlsrbpyqXGPX4EVyHTRyjYTBTC3ryNCChq18tQPLoJez3+2XB6iEVJpF9CqO9NwuL5RBKzKogO5nhglZcfBe52E8OwVxPHBi5i3aPyjruPNlmxhMYd1IY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2019 11:19:47.9421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69215c09-c241-4e00-106a-08d6d3a714bc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3133
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The comment is no longer valid, since it supports arrays with gaps now.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v2 -> v3:
* after fixing __sysfs_match_string() this comment is no longer valid

 drivers/scsi/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2b2bc4b49d78..73ce390956c1 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -376,7 +376,6 @@ thin_provisioning_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(thin_provisioning);
 
-/* sysfs_match_string() requires dense arrays */
 static const char *lbp_mode[] = {
 	[SD_LBP_FULL]		= "full",
 	[SD_LBP_UNMAP]		= "unmap",
@@ -424,7 +423,6 @@ provisioning_mode_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(provisioning_mode);
 
-/* sysfs_match_string() requires dense arrays */
 static const char *zeroing_mode[] = {
 	[SD_ZERO_WRITE]		= "write",
 	[SD_ZERO_WS]		= "writesame",
-- 
2.17.1

