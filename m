Return-Path: <linux-iio+bounces-5431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 628928D32AF
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 11:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BCFB2151D
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959016937A;
	Wed, 29 May 2024 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHwTCQNG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C61E888;
	Wed, 29 May 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974078; cv=none; b=mCZrGETik0PhccjEIBR6/hvVlUSLVW2ErtwAJ/gtfvR7d8VjiEXzNDBLJ8S2btHj2VykRz90y71tdL0oYpFOY/PK3nivNOEz4CYoajlkAFrKKyASk9YmiaLTLCdr157CwZcDi31alSRTay1Mq7u4ALe9vQr2nTYN1HJ61Mx6hNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974078; c=relaxed/simple;
	bh=DWvbZz4v6j9jat4mR/BGEhhV8WoFqrTRClETcJmeCjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+LiK0E6P7gjbBxe33I1mzNcj64zphXWxQ62IueVhJxFRBrgQRki8gav3XVN7/jrlzb/Fomrrmj+O2HCN8TeNYWRXWj2B5wpUdnvhgcKMU2LfqKOZVW1p/MXACsiOFoe9w1un8zlXO2w6wnbxBB4TIAEpbVqFtZBqxZz2X7WIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHwTCQNG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57857e0f464so2366931a12.0;
        Wed, 29 May 2024 02:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716974074; x=1717578874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YrljGmipZ9djxQoMmqDd5fv2jWlsQYLEqt/wsOoKx0=;
        b=PHwTCQNGCCxbD3mXtBjvZEovPlJMXjzIb4Kwg9OgI2/HHzf38CYAFwh6P3S2iWF7gd
         ULbyWzRbVv8Be70V9lLS+P56PFobS8zO7UlZIZt1PhsjUjvFVjlrAuKV5C6U2whDxUuV
         kGBJME++Qw5qxHl4vaLC8HK7rp4EP/OIJmLp+o4KenRC1RpuSQ3RNQn5mInh+/tG21yX
         y3GR/49juKQ/fdXJpbiATLyQnZGED5fS80mRNtxweuRcgRfuBZ0l2o7DKILI9Qg/jsfw
         cGSY809xK3rbcA42aWcVqGcbQwHczJKN2h4Ke54kNK5ZBI5lICeKyiV2N2Uer/Wx3PRs
         9pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716974074; x=1717578874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YrljGmipZ9djxQoMmqDd5fv2jWlsQYLEqt/wsOoKx0=;
        b=XUnYgLJkRfPriDR4oslatK49aK8Y5ouwobHUHeTDe52ZYXHqXgS2nA8cys/xmfIPpV
         UuQ9QYLQG2L2fDDOtXTcRqszFDpqDb9dUH6rEx3trg+yGR3baRqNtSXMlXw/5bLsqETu
         r5HeDD3GZXR7u8wLbrugwbdTCYdVH5NRKwvodhrdtdluh+bpMGb0DJDqCk/sBXlSxIn3
         g2mqaDJPvh/V9wR/S4gUXHvClQFVlQSq0WL6c5JCrordhS7Vn1Dtpm7tVhsDHcTWhii2
         XKE3e+hC7DcFggKXAGIyIn1RxBOWRpnk2rhKhOGs3wpIK3vnt6Quxnt58cecJGADAs2g
         zUtA==
X-Forwarded-Encrypted: i=1; AJvYcCVziqboq2Dn2qDLS0RX3jMntXCqV1xdmIL+7TxfbPk/cWC2AFWX7Ti57/teZTpX74O/keQ31otemOdyir0y3Z3oUmgA3hiJdXMIKAe0tH1KprX+PKuzCQ0R6CrH54zPm4wsaD9aSc4M
X-Gm-Message-State: AOJu0YzaHweT7GeDbUzscw4ofy7Kvq5/cZD7OuBmMQx5AQw+IQcBGCyr
	iiZtKtoNTRFyt0/AAPUFjLYQlD9PmfKsWoKgcT3ThI7kpErn3hjKVifrHJhuFZFqI8p/PGPPmG4
	lsP+NKqPyvx+KJXfbB30jRwzRlIc=
X-Google-Smtp-Source: AGHT+IH7sSxnTprPhfwM7UZSg/j3Tk66FxCiuSOdyJEZSeewjHQFpoLxy2K4RC+cK30NwgcAAzIkHPr+3P2SkcM8k1o=
X-Received: by 2002:a17:906:13ce:b0:a63:37c7:b76 with SMTP id
 a640c23a62f3a-a6337c70bc9mr342019866b.47.1716974074047; Wed, 29 May 2024
 02:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519162438.17af0ff8@jic23-huawei> <20240529045749.530039-1-yasin.lee.x@outlook.com>
 <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 May 2024 12:13:56 +0300
Message-ID: <CAHp75VfOd9jG3F6MvOwH8LedOA3CmC4pDng5jZa0X2n-Kd9V_g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org, 
	u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 7:58=E2=80=AFAM Yasin Lee <yasin.lee.x@outlook.com>=
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

> @@ -21,4 +22,3 @@ obj-$(CONFIG_SX_COMMON)       +=3D sx_common.o
>  obj-$(CONFIG_SX9500)           +=3D sx9500.o
>  obj-$(CONFIG_VCNL3020)         +=3D vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)      +=3D vl53l0x-i2c.o
> -

Stray change.

...

> +#include <linux/i2c.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>

Move this group (linux/iio/*) headers...

> +#include <linux/regmap.h>
>
> +#include <asm-generic/unaligned.h>

...here.

Also the rest (only two inclusions?!) is too little to this big
driver. Follow the IWYU principle ("include what you use").

...

> +#define TYHX_DELAY_MS(x) msleep(x)

This is misleading and actually useless. Use msleep() directly (btw,
you missed delay.h to be included).

...

> +#define HX9023S_RAW_BL_CH1_2                   0xED
> +#define HX9023S_RAW_BL_CH2_0                   0xEE
> +#define HX9023S_RAW_BL_CH2_1                   0xEF
> +#define HX9023S_RAW_BL_CH2_2                   0xF0
> +#define HX9023S_RAW_BL_CH3_0                   0xF1
> +#define HX9023S_RAW_BL_CH3_1                   0xF2
> +#define HX9023S_RAW_BL_CH3_2                   0xF3
> +#define HX9023S_RAW_BL_CH4_0                   0xB5
> +#define HX9023S_RAW_BL_CH4_1                   0xB6
> +#define HX9023S_RAW_BL_CH4_2                   0xB7
> +#define HX9023S_LP_DIFF_CH0_0                  0xF4
> +#define HX9023S_LP_DIFF_CH0_1                  0xF5
> +#define HX9023S_LP_DIFF_CH0_2                  0xF6
> +#define HX9023S_LP_DIFF_CH1_0                  0xF7
> +#define HX9023S_LP_DIFF_CH1_1                  0xF8
> +#define HX9023S_LP_DIFF_CH1_2                  0xF9
> +#define HX9023S_LP_DIFF_CH2_0                  0xFA
> +#define HX9023S_LP_DIFF_CH2_1                  0xFB
> +#define HX9023S_LP_DIFF_CH2_2                  0xFC
> +#define HX9023S_LP_DIFF_CH3_0                  0xFD
> +#define HX9023S_LP_DIFF_CH3_1                  0xFE
> +#define HX9023S_LP_DIFF_CH3_2                  0xFF
> +#define HX9023S_LP_DIFF_CH4_0                  0xB8
> +#define HX9023S_LP_DIFF_CH4_1                  0xB9
> +#define HX9023S_LP_DIFF_CH4_2                  0xBA

Please, jeep sorted by the register offset.

...

> +#define HX9023S_DATA_LOCK_MASK BIT(4)
> +#define HX9023S_INTERRUPT_MASK GENMASK(9, 0)
> +#define HX9023S_PROX_DEBOUNCE_MASK GENMASK(3, 0)

bits.h is missing above.

...

> +struct hx9023s_addr_val_pair {
> +       uint8_t addr;
> +       uint8_t val;
> +};

Can you use regular in-kernel types, i.e. u8?

> +struct hx9023s_channel_info {
> +       bool enabled;
> +       bool used;

Despite the above, you missed types.h to be included.

> +       int state;

Have you run `pahole` to check if it would be better to have this field fir=
st?

> +};

...

> +static struct hx9023s_addr_val_pair hx9023s_reg_init_list[] =3D {

I would like to see a comment along each initialisation value to
explain what it does. Otherwise it looks like a magic blob.

Also make comments, if needed, about the ordering of this list. I.o.w.
does it have dependencies or all registers can be initialised in
arbitrary order?

> +};

...

> +struct hx9023s_data {
> +       struct mutex mutex;

> +       struct i2c_client *client;

For what purpose?

> +       struct iio_trigger *trig;
> +       struct regmap *regmap;
> +       unsigned long chan_prox_stat;
> +       bool trigger_enabled;
> +       struct {
> +               __be16 channels[HX9023S_CH_NUM];
> +

Redundant blank line.

> +               s64 ts __aligned(8);
> +

Ditto.

> +       } buffer;
> +       unsigned long chan_read;
> +       unsigned long chan_event;
> +
> +       struct hx9023s_threshold thres[HX9023S_CH_NUM];
> +       struct hx9023s_channel_info *chs_info;
> +       unsigned long ch_en_stat;
> +       unsigned int prox_state_reg;
> +       unsigned int accuracy;
> +       unsigned long channel_used_flag;
> +       unsigned int cs_position[HX9023S_CH_NUM];
> +       unsigned int channel_positive[HX9023S_CH_NUM];
> +       unsigned int channel_negative[HX9023S_CH_NUM];
> +       int raw[HX9023S_CH_NUM];
> +       int lp[HX9023S_CH_NUM]; /*low pass*/
> +       int bl[HX9023S_CH_NUM]; /*base line*/
> +       int diff[HX9023S_CH_NUM]; /*lp - bl*/

Mind spaces in the comments.

> +       uint16_t dac[HX9023S_CH_NUM];

u16

> +       bool sel_bl[HX9023S_CH_NUM];
> +       bool sel_raw[HX9023S_CH_NUM];
> +       bool sel_diff[HX9023S_CH_NUM];
> +       bool sel_lp[HX9023S_CH_NUM];
> +       unsigned int odr;
> +       unsigned int integration_sample;
> +       unsigned int osr[HX9023S_CH_NUM];
> +       unsigned int avg[HX9023S_CH_NUM];
> +       unsigned int lp_alpha[HX9023S_CH_NUM];


Can you rather make a per-channel structure and then have only one array he=
re

  struct foo_channel chan_context[_CH_NUM];

?

> +};

...

> +static const unsigned int hx9023s_samp_freq_table[] =3D {
> +       2, 2, 4, 6, 8, 10, 14, 18, 22, 26,
> +       30, 34, 38, 42, 46, 50, 56, 62, 68, 74,
> +       80, 90, 100, 200, 300, 400, 600, 800, 1000, 2000,
> +       3000, 4000

Keep trailing comma.

> +};

...

> +static const struct regmap_config hx9023s_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .cache_type =3D REGCACHE_NONE,

Why no cache?
Do you need a regmap lock on top of what you have already?

> +};

...

> +                       dev_err(&data->client->dev, "i2c read failed\n");

> +                       dev_err(&data->client->dev, "i2c read failed\n");

  struct device *dev =3D regmap_get_dev(...);

  dev_err(dev, ...);

here and everywhere else.

...

> +static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
> +{
> +       int ret;
> +
> +       if (locked) {
> +               ret =3D regmap_update_bits(data->regmap, HX9023S_DSP_CONF=
IG_CTRL1,
> +                                       HX9023S_DATA_LOCK_MASK, HX9023S_D=
ATA_LOCK_MASK);
> +               if (ret < 0) {

Why ' < 0' ?

> +                       dev_err(&data->client->dev, "i2c read failed\n");
> +                       return ret;
> +               }

  if (ret)
    dev_err();
  return ret;


> +       } else {

Redundant. see above.

> +               ret =3D regmap_update_bits(data->regmap, HX9023S_DSP_CONF=
IG_CTRL1,
> +                                       GENMASK(4, 3), 0x00);

With 0x00 --> 0 and above this will be one line.

> +               if (ret < 0) {
> +                       dev_err(&data->client->dev, "i2c read failed\n");
> +                       return ret;
> +               }
> +       }
> +
> +       return ret;

Too many unneeded LoCs, see above how to optimise.

> +}

...

> +static int hx9023s_get_id(struct hx9023s_data *data)
> +{
> +       int ret;
> +       unsigned int rxbuf[1];
> +
> +       ret =3D regmap_read(data->regmap, HX9023S_DEVICE_ID, rxbuf);
> +       if (ret < 0) {
> +               dev_err(&data->client->dev, "i2c read failed\n");
> +               return ret;
> +       }
> +
> +       return 0;

Same optimisation as per above function applicable here. Do it
everywhere to remove a few LoCs here and there.

> +}

...

> +static int hx9023s_para_cfg(struct hx9023s_data *data)
> +{
> +       int ret;
> +       uint8_t buf[3];
> +
> +       ret =3D regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &data->o=
dr, 1);
> +       if (ret) {
> +               dev_err(&data->client->dev, "i2c write failed\n");
> +               return ret;
> +       }

> +       buf[0] =3D data->integration_sample & 0xFF;
> +       buf[1] =3D data->integration_sample >> 8;

put_unaligned_le16()

> +       ret =3D regmap_bulk_write(data->regmap, HX9023S_SAMPLE_NUM_7_0, b=
uf, 2);
> +       if (ret) {

> +               dev_err(&data->client->dev, "i2c write failed\n");

This is a very repetitive and useless message AFAICS.

> +               return ret;
> +       }
> +
> +       ret =3D regmap_bulk_write(data->regmap, HX9023S_INTEGRATION_NUM_7=
_0, buf, 2);
> +       if (ret) {
> +               dev_err(&data->client->dev, "i2c write failed\n");
> +               return ret;
> +       }
> +
> +       buf[0] =3D (data->avg[2] << 4) | data->avg[1];
> +       buf[1] =3D (data->avg[4] << 4) | data->avg[3];

I believe this also can be optimised, esp. if you reconsider the avg[]
data type.

> +       ret =3D regmap_bulk_write(data->regmap, HX9023S_AVG12_CFG, buf, 2=
);
> +       if (ret) {
> +               dev_err(&data->client->dev, "i2c write failed\n");
> +               return ret;
> +       }
> +
> +       buf[0] =3D (data->osr[2] << 4) | data->osr[1];
> +       buf[1] =3D (data->osr[4] << 4) | data->osr[3];

Ditto.

> +       ret =3D regmap_bulk_write(data->regmap, HX9023S_NOSR12_CFG, buf, =
2);
> +       if (ret) {
> +               dev_err(&data->client->dev, "i2c write failed\n");
> +               return ret;
> +       }
> +
> +       ret =3D regmap_update_bits(data->regmap, HX9023S_AVG0_NOSR0_CFG, =
GENMASK(7, 2),
> +                               ((data->avg[0] << 5) | (data->osr[0] << 2=
)));

Too many parentheses.

> +       if (ret < 0) {
> +               dev_err(&data->client->dev, "i2c read failed\n");
> +               return ret;
> +       }

> +       buf[0] =3D data->lp_alpha[4];
> +       buf[1] =3D (data->lp_alpha[1] << 4) | data->lp_alpha[0];
> +       buf[2] =3D (data->lp_alpha[3] << 4) | data->lp_alpha[2];

Also sounds like put_unaligned_be24() with a properly cooked argument.

> +       ret =3D regmap_bulk_write(data->regmap, HX9023S_LP_ALP_4_CFG, buf=
, 3);
> +       if (ret) {
> +               dev_err(&data->client->dev, "i2c write failed\n");
> +               return ret;
> +       }
> +
> +       return ret;
> +}

I stopped here as most of your functions have the same problems and
can be shrinked with a few % gain of the overall number of LoCs.

...

> +       for (i =3D 0; i < HX9023S_CH_NUM; i++) {
> +               value =3D get_unaligned_le16(&rx_buf[i * offset_data_size=
]);

> +               value =3D value & 0xFFF;
> +               data->dac[i] =3D value;

Just

  ->dac =3D value & GENMASK();

> +       }

...

> +static int hx9023s_dts_phase(struct hx9023s_data *data)
> +{

> +       struct device_node *np =3D data->client->dev.of_node;

No for at least two reasons:
- for the sensors we do not accept new code that is OF-centric, make
use of the agnostic device property APIs
- it's bad to dereference of_node/fwnode as it adds unneeded churn in the f=
uture

You will need property.h to be included.

> +       return 0;
> +}

> +       if ((data->chan_read | data->chan_event) !=3D channels) {
> +               for (i =3D 0; i < HX9023S_CH_NUM; i++) {
> +                       if (test_bit(i, &data->channel_used_flag) && test=
_bit(i, &channels))

Make it
  for_each_set_bit(i, &channels, ...) {
    if (test_bit(..., _is_used)) // rename _used_flag to _is_used or
even _in_use
  }

(Replace bits.h with bitops.h in the inclusion block for these)

> +                               hx9023s_ch_en_hal(data, i, true);
> +                       else
> +                               hx9023s_ch_en_hal(data, i, false);
> +               }
> +       }
> +
> +       data->chan_read =3D chan_read;
> +       data->chan_event =3D chan_event;
> +       return 0;
> +}

...

> +       odr =3D hx9023s_samp_freq_table[buf[0]];
> +       *val =3D 1000 / odr;
> +       *val2 =3D ((1000 % odr) * 1000000ULL) / odr;

Include units.h and use the proper definitions from there.

...

> +       period_ms =3D div_u64(1000000000ULL, (val * 1000000ULL + val2));

math.h is missing.
Also consider using proper time constants live NSEC_PER_SEC or so.

...

> +       for (i =3D 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {

array_size.h is missing.

> +               if (period_ms =3D=3D hx9023s_samp_freq_table[i])
> +                       break;
> +       }
> +       if (i =3D=3D ARRAY_SIZE(hx9023s_samp_freq_table)) {
> +               dev_err(&data->client->dev, "Period:%dms NOT found!\n", p=
eriod_ms);

dev_printk.h

> +               return -EINVAL;

errno.h

> +       }

...

> +       ret =3D regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &buf[0],=
 1);

, buf, sizeof(buf) ?

> +       if (ret)

You are not even consistent with the checks in one file!

> +               dev_err(&data->client->dev, "i2c read failed\n");

> +       return ret;

Can it not be 0 here?

...

> +               if (data->chs_info[chan->channel].enabled)
> +                       set_bit(chan->channel, &data->chan_event);
> +               else
> +                       clear_bit(chan->channel, &data->chan_event);

Why atomic?
In any case, use assign_bit() / __assign_bit().

...

> +       int i =3D 0;

Why signed?

> +       guard(mutex)(&data->mutex);
> +       hx9023s_sample(data);
> +       hx9023s_get_prox_state(data);
> +
> +       for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->mas=
klength)
> +               data->buffer.channels[i++] =3D data->diff[indio_dev->chan=
nels[bit].channel];

...

> +static int hx9023s_probe(struct i2c_client *client)
> +{
> +       int ret;
> +       int i;
> +       struct device *dev =3D &client->dev;
> +       struct iio_dev *indio_dev;
> +       struct hx9023s_data *data;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct hx9023s_da=
ta));
> +       if (!indio_dev)
> +               return dev_err_probe(&client->dev, -ENOMEM, "device alloc=
 failed\n");

You are even inconsistent in the use of dev in a single function! Why
not dev here?

> +       data =3D iio_priv(indio_dev);
> +       data->client =3D client;

> +       mutex_init(&data->mutex);

mutex.h

> +       ret =3D hx9023s_dts_phase(data);
> +       if (ret)
> +               return dev_err_probe(&data->client->dev, ret, "dts phase =
failed\n");
> +
> +       data->chs_info =3D devm_kzalloc(&data->client->dev,
> +                               sizeof(struct hx9023s_channel_info) * HX9=
023S_CH_NUM, GFP_KERNEL);

Okay, you need to replace dev_printk.h I mentioned above by device.h,
but on top of that this should be devm_kcalloc().

> +       if (data->chs_info =3D=3D NULL)

Pattern is if (!...)

> +               return dev_err_probe(&data->client->dev, -ENOMEM, "channe=
l info alloc failed\n");

Ouch, as I said, this is the third variant of dev to be used. Use dev
everywhere.

> +       for (i =3D 0; i < HX9023S_CH_NUM; i++)
> +               if (test_bit(i, &data->channel_used_flag))

for_each_set_bit()

> +                       data->chs_info[i].used =3D true;

Interesting why you need this.

> +       data->regmap =3D devm_regmap_init_i2c(client, &hx9023s_regmap_con=
fig);
> +       if (IS_ERR(data->regmap)) {

> +               ret =3D PTR_ERR(data->regmap);
> +               return dev_err_probe(&data->client->dev, ret, "regmap ini=
t failed\n");

Use dev and move PTR_ERR() to be in the parameter for dev_err_probe().

> +       }
> +
> +       ret =3D devm_regulator_get_enable(&data->client->dev, "vdd");
> +       if (ret)
> +               return dev_err_probe(&data->client->dev, ret, "regulator =
get failed\n");

> +       usleep_range(1000, 1100);

fsleep()

> +       ret =3D hx9023s_get_id(data);
> +       if (ret)
> +               return dev_err_probe(&data->client->dev, ret, "id check f=
ailed\n");
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
> +               return dev_err_probe(&data->client->dev, ret, "device ini=
t failed\n");
> +
> +       ret =3D hx9023s_ch_cfg(data);
> +       if (ret)
> +               return dev_err_probe(&data->client->dev, ret, "channel co=
nfig failed\n");
> +
> +       ret =3D hx9023s_para_cfg(data);
> +       if (ret)
> +               return dev_err_probe(&data->client->dev, ret, "parameter =
config failed\n");
> +
> +       if (client->irq) {
> +               ret =3D devm_request_threaded_irq(dev, client->irq, hx902=
3s_irq_handler,
> +                                               hx9023s_irq_thread_handle=
r, IRQF_ONESHOT,
> +                                               "hx9023s_event", indio_de=
v);
> +               if (ret)
> +                       return dev_err_probe(&data->client->dev, ret, "ir=
q request failed\n");
> +
> +               data->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d", in=
dio_dev->name,
> +                                               iio_device_id(indio_dev))=
;

I'm wondering if there is a default naming in that API... Would be
nice to have it for cases like this.

> +               if (!data->trig)
> +                       return dev_err_probe(&data->client->dev, -ENOMEM,
> +                                       "iio trigger alloc failed\n");
> +
> +               data->trig->ops =3D &hx9023s_trigger_ops;
> +               iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +               ret =3D devm_iio_trigger_register(dev, data->trig);
> +               if (ret)
> +                       return dev_err_probe(&data->client->dev, ret,
> +                                       "iio trigger register failed\n");
> +       }
> +
> +       ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollf=
unc_store_time,
> +                                       hx9023s_trigger_handler, &hx9023s=
_buffer_setup_ops);
> +       if (ret)
> +               return dev_err_probe(&data->client->dev, ret,
> +                               "iio triggered buffer setup failed\n");
> +
> +       ret =3D devm_iio_device_register(dev, indio_dev);
> +       if (ret)
> +               return dev_err_probe(&data->client->dev, ret, "iio device=
 register failed\n");
> +
> +       return 0;
> +}

...

> +static const struct acpi_device_id hx9023s_acpi_match[] =3D {
> +       { .id =3D "TYHX9023", .driver_data =3D HX9023S_CHIP_ID },

We don't use C99 for ACPI ID tables, moreover you need mod_devicetable.h.
See also below.

> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, hx9023s_acpi_match);

> +static const struct of_device_id hx9023s_of_match[] =3D {
> +       { .compatible =3D "tyhx,hx9023s", (void *)HX9023S_CHIP_ID },

No, use a proper pointer that will give a chip info like structure.
Same for above and below ID tables.

> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, hx9023s_of_match);
> +
> +static const struct i2c_device_id hx9023s_id[] =3D {
> +       { .name =3D "hx9023s", .driver_data =3D HX9023S_CHIP_ID },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, hx9023s_id);

...

Also, for better review experience, can you split this to a few patches, li=
ke
1. main functionality
2. trigger support
3. ACPI support (ID table)
?

Reviewing 1.5 kLoCs at once is kinda big load.

--=20
With Best Regards,
Andy Shevchenko

