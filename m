Return-Path: <linux-iio+bounces-13265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4739A9E8808
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 22:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C09C164391
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE27192B74;
	Sun,  8 Dec 2024 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwcx4bBi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570213A865;
	Sun,  8 Dec 2024 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733692033; cv=none; b=c4JeYP03AVTo//TUef24JzYyAqfn9ZjROYR0y77U6kMaTEQ2MkL/H9pxTk47KPq4Q9cc9aNmfKZeUYcEPmbVNt4KNp26ddrh9RHSDv/4SjoHIh12K+p+kM1njU6R8Fb+wfQcsG8Wf7QeqGDepe6N2q6XVUqDzV0QUWczMj2X9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733692033; c=relaxed/simple;
	bh=9tNYOV5TqqYbyBebVauc7ebsVmi+8QDg5NKUsfQMpSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr+zoMYVXPNH5mZf6WnHLXG1B+CUpTEzcSteZL7CjZ43DHdpH/UvWWPMzolwYoWKW0hmKrjDRog18NnTHucG/CfytqDW4DvPOkvw5jNsiCtjsn518K4J7BI14O+I67KZB2mk2dgmszI8Tsqf3lfYAVB+4Vq3dfftu12p4G4Tdz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cwcx4bBi; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-517aea3ee2aso250028e0c.2;
        Sun, 08 Dec 2024 13:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733692031; x=1734296831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4+OM9OGW2I6P+0c+wJAxM/Lz27zv2jMkUrN0t15gVY=;
        b=Cwcx4bBiO0I06HL2wEv4xpDcclCOOGAFK7FwH7ClIwS6Nt1g04jcniNwu8VIN+c9Mo
         kbLqvaWmiHwHUjTK4fAAvom5olpGhMwz19UhNv5kICbs+oJLZOcK6nvXL9Hr7mj+7hNB
         M78MlJTGYNyvDmgxRcSr1MufMLDwN7QdV8kna9K9TMLkxG/EkNeilkj4dlNAA2ilcTXq
         Fpg7A8ivw8cuePdDyRO5sLLNs65HphIugpncVpCGsW3j8OMvRcnxd/3wCPPHP1yKaepM
         tM0gxp+YygEIgB2PILrkj88lXeua5BQ/jXX4mPxycP3rA1FOmYZKTFGgOvTxPhmY2zvr
         7yfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733692031; x=1734296831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4+OM9OGW2I6P+0c+wJAxM/Lz27zv2jMkUrN0t15gVY=;
        b=dzy48C4DID7d/zIiE7GHeXC9JhpwGBYS2HX1fEOGPzwyjInG1/HGlSExKo3Vz7kVkY
         GCMoJzHnBZ4wa0xZt5aFbMv/dqGXWll5xr3PkQCgZnCJuSchEE+gjRPw9WE3D0DLTOXx
         Se08Wa8TMi9NRe4Lp83nen9FEmqn6xAyZb02TsqtqT6UqHktUElKn2C6BOcU/6iyly3n
         TKXQlDrlhYfN9+R/D9d43S3XQLpQK6QawI5zg1yaV6b5955n1N4+gy/cuke2RG67Ij7f
         8nufpfrqoHZdCZuE754NOJc3BWIwGAllFKe1XJpwTnnjyQxD3dbbD9/9figyTEaF970i
         Xc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVApJCjrJClqXzB2ZKxoANw1xoV1qX4etW1VniK+37/42+NH5fbuChZ5y+P9jz41WeU4Jl0TRs81+O065G/rGIXmek=@vger.kernel.org, AJvYcCViBPnmK+1qHG8HFezVH9MMUfecIah6PmUz1/CzIyuMamt/Pc/cST15y0PzNFbeyLp6sCVW7VZK9hh6nDHC@vger.kernel.org, AJvYcCWZb73TLdHhCD7KG2PPGlN0JG81xIExUOnuKncsqi+YXgyYSDA638JaP8eepftMUg2AoTtNQnrYGzgl@vger.kernel.org, AJvYcCWe/BLRW/DS/LDyQwZsOBPyKn7LSB5uqce/EkzjgmNlBbrXo9K5j3c4RExpo45LKspQ/0Y5MYzMcViU@vger.kernel.org, AJvYcCWnQnwQoutP3Vs1QCxh2jGNCOSdxqIIBYtXPBTGDYnuvjUbzV9OBHiEH7Q5z/p004UwhTleOuuH8Adq@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCNpcCnshRYF3WeJvWBjc23/Mo/Dn7mdCIqYwcInuf1iVL2W8
	WThExHEIDzHCYn4RT9DB+pp2buiSzih8+bac4BEsdCUp/vNq4Nh53hKQPplJDxSS3z0AQftx0wB
	csVQ52OzpnoTf2jUsi9gaFlyXKfs=
X-Gm-Gg: ASbGnctqqZbn+JnqOHf4H6ugq8dsHWJ1MSztAaUt9JjAkPJixSa5FtavGk3XXum3Oos
	zb/GMLc4v1TmPE34fPV8eZjIPMDxqhofP
X-Google-Smtp-Source: AGHT+IEUVEUG85etVq+sE0bbhoitub03G0rIJjZ9yYz1CiNrUaLq4inTuWLZupc8vg7TvOR6oGnRVoE6IIaabCKF410=
X-Received: by 2002:a05:6122:2009:b0:50d:3ec1:1546 with SMTP id
 71dfb90a1353d-515fca1233emr10297600e0c.4.1733692030811; Sun, 08 Dec 2024
 13:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-10-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 21:06:45 +0000
Message-ID: <CA+V-a8vQm+JDL19TwjcNBD-xGzFApZywJCqVisBVRBNC2xwLHA@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] iio: adc: rzg2l_adc: Prepare for the addition of
 RZ/G3S support
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
> The ADC IP available on the RZ/G3S differs slightly from the one found on
> the RZ/G2L. The identified differences are as follows:
> - different number of channels (one being used for temperature conversion=
);
>   consequently, various registers differ
> - different default sampling periods
> - the RZ/G3S variant lacks the ADVIC register.
>
> To accommodate these differences, the rzg2l_adc driver has been updated b=
y
> introducing the struct rzg2l_adc_hw_params, which encapsulates the
> hardware-specific differences between the IP variants. A pointer to an
> object of type struct rzg2l_adc_hw_params is embedded in
> struct rzg2l_adc_data.
>
> Additionally, the completion member of struct rzg2l_adc_data was relocate=
d
> to avoid potential padding, if any.
>
> The code has been adjusted to utilize hardware-specific parameters stored
> in the new structure instead of relying on plain macros.
>
> The check of chan->channel in rzg2l_adc_read_raw() function, against the
> driver specific mask was removed as the subsystem should have already
> been done this before reaching the rzg2l_adc_read_raw() function. Along
> with it the local variable ch was dropped as chan->channel could be used
> instead.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - kept the RZG2L_ADC_MAX_CHANNELS as suggested in the review process;
>   along with it, last_val[] is now again statically alocated; code
>   from v1 around last_val has been adjusted to align with the new
>   approach
> - dropped ch variable from rzg2l_adc_read_raw() and adjusted the
>   patch description to reflect it.
>
>  drivers/iio/adc/rzg2l_adc.c | 87 +++++++++++++++++++++++++------------
>  1 file changed, 59 insertions(+), 28 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index c3f9f95cdbba..6740912f83c5 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -33,20 +33,15 @@
>  #define RZG2L_ADM1_MS                  BIT(2)
>  #define RZG2L_ADM1_BS                  BIT(4)
>  #define RZG2L_ADM1_EGA_MASK            GENMASK(13, 12)
> -#define RZG2L_ADM2_CHSEL_MASK          GENMASK(7, 0)
>  #define RZG2L_ADM3_ADIL_MASK           GENMASK(31, 24)
>  #define RZG2L_ADM3_ADCMP_MASK          GENMASK(23, 16)
> -#define RZG2L_ADM3_ADCMP_E             FIELD_PREP(RZG2L_ADM3_ADCMP_MASK,=
 0xe)
> -#define RZG2L_ADM3_ADSMP_MASK          GENMASK(15, 0)
>
>  #define RZG2L_ADINT                    0x20
> -#define RZG2L_ADINT_INTEN_MASK         GENMASK(7, 0)
>  #define RZG2L_ADINT_CSEEN              BIT(16)
>  #define RZG2L_ADINT_INTS               BIT(31)
>
>  #define RZG2L_ADSTS                    0x24
>  #define RZG2L_ADSTS_CSEST              BIT(16)
> -#define RZG2L_ADSTS_INTST_MASK         GENMASK(7, 0)
>
>  #define RZG2L_ADIVC                    0x28
>  #define RZG2L_ADIVC_DIVADC_MASK                GENMASK(8, 0)
> @@ -57,12 +52,27 @@
>  #define RZG2L_ADCR(n)                  (0x30 + ((n) * 0x4))
>  #define RZG2L_ADCR_AD_MASK             GENMASK(11, 0)
>
> -#define RZG2L_ADSMP_DEFAULT_SAMPLING   0x578
> -
>  #define RZG2L_ADC_MAX_CHANNELS         8
> -#define RZG2L_ADC_CHN_MASK             0x7
>  #define RZG2L_ADC_TIMEOUT              usecs_to_jiffies(1 * 4)
>
> +/**
> + * struct rzg2l_adc_hw_params - ADC hardware specific parameters
> + * @default_adsmp: default ADC sampling period (see ADM3 register)
> + * @adsmp_mask: ADC sampling period mask (see ADM3 register)
> + * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
> + * @default_adcmp: default ADC cmp (see ADM3 register)
> + * @num_channels: number of supported channels
> + * @adivc: specifies if ADVIC register is available
> + */
> +struct rzg2l_adc_hw_params {
> +       u16 default_adsmp;
> +       u16 adsmp_mask;
> +       u16 adint_inten_mask;
> +       u8 default_adcmp;
> +       u8 num_channels;
> +       bool adivc;
> +};
> +
>  struct rzg2l_adc_data {
>         const struct iio_chan_spec *channels;
>         u8 num_channels;
> @@ -72,8 +82,9 @@ struct rzg2l_adc {
>         void __iomem *base;
>         struct reset_control *presetn;
>         struct reset_control *adrstn;
> -       struct completion completion;
>         const struct rzg2l_adc_data *data;
> +       const struct rzg2l_adc_hw_params *hw_params;
> +       struct completion completion;
>         struct mutex lock;
>         u16 last_val[RZG2L_ADC_MAX_CHANNELS];
>  };
> @@ -154,6 +165,7 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
>
>  static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
>  {
> +       const struct rzg2l_adc_hw_params *hw_params =3D adc->hw_params;
>         u32 reg;
>
>         if (rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_ADBSY)
> @@ -163,7 +175,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_ad=
c *adc, u8 ch)
>
>         /* Select analog input channel subjected to conversion. */
>         reg =3D rzg2l_adc_readl(adc, RZG2L_ADM(2));
> -       reg &=3D ~RZG2L_ADM2_CHSEL_MASK;
> +       reg &=3D ~GENMASK(hw_params->num_channels - 1, 0);
>         reg |=3D BIT(ch);
>         rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
>
> @@ -175,7 +187,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_ad=
c *adc, u8 ch)
>          */
>         reg =3D rzg2l_adc_readl(adc, RZG2L_ADINT);
>         reg &=3D ~RZG2L_ADINT_INTS;
> -       reg &=3D ~RZG2L_ADINT_INTEN_MASK;
> +       reg &=3D ~hw_params->adint_inten_mask;
>         reg |=3D (RZG2L_ADINT_CSEEN | BIT(ch));
>         rzg2l_adc_writel(adc, RZG2L_ADINT, reg);
>
> @@ -184,6 +196,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_ad=
c *adc, u8 ch)
>
>  static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_=
adc *adc, u8 ch)
>  {
> +       const struct rzg2l_adc_hw_params *hw_params =3D adc->hw_params;
>         struct device *dev =3D indio_dev->dev.parent;
>         int ret;
>
> @@ -201,7 +214,7 @@ static int rzg2l_adc_conversion(struct iio_dev *indio=
_dev, struct rzg2l_adc *adc
>
>         if (!wait_for_completion_timeout(&adc->completion, RZG2L_ADC_TIME=
OUT)) {
>                 rzg2l_adc_writel(adc, RZG2L_ADINT,
> -                                rzg2l_adc_readl(adc, RZG2L_ADINT) & ~RZG=
2L_ADINT_INTEN_MASK);
> +                                rzg2l_adc_readl(adc, RZG2L_ADINT) & ~hw_=
params->adint_inten_mask);
>                 ret =3D -ETIMEDOUT;
>         }
>
> @@ -219,7 +232,6 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_d=
ev,
>  {
>         struct rzg2l_adc *adc =3D iio_priv(indio_dev);
>         int ret;
> -       u8 ch;
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW: {
> @@ -228,12 +240,11 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio=
_dev,
>
>                 guard(mutex)(&adc->lock);
>
> -               ch =3D chan->channel & RZG2L_ADC_CHN_MASK;
> -               ret =3D rzg2l_adc_conversion(indio_dev, adc, ch);
> +               ret =3D rzg2l_adc_conversion(indio_dev, adc, chan->channe=
l);
>                 if (ret)
>                         return ret;
>
> -               *val =3D adc->last_val[ch];
> +               *val =3D adc->last_val[chan->channel];
>
>                 return IIO_VAL_INT;
>         }
> @@ -258,6 +269,7 @@ static const struct iio_info rzg2l_adc_iio_info =3D {
>  static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
>  {
>         struct rzg2l_adc *adc =3D dev_id;
> +       const struct rzg2l_adc_hw_params *hw_params =3D adc->hw_params;
>         unsigned long intst;
>         u32 reg;
>         int ch;
> @@ -270,11 +282,11 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev=
_id)
>                 return IRQ_HANDLED;
>         }
>
> -       intst =3D reg & RZG2L_ADSTS_INTST_MASK;
> +       intst =3D reg & GENMASK(hw_params->num_channels - 1, 0);
>         if (!intst)
>                 return IRQ_NONE;
>
> -       for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS)
> +       for_each_set_bit(ch, &intst, hw_params->num_channels)
>                 adc->last_val[ch] =3D rzg2l_adc_readl(adc, RZG2L_ADCR(ch)=
) & RZG2L_ADCR_AD_MASK;
>
>         /* clear the channel interrupt */
> @@ -287,6 +299,7 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_i=
d)
>
>  static int rzg2l_adc_parse_properties(struct platform_device *pdev, stru=
ct rzg2l_adc *adc)
>  {
> +       const struct rzg2l_adc_hw_params *hw_params =3D adc->hw_params;
>         struct iio_chan_spec *chan_array;
>         struct rzg2l_adc_data *data;
>         unsigned int channel;
> @@ -302,7 +315,7 @@ static int rzg2l_adc_parse_properties(struct platform=
_device *pdev, struct rzg2l
>         if (!num_channels)
>                 return dev_err_probe(&pdev->dev, -ENODEV, "no channel chi=
ldren\n");
>
> -       if (num_channels > RZG2L_ADC_MAX_CHANNELS)
> +       if (num_channels > hw_params->num_channels)
>                 return dev_err_probe(&pdev->dev, -EINVAL, "num of channel=
 children out of range\n");
>
>         chan_array =3D devm_kcalloc(&pdev->dev, num_channels, sizeof(*cha=
n_array),
> @@ -316,7 +329,7 @@ static int rzg2l_adc_parse_properties(struct platform=
_device *pdev, struct rzg2l
>                 if (ret)
>                         return ret;
>
> -               if (channel >=3D RZG2L_ADC_MAX_CHANNELS)
> +               if (channel >=3D hw_params->num_channels)
>                         return -EINVAL;
>
>                 chan_array[i].type =3D IIO_VOLTAGE;
> @@ -336,6 +349,7 @@ static int rzg2l_adc_parse_properties(struct platform=
_device *pdev, struct rzg2l
>
>  static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
>  {
> +       const struct rzg2l_adc_hw_params *hw_params =3D adc->hw_params;
>         u32 reg;
>         int ret;
>
> @@ -353,11 +367,13 @@ static int rzg2l_adc_hw_init(struct device *dev, st=
ruct rzg2l_adc *adc)
>         if (ret)
>                 goto exit_hw_init;
>
> -       /* Only division by 4 can be set */
> -       reg =3D rzg2l_adc_readl(adc, RZG2L_ADIVC);
> -       reg &=3D ~RZG2L_ADIVC_DIVADC_MASK;
> -       reg |=3D RZG2L_ADIVC_DIVADC_4;
> -       rzg2l_adc_writel(adc, RZG2L_ADIVC, reg);
> +       if (hw_params->adivc) {
> +               /* Only division by 4 can be set */
> +               reg =3D rzg2l_adc_readl(adc, RZG2L_ADIVC);
> +               reg &=3D ~RZG2L_ADIVC_DIVADC_MASK;
> +               reg |=3D RZG2L_ADIVC_DIVADC_4;
> +               rzg2l_adc_writel(adc, RZG2L_ADIVC, reg);
> +       }
>
>         /*
>          * Setup AMD3
> @@ -368,8 +384,10 @@ static int rzg2l_adc_hw_init(struct device *dev, str=
uct rzg2l_adc *adc)
>         reg =3D rzg2l_adc_readl(adc, RZG2L_ADM(3));
>         reg &=3D ~RZG2L_ADM3_ADIL_MASK;
>         reg &=3D ~RZG2L_ADM3_ADCMP_MASK;
> -       reg &=3D ~RZG2L_ADM3_ADSMP_MASK;
> -       reg |=3D (RZG2L_ADM3_ADCMP_E | RZG2L_ADSMP_DEFAULT_SAMPLING);
> +       reg &=3D ~hw_params->adsmp_mask;
> +       reg |=3D FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adc=
mp) |
> +              hw_params->default_adsmp;
> +
>         rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
>
>  exit_hw_init:
> @@ -392,6 +410,10 @@ static int rzg2l_adc_probe(struct platform_device *p=
dev)
>
>         adc =3D iio_priv(indio_dev);
>
> +       adc->hw_params =3D device_get_match_data(dev);
> +       if (!adc->hw_params || adc->hw_params->num_channels > RZG2L_ADC_M=
AX_CHANNELS)
> +               return -EINVAL;
> +
>         ret =3D rzg2l_adc_parse_properties(pdev, adc);
>         if (ret)
>                 return ret;
> @@ -444,8 +466,17 @@ static int rzg2l_adc_probe(struct platform_device *p=
dev)
>         return devm_iio_device_register(dev, indio_dev);
>  }
>
> +static const struct rzg2l_adc_hw_params rzg2l_hw_params =3D {
> +       .num_channels =3D 8,
> +       .default_adcmp =3D 0xe,
> +       .default_adsmp =3D 0x578,
> +       .adsmp_mask =3D GENMASK(15, 0),
> +       .adint_inten_mask =3D GENMASK(7, 0),
> +       .adivc =3D true
> +};
> +
>  static const struct of_device_id rzg2l_adc_match[] =3D {
> -       { .compatible =3D "renesas,rzg2l-adc",},
> +       { .compatible =3D "renesas,rzg2l-adc", .data =3D &rzg2l_hw_params=
 },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
> --
> 2.39.2
>
>

