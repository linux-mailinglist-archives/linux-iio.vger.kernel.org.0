Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2875425B374
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 20:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgIBSMC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBSMA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 14:12:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15BAC061244;
        Wed,  2 Sep 2020 11:11:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s10so145238plp.1;
        Wed, 02 Sep 2020 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6TOmOrCZtm2PKElQwKKFVR8K33LhkQtrY60ZBYOlVA=;
        b=G4+KTfIXvJ9/twpD5m8b8olPRan3z9kLrIzzjpQkpjEY0tZ1wc0D3JlIE9c8bGrfG1
         Pe+RWtZvCYb3yicE3HgDvzpVhmpjdP1uoUVWKDXwEm5n2BepWyF3w/5y+PzbQrBj/1pm
         Wg8rnif76+cyALJIPWXr1ZWOd0DONOJg3MBYaspXbRD1p2hWh+UdBOdsthJi2sQd7E2i
         kmVcIG2qlwR8BlM5g/dMpl+I9d51nVWXw9aISZnpxGiA83Gftm4I7wwLSoWxIczwvaXA
         8Gv6evpieoOiN5/6nk/4D2hfyb3bTQTH56/T/G5i6j60MTKlYFk1y4EEMd8sHxbXjW4s
         7uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6TOmOrCZtm2PKElQwKKFVR8K33LhkQtrY60ZBYOlVA=;
        b=V+eRSxyfvMAfc9LXJcCi5yDSiuntqZwJ/+7WAKDs//DTQoSXQ3w1dKV3wPIs0y/+4K
         ijULJaPl6JY5zDWHRYi2WXMZQ9y+xi4IM6miw8jl8Ymg1Toc2qz+Z0oN1qsf5ZXQ+QY6
         9fOOS7QdEgVhosBiIXY8fOaqU50vV6ruD/oxxeebaorPLEcvQQWr+oPLbkXGrOc0z+nz
         TdlIhnADCCeIMld9IubskhddMlBqCu/AXeqXAxiAT2PRGOUqHG28X2srLOL6G8jnAxu9
         rcGbr7iNlU2LBf127P/aK1W4TdHMWpsi+M6mdFFd80/BDTH4ecqMPeqttw1kuV5dp6yZ
         ssmQ==
X-Gm-Message-State: AOAM533lMhiuMDpaItTi5BR9CG3s/R+1MpmNdqSKO+3Aejecy1PwkmaO
        YMYTUha+dfpCb0Mwy5r8QQ7TVf6b19eAF1NDz+8=
X-Google-Smtp-Source: ABdhPJxQzwDKfrS7Z5FlDx0PI3CHUn0p30Uj/lSoaiER0LlTopMWMJUUXUx7/zx/l1068yQcJSKm0ZfKESACdNrKLGU=
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr3395039pjr.228.1599070317944;
 Wed, 02 Sep 2020 11:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200902145957.13861-1-krzk@kernel.org>
In-Reply-To: <20200902145957.13861-1-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Sep 2020 21:11:40 +0300
Message-ID: <CAHp75Vd3sT6Vuovsy8YQg+pdqQd3s4vU8PQNNQvUruKZOiRSAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: Consolidate Analog Devices IIO
 entries and remove Beniamin Bia
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 2, 2020 at 6:04 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Emails to Beniamin Bia bounce with no such address so remove him from
> maintainers.  After this removal, many entries for Analog Devices Inc
> IIO drivers look exactly the same so consolidate them.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
But nit-pick below.

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio <linux-iio@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Consolidate IIO entries
> ---
>  MAINTAINERS | 56 ++++-------------------------------------------------
>  1 file changed, 4 insertions(+), 52 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8107b3d5d6df..facffcf7b1d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -950,38 +950,6 @@ S: Supported
>  F:     arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
>  F:     drivers/net/ethernet/amd/xgbe/
>
> -ANALOG DEVICES INC AD5686 DRIVER
> -M:     Michael Hennerich <Michael.Hennerich@analog.com>
> -L:     linux-pm@vger.kernel.org
> -S:     Supported
> -W:     http://ez.analog.com/community/linux-device-drivers
> -F:     drivers/iio/dac/ad5686*
> -F:     drivers/iio/dac/ad5696*
> -
> -ANALOG DEVICES INC AD5758 DRIVER
> -M:     Michael Hennerich <Michael.Hennerich@analog.com>
> -L:     linux-iio@vger.kernel.org
> -S:     Supported
> -W:     http://ez.analog.com/community/linux-device-drivers
> -F:     Documentation/devicetree/bindings/iio/dac/ad5758.txt
> -F:     drivers/iio/dac/ad5758.c
> -
> -ANALOG DEVICES INC AD7091R5 DRIVER
> -M:     Beniamin Bia <beniamin.bia@analog.com>
> -L:     linux-iio@vger.kernel.org
> -S:     Supported
> -W:     http://ez.analog.com/community/linux-device-drivers
> -F:     Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> -F:     drivers/iio/adc/ad7091r5.c
> -
> -ANALOG DEVICES INC AD7124 DRIVER
> -M:     Michael Hennerich <Michael.Hennerich@analog.com>
> -L:     linux-iio@vger.kernel.org
> -S:     Supported
> -W:     http://ez.analog.com/community/linux-device-drivers
> -F:     Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> -F:     drivers/iio/adc/ad7124.c
> -
>  ANALOG DEVICES INC AD7192 DRIVER
>  M:     Alexandru Tachici <alexandru.tachici@analog.com>
>  L:     linux-iio@vger.kernel.org
> @@ -998,15 +966,6 @@ W: http://ez.analog.com/community/linux-device-drivers
>  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
>  F:     drivers/iio/adc/ad7292.c
>
> -ANALOG DEVICES INC AD7606 DRIVER
> -M:     Michael Hennerich <Michael.Hennerich@analog.com>
> -M:     Beniamin Bia <beniamin.bia@analog.com>
> -L:     linux-iio@vger.kernel.org
> -S:     Supported
> -W:     http://ez.analog.com/community/linux-device-drivers
> -F:     Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> -F:     drivers/iio/adc/ad7606.c
> -
>  ANALOG DEVICES INC AD7768-1 DRIVER
>  M:     Michael Hennerich <Michael.Hennerich@analog.com>
>  L:     linux-iio@vger.kernel.org
> @@ -1068,7 +1027,6 @@ F:        drivers/iio/imu/adis16475.c
>  F:     Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>
>  ANALOG DEVICES INC ADM1177 DRIVER
> -M:     Beniamin Bia <beniamin.bia@analog.com>
>  M:     Michael Hennerich <Michael.Hennerich@analog.com>
>  L:     linux-hwmon@vger.kernel.org
>  S:     Supported
> @@ -1135,15 +1093,6 @@ S:       Supported
>  W:     http://ez.analog.com/community/linux-device-drivers
>  F:     drivers/dma/dma-axi-dmac.c
>
> -ANALOG DEVICES INC HMC425A DRIVER
> -M:     Beniamin Bia <beniamin.bia@analog.com>
> -M:     Michael Hennerich <michael.hennerich@analog.com>
> -L:     linux-iio@vger.kernel.org
> -S:     Supported
> -W:     http://ez.analog.com/community/linux-device-drivers
> -F:     Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> -F:     drivers/iio/amplifiers/hmc425a.c
> -
>  ANALOG DEVICES INC IIO DRIVERS
>  M:     Lars-Peter Clausen <lars@metafoo.de>
>  M:     Michael Hennerich <Michael.Hennerich@analog.com>
> @@ -1152,8 +1101,12 @@ W:       http://wiki.analog.com/
>  W:     http://ez.analog.com/community/linux-device-drivers
>  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:     Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350

> +F:     Documentation/devicetree/bindings/iio/adc/adi*
> +F:     Documentation/devicetree/bindings/iio/amplifiers/adi*

I would rather see one line like
F:     Documentation/devicetree/bindings/iio/*/adi,*

Since we know that vendor,part-number is guaranteed by DT binding naming schema.

> +F:     Documentation/devicetree/bindings/iio/dac/ad5758.txt
>  F:     drivers/iio/*/ad*
>  F:     drivers/iio/adc/ltc249*
> +F:     drivers/iio/amplifiers/hmc425a.c
>  F:     drivers/staging/iio/*/ad*
>  X:     drivers/iio/*/adjd*
>
> @@ -16537,7 +16490,6 @@ F:      drivers/staging/rtl8712/
>
>  STAGING - SEPS525 LCD CONTROLLER DRIVERS
>  M:     Michael Hennerich <michael.hennerich@analog.com>
> -M:     Beniamin Bia <beniamin.bia@analog.com>
>  L:     linux-fbdev@vger.kernel.org
>  S:     Supported
>  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
