Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77B26077B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 02:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIHAR6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 20:17:58 -0400
Received: from mail-bn8nam12olkn2024.outbound.protection.outlook.com ([40.92.21.24]:31201
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbgIHAR6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 20:17:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9KtL7L7YGhg+g4nNF/sYyAihGWGo3JOVPFTzlropawnF3kon+RiI6bOf2LQO8Jt701V9K6mJ0RHMtvO8cX/sUefUcZ/XydPW9lMMRJ+P+MXRCm13Tgcn4z9eUn1m0/FLNRBIB+lIOVaT58aYSLqYC8U+W+8XhePvLV9lZqn/i5WMv9kVGNrUm5Nc6Eg2VhY059da8OYLOfgRZy22Y+N3fSXX2uVJ9BFbJpFb31nwohiScFYIzQJlZv8nx3LKi2neCTqxI2x0fI9QuywwhNTspysDMR1HD+t1cI+HrA+TLj0+Qi4IhMPyVai3y8Wi/VPxPWxQhhKXshOw6aVPir5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5tZdaKu7+8ZUqU9zZbR35uXlDNO6GfKfKwTn/AsiSI=;
 b=c7DsF4NWJ3xtGRqeMTvct8l09y/W41O3koONbte02xI8Jz7/TGGdWWeWWh9Ij4Gqadb0j73vbeamMSqoXxJNfPxedoSlaiLx822KysObcHX4tfmShav1Er3TGQQML69Pb+2F47yc6bI4PMMnp6ln11ZingG6h/7pj1jAyLXVN4jXvIpZDG1V854+f967I1ocKKNhW90p6qxhdUbtGHu2TtvOxm0RFwz2tuF8sUvdYulGBScSZULj5AmOmltTPcEH9/MEXEiVGHQdKqGkeVku3WhHUcl5Ar0F5C+3E3Nes8nj0HWw9jiKhK/j9PiZp7Q/XYt4/eYxdSlXpY44Wcyd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6NAM12FT039.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::41) by
 DM6NAM12HT067.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::263)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.8; Tue, 8 Sep
 2020 00:17:55 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::4f) by DM6NAM12FT039.mail.protection.outlook.com
 (2a01:111:e400:fc64::315) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.8 via Frontend
 Transport; Tue, 8 Sep 2020 00:17:55 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:9B1D61E5B4793AB0A78C08045FB7C9C2FEC673032C6B8D7537BC7CE2110FD396;UpperCasedChecksum:53878A2B4321716C2FABF261013C101599E045854101B72394B21AF44960067C;SizeAsReceived:9299;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 00:17:49 +0000
Subject: Re: [RFT 25/25] ARM: dts: s5pv210: align DMA channels with dtschema
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
 <20200907161141.31034-26-krzk@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB06605FBC44DFE283C040AFD5CB290@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 17:17:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907161141.31034-26-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0034.namprd14.prod.outlook.com
 (2603:10b6:300:12b::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <25178674-e4af-ba35-b7f0-42091208e0e8@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR14CA0034.namprd14.prod.outlook.com (2603:10b6:300:12b::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Tue, 8 Sep 2020 00:17:46 +0000
X-Microsoft-Original-Message-ID: <25178674-e4af-ba35-b7f0-42091208e0e8@live.ca>
X-TMN:  [uMyLP4XIBBjtx863ydjY2SAyKMB74BWRZbeb1MXljOs/TAlnJ9W96FnVlxvKfKtL]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: dfd20bde-e597-46b3-fa9a-08d8538c9e26
X-MS-TrafficTypeDiagnostic: DM6NAM12HT067:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8goFzah7cNSM5qulaVEFlh1UX+O6eLcaV5sXXOFyta/RmuhqCoUbf4Wk97Tls4aXtBL2wARtQoS+R3sI7C0E8yiWbaI5ggBYknHpvYzCCbbVipY6lBz+p//iLryWLiJ3pEGrYdc5oHUzbzSxL0Ke5W2DCnDE40Fy8heE9gnMInU+GK3yunTF1+AzN7nmBn348m1C0cU5vKvXcsFbvvpnYA==
X-MS-Exchange-AntiSpam-MessageData: +N5macTQhTsUNl+0X8s+s/xcyKi87We1bxLsaYEkFuZx2JWk5zlw1KXxPA7XUliqIfCaJXJmxJS5pn8xri36dTu7zbQAbusphlyiF+wVLFNcjwdpY6zhzWyMDptDf8elrQ3eRfXqbJolS68dgz/3Tm5S0bw8hbt4oL3xFzyY7fu8Auu0Ni2+iaRlFHOnsPyzoc7XT2z1vn+L/QJ1xtd8ww==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd20bde-e597-46b3-fa9a-08d8538c9e26
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 00:17:48.9735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT039.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Initial testing on both an i9000 and an SGH-T959P are showing that the audio has
stopped working with this.  I'm not 100% convinced as I've had DMA issues in the
past.  However trying to play something just results in a hang after 1.5s while
it works just fine without this patch.

Thanks,
Jonathan

On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> dtschema expects DMA channels in specific order (tx, rx and tx-sec).
> The order actually should not matter because dma-names is used however
> let's make it aligned with dtschema to suppress warnings like:
> 
>   i2s@eee30000: dma-names: ['rx', 'tx', 'tx-sec'] is not valid under any of the given schemas
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
> index 96e667ba1c3f..72fb9d9f7ba3 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -240,8 +240,8 @@
>  			reg = <0xeee30000 0x1000>;
>  			interrupt-parent = <&vic2>;
>  			interrupts = <16>;
> -			dma-names = "rx", "tx", "tx-sec";
> -			dmas = <&pdma1 9>, <&pdma1 10>, <&pdma1 11>;
> +			dma-names = "tx", "rx", "tx-sec";
> +			dmas = <&pdma1 10>, <&pdma1 9>, <&pdma1 11>;
>  			clock-names = "iis",
>  				      "i2s_opclk0",
>  				      "i2s_opclk1";
> @@ -260,8 +260,8 @@
>  			reg = <0xe2100000 0x1000>;
>  			interrupt-parent = <&vic2>;
>  			interrupts = <17>;
> -			dma-names = "rx", "tx";
> -			dmas = <&pdma1 12>, <&pdma1 13>;
> +			dma-names = "tx", "rx";
> +			dmas = <&pdma1 13>, <&pdma1 12>;
>  			clock-names = "iis", "i2s_opclk0";
>  			clocks = <&clocks CLK_I2S1>, <&clocks SCLK_AUDIO1>;
>  			pinctrl-names = "default";
> @@ -275,8 +275,8 @@
>  			reg = <0xe2a00000 0x1000>;
>  			interrupt-parent = <&vic2>;
>  			interrupts = <18>;
> -			dma-names = "rx", "tx";
> -			dmas = <&pdma1 14>, <&pdma1 15>;
> +			dma-names = "tx", "rx";
> +			dmas = <&pdma1 15>, <&pdma1 14>;
>  			clock-names = "iis", "i2s_opclk0";
>  			clocks = <&clocks CLK_I2S2>, <&clocks SCLK_AUDIO2>;
>  			pinctrl-names = "default";
> 
