Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D6D26074B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 01:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgIGX6F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 19:58:05 -0400
Received: from mail-bn7nam10olkn2023.outbound.protection.outlook.com ([40.92.40.23]:2528
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727058AbgIGX6A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 19:58:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmgeMEy12WdIKnwMDH+F+R+TuQhNhaaxHGjaW66tKbvICCofJAjJnu+Y7O9q8+vxYJobSUC3EvY4ZwRT4TIAlyuXmWTSB7Qlw/8ZYBO6cz638z2yPehUyuRvdfkacwoDlNCZx6hbwDrLWvPMl3rvYJ+bZi/aLBItLnIGZnsuycTZ3NsUTx6h9er5bR+CIXyHC3QU9AQq6OaqyT6MMDCOeJIwKTmSlEOoXdLr4EYwsYlel9vb2F/yZHTivoyIA4ur46laxhK33gbrKbVFK3kaaSK8n2c5NyVrc6DBrSQFINblHeGY7Mhtrvs3J2wJR8ZdB/HbblJaOK9ob5BGTN/RJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HntvSMKcMp6nPWAeky7lX80zSyFz7+LuGIVDu9CmML0=;
 b=db251tpKrkv5do8WMNP5JS2zg8otRMQxsFR1bIiZgcRADPYF8eJTfa7Q0IN1U4UVKtlXKuvuqr3y4E9jG4rWVobRjQ2/d7EGGw6h0Y/GUVJBXLPzONxG+YEZI9HG+PBPKX4mHesIPU6vlC/4/W9SM7ZmvtpI+KsKO8rKZkMvUVYdVra6wIy7fYwQsbyyojhGvh4NN3rPPzxa+hgnjoHCJd1tkDNZN4CP5vzoIRjyH+yLYKFTXrQ+IlgNu83rBrf+1YuAG/aYdbNlPeTNmZIFBSOgQjtrMO5oGBn7A+VsKQ1qWx9Ba/WEfPLNraa8QiderfR7DGf2aQtPnzttl2Shaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN7NAM10FT047.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e8f::4f) by
 BN7NAM10HT056.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e8f::64)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 23:57:58 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e8f::50) by BN7NAM10FT047.mail.protection.outlook.com
 (2a01:111:e400:7e8f::126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Mon, 7 Sep 2020 23:57:58 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:8CF1001AE62D46DB815F46CE29B099155776B1E4525096109C9E4E312E0C574A;UpperCasedChecksum:DCF91870F4ED01B99357943FC49B92E139A22B7654A195535A21E478F9D2CA5A;SizeAsReceived:9289;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 23:57:58 +0000
Subject: Re: [PATCH 11/25] ARM: dts: s5pv210: add RTC 32 KHz clock in Aries
 family
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
 <20200907161141.31034-12-krzk@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660939E010C3175CD0DF9D6CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 16:57:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907161141.31034-12-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To BN6PR04MB0660.namprd04.prod.outlook.com (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <c46752bf-7a1a-2a42-9f15-a504e5f9b7a2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 23:57:55 +0000
X-Microsoft-Original-Message-ID: <c46752bf-7a1a-2a42-9f15-a504e5f9b7a2@live.ca>
X-TMN:  [k4tqjJgX5hGeluGZs9Q46AzGeJY0KK2EcLeTWBJjIjKPtuRSEtQPsVVoUj+QDr9L]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 2c6f8427-16bd-4d0a-94f9-08d85389d84b
X-MS-TrafficTypeDiagnostic: BN7NAM10HT056:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOmx1GuBX1LZwHQvBC4zaq+3nyAjmyWo+Clo/SAOAUedOdOOrLkCDL0HpFzFdTD53u+ZggMwrgXd5rekTGpNzcePHGhqKtTf/2BGLH73Bvn3Q5Hh+Py2oDzXhkdYTUJ/tREYGmAYaqFHLAN1pBfULtR4MWyQyVDkGBxjz9PDUdwbcBKL1eZ0xoTHygedrxrtWKjIFYJhLrKQRZBPt1DH3A==
X-MS-Exchange-AntiSpam-MessageData: bEqoz062S9Zc1hB3Nwy2d/bMOhJE0AbRQJRtKCeonzebnhH7v/9hXoNSdj7zQvmfR0swX24z7WJoGOLjzrEcGYK9LtqBhLYcPwU7u7LuiM57E4Gc+wId3w/N5ZeigP3g4N0Mwp/u4A3Oc/yqHrfRSkjizVKhQ1VObzVvIUqnrpJ1LAacQ9SNdtHscDolUIzxBKet96sMxuh3y5yAavF41w==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6f8427-16bd-4d0a-94f9-08d85389d84b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 23:57:58.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT047.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7NAM10HT056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Krzysztof,

On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
> However there is no such clock provider but rather a regulator driver
> which registers the clock as a regulator.  This is an old driver which
> will not be updated so add a workaround - a fixed-clock to fill missing
> clock phandle reference in S3C RTC.
> 
> This fixes dtbs_check warnings:
> 
>   rtc@e2800000: clocks: [[2, 145]] is too short
>   rtc@e2800000: clock-names: ['rtc'] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
> index 6ba23562da46..86c3b26fd21e 100644
> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -47,6 +47,13 @@
>  		};
>  	};
>  
> +	pmic_ap_clk: clock-0 {
> +		/* Workaround for missing clock on PMIC */
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +	};
> +
>  	bt_codec: bt_sco {
>  		compatible = "linux,bt-sco";
>  		#sound-dai-cells = <0>;
> @@ -825,6 +832,11 @@
>  	samsung,pwm-outputs = <1>;
>  };
>  
> +&rtc {
> +	clocks = <&clocks CLK_RTC>, <&pmic_ap_clk>;
> +	clock-names = "rtc", "rtc_src";

Missing a

status = "okay";

here, but with that it works fine for me.  Looks like it's also
missing in the patches for the other devices as well.

Thanks for the series of cleanups,
Jonathan

> +};
> +
>  &sdhci1 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> 
