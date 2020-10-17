Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEEF2910E6
	for <lists+linux-iio@lfdr.de>; Sat, 17 Oct 2020 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437765AbgJQJU0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Oct 2020 05:20:26 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:51425
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437764AbgJQJUZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Oct 2020 05:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOEiSlS9hOxnrzPQOnwLJbStaSNhzgKkk9NW4CLKug5bVVpVnxwR+o9DTJoDCkeGSAQQkMEcurXA6PKDi7j0eSEkz9SrhnSywV0QJS6ve27oYJy50k0mp+4bh4RUeSFRGWVmud5WRvgPOBIOCYIu7ydZ1iNicskYnauBDj7eBfgRrOgcsA5YWa3/HcULzro++0aJAZDx31Mezh+InnZq73IIEnGGV97s5bFeb6oBtegKbbYz7NbqzXQmxGs9o5oBAChlRw7/O8XMKJ/hBCc8gtiis5vtUcBa1hV33zrOebG7O9tCMmO7eqNr2mdUXa6KLrLI33lFJRv8u55z29XJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkaHOMwy9Sgf5zSna1Gh+Ug6A47ltkgoGj4Q2vZ6e4I=;
 b=WgJn4HatVFg58yk+Ui+Fwzquz3i7KqRmCGUUeocyN1lV+8ExUO7a5T/t3r6vD80wJDhGdKJ5Vnc9PjWI0UD4EceAB2X7pTNvwogSyyHdMYJzhklXj98NOD37LkrQiv9WNzwk2RXhuls6FV+IIIkXYF2rTcZxKCaXr0AVvQ2n7yqRssZ9UUkBsc/m55UXjAgzEeY7PuoDL781yuiwCZphvdMv2wXUXoyHA4YrqS02JhnKzR2X0uqm4M40RzqUklA7q6air8cgTXON+uc1inQHfhDjwNT5SGqsqw/yZQx19NWcKBxef1/dMcOM8sou/PDSZwvGch0hIezeG309MXwE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkaHOMwy9Sgf5zSna1Gh+Ug6A47ltkgoGj4Q2vZ6e4I=;
 b=UOXvWyVREcokzLWK7vlnUNZ5g0KD4J7jsWRgQizVeaVszkLC01lww8TtDcv40ppy7oqNKR6HD0n5HCXymaSLTavyJsq02wMhsUiFXcnLtKaf3hnVE7TyuTHSDEeC4J0Bdwth6mfORRRq5Jh7j6WkdG6D6x9j7xiHgcbr6NF2qbk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Sat, 17 Oct
 2020 09:20:21 +0000
Received: from BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d]) by BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d%5]) with mapi id 15.20.3477.027; Sat, 17 Oct 2020
 09:20:21 +0000
Subject: Re: [PATCH v8 0/4] SFH: Add Support for AMD Sensor Fusion Hub
To:     Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
From:   "Singh, Sandeep" <ssingh1@amd.com>
Message-ID: <c346c389-98d8-9a48-8029-98bea180eee1@amd.com>
Date:   Sat, 17 Oct 2020 14:50:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [103.6.158.204]
X-ClientProxiedBy: BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::24) To BY5PR12MB4098.namprd12.prod.outlook.com
 (2603:10b6:a03:205::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.3] (103.6.158.204) by BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Sat, 17 Oct 2020 09:20:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b6141f8-f71b-4ba1-d13d-08d8727dde82
X-MS-TrafficTypeDiagnostic: BY5PR12MB4067:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4067FC03FFF81C7F188195BAE0000@BY5PR12MB4067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSA/vrj5rg+eiBa7izHGFMuKE/WxQN6Tu/eWYOPm/xc/ly8MxxCU9OWQ3C7QReEEsMPG2pBoVeKL4QKjd5rlfi3dkDH9WEu5aPHAnxpDXpb5/Mmt+X4dYUPvloV0T5iGMTjge8Nnh9flfc9R9x+1msPNo/cySHFVF2RUVgfx4C8fhd04YceGmBcoJ8kuJOEaFAnTGd9Ef+6Njhy58Zg+lv/PHBdpbT8zdqzsrcaNKXv9QEaPkTQNwOoKngEcqQPpo6dqkhqrfceLJgr5S/2xqwVWunIcP+IRYu5mC4YtQUMHBVoEXIX1tLfB8Jkb/HVl+OlR4Yp8jhQ8EWQ9DVbwdR/58+xp0hG+/GPeF3Jbq0/It2lnIWDCVyKrE6ilYSDViHa6kFamiPWDscgQD0JzYKoDT5R90H3ftc1rniw/qVUZF8msV2FGdgXrjoFwvXMGvul1BWd8Gy8NyykVNs9D+vfOf7OwHysEQ3fbrellweY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4098.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(36756003)(7416002)(966005)(8676002)(478600001)(4326008)(2906002)(31686004)(8936002)(66946007)(26005)(5660300002)(2616005)(956004)(16526019)(186003)(53546011)(55236004)(6666004)(1006002)(16576012)(66556008)(31696002)(83380400001)(66476007)(52116002)(316002)(6486002)(921003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gDQ43qy408j1ziaW7+ikcCEVsjYefYQNZI+4pI/tioBqbQhbeAexxJkmE4BczBYUCQF468+4L0Vic6S044roxM3/zD01R7gKwO8mTww4tA1mO7FbscexUbylGaD3qG5IYidLrWcDzjinVE5KhPy0ToN/0AahJiNC38Uh+QxK4Z6tdKyatdXQ3QRwz3kjMf+OyY8nmXKgQgIe1J0XM7xcaoJRFkylSRLC2D3IhLOFQR7kDR4Uv+BBRJewYdUA4oW04pF67LAo6dW88gDADcdtZBbmthmCwng7EM5bCHgZVrjcuuqS4sjsJdzeEpNUYhQq3ktHO9Gb3TmJ0xgj/nlnPtE/Fyx0sS+Kn1kamq6yfmjm8V8xhcodWmygt7kQa5CoP5XNG/RO5zGqVJQ2ya6IFcyrAmHz80MMr07y9yrFRQks6EHDpyZ5grW4HDv7H3ZXlvWDfajEV4xuRTPu4tZQgOfOYV+IhPnoMbUADpxZzvGbr03Q6sYZHlGgbkQIYyp+YiscuJbgHo5U2iiWiRIZ3rBtciXUC60WqEhbkD8SRIqwRES6JBLbppclnpsW1sp+5p3dWwccH7ZFp8iGxNFhZXs6fTGlzZ6OyBDr3Q2Qs/UDAG1OEkAPT/+CM4WhnfmWCs7fwmUFMBzihaHuLD/tXw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6141f8-f71b-4ba1-d13d-08d8727dde82
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2020 09:20:20.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W280KTMszTLEqpqjwGhzgqHtZKYivbKUcBAI1wKVgkgeD4jQvCdcnsEw69pIkhJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Folks,

On 10/10/2020 1:31 AM, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
>
> AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW is part of MP2
> processor (MP2 which is an ARM core connected to x86 for processing
> sensor data) and it runs on MP2 where in the driver resides on X86.
> The driver functionalities are divided into three parts:-
>
> 1: amd-mp2-pcie:- This part of the module will communicate with MP2
> 		  firmware. MP2 which is exposed as a PCI device to the
> 		  X86, uses mailboxes to talk to MP2 firmware to
> 		  send/receive commands.
> 2: Client Layer:- This part of the driver will use DRAM  data and convert
>                    the  data into HID format based on HID reports.
> 3: Transport layer :- This part of the driver the will communicate with HID
>                    core.Communication between devices and HID core is
>                    mostly done via HID reports
>
> In terms of architecture, it resembles like ISH (Intel Integrated Sensor
> Hub). However the major difference is all the hid reports are generated
> as part of the kernel driver.
>
> AMD SFH is integrated as a part of SoC, starting from 17h family of
> processors. The solution is working well on several OEM products.
> AMD SFH uses HID over PCIe bus.
>
> Changes since v1:
>          -> Fix auto build test warnings
>          -> Fix smatch warnings "possible memory leak" -Reported by Dan
> carpenter
>
> Links of the review comments for v1:
>          [1] https://patchwork.kernel.org/patch/11325163/
>          [2] https://patchwork.kernel.org/patch/11325167/
>          [3] https://patchwork.kernel.org/patch/11325171/
>          [4] https://patchwork.kernel.org/patch/11325187/
>
> Changes since v2:
> 	-> Debugfs divided into another patch
>          -> Fix some cosmetic changes
>          -> Fix for review comments
>             Reported and Suggested by:-  Srinivas Pandruvada
>
> Links of the review comments for v2:
>          [1] https://patchwork.kernel.org/patch/11355491/
>          [2] https://patchwork.kernel.org/patch/11355495/
>          [3] https://patchwork.kernel.org/patch/11355499/
>          [4] https://patchwork.kernel.org/patch/11355503/
>
> Changes since v3:
>          -> Removed debugfs suggested by - Benjamin Tissoires
>
> Links of the review comments for v3:
>          [1] https://lkml.org/lkml/2020/2/11/1256
>          [2] https://lkml.org/lkml/2020/2/11/1257
>          [3] https://lkml.org/lkml/2020/2/11/1258
>          [4] https://lkml.org/lkml/2020/2/11/1259
>          [5] https://lkml.org/lkml/2020/2/11/1260
>
> Changes since v4:
>          -> use PCI managed calls.
>          -> use kernel APIs
>
> Links of the review comments for v4:
>          [1] https://lkml.org/lkml/2020/2/26/1360
>          [2] https://lkml.org/lkml/2020/2/26/1361
>          [3] https://lkml.org/lkml/2020/2/26/1362
>          [4] https://lkml.org/lkml/2020/2/26/1363
>          [5] https://lkml.org/lkml/2020/2/27/1
> Changes since v5
>          -> Fix for review comments by: Andy Shevchenko
>          -> Fix for indentations erros, NULL pointer,Redundant assignment
>          -> Drop LOCs in many location
>          -> Create as a single driver module instead of two modules.
>
> Links of the review comments for v5:
>          [1] https://lkml.org/lkml/2020/5/29/589
>          [2] https://lkml.org/lkml/2020/5/29/590
>          [3] https://lkml.org/lkml/2020/5/29/606
>          [4] https://lkml.org/lkml/2020/5/29/632
>          [5] https://lkml.org/lkml/2020/5/29/633
>
> Changes since v6
>          -> fix Kbuild warning "warning: ignoring return value of
> 	   'pcim_enable_device',
>          -> Removed select HID and add depends on HID
>
> Links of the review comments for v6:
>          [1] https://lkml.org/lkml/2020/8/9/58
>          [2] https://lkml.org/lkml/2020/8/9/59
>          [3] https://lkml.org/lkml/2020/8/9/125
>          [4] https://lkml.org/lkml/2020/8/9/61
>          [5] https://lkml.org/lkml/2020/8/9/91
>
> Changes since v7
>          -> Add Co-deveploed-by
>          -> Build the Documentation
>          -> Fix cosmatic changes
>          -> Add init function inside probe function
>          -> Use devm_add_action_or_reset() to avoids the remove()
> 	   callback.
>
> Links of the review comments for v7:
>          [1] https://lkml.org/lkml/2020/8/10/1221
>          [2] https://lkml.org/lkml/2020/8/10/1222
>          [3] https://lkml.org/lkml/2020/8/10/1223
>          [4] https://lkml.org/lkml/2020/8/10/1224
>          [5] https://lkml.org/lkml/2020/8/10/1225
>
> Sandeep Singh (4):
>    SFH: Add maintainers and documentation for AMD SFH based on HID
>      framework
>    SFH: PCIe driver to add support of AMD sensor fusion hub
>    SFH:Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
>    SFH: Create HID report to Enable support of AMD sensor fusion Hub
>      (SFH)
>
>   Documentation/hid/amd-sfh-hid.rst             | 145 ++++
>   Documentation/hid/index.rst                   |   1 +
>   MAINTAINERS                                   |   8 +
>   drivers/hid/Kconfig                           |   2 +
>   drivers/hid/Makefile                          |   2 +
>   drivers/hid/amd-sfh-hid/Kconfig               |  18 +
>   drivers/hid/amd-sfh-hid/Makefile              |  13 +
>   drivers/hid/amd-sfh-hid/amd_sfh_client.c      | 246 +++++++
>   drivers/hid/amd-sfh-hid/amd_sfh_hid.c         | 174 +++++
>   drivers/hid/amd-sfh-hid/amd_sfh_hid.h         |  67 ++
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 152 +++++
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.h        |  79 +++
>   .../hid_descriptor/amd_sfh_hid_desc.c         | 224 ++++++
>   .../hid_descriptor/amd_sfh_hid_desc.h         | 121 ++++
>   .../hid_descriptor/amd_sfh_hid_report_desc.h  | 645 ++++++++++++++++++
>   15 files changed, 1897 insertions(+)
>   create mode 100644 Documentation/hid/amd-sfh-hid.rst
>   create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
>   create mode 100644 drivers/hid/amd-sfh-hid/Makefile
>   create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_client.c
>   create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.c
>   create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.h
>   create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
>   create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
>   create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
>   create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
>   create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
Any feedback on this patch series.?
