Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A238B23FDA7
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgHIKZu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 06:25:50 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:19265
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgHIKZu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 06:25:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b04GNEvzq1MvQero4py+H8bjnLXD6RRpTZIEHhLdYGSqUpI1cT08tfII21TTdfdZEQAs16RWZC9vNdvRncsWB9ivlaU0Jw1gFD+mvYou4Xl89MjHtSjfXJPk0+3iF+AJc1R4sA2gCB//t+rhJeSA7PPrsMtLhPhBiKop5ElraFw4bHfW1LmXgkx3DDePTxU14emYCSIp9YlKBWhkWH+K+Myg2aM6QzwoKlQskzXexOWyLOIaKRXpb1Mp6TowlNw4c9Rk+gVmOa0crBvbYrCCUjpvyeDJ6/GcWWDNptrMtEF2QqZJPe21cBkz7uAsAV6JpA6eWgNTK89sEF6p7W2h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1EtviEHit+XndUBttxSOiVqnbh7P3v0heB9DfCAdFo=;
 b=LKI4KwlagOzFVq1NoIZb2XRmUGxyPGoOOuALTAsuKUUmVYwujb6GLYzxUltRJtvMopEhIeyLJM/FzlN8QcRI5ljhxTlms9xuetg+09BcTiyBjiselPPS6gzKs4Zw0ePq3S2FLI8IF+KCwhnLQn5xMwh5c4RmWr9PiCWicuiKcr62aOlnUZ2JXWAzNmfUQPH47k2hUgK3gbgqZ06XFQf5fAO6AoU8gv/CEDe1zaisxFGFVVS0hEAJiQXD0JpFBUpEPMorp5i5SD81FDhQynIcxU7LVSkLAGqJxS1DYu6plT6tyct3tN5vU7RHxVcFVje8WP3PxXoqbG5S482qXLeG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1EtviEHit+XndUBttxSOiVqnbh7P3v0heB9DfCAdFo=;
 b=VbekSB85DqKL/IGF/6uJVVBdzO+XwytC8OnhhhxYGTzKfZ312WbAaQw/XCyxhAuiu08mfwsSEUCE2h9S1nRETVja5h2lAf2BSug169vqbrZvbotTmsgn459374/EBt4kpoaMz6NtAUqr/HiYD/dCN2IOLFsjRsxqah2wKbg2c9A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sun, 9 Aug
 2020 10:25:42 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09%6]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 10:25:41 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v6 0/4] SFH: Add Support for AMD Sensor Fusion Hub
Date:   Sun,  9 Aug 2020 10:25:07 +0000
Message-Id: <20200809102511.2657644-1-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::30) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Sun, 9 Aug 2020 10:25:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 813e5409-6343-4360-8dca-08d83c4e913d
X-MS-TrafficTypeDiagnostic: BY5PR12MB3778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37789B1A70A00DDDE8DEDC35E0470@BY5PR12MB3778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4L6dZZO28MZq6KAXQvy0ZeKPvSMzqyhG4/6SM5d5MWp74ulM9xLH4ht8NeY3YBP+wTuKpBeebyKOHdiyis1DDGyuRGHZkeGW860hHus2XUf70WvvhkZ7ZbXmhDLA5sgSQPW3FIuWG+kAwvAl+zLm2+6Tx57onPciXnSJKogqHGuRyNjX3OiHa+yQAww3EGBg1neGNLZ09hgBFL6/NNRdtczFjyfxonDtoT2q7FREd6RYbCUEuGZGgdKyfYgdhXZWu70MeZuy15uRl29r66KBi0oeQA5ORFkH2x0jln95cj2gbCvy8TsWLFYLtW4I9kWss/MPqgn/XuCD+Z7SvX0a/0GlA1oug+1QEk0qPPtJVFZBNUwtFXY1WSBJ4had8pHIkvf6Ng/WffOphHFGvn6OloKm1ZQeEy7BpFkMnkGexL/pTimPSsPzc4rrh2Ex1HLf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(1076003)(7416002)(956004)(5660300002)(83380400001)(2616005)(66556008)(66476007)(16526019)(6486002)(66946007)(26005)(186003)(7696005)(8676002)(8936002)(36756003)(316002)(966005)(2906002)(6666004)(86362001)(478600001)(4326008)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Kk63Dy+DAJSsPek26sIDY/KUdtQj0wV04WvHfNIUXZe3LrTXS9vcozm35dQCk7D02G/6ebnBRWXEHuHfsXS4DVqQttzh4uOtrVXugJ7CMtJxWXUr7DThmRhD9Bn1xVcNQglmjYuE0nmtzNxnuBQR/KcQizWZ6m0XeNdRHvDWxRcJenbIxWnqZykhk1W+L1tuMUFA939NwCKhO6YAUQOB2bi/3uqN50Tnt9N2G6RySb3bVoUpAV49e0NmBXhpskzO6y8kHOOn/YIJiOBrR/YQOghDE1ckSwE5Vo7VbVw5Hc+G7+eer3zXh/LNNzTv09SKy2G2F2SspW1CKXhCfzahdGEU4o8bPPaF42llhQ0DsTrbEGKZUZ2sFNEFvWtSqP1ttgrP33SzTlSZqI6oVf5ajTFy6PY4QDXdg/8igxjjyDRk9xlETT5SJ3J25fwD0o2nRHK4Qt3jJWbR5BIaTAjJ3Fn0FkTCvJoUNJf6xX47pKMG4sAdErD8d6fZlI+NcGlSC0BEWi5m9knwo1k2Ez197AYY/coEh8/72AmnkCtpByWBMlA4yTRgVmZZpxt6Y82Bsfn2MhMm3U7Xh/BezM8zzENWMpBCfK+WxVeF1SVwnBAZM5rQ+FLmFziYHsSwOeHjZKHIiNObHnblTkFMTu2r7Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813e5409-6343-4360-8dca-08d83c4e913d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2020 10:25:41.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZysI7dY1nUQNM5ITb7MxBY4ZPs37U6CbjXn4kNuIdwHyktFcJFt0lTMB4NpajyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW is part of MP2
processor (MP2 which is an ARM® Cortex-M4 core based co-processor to x86)
and it runs on MP2 where in driver resides on X86.The driver 
functionalities are divided  into three parts:-

1: amd-mp2-pcie:- This module will communicate with MP2 FW and  provide
		  that data into DRAM.
2: Client Layer:- This part for driver will use dram data and convert that
		  data into HID format based on HID reports.
3: Transport driver :- This part of driver will communicate with  HID core.
		       Communication between devices and HID core is mostly
			done via HID reports

In terms of architecture, it resembles like ISH(Intel Integrated Sensor
Hub).However the major difference is all the hid reports are generated
as part of kernel driver.

AMD SFH is integrated as a part of SoC, starting from 17h family of processors.
The solution is working well on several OEM products.
AMD SFH uses HID over PCIe bus.

Changes since v1:
        -> Fix auto build test warnings
        -> Fix smatch warnings "possible memory leak" -Reported by Dan Carpenter

Links of the review comments for v1:
        [1] https://patchwork.kernel.org/patch/11325163/
        [2] https://patchwork.kernel.org/patch/11325167/
        [3] https://patchwork.kernel.org/patch/11325171/
        [4] https://patchwork.kernel.org/patch/11325187/

Changes since v2:
        -> Debugfs divided into another patch
        -> Fix some cosmetic changes
        -> Fix for review comments
           Reported and Suggested by:-  Srinivas Pandruvada

Links of the review comments for v2:
        [1] https://patchwork.kernel.org/patch/11355491/
        [2] https://patchwork.kernel.org/patch/11355495/
        [3] https://patchwork.kernel.org/patch/11355499/
        [4] https://patchwork.kernel.org/patch/11355503/


Changes since v3:
        -> Removed debugfs suggested by - Benjamin Tissoires

Links of the review comments for v3:
        [1] https://lkml.org/lkml/2020/2/11/1256
        [2] https://lkml.org/lkml/2020/2/11/1257
        [3] https://lkml.org/lkml/2020/2/11/1258
        [4] https://lkml.org/lkml/2020/2/11/1259
        [5] https://lkml.org/lkml/2020/2/11/1260


Changes since v4:
        -> use PCI managed calls.
	-> use kernel APIs 

Links of the review comments for v4:
        [1] https://lkml.org/lkml/2020/2/26/1360
        [2] https://lkml.org/lkml/2020/2/26/1361
        [3] https://lkml.org/lkml/2020/2/26/1362
        [4] https://lkml.org/lkml/2020/2/26/1363
        [5] https://lkml.org/lkml/2020/2/27/1


Changes since v5
        - Fix for review comments by: Andy Shevchenko
        - Fix for indentations erros, NULL pointer,Redundant assignment
	- Drop LOCs in many location 
	- Create as a single driver module instead of two modules.

Links of the review comments for v5:
        [1] https://lkml.org/lkml/2020/5/29/589
        [2] https://lkml.org/lkml/2020/5/29/590
        [3] https://lkml.org/lkml/2020/5/29/606
        [4] https://lkml.org/lkml/2020/5/29/632
        [5] https://lkml.org/lkml/2020/5/29/633


Sandeep Singh (4):
  SFH: Add maintainers and documentation for AMD SFH based on HID
    framework
  SFH: PCIe driver to add support of AMD sensor fusion
  SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
  SFH: Create HID report to Enable support of AMD sensor fusion Hub
    (SFH)


 Documentation/hid/amd-sfh-hid.rst             | 153 +++++
 MAINTAINERS                                   |   8 +
 drivers/hid/Kconfig                           |   2 +
 drivers/hid/Makefile                          |   2 +
 drivers/hid/amd-sfh-hid/Kconfig               |  21 +
 drivers/hid/amd-sfh-hid/Makefile              |  15 +
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c        | 162 +++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h        |  83 +++
 drivers/hid/amd-sfh-hid/amdsfh_hid.c          | 175 +++++
 drivers/hid/amd-sfh-hid/amdsfh_hid.h          |  68 ++
 drivers/hid/amd-sfh-hid/amdsfh_hid_client.c   | 220 ++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.c   | 226 ++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.h   | 121 ++++
 .../amd_sfh_hid_report_descriptor.h           | 645 ++++++++++++++++++
 14 files changed, 1901 insertions(+)
 create mode 100644 Documentation/hid/amd-sfh-hid.rst
 create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
 create mode 100644 drivers/hid/amd-sfh-hid/Makefile
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh_hid.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh_hid.h
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh_hid_client.c
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h

-- 
2.25.1

