Return-Path: <linux-iio+bounces-24511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78444BA62AA
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 20:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282644A2DD7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A222288D5;
	Sat, 27 Sep 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcwN0ppe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34438DE1
	for <linux-iio@vger.kernel.org>; Sat, 27 Sep 2025 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758998642; cv=none; b=QAIixa/4K8vHaXyD8pQVr7nprpKVsGOk6z4IOMwQh1hUj2XutXQYxB39lKuD0EAxpfLsFyddV4tjbo3kXxncTVjsZiDzSUCdTa1zFfAyjwNK+jd7OmENmlw8DLB0s4Z/ExeSXYr3dSvsQBlYBgkM5cV+FuUXSn3JREZZLQB6UUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758998642; c=relaxed/simple;
	bh=IhBKQD+ec1TxejDrHgOgmL6Q6Ndh6ROqZ90IhFJAEs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIgnh0HPPvqFToJvWqjhZO1sDsJsfT/dyNXW3wkZgPqSJ+SVyoenz0Wt3rsl7rGeOlh/3BdsN6J87imXd+lRI3WAgqkM21W1xSkoFEke9/5WgU2nqoZ231rXw3Woqo7k0eeSlExZAwMcH2DqhgmqS3J0LDzlEsyE/DZ8ChUapCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcwN0ppe; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so38840861fa.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Sep 2025 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758998638; x=1759603438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpbpO3uaLa7SATTKzH/Q1+Sh9Y16VeZC5lWHZiw7e6E=;
        b=ZcwN0ppey5vn77HAt6UNjve/aMb0aBNBHoP+ZeXaxT6ZTzNBKJHW1JWfldi7piQ4rg
         gV0O3eUIpOQW0fmf0SvJUPprum/faW4OENQm/AvkkOU8qKbZmj3iQ4LEbVfF0Y1RcsiV
         woKJPZGCSLtQnXXcXZZO4cwH959a8R7y5A6j4uSeQnCzZkZ7R7jx92NmDdAYZZef797D
         YsQx8TSLe3KatsQ8nfnrf9mjIOjaoDH+JDhXMo79kkahg3uf714PbN03CZywCa03FgCF
         JU3aKkCMlLwTUwiVlvSfAeMPg/PZ7AL12Fh8gVDkiG9/ELoDPgCJwDLxTkdEvcPaEbnx
         SawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758998638; x=1759603438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpbpO3uaLa7SATTKzH/Q1+Sh9Y16VeZC5lWHZiw7e6E=;
        b=klVxS/3Zs7Xegj2zo4j738LlsjgUKXG8pDxVu4ESGW6EUkCtdbCFjZDJ3i8Mt70lws
         /gvkuftxk/jfb5CNdcmVXCVOTRKIN7gPntOSf1sK5+5GgAdYpan+BKPfCkw8iQfl8BzL
         G4M8AAPbXucbubHy1yeSvMClps9z0qJruDHI7pn3zRhy4H+hOaTtPhPt22qs+wExrXT0
         j2gw6q4BNo/bPOKKrbJbaJaBZ61DFVAoHCKdtpdkmJt8TzlTNN81iFzMjWRiIP24W++j
         uAg2RVLAhtZq+CzwDIBk293ic+hgWYa46XQ2EMjBsF0rZkR9A7QTdFH72mMgUwGu0AkT
         EKqA==
X-Forwarded-Encrypted: i=1; AJvYcCUtqkk1i2psQay4ZNAdnSHVoKJE3+tDJbCOxDVNlOPoaGGrEAhKT2Og4KZinE7OfyukZjqvFE453Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2hxSY4Nv2Ju/4szF6DX2SYlRyEHmhtc3g5mY5/nobTVMAP9Z
	LI87T4z0Z1NZntk3M7Cg76T9ayFfLnHYCOwK8LeEEwa5NLxoaj2DCq9DQTG/j9QHz5lIw6SBcCs
	hxxDat8M7iuBKbXyhhA2Le7Tv0m6zYLU=
X-Gm-Gg: ASbGncuAy3TlESWVPKPpDWYzKMiy7sVuOqhpfhNid7hPQsmGb1LxmXQMzER42/+6ElZ
	rY+s4hPob7NHQq3R/fGvG4oGnDn3NH6lDCJJgM67gm5Fk+VQFdRbFwpeI4Xlt3t4HqlD4kmYf3+
	ToSpXUVSoa3IjOsnrJa8nkrI40CC6BOTojZPP+sMZiEDlXsGajuHzeQaiUJn0W6neIHu8tU8TTi
	ogqR2Xgyn+wQFVTlA==
X-Google-Smtp-Source: AGHT+IHuH8QgTCNhgau9kvdOt+4QV9wGi73pSK+IyObadraAxIMbCfRdNYbCJ0YZWNuZzMG39NHcsZpB8I6STo3aXLM=
X-Received: by 2002:a05:651c:19a6:b0:352:b6c0:d33e with SMTP id
 38308e7fff4ca-36f7ccdf2a8mr35099631fa.11.1758998637878; Sat, 27 Sep 2025
 11:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925170942.259314-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250925170942.259314-1-akshayaj.lkd@gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Sun, 28 Sep 2025 00:13:46 +0530
X-Gm-Features: AS18NWAlzQ1cKyuu0h-gSYt1u5cj296hVWTaNUahd5-gupQQFT_AlagkI_7MUBo
Message-ID: <CAE3SzaRfeU9E78YNCofjgRZf76pDFEGxDdA9XwTF2_WAb8zj4Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bma400: Refactor generic interrupt configuration
To: dan@dlrobertson.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:39=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.=
com> wrote:
>
> Refactor generic interrupt configuration to replace hard-coded
> register values with logical macros and enums, thereby making the
> configuration understandable and in-style with common kernel
> patterns.
>
> Introduce a const struct with a helper to map event direction to the
> corresponding generic interrupt and sanitize the input before use.
>
> Rename activity_event_en() to generic_event_en() to better describe
> its role in activity and inactivity detection.
>
> No functional changes done.
>
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
>
> Changes since v1:
> - Address Nuno's feedback of using a helper function to sanitize dir.
> - Fixed a bug introduced in v1 changes (incorrect bit set in GENINT_CONFI=
G0 register).
> - Rename bma400_activity_event_en() to bma400_generic_event_en(), since
>   bma400 offers 3 variety of events related to activity. Renaming to gene=
ric
>   makes it more relatable to the functionality.
> - Added Testing summary.
> - Edited minor comment.
>
> Testing Summary:
> - Tested on raspberrypi 4b and 7-semi bma400 sensor breakout board.
> - Since no functional impact is there, so before functionality is
>   expected to be equal to after change functionality.
> - Tested mapping of GEN1 and GEN2 both on INT1 pin as before.
> - Tested both activity and inactivity detection by setting attributes
>   events/in_accel_mag_falling_en as well as events/in_accel_mag_rising_en=
.
> - Did read and writes on various attributes such that write_event_config(=
),
>   write_event_value() and read_event_value() callbacks are triggered.
>
>  drivers/iio/accel/bma400.h      |  71 ++++++++++++--
>  drivers/iio/accel/bma400_core.c | 163 ++++++++++++++++++++------------
>  2 files changed, 161 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 932358b45f17..ab7d1d139b66 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -68,7 +68,19 @@
>  #define BMA400_CMD_REG              0x7e
>
>  /* Interrupt registers */
> -#define BMA400_INT_CONFIG0_REG     0x1f
> +#define BMA400_INT_CONFIG0_REG                 0x1f
> +#define BMA400_INT_CONFIG0_ORTN_CHG_MASK       BIT(1)
> +#define BMA400_INT_CONFIG0_GEN1_MASK           BIT(2)
> +#define BMA400_INT_CONFIG0_GEN2_MASK           BIT(3)
> +#define BMA400_INT_CONFIG0_FIFO_FULL_MASK      BIT(5)
> +#define BMA400_INT_CONFIG0_FIFO_WTRMRK_MASK    BIT(6)
> +#define BMA400_INT_CONFIG0_DRDY_MASK           BIT(7)
> +
> +enum generic_intr {
> +       GEN1_INTR,
> +       GEN2_INTR
> +};
> +
>  #define BMA400_INT_CONFIG1_REG     0x20
>  #define BMA400_INT1_MAP_REG        0x21
>  #define BMA400_INT_IO_CTRL_REG     0x24
> @@ -96,15 +108,53 @@
>  #define BMA400_ACC_ODR_MIN_HZ       12
>
>  /* Generic interrupts register */
> -#define BMA400_GEN1INT_CONFIG0      0x3f
> -#define BMA400_GEN2INT_CONFIG0      0x4A
> -#define BMA400_GEN_CONFIG1_OFF      0x01
> -#define BMA400_GEN_CONFIG2_OFF      0x02
> -#define BMA400_GEN_CONFIG3_OFF      0x03
> -#define BMA400_GEN_CONFIG31_OFF     0x04
> -#define BMA400_INT_GEN1_MSK         BIT(2)
> -#define BMA400_INT_GEN2_MSK         BIT(3)
> -#define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
> +#define BMA400_GENINT_CONFIG_REG_BASE  0x3f
> +#define BMA400_NUM_GENINT_CONFIG_REGS  11
> +#define BMA400_GENINT_CONFIG_REG(gen_intr, config_idx) \
> +       (BMA400_GENINT_CONFIG_REG_BASE +                \
> +       (gen_intr) * BMA400_NUM_GENINT_CONFIG_REGS +    \
> +       (config_idx))
> +
> +/* Generic Interrupt Config0 register */
> +#define BMA400_GENINT_CONFIG0_HYST_MASK                        GENMASK(1=
, 0)
> +#define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK                GENMASK(3=
, 2)
> +#define BMA400_GENINT_CONFIG0_DATA_SRC_MASK            BIT(4)
> +#define BMA400_GENINT_CONFIG0_X_EN_MASK                        BIT(5)
> +#define BMA400_GENINT_CONFIG0_Y_EN_MASK                        BIT(6)
> +#define BMA400_GENINT_CONFIG0_Z_EN_MASK                        BIT(7)
> +
> +enum bma400_hysteresis_config {
> +       NO_HYSTERESIS,
> +       HYSTERESIS_24MG,
> +       HYSTERESIS_48MG,
> +       HYSTERESIS_96MG
> +};
> +
> +enum bma400_accel_data_src {
> +       ACCEL_FILT1,
> +       ACCEL_FILT2
> +};
> +
> +enum bma400_ref_updt_mode {
> +       BMA400_REF_MANUAL_UPDT_MODE,
> +       BMA400_REF_ONETIME_UPDT_MODE,
> +       BMA400_REF_EVERYTIME_UPDT_MODE,
> +       BMA400_REF_EVERYTIME_LP_UPDT_MODE
> +};
> +
> +/* Generic Interrupt Config1 register */
> +#define BMA400_GENINT_CONFIG1_AXES_COMB_MASK           BIT(0)
> +#define BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK          BIT(1)
> +
> +enum bma400_genintr_acceleval_axescomb {
> +       BMA400_EVAL_X_OR_Y_OR_Z,
> +       BMA400_EVAL_X_AND_Y_AND_Z,
> +};
> +
> +enum bma400_detect_criterion {
> +       BMA400_DETECT_INACTIVITY,
> +       BMA400_DETECT_ACTIVITY,
> +};
>
>  /* TAP config registers */
>  #define BMA400_TAP_CONFIG           0x57
> @@ -119,6 +169,7 @@
>  #define BMA400_TAP_QUIETDT_MSK      GENMASK(5, 4)
>  #define BMA400_TAP_TIM_LIST_LEN     4
>
> +
>  /*
>   * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
>   * converting to micro values for +-2g range.
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_c=
ore.c
> index 85e23badf733..aabbe74e1db7 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -121,6 +121,29 @@ struct bma400_data {
>         __be16 duration;
>  };
>
> +struct bma400_genintr_info {
> +       u8 genintr;
> +       unsigned int intrmask;
> +       enum iio_event_direction dir;
> +       enum bma400_detect_criterion detect_mode;
> +};
> +
> +/* Lookup struct for determining GEN1/GEN2 based on dir */
> +static const struct bma400_genintr_info bma400_genintrs[] =3D {
> +       [IIO_EV_DIR_RISING] =3D {
> +               .genintr =3D GEN1_INTR,   /* 0 for GEN1 */
> +               .intrmask =3D BMA400_INT_CONFIG0_GEN1_MASK,
> +               .dir =3D IIO_EV_DIR_RISING,
> +               .detect_mode =3D BMA400_DETECT_ACTIVITY,
> +       },
> +       [IIO_EV_DIR_FALLING] =3D {
> +               .genintr =3D GEN2_INTR,   /* 1 for GEN2 */
> +               .intrmask =3D BMA400_INT_CONFIG0_GEN2_MASK,
> +               .dir =3D IIO_EV_DIR_FALLING,
> +               .detect_mode =3D BMA400_DETECT_INACTIVITY,
> +       }
> +};
> +
>  static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
>  {
>         switch (reg) {
> @@ -1114,10 +1137,10 @@ static int bma400_read_event_config(struct iio_de=
v *indio_dev,
>         case IIO_ACCEL:
>                 switch (dir) {
>                 case IIO_EV_DIR_RISING:
> -                       return FIELD_GET(BMA400_INT_GEN1_MSK,
> +                       return FIELD_GET(BMA400_INT_CONFIG0_GEN1_MASK,
>                                          data->generic_event_en);
>                 case IIO_EV_DIR_FALLING:
> -                       return FIELD_GET(BMA400_INT_GEN2_MSK,
> +                       return FIELD_GET(BMA400_INT_CONFIG0_GEN2_MASK,
>                                          data->generic_event_en);
>                 case IIO_EV_DIR_SINGLETAP:
>                         return FIELD_GET(BMA400_S_TAP_MSK,
> @@ -1155,63 +1178,83 @@ static int bma400_steps_event_enable(struct bma40=
0_data *data, int state)
>         return 0;
>  }
>
> -static int bma400_activity_event_en(struct bma400_data *data,
> -                                   enum iio_event_direction dir,
> -                                   int state)
> +static inline const struct bma400_genintr_info *
> +get_bma400_genintr_info(enum iio_event_direction dir)
>  {
> -       int ret, reg, msk, value;
> -       int field_value =3D 0;
> -
>         switch (dir) {
>         case IIO_EV_DIR_RISING:
> -               reg =3D BMA400_GEN1INT_CONFIG0;
> -               msk =3D BMA400_INT_GEN1_MSK;
> -               value =3D 2;
> -               set_mask_bits(&field_value, BMA400_INT_GEN1_MSK,
> -                             FIELD_PREP(BMA400_INT_GEN1_MSK, state));
> -               break;
>         case IIO_EV_DIR_FALLING:
> -               reg =3D BMA400_GEN2INT_CONFIG0;
> -               msk =3D BMA400_INT_GEN2_MSK;
> -               value =3D 0;
> -               set_mask_bits(&field_value, BMA400_INT_GEN2_MSK,
> -                             FIELD_PREP(BMA400_INT_GEN2_MSK, state));
> -               break;
> +               return &bma400_genintrs[dir];
>         default:
> +               return NULL;
> +
> +       };
> +}
> +
> +static int bma400_generic_event_en(struct bma400_data *data,
> +                                  enum iio_event_direction dir,
> +                                  int state)
> +{
> +       int ret, regval;
> +       u8 genintr, detect_criterion;
> +       unsigned int intrmask;
> +       const struct bma400_genintr_info *bma400_genintr;
> +
> +       bma400_genintr =3D get_bma400_genintr_info(dir);
> +       if (!bma400_genintr)
>                 return -EINVAL;
> -       }
>
> -       /* Enabling all axis for interrupt evaluation */
> -       ret =3D regmap_write(data->regmap, reg, 0xF8);
> +       genintr =3D bma400_genintr->genintr;
> +       detect_criterion =3D bma400_genintr->detect_mode;
> +       intrmask =3D bma400_genintr->intrmask;
> +
> +       /*
> +        * Enabling all axis for interrupt evaluation.
> +        * Acc_filt2 is recommended as data source in datasheet (Section =
4.7).
> +        */
> +       ret =3D regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genin=
tr, 0),
> +                          BMA400_GENINT_CONFIG0_X_EN_MASK |
> +                          BMA400_GENINT_CONFIG0_Y_EN_MASK |
> +                          BMA400_GENINT_CONFIG0_Z_EN_MASK|
> +                          FIELD_PREP(BMA400_GENINT_CONFIG0_DATA_SRC_MASK=
, ACCEL_FILT2)|
> +                          FIELD_PREP(BMA400_GENINT_CONFIG0_REF_UPD_MODE_=
MASK,
> +                                     BMA400_REF_EVERYTIME_UPDT_MODE));
>         if (ret)
>                 return ret;
>
>         /* OR combination of all axis for interrupt evaluation */
> -       ret =3D regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF, =
value);
> +       regval =3D FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA40=
0_EVAL_X_OR_Y_OR_Z) |
> +                FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, detect=
_criterion);
> +       ret =3D regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genin=
tr, 1), regval);
>         if (ret)
>                 return ret;
>
> -       /* Initial value to avoid interrupts while enabling*/
> -       ret =3D regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, =
0x0A);
> +       /*
> +        * Initial value to avoid (activity) interrupts while enabling
> +        * Value is in units of 8mg/lsb, i.e. effective val is val * 8mg/=
lsb
> +        */
> +       ret =3D regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genin=
tr, 2), 0x0A);
>         if (ret)
>                 return ret;
>
>         /* Initial duration value to avoid interrupts while enabling*/
> -       ret =3D regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF,=
 0x0F);
> +       ret =3D regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genin=
tr, 4), 0x0F);
>         if (ret)
>                 return ret;
>
> -       ret =3D regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, msk=
,
> -                                field_value);
> +       regval =3D FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state);
> +       if (genintr)
> +               regval =3D FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state=
);
> +
> +       ret =3D regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, int=
rmask, regval);
>         if (ret)
>                 return ret;
>
> -       ret =3D regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, =
msk,
> -                                field_value);
> +       ret =3D regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, =
intrmask, regval);
>         if (ret)
>                 return ret;
>
> -       set_mask_bits(&data->generic_event_en, msk, field_value);
> +       set_mask_bits(&data->generic_event_en, intrmask, regval);
>         return 0;
>  }
>
> @@ -1303,7 +1346,7 @@ static int bma400_write_event_config(struct iio_dev=
 *indio_dev,
>                 switch (type) {
>                 case IIO_EV_TYPE_MAG:
>                         mutex_lock(&data->mutex);
> -                       ret =3D bma400_activity_event_en(data, dir, state=
);
> +                       ret =3D bma400_generic_event_en(data, dir, state)=
;
>                         mutex_unlock(&data->mutex);
>                         return ret;
>                 case IIO_EV_TYPE_GESTURE:
> @@ -1336,18 +1379,6 @@ static int bma400_write_event_config(struct iio_de=
v *indio_dev,
>         }
>  }
>
> -static int get_gen_config_reg(enum iio_event_direction dir)
> -{
> -       switch (dir) {
> -       case IIO_EV_DIR_FALLING:
> -               return BMA400_GEN2INT_CONFIG0;
> -       case IIO_EV_DIR_RISING:
> -               return BMA400_GEN1INT_CONFIG0;
> -       default:
> -               return -EINVAL;
> -       }
> -}
> -
>  static int bma400_read_event_value(struct iio_dev *indio_dev,
>                                    const struct iio_chan_spec *chan,
>                                    enum iio_event_type type,
> @@ -1356,22 +1387,24 @@ static int bma400_read_event_value(struct iio_dev=
 *indio_dev,
>                                    int *val, int *val2)
>  {
>         struct bma400_data *data =3D iio_priv(indio_dev);
> -       int ret, reg, reg_val, raw;
> +       int ret, genintr, reg_val, raw;
> +       const struct bma400_genintr_info *bma400_genintr;
>
>         if (chan->type !=3D IIO_ACCEL)
>                 return -EINVAL;
>
>         switch (type) {
>         case IIO_EV_TYPE_MAG:
> -               reg =3D get_gen_config_reg(dir);
> -               if (reg < 0)
> +               bma400_genintr =3D get_bma400_genintr_info(dir);
> +               if (!bma400_genintr)
>                         return -EINVAL;
> +               genintr =3D bma400_genintr->genintr;
>
>                 *val2 =3D 0;
>                 switch (info) {
>                 case IIO_EV_INFO_VALUE:
>                         ret =3D regmap_read(data->regmap,
> -                                         reg + BMA400_GEN_CONFIG2_OFF,
> +                                         BMA400_GENINT_CONFIG_REG(genint=
r, 2),
>                                           val);
>                         if (ret)
>                                 return ret;
> @@ -1379,7 +1412,7 @@ static int bma400_read_event_value(struct iio_dev *=
indio_dev,
>                 case IIO_EV_INFO_PERIOD:
>                         mutex_lock(&data->mutex);
>                         ret =3D regmap_bulk_read(data->regmap,
> -                                              reg + BMA400_GEN_CONFIG3_O=
FF,
> +                                              BMA400_GENINT_CONFIG_REG(g=
enintr, 3),
>                                                &data->duration,
>                                                sizeof(data->duration));
>                         if (ret) {
> @@ -1390,10 +1423,12 @@ static int bma400_read_event_value(struct iio_dev=
 *indio_dev,
>                         mutex_unlock(&data->mutex);
>                         return IIO_VAL_INT;
>                 case IIO_EV_INFO_HYSTERESIS:
> -                       ret =3D regmap_read(data->regmap, reg, val);
> +                       ret =3D regmap_read(data->regmap,
> +                                         BMA400_GENINT_CONFIG_REG(genint=
r, 0),
> +                                         val);
>                         if (ret)
>                                 return ret;
> -                       *val =3D FIELD_GET(BMA400_GEN_HYST_MSK, *val);
> +                       *val =3D FIELD_GET(BMA400_GENINT_CONFIG0_HYST_MAS=
K, *val);
>                         return IIO_VAL_INT;
>                 default:
>                         return -EINVAL;
> @@ -1444,16 +1479,18 @@ static int bma400_write_event_value(struct iio_de=
v *indio_dev,
>                                     int val, int val2)
>  {
>         struct bma400_data *data =3D iio_priv(indio_dev);
> -       int reg, ret, raw;
> +       int genintr, ret, raw;
> +       const struct bma400_genintr_info *bma400_genintr;
>
>         if (chan->type !=3D IIO_ACCEL)
>                 return -EINVAL;
>
>         switch (type) {
>         case IIO_EV_TYPE_MAG:
> -               reg =3D get_gen_config_reg(dir);
> -               if (reg < 0)
> +               bma400_genintr =3D get_bma400_genintr_info(dir);
> +               if (!bma400_genintr)
>                         return -EINVAL;
> +               genintr =3D bma400_genintr->genintr;
>
>                 switch (info) {
>                 case IIO_EV_INFO_VALUE:
> @@ -1461,7 +1498,7 @@ static int bma400_write_event_value(struct iio_dev =
*indio_dev,
>                                 return -EINVAL;
>
>                         return regmap_write(data->regmap,
> -                                           reg + BMA400_GEN_CONFIG2_OFF,
> +                                           BMA400_GENINT_CONFIG_REG(geni=
ntr, 2),
>                                             val);
>                 case IIO_EV_INFO_PERIOD:
>                         if (val < 1 || val > 65535)
> @@ -1470,7 +1507,7 @@ static int bma400_write_event_value(struct iio_dev =
*indio_dev,
>                         mutex_lock(&data->mutex);
>                         put_unaligned_be16(val, &data->duration);
>                         ret =3D regmap_bulk_write(data->regmap,
> -                                               reg + BMA400_GEN_CONFIG3_=
OFF,
> +                                               BMA400_GENINT_CONFIG_REG(=
genintr, 3),
>                                                 &data->duration,
>                                                 sizeof(data->duration));
>                         mutex_unlock(&data->mutex);
> @@ -1479,10 +1516,10 @@ static int bma400_write_event_value(struct iio_de=
v *indio_dev,
>                         if (val < 0 || val > 3)
>                                 return -EINVAL;
>
> -                       return regmap_update_bits(data->regmap, reg,
> -                                                 BMA400_GEN_HYST_MSK,
> -                                                 FIELD_PREP(BMA400_GEN_H=
YST_MSK,
> -                                                            val));
> +                       return regmap_update_bits(data->regmap,
> +                                                 BMA400_GENINT_CONFIG_RE=
G(genintr, 0),
> +                                                 BMA400_GENINT_CONFIG0_H=
YST_MASK,
> +                                                 FIELD_PREP(BMA400_GENIN=
T_CONFIG0_HYST_MASK, val));
>                 default:
>                         return -EINVAL;
>                 }
> @@ -1650,10 +1687,10 @@ static irqreturn_t bma400_interrupt(int irq, void=
 *private)
>                                                   IIO_EV_DIR_DOUBLETAP),
>                                timestamp);
>
> -       if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
> +       if (FIELD_GET(BMA400_INT_CONFIG0_GEN1_MASK, le16_to_cpu(data->sta=
tus)))
>                 ev_dir =3D IIO_EV_DIR_RISING;
>
> -       if (FIELD_GET(BMA400_INT_GEN2_MSK, le16_to_cpu(data->status)))
> +       if (FIELD_GET(BMA400_INT_CONFIG0_GEN2_MASK, le16_to_cpu(data->sta=
tus)))
>                 ev_dir =3D IIO_EV_DIR_FALLING;
>
>         if (ev_dir !=3D IIO_EV_DIR_NONE) {
> --
> 2.43.0
>
Hello Reviewers,
After waiting for a week, I have sent v2.
Requesting your valuable feedback on this.

Thanks,
Akshay.

