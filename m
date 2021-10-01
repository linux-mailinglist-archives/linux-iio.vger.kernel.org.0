Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8995F41E805
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 09:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhJAHMx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Oct 2021 03:12:53 -0400
Received: from mail-am6eur05on2096.outbound.protection.outlook.com ([40.107.22.96]:50166
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229829AbhJAHMv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Oct 2021 03:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luNLrbULZ+9on+G+EA4+9T5NzffAhWqQdHo3nnz2emuHakNO2qI6ooI+RZbu4c778kYXJH878MqVN45Dc83wEku0+gEYEtND5cQIb4Y8DUgtR6djFUmn81/EZvUFwDqZFyANPwMXmsSBDLM/yNMcOgBjGEl9nNKR+J9Yh/q6AjY1iD8vdZUk4WCuWf52sMMpC+7aLDOkerA3W3p+u7lrHUeYzZoDFeyDvxdkfOF99iBUspm6KIPDBtssu7BZdUD2KOogKQcLcpyngFhU2O1MJ3AiPTFUbEXCrkDeZeR2Tb60YUxx6yK1KjOjH/IPz3/seae8l2VqiLzquYJZqYcqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETVBNzK8KlRIrjP95BsaUzQBEt7PADfmgA3syGE3oek=;
 b=Gq2mZ8Ud4ZE2rEXY3QkXdGmpAmFHARFEwxQkfzsXj58go/lSWut+9a2W+iE+qtt68vziUT/O3BNsbdux7ekQHg3JINYyWJyEgJ7TLFffEzWDqld4LRgDiAAO6MtRo+7ZlBEdArBLXGDqOCxk+sMLwn07MmZMvILOdpKFRQpGLJpv06zflOTPYJmTDDV1ncPuBs2Qk7LTUehisU4ed+tJqUEOXBV72YYbVEjGqXCsAzspj8PDNFfllm5dMLVPqAkbEQTC3F1z8HvgGDMNAYw2wvXlXBMyL5hEu3Lcm+XA6tC3Ynmw2rl0ReLeO+O9RKsQIiGRmhNIffW91S8fh/L+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETVBNzK8KlRIrjP95BsaUzQBEt7PADfmgA3syGE3oek=;
 b=XNFowS4XvO/r9RnwUl2ZuQMULaiJkXcy56ZvM1ZOTDIYuui9p5y3qcdMMxnY+TpuBZ/Ef8w3WrkTI5O1LshsbS9WWyZQPcZ+1E9Exv2Cs0nmRxWIRWpDOX+oM5qQVtBqAvchBdyyeAiAp0op4G0ehSCiRRntx+GXjOV/gDpVAWE=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
Subject: Re: [PATCH v2 0/1] iio/scmi: Add reading "raw" attribute.
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
References: <20210927132202.17335-1-andriy.tryshnivskyy@opensynergy.com>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Message-ID: <c284e696-df3f-c30c-4346-e60f6db96e0b@opensynergy.com>
Date:   Fri, 1 Oct 2021 10:11:03 +0300
In-Reply-To: <20210927132202.17335-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4042fac-f669-4ba9-2299-08d984aaa279
X-MS-TrafficTypeDiagnostic: AM6PR04MB5047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5047747FBF7D1A3DAC4B8B8EE6AB9@AM6PR04MB5047.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldzmqEXM0xjcKopCUGYFTCElTFgKQRSLMEpY6PbNx75OFI7L+AdO86JR/gdw5p+E4TVkddY+94zQRUUodU9AOcwQ/uH2YlDnfGBIiK6WpJJWCv2mfKbR385CXx4G6FYgSB8gSeam114Fg84NcJY8RVwBtmPIt80R4JLSaC7EIAY0MsfCWyoIboJy+yp3yTW4xM3GbF0Gq1cmX3vMwMDUlK8yTlq4HwpLBp+/72DTIaeWHGJyjK9fVe/d7YLb3LsG5fRcZaNHbSbxh343stUU+uxIGUmLNOryGcxy3v4kcGzmAELxVd6a/lw8Be4BfruC5h53tRWZmyyK6jM8up3g1HIeIoWrS6WM1i12mPl0/wQecWnhkCn9gqUOL0Jw1Y4zGdXU8FV7H7qwYnf/RBskoHjZRiMb7AY9dRvku01kXiI4enTPKeXV73WdNYA/u+8hq3VC3MSwscqW7ncHQZM+uQ7fnoYc5lyrL8YL4ikovF58zdwoMSdLLQfIP2ozWJ4L70rIB/P0ZDzYIrSrcggLeZt0bEcOwajyL7W8hGSXP9ABkNrSC2gHheeFVF++uP+eJ/FGCXIC47VLKa/ixTB3hxcqG7sAA5DVijQDMEzteYQnVz014bOp8YITj/+GrS6VIvbQla5CeMib8UvgDtuIxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(66946007)(5660300002)(31696002)(31686004)(316002)(86362001)(8936002)(2616005)(4744005)(2906002)(26005)(36756003)(186003)(53546011)(83380400001)(8676002)(38100700002)(44832011)(55236004)(42186006)(107886003)(508600001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEtxdWswbTZ5MUpZTHpER3R3V2grc09NQm5OZHFEUW9YYzQzZHhqN21SOWZw?=
 =?utf-8?B?NnRwcEJObkhRek0yUkxkN3VsZGtSR0RTcU9GZzMwOGZxYTk2S1hnMit1bVNk?=
 =?utf-8?B?K1V5UGo3VmFPWmRGTTIwTGdCOFN0NGhTd2h0alZaNTh4QXNwM3VNVVNkeTVB?=
 =?utf-8?B?VEYwcllac1U1cGFTTjFrWkZxbC9UK2NLMVlHUm1FOTBQVEUxK2p4bGcwQVpl?=
 =?utf-8?B?cGR1OUtFMEZZSEVpK3J6eUlENWcxOXp3bDY4bW5LYkNBQVNmeFc4aGFlSkF0?=
 =?utf-8?B?VndkOHpaTlJEUGRMRFdyNWJRc25oUVZ6NzNoOHg4aUF3SVBSdEthMVFSNUJY?=
 =?utf-8?B?SkxVZHhOTWdWZUsyUTJsUDZpYVY0Wkk3THRLT2VZc0llVHN1UHloLzlIU2Ji?=
 =?utf-8?B?c0pEUjVvMWVLdGhxTUN2L1VDbjBaekUwODhHdEkzaVJKd1dsV1UwNmtUQzVj?=
 =?utf-8?B?YnpGTFJpd2J3RDdGMmtZN2E4WlJGQTgvWE5zeWc4ZzN4WG1aV01GM0R5WE5F?=
 =?utf-8?B?d3lOUk9IaHlVL3ZYNW02QTdyZGlwcGxKK0NTSzgvcHdaTmZ3Y3FTMjBsazZp?=
 =?utf-8?B?Z1NVdEU3c3ZVc1BpRWR2ZThWZUFBMGxHWVFWU1hyYStXSjBKY0J5Z0NnWnN6?=
 =?utf-8?B?VzE5ZnMzQjhNMlVrWjNxV05INzVpSkw4ZjJUVXI4Ukt1aVFPZ0VzOEJSQVhI?=
 =?utf-8?B?cDkrczVaSXJkZ212N1drbFIvMDRNeDlVdDVEcm5aZjh2N0FETGNwbkVyMEZ6?=
 =?utf-8?B?MjlVYnJIR1B2Rkc3ZmJTUUJtcUR0QmFIQzRTNmtNUU81UmMxTFF4WnBpZFZM?=
 =?utf-8?B?MkVaQnRxK09DaTdFNW5xM3NmU3ZXVVV3NDJVYldGNmxEWnZKS1BDQVV3NnZZ?=
 =?utf-8?B?ZS92cW04S0g1bk5ua3h5YkZmQ2ErS1BXWHE4b0lhSzl6NUhHcC92azU2a3ZT?=
 =?utf-8?B?NXFjUVZGYkNxaytNODg0cE1XSDF5Zko0RnJ1a0NEdkZIWTNibDlTcSt2TERo?=
 =?utf-8?B?MnF0b1g1b0pEbWh1djRtNEpwc0tSQ01qTmVlMFI1ZE9NZE90Wk5ZM2hPUXNs?=
 =?utf-8?B?ZHd6dTFxSUZMcjlmR0h6SFI4bjhDM2IzQ0hpVWRGc3dFeGJHSEJWa1lxa0c4?=
 =?utf-8?B?TGFBbmlBNHlJQ1dER0dXQVhYUGlQeXJTOUI4ckIxdUFJM3c3bXhZblQ3T1Vk?=
 =?utf-8?B?N1R4amZObE9RS2pVcjN5anpvNWFCMVZROEttdERpc2JMUGhhMjFzTTBqUG5p?=
 =?utf-8?B?N3pBZGpCeHF1SUg2czRiN3UxK1kyRVRTR1QzclhockdrYllHMlFhUWJvQ0Jo?=
 =?utf-8?B?b21LaHlkRmJVakNmVVo3MDNlSEpRaXdMMXRqQ2YzRUlGdFQ1ZlpzN25mVkdy?=
 =?utf-8?B?WEZvcXJKVTZIZFNveVpJNWl0V2JRRWdTUTRpUGdlcmVWOC8wbkZDc0lsdDNn?=
 =?utf-8?B?bmlJOUE3K3hWcnJaNU02aURaRlVBTk1BVHlYVmhST3oySDMzUXFiSFF4VExu?=
 =?utf-8?B?QWJZUGlnWldWcFRZZGZWRCt3Q1MrTnFJMkQ4TkloT09BdUxmQTJUZlpEZTdv?=
 =?utf-8?B?ZUFKSUpIK082NHo5cWlmN25pR3hlSngveER5N2ttSGhqckVNQWpybWtTMTha?=
 =?utf-8?B?a1loUERnTVBTelZXeEg1clhsWUttUmJmbTBzWHo2cDViU1pFRW1PV0MzWS8w?=
 =?utf-8?B?ZW1Ya1JmRVhHK0RSYVg1K0NXZktkUkkva2pKcldaVm9vdjJjWjQwRmpEVnZI?=
 =?utf-8?Q?WeXwYG8MyNLsOR7LPdlgy2kfHu9s3SbkstBjN08?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4042fac-f669-4ba9-2299-08d984aaa279
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 07:11:05.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /th9D27J7H8/VZ4juU+tfLfCFlL4Gna7n9df0ElUUEeREsi1qNiMNKR9og8TOBQuHiQHplhC17JSS7pm3sSbsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5047
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

I've found a problem with this patch and prepared a new one with a fix.
So please review v3 and ignore this one.

Thanks,
Andriy.

On 27.09.21 16:22, Andriy Tryshnivskyy wrote:
> This patch implements reading "raw" attribute.
>
> The patch is based on v5.14.
>
> Comparing to the previous version it has:
> * added an error return when the error happened during config_set
> * removed redundant cast for "readings"
> * added check if raw value fits 32 bits
>
> Any comments are very welcome.
>
> Thanks,
> Andriy.
>
> Andriy Tryshnivskyy (1):
>    iio/scmi: Add reading "raw" attribute.
>
>   drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
>
>
> base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
