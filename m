Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A50F23F742
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHHKok (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 06:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgHHKoi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 06:44:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A129C061756;
        Sat,  8 Aug 2020 03:44:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so2400738ply.11;
        Sat, 08 Aug 2020 03:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33Obhlc0KNOUX89hNriS1w2+7EzYq956oNeQyyQWNpA=;
        b=u4rctRdV6B0VDzY4pKRy2XTtdXy0rJ8RTXRcA8TuPCk7ehOaImKXn29XH5Pz58aYpl
         z44RP+9DBX/ESFrzfZhf9PM0BrTJHVPe87FZMZ1yhQWC/6mpwuR0vhXU2ADmXEsv+Hzy
         kCEhFg/hf5Ef/GLaI4SPNqdYOGTiAFuj9U/vmgULV2de+72sUhq+PbIdwctZ7ADDQZQP
         LC+crq9Bxu9HEWKa4L+4p5ECuB/Huz5JcwOwfw+joLV1td+XXBPIbbb+3OQSpnNbRsvq
         ol7Uyu7Eq4BdjaZ9RqlbGK/x9MnukFJVb2bp5b4N7ntqNaeB5e1O+V1uhmdRPInvlTBO
         eDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33Obhlc0KNOUX89hNriS1w2+7EzYq956oNeQyyQWNpA=;
        b=JW5FwO5idCJsHg/JMWvQf2ihMkiu1eqtBDnE6GTpvWj/q66QAFhW5CvGU3tmIcthS1
         B2ScSWY4UJFON3Tj6FTAPrgQzN8+Sv350y/gpFis12g4qVuY2ooFUe3/FSrXEKphqL6C
         xCoBcLlqs77xH6gY3iTe1F4TaTPIXGx68L98c5r6Y+fGOBJ99PzpEurDITW0kZQHJ1Le
         mLzmvvAS4iAPPqAIt76Kgc7eomKMNrRBOBpDtfxodQJOcaA2gVhgLTRHcQLvdFYhnSP2
         i0WRYTdFszy56maGst5kyJkRnhaFoVOYdJXPiGnBh0I40GgE0aneJ5pifwVBaut1EsUf
         HitQ==
X-Gm-Message-State: AOAM532utHhCC1tWd831sMaOT28emOgT7uImbrnTGRGvs7VVfMIu6hNB
        9QbOgcXE/uaPQWaw3cj02hO7HNYguuAnjeWALhNYvppa0djfUg==
X-Google-Smtp-Source: ABdhPJxj4RN+GanjuoqCMvvyb0L1CWK1QascWb269xjMB4W7SxN9hJwB/6RdLsDOkoPkI+UIbkYor9Pa+++8YbNDTcs=
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr16068275plo.262.1596883474353;
 Sat, 08 Aug 2020 03:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200807232104.1256119-1-cmo@melexis.com> <20200807232104.1256119-3-cmo@melexis.com>
In-Reply-To: <20200807232104.1256119-3-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Aug 2020 13:44:17 +0300
Message-ID: <CAHp75VemS+QJ+m05KVNobYyzbqB-hcBdbLK1YbiaZWbAFJ9xfw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio:temperature:mlx90632: Adding extended
 calibration option
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 8, 2020 at 2:24 AM Crt Mori <cmo@melexis.com> wrote:
>
> For some time the market wants medical grade accuracy in medical range,
> while still retaining the declared accuracy outside of the medical range
> within the same sensor. That is why we created extended calibration
> which is automatically switched to when object temperature is too high.
>
> This patch also introduces the object_ambient_temperature variable which
> is needed for more accurate calculation of the object infra-red
> footprint as sensor's ambient temperature might be totally different
> than what the ambient temperature is at object and that is why we can
> have some more errors which can be eliminated. Currently this temperature
> is fixed at 25, but the interface to adjust it by user (with external
> sensor or just IR measurement of the other object which acts as ambient),
> will be introduced in another commit.

Thank you for an update!
My comments below.

...

>  struct mlx90632_data {
>         struct i2c_client *client;
>         struct mutex lock; /* Multiple reads for single measurement */
>         struct regmap *regmap;
>         u16 emissivity;
> +       u8 mtyp; /* measurement type - to enable extended range calculations */
> +       u32 object_ambient_temperature;
>  };

As a separate patch to have a kernel doc for this, there are plenty of
examples in the kernel, but I will show below an example

/**
 * struct foo - private data for the MLX90632 device
 * @client: I2C client of the device
 * @bar: ...
 ...
 */
struct foo {
  struct i2c_client *client;
  ... bar;
  ...
};

...

> +       if ((type != MLX90632_MTYP_MEDICAL) && (type != MLX90632_MTYP_EXTENDED))
> +               return -EINVAL;

So, just to point out what the difference between & and &&  (even for
boolean): the former one forces both sides of operand to be executed,
while && checks for only first in case of false.

...

> +static int mlx90632_read_ambient_raw_extended(struct regmap *regmap,
> +                                             s16 *ambient_new_raw, s16 *ambient_old_raw)
> +{
> +       unsigned int read_tmp;
> +       int ret;
> +
> +       ret = regmap_read(regmap, MLX90632_RAM_3(17), &read_tmp);
> +       if (ret < 0)
> +               return ret;
> +       *ambient_new_raw = (s16)read_tmp;

Again the same question, do you need all these castings?

> +       ret = regmap_read(regmap, MLX90632_RAM_3(18), &read_tmp);

These 17, 18 and 19 should be defined with descriptive names.

> +       if (ret < 0)
> +               return ret;
> +       *ambient_old_raw = (s16)read_tmp;
> +
> +       return 0;
> +}

...

> +       int tries = 4;

> +       while (tries-- > 0) {
> +               ret = mlx90632_perform_measurement(data);
> +               if (ret < 0)
> +                       goto read_unlock;
> +
> +               if (ret == 19)
> +                       break;
> +       }
> +       if (tries < 0) {
> +               ret = -ETIMEDOUT;
> +               goto read_unlock;
> +       }

Again, please use

unsigned int tries = 4; // or should be 5?

do {
  ...
} while (ret != ..._ LAST_CHANNEL && --tries);
if (!tries)
  ...

It will really make the code easier to read.

...

> +static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient_new_raw,
> +                                                s16 ambient_old_raw, s16 Ka)
> +{
> +       s64 VR_IR, kKa, tmp;
> +
> +       kKa = ((s64)Ka * 1000LL) >> 10ULL;
> +       VR_IR = (s64)ambient_old_raw * 1000000LL +
> +               kKa * div64_s64((s64)ambient_new_raw * 1000LL,
> +                               MLX90632_REF_3);
> +       tmp = div64_s64(
> +                       div64_s64((s64) object_new_raw * 1000000000000LL, MLX90632_REF_12),
> +                       VR_IR);
> +       return div64_s64(tmp << 19ULL, 1000LL);
> +}

It would be nice to have a comment on this voodoo arithmetics.

-- 
With Best Regards,
Andy Shevchenko
