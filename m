Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364D02606B2
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 23:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgIGV4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 17:56:41 -0400
Received: from mail-dm6nam10olkn2038.outbound.protection.outlook.com ([40.92.41.38]:19237
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbgIGV4k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 17:56:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJy2YZslcSZU/uvlsZ0GXESmg7HFr9Tm7xyxoZxQaKaRAOvJOpTvGMT5ehviCKSKxMVpI0jXQm1XsjHrvYIB4IzoJma42SJdkrLyO0ewHspdHyIVxJAnYxtQywQ0u3dw1V1zwQPwAHUDQVN6vo2CjfSvcKf7iPrjzwbWlRSqsAXmfAXL6gYEJnttnEhPii56o7pGvWRZsk8u0wfLJtNPjhQ05An/jTIRQJ6qdVtT0Zc2nBVsXnkX9Da5dkrjInVr5iDa7VDscdP8uOtE1m4FBJyFYillGjxjHSdPUNlqXS1M3Ney0L72nnv4QAkjGkiyfBigBufAkHNSBkUtkn2Tdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWecuI/L/mIpqsrlECKDTc804JRlC/+jggpXoUs89g4=;
 b=kFLxh1HyRh1N5rtig+KE+PebMzJeXST/VHHZNcdgSoFTz5NtX4WkFSthz/W8yBBsIbXHwOSt+4rYZxjvMpbRghIDh4ybCdIWw5k6KZRJdvBcVnCxgW+f6NkraX2z9UF+nfC4UrWcy+YyVgFNj880u7faROlOyPYUAPKrc5Dz7xUJwIifWzB4bDy/x49eRZ6EUZ631sUY56o+Qd5kiQF7wRJejZTU3MawmQ+VfleBPVEnGNdNQbejS1ICpFCwMLIvHf+TP5ZDJVwM3yW+fAC0MAofojP7yNBNtZ4nc8DJbWJdhmcYuTlpdrLr6dKW1aaVzwHq/jBCnTMA4juwb3hl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN7NAM10FT016.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e8f::52) by
 BN7NAM10HT200.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e8f::104)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 21:56:37 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e8f::4e) by BN7NAM10FT016.mail.protection.outlook.com
 (2a01:111:e400:7e8f::226) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23 via Frontend
 Transport; Mon, 7 Sep 2020 21:56:37 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:BAFCA61F5FE3AD5D30C839D6CACB2E172138F0FC300E34F1A5B238598202C35D;UpperCasedChecksum:A8CBEEBA53C5D5AD452F2460D77A4DBE226743945E26DBC6C504C7221E63468D;SizeAsReceived:9304;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 21:56:37 +0000
Subject: Re: [RFT 05/25] ARM: dts: s5pv210: remove DMA controller bus node
 name to fix dtschema warnings
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-6-krzk@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB06608CD84EDB798065902231CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 14:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907161141.31034-6-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:102:2::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <f466270c-9e85-ed85-e5b7-1a4a8aec5468@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by CO2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:102:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.8 via Frontend Transport; Mon, 7 Sep 2020 21:56:35 +0000
X-Microsoft-Original-Message-ID: <f466270c-9e85-ed85-e5b7-1a4a8aec5468@live.ca>
X-TMN:  [K2lBcATxibAAB6bSwmEpTg75h6jAZpR7G3hMJdbQAEv9qLQgERzCJgyK99LGFqmF]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: eed4cadc-4ac2-48c1-f29a-08d85378e49f
X-MS-TrafficTypeDiagnostic: BN7NAM10HT200:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYj944/LshtayfdflKPHelebzJpi9s70IToJfDQ/ZFH7EzeJ5iR3bQ+TLwc8YJh6beNa+IJcyIENVe3tU3MSy79WOtZMMW8E1Y7XNGPBrQwBSSvFnVeod5bF2v5HTE00bKx5EQGUXNz+Vxg6gzR4FgJmjlKBZu3zhc+2cHUrjIswopKhYCTKYDqoU+/TEWy7FWFjtJ+36IAXvKR+r/UekA==
X-MS-Exchange-AntiSpam-MessageData: fHz7h23EDTOkbDrcp/+riYz7SALxKOj7jQhilDbf4WBZ1d9nj50Wm4MVIIf8KMKMrti//5V3zL6ua7sw/VdO71NwfX+Mb8whVm9A19TCZUvGtJyeWnUZtWdbDmQjLNcjZplgXcpZ6Q1NRlSl3LtQBhbhNzPRP9ceWA0XcncDCFOsWHwmaPNAJ4v5DL/r8wsR/stHMFqN4dWATgxkrL4/Lg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed4cadc-4ac2-48c1-f29a-08d85378e49f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 21:56:37.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT016.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7NAM10HT200
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DMA still works for me on the Galaxy S.

Tested-by: Jonathan Bakker <xc-racer2@live.ca>

Thanks,
Jonathan

On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> There is no need to keep DMA controller nodes under AMBA bus node.
> Remove the "amba" node to fix dtschema warnings like:
> 
>   amba: $nodename:0: 'amba' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 49 +++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
> index 1b0ee884e91d..84e4447931de 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -128,35 +128,28 @@
>  			};
>  		};
>  
> -		amba {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "simple-bus";
> -			ranges;
> -
> -			pdma0: dma@e0900000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0xe0900000 0x1000>;
> -				interrupt-parent = <&vic0>;
> -				interrupts = <19>;
> -				clocks = <&clocks CLK_PDMA0>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma0: dma@e0900000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0xe0900000 0x1000>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <19>;
> +			clocks = <&clocks CLK_PDMA0>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
>  
> -			pdma1: dma@e0a00000 {
> -				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0xe0a00000 0x1000>;
> -				interrupt-parent = <&vic0>;
> -				interrupts = <20>;
> -				clocks = <&clocks CLK_PDMA1>;
> -				clock-names = "apb_pclk";
> -				#dma-cells = <1>;
> -				#dma-channels = <8>;
> -				#dma-requests = <32>;
> -			};
> +		pdma1: dma@e0a00000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0xe0a00000 0x1000>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <20>;
> +			clocks = <&clocks CLK_PDMA1>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
>  		};
>  
>  		adc: adc@e1700000 {
> 
