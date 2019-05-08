Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE721788B
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfEHLpB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 07:45:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54333 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfEHLpB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 May 2019 07:45:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203so1705056wmb.4
        for <linux-iio@vger.kernel.org>; Wed, 08 May 2019 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l3GvcY7+LxbIORg1GuBtuIu7AC5wBX2cmnXnWgsKaLM=;
        b=gomqhzozH1rPJo3UJO0LZmi16/eDaOhei9FnFZbmPkMw+Ae+GpcAXhcWY/fbEQ7Mcd
         jfm+RSPSYQH+M2R/mAdCvtQ2z7hEmftDMLlfvH1EQhWzs/Y9dAEcQ0zrv/WMy2Jz/bVI
         s8gRF2XMt7TNmzxX9sRGkt/DlL97XTbncGL8s1KPNtiR4SKKtALPOzi6BQVgtgLyvpdL
         gGO8tvk6um9LyLYMLIV0uOffPgRE0mlHJm+VaQiSUaSiMC149so0mcLKfzNW2Nu54BV9
         ezygmQAuvEgCeK3CrKIz0EqNqgcgwWbLODiLXKjl0ZwSYyRpWJS+esOiqDdy6r5XNqIF
         tDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l3GvcY7+LxbIORg1GuBtuIu7AC5wBX2cmnXnWgsKaLM=;
        b=IVu+qaLbivBxNeFnoytNjyUVLiq4YsQ2hHcaOm5/Enb9r41jmw3uh8gwIzUO6vjZN0
         HzBDGuHg51KhMVSYbe8p7rbgq3+fHtB6npoRyJ9cQSwN0xFMau1eqIH4q+DNuWu0Nx7i
         6NJT9tOhDLWxWm+GhqX7q24PstV4yoZy/tVUMohg5+I/gnOQTjnLT9zWiy5BXH6O5fBf
         34SQdwUPMQ+iDWTO4A5H0JvJmzeZO51xj/Rn7Ikk6g2Ly6VMIRCerrb5SaOSVJ9X52ZS
         lnJvxcfTE3DBGJsxVEv+K9gguDqNGS9gaNn31NkTz7Nc0aY6IIb5j3WhgVyJrvjDxxq+
         QsLw==
X-Gm-Message-State: APjAAAW7hALdvlNUt7xArxs9Vuml7HLUBQYMAmhPfqgPdT5OnhmDBr3Z
        SoSgYscNH8qiRGnW5TP+IW4F7w==
X-Google-Smtp-Source: APXvYqzbsOXVFvnhQCKFgeir9JCHCmFZIU6UKosT98os4blSJ2GmkYH6+ek8sOTv5dGFKfg8zfirIg==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr2714770wmj.88.1557315899750;
        Wed, 08 May 2019 04:44:59 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id m8sm28373099wrg.18.2019.05.08.04.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:44:58 -0700 (PDT)
Date:   Wed, 8 May 2019 12:44:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: mfd: Add H6 GPADC binding
Message-ID: <20190508114456.GF31645@dell>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
 <20190503072813.2719-6-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503072813.2719-6-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 03 May 2019, Yangtao Li wrote:

> This patch adds documentation for the H6 GPADC binding.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt   | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> index 86dd8191b04c..eeaf27eb8abd 100644
> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -5,11 +5,22 @@ and sometimes as a touchscreen controller.
>  
>  Required properties:
>    - compatible: "allwinner,sun8i-a33-ths",
> +		"allwinner,sun50i-h6-ths",
>    - reg: mmio address range of the chip,
> -  - #thermal-sensor-cells: shall be 0,
> +  - #thermal-sensor-cells: shall be 0 for sun8i-a33-ths,
> +			   shall be 1 for sun50i-h6-ths,
>    - #io-channel-cells: shall be 0,
>  
> -Example:
> +Optional properties:
> +  - clocks: Must contain an entry for each entry in clock-names.
> +	    See common clock-bindings.txt for details.

Nit: This should be a relative path, like the reset.txt below.

> +  - clock-names: A list of clock names. For sun50i-h6-ths, it must contain
> +		 "bus".
> +  - resets: Must contain an entry for each entry in reset-names.
> +	    See ../reset/reset.txt for details.
> +  - reset-names: For sun50i-h6-ths, it must contain "bus".
> +
> +Example1:
>  	ths: ths@1c25000 {
>  		compatible = "allwinner,sun8i-a33-ths";
>  		reg = <0x01c25000 0x100>;
> @@ -17,6 +28,18 @@ Example:
>  		#io-channel-cells = <0>;
>  	};
>  
> +Example2:
> +	ths: ths@1c25000 {
> +		compatible = "allwinner,sun50i-h6-ths";
> +		reg = <0x05070400 0x100>;
> +		clocks = <&ccu CLK_BUS_THS>;
> +		clock-names = "bus";
> +		resets = <&ccu RST_BUS_THS>;
> +		reset-names = "bus";
> +		#thermal-sensor-cells = <1>;
> +		#io-channel-cells = <0>;
> +       };
> +
>  sun4i, sun5i and sun6i SoCs are also supported via the older binding:
>  
>  sun4i resistive touchscreen controller

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
