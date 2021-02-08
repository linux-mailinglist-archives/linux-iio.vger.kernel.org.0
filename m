Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D83138E1
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 17:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhBHQHw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 11:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbhBHQH0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 11:07:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698AFC061788
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 08:06:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e9so9050397pjj.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiGQ1a+ocaFv/oN1twet9JTGRuf/5E5q4ifpPbH3kY4=;
        b=DVRq0eWguGA3ST4Rc5JVp5Ah4l82xyltocw00Rx4S/7cwi5unaij0xapeNrGUA6O8K
         PcTNopuHr9e6bxdn3PQcyHd4V2U1Qj30rAVa9zJIrHBbrHRszh0fgRoEeBvL9tygJGHz
         HQ66GOfY8lci3j80EUz+jPi9YbVaOFMj0FiFfoHDZ+vQUJ2cwiDwPlrptJWV+3G55UtZ
         IrQJ4ehTLdxW01DgJmRjdRZ8uw2clIfE3/DOBZE/8gs9DKdsHJmfRyv8mYa++6FyRZZZ
         bbFiQoe7mnHiYfKnKd5lK4pxKPrZU6wMzexd1xCmEK9h3RrSgK02qoVmIvJDOrJYYSkL
         gqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiGQ1a+ocaFv/oN1twet9JTGRuf/5E5q4ifpPbH3kY4=;
        b=Y6zvTKoUczmhBBP3Q+/qZdCj0sHKTeE/ZPwA8soxs1twC2RpuvO3/gW+Xwr7sxbW9w
         Mt4jEvxruVgHpvnDPrG0GGM3pfRQYyHrK6oOTOYrRTECrYNN5jXayPY0Ur4tw49Venuc
         +87LhKIWiqPr4VfwMBU+mOCoY9FhLDWXif6SiZPsH66dEWfw0x652vOUEpZVxLtBYMWf
         dUMiCjq2cVpPd5+0wvn06ysC5yFN7P0xTuTtoOIRWambWyx62VmxhVjl49ZD810txS1V
         RHbEplo9VvS19edEd7+41kg/fcAz6q7bdc9Nk6Hg1tEvyx3Iff6rmsr+XddHes880ypI
         hsLw==
X-Gm-Message-State: AOAM530tm1UlB85fo2GzsjhrhwYEaNPf9ImX5BYQyMCjchcXapm5AWO5
        BPjmJGcXLlIEHSxzIGUmEQd0HNGX5g6DkwRpTQA=
X-Google-Smtp-Source: ABdhPJzg/AXM6ZJv2Ji+SVKzjlvkY+YDUEzB9CPgC9wpPRH3XFijSIAmik/Q3roac64CNy3+NAsFKhJJz7uIFwpR1Vw=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr16728887pll.0.1612800405935; Mon, 08
 Feb 2021 08:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20210208142705.GA51260@ubuntu>
In-Reply-To: <20210208142705.GA51260@ubuntu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Feb 2021 18:06:29 +0200
Message-ID: <CAHp75Vc1VWYLO1rF-NNnW3qkgiGycgpTHvr5Q2Yn91aZcFuyJg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: ad7949: fix wrong ADC result due to incorrect bit mask
To:     Wilfried Wessner <wilfried.wessner@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 8, 2021 at 4:27 PM Wilfried Wessner
<wilfried.wessner@gmail.com> wrote:
>
> Fixes a wrong bit mask used for the ADC's result, which was caused by an
> improper usage of the GENMASK() macro. The bits higher than ADC's
> resolution are undefined and if not masked out correctly, a wrong result
> can be given. The GENMASK() macro indexing is zero based, so the mask has
> to go from [resolution - 1 , 0].


> Fixes: 7f40e0614317f ("iio:adc:ad7949: Add AD7949 ADC driver family")

>

Shouldn't be blank like here, but I think Jonathan can fix when applying.
Jonathan, can you also amend the subject (I totally forgot about
subsubsystem prefix)?
Should be like:
"iio: adc: ad7949: fix wrong results due to incorrect bit mask"

And FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>
>
> ---
>
> The issue was found in combination of an AD7682 ADC with an ARM based
> iMX7-CPU. The SPI line was analyzed with a logic analyzer and a
> discrepancy between applied voltage level and the ADC reported value
> in user space was observed. Digging into the driver code revealed an
> improper mask used for the ADC-result.
>
>
>  drivers/iio/adc/ad7949.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 5d597e5050f6..1b4b3203e428 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>         int ret;
>         int i;
>         int bits_per_word = ad7949_adc->resolution;
> -       int mask = GENMASK(ad7949_adc->resolution, 0);
> +       int mask = GENMASK(ad7949_adc->resolution - 1, 0);
>         struct spi_message msg;
>         struct spi_transfer tx[] = {
>                 {
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
