Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F548A52D3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfIBJa2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 05:30:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38216 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbfIBJa2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2019 05:30:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so4435999wrx.5
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2019 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B3gF1CsBOJmlxlxtJnkF5r+kj3UhZPCxGUolNKwePN4=;
        b=EzxZRrBnIsDndhuQDm1khk3kfA0Vkzaz/UOJUpG/WuOlHWYUDK28nekQ/mmsVxusCm
         RyJBl7MIMhHx01QFPu8JHRsPjrkd72NuEmf/9h7fShIgOczV8/KAz1qt+sqFKCQRYuqd
         lV/RaqfbZza26mn3WZNX/4tSHKT97vhZCER3rrCvmGnOqqEVoMjxiNoHoAG4L0HQTa/f
         CfHZxt4jqe8Iup4W8i9R/ESyuukvFsQ4QUPttHpmDnjYj/W5VNx67P55ofaWQ7hs72k+
         VAUxewlHae9AY2lkwNxPpFDWWhp7KMOS0QqCfyF73ZavdxGrQyhZgUQeGK+2O2xD7fTo
         vgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B3gF1CsBOJmlxlxtJnkF5r+kj3UhZPCxGUolNKwePN4=;
        b=XGRoMCJAt+a9ooePikcV7zwcN/RrR8qZ9NjlVy7Qjh2NZXcu8Xb7bYLeQyaKqpdiU+
         3yfvxj/p+ajPaKedAsZCfktK90PkYRV6blxGUlZtglEsHS38HVh3/5l6inLAj2FPgyXe
         pfWlwEYITzlBNWetaD4aQY/iVxvkAmJ1ryJa4wvEojDVhAaGUecGviiUyKfS2Z/euloi
         SC4ZJMSXK3Pl+K8vcYLq6KbBAtsoIWFB2YsPHG1wv686Xwk/3FbiKQ2+422VhDgTixKR
         onra8WWvlZtK8Br+QZhANqhUzea7F6q5cNY/tJAjuxYkfDOKVx+jyA3GaxjyqZzHNmR5
         JQRA==
X-Gm-Message-State: APjAAAUMzXnMDcwzj+Dw6kOXVNOcZf2ydVYv0fFm6yW8fsOb4mag5Bd7
        bhYdXFxVBuZVnaFhKX5nkehZwQ==
X-Google-Smtp-Source: APXvYqyReJSdrYqL701rCHXpsWAjrv+epzO2ilYSKdH7yxfzsUZl2vK1pzI/Jjg7uOuc3tz4EmLTkw==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr36985738wru.27.1567416626535;
        Mon, 02 Sep 2019 02:30:26 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id 39sm31969642wrc.45.2019.09.02.02.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:30:25 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:30:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: Re: [PATCH 5/8 v2] mfd: ab8500: augment DT bindings
Message-ID: <20190902093024.GH32232@dell>
References: <20190822145233.18222-1-linus.walleij@linaro.org>
 <20190822145233.18222-6-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822145233.18222-6-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Aug 2019, Linus Walleij wrote:

> As we migrate the AB8500 GPADC driver to use IIO, we need to augment
> the bindings to account for defining the ADC channels in the device
> tree.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rebased on v5.3-rc5
> ---
>  .../devicetree/bindings/mfd/ab8500.txt        | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
> index cd9e90c5d171..05d4b473c7c8 100644
> --- a/Documentation/devicetree/bindings/mfd/ab8500.txt
> +++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
> @@ -69,6 +69,18 @@ Required child device properties:
>  - compatible             : "stericsson,ab8500-[bm|btemp|charger|fg|gpadc|gpio|ponkey|
>                                                 pwm|regulator|rtc|sysctrl|usb]";
>  
> +  A few child devices require ADC channels from the GPADC node. Those follow the
> +  standard bindings from iio/iio-bindings.txt
> +
> +  abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
> +			   temperatures
> +  ab8500_fg		 : io-channel "main_bat_v" for measuring main battery voltage
> +  ab8500_btemp		 : io-channels "btemp_ball" and "bat_ctrl" for measuring the
> +			   battery voltage

Voltage?  Not temperature?

> +  ab8500_charger	 : io-channels "main_charger_v", "main_charger_c", "vbus_v",
> +			   "usb_charger_c" for measuring voltage and current of the
> +			   different charging supplies

Are you not a fan of full stops? :)

Besides this, looks okay in general:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
