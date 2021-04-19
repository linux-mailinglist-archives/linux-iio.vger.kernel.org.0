Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6BD3644EB
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 15:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbhDSNgY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 09:36:24 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:40928
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242828AbhDSNfL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Apr 2021 09:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJOGHrZfM0fiyaFJY/T2REiU1eLCTe0zayBFKWFeKmuqv51UVGwkSe3Z/A3/7Xyeete9snl1eDSZb+2r/+9n+hZU9CLJvSGq+idn62n2wFrCmrw1tmSbcZU9MSEJPpnOySCeb2e/5rP17ouWodVFHzmZMnU75PoCc5pU+ty11EswWBs+S4eTH3wYe09TB/oLX34GYtAHlKYIKYHNbzhhUUZTaTJe9mxZfZLqD0jTWaDkxKutv7Kis3EjdFw2Zu0E38OkgFAH0+Fyre0ICNo7KINxqGmAKDr1CTdXiI68jwGutIhFTMDtoLgeTb7QCHKh124geiQUwX11eASZB1rapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c0Ten8Spqb5WkOREQM/WcabkNoSr+Mt58WWcb+eWT4=;
 b=FVph2gt7NsPBj76COXebQQ4kAz2hIHuSdDUeoIFYfwIVzq9hpRQMWPp304U/tCQ3Fchtdq0SU1ewbOEBkyZKLl0MN3RV6FiLXeEhzt2POcTycB9ewMfj5GAn8RRSdjwnP7n/7ASGaqMWGYnWzcY7w5f61uxOYq5UO4bJOetlg3BwUXBy6x21RhWQ23iLEeppH7Ed8g9RqAa/QhnA3vZWlHjeTS1Yj73p1LRllEBjP2dN6ABRBlnkdFTsuXL5kmVsx3izi6NQi0a4wv93D3N8j6eDScmScU7YFYUteas6Gft30Wirn793TVjdTDZkQpIAX3l4NzHG4lQNUZIxBd/5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c0Ten8Spqb5WkOREQM/WcabkNoSr+Mt58WWcb+eWT4=;
 b=qCyDR1KWF7rPqnyNLsd+mbvxXQE6So2RLQg1uU61BmBz/7iNHc3fgGd95aY7rRi4ew3R+FNs0HAp3Jw5cGvC2uzcOOgPjPcKbBPrsxSwmnF5xPQEX1XVFfMhs951Di5fVjDHc+1E+Z45dbeZaUw5gusZ1fJJyIp8diWFcyE2j2QNV067lkAcXrcbbUFLyfoTXTiiSUKC/RnTj5FM8SR+W54DWwEQ+ZubECy60jTVmogQ2ChZBwBxbgRQB9KXCzkAQzsp0RL++q6RL3UbSr0K+pZbdzbqNW6q2dzLHnlCZVkKKn633Q9LRnkN9J/PRcq6x4fvyA5DP+738y7m0Vg81Q==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR0602MB3567.eurprd06.prod.outlook.com
 (2603:10a6:803:11::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 13:34:37 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 13:34:37 +0000
Subject: Re: [PATCH 2/2] iio: accel: Add driver for Murata SCA3300
 accelerometer
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, aardelean@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>
References: <20210412075056.56301-1-tomas.melin@vaisala.com>
 <20210412075056.56301-3-tomas.melin@vaisala.com>
 <20210412120807.000044d3@Huawei.com>
 <87302341-f9d0-372a-1f18-b934df202e82@vaisala.com>
 <c3fca8dc-9617-220b-2085-febe2a7f3b7e@vaisala.com>
 <1541221b-3dd3-9cc6-1dfe-6a4a100579d0@vaisala.com>
 <20210418110319.72694b7e@jic23-huawei>
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <ea58851c-3bf1-ab51-0771-6844ed53b892@vaisala.com>
Date:   Mon, 19 Apr 2021 16:34:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20210418110319.72694b7e@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR0802CA0008.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::18) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.132] (85.156.166.106) by HE1PR0802CA0008.eurprd08.prod.outlook.com (2603:10a6:3:bd::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 13:34:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40dafc1d-eba1-404b-a50b-08d90337e07d
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3567:
X-Microsoft-Antispam-PRVS: <VI1PR0602MB3567632F760EF68D9C5A9FD4FD499@VI1PR0602MB3567.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLFqyGgpStIxn7v4TqAn57hpV80y/J2meWVTOQr5wgI0j5VLJE2Nat+uJFxKlLegE4e18dMC7vxXZnx6f6J05rz6KhKvXpWZOKvvAQvdGjQvVc/a9Rc+TcBTnbqOGrYHYLRvZeRYdGreBOQaZ3mCfYYuQE+78CRlQCPLsPfCFvhiocsEmrk1ECYHXrY2hVT7GXmVn5Lw+B6D3C/nzVqziIIfhjCgjUN4I5RMtMRTKXlVbs5dshjPEFzVDm68xrtJHAPjqhCwrhqOr+d6kzGqFXsc6lzn+9C1NckFHbQ4Zu1eZ95URGkmoN//DT/fwqbXD5pU+KQuK8cAyAHJIMaROQR0Mc1YJsubgW4tJFOxWpneBfwFhYCv/Y9FSPYNfZjrdxqBAvFcd6JC8BBUSSD5Y5lTEqxMm1bhO5YAho7qHbrhPGIuj35MhaxYVaYU5TkMxvBOmwjM33/aBdg0FoZYGgAmObNrHzIj7W/k4OPX0eb8zBVeX63mNySCbISAh+gy4eic4BbsZP9dzmIXULdk4CNl1VoZXJ0amtQJRKsHl5KYDgeadb14cXwhZOKf6rGdpIsZby9jK1OB136d+dxx4E+4FB2xWyWflB7imEXl8QWWh0XenpFRi5zDhJTUMc6yygp62xKWEYGfGb33WnyQTjpd4YDohDSZ2y9j7HLhEv2ZtJSBFV3ukyGOK1xq/t9HuyzavEmPCvml/k8c5TWIZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(54906003)(186003)(26005)(5660300002)(16526019)(8676002)(956004)(16576012)(2616005)(31686004)(4326008)(2906002)(86362001)(316002)(8936002)(53546011)(31696002)(44832011)(66476007)(6916009)(66556008)(6486002)(478600001)(30864003)(38100700002)(38350700002)(52116002)(36756003)(83380400001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akZkWUE2cXd4VkdQOVRuM3pGdHdncC9XMWZGR3ZRakp6bE1MVnRLZEdlRG9k?=
 =?utf-8?B?ZlM3NWFBZGpOMDcxb0VEd0M2T0l3eTYwRkhTYVFLd1BnRFR3bmNNSFdvVDlR?=
 =?utf-8?B?Z2YxVEhMcUZ5Z3NtaCtQb0YrWkFKUUtiN0s0TFNjOW4yVDh2MXhjcGI3cjFo?=
 =?utf-8?B?KzNmZi91UW9tTTB1QzRqWjFkZ0NDWlBXVEhKcXFCQ3c4NUpiV0UrbjhSYzN5?=
 =?utf-8?B?anY1ZjFjek82WnVJV1RmN1oyTXN2ek5XVmlpVW55c25KUHU5Q3ltRytQYU12?=
 =?utf-8?B?L1l3SWhxOXl6TnBEVGRUNk1acmtwT2N1dkx3MVVsWml3cElremJoQ3hqWHpE?=
 =?utf-8?B?bDg4QldtTTAzL09yMFFBSHFjZDJLWEpCcURUTkJPVDdlY0ZodmRNRUVzc20r?=
 =?utf-8?B?TFQ0V2M4M0JuMWk0clBrczl3NjZlbGI1R2gyK3hxRk1jQzEwcjd4dTJrVWYz?=
 =?utf-8?B?TEVwVFdhOXhuNDJWcjl4ak0zbGE3YVB6OUU4YmpWMlM4dHU2ZE5RSDJhQnJz?=
 =?utf-8?B?NGo1SkI0SnRFRWU0OG9iVGNXQ0NhZnY0MWdCNENrVkZmZE9leC94aEtXMUlq?=
 =?utf-8?B?NS9HaHN0UU9ZalRxcy8xQUVjSUVvUEhibmVLYnpISllGK29lT1dPQi9QRVU2?=
 =?utf-8?B?MnBjK2s2Nm13WGZNUWo3TXZtR0l3dVh1b1ExR2FiOWxOMy9kZWpXaFRzZXdl?=
 =?utf-8?B?UURDSjMxUjJVQjJReFdhZzBlcnBzeVFmLzhNbk5NeE1YU2JzT1l0b004NUF4?=
 =?utf-8?B?aTA4UGdOczFCSlNNdTF1NXA1cXcyT21TTFMrSFNxNmxiZndidFI4cTVsRG11?=
 =?utf-8?B?TUFaUkpEdDZnL3pJdWZWcVFpckpIcFMrQTNKKzNMY1ptUGN3aGNpZ2VNVnUx?=
 =?utf-8?B?Qi9Qb2lTTnRqTXhQMnNVNjZsdjFtb29HTDh3VitUS3JFdzdqODRVYngyb2th?=
 =?utf-8?B?N2QydmlOU0JmNTROQmdKdTZYa21mM2FQbjJ0NlFreVVITGNyMjVSSTBmZnVR?=
 =?utf-8?B?VnpLMmZzWTR4ZHd3NlFwRzBVaFFPT2h6dDhNeXRTZTJlb1BicHNMZi9UaHJP?=
 =?utf-8?B?U0NJN09pTjgwNFBPRFduNFUwbnQ1bDVUMXBrWm92ajRQK0c5U2M4MEtzTzNh?=
 =?utf-8?B?RG45VXBTR003NmJDZGs1ODJUOThzZkZaSGFXalU3YngwL3dlcEwwNjR2ems2?=
 =?utf-8?B?dmZXa3pEZERrdXBoMVB4UG53WTJXV1lGTE45d3grWWtUMWRSZWlidmlwNnlX?=
 =?utf-8?B?Kyt3Ymg2RUliYXl3SThncUV2a0M2NlhQTGlqM09IVHlVQjRyQ213L3R1dVdE?=
 =?utf-8?B?dGVXN0p4VVpiWnJlRTUvWm44SysrYU5UL3B6d084bEVlSmM4RVBRbkpqUlRP?=
 =?utf-8?B?MDgwOExFRjlEcFo2VTgrNmdJTXFwS21GK0dvQVdIazhmRkl4UGM1eDZDUlEy?=
 =?utf-8?B?NjNmbzMzTmkyZ2dkM21mbTJqV1I3cXlIRXMwcE5hbTZSU0lxd1Q5by9XY0xs?=
 =?utf-8?B?WGdJUlFFMCtIQ0dsazZ4NWllUjZmUVFzWFBCbEZFSmd0V3hoWGwzVmxUN3Bx?=
 =?utf-8?B?TUJLYnJTcXFvKzRLY08yU2x2QTJMMmpLTEJqbUo0NHlVaFJNU2xkL002TGNP?=
 =?utf-8?B?TnJmNlZQdzIxTTE0QUpVazQrUEZBbjB5R3ZnRHlyUnJqQ2QyUVEwNWtReXg0?=
 =?utf-8?B?dnpTUzl5MmgweVhBTkZjTVBIUm01VVAvNEhnSEZDR2h6Qk9WNnNsaG41N0xr?=
 =?utf-8?Q?ZyVNGgiG0bGwrtJn6ODHaSSrleEFFQyz3GJjSqI?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dafc1d-eba1-404b-a50b-08d90337e07d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 13:34:37.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wTKqYPbJ5mYMeRGqCbrviDP1jXjhagjeLwVGubwfxDSS3TcbkAT0zzcH0JTQH4PYoueyqg8kN3z5kbq+A3Wjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3567
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 4/18/21 1:03 PM, Jonathan Cameron wrote:
> On Fri, 16 Apr 2021 15:21:14 +0300
> Tomas Melin <tomas.melin@vaisala.com> wrote:
>
>> Updated email-address for Alexandru.
>>
>>
>> On 4/16/21 3:17 PM, Tomas Melin wrote:
>>> On 4/15/21 11:41 AM, Tomas Melin wrote:
>>>   
>>>> While working on updates I did notice something new which I cannot
>>>>
>>>> reproduce on older (5.10.17 kernel) version. If compiling this as a
>>>> module, getting error while
>>>>
>>>> unloading module:
>>>>
>>>> [   40.200084] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 00000104
>>>> ...
>>>>
>>>> [   40.510054] Backtrace:
>>>> [   40.512502] [<c06c5e0c>] (iio_device_ioctl_handler_unregister)
>>>> from [<c06ca8c4>] (iio_buffers_free_sysfs_and_mask+0x2c/0x6c)
>>>> [   40.523735] [<c06ca898>] (iio_buffers_free_sysfs_and_mask) from
>>>> [<c06c4a18>] (iio_device_unregister+0xa8/0xac)
>>>> [   40.533746]  r5:c1811228 r4:c1811000
>>>> [   40.537318] [<c06c4970>] (iio_device_unregister) from [<c06c4a38>]
>>>> (devm_iio_device_unreg+0x1c/0x20)
>>>> [   40.546461]  r5:c2415000 r4:c25bab80
>>>> [   40.550025] [<c06c4a1c>] (devm_iio_device_unreg) from [<c0556820>]
>>>> (release_nodes+0x1c0/0x1f0)
>>>> [   40.558654] [<c0556660>] (release_nodes) from [<c0556bb0>]
>>>> (devres_release_all+0x40/0x60)
>>>> [   40.566847]  r10:00000081 r9:c2350000 r8:c0100264 r7:00000081
>>>> r6:bf00c010 r5:c19be000
>>>> [   40.574669]  r4:c1a91c00
>>>> [   40.577194] [<c0556b70>] (devres_release_all) from [<c055216c>]
>>>> (device_release_driver_internal+0x120/0x1cc)
>>>> [   40.587031]  r5:c19be000 r4:c1a91c00
>>>> [   40.590596] [<c055204c>] (device_release_driver_internal) from
>>>> [<c05522b4>] (driver_detach+0x54/0x90)
>>>> [   40.599828]  r7:00000081 r6:00000000 r5:bf00c010 r4:c1a91c00
>>>> [   40.605482] [<c0552260>] (driver_detach) from [<c0550ba4>]
>>>> (bus_remove_driver+0x5c/0xb0)
>>>> [   40.613583]  r5:00000800 r4:bf00c010
>>>> [   40.617148] [<c0550b48>] (bus_remove_driver) from [<c0552c38>]
>>>> (driver_unregister+0x38/0x5c)
>>>> [   40.625596]  r5:00000800 r4:bf00c010
>>>> [   40.629161] [<c0552c00>] (driver_unregister) from [<bf00a760>]
>>>> (sca3300_driver_exit+0x14/0x8b4 [sca3300])
>>>> [   40.638747]  r5:00000800 r4:bf00c080
>>>> [   40.642311] [<bf00a74c>] (sca3300_driver_exit [sca3300]) from
>>>> [<c01c06f0>] (sys_delete_module+0x16c/0x238)
>>>> [   40.651990] [<c01c0584>] (sys_delete_module) from [<c0100244>]
>>>> (__sys_trace_return+0x0/0x1c)
>>>> [   40.660435] Exception stack(0xc2351fa8 to 0xc2351ff0)
>>>> [   40.665484] 1fa0:                   0050e5a8 00000000 0050e5e4
>>>> 00000800 081d4b00 bec18af4
>>>> [   40.673661] 1fc0: 0050e5a8 00000000 bec18b50 00000081 bec18e51
>>>> 0050e190 00000001 bec18d3c
>>>> [   40.681834] 1fe0: 0050cf70 bec18afc 004f1ec8 b6ecb27c
>>>> [   40.686887]  r6:bec18b50 r5:00000000 r4:0050e5a8
>>>> [   40.691507] Code: e8bd4000 e1c020d0 e3a0cc01 e3001122 (e5823004)
>>>> [   40.707675] ---[ end trace 189882b050077333 ]---
>>>>
>>>> This happens when building against linux-next
>>>> 5.12.0-rc6-next-20210409. I'm failing to see what is wrong. Any ideas?
>>>>
>>>> Thanks,
>>>>
>>>> Tomas
>>>
>>> Tested further that for this driver, loading and unloading as module
>>> works fine until commit:
>>>
>>> commit f73f7f4da581875f9b1f2fb8ebd1ab15ed634488
>>> Author: Alexandru Ardelean <alexandru.ardelean@analog.com>
>>> Date:   Mon Feb 15 12:40:39 2021 +0200
>>>
>>>      iio: buffer: add ioctl() to support opening extra buffers for IIO
>>> device
>>>
>>>
>>> Any thoughts what causes this issue?
> Is this still happening after fixing the ordering in probe / remove?
> (devm_iio_triggered_buffer_setup() being easiest way)
>
> As driver currently stands it's calling iio_triggered_buffer_cleanup
> before the managed cleanup of the iio_device_register() call.  That
> should never happen so would be where I'd look for problems here.
>
> It is possible Alex's work is relying on that ordering being correct
> a little more than we previously were. I could be wrong though
> and could be something else going on!
>
> Jonathan
>
> +CC Alex's other email address.

This is still happening with v3 of driver patchset, which uses only devm_*

versions in probing. v5.12-rc7 works ok, I'm currently only seeing this 
using linux-next.

Thanks,

Tomas


>>> Thanks,
>>>
>>> Tomas
>>>
>>>
>>>   
>>>>   
>>>>>   
>>>>>> ---
>>>>>>    drivers/iio/accel/Kconfig   |  13 ++
>>>>>>    drivers/iio/accel/Makefile  |   1 +
>>>>>>    drivers/iio/accel/sca3300.c | 434
>>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>>    3 files changed, 448 insertions(+)
>>>>>>    create mode 100644 drivers/iio/accel/sca3300.c
>>>>>>
>>>>>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>>>>>> index cceda3cecbcf..0dbf7b648e8a 100644
>>>>>> --- a/drivers/iio/accel/Kconfig
>>>>>> +++ b/drivers/iio/accel/Kconfig
>>>>>> @@ -450,6 +450,19 @@ config SCA3000
>>>>>>          To compile this driver as a module, say M here: the module
>>>>>> will be
>>>>>>          called sca3000.
>>>>>>    +config SCA3300
>>>>>> +    tristate "Murata SCA3300 3-Axis Accelerometer Driver"
>>>>>> +    depends on SPI
>>>>>> +    select CRC8
>>>>>> +    select IIO_BUFFER
>>>>>> +    select IIO_TRIGGERED_BUFFER
>>>>>> +    help
>>>>>> +      Say yes here to build support for Murata SCA3300 3-Axis
>>>>>> +      accelerometer.
>>>>>> +
>>>>>> +      To compile this driver as a module, choose M here: the
>>>>>> module will be
>>>>>> +      called sca3300.
>>>>>> +
>>>>>>    config STK8312
>>>>>>        tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
>>>>>>        depends on I2C
>>>>>> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
>>>>>> index 32cd1342a31a..4b56527a2b97 100644
>>>>>> --- a/drivers/iio/accel/Makefile
>>>>>> +++ b/drivers/iio/accel/Makefile
>>>>>> @@ -50,6 +50,7 @@ obj-$(CONFIG_MXC4005)        += mxc4005.o
>>>>>>    obj-$(CONFIG_MXC6255)        += mxc6255.o
>>>>>>      obj-$(CONFIG_SCA3000)        += sca3000.o
>>>>>> +obj-$(CONFIG_SCA3300)        += sca3300.o
>>>>>>      obj-$(CONFIG_STK8312)        += stk8312.o
>>>>>>    obj-$(CONFIG_STK8BA50)        += stk8ba50.o
>>>>>> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..112fb88ecd3a
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/iio/accel/sca3300.c
>>>>>> @@ -0,0 +1,434 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>>> +/*
>>>>>> + * Copyright (c) Vaisala Oyj. All rights reserved.
>>>>> Give a year for the copyright notice if you can.
>>>>>   
>>>>>> + */
>>>>>> +#include <linux/crc8.h>
>>>>>> +#include <linux/delay.h>
>>>>>> +#include <linux/iio/buffer.h>
>>>>>> +#include <linux/iio/iio.h>
>>>>>> +#include <linux/iio/sysfs.h>
>>>>>> +#include <linux/iio/trigger_consumer.h>
>>>>>> +#include <linux/iio/triggered_buffer.h>
>>>>>> +#include <linux/kernel.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/spi/spi.h>
>>>>>> +
>>>>>> +#define SCA3300_ALIAS "sca3300"
>>>>>> +
>>>>>> +#define SCA3300_REG_STATUS 0x6
>>>>>> +#define SCA3300_REG_MODE 0xd
>>>>>> +#define SCA3300_REG_WHOAMI 0x10
>>>>>> +#define SCA3300_VALUE_SW_RESET 0x20
>>>>>> +#define SCA3300_CRC8_POLYNOMIAL 0x1d
>>>>>> +#define SCA3300_X_READ 0
>>>>> I wouldn't bother defining this.
>>>>>   
>>>>>> +#define SCA3300_X_WRITE BIT(7)
>>>>> Even this one is something I'd just put inline with a comment.
>>>>>   
>>>>>> +#define SCA3300_DEVICE_ID 0x51
>>>>>> +#define SCA3300_RS_ERROR 0x3
>>>>>> +
>>>>>> +enum sca3300_scan_indexes {
>>>>>> +    SCA3300_ACC_X = 0,
>>>>>> +    SCA3300_ACC_Y,
>>>>>> +    SCA3300_ACC_Z,
>>>>>> +    SCA3300_TEMP,
>>>>>> +    SCA3300_TIMESTAMP,
>>>>>> +};
>>>>>> +
>>>>>> +#define SCA3300_ACCEL_CHANNEL(index, reg, axis) { \
>>>>>> +        .type = IIO_ACCEL,                    \
>>>>>> +        .address = reg,                        \
>>>>>> +        .modified = 1,                        \
>>>>>> +        .channel2 = IIO_MOD_##axis,                \
>>>>>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>>>>>> +                      BIT(IIO_CHAN_INFO_PROCESSED),    \
>>>>> As mentioned below, don't provide PROCESSED. Userspace is better at
>>>>> handling the
>>>>> conversion so leave it to them.
>>>>>   
>>>>>> +        .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),    \
>>>>>> +        .scan_index = index,                    \
>>>>>> +        .scan_type = {                        \
>>>>>> +            .sign = 's',                    \
>>>>>> +            .realbits = 16,                    \
>>>>>> +            .storagebits = 16,                \
>>>>>> +            .shift = 0,                    \
>>>>>> +            .endianness = IIO_CPU,                \
>>>>>> +        },                            \
>>>>>> +    }
>>>>>> +
>>>>>> +static const struct iio_chan_spec sca3300_channels[] = {
>>>>>> +    SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
>>>>>> +    SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
>>>>>> +    SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
>>>>>> +    {
>>>>>> +        .type = IIO_TEMP,
>>>>>> +        .address = 0x5,
>>>>>> +        .scan_index = SCA3300_TEMP,
>>>>>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>>>>> +        .scan_type = {
>>>>>> +            .sign = 's',
>>>>>> +            .realbits = 16,
>>>>>> +            .storagebits = 16,
>>>>>> +            .shift = 0,
>>>>>> +            .endianness = IIO_CPU,
>>>>>> +        },
>>>>>> +    },
>>>>>> +    IIO_CHAN_SOFT_TIMESTAMP(4),
>>>>>> +};
>>>>>> +
>>>>>> +static const int sca3300_accel_scale[] = {2700, 1350, 5400, 5400};
>>>>>> +
>>>>>> +static const unsigned long sca3300_scan_masks[] = {
>>>>>> +    BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>>>>>> +    BIT(SCA3300_TEMP),
>>>>>> +    0};
>>>>>> +
>>>>>> +/**
>>>>>> + * SCA3300 device data
>>>>> run scripts/kernel-doc over the file and fix the warnings + errors.
>>>>>   
>>>>>> + *
>>>>>> + * @spi SPI device structure
>>>>>> + * @opmode Device operation mode
>>>>>> + * @lock Data buffer lock
>>>>>> + * @txbuf Transmit buffer
>>>>>> + * @rxbuf Receive buffer
>>>>>> + * @scan Triggered buffer. Four channel 16-bit data + 64-bit
>>>>>> timestamp
>>>>>> + */
>>>>>> +struct sca3300_data {
>>>>>> +    struct spi_device *spi;
>>>>>> +    u32 opmode;
>>>>>> +    struct mutex lock;
>>>>>> +    u8 txbuf[4];
>>>>>> +    u8 rxbuf[4];
>>>>>> +    struct {
>>>>>> +        s16 channels[4];
>>>>>> +        s64 ts __aligned(sizeof(s64));
>>>>>> +    } scan;
>>>>>> +};
>>>>>> +
>>>>>> +DECLARE_CRC8_TABLE(sca3300_crc_table);
>>>>>> +
>>>>>> +static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
>>>>>> +{
>>>>>> +    struct spi_delay delay = {.value = 10, .unit =
>>>>>> SPI_DELAY_UNIT_USECS};
>>>>>> +    int32_t ret;
>>>>>> +    int rs;
>>>>>> +    u8 crc;
>>>>>> +    struct spi_transfer xfers[2] = {
>>>>>> +        {
>>>>>> +            .tx_buf = sca_data->txbuf,
>>>>>> +            .rx_buf = NULL,
>>>>>> +            .len = ARRAY_SIZE(sca_data->txbuf),
>>>>>> +            .delay = delay,
>>>>>> +            .cs_change = 1,
>>>>>> +        },
>>>>>> +        {
>>>>>> +            .tx_buf = NULL,
>>>>>> +            .rx_buf = sca_data->rxbuf,
>>>>>> +            .len = ARRAY_SIZE(sca_data->rxbuf),
>>>>>> +            .delay = delay,
>>>>>> +            .cs_change = 0,
>>>>>> +        }
>>>>>> +    };
>>>>>> +
>>>>>> +    /* inverted crc value as described in device data sheet */
>>>>>> +    crc = ~crc8(sca3300_crc_table, &sca_data->txbuf[0], 3,
>>>>>> CRC8_INIT_VALUE);
>>>>>> +    sca_data->txbuf[3] = crc;
>>>>>> +
>>>>>> +    ret = spi_sync_transfer(sca_data->spi, xfers, 2);
>>>>> Use ARRAY_SIZE(xfers) instead of 2.
>>>>>   
>>>>>> +    if (ret < 0) {
>>>>>> +        dev_err(&sca_data->spi->dev,
>>>>>> +            "transfer error, error: %d\n", ret);
>>>>>> +        return -EIO;
>>>>>> +    }
>>>>>> +
>>>>>> +    crc = ~crc8(sca3300_crc_table, &sca_data->rxbuf[0], 3,
>>>>>> CRC8_INIT_VALUE);
>>>>>> +    if (sca_data->rxbuf[3] != crc) {
>>>>>> +        dev_err(&sca_data->spi->dev, "CRC checksum mismatch");
>>>>>> +        return -EIO;
>>>>>> +    }
>>>>>> +
>>>>>> +    /* get return status */
>>>>>> +    rs = sca_data->rxbuf[0] & 0x03;
>>>>>> +    if (rs == SCA3300_RS_ERROR)
>>>>>> +        return rs;
>>>>>> +
>>>>>> +    *val = (s16)(sca_data->rxbuf[2] | (sca_data->rxbuf[1] << 8));
>>>>> Preference for an unaligned endian conversion here and explicit sign
>>>>> extend e.g
>>>>> something like
>>>>>
>>>>> sign_extend32(get_unaligned_le16(&sca_data->rxbuf[1]), 15)
>>>>>   
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg,
>>>>>> int *val)
>>>>>> +{
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    mutex_lock(&sca_data->lock);
>>>>>> +    sca_data->txbuf[0] = SCA3300_X_READ | (reg << 2);
>>>>>> +    ret = sca3300_transfer(sca_data, val);
>>>>>> +    if (ret > 0) {
>>>>>> +        sca_data->txbuf[0] = SCA3300_X_READ | (SCA3300_REG_STATUS
>>>>>> << 2);
>>>>>> +        ret = sca3300_transfer(sca_data, val);
>>>>>> +        /* status 0 = startup, 0x2 = mode change */
>>>>>> +        if (ret > 0 && *val != 0 && *val != 0x2) {
>>>>>> + dev_err_ratelimited(&sca_data->spi->dev,
>>>>>> +                        "device status: %x\n",
>>>>>> +                        (u16)*val);
>>>>>> +            mutex_unlock(&sca_data->lock);
>>>>>> +            return -EIO;
>>>>>> +        }
>>>>>> +        if (ret > 0)
>>>>>> +            ret = 0;
>>>>>> +    }
>>>>>> +    mutex_unlock(&sca_data->lock);
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int sca3300_write_reg(struct sca3300_data *sca_data, u8
>>>>>> reg, int val)
>>>>>> +{
>>>>>> +    int reg_val = 0;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    mutex_lock(&sca_data->lock);
>>>>>> +    sca_data->txbuf[0] = SCA3300_X_WRITE | (reg << 2);
>>>>>> +    sca_data->txbuf[1] = val >> 8;
>>>>>> +    sca_data->txbuf[2] = val & 0xFF;
>>>>> Prefer (Slightly) an unaligned put.
>>>>>   
>>>>>> +    ret = sca3300_transfer(sca_data, &reg_val);
>>>>>> +    if (ret > 0) {
>>>>> Factor this error handling out to another function, plus trigger it
>>>>> from an
>>>>> appropriate standard error code rather than a positive return value.
>>>>>   
>>>>>> +        sca_data->txbuf[0] = SCA3300_X_READ | (SCA3300_REG_STATUS
>>>>>> << 2);
>>>>>> +        ret = sca3300_transfer(sca_data, &reg_val);
>>>>>> +        /* status 0 = startup, 0x2 = mode change */
>>>>>> +        if (ret > 0 && reg_val != 0 && reg_val != 0x2) {
>>>>>> + dev_err_ratelimited(&sca_data->spi->dev,
>>>>>> +                        "device status: %x\n",
>>>>>> +                        (u16)reg_val);
>>>>>> +            mutex_unlock(&sca_data->lock);
>>>>>> +            return -EIO;
>>>>>> +        }
>>>>>> +        if (ret > 0)
>>>>>> +            ret = 0;
>>>>> Whenever you get this sort of juggling it rather implies your design is
>>>>> less than ideal.
>>>>>   
>>>>>> +    }
>>>>>> +    mutex_unlock(&sca_data->lock);
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int sca3300_write_raw(struct iio_dev *indio_dev,
>>>>>> +                 struct iio_chan_spec const *chan,
>>>>>> +                 int val, int val2, long mask)
>>>>>> +{
>>>>>> +    struct sca3300_data *data = iio_priv(indio_dev);
>>>>>> +
>>>>>> +    switch (mask) {
>>>>>> +    case IIO_CHAN_INFO_SCALE:
>>>>>> +        if (val < 0 || val > 3)
>>>>>> +            return -EINVAL;
>>>>> No.  Scale values need to be the value of 1LSB not a random integer
>>>>> that requires you to look up the datasheet.
>>>>>   
>>>>>> +        return sca3300_write_reg(data, SCA3300_REG_MODE, val);
>>>>>> +    default:
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +static int sca3300_read_raw(struct iio_dev *indio_dev,
>>>>>> +                struct iio_chan_spec const *chan,
>>>>>> +                int *val, int *val2, long mask)
>>>>>> +{
>>>>>> +    struct sca3300_data *data = iio_priv(indio_dev);
>>>>>> +    int ret;
>>>>>> +    int reg_val;
>>>>>> +
>>>>>> +    switch (mask) {
>>>>>> +    case IIO_CHAN_INFO_RAW:
>>>>>> +        ret = sca3300_read_reg(data, chan->address, val);
>>>>>> +        if (ret < 0)
>>>>>> +            return ret;
>>>>>> +        return IIO_VAL_INT;
>>>>>> +    case IIO_CHAN_INFO_SCALE:
>>>>>> +        ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
>>>>>> +        if (ret < 0)
>>>>>> +            return ret;
>>>>>> +        *val = sca3300_accel_scale[reg_val];
>>>>> Scale is very very rarely an integer value which makes me wonder what
>>>>> you are returning here...  It should be the multiplier needed to
>>>>> take the raw value to a reading in m/sec^2  Given you use it as
>>>>> fractional
>>>>> below, I'm guessing this is 1/scale_value?
>>>>>   
>>>>>> +        return IIO_VAL_INT;
>>>>>> +    case IIO_CHAN_INFO_PROCESSED:
>>>>> Don't provide processed here.   Userspace needs to do the conversion
>>>>> itself
>>>>> (and given it has floating point easily available will probably do a
>>>>> better
>>>>>    job than we can).   I'm assuming the mode can't autonomously change?
>>>>>   
>>>>>> +        ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
>>>>>> +        if (ret < 0)
>>>>>> +            return ret;
>>>>>> +        *val2 = sca3300_accel_scale[reg_val];
>>>>>> +        ret = sca3300_read_reg(data, chan->address, val);
>>>>>> +        if (ret < 0)
>>>>>> +            return ret;
>>>>>> +        return IIO_VAL_FRACTIONAL;
>>>>>> +    default:
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +static irqreturn_t sca3300_trigger_handler(int irq, void *p)
>>>>>> +{
>>>>>> +    struct iio_poll_func *pf = p;
>>>>>> +    struct iio_dev *indio_dev = pf->indio_dev;
>>>>>> +    struct sca3300_data *data = iio_priv(indio_dev);
>>>>>> +    s64 time_ns = iio_get_time_ns(indio_dev);
>>>>> Is the timestamp at the start more accurate that that at the end
>>>>> of reading the channels?  If not, just put this inline in the
>>>>> iio_push_to_buffers_with_timestamp() call.
>>>>>   
>>>>>> +    int bit, ret, val, i = 0;
>>>>>> +
>>>>>> +    for_each_set_bit(bit, indio_dev->active_scan_mask,
>>>>>> +             indio_dev->masklength) {
>>>>>> +        ret = sca3300_read_reg(data, sca3300_channels[bit].address,
>>>>>> +                       &val);
>>>>>> +        if (ret < 0)
>>>>> Given we can't return an error code from interrupt handlers, it is
>>>>> usually
>>>>> a good idea to print something to the log. Otherwise we get missing
>>>>> data
>>>>> with no idea of why..
>>>>>   
>>>>>> +            goto out;
>>>>>> +        if (ARRAY_SIZE(data->scan.channels) > i)
>>>>> How could this not be true?  If it's always true, don't bother
>>>>> checking i.
>>>>>   
>>>>>> +            ((s16 *)data->scan.channels)[i++] = val;
>>>>>> +    }
>>>>>> +
>>>>>> +    iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>>>>>> time_ns);
>>>>>> +out:
>>>>>> +    iio_trigger_notify_done(indio_dev->trig);
>>>>>> +
>>>>>> +    return IRQ_HANDLED;
>>>>>> +}
>>>>>> +
>>>>>> +static int sca3300_init(struct sca3300_data *sca_data,
>>>>>> +            struct iio_dev *indio_dev)
>>>>>> +{
>>>>>> +    int ret;
>>>>>> +    int value = 0;
>>>>>> +
>>>>>> +    if (sca_data->opmode < 1 || sca_data->opmode > 4)
>>>>>> +        return -EINVAL;
>>>>> Whilst this is going anyway, better to check that next to where
>>>>> it is read so we drop out immediately rather than buried in this
>>>>> function.
>>>>>   
>>>>>> +
>>>>>> +    ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
>>>>>> +                SCA3300_VALUE_SW_RESET);
>>>>>> +    if (ret != 0)
>>>>>> +        return ret;
>>>>> For sleeps, good to reference which section in data sheet gives the
>>>>> timing.
>>>>>   
>>>>>> +    usleep_range(2e3, 10e3);
>>>>>> +
>>>>>> +    ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
>>>>>> +                sca_data->opmode - 1);
>>>>>> +    if (ret != 0)
>>>>> if (ret) see below.
>>>>>   
>>>>>> +        return ret;
>>>>>> +    msleep(100);
>>>>> Again, document where the time comes from. Saves reviewers time if
>>>>> they want to check it. (I'm too lazy :)
>>>>>   
>>>>>> +    ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
>>>>>> +    if (ret != 0)
>>>>> if (ret) is more idiomatic in kernel code.
>>>>>   
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    if (value != SCA3300_DEVICE_ID) {
>>>>>> +        dev_err(&sca_data->spi->dev, "device id not expected
>>>>>> value\n");
>>>>> Perhaps useful to print what was expected and what was seen. Maybe it's
>>>>> a new variant and this might help the user to identify that and add
>>>>> it to the
>>>>> driver.
>>>>>   
>>>>>> +        return -EIO;
>>>>> -EINVAL probably more appropriate return.
>>>>>   
>>>>>> +    }
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int sca3300_debugfs_reg_access(struct iio_dev *indio_dev,
>>>>>> +                      unsigned int reg, unsigned int writeval,
>>>>>> +                      unsigned int *readval)
>>>>>> +{
>>>>>> +    struct sca3300_data *data = iio_priv(indio_dev);
>>>>>> +    int value;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    if (reg > 0x1f)
>>>>> Use a define that names that register.
>>>>>   
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>> +    if (!readval)
>>>>>> +        return sca3300_write_reg(data, reg, writeval);
>>>>>> +
>>>>>> +    ret = sca3300_read_reg(data, reg, &value);
>>>>>> +    if (ret < 0)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    *readval = (unsigned int)value;
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct iio_info sca3300_info = {
>>>>>> +    .read_raw = sca3300_read_raw,
>>>>>> +    .write_raw = sca3300_write_raw,
>>>>>> +    .debugfs_reg_access = &sca3300_debugfs_reg_access,
>>>>>> +};
>>>>>> +
>>>>>> +static int sca3300_probe(struct spi_device *spi)
>>>>>> +{
>>>>>> +    struct sca3300_data *sca_data;
>>>>>> +    struct iio_dev *indio_dev;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*sca_data));
>>>>>> +    if (!indio_dev) {
>>>>>> +        dev_err(&spi->dev,
>>>>>> +            "failed to allocate memory for iio device\n");
>>>>>> +        return -ENOMEM;
>>>>>> +    }
>>>>>> +
>>>>>> +    sca_data = iio_priv(indio_dev);
>>>>>> +    mutex_init(&sca_data->lock);
>>>>>> +    sca_data->spi = spi;
>>>>>> +    spi_set_drvdata(spi, indio_dev);
>>>>> Won't be used once using devm as below and remove() is dropped, so
>>>>> drop this.
>>>>>   
>>>>>> +
>>>>>> +    crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
>>>>>> +
>>>>>> +    indio_dev->dev.parent = &spi->dev;
>>>>>> +    indio_dev->info = &sca3300_info;
>>>>>> +    indio_dev->name = SCA3300_ALIAS;
>>>>>> +    indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
>>>>> BUFFER_TRIGGERED bit now set by iio_triggered_buffer_setup() so
>>>>> shouldn't
>>>>> be ehre as well.
>>>>>   
>>>>>> +    indio_dev->channels = sca3300_channels;
>>>>>> +    indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
>>>>>> +    indio_dev->available_scan_masks = sca3300_scan_masks;
>>>>>> +
>>>>>> +    if (spi->dev.of_node) {
>>>>>> +        ret = of_property_read_u32(spi->dev.of_node, "murata,opmode",
>>>>> Please use generic firmware access calls rather than the of specific
>>>>> ones.
>>>>> That lets us get ACPI support for free :)
>>>>>
>>>>> As per the binding review however, this one needs to go in favour of
>>>>> userspace
>>>>> control of scale + filter frequencies / sampling freq.
>>>>>   
>>>>>> + &sca_data->opmode);
>>>>>> +        if (ret < 0)
>>>>>> +            return ret;
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = sca3300_init(sca_data, indio_dev);
>>>>>> +    if (ret < 0) {
>>>>>> +        dev_err(&spi->dev, "failed to init device, error: %d\n",
>>>>>> ret);
>>>>>> +        return ret;
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = iio_triggered_buffer_setup(indio_dev,
>>>>>> iio_pollfunc_store_time,
>>>>>> +                     sca3300_trigger_handler, NULL);
>>>>> devm_iio_triggered_buffer_setup() and you can drop the manual
>>>>> cleanup in remove()
>>>>> and hence drop remove() entirely as nothing else left.
>>>>>   
>>>>>> +    if (ret < 0) {
>>>>>> +        dev_err(&spi->dev,
>>>>>> +            "iio triggered buffer setup failed, error: %d\n", ret);
>>>>>> +        return ret;
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = devm_iio_device_register(&spi->dev, indio_dev);
>>>>>> +    if (ret < 0) {
>>>>>> +        dev_err(&spi->dev, "iio device register failed, error: %d\n",
>>>>>> +            ret);
>>>>>> +        iio_triggered_buffer_cleanup(indio_dev);
>>>>> With devm above, no need to manually clean this up.
>>>>>   
>>>>>> +        return ret;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int sca3300_remove(struct spi_device *spi)
>>>>>> +{
>>>>>> +    struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>>>>> +
>>>>>> +    iio_triggered_buffer_cleanup(indio_dev);
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct of_device_id sca3300_dt_ids[] = {
>>>>>> +    { .compatible = "murata,sca3300"},
>>>>>> +    {},
>>>>>> +};
>>>>>> +MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
>>>>>> +
>>>>>> +static struct spi_driver sca3300_driver = {
>>>>>> +    .driver = {
>>>>>> +        .name        = SCA3300_ALIAS,
>>>>>> +        .owner        = THIS_MODULE,
>>>>>> +        .of_match_table = of_match_ptr(sca3300_dt_ids),
>>>>>> +    },
>>>>>> +
>>>>>> +    .probe    = sca3300_probe,
>>>>>> +    .remove    = sca3300_remove,
>>>>>> +};
>>>>>> +
>>>>>> +module_spi_driver(sca3300_driver);
>>>>>> +
>>>>>> +MODULE_AUTHOR("Tomas Melin <tomas.melin@vaisala.com>");
>>>>>> +MODULE_DESCRIPTION("Murata SCA3300 SPI Accelerometer");
>>>>>> +MODULE_LICENSE("GPL v2");
