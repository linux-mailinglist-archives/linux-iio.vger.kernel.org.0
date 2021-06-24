Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56E43B35AE
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhFXScM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 14:32:12 -0400
Received: from mail-sn1anam02on2056.outbound.protection.outlook.com ([40.107.96.56]:21377
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231169AbhFXScL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 24 Jun 2021 14:32:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ9WGOjg3w+IAvSNeF0wtB/NcVz5YTXKcllX6wGR0/M4uoliESJv9fCa8p+qQFiKepK6wPvW/h5rt9ZeFFsSZ+RJ3y80hsSDAx3XaTPj/WyJaWUYCMHwJKkmHhgdUW4Ym1ZxKdc8zkLGI0QIWjj6+IYx4gkSWNtqwkmZaDEKrXo51xt2oDS9OOl1EhOxSEkseo8JkCYhV5wSEWkF4iwnNd6+M7ZNTxnqkAzd0MnFBxCyAoRsMJnqo4xkL1LpW5dHcnsLzTcP1GejP4nNcKK/hrAM4yOp+nSU+rHkxp/wiLKkEUA6uWgHxWoA80l6sD/jI25p6Jj1VIlNNmX/15neNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWHTiFfDbRS0+MP1w8SjZFEQmjgztE9ISAC3lHGVpro=;
 b=fbzKfD+I/hflKiTIDyEwpZuKF439rkzPGgxvXuS177BTKHnfdSc1iNZdEg2tbbPaOdagz4jzpNxvx5a8ux4m9p2Ee0th3SPQ+9S9ZUg5a77Me5tBByCvciS9yyo/ys3ufniYpim0I7rBeeHGTjN9dIggqZnuLfP8CLABhvUukHk+ha02L9o7mtFvlwZ7+0E576UoMVNh6JEG+nODUoaxcUzuss+ghSFeo/h58su87x/b1ocmgGkZWzK+FA5Lt2ss5387pceBg4Vp7fBk1oXrszBgtWVorCa74kMe0uDIZ+zEsNfU/dVipan2IrNuBql7EFnMWTOHHyP8svZ7/MGN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWHTiFfDbRS0+MP1w8SjZFEQmjgztE9ISAC3lHGVpro=;
 b=NbkmYipMzta6cjy4M9pyEr06O/RWDHflj0CuCtQhmwNOJc7Pp9fOURD8Zsf2pvI5uhZeJIqTbrtgyoDsfHQW3sa6p2r0CSjVVgyQ6HbM+7m9lburNUD45SJQtCGdap6zhaB5kUTwNNAPuYlXNxJAmpP8Hh5Hl5oRcJ5PaNbEnEQ=
Received: from BN0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:408:ec::13)
 by CY4PR02MB2470.namprd02.prod.outlook.com (2603:10b6:903:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 18:29:50 +0000
Received: from BN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::3e) by BN0PR04CA0098.outlook.office365.com
 (2603:10b6:408:ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend
 Transport; Thu, 24 Jun 2021 18:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT019.mail.protection.outlook.com (10.13.3.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 18:29:50 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 19:29:48 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 24 Jun 2021 19:29:48 +0100
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
Received: from [10.71.188.1] (port=43962 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1lwU6e-0004j4-F4; Thu, 24 Jun 2021 19:29:40 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <git-dev@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v6 1/4] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Thu, 24 Jun 2021 19:29:36 +0100
Message-ID: <20210624182939.12881-2-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
References: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bf15a7b-337f-4387-3fe0-08d9373e0d65
X-MS-TrafficTypeDiagnostic: CY4PR02MB2470:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2470C4CEDDEEBFF99BA00BD0A9079@CY4PR02MB2470.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crKsDxnz4ET9QPtQCZMAEy3emV+mTFOp6b09nuHJKBHhmD9saDegLmPgFy914MNNNyElM8lK66PQPjW7Lc4tnzLuM5U2cSu55vBiCp86uRZ6ZVGG0Xv3FnVDeDaUtlahQ3g65sMMn+4/zXHW5WilxNVEf1N0aacwTLrKXxJp195VuLIzeJKKojrlSJ1S+VZh23468Q3Fm+3YRRkw46FME+ONdOHwWI2nldWhu27N3UrwH/vswcKhH4y8wJ16gIhRsPbmbWRG33KihZYJu1CG5TNPBJE7unMXGUjJDPg7/me8G2tVyKI+ycqwg9snHi3WzNR0X+5kgHh8X8rbuN+wM8cD9GPWTuY6t/S3gasBnu/kAnopFwq4RDhCWerO6Ok8segQXLXnGtfzI1atqL2qxK4FnOwYPSSvHfw0ICQnrXL5ySG83CCkOuBOQJnUcgPklNqmVMB+OmEG9JKd6Ba8XKlFbeW1X9nvreaqh4aRzePg2N52icI/3nd0GiOIGNHjOaxpItA0UpjjWz2cZ7FfwCvMIz95PYsAjZY4M5J29TehGuObpElxwskZ0tRnGGC8PImWlJzk/aoGh6gwq3JEtJAr+P6/+oA5SY3vr2KmojEYtiOHb3DDh19MgEn8KLgEUkwFrr5EGGnD7C2siYDx/kYy6FpIQWOm3kxwS+CTGo09KU7TqMeJx0rduFUaLXjjFqmc/XVNYCPh+85w64CV3IabPYYGYccrOPaKo6G/r5M8R0eCNXpLy2TQFoy9JHjX
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(9786002)(103116003)(8676002)(498600001)(7636003)(1076003)(82310400003)(36756003)(36860700001)(107886003)(356005)(8936002)(6666004)(83380400001)(47076005)(2906002)(54906003)(26005)(70206006)(70586007)(5660300002)(36906005)(426003)(110136005)(336012)(2616005)(4326008)(186003)(7696005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 18:29:50.0205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf15a7b-337f-4387-3fe0-08d9373e0d65
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2470
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
index 28dccb891a53..cb14fd106fc6 100644
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
+			ams_ps: ams-ps@0,400 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+
+			ams_pl: ams-pl@400,400 {
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

