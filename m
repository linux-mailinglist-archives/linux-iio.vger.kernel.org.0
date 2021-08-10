Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69203E836D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhHJTLO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhHJTLO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 15:11:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF921C0613C1;
        Tue, 10 Aug 2021 12:10:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a8so34480145pjk.4;
        Tue, 10 Aug 2021 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Da6wJReHrcDQVkAOyF8U8ePTmkNSaOtjDSMcilTlogI=;
        b=bENRq13kLVFXXCOudAOcCBTiLmab3hXnEYDyyOE4/7yUMmI5Gqtpqb86oeUQJjIANf
         YlNdfNN1D6ubHdNT7+sZNhjk0+WSGCI9Rb/u5OIrD4PqONCCtNG01tUPCea3qWhU24Y3
         qxhWraoQ1fmE8B3W0CInFhE+uRJS9RlHCuKuooD1hc5UPoPHTYZQugKi6+576bs0Jn8O
         /dnAw3IDOYKfOz577zguCtF2J2aekTsN5PL7X/CZEk1hUDzdkJURPXaiXp1pkLx2XIuw
         2N1lTq4oMG9248pGvV10Ja5QZDPedjkXmStUgBLiIHgol0ACIPxfSYDw+uBe4DGiGdiO
         6u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Da6wJReHrcDQVkAOyF8U8ePTmkNSaOtjDSMcilTlogI=;
        b=O7VVO8Sc7S25rRhQGP00iCN+d/KebszARzXILJm2DKIi7rmUGCyXWKxsGWT/izPrS4
         Pz2+PkC/d8shH6t7/oECrCVJGf8ppvGj3aXheSDChCRPyV6vTMVp7q8ee8tjZ7X+RnUW
         /1mLXsIRPeZJ/4q7qgzYn8tbrgPxv+Ao6LSdjymP7HGsAXwUlZ/CAyLT+eiXAgYFxF6R
         wT4YBq9gx8UO91yDUpmRKBb5gzEk3DWSD6pYAujRDm81YPSL1nrsGr+vbuDGQGfpsAYn
         uoICrQtjscKkHIO6+YtdvJPtWMGOVrYWA60J1puxuacxods9A9+L36E1wvvGeTssYDa2
         dg0A==
X-Gm-Message-State: AOAM533TkO3foo1E9s9Hu8UoDHGLgThCAd8lCnNXDvVJLWjuBKFw8Lwv
        bb0BYy+X7SUo+5qx6d5mm6et0tlxckamjbmLDws=
X-Google-Smtp-Source: ABdhPJw+QY86a1jAG3g5wjYzpU661Tfv80JIv4dffIBdFIqES0J1ZHpRwK48oi+6xDGteNZHLNbK6w5uDM0TXfOte2k=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr1157469pgg.4.1628622651293;
 Tue, 10 Aug 2021 12:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210810184536.34443-1-puranjay12@gmail.com> <20210810184536.34443-3-puranjay12@gmail.com>
In-Reply-To: <20210810184536.34443-3-puranjay12@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Aug 2021 22:10:14 +0300
Message-ID: <CAHp75Vf9zbGn-MoP2sd2Fv+bCPZtidCm4RrNKY+QUv1Vnb3PHA@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] iio: accel: Add driver support for ADXL355
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 10, 2021 at 9:45 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> ADXL355 is a 3-axis MEMS Accelerometer. It offers low noise density,
> low 0g offset drift, low power with selectable measurement ranges.
> It also features programmable high-pass and low-pass filters.

Thanks for an update. Seems some of the comments left unaddressed.

...

> +#include <linux/device.h>

No need. There is no user for that.
A forward declaration is enough.

> +#include <linux/regmap.h>

...

> +       u32 multiplier;
> +       u64 div;
> +       u64 odr;
> +       u64 rem;

div and rem seems of the same nature, you may put them on one line.


> +       int i;
> +
> +       odr = mul_u64_u32_shr(adxl355_odr_table[data->odr][0], 1000000, 0) +
> +                             adxl355_odr_table[data->odr][1];
> +
> +       for (i = 0; i < ARRAY_SIZE(adxl355_hpf_3db_multipliers); i++) {
> +               multiplier = adxl355_hpf_3db_multipliers[i];
> +               div = div64_u64_rem(mul_u64_u32_shr(odr, multiplier, 0),
> +                                   100000000000000UL, &rem);
> +
> +               data->adxl355_hpf_3db_table[i][0] = div;
> +               data->adxl355_hpf_3db_table[i][1] = div_u64(rem, 100000000);
> +       }

Here, I didn't get if those powers-of-two are some kind of units?
If no, we may have locally defined SI prefexes for them.

> +}

...

> +static int adxl355_set_hpf_3db(struct adxl355_data *data,
> +                              enum adxl355_hpf_3db hpf)
> +{
> +       int ret = 0;
> +
> +       mutex_lock(&data->lock);
> +
> +       if (data->hpf_3db == hpf)

> +               goto unlock;

This...

> +       ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> +       if (ret < 0)
> +               goto out_unlock;

...and this are kinda easy to confuse. Please, give them better names.

> +       ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
> +                                ADXL355_FILTER_HPF_MSK,
> +                                FIELD_PREP(ADXL355_FILTER_HPF_MSK, hpf));
> +       if (!ret)
> +               data->hpf_3db = hpf;
> +
> +out_unlock:
> +       ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> +unlock:
> +       mutex_unlock(&data->lock);
> +       return ret;
> +}
> +
> +static int adxl355_set_calibbias(struct adxl355_data *data,
> +                                enum adxl355_chans chan, int calibbias)
> +{

> +       int ret = 0;

Redundant assignment.

...

> +out_unlock:

And as per above function, this one does more than simple unlock.

> +       ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> +       mutex_unlock(&data->lock);
> +       return ret;
> +}

...

> +static const struct iio_info adxl355_info = {
> +       .read_raw       = adxl355_read_raw,
> +       .write_raw      = adxl355_write_raw,
> +       .read_avail     = &adxl355_read_avail

+ comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
