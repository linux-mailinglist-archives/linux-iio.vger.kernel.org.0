Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5DF1ADAF3
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 12:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgDQKZJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726207AbgDQKZJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 06:25:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D794DC061A0C;
        Fri, 17 Apr 2020 03:25:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so900780pgc.8;
        Fri, 17 Apr 2020 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b59Nt5scDU2I1ZDjfM7PvNLErzWlHfnlPXD2jIEsqco=;
        b=QF/62xKOAGBXrpJVXe2CSzq0qfuJV5Jn7SLuPzRkDM4nnT6httYseD3xm1KN+exzJ0
         3iKkz7+eNWQRw+cT9m4eZTnQy3Tsl1WNIxmUjXFLWKXJ7TKMw63RNaHN/EXoFzNRK3UR
         KJ+dvaUFseoBPUECuk1agUwjwK5PNIHj1983Ona1WMgbwEO2izQfnYGSxO5YhrZfjrns
         sM7Ncz8OeHUvb7/lpmMOa5WhKfVojort7uihb7WWkV4Ts8QyYDOKdQze8ORPoD4LjIlP
         5pO9swd8Mh2Bjw/XYEbJXbm1U1SIQw+mzGmQeizLNi0BGA5mMG3FCv2EUgIMmFFVQ60i
         JUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b59Nt5scDU2I1ZDjfM7PvNLErzWlHfnlPXD2jIEsqco=;
        b=Oijhq2f3DXgrcWVJCxlAcukulNOfbYPSlKnxLGFXLGeUwumGqE12mfiGZGyI1OXoRh
         jGX3gpOgx4Q3bNlsWnmWVofR0/W6+4Yacs98gK3FZEKc0aoR9TrNvwnNx7Ie3N4tEErG
         vI7B5CpcTTfk18ojj2rEHMkMhSAhSQmI1HsX/z9l+BCmw7HJKPgdFIfyO/f71WaQfI3T
         7cQacOzP0DYfIFvhHeuLThPQP4+e59SK4RIHmV+OhH01nJmxTS/fDoHwDjACjmns/OLf
         W4wLkiJmndN9kJz0yAacBsB0r87rFGpHQsJUy8YOR8/fgzLFzHQMtPxF6UgYABfcYDAs
         yT8Q==
X-Gm-Message-State: AGi0PuZuRD6ttE2O5IsJboSyuuDrh0ghHf9t02uefA0xkc6kraHAhAcU
        5/S/7O0RmqPDuJ6rfg1/oyVtGjOppiuFflYQrqM=
X-Google-Smtp-Source: APiQypJB5C0r8xWDag1OlivjFfDKudf0TLNN5OTS7UcWSbL6KeqEjucuUfSLSXFbYi3TBDhBThCAum6+tRIRm/lhiOg=
X-Received: by 2002:aa7:9097:: with SMTP id i23mr2448171pfa.170.1587119108436;
 Fri, 17 Apr 2020 03:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200415212257.161238-1-alexandre.belloni@bootlin.com> <20200415212257.161238-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20200415212257.161238-3-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 13:24:57 +0300
Message-ID: <CAHp75VcHRYLqk_b6H6TXqer98c6ZzSKctW=CbMvHzdThPxjfgQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ti-ads8344: remove tx_buf from driver data
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

On Thu, Apr 16, 2020 at 4:08 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> There is no need to keep tx_buf around, it is only used for the conversion.
>

As Lars said. And some SPI controllers may want to DMA even one byte, so, NAK.


> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/iio/adc/ti-ads8344.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> index 6da50ea35217..9b2d3a8ea6bd 100644
> --- a/drivers/iio/adc/ti-ads8344.c
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -22,13 +22,7 @@
>  struct ads8344 {
>         struct spi_device *spi;
>         struct regulator *reg;
> -       /*
> -        * Lock protecting access to adc->tx_buff and rx_buff,
> -        * especially from concurrent read on sysfs file.
> -        */
> -       struct mutex lock;
> -
> -       u8 tx_buf ____cacheline_aligned;
> +       struct mutex lock; /* protect from concurrent conversions */
>  };
>
>  #define ADS8344_VOLTAGE_CHANNEL(chan, si)                              \
> @@ -77,13 +71,13 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
>         int ret;
>         u8 buf[3];
>
> -       adc->tx_buf = ADS8344_START;
> +       buf[0] = ADS8344_START;
>         if (!differential)
> -               adc->tx_buf |= ADS8344_SINGLE_END;
> -       adc->tx_buf |= ADS8344_CHANNEL(channel);
> -       adc->tx_buf |= ADS8344_CLOCK_INTERNAL;
> +               buf[0] |= ADS8344_SINGLE_END;
> +       buf[0] |= ADS8344_CHANNEL(channel);
> +       buf[0] |= ADS8344_CLOCK_INTERNAL;
>
> -       ret = spi_write(spi, &adc->tx_buf, 1);
> +       ret = spi_write(spi, buf, 1);
>         if (ret)
>                 return ret;
>
> --
> 2.25.2
>


-- 
With Best Regards,
Andy Shevchenko
