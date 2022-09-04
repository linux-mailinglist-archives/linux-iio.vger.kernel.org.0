Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D795AC4F3
	for <lists+linux-iio@lfdr.de>; Sun,  4 Sep 2022 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiIDPX5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Sep 2022 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiIDPXz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2022 11:23:55 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7813120F
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 08:23:53 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1274ec87ad5so1578749fac.0
        for <linux-iio@vger.kernel.org>; Sun, 04 Sep 2022 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wF53HjxtR86veH7tNHBqva/Hj5Xhl68Fnyl6ylaPrRk=;
        b=FdZYmtoXbUfpevwZPExfiZoJOJfteKBm0rZg0bFDy6woJYbXO+kEbnrX2JKqn/0K5F
         iM0QYbK+tH1rrPniF27TFNGYr6wDZSNaEIy40ZhVVayzsyga+GjFk4t/8Tqb1XENcZNs
         3cHTJUb0g6JFr+n8WLAqOaPmglLjAzDWlYQu2QPPU+e+HNHe53Qhup+vmYdjTn0D96gO
         z5rDHs8KL8OPDAPtdvdNrmNXIjGNNCPewd1lQ2QRinqq+xdHF2CJSmbSLHEkma6j5dts
         RQIc3LKAbFPsrzD0/WkFKG+caZqeCjD/eJJ232N+j2X4gwCDnTurJC0QALarfEyShmZ8
         RiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wF53HjxtR86veH7tNHBqva/Hj5Xhl68Fnyl6ylaPrRk=;
        b=MpyexOADmHswZJ4e0Om/lGh/FemrIn9AIjlM/AKkqCLMXy0W/5tr4Bhb8HVK2Olqwf
         fnySnQ6RTnInapZewz/pF0zYoXExN6ZjFKexJbpzvUDEBj1mDzS1GWrS426QYBUThgFZ
         AtMK6Cl6Iv5PwSwDgQNRe08yHH/1ExopG4fnnaO6+IMERnuN2Qt2+3tGcTChI60CflyD
         O6wjXUZYaVHKNG+hlRz31EAFDch8NHckIfbn5zYwrZsjaMYAvqObw7Bl/SZ+q8sESZuI
         2cNYMggFbtyr9IRxrH2w66eEUF6aGkLwojhjucpRWzrsb4d47vuQ9lu3zgPXX0BPRPrH
         vf0Q==
X-Gm-Message-State: ACgBeo0uirajnI/RwU3CbTC8lslUuRIWUQBG3TNVyUzK+UC/HJghGu1g
        7lxvnsC9T+co05R2/1LXRnqD0iZIpxtnzPIm1CgIoA==
X-Google-Smtp-Source: AA6agR4XvDpYJdMgoQCi6PrjINAZN8b6mGWcF/9fo4JnPiIh1htSPLTLwfsWvhf94umpnpaTh6NfisJrY3xqXhh98fk=
X-Received: by 2002:a05:6870:3115:b0:11e:753e:d2e3 with SMTP id
 v21-20020a056870311500b0011e753ed2e3mr6922369oaa.175.1662305032453; Sun, 04
 Sep 2022 08:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220903222402.3426058-1-cmo@melexis.com> <20220904154535.0bb526bc@jic23-huawei>
In-Reply-To: <20220904154535.0bb526bc@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 4 Sep 2022 17:23:16 +0200
Message-ID: <CAKv63uuHpjVEPoTgcJ6QptQmkCmvWhh8eNBwibOrR0SQGLG8Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: temperature: mlx90632 Read sampling frequency
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 4 Sept 2022 at 17:19, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun,  4 Sep 2022 00:24:02 +0200
> cmo@melexis.com wrote:
>
> > From: Crt Mori <cmo@melexis.com>
> >
> > Allow users to read sensor sampling frequency to better plan the
> > application measurement requests.
>
> I didn't read this closely enough.  Why is the frequency read only?
> We'd not normally have an available attribute in that case, because
> the values aren't available if we have no way to set the value.
>

It is writable, but so far I did not want to include the change part,
because it is writing to EEPROM and that means sensor slowly gets
killed as memory has limited number of write cycles.

> Jonathan
>
> >
> > Signed-off-by: Crt Mori <cmo@melexis.com>
> > ---
> >  drivers/iio/temperature/mlx90632.c | 44 ++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index 9acd819c76a6..37edd324d6a1 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -80,6 +80,9 @@
> >  #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
> >
> >  #define MLX90632_EE_RR(ee_val) (ee_val & GENMASK(10, 8)) /* Only Refresh Rate bits */
> > +#define MLX90632_REFRESH_RATE(ee_val) (MLX90632_EE_RR(ee_val) >> 8)
> > +                                     /* Extract Refresh Rate from ee register */
> > +#define MLX90632_REFRESH_RATE_STATUS(refresh_rate) (refresh_rate << 8)
> >
> >  /* Measurement types */
> >  #define MLX90632_MTYP_MEDICAL 0
> > @@ -908,6 +911,24 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
> >       return ret;
> >  }
> >
> > +static int mlx90632_get_refresh_rate(struct mlx90632_data *data,
> > +                                  int *refresh_rate)
> > +{
> > +     unsigned int meas1;
> > +     int ret;
> > +
> > +     ret = regmap_read(data->regmap, MLX90632_EE_MEDICAL_MEAS1, &meas1);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     *refresh_rate = MLX90632_REFRESH_RATE(meas1);
> > +
> > +     return ret;
> > +}
> > +
> > +static const int mlx90632_freqs[][2] = { {0, 500000}, {1, 0}, {2, 0}, {4, 0},
> > +                                       {8, 0}, {16, 0}, {32, 0}, {64, 0} };
> > +
> >  static int mlx90632_pm_interraction_wakeup(struct mlx90632_data *data)
> >  {
> >       unsigned long now;
> > @@ -978,6 +999,15 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
> >               *val = data->object_ambient_temperature;
> >               ret = IIO_VAL_INT;
> >               break;
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             ret = mlx90632_get_refresh_rate(data, &cr);
> > +             if (ret < 0)
> > +                     goto mlx90632_read_raw_pm;
> > +
> > +             *val = mlx90632_freqs[cr][0];
> > +             *val2 = mlx90632_freqs[cr][1];
> > +             ret = IIO_VAL_INT_PLUS_MICRO;
> > +             break;
> >       default:
> >               ret = -EINVAL;
> >               break;
> > @@ -1012,12 +1042,24 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
> >       }
> >  }
> >
> > +static IIO_CONST_ATTR(sampling_frequency_available, "0.5 1 2 4 8 16 32 64");
> > +
> > +static struct attribute *mlx90632_attributes[] = {
> > +     &iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group mlx90632_attribute_group = {
> > +     .attrs = mlx90632_attributes,
> > +};
> > +
> >  static const struct iio_chan_spec mlx90632_channels[] = {
> >       {
> >               .type = IIO_TEMP,
> >               .modified = 1,
> >               .channel2 = IIO_MOD_TEMP_AMBIENT,
> >               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >       },
> >       {
> >               .type = IIO_TEMP,
> > @@ -1025,12 +1067,14 @@ static const struct iio_chan_spec mlx90632_channels[] = {
> >               .channel2 = IIO_MOD_TEMP_OBJECT,
> >               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> >                       BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
> > +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >       },
> >  };
> >
> >  static const struct iio_info mlx90632_info = {
> >       .read_raw = mlx90632_read_raw,
> >       .write_raw = mlx90632_write_raw,
> > +     .attrs = &mlx90632_attribute_group,
> >  };
> >
> >  static int mlx90632_sleep(struct mlx90632_data *data)
>
