Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BEC5E5B25
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 08:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIVGM2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 02:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIVGM1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 02:12:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64353B514E
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 23:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFEp5lMfgxvkUPk0UYL3CXnS8fjlbmNrQTq6+lZfcIJ0qlr4S5rTFYqvtrDc0rgmtOzFyyCPfa4flzMyfn0YjMQvgcXWhiU/Fbuj44iL/d0QKb/8+qLJawzWpcuTRa81juAhf69nuDEREh9znJ9JIX8W7/rcbqXa9IPLaD3vC+IJ2MaU8bvR87qiqSH7D3dvVXHp/z/RYSMkpfXbl2wsL5weXWj7CRgXs8OlikrZimGvqMXrQD/wAUIVxIBh1iNJ+UOdXZkpD2KjmhWc3SVGAGWU2l3wSVG7W921NJXqG04uZWxq6gPv/9PL0DQKG4YXwpEDGXqqEo5zB8FkeuJaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zRVpYdTa2gdy9b7T4t3pxQ0fWaG2/wnYCL++1Ix3p4=;
 b=cfKFNST5WMDLuaMzlB94sZxc5VwBCTSRZPI/BoSDOujniW1OUMP1/mHznMTdxFV1yF+XuNu5bixIsE5cRa+JjNp2trg+5k9HrlrsGSdoFtLYNIbzykepRojt6jdTzI2Rlks5CDiyWmUB6nDSAxTF66+gEUBks1sn8hj+DYyN0WfbThPaPlJd5TnS/tgrPBzW05x89MSKSzUNlsf8LNxpHn/CfHyXLHnu4bt5+zhM5DrIwF7Z8GEcswDBO7Z6MImEpddkGqaib1VDf8VALItVnvxghP6Tt3la6M0dDXC+hWPEdzU91Kpp1OVvM6Y8iwifRK3m60bwEcMw6OHkkQsgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zRVpYdTa2gdy9b7T4t3pxQ0fWaG2/wnYCL++1Ix3p4=;
 b=G2YPAlBVMOnuYLyMYiTyLIF7qnb/osavjO7NsJZf1dmIf6I5FkX6M7v5+KBqlqZg45AQr+HAzG3WQFCTSA8ol2t7S31cw8lqhGgw3xNzifMadL4RKr89wmKZMWwXwx/wfaIHl1p31gKUdYwVyoJgrX2W79Fdii2JQa96awaVceRp52e5ugYBqvpuvvfXVpV6nQgejNUNyGHXeHdjPH7Ek5MMnU9hY8az64wcD6Fj+YrRI5V1tb7wVo2JTTkkJbPfsOBcKgllqK8r4Jv2VYpRAiI47wIUiw9qQ5UDR3d1YhK/514BW3MsmabOkJmK0ztaeWm+Y5+I7tH1OUASe4+IiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by PAXPR06MB7693.eurprd06.prod.outlook.com (2603:10a6:102:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 06:12:22 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::b194:6047:f28b:bc91]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::b194:6047:f28b:bc91%6]) with mapi id 15.20.5632.021; Thu, 22 Sep 2022
 06:12:22 +0000
Message-ID: <1760ee8f-f256-1645-1d82-a740833b16e0@vaisala.com>
Date:   Thu, 22 Sep 2022 09:12:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5 v3] iio: accel: sca3300: Silence no spi_device_id
 warning
Content-Language: en-US
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        =?UTF-8?B?TnVubyBT4Lij4LiB?= <nuno.sa@analog.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
 <20220921163620.805879-3-weiyongjun@huaweicloud.com>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20220921163620.805879-3-weiyongjun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::19) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3625:EE_|PAXPR06MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: fd445ffc-f3da-4515-7287-08da9c616966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a09U2rFYqX30CPkaPfANFH8PhgCksg4ShYRetMJHurBKIk2VJtFaOS2b3QeXya4Q2HW2Igknc4y0/6m73yj/uwhpblnjlSy428/lX881JqMLVFl2TMNy5Ymupv9GhEWEUbgsAbzxAVXDt/GnI07IBrq9FIq35SRGyRJezHqm1oy4avYyRqExmJyF2FOBZTQ8mMOpe8LwnvFY2uxXiczBbiPjD/0RbG3UU77ftd+KZQTe0aQ5O7u78s0mwbnH0jGIutptI+LboE+xju+brlEEXBSibpwnI8TZEu3XNo64Ugucn8t/pBX7oPTKDcTONSHf76N5W1R1/e3bYouAAELqG9sI9taWaZ/kOmmK9qvHAt3zaLzT/0PKYwC5JAdAdyOMV7Inq5YyP2bZ5QC9Seu9qYVFsdBkFSzG6VI5WzwKogkAqV6FpWcTA9Ry4t8wDfEXy5Sz4BFyQc+vtOhw10EOYDLksyhGFJmL6QkHLcvptlfU236929ufZZjYA3qpbCsD4aEG5IRMauRAL+/KlXwA9xoqezyHIX+PNX4mJ8s/oN6IEGrwOJo5cipyYdBgb1V+kb5Aw3LYzVcQMJM1zLlOs+ydH0f9TcN567jHtU3DWJe8RYOl2ksmIzOGmv4W7RUlpV63xeDTj2+WifeI8AGjokerwN12lu3HbOff6xiEwTHQ+SCC/BbHRtSUYOWtdloRsuqBubJZOrECtGuABFbbsl7+DbSXWP43zRx83F0zAbkUUYFZYUbEZbpBiZjugKJm8i5+xYMOV5FUW2Shv/YyYEDlVRKW8+DTcj7q3BPkRFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(6506007)(6666004)(41300700001)(83380400001)(53546011)(186003)(2616005)(36756003)(26005)(6512007)(86362001)(31696002)(31686004)(38100700002)(66556008)(66476007)(66946007)(8676002)(5660300002)(4326008)(316002)(44832011)(110136005)(2906002)(6486002)(478600001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0x0ZldKMFdmTk8yWHR4c0tqWnI4c3UvaHZrbE00UlJIWWVINHVxZjJmNTM0?=
 =?utf-8?B?czI2RTFFMXlDU0pwV3VsSVpTWUVpRmdpNkp2am9RYUZiRW1POG50a01YS1VF?=
 =?utf-8?B?VUl2MG1GMlBKdTdsaXJGYllwTjlyRVlIallkT2lLaEM2TmZ2L3RhUmFHdmhz?=
 =?utf-8?B?UmphOGZWQnlKNzFzVE0xd1JOWjVPMVI1SG1zZ0pPQTRXblppMjMySWRhNzhh?=
 =?utf-8?B?QUlVZyt6aC9tVXJZUkpRUmxNTzNVNWxQak0wZEdsb0FKbUFpZ25FcjlCU0xY?=
 =?utf-8?B?YzVUS0dHL1p1UkRhNklzekk3c3ZRNUt2UFZ2RCswUVViNUhNNGVyY3BFRkNo?=
 =?utf-8?B?cStSNnF4U1ZIOFpydU10T3R2dGVOTEJmaFA3UWVJRDRQTjFjcUxoOUNsQVlP?=
 =?utf-8?B?WFlQc2NMQWh4ejE0eTZDL2c3WDFJK0ppdk9ud1JoWndpYmZSUXZ6bGtLNEVK?=
 =?utf-8?B?ckRXdlNkdXdmVGF3VlhxSTJiNS9CaGtENVhhWXFLSEtlek1UZFNOUFU3dDR2?=
 =?utf-8?B?b2VtbWVldVpEdEl1T0VFRlVNOTRjWjY1SW9KU3FHOVZYaDBsVUR5Ymt0SFJ3?=
 =?utf-8?B?Y1lTaE5GU05WSk90blRQc0lHTGdvOFZBWFBIUUVEa0t2dTduVHJmbmFoWWtk?=
 =?utf-8?B?RnJFOGhuSktMeW5HRHhCcGhuTTdtcElOZlZmdk5EaXFMVjUyVGRiS1VncGFn?=
 =?utf-8?B?VFRtVm9tbTB6ZmJ1UTNWdWViMjlHSGVjZFFQRnpkb1E1Uk5BZVl6QjFTS0gz?=
 =?utf-8?B?RXNIZFFZNk1DZ0NsY2QvZjlhY2Zyd241RWg2Vk5PQkF6aXFyZU9LSE9pd3M1?=
 =?utf-8?B?akpGbjBQQnJteERFSUhLRXhkYnNSMVZINWFqdXliNmFra1k2K1BCaVJaOS8x?=
 =?utf-8?B?VHlkaDNJYWVBUmJmQ0RmTUM5S2tUM3ZxV2xkaHpuMmZjNCt6Y014THFRMWNw?=
 =?utf-8?B?SEYrVERvMzVLOEltZmRZaDN4NUdhRHROemF2UzdETk03SDdhNEpuM0s1Ym1D?=
 =?utf-8?B?YjFkQTZuRDcrdkFaVGtRLzdUdmdyUExFSTVYYk8ycTVTbkVoNW9PZzlyQi9X?=
 =?utf-8?B?NThaZFI5Qm1iRTBEVkpkcSt1Vm9BS3B3WW9Jek9RRnUrczg5WjR3OUxVR2FM?=
 =?utf-8?B?UkI4UFlJTXhJOVM4OEFmQlhkYlVlcEZLU1c1UWtsNThqU2w2anZXcGJGM2d3?=
 =?utf-8?B?Qi8zcGJmelRpc2M4MExEY3h4ZWIvSzlsNG1wODZxb3MrRGl2bkg5SFlDRDBt?=
 =?utf-8?B?b0R5VkptcVgwUnE3aG54eUdFQXhsU2Zwa3JjTld1djdmVjVDVjlKbUswdGcz?=
 =?utf-8?B?MTB3OXpMQ1l6YTBaaDZsNkNEakxyWDFIcXQyYjFvSU1Wd1lIMWZ2L09FaExy?=
 =?utf-8?B?UEdIbm9BOFBxcllNMTRiT0NtT0c1eE0xSElINjc2bk5nTHpBZHlUSEVQTTYw?=
 =?utf-8?B?RnY3VzdwZ3lWMGF0L3IwcGhhQ1YyZ0Y3b1J0dUxVaTVBaXI0b01zazFYcERY?=
 =?utf-8?B?cmY0aXJKN2p6VVV0NGs0elREUGdhcVJqVUFYUHlnSW91aVNDRDd0TFZyRDJz?=
 =?utf-8?B?NU1OV0V5NGM1T3NWWXpNSWtyUjM5c1F6d256bDNMck9HeTJYK2tQTjRTZlNt?=
 =?utf-8?B?VC9TbmU4MExaMk9Bakl5bXd6eE9jTzRlblFNNU4yYmZXeStpYnpHb000M0Jy?=
 =?utf-8?B?RkJkSU5GbmMwaWFGTjNPMFhNM2lHUzBGYjBMU1JXUWNkS0NzRWc2S01DTlgy?=
 =?utf-8?B?K2ErTVFhYVoySXNSSHRsOXg1emFGWkFGL1hUMmx6allXdklIZXBTMUcvamRI?=
 =?utf-8?B?NC9WVDVTODA1aTZXYjBXdVZaUmJzOW95VFA1N2lYQm9sSndNdmNqVWFQWVJn?=
 =?utf-8?B?YjB5WjNiZ25YRzBlenI0TkpQb2dwVCtsOTFGd1RzYWZzMHN6cUhnYkxJL3BM?=
 =?utf-8?B?UnBlZW1ueWpzcVgrblIrcXFHTTRKOWYxdlBTSmRhUUtMcWloZnB5QVBaTmtx?=
 =?utf-8?B?L0ZoTUpHOWorUEZtcHJNWGVuN0FjUHgxcFQxZ0x2NzFMODFtRnBTem0xSTAw?=
 =?utf-8?B?QTZnTW9pMGIyTEFzUldXQ1A1b3lsUk1uUVArNnVUdHRmT0FIRTdrbnRYKzE0?=
 =?utf-8?B?d3VickM0akZuUTl4YldWaHgwZTJmdmNHaHNJcXFKUGhOWW81YzRyWU4xRGo4?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd445ffc-f3da-4515-7287-08da9c616966
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 06:12:22.1991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12Gawd/4AzM9+ip4xeOgT7ia1gVpPRMmxfbcSx6wf8YwkyhE+u3o9vMKPzJiBkf9aLOvXSqzgbWJ6sueZ0upFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7693
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 21/09/2022 19:36, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> SPI devices use the spi_device_id for module autoloading even on
> systems using device tree, after commit 5fa6863ba692 ("spi: Check
> we have a spi_device_id for each DT compatible"), kernel warns as
> follows since the spi_device_id is missing:
> 
> SPI driver sca3300 has no spi_device_id for murata,scl3300
> 
> Add spi_device_id entries to silence the warning, and ensure driver
> module autoloading works.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>

> ---
>  drivers/iio/accel/sca3300.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index eaa0c9cfda44..306482b70fad 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -679,12 +679,20 @@ static const struct of_device_id sca3300_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
>  
> +static const struct spi_device_id sca3300_ids[] = {
> +	{ "sca3300" },
> +	{ "scl3300" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, sca3300_ids);
> +
>  static struct spi_driver sca3300_driver = {
> -	.driver = {
> +	.driver   = {
>  		.name		= SCA3300_ALIAS,
>  		.of_match_table = sca3300_dt_ids,
>  	},
> -	.probe	= sca3300_probe,
> +	.probe	  = sca3300_probe,
> +	.id_table = sca3300_ids,
>  };
>  module_spi_driver(sca3300_driver);
>  
