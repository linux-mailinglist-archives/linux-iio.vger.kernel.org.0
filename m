Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450363A3D52
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFKHjk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 03:39:40 -0400
Received: from mail-eopbgr70137.outbound.protection.outlook.com ([40.107.7.137]:19939
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231380AbhFKHjh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 03:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmyjJAAfwPw6ES9hSq6cnAhhYRa/L9bAbIsMGX4e5DzhK+Rc7l+lnf24/for6DK0C/SOBytlKzuEjEZFNKK788WDP4u7imhpHv4AGCY+jTAZQeLK/dy3fB6mo8ihkoY3fFyeiolAqK39j+04h1A8qN+g1WAMAEGAKHwxisSs5foZi8XXAaSFceZD+Lx4Gve3MG9T7uGWqbIoPnZfdlmzExYlLxTxmusSU0GCgxvDSFvG7uvvs3qtWwjBJ5RNAhKZ6aQnNg9sxHBsMV4phMkpGodwySQnhyv4aqIL5ltobe4OnxSZ5p+k+eoT3mKPIu62frBZXAam2Q+fkdMxkACiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9i4lfsyBVcgl4wTUGZaPjclZj9SgM8drWrCL0UfnfM=;
 b=Am8W/6DO5s0WXzhENopl1rlicDGvHtvA33vDU/bsbZD5rsSjqbQhMw3biNMODk79GTbJRV055AfQNG8DHoSjQuvxjJ07tfhxmVSPQiOTM4QxlqwAmnexj52mfyR7KLOI4Wy1hdBWJWvjoMGRam2Zy2XeZvuevPy7iey0J2KJ4fBaUPNkFIZJRS7OUH+SFFlwAc3ZNdP9ISalkEJ3Xso98V4OescaISA3VqwAiquMitUM7w7vTThW66L3Kx8/9luaYJnbcpEJ4RJfoSnEcslcReRyuv17iPE+hk66flOXr7asGvVxHZHODL7h7Gx/CDhY2lHozliuyYVXc8emmbVIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9i4lfsyBVcgl4wTUGZaPjclZj9SgM8drWrCL0UfnfM=;
 b=m007ok2JbBWD4AfZC1ssOPZ6uzfjg8iUv5FlTgFpubiiDdj74x6pItarD06cORpeEypZP7Px2vULsl9ebDO+mR3232IBquYUX+pkGWwOZirer5esYdPC47B8YLZm+yxeH4c6GQy6m2WOlQmFY7TJHfF4V8L8yMrPloKWA50sCiQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2295.eurprd02.prod.outlook.com (2603:10a6:4:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 07:37:36 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4219.022; Fri, 11 Jun 2021
 07:37:36 +0000
Subject: Re: [PATCH v2 8/8] dt-bindings: iio: afe: add binding for
 temperature-sense-amplifier
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210607144718.1724413-1-liambeguin@gmail.com>
 <20210607144718.1724413-9-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <6973b6b1-eb49-24f5-d9fb-053cb4744196@axentia.se>
Date:   Fri, 11 Jun 2021 09:37:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210607144718.1724413-9-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1P189CA0012.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::25)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1P189CA0012.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:37:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92a36c76-e19b-4b08-7a57-08d92cabc828
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2295:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2295ABC8998F23DFA4CF86E1BC349@DB6PR0201MB2295.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8iyyuzrRX51GRs7JY0iSVe79qqVc+wEXq5d9Ip3birxbUb2xZuvzAeVhgOCAqYOkT1+NoH2o+jY4wlW0I2yvoDKN2bP5F06hXAKaZxLyYTR1iqcKDC+i8sAX24wlVkzYTw7bE09N9yPSYoO5h53i/WvelfkPNprd3ZFBYGRFybFBijaSvMqgyVirfwjycmWLwVknlBYSCLb3m3ZWJj/Z8/Z9KZaO3DSdsEYVowRqmpesM9UFF9R5PoYn2FT8NR0HWKx58NfP0FRGw1KkFGgDlUA07oCui83gscwXp6f6tH8b1M5W/IbR6zQ1bMWiIb3SAFKNibeo9eU0j2zvpMueAb1hbOO93+2KlWrhYpspvEr56RFErI3axlbgCe0ZUv3dEhTdnLOmCyxaXlanW+yUTaWYd6qYpGFLb4Hi7zaJplEvQNa3K6HmszcQ7E4LCCIhGDKvmlqwmJLudgKxN377vavkBqWMIXuOBaffYyOlv0fQ4JnKJ5WWJFGVHDWaT2fO310cnxabAelNUhDIgqb70oE1SYeqzhpr+opb0C0P4yqaQfTfhWcQu1AsSx/faYnRp16dZph9MVpq65Q+zjpOau4UOv6WGZQYNsbjd2oETSSquwxI0MRz1C+5NbTOxoDdrbOo1TS6ZAuGoZm7r1HZdgblaKCE5z/vjflTLgPdnvnsJSTQ0NBcifCcZNpwb6xCvWsO38M2Izw9dWAcSW3rU65nvkQtiWKfRSSHyjDAcUfI3LTILMn1Hop63y5VC6cTh5wusoD0b2RfvQ/IFMwyAXJFKh6iQT5AFcBHIA9kYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39830400003)(8936002)(83380400001)(31686004)(86362001)(2616005)(5660300002)(6666004)(6486002)(16576012)(66476007)(26005)(2906002)(966005)(956004)(53546011)(8676002)(31696002)(36756003)(38100700002)(36916002)(316002)(478600001)(66946007)(4326008)(186003)(66556008)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkIweTg5VGN0Uno0elpjTFNqLzZLc2lJM1VNb0JGcHBGbkpxZG9xK3lMOU0w?=
 =?utf-8?B?bFhpNFFmK2ZzR2lGRHRyTFNtU3ZVNXRFSU9sR3ppSjhJQTBNYmp2bHpNWUJO?=
 =?utf-8?B?MFFqNDlWc3dNMzVYUVdZRnpLVkpaS2F3eTVnWmJWNGo2aHJlS3RBYmZMS1gw?=
 =?utf-8?B?Y0tjOXhRNDBQWEpldzZhbVBNK3N0dFZZeFlEb1pWR0NkeE5zVC9tTGp5YWVB?=
 =?utf-8?B?VElRa3N1THJ5QlNtK05NNER0UXIxR1hEVWR5RWZOQ01ibGsyQ0M2RnNDVE5J?=
 =?utf-8?B?RnIzeG5JTW1MakNXN0ppTlJtZFBabEdNdkVRUi9ieFJKRUVmTlF2NmFjc2xN?=
 =?utf-8?B?QVdRWEhNbmFNdytOSmxGa3Z2UnBLN2RHUUpqdkNkbGFxM0g3b2RQS1J4ZWZI?=
 =?utf-8?B?NU0wWmF1WldnaDJIR2FKMzRWbzFnVm1iakxEcjUwaE1Sck1iVWkyL1cyQ21D?=
 =?utf-8?B?Sk1OSTJNME85N1ZNSCs2K1UrNXpkd2grUDZwNk5vcGJ5ZzRDVHRScm90SThV?=
 =?utf-8?B?TWs2NFhkNVk5cEV4MDdRN0Z6dTdQQW9JbVdFL1h6cXZQSzVyWUxZbXErQURq?=
 =?utf-8?B?Y1pBb2hrWjlNUStjL3NGTHBzMy8xdlJaZVZROW5FTlNtTW02RVNPTS9rUVhH?=
 =?utf-8?B?WndQUXp4dmdiYWZRQVFPWGlwRlVxVmxFTFFjMzFRUG9oY2JwVytTcHhNT2tM?=
 =?utf-8?B?VnBGQ1dNV0NaRmEvd1pvVkcrUHhnbkJ2cWl5VjFWTzAvUlV1NGFCMWZ1NzRv?=
 =?utf-8?B?Umdpd2RybGdGcnowbEFkTzdDUWgzSGFqcWEwUVo3WWNhZnhMZkFDZGRLaURZ?=
 =?utf-8?B?STZpSTdmWm9zbmU0TFd2c3RsREhGOGRYVXB5ZDRpMEpuSVh1b2dsOXdnMlVV?=
 =?utf-8?B?RDlIY0l5d1Bkd2tNMkhDWStWNXF2aHFJZzlGbkZVeTJHY3Axd3c2MjIvMmFp?=
 =?utf-8?B?VmVRcFBZOFZDVGVPZ3VveHFBYTZtN2EyMkFvM2ZndzcrYngzaEkwYUtzSVlD?=
 =?utf-8?B?QjRSTWxkblpmVGhJNWQwbTlXZEl0SkZsZTdiekJWSUpVZW5XK1oycFpVaDhQ?=
 =?utf-8?B?U3I1cjBCN2tvU2xyWFphLzdOa2pFOGpxclkwanVkcG81ZVFOcXdNSmtJczRs?=
 =?utf-8?B?eStXelF1aEVQMG9UMDUyS1AzekVFOE1PTzZleWhXVTVyTUFiWXlvSXMybEhJ?=
 =?utf-8?B?TnNsVXcvTmg2Zy9JVzBaT1dwU3lYL3loTHBhSjZLK09lR2tFNUtySmxNZFZq?=
 =?utf-8?B?THNkVHYwMXB4N1ladlBrYm1kK29NMkJBZWZFOWRMQU9HQ0hNcW1SN3d0YkJF?=
 =?utf-8?B?NHdVbVBkdzlJdVRNWDBUaFZ2WkhFSmwzMnUrMEdVTUIwQ0JENlZ3M0o5Tkl4?=
 =?utf-8?B?OFd1YWZ2eU93OW9SZkxUOWVndlVHVUU2S2lyNGFQeExXUWpDQ1B0OHpIdlBY?=
 =?utf-8?B?ei9ubnd4eGtzMXBpZjQ5UllIR2dZMytLSHU1dktGM3ZhazFqcmJGZmZZZzNk?=
 =?utf-8?B?RFhib1pjZ3oxYnN3b2MrTGhQR0EzekNTSHE2U29CRjFuZTNjUkJEOE40aTFh?=
 =?utf-8?B?L1BWVHd6UmZ3N3ZpajA0N05kMjVEd2FTOTFMVVByclcxMXlVY2pweUNxa3Q0?=
 =?utf-8?B?YVBNTHpzNzQ3TlNXMmZ0UVNkUWNMdUJ6cXRDWWYrNWpvVWFmRlVkaGRaWVpD?=
 =?utf-8?B?VmNOb1FZWDRYbHJrVG1YdFh6Q1pkWXF0RzR0ZmphRjRQVlZZVUdQY09objlE?=
 =?utf-8?Q?djgAJm1/WXnyzGO8fDMJtAweRkEdkqnDGJrpHBg?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a36c76-e19b-4b08-7a57-08d92cabc828
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:37:36.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9QWc6eI5Q5T/D6n+hVSjvbFvY2UlNcZFoHUrgrlOXVbkJohilGqWDPrpxOIDVo8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2295
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Should "amplifier" really be part of the name for this binding when it's now
just a generic voltage-to-temperature rescale binding? Or, perhaps a better
description is THE generic voltage-to-temperature rescale binding?

But that's not a strong opinion, I know next to nothing about these things
and it might be that an amplifier is involved in the vast majority of cases?
Maybe it's enough to be more explicit in the describing text that the binding
is intended for analog front ends lacking an amplifier as well? I just find
it a bit confusing since there are actual HW that calls itself "temperature
sence amplifiers" that I think this binding targets but then isn't
exemplified anywhere.

Also, it disturbs my sense of symmetry if volt->temp gets a generic
binding like this, when volt->current and volt->volt have bindings for
specific front ends. Again, it's not a strong opinion, I'm just pointing it
out. For the record, I started out with a generic volt->current binding
similar to this volt->temp binding, but got push-back so that we now have
two specific volt->current bindings. Again, I'm just pointing this out, and
I'm perfectly aware that "rules" and opinions change over time.

On 2021-06-07 16:47, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe such a use case, the measurement of a temperature
> through an analog front end connected to a voltage channel.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-sense-amplifier.yaml  | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
> new file mode 100644
> index 000000000000..08f97f052a91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-amplifier.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Temperature Sense Amplifier
> +
> +maintainers:
> +  - Liam Beguin <lvb@xiphos.com>

Here, you claim maintainership...

> +
> +description: |
> +  When an io-channel measures the output voltage of a temperature analog front
> +  end such as an RTD (resistance thermometer) or a temperature to current
> +  sensor, the interesting measurement is almost always the corresponding
> +  temperature, not the voltage output. This binding describes such a circuit.

Why would you convert from a voltage if you have a "temperature to current
sensor"? Such a sensor should give you a current. Yeah yeah, I get it, you
bake some resistance into the "gain" and you are done. But I think these
things should be explicitly mentioned with examples. I think it would be a
lot less terse if you spell out a couple of common ways to connect one of
these linear temperature sensors and how that then maps to the gain that the
consumer of the binding needs to use.

It would also be a good thing to mention sensors by name, so that someone
grepping for them finds this binding. It's a djungle out there.

> +
> +properties:
> +  compatible:
> +    const: temperature-sense-amplifier
> +
> +  io-channels:
> +    maxItems: 1
> +    description: |
> +      Channel node of a voltage io-channel.
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  sense-gain-mult:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Amplifier gain multiplier. The default is <1>.
> +
> +  sense-gain-div:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Amplifier gain divider. The default is <1>.
> +
> +  sense-offset-millicelsius:
> +    description: Amplifier offset. The default is <0>.
> +
> +additionalProperties: false
> +required:
> +  - compatible
> +  - io-channels
> +
> +examples:
> +  - |
> +    pt1000_1: temperature-sensor {
> +        compatible = "temperature-sense-amplifier";
> +        #io-channel-cells = <1>;
> +        io-channels = <&temp_adc 3>;
> +
> +        sense-gain-mult = <1000000>;
> +        sense-gain-div = <3908>;
> +        sense-offset-millicelsius = <(-255885)>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e679d422b472..4f7b4ee9f19b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8887,6 +8887,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml

...and here, you give maintenance to me. I didn't want all afe bindings so I
didn't put an asterisk there for a reason :-)
This binding is backed by the iio-rescale driver, so it's not totally alien
for me to maintain it, but I'd be more happy if you listed yourself as I think
you intended to?

Cheers,
Peter

>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c
>  
> 
