Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4291449D8F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 22:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbhKHVIO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 16:08:14 -0500
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:50816
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239710AbhKHVIO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Nov 2021 16:08:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIW0PhDSB0MGwn9XjZodaWnXUxgzwgRZzxqTqaSM7qUrBS3sRdFk2Spbti7GnqCNEXtj3CIRokLIoNulqtibBgdogvnCNpMK7XTq+LZdiTQxDDtfhq0jadLhgMGTk7BjWI49mknPOJUnIIj1qTlvMoYzTvHWCMWXAfSde8mCPRfC6WoSJ2ZyirZo6scbybgKxI6BDQzFpsdMGUlFNCMeSa3abJIpvtCfIVFb/ghzSOzPHatF28saGlCwnzfOITMyuXXRqHQpjeq+wa8PmO662XY296y3X+uPq1nYSG5aKiVL/sDRKKvgPiwvNfhQWOCuO3BRzpmf/2E+lyOspxVy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/kej1JFY9mm9J/x45hBoTL7+BVmh9im8bcGlEVvaOA=;
 b=Sr0nK4RMbk1XK3UD6Lftf6qCDpQYKhkWZqrIdgB+Je8Sa/d3kThd4m+3LAYuwp9Y/1kmn4VhocVU/j9rOZYPu/LRE8uBpeI9+we3r9g7SrkkP00haiDbMlSGviybFD7SPOU4eqne5WaT9fyIvKkaPsY4d2PpE4ZCUuhCzqx7bfQoDX6WKLOO1R+Ru7I82f3JVWR6bdqRzB0U+RWNKq5mOarM6TW6MZ8n+jV1cXfvn7sHHHWNAnvjW2we8MGjF97d351IOqzc/ItFbrZ8jxRZ+ZnrSThpeFxi1XkeRpJufCB9/lQUnxdj6QVfK6m93wuqrjDnsKzdT1Rfv0R6slA7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/kej1JFY9mm9J/x45hBoTL7+BVmh9im8bcGlEVvaOA=;
 b=rzghtQSAuV/CF45rVtli5bhSK/w0wK3DY6ZSy6AbESgLcXUCQcGZdrFQEjo4DGzLqHcpakUQK4Je4nYX69kg1GBMxtUbh672YEQ5aCDtk38lLT3ytWzat45cmYyNkVP/wjNcVdtE+Rl0rjoaUZwoWWpck1ej+brTqQGRcRMQaOY=
Received: from DM5PR19CA0039.namprd19.prod.outlook.com (2603:10b6:3:9a::25) by
 SJ0PR02MB8766.namprd02.prod.outlook.com (2603:10b6:a03:3d8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Mon, 8 Nov 2021 21:05:27 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::8) by DM5PR19CA0039.outlook.office365.com
 (2603:10b6:3:9a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Mon, 8 Nov 2021 21:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 21:05:27 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 8 Nov 2021 21:05:24 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 8 Nov 2021 21:05:24 +0000
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
        id 1mkBpO-0008LJ-Br; Mon, 08 Nov 2021 21:05:18 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v8 0/4] Add Xilinx AMS Driver
Date:   Mon, 8 Nov 2021 21:05:05 +0000
Message-ID: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1db5413e-63a4-4889-a0e5-08d9a2fb7d55
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8766:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB8766E29271FC6ACD038673E1A9919@SJ0PR02MB8766.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJte3jXOIXxfGWQo2nNWv9/e3U+XL1pDosqiS0NZm1hzlqbxO8bEy7T9myYvuGlZBOMg2D+sIW8dYdJGDNM3vaob+yqS284MHKi0OPdM0fi+MUv8l0OKeahbOYI+Tc2XRVmkEpcc2z8xhJSW4z9AS9uUO0UcnRV6sOlnl2yAI00CUzHamyFXxZIsVtjwXJzlic3aNR6VNSOTdNG32Y6voejiFkB/Jw0bpWxizjbtUAbrPpOh1eRExU7MNTXuPMe09yW6ftfR97Pwi43dqCa5W63S8B2TBn6SYynecEWpCKRObKrGd73V5m4vA5kJPLsMhARwwcQQ9sCDkEjqnL0oRVj21K87LCnvIKNor+wYw5iq+IQCcy28xgXIDGXA73gbLsApM8u76+n7EnFp+PHnIDEm7QXfD/DC/X9lNNgM+Cq1d05VQ178IASWPtz1hII1+Ghng1MwpDz9jbc/PUZb0pKeQPw+UjNVQOh5U0SadpVXOYLaQoW6EpZqY8E0O/czoR2K/thKLfu+ex9nkZMT1nFfpEKaQ4PcRT7BJ5RMjlPsZHELFN2ipDpPkscxShHM2oIA1ngRHk/es65sa5PI8Nro1uYSILPpiM+MObByECkOe8ujOfM/d+kniDT+OmLd4CE8rRy4kVnqtjEnBzGQLZIoZq3c7u6J69M1UrB17oPQj2yHNv/fqbhDmNQpqC+yS0wkMzofTMSZTd47VEopPEcN9WUF8mTgSezL9c3XECaOcC/DyMLvojqTadh99ILN
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(83380400001)(7696005)(336012)(508600001)(82310400003)(8676002)(426003)(4326008)(2616005)(7636003)(70206006)(26005)(356005)(36860700001)(186003)(6666004)(36756003)(70586007)(5660300002)(2906002)(36906005)(103116003)(8936002)(9786002)(110136005)(107886003)(47076005)(1076003)(316002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 21:05:27.0611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db5413e-63a4-4889-a0e5-08d9a2fb7d55
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8766
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
This AMS driver is used to report various interface voltages and temperatures
across the system.
This driver will be used by iio-hwmon to repport voltages and temperatures
across the system by using various channel interfaces.
This driver handles AMS module including PS-Sysmon & PL-Sysmon. The binding
documentation is added for understanding of AMS, PS, PL Sysmon Channels.

Changes in v2:
	- Added documentation for sysfs (Patch-2)
	- Addressed code style review comments
	- Patch-2 (Now it is Patch-3)
		- Arranged the includes in alphabetical order
		- Removed the wrapper 'ams_pl_write_reg()' and used writel
		  instead
		- Removed the unnecessary delay of 1ms and used polling of EOC
		  instead
		- Removed spin_lock and used mutex only.
		- Used request_irq() instead of devm_request_irq() and handled
		  respective error conditions
		- Moved contents of xilinx-ams.h to inline with xilinx-ams.c
	- Patch-1
		- Addressed Documentation style comments

Changes in v3:
	- Updated bindings document with the suggested modification in v2 review
	- Removed documentation for sysfs
	- Removed extended names for channels in the Xilinx AMS driver
	- Modified dts to use ranges for child nodes
	- Reduced address and size cells to 32-bit instead of 64-bit

Changes in v4:
	- Updated bindings document with the suggested modification in v3 review
	- Changed the Device Tree property 'ranges' for child nodes
	- Used Channel Numbers as 'reg' value in DT to avoid confusion
	- Removed unused NULL arguments as suggested in v3 patch review
	- Addressed comments on Device Tree property naming

Changes in v5:
	- Updated bindings document to the YAML format
	- Updated bindings document with the suggested modification in v4 review
	- Renamed iio_pl_info struct to iio_ams_info in Xilinx AMS driver
	- Updated the Xilinx AMS driver to not use iio_priv_to_dev function
	- Updated Xilinx AMS node to reflect the changes in bindings document
	- Update MAINTAINERS file

Changes in v6:
	- Removed all tabs from bindings document.
	- Removed the xlnx,ext-channels node from the device tree since
	  it is not neeeded.
	- Fixed unit addresses for ps-ams and pl-ams.
	- Removed the names property from bindings.
	- Fixed warnings from checkpatch.pl in the driver.
	- devm_add_action_or_reset() used for exit/error path.
	- devm_request_irq() for managed irq request instead of
	  request_irq()

Changes in v7:
	- Added use of FIELD_PREP and FIELD_GET.
	- Added the spinlocks back the v1 which were removed in v2 for
	  no justifiable reason and replaced with the same mutex. This
	  caused deadlocks.
	- Removed the buffered mode information from channel config.
	- Usage of wrapper functions for devm_add_action_or_reset
	  callbacks to avoid typecasting functions.
	- Usage of devm_platform_iremap_resource().
	- Handled platform_get_irq() return values.
	- Removed the remove() callback.
	- Fixed the dt-bindings.

Changes in v8:
	- Replaced *_of_() APIs with fwnode
	- Added missing headers.
	- Fixed documentation.
	- Added devm_add_action_or_reset() for iounmap.
	- Restructured read_raw function.
	- Added helper functions.
	- Usage of GENMASK for all masks.
	- Added defaults for most switch cases. Some can't be added
	  since the default will never occur.


Anand Ashok Dumbre (4):
  arm64: zynqmp: DT: Add Xilinx AMS node
  iio: adc: Add Xilinx AMS driver
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  MAINTAINERS: Add maintainer for xilinx-ams

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  227 +++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   26 +-
 drivers/iio/adc/Kconfig                       |   15 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/xilinx-ams.c                  | 1452 +++++++++++++++++
 6 files changed, 1727 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.17.1

