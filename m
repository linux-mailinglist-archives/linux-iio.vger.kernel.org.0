Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C57135439
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 09:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgAIIVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 03:21:41 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:41312
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728347AbgAIIVl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Jan 2020 03:21:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRR8tCI+EicrWCMVgk58uNvz6c1xIxOcc2JDrv0aoGvY3dyXGDkncs+Sjf9N7a3cTpgmVI+y/MZTEXrK7utUoV9UIFrSrAE5/NCMcA42soPhiu585u7W2k73CYAoO+vnP6sThObQqHQTEnyXjHKrU/XnlYH/lw3mJkQDMiyP0Nzn+po3Bl9ybUfFGsfKPSjXhD3p9s8CZI1a4nklrlrZ/3ALBUz2u/XsQwWtPbDI25mMU3bnCiImYjDq2ZiSFkILc8V7qRn4Ya77VzjG0vNU9le7rE9TEVhj72d/xYAT2UG9vj1/8N+D5SicK1sBnb1fNUB9tZEGPkTPqf7bW11HEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtX2f0YurQVONZgMxEmgegAHNVwEUC8ikZ+lp0Tqi5c=;
 b=OZ4Mrjiwx/2Ol+e7vpSBMczmDmO8L8iJ0NSSUH/eKXCcZ5EAKIdsSnLk8jNfXl5K7OxFssxnPrNjI7lE3X83TqxntCkq5+/1MNIlWsUKZZtPB5DQqMd5O4FYDzLoiwUoVFNbnuVeAQO185gWkdBvsjiQvkUqAypC+y+qeLoO12yXsmhqQP6PTF02YVLPjarOQWWf5j3XguRVQ2xPW9J997N5zdxhaKmvliDL67iZV02HsRbfnZql9R6MBcum8ztL6Z3kTgDYmfNkr47xQJl1i/z2NYIg15jhpTAxUU07NcURFByKCmuTqOgq1kd+IpOAhwmwqWqTI70GXL7iMxPZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtX2f0YurQVONZgMxEmgegAHNVwEUC8ikZ+lp0Tqi5c=;
 b=dJG86w1BqyiMWssCEGUgjOWJBTIG27fbLwq4zrVD0xz1lUXgMDnxRMAhEj4NJxXsYH0n15MXuexMUsfjPbEYAzxqla5CVGuvw2rToqeyl1pW51S5J7RcxfFPGpZYKCJc0cjXdA3pdmoIcqpvdic1YUGZD4n3DEx9cim4nvwcKKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3504.namprd12.prod.outlook.com (20.178.244.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 08:21:37 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 08:21:37 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH 0/4] SFH: Add Support for AMD Sensor Fusion Hub
Date:   Thu,  9 Jan 2020 13:51:17 +0530
Message-Id: <1578558077-9798-1-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::22) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0036.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 08:21:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12fa5b8f-5d69-4936-a399-08d794dcf1fd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3504:|MN2PR12MB3504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3504B09C3132A4F43FA5F9A1E0390@MN2PR12MB3504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(5660300002)(6666004)(66946007)(478600001)(16526019)(7696005)(52116002)(36756003)(4326008)(186003)(26005)(8676002)(6486002)(2906002)(2616005)(81156014)(66556008)(66476007)(81166006)(8936002)(316002)(956004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3504;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZ4F9DKrY4SXv/p1I5Y7zInWcIqqfrXzFiIkPoqIhbnfApx07lhAckhLvnVFyULjgzeNzCAmV3AAFbrhP3GA2mYEZSmZtlcXyMtNKOZN3kjo1jrPVkp660otjs4D1b8EPRCFcjkySkDMz5dobq9ppu2FOhlzr3CGZXoklnKQd7wgSleZY3/EWfzNJgA9nxMnjjHv37wC9b4X9IieaYAQf0cL55TTIBwEh/0kRjg/Bx9QBkP4TEUrHOB96wqkcUBGXeHvzmsQrKQWsm0KuKR3eJuB659yxrDmuMdy4j7hnWSoKynwCsI/piJFoXBI7r7moPsRucjvw+SbUVKcJVyLpU77FwwWJUfxXKgUvTteqibf5myx0XkL2H13HMF6S13J7aNrqaMz6HRjdhLZRupLnsyd8FqbQ5Adq6nQNJjYgy3HVFJrb4frYZRw9LsgdlEC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fa5b8f-5d69-4936-a399-08d794dcf1fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 08:21:37.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpiVaYD0p7BZiFqc7QZ6ib7/a6RLZH6wHhDNQSPGP0VKA4e8rpvc/t14dCT/4dmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3504
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH is HID based driver. SFH FW is part of MP2
processor and it runs on MP2 where in driver resides
on X86. The driver functionalities are divided  into
three parts:-

1: amd-mp2-pcie:- This module will communicate with MP2 FW and
                   provide that data into DRAM.
2: Client driver :- This part for driver will use dram data and
                     convert that data into HID format based on
                     HID reports.
3: Transport driver :- This part of driver will communicate with
                        HID core. Communication between devices and
                        HID core is mostly done via HID reports

In terms of architecture it is much more reassembles like ISH.
However the major difference is all The hid reports are generated
as part of kernel driver. AMD SFH driver has taken reference
from ISH in terms of design and functionalities at fewer location.

AMD sensor fusion Hub is part of a SOC starting from Ryzen
based platforms. The solution is working well on windows OS
in several OEM products. AMD SFH uses HID over PCIe bus.


Sandeep Singh (4):
  SFH: Add maintainer list and documentation for AMD SFH based      on
    HID framework
  SFH: PCI driver to add support of AMD sensor fusion Hub      using HID
    framework
  SFH: Transport Driver to add support of AMD sensor fusion      Hub
    (SFH)
  SFH: Create HID report to Enable support of AMD sensor fusion Hub
    (SFH)

 Documentation/hid/amd-sfh-hid.rst                  | 159 +++++
 MAINTAINERS                                        |   8 +
 drivers/hid/Kconfig                                |   2 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/amd-sfh-hid/Kconfig                    |  17 +
 drivers/hid/amd-sfh-hid/Makefile                   |  17 +
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c             | 255 ++++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h             | 169 ++++++
 drivers/hid/amd-sfh-hid/amdsfh-debugfs.c           | 251 ++++++++
 drivers/hid/amd-sfh-hid/amdsfh-debugfs.h           |  14 +
 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c        | 257 +++++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.c               | 179 ++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.h               |  85 +++
 .../hid_descriptor/amd_sfh_hid_descriptor.c        | 275 +++++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.h        | 125 ++++
 .../hid_descriptor/amd_sfh_hid_report_descriptor.h | 642 +++++++++++++++++++++
 16 files changed, 2456 insertions(+)
 create mode 100644 Documentation/hid/amd-sfh-hid.rst
 create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
 create mode 100644 drivers/hid/amd-sfh-hid/Makefile
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.h
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.c
 create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.c
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_descriptor.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_descriptor.h

-- 
2.7.4

