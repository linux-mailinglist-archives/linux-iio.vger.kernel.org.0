Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903AC45D092
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 23:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352445AbhKXW56 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 17:57:58 -0500
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com ([40.107.237.50]:15767
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346935AbhKXW5r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Nov 2021 17:57:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVlmMZPD1V1J2ebtSgjlVOTXDlBCqQaBuMYqB0pe6kW9+vN6AbVEZfUrhY3CNoE0a+6Tf6sYMSqTVs8QpBl6ugaGAhYlAtWuc245d3S3S35BWy6BnGnG/4orhBVbeLvX/e9kji5jH9uLfLV1s/F1sys0xPHdtQLIVQbkvrlptoa0deJivkMjVC5WRIle/17hjjxMAcvWptZ89bqkD/DczozbkRTreTFGRc1GjT9obpNRHUd5Uy0MTaUAQoweW2qkQysWWSinnD+qCKv0PfgTNtSCoZ3B8x9BUMp9P/hOnhxINdoekDEis5UA52P8i8UwqNEyZE3moLIt9pPEWoxqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my1jnLT6TU7SwBAdjPq4jOjjxnFQpEyXvE7/nxVtu3M=;
 b=gahA0Livuz6eHJa8UhEPY9uff/CLWVcY5BZ1H3kOKr97Jg+y97BW4O/XVX9/rKJz36DLF5FERoTBYaoMorqYu91+TQHiFgyTcFd4i7b/dyk4sbYmTuDgOVysrhf54XHAZiBoc2n7O9RCP5edQxguEV5BQ3uL69xXtko3wP8Ce3pog/Xz57UGfpJi1+9zlHugxfFbPG+9a3bCkLzkdLXFQLcRLBhLVy2QlQ7VB7TUnRVHcZbcSCMv2AeJus3YtOaAQeWyrEIG763p79Tnw46ZgXCJ/+K+iEI1ZYsEDkrtylxviVYnMCIg0x3dg6qeCUxvCTJJw2HtoyKdnCSnqOHc2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my1jnLT6TU7SwBAdjPq4jOjjxnFQpEyXvE7/nxVtu3M=;
 b=R5YWsXyzE7niHXjCAjEsZalxeoTzgoC8S8idBpD2+BHtVKSD9nKg9WNdBufWbHMrXbbVR7T9bWy2MFrhxpxp5hr+RWhq5owwIC0qgpgIgpilUMp7QI2pVBBxbF1m12UHuvXMl7bh01QC7YyaW5NG2PIUM+L2/S7/bLDZsBW4Vi8=
Received: from BN8PR04CA0009.namprd04.prod.outlook.com (2603:10b6:408:70::22)
 by DM6PR02MB5337.namprd02.prod.outlook.com (2603:10b6:5:4f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 24 Nov
 2021 22:54:33 +0000
Received: from BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::22) by BN8PR04CA0009.outlook.office365.com
 (2603:10b6:408:70::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Wed, 24 Nov 2021 22:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT029.mail.protection.outlook.com (10.13.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 22:54:32 +0000
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
        id 1mq19g-0003SI-2H; Wed, 24 Nov 2021 22:54:20 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v11 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Date:   Wed, 24 Nov 2021 22:54:07 +0000
Message-ID: <20211124225407.17793-6-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54122937-f749-47cf-a70e-08d9af9d6187
X-MS-TrafficTypeDiagnostic: DM6PR02MB5337:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5337618003ED5B1CD49D1D87A9619@DM6PR02MB5337.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkVv5C4xYnyKNChHrvmffV1O7z6OUPGrviYlz9enD4UR21uxW6kjW1TlWE425DkGPEKziQmDB+qvs5fQRDwXuHYUStziLpPnaj7v9a9eiVbJCMxbmEXsw6w6llX3WeCRnu6vIS3WEfZcZVSv1NsL6JNwhkq0ePrWxd0D0axnY4fBlh4JjGKz03wCVaqY67JJprITLT2qJxxRvBLy6zTkoByO7gK1U/XHtSHl6Gmd8hYQS14SA4QVVNmyAp1orc6/fggpWMrj8Ntfw652Mft7HI+Dq/Hgjsg/jq2ldv7X25vr63wJ8R2Qe+ITwaVAbsV58hI7Ql2GuWgn6jM18uKCXvO05ZC3pT44Ce8yTTIlP/xtCBHzPEutAKlXhANGXag5+Rvac4CoQcgIDcwssrt9SHQCANvmHtW37HGTEA/eGAIFvaBzFYU81mpt5XBs9jKHcijbQoNFzZGcBL8gmosV7p/CFZvCMDnvPr3bdXOKpSr2XVsZH/YXq24+YAUOIMcRJYpUDP9LMIR7Y1/re/64aHW6sZMist+ouldv7bCqZ4KciEVuqk7gmZTEO7eOVFldlHe2Hx/5ZAAJHfbUzelHKM1J10RXpH0X+bqurmTA5EjtS+0k+3ttJGwAGZuE3rAy9Mjn1L4w7//aezLjXNZZxDBzQ+3jHP8mnVeBmgZVZ3d+uiE4AzhLnKrEDZAUWKwq6wwg75ZmSKJH3YhLN2h5RBPx82XqWx1gRiOF6xf2ZTO7N6DiVkFOxp+jLFfVceBd5fei9JgX3AmOTOmSOGZhM6Upy4qf0gHkVFWPIDwkJZo=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(7636003)(70206006)(36860700001)(70586007)(47076005)(5660300002)(82310400004)(2616005)(186003)(7696005)(103116003)(4326008)(9786002)(356005)(1076003)(4744005)(336012)(107886003)(26005)(110136005)(426003)(8676002)(508600001)(6666004)(2906002)(316002)(8936002)(921005)(36756003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 22:54:32.8953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54122937-f749-47cf-a70e-08d9af9d6187
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5337
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add maintaner entry for xilinx-ams driver.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..64d6a06b22f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20862,6 +20862,13 @@ F:	fs/xfs/
 F:	include/uapi/linux/dqblk_xfs.h
 F:	include/uapi/linux/fsmap.h
 
+XILINX AMS DRIVER
+M:	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+F:	drivers/iio/adc/xilinx-ams.c
+
 XILINX AXI ETHERNET DRIVER
 M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
 S:	Maintained
-- 
2.17.1

