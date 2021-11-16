Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C567145356A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 16:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbhKPPPY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 10:15:24 -0500
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:59360
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238086AbhKPPM0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 10:12:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTH/A3ZvWhZSYkNzz/v23AGEEQAt5gVCGEa3FXB6cbhTNfsK0iMMGCAeUht/C5ftSKEfSz3VlvlDGrY26I7drYfGwv5f/p7vv47A8QONT2mxDfc5U0NMZAaqdpA8l6Kk4tTvclWx2BxA28DzPRf1gzyTED/Qlw30RqN19KGX/UvsINC1bI2uKVDndAFuTpFWfIC+VaTYyN5uPgc2i8kPN43rzexXTZDttLWHRBzLV8Ju6dVVlQo0abA+5Z/mZoGjhKbbQqnzLm/IUpMgK3V+XXzxduM/ky3+ZP83sipJeO2RZ+K5yTFRUf7B7qMXfnz/oSDKnxDqaiD8ZtFnkrpY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAYhS7s0vj608Vj2eN+nnwQUDhU4jD2SfJYv+St3vbo=;
 b=oQK8I3psWICm5m+Tc5AdRXD+KU/rdVBo5wUqkDOBiauAddq8boz3DNzx4oDFp06nEE+oCll9FIvF+Y+5vtec0MVKgb1gZQJtgjY9RN3HZK9p8eZut+iug4V+SNzUTf5z7zM7XWo2GazFFGy5MsiByeowMwizAO28dvaMCUtAiyQn4EUFhv5fZWr2xZmrWpwfkEGAznrBi3r2jbdVzliJw+icP+XNaoQnpzbeaVlno5WqRHKL4VWZ67FJtGM2IyLfhodsPoB37e48P2MKlke4nTS3SQ0xZxNPCFWN4rGjx8JajCZ+G5bSe/3/XZ0yX+U1RWEL1zcS+sQwvUfc1dnnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAYhS7s0vj608Vj2eN+nnwQUDhU4jD2SfJYv+St3vbo=;
 b=mZzTg1DuEBOYUenX51GOLfmxTjCReZ8QkIkdU/5cVdSBDN6cYtD0rERen5M1D9BA2huZa/T2MWDDZKQ+NVlGEo9rB/5uNo8xcl2CR5ft8P1T0VtCeFltQ574RgLGmOKdXMso4y/k1kG4X77V19bK5OY5jE6uP9m+pkk68v6UWG8=
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by BYAPR02MB4887.namprd02.prod.outlook.com (2603:10b6:a03:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 15:08:55 +0000
Received: from BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::e5) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 16 Nov 2021 15:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT048.mail.protection.outlook.com (10.13.2.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Tue, 16 Nov 2021 15:08:54 +0000
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
        id 1mn04h-0008P4-Vx; Tue, 16 Nov 2021 15:08:44 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v9 1/5] device property: Add fwnode_iomap()
Date:   Tue, 16 Nov 2021 15:08:38 +0000
Message-ID: <20211116150842.1051-2-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e1d0d8e-89b3-41fe-873a-08d9a91301c2
X-MS-TrafficTypeDiagnostic: BYAPR02MB4887:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4887916685E8D09DB5887608A9999@BYAPR02MB4887.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +uCyi/lRMOQhDaWWMU8FO38ExsUvhwFOS9jYCxwyACQ7aIDlrlT23DgLRuCP1hrccmnzR1JKey9UHu+b35m9hDgVtjjnfmMDyr1ob5CCVvtgAmRtX+62o9vuVXR7fvNUKZ15fr+6uHY9yVGI0zdlCzJsITuU7BCFuOaP6FeNl8lh313ED72WDLfHbIlE8MAaaFMyIpTsKi3Z0M8wBaM8SC3Ch1SlQtWCMdq1jntPbvwGzjqd3CTeexeuXTeIotHiHmMEhUViVTwG+xRihByEifmnmbbbHQXRy7k3QNxB8Nxwza9OQP9K58DrqP9TfaWE3HmHyhU8tgXuOK1P2Ymx7NmNGfcg6oEyIaOG4wjIqTIYuWoGHCYh7KhJdYqAN0AtcKZ82VtPdkovY6YWbiaUufTW4jdaqCcI+VsmIhDOavD1OZUPd8ksYsf8cBmNHAhA/AqB5pXHq4Ua4elwiYVGq33EjfduHTPadlWlmFIGw00B3kcPbi72ZQ5/kG26msvjsrjMU5Ws3E8DYWFxbAGTKVU6wQoduignYUarZyV83tBPAfDIOzOmA/gcZPz/TX6dvvQeBPWRBqZr3ft6ZAGpLl7oe8k72Whlj+LfEzvL/GT50fike+j5/gCUZUSaWjua7QBDP+VFYDBycAvdxDnzAH3q+9670v+NKYrU6K/HpeVPvTDVB/eoJKLUnv+3cau+0QrUzZTWC45gjeKF9eRFfipwf6oEpOufyKylhtTkregTWP28f0KO3eItOUvuzjWyZOZYWpbYARZsh5N2AQIB9b4RR+xDpN7ivV/Pt2wNF9M=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(70586007)(103116003)(2906002)(426003)(316002)(356005)(36756003)(107886003)(36906005)(6666004)(70206006)(1076003)(82310400003)(7636003)(9786002)(5660300002)(26005)(508600001)(4326008)(186003)(921005)(8936002)(47076005)(36860700001)(2616005)(336012)(110136005)(7696005)(8676002)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 15:08:54.6945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1d0d8e-89b3-41fe-873a-08d9a91301c2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4887
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces a new helper routine - fwnode_iomap(), which
allows to map the memory mapped IO for a given device node.

This implementation does not cover the ACPI case and may be expanded
in the future. The main purpose here is to be able to develop resource
provider agnostic drivers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 drivers/base/property.c  | 16 ++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 453918eb7390..d2cca7ffea18 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1021,6 +1021,22 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
+/**
+ * fwnode_iomap - Maps the memory mapped IO for a given fwnode
+ * @fwnode:	Pointer to the firmware node
+ * @index:	Index of the IO range
+ *
+ * Returns a pointer to the mapped memory.
+ */
+void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
+{
+	if (is_of_node(fwnode))
+		return of_iomap(to_of_node(fwnode), index);
+
+	return NULL;
+}
+EXPORT_SYMBOL(fwnode_iomap);
+
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 357513a977e5..9bb0b0155402 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -121,6 +121,8 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 
+void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
+
 unsigned int device_get_child_node_count(struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
-- 
2.17.1

