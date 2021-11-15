Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDBE450CC4
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 18:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbhKORnH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 12:43:07 -0500
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:35361
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238543AbhKORl1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 12:41:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEveHnJ69uZpRVY0LBDLeIWU42nFUK2bTc54XuQpv7kXWh5KEzPbGsur7sn/vU/xcuLNvGVx2lAh2st9SA1gWb/R3TiifGsHJkw9LDUUhPlOGS6Z0G/bQ9edJlS6TbHbAe7rJiTSlcpcZl0H7Riox9mnje0Ebj9eAlGYr2G12sJqzUYBa0uX3/oN80vLrRhj36NiPoaFcq4IgeFGnvmFyZCUPaDhuqxaWbeao9ISsKSTzwJvpE+AxNE2IMuvQTg2TO1G+ZFtj62pXAdCkIeYKqkpsDZtyYqX+NZYHe8sEzcvh2uGNBs76ib8B8hTKUMzYoItkI+AGIpPhcpcBJGmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWbtneqZm7WH1cdoAmCqw2wnyVnRgLPln1Zjiw4MviM=;
 b=cCBL3/czfid15HbQUsRTo2d6EIRG/dDMr2NxypdBYT584AfuXtZKOonlU9PkdlH+nkvBBeC6/wR+af3HgFhxNpBeAu9Wc8gXrGt79/ZLecYhajf2gF4QvsEYl3wL17TzRoVIv5lC9DW0IWSXN6BmRL2t6DAbXJhAECenH2Iu7GnVI6I8E9iC53azO9VtCTA2cLt5hRB2vR+XSaVP6lmZcxUbbbwh0IjWPjjEOa2iIQPQDZPPf5bO37g5Hdm5tYaL12KrSlTC02p0pMKVyqKRQIDdkU2g06cdxnQinY278ad6NFB56tjI8HVLzV/eomSuTsfmT+Z44Oz4VY17kOs8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWbtneqZm7WH1cdoAmCqw2wnyVnRgLPln1Zjiw4MviM=;
 b=MCb6it6v+aDmLoHaHaoCtmdCjVKFlxqvzZeC2/ise/APVANIwUmJvt1Mm7CKW/BgWuOe60Ojo/eHWUtFEx0vrzNlR+W/I2+p88fmCrnM5DGJkPQzHxtbBPivFjwzkTq1hPgXGYkePEUHBTo7zJ/GkHME9b/SiiiZmePl9ZK2qyE=
Received: from SA9PR13CA0078.namprd13.prod.outlook.com (2603:10b6:806:23::23)
 by SN6PR02MB5166.namprd02.prod.outlook.com (2603:10b6:805:67::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Mon, 15 Nov
 2021 17:38:30 +0000
Received: from SN1NAM02FT0005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::cb) by SA9PR13CA0078.outlook.office365.com
 (2603:10b6:806:23::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.17 via Frontend
 Transport; Mon, 15 Nov 2021 17:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0005.mail.protection.outlook.com (10.97.4.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Mon, 15 Nov 2021 17:38:30 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 15 Nov 2021 17:38:27 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 15 Nov 2021 17:38:27 +0000
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
Received: from [10.71.188.1] (port=56032 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mmfvw-0006sD-7j; Mon, 15 Nov 2021 17:38:20 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH] device property: Add fwnode_iomap()
Date:   Mon, 15 Nov 2021 17:38:19 +0000
Message-ID: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a2f6bac-e00f-495d-df5b-08d9a85ebd4c
X-MS-TrafficTypeDiagnostic: SN6PR02MB5166:
X-Microsoft-Antispam-PRVS: <SN6PR02MB51664D444757A6A0F3D9BA60A9989@SN6PR02MB5166.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ak5Ekc84PkvSqqeOSL+IXViKm1r9x4rjMpHbBpJhtVOvRddPH/BnAVWG1ahKulTMiB6PFM+fVbqc2p2ra7r5VkM2Y2Ml4KoRuXr21DVf8q+T5yZ4c+C+8H4a3Is/brkgnSEumWwaK1jiPfY7fDFn9gsb+m3/EerxPK9YgxPoLpSnbcin4B67hgC/D1UBqfpC2Y/XY0ZxLm3PnxXv3LXw4TA09KhRl15URl5emcrX1moJ1N425KAg3LSkp6ZJH6JiCiqiwbWATQAqcIrm7TXT/dKU9w/KUyW/mOlRxDmfk4MP37744KUiGjr40milneotIZoqVqd/mBBmWfmN6HmfO6uuFVo8LP1e31WC5tSXxHUq1o+loyXt92Qozp+4CuqnM4l+I1qE5kxuIWSAXlnN4/d/11Y+b1v0to9QFyULeFx402FA+w0Qx2q9fyYdnEWfBSG7CVk08eRNf8GzhhEeUMd6GIXF7jJUErlHQ82XBilJTzE2TH5vn6CcXl7PlcN+mkZdGKEF08C36vT3CNYMA1pr/VTjhtMyHylG9LPXktjo6ZaacNFrswdOWJ6gvAYkM3OMaI4phUINOmp6FcSN0+Ph0Bw8VgyeFpRcsxwPH+TcVK4akLho+UTpWeObMnKjb58RAIkaX18//NEfyphfNcFPCwfzIbaz8PdULkK5IDigmJUK2P/VvIV2feV61SPn/xiHWPFH8VURKuNy+2lRoynogfHGuoqW68PsB+USoKhV007DzDDVtEZs01JcTY65y0+W/xxmEVpnPIT1K8PgfrqFvumLozo+WviBi9UHBBU=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(107886003)(5660300002)(1076003)(356005)(2906002)(8676002)(336012)(921005)(8936002)(508600001)(7696005)(4326008)(2616005)(82310400003)(7636003)(9786002)(36756003)(110136005)(426003)(70206006)(70586007)(316002)(47076005)(36860700001)(36906005)(103116003)(186003)(26005)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 17:38:30.3270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2f6bac-e00f-495d-df5b-08d9a85ebd4c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5166
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces a new helper routine - fwnode_iomap(),
which allows to map the memory mapped IO for a given device node.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 drivers/base/property.c  | 15 +++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 453918eb7390..9323e9b5de02 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1021,6 +1021,21 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
+/**
+ * fwnode_iomap - Maps the memory mapped IO for a given fwnode
+ * @fwnode:	Pointer to the firmware node
+ * @index:	Index of the IO range
+ *
+ * Returns a pointer to the mapped memory.
+ */
+void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index) {
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

