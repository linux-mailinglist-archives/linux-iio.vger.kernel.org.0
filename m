Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2126339466A
	for <lists+linux-iio@lfdr.de>; Fri, 28 May 2021 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhE1Rbz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 May 2021 13:31:55 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:12833
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229468AbhE1Rbw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 May 2021 13:31:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5znqX/EPiWGLB9ktvFx0dhKHYEhzGVZhiwtKAE+qxeDABxwDEWA4vNFCJfEgR4z/zWU4KARhiranJxaY1/NCnClgtixSKTGInJh8YI6bd9XqYf2OXL6H5bz7QexsCL528WnhROTUufOHF/udp+7E+Lo2vE6ZzbGW+QVSkG5+v4Z2+ZVAXctF9bHTZhacm/w8rMmEE2ryU+o83s5vdAD/fzGYwJOw1vIVM3BG/kX+qEt5n3qNLaoBiVPypj1btklG2e4+Trz/PboSry9OMAmCYPZjdRgkifxCs0x/aUvC7BYZeQ1au7j5I8fWWPYdjce7e62LesQyKOIs5i9Ct//3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iwNruTkQEJJt+s7+5IPE1ZvEyMywyhe5joP4YjD6Vk=;
 b=MxCFgxPsw7Ok+7EqJmAykW2xkUwS9E4EXG0QZAF0gDQrjDxK40CHs4utXA9ZxGbGkvNWp/QD47gsNkb0M+9pqglbl2TAbdLb0hidJeQfcy7CWtxhXmZXqmY8idRBkJiE10kcalOtfq7a7ethEP2zAS6M2QfwZg0KhGl9Qy/RXsfbsJDEIk6FFDXfELxdDddgCkK6X83VjdEW/PHgqToVnxebM1sWxqFCdZJS6rJHBriTa3p8wDEV2lE5apTi/tg60jJzSigqnIWz7YdEJos/ItEkU6salA165bnIpX/3hStS/pxudsQkhOsUSeM2A2yMXJvnZWrV19Vtr2T/E8PGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iwNruTkQEJJt+s7+5IPE1ZvEyMywyhe5joP4YjD6Vk=;
 b=M77OkslkES5xYw5ZCfrglNLn8HXPfJLoD7FQueQpbtWIx4rV4q06ZQoUqWrrncgMpCgoVR2vbUfuoDmvzamNutavBfAg//TliCr0qnJzgvkmkmbhKQVgQJS4Y/OYvO/oc1oKYcE04IO6aZkwa5sJFBD9TrRkhVbyFERRLABkzvE=
Received: from SA0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:806:130::14)
 by SJ0PR02MB7165.namprd02.prod.outlook.com (2603:10b6:a03:298::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 17:30:16 +0000
Received: from SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:130:cafe::e3) by SA0PR13CA0009.outlook.office365.com
 (2603:10b6:806:130::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Fri, 28 May 2021 17:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0014.mail.protection.outlook.com (10.97.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 17:30:15 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 18:30:12 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 28 May 2021 18:30:12 +0100
Envelope-to: git-dev@xilinx.com,
 anand.ashok.dumbre@xilinx.com,
 manish.narani@xilinx.com,
 michal.simek@xilinx.com,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.71.188.1] (port=44054 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1lmgJA-0004hp-BY; Fri, 28 May 2021 18:30:04 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <git-dev@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v5 1/4] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Fri, 28 May 2021 18:29:56 +0100
Message-ID: <20210528172959.15663-2-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com>
References: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4fc77d5-8f3d-4b87-f81f-08d921fe41c8
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7165:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB71652FECAB93C73B25E81A6AA9229@SJ0PR02MB7165.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVyvOu/t6dEj5op1fUxW7s+GaZHFh7Gtux7LsUY/U8a5UORRPbWVucokkSV6aeM/pVJX9IkuC+tOI3UxtSNgQx7mKOaoZCFAQ51bX6zCb2mECS/RNw+y/3155zOGEC4KQxkmtBP1oa1mBJ0KeQHvyFq9EpEK/bo69CApLTYSnCbV1CUJ2Jua+fg/izxl3SZ7m17hhkDY0/BP2puLmxaa0Ns5FoBoNpyaVGTjSsmGFZyGLzlRPZGJFTssfthIy0za7Ps3GJcrEbaW2577Be3MOEfjglsOH6r81jkRkqcxMTIihSbu2Ufp7hqH2apj2GcKqTauhfXM5tgqogvALKqjjxTIWBY1/ZHzPVMVtUGIO0Kx+qIem1k1fPC5cuUt6mf6EW6JRW7/mvjsh7Sq3pvKMSLM8wdal9ErBarLyQ7/7KJewROxVHrzaBbNDAqYmfaqGjS0DBKFSGDDfnroKiBXjxvQ/I152qnWyDflXoR5bWMALuAoJApfiocnuJi19mGQ8zJrWZ5jRhGb53qGz0tlaPDiDyKRcSxD4j4rtRKV3d2YCR+20VGy8wUk3NEcbjHgtvk+/F3eBGILQ0+VWyGEQY//yUFLnaBtVvKIROdyahKtxOhKHhkAIwjQ9C3osZhWkwoB13LDUh2QX4gbjPBttLma9W04wiwO2N0xl8Hi0YWuq+6eYo7KQ+Q2VSu4pLyzp8NBQu3mTQUWt+Sw5efZCw==
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(186003)(1076003)(2616005)(336012)(54906003)(316002)(107886003)(2906002)(426003)(36906005)(4326008)(5660300002)(110136005)(8676002)(7696005)(6666004)(70586007)(70206006)(26005)(103116003)(82740400003)(9786002)(36860700001)(47076005)(36756003)(356005)(8936002)(83380400001)(7636003)(82310400003)(478600001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 17:30:15.6056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fc77d5-8f3d-4b87-f81f-08d921fe41c8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7165
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 28 +++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 28dccb891a53..629b3d555173 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * dts file for Xilinx ZynqMP
  *
@@ -849,6 +849,32 @@
 			timeout-sec = <10>;
 		};
 
+		xilinx_ams: ams@ffa50000 {
+			compatible = "xlnx,zynqmp-ams";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 56 4>;
+			interrupt-names = "ams-irq";
+			reg = <0x0 0xffa50000 0x0 0x800>;
+			reg-names = "ams-base";
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

