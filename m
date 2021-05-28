Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65216394670
	for <lists+linux-iio@lfdr.de>; Fri, 28 May 2021 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhE1Rb5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 May 2021 13:31:57 -0400
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com ([40.107.237.52]:11419
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhE1Rbx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 May 2021 13:31:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXdNfHZICVT0unrTyYythdfG3HZP5vas/WiAW0AG3a/VxI+++lXc2IXsKMRqiu9SFmjxzEfVsMlloE1JvGEuXxGHHDmVQmiF2q3aTf5DVYX7bOxMV0deRKFIxH/H6ZF8n7g5B6DEsSabFV7sInCCbbzraMLYuQJD9X8jVuf3PJydIs9ze4vIc/lWsDVghTKysMprAOsLgYK67s07686IuzFPPYC0QtxUBXOhEyOFB+PLRcD6wsHblErJU0NA5aX24Rauy3NP1K2fY4L58jS9UkbzX6Y6VuJR8HtKeJF1CZNm0weYplu/xKAtV+2MHTRVRsxCrH+38juoLc+wackpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiIQj5Q9/nRpXcdc3PISLHkZRkcnAzIKYkakOJfA+28=;
 b=LkHtptUMvK0gieHc+s4Uiw74PnH1xXvXSI7T5GHgBUbHlwu/T/Q0BOODX1Zx4/5gIKXFyZS1T89rct7CX1rQz85Py66XgIAPOp0SbWzUmI0DRFSEHbu1v1lezjnzpENF/oIw17wDVv5x8KeHsX9gq98e/VG6PJH/e4LdOi5nD/bBbvhjSIFY9Ml4NN+mrAgmVeZUNJybZ+grMiSl06WcGUL7el/KjwFswU6wLuSAS+iiASQ36sikE099ikyaPnlMcpEOqyotCCjF3T5VIpZUW+YzIy4UQpOx8N7vBl22gcCkHuyHaRsYaC/waYeGLjWW40H7eh6Av2bZ5lbxO1PyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiIQj5Q9/nRpXcdc3PISLHkZRkcnAzIKYkakOJfA+28=;
 b=Yx230667UbGJcgvjF/Yz+dyKuUOQ4nohMrzkCPu5kurPZqSzLMmCA5KJoZM1kAkXuRLQncnEyhTlClZtg0PTB1azWRXDefAozDbC+2+mMa/EXsOZgyMt+oTjVTdOD4NBqWZjAvuL2IVeSYGVZemJM78bEYsncE6jPlO/3nA1L5k=
Received: from SA9PR11CA0023.namprd11.prod.outlook.com (2603:10b6:806:6e::28)
 by MWHPR0201MB3612.namprd02.prod.outlook.com (2603:10b6:301:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 17:30:16 +0000
Received: from SN1NAM02FT0049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::75) by SA9PR11CA0023.outlook.office365.com
 (2603:10b6:806:6e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 17:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0049.mail.protection.outlook.com (10.97.5.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 17:30:16 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 18:30:12 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 28 May 2021 18:30:12 +0100
Envelope-to: git-dev@xilinx.com,
 anand.ashok.dumbre@xilinx.com,
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
        id 1lmgJA-0004hp-9q; Fri, 28 May 2021 18:30:04 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <git-dev@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v5 0/4] Add Xilinx AMS Driver
Date:   Fri, 28 May 2021 18:29:55 +0100
Message-ID: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72f8226f-e346-4891-6342-08d921fe423b
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3612:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3612763B9342088264415636A9229@MWHPR0201MB3612.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwKGOSLIsFjQaOxR4RlovWn728r3Yd0NH1ks0diUzfwOfVqH5+2cc2MHwrZaaKAdhKnrJald456fO2sNzIsk5Vg6Gm+s/tsg5pHZkVAVcJzTTPz0JnmLI128SFTn2+kYVa3xm9yrk6zj1Hv7D/4uB8b6UVyOUBTbZ/1Z58ICnC6jf/K72ACrJFsqDZR81oWOa/Or+1qFj/jAu0F43CYh5wmqHAsHRx/Fa9pDBe52MC5HQZsaX7grz53NWGFFY1bmLY5c5edX3kqkl7mLB/lzcIRiiyTNRSFr93DGn6DMLx11w4CBjUtAgcLthaix61WqZtNRhx22LS1Sk8mkCMRoelhML8gFsaMgaczB+2xowEULGrfgzjJjsMrYajssOxj6/75hauKzEvOQMsZWoa6cb5q/4ejkdr/IcwPsGB1OKzwwjUMblq+ZR6QlitvSZQo2XTZxlOC/qO4aDgAOH9nm2B/bjRNazkKl4/6IN99TTeGkjvSfUnH3UFppe8WvnvXbV2J2l+/8b9rUegwluAwW9YCRhcSsXg5OX/+K43JVogiaju4UUrKNVDzjRwHIv8NTp7xl7uo0tleCAFMLQqcPk8MgC5ApWb77Z6pXwHaP3qSOjITdGeqNGQ8WSq3O3garL/Li/dMN+hg3ffF5v4QEh1qexqAeO/BO+1QUxcg5qV2JV9jQYHySQhFKyNRTrHb6Iq5RwQIDNhYqLmbME5vsKQ==
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(9786002)(107886003)(5660300002)(478600001)(1076003)(47076005)(103116003)(7696005)(70586007)(6666004)(2616005)(36906005)(70206006)(336012)(8936002)(426003)(110136005)(26005)(7636003)(8676002)(356005)(36860700001)(36756003)(186003)(316002)(82740400003)(82310400003)(2906002)(4326008)(83380400001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 17:30:16.3555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f8226f-e346-4891-6342-08d921fe423b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3612
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

Anand Ashok Dumbre (4):
  arm64: zynqmp: DT: Add Xilinx AMS node
  iio: adc: Add Xilinx AMS driver
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  MAINTAINERS: Add maintainer for xilinx-ams

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  265 ++++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   28 +-
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/xilinx-ams.c                  | 1341 +++++++++++++++++
 6 files changed, 1654 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.17.1

