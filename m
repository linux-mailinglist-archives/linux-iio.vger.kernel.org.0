Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E929084B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Oct 2020 17:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410015AbgJPP1m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Oct 2020 11:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410006AbgJPP1l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2020 11:27:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E65C061755;
        Fri, 16 Oct 2020 08:27:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o9so1455464plx.10;
        Fri, 16 Oct 2020 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjOH7NSlzQ7luzN2AMo9usje/o0UOzhmlVRD7uHXj6M=;
        b=K9x1Rli/OUH/hZT7zUWaeKHbnNXAbCLRgnq0lD6FZZwPEaGKZS/DVU3KPE84bipH/B
         REnPrkeicA7AASNY+yqg1FXbsPnMR3zKPn6JXkOratJxVKyNVuWr4Q/nIYybDMVB0Goy
         hhGA5ji82UU8gx0AI5grKhfo9TXKvDhVfi9rhxSd21jZyg0csK1TnZdTtCIdRaARL9MA
         byqR//9GsK62PBX7Et/5o3UB7+xP8bp4zsFkWtERoMFXCas2mgovU0yHFL5Y2iiCpXg7
         LaYWioxVs2rrcylQQ6LgbaQEOswEc5Ver2g0lpaUfike4R1VFfCKlceSqmwm7EfIbJXl
         yjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjOH7NSlzQ7luzN2AMo9usje/o0UOzhmlVRD7uHXj6M=;
        b=XQggIq6WC3oMwiUIb0URf5VBzqspuRRwEOc454dt9xMbnVOJmpx5tFsEj91O22hfYy
         b9Gm8R8T3eUZDbiNFwe3QyUWzeFtgE/RYFkrV4kp1WoILeIkaxpWKuHNCHhMa3nNU6Uw
         WPEPTtumDKBjNGTbuuhQ5AT9OMY8Izh2Z3HF3JEU8JaqgHcYIF7OYad1efFrYIVxTipG
         CTdJoN+dF0nlz9T3HM77sIYi+zUd1og/9UqID0HOAtGp43ouMHYPK/nEXBL0r7IpNDC3
         y1fHFagMD7k8F82PObGrj51xWIGzpbbAg220i5YHzCuqbqAD2gpHHTjpYU1xyD2gZBd8
         YhqQ==
X-Gm-Message-State: AOAM531TaQGID03t8EVymmMv/LKeW6KoIckwDsAN6eykh+jJQKXcNbRw
        OEAnYX/q1HkS+KFLCLlG9ptMvTQrkY70++i9kXI=
X-Google-Smtp-Source: ABdhPJyEcO5/SUrS3pBTLwVxNUw44/tRmS0EyySbmvXAf/Ih98PiyY0i3H9Nfb9IY7DnsI6E/rU3+aLtOuYddVVQDwY=
X-Received: by 2002:a17:902:aa8a:b029:d3:c9dd:77d1 with SMTP id
 d10-20020a170902aa8ab02900d3c9dd77d1mr4688408plr.0.1602862060726; Fri, 16 Oct
 2020 08:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com> <1601542448-7433-4-git-send-email-gene.chen.richtek@gmail.com>
In-Reply-To: <1601542448-7433-4-git-send-email-gene.chen.richtek@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Oct 2020 18:28:29 +0300
Message-ID: <CAHp75VdPjT-wNw0_fNXBEd9ub2Eg_thM2wY9QqrjhwYcz+=ytQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] iio: adc: mt6360: Add ADC driver for MT6360
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 30, 2020 at 11:55 AM Gene Chen <gene.chen.richtek@gmail.com> wrote:
>
> From: Gene Chen <gene_chen@richtek.com>
>
> Add MT6360 ADC driver include Charger Current, Voltage, and

including

> Temperature.

...

> +#define MT6360_AICR_MASK       GENMASK(7, 2)

bits.h is missed.

...

> +#define MT6360_ADCEN_MASK      0x8000

BIT() ?

...

> +static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int *val)
> +{

> +       start_t = ktime_get();
> +       predict_end_t = ktime_add_ms(mad->last_off_timestamps[channel], 2 * ADC_WAIT_TIME_MS);
> +
> +       if (ktime_after(start_t, predict_end_t))
> +               pre_wait_time = ADC_WAIT_TIME_MS;
> +       else
> +               pre_wait_time = 3 * ADC_WAIT_TIME_MS;
> +
> +       msleep(pre_wait_time);

This looks like NIH of wait_interruptible() or so.

...

> +       while (true) {

Oh, please avoid infinite loops.

> +               ret = regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT1, rpt, sizeof(rpt));
> +               if (ret)
> +                       goto out_adc_conv;
> +
> +               /*
> +                * There are two functions, ZCV and TypeC OTP, running ADC VBAT and TS in
> +                * background, and ADC samples are taken on a fixed frequency no matter read the
> +                * previous one or not.
> +                * To avoid conflict, We set minimum time threshold after enable ADC and
> +                * check report channel is the same.
> +                * The worst case is run the same ADC twice and background function is also running,
> +                * ADC conversion sequence is desire channel before start ADC, background ADC,
> +                * desire channel after start ADC.
> +                * So the minimum correct data is three times of typical conversion time.
> +                */
> +               if ((rpt[0] & MT6360_RPTCH_MASK) == channel)
> +                       break;
> +
> +               msleep(ADC_WAIT_TIME_MS);
> +       }

So, a new NIH of regmap_read_poll_timeout() ?

...

> +       /* rpt[1]: ADC_HI_BYTE, rpt[2]: ADC_LOW_BYTE */
> +       *val = rpt[1] << 8 | rpt[2];

get_unalined_be16() and hence redundant comment.

...

> +static int mt6360_adc_read_offset(struct mt6360_adc_data *mad, int channel, int *val)
> +{
> +       *val = (channel == MT6360_CHAN_TEMP_JC) ? -80 : 0;
> +       return IIO_VAL_INT;

> +

Misplaced blank line.

> +}

> +static const char *mt6360_channel_labels[MT6360_CHAN_MAX] = {
> +       "usbid", "vbusdiv5", "vbusdiv2", "vsys", "vbat", "ibus", "ibat", "chg_vddp", "temp_jc",
> +       "vref_ts", "ts"

Leave comma.
And split  either by power of two or equally between the lines (seems
like 8 + 3 here).

> +};

...

> +       /* Reset all channel off time to the current one */
> +       all_off_time = ktime_get();
> +       for (i = 0; i < MT6360_CHAN_MAX; i++)
> +               info->last_off_timestamps[i] = all_off_time;

memset32() / memset64() / memset_l()
(Not applicable, but JFYI: memset_p() also present)

-- 
With Best Regards,
Andy Shevchenko
