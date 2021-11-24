Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56745D089
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 23:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245200AbhKXW5n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 17:57:43 -0500
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:12116
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244373AbhKXW5m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Nov 2021 17:57:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vcp7q2fAAiplfOzZRWqCWNAZ143Z1xgcqElxSJGFVWN8UVEbpue1+XpbDBkTF1pKTtnXi10g+jdiq9pnRp4QtNZq9E1iuNm92Gy5WSvOzocKycdXIGMEBbMYkuoSNHZDIpKYgpWa9tcae1+0vZkiTDTpia42u3vvF5lrP+L10+38SpmE4bSnGmJ0oUUe+jOkG10dB+bQRSGOQ+3qHCf4L45aCcJpNfjlVaZZDiPg4HQ6SasH/uonv4UovFyvqzd0fjfvmCIn3ouK7/JFMZrqNIN8w53NGtYOv+aXjZrprgugaIZ/axUC3fPRcprsgnWeaXCqu5JL02iJFtgair1SlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmVlCzmvuBcqkDONTtQyAXgD120L3C519ZQiyfjLWIw=;
 b=mgH8dTw0rTgFztpIQMrptQE3vVWdjHkLVH8Hh8ciRPzxa4M87AKdPZ0GPIcuxNTrEqs3Vul7nAZms20nNrvvKj10FGFYI/3jdd7W5EwyMeNI5H4WdztpkK2fSOmwXhMG4LqZbZN0mO0b63O4lAUWV3vHkPTETiVdCWOca8IoljCtGNsnBE1P4ZLajC2C9wYYVF9oab8jhLVhiiYaAvSuw9WpfJ6VhR0/02FzK0Th4Lrw4ilMBQbCX7kMpIOagfJJKjrzNvV6lTW4bAukuSMFA5ZICa6zgTucXOmEMBfJWFVNds17rG0DJowixI2nb4XHhI4YzxmPWIeZ6BjyUEFibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmVlCzmvuBcqkDONTtQyAXgD120L3C519ZQiyfjLWIw=;
 b=iI0c3t8E6roSLDKz1SeOJMzMyiuqUPEjjuCWE6GKotsGC+kTIVzmuOOxkpCsrDH0duNgcEPNGSs9vbw8i6+1Iy3yTgf8RH1BcdiMds3d2B2sxbSOfecNbP34BIrZdI+6A2qyT3jlBVEXn1q0pEtyRW1q4aLUQ6/xU2dzc7QfQus=
Received: from BN8PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:70::40)
 by CO6PR02MB8801.namprd02.prod.outlook.com (2603:10b6:303:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 22:54:30 +0000
Received: from BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::3d) by BN8PR04CA0027.outlook.office365.com
 (2603:10b6:408:70::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Wed, 24 Nov 2021 22:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT029.mail.protection.outlook.com (10.13.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 22:54:30 +0000
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
        id 1mq19f-0003SI-3g; Wed, 24 Nov 2021 22:54:19 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v11 1/5] device property: Add fwnode_iomap()
Date:   Wed, 24 Nov 2021 22:54:03 +0000
Message-ID: <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991491d0-e706-41ea-d569-08d9af9d5fef
X-MS-TrafficTypeDiagnostic: CO6PR02MB8801:
X-Microsoft-Antispam-PRVS: <CO6PR02MB8801988D9FC70A3B2FBE70CFA9619@CO6PR02MB8801.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1V5S+mpSnIAQpgq94/zwN+rpGWWQ81edunF04Af1fP4okE/YB9bmAY3C66KIsIQE5I/PbkMJAR+3Zw8WqNbGmPZeD/QwKiYNH0D8YnRPTRUJQlv0US3Hu6GAmU5vulUid27xUKKuDNk/Gyic11rfz/UMA0p23pewyae3FsDuSopCf0YT2/pFCjlrtZFy5YSrCeDgC2344tJjOFZCtd/FeH3wRP8NffcdKCNmOaZQAnpErzIum28eWFeNJpDl2IAXKKHMXK/tkF9c+AUBl/twwFnGTNR4Wgq0+gRXbFJVcjvqRYOREAzxsVlRYYltp+Jc1Nko4CYL/Lgaj4LC25zicBr8NMbwvre6/4PbGHEskmDpG3AX6FAniFZ4DtOXKfeW5CjPZFZnhr7uDzv/h4eb0ctK6zXoaInxcUROKYS1kb8dvtuptKGMJmzHQJjfEqcXVglHZ+N6LLUe3aT2RsqjHhGtX0phpG3M1qFhb/s4YsSZyB2yV/Fs9BWcS5ZnLWUW4REoRaPxnZv32VR8oW6RGXT66mfpFZF8wJjNeQBCh7HAws+qsy4PF9ellurhaDWlCO2JHoB0CvsevsnJIyExYj1apO7Jp4ppYUzXoUjGpEn74j9JNOWdO3jMXcc8egQ7Zibwj1fVuDo/IYno2etqVLCg3SRubQ1pv1O4BxcBt22MutCqAtu5quPbpc7ioGGuph0Svh2pRFssjbsG1B1zaLzuCeb377uRTwwBTv6wlGJI1xGC1kpvY4fZZ9VhjApRRFQE3tp9jtXDjRV1dzt1kbL4V0RpVB3gRquy6vk2JU=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(47076005)(1076003)(110136005)(2906002)(6666004)(8936002)(356005)(4326008)(82310400004)(5660300002)(36756003)(103116003)(336012)(7696005)(7636003)(508600001)(316002)(8676002)(70206006)(186003)(107886003)(26005)(36860700001)(921005)(70586007)(9786002)(426003)(2616005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 22:54:30.2226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991491d0-e706-41ea-d569-08d9af9d5fef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8801
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

