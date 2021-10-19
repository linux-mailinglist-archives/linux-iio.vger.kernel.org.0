Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC2433A1A
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhJSPXQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 11:23:16 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:45153
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233677AbhJSPXN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 11:23:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs7wUs42JXKt2wXiRoglCtQyqbykIMq9GfCjELEQpzgAqgN/WQoshjeQ3pkZBKY48DenJVjWK/YOfFHM9vIcfAatq1R8Z8PdTx4JsnpMYv6KTcTwanYsljh2/h4bO6EpNgmZfjsnr8wqeXwmRlHU9qf5DQbxzEAO01nyLdXqx6AMmbotFitXwBd7ljSv0dKx6xfX6wAxoH95FBlUqIpKOFvDoLpY9GqrDQjtXPf8WEHyTgNXVya5WDF/gx0DeL69XWJyiDu4/bcvT18rIz83MlNgnoVGEDRDJE0/xrM9AWHWbMRPZXsL+QGftDcGh3ysqzTEMKcY4T1EGhUVszCpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g015nim8vgp52WwgrtqdkfVGmFDaS3hqY0e9qwWxoK8=;
 b=YwZ/IP8scrYyIWPMLKPTxpFNACIiLu+9XftPk+B8GwxxeB0B87YnsfSruLId7CMVWq5Nx/+YW6/HCy/kLavLwCmjUudFOmQYBnoxfmHRjPNqIndoCNrXwPWRQ1+aWf11eXwqVx60Jd1qd+PIOW37WI4EJeuARv/+eenj+P7cAyLVk0I62Fovj9Lsmt/NLA1WNq7RgcsuZvA0OTlx4DVNhgY7z9X1io47mcLy7RHOs1iWChylu4ZMgP3Cs3CTwmUv2Z79D5FVeu5a0UrtgrsmPhv/gG/3qEOIrbmSV79b30n7PJwD4yhrc700nlJ2UlqUxHFpq8kF8xB9tEBeVG591Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g015nim8vgp52WwgrtqdkfVGmFDaS3hqY0e9qwWxoK8=;
 b=VVOJtz2YOGl+t/OFxLSywbfcj0zYcD23kHeVrdNFUxujjqyD4I6yLsQgUjjyL6/7F17TLxCSyaGM/XehYkkD9Xhcm+ZMTbdeyFQVTIE5T90ZAZVO4D+yfrqyE277VLTsZFAFSnmF2NNXpyzsOa4HON+ql6VD4W3AsR5/K7Nt/cU=
Received: from DS7PR07CA0014.namprd07.prod.outlook.com (2603:10b6:5:3af::17)
 by DM8PR02MB8122.namprd02.prod.outlook.com (2603:10b6:8:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 15:20:59 +0000
Received: from DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::eb) by DS7PR07CA0014.outlook.office365.com
 (2603:10b6:5:3af::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 15:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT058.mail.protection.outlook.com (10.13.5.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 15:20:58 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 16:20:56 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 16:20:56 +0100
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org
Received: from [10.71.188.1] (port=8251 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mcqv4-00030B-3h; Tue, 19 Oct 2021 16:20:50 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v7 0/4]  Add Xilinx AMS Driver
Date:   Tue, 19 Oct 2021 16:20:44 +0100
Message-ID: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65b8e37a-7bfd-4183-d87f-08d993140dd7
X-MS-TrafficTypeDiagnostic: DM8PR02MB8122:
X-Microsoft-Antispam-PRVS: <DM8PR02MB8122D75F8D84E624315AE967A9BD9@DM8PR02MB8122.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3h/JC3vAZoyLjNv7KIEIuNyPxoFwvNJNFKQKu3iP4p3mbant1Z/2tei5fTJNVvZWyZ+xfHha/ZoeaiLknYWZKSgJCnmk9ocaywHBPdbDMPvyp8Kq3mkOOgBcxeckFZoQSiW4phfClzrjJe6yo/GAQKFsUlHVW92krUiM8JowCFVXMVbKZD67lncan7OmUlVz1WebjP6r8NNRw3oROEI83VxxBEOzqfqRsoCOBoSZbgkgfzej9TzN+h+tpLgDxQXvOUoiaXzaEGbG2rUyMr1mwdRlbLV82VMreyo5oVokhHpLv9y8Et3Y+OOevd+cfeX9GBBTnABpSugPacFcWcLNsnVRattC9MJbo899ibDkpUOAVAvBfvd48JCzVcHrJ2DAuTI3c6w0OygMoK9XwXlfdwmhpnaHXXWGXEdbHhe91xqzMIl25UbtZ9g6L/MT7s5scgcZlvRtKgMQ9rTcpcQ2GSeMp72NOc9N/sVsrNoZLl2CDkoAQCig3WBNFlih8qKYuRkQ1ZDV3xc9dLkBgdIeockiq0G3Uu2D7kc1simkXTztmi4BCUHqUgedYmNy8TCrMe8Vsr4rzfLQ+SZetzQrUeTpAg4S143QHbhTzulEMGUVFpafHj0DkQeJtqfMFVmgJdR395kncLNLm7eEOvlPYka1GkAfzKUF8Zu5vs+4yMUsbQubeWQM8gnyuLwHhhHUzOx+X7E2GweXzZ2tiy6sUOT0J1itgqYN0luwY+S+Vcfg8VFZw8FwdzAlz8oVmj9b
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(8936002)(508600001)(1076003)(4326008)(47076005)(7636003)(316002)(2906002)(82310400003)(26005)(186003)(336012)(36860700001)(83380400001)(2616005)(356005)(110136005)(8676002)(36756003)(5660300002)(107886003)(7696005)(36906005)(70586007)(426003)(70206006)(9786002)(6666004)(103116003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:20:58.8255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b8e37a-7bfd-4183-d87f-08d993140dd7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8122
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

Anand Ashok Dumbre (4):
  arm64: zynqmp: DT: Add Xilinx AMS node
  iio: adc: Add Xilinx AMS driver
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  MAINTAINERS: Add maintainer for xilinx-ams

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  227 +++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   26 +-
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/xilinx-ams.c                  | 1338 +++++++++++++++++
 6 files changed, 1611 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.17.1

