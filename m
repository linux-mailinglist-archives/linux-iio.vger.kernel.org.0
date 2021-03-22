Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52C7343E65
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 11:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCVKwI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 06:52:08 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:57825
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229508AbhCVKvv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Mar 2021 06:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbIhcqt4gXqUYiHGEVo+JJXw09GM2aFUfS/mkfJhVJAKixpiAWc4MPm1io9qq7ABnYWlvFLOcLbkwxVI17Wml5TVlVXRTBngntZOJmOKE2VxHA37lpNoVcrGIRuBi6S3PTz4Rw2ATU/S1+5H2+c8TNLFsAjXlrj7ACfuBAOgVWu2Lm7tjehuoZKkfVF+JOr6o6sEvBy7GkjTa8UIVpLRkaERAKcU9pXt/cSQ7noQc3l9pltF3ZRiVr9IgB0n5SnTf8BPJ+zQ84xStYXwzzyJH95xxXKmmiUjpt14zgeloGoaTyM0SocA7v2dtRFD9InEgFGah0TLWgEp16HlDP9GqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K48reQq1rnHH0TWqFfjPcpxiNqjzAtv2CZvto+fP4bM=;
 b=lCsdxcd8WbnRI8EsWihLnPR7KAcmaCATwBkMz2Y+Q4/bNs/cHyjwu/9PRDnphUvvvsC5lP+CcyYYS+jAlnMC9RNUhyU0aC51Au+AsB1L+aG8XTtNqK+x2Zv2n4J55f877hNh3T/7pRJUO6tNKb0SSbFnsVwpZ7zp2luSXuMWujvzecMY9n9p3pqgNNocu258zzE810zj1y4VQ6q7ND4XzCqUEk7DcehGBsNIKatc0OvtLFxPzBadPryeyaab5yrozvtvPLgLi9HLsMWCXzw9FtbldTL7MzJltcnd82VzN4Rwwe8/aWAwXvnWQZN3bZLbeByOB3fK/AtmU2M6BNGz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K48reQq1rnHH0TWqFfjPcpxiNqjzAtv2CZvto+fP4bM=;
 b=iYNEtmEjiv3/WBnE46FOMuKCaeHxF8v+zYcfawDz1yQnot4+Yzq7D9rDzX077jyZZRpyMsGwVtY7hW7JOBKOFe2UJPnjL+IMLyEznpntDQf/QZDo4obO5sEqwH8KMGP+snRVYGvBOdOlWyjczRBHlsEhVjaGIwMeG2Am36SDpD0=
Received: from BL1PR13CA0244.namprd13.prod.outlook.com (2603:10b6:208:2ba::9)
 by DM5PR02MB3257.namprd02.prod.outlook.com (2603:10b6:4:65::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Mon, 22 Mar
 2021 10:51:49 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2ba:cafe::87) by BL1PR13CA0244.outlook.office365.com
 (2603:10b6:208:2ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend
 Transport; Mon, 22 Mar 2021 10:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Mon, 22 Mar 2021 10:51:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 03:51:24 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 22 Mar 2021 03:51:24 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.6] (port=46094 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1lOI9a-0007fI-MI; Mon, 22 Mar 2021 03:51:23 -0700
From:   Raviteja Narayanam <raviteja.narayanam@xilinx.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>
CC:     <michal.simek@xilinx.com>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: [PATCH 0/2] iio: adc: Add driver for INA260
Date:   Mon, 22 Mar 2021 16:20:54 +0530
Message-ID: <20210322105056.30571-1-raviteja.narayanam@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78ff8074-811c-46f9-9694-08d8ed207e55
X-MS-TrafficTypeDiagnostic: DM5PR02MB3257:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3257BFA9B4ED284CB686D483CA659@DM5PR02MB3257.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TEpfTv+rSqT44/X9RfzE4PMs3ZUTqgXZGVsTKpUBr8I+G1QBZtwLpy5ikTRGN8Ug/oBpWGPeHhVWT1FPObaAQX4hRZ9HDO1pUn7rwxeHvW29OcGOEI9BQW/HMkOXkOgod01ftrd4BfbnZsoc2/LWBxixN4p+whp6ccbLtqhiPQWz6L530+Fxav3PTxenbdSYkKwPhL7jAukPR3bEITpbySIMtiSufuSREM6A2ovVf8sLLMA6lyapiQRRZnc8MpgkY0p1qMhv7wofIaQ0Dx+9+R8biVwGwKOCzvEqPwxGwT2UDqKmhAIdd/HJfpgmmyopFcIUrEmQEAlLdCO5wuHS/kt4mWqSbPxLPc6RN++Lz9ARtZZ7VmN5Yz6hyjAoSpQiu4iaAC6HZ/uECemjTwEYApmBMVhCRkoKXTYxmHcBQYqaozqvcom9aZl9FJ+WsSI46xQHLMkW9aR6g6V3UF4UoMu9W4/2lCyjX53Nt49Ia7LTuwmDawAAipGuGcFlD83gvl/xTlRvRRuiQ2IiGPAJsas3AigEkCf3JSVwVKQMxOpXn09BayIfycS/zBMvdXnVnV+wxWzzy9uPgvcui7iDbtE5cylnatPqaBGG5YRYeULQKz6a1dBLoO0Vu2Un5vt/+tduDuty6IxWa9EH8yFreAooKRsTWOLYGqFtlPACIcCsILopqBzk9ELBonx2gnY
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(316002)(44832011)(2906002)(5660300002)(9786002)(478600001)(8936002)(4326008)(110136005)(8676002)(36906005)(4744005)(426003)(336012)(7636003)(2616005)(1076003)(356005)(186003)(70206006)(54906003)(6666004)(26005)(47076005)(7696005)(82740400003)(36756003)(82310400003)(36860700001)(107886003)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 10:51:48.5717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ff8074-811c-46f9-9694-08d8ed207e55
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3257
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series does the following:
-Add dt-bindings yaml file for ina260 driver.
-Add ina260 driver.

Raviteja Narayanam (2):
  dt-bindings: iio: adc: Add ti,ina260.yaml
  iio: adc: Add support for TI INA260 power monitors

 .../bindings/iio/adc/ti,ina260.yaml           |  57 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ina260-adc.c                  | 556 ++++++++++++++++++
 5 files changed, 634 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml
 create mode 100644 drivers/iio/adc/ina260-adc.c

-- 
2.17.1

