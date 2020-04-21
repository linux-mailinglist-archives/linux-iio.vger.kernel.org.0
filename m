Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517FA1B2F27
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDUScF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 14:32:05 -0400
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:58945
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgDUScF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Apr 2020 14:32:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpSdNwL2JVNkIoeVrx5q1KAXywHL8aGWis6bP4iKrWU7P5UjpIjWFO4thUMNjDWgiS0uMxEabQQ90ANA5ERLz/lwH3XzzvKqDrGi40K+3ZCvobeyYK7NIriG2YX8iyb/UEukjukbo7LU2XHKx28hAeoV1WX/nr6Z73Ng0jO1v1RCGCegIo9NVZlwQj4ebSk5jUdD9NQ6m8PEjgFbvSdDOEfLyrAxgHj8S6UrL3Ddl81JOMh+qynM229YTU3FOsHGMOW+VMh0ZaHQRJKEajYt5Vc2hoapKgLyX0ZWEuSqVEHbGXZwKr7jZg/PoYWbA8qjf0jk4eUYs7IGndEoU47ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu+qLSuzZ72tG4LsNbFsd0GkqwSxs1qvCT/a7rLh9/E=;
 b=EdYJ4If3Po1yuSJI8FM6no4tEgxc34lCZuTw8jmvBlqVk/4z45AftZ93ey8IM0uUZA2HN48d6EVXuYnJQf+Mkoz/WH619/IF8gR9UoA7rVea6ctAmN372I2yCZwlkOHtzipF6PFQTwjT5km9+QjC3Mb6984oA2gCtB8iQxCZf96sqqoFYN0AEA1T//IUXqM4/YAdPThScmpt/2jgvFwZDfIq9pSpFuxMFluhL32R28zoV/uvZNTISYck/Oobh7yq97zM5qXCyB2kMncnzsjiMwMDIBeL1DgcbVox+7KQf8DDjm36zLlxcl85EjKicOyp1MErKf4zD9gtIcGn8mZsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu+qLSuzZ72tG4LsNbFsd0GkqwSxs1qvCT/a7rLh9/E=;
 b=EwbWieUTvdfi44FoKBPS6kDXLCNITBls9NQhQrJyBKT6kvbRbT40917GAFCqE6YPdWwrSnVDcWyItkqqgZ43AJTDXdjNnOixpMmM88MZcXW4ThFmDxAsDPL2npSHYnlPtAX0D6GS3hj9iq8Xw+nQWFZm1cKN2RK4qtkf4O19duE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN6PR1201MB0209.namprd12.prod.outlook.com (2603:10b6:405:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 18:32:00 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759%12]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 18:32:00 +0000
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
 <3ffc343e-c44b-1b4e-993e-179a13dc928c@amd.com>
 <7683f875aa617b3003a1949131ce79bd0e3c4dcb.camel@richard-neumann.de>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <f4c08c96-bbaf-c42e-0dff-a02c5bbed6ed@amd.com>
Date:   Wed, 22 Apr 2020 00:01:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <7683f875aa617b3003a1949131ce79bd0e3c4dcb.camel@richard-neumann.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::33) To BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.103] (202.62.82.154) by BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 18:31:56 +0000
X-Originating-IP: [202.62.82.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03ae17a6-6178-44f9-7cad-08d7e62247bc
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0209:|BN6PR1201MB0209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0209EB5BDF945BBD11962948A0D50@BN6PR1201MB0209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(5660300002)(6486002)(55236004)(31686004)(26005)(478600001)(52116002)(7416002)(36756003)(966005)(6666004)(956004)(31696002)(110136005)(83080400001)(4326008)(8676002)(16576012)(316002)(186003)(53546011)(2616005)(54906003)(16526019)(81156014)(66946007)(66476007)(86362001)(8936002)(66556008)(2906002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZHbyDMa7TDWST7+QN7xYZmx6BV6P2P/9O6ObGCWjVq6gUU+uI0/hzYb9GZBfr8G1gn+KM9McwGhcKL2QnAuknJTqwVE8dOfdpsRLtZvHOMyXk7vJGaNCuh8zyf9EXXPxjCeuRyLnN2ztRCByQ+aFaRfeFDwo37LFyxL/WkBdnCWTbqQgbeKeN0yjer2R/B5GnZau/OZaEXzk4gqDnNAAwLPjSzT22b8mu18OD/x1+5OhnRKikRBrqsX+4vjcOdKTAB1N+uNP+Ibil5jFLV+Ch4jTkrFQlSOZ8ANGNNmeKo4sd4L2NCAre4blWCXvpDIVS6bDdG9h+TipEm1ApSK3pytWyrqI32cajaA9tXShb4VMhfo8UrxWzJAw0f0llwI+V5hCAY4065/6Qg3k49dipmDak9Ont+8uoNnjpNnl5T8e2liRxwjiK2HoWSBwBWhttED/BepwRnt1DNdpPwwwKh7GY0ClJxZEbx9vj845J0g1cX7+ZZ5wtHwHYm2C9/0daDM7EioMZIl+gX23NgQTA==
X-MS-Exchange-AntiSpam-MessageData: miMClg2EpLWXsk8IsFJcAlJHAtytLeTaH0izhKQ+9TmD/V70znNso/37PM2j5oxxmkvbNi8orToiWlKVWudY1fUKf+mWOryAG6FRpL0bNgJAVx2kSrFrqRSOMMUXEzm5CJ+9eqqVlswszQV06nY95A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ae17a6-6178-44f9-7cad-08d7e62247bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 18:32:00.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6COXRli21oK4amLGoql0o3ae2yFI90I0Jpx12+aEOnSKcFZlmA2nWxkC71WvNOU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0209
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Richard,

On 4/13/2020 7:03 PM, Richard Neumann wrote:
> Am Montag, den 06.04.2020, 10:56 +0530 schrieb Shah, Nehal-
> bakulchandra:
>> HI
>>
>> On 4/1/2020 9:58 PM, Richard Neumann wrote:
>>> Am Dienstag, den 31.03.2020, 20:24 +0300 schrieb Andy Shevchenko:
>>>> On Tue, Mar 31, 2020 at 4:26 PM Shah, Nehal-bakulchandra
>>>> <nehal-bakulchandra.shah@amd.com> wrote:
>>>>> On 3/31/2020 6:01 PM, Richard Neumann wrote:
>>>>>> Not a real review, but your patch series seems to be
>>>>>> repeating a
>>>>>> lot
>>>>>> from drivers/i2c/busses/i2c-amd-mp2*.
>>>>>> Is there any chance we could re-use the code?
>>>>>> E.g. the AMD_C2P_* definitions from drivers/i2c/busses/i2c-
>>>>>> amd-
>>>>>> mp2.h?
>>>>> Thanks for the mail. Yes there are some common structures,
>>>>> however
>>>>> as of now we have kept separately considering both
>>>>>
>>>>> are part of different sub systems. But may be will consider
>>>>> this
>>>>> input for future enhancement.
>>>> It can be done in a form of shared definitions at least in
>>>> include/linux/platform_data/x86/amd-mp2.h or alike ...
>>>>
>>> I managed to add support for the AMD SFH PCI device to i2c-amd-mp2* 
>>> and
>>> outsourced the headers to include/linux/i2c-amd-mp2.h. [1]
>>> I also refactored the patch series (excluded the documentation) [2]
>>> to
>>> use the PCI device now provided by i2c_amd_mp2_pci and removed some
>>> duplicate and unncessary code.
>>> The driver now consist of just one module (amd_sfhtp_hid).
>>> Unfortunately I was not able to solve the problem, that I get AMD-
>>> Vi
>>> IO_PAGE_FAULT errors when not booted with amd_iommu=off.
>>>
>>> [1] 
>>> https://gist.githubusercontent.com/conqp/4d726f86da8a8397d6e70091a124de67/raw/f97e88a0b44d98bfa1258cb73c8afe4dce7afa87/i2c-amd-mp2.patch
>>> [2] 
>>> https://gist.githubusercontent.com/conqp/67036e690aca89d08b958971edac283d/raw/2a1ef122f9c8c8e07164b6d597962ce7bbad6d45/amd-sfhtp.patch
>> Thanks for the patch and appreciate your efforts. At this point of
>> time, we would like to have our first patch for SFH to be upstreamed
>> and dont want to complicate the
>>
>> with two sub systems and maintainers. Surely will consider this input
>> for future enhancement. Thanks for your understanding.
>>
>> Thanks
>>
>>
>> Nehal
>>
>>
> Hi all,
>
> I spent the last two weeks learning the HID API and refactored [1] the
> patch series again. I also took into consideration Nehal's input
> regarding the two subsystems. After tinkering with the integration of
> the SFH PCI driver into the existing i2c-amd-mp2-pci driver, I realized
> that this was a futile effort at this point of time, since the SFH
> protocol, as far as I understand it, does not really implement the I2C
> protocol. Thusly I turned away from trying to integrate the two
> drivers. The core changes I did, is to refactor the PCI driver to use a
> similar initialization as the i2c-amd-mp2-pci driver. The registers are
> now mapped correctly on initial setup (1 << 2) and not mapped to zero
> (1 >> 2) and the ioremapped later. With this change, the AMD-Vi page
> faults when not booting with amd_iommu=off also automagically
> disappeared. 
> The second change is the HID device handling. I now implemented the
> hid_ll_driver API with the respective functions to process raw events
> as well device start / stop and open / close routines. I also
> refactored the platform driver wich is now solely responsible for
> spawning and despawning the HID devices. I also reduced the commonly
> used structures and constats to those that were actually being used by
> the driver and renamed the PCI registers to express what they are used
> for in this driver. I also commented most functions and shared
> structures. The only problem I keep having on my machine is, that the
> register for the bit-shifted active sensors mask 0x1068C keeps
> returning zero on readout and thusly I need to override it.
> I tried to get the sensor mask by sending the "dump_sensorinfo" and
> "number_of_sensors_discovered" commands to different C2P registers and
> dumping the corresponding P2C registers. But so far I could not get any
> information that could be interpreted as the sensor info and mask that
> I need. Maybe Nehal or Sandeep could provide the information, if and
> how it ts possible to get information about the amount, position and
> type of the connected sensors in another way. I also found out, by
> sweeping the SFH registers (from 0 to 31), that there seem to be other
> sensors connected on my machine, namely at positions 0, 1, 2, 3, 4, 7,
> 8 and 9. The ALS at 19 does not seem to be present on my system. I
> suspect that at least one of those is an additional accelerometer,
> since the only one working right now ist the accelerometer at position
> 0, which is located in the sceen / lid. I suspect that the other one is
> located in the chassis, allowing the use of both to perform tablet mode
> detection by processing their relative orientation. I'd appreciate a
> hint on this assumption as well. ;-)
>
> Sincere regards,
>
> Richard
>
> [1] https://gist.github.com/conqp/33baa079d9524914c4c0c196200e4f89

Thanks for the refactoring  the patch. The .raw_request in hid_ll_driver is not correct, the output of sensor is not raw but it is processed one,

so better to move it to .request function. Regarding your question for sensor position well it comes from firmware. So i am not sure about the firmware

for sensor , what you have.Also, regarding the IOMMU, we figured out the issue, earlier patch series has bug that during DMA allocation pdev was passed

from platform driver context, where in for IOMMU needs context PCI pdev. So that is taken care in your refactored patch hence issue is disappeared.


Now regarding the patch (with your changes) i need to validate at our side. Due to lockdown i dont have access to the system, so may be we can wait on that.


Thanks

Nehal Shah



