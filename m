Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93990454A9E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 17:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhKQQNo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 11:13:44 -0500
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:4192
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232000AbhKQQNl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 11:13:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocTL0vEV9dJ/Nk1xHYMtQRTXcnUtYOe9Oc/k+ieIDo0mTzllCV/CJbRbv8P/HHn72lKlBYi1CllcTa7pRNHgzESveBm3xECU1Yv3B5c9kVRskegkihL0miohLu40SoMy9TtUn+vHhQtLQWU4O18yG4wU6evRsfkYk52bNDl+62PDZ3ZPtRxhZuPZuubKdTshj7ZedIAglD2/00gC/U9H9rmsZNFJZdmSA+dyPD0Mm4njOHTmv2DgW0sfFsmZRWuCX46wp5SbzzalqbSQ9KbYbmFxjD/072J9ex8YhCTgdsKQOi0Wk/Q+9el/ZxaMeLx78LPH+TGV19cOsYof7hbfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSI751JYy2fHcTvWBvHKZDmriM8Fec9AEZVhUTarips=;
 b=cNQNm+9uphEzMRSJIXvbcsYu3RS0snyj7Rv5nfoMhgb8RLTxkgX2oYaAXxCVkf9KO8S8DQuIAkRFOBW+lrerfE1XqmLMYwgAH9J+ksJsHFhYx5KYKnrvbLZNmgBCyI3+FxV26jZTNGPwfs+hSL/mF8ZaMHLXTrtf6EoP0IXzfy0M99ZTF67O8HIC7cwlUvw8CYzCoLBhirkIH79xvvekyBArBCc1I6yGfYgWfx3imltwulFA31nZHqn3q4bmVtjTFfU7dgnj8UBfW/qdKHNy8FilBpEQ/byAF6EkKzjUFKsmHDukH17RnuBnwySEGWNxeqLa18hUEgPHAhrPjnkP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSI751JYy2fHcTvWBvHKZDmriM8Fec9AEZVhUTarips=;
 b=FB8gXBEZpAHUY7Uwd3HRDLnMyOfeTJNtTbGsVWr5C1+ghyjJbpbZxlwU/bLevserthu5GbesO5QRvThfm2nDGZNKHqDqWONgp5+9XGmkKaOL0oJZnrUxEDx31PPfE0UPEIlhOp9LsvD0JdLbHNWZCtHZYzO2wOwNbfsh2QuSXZA=
Received: from SN2PR01CA0013.prod.exchangelabs.com (2603:10b6:804:2::23) by
 MN2PR02MB7103.namprd02.prod.outlook.com (2603:10b6:208:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 16:10:39 +0000
Received: from SN1NAM02FT0011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::f5) by SN2PR01CA0013.outlook.office365.com
 (2603:10b6:804:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 17 Nov 2021 16:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0011.mail.protection.outlook.com (10.97.5.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 16:10:38 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 17 Nov 2021 16:10:36 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 17 Nov 2021 16:10:36 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michal.simek@xilinx.com,
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
        id 1mnNW1-0000gH-UY; Wed, 17 Nov 2021 16:10:30 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v10 0/5] Add Xilinx AMS Driver
Date:   Wed, 17 Nov 2021 16:10:23 +0000
Message-ID: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe1256b-9a58-4925-ac07-08d9a9e4cc10
X-MS-TrafficTypeDiagnostic: MN2PR02MB7103:
X-Microsoft-Antispam-PRVS: <MN2PR02MB710343D365C4748CDD09E608A99A9@MN2PR02MB7103.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4ZXGNBFwOJT/CDHX9RI82vOVuzHyGgXKEh9YAF9le3ZgZOndZ3frW4IDYRIKeW/WaTV4D5FFJ7mycbkkcoMcY7yYvMMTKnVNy+Itv9XC/jOsLOjh+NieYCFq/5m9XBakgVJgIDXpl5KHV93SQFEU2wVWVrlWP2CieVMKHe9imLGkhVNGBlt+g/ZRZL9genLL8MIY995XUR9kdaKu8iw45XI60rnmX4RTDg1rkfQCpkw15Hxwt8oLoI8p+z4LOpgceTSbO5r8e++AYdEctkte5bPkqyw69fkaUdMxSDxrPAXlFSVviBVt1KoT23RgZIA306cudJnDPzm/Zhnf7coGuWWGlHGbwjVkPT97ZLSim/JgeqrrezOTcxWd0Ot42tP8bGCLq56XU6QYPU98+kI3nOr4p7LzNd2OXVmVtCWASAXgyGOxIM7YpejKF3jxYSSCSddi25Ebfm8V5CsmQywHr5D3ghthIDMc8N/lJBkuXMeODF3Sn4g2PZ7NDkFMMZe4WR3Tf2swgmI3zrVWR4Hoei7m2obu0hMHPPKxNAB/hwLsMl2b2RJkVtXiBe1iygXxIDSCGS+IKA9M/x+IuLa6Z8qdx6VENZ0tDexIwCVOkYrJHLbQ2AsH5RRklh9C6oGDdvIK1x232RAKBoy6RsjyLt25Lc1IZt5/UBXYwGuipGsi0vIws7D11/yD9/n4Yv9vkK0j6MpwKu9sPZeUbEZr59uXSLvMkyn/HEI5qV0hR0aNj9alznxgebnjRHMBoIVYQkywBvK5uZwe2pwp6/NutthNfNn0jw6z65DsnHD5YQ=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(70586007)(107886003)(336012)(8676002)(4326008)(83380400001)(5660300002)(7636003)(7696005)(1076003)(36860700001)(8936002)(26005)(921005)(70206006)(356005)(47076005)(103116003)(186003)(508600001)(110136005)(9786002)(2906002)(36906005)(316002)(82310400003)(6666004)(426003)(2616005)(36756003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 16:10:38.8229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe1256b-9a58-4925-ac07-08d9a9e4cc10
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7103
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
	- Replaced *_of_() APIs with fwnode.
	- Added missing headers.
	- Fixed documentation.
	- Added devm_add_action_or_reset() for iounmap.
	- Restructured read_raw function.
	- Added helper functions.
	- Usage of GENMASK for all masks.
	- Added defaults for most switch cases. Some can't be added
	  since the default will never occur.

Changes in v9:
	- Added a fwnode_iomap().
	- Fixed Kconfig indentation.
	- Added the overflow checks before memory allocation.
	- Usage of fwnode_iomap() instead of iomap().
	- Rename ams_parse_dt() to ams_parse_firmware().

Changes in v10:
	- Fixed licence in zynqmp.dtsi.
	- Changed the macros to use BIT().
	- Realign some code to fit within 100 chars.
	- Modified readl_poll_timeout usage.
	- Usage of array_size() instead of check_mul_overflow().
	- Usage of dev_err_probe() instead of dev_err().
	- Usage of kcalloc instead of kzalloc()


Anand Ashok Dumbre (5):
  device property: Add fwnode_iomap()
  arm64: zynqmp: DT: Add Xilinx AMS node
  iio: adc: Add Xilinx AMS driver
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  MAINTAINERS: Add maintainer for xilinx-ams

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  227 +++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   24 +
 drivers/base/property.c                       |   16 +
 drivers/iio/adc/Kconfig                       |   15 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/xilinx-ams.c                  | 1447 +++++++++++++++++
 include/linux/property.h                      |    2 +
 8 files changed, 1739 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.17.1

