Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1F25365F
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHZSOw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 14:14:52 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:41184
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbgHZSOw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Aug 2020 14:14:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPbxvr3SLWPQZrnWepK6/LHPwDlfKTrft3+xEPRvFXCU8BD/WHUo4mtJmN6POpEK3DiNOwePvO6KDQySFY3iPDquLEd7EiLKiutbH8UQdQw2lTaa8Qt9tQLs8dUMPILAf87i9qBUFnjm/pXKxRXmq9xl2/1Hn7tiK+vEfKHehRx80L8n6AVghRsN40rKd3cFxssighWStnsK9OazQjkmWLaEigTGKRNTZPnzSIESljhsJX5SYA5HVIyzqqh5AVLWW6HmtiGeqqdSPlzANtj0nKmEBNkSRdu4bK0EKcH8p7cccAk0Q5soAJmeB4dDO/v0oTCLRCMxbwh1R26qK+t7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVILtDz/JeMcC9222j4m8DBYBN1Z2uVfJ5OOvYUEhfA=;
 b=KKrowVlC+mZI4IdpT3+It8OkZp0JKFf734TE6V8GfcCRXsuTyo+P+p0214yC6cNEadq1o2LwTqWdQXWiSwkWdxPTcoHhRCwHDbT3amZd96KNTUdUjW+llYJfuTBkC5JL1TsnZ6jfgnKntweQ3GXCz2tQbgjAGZSCaH5mivqcRZTtpOvR2OBdc5AdwagiDxPIh7Qw5NWnpXRweL4hh6itBoCrZe/KXlEWsNr4ZWRN0hmCkBsz2cmuOFumENrF0+IplHLggJ07zI4iAifMjCarKLD14MfoyhJsHcfjX6d+pc5DcfUAAa4RTUqA9YdUk1T9GK0lAPa2O8x4juHXNc3Yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVILtDz/JeMcC9222j4m8DBYBN1Z2uVfJ5OOvYUEhfA=;
 b=SaHBFhxshGcV5LsL6hNwCAM2LVULgdW4HT61bQwBE+R2R81crGSFwQdTl7ZkMjl3Zbe5ypwKXUGDqG3roxzzZwHvSEUUaK9EdnCYLTOTPusxQdtwgyS8s23bNzRTZNbLs8/l1CGquPyB2PYatkpW926Zo+erjh7JWrTVne9/fjQ=
Received: from DM6PR11CA0009.namprd11.prod.outlook.com (2603:10b6:5:190::22)
 by DM6PR02MB5436.namprd02.prod.outlook.com (2603:10b6:5:7d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 18:14:47 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::bc) by DM6PR11CA0009.outlook.office365.com
 (2603:10b6:5:190::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 18:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 18:14:46
 +0000
Received: from [149.199.38.66] (port=50203 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1kAzw7-0000G1-Bb; Wed, 26 Aug 2020 11:14:15 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1kAzwc-0000P0-Eb; Wed, 26 Aug 2020 11:14:46 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07QIEgOK028983;
        Wed, 26 Aug 2020 11:14:42 -0700
Received: from [172.19.2.102] (helo=xsjanandash50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1kAzwY-0000OR-L5; Wed, 26 Aug 2020 11:14:42 -0700
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, michal.simek@xilinx.com, git@xilinx.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     anandash@xilinx.com,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v2] iio: core: Fix IIO_VAL_FRACTIONAL calculation for negative values
Date:   Wed, 26 Aug 2020 11:14:36 -0700
Message-Id: <1598465676-28912-1-git-send-email-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ad05ed34-96a7-491d-07ce-08d849ebea29
X-MS-TrafficTypeDiagnostic: DM6PR02MB5436:
X-Microsoft-Antispam-PRVS: <DM6PR02MB543640FAB8EBC3504DA42A3CA9540@DM6PR02MB5436.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InDum2mdLljtHonlv6N+sgGGnXzJ2iIhGSSHzWOPILRY2kQDxR9j4H1scnSJ9flfyFDDE99CFe9xgbEF04S0dsVnyCXvX9stmz8baPhqXkWATTUWKQQH4zOwlwwgwDl0slD4di2epC8uQzgiNHZbX5ZkqBBvWrkFYN5J0HwKB5x3t+3ndAQLeWb84slw7LiguEUATs8NoOVcxHwLTxPOXFHgXkbVm6FlyLqCHAbZUflketch0th+yb1czcN2qizIKIenhuaecdziLjXMloirC2w+14HgKu7OHoDNMG82XanUSgjKmLE/+w8KTG6SDKNxwGD/66iHutlzTiq/QdM4qMFMdDkK65zoslF31w0OJ8QsOgcgva91bMjZBX35d5qKjIl10k5pfYT0FXm4qlWIyQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(46966005)(356005)(36756003)(2616005)(2906002)(6666004)(336012)(82310400002)(426003)(186003)(107886003)(478600001)(81166007)(9786002)(70206006)(83380400001)(8676002)(82740400003)(8936002)(70586007)(4326008)(47076004)(26005)(5660300002)(316002)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 18:14:46.7524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad05ed34-96a7-491d-07ce-08d849ebea29
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5436
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes IIO_VAL_FRACTIONAL for case when the result is negative and
exponent is 0.

example: if the result is -0.75, tmp0 will be 0 and tmp1 = 75
This causes the output to lose sign because of %d in snprintf
which works for tmp0 <= -1.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
changes since v1:
	Changed -%d to -0 to make the fix clearer.
	Removed the email footer.
	Updated the commit description with an example
--
 drivers/iio/industrialio-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index cdcd16f1..a239fa2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -592,6 +592,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 {
 	unsigned long long tmp;
 	int tmp0, tmp1;
+	s64 tmp2;
 	bool scale_db = false;
 
 	switch (type) {
@@ -614,10 +615,13 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 		else
 			return scnprintf(buf, len, "%d.%09u", vals[0], vals[1]);
 	case IIO_VAL_FRACTIONAL:
-		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
+		tmp2 = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp1 = vals[1];
 		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
-		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		if ((tmp2 < 0) && (tmp0 == 0))
+			return snprintf(buf, len, "-0.%09u", abs(tmp1));
+		else
+			return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
-- 
2.7.4

