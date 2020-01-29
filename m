Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D68314C530
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 05:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA2E1v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 23:27:51 -0500
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:6071
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbgA2E1v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jan 2020 23:27:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBt5FqWc95jiJg2HoxzEs79gf/ry3483dPpiFlo6m6D2W00O/GIMv4bidlUhghb3A0gL/8WJeuWVe2DY0WVosWps+xZsTVB0FjRhjNDRiqQ5IrJM7zym/c/EAvQVtrXTExAIobdJ5zKKm/tsHra3WIv+0TresrSWadW2UqOE8JB2Gb/e+ZIJkv5rbyDjHE5MmnypgTZ2iXyQtVveYTIU3lS4+bACmBBRiakwpH/HZZNH9I/GOgksPF17wt/uRHF1mRt3c5Xv3ec8JXqD+x3yJQeROXI2sVGbrhS2vDdQ2yAM7MbYO3I006vQ3CJJbPWMtnSs7/Gvm7VJSY9ngm4/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmAc2zGW3Xp173fdtELOQvyb0hDKGWXXXvv56q4wvFg=;
 b=JBvgke9SPjz79Uq6saP60skspthG5LZFjuJmQXhHaeTLEkzWHhqwiwjNVbl0lI9c398Z13nq0n4hq59SYZk/y/BrPVhkHzNb4npQRxuczojJ/qCdS62Gwwc7KE+gElKbrtQu3Sf6aH6tY7wI5hm9ky20iFWxHYQtVb5jzH7cL2WvhzN7ABJI4JXUFvUOP2wXYqwfw2xNK8RgALZh0x2T/AhL5uvc/S1597/QVcpH8SXPhphk0MeYG2JkV691iSqc6rjmtvnsA/wghq9/Mu04gs1H77DTe1xs6acs7WqjOi9vDPzbYt0WBuhKqPLSazS4Y6euJs4avwQgnmEH3AtZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmAc2zGW3Xp173fdtELOQvyb0hDKGWXXXvv56q4wvFg=;
 b=YPBlRKuVTF+lmevgwr2gcKlqrPnW2CbLcYhH77JbgOkIyXTA5FU6p85HXNVHvFdwjx7qnvkOQk0yruQ+VkMYVkXn19LBoFJTHOopP37PuMuCYkPCCWIBjgZ8mhq6rbf4Phg85J6bHXTt/q4dvcIOYY+n24thLpDfFS/Lk8HlZwI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3501.namprd12.prod.outlook.com (20.178.241.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Wed, 29 Jan 2020 04:27:46 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 04:27:45 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v2 0/4] SFH: Add Support for AMD Sensor Fusion Hub
Date:   Wed, 29 Jan 2020 09:57:22 +0530
Message-Id: <1580272046-32101-1-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::16) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.22 via Frontend Transport; Wed, 29 Jan 2020 04:27:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05da7ba2-0e3f-425a-e563-08d7a47396d3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3501:|MN2PR12MB3501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB35015FE858A58B492E02CFE1E0050@MN2PR12MB3501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(2906002)(4326008)(5660300002)(66556008)(66476007)(16526019)(956004)(2616005)(26005)(186003)(66946007)(36756003)(6486002)(8676002)(81156014)(81166006)(478600001)(7696005)(8936002)(966005)(316002)(86362001)(6666004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3501;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOEtTgiT+wE7OfFSZBBfTqLCXEZ+UGQRfhGhNGyfcqlTw0TF6oOm5O+GPVkUoUrqX8TXnRM6P9T8u2QspWsBLNfExZ9zud883Look3VJhOPvF2WFdimuk0tpZ5GEaPjutQ0FMkwrFgXPaUCBBhktiywkpLhLVG+flWdpaVjiqUqdfvEPbkJ1qX29vW8Yq6/4nXrYrzsuodnEyZ45UQsrwEeuLYjEYQSLZOCLVap7s7rOZwXP1swuA5uU4x5GtNcowAALkXo6ib01KJ+k43oZ73TEZfgKfH4DrbJqZxlLn1kLnYgUsuayn08uaYZ+OjEoQr9YPz0JvpvYRrdHxZBzNWhChpktD8O15sTLXZsIIUMsk28kkxI96pic0qOigS4pSwC8P2216GuzuhExm2ayYtAtlFd9t8UO8KnJf8TvYum+VfuJRkFpraDT49AAd1JhUjF+vvvkukw5heSjH88SNiPQm3hRhi9OK2SWCsrVPXNRwJ4sHa/48YtFeFtXmirXikp5JFVcI5Hv/BadhS2xtQ==
X-MS-Exchange-AntiSpam-MessageData: e9kvz5iG1bLaQtRk18nl7cCXyluG03BG5C/51Smeyou+eud29F8avXo7jYDND4APdzAKQ8lG6si29AdXnpQGeEruNeReNDljIgi5IZ8jUYZbPnOqvkaGzmVBgVIhRimZ6b0qM7Ae7Di6XfDSYIFhwg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05da7ba2-0e3f-425a-e563-08d7a47396d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 04:27:45.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6H7UE95QTiaPG+k3vrsmRadtigwQRsT69d5reRM4q5wvIVg+alr7j2mbfjWIJkNL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3501
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
  SFH: Add maintainer list and documentation for AMD SFH based on HID
    framework
  SFH: PCI driver to add support of AMD sensor fusion Hub using HID
    framework
  SFH: Transport Driver to add support of AMD sensor fusion Hub (SFH)
  SFH: Create HID report to Enable support of AMD sensor fusion Hub
    (SFH)

Changes since v1:
        -Fix auto build test warnings
        -Fix warnings captured using smatch
        -Changes suggested by Dan Carpenter

Links of the review comments for v1:
        1- https://patchwork.kernel.org/patch/11325163/
        2- https://patchwork.kernel.org/patch/11325167/
        3- https://patchwork.kernel.org/patch/11325171/
        4- https://patchwork.kernel.org/patch/11325187/

 Documentation/hid/amd-sfh-hid.rst                  | 159 +++++
 MAINTAINERS                                        |   8 +
 drivers/hid/Kconfig                                |   2 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/amd-sfh-hid/Kconfig                    |  17 +
 drivers/hid/amd-sfh-hid/Makefile                   |  17 +
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c             | 256 ++++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h             | 169 ++++++
 drivers/hid/amd-sfh-hid/amdsfh-debugfs.c           | 251 ++++++++
 drivers/hid/amd-sfh-hid/amdsfh-debugfs.h           |  14 +
 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c        | 261 +++++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.c               | 179 ++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.h               |  85 +++
 .../hid_descriptor/amd_sfh_hid_descriptor.c        | 275 +++++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.h        | 125 ++++
 .../hid_descriptor/amd_sfh_hid_report_descriptor.h | 642 +++++++++++++++++++++
 16 files changed, 2461 insertions(+)
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

