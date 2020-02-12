Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC1159F43
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 03:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgBLC5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 21:57:00 -0500
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:3296
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727565AbgBLC5A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Feb 2020 21:57:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8MT7Mzbdey/AnY/Obr45a97JzoLjHEFEhXN3apgcwZYgL3A+0kI8oor2Yv7dBOyWeyWj3iNiZNKzLsLUkdUCJ+wG47VoyTeqGJXi9YpWPcJ7MoRsGJkDPJLMI8LUBxzUNygwyQ8mARgPBvbH2h5GzCQYGKz+1jekUND5DA8shOfXI7zOM+kLd0vQormKiUz3FVUB7Ej2Ybf7+BNcmDnrDKElh5LKnyX5ylg78+e1xGi4/7jsA3eK0KUbBbBgjOmt1rN2PCZF26O0A8Uel2Hhbc/WB23gxkNQQI2Y6BWIXqQbhf/qpv5UFQqk/xwL5HsTL/ed3EhP3/lIu1XdIZcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYPFoNh94xjfveTdL/DtjIKbETAT3qI2ZQEo951cqoQ=;
 b=bdh8NCOQyQrhqOxMRlTxVDzRg2NA2ms7SjGMXZaL4lo1G7aUafFYtn+piFhG8bYFK9kG2PNQMXrN9f/eFMI6zodwNhTk+ko0gOH1LsUlTYNaSw/O9UkxpoQ+0UuRYBZxZVgUrYQHRb24bAkmWZc9XSjwrVZ4aUqNoq2oPY0G3+L2eGQQPJ9rqEeSAMQujXvwhPnhbjRiNIHyKuYHqt8rtnDwIM+rkH+CCbtkCikUXTy8cGewbZt1zPSfYWHjqiyIn46NaReMI6VmivznEWmpx75waz1OWs1kLpJ1hlk+XeR9dFNKkpQnv+TXYOR/KK/mCPfpCjqsUwGyes5zJ+ZQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYPFoNh94xjfveTdL/DtjIKbETAT3qI2ZQEo951cqoQ=;
 b=kT6QLZNICwwR6dzONRsoqCPQlMvWcsPGpCmLEF/x19HLTIXt+9ZYVYdGsOzaTKDwW5RbYgP4NznKHP/SfIt86V05hCqwFVYbofAtMU/PVPIb/yBzw5hfp5B9uwzf+Zx3Bm+AhvlsoBmEP1cPOHiHJPqVZIf1BOlKYoEUNNnZVyM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3343.namprd12.prod.outlook.com (20.178.240.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Wed, 12 Feb 2020 02:56:56 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 02:56:56 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v3 0/5] SFH: Add Support for AMD Sensor Fusion Hub
Date:   Wed, 12 Feb 2020 08:26:32 +0530
Message-Id: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::26) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Wed, 12 Feb 2020 02:56:53 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9024b952-21d4-43fb-9d9f-08d7af673861
X-MS-TrafficTypeDiagnostic: MN2PR12MB3343:|MN2PR12MB3343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB33432F63F9846A065BD965E1E01B0@MN2PR12MB3343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(6636002)(81166006)(6666004)(2906002)(81156014)(8676002)(6486002)(8936002)(86362001)(956004)(36756003)(66946007)(66556008)(966005)(4326008)(5660300002)(7696005)(66476007)(2616005)(52116002)(16526019)(316002)(26005)(478600001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3343;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMm7yspdIMPeynH+QSkptr+pqwSk8MIervclo+N1lZvfZSqEiPCNfqezMgKSa2+I5Dk7at1Z5j3BiXYeguMuaMDnDWzZsS/GMP7kkw15utN2j01AQJbNNXJD8t+BEDVYo4WKDxP2me6lhOB/EibX4FfrTDfvt3eFi39xytsFXlnVN+/XyI09pFgvwXBETMtNh0FOX7/Yz+LqohN1F+cJbosiq3IBLPcpzHYkHzIZongNBP36qBPPGhq25dNimaSInkpVdxJ1PP+sA6zJgFK9yHENXTVkFLOZgMtCoXGcmw7OLjLJ2KsbEXRiBBqwrf4gLR9K1XHltC3pocZi186QzxvcfqHqavFQtEpHc42hKWT9+ZCMUQHvtqNzwhnnV1YrXpENyrO1pdr06ITYZwOAda5CkZal4P8kc+naaXRicijnwtYwO7AaeTTD6HptjDasur0GpMKuaqUgSyVdZglpwTUyQJi8+CTBZDamwywPlmg6NgH81JuljGuHuK/K9bZh6usYtdnpO5MvsGB9HePOKw==
X-MS-Exchange-AntiSpam-MessageData: RTPvAVIwoGLifvP8HeBbJ9/1pGaEmvFpkshcNXo8GC58DY5ArHquCUMpBeiB29rUoqM+N2QyVmpERT4xRbG/1v+qT3aSYZ4EYI3wwUU5zuy/RuT4fhqVq56Uf0xlp31EFJ6B3IZfwW3GN7kPq1LZ6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9024b952-21d4-43fb-9d9f-08d7af673861
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 02:56:56.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdnbWZ0KybB5BPhMKbYzvJEGJD99QEAk90QvBWx9rza//jJ0KuUbSCbYfMTjwP6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3343
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


Sandeep Singh (5):
  SFH: Add maintainers and documentation for AMD SFH based on HID
    framework
  SFH: PCI driver to add support of AMD sensor fusion Hub using HID
    framework
  SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
  SFH: Add debugfs support to AMD Sensor Fusion Hub
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


 Documentation/hid/amd-sfh-hid.rst                  | 160 +++++
 MAINTAINERS                                        |   8 +
 drivers/hid/Kconfig                                |   2 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/amd-sfh-hid/Kconfig                    |  20 +
 drivers/hid/amd-sfh-hid/Makefile                   |  17 +
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c             | 243 ++++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h             | 177 ++++++
 drivers/hid/amd-sfh-hid/amdsfh-debugfs.c           | 250 ++++++++
 drivers/hid/amd-sfh-hid/amdsfh-debugfs.h           |  14 +
 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c        | 260 +++++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.c               | 179 ++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.h               |  85 +++
 .../hid_descriptor/amd_sfh_hid_descriptor.c        | 275 +++++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.h        | 125 ++++
 .../hid_descriptor/amd_sfh_hid_report_descriptor.h | 642 +++++++++++++++++++++
 16 files changed, 2458 insertions(+)
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

