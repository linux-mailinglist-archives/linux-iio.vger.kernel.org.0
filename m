Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF140C2A3
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhIOJSR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 05:18:17 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58437 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbhIOJSR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 05:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631697418; x=1663233418;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zSioON/ethx2UvJb6ICepFu9penhcSvTAXx0NhEDVCo=;
  b=EHSG3Q8qXORJIdBwmddIXu5NNXvLRq0PHwVWWsCPKgNsgKQIhTVkmzCl
   mamkBYbzBWMehW4H9LJbM/mYPdLOO+As/AdGpea8bmo+PZ2EDERZjsN3l
   Wjf3aBg8kpFOJCXnsjsUrsw86X+tD5oGxG7AYA3/HP/9XGn0MfLjrF1Xh
   Sj5gQlZEHHb7I54f6PxiwA81sESZBgcgNMA76b00S0xwg2/zkcpvlvW9Q
   BWmKVxBgbBloHDbD9MoO7kmdov7/jA2zs8O3G8CrIhMtmSk1AjPAkhHPy
   f8KI2HXskrM8FwgdImCzRqPngjFbdecZjROhQcSfZugCmIGgpG4RD4NS3
   w==;
IronPort-SDR: /+ib958lP0Wkp3S2mHQX7KUGcq+rvuU/ESIVzV0VaJU9Wq8QG8UUflmTgXcOo+yUDOyj6C5IOS
 JiZ4tEc2UwLAw5AIl1r9d0+NmyijnNB1XsKMqptOXJL21J3COGg6Zq22y8wJiVh9FeDQelHeo3
 d/zTj6ugdPODMe7l6DYpYYSgjjDk9h6jCAAAiCpyv3ReDEQmNc2d/JxTAhZZoKw9AOfPgIz6Qv
 3UFDdA/u+pjSDU4h4btctmeP6dFjdmLxIRSD3HMOZTFU0w9a0guWuIeSkFwLS58eCqVRuRJ528
 E1xjoyXwcYmhaPxGDOKeSsBT
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="69373841"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 02:16:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 02:16:57 -0700
Received: from [10.171.246.91] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 15 Sep 2021 02:16:55 -0700
Subject: Re: [PATCH v3 09/10] ARM: dts: at91: sama7g5: add node for the ADC
To:     Eugen Hristev <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
 <20210901123013.329792-10-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <069f7714-c4c6-ccf4-82d7-914dba5ea735@microchip.com>
Date:   Wed, 15 Sep 2021 11:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901123013.329792-10-eugen.hristev@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 01/09/2021 at 14:30, Eugen Hristev wrote:
> Add node for the ADC controller in sama7g5 SoC.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   arch/arm/boot/dts/sama7g5.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index f9ad5365862f..de960519c72a 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -137,6 +137,22 @@ ps_wdt: watchdog@e001d180 {
>   			clocks = <&clk32k 0>;
>   		};
>   
> +		adc: adc@e1000000 {
> +			compatible = "microchip,sama7g5-adc";
> +			reg = <0xe1000000 0x200>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_GCK 26>;
> +			assigned-clocks = <&pmc PMC_TYPE_GCK 26>;
> +			assigned-clock-rates = <100000000>;
> +			clock-names = "adc_clk";
> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(0)>;
> +			dma-names = "rx";
> +			atmel,min-sample-rate-hz = <200000>;
> +			atmel,max-sample-rate-hz = <20000000>;
> +			atmel,startup-time-ms = <4>;
> +			status = "disabled";
> +		};
> +
>   		sdmmc0: mmc@e1204000 {
>   			compatible = "microchip,sama7g5-sdhci", "microchip,sam9x60-sdhci";
>   			reg = <0xe1204000 0x4000>;
> 


-- 
Nicolas Ferre
