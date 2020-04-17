Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D591ADB5F
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 12:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgDQKoq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 06:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729143AbgDQKoq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 06:44:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D431BC061A0C;
        Fri, 17 Apr 2020 03:44:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k18so834146pll.6;
        Fri, 17 Apr 2020 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d42f2h9ctMaCehQT0Tc2kOQMVp8paPlwrO5LTLzjmso=;
        b=SVQ6DyRAWbehkdkiK/O0D40lSjnmEUva1SldvnuirK5asqzHVVStpftfknnhtopkoQ
         JVR2ivIHCCcQPvzp/kbNI8Qi0j8gHg3Nsuwy2PK5ly3vp1XDM5Rrrp/rOo3RflYu9RJu
         97UxjpxFCjRZSNgSUdy6OohTWetibZciF6Nx+Rnwswl5UumoY31//R/Nwk+OMdp4yf6w
         5jnTxqBxXjkS7dsjSHxZq7uyM78L28GF0J8zkbcWPKF/x9dqvbWBWLLW4yCdg58+CsJ6
         v6FVAj7gpnVWaNxy5G5uKYj+bESZXF8cQaQp+Ps4WM7+bszcJlzjJuE9IBVEHrhPLqU2
         G07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d42f2h9ctMaCehQT0Tc2kOQMVp8paPlwrO5LTLzjmso=;
        b=hGyuVPS5YLYPzG74GsGpGcPDueT/53U3UgT65EFpxOBRuCvTqiHSOlO6Wh/uWbqZJa
         NZQ+hJxXV/doD1NKcL5zR4yVQWU8ZLof8znup7H3prv+jN/nHbgrvFF9i5EYa9x9B+yS
         Fe1DYZQMd+1y/HiUbz4OyIGmcUFcyNhtF9ulbLlI6gMaHMl/2dMqQNPRjF3nIRowfKm1
         l6VG3UEKYZNtSS/iNeV6h469UM2DX2S7ZSB6lo4jM4jJjx3qh+qnYfYsNY2ZPj32ERuY
         SDoK1IOEy5HPW5uT1rrDWCBQufmllRhnZlZKMcYX0JV497ySvwKiJ1A6Z1VAx1DXJmfk
         5rsA==
X-Gm-Message-State: AGi0PuahxmIOVX5MTq7ruAlt3a1Nv6mzr/qCKP+pn2MHol+vC7zZBiuN
        srd+/vMU9QEKnHZAL12MfWSgaifcTHIK5Gm/ZhQ=
X-Google-Smtp-Source: APiQypJjy/nqbVYfePMYGlGonxzGHni7ixbPvw6nM8NVNtQvWlT+TZXaBKPQHXx4t6E3c5CrBIMxJnkLntjvHE9hVcc=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr3570968pjb.143.1587120285359;
 Fri, 17 Apr 2020 03:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com> <20200416205428.437503-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20200416205428.437503-2-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 13:44:33 +0300
Message-ID: <CAHp75Vddt-UKkP+b8W2CDYjt5kzggwQ+gTjrieigeYhM=e4Tig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads8344: properly byte swap value
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 16, 2020 at 11:55 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> The first received byte is the MSB, followed by the LSB so the value needs
> to be byte swapped.
>
> Also, the ADC actually has a delay of one clock on the SPI bus. Read three
> bytes to get the last bit.
>

Can you show example of what is read and what is expected to be a correct value?
Because it seems I have been reported with similar issue on other TI
ADC chip [1]. Perhaps we have to fix all of them?

[1]: https://github.com/edison-fw/meta-intel-edison/issues/108

> Fixes: 8dd2d7c0fed7 ("iio: adc: Add driver for the TI ADS8344 A/DC chips")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/iio/adc/ti-ads8344.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> index 9a460807d46d..abe4b56c847c 100644
> --- a/drivers/iio/adc/ti-ads8344.c
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -29,7 +29,7 @@ struct ads8344 {
>         struct mutex lock;
>
>         u8 tx_buf ____cacheline_aligned;
> -       u16 rx_buf;
> +       u8 rx_buf[3];
>  };
>
>  #define ADS8344_VOLTAGE_CHANNEL(chan, si)                              \
> @@ -89,11 +89,11 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
>
>         udelay(9);
>
> -       ret = spi_read(spi, &adc->rx_buf, 2);
> +       ret = spi_read(spi, adc->rx_buf, sizeof(adc->rx_buf));
>         if (ret)
>                 return ret;
>
> -       return adc->rx_buf;
> +       return adc->rx_buf[0] << 9 | adc->rx_buf[1] << 1 | adc->rx_buf[2] >> 7;
>  }
>
>  static int ads8344_read_raw(struct iio_dev *iio,
> --
> 2.25.2
>


-- 
With Best Regards,
Andy Shevchenko
