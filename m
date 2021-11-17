Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85A5454AA4
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 17:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhKQQNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 11:13:48 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:28096
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232144AbhKQQNm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 11:13:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JngBKGsxe2uZMWvcqLvqSNkh1YkWTYFNEHW++CfCCdi6kVnyJpRzCiwSqHf+wM73DlB3Cg62AFxH5DNSkzgUYncRLAdv2HAWZuoHEEVlEI4NNBRlRqCPKCg3xF/3+8sadG07KBGRMIUW52KvOF9Z72vamHBRkjzhhLmEMrT5krhhjRaibbbF6gS69r+2d2rNzyHNqC8fwPbG5RuPbqlFeehaKSCGA7FHuc8sI06BsUxVf/CjlYdfP3j2KqDT8ZrkOJq3YIKUKzjKqUBZUUX3Wk4339MP/55vhozsArZLPpH7NPsjHsertBYozLq7tRTFZP052i0Ti4fIihvpv/YAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmVlCzmvuBcqkDONTtQyAXgD120L3C519ZQiyfjLWIw=;
 b=Nh6IfSnw+QsXzqw+CcQiCf/JHrL4VAQk6Pvpdy48OoS98v1/pVE7d21mrdVO2nTMBibWHLHnL7HYcdJAvfW9jjgQV7uElj4CSR0nri/olTBsV/k7RfnnVOYP+C+ooR7YDSLl0nmHh21sB35QydqKWXWKI4mOzk2pGVdN+uNcQdBf8WB3IFru6STm9cQMu+/M65pvlVh4a9qUZuOUu8rOOZG6aTs+pdvye+WOwyw+hRIh8uyJm+tNRQOB2TlLuMFuBLeF6tXYqQdoHK1pnHaKiXmdplJ8AT/rrDehE2H6CPZD6Q4CuACa+1w/7n+2mxygxXFLtZln219npvPAsy5tyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmVlCzmvuBcqkDONTtQyAXgD120L3C519ZQiyfjLWIw=;
 b=og0agyO6t42UpmuJIpTsBTBSK+4uuAKeOAOZucNJrq6QIp8CaV0Yxo4onz4keFamiGJ83B0JQ9vMR7+/DWDbbNx/FGUjEBSRV/tkvFZdu6tp6QMcs+eIrArQXJjWT6aM+P9vF/3XioMLSeZdK2x1rJ902e8+iHMbpQepHO6rl1g=
Received: from SN2PR01CA0012.prod.exchangelabs.com (2603:10b6:804:2::22) by
 CH2PR02MB6759.namprd02.prod.outlook.com (2603:10b6:610:7c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21; Wed, 17 Nov 2021 16:10:40 +0000
Received: from SN1NAM02FT0011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::a0) by SN2PR01CA0012.outlook.office365.com
 (2603:10b6:804:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 17 Nov 2021 16:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0011.mail.protection.outlook.com (10.97.5.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 16:10:40 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 17 Nov 2021 16:10:36 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
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
        id 1mnNW2-0000gH-1H; Wed, 17 Nov 2021 16:10:30 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v10 1/5] device property: Add fwnode_iomap()
Date:   Wed, 17 Nov 2021 16:10:24 +0000
Message-ID: <20211117161028.11775-2-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa116cb6-51f4-4f59-e19e-08d9a9e4ccf0
X-MS-TrafficTypeDiagnostic: CH2PR02MB6759:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6759B25F66B35E3028F3A6FEA99A9@CH2PR02MB6759.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Q6IAqYoD54m+uvR1mGRtw4/GXq8onMj+smqvX0GH3KjcHEPhHTNxog8Aj51idOhaXXdC0N81yvHIDavse0A8yW9AJDNH5G4CKMBhWwtxJCeQgwQV9crDGgNwU3zsyYFCYsIIiRuFBSoNgAzUZafDfUV2Y0ar4cisNnfgAJxn72JgR742M0OD8SblvcXAt2zfSQJv9AUZ3i8IIy77T46Mue4OLzgavd2a9pRV5kb09EAQZgQYggoKIvz55pMdzSmMQBbq/ivZSsKRJFj6nlWre7VJeF5u6CZrP4M/bCwx5V7ShqkDV25uHbXq2/Zm10bFxCDaIH5vHCcyfcAfK7blWm6Sp5DWwud1qnn1kevUVElRkkoqb0DMqMCe9hDvYr+6jKkLRCNf54riXK8T53CFEPp2BItMTl5Kj69v4CP53DuCBnq9KwBu5T14W72MZCij4jm62aIPdCuS8NjNFQhinJLJr3EUF0FgIk7zsA5zAIvrfa2xrkNNyKy0swFJjBvri9elUvrK2VrtVDO9GFmP1nmqB+R7oLQ0ivBZRl7MEJHmwWoLHcspFu31U86sCSB3RuIMMshHri56HGHgqc4U08h9l6dq5Pl5gPlyPUv8+ke5ZrK/SY9/KFfr4Qxkw6YrXe3OUR+LF6X5jWila1ZM43OoBzUqMUfBWeTovNHpuV8DuxEYJsZ/l0em67LjR5SR3BSwOpC/zdLCZPSybBA1p2RswVBRCheiSvE8Qk6ktRojrIzvj9cpNmVgP9VSeIes0jAlr4zqPSPoDMNiqMQ20pbBUXDbsmcx4erp9daqxA=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(921005)(356005)(2616005)(7636003)(6666004)(426003)(70586007)(5660300002)(336012)(1076003)(47076005)(107886003)(70206006)(8936002)(26005)(186003)(103116003)(4326008)(508600001)(7696005)(9786002)(36756003)(8676002)(82310400003)(36860700001)(2906002)(110136005)(316002)(36906005)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 16:10:40.2923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa116cb6-51f4-4f59-e19e-08d9a9e4ccf0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6759
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 16 ++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f1f35b48ab8b..f2e38be3a999 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -958,6 +958,22 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
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
index 88fa726a76df..6670d5a1ec2a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -122,6 +122,8 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 
+void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
+
 unsigned int device_get_child_node_count(struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
-- 
2.17.1

