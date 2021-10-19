Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31A6433A22
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhJSPXT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 11:23:19 -0400
Received: from mail-dm6nam10on2067.outbound.protection.outlook.com ([40.107.93.67]:60129
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233680AbhJSPXR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 11:23:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScziLFpRpmLayx2sjbUb81N+pG6GMP7BXHYvC3xmxgl/3mwFGeWTmVR48X/YIo4Fv2lhlF9h9wzt9gaB7WvCz8SxtP96dWdero1zjeJnfHYTwQROrJW58CWlsiB0vLykH18qg8XOMKjEWJLmVxW8MiMpweniXwe8bmbw9Kzbl8u7RLuKv+Mtz9kPvCHsU2qOnPTdvHktPwCf4LbLkMeOA8D2f9UmdpIh4axfzlbcr1U2gGeABzSlMrHtstdb5GZ/tl5EC/gGEcQhVVXwVzeHaMDuiB09lU9gTl1ldxqYI5xYvgC+T3h5TL+GLivBaupzFlCznpoTXbSIecr7DvkBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7Z8DzZmY2D3UcmQb3fbDIymV3OwBZiczoVAyAfvCGc=;
 b=Abwc1UMQo+iQcuCOSlXJMQ78NeBrfon1gwrZk8gbas8iS/8LRdgPvI9h5PKhiVYGuRESkL4ltu5UFo9EsxRxFTx5/M25YAFcprdFSUGUM0yecp+XakkdBzwgmZc2WVF3Kazk/0Fh9T2pm/Jqe4vnT1mIQdpXYYNnqhuSTdx0Ny2DlGNk3kwkvRiX1E5sS1bf4Xj1cMtWhBjfCM47rf/AHXm9KGVZEXUIPuuUfylpYDeIz489/2m07f3Y45m7K5GPWjYs3qA+EQ+brqldCMnojPhWiEMdxhIvufv0de/t0d1MHCvBx1J2wCuz1ah08vAiDkqP8O+/7NbGdBy5VzrATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7Z8DzZmY2D3UcmQb3fbDIymV3OwBZiczoVAyAfvCGc=;
 b=bsykcHHK1g30TRh76ViGhIUOwAfb3PolSViIL0HcgAbTUDGaeF0OG6VUdxudHb7JSaz3V5rRmcsNusvHNeBPVoD2HaeVfQcOGzIj3xbHLmE+dUCdDZXN1YXx2XpWATEeOA8MoghLKiafjkN+QAMwo/oCCnN2K7zHssUJr6KiH/s=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by DM5PR0201MB3576.namprd02.prod.outlook.com (2603:10b6:4:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 15:21:02 +0000
Received: from DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::d9) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 15:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT058.mail.protection.outlook.com (10.13.5.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 15:21:02 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 16:20:56 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 16:20:56 +0100
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
Received: from [10.71.188.1] (port=8251 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mcqv4-00030B-4o; Tue, 19 Oct 2021 16:20:50 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v7 1/4] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Tue, 19 Oct 2021 16:20:45 +0100
Message-ID: <20211019152048.28983-2-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d1bb89-6042-43ed-0bb6-08d99314101a
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3576:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB357649D5870EC4B6D7D7D64AA9BD9@DM5PR0201MB3576.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ax0DCA0iTJoSG5rinf9fHAi2C0+DCIoX+/GLsmGvlhO76iOcYxpKAadDzbofwx3HryJ80yq+1WNN7DhOTan+ZruNKNg6l6q6Bit58A2v4RK3IdkUa0XsjH9aqJ1ECmaL39Zm428+TwHpFUDCqxKGyaJApW2Vo4/SsyZzaDdmgaCwFh8aWYhRxkOKSpUjeurDmhXjBS3rUaZ1s8WvLangBdXWObWvdA1U5vnzekTwB+fSIRnm1IUnfTQiNOSIGRwjkwSB5Drz5irx7qWh7wUE/pLLgNKIjy3IiMnU7oNWXacgN8RDnQFu4BuOq51gPRL0ASvbAYri3t/AAxOYghC2dbctdce/ajZxdpk++WlpCGJ4RUvwtR4xqzdkMC1diUK6TUCRr+jcJxZo1iwH4AJCEP0Ap3IBlYmUz6BQ5Tut7vCktrgitISIEtCyMTcCp411EKJ7EyiBDeU6qWh/tOn+eVFqUUxAqi0fbPpb8oZyJLds4fOEl+NNveWnod/1qJWA6dEJKSOjjeYKds9wPFg546Wt30/u41/AaybJd+G+wUaLUSwtbyU6OJvtxSJlfrhXfIB63eo4JhKRX7t5I9hxP0+eEFOXr+g3CG8yf8hDtE3IhnDOZN1MploDxJdxmWcfIxJH3vDG55ZvAjP0NXE0t4gJzvefsWKMJj8iEAr7Mnzf9Ne4EjAtWAa2yhHcG4SFOgxipt55ScxqtCvL1JbRDrn4OIP9yg9h6p4P36KMBLFiVJrgtJo1hr3SJQAKLL7U
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(336012)(426003)(103116003)(70586007)(508600001)(4326008)(5660300002)(36756003)(356005)(7696005)(186003)(36906005)(83380400001)(26005)(316002)(70206006)(1076003)(36860700001)(6666004)(54906003)(110136005)(82310400003)(9786002)(7636003)(8936002)(107886003)(47076005)(2616005)(8676002)(2906002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:21:02.6158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d1bb89-6042-43ed-0bb6-08d99314101a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3576
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

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

