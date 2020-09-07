Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC192606B4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 23:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIGV7h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 17:59:37 -0400
Received: from mail-mw2nam10olkn2076.outbound.protection.outlook.com ([40.92.42.76]:24161
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726941AbgIGV7g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 17:59:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ofs4DqrcGV6LCNF7NeTtTyP4rAl1klnY5W/TXYLaebEXlT/ozrwIThFxq5IGidFNGo1rU59B58ZLqCqi4Yx+2fHAbbUx6VQo0TvhFkbHc3HBlTXtuUu6H5bkmoPYi7qRDhY5RFYPlhOBnVgjmcnSdvEWYLGQ0rHn7C8FzcdeSsmV2wUexMqEpUgt7/LsaOpu//mOB5BUzvgUXakomhTB18yhaQc5R/N4ojJXLZToCOxxawfXARiBrmzn+KJVfs/ERmprlpWew9DHz+Itu4XtDPbmz23/iYp/4ZECctuTM4OacIlcWFeys9vzSPmiOWfWT33O9rD4kFVD/DivqBMPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mMyIFLn7x13+26wfsZzZmU9kKND5Fz5URdzquQjUlg=;
 b=oA05g+7mEorQARYbynDEh+OaJriBeYHKiYz/ScXnPzVTLPW+MtvEcSlPypTEP+cp1y8P05tbNBweLmzofItugpF6qToH9n1Cqc39REHDvpT/QZ4Jb56PsmTobzCH/UYliS1lCH9E2YRMMjM5cBWjX/6q7aUd9KmSvvtyuhZAf+mNOJG+9NwgqG9Rmv3j9q9oi+OKV3Xf5oghbrc0fiRXx/ntaIatyMpkL3FB1MlfszudH+1UGRafbcxuB4riTnwQlcdsXwzu9p4vg0dnnQTSg7wh4QkFnaxWW/VOoTcpP6REqZtkc6q0+LUV8NNuOPQbUTxUOXVcwOrG3qp4cxCCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN7NAM10FT016.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e8f::4c) by
 BN7NAM10HT177.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e8f::295)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 21:59:34 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e8f::4e) by BN7NAM10FT016.mail.protection.outlook.com
 (2a01:111:e400:7e8f::226) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23 via Frontend
 Transport; Mon, 7 Sep 2020 21:59:34 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:1AC2766FC08D98C8B0B437D50376D26C203F8DD870C1FDE5CE551708501B3778;UpperCasedChecksum:57B2A49983E1ABEDDB9A01E793BFF078E699D11AE9577201387F12BCC9FAFC0C;SizeAsReceived:9290;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 21:59:34 +0000
Subject: Re: [RFT 06/25] ARM: dts: s5pv210: move fixed clocks under root node
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
 <20200907161141.31034-7-krzk@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB06608B88962AD3D8BF5301D3CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 14:59:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907161141.31034-7-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR18CA0056.namprd18.prod.outlook.com
 (2603:10b6:104:2::24) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <d6d74e49-57f0-506e-289a-b6cc786cabe0@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by CO2PR18CA0056.namprd18.prod.outlook.com (2603:10b6:104:2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Mon, 7 Sep 2020 21:59:31 +0000
X-Microsoft-Original-Message-ID: <d6d74e49-57f0-506e-289a-b6cc786cabe0@live.ca>
X-TMN:  [G6aTOyxuKOyt7jjK6HKCYUMiKhFeVfuFcb+vC0+Z1TT0ipj2LYdB/aXmC66kDrSu]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c03078b4-7411-41d1-3092-08d853794df6
X-MS-TrafficTypeDiagnostic: BN7NAM10HT177:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftYHjl3RitJDUNld+16ZH5kVvuAyRhChR3oPbMONp6+A9wzbNLCE78J8+jxz2FvjB74XxSfvl6Ga7NmhQM8wBNsjDKJ/bemTdeTapMwlV7dKR0F9mhE91Upn0X5AzLud+w+HSxp93EsYQW9NGkjaNNrCbM5gfXJ+zBwR7QOO/OzdTqEPhUX7T57ziZ3oDehNPp3eXvFobGLY8W32QcwB1A==
X-MS-Exchange-AntiSpam-MessageData: uKWby0FG/2bXOfx9WCUJnonk84yAgpFz03LYGbSFUMJ4ZCpoJLOGDbIo+VhV3AzLChgV6CVnKLnr3kLqQB6tFB1b5C0Z7PqF78JBPryR5oUz2dQMwhLeL9260/sxtJDtpWMi25avyUlieZxEtZgi8gZ1AL5Wi1enpjAKK9ozpVwrD7BFNY30ZLA56qAqv4gcsg3CFk9GWYxEKOWsFCimWQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03078b4-7411-41d1-3092-08d853794df6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 21:59:34.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT016.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7NAM10HT177
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Works for me on the Galaxy S.

Tested-by: Jonathan Bakker <xc-racer2@live.ca>

Thanks,
Jonathan

On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> The fixed clocks are kept under dedicated 'external-clocks' node, thus a
> fake 'reg' was added.  This is not correct with dtschema as fixed-clock
> binding does not have a 'reg' property.  Moving fixed clocks out of
> 'soc' to root node fixes multiple dtbs_check warnings:
> 
>   external-clocks: $nodename:0: 'external-clocks' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>   external-clocks: #size-cells:0:0: 0 is not one of [1, 2]
>   external-clocks: oscillator@0:reg:0: [0] is too short
>   external-clocks: oscillator@1:reg:0: [1] is too short
>   external-clocks: 'ranges' is a required property
>   oscillator@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 36 +++++++++++++---------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
> index 84e4447931de..5c760a6d7955 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -52,34 +52,26 @@
>  		};
>  	};
>  
> +	xxti: oscillator-0 {
> +		compatible = "fixed-clock";
> +		clock-frequency = <0>;
> +		clock-output-names = "xxti";
> +		#clock-cells = <0>;
> +	};
> +
> +	xusbxti: oscillator-1 {
> +		compatible = "fixed-clock";
> +		clock-frequency = <0>;
> +		clock-output-names = "xusbxti";
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges;
>  
> -		external-clocks {
> -			compatible = "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			xxti: oscillator@0 {
> -				compatible = "fixed-clock";
> -				reg = <0>;
> -				clock-frequency = <0>;
> -				clock-output-names = "xxti";
> -				#clock-cells = <0>;
> -			};
> -
> -			xusbxti: oscillator@1 {
> -				compatible = "fixed-clock";
> -				reg = <1>;
> -				clock-frequency = <0>;
> -				clock-output-names = "xusbxti";
> -				#clock-cells = <0>;
> -			};
> -		};
> -
>  		onenand: onenand@b0600000 {
>  			compatible = "samsung,s5pv210-onenand";
>  			reg = <0xb0600000 0x2000>,
> 
