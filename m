Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D22A197324
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 06:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgC3EYI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 00:24:08 -0400
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:24562
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgC3EYI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Mar 2020 00:24:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW5Zt7S2/gHrhESqfpa+6Qbrzq4vGZbmaEBAYCF1/NtZbBuPGXF0fxB4511IhwHmDyOAR4MEE8kdbP82jWlbYKYqg4G21U/VFfSI51HeFwTTLDVgiCBDc5mHk8Y5wDvvLVk9E7iMNIh8X34s/+WIeXhHWEHQbsYps9AsfwtdDvon1pg4fIlmt994+QChYgDtD3SzyrtAZvDslXmob8afoqXGJLDLdw9pja2Gi1gdWtAICQLn3A7qb2pDJdLBBgIaZX9m6J6KsuHah/Fr+GqGGopPSqp7sThF6onxbhfYvDWzjmgLZtLSavePwjtAesFFEt+tLJpTfnBFy1BsXY9OJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbFFcRS4eG7dh93E8HuM2/MtVAX4bBCz0neyGiA65oA=;
 b=JlSn097tiznJhE40/pKaAkmAqzucn6OnI4uOQzGFku1Yll82YXH9RNyLnEoyeNVXbUWJkDwKMADO3SXRH7cou8cQJQAw2UbdUk8Wx34vB2srweCH5FdxWuT99RJr+91rRbqXwbAjGsh6E7vCOc7q6Jf2dnQErORQjUTUosDQtuiLN4pLB5ZHfm64zLkjFcdh7Vc7Ofo3JDHJGoewVypzwJt+wCsdOaB7dVmpc1m1YKBlY51I3udpK+mrF5B47KyHCFEnOuoNN/zWBwtZkZtsQJqV0l381colSjQihYUBMhQpRqV9Ddcebaz8Zc808y++FejXdcpz5JpnceOFzOTH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbFFcRS4eG7dh93E8HuM2/MtVAX4bBCz0neyGiA65oA=;
 b=jaVxxLAvnoZo1YVTUxi/qd35AKfB9A9XwuIYskI57qTLLF6RMPHW2/T9CczOxVKt1RycrV/QGHgoCHGx64qilhm+uTveOizUCpPj+/YH88/3anDyUXgTiVMThYf+UXrT4oHyfxSd2ZIXaSxzxKU4dhjZGQroesZRjjfGCjJVAIE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BYAPR12MB3128.namprd12.prod.outlook.com (2603:10b6:a03:dd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 04:24:03 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::61e1:6a43:d8b:f7a4]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::61e1:6a43:d8b:f7a4%6]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 04:24:03 +0000
Subject: Re: [PATCH v4 4/4] SFH: Create HID report to Enable support of AMD
 sensor fusion Hub (SFH)
To:     Roger Gammans <rgammans@gammascience.co.uk>,
        Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20200329184006.GA8199@kilburn.gammascience.co.uk>
From:   "Singh, Sandeep" <ssingh1@amd.com>
Message-ID: <b96bb88c-dd1a-97d3-21fa-2cc60a4d6a60@amd.com>
Date:   Mon, 30 Mar 2020 09:53:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200329184006.GA8199@kilburn.gammascience.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::13) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.218] (165.204.159.242) by PN1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Mon, 30 Mar 2020 04:24:01 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e20cf8e7-22fe-4033-187b-08d7d4622d5c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3128:|BYAPR12MB3128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3128F745306179BCA57D9DB4E0CB0@BYAPR12MB3128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(5660300002)(8676002)(81166006)(52116002)(6636002)(53546011)(2906002)(478600001)(26005)(81156014)(16526019)(110136005)(16576012)(316002)(186003)(66476007)(66946007)(31696002)(6666004)(4326008)(2616005)(66556008)(6486002)(8936002)(956004)(36756003)(31686004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lmBapSqn9HfluaM72iMKPD75ZBjBQm9+3X54u0PCpIGWACTPttPMQX0G6AyEiyd4FhFYq8T7G4s7p2fi8ZWpQiXYtNGZ7fn/gnAzprPsC+H0PG0SHm1HpSujD/gtbKZ2nU5XqPAPrImS4psb553XNdQwiUOPxAyKjLPTJtPVtgErdh7a69SIQ2qnrokj2BaBYTHXlXh+/pFPWFUeUxeccaGgVwZ7bsa3YatlrhKnQdPOy0Xe3AC6XhQjFCh++VgbLyR0B/+e4ekvBSpwjnupZPEW0fEJFU5BpOEsh0Fb8r0PIuaZ1Tbbw/yXvvhoyfPOuPu0ucq2LlYvUXM3JenrCtvyA68Q7h8sFk1gQqb5t6IHngQOhKG0jIMfZpVo+QeBl9Vs04nkGq+mSIoNPYZ8zjwUFpufAbMjtufSdSlfr8K3D9CO2DvjAMMaSjIJ7Pt
X-MS-Exchange-AntiSpam-MessageData: xZYmKMQjKEVOPpHAkzE52VYsfTRdmW23WcuLxsoW6raULBFNYrJRlnTuR2/8zWj6AfTgN6rY+QlEXzfhqxpXUR0qwO/J+P03dgxoJ2/t48wXykY/ZXi+NwEQomJVeu46KUD4IGLE2rsa7yUfg5PEzQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20cf8e7-22fe-4033-187b-08d7d4622d5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 04:24:03.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: px/sSJXO5Yu5vZndonT5gHoi0FXf8I2TT1HU7PSP75LSwoXmCzZwf9mEfroZ+zbP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3128
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Roger,

On 3/30/2020 12:10 AM, Roger Gammans wrote:
> [CAUTION: External Email]
>
> On Thu, Feb 27, 2020 at 05:10:57AM +0000, Sandeep Singh wrote:
>
>> From: Sandeep Singh <sandeep.singh@amd.com>
>>
>> +#include "amd_sfh_hid_report_descriptor.h"
>> +#include "amd_mp2_pcie.h"
> I had to change the last line to
>
>    #include "../amd_mp2_pcie.h"
>
> to make it compile out of tree. After that I got a clean compile.
>
> Also I don't seem to be getting any data through
> to monitor-sensor in user space when I do install it, but I am
> gettting logs of log messages similar to this:
>
>   pcie_mp2_amd 0000:04:00.7: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0x5267f000 flags=0x0020]
>   pcie_mp2_amd 0000:04:00.7: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0x5267f000 flags=0x0020]
>
> This is compiled against the debian 5.4.0 kernel, on a
>       HP ENVY x360 Convertible 15-ds0xxx, SKU 6TD07EA#ABU
>
> I can run other tests or try other kernels if you think it might help,
> let me know what you need.
Can you disable IOMMU from bios and give a try or if your laptop does 
not have iommu option you can pass boot parameter "iommu=soft"
>
> --
> Roger Gammans
