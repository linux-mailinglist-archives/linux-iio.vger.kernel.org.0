Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1FD395613
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEaHaM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 03:30:12 -0400
Received: from mail-vi1eur05on2135.outbound.protection.outlook.com ([40.107.21.135]:40727
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230104AbhEaHaK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 03:30:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxaQCP1INKYXg1yAiXFLOIKV1wESF5CcfzTga75ssWCo5qIhR490g+31mFEfGxKefrA6S0WLnqPzVc3YWs4LvHsjbeOaymfBcLc1JrRggrZv+GrIQKzQ4Jn4GBXTxa5iNfvUR9M5f/OTuLFmT6XyD8DzRcB5Mmf9MSHcla91iPtCVhtIW2PKnUVRGPixT+05SAFYP3q8tbyzygs4YCJMKvyqs3jG2KcBEmCjS+bLpSpUt35YHbgijLc3117P6qkH5Sf9Hqi618wIaiJtBo6bz7adFaugBB12uF9chnXpu0uCB7U7yYGF5bJ5euIjP51NgUVvoGW3QlbWJwrSVMyr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww67vWoh4g0SE610Fcwp6XzB59ZE6zEbLQRJzui4ESM=;
 b=BIG6o0f+Qi/Rkqi4rCaaH+kB3JEQeGvdScbbCP4fM5lpk3tkh+L4xn2VUUOzUo2I8Op7pYOqDtlpy9uKlKMvu19xrGwHgYvqrbIfJpFDJXqg5mzr0l+nDT+z3fvYtUoCDmWuFshFeRUOXWKGVsCk5ibEHwqZrs2G5thPJh+VIyiWaBV/VbDvpDn1dh6rTSZZMbM0hOX0t0BdzGJckAdj4orX3/q9mF7kj5JOSHKa6kiBRNnTT6eQo5cSNoxpxBLVCFeSJzPnQxwVSi2rVvOEvQ9Q2Sscv12zPBRWVw9izCeOhnlnTUmeYAWXRxEIWJWOrYUqAbaCHS761j0EAiybIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww67vWoh4g0SE610Fcwp6XzB59ZE6zEbLQRJzui4ESM=;
 b=kJSbK3k/sMlwWoxtM9lJFbtwrXUw6NhkeuIFe3No3YGecWjPFzpsUY8l26pO2GnUnEdthLZEppSVvyYKPcgedEvLCJYJZZn9qms6A0FEu64AMeDbiPGUzddgvji5fjGhjvA5P6YD/kONG44TTS07mI18T83WnBfoAOAggT4XbS0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5241.eurprd02.prod.outlook.com (2603:10a6:10:74::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 07:28:28 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 07:28:28 +0000
Subject: Re: [PATCH v1 8/9] dt-bindings: iio: afe: add binding for
 temperature-sense-current
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-9-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9f38ad0a-0a08-458d-b721-f4d424cecc6d@axentia.se>
Date:   Mon, 31 May 2021 09:28:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210530005917.20953-9-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR05CA0276.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::28) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR05CA0276.eurprd05.prod.outlook.com (2603:10a6:3:fc::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 07:28:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6510ae6-d168-4d68-4be2-08d92405af5f
X-MS-TrafficTypeDiagnostic: DB7PR02MB5241:
X-Microsoft-Antispam-PRVS: <DB7PR02MB5241AC732197A523709205BCBC3F9@DB7PR02MB5241.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQfcJNqwwFi2gpV7AENJBVhk0HLYfMJoUPL+2NQgHFQ20sy7g2gEIjnb+ABrq7hNXzyX7Gx+ghiiXDciR//rM0NGYiIyO8hj3xPfIRdSzAbyNH6zy/avyyGqp6f4YW0wSuxisA8XnmzRnhiMBn2l5OwC0fgWuORHe5Txlwizh7COYDqlqW6G3SIrh0bAMknoDzYSzNm5QBny6CvJxEvxE2DSG6apM42XVhb2j4xA7ItXY4VNpfjGfBokhZl0WPbsyoQZZBQWq2t26uAWUaH5vOY6Ai6aq6pG4f63PcqWb76G9VzCDYWmYG10+ukJhnC9Ykmfxq9j4iZ78g9tHw+cb5XDETPKJ4S+8HEyVYJLsNTax2YMCoLYsEospFHcUfYnXSufoY3uNIWlqcIW6JcVzoVJvQVVQeTD3bGr5pn1Z1CCEvLduVZojbSUD2yskEaQ418xUdzcMAD7gzvI4pZUg9c/EXn7NSBKTejWieGNw1rd+CL9/FfVmNgdhzMBMjChDpZpLyCX3MZ4Uzbf94dyoZxTrS8D245xvlYN/CTKmWmG7Op3ri3rIh15MuyEbQGCiAAzYDcsAtfGnaGAm5WGcrNZnKOKwWSKj/KiXdeO9rw3FYkFgkoT33BvoISiyRo2TkphTR+5+5UNeHrVXL2svOXH7evk3zrNfByClKfbx407ZEOlTgUHvaT49vVp9KSSa4Guvf/jDUZPSqry6nHOHjw2c8vhQ1UX3lLMJkNkrhIUxI80ZYklXdeUTpzCqT93L6NL/PhjMAzPpowgpufgUKJubGTwczgJ89kzS3nqZag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(366004)(376002)(136003)(396003)(316002)(8936002)(31696002)(16576012)(53546011)(4326008)(26005)(36916002)(86362001)(8676002)(186003)(16526019)(6486002)(31686004)(2906002)(966005)(2616005)(956004)(5660300002)(478600001)(66946007)(66556008)(38100700002)(66476007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ry82R0NQMWg3UHI2ckllekUyM1d4K0d1TDVkTVNFT3F2cmVxUkVldXowTENh?=
 =?utf-8?B?M3h1S1JXK3VsVmtHTSt2VUVQL2JRMFNJOEV4Rm1TL3dYVm5UOWc5L3pjNWxC?=
 =?utf-8?B?Sks0dXJSaXhqQnRmTjdseVYzOU1aaGp0YzRLWC83b0M5dHowbFZoM1lKbUVK?=
 =?utf-8?B?eGFRY0RKWFR5NDVJMWdMbmkrU2thTXFCdEgyeXNBK0QvZVpOMktOY082Wklt?=
 =?utf-8?B?YUttTHNDbStscXRLRFBxb2FoVnFwOUlVcnc5WE9RYjh3K3UwMEZrc2ZGcFdO?=
 =?utf-8?B?dU8wUUt3WjlJZHFIbUl5OWpGNXNQK216Q3doR0Fuc2NYTHZnMXpSYjdXVkFt?=
 =?utf-8?B?b3BBY2N6bEFoc1RwanJlZkpjRGNvOWRrdzRzRkRra1U2SCtHWVdsZFZNdnM0?=
 =?utf-8?B?WnJPeVJoTjdkSUNwWCtKSEFFTCsyOTlNMGpxZms5NXRkVk5NMTR3eCtTdDBB?=
 =?utf-8?B?SVFDQWFyY2h0MDJhSWJEZE9jUjNINkNaYXlIWDZhNjNEamlSUy81R3k4WEJW?=
 =?utf-8?B?ZGo0WEcxWmhrQWRzbWppVTdRaHNodUN6UUFkUzkwUS9tZ28yb1YraHpiTXM3?=
 =?utf-8?B?M3F0RXRXMHlIODh3czUzRGFzNDgrc1J6WEhTMllVME9DdDBGY0MvU1I2d2Zp?=
 =?utf-8?B?K2dzTkFrYzNZRkxwM3hOclhhS3dlNDRnR2RWa1lPUDQydlM5UUxDUUF5Yytu?=
 =?utf-8?B?YU92THJTRFIvclVtNFg1cGVwczlkRkN6bXFaRGZTOUJWdjA4bEI0OVJLalpJ?=
 =?utf-8?B?WWFRaGNhSzFmK2l6OUVGZTQ4OVRvQjZGRy9CbnpLZkVoK3JFOHgwalE3U3dF?=
 =?utf-8?B?TnFkZjlJNUwvVVVEK09hNGFjTDM4VEQ3SlVGNUVwejNLa1YwTmpuZnhoVCt2?=
 =?utf-8?B?UjJYRy9FL09OQldPRkIvajFnRmN6aGpaQW15cWRsaGZseDVOMDdodk5Lam5F?=
 =?utf-8?B?MmxwdVJFd1RyM29Nc1IxdWpwZGhYRVhTZnZKUFMzbzB1WlRyZ3ZpYnNGVy8w?=
 =?utf-8?B?MzRRSmE4K0ZnYzFDd1UxR3RINUp6MmhmeHQwQUdzUGV2Ukp2bVlVV0hkb1M2?=
 =?utf-8?B?WmJHVUNyQ0FicXlZVkZVdVloTW1DMVBYZ1hDRmxIbDdEQ2ZrOFlNQVdzOXNu?=
 =?utf-8?B?eVhqUmJicHhXR0E3N0Frd3dvN2lMSDJMakQrSTBYdC9jNGVoREh3Z0tlazNW?=
 =?utf-8?B?Wkl1UVhnY1JmcXFYblZQYStENFJHejk3ZDJta0xseExrSUtlQVdncVhNSWd4?=
 =?utf-8?B?TGJPKy9OZG40ZnJGT1BwcU5OVHNDWW1iLzY0UTFDQU4vdWRXZWZmbks4bzJT?=
 =?utf-8?Q?c7OHoPHZi0?=
X-MS-Exchange-AntiSpam-MessageData-1: iWYxNYE1tZUW4Yw1Fjtyok+s56osKl7k2Jon6VhV4n0fwKvmGqlrFd+7iGf7XTgK1eEyjjCr5WP+RzHdXfFW3G6zNvsHTwVxOtfHhk+E5fR3rSP3FIs30o1h7F9/IK5lFjLODKToUNnYQIuOp8jrf2K9TW4EU593QyUiYHTxj5pN1V/MxMVsUUEBfS1YsHjoXm68W93waqd2CbmcopHGj7vBFs10iBECReWriXPGG/WwTu8APqsAdD2kw6JsVWJgjLS1XlDJqhOjIYREj3tL7b0Q84Zirr+7AtQiy1EGUFHJVIy7bY6GdIJtPWWQcTODEJXS5vKobCqlsl9dNyrmyzw7
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b6510ae6-d168-4d68-4be2-08d92405af5f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 07:28:28.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTJMVY1s6OG49Suji329lK9B1uT8novbXqRKiV7/SPP/xD3ewFRpd0C+PHsZRgKz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5241
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2021-05-30 02:59, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, the measurement of a temperature through
> a current sense amplifier (such as an AD590) and a sense resistor.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-sense-current.yaml    | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
> new file mode 100644
> index 000000000000..1bac74486102
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-current.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Temperature Sense Current
> +
> +maintainers:
> +  - Liam Beguin <lvb@xiphos.com>
> +
> +description: |
> +  When an io-channel measures the output voltage for a temperature current
> +  sense amplifier such as the AD950, the interesting measurement is almost
> +  always the corresponding temperature, not the voltage output.
> +  This binding describes such a circuit.
> +
> +properties:
> +  compatible:
> +    const: temperature-sense-current
> +
> +  io-channels:
> +    maxItems: 1
> +    description: |
> +      Channel node of a voltage io-channel.
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  sense-resistor-ohms:
> +    description: The sense resistance.
> +
> +  alpha-micro-amps-per-degree:
> +    description: |
> +      Linear output current gain of the temperature IC.
> +
> +  use-kelvin-scale:
> +    type: boolean
> +    description: |
> +      Boolean indicating if alpha uses Kelvin degrees instead of Celsius.

It's "kelvin", not "Kelvin degrees", and it's "degrees Celsius".

But what exactly is this property for? We always want degrees Celsius, don't we,
and any offset can be handled...with an offset. No?

Cheers,
Peter

> +
> +additionalProperties: false
> +required:
> +  - compatible
> +  - io-channels
> +  - sense-resistor-ohms
> +  - alpha-micro-amps-per-degree
> +
> +examples:
> +  - |
> +    ad590: iio-rescale0 {
> +        compatible = "temperature-sense-current";
> +        #io-channel-cells = <1>;
> +        io-channels = <&temp_adc 2>;
> +
> +        sense-resistor-ohms = <8060>;
> +        use-kelvin-scale;
> +        alpha-micro-amps-per-degree = <1>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7279af85adb..0eb7fcd94b66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c
> 

-- 
Peter Rosin
+46 730 746 224
Axentia Technologies AB
