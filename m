Return-Path: <linux-iio+bounces-9956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD2398B6E1
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 10:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBCA28248D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8919ABAF;
	Tue,  1 Oct 2024 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2oyzlDwS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD519A28B
	for <linux-iio@vger.kernel.org>; Tue,  1 Oct 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771216; cv=none; b=d9Bu/gOlU0Lh5LOrJMOGmNDRgCHlttD6Z9A+gNh26lXe0FskeOLP/CWZ6sUsqFM+tJl8YFZIuWMlkXiqWM8l8u0cWn6sd/LzgdaLvvtWTX8TJne7OQBtMcTtpev5hgJu6goVgLxGrnaS1bQwV3thG6FC/odtCR78QAbXWZcA1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771216; c=relaxed/simple;
	bh=ttIrGurQvKMwIbe5CuFjqIr0vQifjfcxiESbfoe6N3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSn8tv7eifNWmPBt2aI7mRT6anD5T909/CuWwNmW55ekcESFHGlQDgqalSZcq2f9Xt3eR8KHtQ7GqaftH0sD/UWPVKqzSCXgYjzS10N3edLlKhHBw7wsHnO27g1YukwVCT9bOl5aytm676uuWHqTqfOtR+fjzpoTq53ttCw0A6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2oyzlDwS; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50abf1bd152so584823e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2024 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727771212; x=1728376012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46BrxJavPdtycbzcyopLYt/5oNHIzM/rbBExYtyNfTQ=;
        b=2oyzlDwSbD3KAaVXur4uHVzUUxyYDmZ4AE7MIjLbXjlNrSOFYWFGc/ms9mOJ9KWLzf
         SMQXc5F130oPZUkNhKDx2WAQJBE1aGt7oEadCm9O4Gbvmfr0RVxaioCRhXhbhbccyZ2k
         ZIQPG0H/o8jhgpO3U2ORloLEi0y5TCe2G6Q0soFt/5mowchHJq0dRoKKV9U3p2vSlHJf
         Q+8jxIs2U59qCOj5KdiIwBZsr32EMK3Nr2n7aharFzB/vqHXCckzDOu2M8lm9WoVykDj
         Ozsezz6PqFYByKIB13JR0h5rNglPKGke3SvgYqaD4kU6afFPuBUxyp0q0rJPOtiHuE2X
         0mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771212; x=1728376012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46BrxJavPdtycbzcyopLYt/5oNHIzM/rbBExYtyNfTQ=;
        b=xCURNzbcsJZznT1w3K7GYQ1EjoRZRnAHajCCSEgRnwq2lkLCSKLUk8PNzsJWLZHh8J
         3VnKcRVSmjqsMn8Hf0yZiDRi14HKMhvCA+LzD90Ja+7fsXLmZVvmmOvZVwcc5uMJLYH+
         qh7RdO4AEzYE0X34gp+A2rCuAdSPWCj5fIfLjYI/1OpA9sUggfvCO/yasNEZHAv8P+tt
         dSNSCELY3ik3pabfNduQBu4PMpTx868MlGpqovv5KN6enoyQjGfuktWOQbTQAJzP+zMP
         5ogYM0AGR990S6+x2ik2tmoY/z1j2Li694AaDU9D/gCnZ8Ysv71033dXfkB9H2JVKLef
         7V/Q==
X-Gm-Message-State: AOJu0YxAawyZiEWHduf7QYGAJiM/XQCH+W3U5VzsAKmUL9zfkIf8IkoN
	ULPpQDM7MFbFIWzlVAB26NIGu2ZLZPtHBrHgxDRxhldVSX5QqQx0d6K43itXcKbNbEVBIWNovd3
	AdLAdM68jKdkhrIXXKgeaxqu8vQpdIENhG3Ri+KuX7BP78CJa5pVKnA==
X-Google-Smtp-Source: AGHT+IGMUWm8BmJM5s7vkT+PHMCXAxdg6VZcJelrbhyaWFq9Sg6wYbyIhMPkQpHBOFcEntB+qaUdtj1NxG2etmrqCys=
X-Received: by 2002:a05:6122:4585:b0:509:e5b5:d133 with SMTP id
 71dfb90a1353d-509e5b5dfb2mr4776882e0c.6.1727771211593; Tue, 01 Oct 2024
 01:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919130444.2100447-1-aardelean@baylibre.com> <20240919130444.2100447-9-aardelean@baylibre.com>
In-Reply-To: <20240919130444.2100447-9-aardelean@baylibre.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 1 Oct 2024 11:26:40 +0300
Message-ID: <CA+GgBR_kKYOgPUHM5-LUAZboy6nab1tLvC4TFtzpqkjP+5A8wg@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Cc: jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de, 
	michael.hennerich@analog.com, gstols@baylibre.com, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 4:05=E2=80=AFPM Alexandru Ardelean
<aardelean@baylibre.com> wrote:
>
> The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
> The main difference between AD7606C-16 & AD7606C-18 is the precision in
> bits (16 vs 18).
> Because of that, some scales need to be defined for the 18-bit variants, =
as
> they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants)=
.
>
> Because the AD7606C-16,18 also supports bipolar & differential channels,
> for SW-mode, the default range of 10 V or =C2=B110V should be set at prob=
e.
> On reset, the default range (in the registers) is set to value 0x3 which
> corresponds to '=C2=B110 V single-ended range', regardless of bipolar or
> differential configuration.
>
> Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.
>
> The AD7606C-18 variant offers 18-bit precision. Because of this, the
> requirement to use this chip is that the SPI controller supports padding
> of 18-bit sequences to 32-bit arrays.
>
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad7606c-16.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad7606c-18.pdf
>
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c     | 263 +++++++++++++++++++++++++++++++++--
>  drivers/iio/adc/ad7606.h     |  16 ++-
>  drivers/iio/adc/ad7606_spi.c |  55 ++++++++
>  3 files changed, 322 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index b909ee14fd81..f04e5660d2f8 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -36,6 +36,33 @@ static const unsigned int ad7606_16bit_hw_scale_avail[=
2] =3D {
>         152588, 305176
>  };
>
> +static const unsigned int ad7606_18bit_hw_scale_avail[2] =3D {
> +       38147, 76294
> +};
> +
> +static const unsigned int ad7606c_16bit_single_ended_unipolar_scale_avai=
l[3] =3D {
> +       76294, 152588, 190735,
> +};
> +
> +static const unsigned int ad7606c_16bit_single_ended_bipolar_scale_avail=
[5] =3D {
> +       76294, 152588, 190735, 305176, 381470
> +};
> +
> +static const unsigned int ad7606c_16bit_differential_bipolar_scale_avail=
[4] =3D {
> +       152588, 305176, 381470, 610352
> +};
> +
> +static const unsigned int ad7606c_18bit_single_ended_unipolar_scale_avai=
l[3] =3D {
> +       19073, 38147, 47684
> +};
> +
> +static const unsigned int ad7606c_18bit_single_ended_bipolar_scale_avail=
[5] =3D {
> +       19073, 38147, 47684, 76294, 95367
> +};
> +
> +static const unsigned int ad7606c_18bit_differential_bipolar_scale_avail=
[4] =3D {
> +       38147, 76294, 95367, 152588
> +};
>
>  static const unsigned int ad7606_16bit_sw_scale_avail[3] =3D {
>         76293, 152588, 305176
> @@ -62,7 +89,8 @@ int ad7606_reset(struct ad7606_state *st)
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
>
> -static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st, int ch=
)
> +static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
> +                                        struct iio_chan_spec *chan, int =
ch)
>  {
>         struct ad7606_chan_scale *cs =3D &st->chan_scales[ch];
>
> @@ -83,6 +111,173 @@ static int ad7606_16bit_chan_scale_setup(struct ad76=
06_state *st, int ch)
>         return 0;
>  }
>
> +static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
> +                                 bool *bipolar, bool *differential)
> +{
> +       unsigned int num_channels =3D st->chip_info->num_channels - 1;
> +       struct device *dev =3D st->dev;
> +       int ret;
> +
> +       *bipolar =3D false;
> +       *differential =3D false;
> +
> +       device_for_each_child_node_scoped(dev, child) {
> +               u32 pins[2];
> +               int reg;
> +
> +               ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +               if (ret)
> +                       continue;
> +
> +               /* channel number (here) is from 1 to num_channels */
> +               if (reg =3D=3D 0 || reg > num_channels) {
> +                       dev_warn(dev,
> +                                "Invalid channel number (ignoring): %d\n=
", reg);
> +                       continue;
> +               }
> +
> +               if (reg !=3D (ch + 1))
> +                       continue;
> +
> +               *bipolar =3D fwnode_property_read_bool(child, "bipolar");
> +
> +               ret =3D fwnode_property_read_u32_array(child, "diff-chann=
els",
> +                                                    pins, ARRAY_SIZE(pin=
s));
> +               /* Channel is differential, if pins are the same as 'reg'=
 */
> +               if (ret =3D=3D 0 && (pins[0] !=3D reg || pins[1] !=3D reg=
)) {
> +                       dev_err(dev,
> +                               "Differential pins must be the same as 'r=
eg'");
> +                       return -EINVAL;
> +               }
> +
> +               *differential =3D (ret =3D=3D 0);
> +
> +               if (*differential && !*bipolar) {
> +                       dev_err(dev,
> +                               "'bipolar' must be added for diff channel=
 %d\n",
> +                               reg);
> +                       return -EINVAL;
> +               }
> +
> +               return 0;
> +       }
> +
> +       return 0;
> +}
> +
> +static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
> +                                         struct iio_chan_spec *chan, int=
 ch)
> +{
> +       struct ad7606_chan_scale *cs =3D &st->chan_scales[ch];
> +       bool bipolar, differential;
> +       int ret;
> +
> +       if (!st->sw_mode_en) {
> +               cs->range =3D 0;
> +               cs->scale_avail =3D ad7606_18bit_hw_scale_avail;
> +               cs->num_scales =3D ARRAY_SIZE(ad7606_18bit_hw_scale_avail=
);
> +               return 0;
> +       }
> +
> +       ret =3D ad7606_get_chan_config(st, ch, &bipolar, &differential);
> +       if (ret)
> +               return ret;
> +
> +       if (differential) {
> +               cs->scale_avail =3D ad7606c_18bit_differential_bipolar_sc=
ale_avail;
> +               cs->num_scales =3D
> +                       ARRAY_SIZE(ad7606c_18bit_differential_bipolar_sca=
le_avail);
> +               /* Bipolar differential ranges start at 8 (b1000) */
> +               cs->reg_offset =3D 8;
> +               cs->range =3D 1;
> +               chan->differential =3D 1;
> +               chan->channel2 =3D chan->channel;
> +
> +               return 0;
> +       }
> +
> +       chan->differential =3D 0;
> +
> +       if (bipolar) {
> +               cs->scale_avail =3D ad7606c_18bit_single_ended_bipolar_sc=
ale_avail;
> +               cs->num_scales =3D
> +                       ARRAY_SIZE(ad7606c_18bit_single_ended_bipolar_sca=
le_avail);
> +               /* Bipolar single-ended ranges start at 0 (b0000) */
> +               cs->reg_offset =3D 0;
> +               cs->range =3D 3;
> +               chan->scan_type.sign =3D 's';
> +
> +               return 0;
> +       }
> +
> +       cs->scale_avail =3D ad7606c_18bit_single_ended_unipolar_scale_ava=
il;
> +       cs->num_scales =3D
> +               ARRAY_SIZE(ad7606c_18bit_single_ended_unipolar_scale_avai=
l);
> +       /* Unipolar single-ended ranges start at 5 (b0101) */
> +       cs->reg_offset =3D 5;
> +       cs->range =3D 1;
> +       chan->scan_type.sign =3D 'u';
> +
> +       return 0;
> +}
> +
> +static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
> +                                         struct iio_chan_spec *chan, int=
 ch)
> +{
> +       struct ad7606_chan_scale *cs =3D &st->chan_scales[ch];
> +       bool bipolar, differential;
> +       int ret;
> +
> +       if (!st->sw_mode_en) {
> +               cs->range =3D 0;
> +               cs->scale_avail =3D ad7606_16bit_hw_scale_avail;
> +               cs->num_scales =3D ARRAY_SIZE(ad7606_16bit_hw_scale_avail=
);
> +               return 0;
> +       }
> +
> +       ret =3D ad7606_get_chan_config(st, ch, &bipolar, &differential);
> +       if (ret)
> +               return ret;
> +
> +       if (differential) {
> +               cs->scale_avail =3D ad7606c_16bit_differential_bipolar_sc=
ale_avail;
> +               cs->num_scales =3D
> +                       ARRAY_SIZE(ad7606c_16bit_differential_bipolar_sca=
le_avail);
> +               /* Bipolar differential ranges start at 8 (b1000) */
> +               cs->reg_offset =3D 8;
> +               cs->range =3D 1;
> +               chan->differential =3D 1;
> +               chan->channel2 =3D chan->channel;
> +               chan->scan_type.sign =3D 's';
> +
> +               return 0;
> +       }
> +
> +       chan->differential =3D 0;
> +
> +       if (bipolar) {
> +               cs->scale_avail =3D ad7606c_16bit_single_ended_bipolar_sc=
ale_avail;
> +               cs->num_scales =3D
> +                       ARRAY_SIZE(ad7606c_16bit_single_ended_bipolar_sca=
le_avail);
> +               /* Bipolar single-ended ranges start at 0 (b0000) */
> +               cs->reg_offset =3D 0;
> +               cs->range =3D 3;
> +               chan->scan_type.sign =3D 's';
> +
> +               return 0;
> +       }
> +
> +       cs->scale_avail =3D ad7606c_16bit_single_ended_unipolar_scale_ava=
il;
> +       cs->num_scales =3D
> +               ARRAY_SIZE(ad7606c_16bit_single_ended_unipolar_scale_avai=
l);
> +       /* Unipolar single-ended ranges start at 5 (b0101) */
> +       cs->reg_offset =3D 5;
> +       cs->range =3D 1;
> +       chan->scan_type.sign =3D 'u';
> +
> +       return 0;
> +}
> +
>  static int ad7606_reg_access(struct iio_dev *indio_dev,
>                              unsigned int reg,
>                              unsigned int writeval,
> @@ -107,9 +302,8 @@ static int ad7606_reg_access(struct iio_dev *indio_de=
v,
>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
>         unsigned int num =3D st->chip_info->num_channels - 1;
> -       u16 *data =3D st->data;
>
> -       return st->bops->read_block(st->dev, num, data);
> +       return st->bops->read_block(st->dev, num, &st->data);
>  }
>
>  static irqreturn_t ad7606_trigger_handler(int irq, void *p)
> @@ -125,7 +319,7 @@ static irqreturn_t ad7606_trigger_handler(int irq, vo=
id *p)
>         if (ret)
>                 goto error_ret;
>
> -       iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +       iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
>                                            iio_get_time_ns(indio_dev));
>  error_ret:
>         iio_trigger_notify_done(indio_dev->trig);
> @@ -139,6 +333,8 @@ static int ad7606_scan_direct(struct iio_dev *indio_d=
ev, unsigned int ch,
>                               int *val)
>  {
>         struct ad7606_state *st =3D iio_priv(indio_dev);
> +       unsigned int storagebits =3D st->chip_info->channels[1].scan_type=
.storagebits;
> +       const struct iio_chan_spec *chan;
>         int ret;
>
>         gpiod_set_value(st->gpio_convst, 1);
> @@ -153,7 +349,19 @@ static int ad7606_scan_direct(struct iio_dev *indio_=
dev, unsigned int ch,
>         if (ret)
>                 goto error_ret;
>
> -       *val =3D sign_extend32(st->data[ch], 15);
> +       chan =3D &indio_dev->channels[ch + 1];
> +       if (chan->scan_type.sign =3D=3D 'u') {
> +               if (storagebits > 16)
> +                       *val =3D st->data.buf32[ch];
> +               else
> +                       *val =3D st->data.buf16[ch];
> +               return 0;

Arrggh...
I messed up here.
Guillaume found a bug here, where this should be "goto error_ret" or
do an "if ()  {} else {}"
How should we do it here?

Do we send a fix-patch or send a new series?


> +       }
> +
> +       if (storagebits > 16)
> +               *val =3D sign_extend32(st->data.buf32[ch], 17);
> +       else
> +               *val =3D sign_extend32(st->data.buf16[ch], 15);
>
>  error_ret:
>         gpiod_set_value(st->gpio_convst, 0);
> @@ -266,7 +474,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev=
,
>                         ch =3D chan->address;
>                 cs =3D &st->chan_scales[ch];
>                 i =3D find_closest(val2, cs->scale_avail, cs->num_scales)=
;
> -               ret =3D st->write_scale(indio_dev, ch, i);
> +               ret =3D st->write_scale(indio_dev, ch, i + cs->reg_offset=
);
>                 if (ret < 0)
>                         return ret;
>                 cs->range =3D i;
> @@ -349,6 +557,18 @@ static const struct iio_chan_spec ad7606_channels_16=
bit[] =3D {
>         AD7606_CHANNEL(7, 16),
>  };
>
> +static const struct iio_chan_spec ad7606_channels_18bit[] =3D {
> +       IIO_CHAN_SOFT_TIMESTAMP(8),
> +       AD7606_CHANNEL(0, 18),
> +       AD7606_CHANNEL(1, 18),
> +       AD7606_CHANNEL(2, 18),
> +       AD7606_CHANNEL(3, 18),
> +       AD7606_CHANNEL(4, 18),
> +       AD7606_CHANNEL(5, 18),
> +       AD7606_CHANNEL(6, 18),
> +       AD7606_CHANNEL(7, 18),
> +};
> +
>  /*
>   * The current assumption that this driver makes for AD7616, is that it'=
s
>   * working in Hardware Mode with Serial, Burst and Sequencer modes activ=
ated.
> @@ -414,6 +634,20 @@ static const struct ad7606_chip_info ad7606_chip_inf=
o_tbl[] =3D {
>                 .oversampling_avail =3D ad7606_oversampling_avail,
>                 .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avai=
l),
>         },
> +       [ID_AD7606C_16] =3D {
> +               .channels =3D ad7606_channels_16bit,
> +               .num_channels =3D 9,
> +               .scale_setup_cb =3D ad7606c_16bit_chan_scale_setup,
> +               .oversampling_avail =3D ad7606_oversampling_avail,
> +               .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avai=
l),
> +       },
> +       [ID_AD7606C_18] =3D {
> +               .channels =3D ad7606_channels_18bit,
> +               .num_channels =3D 9,
> +               .scale_setup_cb =3D ad7606c_18bit_chan_scale_setup,
> +               .oversampling_avail =3D ad7606_oversampling_avail,
> +               .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avai=
l),
> +       },
>         [ID_AD7616] =3D {
>                 .channels =3D ad7616_channels,
>                 .num_channels =3D 17,
> @@ -586,7 +820,7 @@ static const struct iio_trigger_ops ad7606_trigger_op=
s =3D {
>         .validate_device =3D iio_trigger_validate_own_device,
>  };
>
> -static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
> +static int ad7606_sw_mode_setup(struct iio_dev *indio_dev, unsigned int =
id)
>  {
>         struct ad7606_state *st =3D iio_priv(indio_dev);
>
> @@ -604,13 +838,24 @@ static int ad7606_chan_scales_setup(struct iio_dev =
*indio_dev)
>  {
>         unsigned int num_channels =3D indio_dev->num_channels - 1;
>         struct ad7606_state *st =3D iio_priv(indio_dev);
> +       struct iio_chan_spec *chans;
> +       size_t size;
>         int ch, ret;
>
> +       /* Clone IIO channels, since some may be differential */
> +       size =3D indio_dev->num_channels * sizeof(*indio_dev->channels);
> +       chans =3D devm_kzalloc(st->dev, size, GFP_KERNEL);
> +       if (!chans)
> +               return -ENOMEM;
> +
> +       memcpy(chans, indio_dev->channels, size);
> +       indio_dev->channels =3D chans;
> +
>         for (ch =3D 0; ch < num_channels; ch++) {
>                 struct ad7606_chan_scale *cs;
>                 int i;
>
> -               ret =3D st->chip_info->scale_setup_cb(st, ch);
> +               ret =3D st->chip_info->scale_setup_cb(st, &chans[ch + 1],=
 ch);
>                 if (ret)
>                         return ret;
>
> @@ -698,7 +943,7 @@ int ad7606_probe(struct device *dev, int irq, void __=
iomem *base_address,
>         st->write_scale =3D ad7606_write_scale_hw;
>         st->write_os =3D ad7606_write_os_hw;
>
> -       ret =3D ad7606_sw_mode_setup(indio_dev);
> +       ret =3D ad7606_sw_mode_setup(indio_dev, id);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 25e84efd15c3..14ee75aa225b 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -63,7 +63,8 @@
>
>  struct ad7606_state;
>
> -typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st, int ch);
> +typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
> +                                      struct iio_chan_spec *chan, int ch=
);
>
>  /**
>   * struct ad7606_chip_info - chip specific information
> @@ -94,6 +95,8 @@ struct ad7606_chip_info {
>   *                     such that it can be read via the 'read_avail' hoo=
k
>   * @num_scales         number of elements stored in the scale_avail arra=
y
>   * @range              voltage range selection, selects which scale to a=
pply
> + * @reg_offset         offset for the register value, to be applied when
> + *                     writing the value of 'range' to the register valu=
e
>   */
>  struct ad7606_chan_scale {
>  #define AD760X_MAX_SCALES              16
> @@ -102,6 +105,7 @@ struct ad7606_chan_scale {
>         int                             scale_avail_show[AD760X_MAX_SCALE=
_SHOW];
>         unsigned int                    num_scales;
>         unsigned int                    range;
> +       unsigned int                    reg_offset;
>  };
>
>  /**
> @@ -158,9 +162,13 @@ struct ad7606_state {
>         /*
>          * DMA (thus cache coherency maintenance) may require the
>          * transfer buffers to live in their own cache lines.
> -        * 16 * 16-bit samples + 64-bit timestamp
> +        * 16 * 16-bit samples + 64-bit timestamp - for AD7616
> +        * 8 * 32-bit samples + 64-bit timestamp - for AD7616C-18 (and si=
milar)
>          */
> -       unsigned short                  data[20] __aligned(IIO_DMA_MINALI=
GN);
> +       union {
> +               u16 buf16[20];
> +               u32 buf32[10];
> +       } data __aligned(IIO_DMA_MINALIGN);
>         __be16                          d16[2];
>  };
>
> @@ -201,6 +209,8 @@ enum ad7606_supported_device_ids {
>         ID_AD7606_6,
>         ID_AD7606_4,
>         ID_AD7606B,
> +       ID_AD7606C_16,
> +       ID_AD7606C_18,
>         ID_AD7616,
>  };
>
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index e00f58a6a0e9..143440e73aab 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -77,6 +77,18 @@ static const struct iio_chan_spec ad7606b_sw_channels[=
] =3D {
>         AD7606_SW_CHANNEL(7, 16),
>  };
>
> +static const struct iio_chan_spec ad7606c_18_sw_channels[] =3D {
> +       IIO_CHAN_SOFT_TIMESTAMP(8),
> +       AD7606_SW_CHANNEL(0, 18),
> +       AD7606_SW_CHANNEL(1, 18),
> +       AD7606_SW_CHANNEL(2, 18),
> +       AD7606_SW_CHANNEL(3, 18),
> +       AD7606_SW_CHANNEL(4, 18),
> +       AD7606_SW_CHANNEL(5, 18),
> +       AD7606_SW_CHANNEL(6, 18),
> +       AD7606_SW_CHANNEL(7, 18),
> +};
> +
>  static const unsigned int ad7606B_oversampling_avail[9] =3D {
>         1, 2, 4, 8, 16, 32, 64, 128, 256
>  };
> @@ -120,6 +132,19 @@ static int ad7606_spi_read_block(struct device *dev,
>         return 0;
>  }
>
> +static int ad7606_spi_read_block18to32(struct device *dev,
> +                                      int count, void *buf)
> +{
> +       struct spi_device *spi =3D to_spi_device(dev);
> +       struct spi_transfer xfer =3D {
> +               .bits_per_word =3D 18,
> +               .len =3D count * sizeof(u32),
> +               .rx_buf =3D buf,
> +       };
> +
> +       return spi_sync_transfer(spi, &xfer, 1);
> +}
> +
>  static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int add=
r)
>  {
>         struct spi_device *spi =3D to_spi_device(st->dev);
> @@ -283,6 +308,19 @@ static int ad7606B_sw_mode_config(struct iio_dev *in=
dio_dev)
>         return 0;
>  }
>
> +static int ad7606c_18_sw_mode_config(struct iio_dev *indio_dev)
> +{
> +       int ret;
> +
> +       ret =3D ad7606B_sw_mode_config(indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       indio_dev->channels =3D ad7606c_18_sw_channels;
> +
> +       return 0;
> +}
> +
>  static const struct ad7606_bus_ops ad7606_spi_bops =3D {
>         .read_block =3D ad7606_spi_read_block,
>  };
> @@ -305,6 +343,15 @@ static const struct ad7606_bus_ops ad7606B_spi_bops =
=3D {
>         .sw_mode_config =3D ad7606B_sw_mode_config,
>  };
>
> +static const struct ad7606_bus_ops ad7606c_18_spi_bops =3D {
> +       .read_block =3D ad7606_spi_read_block18to32,
> +       .reg_read =3D ad7606_spi_reg_read,
> +       .reg_write =3D ad7606_spi_reg_write,
> +       .write_mask =3D ad7606_spi_write_mask,
> +       .rd_wr_cmd =3D ad7606B_spi_rd_wr_cmd,
> +       .sw_mode_config =3D ad7606c_18_sw_mode_config,
> +};
> +
>  static int ad7606_spi_probe(struct spi_device *spi)
>  {
>         const struct spi_device_id *id =3D spi_get_device_id(spi);
> @@ -315,8 +362,12 @@ static int ad7606_spi_probe(struct spi_device *spi)
>                 bops =3D &ad7616_spi_bops;
>                 break;
>         case ID_AD7606B:
> +       case ID_AD7606C_16:
>                 bops =3D &ad7606B_spi_bops;
>                 break;
> +       case ID_AD7606C_18:
> +               bops =3D &ad7606c_18_spi_bops;
> +               break;
>         default:
>                 bops =3D &ad7606_spi_bops;
>                 break;
> @@ -333,6 +384,8 @@ static const struct spi_device_id ad7606_id_table[] =
=3D {
>         { "ad7606-6", ID_AD7606_6 },
>         { "ad7606-8", ID_AD7606_8 },
>         { "ad7606b",  ID_AD7606B },
> +       { "ad7606c-16",  ID_AD7606C_16 },
> +       { "ad7606c-18",  ID_AD7606C_18 },
>         { "ad7616",   ID_AD7616 },
>         { }
>  };
> @@ -344,6 +397,8 @@ static const struct of_device_id ad7606_of_match[] =
=3D {
>         { .compatible =3D "adi,ad7606-6" },
>         { .compatible =3D "adi,ad7606-8" },
>         { .compatible =3D "adi,ad7606b" },
> +       { .compatible =3D "adi,ad7606c-16" },
> +       { .compatible =3D "adi,ad7606c-18" },
>         { .compatible =3D "adi,ad7616" },
>         { }
>  };
> --
> 2.46.0
>

