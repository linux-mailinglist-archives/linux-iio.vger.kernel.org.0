Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDB344622D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 11:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhKEK3k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 06:29:40 -0400
Received: from mail-vi1eur05on2120.outbound.protection.outlook.com ([40.107.21.120]:23585
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233066AbhKEK3j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Nov 2021 06:29:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fItBeSraZr+KpX5aRhPQx6+V2t0PeZKfyoyYwNoe+0DqCOJ+LpeNxynQ8vBBrLZCPeN4AEcyvZcr8Kp7tfEToI9EfuJetC0YFdwljb9ltC7soH3HMl6cH+kFszJ01pEUkB0dv77hC26smYdmeXUMmxWLo0z/luooG+nFN3xYFnaAG5xMzZHhulATds+oj/c6moJi4ELwwMCM82bXIa3l4iVdXvEk1IVaI/JTCSiQBENM5N7h2VXqJFLbR1XD4X6uEH1ecbTt1NmNEVLQFG70uE2gemOu3Vqv+V57ghyclkD4VZgu5cNditx2uG6oscZovAE577if+IjSrEvVxuPm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WB5m2xsumyFxu+1y+jlDRBTo7Eb6k0qM/P4zL6A0fVo=;
 b=jlqII/5+a/M4F/UVOcybstKJccKpFRaQepmRN3O9KDz7MJ0rMYgtV873joDi99HRkv0JjyWGOsAjPOrsO9aNDENkxOM9RLwcaS0Zuqm1amyLqQ6ppypYN4CIB5biYG9h4WbbXEp7eb2gyoSnoj9VF+cWEm+xQtHx5gWV8YgLBGO3A/MFIZ3R+NpGvk2ioQEU4lmnGIfI9pG9wCwlBejZc4uMuFM3wBYZzitbaP1BvGQ3T4EOOEpypLWWgbwqLKhhMnOvSaXchPmwQCadlaa5+8YSUKHF1AwO8sE1yPCdhssr9K9t4CKYjkO58LYvA8FTkY2updZt0yNezQykt41AGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WB5m2xsumyFxu+1y+jlDRBTo7Eb6k0qM/P4zL6A0fVo=;
 b=kyh6ndY4oIXmL2lUPFizGhhOHeBZ7LtMsUpygnOoZnyiGhFP5NPSiM9vEcfUn6bGqKungOAPu2+NkIELX8hg9r3QMplNOwC4GWLAaTkKeSt+IGMIiDbYtwCEdAYwoZblXiY6f59/pMyqHQaqEPyD7+qI1pDtWvgy5GQQYJovU7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <3106eaec-8055-af91-cad5-1624bd42f869@opensynergy.com>
Date:   Fri, 5 Nov 2021 12:26:54 +0200
Subject: Re: [PATCH v1 0/2] iio: test: Add test for IIO_VAL_INT_64.
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     jbhayana@google.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasyl.Vavrychuk@opensynergy.com
References: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
 <CAHp75VfrfH5Oro6cp3yGPKBLn=9x7wg6ucs2GA0_USff=ay0Cg@mail.gmail.com>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <CAHp75VfrfH5Oro6cp3yGPKBLn=9x7wg6ucs2GA0_USff=ay0Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b8db8a-09a7-4404-bf00-08d9a046cb3e
X-MS-TrafficTypeDiagnostic: AM6PR04MB4933:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4933042522D305E5C86FD94FE68E9@AM6PR04MB4933.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbrGPykWO39zTX7muDnsZJDwqzql17Pdq8FpD81xNGyYC5Z4/vBxA/W6+PSNT0V5fSbC8gwLQQdkZfpfEj8vtzHSBmnlTKjaEfD5AL5yHrVyE1IDbO9dy40+jNhBe+M9gvZaQqo2WWVB3BTI+m1gO7qHgkY4LKRlcI5pEePbK8hAQKRD3Mb4Vx7SW+W67Djs3V7eDEG81IafV8d+JS40pn9ktv1EMwq+oaD1hJn263FfS0JGiw6EwhbXP++4Q1hAFM1OLw1SLQwaNjudIDkzZDSVY3z3t6WsybJhdNWmsr6UZqBnVBCNOWeY5yUPuJoq0iNdKwt0RvOikKot00k0J1W4X8wVUG93uTz7qzetccFgJQbpR/YVGJYiirx2tK/wH2jJXoQee+v52yk05zSzvEHjx1UtxdrrScAppUqv7d49lpQiDXmCzkc3rguZAkjjQ/MdvM7Rhik5Sga66wiL3GKCYZ926+gYCZPmF3BXr6toJaLL+4F3CDKyZ99CYTGIpbgD0gAPjps8YIR27n5rvdBsE4aK9dI9ND8mamrmUW0tRNxEUqgqQct0qfLcDybN08Pi+59dgPakV+4Rkw74jQZkmiQkhVWHYZFD8DuxscrpCQ0G1oTZNz4ls2tZZp/gRvKwMFFNmb0olkbbrKNzXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39830400003)(376002)(396003)(366004)(42186006)(2906002)(66946007)(316002)(38100700002)(26005)(4744005)(86362001)(54906003)(8936002)(66556008)(8676002)(66476007)(2616005)(4326008)(107886003)(83380400001)(31686004)(31696002)(508600001)(36756003)(44832011)(6916009)(5660300002)(186003)(53546011)(55236004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2d1bC93aU81UEVMZm9JUHRxRHpibENCMnBkZVZGNSszeERJTFZ3b0l3ejRH?=
 =?utf-8?B?MU1hM21LakIxOWdmOXdQOTFjZCtGUTNUNzVjTHArbTg3YXpTQ3pyWlZuWVBX?=
 =?utf-8?B?eHRPTUQ2ZnZ6Q1JmNkpKV2NqVGNaZFBPWUZEY3hYekQwRGcvQThqdW0vRFJl?=
 =?utf-8?B?dEJzN1Y5elRzSFlKdU1UenJoU3VGMFNncWhIUGhXUndla09mRHNERHFCZ0Qx?=
 =?utf-8?B?dTNpWHJMMDFzSy95L3owYzFWQ3dTcEdLZGl1ZE9FekJ3a1dHRUM2Y0t0a01X?=
 =?utf-8?B?c3Y1UWs1dm9XL1VWc3RheDduOFQwNHcxOUlGK3lGb2N3VG5jQUdrMWtJQUFL?=
 =?utf-8?B?V2orSFZpSWptMkVDbGNnTlNMbTErL3YvME4xbExkUERKSjk5a0RkODZXQVNX?=
 =?utf-8?B?Q0hMbGNKaTlsTUpCLzVyZjFzYytnazZhSllhWUVVTnRLOUczZHphRGRkZFRK?=
 =?utf-8?B?WnlkdUFLbGtJa0Y1VVFyRlN6Sjl4dG1oTXJMOVN6cDcwSzEvQ0M3Mm52QzdK?=
 =?utf-8?B?bUoyUldXR0liQUoyWklSblN2UXJXRnN2aFg3NFN4Z1NldThyMThDUnVNcXUz?=
 =?utf-8?B?USttNGRWZldxdDJqeEF0WXhNOUhrYzZ2bVBoN2RrNkdFak5KRUNQWTFVVDEy?=
 =?utf-8?B?WCtRV0ptVmtaU3FJMlJBalNHVEdZRWNKbGhwSjJ1T0tlZXlyWmxVdE5aWmc0?=
 =?utf-8?B?TDZrUmhDSzJFMXBIYUQrUUE0cy82WWhzMk11ODhnTWhjSm5DbTdFMytleHRP?=
 =?utf-8?B?dk5tK2RKbk1STHVtZjNsZHZBVWtGYnJYUmNYMDM1Yi9zNnBxT0VueGkvUGFq?=
 =?utf-8?B?RmxpcjNYL3BtVExsLzcyejFoWDBsYjNQK2lXWXl2bWNqSHJaTkJhTnFXYUtQ?=
 =?utf-8?B?YmVraldXNjRCWTRRa0U4eFJvRHNibUdvTHcxL2I1UjJjcS9zSDNqdm93eFlF?=
 =?utf-8?B?WUlEa2JqanBLZjBCemd3K0RaOCs3MURlK0txbFdhcnFHWnFDNWRxb05lUjhC?=
 =?utf-8?B?bGx1eFF4dWRqRHM0ZURMMTNwNlMxTlMvdHRuUW9CYmVTS3hnaFI3a3VvMFgw?=
 =?utf-8?B?eURFejhCZlJrZWU4NjVrc2MxQTgrVFJ1RlBXeUdsR3J4bHBpWWNucG5HWEtS?=
 =?utf-8?B?bTBxMXJYZ243KzdaRWtXS3k4QVQ4NDk0NGttTENlZWxpVWowalRQRVphUnE0?=
 =?utf-8?B?VitvYU54OURmWjAvRlEyaCtIdjJRYTBkdXJjZnFDNzdaajdtRHlCSDh0cDhv?=
 =?utf-8?B?c0VJU3RQTndDSGQrQzZwM0FFWFVSQ2ZvbmpTZldNSjZ4endXVUFUR2hDRGFy?=
 =?utf-8?B?VzlZY0RpUW92ZTVuZ1JZcUJPUjRSK2JVQjJKV3dkYVhKQXptbk5wdEJHaEQ0?=
 =?utf-8?B?TE1Ydk9vWHBKaFNlcmFBVnk1VXpMb0ZXZThmNWNOVXVlR0VNdEpDSlhaSUJk?=
 =?utf-8?B?emFIWU5PZ2pVVzlrd1Y3ajdqd2hsd1ZxakFDSUFTcGRIano1VXlhOUZzM1BP?=
 =?utf-8?B?aFlONzMrUGh6bXpBVEtwamRGU3FMMzB6Tk51ZWk4RU1DMk1nOGVwbG5MU1ly?=
 =?utf-8?B?djROa1F6WTRRMEk4c3p3RnltSW5FK21Cb0YxK1hoVXB0b280Y2djaCtsK1Uy?=
 =?utf-8?B?TWxVcSsvN1VPQjF2SHhyVyt4ZjBtMGhCTFFGeTNudWZ2UTZOMEZBR3QvOWtV?=
 =?utf-8?B?THVOOFpwbDJrZ2tzZy9iL1Jjczd5NjVBY0g4Um8zSmRyTXRPUldod29lSnV2?=
 =?utf-8?B?L1ZHZ3hFdWEzQjB4NXlaZ3VDSGFnRGh4Z1hKNDhhWmpIc0wzcFFhRGRoaHVQ?=
 =?utf-8?B?RjcraFJsUzlVNy92ZU9UQkVMejVjeUYxdTJJb0ZjVCsrTmhaaUJxS09RZ3Jm?=
 =?utf-8?B?YUZ3SjZPd2VnNmp0REhWQnZGUC8zQkQzL1Vpd2VKOTBwMmRIWUgwaGt6eVdO?=
 =?utf-8?B?NzQxSno3VWl4QlA4VlY2cmpwL0RPNm1CM3Vod3pCSWMrRDJQMFZJbzRBWU1W?=
 =?utf-8?B?M2o2MklxU1BRVDJVTCtSbFBSdzBQUW5zUmZOYkdhQVhmbTk5SHhjamVQc08z?=
 =?utf-8?B?N1BYL0JqU2FzSUVGeS82ay9WbnRsY3FQUXFvemZUekZtRERoSXAybUZzN2JE?=
 =?utf-8?B?SURNMjhtejlGYmxjZ2JVbERudG52bGxLRW1xQ250aHd4ZFNuRHQvUkpnK1FK?=
 =?utf-8?Q?CU53N8YU1GroFPqvBsu2qFI=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b8db8a-09a7-4404-bf00-08d9a046cb3e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 10:26:56.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbGM8IbcjWPYRrxbzizrcUDf+BT7QcvZcIHZT0TtuLf+6wt48Pp1U0mmBOPS9mc/QF7voA2S9foViKOgEIWnww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4933
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thank you for review!

Best regards,
Andriy.

On 05.11.21 12:17, Andy Shevchenko wrote:
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Fri, Nov 5, 2021 at 12:05 PM Andriy Tryshnivskyy
> <andriy.tryshnivskyy@opensynergy.com> wrote:
>> Add test for IIO_VAL_INT_64.
>> Add check against NULL for buffer in tests.
>> Use ARRAY_SIZE(values) where it is possible.
> With or without splitting, for the entire series
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Andriy Tryshnivskyy (2):
>>    iio: test: Add check against NULL for buffer in tests.
>>    iio: test: Add test for IIO_VAL_INT_64.
>>
>>   drivers/iio/test/iio-test-format.c | 123 ++++++++++++++++++++++-------
>>   1 file changed, 96 insertions(+), 27 deletions(-)
>>
>>
>> base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
>> --
>> 2.17.1
>>
>
> --
> With Best Regards,
> Andy Shevchenko
>
