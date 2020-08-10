Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353B1241261
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 23:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHJVbb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 17:31:31 -0400
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:46689
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbgHJVba (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 17:31:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka/P9ssAEmjdfMIuWzkoX28BOjYHWHAIWSoTYUO37e21tDDNkqw6OUufT8xHYl0V0O4+QXAky8mlidQmGGbQUXfnocDlIKQ5c9klLzOf6AnRUR2khggB2N4PEjgng48LTxHZFtifC4xy9qAcsk87DzWpTa44UcOnQDWd+rBgGW65+rJz/tbTKuLpSlTRy/l6w/GImsT4f0TCt5BhcXy4obiSIJPdaKcdm28HWVQnGhwC4dOCNbhZGIMm5E5EpdpH9E9+A8l3jVYJ0VKu0yMcsrufo/AApnuJs29cBPzXE/DLc9RFbTN5EBCR1qjWQtWUyMoRtGNsCCDkteTsmOE1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRhOQA9n4u+nwuyLR+L7p9Z6yyLr05FL2I5/7hK4Arc=;
 b=FW0RxuKU4KVinkw0Alzkap2/3fec5g/ovo/aPeNWG3y/Vyh/FTEXf7ZxZK4ywhWLRywX1+Ju4o4oJiYkzaxvWvjTQsqYVzfbFFU4UotISpw1SEwaF6uYd0ey/Ml3/1SYOGIX+ix9XJiWNSU4Xdmpse17r+O1l8PTz6nd/vMckzZaGMxGWyh6K3zRITA/vq/h0iiL4Gfr6hwHaR1UTQ+KnjaiFYWcCkxPgryJNj4+tBCfKCBwz1wLO04blMLQ4gwQGPPEWizQTYWor7/VmXhdxuQ6ZcEB0gEomZZAOw8inpTUeZQb/dk18GZpuMbX5ePwm5HudCjdpRhGbuoM+0YXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRhOQA9n4u+nwuyLR+L7p9Z6yyLr05FL2I5/7hK4Arc=;
 b=1X++8ZlAjsS3rOySVxvlL6z4wtJ17EPnyVHb+vZV08AUYGxOg6h89oBAlNOJ+LWdNfv2nVJO5RQv9KVNgKD5XjmqXKbgXevC9vXlj2N8IsDYhnYQDb49sLAxIIYr+rC2RWV2lAbGviQ+MIHKXr9PdvM8MA3ubVXOFnSqAoiaoLg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BY5PR12MB3714.namprd12.prod.outlook.com (2603:10b6:a03:1a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 10 Aug
 2020 21:31:25 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 21:31:25 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v7 0/4] SFH: Add Support for AMD Sensor Fusion Hub
Date:   Mon, 10 Aug 2020 21:30:51 +0000
Message-Id: <20200810213055.103962-1-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Mon, 10 Aug 2020 21:31:21 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eec20f42-4f92-451b-5792-08d83d74bbad
X-MS-TrafficTypeDiagnostic: BY5PR12MB3714:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3714FB1684DEC562E1CAF724E0440@BY5PR12MB3714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2KvzRwjTS0AXl7kRUq93PLb2acU0RVzuwFuMUDlJyQLrK/OlaPh4/nOiLq/P045fQ8EbCnE/JipXOdxNR/LdfLIbwt+KMELgqx73cQY7euiPFdaOuV2DYdPmoSupicaixSthaze4ItjFz3JXFxAJ1BNqzHHC06ohBAJy9NuLX4WwlWWEYk8G6wXqAlun426qQNMIS9HxKE6fuCvosiX312togi6ADWJYj63E6SjnBsRonYSt0aGz30J/qgzu8psninnsvytQsdTbSeEyGf2zks3L0QbO1xJHBp6w5wCKEdp8YIucj31apTkqBIIp6fuNbgZgEpxM9w0I6LWiDFCkw0DKyxG2G++BoJnKYVgOVooGTCcqkEmXYe+DlxDJJCqkmyVjQAqHX9gRZo0a9hGow3fgqHjakFmbvJ4jHWnT7l394yLbzXGoSFeJWe9FE7A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(2906002)(1076003)(7416002)(83380400001)(478600001)(6666004)(52116002)(66946007)(7696005)(8676002)(66476007)(66556008)(26005)(6486002)(5660300002)(8936002)(36756003)(956004)(2616005)(316002)(16526019)(966005)(4326008)(86362001)(186003)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: V04MBusHYyO9kZuR9MoaT6T40VOJusP6GZJpP1N1bTB87BJYyIjJ9DokkseFwx9wP2qbftworBEjYrWGd4spUbNJC3sPl8JlW870vJcHjUT3zhdYFFziy6hLMubrrwYV1eW+XVlD1FbzvqmB5KtqiI2R4LhNn0aSI7dcw7aXDP00491lzrnCXsf7JylNkv8VLbSmeCtUV/4ljjXnFREUpvqWIVx+3YwLERTsebJ5uh84l3HEx6nuroWeEvyf0IgdXl1OUNDQgc7aELF4k/VQ8v9eoxoX2uVhAOQs/AAcGmTuVWAHcykVrMLvsqMRX9JE1RfU1qCmpDoMtLFpXhy7Vstf1/QDEicWxXwXbGM2SNLlSO/WhkVxE/yd9wMVvgMKkfrol/3FlcrAyAmAZqFM1miWrCLHZ4CHPbcBsFGA16z3Qawx75lKpQjdKT+TH7bard5Wz77NhIM6z9PWjKy/0YzE/O3thYd+LrRU8MtwIFZ8J1kp+E+m8ByrBIPrauNXtbTK5dOyiZWcosGcD4/BQJMb76MzZp6kdO5qSVmugn03c/NViK5DexHXJZtLrUl0O5Y56luuO39xGkUQ4k41jirPsICBROSqDI1oOd38lx6HNmZNrZM3k5sdXEXmmWg3Z8rDozT92lMcw/+/XnxW5A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec20f42-4f92-451b-5792-08d83d74bbad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 21:31:25.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C61zMQL+PexUUVkdOmD31fPlCY5iLi6Wa2MQmNFNkW0C4euvLv3FH+jQgM+6BLUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3714
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW is part of MP2
processor (MP2 which is an ARM® Cortex-M4 core based co-processor to
x86)
and it runs on MP2 where in driver resides on X86.The driver
functionalities are divided  into three parts:-

1: amd-mp2-pcie:- This module will communicate with MP2 FW and  provide
                  that data into DRAM.
2: Client Layer:- This part for driver will use dram data and convert
		  that data into HID format based on HID reports.
3: Transport driver :- This part of driver will communicate with  HID
		  core.Communication between devices and HID core is
		  mostly done via HID reports

In terms of architecture, it resembles like ISH(Intel Integrated Sensor
Hub).However the major difference is all the hid reports are generated
as part of kernel driver.

AMD SFH is integrated as a part of SoC, starting from 17h family of
processors.
The solution is working well on several OEM products.
AMD SFH uses HID over PCIe bus.

Changes since v1:
        -> Fix auto build test warnings
        -> Fix smatch warnings "possible memory leak" -Reported by Dan
Carpenter

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
        -> Fix for review comments by: Andy Shevchenko
        -> Fix for indentations erros, NULL pointer,Redundant assignment
        -> Drop LOCs in many location
        -> Create as a single driver module instead of two modules.

Links of the review comments for v5:
        [1] https://lkml.org/lkml/2020/5/29/589
        [2] https://lkml.org/lkml/2020/5/29/590
        [3] https://lkml.org/lkml/2020/5/29/606
        [4] https://lkml.org/lkml/2020/5/29/632
        [5] https://lkml.org/lkml/2020/5/29/633

Changes since v6
        -> fix Kbuild warning "warning: ignoring return value of 'pcim_enable_device',
	-> Removed select HID and add depends on HID 

Links of the review comments for v6:
	[1] https://lkml.org/lkml/2020/8/9/58
	[2] https://lkml.org/lkml/2020/8/9/59
	[3] https://lkml.org/lkml/2020/8/9/125
	[4] https://lkml.org/lkml/2020/8/9/61
	[5] https://lkml.org/lkml/2020/8/9/91

Sandeep Singh (4):
  SFH: Add maintainers and documentation for AMD SFH based on HID
    framework
  SFH: PCIe driver to add support of AMD sensor fusion hub
  SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
  SFH: Create HID report to Enable support of AMD sensor fusion Hub
    (SFH)

 Documentation/hid/amd-sfh-hid.rst             | 153 +++++
 MAINTAINERS                                   |   8 +
 drivers/hid/Kconfig                           |   2 +
 drivers/hid/Makefile                          |   2 +
 drivers/hid/amd-sfh-hid/Kconfig               |  21 +
 drivers/hid/amd-sfh-hid/Makefile              |  15 +
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c        | 164 +++++
 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h        |  83 +++
 drivers/hid/amd-sfh-hid/amdsfh_hid.c          | 175 +++++
 drivers/hid/amd-sfh-hid/amdsfh_hid.h          |  68 ++
 drivers/hid/amd-sfh-hid/amdsfh_hid_client.c   | 244 +++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.c   | 226 ++++++
 .../hid_descriptor/amd_sfh_hid_descriptor.h   | 121 ++++
 .../amd_sfh_hid_report_descriptor.h           | 645 ++++++++++++++++++
 14 files changed, 1927 insertions(+)
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

