Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76A3D155F
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhGURGY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 21 Jul 2021 13:06:24 -0400
Received: from aposti.net ([89.234.176.197]:46158 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236596AbhGURGY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jul 2021 13:06:24 -0400
Date:   Wed, 21 Jul 2021 18:46:49 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/6] dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
To:     citral23 <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Message-Id: <12WLWQ.Q7OL1MQHTXI52@crapouillou.net>
In-Reply-To: <20210721105317.36742-3-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
        <20210721105317.36742-3-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christophe,

Le mer., juil. 21 2021 at 12:53:13 +0200, citral23 
<cbranchereau@gmail.com> a écrit :
> The JZ4760(B) socs have 3 AUX inputs, add an entry to prepare 
> including the one named AUX in the sadc driver.
> Leaving the rest untouched as it's ABI.
> 
> Signed-off-by: citral23 <cbranchereau@gmail.com>

Please use your real name when you sign a commit.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h 
> b/include/dt-bindings/iio/adc/ingenic,adc.h
> index 4627a00e369e..a6ccc031635b 100644
> --- a/include/dt-bindings/iio/adc/ingenic,adc.h
> +++ b/include/dt-bindings/iio/adc/ingenic,adc.h
> @@ -13,5 +13,6 @@
>  #define INGENIC_ADC_TOUCH_YN	6
>  #define INGENIC_ADC_TOUCH_XD	7
>  #define INGENIC_ADC_TOUCH_YD	8
> +#define INGENIC_ADC_AUX0	9
> 
>  #endif
> --
> 2.30.2
> 


