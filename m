Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C375449D91
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 22:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhKHVIc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 16:08:32 -0500
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:50400
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239759AbhKHVI3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Nov 2021 16:08:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlD38NkBS7gPnRWeND1fd6sYJwR/wLJgDIhi9BGoOPIRJkHtbdz+gYxIOXJlGPTs4M+2ezg7RMbzS/ZD9+kCTZvXO1sKJgnvHzDlRz1JJgPgQMQNeCLmJS4x+t1aLN09wRN75bm4HKhC/iUwT+7DXW49qyn68VHs/Z3VpypReYG8ju4LeVD7QvAE74OLnOVzWGsfPT32zDUTNK/64lU2Xio3NW0+D+2+TTN7bCIC6mj6ZO7m3YjVsvw4GGkMmkBnaKS2/qErCOZ5PFa23Mx4zdxfsAKpEmQVePWR8sEuc/Nj2MG/94FQWWvOujNBsfCJo8GcrqNE9wDA7AV4X5++6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtYt8ih8MfTMnqeVgSaFp7dcfPwk7yHF3/fwvptTPp8=;
 b=kz3wFSuJT7h7Ad0WYrQdNxU0aP9vq4dCcjsW3ZchSCleO8tmmbZI4+YwdPFQ0R23jxLiCPFX7vG8ibw30YhsorsGKfkMh+iy9W/HP26npN02Y/T4toDt/dBEZJv+NwqpNN53G9ayx6IwnZ5bCGPFTGNdL56pHVAvkdpNtQf8ITlD9LF1rYSdMcHsNcd+7OfhYAfef6H13NaXp/Z4nf/8TDHz+3WI7ZC1474KlrgVtCdXw/SOT/8Jvu3qoLNPz7njPSbYyt2Fm5sCmZ+2ZbPqlSyK17qSMXXJ+1nLVGa+sQ4TFE5o2WMVIFOqutMuiv+SdcRjnHKM48Y9Yc8rBllyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtYt8ih8MfTMnqeVgSaFp7dcfPwk7yHF3/fwvptTPp8=;
 b=SxMtjvwAdmdjC849Fr0kSQlig/i9g4NCiWsEUh6GU8jKD+5i9kWZl3w2h2fCvbOGmlxYzU+ivVcEwYHGDdm33fqmewQORmf6zrhm1Md4MdMDDNMW3Zrf4Egtg2rSU684RRKxKzhkM/5E0DFMK6q9hZCtVchdmArbdA8IwiB8QS4=
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by BN8PR02MB5873.namprd02.prod.outlook.com (2603:10b6:408:af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 21:05:39 +0000
Received: from BN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::ce) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 21:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT036.mail.protection.outlook.com (10.13.2.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 21:05:39 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 8 Nov 2021 21:05:37 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 8 Nov 2021 21:05:37 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michal.simek@xilinx.com,
 manish.narani@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org
Received: from [10.71.188.1] (port=52274 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mkBpg-0008LJ-57; Mon, 08 Nov 2021 21:05:36 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v8 1/4] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Mon, 8 Nov 2021 21:05:06 +0000
Message-ID: <20211108210509.29870-2-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846a6469-caf1-4a40-abe7-08d9a2fb84a1
X-MS-TrafficTypeDiagnostic: BN8PR02MB5873:
X-Microsoft-Antispam-PRVS: <BN8PR02MB5873C8D4B72F85FEB9C256C3A9919@BN8PR02MB5873.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8orI4MPbvQ+FWf+4So3uiBMNb5hGhprwMSctSh1AujDEEQqxyn4mAXD5XF0BMDO72XQgICmj4pwy2r/To5qA4TAx0HHAxYYzVRKvBWdMOScFZBo+SODGKQr1wCuzHF2V5H/cnCfLf0WwlB7It+NCjsgaW3k8FjQgRIBqqrQ8Qhzraa97hDnpb6epjG38LVrEZIBf7P3r3vPz6p6XIvOB3WNFpgclsNOnVI4O3cQn+yaZ+A1bnBIquJDSqeR50OxUg8QAjvkKILWB0x7uCLCe4SAMe6jLoH4QdtQPHeltI/qv3TKLBrvbkZPzs7r1qWFYWM+jYYesu6DVgfMxiw6sRgEEcZ+w9Nivq8++7mR61XahNSBoxog+NncueTikLUvMMW9qMPdzD0TIm2AthEwO2EecrChpmpGQfrl+Pbslv4q3f9SFEYnBQwMGQllEhgwf5/2us4E7OJwwZdHf8KwxpA/JrHMb3FJDAuy7MI1Uiw4RBSfcv+UUGU7JSuA0ilup9wmJn3vV7Cmp6a0XBY5n/Mmam1FtZfmQtmuJxD+UXBIBkSU/IYKsMZrUVKZfwntgPHyXKJcd8mHPMW8EkDIS6CuKtqKuu0cx4OJrLNUerLgomwbCcjOXs510Sxud0DtsYQPo905CbeSUpzKxQsgaTZxXY8r+tTTXD9DuD403zIjEAEAM2PygZklceuvJ515ZhvfuZgJ+00I1QoPkYvvG2OQI+AVIElfr1Vih1uZj5lloF5xGRONT+Foo35VFXEb
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(9786002)(8936002)(107886003)(508600001)(36860700001)(1076003)(186003)(8676002)(36756003)(5660300002)(7696005)(26005)(4326008)(47076005)(110136005)(316002)(356005)(36906005)(82310400003)(6666004)(83380400001)(7636003)(70206006)(70586007)(2906002)(2616005)(336012)(54906003)(426003)(103116003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 21:05:39.3635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846a6469-caf1-4a40-abe7-08d9a2fb84a1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5873
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

