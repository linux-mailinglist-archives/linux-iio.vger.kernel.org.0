Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D5E453552
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 16:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbhKPPMz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 10:12:55 -0500
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:65504
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235340AbhKPPLx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 10:11:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9WSoMZgLRuGU7iuQp6s1V3AdzQQytKw+5nno+/Sttp/lhe4LEGf41tcoHV7a1g+nSu8GsknyFjv0QA8pn5ls08WSrDunW+cTHCoYlJfSd1HUSOqnaYFjDgDHSqiKVNqQcp5xymc/0Kdo7E3Uapmn+uj4ZLwppclyWfSsSV9CxW8IMcVOwfjU2J+sLfq3kzdsKFi9C5rNQdQ+s+G4NmJq6AbOjtPXVV148L7BqDV+mt6hDw3rdsD4RGR/CjmULkhrV1sSRN2RSGfzOFROwAOP0T9sZvOHQZax9GWPBondDFS2Td2a6EIEf8niddnLHtyh2yWnQmshsiTn1YlPEgT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpPqBxpK+035IL6d3wKPYE9/Q5edgQekSSiiFwypDqE=;
 b=Zu5B75waXwQCFmBGHm5r1FcU6EuU8wyXEiqhPP6JaBFYh7PjebsjhQxR8QNaqc/fyNCQtei/sjm/K+redmne+Fu2ZL7HOl+gWxMbLJFCUH4DqmKm0c/LTrHCrs5wP1C7nkrnnejHb7dZKOxZf1pLdF/sYZldPio5O9SvnJdVitWvTzwLNzXaM9iNuLucXm3WjZjWCfo1mhQSAnGLAA7kj7Q6krzogdeSAovICjZSP1ltw7efrvruA0xJgrfnjD1k+T76fzRF+Q6QeuB8Npt5JmuP/zvyXCh5nXP/3PA18y/LamOARkJqwtIbjqm0SGajpC4t2X9sQi16a7O7NbLQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpPqBxpK+035IL6d3wKPYE9/Q5edgQekSSiiFwypDqE=;
 b=bEadNuwhrnAiE9pMFsCNcG94SCf4bMpCVpZ8VyoAXXpifR30FyRcd/IySRFkQ3KvuhcvN+wusHj3bFJsR+pbORH2vMJfjojnQTMTTHCe1UZg0CvIAnghoD7CWvHmUv0ZbjY1RrwFqj457lKmoq1s3q0jq7i7VhqsnF7T861bTPA=
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by BYAPR02MB4887.namprd02.prod.outlook.com (2603:10b6:a03:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 15:08:53 +0000
Received: from BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::99) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 16 Nov 2021 15:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT048.mail.protection.outlook.com (10.13.2.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Tue, 16 Nov 2021 15:08:52 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 15:08:50 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 15:08:50 +0000
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
Received: from [10.71.188.1] (port=4502 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mn04h-0008P4-G5; Tue, 16 Nov 2021 15:08:43 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v9 0/5] Add Xilinx AMS Driver
Date:   Tue, 16 Nov 2021 15:08:37 +0000
Message-ID: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5e25c87-07a7-4c30-e108-08d9a9130087
X-MS-TrafficTypeDiagnostic: BYAPR02MB4887:
X-Microsoft-Antispam-PRVS: <BYAPR02MB488736D4D71F5E582B973779A9999@BYAPR02MB4887.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozVsdBS0+Ri8Fq71jVC9tXsZ1Cv9E6JaVlu8xmsMd+gfrWVzMOBbH8outEKp1pgqCZzd/u/sgjqGcnPYr2fk00wJzUdtJ3hpUpKVu7Vy8MsaM58ZtzuSeC0A0zXCtmFCt/k7Y7G+1dnYYnNWWj3h1sd/Ue86/0ZvGPOPvDITq/JrvLChmpc3UtT4vq6ChVczZ1WewTAYZJfCGj/241X1PorpW6zYOs2pbZ9BJMZuWe0gCFmEYvM8zkJ1OMofuUyS9s5ixjzsjqtynONkzYudAfRcZ/hV6yOfDLc3DdmhTEaq0ySV3gZU6g2K/Jjo/p3gxtSNUOE7Ff0uNL911/p+pY2YpLtUNCLQomHgxROCy/Var1CDmmaNELf4Oz0VVaG+RgxR31IC3abjH0rtCiCvsOdsUllZu9svPCk7TtRR2lozofGsr57gGJV+r86r5mPJ/CNoCwYA/evjwtrIxzUz+fjuvIubyxN4Qyg90T9mvV1kCE1uVRaYvscKCFx6mNDyWdvWenbRMUXaPPc5fU730WaH3oWC5XqytWHc+hc274a2MjFSSLA8jZZqNoW0xoOtowkSrZ71NC8kWEXXIqEXXu1E0ZEURsTuzjhj15DtIK/JFaZrpNBqI+k+9BZxCUT0w/2YtBSgSuwy9b1XeGehR+Dd5B9Di1TeR/utUm8AiI9V1np4maX8h0EPVx+VcnUSkC38bAXb/dcLD/FsYbZaBIsB8gc4DrBJ7cG00eWaA5Zq57QyfipQ5l513XpXmaNEpX9HcnRJXdzx/gOZatiGNhrFQB56QUOeEQt6qQGzH2o=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(70586007)(103116003)(2906002)(426003)(316002)(356005)(36756003)(107886003)(36906005)(6666004)(70206006)(1076003)(82310400003)(7636003)(9786002)(5660300002)(26005)(508600001)(4326008)(186003)(921005)(8936002)(47076005)(36860700001)(2616005)(336012)(110136005)(7696005)(8676002)(83380400001)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 15:08:52.6314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e25c87-07a7-4c30-e108-08d9a9130087
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4887
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

Anand Ashok Dumbre (5):
  device property: Add fwnode_iomap()
  arm64: zynqmp: DT: Add Xilinx AMS node
  iio: adc: Add Xilinx AMS driver
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  MAINTAINERS: Add maintainer for xilinx-ams

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  227 +++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   26 +-
 drivers/base/property.c                       |   16 +
 drivers/iio/adc/Kconfig                       |   15 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/xilinx-ams.c                  | 1456 +++++++++++++++++
 include/linux/property.h                      |    2 +
 8 files changed, 1749 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.17.1

