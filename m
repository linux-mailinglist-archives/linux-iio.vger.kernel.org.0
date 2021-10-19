Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F32433A31
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJSPZJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 11:25:09 -0400
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:38632
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233787AbhJSPXO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 11:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehURB/ck2BgpjBH7Bug1fSiuiVvmK1uRNmXYj3NxhrSnypk7NCv+G+XJ2y9Rp/HGe+X1/HIUKqqrWniix9qJFQkAuiAdJHnQ5ceUeK+5KJhRIWXhHldf4zZAf9jrqQV3fZovzGg1jhSAzNAP4MEvIukVeA0p9Nj/ZtTiUcuL4nphNnR7ntIW3rn0lRcX9HrsNUaVaeHyiB95USvfvlvFhOSZq+duOq2ZPWbZDJ6OMcQSl1Ve4eUvdWCa0FX+sydzb34c8PNaD/QsJwaYG3yKi8PgMZjVjOKI0k7a+HbuNYAkIvg9//dPr3mockH2jYtnuIfpTJHnPhowOdqQh7YYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLZHeiCTDLL8Jch4HqmG9ai3sPRAcAzH/2EgW/tEcyg=;
 b=Ns6MfyD0EVewBKcbar6YaziArf9X1S3X3zhcxcUqRNWzbph5UM6SvMhXPxvMLzqAGa2oHWB8r0btG00kJr2wnvNJzPZbxtN4WOsgY5amJFQ6PQBkW7Zwtg9Es7n4v6Rp4BuVqaYO65mqPN92i/MYPXBlp+E36QrLxAFvhT0PRYClw7zhX9EW1hG9pnG04eyOHzFVk1cbSUGA6UMvWUvNkg7k6CAoNt1u3zmCM4nnHPJTQbs4WSrLFt8j8uKSpNLO3+yi+GYAlJW0hRR6pIKdvwkdcgMjhdkQ2WSDlPzqClcKTr2h/8vKRCCxShQu20OVLiBDTGGbpar+YATzHFN4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLZHeiCTDLL8Jch4HqmG9ai3sPRAcAzH/2EgW/tEcyg=;
 b=OiZtIt58B1OVPzTbcfSdVV43fb75q22D8H0vMY4OGURuKOdWt4aVLprRsC5o0Oem/b3XxsxdLCWC22CDOC4le6OjmJOEa73NVY3HmX7fXq04WgoXdApEt+g7xJMrT8d3HAeX3CaAMBe95Upqths/8pr58gssV4dUXxQbUhtSV/k=
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by CO6PR02MB8802.namprd02.prod.outlook.com (2603:10b6:303:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 19 Oct
 2021 15:21:00 +0000
Received: from DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::3c) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 15:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT058.mail.protection.outlook.com (10.13.5.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 15:20:59 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 16:20:56 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
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
        id 1mcqv4-00030B-8P; Tue, 19 Oct 2021 16:20:50 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v7 4/4] MAINTAINERS: Add maintainer for xilinx-ams
Date:   Tue, 19 Oct 2021 16:20:48 +0100
Message-ID: <20211019152048.28983-5-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e90d33-1664-48dc-7ae7-08d993140e86
X-MS-TrafficTypeDiagnostic: CO6PR02MB8802:
X-Microsoft-Antispam-PRVS: <CO6PR02MB8802E8E2B12ADEE59D9E99F3A9BD9@CO6PR02MB8802.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIYPdNKaI/nPPp13Cm46KyR30iiBmedUmr2W0qdN7ndOGIlTkQEGjqRHk2zDixaDEb5yAR34EL5BV1a4hXxiNsvWRH1p1Fm8ZW00vBQLaqyh6XZGxSEp4TlIXJALvzStG0zXEbeIGixa6Kvwt7mreUe9LGPzAEUQ5MDh+8CoY+5K/zASsRk1Qp2ZEWsqGJDo3VuDcJZ171M4V9V+jaU/ga3jcc8a+S6KiHwbYl1TewbCQodHHRcQjk2YFHRPmFP1LHL/ANvIKzuFFxFpDND4hbG8Wh4GqRDCWl80fGG8KDT8Q64fePuTqT2+2TIMRIcvuNuIUlPP4nugJfY3Z37KpwBkFZkzjeZ4hWnIOlXKL45P4c/Li4bM63cZt7LXBqsGlERV/92TI77a0W0zpD2k/BiHdgbrnLK/Uw5ApVDl2WY/rwsEZonFA3dBd8CEFL1AcJUvTJNX4fjQZ0JAEkZMo9xTiNU6hrVz6qlywV2rjgQRJbNxJbv+LkPPJ6gXzda5YrC9vgtq2gKJCsHNhZhWE7WSeFTP9pT34e5eDFZM2LrIxPJ0Fcv1ws44iYwRm2yVATTClHTvnSDdezuNdR20HVkroVgLcAxioaLpQGmCeIdMZ3bykiO9jFBEaVrThYMbecJKeaCP1sPcC2q3A5WAzMzf5j/YhjjDQQMX6/ns+Myybxc5czg9I2WOmMogvJ7RsrAF8ryH2wAWksFPvleDkRA5TFoRbOHwvHIZjW4p1eRYcdGK1axFRqy0l7JE3fnr
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36756003)(110136005)(82310400003)(36906005)(8936002)(5660300002)(336012)(8676002)(2616005)(1076003)(426003)(26005)(107886003)(4744005)(103116003)(186003)(508600001)(4326008)(36860700001)(7696005)(2906002)(70586007)(70206006)(316002)(7636003)(356005)(9786002)(47076005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:20:59.9720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e90d33-1664-48dc-7ae7-08d993140e86
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8802
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add maintaner entry for xilinx-ams driver.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d118d7957d2..d279c170a4cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20573,6 +20573,13 @@ M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
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

