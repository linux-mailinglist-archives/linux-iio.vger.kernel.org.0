Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764A8176A0
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 13:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfEHLTu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 07:19:50 -0400
Received: from mail-eopbgr770082.outbound.protection.outlook.com ([40.107.77.82]:39494
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfEHLTu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 May 2019 07:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHpMFIYfp33T4yjqGwUYX04XSxeEs1fQxYo0IECcn6U=;
 b=LO8k/fW1ANcSwRP0j0ubwP564tLQ5YLtyBsJuTF3c6wqdVRWviCt92D7r9cJNB2Y7T5r7MuVWaEdaQ0wE93FYADwTjraNoZ1YHh7ZZmiNaVSgoa3VJuh5dlC8gG4gAHW7XFmf9a//diWL/MsOSLjP78SdpFknnSLEJOp7YiOJi4=
Received: from MWHPR03CA0048.namprd03.prod.outlook.com (2603:10b6:301:3b::37)
 by MWHPR03MB3134.namprd03.prod.outlook.com (2603:10b6:301:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.11; Wed, 8 May
 2019 11:19:46 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR03CA0048.outlook.office365.com
 (2603:10b6:301:3b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.11 via Frontend
 Transport; Wed, 8 May 2019 11:19:45 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 8 May 2019 11:19:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x48BJjmk020815
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 8 May 2019 04:19:45 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 8 May 2019
 07:19:44 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <andriy.shevchenko@linux.intel.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3][V3] lib: fix __sysfs_match_string() helper when n != -1
Date:   Wed, 8 May 2019 14:19:11 +0300
Message-ID: <20190508111913.7276-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(2980300002)(54534003)(199004)(189003)(476003)(126002)(44832011)(2616005)(486006)(53416004)(478600001)(426003)(336012)(5660300002)(186003)(26005)(1076003)(77096007)(356004)(50466002)(305945005)(7636002)(6666004)(48376002)(2906002)(50226002)(47776003)(246002)(36756003)(8676002)(8936002)(14444005)(107886003)(16586007)(110136005)(316002)(2201001)(7696005)(4326008)(54906003)(106002)(70586007)(51416003)(86362001)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3134;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b38afcb6-23aa-410b-5035-08d6d3a71355
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:MWHPR03MB3134;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3134:
X-Microsoft-Antispam-PRVS: <MWHPR03MB31348943C264053443739408F9320@MWHPR03MB3134.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0031A0FFAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: nzWa3xrxyHB1zEKTca8pGFwuk9fAlJRcfn+T8uniTYcp73YLJz+d7l4cT88khCBXiRqJ4cqZv20CjAKAVx4mH4Pivql+u4/COf0Wqr2umYp/XWJmlIECPpX38lFrtz+zKidzkkXUpS+IY8Cq2FxisVUg0ToNzluXGjuSWNzR2d6w0JDfk+5+BR2D7XKm2nJUHDjqxWagTzlmp+tniIb0g4oYkrPTgLvTQmnbc4wv1h1Wp95o58D8w0G4SLJucyUnh/k8yMmtPuTVLx007uTPLxVp63rd4r6Qr/dlBVX8wvJQy9j9n8DI+k3Kzo/EsuNqMpMnoxAgKhSX73gBunmNXp7Enprp0I9ZqDmrz/h0/e6w1VOB+zD3UKMZiiDvaEeCZmIfmfWoXp/cCPdr9gYK8WuF0Eo4Kl0sSm0AQsGXcT4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2019 11:19:45.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38afcb6-23aa-410b-5035-08d6d3a71355
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3134
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The documentation the `__sysfs_match_string()` helper mentions that `n`
(the size of the given array) should be:
 * @n: number of strings in the array or -1 for NULL terminated arrays

The behavior of the function is different, in the sense that it exits on
the first NULL element in the array.

This patch changes the behavior, to exit the loop when a NULL element is
found, and the size of the array is provided as -1.

All current users of __sysfs_match_string() & sysfs_match_string() provide
contiguous arrays of strings, so this behavior change doesn't influence
anything (at this point in time).

This behavior change allows for an array of strings to have NULL elements
within the array, which will be ignored. This is particularly useful when
creating mapping of strings and integers (as bitfields or other HW
description).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v2 -> v3:
* fix __sysfs_match_string() vs adding a new
  __sysfs_match_string_with_gaps() helper

 lib/string.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 3ab861c1a857..5bea3f98478a 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -674,8 +674,11 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *str)
 
 	for (index = 0; index < n; index++) {
 		item = array[index];
-		if (!item)
+		if (!item) {
+			if (n != (size_t)-1)
+				continue;
 			break;
+		}
 		if (sysfs_streq(item, str))
 			return index;
 	}
-- 
2.17.1

