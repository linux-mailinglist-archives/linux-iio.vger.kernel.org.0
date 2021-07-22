Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31473D1D3B
	for <lists+linux-iio@lfdr.de>; Thu, 22 Jul 2021 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhGVE26 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Jul 2021 00:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhGVE26 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Jul 2021 00:28:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FA5C061575;
        Wed, 21 Jul 2021 22:09:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u1so4502153wrs.1;
        Wed, 21 Jul 2021 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IPyvILfcy5g4pOCZ9oUbxLJdS8m8+UwpG2eFIHIG0/c=;
        b=FnnBUFR9AJANRg5xEoaSmqlxeYelTG4x6mpxOkcibDEhEXqOybGBDAi7uGTasHsJOO
         eGu4gPmx3Lxvp9bb7yZ2O59yEjuIGxZxmyOvF0LZz5Zoh0vFE28BA4Ffyd2KMQZ+A5UA
         h7OmQWwFQYXwmSIvL5sz3wCBPvUltzp7vGPT4ktsKtpwRh+/C+ljXzm3dzZbT439vS8F
         /fN3xQMB4de6a2OKWD6wQboE5xybm+ucA/SdKfKj0Gf1946EuMZow1QUVSwAgrdm0YR/
         1oIfAV35J1K4eQdpPUC+tWXqJDdnFzmg22+dXhDJIVEMTWZqu2kF1WETTr6mKDigrF2q
         fsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IPyvILfcy5g4pOCZ9oUbxLJdS8m8+UwpG2eFIHIG0/c=;
        b=rpQXXWNJc0aBzJM1jHPusKKQmlqaLwNQwlP+6OuiSUbBwbGq383iNsZXSERWOvs+g4
         +zB4tdVAA8IE9VFvixfZjPGqZsaprXMQGSKXoqUCLJLWGw3dESfAi3Zw5zS6o/zCqZup
         w9BI2ylvzWcAECSiQFano0Wx4t6fgn7Qvl1I8oeuEEpWFgXX6m4eVrJMlOlT6fIn67s2
         pJQKXEQAN20krZUJytbHCRY/72FNGOu1LuH+oOLF3h2CdkPxcVUP6Tw4w/PsaW6A+jTQ
         O9TJhIcQ88rFJyRterFsO/CEhVqC/r6YZQnV/aXQEJJacepxkkxTkqOIE2z4T2d4Iagx
         BQPw==
X-Gm-Message-State: AOAM5306MiUnhB4AhKsLaT7T1/+7YYWtFK2Uuv4Rfy9KrR63lZZWozkg
        bceUuRXZGKHEG72inxpn4B6gUV74VLjKc93Nw64=
X-Google-Smtp-Source: ABdhPJzMYwf7dP/U8+spn9cNNq0w4H62jP6C73Zl9vHKXEXAJh2dJh2O3ouULrH7LLMd0mpVpEbotuFTnJ51RYhloPo=
X-Received: by 2002:adf:a54b:: with SMTP id j11mr46685838wrb.305.1626930571441;
 Wed, 21 Jul 2021 22:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210721105317.36742-1-cbranchereau@gmail.com>
 <20210721105317.36742-4-cbranchereau@gmail.com> <BEXLWQ.Q6JDGD8HI0S31@crapouillou.net>
In-Reply-To: <BEXLWQ.Q6JDGD8HI0S31@crapouillou.net>
From:   Christophe Branchereau <cbranchereau@gmail.com>
Date:   Thu, 22 Jul 2021 07:09:19 +0200
Message-ID: <CAFsFa86rDydfvumcA7Ld5Vx=hJyYb9_soeYfRk_we1ZofFxUgQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio/adc: ingenic: add JZ4760 support to the sadc driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Paul, thank you for all the feedback, duly noted I will V2,
there is just one I disagree with:

On Wed, Jul 21, 2021 at 8:15 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Christophe,
>
> Le mer., juil. 21 2021 at 12:53:14 +0200, citral23
> <cbranchereau@gmail.com> a =C3=A9crit :
> > Signed-off-by: citral23 <cbranchereau@gmail.com>
> > ---
> >  drivers/iio/adc/ingenic-adc.c | 64
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/drivers/iio/adc/ingenic-adc.c
> > b/drivers/iio/adc/ingenic-adc.c
> > index 40f2d8c2cf72..285e7aa8e37a 100644
> > --- a/drivers/iio/adc/ingenic-adc.c
> > +++ b/drivers/iio/adc/ingenic-adc.c
> > @@ -71,6 +71,7 @@
> >  #define JZ4725B_ADC_BATTERY_HIGH_VREF_BITS   10
> >  #define JZ4740_ADC_BATTERY_HIGH_VREF         (7500 * 0.986)
> >  #define JZ4740_ADC_BATTERY_HIGH_VREF_BITS    12
> > +#define JZ4760_ADC_BATTERY_VREF                      2500
> >  #define JZ4770_ADC_BATTERY_VREF                      1200
> >  #define JZ4770_ADC_BATTERY_VREF_BITS         12
> >
> > @@ -295,6 +296,10 @@ static const int
> > jz4740_adc_battery_scale_avail[] =3D {
> >       JZ_ADC_BATTERY_LOW_VREF, JZ_ADC_BATTERY_LOW_VREF_BITS,
> >  };
> >
> > +static const int jz4760_adc_battery_scale_avail[] =3D {
> > +     JZ4760_ADC_BATTERY_VREF, JZ4770_ADC_BATTERY_VREF_BITS,
> > +};
> > +
> >  static const int jz4770_adc_battery_raw_avail[] =3D {
> >       0, 1, (1 << JZ4770_ADC_BATTERY_VREF_BITS) - 1,
> >  };
> > @@ -339,6 +344,8 @@ static int jz4725b_adc_init_clk_div(struct device
> > *dev, struct ingenic_adc *adc)
> >       return 0;
> >  }
> >
> > +
> > +
>
> Unrelated cosmetic change - remove it.

This is not cosmetic, but to add a VREF of 2.5V for the jz4760, as per spec=
s

>
> >  static int jz4770_adc_init_clk_div(struct device *dev, struct
> > ingenic_adc *adc)
> >  {
> >       struct clk *parent_clk;
> > @@ -400,6 +407,47 @@ static const struct iio_chan_spec
> > jz4740_channels[] =3D {
> >       },
> >  };
> >
> > +static const struct iio_chan_spec jz4760_channels[] =3D {
> > +     {
> > +             .extend_name =3D "aux0",
> > +             .type =3D IIO_VOLTAGE,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .indexed =3D 1,
> > +             .channel =3D INGENIC_ADC_AUX0,
> > +             .scan_index =3D -1,
> > +     },
> > +     {
> > +             .extend_name =3D "aux",
> > +             .type =3D IIO_VOLTAGE,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .indexed =3D 1,
> > +             .channel =3D INGENIC_ADC_AUX,
> > +             .scan_index =3D -1,
> > +     },
>
> A couple of things. First, ".extend_name" is deprecated now... But
> since the driver used it before, I suppose it doesn't make sense to use
> labels just for this SoC (as we can't remove .extend_name for other
> SoCs because of ABI). So I suppose it works here, but maybe Jonathan
> disagrees.
>
> Also, you should probably use "aux1" as the channel's name instead of
> "aux", independently of the macro name you used in the .channel field.
>
> > +     {
> > +             .extend_name =3D "battery",
> > +             .type =3D IIO_VOLTAGE,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .info_mask_separate_available =3D BIT(IIO_CHAN_INFO_RAW) =
|
> > +                                             BIT(IIO_CHAN_INFO_SCALE),
> > +             .indexed =3D 1,
> > +             .channel =3D INGENIC_ADC_BATTERY,
> > +             .scan_index =3D -1,
> > +     },
>
> Swap the battery channel at the end, no? First the three AUX then the
> battery channel?
>
> The rest looks pretty good to me.
>
> Cheers,
> -Paul
>
> > +     {
> > +             .extend_name =3D "aux2",
> > +             .type =3D IIO_VOLTAGE,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .indexed =3D 1,
> > +             .channel =3D INGENIC_ADC_AUX2,
> > +             .scan_index =3D -1,
> > +     },
> > +};
> > +
> >  static const struct iio_chan_spec jz4770_channels[] =3D {
> >       {
> >               .type =3D IIO_VOLTAGE,
> > @@ -526,6 +574,20 @@ static const struct ingenic_adc_soc_data
> > jz4740_adc_soc_data =3D {
> >       .init_clk_div =3D NULL, /* no ADCLK register on JZ4740 */
> >  };
> >
> > +static const struct ingenic_adc_soc_data jz4760_adc_soc_data =3D {
> > +     .battery_high_vref =3D JZ4760_ADC_BATTERY_VREF,
> > +     .battery_high_vref_bits =3D JZ4770_ADC_BATTERY_VREF_BITS,
> > +     .battery_raw_avail =3D jz4770_adc_battery_raw_avail,
> > +     .battery_raw_avail_size =3D ARRAY_SIZE(jz4770_adc_battery_raw_ava=
il),
> > +     .battery_scale_avail =3D jz4760_adc_battery_scale_avail,
> > +     .battery_scale_avail_size =3D
> > ARRAY_SIZE(jz4760_adc_battery_scale_avail),
> > +     .battery_vref_mode =3D false,
> > +     .has_aux_md =3D true,
> > +     .channels =3D jz4760_channels,
> > +     .num_channels =3D ARRAY_SIZE(jz4760_channels),
> > +     .init_clk_div =3D jz4770_adc_init_clk_div,
> > +};
> > +
> >  static const struct ingenic_adc_soc_data jz4770_adc_soc_data =3D {
> >       .battery_high_vref =3D JZ4770_ADC_BATTERY_VREF,
> >       .battery_high_vref_bits =3D JZ4770_ADC_BATTERY_VREF_BITS,
> > @@ -621,6 +683,7 @@ static int ingenic_adc_read_raw(struct iio_dev
> > *iio_dev,
> >               return ingenic_adc_read_chan_info_raw(iio_dev, chan, val)=
;
> >       case IIO_CHAN_INFO_SCALE:
> >               switch (chan->channel) {
> > +             case INGENIC_ADC_AUX0:
> >               case INGENIC_ADC_AUX:
> >               case INGENIC_ADC_AUX2:
> >                       *val =3D JZ_ADC_AUX_VREF;
> > @@ -832,6 +895,7 @@ static int ingenic_adc_probe(struct
> > platform_device *pdev)
> >  static const struct of_device_id ingenic_adc_of_match[] =3D {
> >       { .compatible =3D "ingenic,jz4725b-adc", .data =3D
> > &jz4725b_adc_soc_data, },
> >       { .compatible =3D "ingenic,jz4740-adc", .data =3D &jz4740_adc_soc=
_data,
> > },
> > +     { .compatible =3D "ingenic,jz4760-adc", .data =3D &jz4760_adc_soc=
_data,
> > },
> >       { .compatible =3D "ingenic,jz4770-adc", .data =3D &jz4770_adc_soc=
_data,
> > },
> >       { },
> >  };
> > --
> > 2.30.2
> >
>
>
KR
CB
