Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41022838FE
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgJEPFh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 11:05:37 -0400
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:27872
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbgJEPFg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Oct 2020 11:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blUSgO/VxfRCwg/MOEiDaVqUMqgrw+QmUj18MhDYawLrjMltv3k7X6F3rAXG4vwbIEHM9V5PJFo8GyL6mVBiH5Krc+jTdBUbfRHKkxVBs7JaURLfEnISa/DsVdUCZTEZMxKxMpvkRoZueQ5KJZHQyH95iisEV+fskC+ROPZtW1knyiCk957UFZJHTAyB/c+PQbj7X/2hrUhCOd2VqUOZjFa1r4snkwFe/XYfF3R76pd48EoAsq0O5k0JQLLojHt6hKOY5S53ki40/rJgYFf6W38zQW7AnEfXUdG0a04qMOoNraH0hkW7vY2pWC3ZQknEZ8y64dPd/5k3mL6bnmdmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZTK1CehlUDk5escz2GypxQ5KTFvmsr3a1gBTfU26OY=;
 b=nr1iK6b8RPaBjjH8rmvyleST6If0gbJP4QOxBH55wZid3yoAQpXzTEvN9LuqsROCg/Em7hQtCDnzuF8+zmJMzJHbRu+Gvvxv6/F2949kyBg2EENJcwdIYX7jRHhwFPEW+EyUZ4BFHHcT/iiQjTs59swmXVkr5cjnzGIL0lxN/YTtMsvWPwC+y+4Xtux4TNND5tQdWsbY0dpA9KVrtTozIvMx9uW5PSU4K3rXa9iPKnuE0dlLOOU/QHG/x35Rplf1ZjExFJ2vXgdePURMbzy7nq4aMihISpLHi0FzL8Xkf8FkICiOg/Zu9SI9ViAP+BwiVg8GrRhKyhtxGtHlbKGYpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZTK1CehlUDk5escz2GypxQ5KTFvmsr3a1gBTfU26OY=;
 b=QORPVmiEINP5flaUeS/JC7WDUyySWpJmxf5CBDFa6u4mtMcFIgwVjQ3LLR3HcfpYzTLW9KBAJsce0vilIHytaLQdIMSJiecXGdRTR0ErLeb9Maw7xJ9+PeAkClSrCY42dZpKDH6Ba0xxR18b4c3FQy6o8DpHAmXOylytZGZUSyw=
Received: from SN1PR12CA0055.namprd12.prod.outlook.com (2603:10b6:802:20::26)
 by DM5PR02MB2636.namprd02.prod.outlook.com (2603:10b6:3:43::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Mon, 5 Oct
 2020 15:05:34 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::58) by SN1PR12CA0055.outlook.office365.com
 (2603:10b6:802:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Mon, 5 Oct 2020 15:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Mon, 5 Oct 2020 15:05:33
 +0000
Received: from [149.199.38.66] (port=56212 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1kPS2u-0000wj-6t; Mon, 05 Oct 2020 08:05:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1kPS3R-0006yz-Eh; Mon, 05 Oct 2020 08:05:33 -0700
Received: from [172.19.2.102] (helo=xsjanandash50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1kPS3J-0006wF-1T; Mon, 05 Oct 2020 08:05:25 -0700
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, michal.simek@xilinx.com, git@xilinx.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     anandash@xilinx.com,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [LINUX PATCH v3] iio: core: Fix IIO_VAL_FRACTIONAL calculation for negative values
Date:   Mon,  5 Oct 2020 08:05:16 -0700
Message-Id: <1601910316-24111-1-git-send-email-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d65985b-8337-4837-7c25-08d869401bc6
X-MS-TrafficTypeDiagnostic: DM5PR02MB2636:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2636BD3706F1346AAB22A656A90C0@DM5PR02MB2636.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vAzDsiGfXp/1cBp1dcnN0MNasuf7YfbrPhijlP1UqgRG03JX2+a9y6J0hyXSzbqi+td7E1BU5XU/xbj3D67OEZHCpMRWv23zBJXrsXKXdZ3fDcGcLD3LOh7PohvMyIHYGb+PDXKQKtgrOacaImgRjJpHdOw+3RDERPy1l1Iw17fJaZ8W9ypXE3rrk4aLK+ig+LOWx+jkaUbvkb8bWq0cIs7AMtzEswRp5c8tE5IwQZgo6l58ZxbylwrivhPOAh2tAs8bxxRzLCMyP0oCcHJbaC1t7cx9TJQ4nGXItlRr9Bdprnp1MdVqVomE3mRU5N4C0QISN0TPWrkWy5CYTqDJNZp0OLqCrw+nORjtGAbr3S7QlyI7pLijezEAHd5+//L0omBJLpSRJoI3JfduiCMzA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(136003)(46966005)(82310400003)(26005)(8676002)(2906002)(82740400003)(9786002)(426003)(107886003)(36756003)(4326008)(7696005)(6666004)(336012)(8936002)(47076004)(2616005)(186003)(83380400001)(478600001)(316002)(81166007)(5660300002)(356005)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 15:05:33.7651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d65985b-8337-4837-7c25-08d869401bc6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2636
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes IIO_VAL_FRACTIONAL for case when the result is negative and
exponent is 0.

example: if the result is -0.75, tmp0 will be 0 and tmp1 = 75
This causes the output to lose sign because of %d in snprintf
which works for tmp0 <= -1.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Reported-by: kernel test robot <lkp@intel.com> #error: uninitialized symbol tmp
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---

Changes in v3:
	Fixed a bug caught by kernel test robot and used correct variable

---
 drivers/iio/industrialio-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index cdcd16f1..ffd5176 100644
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
-		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
-		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
+		if ((tmp2 < 0) && (tmp0 == 0))
+			return snprintf(buf, len, "-0.%09u", abs(tmp1));
+		else
+			return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
-- 
2.7.4

