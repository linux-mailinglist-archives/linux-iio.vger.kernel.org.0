Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3819F01B
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 07:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDFF06 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 01:26:58 -0400
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:64139
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726474AbgDFF06 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 01:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4B78RZ12bvnw/3/mYks+xUnXWEiNGzscewwS0PIjq15c1fLU/1rh+bLYAs7/00c1p+AuKWYsZWm60J3OlbWwgkMN0CUVzs32kDPVj3TqwdhbYgiBtWblMkHkyZb4gDQTQfxuJYKW23Y8cB3v80ECqO9KUTpC5tJ3U6XbW3Phyao4MfqkulRyNmvgJU6CcDIOzl8rtC0etWROn6cUuFwnNHsPvNCbSe4JhFuGv4Tg9s947lDVMQugw+jMatKC0ys29P4YMooRDbx+9xy4P595+nXcm7Y5lcO41Jwd+gD36+9GehuRmyber+nqe5PCVz7ghlWMPBZbBq+8+GT3pKjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht2vboZnZiRfauaKcfMGnX06q5cpJsmvHlK6kllRLIQ=;
 b=ddCwIp3UxHc3wZRF+2y8dqlv5gdjXqpkEYBepsV/oVUog9Lr3woZwWtBxz7z4LCe9EIfxPcw0ZcglKUOMxb9lla0c8F2LRcF96QGZPAhBYPeMMGa7RBhR0T+V2GWcSO9SxtFObEvIanLmcsVBI8YnRRMPevuHRAWDN4xkjqy7aWN5Umwz4FqFX95wkqfLUCQZQjC6mMUUt50tD3G2yBiDBuKn9uhJz7nENmQkJug9ND9vfNQ2m1cb+uhKE0/HKDW1EU0MQidlQMWLWlEYN5OzHdkYyMpPGKQRWl1iH6YMNnQcTKotEIo8OoVJxlSI1MsAeQs6cn90dM58pz+G4CVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht2vboZnZiRfauaKcfMGnX06q5cpJsmvHlK6kllRLIQ=;
 b=I2aMpEf4GaWKdchwjTuzOj1I+9rRMNp324QCMopafU0ubBWzF/F9k6nDuyC1l+LCL41KJGltx0RDdYkcIp9fYguzmcCcZ8NJa1bWDS7RW3TGllffrvVNSdLLZWyDixS/Pj+eEiLcQj9dIRPUv3jfwV1/kB7YxIVaNLFXZhY8cEg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN6PR1201MB0018.namprd12.prod.outlook.com (2603:10b6:405:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Mon, 6 Apr
 2020 05:26:52 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759%12]) with mapi id 15.20.2878.016; Mon, 6 Apr 2020
 05:26:52 +0000
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
To:     Richard Neumann <mail@richard-neumann.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sandeep Singh <Sandeep.Singh@amd.com>, Shyam-sundar.S-k@amd.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
 <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
 <4fe47b0323c1d65d429ee89b000e8bfcd984495f.camel@richard-neumann.de>
 <896f84bc-f0d6-59a5-c894-809695aa348f@amd.com>
 <CAHp75Vfr6q_H6z6tRFfaKedF7oR7nhmZvRWL4mxx3W7uypUFvA@mail.gmail.com>
 <9aea760f9abdd2f90f36642af77de7bfae719485.camel@richard-neumann.de>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <3ffc343e-c44b-1b4e-993e-179a13dc928c@amd.com>
Date:   Mon, 6 Apr 2020 10:56:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <9aea760f9abdd2f90f36642af77de7bfae719485.camel@richard-neumann.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::22) To BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.38.85] (165.204.159.242) by BM1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Mon, 6 Apr 2020 05:26:47 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 196808c4-3724-4781-7310-08d7d9eb1cfe
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0018:|BN6PR1201MB0018:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00185D46B46A54119CE11346A0C20@BN6PR1201MB0018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(6486002)(5660300002)(966005)(4326008)(16526019)(26005)(81156014)(956004)(2616005)(6666004)(8936002)(36756003)(186003)(8676002)(81166006)(52116002)(16576012)(7416002)(31686004)(110136005)(66946007)(478600001)(66476007)(31696002)(66556008)(54906003)(86362001)(53546011)(2906002)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LofnWlv0Of9XvnyvvaNd1LoKUfDu6g3LIglJKaEsKVJsVOP5S5moulG8TyIohgdrWi6W3ONiYVFEGPfo7BB67rcXbQvXIK8GseQQ1797dYixXwRCoBvipaOyv4R3RtLPruDkd6ySqSNWUgqJeXSgZivdrdOabRMJq3sjmhQGDcD6Fiw/oDeMmr08Tnyw0Kb0ZyNNFaY3rBVBZkNka8tEuF09wlFP+9J66TIBty969iM8zKESw/+BrV2TC5UdZgpw7LIhrKYF2Ud1aAx9r69CdiozsxPQUBlAyKG9RWq5UL+NBdnirrAmDnZ9zGfdOcAqGlBu0+MORfrghviEePezq31WquPRICic2WvdjM2eXRs0+lPwtXb6CVBiXIPplXcL+Tb5COlZ9qcGvc/Vg6xi+YQC51Ximl7KOwg3lLO6cY/FMsykhVwb1j0XiQ1RZgLmW+UcRlVYZZsVBkjA4hZfDSqNus/eMHGjpuWOQSFDO8oyw3ZZ6akeIPsKw5s7qvbs3IKsYIh8UpLHGV4ANbfEg==
X-MS-Exchange-AntiSpam-MessageData: Q7qTfmeCDSSiyS8uh6cST9+4iqBQnlWWBMyWGGn4z9rbmXlPO49guPvhCrRwyxPZ+x1lpEabxtp56TaQiRDJumLlrQTadKURMNk1BlL1pNeD8Y5Nlzi7LEZwyF0djRIT+cArcYMbk3XUbIAwBkpjlw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196808c4-3724-4781-7310-08d7d9eb1cfe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 05:26:52.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuTMvzWAM66uXzsA7QncnUWROhLzkdI9C3MV52Jjdg0p4PuzgNshm/zZl9sLfvAo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

HI

On 4/1/2020 9:58 PM, Richard Neumann wrote:
> Am Dienstag, den 31.03.2020, 20:24 +0300 schrieb Andy Shevchenko:
>> On Tue, Mar 31, 2020 at 4:26 PM Shah, Nehal-bakulchandra
>> <nehal-bakulchandra.shah@amd.com> wrote:
>>> On 3/31/2020 6:01 PM, Richard Neumann wrote:
>>>> Not a real review, but your patch series seems to be repeating a
>>>> lot
>>>> from drivers/i2c/busses/i2c-amd-mp2*.
>>>> Is there any chance we could re-use the code?
>>>> E.g. the AMD_C2P_* definitions from drivers/i2c/busses/i2c-amd-
>>>> mp2.h?
>>> Thanks for the mail. Yes there are some common structures, however
>>> as of now we have kept separately considering both
>>>
>>> are part of different sub systems. But may be will consider this
>>> input for future enhancement.
>> It can be done in a form of shared definitions at least in
>> include/linux/platform_data/x86/amd-mp2.h or alike ...
>>
> I managed to add support for the AMD SFH PCI device to i2c-amd-mp2* and
> outsourced the headers to include/linux/i2c-amd-mp2.h. [1]
> I also refactored the patch series (excluded the documentation) [2] to
> use the PCI device now provided by i2c_amd_mp2_pci and removed some
> duplicate and unncessary code.
> The driver now consist of just one module (amd_sfhtp_hid).
> Unfortunately I was not able to solve the problem, that I get AMD-Vi
> IO_PAGE_FAULT errors when not booted with amd_iommu=off.
>
> [1] https://gist.githubusercontent.com/conqp/4d726f86da8a8397d6e70091a124de67/raw/f97e88a0b44d98bfa1258cb73c8afe4dce7afa87/i2c-amd-mp2.patch
> [2] https://gist.githubusercontent.com/conqp/67036e690aca89d08b958971edac283d/raw/2a1ef122f9c8c8e07164b6d597962ce7bbad6d45/amd-sfhtp.patch

Thanks for the patch and appreciate your efforts. At this point of time, we would like to have our first patch for SFH to be upstreamed and dont want to complicate the

with two sub systems and maintainers. Surely will consider this input for future enhancement. Thanks for your understanding.

Thanks


Nehal


