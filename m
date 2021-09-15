Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378FF40C2A6
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhIOJS3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 05:18:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:48121 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbhIOJS3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 05:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631697431; x=1663233431;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Dfa252DYPnAczaB3OriaDcww1m7VLIetrz7OSnE6jpY=;
  b=KOv00J9iwmDpdtHIYThxLsFqCdljp3nMzE5LsNc8JuJxvpPUpPml6uKB
   SjVwDlwG1Uq1uDWamkE6QabGQhR4cu6E2xO5Ve5SVf/WaZiD0h6UqfL/p
   tQwalMoaCa1fgnnxM1Cxf6ujIxzlEFVTXDleYWNPSBTa++IfCcthKDOAd
   vRI2kivWOPCYyZazbbJ2uQXerIeoeXo87bQ9cCzNIYoNA4sxcN947FSj+
   CTHXUrkHdbminVWaCVzR8xcYCIBX9oupXoaYWoOZ0E5oG9rJJhP5ZuLLU
   4rT2mFiw0VXqQgDlX/+LDDZ2eDtcyBFaQMnFdLR7mU2EUxc6Q3An4ZYlD
   g==;
IronPort-SDR: m2vU5cRTr3FPVHq5FJPCXpAaTdl0NrtHID8zQOla+eKTUktHPgrjJiLKNMdrbMV2k0rhvLwmkv
 NSGJU9Rhuc5LVKroX3L5xSV+Vxom40nkEyQja5L4cZ/M/txlwi+ccxCHHkxS388jQ91NfIQiJV
 mL9lYKOb48nUWHKQ699ApwBEYFjghROB/Erb7LdfvUI9SLPWVkUUgPW59nzKnwVYOSkaxngWqX
 QCyxSrywHwPkh7dmWpBhuFMJoJ9JU0oAB+1AMLpgb9f0DPAcLZF3ov+jjZ8Xadvg5OBU7t1NZE
 tuzA/iMZIPc1Ngcs2/K1yHRe
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="136033879"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 02:17:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 02:17:09 -0700
Received: from [10.171.246.91] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 15 Sep 2021 02:17:07 -0700
Subject: Re: [PATCH v3 10/10] ARM: dts: at91: sama7g5ek: enable ADC on the
 board
To:     Eugen Hristev <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
 <20210901123013.329792-11-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <22d425df-a014-a632-d55d-ff5b95852f52@microchip.com>
Date:   Wed, 15 Sep 2021 11:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901123013.329792-11-eugen.hristev@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 01/09/2021 at 14:30, Eugen Hristev wrote:
> The ADC controller on the board is fed by a 2.5V reference voltage.
> By default the channels #14 and #15 are dedicated to analog input
> (marked AN on the board), on the connectors mikrobus1 and mikrobus2.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   arch/arm/boot/dts/at91-sama7g5ek.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
> index 4cbed98cc2f4..c46be165f2ba 100644
> --- a/arch/arm/boot/dts/at91-sama7g5ek.dts
> +++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
> @@ -122,6 +122,14 @@ spdif_out: spdif-out {
>   	};
>   };
>   
> +&adc {
> +	vddana-supply = <&vddout25>;
> +	vref-supply = <&vddout25>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mikrobus1_an_default &pinctrl_mikrobus2_an_default>;
> +	status = "okay";
> +};
> +
>   &cpu0 {
>   	cpu-supply = <&vddcpu>;
>   };
> 


-- 
Nicolas Ferre
