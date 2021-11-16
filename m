Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB745355A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 16:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhKPPNC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 10:13:02 -0500
Received: from mail-bn1nam07on2051.outbound.protection.outlook.com ([40.107.212.51]:41283
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238073AbhKPPL6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 10:11:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct0lInQpt1XiUzxbATT6L7PXFaCo02pxtpt5LsBPsSyLMzximGxWDzvq2TRv54D3d57wi1SpqePmOiCBSa60ffYEeFLMVM5cpTk3+drgvANCxiJ7GPgAxYfJJoZI9e7Tnt2chVOw1eXA+qYSIVonHazYlWuFgzMLy3M6szInNnHQpb+QhuJIZZpaNzSjErV6ei2jMmAbEwaH3ploIuNsLHRyXSbU59DaEFSbdINiE6D8UeBahRRkgiXsRrHgXu2T21N7OJrDS9xUfAPIhIkquSwgmZ4KPeKLA8VWEVz4MSHLRKWoU9xYC6etz22s971/wPI9bKSJL9uirr/wxB08Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3PUW1DuRbUlyeth8cIQGVD+Ka3aIkAuacFplTu2g0E=;
 b=VmVBC1oCPCVMBRnnfLu6xAdItYZeW53ZDdBycwjp3clO6cMfUEx1OQxxHHwMEGQSkg6xMpPwYHRgIcDNASTmfZD6ePPP0/zl/YQwt0pZFCDZpYqXSZuib0rUeSXLuT7L7NqjXFt3sL5uN3aTgBiidQtRL1lh1GblEJ/v/82+FH5kFfPXC3JTlZdHHvHfQr5oYWY3M14Kf8tr0xZRdwN8ioWxiR4TTgmxxdicQHOKKvivedEoVIxcp1ZwOc4NYOINeDviD1Jl+qDNC1L6cvOBzF1LOjgTJUHTFf7yxLXTXgE/uywcZgzus8YFAdRsA4LAHLijwjF7S+7TYewGFKqt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3PUW1DuRbUlyeth8cIQGVD+Ka3aIkAuacFplTu2g0E=;
 b=Ed5V7g1letcg6IYvbOBE+HaQLQjvq8L1Fx/EeNYJ4Av+fkqIuh66L0P82aF6B4WBxD4rSI+ZNAO9jjN594pf+pBWhZcSC7EqesOVOO+cKtsdKlEKzEj/rfZi8tLGsR8AR27i4ZDcg5bdxkFELfjm9Lk4t0UQGgOatVQp96YkYxg=
Received: from BN9PR03CA0975.namprd03.prod.outlook.com (2603:10b6:408:109::20)
 by BN6PR02MB2739.namprd02.prod.outlook.com (2603:10b6:404:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 15:08:58 +0000
Received: from BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::2) by BN9PR03CA0975.outlook.office365.com
 (2603:10b6:408:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 16 Nov 2021 15:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT048.mail.protection.outlook.com (10.13.2.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Tue, 16 Nov 2021 15:08:58 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 15:08:51 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 15:08:51 +0000
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
        id 1mn04i-0008P4-4r; Tue, 16 Nov 2021 15:08:44 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Date:   Tue, 16 Nov 2021 15:08:42 +0000
Message-ID: <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bf4237d-d91d-418e-4c76-08d9a91303d5
X-MS-TrafficTypeDiagnostic: BN6PR02MB2739:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2739039C40B0E523FE6428C2A9999@BN6PR02MB2739.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nCI+TbY2EnI9mY8Wf7umIFhy0UMrWYDH4uuDnRlDOOTl952Wpzv4TucxWfrekp70QPZVjT+e1wIufkiC++Swb8XXRtqeaY3RJ03O2HEUu8jSoxtRaOkVw2F7GnjYYWceUNrLvsvXeFcdVLZpXPbfcen3JLs3oeu8+w0ScarRTm8JQhdz8ZOtIu0wyaOE33fn7P8CHWjtrieqwbW1tp68KK0y2JmcqGvbrbMYD2JikCWwTrvVlWeeNnb6wWI9Nii3YO5oDqnRsFwQP0XJaY6xYe0GS9XU4U7eOBhl4Q7ncrJO2eJRBe/NCg72T/iG3xx907yuAlKZ1GKETabTk36/eUivjBEj/EzjEvdWfwiMlcW+LPdrDJagmgV+NHbq5recyodjfAzWNmh62rpvFK3v7oVvOh/p0q6/CxIRL+RLWmo4XKQGb4Byf/pWl+mWOOH7XDbZ38V3A5zsmso0AfKxk6nS8xMwOt1bjbuTiII+t7qXLOOxLItb4dd1CLonDO91qPjD2A2JDBOnOeF/4spX5Qzxb4j5crDNkPb60aEfYJoLYEV4Ueh8JQFCH2p6zFT7ewlOdXtBStbfZtOJ1CtwvuIGz+dn7NM2f2pQ41/OastwmKXqGiAw+jQ6R6HoMSArSwitesdt/6/PGC+r3bpiE2A3tdJ0r2ubgP/rQnl1K2tNDh1DObkLK226nWK1JQzuMhdtu0FTWJVmJQ0DHA5CrPISClvGgvZhlpk+7m0okergfd6UUxAO389uVXzPXB3+yKyPWMExyrn33GD3QtgtPLx7CjPU4JlA8smP9XZTwg=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(2906002)(2616005)(103116003)(26005)(4744005)(82310400003)(1076003)(7696005)(110136005)(36906005)(9786002)(36756003)(8936002)(316002)(47076005)(70586007)(8676002)(4326008)(107886003)(70206006)(186003)(356005)(7636003)(426003)(336012)(508600001)(36860700001)(921005)(5660300002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 15:08:58.1729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf4237d-d91d-418e-4c76-08d9a91303d5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2739
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add maintaner entry for xilinx-ams driver.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dcc1819ec84b..30de0ea64ac4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20640,6 +20640,13 @@ M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
 S:	Maintained
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
+XILINX AMS DRIVER
+M:	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+F:	drivers/iio/adc/xilinx-ams.c
+
 XILINX CAN DRIVER
 M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
 R:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
-- 
2.17.1

