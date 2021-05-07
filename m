Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD43A376CE8
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 00:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEGWqE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 18:46:04 -0400
Received: from mail-eopbgr60100.outbound.protection.outlook.com ([40.107.6.100]:24645
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229470AbhEGWqE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 May 2021 18:46:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgBxQkv4jKnpWonP2Gv5T5MiPfi7dpQeqDFUvjenedUtYz7dFLhpoBf7uxT1EPupNatpQ5ACo656zON3/zcT6k5GFH22NccFjGInq98uiPo+azXeZMo8AJqIct2j7vi6shxs6jort89DF5AxCYvuPgBDCAjpGgdllyHqoZmOuOdFzRVX0M29TrQV74OvobkMn2Ep4+EwIE+5UJ3+PvInMUZM6gOilVDddAUzf8AqLVvhfhVzQBzPPT8Z0pd0Tlfi6o1v0paHulixLizvp2pTx21ZJAjsZkPiTVb9BJw7ClBZiQnBBPT+LVltDieD4m2SWEzs094E4gI0RtgrRQJXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKqY0UwB97/aLXfsGstGKgVq40yDemKiIxvAgsYgEuk=;
 b=kZO1X8cJNLZipwXfAwMpYaIR0vkV9HKJsJlk2ff+iKHAw+2ME0JK0dbTa1hB9xl7uSnv4iRBlPSmMu8kaLt5eN+2RgPKWzh8Sm1Ur8oWXU5J9QFh+In2ub6XO64Oga0T9YO0x9gmqnhyd/q6VIbNT6Ld+Gzn5ajVPbb7QDCv82xQFn+M73KxDlvosNh1EmDCcrp1IUaPnDQSRZJSuUDxQhNnxaZfAu8fpj1D9CGLr/7M6wlo8lzd8pQkNL7L5U4nmHSZqgWmIN5eYbQmNG+YlCbVNPryxJJBxDrgQ6dtZqCHAUzBNjSZsPZZdhPeXeVIEcvBbt3Jp3Sr8PAOrOFf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKqY0UwB97/aLXfsGstGKgVq40yDemKiIxvAgsYgEuk=;
 b=kuZbS7y5ahg/ir9u5KB884vj0to7CBMNHlf2F7j/tlIQkSAX8h1CPrnNbU6ssUOFoU9kbay+iubyORC7i8esUrWwNX4iFXTMxf95jNmXUqsfRqRNPJKxYnN460sC2UP0cWIWJfntobNVhMLrFyBwub6QNmo9GltjqNQXvcmgmQw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com (2603:10a6:803:115::17)
 by VI1PR02MB4269.eurprd02.prod.outlook.com (2603:10a6:803:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 22:45:01 +0000
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::10c7:71b5:b4ac:e4f2]) by VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::10c7:71b5:b4ac:e4f2%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 22:45:01 +0000
Subject: Re: [PATCH] dt-bindings: iio: afe: current-sense-shunt: add
 io-channel-cells
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210506150637.35288-1-krzysztof.kozlowski@canonical.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0e68ca18-7d8c-12ab-59b1-56404b29be77@axentia.se>
Date:   Sat, 8 May 2021 00:44:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210506150637.35288-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0301CA0024.eurprd03.prod.outlook.com
 (2603:10a6:3:76::34) To VE1PR02MB5487.eurprd02.prod.outlook.com
 (2603:10a6:803:115::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0301CA0024.eurprd03.prod.outlook.com (2603:10a6:3:76::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 22:45:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aea846ef-1c19-42e7-0fe9-08d911a9bf5b
X-MS-TrafficTypeDiagnostic: VI1PR02MB4269:
X-Microsoft-Antispam-PRVS: <VI1PR02MB42691847F97EFE4DCDF4FAA5BC579@VI1PR02MB4269.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qculLFO88qN4A2MLWafDOZHH7HFlv0hVmE7VdpqyF6//fTY94/Pe3q8G937EWMn/2aa4JNoeEdF23Df8vZVf6uMfs6vXcndU68nYL4Lhh/wU6Zu/DJ1eKXxgYjkR/uI0CqVHT3aYaFE6tc1WhKYv0TJI01QuX6eK3hhrcAdNaDU87bKW97ZqAPs/qYoIVGgravnoW6Zzl9hbEo8ITdC5enxq+nMRz7gApkBe6skPSkZhTtsA1DWQgAP7fTJrrt3XLptTtYIh+RUBXK8zV4y4H+HBUwyKLWDLgO1G3kPE7khmP4WrMtyAHtiWSJ35Fjle0zyRlWkyhl8p1c86QNwoYUR8KYAmskt6aMGXicDqrlh5YDnX65cPwe1oCeNBHPZ6Hk9HEl5qzXuFXyoGrsrn+aE1TQIlxzQTicgwf9VqSL53Xum8RMauqEJ8+PUrtMajuKXfjocs1sJbxK7MlXuQNq7R2T7M69HEEuRt3fkPdzmMgkfBIyxfB12laeX352XTZmOWo0dG4qpjaSaz9FgU3aOXgAI6rfSllawy5mUgM8Upma21BZu6/lGZtyHlSOL3N4sizce9Osl1x/VJ8RVIDukh4L0z30BaIh3umc+JQu1QdXRERbylVcQDW+gaBmF7T0pnnYXWfxztiHKvbC+xcZ9+7RJYR3gFRHz6mwGVh0xZ/YBtA5bnB/7WwHzl8ISg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR02MB5487.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(39830400003)(136003)(2616005)(956004)(26005)(66946007)(53546011)(86362001)(31696002)(83380400001)(38100700002)(186003)(31686004)(316002)(36756003)(36916002)(16526019)(8676002)(16576012)(2906002)(110136005)(5660300002)(66476007)(8936002)(66556008)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE1tUjhKV3hrazllZ1lRcnpUeVJvM3lwM2VqYmpLVENyVEhFVVYvajEzMmt0?=
 =?utf-8?B?bzdBL2NwS0J5WCtCVUEyWldYYTRuUUV2SnZLR0svejh0TzdOK1RFZUdSMGUx?=
 =?utf-8?B?MG9mellvY1JlOGhPeUp3blZEa0Fsa2p0WjlsQUh5QjA3cktEaCt3bFI5cHVh?=
 =?utf-8?B?SHIvNTUybFlxT0dOSURzS2s4Y2ErRWh5eDg0MTl5RDNmKzh1eE5lSFRsL2Jr?=
 =?utf-8?B?QnUzZi9BbTdBUG9BSitMamdHcnVGbmpjUmhOWml1N2lxem9xaVJrMTlwQnZ3?=
 =?utf-8?B?VHhGdmdObEl6ajhmY05BK01TbkpKTGcvNFBqNGJzT1ZDamNTWmZZd2NCekZR?=
 =?utf-8?B?dVNLQzJtNHUxV0E0eDY2OVdPd1JrMkc3ZXZUTkxKZU5qMlZnTytQQUMvMUtU?=
 =?utf-8?B?VWkyemxXNm1sTFE4TDhXQSsxS24wejJYczkwTG5mNjRteUU5bXhIVS9scXhp?=
 =?utf-8?B?R2J1N1pBeldBL0RXcndwN0Q0NHFvMjdoSUhJSzdva0FKeVYxR25tZzdVKzRZ?=
 =?utf-8?B?WDR6bkkyZnFsSllIdEY0ckJHNk1Ra2UwemdOM0o1eXN4bU9kK1IrZnZLRndG?=
 =?utf-8?B?K2pvTFJtSm9zS08yTklNZnhDY2xZbG9FVFhGd3JxOGxoa1kyNTdHTVg3SUlu?=
 =?utf-8?B?ZU9nU3VCV0dJL0dlYm9ZRk1FbW1kak91Mml0ek5nSVhkQnFIelpXWndGbW8y?=
 =?utf-8?B?UU1WYzF6WC9BV3hSM09kYjhBakltWXdFVmVKZEpZK3VHVmRBRzdGRmlTWGww?=
 =?utf-8?B?dWwvajBsOUcrOWMwLzlCd2Ura1cydmdETlFhdUtPcjV3SGFTUHV2ek5HUVJp?=
 =?utf-8?B?SGVkZjRXZjlSVHhFU2wyc1NKdFoxSHpxN1p3U1E3bGtkTWNJeWZPM2RRNmg4?=
 =?utf-8?B?aFpscEZDN2tTSi8xMTdadlZ0RFBGdS8wTENwN1BCL3J5V3daa3JxTVFLOVJn?=
 =?utf-8?B?S1ovcVlhSG1vNDFnMnBMckJQUjlBaFBlUm1mZFEvei90YlRCeEgwTWdBMGVW?=
 =?utf-8?B?Z3pHTlhtU3Yyb2QyQ3FmN1I5K2FCc3RKWjRYUVEwc2MzQytDNjVESmkxejZi?=
 =?utf-8?B?YVR2KzN6YTRwNkNSR0o5ODBMNFVab1ZwaTJkWlN6ajBWdUFhQlRsT3cxbGZx?=
 =?utf-8?B?YTlpVzk2d0tySzZVUmZkbm04aG9DN1p5NGNYY0FWck1OTmhiTVdURGllTnJu?=
 =?utf-8?B?VWlMTVFCZ2xQd0R0aEVNWGZFeXE2bVU4NFozSmRtY2hEbHFUMUxHV0tjbjAv?=
 =?utf-8?B?empJalJNRFhtek00cHZMZFZJVmlNVXVmcG5GOC9yMm9vT3pOTzRJV1A1T1dj?=
 =?utf-8?B?ejlvdTcrZ3VRKzFEQmVtWU42Tzhhb01PY09CK09XNm9Rd2t6d3pLT1BPZFBm?=
 =?utf-8?B?NnJKUUxoZzNzT0M0NXE3eldlMENsN1VvTEtvNGJkd0U0OHNZVlpOSDlqaTB0?=
 =?utf-8?B?cVJxL2NuSFlib0g0NzlTSURMTjRvdzZqYTZjK3ZTMHRydnU3cS91QTdHWHdw?=
 =?utf-8?B?WlFQTmR6Tlg1SDNKejlEcjNUZHljakorYUFYVHowOHVWWVd2dVhtRklvQ0Ev?=
 =?utf-8?B?cFZKYzBocUs2V3dUM2dOQU1QUS8rMFpzN21nekhPNCs5SE05Sm0zZ05RdTZR?=
 =?utf-8?B?WTJjMVJ2a2ZRNGt1dVMrYnJrNEhtdDI2NVBtamIza0RtK2RxV2dMa3U0UjlL?=
 =?utf-8?B?amRNTDY2c05xZ0VaNnBad0xXNGpLRHBnNFJmMWxLM2NhU0Vwam5GZ2s0bG5Y?=
 =?utf-8?Q?bUrn497oKaHPS7HE/xjpQm3azIVr04s4qpv5Ula?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: aea846ef-1c19-42e7-0fe9-08d911a9bf5b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR02MB5487.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 22:45:00.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faOi5rdy6zEXGVw3yxzaSgnw/CYXN7DBhRT3LV6BuCtwbkZTYCqiaS9LNpb8xuPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4269
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2021-05-06 17:06, Krzysztof Kozlowski wrote:
> The current-sense-shunt is an IIO provider thus can be referenced by IIO
> consumers (via "io-channels" property in consumer device node).
> Such provider is required to describe number of cells used in phandle
> lookup with "io-channel-cells" property.  This also fixes dtbs_check
> warnings like:
> 
>   arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: current-sense-shunt:
>     '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: ce66e52b6c16 ("dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/iio/afe/current-sense-shunt.yaml     | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> index 90439a8dc785..05166d8a3124 100644
> --- a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> @@ -24,12 +24,16 @@ properties:
>      description: |
>        Channel node of a voltage io-channel.
>  
> +  "#io-channel-cells":
> +    const: 0
> +
>    shunt-resistor-micro-ohms:
>      description: The shunt resistance.
>  
>  required:
>    - compatible
>    - io-channels
> +  - "#io-channel-cells"
>    - shunt-resistor-micro-ohms

I know I'm listed as maintainer and all, but I have not kept up with the yaml
conversion. Sorry. So, given that I might very well fundamentally misunderstand
something, it does not sound correct that #io-channel-cells is now "required".
I regard it as optional, and only needed if some other in-kernel driver is
consuming the sensed current. What am I missing?

Also, whatever is done in this binding should preferably also be done in the
two "sister" afe bindings, i.e. current-sense-amplifier and voltage-divider.

Cheers,
Peter

>  additionalProperties: false
> @@ -57,6 +61,7 @@ examples:
>      sysi {
>          compatible = "current-sense-shunt";
>          io-channels = <&tiadc 0>;
> +        #io-channel-cells = <0>;
>  
>          /* Divide the voltage by 3300000/1000000 (or 3.3) for the current. */
>          shunt-resistor-micro-ohms = <3300000>;
> 
