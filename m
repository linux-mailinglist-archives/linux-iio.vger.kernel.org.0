Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092D3454A9C
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 17:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhKQQNn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 11:13:43 -0500
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:16032
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229841AbhKQQNk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 11:13:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CErHf3PfwO4mj8Uw7rkbKf+OlZ21E+Lb0Vh2YDcup2kNWjS17IqdFnQwLAeLS8n1p1L8xAG/MJQxx3Z8TiiJP2EMItAEs36/bNPqc1TjsjFaw8s4PTiWgIxdlJFvbdZFnmBV9Yqj0h9QShZnmnG5uPwy56JFkgsvnc5OeMS/uRavfU8XQQlKbhf4Jal1QyjILT9DoC70Zx0VjRyUDl0u+aOK8W4jKwIYEWruXCoeJi1azhfMtMXiQgL5KPCxkXOmB9kXOxKCCk7w4xr9k9RhTgQ1SbQvgLvox2RJdQEF7lkki5/7Z4ToEfQPP6y5Z7egOmvzmrVGVOe7ZN0HsZFFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laOcEqm5HDLlDgZL11S5LDkwMtUE8EXWoW7tnsHYRG8=;
 b=YALtl/HdSMMwC6UJGRWKSJ/Cj21ZWL5h6XfVOW9xsxm/Qsvf73tWlK+yEKtH4ZgNLjS1XiNGgb08IVLtqECQUVTBPCkTwZvts/eee64peghoNj5pFCjjyblaxKpu1ESGj+m/8U5Kao3QwGNEwxULV1z0iBUA68lZVIEK19NL8MssZGiykjlUORHFdU6LL9k3kDA/1hGlLeVTEOmohgpfumK4cSedKSLDeZMccTdc00UrGx6w7PPhd0SzMEU+PCg8g4iE7jAM2lA+1LcBIGEl185Q/3VL01zvTsOE9kuV5Kdwg1AXJZb3Orr9jNNqgRZ7RCw2VGNDkKOkacpQU9UaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laOcEqm5HDLlDgZL11S5LDkwMtUE8EXWoW7tnsHYRG8=;
 b=JqaeQwlBKOE+pDyY761G966ECp4NyNRgwNZw3ToFHjxvK0a4nsLQY7tsbvZrB6E0wIq2F3JoddFGpWhf4L4nEcLXpgAg7LfGPTHlmb4QhWxfKPnRZLOD2FQ73iqy+vZVO0JyWnRh/mUTI3aW1PFBNQYMa8IkcokRGhZ+hWngYAk=
Received: from BN9PR03CA0337.namprd03.prod.outlook.com (2603:10b6:408:f6::12)
 by SA2PR02MB7628.namprd02.prod.outlook.com (2603:10b6:806:136::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Wed, 17 Nov
 2021 16:10:40 +0000
Received: from BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::d9) by BN9PR03CA0337.outlook.office365.com
 (2603:10b6:408:f6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Wed, 17 Nov 2021 16:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT045.mail.protection.outlook.com (10.13.2.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 16:10:40 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 17 Nov 2021 16:10:36 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 17 Nov 2021 16:10:36 +0000
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
Received: from [10.71.188.1] (port=38490 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mnNW2-0000gH-2H; Wed, 17 Nov 2021 16:10:30 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v10 2/5] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Wed, 17 Nov 2021 16:10:25 +0000
Message-ID: <20211117161028.11775-3-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0493bcbb-9a8f-4a41-b667-08d9a9e4ccea
X-MS-TrafficTypeDiagnostic: SA2PR02MB7628:
X-Microsoft-Antispam-PRVS: <SA2PR02MB762821733E04DFCDE5F15204A99A9@SA2PR02MB7628.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XjT4FApXuPnwZzSpTk/hsr0VcMo+s331xk/UvS6mEgxMSomWAg0NS8hmE/69OliX5ekhTN7B2sL/DkqUEMhlZf1xUcqZzahuHbOgD0e5aIrWy+q0ahGizjmsOcIfmVTGRUXEZ9w+G7KuYT1WmcHxCd+U4s/05knkTBC3afoiRMPpprkSW4t5xr1had7m9/HLMGXaLuq2ybYYnS/LxVDqsa8eKftUzunyV4L74PSU5HNkpsLRVRjd13yxycqpLftc8ky6tL0qrhwCRalcCnHfKIASo0bDMeQdKEw7OTfwDHcZ2aZPTu0bK0o6A5qlLyF+7IlizzxLb1mEemFg5V9I+gdy2KR1rrK6Mo4bNzbO46Qd27ygT8avcWbSkq3VncZqHyiM2GLr0bmWf74B1AlaBMeJ3S6xpNPYZ1QkhQ/lcDI/AY7Ms28l80wS88JVN0YhwOnNFFsmkLnpBxrh85Vh0G48Luoh/kyiQ6p+Qg0rChZqoun002TF6TdtD9gxD3k9zECfFyM8k9N09WGaEDricel09a1VAp6gobdWW18sLU3x1w2nm3dhUlLJuhSXGRQF88+sOJpD7S11ZV0OpbXgKn+PFEzq3CxZJcyhRZIURIjqsObRVoUcymGbHmKdCI5ceGjHHj+HjCiwFWoYvwFNOFIYGRy0kTptSCFRdafTIXAHWnaW34ihGJHKoiLwJlXSPr2G+3ZNb+GpiFCmUynGnnsXchWzQXGHn6bqHOnhTaOBxIx3reGDM5oyd3f9CCecfKrO6EYozKzl41Ltv6HXMDzbfoneh3jNDBUNjqVwYs=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(7636003)(2906002)(107886003)(7696005)(36860700001)(103116003)(8676002)(83380400001)(356005)(4326008)(47076005)(921005)(26005)(9786002)(82310400003)(2616005)(6666004)(8936002)(508600001)(54906003)(36756003)(70206006)(36906005)(70586007)(186003)(426003)(316002)(1076003)(5660300002)(336012)(110136005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 16:10:40.3528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0493bcbb-9a8f-4a41-b667-08d9a9e4ccea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7628
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

