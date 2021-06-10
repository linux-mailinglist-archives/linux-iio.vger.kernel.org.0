Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4292B3A35CF
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 23:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFJVZ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 17:25:59 -0400
Received: from mail-eopbgr70101.outbound.protection.outlook.com ([40.107.7.101]:35841
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230117AbhFJVZ6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Jun 2021 17:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K52R0DUczGB1N0zNjENZeB+sMj49JIGo1I6Kx9gQl1hlTWUgAePM411izsK/8Wur7ISdj58NuavD/6f/O/CJvp74q0xSqqXjCYSRs39T/tH3FHNICO+ud3kbG6WUpXZVnhB4qDMV2Xe32ow/A4XYBN9Nb0CqEETSe3eVDoEajARpDo/BFHSKMb7QjCDyK4clzyxtoDNna4BFe0rpzofIgRFH5gj52aN2FtBemNoIZU2AFKrCIGPTpjVqJmFpN8VFMr3jnNd3CYcaLcmiPsLC2wGpjfNaEluhL3M3eeK0pbQkwmOUu8b+ShDdyCmgRhXPyHl8+rYIjFiTg+1BsZLvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcD4NDBDuUG613uAbTCBnO7Tav9MAuBzfuL3XzedFU0=;
 b=Z7X0jcDPLdS0AAoXC4Uhff4027Mk6QuDSuYWHHCJKsDWyIE0+y+kYXi596bk3MhG1TkfdCMqQr/+da6EBSIwLBwDjeSwThf7OBlmsRQooJadPZyHKIg6NcrKSxWmD7Q7ga4v9/9PwHvxX4kOW4IVkqJMpjX9wpz3cw9WZX1UJMZd9+ZQTz8N4cvUEMxu5yPqeN/MbCibA5x2Hx1LlnEWULzz8czkJmaC7bfzmIWK0S2Fli0sbk6FlLxnr/N1Bm7ywtBE1aZxtfcx5T9O/yuamP2SILCxVC0TTPi2ArfjSGg5pFRUBAf1awvlHo8Z8Kte+B1JBL7RA44J0Sq5lZIfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcD4NDBDuUG613uAbTCBnO7Tav9MAuBzfuL3XzedFU0=;
 b=lCBpisx/t0Dh09O3fawRFgoG4iCCFuM1GD4eRYzwVyjcFDT2Sp8DeNlk97yy2/DG8l8dwE3IGjfFmJ5YuLakZ/oHLh4B/AJm8lTz1LtSfw7/SKrBwSh6pI7Yrmx4EZLNjaQ/OzyPqT3zWD7xiVHTY4/BcrL/uwuA5NuoosZP3gI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR02MB3061.eurprd02.prod.outlook.com (2603:10a6:6:1e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 21:23:59 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 21:23:59 +0000
Subject: Re: [PATCH v2 7/8] iio: afe: rescale: add temperature sensor support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210607144718.1724413-1-liambeguin@gmail.com>
 <20210607144718.1724413-8-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <f431687a-0cd5-a2b8-2294-7e4dace91b24@axentia.se>
Date:   Thu, 10 Jun 2021 23:23:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210607144718.1724413-8-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: BEXP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::12)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by BEXP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Thu, 10 Jun 2021 21:23:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bd3daa4-c05d-4a05-a0be-08d92c560f68
X-MS-TrafficTypeDiagnostic: DB6PR02MB3061:
X-Microsoft-Antispam-PRVS: <DB6PR02MB30616DCDA3CF859EAB1A9E36BC359@DB6PR02MB3061.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xom/8QJh1KCB4gkFer7b3Y/STpH8Kapi7D/ICt/2LvufjRyhWPuzD930peIeu0Hm+ZVVi+png89r6SUWpA7imQ+Isaf2p/Z8NO9M0zFHw+h5DzldsM6mWsQTUXVahLAG/0lRBB7Jf1V8eKB0lsSdF1LwsvS/Qe7HIZ854Ie1DyBnjVpCjplmbx2o4vJ4oBt7ZDWGzuchHIgg86FJOfjse7V9gubMlj5D7WS7vxfnCXl3mwxL4qdT4X35JETzwrfckXm8qn+ptF4sLG3fK0YhaVn+ycLAIJ82Z0gIYBFwvedVulExoyfPe0CxxJDVLsaFDAxMEbLbWQ2JpIxnVYJkuHRS323jYcbSSwVbLxNQBnqhP6UPMOsCoX2coe1s1EOQXlZZLFDXGnVqppl+WbWMgZT30DZmlU4audT+PotfMeaOmkdkKmHO2MnwrkDqXyda+ZRmq+VtnehmL6kMApOvAPX9O7574dKLe3hEnJqLz3OYfPk1YjPgHins936TGYD/ysGYkVow2R5HepJjWA8cNtAWZGHoRDSVO37BjwoRRpcKeqtRJivbvAmxfMVtllWNzUROBPEg90RiSFSvid6GviqRXTNYQtw8MS+NjMUtWHDNL9yGOCIyZfC0uYaW1J9WuMifLS0C5yXrvSc2IQnh0P3J0dEHlQgv5ml4yCIPlDRo99aII8AO1ZTo4YVdEEoA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39830400003)(366004)(136003)(86362001)(6666004)(2906002)(36756003)(5660300002)(6486002)(16526019)(956004)(2616005)(31696002)(26005)(4326008)(478600001)(8676002)(53546011)(8936002)(66946007)(66556008)(66476007)(38100700002)(316002)(16576012)(186003)(31686004)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVWUmxIdDdwSnJlMmlJN1psZFMzeCtyRGhWK0xoWUZJcXpBcVhRS2M3dlR2?=
 =?utf-8?B?VGwyb0JYTjVMbHk4QThzK0JpakVvY3JodGw2UFp3aEoyUEJnQXd4dTdmbytF?=
 =?utf-8?B?RHBWdjlHYVZyVHREanh4cy84d0g2Uyt6Q3dFMWhKUm03aUdLZ2RPN0QyWE5h?=
 =?utf-8?B?RWZTem1UU2xtcGV4ZnFsVEtWcnV1VlNrQWEvV3gxaWM4TzZpMTEwQzZ2UXRh?=
 =?utf-8?B?SzQzLy9ONisrdjhiaWxGTERrS3UwTmxXbDRHam84R1JSNGZWeWZKSG9URi8v?=
 =?utf-8?B?S0wrN2Q3MXVxTVAvT0ZKL0ZWZGp4Wk1ZTEtFK3RMQWRvZVVMVTdhRnpvQ3lG?=
 =?utf-8?B?TkREZXkvTjlzRTlCUE1YZmY3c2FEWUJJWm93M1prWjJnTTBrNVM5QmVmSjhl?=
 =?utf-8?B?dGhjVXlCQWpaQWk0UG83SVlSVEp3dHRuQkFVaUQrUS9UTk5yczBWMnppMkl3?=
 =?utf-8?B?aDd6YlJZV0wvMndCclVlU1FYY0F0Y0dLS0F1ZksrNi9lNSs1TnBDMXl5ajRp?=
 =?utf-8?B?Q3BaZjhySW5aKyt5MnQ4NjdPYzhsdDVaMUhnSzlzRGxOUSt2N1kyWUQvcWpS?=
 =?utf-8?B?OTd0YkFiaEQvRTduaFpEc0p5eXRSYVM4WUJJSW5EMlA2Q0IvWXlPdnNyQmhh?=
 =?utf-8?B?Uk1QbnQrb2V2c1RKWXdxd1Qrek5kTEViN29HZndTeEhLb0tmUTVZZWlXQldu?=
 =?utf-8?B?VTRvVU1KVnhjdnJQU09nOXZyTzZTdFBuMnV6ampkOXQrZklBallnYUhYYWMv?=
 =?utf-8?B?UjVLalpjTHphdktsOVZ4YjljcjJGUVZteDZtcFhPWFIxNlQ5azFpM1Axcnpz?=
 =?utf-8?B?bVgyZ2RZNmx6aTc4dUd5dGR2RDZGS0J4TEJQM3hhT0RaK0FrZnZJTWV6N2h5?=
 =?utf-8?B?ZUdmZjRFVis2UGxqVVh2QnpFUmlxYnRFYmNxc2dPczVXa3VKRkJNc24wcmNC?=
 =?utf-8?B?bjNUbzRRSHVkYytRelNET0pTMEFHbHY2YndBWi9DdjFMSUI3RGo3LzlKdW5j?=
 =?utf-8?B?aUIzY1ZBK3dxd2l5anpua3puWko4K1d0V0JWT1VVekd4ZjlXUW9OR3VsZVJJ?=
 =?utf-8?B?dWV5eXppVHNscWViWXZ4bEZEMndvTkdzZ3ZuUXhEL3BGOGx6ZmpoK0x0ZjhE?=
 =?utf-8?B?UXc0MmtpNW00Ylk4WjVXL0VNeDNWdkpxVzJPVjUzYXJFNnRnN0hGbzdFWmR2?=
 =?utf-8?B?Sml6Z3JydE11S0Y0M241WHBJbG5JU21DcERMVlkzNEI2czIxeGtCUzFaZU15?=
 =?utf-8?B?N3NHQVBDZVlWMWgrL0VibnNpTkNVMW9yeWc0c0hNL1N6aDVnSzdoc2xnYTZu?=
 =?utf-8?B?NWVDTWNiWTlsR3JQOGxncERJUUNtd243ZHdjTzVmcGI5OXlXU1hjL1JTcDVn?=
 =?utf-8?B?Z1kzRUhrUmxHdDJwdFBobWMraDBpejBJWEd4em5PUTkwTzFabnVTdkRzNkZt?=
 =?utf-8?B?bmpCK2hlblgweHhzRE9JdHVZc2d3ZWVHNzZUazRDVkVpajNKb25xQ1VaZmVr?=
 =?utf-8?B?b3B1dHM5VENwVUNpbE13T3U1OXA2OHBLZjJXQkhWZDRBT3hvMFFTaEk1elBP?=
 =?utf-8?B?UVZjN2d3SWpacXlUNlhJNVdHUXlyamprcHBjcElKRTNoS0xSdERyU2YxNjBt?=
 =?utf-8?B?bkJNVzQwNngwTXp6a1p5SWkrSE9ISzRzb1dyUG5TR2xYMHhPaGUydHBkV2ZB?=
 =?utf-8?B?VlF2RXNBc0RDWjRFVnN1ZnVmWE9QblU0WnlXby9qWk0ydmN0aCs1WUU3NXZm?=
 =?utf-8?Q?zkm0b3jqvz6NjyOLqRjSH4v4djh+CphLkwaoXfc?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd3daa4-c05d-4a05-a0be-08d92c560f68
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 21:23:58.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP/0yAICrAPzyG+7hDKvyjEV9v0cWu4vZKaHDsQtBKLz6OGEYiclCw/haXDn6wr4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3061
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2021-06-07 16:47, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Add support for linear temperature sensors. This is meant to work with
> different kinds of analog front ends such as RTDs (resistance
> thermometers), voltage IC sensors (like the LTC2997), and current IC
> sensors (see AD590).
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 3d445c76dbb2..9e3c7e2b47cd 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -272,10 +272,29 @@ static int rescale_voltage_divider_props(struct device *dev,
>  	return 0;
>  }
>  
> +static int rescale_temp_sense_amplifier_props(struct device *dev,
> +					      struct rescale *rescale)
> +{
> +	s32 gain_mult = 1;
> +	s32 gain_div = 1;
> +	s32 offset = 0;
> +
> +	device_property_read_u32(dev, "sense-gain-mult", &gain_mult);
> +	device_property_read_u32(dev, "sense-gain-div", &gain_div);
> +	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
> +
> +	rescale->numerator = gain_mult;
> +	rescale->denominator = gain_div;
> +	rescale->offset = offset * gain_div / gain_mult;

This should be done with 64-bit math, no? After all, An offset of
approximately 300000 is not unexpected, and that's quite big to
scale with 32-bit math.

Cheers,
Peter

> +
> +	return 0;
> +}
> +
>  enum rescale_variant {
>  	CURRENT_SENSE_AMPLIFIER,
>  	CURRENT_SENSE_SHUNT,
>  	VOLTAGE_DIVIDER,
> +	TEMP_SENSE_AMPLIFIER,
>  };
>  
>  static const struct rescale_cfg rescale_cfg[] = {
> @@ -291,6 +310,10 @@ static const struct rescale_cfg rescale_cfg[] = {
>  		.type = IIO_VOLTAGE,
>  		.props = rescale_voltage_divider_props,
>  	},
> +	[TEMP_SENSE_AMPLIFIER] = {
> +		.type = IIO_TEMP,
> +		.props = rescale_temp_sense_amplifier_props,
> +	},
>  };
>  
>  static const struct of_device_id rescale_match[] = {
> @@ -300,6 +323,8 @@ static const struct of_device_id rescale_match[] = {
>  	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
>  	{ .compatible = "voltage-divider",
>  	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
> +	{ .compatible = "temperature-sense-amplifier",
> +	  .data = &rescale_cfg[TEMP_SENSE_AMPLIFIER], },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rescale_match);
> 
