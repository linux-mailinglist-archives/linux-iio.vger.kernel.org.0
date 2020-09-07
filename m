Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18D2606A9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 23:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgIGVt5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 17:49:57 -0400
Received: from mail-mw2nam10olkn2041.outbound.protection.outlook.com ([40.92.42.41]:10622
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgIGVt4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 17:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABrXVH5I9P62oHstqonXwX9oD6vqc9wBHMudxgb8C/nRQ66LHuz4rDG7dZ+9fChoECMlrDPQPdb6d2AMEp0REgix/AN8d7zzH52+5hiaRNLMHU4IPC+SdzlV2T02PNqo1RJevt1MQKL2pi87S+EKIiK57DQI/C0RMuDnnmGZzrWYmJTzUq/O9Hg1+6Oq7iKlsAi9XOU5ArDCq+ITuv5R2wjLctO2ITYxUYQaP9EcgpFKjZ4toQQH1LNJdyAJ9drCQR4bGg/AWz0zXG0mnjgLshbiFpewUVOUU7Nu/AzQLmWNQJI5UrD2TWJase4rYZybFfzEJlrRkcSWeJk/+Qow/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ/1QbGbVZigfYaiWJt2CRjoEpyBFGYrxNoTpUvzQ+k=;
 b=TQ19nnDwmqvEjwniN9+yq2SX5os/pZho+chXZ/++QVn9eF3qk6ZXDm06R+Mf+kIujWr2CwNypLSpY0vdwFG7evlurAldytssktS56eIwpPkwSjS2pkRmRI5XYgCVBfse4MxVT65vhdeWLHDck/oRO5SRF08KF8RlAqYbfutSkJ6MjL5awzWE8nkzm6Rrsm2yd3Pb/cxdfQhoXIQdUuVjMmT3Mu76D0hYqOBR5nHBa2OMrGAFhSYgjdMEGR3Z/UN7K1kibcX9XkGuIrN38QoVmETVA8JXFO04WHUgLLidiO4MRAT7U7wvRIOrnGceDQhrAAZwPzlemhGNFuwsanZMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR01CA0030.prod.exchangelabs.com (2603:10b6:300:101::16) by
 BY5PR21MB1425.namprd21.prod.outlook.com (2603:10b6:a03:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.0; Mon, 7 Sep
 2020 21:49:54 +0000
Received: from MW2NAM10FT031.eop-nam10.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::11) by MWHPR01CA0030.outlook.office365.com
 (2603:10b6:300:101::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Mon, 7 Sep 2020 21:49:53 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e87::50) by MW2NAM10FT031.mail.protection.outlook.com
 (2a01:111:e400:7e87::488) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Mon, 7 Sep 2020 21:49:53 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:F7C54E0B108E22D99F8E46A580DB0C50820B95670B5C450E06D8951D68A0F50C;UpperCasedChecksum:B253B91B88A502047AFC803EC6F3018FDB5134B72BA3DA1FF65DDE0FBA60562E;SizeAsReceived:9313;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 21:49:53 +0000
Subject: Re: [PATCH 03/25] dt-bindings: iio: adc: exynos-adc: do not require
 syscon on S5Pv210
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
 <20200907161141.31034-4-krzk@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB06601B8D0B7F1E51953024E6CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 14:49:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907161141.31034-4-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0080.namprd19.prod.outlook.com
 (2603:10b6:320:1f::18) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <9b86ea56-6afe-cbcc-52a3-c75d23e1a62b@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR19CA0080.namprd19.prod.outlook.com (2603:10b6:320:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 21:49:51 +0000
X-Microsoft-Original-Message-ID: <9b86ea56-6afe-cbcc-52a3-c75d23e1a62b@live.ca>
X-TMN:  [JiSKL8DRPDgGXdBt/+WDUrQFhwTmujX7oj3voAQmvt6O/7c6QorpjXIzJy99aXK4]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e9a8be77-b337-4d60-ff26-08d85377f3fe
X-MS-TrafficTypeDiagnostic: BY5PR21MB1425:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZBATa1ANBuEEWeAOgHwvgXo1rkandmR8L9qf2nVmlCDvlPqgBdjOH3mSwlkjyJlgo8QjMvd9EM4Z6J+wBmA6G8lW/24PDRdg1dTgduBpPrpbo4uOpDpxEFXHyAN/+SgQAseLtKFryq5qfO1WeV0I1OLfUzC4hPf8icxmekt4XZOiZyjbHkiG4i0komPs2l6RWYbocg0mC/POOxll1FBOsxBPAx1RugCZqeRtk8DVizJUhNXxXSmjQmbjYey+jQ8
X-MS-Exchange-AntiSpam-MessageData: s4E5NVFRl+DuTndJRm2WiohbiCEGNorz0s6efxlXn9uKz4j51wgC92SqoyQ6lSTManYtXdAQdgjbUwv1IButgRAIyTOd/RdX2NSlj2XE7BMjGuQtnF9EQDOqRdvTYDybqeMWK1A3sUki8c9qBEJdpTpHOW8IrZuoqy8ZAsZbbrH9WN1Yyma0PwKMMHeyRZzCs+uJePKTV9pW+QzSuFzQ9w==
X-OriginatorOrg: sct-15-20-3174-0-msonline-outlook-fb0b2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a8be77-b337-4d60-ff26-08d85377f3fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 21:49:53.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM10FT031.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1425
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Looking at this again, it appears that there is actually control for
it at offset 0x6818 of pmu_syscon (0xe0108000) [1].  However, it defaults to
enabled so it's not required for proper use of the block.  Whether it should
be present in the schema/DTS is up to you.

Thanks,
Jonathan

[1] https://android.googlesource.com/kernel/samsung/+/refs/heads/android-samsung-3.0-jb-mr0/arch/arm/mach-s5pv210/include/mach/regs-clock.h#325

On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> The ADC in S5Pv210 does not have ADC phy registers in separate block for
> which syscon would be needed.  Remove this requirement to fix dtbs_check
> warnings like:
> 
>   arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: adc@e1700000: 'samsung,syscon-phandle' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index 89b4f9c252a6..75174af72288 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -81,7 +81,6 @@ allOf:
>                - samsung,exynos-adc-v2
>                - samsung,exynos3250-adc
>                - samsung,exynos4212-adc
> -              - samsung,s5pv210-adc
>      then:
>        required:
>          - samsung,syscon-phandle
> 
