Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD9260702
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 00:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgIGWlN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 18:41:13 -0400
Received: from mail-co1nam11olkn2090.outbound.protection.outlook.com ([40.92.18.90]:42881
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728009AbgIGWlL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 18:41:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFavTg1SCXuvzFROZ4cjcMUSeBQbw2VceugzXSe7eZFgyDDE5ALzkambhVovNJX7ivAbgNDzBZjS+hqHXsA7PB1yQSxCs9BAdWCUmZqeVMTQfBmQwD5bNfXDMjmnoLUuadkEa6VajhW1P2Vvs4iBvh8aIeOW2rNtoCEWVduu3BaRArI9cUxTMBc4sJJX9mTqU9rpzDgWzEm48p3vdF06g8gK7lQBhe+Cw7a+breY4wUYwFv3ramazlrvj4q/IvE8zccg2qQpnGxBXq0h3SSLsUc+OeQ1t0nrEAU6xo+bYhQxNlLmjBrtsOzoI8TkUU72tux8nHyQSPIKKnwonZmwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRExTv/r0jt75NUN4wLR0vmpEbWkfjPxOwls1eIkL8A=;
 b=NdJt1RLguoMUmhoxpc1RbgvxRAW3lnNlEM6EvMpLXMn19ia5nAwfOeMrPioyWFr9oYCXsQIF2A9WEj9faSalOY2dYXDWE2XCpxRPMDBCnlFGlOdKs1nrEmVac0uFn+0h2krah0K2b6Q+MNcfS3PuhLoaVcQgveiXSDRpogg0U7CDqOqvjw0pi1F/dZTEzYPIyXXWhz5efDfuOAB0Ewj2WpzGt/n4tfGk5e7e7QjI8Ni4tAVIQD0ibO55klCv3LkS/wuORLAS2QvBGT0+sHO4gxkit4eYI+E4pvMYT/onpu4vmVCCfsPMKSfvXXY9NuNZglMhHH+jyAcfRui6AUQXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN4PR13CA0018.namprd13.prod.outlook.com (2603:10b6:403:3::28)
 by BYAPR21MB1304.namprd21.prod.outlook.com (2603:10b6:a03:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.8; Mon, 7 Sep
 2020 22:41:09 +0000
Received: from BN7NAM10FT057.eop-nam10.prod.protection.outlook.com
 (2603:10b6:403:3:cafe::b) by BN4PR13CA0018.outlook.office365.com
 (2603:10b6:403:3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.9 via Frontend
 Transport; Mon, 7 Sep 2020 22:41:09 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e8f::4c) by BN7NAM10FT057.mail.protection.outlook.com
 (2a01:111:e400:7e8f::403) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Mon, 7 Sep 2020 22:41:09 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3D45B78D509E6EA68637F698206A0CA6FB000EF3A8AF48A802964261280DF684;UpperCasedChecksum:96F1B62A48ADCFCAF4B3F525C0EBAE4C7D6D9801C304B87C5293C21DA771C240;SizeAsReceived:9288;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 22:41:09 +0000
Subject: Re: [RFT 08/25] ARM: dts: s5pv210: remove dedicated 'audio-subsystem'
 node
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
 <20200907161141.31034-9-krzk@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660C8AFE24B3F2A35A63D09CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 15:41:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907161141.31034-9-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0091.namprd15.prod.outlook.com
 (2603:10b6:101:21::11) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <b3e3b653-b321-e0a1-88bf-f1e5e53fa8bb@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by CO1PR15CA0091.namprd15.prod.outlook.com (2603:10b6:101:21::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 22:41:06 +0000
X-Microsoft-Original-Message-ID: <b3e3b653-b321-e0a1-88bf-f1e5e53fa8bb@live.ca>
X-TMN:  [EBm6ODzve/MpF4k2M9ZDgIJAU2LpnNWk6dgBSUFuJIMqnUrurQRro6tIbdbMqeMj]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 5f6b10da-f27c-4bd2-11e4-08d8537f1d36
X-MS-TrafficTypeDiagnostic: BYAPR21MB1304:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sowg6x0/31ecKhXX4YATkn2c0lEB7do/J7DSYfLDeouf0gDqBdw208lo1BlxixlNDb1ZfFN/mlm1L5YfeECqL0GISfSeQauWPfKaA9Y/jVXGSt/TUDTJb6ZS6Ffr5V3uYxgvkYMqyAYkC665BZciAAe51q/wK39n9DLQtlEBPenbDnfJ7lWehLj11pBf5iJw4Kf/glVN+E4KjLzGXY13jA==
X-MS-Exchange-AntiSpam-MessageData: veWzlhB1n69xrFCf4O+bzgm3k9izoJ81iraDzJGI88bedsdQol24/yp8+8v7z2xj4TkuATVc9DgHKjUlyucxTYNHFcXCgkB8KvQ3QskV552LfMN1cTPDjAdhfq7wuLFe0aGGHg/CXphp/6qFxpvpZzL/fYHPeHOarD5a+9K92TgiaFLSfva9bzE27PmZIC0iM7MYo6iSR7vIH/FEPr515w==
X-OriginatorOrg: sct-15-20-3174-0-msonline-outlook-fb0b2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6b10da-f27c-4bd2-11e4-08d8537f1d36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 22:41:09.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT057.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1304
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Audio still works for me on the Galaxy S.

Tested-by: Jonathan Bakker <xc-racer2@live.ca>

Thanks,
Jonathan

On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> The 'audio-subsystem' node is an artificial creation, not representing
> real hardware.  The hardware is described by its nodes - AUDSS clock
> controller and I2S0.
> 
> Remove the 'audio-subsystem' node along with its undocumented compatible
> to fix dtbs_check warnings like:
> 
>   audio-subsystem: $nodename:0: 'audio-subsystem' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 65 +++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
> index 46221a5c8ce5..2871351ab907 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -223,43 +223,36 @@
>  			status = "disabled";
>  		};
>  
> -		audio-subsystem {
> -			compatible = "samsung,s5pv210-audss", "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges;
> -
> -			clk_audss: clock-controller@eee10000 {
> -				compatible = "samsung,s5pv210-audss-clock";
> -				reg = <0xeee10000 0x1000>;
> -				clock-names = "hclk", "xxti",
> -						"fout_epll",
> -						"sclk_audio0";
> -				clocks = <&clocks DOUT_HCLKP>, <&xxti>,
> -						<&clocks FOUT_EPLL>,
> -						<&clocks SCLK_AUDIO0>;
> -				#clock-cells = <1>;
> -			};
> +		clk_audss: clock-controller@eee10000 {
> +			compatible = "samsung,s5pv210-audss-clock";
> +			reg = <0xeee10000 0x1000>;
> +			clock-names = "hclk", "xxti",
> +				      "fout_epll",
> +				      "sclk_audio0";
> +			clocks = <&clocks DOUT_HCLKP>, <&xxti>,
> +				 <&clocks FOUT_EPLL>,
> +				 <&clocks SCLK_AUDIO0>;
> +			#clock-cells = <1>;
> +		};
>  
> -			i2s0: i2s@eee30000 {
> -				compatible = "samsung,s5pv210-i2s";
> -				reg = <0xeee30000 0x1000>;
> -				interrupt-parent = <&vic2>;
> -				interrupts = <16>;
> -				dma-names = "rx", "tx", "tx-sec";
> -				dmas = <&pdma1 9>, <&pdma1 10>, <&pdma1 11>;
> -				clock-names = "iis",
> -						"i2s_opclk0",
> -						"i2s_opclk1";
> -				clocks = <&clk_audss CLK_I2S>,
> -						<&clk_audss CLK_I2S>,
> -						<&clk_audss CLK_DOUT_AUD_BUS>;
> -				samsung,idma-addr = <0xc0010000>;
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&i2s0_bus>;
> -				#sound-dai-cells = <0>;
> -				status = "disabled";
> -			};
> +		i2s0: i2s@eee30000 {
> +			compatible = "samsung,s5pv210-i2s";
> +			reg = <0xeee30000 0x1000>;
> +			interrupt-parent = <&vic2>;
> +			interrupts = <16>;
> +			dma-names = "rx", "tx", "tx-sec";
> +			dmas = <&pdma1 9>, <&pdma1 10>, <&pdma1 11>;
> +			clock-names = "iis",
> +				      "i2s_opclk0",
> +				      "i2s_opclk1";
> +			clocks = <&clk_audss CLK_I2S>,
> +				 <&clk_audss CLK_I2S>,
> +				 <&clk_audss CLK_DOUT_AUD_BUS>;
> +			samsung,idma-addr = <0xc0010000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2s0_bus>;
> +			#sound-dai-cells = <0>;
> +			status = "disabled";
>  		};
>  
>  		i2s1: i2s@e2100000 {
> 
