Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCEE453557
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 16:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhKPPNA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 10:13:00 -0500
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:5249
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238046AbhKPPL6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 10:11:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/S4ZmatuWe6kxFAAIYi7F4NHF1guwFf7at/vIcMSZlzV4eIpgsvrSeY8o+9HG8cc2Z7/+ijrq/8pJBBx0JGWNYpPRrZE1uLTAN3/j5hMRrT+4dIl3B0uWj8E9J0V+fvUysVfTIXON5/Nk6gzYUoNa+ONfk9P8xHHYCcSKXDTbS7TkjIck5fTN4ci1q2OrdSAv4t9pjP2NqUGekLxBJhskCTSej9vTmt2SrQDyhj5rNP6bMpFNAkH9VRvt8017j8rDCm5yFL/VMZU1zlyIZZXvmx4kNNS8pMK3sCL1L08zFme1KUxHFB2mXiCEV2Mj5YgXrW2EYOVrNenvicMStkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtYt8ih8MfTMnqeVgSaFp7dcfPwk7yHF3/fwvptTPp8=;
 b=DPIMndXX3/dxeYY+0gz08Q62R/JY7MUAVt/rwIQ6H0Lf1s52C5IWA2JeBGV6NOYEDe5UMEbTcFUZXj61C1iOhQm2EwwZqfYK0fpAcf01ReC/Xr8Qm2kinla0cV178DdTCyRFSNiS8UGF9FvuhHY853cRy1EirhitzgNEwEYA6ADIWO3mRtC2nqfj1f9RR4SF36zJVJGdOmc6sVqsqRT4SyKe4p1T8SOtRUGZDIM+xQqJUEUZyAxKpSk8Qn1uR8qn8LfwT/AGHNK0oGQCoVnqC+HFIZBmcw6jC2RGhdiHzH4ELZoribxUAFBbW4HNLLeWd7YNQJ2bC0YJrwWpyzi2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtYt8ih8MfTMnqeVgSaFp7dcfPwk7yHF3/fwvptTPp8=;
 b=J6+1Rba0BlsQty9N6Ld9QvilSWNaMolD8a4AjDDXHGujJ/UhB8FkTK3j8u5zMjOh0rO+6SuwznWh9n/CYTr1cLU4W5XSx+KK+LeaL5uWq+WV4LQn3W9U3TYCZNxjTrrulfSxHg8kOw+3BWBFm7FgEM4YRarMKls04leXHtBg6zU=
Received: from BN9PR03CA0949.namprd03.prod.outlook.com (2603:10b6:408:108::24)
 by PH0PR02MB8761.namprd02.prod.outlook.com (2603:10b6:510:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 15:08:58 +0000
Received: from BN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::cb) by BN9PR03CA0949.outlook.office365.com
 (2603:10b6:408:108::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Tue, 16 Nov 2021 15:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT060.mail.protection.outlook.com (10.13.3.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 15:08:57 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 15:08:50 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 15:08:50 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michal.simek@xilinx.com,
 manish.narani@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-acpi@vger.kernel.org,
 andriy.shevchenko@linux.intel.com,
 heikki.krogerus@linux.intel.com
Received: from [10.71.188.1] (port=4502 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mn04i-0008P4-0i; Tue, 16 Nov 2021 15:08:44 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v9 2/5] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Tue, 16 Nov 2021 15:08:39 +0000
Message-ID: <20211116150842.1051-3-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ce6f3d2-708f-44f6-de9c-08d9a91303b4
X-MS-TrafficTypeDiagnostic: PH0PR02MB8761:
X-Microsoft-Antispam-PRVS: <PH0PR02MB8761447E1148CCE60149E01DA9999@PH0PR02MB8761.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4aZPCxrvYmtgYL5hz/YMfzqYNANna3RPV5A4nmFD7Uvcg7JOZxvBng04mIJPCkuYXkWcDbFOMwUrSPdJoJi4fd5vQadlzw9S2ZKHpafTc5tBuDPt8z4dOBsLA1PZq3B9cDoJ9TbHuRykd/cBUGu563onduyBOilPHfHk6fI3PbpWT1wRP+iJJK6Q7JkKxohavfQ8Y8xJLv4s3v1fjWuiNrCCG44l1+m9eAGvNELqFWJyWyztUjNHbhj2S9Qv4QAl5mJeEGWvB0xtsZEewjMr7qOs1veD+9Orjy8+TvUqCo6dYWvpSm4J8vFWtb80JU9oQ5/it1PGD0eSBTl0uQs/8KN9/w4NQFrtqHPhb1lh71U3cYSs5uucEHH8fs8/bluJCmmkWyzFbm1G9QvcODBhzzzzLP0gmaTZOilrgsS0AU0Sb7vcAfzOFO7IhGcBPo6+0tnQ5u5mIBRHhfEgOQHwQoR4CC9pA1Pf8sTWu/YowQ8oVxJvzV8IQFyJg+D+LIPnAmmvSD7Jt9xqdrtyN3NuSRVv5lTxk8ZvxesMs7XMPHFhrfpwjPaBsVBK1i1vde1ZrHRUUyzthVb8Tn//bVyK3g3JGBjhMuHQaE2uW46MTCEJiUvM7SlzVHbKASym32tCX4aGTBn3ikz8AgsiKZqS8b4kJYWazfySQh6X/ZBJ4llmXF3fJXmM1kw76ywfYjJuUR1okwfPuq64Xhigyq4InZFs5p0VxvSTXRFLq6dQ+srTZsEKirld3jczZ2r4NTgez/3UgwXIwtUjZF7Qs9NKGydWjDxhDnCgngLgOZbbxU=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(508600001)(6666004)(921005)(186003)(110136005)(7636003)(2616005)(426003)(47076005)(316002)(9786002)(103116003)(36906005)(5660300002)(336012)(2906002)(7696005)(8676002)(36756003)(36860700001)(82310400003)(8936002)(356005)(1076003)(107886003)(54906003)(26005)(4326008)(83380400001)(70586007)(70206006)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 15:08:57.9594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce6f3d2-708f-44f6-de9c-08d9a91303b4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8761
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Co-developed-by: Manish Narani <manish.narani@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 28dccb891a53..b12e0cd0adfd 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * dts file for Xilinx ZynqMP
  *
@@ -849,6 +849,30 @@
 			timeout-sec = <10>;
 		};
 
+		xilinx_ams: ams@ffa50000 {
+			compatible = "xlnx,zynqmp-ams";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 56 4>;
+			reg = <0x0 0xffa50000 0x0 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#io-channel-cells = <1>;
+			ranges = <0 0 0xffa50800 0x800>;
+
+			ams_ps: ams-ps@0 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+
+			ams_pl: ams-pl@400 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0x400 0x400>;
+			};
+		};
+
 		zynqmp_dpdma: dma-controller@fd4c0000 {
 			compatible = "xlnx,zynqmp-dpdma";
 			status = "disabled";
-- 
2.17.1

