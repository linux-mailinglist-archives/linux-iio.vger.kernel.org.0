Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56A170FDC
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 05:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgB0E7X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 23:59:23 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:23707
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbgB0E7X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Feb 2020 23:59:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf7XxF0Qt7s4ea4iM1zHKMN0eeu2d3Wv+ymRynrYIlYomeLpog8YzzD2XMSJLPLhucXyTl4c2h9BRlqGou9X1yfzGS2YH/ryT7SGTdmHUTSMvqgjsaOp8tjLdPVdS8sMEpVZjIOX5CQ9ibWs9TcxYzhsIc+3l/CRzKIQ4YxYeusQOgK6z9fHp+C9YEes5p6MRl4FtCtGiwdIxiqDBUL/5Yod1/lU/Xkh6YWaZvVOKvFsKYTg/TI63F7EZvxqPUfFZrXGdJMLJ+42zoIEabEAJQVcWd2oGwNvfK3UJWR07rYcY0rgA1HO6LxALJpgmizK3BvNuZRoT62ulVkB86a1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2befd9Xw2+cBXSeyOatCBQ41BDwz1NVy6hftIay9jo=;
 b=oGwNiRtIkT8oAedMRgdrfsG421bEfApil5cFW/E1cOxEEiWoHKmeObnxCCN3faLSrsyh/DGfOy1EQKHJEU1VPbsu17xsz533cFSyD7+dD7wq1YCoClmwwq9noUOWBRRyQOYnE2wth979Q36V1e2tOgxUoGzKW8tOGDjZFJlyOwL49JeA1OIoYfhUIkwzbJqNcoLUIoAngwiVYXYcWqjhNn7XV3qMFOcdNPO6rGF9/SkbZpRxW8Gb72vMCjkpa9Gp44982MQTMkP5W6rzSntvgrxx5lkhm9kmT4WyzPD1F8Ll9t1PJlCKcglDdWt3IN8fkeYDf/guLUK9/tzTsKUQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2befd9Xw2+cBXSeyOatCBQ41BDwz1NVy6hftIay9jo=;
 b=fzXlYMZEtkwHJ9Y3klEBFcfEE9qfv4yP+kuGi12kJms3nVJ5s4ARIOeLkBPZWvlshYuUrwqaLJSqHdkMokS924y+pO47kmOoi9ek9YypzIuHMW9IgLYjUARvsEy1Z1I21W0Yg+jyFjKf6WWD/PMeaEptD+nhkQNk5xXojt3C9z0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 04:59:20 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 04:59:20 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v4 0/4] SFH: Add Support for AMD Sensor Fusion Hub
Date:   Thu, 27 Feb 2020 10:28:53 +0530
Message-Id: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::17) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 04:59:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6edb224f-bd1d-46f8-78e9-08d7bb41cded
X-MS-TrafficTypeDiagnostic: MN2PR12MB2912:|MN2PR12MB2912:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2912491BAC37B16D95C00B96E0EB0@MN2PR12MB2912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(26005)(66476007)(66556008)(8936002)(186003)(16526019)(2906002)(4326008)(6486002)(8676002)(7696005)(52116002)(86362001)(66946007)(316002)(81156014)(81166006)(6666004)(6636002)(5660300002)(36756003)(966005)(478600001)(956004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2912;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyCiNzqJCRLgA+tSf5ARknTZrHziyPY3BAKSQgMZX0jAZ4uWbRlAc1mqg3FpZ5twjjQiH/3HL7IJcAnir8lGCpX2I8nYilXeAOSHJ3DYR5ndQ7GCm3/8JyuQ/ZnklgIcE3TiADVjUpkduID62O8FzRiPmefkB2ItBnHKa9M98AAjvtx4jOkTdsxjtQNWsVrAkvwYRMDEbrU91qNbd+sTpohCvopFtYl0LzkAiumN4xX4wpfkW78fMhv0E6VXSoW8Bk7Vsxiij6B015zDU97SDOQYC6FwUOAsyHzkFIAJfA1FKkaXrnqEtFzWGOu0DMWjHKDY2PQljXAplbtYMLZd8ovDEP7NRnbHU4n0xQs+nVELu6t2FT88bC1YvbHyMx9JjN5XcUwT+uVGDCyvZhJP+7R2B3guHpU8nIZtWnEDvbKUc+mF4CgN66PTOcNn8qZ+K1bFoiUUJLbp2WUbmJSbQiobGAQeiDuRHxGjW5LmW2wm1rDcG8KohUsW/uvwuRMUbQ/aD9SbUr6swNW2FE/wvQ==
X-MS-Exchange-AntiSpam-MessageData: 2Nw+FTn94cBPf4oWCxltoKUMFMFp29N8BV+A2mogcEvtT8Px+GxBpONQe0dcUDGGvSii1B8O8BJjBhpu0v7AmPfDME+XanQwKfWqeqeWzIc343KFKKxrbEfE8f8cK//tm+mw3nV0NXj0q6ai9t5Ruw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edb224f-bd1d-46f8-78e9-08d7bb41cded
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 04:59:20.4101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsiVpO1uCCFMkcTt9yMStw3pvodHHgMPjjCW+zHns7/QzYiEInS4YjPwYMgsHn4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
is part of MP2 processor (MP2 which is an ARM® Cortex-M4
core based co-processor to x86) and it runs on MP2 where
in driver resides on X86.The driver functionalities are
divided  into three parts:-

1: amd-mp2-pcie:-       This module will communicate with MP2 FW and
                        provide that data into DRAM.
2: Client driver :-     This part for driver will use dram data and
                        convert that data into HID format based on
                        HID reports.
3: Transport driver :-  This part of driver will communicate with
                        HID core. Communication between devices and
                        HID core is mostly done via HID reports

In terms of architecture it is much more reassembles like
ISH(Intel Integrated Sensor Hub). However the major difference
is all the hid reports are generated as part of kernel driver.
AMD SFH driver taken reference from ISH in terms of
design and functionalities at fewer location.

AMD sensor fusion Hub is part of a SOC 17h family based platforms.
The solution is working well on several OEM products.
AMD SFH uses HID over PCIe bus.

Sandeep Singh (4):
  SFH: Add maintainers and documentation for AMD SFH based on HID
    framework
  SFH: PCI driver to add support of AMD sensor fusion Hub using HID
    framework
  SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
  SFH: Create HID report to Enable support of AMD sensor fusion Hub
    (SFH)

Changes since v1:
        -Fix auto build test warnings
        -Fix warnings captured using smatch
        -Changes suggested by Dan Carpenter

Links of the review comments for v1:
        [1] https://patchwork.kernel.org/patch/11325163/
        [2] https://patchwork.kernel.org/patch/11325167/
        [3] https://patchwork.kernel.org/patch/11325171/
        [4] https://patchwork.kernel.org/patch/11325187/


Changes since v2:
        -Debugfs divided into another patch
        -Fix some cosmetic changes
        -Fix for review comments
         Reported and Suggested by:-  Srinivas Pandruvada

Links of the review comments for v2:
        [1] https://patchwork.kernel.org/patch/11355491/
        [2] https://patchwork.kernel.org/patch/11355495/
        [3] https://patchwork.kernel.org/patch/11355499/
        [4] https://patchwork.kernel.org/patch/11355503/


Changes since v3:
	-removed debugfs suggested by - Benjamin Tissoires

Links of the review comments for v2:
	[1] https://lkml.org/lkml/2020/2/11/1256
	[2] https://lkml.org/lkml/2020/2/11/1257
	[3] https://lkml.org/lkml/2020/2/11/1258
	[4] https://lkml.org/lkml/2020/2/11/1259
	[5] https://lkml.org/lkml/2020/2/11/1260 

 Documentation/hid/amd-sfh-hid.rst                  | 160 +++++
 MAINTAINERS                                        |   8 +
 drivers/hid/Kconfig                                |   2 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/amd-sfh-hid/Kconfig                    |  20 +
 drivers/hid/amd-sfh-hid/Makefile                   |  16 +
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c             | 243 ++++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h             | 176 ++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c        | 256 ++++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.c               | 179 ++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.h               |  84 +++
 .../hid_descriptor/amd_sfh_hid_descriptor.c        | 275 +++++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.h        | 125 ++++
 .../hid_descriptor/amd_sfh_hid_report_descriptor.h | 642 +++++++++++++++++++++
 14 files changed, 2187 insertions(+)
 create mode 100644 Documentation/hid/amd-sfh-hid.rst
 create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
 create mode 100644 drivers/hid/amd-sfh-hid/Makefile
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h

-- 
2.7.4

