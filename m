Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705E7449D99
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 22:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbhKHVIh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 16:08:37 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:8353
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239758AbhKHVIc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Nov 2021 16:08:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F97eEIov8syS+rvb001OD6KWZIVBNbPQji+VyrD67JqCLZBiUMdoTzPrrFdhxG7ngmGvAZnPjf5AWVXeEonxUPqny2N31iRRWEtIAinQAzRL4O1oGdFsSErhVIZgPQhgaZ5iybu7sP/4MxX+xK3NqMmQYY5+Yk+vAZtGSFSmSXmeDCG8e/gfa4UIP8tO0T7yyhSJIQas01BiyOt1ba6zWNY5QTLy8+xPwzWmDbCA8lzsCNYXXpY9vygHpdpYbKvlM0ca7u4UZzErDVlYa0A0lNWeqOK2b72SBdSaY3zp/rbs50/B/BE2CHpRSrkGSgUH0xas5J8X6Q334ZppX1T1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3PUW1DuRbUlyeth8cIQGVD+Ka3aIkAuacFplTu2g0E=;
 b=ZN2GvJ1p7p3jAlSGEy4KyeD5iCD8Rc2DHEdDhEM6cUCFsUIxsCExrmg54ZokfOUhfVDGBsuyhifFmxzBqDpFN9gyxoEqJNnhQcfD5pvuwHc1ggEcvSyHyRccz0+OxiK9PVvMwaoKLq9E8k91Qmo0YsfaIa+XGJn8dVC4DQ5m+drWnzKcRFvA50K0ipJ1R9IxvPsXndXSrSkZeXRr3LtPn0Nj46+gyTMWmLULI6xnlczlp4qp8IXdUWl72p0GGRh9XeBd/TXYBH7v90jGWZyhzgDRAypOmtbBrYEI+NN2CUdlGxZ1evEBbdwidLoCAMz/8Sy4hjt1s819Y/Sxb7x3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3PUW1DuRbUlyeth8cIQGVD+Ka3aIkAuacFplTu2g0E=;
 b=R+GGHHiSyPnsH9wG0VD4V0SHIQMcX0OyGFsczRaikO0x91U1/p1kQ47jPOBs1/wxs7dH9v1GczHZDLruN4SEozCtfZR/soupfLYkrbqgUDR90GA8LuSdKPfC7LRyz9xhPPC2g5Q6nuNMGzwoEPwkRVk/dCEf2S0QSFOjztQmO2A=
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by BYAPR02MB4917.namprd02.prod.outlook.com (2603:10b6:a03:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 21:05:44 +0000
Received: from DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::69) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 21:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT026.mail.protection.outlook.com (10.13.5.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 21:05:44 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 8 Nov 2021 21:05:41 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 8 Nov 2021 21:05:41 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org
Received: from [10.71.188.1] (port=52274 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mkBpl-0008LJ-2x; Mon, 08 Nov 2021 21:05:41 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v8 4/4] MAINTAINERS: Add maintainer for xilinx-ams
Date:   Mon, 8 Nov 2021 21:05:09 +0000
Message-ID: <20211108210509.29870-5-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aa513c1-1dbf-405a-b769-08d9a2fb87c4
X-MS-TrafficTypeDiagnostic: BYAPR02MB4917:
X-Microsoft-Antispam-PRVS: <BYAPR02MB49179F547067D7A01F82EA18A9919@BYAPR02MB4917.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9TRx63/09N+tTVTNgqeF3eG2oBaHfwNdJSL7h0mAq7Z5n510ySXd4AqIX5jKuJvVZ4SH5HfTSxCzKv1Ea06ri8oRkvTd4Y1wFWXX1aBFPqD6pxirliJxPwzuQOt9m7BfdW+mTOmj/YJKtDd1j4SPhpjSL4Iisdf3j8rwBSwTNi+ul4Rtu16hybPB2Zad+n6n0zKgI7DM4DFpIosnlxCPDU+1gjhKu/PIZSwBj2bJUti4yKZIXFYatRGjL35/e3DUXTPDPmxiIjyZA8iDYTSE/4fQjdAhNhyjiKwmVppozJUIQonbQJNVlvkGNRqKUYNS0EmG4RPV/wrYXD/92dJK0AZDo84p3PH8jnYR2dqNrQkWNPzrfonqNANANtV3Vyvu5j+42BXZxBnS/8+cLSdLeKVT36081PNo3lgUgnc7X4Kw54qg8uPv1Bo8MkgXoc58Uv9l5WQKfX4RCLarbpWshZD4rPJ+Q5XG7lJhcGmB00GVAwqyDhI7cqQ8l8f/JJLAHG98RfVZQ9J0EpQmUdUR7AB9BEQ9okOJ7avMbrUcNfUTuhwdfD3auCaMPGQul6FXPbN22rUa0zAzQ9zN34MyPnhlc+HyYsmgN9ng2jc0mAL/fg8XEVwbbpo4FcjPEXqOlC4Zxr300V/706RxWBuSrf8OXCxXoLw1RqdJjAiKMrp7uv92Cx71lAAyMdHRH816+N3BUaBjS+Axx9vOnDrDnpDHM8LVjWwym/zPW0WoKP2MEXEJRNKBFyrBrPRAKOd
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(426003)(4744005)(336012)(1076003)(8676002)(36860700001)(8936002)(26005)(70206006)(186003)(70586007)(82310400003)(107886003)(103116003)(2616005)(6666004)(508600001)(110136005)(36756003)(4326008)(47076005)(36906005)(316002)(356005)(9786002)(2906002)(7696005)(5660300002)(7636003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 21:05:44.5104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa513c1-1dbf-405a-b769-08d9a2fb87c4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4917
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add maintaner entry for xilinx-ams driver.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dcc1819ec84b..30de0ea64ac4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20640,6 +20640,13 @@ M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
 S:	Maintained
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
+XILINX AMS DRIVER
+M:	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+F:	drivers/iio/adc/xilinx-ams.c
+
 XILINX CAN DRIVER
 M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
 R:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
-- 
2.17.1

