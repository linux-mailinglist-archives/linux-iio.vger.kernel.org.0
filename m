Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A01260746
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 01:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgIGXzq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 19:55:46 -0400
Received: from mail-bn7nam10olkn2011.outbound.protection.outlook.com ([40.92.40.11]:9344
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727058AbgIGXzp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 19:55:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6RZ0iJvg6CRQ3je10GVhx0kQVwC9QnSVtOLDt46QvL2wf8yHDAz2+1N5/vaZiu7IqgFgfxM0xCX2byBW40H22pUr+64JDKkpVSvlr2KcdPM9/R4/AnegpNHbR4Nd2ccdQk+UmASsOTkln9NedWEtpvvNF3CzoEJno1UE5/WGlmizSkwh/hKUMkDxrZXcOgtNvsfexniHJYEGXZ5VftAV7VUX7Tya6AAsdd3btiLzmVembjtWyvgQAuhA4aDfSLBpq/GjjC2KbTzigpWZSNZvfn7WlpLguHK6yp3rPyzDGKvzJNA4w/YfvqeeD2K4hQYffpKwZIxnYHfJDU6jCa1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhp5kpm+xJHMQu6zDkcK7rgQ/52TPIfbtiJo9pP4fuE=;
 b=PmJc6ZKrVlSwwwMB+Wp905I+/tM3QADKVFXtQhKw+bT5N5Q2y6QYJhTNSOFM+8DiQGmN7tvzoY/J8r2lVNkx800B7usSOzqw0gHZauDICNxsP+PUHR4xGdMkuXm6J0vrI2a88M1B1oGYIbHglFAqUZs8srfh4F7vCz6BTvdmzqslrL/8uqCxrnE76cYzBNNsD9xKJF1XqkjsuGUw/FY8gTe4mjfe5eYYFYanwxwrvttaUodeYLA+5h4Tae6R1F61/jRHnpF3fpLMgf25K7j8oQtlfaov54HNcsj7H/FeHBSaz+uUZW+LGcb8XfXILsqBT0LwKvtSRDXdc0K4UlR6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN7NAM10FT047.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e8f::40) by
 BN7NAM10HT080.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e8f::108)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 23:55:42 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e8f::50) by BN7NAM10FT047.mail.protection.outlook.com
 (2a01:111:e400:7e8f::126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Mon, 7 Sep 2020 23:55:42 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0614694EEEB9EEFAC7799501BF9DF3CEAC7E4D039BC2D5F554942613E41C340D;UpperCasedChecksum:8D13EE74243F57BEBE248144F76506505741DE9B57F485FDD1A5207AC64B4CEA;SizeAsReceived:9289;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 23:55:31 +0000
Subject: Re: [RFT 09/25] ARM: dts: s5pv210: fix number of I2S DAI cells
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
 <20200907161141.31034-10-krzk@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660D9B0D0B5FB4F40CF2769CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 16:55:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907161141.31034-10-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:101:1f::15) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <b3120e9e-c16a-7fc0-1a61-58463210ee8e@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by CO1PR15CA0047.namprd15.prod.outlook.com (2603:10b6:101:1f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 23:55:28 +0000
X-Microsoft-Original-Message-ID: <b3120e9e-c16a-7fc0-1a61-58463210ee8e@live.ca>
X-TMN:  [/GJJJ0TDLeNVslWPYdc+YyZHrn2aQ5+Q+VyUnIFd9X7i3j11xOYL9RYXJ7cvP1ZY]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: bcfbf58f-a31c-4904-ddde-08d8538980bd
X-MS-TrafficTypeDiagnostic: BN7NAM10HT080:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztdrQdlJQKL1UXQnGMLcFlcBApkGOhpeNml0PKBGzmnitpKG9zGN3F5UnoULtrYaV4ABNctjXHNS1SZsP+8Z2wegVjTr+56x/j2ppfufjrbL6KNNZvX4bbwjdzzHczZbmLdTDzbd+2lEOkyyV8w1nIZrnXxRNjcMnvQre8BraD/vBu0TVBBEON37QSvb3pzIo9kjvPXTAYpYj44xIAuXaA==
X-MS-Exchange-AntiSpam-MessageData: 1a7k1vPztP0sjQ46N9+A2p+DXlz8r1tfjy9tWfutZCMqf8FfkwA7C+5sxgXWHXoi+G/wLViswcY4eePATQX95mXcrKtFNlYYxxKGRHsQJDvR7H7c8cCvLZJKrpOPpGFgT2leRFRbBJLhPrTLeyo1h9Wn2a4++Ua76e4mPVuAtt8+ihIepmxUVl/xYYsABN/5X+BnvNthGc28WEUN/kqXxg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfbf58f-a31c-4904-ddde-08d8538980bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 23:55:31.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT047.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7NAM10HT080
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sadly, this is causing issues for me.  The machine driver is no longer probing correctly
on the Galaxy S.

The failing call in sound/soc/samsung/aries_wm8994.c is

	/* Set CPU of_node for BT DAI */
	aries_dai[2].cpus->of_node = of_parse_phandle(cpu,
			"sound-dai", 1);

where cpus->of_node is not set properly.  Which is definitely weird because it doesn't
look like this should affect that.

Let me know if there's any specific test that you want me to do.

Thanks,
Jonathan


On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> The bindings describe I2S DAI has 1 cells.  This makes especially sense
> for i2s0 which registers two DAIs.  Adjust the cells to fix dtbs_check
> warnings like:
> 
>   i2s@e2100000: #sound-dai-cells:0:0: 1 was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 2 +-
>  arch/arm/boot/dts/s5pv210-galaxys.dts     | 2 +-
>  arch/arm/boot/dts/s5pv210.dtsi            | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> index ca064359dd30..a6dc8a173af1 100644
> --- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> @@ -102,7 +102,7 @@
>  		pinctrl-0 = <&headset_det &earpath_sel>;
>  
>  		cpu {
> -			sound-dai = <&i2s0>, <&bt_codec>;
> +			sound-dai = <&i2s0 0>, <&bt_codec>;
>  		};
>  
>  		codec {
> diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
> index 560f830b6f6b..0eba06f56ac7 100644
> --- a/arch/arm/boot/dts/s5pv210-galaxys.dts
> +++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
> @@ -132,7 +132,7 @@
>  		pinctrl-0 = <&headset_det &earpath_sel>;
>  
>  		cpu {
> -			sound-dai = <&i2s0>, <&bt_codec>;
> +			sound-dai = <&i2s0 0>, <&bt_codec>;
>  		};
>  
>  		codec {
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
> index 2871351ab907..96e667ba1c3f 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -251,7 +251,7 @@
>  			samsung,idma-addr = <0xc0010000>;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2s0_bus>;
> -			#sound-dai-cells = <0>;
> +			#sound-dai-cells = <1>;
>  			status = "disabled";
>  		};
>  
> @@ -266,7 +266,7 @@
>  			clocks = <&clocks CLK_I2S1>, <&clocks SCLK_AUDIO1>;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2s1_bus>;
> -			#sound-dai-cells = <0>;
> +			#sound-dai-cells = <1>;
>  			status = "disabled";
>  		};
>  
> @@ -281,7 +281,7 @@
>  			clocks = <&clocks CLK_I2S2>, <&clocks SCLK_AUDIO2>;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2s2_bus>;
> -			#sound-dai-cells = <0>;
> +			#sound-dai-cells = <1>;
>  			status = "disabled";
>  		};
>  
> 
