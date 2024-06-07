Return-Path: <linux-iio+bounces-6037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65664900C86
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657E31C2211A
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C014D2BE;
	Fri,  7 Jun 2024 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFi8jOLJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A433EE;
	Fri,  7 Jun 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717789250; cv=none; b=bBCbb7e8efviByE9Mmd0lknyexC2QoZOxl1s7y3rirtt3NrCib4zegWbbTlcfqABEY7FfiVqxiH+XKDps+QaSsFy4XwrcKkJECP/c9V50qN7/R9UbmnVFDcxew5wTaMjgjpqcfFxyIeeierjAy/GPBYtci5K3KAdo92MrvEzqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717789250; c=relaxed/simple;
	bh=xgVFvuM9ueCgOFcPr1vQxol8Y4nKYS8BbLn2vUjKIuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSYDvFTWba/wlez2GWVqwZef1iLygwOkucpv97B+XqNgAxicntEFQudX+lvrFwx90FrbzNhIuOpluYP4YFeobNb8V73F5lGiYoGD/aFaE4oA1X2p6rbfUkgVsxR8tmtPq444tOKkWs+EkfNip//PCUcdrmyQMgFfZ7Edm6DW+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFi8jOLJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso40792266b.0;
        Fri, 07 Jun 2024 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717789247; x=1718394047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0yV4b5QsibQjFNNz3DSQ8PjyCbAtDjSZNhUk0P45ag=;
        b=YFi8jOLJ8ifcwxfzOxdKWzFGihOozTJ6g1jRt/kToyCQ2E6L3EZccTvoz180SFFnmn
         MxcS54Gzghd6SPSrBWMgMkee00cNL2HWPNa/7J/hLR6swdxZZnTQl7N69yPsCV4TshoG
         4JwwhCdPw/RFzPmHiZ1191KU9OdCHU/ZBegXlAmWQ7McA232OJcDiGisGxMR6cbkUa1N
         ryBzf8um+r8MePFgB2HDJF9M/qWwHkmibyyFLHrz+Xg+WSHqbsZdH15Sjh4pTucpxp8X
         4ojkWTe3B6juRZGBk98qDAFIuAhQtSuvES5X0oAUyOmAuOA2A7FusOmsNXA1uF0sMJuz
         7XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717789247; x=1718394047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0yV4b5QsibQjFNNz3DSQ8PjyCbAtDjSZNhUk0P45ag=;
        b=WQMjA0c9ZsnSKRq76KtAtKuWs1NuhLmohArRTgP48jgWG3v4jkTLtm5AHMwNzePkrz
         y30295PXH+I8B+I95ZicZAb3oxWhz9HXAub7U9QXmMM4bFEdeb+7SG54LfHqTX/UKxR8
         Ns6QmOfL506hO7RbiuDHnWYIpVGd/t2TOs2vtzLrXD4srdiQ5H6yYyXaeHBKXaltwZkI
         MTn/qWQWxO7dWNxWlzeXrejLtiDZ8v2GLDFg+Q+qoRv4D7/fIxGOWtwNk4XmjHmikZZ9
         8AkUnCxCPr0bMsYFCvVRXlsayCLMWj5ypFOqTDo371/Riz7VDT8C0YaCgWCmMLc8XGcs
         q67g==
X-Forwarded-Encrypted: i=1; AJvYcCWnEPk/10Y9Nz5ZZx07Z6kQ+ssDQQ6axIdCRx3UTyqSnroA5pcc+sLSEzeuWpwdkrYGBsW9V+ZPQ8L+zemXrTgjXXAZMN+SabBCqXGCf3yUW0MNrGaRiH44qYFZebydpsqEnQ7k2mZr
X-Gm-Message-State: AOJu0YxB+ZMM29OiOrZY0+7E5HmvxtTNjw4SPtxDRuqkz2qkKRo5vmWk
	F+TJfBwBaNH8Rc467FNar5N1E9YaJJ6jQikWqKDcMPkCA1O4UgM4pwKPGAr9W87e5uwz8NT6ETO
	cDGGSGDP/E+maJvkP0kDbk8hzoKA=
X-Google-Smtp-Source: AGHT+IHuQl5AMgIV4mT5QSFQicjsNRKpOT3EElzgsWJxYjtVDFKyp2Q8t428uogMYiC+RAZ6T2IQ8HrFLqdMDnju+1M=
X-Received: by 2002:a17:906:2a44:b0:a69:b5:def2 with SMTP id
 a640c23a62f3a-a6cd561e296mr233773466b.6.1717789246528; Fri, 07 Jun 2024
 12:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607114138.390272-1-yasin.lee.x@outlook.com> <SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Jun 2024 22:40:09 +0300
Message-ID: <CAHp75VdYYGe7rXJm1z2a=r7ZnSU0-y+3N8juoNF-5xXi5=z5nA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org, 
	u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 2:42=E2=80=AFPM Yasin Lee <yasin.lee.x@outlook.com> =
wrote:
>
> From: Yasin Lee <yasin.lee.x@gmail.com>
>
> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>
> The device has the following entry points:
>
> Usual frequency:
> - sampling_frequency
>
> Instant reading of current values for different sensors:
> - in_proximity0_raw
> - in_proximity1_raw
> - in_proximity2_raw
> - in_proximity3_raw
> - in_proximity4_raw
> and associated events in events/

...

> +#include <linux/acpi.h>

Unused.

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>

> +#include <linux/byteorder/generic.h>

It should be asm/byteorder.h after linux/* (you have already
unaligned.h there, move this one there)

> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>

> +#include <linux/kernel.h>

Why do you need this?

> +#include <linux/math.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/types.h>

Do you really use all of these iio/*?

...

> +struct hx9023s_ch_data {
> +       int raw;
> +       int lp; /* low pass */
> +       int bl; /* base line */

> +       int diff; /* lp-bl */

Decrypt the comment.

> +       struct {
> +               int near;
> +               int far;
> +       } thres;

Do all of the above have to be signed? Why?

> +       u16 dac;
> +       u8 cs_position;
> +       u8 channel_positive;
> +       u8 channel_negative;
> +       bool sel_bl;
> +       bool sel_raw;
> +       bool sel_diff;
> +       bool sel_lp;
> +       bool enable;
> +};
> +
> +struct hx9023s_data {
> +       struct iio_trigger *trig;
> +       struct regmap *regmap;
> +       unsigned long chan_prox_stat;
> +       unsigned long chan_read;
> +       unsigned long chan_event;
> +       unsigned long ch_en_stat;
> +       unsigned long chan_in_use;
> +       unsigned int prox_state_reg;
> +       bool trigger_enabled;
> +
> +       struct {
> +               __be16 channels[HX9023S_CH_NUM];
> +               s64 ts __aligned(8);
> +       } buffer;

> +       struct hx9023s_ch_data ch_data[HX9023S_CH_NUM];

I would suggest moving this to be the last field. It might help in the
future if we ever need to convert this to VLA.

> +       struct mutex mutex;
> +};
> +
> +static struct hx9023s_addr_val_pair hx9023s_reg_init_list[] =3D {
> +       /* scan period */
> +       { HX9023S_PRF_CFG,                    0x17 },
> +
> +       /* full scale of conversion phase of each channel */
> +       { HX9023S_RANGE_7_0,                  0x11 },
> +       { HX9023S_RANGE_9_8,                  0x02 },
> +       { HX9023S_RANGE_18_16,                0x00 },
> +
> +       /* adc avg number and osr number of each channel */

ADC
average
OSR

> +       { HX9023S_AVG0_NOSR0_CFG,             0x71 },
> +       { HX9023S_NOSR12_CFG,                 0x44 },
> +       { HX9023S_NOSR34_CFG,                 0x00 },
> +       { HX9023S_AVG12_CFG,                  0x33 },
> +       { HX9023S_AVG34_CFG,                  0x00 },
> +
> +       /* sample & integration frequency of the adc */

ADC

> +       { HX9023S_SAMPLE_NUM_7_0,             0x65 },
> +       { HX9023S_INTEGRATION_NUM_7_0,        0x65 },
> +
> +       /* coefficient of the first order low pass filter during each cha=
nnel */
> +       { HX9023S_LP_ALP_1_0_CFG,             0x22 },
> +       { HX9023S_LP_ALP_3_2_CFG,             0x22 },
> +       { HX9023S_LP_ALP_4_CFG,               0x02 },
> +
> +       /* up coefficient of the first order low pass filter during each =
channel */
> +       { HX9023S_UP_ALP_1_0_CFG,             0x88 },
> +       { HX9023S_UP_ALP_3_2_CFG,             0x88 },
> +       { HX9023S_DN_UP_ALP_0_4_CFG,          0x18 },
> +
> +       /* down coefficient of the first order low pass filter during eac=
h channel */
> +       { HX9023S_DN_ALP_2_1_CFG,             0x11 },
> +       { HX9023S_DN_ALP_4_3_CFG,             0x11 },
> +
> +       /* output data */

What is this supposed to mean?

> +       { HX9023S_RAW_BL_RD_CFG,              0xF0 },
> +
> +       /* enable the interrupt function */
> +       { HX9023S_INTERRUPT_CFG,              0xFF },
> +       { HX9023S_INTERRUPT_CFG1,             0x3B },
> +       { HX9023S_DITHER_CFG,                 0x21 },
> +
> +       /* threshold of the offset compensation */
> +       { HX9023S_CALI_DIFF_CFG,              0x07 },
> +
> +       /* proximity persistency number(near & far) */
> +       { HX9023S_PROX_INT_HIGH_CFG,          0x01 },
> +       { HX9023S_PROX_INT_LOW_CFG,           0x01 },
> +
> +       /* disable the data lock */
> +       { HX9023S_DSP_CONFIG_CTRL1,           0x00 },
> +};

...

> +static const struct regmap_config hx9023s_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .cache_type =3D REGCACHE_RBTREE,

Why not MAPLE?

> +       .wr_table =3D &hx9023s_wr_regs,
> +       .volatile_table =3D &hx9023s_volatile_regs,
> +};

...

> +static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
> +{
> +       int ret;

Unneeded, you may return directly.

> +       if (locked)
> +               ret =3D regmap_update_bits(data->regmap, HX9023S_DSP_CONF=
IG_CTRL1,
> +                                       HX9023S_DATA_LOCK_MASK, HX9023S_D=
ATA_LOCK_MASK);

  return regmap_update_bits(...);

> +       else
> +               ret =3D regmap_update_bits(data->regmap, HX9023S_DSP_CONF=
IG_CTRL1, GENMASK(4, 3), 0);
> +
> +       return ret;
> +}

...

> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
> +{
> +       int ret;

> +       int i;

Why signed?

> +       u16 reg;
> +       u8 reg_list[HX9023S_CH_NUM * 2];
> +       u8 ch_pos[HX9023S_CH_NUM];
> +       u8 ch_neg[HX9023S_CH_NUM];
> +
> +       data->ch_data[0].cs_position =3D 0;
> +       data->ch_data[1].cs_position =3D 2;
> +       data->ch_data[2].cs_position =3D 4;
> +       data->ch_data[3].cs_position =3D 6;
> +       data->ch_data[4].cs_position =3D 8;
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {
> +               if (data->ch_data[i].channel_positive =3D=3D 255)

Magic number! Should it be GENMASK()? U8_MAX? Something else semantically?

> +                       ch_pos[i] =3D 16;
> +               else
> +                       ch_pos[i] =3D data->ch_data[data->ch_data[i].chan=
nel_positive].cs_position;
> +               if (data->ch_data[i].channel_negative =3D=3D 255)

Ditto!

> +                       ch_neg[i] =3D 16;
> +               else
> +                       ch_neg[i] =3D data->ch_data[data->ch_data[i].chan=
nel_negative].cs_position;
> +       }

> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {
> +               reg =3D (u16)((0x03 << ch_pos[i]) | (0x02 << ch_neg[i]));

Why casting? What are those magic numbers?

> +               reg_list[i * 2] =3D (u8)(reg);
> +               reg_list[i * 2 + 1] =3D (u8)(reg >> 8);

put_unaligned_le16()

> +       }

> +       ret =3D regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_=
list, HX9023S_CH_NUM * 2);
> +
> +       return ret;

Return directly.

> +}
> +
> +static int hx9023s_reg_init(struct hx9023s_data *data)
> +{
> +       int i =3D 0;

Why signed? What is that assignment for?

> +       int ret;
> +
> +       for (i =3D 0; i < (int)ARRAY_SIZE(hx9023s_reg_init_list); i++) {
> +               ret =3D regmap_bulk_write(data->regmap, hx9023s_reg_init_=
list[i].addr,
> +                                       &hx9023s_reg_init_list[i].val, 1)=
;
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}

...

> +static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val=
)
> +{
> +       int ret;
> +
> +       if (val > 0xF)
> +               val =3D 0xF;

What is this magic?
Shouldn't you use clamp()?

> +       guard(mutex)(&data->mutex);
> +       ret =3D regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG=
,
> +                               HX9023S_PROX_DEBOUNCE_MASK, val);
> +
> +       return ret;

Return directly. Really you may reduce your code base by ~50 LoCs just
 by dropping unneeded ret and this kind of code.

> +}

...

> +static int hx9023s_write_near_debounce(struct hx9023s_data *data, int va=
l)
> +{

As per above function.

> +}

...

> +static int hx9023s_get_thres_near(struct hx9023s_data *data, u8 ch, int =
*val)
> +{
> +       int ret;
> +       u8 buf[2];
> +
> +       if (ch =3D=3D 4)

Instead, make a temporary variable for the reg and use only a single
call to regmap_bulk_read().

> +               ret =3D regmap_bulk_read(data->regmap, HX9023S_PROX_HIGH_=
DIFF_CFG_CH4_0, buf, 2);

sizeof(buf)

> +       else
> +               ret =3D regmap_bulk_read(data->regmap,
> +                               HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * =
HX9023S_2BYTES), buf, 2);

Ditto.

> +

Redundant blank line.

> +       if (ret)
> +               return ret;

> +       *val =3D get_unaligned_le16(buf);
> +       *val =3D (*val & GENMASK(9, 0)) * 32;
> +       data->ch_data[ch].thres.near =3D *val;

Better to have a temporary variable and do something like

  unsigned int tmp;

  tmp =3D (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
  near =3D tmp;
  *val =3D tmp;

See the difference?

> +       return IIO_VAL_INT;
> +}

...

> +static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *=
val)
> +{

As per above.

> +}

...

> +static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int =
val)
> +{

As per above.

> +}
> +
> +static int hx9023s_set_thres_far(struct hx9023s_data *data, u8 ch, int v=
al)
> +{

As per above.

> +}

...

> +static void hx9023s_get_prox_state(struct hx9023s_data *data)
> +{
> +       int ret;

Are the 4 LoCs just for fun? Or why does the function return void?

> +       ret =3D regmap_read(data->regmap, HX9023S_PROX_STATUS, &data->pro=
x_state_reg);
> +       if (ret)
> +               return;
> +}

...

> +static void hx9023s_data_select(struct hx9023s_data *data)

Why void?

> +{
> +       int ret;

> +       int i;

Why signed?

> +       unsigned long buf[1];

Why an array?

> +       ret =3D regmap_read(data->regmap, HX9023S_RAW_BL_RD_CFG, (unsigne=
d int *)buf);

No. Why do you need this ugly casting?

> +       if (ret)
> +               return;
> +
> +       for (i =3D 0; i < 4; i++) {
> +               data->ch_data[i].sel_diff =3D test_bit(i, buf);
> +               data->ch_data[i].sel_lp =3D !data->ch_data[i].sel_diff;
> +               data->ch_data[i].sel_bl =3D test_bit(i + 4, buf);
> +               data->ch_data[i].sel_raw =3D !data->ch_data[i].sel_bl;
> +       }
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_INTERRUPT_CFG1, (unsign=
ed int *)buf);
> +       if (ret)
> +               return;
> +
> +       data->ch_data[4].sel_diff =3D test_bit(2, buf);
> +       data->ch_data[4].sel_lp =3D !data->ch_data[4].sel_diff;
> +       data->ch_data[4].sel_bl =3D test_bit(3, buf);
> +       data->ch_data[4].sel_raw =3D !data->ch_data[4].sel_bl;
> +}

...

> +static int hx9023s_sample(struct hx9023s_data *data)
> +{
> +       int ret;
> +       int i;

Why signed?

> +       u8 data_size;
> +       u8 offset_data_size;
> +       int value;
> +       u8 rx_buf[HX9023S_CH_NUM * HX9023S_BYTES_MAX];
> +
> +       hx9023s_data_lock(data, true);
> +       hx9023s_data_select(data);
> +
> +       data_size =3D HX9023S_3BYTES;
> +
> +       /* ch0~ch3 */
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, rx_b=
uf,
> +                               (HX9023S_CH_NUM * data_size) - data_size)=
;

Make a temporary variable and use  (CH_NUM - 1) * data_size which is
shorter and clearer.

> +       if (ret)
> +               return ret;
> +
> +       /* ch4 */
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0,
> +                               rx_buf + ((HX9023S_CH_NUM * data_size) - =
data_size), data_size);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {
> +               value =3D get_unaligned_le16(&rx_buf[i * data_size + 1]);
> +               value =3D sign_extend32(value, 15);
> +               data->ch_data[i].raw =3D 0;
> +               data->ch_data[i].bl =3D 0;
> +               if (data->ch_data[i].sel_raw =3D=3D true)
> +                       data->ch_data[i].raw =3D value;
> +               if (data->ch_data[i].sel_bl =3D=3D true)
> +                       data->ch_data[i].bl =3D value;
> +       }
> +
> +       /* ch0~ch3 */
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, rx_=
buf,
> +                               (HX9023S_CH_NUM * data_size) - data_size)=
;

Use a temporary constant.

> +       if (ret)
> +               return ret;
> +
> +       /* ch4 */
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0,
> +                               rx_buf + ((HX9023S_CH_NUM * data_size) - =
data_size), data_size);

Ditto.

> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {
> +               value =3D get_unaligned_le16(&rx_buf[i * data_size + 1]);
> +               value =3D sign_extend32(value, 15);
> +               data->ch_data[i].lp =3D 0;
> +               data->ch_data[i].diff =3D 0;
> +               if (data->ch_data[i].sel_lp =3D=3D true)
> +                       data->ch_data[i].lp =3D value;
> +               if (data->ch_data[i].sel_diff =3D=3D true)
> +                       data->ch_data[i].diff =3D value;
> +       }
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {
> +               if (data->ch_data[i].sel_lp =3D=3D true && data->ch_data[=
i].sel_bl =3D=3D true)
> +                       data->ch_data[i].diff =3D data->ch_data[i].lp - d=
ata->ch_data[i].bl;
> +       }
> +
> +       /* offset dac */
> +       offset_data_size =3D HX9023S_2BYTES;
> +       ret =3D regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, r=
x_buf,
> +                               (HX9023S_CH_NUM * offset_data_size));
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {
> +               value =3D get_unaligned_le16(&rx_buf[i * offset_data_size=
]);
> +               value =3D FIELD_GET(GENMASK(11, 0), value);
> +               data->ch_data[i].dac =3D value;
> +       }
> +
> +       hx9023s_data_lock(data, false);
> +
> +       return 0;
> +}

> +static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
> +{
> +       int ret;
> +       unsigned int buf;
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_CH_NUM_CFG, &buf);
> +       if (ret)
> +               return ret;
> +
> +       data->ch_en_stat =3D buf;
> +
> +       if (en) {
> +               if (data->ch_en_stat =3D=3D 0)
> +                       data->prox_state_reg =3D 0;
> +               set_bit(ch_id, &data->ch_en_stat);

Why atomit?

> +               ret =3D regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CF=
G, &data->ch_en_stat, 1);
> +               if (ret)
> +                       return ret;
> +               data->ch_data[ch_id].enable =3D true;
> +       } else {
> +               clear_bit(ch_id, &data->ch_en_stat);
> +               ret =3D regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CF=
G, &data->ch_en_stat, 1);
> +               if (ret)
> +                       return ret;
> +               data->ch_data[ch_id].enable =3D false;
> +       }

This can be compressed to

  if (en && ch_en_stat =3D=3D 0)
    prox_state_reg =3D 0;
  __assign_bit(en); // or atomic, but the latter has to be justified
  enable =3D !!en;
  ret =3D regmap_bulk_write();
  if (ret)
    return ret;

> +       return 0;
> +}
> +
> +static int hx9023s_property_get(struct hx9023s_data *data)
> +{
> +       int ret, i;

Why is the 'i' signed?

> +       u32 temp;
> +       struct fwnode_handle *child;
> +       struct device *dev =3D regmap_get_device(data->regmap);
> +
> +       ret =3D device_property_read_u32(dev, "channel-in-use", &temp);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to read channel-in=
-use property\n");
> +       data->chan_in_use =3D temp;

Did you even compile your code? The below uses uninitialised value.

> +       device_for_each_child_node(dev, child) {

You have massive leaks in this loop, you need to use _scoped() variant.

> +               ret =3D fwnode_property_read_u32(child, "channel-positive=
", &temp);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                       "Failed to read channel-positive =
for channel %d\n", i);
> +               data->ch_data[i].channel_positive =3D temp;
> +
> +               ret =3D fwnode_property_read_u32(child, "channel-negative=
", &temp);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                       "Failed to read channel-negative =
for channel %d\n", i);
> +               data->ch_data[i].channel_negative =3D temp;
> +
> +               i++;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hx9023s_update_chan_en(struct hx9023s_data *data,
> +                               unsigned long chan_read,
> +                               unsigned long chan_event)
> +{
> +       int i;

Why signed?

> +       unsigned long channels =3D chan_read | chan_event;
> +
> +       if ((data->chan_read | data->chan_event) !=3D channels) {
> +               for_each_set_bit(i, &channels, HX9023S_CH_NUM)
> +                       hx9023s_ch_en(data, i, test_bit(i, &data->chan_in=
_use));
> +               for_each_clear_bit(i, &channels, HX9023S_CH_NUM)
> +                       hx9023s_ch_en(data, i, false);
> +       }
> +
> +       data->chan_read =3D chan_read;
> +       data->chan_event =3D chan_event;
> +
> +       return 0;
> +}

...

> +static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, in=
t *val2)
> +{
> +       int ret;
> +       unsigned int odr;
> +       unsigned int buf;
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_PRF_CFG, &buf);
> +       if (ret)
> +               return ret;
> +
> +       odr =3D hx9023s_samp_freq_table[buf];

> +       *val =3D 1000 / odr;

KILO? MILLI?

> +       *val2 =3D div_u64((1000 % odr) * 1000000ULL, odr);

MILLI / MICRO ?

> +       return IIO_VAL_INT_PLUS_MICRO;
> +}

...

> +static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int=
 val2)
> +{
> +       int i;

Why signed?

> +       int ret;

> +       int period_ms;

Why signed?

> +       struct device *dev =3D regmap_get_device(data->regmap);
> +
> +       period_ms =3D div_u64(1000000000ULL, (val * 1000000ULL + val2));

Use units.h

> +       for (i =3D 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
> +               if (period_ms =3D=3D hx9023s_samp_freq_table[i])
> +                       break;
> +       }
> +       if (i =3D=3D ARRAY_SIZE(hx9023s_samp_freq_table)) {
> +               dev_err(dev, "Period:%dms NOT found!\n", period_ms);
> +               return -EINVAL;
> +       }

> +       ret =3D regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &i, 1);
> +
> +       return ret;

Argh...

> +}

...

> +static void hx9023s_push_events(struct iio_dev *indio_dev)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +       s64 timestamp =3D iio_get_time_ns(indio_dev);
> +       unsigned long prox_changed;
> +       unsigned int chan;
> +
> +       hx9023s_sample(data);
> +       hx9023s_get_prox_state(data);
> +
> +       prox_changed =3D (data->chan_prox_stat ^ data->prox_state_reg) & =
data->chan_event;
> +

Unneeded blank line.

> +       for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
> +               int dir;

Why signed?

> +               dir =3D (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_F=
ALLING : IIO_EV_DIR_RISING;
> +
> +               iio_push_event(indio_dev,
> +                       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_=
TYPE_THRESH, dir),
> +                       timestamp);
> +       }
> +       data->chan_prox_stat =3D data->prox_state_reg;
> +}

...

> +static int hx9023s_write_event_config(struct iio_dev *indio_dev,
> +                               const struct iio_chan_spec *chan,
> +                               enum iio_event_type type,
> +                               enum iio_event_direction dir,
> +                               int state)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +
> +       if (test_bit(chan->channel, &data->chan_in_use)) {
> +               hx9023s_ch_en(data, chan->channel, !!state);

> +               if (data->ch_data[chan->channel].enable)
> +                       set_bit(chan->channel, &data->chan_event);
> +               else
> +                       clear_bit(chan->channel, &data->chan_event);

Why atomic?

__assign_bit()

> +       }
> +
> +       return 0;
> +}

...

> +static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
> +{
> +       struct iio_poll_func *pf =3D private;
> +       struct iio_dev *indio_dev =3D pf->indio_dev;
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);

> +       int bit;
> +       int i;

Why are both signed?

> +       guard(mutex)(&data->mutex);
> +       hx9023s_sample(data);
> +       hx9023s_get_prox_state(data);
> +
> +       for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->mas=
klength)
> +               data->buffer.channels[i++] =3D
> +                       cpu_to_be16(data->ch_data[indio_dev->channels[bit=
].channel].diff);
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->=
timestamp);
> +
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int hx9023s_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +       struct hx9023s_data *data =3D iio_priv(indio_dev);
> +       unsigned long channels;
> +       int bit;

Why signed?

> +       guard(mutex)(&data->mutex);
> +       for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->mas=
klength)
> +               __set_bit(indio_dev->channels[bit].channel, &channels);
> +
> +       hx9023s_update_chan_en(data, channels, data->chan_event);
> +
> +       return 0;
> +}

...

> +static int hx9023s_probe(struct i2c_client *client)
> +{
> +       int ret;
> +       unsigned int id;
> +       struct device *dev =3D &client->dev;
> +       struct iio_dev *indio_dev;
> +       struct hx9023s_data *data;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct hx9023s_da=
ta));
> +       if (!indio_dev)
> +               return dev_err_probe(dev, -ENOMEM, "device alloc failed\n=
");

We don't issue a message for -ENOMEM.

> +       data =3D iio_priv(indio_dev);
> +       mutex_init(&data->mutex);
> +
> +       data->regmap =3D devm_regmap_init_i2c(client, &hx9023s_regmap_con=
fig);
> +       if (IS_ERR(data->regmap))
> +               return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap =
init failed\n");
> +
> +       ret =3D hx9023s_property_get(data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "dts phase failed\n");
> +
> +       ret =3D devm_regulator_get_enable(dev, "vdd");
> +       if (ret)
> +               return dev_err_probe(dev, ret, "regulator get failed\n");

> +       fsleep(1000);

> +       ret =3D regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "id check failed\n");
> +
> +       indio_dev->channels =3D hx9023s_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(hx9023s_channels);
> +       indio_dev->info =3D &hx9023s_info;
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +       indio_dev->name =3D "hx9023s";
> +       i2c_set_clientdata(client, indio_dev);
> +
> +       ret =3D hx9023s_reg_init(data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "device init failed\n");
> +
> +       ret =3D hx9023s_ch_cfg(data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "channel config failed\n")=
;
> +
> +       ret =3D regcache_sync(data->regmap);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "regcache sync failed\n");
> +
> +       if (client->irq) {
> +               ret =3D devm_request_threaded_irq(dev, client->irq, hx902=
3s_irq_handler,
> +                                               hx9023s_irq_thread_handle=
r, IRQF_ONESHOT,
> +                                               "hx9023s_event", indio_de=
v);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "irq request faile=
d\n");
> +
> +               data->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d", in=
dio_dev->name,
> +                                               iio_device_id(indio_dev))=
;
> +               if (!data->trig)
> +                       return dev_err_probe(dev, -ENOMEM,
> +                                       "iio trigger alloc failed\n");
> +
> +               data->trig->ops =3D &hx9023s_trigger_ops;
> +               iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +               ret =3D devm_iio_trigger_register(dev, data->trig);
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                       "iio trigger register failed\n");
> +       }
> +
> +       ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollf=
unc_store_time,
> +                                       hx9023s_trigger_handler, &hx9023s=
_buffer_setup_ops);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                               "iio triggered buffer setup failed\n");
> +
> +       ret =3D devm_iio_device_register(dev, indio_dev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "iio device register faile=
d\n");
> +
> +       return 0;
> +}

...

> +static const struct acpi_device_id hx9023s_acpi_match[] =3D {
> +       { "TYHX9023" },
> +       {}
> +};

Btw, do you have a reference to any device on the market that has this ID?

--=20
With Best Regards,
Andy Shevchenko

