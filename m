Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF842289729
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 22:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbgJIUCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Oct 2020 16:02:39 -0400
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:43745
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387717AbgJIUCW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Oct 2020 16:02:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbYSvUiEF4aw1D/6qZg5gtErs6BsjXIzzRVAK6nXNB6oXTAreIFpeaHTS1coDxU7VP2VyXUgi0PHpNHlSBHZhbgtz44MdcwS27xYUqtrQd0cA72IfFWfJeafBNaH9pqu087BTo2BjHVVyYXDBZHbbRT0njfkxrcVtv0B7eXrhS+a+gVxRtSapIDlIUfN3UEdAW9sqHUR2H4wDV5Zx5hxKVR+o6/t7FfT7vT+jM4BqB1v13kVcmKTJduGJc/otYUSHB8W+Iq7NbwPhF9JwKXq6LMiuf3vqGoJKRThJKgJQ0eQPd7wiY0fAvppLvqdOUwrcTI8OHwJUXV9OaH+iq9vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6okwF4mwLom/pFuSu1nYWJusJ3bk4LFuBMxAlRU7eMA=;
 b=iBLHtnZ9lpX8vKQHD/GpaXQRR/ogpIjfuaXISKnlmD/AyVT8Wmiwmmj2UceWRdFlLKXEUiwZJvqQM080HjG5PBa4T9+zUYUDj+T78mW8pvRolbrcSPZYD5rgKovJsFgPN8Q+RbfpWsTatPHIQPNok4P03v6zdsCOSRuNWrTKpXsTLdTMs9+1TEi1rogRThtTIDAfbvKxW+GeDSoZU8YjqgitesCVF6+gmPNWrdrZ1g+U0Xqy2MtD9n5TOmT2YWNOIcKTtYcyfWBjkmgka05EE/l0OtcMgydkcx2Tegg/1y2DPY95BXMACcZtgQwnXIzy4bw4sUg+rNvKI2KNTSKxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6okwF4mwLom/pFuSu1nYWJusJ3bk4LFuBMxAlRU7eMA=;
 b=r3Qv8GHxkvpNodFa11IEk8nww7q4Axn0HG+lgea+J7OU/0MCYMqJCEf275bxg4CY3efqk8M+rNewlrIef1oE77qKGzFk9BqcLnlANC3Io+1trVi1kLpZ7ysNYPVkJJn98PfNhyBfnfv2AWU90AfUalrZJthNuFA1C8ULhv/DcWY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 9 Oct
 2020 20:02:16 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60%8]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 20:02:16 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v8 0/4] SFH: Add Support for AMD Sensor Fusion Hub
Date:   Sat, 10 Oct 2020 01:31:34 +0530
Message-Id: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::24) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 20:02:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7aeca7d-1b2f-4a68-f85a-08d86c8e3847
X-MS-TrafficTypeDiagnostic: CH2PR12MB4859:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4859EBE98C92D24A5BA77E9CE0080@CH2PR12MB4859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDOcEnRgeQbQKeLdhpJS/7Q9+s14/JVjsT045Q4w4XySB4/p1nWNuoMAmMEioN4lyJWP3xOmxyhJZ6aEobI13Q7fBMkIthqLGupz7+tC5GkWeNL+/jQYdreqoB+TWOh0WoT7uTl+z6JNsr7AKHEyyf6Y5nojBrAHjm4ieXzs6lT+pxONqbkzRTgkgcpvH9V7K43CCM3w0/v2TPyEY72rjdu0V5p/qo3DREKUgICtj1hIlzfHWAlVSeywnSv5noTMvx6YbzDNAx4MIFEmMF65Z+lOhKAs61hdEBP9olcmKE/YsfS8BLF9Uk9HgVOdwLrrhZ8X2elIDK8WcywzNUT/gu4shKY1Hjqkiz6gu7NhpmgDXUobXe0t8ovUTwSpCdO8Zz04exOyKWtcrGEeC3THqmprfNUtKYmqKpD07LhaohzU2FjjpymfthhkoBCVLW/2oBEKhea1G1k5pcgqNqO4Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(16526019)(86362001)(956004)(83080400001)(7696005)(52116002)(6486002)(26005)(186003)(2616005)(4326008)(83380400001)(66476007)(6666004)(36756003)(5660300002)(66946007)(316002)(8936002)(478600001)(66556008)(966005)(8676002)(1076003)(7416002)(2906002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GBzal0+K314DTKoG7U8HjZvgvxr4jHj7Pdeoz68AlC0SD5wmeNEtKWWKD3NmNf3V1h3DaU8BQubzt2ZN4Jg3Z7S8gPijRGkqQ/ka4MeM6eL1yHBANx89kcEKnK4anN0BvpF1Z+3RyaxCpjOP263wn8t18ugZX7Kpuu61F7nL9q2M2w8hWgjBBPHW5NK34U/a0HaBHYvCvgVhEIIWEjoQ7Su3cSexA/orzoDOyEVIkFOzBUiDSa1n3OvTWde5YC/DvC7yJHhzZaen8bTbMHvQSsx+Kwdklkm+eXNdK1Z+B3pKSswurbyxC++NbVur0RM9yw3D+4r9bf7N7avM5cH4ectA9UK64JqA7eH9Mwhy5duLiY8V7srJUs3OP180P0LpLrhb3gGnI6MI0+wPLmI4HuLZ1xHHBOBlfW4nKizSUcK1XaIfrEvniPopOu+QuVxcygnf10O/OHW8ZNrzkNbWWSUtE+w8LlkH8dH8Oae3xlJal44TqPYUGol2P81u+z5/iUdIHrqOPQ8aj659CJ7lAz654xJcw4v2henDWPWGdfBo/5cyUeSrtLFa47DbnV0Rk2PS26ymoLM4bl7L4Qe+TMt9QirxW5F2KquLii+x6gFIGeT07WjOMtNKCVCJ56pOA+3d+F5xwQuCuWCGd++Qmw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7aeca7d-1b2f-4a68-f85a-08d86c8e3847
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 20:02:16.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdMdEezEai1Og5XrEhdXKGJApgGaQcr48MAQexTZOM10Uc5QIdRawSEw4zDuFSgf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW is part of MP2
processor (MP2 which is an ARM core connected to x86 for processing 
sensor data) and it runs on MP2 where in the driver resides on X86.
The driver functionalities are divided into three parts:-

1: amd-mp2-pcie:- This part of the module will communicate with MP2
		  firmware. MP2 which is exposed as a PCI device to the 
		  X86, uses mailboxes to talk to MP2 firmware to 
		  send/receive commands.
2: Client Layer:- This part of the driver will use DRAM  data and convert
                  the  data into HID format based on HID reports.
3: Transport layer :- This part of the driver the will communicate with HID
                  core.Communication between devices and HID core is
                  mostly done via HID reports

In terms of architecture, it resembles like ISH (Intel Integrated Sensor
Hub). However the major difference is all the hid reports are generated
as part of the kernel driver.

AMD SFH is integrated as a part of SoC, starting from 17h family of
processors. The solution is working well on several OEM products.
AMD SFH uses HID over PCIe bus.

Changes since v1:
        -> Fix auto build test warnings
        -> Fix smatch warnings "possible memory leak" -Reported by Dan
carpenter

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
        -> fix Kbuild warning "warning: ignoring return value of
	   'pcim_enable_device',
        -> Removed select HID and add depends on HID

Links of the review comments for v6:
        [1] https://lkml.org/lkml/2020/8/9/58
        [2] https://lkml.org/lkml/2020/8/9/59
        [3] https://lkml.org/lkml/2020/8/9/125
        [4] https://lkml.org/lkml/2020/8/9/61
        [5] https://lkml.org/lkml/2020/8/9/91

Changes since v7
        -> Add Co-deveploed-by
        -> Build the Documentation
        -> Fix cosmatic changes
        -> Add init function inside probe function
        -> Use devm_add_action_or_reset() to avoids the remove()
	   callback.

Links of the review comments for v7:
        [1] https://lkml.org/lkml/2020/8/10/1221
        [2] https://lkml.org/lkml/2020/8/10/1222
        [3] https://lkml.org/lkml/2020/8/10/1223
        [4] https://lkml.org/lkml/2020/8/10/1224
        [5] https://lkml.org/lkml/2020/8/10/1225

Sandeep Singh (4):
  SFH: Add maintainers and documentation for AMD SFH based on HID
    framework
  SFH: PCIe driver to add support of AMD sensor fusion hub
  SFH:Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
  SFH: Create HID report to Enable support of AMD sensor fusion Hub
    (SFH)

 Documentation/hid/amd-sfh-hid.rst             | 145 ++++
 Documentation/hid/index.rst                   |   1 +
 MAINTAINERS                                   |   8 +
 drivers/hid/Kconfig                           |   2 +
 drivers/hid/Makefile                          |   2 +
 drivers/hid/amd-sfh-hid/Kconfig               |  18 +
 drivers/hid/amd-sfh-hid/Makefile              |  13 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c      | 246 +++++++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c         | 174 +++++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h         |  67 ++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 152 +++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h        |  79 +++
 .../hid_descriptor/amd_sfh_hid_desc.c         | 224 ++++++
 .../hid_descriptor/amd_sfh_hid_desc.h         | 121 ++++
 .../hid_descriptor/amd_sfh_hid_report_desc.h  | 645 ++++++++++++++++++
 15 files changed, 1897 insertions(+)
 create mode 100644 Documentation/hid/amd-sfh-hid.rst
 create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
 create mode 100644 drivers/hid/amd-sfh-hid/Makefile
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_client.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.h
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h

-- 
2.25.1

