Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE691E7EF8
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgE2Nmp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 09:42:45 -0400
Received: from mail-eopbgr680057.outbound.protection.outlook.com ([40.107.68.57]:51584
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbgE2Nmo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 09:42:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWqORxtqlNoptL1ECeO3brTiiggEYvTlT/AGoDn8DKAYyc7MsLR4prH/rxeDfrFmPjXaO24tsEwdMegZq++fRA/hW61dC3+566i9FmjHm5GVukhjV4BFRabbVfo0NwJQU95DHPxaHemgyJKFK/tZbQhtlLJTjV9ifYiR9ZEv2UMD6gQPwSFg4naCvkqLm//iRhmpUwCPo4M7xHPfi/EGA6CoyJQ7D6U0rZkKvDVcZ9WlbDDJ6UJtb1azKsiOT7Aak80cyq5WmKNRrckG1RVsnVdppV+ir6/TjeXKWcBecK7VIce3rEa+RAJVousD/zFdJpAWkML3fpP6zJxucjCP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcaFTh2TzQ7FE2SJ8suotl2PPD56lUxsIGukKvqEw08=;
 b=nKFAbh44oR3eUM0BdfOduoiPQmq/QVEsxbhOTR4kXy8h7ocezxhBHYIK1RFu9GPJl2BdMbfLda7HDBi7QleH1SqnxzTnjS1mgC4VUlVVy4oRDAUnDc980QOuKRx1tvgL499xo3EkgAOcUjHdKRmE3S9SVxUxgTpSmuhno4xjlIPowUwxlkvfFUrpddRuYt5ZpWJ2odqmxT/9rLf+rdxMu6+L9wScQ2K/Ff7R0Ohk1jj/wfC/hSzo4r/a7jFprHwDqULp6CAzTkRt35krpI8mqZpk4Sm0rMLIHas9YPvpdozI6UtmhXwA9yPIvzNpIRM3s19vSiz1Wegd9/8oehEzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcaFTh2TzQ7FE2SJ8suotl2PPD56lUxsIGukKvqEw08=;
 b=wYlShrBviXyDkJLwbZVeb/EXSYkWAP7NjrokUKK5tHH8SRlVmGn/8Jqhg29SrbsS2Cm1fQuN5dlARvGclK1wYnEy6EZTbRbaDDaMNa75Pw5kt+jxIr8M/DE1BIkmsUC5OXZuKdO/oqkRDECvV/JCniVoBIXkydMQMrQqOdKzloU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BYAPR12MB2805.namprd12.prod.outlook.com (2603:10b6:a03:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 29 May
 2020 13:42:40 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::a984:b7cb:3ad0:7508]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::a984:b7cb:3ad0:7508%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 13:42:40 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v5 0/4] SFH: Add Support for AMD Sensor Fusion Hub
Date:   Fri, 29 May 2020 19:12:06 +0530
Message-Id: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::17) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang2.amd.com (165.204.156.251) by MAXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 13:42:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d86102a-eeee-4c7b-3b56-08d803d627b8
X-MS-TrafficTypeDiagnostic: BYAPR12MB2805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2805AEE1A51B6843F7D0214CE08F0@BYAPR12MB2805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+xJr2q8mfXj+JFRYZIEPlQifQUjR6g1J7/E8y2tbbqTj+aKGKU1xzm5LaLMpF+WbgCfK0WiLNJZp4OEJ/zbXjckOCe1e1LF6ZDUBF3iq8MKBcj5z7/7yeAsy24SozRFvwjsZz2DxwLkvJAejdMn7tzhHNPRwixpb32Qwd5w8Y4gDnEbpWmFQs2KSOVt/jsdxzpPOGlDQTCSBB3rjq7MNJgJZcFPg/11C1oR5ZJraxKjr3iZ9aOyU/izPJQ0+2OiMrt+s7lfXCEc5GSewOh0CWc1zDMOurwDqZGAYQv9OOCX5gdJnoRBYnBC6AawUBo8H2MUePRLYeMQmuGUYGj2WKEfuNptUSNL1QBZjryM4AjWKTnanmzd2XlUVBqWTkGBnNp6Fi+pHjfpJWVPGwvgxexqBBqVWu0wv7elh3V1kSEkzgMC2TKFU5VS7dbUJ7cTKvep07vv10LsOF/JYb9RTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(316002)(86362001)(83380400001)(478600001)(66476007)(7696005)(52116002)(2906002)(6666004)(966005)(66946007)(6486002)(66556008)(36756003)(5660300002)(7416002)(2616005)(16526019)(186003)(956004)(4326008)(26005)(8936002)(8676002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: w5MX2ZFpaE2HfeJdYRQgBq/ksqrSLgDKc1I35UR3eBls9IBqY8RIek/a/lEkZknbkTALT7I5oBlyGEH8s8j+zazAO/10n59dzNqHN1RM4cZTdVt5/XBPS4SsCC3zCVt7SADFX5yZTTYptTOiIGooGemxYe5kZvKcnz3o42ZY/1Bv9ss2JVTHqv5XB3DL0IUQI4vpMziqXDv3y1qP6w9IDo50ZyeySnjGhfFQmrARUor607J5cSLYfMcjXOTd1k6GosOPX1xMdVzPvhVX1xLyimFlAVD1RG1oyyexo8Ese60DhVAkYFBcnJm2o34y5NygKddRk3sfSshunSRAlgmH96II6g2J/i6t0PWrZgS9fmBFFXJZRKLQ7tWmWH4r/JIXOumtQw1ObLr3rBv6dntBAYeDBNL5i2TI/LyQCUPnVlZ8tlqb2K/noSyBeOvMQwpOpFqAg0Y26rUuMK91VQGF5vJFP8K7Fn+zvRLgBY/xQFmBqekynsG0oRoR+8gJ6Tbn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d86102a-eeee-4c7b-3b56-08d803d627b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 13:42:40.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Vszq0jhL9FYPqUWURV3f3BtdVDmVVFwhPMyDUE3r84rzIQnYGPY6hrEHDNjQo2f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2805
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

Links of the review comments for v3:
	[1] https://lkml.org/lkml/2020/2/11/1256
	[2] https://lkml.org/lkml/2020/2/11/1257
	[3] https://lkml.org/lkml/2020/2/11/1258
	[4] https://lkml.org/lkml/2020/2/11/1259
	[5] https://lkml.org/lkml/2020/2/11/1260 


Changes since v4:
	- Rework done based on review comments by - Andy Shevchenko
	- changes done based on suggested by -Richard Neumann

Links of the review comments for v4:
	[1] https://lkml.org/lkml/2020/2/26/1360
	[2] https://lkml.org/lkml/2020/2/26/1361
	[3] https://lkml.org/lkml/2020/2/26/1362
	[4] https://lkml.org/lkml/2020/2/26/1363
	[5] https://lkml.org/lkml/2020/2/27/1


Sandeep Singh (4):
  SFH: Add maintainers and documentation for AMD SFH based      on HID
    framework
  SFH: PCI driver to add support of AMD sensor fusion Hub using HID
    framework
  SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH
  SFH: Create HID report to Enable support of AMD sensor fusion Hub
    (SFH)

 Documentation/hid/amd-sfh-hid.rst                  | 160 +++++
 MAINTAINERS                                        |   8 +
 drivers/hid/Kconfig                                |   2 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/amd-sfh-hid/Kconfig                    |  21 +
 drivers/hid/amd-sfh-hid/Makefile                   |  16 +
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c             | 196 +++++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h             | 137 +++++
 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c        | 256 ++++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.c               | 179 ++++++
 drivers/hid/amd-sfh-hid/amdsfh-hid.h               |  84 +++
 .../hid_descriptor/amd_sfh_hid_descriptor.c        | 251 ++++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.h        | 125 ++++
 .../hid_descriptor/amd_sfh_hid_report_descriptor.h | 642 +++++++++++++++++++++
 14 files changed, 2078 insertions(+)
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

