Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DEB78DA95
	for <lists+linux-iio@lfdr.de>; Wed, 30 Aug 2023 20:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjH3Sgh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Aug 2023 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242368AbjH3IR4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Aug 2023 04:17:56 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE51A1;
        Wed, 30 Aug 2023 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1693383474;
  x=1724919474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8gp+IA90MwFlUeeprhwQm0j4Bk4TJUc4FWQT8UTfbhA=;
  b=ltRipzC7ARagevmBDUsEjZd6uCViuPqUK6AmXDWM5+4rA92a4IeE8GBl
   FlwUhix/9X1oH29ywkHGn4PXly3WZGBu1f7Om13lovL10l+hEXeZKyvCz
   2uOR8qqZnX2mkADMEHVvOigytk0wXM/ZWsWuIdM++A+HzKtHZhrVSzpZZ
   5lBKOdzu4wh8Sr0+Kls4CupcMqRGKVsljk9vD9YaYFZCEZ9nQeE7iBaQt
   1XRV+tUkxyDFEn0Fp1jhg++fLpGJU4B11KV1IuCKcuygUuHwfSudpyAgv
   g2Wa5d39EMluNNKtEHZG/3BxUXKNWvnO0BXBEDxNVOochIZ+ZAYx/IrRA
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4/vEjaER9F49rr8yHo099ad5qAccPa6nbnFYFkuz8fLVLqbddg2Lylb7nyqRj5Tem2aHH1xsZijgC4pf9tJb2n7lSGNvvYj8VBSplHXq/bCuOgmx1A4vD1L2SfTi7lsOjTQlFJSyLxe1R/04r9bzWlyWpE6xLPwuy82cnFQ9ytP5bhmVdnz7SBsoTmo0iG+WHaLc4ESeXQTSQvi+zDsMtjR5epPbDgN/cn3mXiPFvcsBTKLYiws8+kNWracQWMBFa/XBBcSSgOi3wJcae1GD2IoiFW7gnJb8Kr2D2nCIwhN/HeFBAWaMal8/k1j/1zuYUMd67s1TCdjxv+YTeYQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gp+IA90MwFlUeeprhwQm0j4Bk4TJUc4FWQT8UTfbhA=;
 b=EL+GjO7Yyt6kFf+ZxXbABdgUllRwSINq6Iic4nvBNdoft3HmvjK0d7F/ubbg+0yvBpqeLPCCP3lFa2XzJNki9tFqesxeArbS6BRpPjEY9u8Z6LmJ7Ha+nu7o8lYboVpEphNNetXcTB1nyrfxxZ09u+ojW/42xat+R+K72Iph3FFK8HJogfrNV9JSquuVLkUpI9D8+LDsCqiTHHL+QknGQ2vv1oqXrnuVJVznjHst+a6S3tAJ8891F8S51a61Hotq5DxfkRbvQdmKv2NpL5Isq41Uc6qDX3ltc0D12bOEcUOhX1C60XjzXV6FvYkf9PNuEgLMrkJPZPZIMXoTwW/vZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gp+IA90MwFlUeeprhwQm0j4Bk4TJUc4FWQT8UTfbhA=;
 b=e/OcBCeU0e+gudO1/FCcqOReniadQxu4K8GUqDxXe4482cU3rdRiPbDejiPbwCY8s/KzCYoPP+XVLMJ+ssjqw6PV/a2CKLvWOkBBS7N53nkVM2Dd/1JU3AAdN4UtP6pI9YmXe0qBaPC6+rXfcmLDVntHre9Lfpx1JaKsDoGG1ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <ab94e388-2de2-f3ba-12ae-aad0e3a04eac@axis.com>
Date:   Wed, 30 Aug 2023 10:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] iio: light: opt4001: Use i2c_get_match_data()
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <linux-renesas-soc@vger.kernel.org>
References: <20230812151908.188696-1-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From:   Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
In-Reply-To: <20230812151908.188696-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0118.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::8)
 To AS8PR02MB9602.eurprd02.prod.outlook.com (2603:10a6:20b:5a9::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9602:EE_|AS2PR02MB10083:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f831fd7-a7d4-4e9c-ed73-08dba93197e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Sh/gE+FTVSyDleiovCh529Sum0qNgx1tIsHyy0zrURTGJzlUHo+/nVsYmL1RWzoSdbEY5ldzNo4UEdNhZn8UHd0nHk7uB1LPc0S1OdCsWG355JjhTxfWmorzFgfMBlFmTCf+KalXdJ6J1/2APIAqkjICbkTFF8anMc01oUbqYUKzpjd89aZEr8F+F7NJgC1sVBwY3WszMNJMX6nFHB3+0Oz953M9BfXveQb7GHLSZ6A0zvX51PswTWkQd8O7HfoiRaL9NULIIbsrFwv4fSwGlWqZyhIvkguk16OOvcMimfMueCyaeQ3z0Sf3EzfhNwzh5T3c2BbsD47gL8cGR9VI6hirHhxGtmuCVykquuY145imCFV9fmFL3uapaVEcSfQ2rclVcdfZeeZ4KJ1PlUYbyy8Ee3tbl5FQqZNDh9z1JLVesfN9gxXaP47Z69lrgBmOTsCeEf1ReKb+dbywH60kQcqonTri3k/pKyUA7gZaS0KFdt0jV+ePPEIlaUemhIp9m6yJ41apx6j47K/doJDB4NV0d2PZ1cP02vzkatTdTjlpWmCQjEAK6rThkiW/bcwr2V+6YEeyfcE3FuJNOxhaOMjXaZBzctpZ/pfhhCSN0XGvhucy6/qX/VQGMvZPY6hqXo++tNFW9eUVY7PEYDEtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9602.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(1800799009)(451199024)(186009)(31686004)(6666004)(6486002)(6512007)(54906003)(110136005)(478600001)(38100700002)(4744005)(2616005)(26005)(6506007)(53546011)(66946007)(83380400001)(36756003)(41300700001)(86362001)(66556008)(31696002)(4326008)(66476007)(8936002)(316002)(5660300002)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REZ6bytlSlN6R3hZMlNaOGJjQ0l2eHpsclR3T1JVY1JsYUEwa01RVWNocDE3?=
 =?utf-8?B?d2h0clBFVGIvb0JaZUZIWlB2M1E4RzBlb1FwcHZLelpuUURrdVhZSjd5QkQr?=
 =?utf-8?B?N3I4NWNxelFOTXZlVmN0ZTY5RXJ3YjZUajBxbksycHVldFVPM1RVMDIvSjZx?=
 =?utf-8?B?VUx5RUtWNW55a2xDYXBZaUNGcEdKcHB4N1FzR1V4VEdSSHNaL3dGZUhCY3ZY?=
 =?utf-8?B?UDNqSFJmVTZacElCYW5mNEQ5Wjhzb0ZxTXVrMTRrNkJzN1V3Rm9WeHZHNEI1?=
 =?utf-8?B?R0tzL2YyRnQyYldGa0NaRVFOWEg5MUVOMmQwRXpoRTN0Mk0rVU85dks2djlP?=
 =?utf-8?B?ekNmUGNCRnkvUEdnelFXb0hINUl4QkU5MmJaK3F3M20yY3RaNkYwSEJyNndj?=
 =?utf-8?B?cTFlMW1VazFLWDIzUTVpT1p3aTBXZFlKUG9Wek8wZ0RNb1M5ZGtNcGJRQVNw?=
 =?utf-8?B?aDJHRTk1ZmYyNW5ZbC9LOGwyOE9LakUvV01pQWEvalFKS2NYTnNZN2VZVzBt?=
 =?utf-8?B?M0lRd2xjejh5bUlpeFB0NVhqaWZUc1VHRUN2Kzc0Y3VuRUNCa0tocDJTQWg2?=
 =?utf-8?B?T3lDN3pxTHdzTWs4bDNKeVlLWVB2a0RoUGxBN3gzMUpRdGlpcm1OM2RaeDFq?=
 =?utf-8?B?Q3hnK2gzeDFpdWkwejl6MUZkYW1HVGZCYTdEamJ3RUUzZ3F1bHEzQytUSWZP?=
 =?utf-8?B?OWdNdUhpUkx3S1kyb2h1eklHVEhpSlpPS055c3FoanBrQXBRNXhlWjBDZCt4?=
 =?utf-8?B?K2p6NVpiZk5BR0dqK0w1Z2JIWWJnRFNGVXhtYVpCb3hBUVhUc1hhTkcyYXgw?=
 =?utf-8?B?RW1UaGlXUHhzV09XeWE4UjNOZlVKd0RvWDNHTUlxS05ZNGl6Mi9lemRhYkZG?=
 =?utf-8?B?a0hudTJOVUoybGZ2bzZWeXk1TjU1b0xWKy8zWVVvbVhBVFJPMXg2ZHNlUk5w?=
 =?utf-8?B?bU9uUnlLZU5kOVVUT3ErdjBHK2lnSjdnZU81eEJhUDh0RHJPWXF2Y3grZzBI?=
 =?utf-8?B?Yi9QVVE1cjd1eUZxWmxXdERKUlA0NHlVTTlOZ1hxL0MrNXY3YmtpcEl4UlIw?=
 =?utf-8?B?WUg0Tlp6Y2cwSzdXY1djVUFTaXlTWVhKTmRLbnZFZWhYc20rb0YrSE5KNXp1?=
 =?utf-8?B?RjV5Qy8wQ0RkQk4zQk13aThtOUxlMUtCcmE0ck9sbGlub3kveUpiOHlKRFdN?=
 =?utf-8?B?QlFQd2t2cnJEaDRabzd5VzY5YkY3U20wT3FwbDFaMGJkajJYZnZHeGk3NUlR?=
 =?utf-8?B?aVNjYWRhUE1kNENRMEoxNVBmTmZUQWJkYnRJWWl2dktycGtGYmYzOHVZZlp1?=
 =?utf-8?B?TnJncUhxOHVUS1NyWnpjeHJxelJmb0RPZEtQSDZFT2pka2ZWa2xqcEJnNU5h?=
 =?utf-8?B?UFlCWUwzMFlHOXN6MzlnTHhNMUtMbWhKQ3pOam1RbGMrSlcxNktGQUMvYVln?=
 =?utf-8?B?WHlnWlpZb0VvQVJzTWs5TW9MQ1JDNjlocUp0MlpHOGtxcGhoVk8vaXpNL0Nz?=
 =?utf-8?B?U1FIYys5UlhuQ09RM2xRK29ZY0RqdHZQa1E4Q1dEemdPWjg5VjJjbGhVNWEr?=
 =?utf-8?B?YjlWdm5YdTRPMlN5ZTlndEFaV3hKRkdKaktWb2h5L25UZmpUb3JMQ3J2Zjlu?=
 =?utf-8?B?RDR4K256cWlrUG5XR3NqdVRUT2RhSmVIS2Z4dEVLS3ZHRloxM0hMWG5XY0pI?=
 =?utf-8?B?dzQ0SkVRT2pHb3NzaGc4dnVlckNDclBjeUlLMWMvbVpUZ1c0OWdMYmRRWG1Q?=
 =?utf-8?B?akpWeWVkQlcyQkZFSGNyU0Rnd211N04vQTVZdVVyM0ZBV1FoRWI3YUpCVzE0?=
 =?utf-8?B?Y215NHZpVks3NjVibEQrYUozbTFkWFl3M0VudXQ0eGdzMnBMUEcvMUFKZUMw?=
 =?utf-8?B?UFBpeWszL3JXWk5QaFI4dWNEUzBDYVdDdS8vRE9VdERtUmhIbWYyLzFKMmM0?=
 =?utf-8?B?TGZ6NHozUXhwSDFUU1JhenBGem44TElnbU5HaWd1bTRlOENkVDdER0cyLzZo?=
 =?utf-8?B?NmwreVNGL21pWTg3MmNQOHBiYldmZUJGSG02NnFBNGNPK2hwdUd1VWNIUkU3?=
 =?utf-8?B?MWdPekhmZlZUK28zMEZYQzRzYStSU3NCdkxDSTNnTkh1VW51ZEZnZHRhODky?=
 =?utf-8?Q?ZWbQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f831fd7-a7d4-4e9c-ed73-08dba93197e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9602.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 08:17:47.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSlm2RPkexWIpHg+5vJ9JouwhyUoR3JDD09C/RJpUnHM1ahsIon3U32bU0JshCIhGWs4wC9vhky9EoUDkDr6iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10083
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/12/23 17:19, Biju Das wrote:
> Replace device_get_match_data()->i2c_get_match_data() to extend matching
> support for ID table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>   drivers/iio/light/opt4001.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index 502946bf9f94..6cf60151b3d8 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -412,7 +412,7 @@ static int opt4001_probe(struct i2c_client *client)
>   	if (dev_id != OPT4001_DEVICE_ID_VAL)
>   		dev_warn(&client->dev, "Device ID: %#04x unknown\n", dev_id);
>   
> -	chip->chip_info = device_get_match_data(&client->dev);
> +	chip->chip_info = i2c_get_match_data(client);
>   
>   	indio_dev->channels = opt4001_channels;
>   	indio_dev->num_channels = ARRAY_SIZE(opt4001_channels);

Reviewed-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Tested-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
