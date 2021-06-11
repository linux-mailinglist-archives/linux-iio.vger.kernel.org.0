Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8623A48CC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFKSn5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFKSn4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 14:43:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB99DC061574
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 11:41:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k15so5156756pfp.6
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGOzAnlhk0ZIelemS9uSPP3pYbH4PCf3ofr1SpRFaxc=;
        b=S1H9iCcd17Sv9WUyTnWWzcrDP0ak+4ZpAyWU+qU2hq4DW0fgHr/Y8LOGgHeatE5xnk
         ZpBv26+V4tWnPc9DRFXfU5hXSOijyUoAFCZO4U6NqhbGgVHlwmvU4XgXYqiblnIjiVnD
         7254G3nwqBBxDwjXs5sn7HRXa1jhoQQX++epNa3aiYPBkKUtDwyPaLSaZcc2noY0Srd6
         B9ZxSXwLwZDAp3EVMAOyUp64JrMsPD2vV6/BXnh9mnKk4hX9l7ah13Rge/bqMex40Ovc
         enMuqvFhZRL0Xc9noR/ctwYMIY66RFRsKk49HK9tfDIvG1N/HaWbKqgepQyvjpo09vNt
         +6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGOzAnlhk0ZIelemS9uSPP3pYbH4PCf3ofr1SpRFaxc=;
        b=mHJZE6Dmw9Wc/bwV3MspJgq43UlQu20FxOPdbU98awpSllAdo3sy0QPR4JGrb0Duco
         NIp2kX5htlAu56yT6dgVcxu0qGYWwYJ7fHInWDRDYSWR9enOVku8rVJRt5vEq5eEczNo
         BBJldaCqqNwGSPUUiGOGkHZOj+4IxSx/JeVmC0jX/nm+fs8ySDT3179+oZr66ybWmQZW
         5AgWQiyUKA0lQ0voXF0szuB2DRukf6JT/slmdcNJFtdSaMFisQWc7X4RtM/zQAxAUkmv
         npnPxkn7cFhgk/sNaj6mXQwKK7iOv2vmVijZEc3HpsgxYNKPqBWzKsEu4MQVzSEAqE+S
         wxpQ==
X-Gm-Message-State: AOAM532Gc8v8M6eiO4r6wWd+UONHMAVKaEGE2yQZoo/F0Q93ehhmpXgE
        XQDPoZxzAZPvFBfqXfcfhuXFacjzNC9Rj1S8uE4=
X-Google-Smtp-Source: ABdhPJyH14rxspsLccuvzaYLghU79Af2iEYrziMmOwKuAV9a2cLmn93XFiSRsaUCSvvxIUilOhe6sBc/JecD8+8GzpM=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr9680926pfh.73.1623436917806; Fri, 11
 Jun 2021 11:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210611182442.1971-1-stephan@gerhold.net>
In-Reply-To: <20210611182442.1971-1-stephan@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 21:41:41 +0300
Message-ID: <CAHp75Ve2G=YNL+s8zu2vT7nN+onyzUXL0ysRNBvebeP36Rnhag@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bmc150: Use more consistent and accurate
 scale values
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 9:27 PM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> It is quite strange that BMA222 and BMA222E have very close, yet
> subtly different values in their scale tables. Comparing the datasheets
> this is simply because the "Resolution" for the different measurement
> ranges are documented with different precision.
>
> For example, for +-2g the BMA222 datasheet [1] suggests a resolution
> of 15.6 mg/LSB, while the BMA222E datasheet [2] suggests 15.63 mg/LSB.
>
> Actually, there is no need to rely on the resolution given by the Bosch
> datasheets. The resolution and scale can be calculated more consistently
> and accurately using the range (e.g. +-2g) and the channel size (e.g. 8 bits).
>
> Distributing 4g (-2g to 2g) over 8 bits results in an exact resolution
> of (4g / 2^8) = 15.625 mg/LSB which is the same value as in both datasheets,
> just slightly more accurate. Multiplying g = 9.80665 m/s^2 we get a more
> accurate value for the IIO scale table.
>
> Generalizing this we can calculate the scale tables more accurately using
> (range / 2^bits) * g * 10^6 (because of IIO_VAL_INT_PLUS_MICRO).
>
> Document this and make the scale tables more consistent and accurate
> for all the variants using that formula. Now the scale tables for
> BMA222 and BMA222E are consistent and probably slightly more accurate.

Oh, oh, one more HW vendor to blame for not being mathematically precise!
We already had the very same issue in Intel and AMD documentation :-)

In full support of such fixes!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gnail.com>

> [1]: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA222.pdf
> [2]: https://www.mouser.com/datasheet/2/783/BST-BMA222E-DS004-06-1021076.pdf
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 46 ++++++++++++++-------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 43aecd4bf3a4..5ce384ebe6c7 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1088,19 +1088,21 @@ static const struct iio_chan_spec bmc150_accel_channels[] =
>  static const struct iio_chan_spec bma280_accel_channels[] =
>         BMC150_ACCEL_CHANNELS(14);
>
> +/*
> + * The range for the Bosch sensors is typically +-2g/4g/8g/16g, distributed
> + * over the amount of bits (see above). The scale table can be calculated using
> + *     (range / 2^bits) * g = (range / 2^bits) * 9.80665 m/s^2
> + * e.g. for +-2g and 12 bits: (4 / 2^12) * 9.80665 m/s^2 = 0.0095768... m/s^2
> + * Multiply 10^6 and round to get the values listed below.
> + */
>  static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
>         {
>                 .name = "BMA222",
>                 .chip_id = 0x03,
>                 .channels = bma222e_accel_channels,
>                 .num_channels = ARRAY_SIZE(bma222e_accel_channels),
> -               /*
> -                * The datasheet page 17 says:
> -                * 15.6, 31.3, 62.5 and 125 mg per LSB.
> -                * IIO unit is m/s^2 so multiply by g = 9.80665 m/s^2.
> -                */
> -               .scale_table = { {152984, BMC150_ACCEL_DEF_RANGE_2G},
> -                                {306948, BMC150_ACCEL_DEF_RANGE_4G},
> +               .scale_table = { {153229, BMC150_ACCEL_DEF_RANGE_2G},
> +                                {306458, BMC150_ACCEL_DEF_RANGE_4G},
>                                  {612916, BMC150_ACCEL_DEF_RANGE_8G},
>                                  {1225831, BMC150_ACCEL_DEF_RANGE_16G} },
>         },
> @@ -1109,9 +1111,9 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
>                 .chip_id = 0xF8,
>                 .channels = bma222e_accel_channels,
>                 .num_channels = ARRAY_SIZE(bma222e_accel_channels),
> -               .scale_table = { {153277, BMC150_ACCEL_DEF_RANGE_2G},
> -                                {306457, BMC150_ACCEL_DEF_RANGE_4G},
> -                                {612915, BMC150_ACCEL_DEF_RANGE_8G},
> +               .scale_table = { {153229, BMC150_ACCEL_DEF_RANGE_2G},
> +                                {306458, BMC150_ACCEL_DEF_RANGE_4G},
> +                                {612916, BMC150_ACCEL_DEF_RANGE_8G},
>                                  {1225831, BMC150_ACCEL_DEF_RANGE_16G} },
>         },
>         {
> @@ -1119,30 +1121,30 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
>                 .chip_id = 0xF9,
>                 .channels = bma250e_accel_channels,
>                 .num_channels = ARRAY_SIZE(bma250e_accel_channels),
> -               .scale_table = { {38344, BMC150_ACCEL_DEF_RANGE_2G},
> -                                {76590, BMC150_ACCEL_DEF_RANGE_4G},
> -                                {153277, BMC150_ACCEL_DEF_RANGE_8G},
> -                                {306457, BMC150_ACCEL_DEF_RANGE_16G} },
> +               .scale_table = { {38307, BMC150_ACCEL_DEF_RANGE_2G},
> +                                {76614, BMC150_ACCEL_DEF_RANGE_4G},
> +                                {153229, BMC150_ACCEL_DEF_RANGE_8G},
> +                                {306458, BMC150_ACCEL_DEF_RANGE_16G} },
>         },
>         {
>                 .name = "BMA253/BMA254/BMA255/BMC150/BMI055",
>                 .chip_id = 0xFA,
>                 .channels = bmc150_accel_channels,
>                 .num_channels = ARRAY_SIZE(bmc150_accel_channels),
> -               .scale_table = { {9610, BMC150_ACCEL_DEF_RANGE_2G},
> -                                {19122, BMC150_ACCEL_DEF_RANGE_4G},
> -                                {38344, BMC150_ACCEL_DEF_RANGE_8G},
> -                                {76590, BMC150_ACCEL_DEF_RANGE_16G} },
> +               .scale_table = { {9577, BMC150_ACCEL_DEF_RANGE_2G},
> +                                {19154, BMC150_ACCEL_DEF_RANGE_4G},
> +                                {38307, BMC150_ACCEL_DEF_RANGE_8G},
> +                                {76614, BMC150_ACCEL_DEF_RANGE_16G} },
>         },
>         {
>                 .name = "BMA280",
>                 .chip_id = 0xFB,
>                 .channels = bma280_accel_channels,
>                 .num_channels = ARRAY_SIZE(bma280_accel_channels),
> -               .scale_table = { {2392, BMC150_ACCEL_DEF_RANGE_2G},
> -                                {4785, BMC150_ACCEL_DEF_RANGE_4G},
> -                                {9581, BMC150_ACCEL_DEF_RANGE_8G},
> -                                {19152, BMC150_ACCEL_DEF_RANGE_16G} },
> +               .scale_table = { {2394, BMC150_ACCEL_DEF_RANGE_2G},
> +                                {4788, BMC150_ACCEL_DEF_RANGE_4G},
> +                                {9577, BMC150_ACCEL_DEF_RANGE_8G},
> +                                {19154, BMC150_ACCEL_DEF_RANGE_16G} },
>         },
>  };
>
> --
> 2.32.0
>


-- 
With Best Regards,
Andy Shevchenko
