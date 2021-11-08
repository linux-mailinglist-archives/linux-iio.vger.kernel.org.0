Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48751449BEF
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 19:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhKHSsd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 13:48:33 -0500
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:31149
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235369AbhKHSsd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Nov 2021 13:48:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUYPyfqi5cF+Kq2TuIsXfOmAfX6uIDcZvdpSzVtgAMM25HbPdq6nGXC/beMB4Q2Q56GqeD11gV2MEGlGc0oCW16lorucU6m2I9vKHdf6g2ekM1l7GQb3gf/aB/eDNrKQ3KXkvoKxpVykWD7TjJT26n+LFJQ+aNHoRFF5ky77Tjdyq949oSCwtKsCaOEFYmd/RwflQ5INc5hg4/hURSW+EGnSBWYy/i0CilF/vLA/Np0PkLPz9yX3SANq4PceZpiXjnqiZjilI6E+O6ivI7tWs5Efpf7CpSmIK+d5C3oFTwUkMhis95UIAAWvTn1BICD5fzQCnY/DMrtrjBkLJFOwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfZye89NvR4DVDKag8jpiojojIUa/kQcNH5YN4TdPgQ=;
 b=CybpKBr/Npwo0fP0EwCTuqenyITYzdYhzURghk4TbMZTyfQbCr4DtiD4I68izvz3OppRmXMlsiI0gqAFZ4HDLhwxMyJDVuNIrdBj1bp/FH5dNZUArmSt+GM7J918aL3Z5nGxkcI/PCCFQah576CzL1H5h+PrEtxBU3gxP+OhT/spyJOec/NtAzXw9gO24qTbNiJqJMdKpBCRy6a/gLyprbm7OOxp8MvMbIdUYgqA8pUVP9MsCU4fPFsU+SR7sO28qjMuSx9DeUls+JYPayizZB8VvS/ZvYWjAa9O7avpR1FgSud6+BfQ2ASBq6INUAg/8WoLHYYEARK/lDvfxriAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfZye89NvR4DVDKag8jpiojojIUa/kQcNH5YN4TdPgQ=;
 b=pzvwwFYdFY+12q7/xjVgb9zPZEkR35l48/t508x7b0wO6Sb8k0Eu9NuHlNxnrIjhfaLjeJSdM2xvQjRphjdSgY3s3K/oe18OhEzLPJCpl+iUfIYLZ2tpDf3Y1W2AbNlT2WdiHyL4yxtfmbpYJxi2YB7dTUuVw8o3SvAYZn3Nvvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5145.eurprd04.prod.outlook.com (2603:10a6:10:15::18)
 by DB6PR0402MB2773.eurprd04.prod.outlook.com (2603:10a6:4:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 18:45:46 +0000
Received: from DB7PR04MB5145.eurprd04.prod.outlook.com
 ([fe80::58f2:ea93:c6c3:4e63]) by DB7PR04MB5145.eurprd04.prod.outlook.com
 ([fe80::58f2:ea93:c6c3:4e63%4]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 18:45:46 +0000
Subject: Re: [PATCH 1/2] add binding for iio adc driver for TI ADS1018
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211108184327.439460-1-drhunter95@gmail.com>
From:   Daniel Baluta <daniel.baluta@nxp.com>
Message-ID: <08278938-2a19-efc8-b111-73aa9ab2c28d@nxp.com>
Date:   Mon, 8 Nov 2021 20:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20211108184327.439460-1-drhunter95@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: VI1P193CA0009.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::19) To DB7PR04MB5145.eurprd04.prod.outlook.com
 (2603:10a6:10:15::18)
MIME-Version: 1.0
Received: from [IPv6:2a02:2f08:570c:ca00:c0fa:6a41:b933:e441] (2a02:2f08:570c:ca00:c0fa:6a41:b933:e441) by VI1P193CA0009.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:bd::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Mon, 8 Nov 2021 18:45:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2736f1c-61d4-4136-b5f2-08d9a2e7f9bb
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2773:
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27732B1D3AC68C491C5FEAD5F9919@DB6PR0402MB2773.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtBlZSMAxk6WIBDVJdR0z4/LViWQJVdH8Yx5Av73vACvc6TVn4zRwbglZKkrs/ZWdgsKB6L97UAZiOqWmVDmChCXZAkbEu/RHYVTx1mlOsk2sHEIpxG+DA3nVt9JdhEfAv6T7GRzHz2su8je7oA9y6cDg/6rakR7BGE+96S4N0Op6r5VSDPfBawKSWIDoq6Lx4DV3RCDTydMh0IOOS1n7sKAW1IDgG38/65F6MRoHrHULimoAa3W3x7fhKLKwVSbr6rVdKoR394LVQ5u40yWUSY99kqcCjFoq9Tah+8HVSmYMN6RVs0z6ng7DYDmT9zj9w9uZk7ntDoGlI0UafQJl83oj7mUTSl7K/BLkg017OlaYLud2mmiWfs9TBVYsVOd2N6N9SEbwox92yVbLl1OXRDEX4vEdmFYWXfuEu2LRCbBKEmJEqBJhZAJM8JJGu4NHfGw/PWWYiu5KcIjqOVALMvj/B2kRdYnnGQxyC+AlatVIbJaNDVE0eSN3J4ow5BKYQ9QRWc6wxIgjv9HnpgqQT2AgIcqMn23f0yaGvFykUJlP4ssFjofz/c8TL9Mpo/uDgm4YOMhwbvuPglAicteC2DLEgSRNHDOED93jSXMJlYILl/+nsrzRrex46Q3ngFr6N7yKU65ZLvZhNrxnQFYy2wV1n6K65g7z4dmLMxAX1XsJR4i1dX5ZSgy9G9MuSzUAw1Zf7csv75HNfggSSqe54QkeJJu7c/U5+yqoAAEUqrhpIGhEwmoyiQpnTp29PmXy8ztrEsn7t7T72fKMayk4svDuofOLAuQwaQYebUzu8fXcuVX25h3TPVmrqOWom6sgftfD6KHjU2mKXbAXjOul6Za53KXx4kN6lhkyseYVoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5145.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(52116002)(86362001)(508600001)(966005)(36756003)(5660300002)(316002)(186003)(54906003)(4326008)(2616005)(66476007)(6486002)(8936002)(44832011)(66556008)(53546011)(38100700002)(8676002)(31686004)(66946007)(31696002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0gvRzAva094SSswVisxNlNQbkpHV3kvcThIT1RZUFdYR1BpaHJBWE9YTHBI?=
 =?utf-8?B?TGNpN2V1K2VVRlFuQlhhYk9WS1VZNWxnNzhIVWo4Y2JEbjhtQjJCak00dTRR?=
 =?utf-8?B?VGJQVklkejRTTkY5VWJIV2FxUHRyUEljaEdMNnJ3eFBhZ1R5UGFmbHV4TFVM?=
 =?utf-8?B?MzVIempuSzkxRkg4WXFTQ3NaK09ydG16VkdPYUV0NHBEOWZqOUZ3Sno5ZWNQ?=
 =?utf-8?B?UnF3aWExWUJicm5KdmxDVjhCcHB6UHcyclJLRjB1VHpNSnpoQWNuUlZPN21o?=
 =?utf-8?B?cmJBc2NBWHh0Vmhqd2M0cjVrYlVXK3p4ZXdUVWlVNkFWV3hTQXEyQTZvNElP?=
 =?utf-8?B?d1ZwWkgvdlpmK0ZlbVlzZjVSVzNxZW1HRnJtZ0JScHJaMm9vN1Y3NHNFcFIx?=
 =?utf-8?B?NzF0OFh0dDJrVllBVkpGTm5vMmYvcVlMdTVudUxPQjMzL1hjbDRVVFRRZWh6?=
 =?utf-8?B?K0Izd3ZaQjlISWoxVG5BMzJjVnE5ZW9NY2xqT0Z6M1Z0UVh1eG9sNTZ5aUhS?=
 =?utf-8?B?STNUNkRIdnB4YVcyUVNod3RVRXpvNnY1b01QWjVRS0JUcEoyc0oxZkdNcnI5?=
 =?utf-8?B?RjBsMHZCUG9vcjl4TnIxWmVxWVJMNzNJM1A1ZU1NNEsyWXZra1VWcXMwVU1i?=
 =?utf-8?B?MTA1ZVpsNDZOZDdSSnVsK2Z4Y004L1ozZWgxb2V0Qy9CQUFQSGhNYjBnZUhZ?=
 =?utf-8?B?RUlyNWwxRDIyTVZBK0haYkpBbVl4WWluUmRiazArK2w1ZU5pQWpaQjJyWjRs?=
 =?utf-8?B?dlQ0RGJ5WFNzT1RqcDErKzBoZi95Q3NPVGlrYkxWZXJIOGJBYklvbkhyT0hh?=
 =?utf-8?B?QWZpZUZITmx0MXViMXdWVDhpTVlJNFpjSmgyT2p4VkJiVlUyem9UOEgxVnlM?=
 =?utf-8?B?aVpaaFpxb0VKc2ZJZG5nWVFtaWsxcklPeVM3dEhXYkI0QjQ1cEYxQ0pKLzZF?=
 =?utf-8?B?WUxzek80UVJ0UTFPVzE4YVRDaFpYWVQ0SnhnTFRqQ1Z3dDQ1OGZ3c3A0UHRJ?=
 =?utf-8?B?TFRwWFl4Vy92SkZxb3ZYeE1RTUJFZTc2SnJZZU5qUVhxaU5ObnNML2hhTHRR?=
 =?utf-8?B?c1ZtVWtaTkl1VWFmK2VaK0dOMEFXUFVJNGFaaHdvMEp2VTBrUHlGYysxczdw?=
 =?utf-8?B?ejhFcWI3UWI1aWFORnZvZ21GNUFPUkRCc3dhR2gvUzhzc256NzBkVm0xRS90?=
 =?utf-8?B?MkJyUGJtanl0QzRyYU1zWTJrM09hajBCRmtwWTFDNmU4Ry9idXhqYmFuWCs2?=
 =?utf-8?B?cTFWMjNCYTdTR0xVN1VQb0ZVQVZtY0VvUDA1Y3hyRUJEempZZUtZaXdCT0xN?=
 =?utf-8?B?dW9CWlJSaGNWTEptanVVQXpLdXFjQ243VG1wV0R2Z25jVHhOUlIzSHZ3UzRB?=
 =?utf-8?B?MTZRTW53d2JWMFBDM2ZYNzFmNmJXN3hXQ1p3bVNrdXhwWW03ZmdPQzdQOVJX?=
 =?utf-8?B?NU82b29mN0lIbnJMeFlhSDBHYVJvT3RRYmhDc3N6ZVhSTGF2eXpEYVdFNjhR?=
 =?utf-8?B?eW16eFpXS09yV2hjUzQ4OStWVE0wWDZqSWVXQUNWR3YwdXBhMUgzYU4yNDJR?=
 =?utf-8?B?QVJvVUZ0eG8wWEJwZVY4Q0hHVTVEYUc0MWRjSitsSGxOOHRWRHpqUVVkZ2sz?=
 =?utf-8?B?OFFyYTlaZUh2TmdvSzF6akJVMFBDcVhCakk5L2o5YmNqekxtODNxZFFYMVky?=
 =?utf-8?B?bjRJdGYvRytCV0Z3MDY2cUpDeTFST001UDRseUZ2NDYwZS9yY3lrVERidGRI?=
 =?utf-8?B?b3pCejkzem9DUVFoZng3dVI5cVE0S0tOVHNMV2FycFdpTUFpM2JJaHFIUHNl?=
 =?utf-8?B?dWoyOERtb1I1THJJV1dPc2dNK2hvd0ZoMFBXMUxqc2srcTVPbjMreFc3RTFn?=
 =?utf-8?B?WDg0SThVcWtPYmowTnJ4Nms1bzkzNkd2VnV0NmlqTElpcGJZYjFObURrV2dX?=
 =?utf-8?B?cy9ybHZNMGdxTlZ0SDJMQ21pQWpvTTZiNzIrMzRSUHVPV1VVZU1VZzlNaFZS?=
 =?utf-8?B?MFNtekpEOCtLWXZKSXFYM05qUWVtY2JRckx6YmZwOWZtTThpbWE4Z05lRTBr?=
 =?utf-8?B?ckEwMTRFYWhSSklnWktjNGpyV1FwUTQxQXJrNW9lUkRSdGQybVUxVWdsNWFC?=
 =?utf-8?B?V3A4cmIwWFptbFdFRVd4eVB2eXEwbmh0M3kvR0JBRUFkdC8zMkpZc0NQMGE5?=
 =?utf-8?B?WmVZa2ovRVc4enB5VHN2VUwyQzIySURzQTA1NHA5bk9UVVRGWE5PWVVPb0Vw?=
 =?utf-8?Q?Cy1O0FCuwIyyCIwvsVDJ+eX1RoZhkr+KUPrqdTvbHw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2736f1c-61d4-4136-b5f2-08d9a2e7f9bb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5145.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 18:45:46.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/555eKHOJ3LGAToH7T1WG7bIjXzFuMq4BrK7Itgqb/W/OxC06HMolz4ISBTnJp26qQ+p1w+ZBE99HwmmCRIbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2773
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This looks good to me with the only mention that I don't actually have 
time to maintain this :(.

Perhaps you can add yourself?

On 11/8/21 8:43 PM, Iain Hunter wrote:
> Add a new binding for new IIO ADS1018 driver.
>
> Signed-off-by: Iain Hunter <drhunter95@gmail.com>
> ---
>   .../bindings/iio/adc/ti,ads1018.yaml          | 109 ++++++++++++++++++
>   1 file changed, 109 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> new file mode 100644
> index 000000000000..ba0fdfba2c45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS1018 4 channel SPI analog to digital converter
> +
> +maintainers:
> +  - Daniel Baluta <daniel.baluta@nxp.com>
> +
> +description: |
> +  Datasheet at: https://www.ti.com/lit/gpn/ads1018
> +  Supports both single ended and differential channels.
> +
> +properties:
> +  compatible:
> +    const: ti,ads1018
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^channel@[0-7]+$":
> +    type: object
> +    description:
> +      Child nodes needed for each channel that the platform uses.
> +
> +    properties:
> +      reg:
> +        description: |
> +          0: Voltage over AIN0 and AIN1.
> +          1: Voltage over AIN0 and AIN3.
> +          2: Voltage over AIN1 and AIN3.
> +          3: Voltage over AIN2 and AIN3.
> +          4: Voltage over AIN0 and GND.
> +          5: Voltage over AIN1 and GND.
> +          6: Voltage over AIN2 and GND.
> +          7: Voltage over AIN3 and GND.
> +        items:
> +          - minimum: 0
> +            maximum: 7
> +
> +      ti,gain:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 5
> +        description: |
> +          pga is the programmable gain amplifier (values are full scale)
> +          0: +/- 6.144 V
> +          1: +/- 4.096 V
> +          2: +/- 2.048 V (default)
> +          3: +/- 1.024 V
> +          4: +/- 0.512 V
> +          5: +/- 0.256 V
> +
> +      ti,datarate:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 6
> +        description: |
> +          Data acquisition rate in samples per second
> +          0: 128
> +          1: 250
> +          2: 490
> +          3: 920
> +          4: 1600 (default)
> +          5: 2400
> +          6: 3300
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@1 {
> +            compatible = "ti,ads1018";
> +            reg = <0x1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@4 {
> +              reg = <4>;
> +              ti,gain = <3>;
> +              ti,datarate = <5>;
> +            };
> +        };
> +    };
> +...
