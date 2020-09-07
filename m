Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ABF2606C4
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgIGWC7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 18:02:59 -0400
Received: from mail-bn7nam10olkn2067.outbound.protection.outlook.com ([40.92.40.67]:51660
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgIGWCy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 18:02:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJaiOc7DQxbDBJCouWcfoLbzqRn4UtYBiZMGNoI7aprDDVqqaCcQKueQRVfzdbeCndBCqVnsw+KdwG0+14h4OItx8gCi3N8BjJsd3Zlqa2iAeRo2/zaBFqfsRwFMYd6/f9TiPBtrzTWBfpt2wSAah/+TkJsKrevTr0CE5voc70nBfXGeafqYBQegNrlmn9s83bDRX/OKKAkwHy+Zx/G5kIX3q7/Mgl31QmwSHHe/CTpcsttvZjlzlW4u+6P6NYQSH+FOd7OuwYV1mSLFecN74tdvezEa4Zi/eQ7GB3VFStEkwzwhAHhIZ5ERpGt0kqUtm8Pv+fy2MfpVDZFF6nKUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj3Bf8Td7rFVPDItt/LBjLSVbKjWQ3k265TWPYyekQE=;
 b=iaF0uCKuDCNTCpaa0ew1ybeXk5xpQpFLHVIGy+0u9OM1hrFsVgD9FqeIvhRj4kKlKNDoqlxlFM2aXrvAG2dC/uK7UoN0GjNSvxIkKYc2uo62t8aMN6fkWelY2VHiBFi/RmxYZYaLo4cqljIRU+S3iWmKQfUK0eW9FE4IGtwp7VX9k1ZOLY9Kd1RIK5VLF6mgBb/0KFdqTqxoLUaKIiDuiiaXXjj4HovjRMTVsjI7C+DSkiH10i4gN5BBwoDM36PfQ0pDV416CAaQTfyIKyXCWQ3LRoLZSswxsUgIsmDAl/XTHXr9zBwgsypqCISZ7xQHsTA6dp+Ek1Kv43T0e/mD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN7NAM10FT016.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e8f::45) by
 BN7NAM10HT027.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e8f::449)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 22:02:52 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e8f::4e) by BN7NAM10FT016.mail.protection.outlook.com
 (2a01:111:e400:7e8f::226) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23 via Frontend
 Transport; Mon, 7 Sep 2020 22:02:52 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:402BFDDAE15266B5623DA8A7B7CF6BF860F4AEDE0419CD077C8CBF5158F92DB6;UpperCasedChecksum:F072DA42B4375454A06BF772BA6EECC23C7B4DA82B863A67112869AFE2FEEA36;SizeAsReceived:9286;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 22:02:46 +0000
Subject: Re: [RFT 07/25] ARM: dts: s5pv210: move PMU node out of clock
 controller
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
 <20200907161141.31034-8-krzk@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660C619C9C4BB2B583F5BC8CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 15:02:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907161141.31034-8-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0082.namprd17.prod.outlook.com
 (2603:10b6:300:c2::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <db499891-c721-2c05-8474-2704a5e2601d@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0082.namprd17.prod.outlook.com (2603:10b6:300:c2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 22:02:43 +0000
X-Microsoft-Original-Message-ID: <db499891-c721-2c05-8474-2704a5e2601d@live.ca>
X-TMN:  [gFkUa/bI/KBUtRzSNTALzPm29qhHgzxvAJvOqZI4laV6W1B6y0jVh8vzwV+7zs+A]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 4fb5a74f-4f1d-4b1d-01d6-08d85379c065
X-MS-TrafficTypeDiagnostic: BN7NAM10HT027:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uT2Ic+rehXHZhNiJB55B3NyAZcIVhuqGdGs4cFntUpqEbXSkCdokEfWIIJe/An7z5xrkG0x1/iiAeucPuQcwzex4WcnyroXvEirOFG5HAC7GrN7cPkPk7lPldc7qzWm+qSTXfMt34oV7V2SGDsODzJ+aLLmCyRndn+Ecd+xbgKzpZVWbkohojtOr38ozhO6K/gvrJoXeGYwcjb9uFpbHhg==
X-MS-Exchange-AntiSpam-MessageData: k+Wl97Vp6KVLl7XBZ9lP3j1+jWkc4tr4EDTK3qAZOatA1PQ9uKI3wFkZqkB1rWWvqGYlDX3FVuxKIbSBNh3fl/hn4RbqbwlpSQKHmG0ybODKGsM1YKd1EaNU2Xib4NXqSVJpSDTNR0HU/L86AJwKxvh9G/ZwVf8cCn05lqrZChRA5oP1j/pUrIBg+WEQIAdSxrsWfayPAu/cZuElctsU9Q==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb5a74f-4f1d-4b1d-01d6-08d85379c065
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 22:02:45.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT016.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7NAM10HT027
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Works for me on the Galaxy S.

Tested-by: Jonathan Bakker <xc-racer2@live.ca>

Thanks,
Jonathan

On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> The Power Management Unit (PMU) is a separate device which has little
> common with clock controller.  Moving it to one level up (from clock
> controller child to SoC) allows to remove fake simple-bus compatible and
> dtbs_check warnings like:
> 
>   clock-controller@e0100000: $nodename:0:
>     'clock-controller@e0100000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
> index 5c760a6d7955..46221a5c8ce5 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -92,19 +92,16 @@
>  		};
>  
>  		clocks: clock-controller@e0100000 {
> -			compatible = "samsung,s5pv210-clock", "simple-bus";
> +			compatible = "samsung,s5pv210-clock";
>  			reg = <0xe0100000 0x10000>;
>  			clock-names = "xxti", "xusbxti";
>  			clocks = <&xxti>, <&xusbxti>;
>  			#clock-cells = <1>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges;
> +		};
>  
> -			pmu_syscon: syscon@e0108000 {
> -				compatible = "samsung-s5pv210-pmu", "syscon";
> -				reg = <0xe0108000 0x8000>;
> -			};
> +		pmu_syscon: syscon@e0108000 {
> +			compatible = "samsung-s5pv210-pmu", "syscon";
> +			reg = <0xe0108000 0x8000>;
>  		};
>  
>  		pinctrl0: pinctrl@e0200000 {
> 
