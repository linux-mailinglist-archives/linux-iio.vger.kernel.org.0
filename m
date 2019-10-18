Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7613DBFDE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 10:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbfJRI1w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 04:27:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38051 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392728AbfJRI1w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 04:27:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so5185378wmi.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2019 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ww8D46R/iz0M8OWNdAJMU4FTOzZogVexyyKuuvMCEt0=;
        b=O4Hobt1TGGMLv8+tHJSPveoaKIQiifOnqrDH85/4y8D8WwnXXg1bUsAC3WGMWI6afN
         CESIITEdLDRBffGVN+a9bgWdZAKJ5uvWELvTZijhHH3v8Xq+hJXGsEW9QWdfyXk6l+DR
         icnNCFW5Y3WEiPHmU0kFwKLJ0BpzbE8IelJy+BEqMI2I97oaXmKcS5QI0NF1W08Vpl0y
         3UD6xJOyXTE05atqlwQx+U8g+hBOMGtIr1PzjMrAJTgkrJ5zbxhjCDt9138rH17p+ctg
         /UY3w0TZOJPWkawbkpNl7E9R2TaVA8eyXeL1q4n7TEXa/4Ay1n4+glS65tHKePRRTfhk
         tGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ww8D46R/iz0M8OWNdAJMU4FTOzZogVexyyKuuvMCEt0=;
        b=Z/DFukUwp/q09fxnPGmr/itEvjtWknTW/rmkqdC/VrUApK2rvC5l76/moz0GXAC/6q
         DfLM8+YZ91IdotygB1raheGsOziA2Tk2lWiMXGor6Fiwi/K4F+BKf8cJ9zVhpjbdkLrV
         Cs0WU9LMUEH5FzAfgplvUUKFGosIRO6W4nTeb+yddJY5NlxB86xV90wgj7lrRJaUYWTI
         HecnqBorrGWXp0jPHgNdoDg14V2HnpGItS3N0/SLaE8EBGUbOfe/Rkk+LNsf2ZSY83lQ
         M9h1Bq5C2CWU9mNFzeTTbmMQukFdvR/gqrwtI1EljYTrIZtrC0BGuMk3CCPe1DF4sEE5
         eZMg==
X-Gm-Message-State: APjAAAWedf7uxzwriow9U197mM6uZGJHKynsLI45WHhOA9G0ArFlnUNO
        aSoqQgjqevVgHmc6JIwjCsSO7g==
X-Google-Smtp-Source: APXvYqxB315RfZZv+gPwnZ+X9v/2+XSQIrMAc78oD/faOGyqexsPFI38bRRG9a0/K2vptl3vN7zZig==
X-Received: by 2002:a05:600c:21da:: with SMTP id x26mr6526767wmj.152.1571387269490;
        Fri, 18 Oct 2019 01:27:49 -0700 (PDT)
Received: from dell (89-145-231-171.xdsl.murphx.net. [89.145.231.171])
        by smtp.gmail.com with ESMTPSA id i3sm1560274wrw.69.2019.10.18.01.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 01:27:48 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:27:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] mfd: ab8500: Fix up the GPADC binding example
Message-ID: <20191018082747.GW4365@dell>
References: <20191018075429.5544-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018075429.5544-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Oct 2019, Linus Walleij wrote:

> This fixes up the missed device node examples from using
> underscores to using dashes as pointed out by Rob.

Patch is okay.  Subject is not correct.

dt-bindings: mfd: XXX

> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Jonathan, you can either apply this standalone or
> squash it into the previous DT binding patch while fixing
> up the Capitalization Of First Word After Dash in the
> Subject.
> ---
>  Documentation/devicetree/bindings/mfd/ab8500.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
> index b6bc30d7777e..a4f70f0d653f 100644
> --- a/Documentation/devicetree/bindings/mfd/ab8500.txt
> +++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
> @@ -181,26 +181,26 @@ ab8500 {
>  		};
>          };
>  
> -	ab8500_temp {
> +	ab8500-temp {
>  		compatible = "stericsson,abx500-temp";
>  		io-channels = <&gpadc 0x06>,
>  			      <&gpadc 0x07>;
>  		io-channel-name = "aux1", "aux2";
>  	};
>  
> -	ab8500_battery: ab8500_battery {
> +	ab8500_battery: ab8500-battery {
>  		stericsson,battery-type = "LIPO";
>  		thermistor-on-batctrl;
>  	};
>  
> -	ab8500_fg {
> +	ab8500-fg {
>  		compatible = "stericsson,ab8500-fg";
>  		battery	   = <&ab8500_battery>;
>  		io-channels = <&gpadc 0x08>;
>  		io-channel-name = "main_bat_v";
>  	};
>  
> -	ab8500_btemp {
> +	ab8500-btemp {
>  		compatible = "stericsson,ab8500-btemp";
>  		battery	   = <&ab8500_battery>;
>  		io-channels = <&gpadc 0x02>,
> @@ -209,7 +209,7 @@ ab8500 {
>  				"bat_ctrl";
>  	};
>  
> -	ab8500_charger {
> +	ab8500-charger {
>  		compatible	= "stericsson,ab8500-charger";
>  		battery		= <&ab8500_battery>;
>  		vddadc-supply	= <&ab8500_ldo_tvout_reg>;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
