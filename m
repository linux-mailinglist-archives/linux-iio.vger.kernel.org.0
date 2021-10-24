Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E27438739
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 09:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhJXH0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 03:26:04 -0400
Received: from mail-eopbgr140135.outbound.protection.outlook.com ([40.107.14.135]:1926
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229638AbhJXH0D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 03:26:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjpiSW7it9iIx1fspw+YS3pxwJ8ZjfplGUt8B9hRNG4Tn8UvJECDniWK5ZtV2LqXAXn6PVyn20CU0Dt/5kdI0zdZtlEhheSRBNE851OE1TIEWpV84XGA7GWBlwxlrk6yydZvklh7L+4bUSNejUWvAKnDg4YoO56AQgDEQ9dbA2XDd95Qns5BQHdn30XhJj54ndWJf492dym/s60+/oXoPo5XPC5snpLjmnseUX/dPWyLR3Jf7MVaDjoaE6lG8zYrGXuscH3PqT/GQ/DvnEypNWecA0Ip23jQMr4Tb6vnlA2ArEekWWlLtnaa0ByVSu3xBakY4Ezze8KH6XqPBpNJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0GHGT1iUXj7Ermq+mmR6AdDJjyNNsqh7zL98ubXL7k=;
 b=bz+69RUHEMVWg8rE5Ngj/ul4PSBrz8F+1iTMJWUDtzqTxwZd3C6vOBOXwpuubMlQd+8VyVJ+iNlLfZFtqBh5QVt7AC6UKFhplDWDbbKESUxwg5zhg6a33HYApC5qzZDhyuKLK7BMIBxCQFZf6XajM1CiAuiehCyCJ1LbIUUgavOePRXSWQMNn79J1PIxxoxkiML9f2Vy7uTfjWi5XSS+Mu4Xi8Kn9dXSU27pk2kejAxb201/11za4/NvSIdNMK3G9YG+aPwi3y+t54lCjW6x/16Bxio4aouSLnNF6qTH3myObHNVx7x7nbmSMNEYjpH7sAXf9HrBdgG/wCLExncOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0GHGT1iUXj7Ermq+mmR6AdDJjyNNsqh7zL98ubXL7k=;
 b=pjbLMDdawVJNru7AJr55F/f7XNoocdxGeKBn8aBCQC+7QrH283j6MZzp1AGVb9iW9RUHXmoZPy2Dfg5GL7XDiGpwit43RSAVJOe4vONCnWWdHH3eKfnot5tSShLRjZuwkduJz9HPcxIuOaKqm4DyBb5SNS7HNtvQL48uNJe4+kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <d0050bf2-e8d0-c2e7-66cb-f3099dfe8d53@opensynergy.com>
Date:   Sun, 24 Oct 2021 10:23:38 +0300
Subject: Re: [PATCH v6 1/1] iio/scmi: Add reading "raw" attribute.
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
References: <20211019075949.17644-1-andriy.tryshnivskyy@opensynergy.com>
 <20211019075949.17644-2-andriy.tryshnivskyy@opensynergy.com>
 <20211020185118.7a02cbf8@jic23-huawei>
 <4e73398f-126a-0e1a-6eed-88d2d37778c2@opensynergy.com>
 <20211021103607.38c85766@jic23-huawei>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211021103607.38c85766@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR04CA0011.eurprd04.prod.outlook.com
 (2603:10a6:206:1::24) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4345ff4-7d78-468a-d39c-08d996bf33a9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4103:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4103D378B7289AC812A1A537E6829@AM6PR04MB4103.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96PuChBMu5uM68CCho4hI7hHXWPwhEugRlWMLUzVWSCoqidnvpuc2bPj69s66VSakRKNjCl+AfYLzXNJD58eK2lcSgRPLe09ZjFVKaFW614hiGvsfH8km6BPdOf+SKIriRJIeKVlpvDMn0yGxP+cZeRu+shLpcpaAE8Is4HZTUlNL3X2zPbrh96OSN+z9DATO4HDrW3dHLH3p12DBVbt/Sg2BoGvd8kn1wYAiYw4TTCSI68PMx458G1fvKeFLT9xhFNNODfBeJNssfOKYnWaOLPWErva21qq4YTteC34xOpIGMLSqqMcrE1JZwcQDXdnXQAiImu5Q1gHHbUszNvbIio9Jgb1XhUvN7DKIvdZdvTNjWeLSj76swkwGZTLx+HwytS6vNfvghanqYlKg2ovMRHgYxlR34Il3zN1k+0zfFSurL2NyWhpEhh90bBdQLyI3USIiixoDcXGl1EZ1wHm09x5ZSI7ABjqht4nZCeBPw27PRuxF2aHzwbYwjzni61+1a54RavFBrZHtxxpb7A4WqADTrAzOz0IlAlrFlgy0Gbh3jmql8IDBoyPLrjtBZo+/ADdJEnN1FzSS4uvGjawI0A8bdJqOkH/X0qs8yJxhidFjYvSvifE8ERUyw+xYIq/qEejHt2lWV8g1DfhCBuTbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39830400003)(396003)(366004)(2616005)(5660300002)(8676002)(31696002)(42186006)(6916009)(316002)(107886003)(86362001)(55236004)(66946007)(8936002)(508600001)(36756003)(186003)(26005)(4326008)(66476007)(38100700002)(31686004)(2906002)(44832011)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2Faem1ZUDFjMHZYckMxVkkwSUw1ZDhBWVpCVzNkZlVzalYxZ2JCMjg5RUUy?=
 =?utf-8?B?V3ZobnJpUVBSNzVxZXFXdzFsUUVLLzJkUTdDNGVMUk1KZzBLQk9XbFYwanVU?=
 =?utf-8?B?enRGWW1RbjZVam92akxsRG00WmpUYkJSckcxMUVHT1JCREw2a0xFVXVldEZX?=
 =?utf-8?B?RnVSdytzalVJU2NqZVRZRkZ4a3ZJYjloSlBqRW1weU9qbTNyVFQwWE10SDhE?=
 =?utf-8?B?ejRWV1R3NGY4azlrSHhoZ0lHSGgwZllpNUlsbjBYNHVTelZUWDhsS0diTGs1?=
 =?utf-8?B?NVY4NWtwcWFyczFodTNwa2VCeE9aKzRuS2VPb2l3d1gvSkpJdVByY2Zad3VT?=
 =?utf-8?B?MHVDYlByNHg3ZWVpT1B1Z1lVRGsyNXIzbTRhQ21ndDNMUlUvLzhnZERCWmtX?=
 =?utf-8?B?eFpObkRlSVphQ0tRelFpY2RJN0dla2NmN2lvcW5wdHIrQ05ReEZYenhMeWgy?=
 =?utf-8?B?NzNZOEM0Ulh6K3dtdmQrMjFrZWYrRm1HM1FQUkdYcDVCZm90ZjhVSmJIWFg5?=
 =?utf-8?B?b3NzZG85TXBhS0pGSWtDSkErY0d3Ky9JdFdHUjUyVWhjanVxZHFDQWlmSUxx?=
 =?utf-8?B?cW9yVlBQdWhtT0dEME9xbitwTjhLL1Q4c29mclNEeDB2czFuVTcrTU9vM2xs?=
 =?utf-8?B?THh3b2gxOTFhMGZOdkN0V0sxTXFqMWtjSXhFMFpod2ZGSlNyZnlnaDA1YkFB?=
 =?utf-8?B?QU95QVZvSndrYzlWeEhXZHd5Nlh1UWRXZVRMbjRzMFA2d2xUZzczOEdBZDJW?=
 =?utf-8?B?dlM0c3RXSWU1V2cyTTNFTEk0UDRkTFBWamdPdnB4bnQ2K3dOQ2s4Nm9NVzh1?=
 =?utf-8?B?S3QxUXpBdUs0N1lvUk5PVENlSVpndlBXVXNya2pNMUZGVXUyOGVtUTg4TEpR?=
 =?utf-8?B?UDJYOTNzZFgyejdJVE94SVRIVlB2dExxTTgvM0RPSk02eHJyYTJ2UmxrN3lT?=
 =?utf-8?B?TkFwQVRGWFVIdVY0TkZtRWJVQStaVXhQRGNuQzdnL1dBV2phYTlXSisyci85?=
 =?utf-8?B?cFhmYVAyTzVqUldFbGtqQUk0R3MzK1docTRSN000NHhoZ1hnSDRGK0UzRjhX?=
 =?utf-8?B?TEdNL3Z2WHl4eklFbDAzOHZ3bSt5MVRwcW5KdFJlYkdoZkY3OEJFcHJHVCty?=
 =?utf-8?B?K1E1U1RpZjc4S0dBUDNjMFF4VElYOUpoSzVyUWRXOE9KcHBxWm9kUWNHWS8v?=
 =?utf-8?B?QXZtY1I1SWJRdmFFZ2lHKzM5aWJTbWpaR2lWYUMyeWRyUy9DNUN5VVdvOGRx?=
 =?utf-8?B?RWZkRlRCV2RFdWxXQzFBa21vWnpxS0diTnNsblloSU1UcW5paFhjK0ZKYk5M?=
 =?utf-8?B?VGxHcFFzMmJYQmcxekNzRTB5Si9KNE9OYW5zcTVPUEdOd3dqRGRxVkRocysv?=
 =?utf-8?B?OU1sMTlsZDBiSXRxbWlrc0Uwd2t0VUVMcXNpb01sQ294Zm03Z1ZEYmZJU1Fj?=
 =?utf-8?B?dHg3TXZKWlp2TXkybTUyKzVtT0NRdFppeVd3aG1jVlNLZ0FJOEk0cGZwb2Z5?=
 =?utf-8?B?blluVyswUTBSSHVkamY2dkFWTm5hSjZUOFErRVVzMU5laGZJajhjYy84TnpD?=
 =?utf-8?B?aVNQRmZEbVllUDBqd2ZZT0NyaFFtV0tiQkgycnR6ZGYwd04xWDVpaDF4UDRE?=
 =?utf-8?B?ZUg5SWZjTmpUWlZCKzBxNGlFREhKVEtyT0Y3a1FGNVJkc0hMSFMrM0hOMWhk?=
 =?utf-8?B?aHowUHJrVisya2xhQXNKWXE1MEtWSmkxeGdWa0o5RW1jdDdXd014dFRCQS9B?=
 =?utf-8?B?M3RObjlTL3Qrbmd5cVpROTJ3UERIeHpQb2hLUlNpODZ1U3VEQ2Z0VlhLSlpM?=
 =?utf-8?B?YThCRm5mcitrRUpYWlNZTmEvN0NkTXYvbDF3ZkF2a0RQNHpyby9oWHFPdXBX?=
 =?utf-8?B?M0pqTU1JbGxFT2huU05IRmFoQW9ZaWY4WmR0WTl6amdjK21Db2JTa251RGkx?=
 =?utf-8?B?VjZ2M2NBMVRkMGVvajVGcDdSWkRwNUJKY0hkK2d5dkZSNE9iZmx2OVlaTm5l?=
 =?utf-8?B?cENLZFhpWnZWcG0yMWZPMkUrQVF1RE5FODRSeUlBMHdGekdoTHNPUHkrVnA5?=
 =?utf-8?B?Y25NSVJoSXA5NWdpaXBvV1RZTFBKaFJDVlRUTkRlaERRSWhPMVJjZ2dRdWJR?=
 =?utf-8?B?MjFhNVBXbW1kN1dpOFhCSUZlWTBseUJlTENoWkpCNndFRTBkZWxlWGpMY2g3?=
 =?utf-8?Q?ZupW+W7+X6xsLJU4QsZk1Xk=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4345ff4-7d78-468a-d39c-08d996bf33a9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 07:23:40.1072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+K+c20AUn5S0Poh1+Nw1yyVXtmIbMEF+yCbJ50psuf6qQa3oI+AmiyrDgoyHkghMM3PH/2PZ4KrIMS3uzcWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4103
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


>>> On Tue, 19 Oct 2021 10:59:49 +0300
>>> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>>>
>>>> Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
>>>> reading "raw" attribute in scmi_iio_read_raw.
>>>> Introduce new type IIO_VAL_INT_64 to read 64-bit value
>>>> for "raw" attribute.
>>>>
>>> Change log needs to be below the --- otherwise we'll store it forever
>>> in git.  A linked tag (which will be generated when I apply)
>>> is sufficient for this sort of historical info.
>>>
>> Sorry, this is my first patch, I was not aware of that.
>> Thanks for the explanation.
>> Quick question: since next version will include 2 patches,
>> I guess a change log should be moved back to the cover letter, right?
> It's a trade off for which there are no firm rules.
> Sometimes changes are well isolated in individual patches, in which case
> the best bet is to put the change logs in each patch, sometimes they are
> more global things that affect the whole series in which case the change
> log is best in the cover letter.
>
> However, for a given series pick one or other style (don't mix!) as
> otherwise it would get really confusing.  Mostly no one really minds
> where the log is as long as we can find it easily.
>
> Jonathan

thank you for the clarification!

best regards,
Andriy.

