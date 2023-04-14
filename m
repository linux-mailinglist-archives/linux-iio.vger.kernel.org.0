Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278AD6E208B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Apr 2023 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjDNKRp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Apr 2023 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDNKRo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2023 06:17:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372D7E60
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 03:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZjSGk2urj2loQXu+S+pY2OljdSFp4kr0VmnVc7T9lxjZKnBRT8EOyS/SvQd/Tnelbh1OXk3T2PkxfQMKxv3zKl3uHpu55Q1z7PQAJZCIyR2bDJaeK+fe1Ux4bNm5D0uzecdGWWXM3PZK2g4n1YtJj8+wURw/Q4MIm05AHFSYaS6dFt+t4eQHca7IDStF9HYzCGhRy4qu6jnxwIYDnx2sOqR00fteVofDCaq0ZUYA6HqwL1G3+t2WknB7W0DFJ6uFMcUbQvuPz09ZA7MrZWcZhySgnNFehrVxSSOzWu/Bc6Dw9NDAvZH0pL9t8UztwgGVyB1FaIHWFnOPR769AQvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qArBrN1b4TSOfUfnvqGauxjcORL6RrgGUBRB2rR+O3A=;
 b=bor1Mu1XlDqSshBA/c8nXNQsJxtkej1YeKmK/0/NvczPi/HimXCYmZMoThcuQ8ncPV8DJw461xAY8JGfp1ftLrhVt+yjSv9Q0ur/Jn90Gi3ah2Cn+SJjjafFrtl+hrbi3PQuHgOhlb8+F1lY1BQLLWK0oNrawNjmCzJHnmHvU0jrWSO2HVtBAygqc23fDvA4xF37jajvKR0XOTGNHM+8/u8mcrw6TkWwCxd1ab92m9SsYHIBfwu/0z0gryyROhDiN13m6iBdPqnqiUL0V6KWkt3+b5LfemGDJ42CUVybQkkoBUmb0C1VIYhxbaMoG+umE8PnxztckluiTm8Qp8nV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qArBrN1b4TSOfUfnvqGauxjcORL6RrgGUBRB2rR+O3A=;
 b=vK4POyyoKRQBawNGQz8FcIU7RetJSEuafb/KO1Ryc+3FscooLxaSBwfb9ZJvowovYO0O+m/sKzoOTQJeib9h4zdJJJVSBsBkRJCnmybyx8xHP+sQnwkG69eQUVhyoftewWjMQ2Ev9vdWwN2V5vhtLxg/163Rtg0GxUBwiToOjB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by GV1PR08MB7779.eurprd08.prod.outlook.com (2603:10a6:150:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 10:17:39 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::d65c:8aae:eb40:c8ce]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::d65c:8aae:eb40:c8ce%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 10:17:38 +0000
Message-ID: <8d5256ae-3b06-aadd-de5c-73105cb91d74@wolfvision.net>
Date:   Fri, 14 Apr 2023 12:17:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] iio: tmag5273: Fix runtime PM leak on measurement error
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
References: <20230414013752.498767-1-lars@metafoo.de>
 <ce69fcd4ed928cf5cb47847235826668e9b61beb.camel@gmail.com>
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ce69fcd4ed928cf5cb47847235826668e9b61beb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::39) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|GV1PR08MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdf0bd2-7953-4a78-43f3-08db3cd1794d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zi2u+YBWDmfgJtaIXim9eJew7G4c5H7vcWAQOr2oUryRCQkvmbnP0Wd3I3/nzM9pWhxvess3Hfg3PurAo7hbb11EzPz1k48FXo5MQ9OxncbMfZGr8GQ/Y7nOGavtoafu42oK4CQbVLFn3htC5xHqT77lAh2RvIi//YfjVUSn5DpsJvZb+VTw18qlLSOuyN/ch5vXSFwxEX/j32acUfskeNdxX82Co9B07/kyJitdowwFpojl49lYdPbR1Z54FLZaCUU8r3orjRcF2ESA9B1g8MROA+ahT9Ee5j16Ygu6mpkXK/Osc+Xzlc9VzBvZ1gyeNplCB4jrxT3N+TFVS8bxqkaylJSEqcDacDdz1QowXJ57NhSFLYkMI+FTr3cCb6ulNjCenml4GCA0DyAOy4fZE+HH1TW0GrV76+C4YnEPHwO0pQhNAh9L4zBKMvSfvY9bV1rjb2hSTme84ETM8QH+X7fHIUniPoummJ+91mRLGUaVD6lgRc3HOcX8VfoYx1lKGnXPhKbBDy1LF10d0TsnMtkykFNA/pY0KUg4XIxl1/i7A8WlfKTxlj93Eb+sxyUbFoFJ4v8Qou6lYdSXAZwfKVYTqzROPV7zUKreF0JrTa/9gI9tFxGgIHbGVhDNRyueR7WieMi64+j0sNNLIg2HOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(136003)(376002)(396003)(346002)(451199021)(2616005)(8936002)(31696002)(86362001)(4326008)(36756003)(66946007)(44832011)(66476007)(8676002)(66556008)(5660300002)(41300700001)(83380400001)(38100700002)(6486002)(478600001)(31686004)(36916002)(316002)(110136005)(2906002)(6506007)(186003)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTgybEhLcTZmWi8xbTBMMWY5V1MxcG4raUNyRExSQ016bXQ1RDhuYnMxN0ND?=
 =?utf-8?B?eTB6OXpyQ2hkRGNxU3lRY05Fc1pGZ0x1OGVtRVFUTDZmUDNMcjQ3ZjI5S2pQ?=
 =?utf-8?B?ZTB6c2lTT2piRlRjcnlXRFd6YzVUL3RCWjQ1UGRUeFFqZXoyQVM1Q2FadWMz?=
 =?utf-8?B?L3hBYytsVHQ0bWJFM1hKODJuZVIwaTdCdVN3M2wyMXhaUHRMK2N2eU42MUxR?=
 =?utf-8?B?dlp5NzIrNU1sY2c5TmxmSXJIdTFESDFsMmdJMWFuN0N3Q1FmeTRSKzRXMksy?=
 =?utf-8?B?L3hTT0cyQkM0WTRVTHo5c2FKYUVYTW5YN29zKy9VQ1ZkdGZVWlh5dHpvVGJE?=
 =?utf-8?B?N3UxcHBHT1pvNzVSM1Qvc3VndWNiREZNTFFoazhUeUlmdTFCSjJSZlhnQ1R1?=
 =?utf-8?B?Nm1iUUFneWZVVUpKMDlvcGZXd1cxdW84NVhiSGdoc3pnOFo4ampsei9sdDJt?=
 =?utf-8?B?WTJyaUlkaWwvYnV0STl3aEt3WFRiM0VWNGNjcEFDZ2NnZjR0dldoalRmNHdF?=
 =?utf-8?B?NjJJV0pjeEN6dVEzaVhXa2J6YW5nVytsV0xsK1pFRVM0ak9YR1hwZXg4TW9w?=
 =?utf-8?B?OUs3OUFBNVVkbVJEaTVQU2xoUzk0cWs4YlZ6aTBObTBFM21DKzcremdXc3dB?=
 =?utf-8?B?T1JpamNDNlhiM3l1RFJWQk1hKzA0b25YTjNQaEplcXlBWmphSmpibnFHY1du?=
 =?utf-8?B?S09XemJoNkNhcDFMVytjWithaEQxNXdrUE9OWUIrdEE5QXBWc21xbXVYOVIz?=
 =?utf-8?B?SHI1RDFYUlJURmdQRHQyNDZUU2x1ZDk0MWpZVnFKQy9rTTkyTDY3VFFTSXlJ?=
 =?utf-8?B?OWNRaGdsRW4rSmN5ODJ3eEgwN3I4dWVKNzQ4Vi8xRStEazNaV0hET0JLenFs?=
 =?utf-8?B?aVY1K29VTS9CMVUybWJFMDVqNVdLeUJLN1o5Z0ZoWjFUM1hjSHBUa3RiRHAx?=
 =?utf-8?B?a1M3NGkrUVJRNkVlVnRBRlBUWC9FQ0VZM1BRUk9sVHJqU1VRUWN3UU9XZVFE?=
 =?utf-8?B?dE9lclhDTzZQS01ZNWtrK2VoaTQzVklhVGZTUnZlQkZPTnNDVldLdjlQanh3?=
 =?utf-8?B?S3l5T1hvSFhOVTdjL0tDRGN0ZyswcjZjdlRRbVdSSGZmOENNa0JWQmtEOWRu?=
 =?utf-8?B?MTBuS0hVd1NtWnFNTW1hSjRpUmNnVVR0cE9EdFY0WEZLaXRiaVVaVEphWUNy?=
 =?utf-8?B?anB4b2E4bkprMW5CeTFjRlVkeHpKbkhzSysvcjlaeGpaaGxtTytUZzFmVU9T?=
 =?utf-8?B?VnRCY0hxWHJETUgxQ3dWaGxmRjdJeXJnY0l5dTdyWU5NYU95enRaZTdsL0R2?=
 =?utf-8?B?S1J5NTUwZDN2ZUNWOGtUTlRZVGVlZnk4KzNoNjZmSkx2SVl0VkcvTXVjQzho?=
 =?utf-8?B?MHVkZHkyR2haWENMbUJNSTFhVTR0MlNBYm9RY25RN3BoNmI3UDZLVGJoVXZp?=
 =?utf-8?B?YWo4Qi9JdlcrK2pROFBCQTVRbVBCRkM1Ry94V2RZU2NIWEpyUm9TeWlTTHo3?=
 =?utf-8?B?STk0RFo0WmhmS1Ird2FYYmRZczU1OTIvNlM2YmpjZVkrZ2hKclNCaENoeGx3?=
 =?utf-8?B?TCtrSWxwTnVHVGQwQ1hORUM5YjlKalNaWk53YzMyczNSQlA1NTBoOFVSYmhp?=
 =?utf-8?B?OUdPUGg0YlJMUkhzSjczRVJpSTFKdUZROE5kaWkvTjliSVZWbUllT2psQlBN?=
 =?utf-8?B?YjdObk1vYkJVdXV1bWp6NlJMWlY5ZlZnMHBRL2gwQ2E5Ymd1WXdZN3NqQVFG?=
 =?utf-8?B?UUQrTmxWMSt0SUR2QTIxRW5TWitPK2M3czdteWMxRmJiNUtZWERSSHBocXpQ?=
 =?utf-8?B?NklRUTBFcDdvaE5nWGd2MVZXWDRkTHhZMlFxaENDckNoeDNORy9LVTRDUkRh?=
 =?utf-8?B?VkdPVWF5c0RKVTlMY28xRG9wUWh4OUY5ZWMrOVkzVmlrRGZ2T3lkRndkRDdY?=
 =?utf-8?B?Q25TTlhhUEF2ZDVicGZ5NUp2Zm9oNG9McEI5SnB3WnQ3M1BoM1o2d0RHcWZF?=
 =?utf-8?B?YUFSYUxGZ0hxRGh6WHBRNGpaSEtFVlBjcDhYUzhZRUlwM3FYMHpTbDJrRlJY?=
 =?utf-8?B?anUydlBCbFZSNU04Wk4xTFh3cnYrWVo5dnVKZFYzNGtRcENTNWx0OHd5Nlpo?=
 =?utf-8?B?UU91enpQUHB5dkVtTzZlZjB5WURiUTBpeUg3QmpPQXMrS0F4MnFJYU9yUnVT?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdf0bd2-7953-4a78-43f3-08db3cd1794d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 10:17:38.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FwSVLFU/wjsq8gOGIBP7Obi26vkmvkC6R1vc8UuOYVnYxR7ORpbTcgOdlc9IPNfWRFvYQ8B1vYyZKAQdeN7gd7qBGZCTjIxyRsDnmMXpkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7779
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Am 14.04.2023 um 07:57 schrieb Nuno Sá:
> On Thu, 2023-04-13 at 18:37 -0700, Lars-Peter Clausen wrote:
>> The tmag5273 gets a runtime PM reference before reading a measurement
>> and
>> releases it when done. But if the measurement fails the
>> tmag5273_read_raw()
>> function exits before releasing the reference.
>>
>> Make sure that this error path also releases the runtime PM
>> reference.
>>
>> Fixes: 866a1389174b ("iio: magnetometer: add ti tmag5273 driver")
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 

Acked-by: Gerald Loacker <gerald.loacker@wolfvision.net>

>>  drivers/iio/magnetometer/tmag5273.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/magnetometer/tmag5273.c
>> b/drivers/iio/magnetometer/tmag5273.c
>> index 28bb7efe8df8..e155a75b3cd2 100644
>> --- a/drivers/iio/magnetometer/tmag5273.c
>> +++ b/drivers/iio/magnetometer/tmag5273.c
>> @@ -296,12 +296,13 @@ static int tmag5273_read_raw(struct iio_dev
>> *indio_dev,
>>                         return ret;
>>  
>>                 ret = tmag5273_get_measure(data, &t, &x, &y, &z,
>> &angle, &magnitude);
>> -               if (ret)
>> -                       return ret;
>>  
>>                 pm_runtime_mark_last_busy(data->dev);
>>                 pm_runtime_put_autosuspend(data->dev);
>>  
>> +               if (ret)
>> +                       return ret;
>> +
>>                 switch (chan->address) {
>>                 case TEMPERATURE:
>>                         *val = t;
> 
