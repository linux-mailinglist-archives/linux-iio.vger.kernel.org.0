Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA84245D095
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 23:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352369AbhKXW57 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 17:57:59 -0500
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:15773
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352323AbhKXW5r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Nov 2021 17:57:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPWhvmZLsuOc3YFgJVyecujAPGEgIqIYaTiNoJXm0YuDm/seQeM6rGxzbfKVJEYP+snt6yzpHuht5cbAyki2vmN3T98hgb8GIyjx46zgc5pjV6EogWflDOUHc8CLHHPLA8CQoj8kx2Qxrhv76fGNLNAai+rgd2a6RtTpBPbbWLOOtEIkg+CzgO/NIdHe2OjmkkIozF55kQ/4Z3FbHYEgpG1sS7KKQZgmifwNokQ8CjH1q+lqScn5+2iGYe3XY9D4XJZ/OdhnhZ+EY5Ch4yKSWVq0eomXazD/+xhyDX+h4tborLyi/MKSJ53TFFgGcfV1DRZP8Lfvb6Ar4j2CPG+jRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laOcEqm5HDLlDgZL11S5LDkwMtUE8EXWoW7tnsHYRG8=;
 b=XcjPL+avgmh3Ml2KVR0B6/HsPSsUi53OrYvBjRClRIIij5qj4Q93viUmqaAX5v5j55SbebUGHVRXd+wESIZPhm9imtXG4WV7Efee5wIc5K9o4QBJ8PtCmP3+nN+9WqDnaG7v4Iv2KkYpFfb9NYqTK+ziJnB38xRBpzQwk8oEOlRVaaIWeq7RdS5gGxbZ5+IS27Gp+EWKvZcXV+xVDsYYG/jEVWGzqV5sL88LjZxC4/UtQQ3dSccJgmPjaTVaZTHm2PUyZjRzVHBuozCVhxcubu8FMbkGgMnb63O7l9GigQYvP8JK/b13IUJd5BXgB7O/NxVGe7YJbJ/HCCa2UQcDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laOcEqm5HDLlDgZL11S5LDkwMtUE8EXWoW7tnsHYRG8=;
 b=ChBodbmRcYb50FZpuQo5dU69/qIYyciG9z6BSmt+i6R5zXL9yKZaeMGoBkpPSEqfPceOS2EFpadrVMZZ/v23htNjnulIujuT2agzzgk25Ff+rsLVp+yIJ8RBLHeodZm8gWHrDTmSrqxaPp+8btmWNzxTrzQ8VnZLrOKw05joK0Q=
Received: from BN8PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:70::44)
 by BL0PR02MB4801.namprd02.prod.outlook.com (2603:10b6:208:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 24 Nov
 2021 22:54:34 +0000
Received: from BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::5f) by BN8PR04CA0031.outlook.office365.com
 (2603:10b6:408:70::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Wed, 24 Nov 2021 22:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT029.mail.protection.outlook.com (10.13.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 22:54:34 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 24 Nov 2021 22:54:28 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 24 Nov 2021 22:54:28 +0000
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
Received: from [10.71.188.1] (port=41256 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mq19f-0003SI-4h; Wed, 24 Nov 2021 22:54:19 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v11 2/5] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Wed, 24 Nov 2021 22:54:04 +0000
Message-ID: <20211124225407.17793-3-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0fb9254-3e1c-49ac-5396-08d9af9d624b
X-MS-TrafficTypeDiagnostic: BL0PR02MB4801:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4801BF3F3EC8E5EE9A35B3EBA9619@BL0PR02MB4801.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeOLhCLx7wykUYXLMiRZhhjtKKvORGDqFMxs0LPhwNIeOx+iJDCr2ZNOCqVsNzjKhxBeJV9Pgz21NNAz/rZZE+A4SLb8dvFG5FAKPyoVHOuCij3Hp5pGKC0jy10TKi1Quf0nIFqwe/VgyCmI/F681XILz+h/xgvg1TtBwV9mfHSrrurzMDwXNpYpJvwT3HDZUnWbWcqo0+6B3LUdU5tUKV/Do2uHgqiqP0aTJNoabOFpXZ9qu27p/C3sO2AIw0D+2J5K7WxdqizMIKDD/+gHsNQX+5cGG/Q3QRo3kHZVfXrP0YbJQDBbz7WQN30cf3YfjzbZ03Ylv4VOWzwL423JLUBcojJai8F8qHuDK90LA9Mk412YFDE5f6B+cB+M1uoXtdSoSLu0owZw/pVjTkT0KnlvOV1S9JuAU+K1lCjFyvHvYnoYwrbBjgWdZM8943a7N5wZpFpWqiWTAeR85Bj83JgcTJSVwuOy7IAKrhOamTf8V0tj+S64U1qVapn/jgkLIWY8G7ZDFLzSWjAt/0+l2s5QUlrQAtth6a4JnM6LvBn1Ued3lnVy+R0qtxUNLXtyxAcfMc5cVthcSBRKzVM1taCiS7iPfeD/r3foZNbGcEQRfVDgxL55R/cJ0TZkRliZN9IlCRL0e6SaICqN5pukCLPGmgMyOa6p6dHvjWpaIPT/lwHvmUMFOZDUBtIb8ytZHIdSaN1xt6/fWr5H0j35F18udgq1a0rsm1lrBSovN6rLL/p8x/EHOpzUiRxkLOmB7ReLoi35ZKZkRRiEdRYwswsMKBbcwqI1fW3Kd6ABqBQ=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(2906002)(186003)(36756003)(26005)(356005)(54906003)(82310400004)(7636003)(7696005)(5660300002)(1076003)(9786002)(508600001)(70206006)(2616005)(107886003)(103116003)(36860700001)(336012)(4326008)(921005)(426003)(110136005)(316002)(83380400001)(6666004)(8676002)(70586007)(47076005)(8936002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 22:54:34.1766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fb9254-3e1c-49ac-5396-08d9af9d624b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4801
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
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 74e66443e4ce..ab96708fe65e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -878,6 +878,30 @@
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

