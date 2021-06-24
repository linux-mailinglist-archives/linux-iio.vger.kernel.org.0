Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A20E3B35AC
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhFXScL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 14:32:11 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:46369
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhFXScL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 24 Jun 2021 14:32:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvuQQyu7t42AAhSrNpZ+Ra7lSRCYvFH8KfVR64k1ifMUXVTED73OTqb26u7fQXmmcSEQvc974JjrJw44E6PxKPcXCmsQPz9qCr4utMdDG6efZ26pt9a1VvXbMsAdqfhJb6UBZ4bSiVozOm3w7ofchfbHJsyxLrOKqs3XHhryBTYET+YCILPlmSAo0p9QhlTK9nwZzD1EOWDNoEqx83Sl9dndMNvSHwWtjw8zJFPsO7hVSP2srN0F8iVvw7d1dsE+BUU2ab3ROOABrhG21koKcP/DjpYjU5q/n3VVcBgihly1bycYFcq0qauahQM7Ivms06zDL0j+8rGpIRqG3weOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKfh+T7vri5wztjRfZf638F/2hMdk0cT83l3UvW2V4Y=;
 b=llEHY69yPrOAn8N6hVfnqqruDxFz6IZz0EHbs35k13ULTmvYz7tOQmhknyOzGiNP/wafSEV77a1qE0OnZ1jra9fDyPAHO7zNo62Nxu3pYy59wHBj2UahylioaTVkpFLE2Y0YjMmGOh3IDlbhzPJwZkoqKyKVKSnTdfIb9AFxhtMpR0CDv9lUA6iP/ms1OFc5uwdYhFrA+uTaZ/kpg85LFxiXAu4fy1JBO6A1jhlkpvTnKql8ylViQMGliEmZE/HsD43U5jkIWPZZXm9hHCQeJtB6VUmxLMJHGsEDQiQVcs98PJiKTjTx/c94sk7fGuIxGrPUCIgPW9ET2l5HtBxpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKfh+T7vri5wztjRfZf638F/2hMdk0cT83l3UvW2V4Y=;
 b=TFJMR+KkG3vfz/7H8eWyAmJW0Ro1gChN8quu8kxr+z57Paa8fz0CmoaUBQsgwSyMp0DyJnYhsQwizQ3Znm1A5d6w0MXRQ/oQiLA9P393KY2b9Sd5lg578SQC2v2JdyPc927oDl6ZxHHvSY4XY0GaR2I1DOC4EcoUgx1G94A6+to=
Received: from BN6PR2001CA0010.namprd20.prod.outlook.com
 (2603:10b6:404:b4::20) by SN6PR02MB4205.namprd02.prod.outlook.com
 (2603:10b6:805:35::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Thu, 24 Jun
 2021 18:29:49 +0000
Received: from BN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::5e) by BN6PR2001CA0010.outlook.office365.com
 (2603:10b6:404:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Thu, 24 Jun 2021 18:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT057.mail.protection.outlook.com (10.13.2.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 18:29:49 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 19:29:47 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 24 Jun 2021 19:29:47 +0100
Envelope-to: git-dev@xilinx.com,
 anand.ashok.dumbre@xilinx.com,
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
        id 1lwU6e-0004j4-DW; Thu, 24 Jun 2021 19:29:40 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <git-dev@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v6 0/4] Add Xilinx AMS Driver
Date:   Thu, 24 Jun 2021 19:29:35 +0100
Message-ID: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051f9bac-ebc8-40af-bc1a-08d9373e0ce8
X-MS-TrafficTypeDiagnostic: SN6PR02MB4205:
X-Microsoft-Antispam-PRVS: <SN6PR02MB420513C4C1DB51FF915A2333A9079@SN6PR02MB4205.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oI91RG3afz5xZtDP3oEB9y3UUAi7ctNafUA/Pryre3Vr3oAh/LuGwiYluWvh5WcDpmtK5phsAjf2dyBdJBjY0XdbVJwEYe/oXCfdL7tuQMn8XjxBhpP6T0w3G3vsjjOO8RWHnG9vUVM6/27f2hgUDI/gyiSDprs+nOuRRHf5Rss/Er6szd2gXcZAzj7In5k/vJ3w9HaCS95fg53lb8Cbnkd9XZC/6zy2Zc8ivTpqpCToQrI1wjjryGZWXo8f6a0V86+IxMXy3DIcs8fyaAB01O59uJRnwyX9ahtCOTyKX/Yn47B9QuyK/8qZYHQ9VNrAPI7gyRX/gkVQmjHRUdMUmaL2V6BqOkSrGUHxTPYJDYcnXU7vY2Lz4c/Ng/rCjN6XykBUoqzYB1Q5N/H5A1xl5SWRhXF2NpHGqfLBQ5LqOZ4hBrudnM64AWtjq99ZvsnlQ+CXYRHBaCx2NDc1IWnlr2u1QfJXJoRdSdQOGry4AT6K7HFqcmz66Pb7D4DJfps/YlEMaWV5fvHCg3jItRUIefUV7/GoW/5y/BIhDsI4LjSN5NT8a6WbXz1WvhuOadZieobCE/t0QZe7wkyiQyKgl/OTjEBoZOVhc3KS1mM3EfWY75HtIPd8XMaGu93juwnQ02ZehwVKP/Fa9lkeG3JLgYBhD4TmbVNPSXUO47p1BH5nb7Qo4mZrUSjI/7BFdd3yuul7VzCS4BlI7iqwTVMDYEP1BgusBPI1dAEGuxaoh428i+riLz7XYBXPfIn67K41
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(336012)(83380400001)(2906002)(47076005)(2616005)(498600001)(6666004)(36756003)(107886003)(82310400003)(356005)(7696005)(4326008)(103116003)(186003)(110136005)(7636003)(8936002)(5660300002)(9786002)(8676002)(70586007)(70206006)(1076003)(426003)(26005)(36906005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 18:29:49.2035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 051f9bac-ebc8-40af-bc1a-08d9373e0ce8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4205
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




Anand Ashok Dumbre (4):
  arm64: zynqmp: DT: Add Xilinx AMS node
  iio: adc: Add Xilinx AMS driver
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  MAINTAINERS: Add maintainer for xilinx-ams

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  228 +++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   26 +-
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/xilinx-ams.c                  | 1342 +++++++++++++++++
 6 files changed, 1616 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.17.1

