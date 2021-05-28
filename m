Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F80039466B
	for <lists+linux-iio@lfdr.de>; Fri, 28 May 2021 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhE1Rby (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 May 2021 13:31:54 -0400
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:57603
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229473AbhE1Rbw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 May 2021 13:31:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY9lc0SzldOF4/eKiW6ixnDLLzZb1bN+GMqaKgzXTcyCH42oj16FZfS9RzLCdpD3M2WMg3WQZKD09G5Gd+5Wzx3Skk6AcgXhGfMjAGSFaDHWogOEaFgoVdwMU/3TqmPyO0VQJ2BnnLrm2kbyDFcwm2cAl0quf6Pbvo/cOktSqn/ilWP9IBUf+e24nFVJM/ObM5ki1WWcDUb1PUdDco3ChUHBoTjdX4tjH08BfHQyH/YoOOSEuypt6f3o8DZC9+RNPNTKIw2onapXSj2BSGaRfLkmaZM+QeJh5yv7NDMGxGeMBEqFekFdo2o/LV3K5LA/vhUTZ6QbwDTGO1K++eOljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6514ixAazrHT+SSXs5QOr6+14d2fcaFtY+hGhYKjDo=;
 b=f5QCA8CK6n8a7tDRoH+hlYAdO5zTLok04lXXRzQEZVZF7CTulboiyPwYZ68a99kFBXM8i/cJ6sbs9zdMEJt4a4YWV2qFe4UNh6MBTUtssAcGYdFU1xhuvs5yWAdAH74AiHyEWRINROZiyAEcKHi5mjToLwklDvsjpyDBrpyi34G7H/iYgpeSe375xYeYYIEfir/2ylqEPaOzMUxSskknZmxRvYIKNZCYsFhCgTmstV3WEwAPDuP+O6rnrJBZbjKzJgQghDzBKCrhzC94hVIfV8s2GMKWRi5ZWKWbO64RTxGN3D88bl7A+uyxKuXQ6EodKE7HKVvrUvsjL6sAPzoMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6514ixAazrHT+SSXs5QOr6+14d2fcaFtY+hGhYKjDo=;
 b=n/OrD1qCsE9m/6dotQI4OvUusBzFtoyGayAUEqXTEpBRjUysKotsQ8u+FfP3qYiB7MP3cDlF4phx99Nfxc4h5sefW248EXmjErkGtV7SlUWnMm+sPhbb5mv7AMG2CaK3EqejL5vOU/mNy8Yjhv2q624nIPS8wCNZX/HcN1Ezrbw=
Received: from SA9PR11CA0016.namprd11.prod.outlook.com (2603:10b6:806:6e::21)
 by SJ0PR02MB7360.namprd02.prod.outlook.com (2603:10b6:a03:29a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 17:30:16 +0000
Received: from SN1NAM02FT0049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::80) by SA9PR11CA0016.outlook.office365.com
 (2603:10b6:806:6e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Fri, 28 May 2021 17:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0049.mail.protection.outlook.com (10.97.5.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 17:30:15 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 18:30:12 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
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
        id 1lmgJA-0004hp-Gk; Fri, 28 May 2021 18:30:04 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <git-dev@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v5 4/4] MAINTAINERS: Add maintainer for xilinx-ams
Date:   Fri, 28 May 2021 18:29:59 +0100
Message-ID: <20210528172959.15663-5-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com>
References: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 566b5312-55d0-4d93-5aa1-08d921fe41c3
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7360:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7360E1128AF962921E320590A9229@SJ0PR02MB7360.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pveMlHr4/tkvtfdZEnrycqWQME/14OiXr+7xX335kyoLG1zJ4H5Td4yDb+UgSSdq8oO03q2LFPgAhNfH3NDzEHYEvysDGcfmDDjDr1W4cXgywhwBWBeWgWlTvHD7ia9TtnoR0sKg6LyDEZlzxw880OczthbN8wvn1QI3+HUfc6SdMuAJScaA28evXei63BDIfW5/SFy7EOTr5tkkYJzQQrCa7T+c8TBe36U6X0tVqlZ+mBEVJFjRQXFZae9SYfS2m8UEB3FkKqlgyoMZfVUDjrGDvi3LU+lcscCQLEbaefACYQoVB7qakpoadXJCRqTFOG4PgJEJAqeWW6xEQAJN3Eisw1TcG2Yr0PQQeLHLCl+1ZHtEQUGOAtrKXAp3Gwz6+Tlb8tXoD2KCdfB6Rqo/3J4ECYvf3PRIpDdiSRBVIPl6cVsGPNdx8dARJQp/SuzSafgccnoLjYBHDMyDPCp4KF1g/78U5/y+avby+qgufP7MDRCziEz+3C2Gkq0ZoSj1m0V1WWy+BApgMk01kVzSYCmanstj0VNzmUsigJQFjJVD7ayTiscpLgPG8BnKWfbmp5qYDd5+8RoBxNLmFikEXrU306n/sjWMQMF+JYpIhFhYVbS9EXjY3iDLXRN8xw2RvPGQAyCG+IdAtWbjpzIMQxWycPV9kQT7f65oNZ4BFv6WRl2hn3NbXYcmh1VDsK5xHC6O9TdgbDEACpQ2ZGCqvA==
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(36840700001)(46966006)(4744005)(9786002)(82310400003)(107886003)(70586007)(5660300002)(103116003)(478600001)(7696005)(1076003)(47076005)(36906005)(426003)(2616005)(110136005)(336012)(186003)(70206006)(26005)(7636003)(8676002)(6666004)(4326008)(2906002)(36756003)(36860700001)(82740400003)(356005)(8936002)(316002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 17:30:15.5688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566b5312-55d0-4d93-5aa1-08d921fe41c3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7360
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add maintaner entry for xilinx-ams driver.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..2ebb51d828fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20017,6 +20017,13 @@ M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
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

