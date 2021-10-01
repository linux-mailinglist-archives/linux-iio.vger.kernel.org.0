Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89041E7D4
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 09:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352407AbhJAHBq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Oct 2021 03:01:46 -0400
Received: from mail-eopbgr70107.outbound.protection.outlook.com ([40.107.7.107]:29600
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352377AbhJAHBn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Oct 2021 03:01:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRJT/sX3TRgdm2vbT6AdxUUK26Fbx4BjH9m2XDHLfSBZUwtfkDUvZ1axMbxb0PNG6KyNMfKoTVbVj/dJR8pzqeWN+JI2dmM47yZ/d2x2Bn/BCjCdVnqesyc6EiqZM1JvpZOL+0v3sSBjkViiIVPgXP4Yt6D6AfJz80+UhomX78qIogRUj1pzJsui6KtK7aB2XF/GXmYoCI3ww3h8iNvdJR53v8o8u6pTbgOGP+5e4hM2w+GPB0YM5Vq8aOYBr241zxnjVsVJe6NnqeksBpGYCtcmgdx3bppKu/F9pIfX+QDjQuf62dovDQrXqUVJBsp+0tHMEDJpi3QF181D/4fl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV6NZ+jc1Rpwvixoj1C4VbA73uxeIkuoUFyCd0yfx5o=;
 b=fDRjABPrGclUBIuhzd4WYYnnORAzlc6j5Rzoyu/8N8jZA+ubelKBk1AIEz3KndRbMd81bSOzt/h5Vbh+gF8mz/+PlkaTEGev3XAEEey8K3orONDTTnDjySuf8FPkY7qJTPPjNMDxYpmHspqxDCUFxE68KuzTXg74Tctq/hE5WlKCSfRkMnSlF3T8dc5irqYyl9kmqs236JWT0LozoK5cg4eYI73Y3moZJ/6QCG9vl2tJHambQi5/pII46Z6sowLfR93uvRg7ykCWsNn8vqG+BQUu1fOBjvmPR+j6M8lrg9t9IfISEXLV+9YLT/akTZVVep7XkW/qAKtQ7HyIfFf2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV6NZ+jc1Rpwvixoj1C4VbA73uxeIkuoUFyCd0yfx5o=;
 b=freE3mzXlTqAAqg8iVxanQRna/kPIEhAClEDqIv5Da8nrZsqvUtT8ttsQ/o3cSZafhve60lpzotD/Wa4C+rS4K2Kx8qwkwE7I9Wu/+RLUKf7aVrSsYdT8uT9e4iSvUNw85WNQZT0led7WySaCrhPYKYwIVmkJk54KYOq96NZMnw=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
Subject: Re: [PATCH 1/1] iio/scmi: Add reading "raw" attribute.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
References: <20210922065235.12891-1-andriy.tryshnivskyy@opensynergy.com>
 <20210922065235.12891-2-andriy.tryshnivskyy@opensynergy.com>
 <20210925154310.2f31c032@jic23-huawei>
 <18401c96-a88e-c7fa-8f20-56605945891d@opensynergy.com>
 <20210930162618.0c53ec33@jic23-huawei>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Message-ID: <94494815-8835-1faa-441a-ed89358f8048@opensynergy.com>
Date:   Fri, 1 Oct 2021 09:59:54 +0300
In-Reply-To: <20210930162618.0c53ec33@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9353fe1f-4b7f-4c65-c849-08d984a913a8
X-MS-TrafficTypeDiagnostic: AM6PR04MB4934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4934748306C44469CE4A0A49E6AB9@AM6PR04MB4934.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEIgxfqMTNQEyBUKTUk3LLSpvqfuFTbiol7inhgmc5NCXFKnXsPixopcbwnZLxwxBj++o+c51qJiNqh3jLOYcw7INPHtcy+TYQpnbf24w7vzf92rQr866cc/UHZ6HUCZm8I0KYfjTrKco4FWyCf5ZJOeOgrK5qH3pby31O3mxfCw8LNU8FH3t+eZD3QfHc3vQMG7X5nKrrRyN+I9RKSqVjFifew/rMmJGCYsfLBt/2IuzpKMSyYsLBifkw6irh0Pei0mitY840qPuVcHPWT3pf557a6/yKceLwRwW9y8NHKzkl7xGUof4FbOoO/K+J/GWzePvVZRS5yn4aJJz8hk6ayB0vQqcTJOufw7nzP88Vo7AVPAF+rC1iflXxYucGBzE7LAvsUOVDOLsDs/AFtHwgV8UE3CEYy/jxjD4ZmdzpD5gVL2dY+FZ1sy3XUoCrDHzapzRz9+nP7BabetD3EjJ0uWnrL7SqjfETF6x6BJnCQ0LShEfT1VdxWlY3+c3LhJcSks3Rt05Mful3MvVczkgL0kiB1jB0iFwcvoye+zNXVxSSJ+NwzW+niVFz97XJZkp9qwRwoC/KCArOFXDhTlSmOTREzbc0In5ZayXQ0Osm4tLU2ylLeLuSXagGyUiDgrGCmxInUxs7T2POrubW2Mug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(316002)(42186006)(31686004)(55236004)(26005)(2906002)(31696002)(6916009)(8936002)(186003)(8676002)(86362001)(4326008)(107886003)(66556008)(66476007)(2616005)(508600001)(44832011)(66946007)(4744005)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjNHVFNvcm5JVGpIUDk4c1N0NElLR3d0Uitrd2E5SE95eWdZblVhTXM3OHQ0?=
 =?utf-8?B?cGZScVZOMktJVDNGUzhVSjUwd1ZKbTluallNSzU3V1NBMjVqYzRFNjVMSmpk?=
 =?utf-8?B?ZGNZWjd4aWdJQ3FIY2JGS1pwSlZHT2RsNTV3bHN6ZGMxeEFzRFEwRHpkOEIz?=
 =?utf-8?B?TU01R3dVbVZKRis4K010WDZMR2I0eWJVSEduWit4Wk1OU082ejhuYmZxWUl0?=
 =?utf-8?B?OWpudnpubUNuMkR2S3NVLzdkcG92SC9taFVzdEZkZURqVnNhbnQwSVdDZmMy?=
 =?utf-8?B?ajV5QnUwellWTW5PL2tZT1lZVHFNOXJzdG9sY214Q3dVWUw4VFNkV1l1Ynpt?=
 =?utf-8?B?ZGdRZ25pL2RaNWlOemJrL05CV3pBNmF2MFVYaHcyMm5oN3BqeUFOeTNWcUlE?=
 =?utf-8?B?ODUzdGRBU1BIOS9pb1pRVWJZSWR3aENRY3FDMEtUMHlsMFR0aDN6Q0w5V0J4?=
 =?utf-8?B?bXNXWGU5VHJzTjRyc2lWTmkrbTFvQ3RESFFWRDBkZmlpbHAvNjBoejQveE9y?=
 =?utf-8?B?STVBS3hCQ3RWWk00NE5HeUNsUndXNmlMRk0yekJsY2FXWmdJSkY1ZkMxY2JT?=
 =?utf-8?B?WW1DLzJrNFhTNWVreVNXaHlqQVJnYUUwTnVONUkyeUs5QTBSYmRxMXBMcnBJ?=
 =?utf-8?B?d0dZbXg0MjlzWWJkKzlLYTlQNTA1Y1VXUWRMNXJ0b3FQZzhwZkdXZEFlQVM0?=
 =?utf-8?B?VHdSREt4UEMvelJaZ0UzUUUxWllvZ1pWNFJqQ1djZTlieW1RbHlucWVubk1H?=
 =?utf-8?B?d2RkS00zMzlwQ2VQTUNMaFFqbVBFTzY2cnFQU09ienRYN2RKdldIdEE1UjM2?=
 =?utf-8?B?T1Axci9pZlZIN2l0SlRjZGhXWUYxdU10Uys0Szgyend6elBUc0VYYkhLbTg1?=
 =?utf-8?B?dHdsYXhuVm5CR01uM2kzU3lvM1UzVkxRb2pnLzJRWE8vYlhhZHl5eFNyZDBJ?=
 =?utf-8?B?R3NOUkhKeTZDZDl4NVNHdDdtaFlqTmpqVnVSNFFzcEtLYkwvZnRrcmwwVDBl?=
 =?utf-8?B?Q2cwTW9xR1ZRb01BcUVYU3JHbVdNS3B6MEZVV2lZZHJmWW1YRW51OHQ4R3dJ?=
 =?utf-8?B?UDErQWR1RDM5YlV6S0ZlMnZDSXNsM2NCMHlXQ3QzaGRPU1FvSTMxamk3alY3?=
 =?utf-8?B?YVV4aGRtR2RWeGQ0bTg1a3pmU0FHQktmaHFFbUE5N3kxYlQwWVFNVURyWEVn?=
 =?utf-8?B?V1F4VnFLeUhGM3dRaVRXL0t5THJDa1J6YTZ1YnJqeUhyV0MraDFEUXpkRWEr?=
 =?utf-8?B?b3kzOEw2RGdadTB1VGF4TUlsWHF5S3Z6Z1FteHJyZUFZblFwb1c1bnFvWnYv?=
 =?utf-8?B?ZURhVVFtK2xsK0lLeWZaZ010V25JRkFFdk1LQzhrSGk1NEtlN3kzTGNRZjhm?=
 =?utf-8?B?K1lzdUZ4clVpRHBZNTVrTEVNNzFYRThDcTIvS2NKdjJMKzNraFY2d09aUVdz?=
 =?utf-8?B?UkJYbWxnRTV4VHBjWm9Wam9SSXJKQzVFZ2hXZVhObVBBend4NVAyRjZwd05F?=
 =?utf-8?B?aVk4aHJjWngycXB0aVVJMUxKQ3RMdktpTE5zalZST1N1Uk9mdFFuMnB1dkw5?=
 =?utf-8?B?NTFDSDlHdU1wc01NUWJZOXBCenNkc25NT0JGOHpKeEpkbUpyTHRtVUo3ZG1i?=
 =?utf-8?B?ank4c25jT0I4U1FLVFBDRmdEQ0FVOFlRT0dQbkhrVjMyc1J1QjVhVktpamtD?=
 =?utf-8?B?Z2ZWNFkzODMwRk5NZVN6Sk1rY2E5OWJqMEo1VDJqVDRWNDhySU5yd0RnTEQ4?=
 =?utf-8?Q?GqFsnYtt29ziWgGsKzXppsilCxPQou5FQ1aIzpw?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9353fe1f-4b7f-4c65-c849-08d984a913a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 06:59:56.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rimQTRaLfH/BnLValqWY0regH5DCNpMYP7o++lz51U9vOqMQmFlDkAbOqMskYuYPfjtE47XxNgxd1ZH3fUs/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4934
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


>>>> +             /* Use 32-bit value, since practically there is no need in 64 bits */
>>>> +             *val = (u32)readings[ch->scan_index].value;
>>> We should check it fits and if doesn't return an error rather than pretending all was fine.
>>>
>> What kind of error to return in the case it does not fit - ENOEXEC (Exec format error) ?
> That one is a bit obscure.
>
> I'd go with either -ERANGE I think as we are reflecting that the clamp to 32 bit
> is not representable.

Thanks for hint. Later I've found -ERANGE also and used it in my next patch versions.

