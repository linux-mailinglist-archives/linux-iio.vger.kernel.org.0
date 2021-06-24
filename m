Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C03B35B4
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 20:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhFXScO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 14:32:14 -0400
Received: from mail-dm6nam08on2078.outbound.protection.outlook.com ([40.107.102.78]:26305
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232576AbhFXScN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 24 Jun 2021 14:32:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiG2vQ5uSAl7sPZgMbXpjBymRR/cBrdYZvRAKzhtF7IeuQNwrcSqY41bKSgjZ4JWHqZq0lzllT5xoAi2NS5+4XnCh+xQ+6472NYQjbG8dredvxGG7WBPh2SJWbHa4ncp36Y5/f6DYchwC0sNfG9g/CafRA0G3597q5nTG58BlxeuvQyi9WbLZ51CAood4D+0J/qbaJ5wY2Yp7b5PIGPBBkhumQZpM4Fdy994v+z3LSJG+AQpOHqqyYhjpZSQ5MGxrl9FvoawJkrRO4bfyaySaKOjDn+eQ0tkZz+Z0t+vrysNRVeBv/CDCl4oZCWsQSH2WSPOwVoDAPWW7WxV3IVldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6514ixAazrHT+SSXs5QOr6+14d2fcaFtY+hGhYKjDo=;
 b=m0sRJU3/HCtLGbAFL+8Ggt5Cflm/vJRrbjcny1ebKHUNchbMjFVv271KfZuGZnFik3hkJW9oYcY848MxSZDuLNBWS/yNeAOhseO8IMEHZNctC8DYTQp5fGgN9U13m7U3uZGJHvMYCxFIdX3oOZazTyM9vjwSgLif/i+xRZVNGN6Y71AayFESfh56ztXPtNYawyM0XatzO0lAGtrXQkfq/IRfOuzJLiMZbjIK/uyGnosVDXoNMprEkGgXMx/VnpvJ79S3aW/Oi4kFc4gHj14/IisXGqc+cVxa97LcnhqOD7nZX+3Y70tMoK/d23l9Q6vWmoYfBupr10VafMBKlMndfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6514ixAazrHT+SSXs5QOr6+14d2fcaFtY+hGhYKjDo=;
 b=irNjw5vyDbh1CvV9+iefQc0gXFTuicXc60ieIVtqes6ztZHLE5P/2Cv17m5SaeIoNhAuJegc9J1P8drh/y86ptMs/MHlcOBibuV3zw3nWZlSCRYKH+yiVqArTN1Jhu8a84UlSN5d4WiZwKhiu5gkXf+E6vKkt7XVxefzjQq7L/Q=
Received: from BN0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:408:ec::13)
 by BY5PR02MB6932.namprd02.prod.outlook.com (2603:10b6:a03:23a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 18:29:49 +0000
Received: from BN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::3e) by BN0PR04CA0098.outlook.office365.com
 (2603:10b6:408:ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend
 Transport; Thu, 24 Jun 2021 18:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT019.mail.protection.outlook.com (10.13.3.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 18:29:49 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 19:29:48 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 24 Jun 2021 19:29:47 +0100
Envelope-to: git-dev@xilinx.com,
 anand.ashok.dumbre@xilinx.com,
 michal.simek@xilinx.com,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.71.188.1] (port=43962 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1lwU6e-0004j4-JL; Thu, 24 Jun 2021 19:29:40 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <git-dev@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v6 4/4] MAINTAINERS: Add maintainer for xilinx-ams
Date:   Thu, 24 Jun 2021 19:29:39 +0100
Message-ID: <20210624182939.12881-5-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
References: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcbee86e-0bea-40b1-854a-08d9373e0ce4
X-MS-TrafficTypeDiagnostic: BY5PR02MB6932:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6932B3A3CE0C7C48B5C812D3A9079@BY5PR02MB6932.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VA5M+63OPceOPDPkel5TM5QCZK/8EOUMI79OHbI0MqbFOOqsLFdH01FwvdRxhDq8zXX9hJLHk43iYSELjZvmdss5tzOzUIFsVd0DnIqDdqd/8mdTJPvZm0XM6WrIKphqiCdWh0+/oN4vXtMZfUuoZ2XF0DNb8GlQZvq3lhovf1D8idWSBnuEDsTaLs7+UrbAf9wCLzFsrYlluDgC50LPZYoZQVnoCltYy30c2bF4GKfH++k/sAsh5yuhbvam8rN4wfO2kY1FSu9y3w2YSpagSO2lRDfu+LCMsJJ5g1+wFtUPg/4Wu7r2LjZNElVcR7ZZCwUoFwC+5Cyo71GHFk+kNUBbiGHi3Y8epA1XsCrH7Qm6u+EUtvt/3N2lGWpfDGlGGyC+jFY2TWIxtwrjS66/iRZnuW1DTTm5oFUzDtnpSq28CDs8RNAarRk6XAmz4pkYW3X3R3i5gC4Tm09pHw/YOiOIiY+XsBYPHFpq0Sfy9ADzo7LXdkqvgv5Ao+KHBeWAOVAxjTBQWKGRkYLOGEH+BUj1yttgFDgeEtzIBDL6y98l8KfkuAnhmPvGaLXuipAGPImF6rZNyVGIR8d6BHlUuIRvsyTq46RNTwpAy4VHffPKC7i3H6h6McwlLcpmo67MtUH5MFfbMpYrT3v+FPLce3ssS48H8mooluz87PhKgJA8m2Zb/1jzvIEI4bsg8mP4lLilZWMXd9kgkZyhY1t/1A==
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70206006)(356005)(186003)(36906005)(70586007)(7636003)(4744005)(8676002)(26005)(7696005)(110136005)(8936002)(103116003)(47076005)(4326008)(2616005)(2906002)(498600001)(82310400003)(426003)(36860700001)(107886003)(1076003)(36756003)(336012)(5660300002)(9786002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 18:29:49.1759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbee86e-0bea-40b1-854a-08d9373e0ce4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6932
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add maintaner entry for xilinx-ams driver.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..2ebb51d828fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20017,6 +20017,13 @@ M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
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

