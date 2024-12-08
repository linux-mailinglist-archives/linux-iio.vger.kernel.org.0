Return-Path: <linux-iio+bounces-13266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F389E8811
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 22:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6FD28111A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 21:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB81925AC;
	Sun,  8 Dec 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMtxr4z6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081E14F12D;
	Sun,  8 Dec 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733692805; cv=none; b=S+piP/5IMRvlJHnaCh+J3SOEPC7r4El1YBdvpeHyQSiA7dCsRwS+BY99Nu9rCmR5rslxK3RDQxbdJiH68VJEE/lwcZrrMpkf8ER7YcadoA25ZOm9wlor+Gxt0yfcXHXJ5/2JUZNAPiWorc1ofK+nYOUb1e6jf39DiiEhCDirntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733692805; c=relaxed/simple;
	bh=MYZaKTEGw/6f08Oh4I7OXjkjcKPbLv7UQtW7xU+AIAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KY8WDP5Nh3/SYV3elmu11r7YyFusYztAF7EmxTr0VyR1hno6MU4BTEcZOhtg9Law3JjmijvZ05gqyMtN0f5cNh09acobhN1568IsBFvCAd0XUUaet2w2oiQ6967O3HtFqvbkKmrQ2SQBoSiJSCCc6ks8WP2bc50SteXXQAaxblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMtxr4z6; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-517aea3ee2aso252971e0c.2;
        Sun, 08 Dec 2024 13:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733692802; x=1734297602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd0L3F3mQCmTB4pf+gzTeCqXtfXN9Be4txbdBbA91C0=;
        b=OMtxr4z6eU/XYmrb44iolBgIJrbdINcKiFhKQFHRbd9J7J1wjnaTEp8akPiRLkegRp
         yKNsmMkRTJceyJtEyESD+HUUXOqWdDl/qbXNuYSyU3qtiwF6XfF7ATM/PitmGmyGMJD/
         AMyq/HepN4Qzz/l7zDA18bt3qKG2B7JipaPhaLjMS7xG8sI5o0sYoC4+EV+F/zavNQ81
         vmd1vbyfQCHMMRQ0G80aMHzAo8V1qJ2WI76LOAEoYDzUrMlK+WitK8/LO4q24HkSbOTs
         baLkzcjMy7V7I4osEcu50pHCRaVa8zh1WbBico0Wmq4MTiepPQMQQz5I+WdeogMj2OoZ
         APRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733692802; x=1734297602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd0L3F3mQCmTB4pf+gzTeCqXtfXN9Be4txbdBbA91C0=;
        b=dxWDBSnRNBYI8kR/YUXgwwtjWbYehafpiJMyUiLq2y5nLk+nLLgNHwb2eHd8LlU5K3
         PIVKzNAL2YBfkNEDsUItevcEuuAsdKAfv3sljyBxJtYKswjvFKtdejKLy/0ATXi8UeWS
         TELdaSoeHZzL1zUHweJn57TW5B/i073ACQhPjjgwU+vUoLRz5iJtw+REtHB/uRNDkfNl
         eOLeT4/1b5TTWmBGsHtYuiOOebKRCSpjMVcqQdedUK80dSQ+Tm2bHrYdsb6wP4fnwuHI
         ZemdMU+O3gpwpiUrOIAnxvmDZA6mA4DMn8q8+EsvCEw2CDeY7c850pg9j7zUBeC5lRO9
         YXZg==
X-Forwarded-Encrypted: i=1; AJvYcCUbagKhh2GRGHr6RjMFoz8CWpwB5+/+Z2qLLA4FtMQGNcKet0N97uj1WPbdVniZn40+Mai/IwU/PiSt2Pucap+m7Jo=@vger.kernel.org, AJvYcCVLvdZ8P0gezBYcAN91DC4WHREjzCS9RCgISD8/Rx9IFfjRMbs/QI8Fh4ca/MLrqgVy22NDY4zrYpBW40Dn@vger.kernel.org, AJvYcCVaZdIlzG/Jl1XTl6DPb1wccLm4wbGQfpxr5EaDyacUuiZ4QJg3b4oqOjN5w1dtUfjR99FxKQ7gq0Jb@vger.kernel.org, AJvYcCWcMAMYnE6viEY2f56BpIQfrU88nuiLjSz1BCxFUqowQPKI1/5s4FJXIuDeLPsfr3eQmz7z9WUImVHe@vger.kernel.org, AJvYcCX0J/0lQcAwSP648ti7UrSBfCV3PDUQeNoPtXQ1YhpuEq/6TidpCI+O2VJFBMwkZkzBiy+IWjzNYp3Q@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt50N3f1QUW0v8Qt+P2JWoWC20dCU16yh8vH9iQZhrnkl20Nlt
	LqDWviD1L/8QIJqlTtRmH5avSvZdg4oFHCnuhPQWChfnUnkY15YRlr2fEgini/7W12E0hwfIdNE
	nbZHdhJCex6GVuZNt+aXJ2OMDkQc=
X-Gm-Gg: ASbGncsv6Jiw18UcawHGYBzIdryBRXW5GH8d3NZFsKrhbUQ9tTWENph3KPQUy7mY3ip
	LOoI7pKatGfkQPfmGAk7tgXjhomax82FX
X-Google-Smtp-Source: AGHT+IFb4A5vebbrF1bexBVFS0v5rQ0hGc4KhoH18W3fHDxyTnstJJ+DkgT2RbZ9IzoWopboHvUklYEgOsjRMKazeFY=
X-Received: by 2002:a05:6122:3d0b:b0:50a:d1e3:82f7 with SMTP id
 71dfb90a1353d-515fcad53f9mr11224596e0c.8.1733692802358; Sun, 08 Dec 2024
 13:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-11-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-11-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 21:19:36 +0000
Message-ID: <CA+V-a8tDpqtRH0KC3nTEbkCZ+E0ahUEPdMQXeh6htqAOg8r2bA@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] iio: adc: rzg2l_adc: Add support for channel 8
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:16=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The ADC on the Renesas RZ/G3S SoC includes an additional channel (channel
> 8) dedicated to reading temperature values from the Thermal Sensor Unit
> (TSU). There is a direct in-SoC connection between the ADC and TSU IPs.
>
> To read the temperature reported by the TSU, a different sampling rate
> (compared to channels 0-7) must be configured in the ADM3 register.
>
> The rzg2l_adc driver has been updated to support reading the TSU
> temperature.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - adjusted the RZG2L_ADC_MAX_CHANNELS
> - introduced rzg2l_adc_ch_to_adsmp_index() and used it accordingly
> - made the IIO_TEMP channel as raw channel as requested in the
>   review process. I also realized having it as scale channel is
>   wrong as the ADC doesn't actually report a temperature but a
>   raw value that is then converted to a temperature with the
>   help of the TSU (Thermal Sensor Unit) driver. Code from the
>   TSU driver (not yet published) that reads the TSU sensor through
>   the ADC and coverts the raw value to a temperature value is as
>   follows:
>
>
> // ...
>
> #define TSU_READ_STEPS          8
>
> /* Default calibration values, if FUSE values are missing */
> #define SW_CALIB0_VAL   1297
> #define SW_CALIB1_VAL   751
>
> #define MCELSIUS(temp)          (temp * MILLIDEGREE_PER_DEGREE)
>
> struct rzg3s_thermal_priv {
>         void __iomem *base;
>         struct device *dev;
>         struct thermal_zone_device *tz;
>         struct reset_control *rstc;
>         struct iio_channel *channel;
>         u16 calib0;
>         u16 calib1;
> };
>
> // ...
>
> static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *te=
mp)
> {
>         struct rzg3s_thermal_priv *priv =3D thermal_zone_device_priv(tz);
>         struct device *dev =3D priv->dev;
>         u32 ts_code_ave =3D 0;
>         int ret, val;
>
>         ret =3D pm_runtime_resume_and_get(dev);
>         if (ret)
>                 return ret;
>
>         for (u8 i =3D 0; i < TSU_READ_STEPS; i++) {
>                 ret =3D iio_read_channel_raw(priv->channel, &val);
>                 if (ret < 0)
>                         goto rpm_put;
>
>                 ts_code_ave +=3D val;
>                 /*
>                  * According to HW manual (section 40.4.4 Procedure for M=
easuring the Temperature)
>                  * we need to wait here at leat 3us.
>                  */
>                 usleep_range(5, 10);
>         }
>
>         ret =3D 0;
>         ts_code_ave =3D DIV_ROUND_CLOSEST(ts_code_ave, TSU_READ_STEPS);
>
>         /*
>          * According to HW manual (section 40.4.4 Procedure for Measuring=
 the Temperature)
>          * the formula to compute the temperature is as follows;
>          *
>          * Tj =3D (ts_code_ave - priv->calib0) * (165 / (priv->calib0 - p=
riv->calib1)) - 40
>          */
>         *temp =3D DIV_ROUND_CLOSEST_ULL(((u64)(ts_code_ave - priv->calib1=
) * 165),
>                                       (priv->calib0 - priv->calib1)) - 40=
;
>
>         /* Round it up to 0.5 degrees Celsius and report it in Mili Celsi=
us. */
>         *temp =3D roundup(MCELSIUS(*temp), 500);
>
> rpm_put:
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_put_autosuspend(dev);
>
>         return ret;
> }
>
> // ...
>
>
>  drivers/iio/adc/rzg2l_adc.c | 62 ++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 18 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 6740912f83c5..e8dbc5dfbea1 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -52,12 +52,13 @@
>  #define RZG2L_ADCR(n)                  (0x30 + ((n) * 0x4))
>  #define RZG2L_ADCR_AD_MASK             GENMASK(11, 0)
>
> -#define RZG2L_ADC_MAX_CHANNELS         8
> +#define RZG2L_ADC_MAX_CHANNELS         9
>  #define RZG2L_ADC_TIMEOUT              usecs_to_jiffies(1 * 4)
>
>  /**
>   * struct rzg2l_adc_hw_params - ADC hardware specific parameters
> - * @default_adsmp: default ADC sampling period (see ADM3 register)
> + * @default_adsmp: default ADC sampling period (see ADM3 register); inde=
x 0 is
> + * used for voltage channels, index 1 is used for temperature channel
>   * @adsmp_mask: ADC sampling period mask (see ADM3 register)
>   * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
>   * @default_adcmp: default ADC cmp (see ADM3 register)
> @@ -65,7 +66,7 @@
>   * @adivc: specifies if ADVIC register is available
>   */
>  struct rzg2l_adc_hw_params {
> -       u16 default_adsmp;
> +       u16 default_adsmp[2];
>         u16 adsmp_mask;
>         u16 adint_inten_mask;
>         u8 default_adcmp;
> @@ -89,15 +90,26 @@ struct rzg2l_adc {
>         u16 last_val[RZG2L_ADC_MAX_CHANNELS];
>  };
>
> -static const char * const rzg2l_adc_channel_name[] =3D {
> -       "adc0",
> -       "adc1",
> -       "adc2",
> -       "adc3",
> -       "adc4",
> -       "adc5",
> -       "adc6",
> -       "adc7",
> +/**
> + * struct rzg2l_adc_channel - ADC channel descriptor
> + * @name: ADC channel name
> + * @type: ADC channel type
> + */
> +struct rzg2l_adc_channel {
> +       const char * const name;
> +       enum iio_chan_type type;
> +};
> +
> +static const struct rzg2l_adc_channel rzg2l_adc_channels[] =3D {
> +       { "adc0", IIO_VOLTAGE },
> +       { "adc1", IIO_VOLTAGE },
> +       { "adc2", IIO_VOLTAGE },
> +       { "adc3", IIO_VOLTAGE },
> +       { "adc4", IIO_VOLTAGE },
> +       { "adc5", IIO_VOLTAGE },
> +       { "adc6", IIO_VOLTAGE },
> +       { "adc7", IIO_VOLTAGE },
> +       { "adc8", IIO_TEMP },
>  };
>
>  static unsigned int rzg2l_adc_readl(struct rzg2l_adc *adc, u32 reg)
> @@ -163,9 +175,18 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
>         rzg2l_adc_writel(adc, RZG2L_ADM(1), reg);
>  }
>
> +static u8 rzg2l_adc_ch_to_adsmp_index(u8 ch)
> +{
> +       if (rzg2l_adc_channels[ch].type =3D=3D IIO_VOLTAGE)
> +               return 0;
> +
> +       return 1;
> +}
> +
>  static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
>  {
>         const struct rzg2l_adc_hw_params *hw_params =3D adc->hw_params;
> +       u8 index =3D rzg2l_adc_ch_to_adsmp_index(ch);
>         u32 reg;
>
>         if (rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_ADBSY)
> @@ -179,6 +200,11 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_a=
dc *adc, u8 ch)
>         reg |=3D BIT(ch);
>         rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
>
> +       reg =3D rzg2l_adc_readl(adc, RZG2L_ADM(3));
> +       reg &=3D ~hw_params->adsmp_mask;
> +       reg |=3D hw_params->default_adsmp[index];
> +       rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
> +
>         /*
>          * Setup ADINT
>          * INTS[31] - Select pulse signal
> @@ -235,7 +261,7 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_d=
ev,
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW: {
> -               if (chan->type !=3D IIO_VOLTAGE)
> +               if (chan->type !=3D IIO_VOLTAGE && chan->type !=3D IIO_TE=
MP)
>                         return -EINVAL;
>
>                 guard(mutex)(&adc->lock);
> @@ -258,7 +284,7 @@ static int rzg2l_adc_read_label(struct iio_dev *iio_d=
ev,
>                                 const struct iio_chan_spec *chan,
>                                 char *label)
>  {
> -       return sysfs_emit(label, "%s\n", rzg2l_adc_channel_name[chan->cha=
nnel]);
> +       return sysfs_emit(label, "%s\n", rzg2l_adc_channels[chan->channel=
].name);
>  }
>
>  static const struct iio_info rzg2l_adc_iio_info =3D {
> @@ -332,11 +358,11 @@ static int rzg2l_adc_parse_properties(struct platfo=
rm_device *pdev, struct rzg2l
>                 if (channel >=3D hw_params->num_channels)
>                         return -EINVAL;
>
> -               chan_array[i].type =3D IIO_VOLTAGE;
> +               chan_array[i].type =3D rzg2l_adc_channels[channel].type;
>                 chan_array[i].indexed =3D 1;
>                 chan_array[i].channel =3D channel;
>                 chan_array[i].info_mask_separate =3D BIT(IIO_CHAN_INFO_RA=
W);
> -               chan_array[i].datasheet_name =3D rzg2l_adc_channel_name[c=
hannel];
> +               chan_array[i].datasheet_name =3D rzg2l_adc_channels[chann=
el].name;
>                 i++;
>         }
>
> @@ -386,7 +412,7 @@ static int rzg2l_adc_hw_init(struct device *dev, stru=
ct rzg2l_adc *adc)
>         reg &=3D ~RZG2L_ADM3_ADCMP_MASK;
>         reg &=3D ~hw_params->adsmp_mask;
>         reg |=3D FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adc=
mp) |
> -              hw_params->default_adsmp;
> +              hw_params->default_adsmp[0];
>
>         rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
>
> @@ -469,7 +495,7 @@ static int rzg2l_adc_probe(struct platform_device *pd=
ev)
>  static const struct rzg2l_adc_hw_params rzg2l_hw_params =3D {
>         .num_channels =3D 8,
>         .default_adcmp =3D 0xe,
> -       .default_adsmp =3D 0x578,
> +       .default_adsmp =3D { 0x578 },
>         .adsmp_mask =3D GENMASK(15, 0),
>         .adint_inten_mask =3D GENMASK(7, 0),
>         .adivc =3D true
> --
> 2.39.2
>
>

