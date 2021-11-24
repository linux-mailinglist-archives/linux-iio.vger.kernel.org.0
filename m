Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346A545D091
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 23:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352412AbhKXW54 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 17:57:56 -0500
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:63770
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345585AbhKXW5p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Nov 2021 17:57:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV7mBd9vP0V+SV5FR5GNa3q7QDjFWDHphn9iqt7mAidfEDVkrztwilpZTW9e6Ddbbl+d6WwvnvECIZFke/64MQZGu/aofkb7A5zRA2zUZIAOK23MI5Fu4vT2DxvPNUCTQ0OzX1Rdq0vGz3hebFGXTw2rClQFLPGt0akRCtufvKdfYcfMt+1US/IXVVYrKXKzzjyDXwAkKBHti2M5B04HpusrL02wsmjiKefa0X/Y+IihmtYJnKAcpsbSK3EM4hItDkgqyxOoUl1ekhwfefNqwf69VF2mQZp0r4QP/g5ljMKrcV973sUT0pszUlBF3j5o34gbNeU7KpRmqivvoYUIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24805duooPEEuzFGB8K5tRsFH0vOPCU/HIHL5jr+mrM=;
 b=I36X8Ql5biuyfL1Hh+J0s3l+n+ClgBbUjTVDJedjFChfZDZgqyh36d9TkIK8HdjUtScz+7bYSaOWLn2eRe4DFOQhILg/pjTiX7dcF+WX9r39S3a0ZXNJA88c2mA9TqdDeTxUTqvmHEnHeoF/1/ilNKI9KH85FU2S/d8pFxFShMeoKuMpxbLI06QSQi3sU31gUxpBM6GrTPWpZO7ITofEqFWh/H/H8iYd/U3RO7SxP/fOjbILCtl79ObW1xr4w4EZQueGIsignNTSxsnX9PbHlxpNUjlh2Kat6WC1uiA0wX9PVdFJW3fZZ204uDnFKYrWW7UCxWp3+ztMuw9Nc/eGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24805duooPEEuzFGB8K5tRsFH0vOPCU/HIHL5jr+mrM=;
 b=V8Pmi4vVjcVSUXyUCC/jCHANHwAxPWNp0Ymdk7jLDmB0ScuMvqLDmnqlKwf6v/wHK7BCxtM/G2BuCohKAfWQeR0wkAV2YbvrLmbZNOfWOZL66eRWnyzHisaMMnkSWbbVmNz304NDGSGQg+vcj2h+CO3iTj3FaEhlr7LrHNi2CM0=
Received: from BN8PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:70::44)
 by SN6PR02MB5536.namprd02.prod.outlook.com (2603:10b6:805:f0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 24 Nov
 2021 22:54:32 +0000
Received: from BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::bc) by BN8PR04CA0031.outlook.office365.com
 (2603:10b6:408:70::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Wed, 24 Nov 2021 22:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT029.mail.protection.outlook.com (10.13.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 22:54:31 +0000
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
        id 1mq19Z-0003SI-A2; Wed, 24 Nov 2021 22:54:19 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v11 0/5] Add Xilinx AMS Driver
Date:   Wed, 24 Nov 2021 22:54:02 +0000
Message-ID: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d28f2b0-010a-45e7-df08-08d9af9d60e1
X-MS-TrafficTypeDiagnostic: SN6PR02MB5536:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5536D171E232E16CB1706EE1A9619@SN6PR02MB5536.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeZgoYykIBj4B664UrpHVl9ZC8otHtGCXSF1iEnowjPD3dCPiLm3zyeLYIc6aebNS32ZdeLqz0732L9ELBRToYhKikkg8SiPI5aSMUzOPrhnmrrOaaJdW5ZhaizX6CW0LwOWS6ritGLFzkbl9Mt28Xf6barHKRdL70NPdlQCJAPnqi/KCWSbaAgfLCTdZfWPJMURE0Bx/Ut6GYNrKoTe+fquPDSVb6KNYI0GKquGDc3HEGdQhj3lEOZCoYR9GpbaPjkSk1Urj8yBfwdrAHMPLE8r1a+SwkU4nefOxa3FMCYeIv4Mv3+e1I7YgmDqyczJfm1+ZlvzpMzKL14BWaigcNwVL6od7+ni7hpORg/0XSRdKaa2emnkAjs9z/cqL3oqHGXwOYvNtFJHPVPFeESSiRci69+P/iZOp25GBNCDzDizZNHrWFdwVpfTArtllFcUDmw006TOrP5ZG9N+2OeyX+kxe0NUmah+tUG4OfyPAWb9lXtp39+x9vz6bV7cvQGkyfjzsslynCNTcZE9fTQI5qsio8otUhfVpYQ+ZNrTWkyVumsi3LuyobZuVQL53CcvzYXQfVvTXNBJH2zsDEtECMHi3rhWIMOXQyFHYQPJgy1wrTGOTGFmcoLekBJaQkHCgGVzJplbi5ox85YTIb7sCTDt20IuaroNB+EgCUlrmGCgI1QsYfxgIGcxq4+bj/JPF6KyU/YHjLtZ1OgP/3Vztg9K9YHmWe8murEeqkKutgP1GcKM8VPq2OeLIbflxd2kdRXZG+yL9epHLVMXob7Vut3mWu0Qsz/qcl/71g8Wr3Q=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(47076005)(7696005)(8936002)(186003)(7636003)(110136005)(921005)(356005)(107886003)(5660300002)(508600001)(2616005)(316002)(2906002)(36756003)(103116003)(70206006)(6666004)(1076003)(426003)(70586007)(8676002)(82310400004)(4326008)(36860700001)(83380400001)(9786002)(26005)(336012)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 22:54:31.8088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d28f2b0-010a-45e7-df08-08d9af9d60e1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5536
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

Changes in v11:
	- Added missing bitfield.h.
	- Fixed AMS_ALARM_THR_MIN macro.
	- Added terminators to enums where necessary.
	- Added explicit values as suggested to enums.
	- Removed redundant macros.
	- Added delay value for readl_poll_timeout.
	- Corrected shadowed error return.
	- Corrected formatting errors.
	- Added default cases where missing.
	- Made ams_parse_firmware() a single parameter functions.
	- Usage of devm_kcalloc() and devm_krealloc().
	- Directly returning from dev_err_probe().
	- Renamed masked_alarm to current_masked_alarm.


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
 drivers/iio/adc/xilinx-ams.c                  | 1425 +++++++++++++++++
 include/linux/property.h                      |    2 +
 8 files changed, 1717 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.17.1

