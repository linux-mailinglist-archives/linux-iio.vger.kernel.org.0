Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A13393F8
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 17:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhCLQya (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 11:54:30 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:62531
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229959AbhCLQy0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Mar 2021 11:54:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGMBGzG+B01SA5EzCai0txBB8UIcbN1I/YfeOn0ucTHMxZ39EDXy4YoFaQHZ6s7ed4VM19KXoQdUCtsceIR73QLTm+gYdfuPAx1Z2j3DQCuwGpWywj0LVqajTGOoUza3hKOyF93eynYlh1IX4FKNRT8mHiyrHtasGf+PUcjRLYlCbdnPrj/OCQAmUhIzwejBxsGumkTHzJ/hQUCoX98yle2SedfkmKaWDVppmGnEQjSHWvwE2wuisLrf7B64sYcmWFQSPLvu133sHBxtD1Bq93KopHjP2wVxu0dT4UIfDwS7IOlYhNgcT8sDSxPBalbFZ/NCCI1AbEMFRqAzgRVJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMgDp8XTGAvuieCmDAQhuY0imYjFjHbfTJWSxexOjhQ=;
 b=aQr8lfnMQOX4FLuddNZPssUeYyNIMj5LCecghkzNS5nR8b3VeYhNIH+450XcDnVcJfXjMOMc3JyYzeDRj99VoY+ICplvEr5Jezwhut4dO0+T9bKJPx2hwxFNdhJbLuUCYwgpUh8HCXAMS7Ik2goXroGxe2rbpQyvYoVr9DRXbXNexEpZOa4JKRzPEnxQJ+Qa5zdk0ylUMGJ3kqOkRq3CllDDdhBW5AN2UnNaivQ0sdAuL9ESewd2M2L+8Jkd6v/+Y2fzVv5Wubpj2nnyW67OfJl++F5AuXGuplIT8mnd7k6V2zweyeFxyzJP4Kos9QGkeAx/KbPV35brrmSCHBHK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.46) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMgDp8XTGAvuieCmDAQhuY0imYjFjHbfTJWSxexOjhQ=;
 b=n5hpVl2Sz6S20bT7Q4yjzQ2YZVnBSRXWloXBuAbHrjn1uudVnuDRsqMwqHsroRgNCDksKT4EFZM4zD6yNZaei7kJTjldUCBM41sGSwE8yZzifp8q0Z/HTwQYazvS2j0rQ92EkUVzxHVU6lmiUUuxtFBa3BEZhnYJqJSvYjxt4i8=
Received: from MRXP264CA0026.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::14)
 by AM6PR06MB5125.eurprd06.prod.outlook.com (2603:10a6:20b:6a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 16:54:24 +0000
Received: from VE1EUR02FT059.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:500:14:cafe::6) by MRXP264CA0026.outlook.office365.com
 (2603:10a6:500:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend
 Transport; Fri, 12 Mar 2021 16:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 VE1EUR02FT059.mail.protection.outlook.com (10.152.13.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.30 via Frontend Transport; Fri, 12 Mar 2021 16:54:24 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 12 Mar
 2021 17:54:22 +0100
Received: from [IPv6:2001:1458:202:121::101:cf2b]
 (2001:1458:202:121::101:cf2b) by smtp.cern.ch (2001:1458:201:66::100:14) with
 Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 12 Mar 2021 17:54:22 +0100
From:   Michel Arruat <michel.arruat@cern.ch>
To:     <linux-iio@vger.kernel.org>
Subject: IIO advise + help
Message-ID: <77dd5cfb-1215-e929-24cf-2b773f33d2ef@cern.ch>
Date:   Fri, 12 Mar 2021 17:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2001:1458:202:121::101:cf2b]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbeee7d6-bde7-4ab8-29bd-08d8e5777d95
X-MS-TrafficTypeDiagnostic: AM6PR06MB5125:
X-Microsoft-Antispam-PRVS: <AM6PR06MB5125CE65F4931CE43221C840EC6F9@AM6PR06MB5125.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sh2OZleRsYXayqftrL4FbacAqgH21/qiGachhAJ3iW9RT0V7rv2slNj4tLF0ej6KCJmPlITSfedGuGYtuJkX5LPDlJurlK6OdhGV4JTa7FyA9oYt6ZiQwCCuxMoGGG/gdv/R4422L9iI0rAqYe223kP5tZYO/M0jkITwBmd94/grubSOxE/yK4mcd/++nr/MZAOYMEpwzb8EpRM3ZBdhLe7JMyOGeT8Gb+LNxS7ZJKMnYA4O0u5Z1/zLeRx67oBm8FrpDy1W9EcMQTudW/Kn4OHI5dyUfU9G9JdWmHcP2NUs0QATvtH1u4h1UXkD/W6MR5THF91Lxe1FpJnP0/xW9+8btyXEu3pywCI0/hoedwC7noclKLD12vMG/L79hIch3CVYrD8Y912dxDTjdkUm6KzXj2BpPsdJBZRG/frXKoWlJ4gTxmUsVrnIUWjmUZU7y6OZzltK4FYA810PzwCIWkZDGfHKujPoDnunbkRBPpnxSRUhDbfZpgOtnQQ9kAXfDMAalNp78iCUoGJPimo56z/1meKJ3gEEdCVQkJBVRx0QwKA6ffNGEf1dslXToVc0PTon00jlzxorMhf9qOJABjyYnpSeX5tm0L8EvHb/6NFTqie96Enhmig2bOiZuZZ/mkqaXJbG9mF2D7kL44EJw54cJFssRnjYlbFjGFpNCLZZSfGkSKwiH1fq9h1PtRHda7jZxwdt0VNaVSpxjo+1puK5jgTi8lKY9qhqMMHpZW1rBOzSVOydi39f6ek+tcpTnCxinIQascNgLzMdccFcQg==
X-Forefront-Antispam-Report: CIP:188.184.36.46;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx13.cern.ch;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(316002)(82310400003)(5660300002)(8936002)(36860700001)(426003)(336012)(36756003)(82740400003)(6916009)(70586007)(2906002)(86362001)(7636003)(26005)(16526019)(186003)(356005)(47076005)(31686004)(8676002)(2616005)(44832011)(70206006)(31696002)(966005)(83380400001)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 16:54:24.1172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbeee7d6-bde7-4ab8-29bd-08d8e5777d95
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT059.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5125
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear IIO Maintainers,

I'm starting studying IIO framework in order to migrate our acquisition 
systems, based on fast ADC, to this framework.
So far we are using our framework named ZIO which was developed more 
than 10 years ago, when IIO was not mature enough to handle high speed 
constraints, large DMA transfer(>256MB) and zero copy.
Out of curiosity https://ohwr.org/project/zio

The idea is to get rid of our local framework and move to IIO to benefit 
from the large Users community.
For now, most of our drivers are running on x86_64 architecture, even if 
future applications will run on SoC (Zynq UltraScale+).
I made a first prototype, widely inspired from your "ad_adc.c" driver 
found on your git repo, with a 4.18 kernel. I am facing some issues 
including kernel Oops while unloading the module.
Could you please let me know which minimal kernel version is required to 
use the "IIO DMA engine buffer" features. In addition, I would really 
appreciate if you could point me to some reference IIO ADC driver 
implementation that handles similar DMA transfer size with good 
performances.

Thanks in advance for your answer.
Best regards,
Michel Arruat.

Oops:
[ 1110.718286] Oops: 0000 [#1] SMP PTI
[ 1110.759964] CPU: 5 PID: 155923 Comm: rmmod Kdump: loaded Tainted: P 
      W  OE    --------- -  - 4.18.0-193.28.1.el8_2.x86_64 #1
[ 1110.900606] Hardware name: National Instruments NI PXIe-8861/NI 
PXIe-8861, BIOS 1.2.4f2 01/09/2020
[ 1111.007906] RIP: 0010:kernfs_find_ns+0x17/0xc0
[ 1111.061042] Code: c0 79 04 31 ff eb f4 89 c2 eb e3 0f 1f 84 00 00 00 
00 00 0f 1f 44 00 00 41 55 48 85 d2 49 89 f5 41 54 0f 95 c1 55 48 89 d5 
53 <0f> b7 47 70 66 83 e0 20 0f 95 c2 38 d1 75 52 48 8b 5f 48 48 89 ee
[ 1111.286038] RSP: 0018:ffffa5b406e67d08 EFLAGS: 00010246
[ 1111.348548] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[ 1111.433971] RDX: 0000000000000000 RSI: ffffffffb5ab1588 RDI: 
0000000000000000
[ 1111.519394] RBP: 0000000000000000 R08: ffffa5b406e67e18 R09: 
0000000000000004
[ 1111.604828] R10: 0000000000000000 R11: 0000000000000001 R12: 
0000000000000000
[ 1111.690250] R13: ffffffffb5ab1588 R14: ffff99f3c8c82ae0 R15: 
ffff99f435506390
[ 1111.775673] FS:  00007f5690560740(0000) GS:ffff99f435b40000(0000) 
knlGS:0000000000000000
[ 1111.872553] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1111.941310] CR2: 0000000000000070 CR3: 0000000248d1a002 CR4: 
00000000003606e0
[ 1112.026732] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 1112.112156] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 1112.197596] Call Trace:
[ 1112.226778]  kernfs_find_and_get_ns+0x2c/0x50
[ 1112.278872]  sysfs_unmerge_group+0x18/0x60
[ 1112.327843]  dpm_sysfs_remove+0x27/0x60
[ 1112.373688]  device_del+0x85/0x380
[ 1112.414323]  cdev_device_del+0x15/0x30
[ 1112.459143]  iio_device_unregister+0x29/0x70 [industrialio]
[ 1112.525821]  release_nodes+0x21d/0x270
[ 1112.570626]  device_release_driver_internal+0xf4/0x1d0
[ 1112.632094]  driver_detach+0x54/0x88
[ 1112.674814]  bus_remove_driver+0x77/0xc9
[ 1112.721704]  pci_unregister_driver+0x2d/0xb0
[ 1112.772758]  __x64_sys_delete_module+0x139/0x280
[ 1112.827977]  do_syscall_64+0x5b/0x1a0





