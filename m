Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719293FF637
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347714AbhIBVx3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:53:29 -0400
Received: from mail-am6eur05on2123.outbound.protection.outlook.com ([40.107.22.123]:59584
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347710AbhIBVxZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Sep 2021 17:53:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjfZn1TLMZy+TB7L97Gg+B/A06Fjv005NuOk9cFF0AzULH5dtSrJXuHY8rcxb7AWNudHXW1VNu7fEeZaQDsK0gcsOkQWFMF9Txmg/kGLjVvFpAo7gZyMMlK8eJq0gCZvA+BkIYMcLyKcHfcX6REf3AtI2Rxnkcfhj68fKJND0DQQi+neTe/SINWA2gWXKchLRYF2odvZzYxcwv1+LiOZYpCzMr8hCF/ike2A7ZCiYaLj+TeUCLkf2sis9iq2pkCs/RvfQRucCusoIPaANLRgkuuiqSmVTOeB2kDK4zE13BHREwvwUZ4poestJbiIJZFGqBtJYA4pVZ4Vw7+WOcAjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=95jW6UVFj7zGpWJYs8vHz5G7Qcx3xEyvaysKZrJOo3Q=;
 b=TWj16b5ecTvcUXqU+OKlnYRtT4Nc1dwbFdq3SXfQv5FJJs3ni1CWlDQTwEDwlr7LR7NOHl/ucyZ54uPnqJvuycjSkbDnyS6WOSkQJ/9XNCJhSVY5oOuVDcRad9m3MhlhPNInUDv8O87YYQzrbqoLxh5rzCSlbvOEEFVPKj2IsGXDvlxtLtleNmtqcwT4GkkyuMX8iNPgj3wRk1lmoqRvzChj8QuO3jscSpPdAzLQjzSeMfsbl85y+oKWJ0gAA70NW0hXkE8OtivOOeP6GclWT76bsa3ZjUHfZOTUNzv5hoETqpjUcX+X/ICNUpCPvVhXrruyZmOktWBn0FalFkqpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95jW6UVFj7zGpWJYs8vHz5G7Qcx3xEyvaysKZrJOo3Q=;
 b=YtYDtM21x1wT4wsSpChD/Z/paaO2hnany2N2/yQl9WlwzZCDlJ6Ui9Q+eznmdaX43JMkT7jWhRI9B2xId8dD7PSYUpgx6tgkH6yP6fGAdDBf0uCw6HxsoMG5yYUxQMaorBjKQvhPovlRLE5Uihb64wXvil+LyON7P5OAx/TsDUE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4217.eurprd02.prod.outlook.com (2603:10a6:10:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 2 Sep
 2021 21:52:23 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 21:52:23 +0000
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
 fractional scales
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-10-liambeguin@gmail.com>
 <2d028a60-d1fe-7fa1-da4a-0d80f8d468ea@axentia.se>
 <20210830122224.3efc5a63@jic23-huawei>
 <e1542f14-f271-a0a3-eaa1-092e12c3ed6c@axentia.se> <YTA2g2iHB3WtEMBp@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <5a1e0243-263d-455a-83cd-c274d7d8befb@axentia.se>
Date:   Thu, 2 Sep 2021 23:52:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YTA2g2iHB3WtEMBp@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::23) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM5PR1001CA0010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 21:52:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdb683b3-303b-4d03-67cf-08d96e5bf212
X-MS-TrafficTypeDiagnostic: DB7PR02MB4217:
X-Microsoft-Antispam-PRVS: <DB7PR02MB42171A92F54CC30538C21C9CBCCE9@DB7PR02MB4217.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nvx6NDhAZ+NOUky+NvGUxfXKcPSnQ1VWaVQhPxQDHKC60uDRILpFLVacJEwdRIpc43isvLS+EiG+Bea1NMzl6DFHYszTezy/HpCGozAr5BPg2oYtoficHMLx+DIZODenlouf0w0kTrNIOniwz/UX6vpYlFHC7ak02NsU59+NAOU3UIKo+yy6vVQ8IhIbTKma77dbuU6TqiWeS9ipiTRijCkSr6rjJCtfwXCDREiX9dwdSMKZVDDKkFbLvhKNONOy0pfcobw+ZSamhKRk/X2jh8JJ/fklMDfJ96A6XZL57o+o31/bfjohMSbCwtUYa38wDTAWe4ZJNW4Pg3238KmiyNHQmYvAeNnTzXdvtMoDlF4SJd/Jk67tTYiZlGPaYfg4vD8WECdaJqRk5R7BjyrIafVCS5aBeAjZ3zhwSsY+spjB+oDYYuYNcp/V3XGzpyujvwzDMb75tiYU0ZCOQrZEFZkE+5P/BX5t5r91+jzG+QBNXvZ8fvGGb2rG2mCOMyw+DdxIZ9fGwKzJxp7LIyg3jJrqB2SDTyDBIW9uG8SOuEjkYpll1VXCa71jjrw6wNJ2xwUDlvRaSVcIght7bsyrz+fy3wOSlA5xZNKpvNzhCYFXE4LnyB47SzvqfUdPmzGB/meDCvY0gP8GcSQrr3TY4bRUNgpkYLY1mh9T4aJPLx+ZdfG1TN1CNE9DIkCSm1Uj+IGmC88EekB1bA7I3wiXle0urjn5ech2CXlL+fTQfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(136003)(366004)(376002)(346002)(26005)(316002)(36756003)(31696002)(86362001)(186003)(16576012)(31686004)(66946007)(478600001)(4744005)(66556008)(2906002)(66476007)(4326008)(5660300002)(8676002)(38100700002)(36916002)(2616005)(6486002)(83380400001)(956004)(8936002)(53546011)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGE0RkI3SjV5aEQ5dlRaUjJldGg1cmRabytZNS9ld3B0UUtMa2gzMmg0MEUv?=
 =?utf-8?B?SmVNVUd6eURXSEJYZ1ZQN1hGWkJSa3NSU2tzZVo5Y2FyL0VUREo2T2tDWCtv?=
 =?utf-8?B?MXRYb0JFOUo1akRoMnp4eWRNQ0dOZm9BakVLWnBYdDlXWG5MdERRT2l2YXBr?=
 =?utf-8?B?bVp0bWtOemF1ZzBhTEhpdkFFOG5QTUdBb2diTXhNVnlJNUdDbDdRczExc0hj?=
 =?utf-8?B?dTlHalNTVGw5RWgrWXNLM0tGaklwanF3ay9oWTVxUzlrRUlBc2xDS2JiUmk1?=
 =?utf-8?B?Z3dLcjdGNE5NdHRMcjY3eEhKaDNNM2YwWjR6MGlBalRUWnVidEg0cXBSY1hy?=
 =?utf-8?B?anliNUF4UlZqY0xSaHIrcThSbERmWE5rOGFId21KTjlZTGF1N0xYL3JjZ3BN?=
 =?utf-8?B?N2VrbzE1OE9vQ0ZSeHRQb1RGNjQ5Vm5vR2IyNU11ZnRTenU0a1J0ZStJaDUy?=
 =?utf-8?B?U0paN3ptemg4dG50NHNWWHJvK0Nmb0Y5NFc5b3NzNHZybFdXUnYvMXVKS0Jv?=
 =?utf-8?B?YlEwNGhmNEJSbVN1T2ZNZkpuU2V6NzZLaEp3VzQwN2d1RUxmT0JZTHlEajNv?=
 =?utf-8?B?SFIxZjRMNUF4TllDMkx4TUJIeXYySFJHbTErQ1FOeFVlWmJBdzNOM3A0WTVR?=
 =?utf-8?B?WXUxRFJBeTA3TkpvSlh6WFZEVkNqdXNhRVFZVFo0STAwYmpGQno4MlRzYWlF?=
 =?utf-8?B?S2g3dTVEQnkyRk9QQlBVN2piWGg1c0d2RVN6WUN3VlVFbkcybnRIblBYUVFU?=
 =?utf-8?B?UXIrbXVlTmxMbjNNeXI3K1JRMDZtc0Rta0F6VnZmelhOOEpaei9FVW9zVVdR?=
 =?utf-8?B?c3RsaHpLZ2MxbXRabmJkZ3pOdm1tZ1R0TjF3K3liWDRZQkJLbDcyM2hkRytx?=
 =?utf-8?B?WUNkeU9KSzNHdTErS20vb0xoQ0w0Vk92R3dkSnZxeHFzR0N2UWhTNWIwUHh4?=
 =?utf-8?B?NEFlRmdLMSs2QnBhdDJTdy9hemo0bGFFOWhtdEl4eW02VHhnempPSDB5RmN1?=
 =?utf-8?B?MkdRc0g3MlY0RFhQSSs5ZktORjlBT1NXdU1iVk1hUGZPQ21EZmZNUENlVWNa?=
 =?utf-8?B?NHdKUE5jUTRhbW5OUGxNblV0Q0h2MGpFdXY4RHNlK2UwR3ZHNTcwcnd0REc4?=
 =?utf-8?B?M3YwaTU5SE1Vd2JFSU9nTUIxTWNMT0FzaFdJVHlpL2VpYmkwWmdUclhqcTVP?=
 =?utf-8?B?bmR0eWVxS2xlbVJvbWRBSXJGai9iL09NWnd4bytlSTZmN0lEdHJtUEYzNzJQ?=
 =?utf-8?B?MzNIUGNralFJMXo0M1hvV1pjU09JUy96ZGMxZXRlQzB6UWlGdHIrVWRqdk1V?=
 =?utf-8?B?V1NVbUpzUWo5dEpCaTNDaFd3c3cyN2NoN2hDMkw3OGtpbkhXcHZyeXlOc2xk?=
 =?utf-8?B?R091QTJydi82SE9OZVorL0ZuVmJKR1hDSmxGWmlkNk5FTldLbk12SzJ5TkEx?=
 =?utf-8?B?M1dPTGNod2xCTlBVVzNJU0tzYzBHbDRjZ3hoZ2Q3a200OHdsTlJPZ3pybk1E?=
 =?utf-8?B?ZCtQMDZxYzUyYWJNV1ZZQWUycCt1Y012YnFqNkVhMExkMnJJNEpZSzZHWW9N?=
 =?utf-8?B?WHB6NFptS0tvTHVPNmNsWXNlTGxGYVNFWlc4VCt3cnpyR2gvcHNLSTlDa2pv?=
 =?utf-8?B?RzMvVlBjL1liL3JBeVZNTzZVNHpmWXdub2RCYitmMmg2QlJvaStQaSt5SlBS?=
 =?utf-8?B?YlM1dVBkcTAxN3g1UGptTkkrQmZHSGVxdmRHRzJYTDJkVXVPeHEzUkhnZlh0?=
 =?utf-8?Q?xWW1W6ewD9dCao2FtB5cB2V3Lm/oJZBzGm6EIO1?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb683b3-303b-4d03-67cf-08d96e5bf212
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 21:52:23.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJLCEGHHRA9LFtIU6mi6pZEFRnfMHJYpzu880E6jIJ/ZB3q454Fs0bYUgU3Alg1Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4217
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-09-02 04:27, Liam Beguin wrote:
> On Mon, Aug 30, 2021 at 04:30:54PM +0200, Peter Rosin wrote:
>>
>> Having said that, if 'scale' and 'offset' indeed are static, then the gcd
>> cost can be mitigated by caching the result. Exact rescaling is always
>> nice...
>>
>> If IIO_VAL_INT overflows while rescaling, we are SOL whichever way we turn,
>> so ignore doing anything about that.
> 
> I was thinking of using check_mul_overflow() to do something about the
> overflow, but I'm happy to leave it out for now.

My mistake, you are right. A sufficiently large denominator can of course
be used to dodge overflow in the numerator by sacrificing some accuracy
even if our maximum scale is still limited to 32 bits.

I apparently didn't have my brains about when I wrote the above...

Cheers,
Peter
