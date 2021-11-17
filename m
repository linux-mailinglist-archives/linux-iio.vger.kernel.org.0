Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6BB454AA6
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhKQQNt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 11:13:49 -0500
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:6752
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232667AbhKQQNr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 11:13:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ6Cz9FGllifD5lwI8Wu9yrg65cmNINrzO8Bu5n8wQEdE4WMZyOQNrC5bXr7jEVKCTBQM5CxzotGXFed7/Dn6ux2bvw59LR5mG0inTaBuIuyV2sR/CjFP6WM3y3+Kkvm3H1yg2okVO2Zw4JqUJ1z4BOIQlTzM45+fmMr3Ps3Aq6ytScMqEXVli609UXNfS33IKDVZHJPgpys7nj3jPH7yKM0/uK4usEZuE46DgrUkMPvgtHTQtDYMNJDWkGcLKES9cVhBuKw6B3UHCMchYhdFvHACHAyzWSRkN6Sg04iylsvIgzlwqjNLnG5utjsb22EyE1pBYS/bzEUSQjYsvSMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONnncVWcdIQ8bkMcGQax7X4Oe573b6GJVChsAWzfFWw=;
 b=WbSp0lzkPs7Hq8N3sa1aMmIySKQ6CfhT7EeB6EU7cJc2oClH7xxEbP99bZFthFZIl6x+d6pRVBNNrXZ2rMtl6U/oWjZ+NaaW3I0gxcycugnuMrL9UYcQNPo6Vg4gBjdKiUNK5iy/RrUnRPLwmViQqqwtgU5ZwFxWLF6/z73htEX1AwMYNtvuHBq46PFpGjSJYkpBWjlbyAz0A3ZHJI4TKHLr0dKkPpF6HWhljvVuY406yJdXNhyUxyUREbPJd194eci2JeXk1iXs1BHkovcVYKdtAdXDhSW+zCYNA9snpJTqx+Wk37+vtll7gnx1NApcb21q65T4H100+gSRY/X0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONnncVWcdIQ8bkMcGQax7X4Oe573b6GJVChsAWzfFWw=;
 b=YL5w98V6gizSQUoRaBh9jJBsHChQSJ6HPZX9sq5Ii973yv+udTysEBHC0zJ1yDjPoHH/vbbrqp4ED6SOccYtzYuWszy64d7AA9GyUg83wMsg3/U5+PVZB+rbUdOIdXuHaPqdEtyrEnfaAAAVrirlAf0W6VjEi+u0SRmAZwzeB4w=
Received: from BN9PR03CA0341.namprd03.prod.outlook.com (2603:10b6:408:f6::16)
 by CY4PR02MB2439.namprd02.prod.outlook.com (2603:10b6:903:72::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 16:10:45 +0000
Received: from BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::62) by BN9PR03CA0341.outlook.office365.com
 (2603:10b6:408:f6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Wed, 17 Nov 2021 16:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT045.mail.protection.outlook.com (10.13.2.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 16:10:44 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 17 Nov 2021 16:10:37 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 17 Nov 2021 16:10:37 +0000
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
        id 1mnNW2-0000gH-6Z; Wed, 17 Nov 2021 16:10:30 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v10 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Date:   Wed, 17 Nov 2021 16:10:28 +0000
Message-ID: <20211117161028.11775-6-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7442c54c-d6dd-4419-df04-08d9a9e4cfa5
X-MS-TrafficTypeDiagnostic: CY4PR02MB2439:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2439437672CD429DCB4F1928A99A9@CY4PR02MB2439.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7S9PM0gjOgL9vf6NsNxsnIj7BN7NLjd7xmzfGtWy1v0u9YpIEQTMnB670JR4ltffBCTRaZtiB6JVnfAE6rZ/0Dza0JhcWy2StIN8v0UMiQTlVe7JkN/STgbBF62frwentaxsQPqiOV093W0QE0lt5K6jtE4bhn+hBtW3h7x90MPKImd2E4FGc33pXJGB8txoDZLBwzv+47zYF7DKLqdq1nEa76EWfycFejyVcM3mt6VOV6dWvBBpYLyrMorbeuD3h7KeplfqugVKYBFyCR/BP/qfcLaiQyV+uVcBZui5bgF4JzYnIw6e6/3VMD/uURzYby4TSH0cnCqk2pxUjprDBz3Ercu1lfXFWKFZg2g2NPMneJqAinOw5MrE/FSeW/cBpdkXzNwjJLZSRseFTF41SEn5KfEkh1T3mMpzzmGbBVeLF5kOlOrKBKdVAFxLwMs9PXWxjNjwdMGwqva7gIb91VfuBJUv+7qY3BtGNIWffAXTbAPuTfsMyG3POl5SrQn6Lz63+fDkPaZXpkNUy2WJ2oERcjwQ/vvQX2nWC0vnHVuV1h+OJetAKttQm0Lu+PdhxlSAgI5Qo7+1dbVHgEiAH0Cf+pgW6CSW1gnTyjYgiNKsoqZOXd9cjW5zwhGxIG0yXrzCe31KkUCbwe+a2nWCqrsiqrWDG53u9s+N6tz/1Ks1dIBjWEPX9Rxaxe+gmK72xCI8tv5UoqpUJ39s6k4QpslsRJuXgXkmlQAiG2LqlmFmAanE4pD7v4snnVTfTN2wQQ+CVj3M1cSbpmNuUGwZD4ZqoK+cycWbCMkBVfQsjzs=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(26005)(5660300002)(9786002)(82310400003)(4744005)(107886003)(36756003)(70206006)(8676002)(508600001)(70586007)(36906005)(7696005)(921005)(103116003)(8936002)(2906002)(4326008)(36860700001)(336012)(426003)(2616005)(7636003)(110136005)(316002)(1076003)(356005)(186003)(47076005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 16:10:44.9338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7442c54c-d6dd-4419-df04-08d9a9e4cfa5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2439
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add maintaner entry for xilinx-ams driver.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..1ddb55cbe987 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20867,6 +20867,13 @@ M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
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

