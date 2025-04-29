Return-Path: <linux-iio+bounces-18886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FECAA3B74
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 00:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A05E9A39AA
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B212749F4;
	Tue, 29 Apr 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ6KqqbV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD92749ED;
	Tue, 29 Apr 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965641; cv=none; b=kcwXP2a5LukXJPto3XO6jMiuyh01uM7tcwoDtOoDIoZs7EDfaVk1QfveLZDYXyfIk8zQ9ptLAySA+NqNY4DE+SBzED5M1SGqDOy+QPrynci4qun563tg9PiGH+ME49sBK0xNpQUkHamg9hLDoR6aUxvDkfd55eTsLF1EidgcaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965641; c=relaxed/simple;
	bh=OtGRqdpcH2U0CtLkLJmpDiCYxHQ/nTJLUL4O01UeOIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRj5cxxWGbGcy/Iq6y/xlA5D67Ei/IAU/1SLMWLgvO70WU47irwp/S9v7UX8BiH5wpoTz2MnzUtEnBPHJu4YRBlLTmzHPBoW0bKeA7W91CFp1gHI2ds4XjUPzVfzHzDYS9fmelSuFzLfgBEdd7pPMgRY42/70PexSixQX3qdTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ6KqqbV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso1165083366b.0;
        Tue, 29 Apr 2025 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745965638; x=1746570438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd9gQCsKJpq8vf5tNDACpW4tnOCKgHHE95O2VfBWGgw=;
        b=lJ6KqqbVnwOBoeuLZFoL3MQeu6BYOV7II8KbYTTDkM97GSbMsO7aNQFFgteV7lv8Fj
         34kyMk0F7vmVp4o1AmPsaKdIpoTivsHF2Z92R1SEe7su2Dd0wnQbr98COshv5wx8xuJh
         xRQObbUx3m3cu3hvplVf4SV8LN6r0O4zQL3xF0nr+14bdzvq8I4aTqvuT42AWWYuZV9u
         fn8HqJHh8fomlbl8R6dVa0Su8RpH3Yn+4or8I7rKv0svE1HCvHcyHC6MZ/wy/wurDlnw
         n7N89wiqctqA3qQ9og3xQuA/V0m6mMvkcL+XruWcVjOsUcbyg07uF72nMhWqmYYpkyGR
         UqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745965638; x=1746570438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zd9gQCsKJpq8vf5tNDACpW4tnOCKgHHE95O2VfBWGgw=;
        b=IUe3fZLPpgL4XqxO9Td/YI7q061GQ+F6FKh55Qx4RDj3lmoUNxX17BUqk6+1S4oKCc
         ehM1BZfAAgACgXjxytJFlCpKlr6CbMUkHNPkD4vnisIr+HFQTF9CJnYxdSG2gVfdZ5hI
         QsMeBd/OS+qav+zMMD9Sf2nSgytwvWR4YIWdAcBevptngLXpbZukaGp5GNe0CI0nBVYw
         TPf4qhl9If+OtlXW6c5+Zh2rPjra0Te5A/Jf5m2g7bFu9SauGUa3ewUzq4YuC5ksX/9Z
         eOPZ84/+wR6uSlz6yoGfIHhkZ0IlKDr+MBKzoqWn61CiaT5cAh3phdx8pbN39xHoQ2d4
         W1sw==
X-Forwarded-Encrypted: i=1; AJvYcCVNTkoTEZNA1iXIE+Oo4AUf9cwBHDA6G2qTmmvP8z4JcBTKX4T6vwSPKQnKZO+6+Nn+e8eEv3Trw8mW@vger.kernel.org, AJvYcCVdzymBQ7A/LtsrZ0bxNtOAc59CfnXO7kBe093Ae+uaVHH9ZvvomJFS6hEONxlh0KPDiPpWbC/otx+DwJjn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe6gq3OZCO4njNJIEz8lf94cui1wykurt8nxuB991ag4WeYA7c
	b2rxZkdMd4HyTqVBxevvgt5PBxdf6QI7zwkXTSgd825svV029fRj4XSQU0X1PcxnvAMTKzSB/ii
	hjFS4e7aL4uRAeQdGLKaGIpQmMls=
X-Gm-Gg: ASbGnct72OMHKjFEmWbQXfgwx407kk5mrj2cZ1HQNTJ6MLKcBTiQleZzQZS7+HWy6E7
	dLhO3IVRttNOAVn261b+U/kq6C/mBgoPvCP+4cFkvxhXJcnD3g7l8NQUNSfFMyfslc5eaevirUt
	5adO8mDpuxZ1JtbMB4lL+98A==
X-Google-Smtp-Source: AGHT+IGyPe8/uaDOHmjcGbfNVqIL3Y3TgPPVPT9WBKU8oWu6v5eOMjG3nnoHsGqwoKvwkgL/6GUeyG2HdpbTIWpYj0w=
X-Received: by 2002:a17:907:1c96:b0:ace:c3a9:81bb with SMTP id
 a640c23a62f3a-acedc593309mr104325266b.5.1745965637879; Tue, 29 Apr 2025
 15:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745841276.git.marcelo.schmitt@analog.com> <3687a9e0a479aef9736ad557b341ed2e7d4f5756.1745841276.git.marcelo.schmitt@analog.com>
In-Reply-To: <3687a9e0a479aef9736ad557b341ed2e7d4f5756.1745841276.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:26:41 +0300
X-Gm-Features: ATxdqUGegN2_s_sjODFS8rtIi860gHJiqkmftv0vqgAn_mQCpAdd8_T7EXvMtwA
Message-ID: <CAHp75VerW=GnsomWLqUyK6AWU+dVDPxhAVmafuwy4cDpbyPVUA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio: adc: ad4170: Add support for weigh scale and
 RTD sensors
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:30=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> The AD4170 design has features to aid interfacing with weigh scale and RT=
D
> sensors that are expected to be setup with external circuitry for proper
> sensor operation. A key characteristic of those sensors is that the circu=
it
> they are in must be excited with a pair of signals. The external circuit
> can be excited either by voltage supply or by AD4170 excitation signals.
> The sensor can then be read through a different pair of lines that are
> connected to AD4170 ADC.
>
> Configure AD4170 to handle external circuit sensors.

...

> +static const unsigned int ad4170_iout_current_ua_tbl[] =3D {
> +       0, 10, 50, 100, 250, 500, 1000, 1500

Leave trailing comma.

> +};

...

> +       if (st->pins_fn[ain_n] & AD4170_PIN_VBIAS) {
> +               *ain_voltage =3D (st->vrefs_uv[AD4170_AVDD_SUP]
> +                               - st->vrefs_uv[AD4170_AVSS_SUP]) / 2;

Don't wrap like this, keep the logical split, and looking at this I
would just put it either on a single line, or use a temporary variable
for the expression in parentheses.

> +               return 0;
> +       }

...

> +static int ad4170_validate_excitation_pins(struct ad4170_state *st,
> +                                          u32 *exc_pins, int num_exc_pin=
s)
> +{
> +       struct device *dev =3D &st->spi->dev;
> +       int ret, i;

Should 'i' be signed?

> +       for (i =3D 0; i < num_exc_pins; i++) {
> +               unsigned int pin =3D exc_pins[i];
> +
> +               ret =3D ad4170_find_table_index(ad4170_iout_pin_tbl, pin)=
;
> +               if (ret < 0)
> +                       return dev_err_probe(dev, ret,
> +                                            "Invalid excitation pin: %u\=
n",
> +                                            pin);
> +
> +               if (pin <=3D AD4170_MAX_ANALOG_PINS) {
> +                       if (st->pins_fn[pin] !=3D AD4170_PIN_UNASIGNED)
> +                               return dev_err_probe(dev, -EINVAL,
> +                                                    "Pin %u already used=
 with fn %u\n",
> +                                                    pin, st->pins_fn[pin=
]);
> +
> +                       st->pins_fn[pin] |=3D AD4170_PIN_CURRENT_OUT;
> +               } else {
> +                       unsigned int gpio =3D pin - AD4170_CURRENT_SRC_I_=
OUT_PIN_GPIO0;
> +
> +                       if (st->gpio_fn[gpio] !=3D AD4170_GPIO_UNASIGNED)
> +                               return dev_err_probe(dev, -EINVAL,
> +                                                    "GPIO %u already use=
d with fn %u\n",
> +                                                    gpio, st->gpio_fn[gp=
io]);
> +
> +                       st->gpio_fn[gpio] |=3D AD4170_GPIO_AC_EXCITATION;
> +               }
> +       }
> +       return 0;
> +}

...

Also consider inverting the conditional in ad4170_setup_bridge() to
drop indentation level in a lot of LoCs.

...

> +       switch (s_type) {
> +       case AD4170_ADC_SENSOR:
> +               ret =3D ad4170_parse_adc_channel_type(dev, child, chan);
> +               if (ret < 0)

Why ' < 0'?

> +                       return ret;
> +
> +               break;
> +       case AD4170_WEIGH_SCALE_SENSOR:
> +               fallthrough;
> +       case AD4170_THERMOCOUPLE_SENSOR:
> +               fallthrough;
> +       case AD4170_RTD_SENSOR:
> +               ret =3D ad4170_parse_external_sensor(st, child, setup, ch=
an,
> +                                                  s_type);
> +               if (ret < 0)

Ditto.

> +                       return ret;
>
> +               break;
> +       default:
> +               return -EINVAL;
> +       }

--=20
With Best Regards,
Andy Shevchenko

