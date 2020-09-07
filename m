Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0960D26072A
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 01:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgIGXeW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 19:34:22 -0400
Received: from mail-oln040092003100.outbound.protection.outlook.com ([40.92.3.100]:62592
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbgIGXeV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 19:34:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKitb/YdjTubQh5aQHfwdzJtcr4t0p9nYPK8CmuXcbefjcVN+FnQwzoqgJFy7B8qUFOXzUTQ+gXqvJVXhwQDEjbiSo90e+1OX212NCDOfvbnxTy/jNyngMNE8PrybfRmJEUEHc4nTYmTe8YeV4vQP1WY3yqM8e1NDtKkI/aovpmeodUjsC6UGZL1KDdbSSZS5zpYsZRuBpSuCVooT65/cV9mrNWuzAXqKMekBFW0y4Rs48L+9G5HBZD62EnsK7zsEE5k0W+WjI28YKuPGhnn8SxSIgp5XtkIIpmfneDeDb4VUg4qJrBx+CLsyeCX92eCgczAr+z70nVW+uOaazrfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGVdvKN8q6kgMjin1mRGqzW8zITlhvBY+iDO6b4ZzEI=;
 b=NgEGn5FCuhIsSNDzQYq/ZuD4169nNoarJYduDeWzWWUpwkES58ZZubPDxu1b5mS4QLY2PKFZI9jz8n0BUCxaVLGoQc65Qfqu0lLzyUNev8niQW9C6sWKm7vnz4G39qZaghuojy+3L860v8KZ/f0UFgVhUV0hzTseh92lFTyq/OKqiKiE6uME/qMA8jtR/Lr893p7qjPf1473DU+G2LEx+BJ3BMu+rWrqtho9dM0zJBg20WpgZjsGDkqim2S5CexbuFjEBH5SyHjCn9lFu8jhAJHjAHtPScATH5gD2snHiCb91olX2L3QpZRkNbBPB5P9I6YRtoZBlEjhGtMfP9lHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (10.152.74.51) by CY1NAM02HT184.eop-nam02.prod.protection.outlook.com
 (10.152.75.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 7 Sep
 2020 23:34:18 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e45::4e) by CY1NAM02FT045.mail.protection.outlook.com
 (2a01:111:e400:7e45::367) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17 via Frontend
 Transport; Mon, 7 Sep 2020 23:34:18 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3D16240347C6F5D2B96049424D23CE8239BFC7C0915850D3EDE7316F889146CA;UpperCasedChecksum:A48937B9C45BFA96B589DA1E2CE7673D31BF5949BF049546AAE35E5FD9FBF52D;SizeAsReceived:9297;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 23:34:18 +0000
Subject: Re: [RFT 24/25] ARM: dts: s5pv210: align SPI GPIO node name with
 dtschema in Aries
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
 <20200907161141.31034-25-krzk@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660EA3B6B004B1B19C7AB3DCB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 16:34:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907161141.31034-25-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0066.namprd15.prod.outlook.com
 (2603:10b6:301:4c::28) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <393fb8cc-74fd-dcaf-2586-9f166d007aef@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR15CA0066.namprd15.prod.outlook.com (2603:10b6:301:4c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Mon, 7 Sep 2020 23:34:15 +0000
X-Microsoft-Original-Message-ID: <393fb8cc-74fd-dcaf-2586-9f166d007aef@live.ca>
X-TMN:  [Jfn/S8udGVxVxSbHjYs5j9h0t+0xRauF45DHS9uNoXkmtxlHERiBiSDxxkgHbYOo]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 54f78097-1673-4444-d638-08d853868a03
X-MS-TrafficTypeDiagnostic: CY1NAM02HT184:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qy4imoYjbEAsYbhK9zZY8S00ErwL4RlcV8746YYsfhNRHHULxWWoL02h7QF/a7Un4ZjR2TyfkEUzn2rT6KziPU4AURITYqEs/VGGEmHof1qyY9B/ySbGpCCskM249S5gJSQWJkhFbEX3kclx6Gry/ndzz9e1tLu0Is9jbwP0f4ezCQ1OpVAlOvZw4VfpQ38qcDSf18Fxf240DBrEyG04g==
X-MS-Exchange-AntiSpam-MessageData: Y6K3F7ADQCDc0AfLChzWl44XDfmzeK3JRG0mX6/4DY+dGBQRuZjqU/2caGCy0XkVzyFIolzCwTWtOMbIspBvblzjCa9b4bps6WcGMr90U8gqeXeCM4URQPQjQ/bevcKk9lp7zfwQAG9a0BdoMpmjD+vum9B5DtCVlScu8CTs+iUdckFfQ/zLGf6oM2bKwhiAYjBI3Ts3GRCFLt7TOHZCYQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f78097-1673-4444-d638-08d853868a03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 23:34:18.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1NAM02HT184
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Works for me on the Galaxy S.

Tested-by: Jonathan Bakker <xc-racer2@live.ca>

Thanks,
Jonathan

On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> The device tree schema expects SPI controller to be named "spi",
> otherwise dtbs_check complain with a warning like:
> 
>   spi-gpio-0: $nodename:0: 'spi-gpio-0' does not match '^spi(@.*|-[0-9a-f])*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
> index 86c3b26fd21e..bd4450dbdcb6 100644
> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -545,7 +545,7 @@
>  		value = <0x5200>;
>  	};
>  
> -	spi_lcd: spi-gpio-0 {
> +	spi_lcd: spi-2 {
>  		compatible = "spi-gpio";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> 
