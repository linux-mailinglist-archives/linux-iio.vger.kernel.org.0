Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4780C395624
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhEaHeb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 03:34:31 -0400
Received: from mail-am6eur05on2124.outbound.protection.outlook.com ([40.107.22.124]:17505
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230070AbhEaHeb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 03:34:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipEszhDFtIo+5GmMHk+Wg6qF/ZAw2zh13k9ZM6oP45iq7lKTnEWYhQYBMKSXZJ4z3lcu1gsDDGU3KiUg3dWaHTdGyTqYmEqtPC0N0qmdFgnbN5IhnJCUlMfPQJIbUZhKwr31gC2FbCumWmJHC7FNmia2O6hQQz8m8lHIQuAKZ/4qzUl15He+utSzDxleGlwfe+eIVLLcofebF2qii7s/ozr4fYAblJBOIGKh487goE2v+HTPiF1pKk30dHVDuRZPCm/JTOsQdVhvaU9CSScyFf91oTYY6vZoTeGdk8XwiodJY3M2IXcCG1YurLLlwe3D7IdyYYvPQV2RWhoBmhTxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvMR1IE9HKMJzYHipn28pzDrJBrjpPWYeUFLCjeF3i4=;
 b=HA9KqaeAE5NDk0bdQ69Pxj7iYhLmufyRaiPpRbYtuD6n4J9oIPCfsgC8l2CkdfAArAfmxIXMJmFsJ/bH8VMdMl5AF3Bq2AVejDR1YOE6Qjc4Yj5Y+52s/sZrxSEcAhdBZOzP/fcF7HWoWeW1cjIl5SinHywuqeYOOZAcBx4uf9xISBi4kV4YeQNz0p04j+7QsOq1vO78/6F5aDCeF8+TRt1fGpWre1YfX8u9qKBhnqrOcl8XwuBwFCxff2XTFqKgNwyasaYdW/KO3YC+eOc+HQJ21NGEjFcT6Nwdu3ro/taPipsR1ejk9C80+MzEX85lmcHD9h2wfGcPTbRvvsBa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvMR1IE9HKMJzYHipn28pzDrJBrjpPWYeUFLCjeF3i4=;
 b=XHwInROg3Y6Q40Wd3zDfmRKGuTEhrUBsa2ARmSd6YMqXLMXljvvv/2Xw5Qe1YDQorX16frz1fGgLNt+1CldmRaEZMnhdqyLZGUx8fk/umUrRovLWL5DfDP4NZ+zWWdf27QUyAxo85Tsw5QMXwAYqiNBpQs/JysLyWrjEac9aVqg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB3PR0202MB3420.eurprd02.prod.outlook.com (2603:10a6:8:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Mon, 31 May
 2021 07:32:50 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 07:32:50 +0000
Subject: Re: [PATCH v1 9/9] dt-bindings: iio: afe: add binding for
 temperature-sense-amplifier
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-10-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0286de71-1b04-0956-be4e-f38573c6fea2@axentia.se>
Date:   Mon, 31 May 2021 09:32:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210530005917.20953-10-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0402CA0050.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::39) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0402CA0050.eurprd04.prod.outlook.com (2603:10a6:7:7c::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 07:32:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 922aaa0e-0b86-4371-b841-08d924064b1e
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3420:
X-Microsoft-Antispam-PRVS: <DB3PR0202MB342049F79D566910F7075D0BBC3F9@DB3PR0202MB3420.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMJby1bQAMl9K/wbKFWSkaYgJEgQTjp1rtYkHYbK7Hsak+OZp0SA/JiKMI48d9G7zrgfbjSvq+n1atLbgNNRMODS/cGSmJ0qI8FXunPWtNQEeNmhWpdvKI/UrAV7T2ImlTEouUFFYfuQDgFJnHT3+P6t2HoneRHDerWx7mz5EFA7zYIRUxP8NhN8w8E5dEZWlHAp1cqscat+YFoSGtT/spNH6s2VnP9L95Q7tDaB6RKVfM1G3/a8BTL8wk+kio1AZqCq7HVvVFjcDvU4dvI0/HqAjJLlFGJpYha5gtF6xoyH17NkGRW2tPJqdc7e8V+TTtrJyIUwwCvF8N1gmAcPoVotfdzjYj2rilWlrryGrZy1afdxp3rU7af86IC2o4YyCyx2+aaj8KC4Hq332Yo5G+Vo8UQJsSZQX07KFikvhHZh+Zgw5r5NXIwLjO1WfcaYaPqaNedN3OdVLN0wbOACIO9P/fn4zvbPjfzb+5B8zkIcMtU/8daEJnigQ14xGWzgqiBbzKb5hvUEljyZUAUmLbb4xNPsnZ2Es7slH1b1g0nC3lFiXNKDtzpoHDKUV7WICKCrIuNtwBvnx4G7oCIVVa9lQOUbHKNbDC/8WhZTiyswA96Nx2x0dVemjddVU6FSByao+CQER+vV52ax9ysaOKOiMvVHC6YefMJqVFF/oWEWF75tnwN7H3wIui0/tp/K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(136003)(376002)(346002)(366004)(6486002)(16526019)(478600001)(86362001)(36756003)(5660300002)(66556008)(38100700002)(2616005)(956004)(31696002)(2906002)(4744005)(4326008)(6666004)(186003)(31686004)(8676002)(66476007)(16576012)(316002)(8936002)(53546011)(36916002)(66946007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRkYk11NFhqcEJReUd5Y0RRSWxlRDc0OGNLMWw2Ui8vU213SEVndjlzVW5B?=
 =?utf-8?B?YjdveFNwRFdIWUFVckErbnRDRU1IZ1dxYTJFUmVlbWV2eG83ZVd4eXloZFR2?=
 =?utf-8?B?Z2FXZlBoSlg3WlpEUm00clpiK0NHTmZ0TzNGT0dwSlhsdmxyOTh3dFJ4S2pp?=
 =?utf-8?B?T04zcGp2eDFhT0tQZ1BkeE9rNmxRNE1YWWZmNHM2bnhHOHlIVkV2WGM0TE5r?=
 =?utf-8?B?VFpwQS8rZ2tMREVxa3g5ZGsvVENnNEwvdHY5OTJhdThUMHNMTVhmNkV6V0lr?=
 =?utf-8?B?RFpydWdoWTgxOU0rSjZJcE5HQ09vcUw5ZURld012SFdQWHkwSkhDRUNHZnQz?=
 =?utf-8?B?aER1enJKM2tkaU1QODRUZ0FpTTlkRE95SVhvcEdaUllremd0d2p2d0hkVTVl?=
 =?utf-8?B?UnhRazB4Y2FlUlJoMWFodVcwdkVYVDhmTm9NV3NscHhYZEczOUNuTThlOVd1?=
 =?utf-8?B?WEN3bDFFbCtrd3dlS25GM0M4M1BnOFNaZmJmcUcrMjc4UWRuZGJJYzNuZ2dN?=
 =?utf-8?B?M3Jua202M3p2cTJaTjMrUCtuZVNlZnRSbDVnejlyM1NIWS9Oc3dkbTRzejF4?=
 =?utf-8?B?OGd3MHVVQ2paRThhUVZyT3o5NmhnellraFNVSVA5cHNLZTZNUEpNN2lzU04y?=
 =?utf-8?B?SXVSNjZZK1EvYmVCOXI5cTRDcEY5SldkTGZ2RDFrTW8yZ3JGWGRlS0JVL2FG?=
 =?utf-8?B?Rkw5YVRlM3BLdHl6MUFid0hTVXpRS1kycmR3a0VOSHg2NTFzWHM5eXhKdW9Z?=
 =?utf-8?B?ZGhIS2hIbFRwZlFzRTVGa1ZmcENEK1E1ZU1hK3pvUisyQ2FtN2c1YkNBNWVQ?=
 =?utf-8?B?c1A1SlMwSVZTbFJLcGptSDd4OTZSRUxNU0M4Q3dDcG1nUHJ6bmFPendzRFh1?=
 =?utf-8?B?TzFjclVKVWtMemhiTVRoLzYwM20rclYxNUZjOFQvU090eFpBR2FJc0NqNkxJ?=
 =?utf-8?B?RDhvL1FMMjhOd1NtSnNGNGFUUGlyNDg3dzE1MldzcUs4OURvN3pzVzQ1bmJL?=
 =?utf-8?B?TXlQZEhqcWFCd0d4aFYxNmdhdlg3Njh4TXZhbUdZeWdoUE9MeTN4SXd3SFJB?=
 =?utf-8?B?UzN6RllJc1MvdFJXQ0owaEFvQmR2WE9SMDFLOHlXVUR2ZmhmYnhGUUc5NlBO?=
 =?utf-8?B?TnZoUnhxVlZtTTEyRTNEbEJWeXBCNkhwaUM5RFZKUGxBVXpvTEdLRk1RbjFZ?=
 =?utf-8?B?YmVoK2tpV3VyckVQZ0dHWmFmNG91eDJDZENML2c2ZElHbXdDazA2bkV3MkJH?=
 =?utf-8?B?dEd0OEJQZ0RTNTF5ZlN6anVFWEFxMStjUm5EeHpFWGZmZStiNkhtTTFFeUs3?=
 =?utf-8?Q?8CW+4jVwxE?=
X-MS-Exchange-AntiSpam-MessageData-1: kFogqJGIG7VvDhsGtsr4W+JUy26o2bDhBnrZUYvMJfhuez5uN7t4M5vtEURqtIDrDegEd2YbPDOL/0Ld+IQGp6N93cvA/AbsqO8BZOqnEJbzeFyD9m/QPaz0BdakIhiT4Vj4lb65kzzzmZaqoiX2rO2Jh6q2Yb5vnG4tpm6oukNWqTabMG/xTE8xWolnrHopkbDbjV8scxOgo5qYYOWp8mXvwGS44qK0w2f2RQby7FuGmMOhUXaiv6zxOZdJTWSm/MPgpeMO0EOmg9CnXmO1J6QaIPg09BzuLpGucNeMwCVZQqIA0ua0lz3M5hJvTEcBPrxT64E6xJEKGZ0GgonFg7rh
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 922aaa0e-0b86-4371-b841-08d924064b1e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 07:32:49.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGZKJyVR1a+oPzIhzpEAMLlu5CdZ6/aczWbfvn/Z4fPjlmJbDRqGvUNY4iK2qgoI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3420
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2021-05-30 02:59, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, the measurement of a temperature through a
> voltage sense amplifier such as the LTC2997.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>

What's the significant difference between this and the RTD binding? Does
not both simply scale/offset a voltage to a temperature?

Cheers,
Peter
