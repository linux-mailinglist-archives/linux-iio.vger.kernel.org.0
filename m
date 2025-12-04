Return-Path: <linux-iio+bounces-26732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA79CA3A9F
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 13:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431943069E3D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C3341045;
	Thu,  4 Dec 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H47xjB+h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB72F99A3
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852513; cv=none; b=Vtg0Nh1dwNH/kVVebyTkh5FFpnM2KXvdgO/X3jN0FxD7ETaADO4UHR1wAemEVuyijcLYYtH0TcxUfjQzV2kmGlWyJ8+5pF4r6SlizICtt88Tdyz3WaEAV26h/+RtAamCDspurKnbgxMZxcqAIT4vQImdv/qGMCzQzo4F1PZ2Q3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852513; c=relaxed/simple;
	bh=EF/ZE+XVVwNteVh/X9JBALU62U0eV0fb45mT3KKsBW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6Xfvu2gOhWU2j36B/ezDB6NX2dHw2Os7AzeNaYJeW8+bDCoj9aXBk/GlbTPHjwEuDxg+vTuPjQ+uoY9lIybTFDxPzBoJxywOtKnipB90nM4aFCZNL6O9bZbY+LwlhWTTyjOMpRQe+1iTXmyNmxmX3948SNY4SjO4w3L8VKNexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H47xjB+h; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b770f4accc0so112856066b.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 04:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764852508; x=1765457308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iMlmEnZbUHewWGtOlOpHNRr261tcZuz9+wmB1gsqKw=;
        b=H47xjB+hmI2yPr6ftppvjjgkGvLGNGtt3/TPQZwv4wb0fmn3URZ+8WnDVfsiQ32yre
         INE+l0cYSNQ7fYBfUMggoDhomaQ2DXLK3MPQ/FpDyrPxe9O9LYaAq/IuA2wasrWJ3ji4
         KIW/9E8/1P0MiH7M40R7YBBneOCCam77In2bhJPxL1oOp8o+wdKMro/VLJxnz/Cm2cr7
         kdKGDjLpbkWlASsNdipNDzedjw1nEtMlE7++9WsjuRLOcOQLbugKvAUmtaNr/fRKv2hv
         AR6m1+CXsDbwWoItV6dKOE7Uabgmo8o5+Hx560b6tdtYtGic/1DFETFE6KLKbVm9EYKF
         UoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764852508; x=1765457308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iMlmEnZbUHewWGtOlOpHNRr261tcZuz9+wmB1gsqKw=;
        b=hSslQ5zKG/Osb+PuX4qUMpKVFBhKhKuyPt2Jx2bIyDa682VlqlvMkPiOyr6f/QADVw
         diRr9hmugCKKX9BlsBREIM2pLkrZUyFaMbDIYsvKmxoqjlVu1Ewv3r/6j6lXZPhk3moT
         tDH0rBWjnopf+giNOdd6E/PQC/uEMTfm4gkafsgbTXfxnSl2At3yTFlfjBQL5H95kiZn
         zs3eypKOpSVPLTCMsF1B5ZpufOQZLn4J9dzgk/RYve+OWJQOTHC5Nv1nN3l7783gwD8c
         8VisMcECdCWbQM+lQKVz2BmvmsIak2TuSAKBjwWEmnnuFWH9wTflql9CcrY9zDU65dCe
         BNmg==
X-Forwarded-Encrypted: i=1; AJvYcCXUcrRyz8l6m5+M45z2KTxe0+s5607oBeEyqw69ol9Fv54G4cFpDxYpRKFB1AXL3JBu3ZDYbCg2d68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9IhQQIc7H4hnl1YeGHBfRyt7G01HIiVX3Zu4QvTiRbE2xHP+
	N9fzNYW2l5M0ivk06O0UGS7STGQoimiqfAKWAogIrlIMfKo+UkbXFyfZV5bXsavvREPwUOCM1+f
	2cVZzRAN9SX8LGjygieTuARfLDNchW58=
X-Gm-Gg: ASbGncuPOW6BgWNg6vyLW82s9HnIAeCyOUQF4RjV9CTqNtxRUFbgN6NzBocjTf7G+Z0
	A5ZLTNc1FHhPkPlF3l095fxAx9hstnPyMBRykP95QkrklHcrw9xJtR3hHe8pJJa07Ev9ZwNT9kJ
	OxMF3CjPI3s8zUaXpMCW3YuPLGHydYexSWQfqZyd8cyTT5ES8F1ZYN/7LSMpaKFIyedOBksd3Zz
	TuXalzS0ykbl7W6ddgcJOCA9QMoeVfuvZAkil5+XEpYxL4FnCrD89PEfJ6PhqNKPJYJf4S6nYVm
	g7Ye9RhgzdnoAIdbL0eqrqDInYm96yaFsGCj4BQyGCxkN8g5arrbSH3T27buOc1/xGzotZQ=
X-Google-Smtp-Source: AGHT+IHxXXlScA3QP/B2QfMo4xnLROwd1JIxWdG8x8qG6z64K/dZu/VZxhDRyPQ8JxEnYNU3HXvbJCcG9Csp14GfSUI=
X-Received: by 2002:a17:907:3d8c:b0:b73:6dbc:39fc with SMTP id
 a640c23a62f3a-b79ec67cb74mr257554366b.30.1764852508212; Thu, 04 Dec 2025
 04:48:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128144428.24450-1-antoniu.miclaus@analog.com> <20251128144428.24450-3-antoniu.miclaus@analog.com>
In-Reply-To: <20251128144428.24450-3-antoniu.miclaus@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Dec 2025 14:47:51 +0200
X-Gm-Features: AWmQ_blTzO-KfSkXQpkf5TzX35AHqsS6sD5cdEJm8oDVAm7paC_oB7WvX1az-n8
Message-ID: <CAHp75VcxYGskVpQ5HKiFUUnNSj-9qpdXeBjz9-oEHc9eumE0fg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: amplifiers: adl8113: add driver support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 4:45=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
> 10MHz to 14GHz bypass switches.

Almost there, it's the 5th version and looks good (no major issues),
so if you address my comments below in v6, I'll give a tag.

...

> +#include <linux/array_size.h>

+ bitmap.h // bitmap_*(), BIT(), GENMASK(), etc.

> +#include <linux/device.h>

Is it really used? I found

+ dev_printk.h // dev_err_probe() et al.
+ device/devres.h // devm_k*alloc*()

> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>

+ limits.h // INT_MIN

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>

> +#include <linux/slab.h>
> +#include <linux/sysfs.h>

Are those two being used? (device/devres.h should provide what
devm_k*alloc*() needs)

+ types.h // DECLARE_BITMAP()

...

> +struct adl8113_state {
> +       struct gpio_descs *gpios;
> +       struct adl8113_gain_config *gain_configs;
> +       int num_gain_configs;

Do you need this to be signed?

> +       enum adl8113_signal_path current_path;
> +};

...

> +static const char * const adl8113_supply_names[] =3D {
> +       "vdd1",
> +       "vss2",
> +       "vdd2"

Please, keep the trailing comma.

> +};

...

> +static int adl8113_set_path(struct adl8113_state *st,
> +                           enum adl8113_signal_path path)
> +{
> +       DECLARE_BITMAP(values, 2);
> +       int ret;

> +       bitmap_zero(values, 2);

Move this to the switch case...

> +       /* Determine GPIO values based on signal path */
> +       switch (path) {
> +       case ADL8113_INTERNAL_AMP:

> +               /* va=3D0, vb=3D0 - already zero */

Unneeded comment here and below, just put a number to the bitmap

  bitmap_write(..., 0x00);

> +               break;
> +       case ADL8113_INTERNAL_BYPASS:
> +               /* va=3D1, vb=3D1 */
> +               __set_bit(0, values);
> +               __set_bit(1, values);

  bitmap_write(..., 0x03);

> +               break;
> +       case ADL8113_EXTERNAL_A:
> +               /* va=3D0, vb=3D1 */
> +               __set_bit(1, values);

  bitmap_write(..., 0x02);

> +               break;
> +       case ADL8113_EXTERNAL_B:
> +               /* va=3D1, vb=3D0 */
> +               __set_bit(0, values);

  bitmap_write(..., 0x01);

> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret =3D gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpi=
os->desc,
> +                                            st->gpios->info, values);
> +       if (ret)
> +               return ret;
> +
> +       st->current_path =3D path;
> +       return 0;
> +}

...

> +static int adl8113_find_gain_config(struct adl8113_state *st, int gain_d=
b)
> +{
> +       int i;

Does it need to be signed?

> +       for (i =3D 0; i < st->num_gain_configs; i++) {
> +               if (st->gain_configs[i].gain_db =3D=3D gain_db)
> +                       return i;
> +       }
> +       return -EINVAL;
> +}

...

> +static int adl8113_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int *val, int *val2, long mask)
> +{
> +       struct adl8113_state *st =3D iio_priv(indio_dev);
> +       int i;

  unsigned int i;

> +       switch (mask) {
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               /* Find current gain configuration */
> +               for (i =3D 0; i < st->num_gain_configs; i++) {
> +                       if (st->gain_configs[i].path =3D=3D st->current_p=
ath) {
> +                               *val =3D st->gain_configs[i].gain_db;
> +                               *val2 =3D 0;
> +                               return IIO_VAL_INT_PLUS_MICRO_DB;
> +                       }
> +               }
> +               return -EINVAL;
> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +static int adl8113_init_gain_configs(struct device *dev, struct adl8113_=
state *st)
> +{
> +       int external_a_gain, external_b_gain, i =3D 0, j;

  unsigned int i, j;

And it's better to decouple assignment

> +       /*
> +        * Allocate for all 4 possible paths:
> +        * - Internal amp and bypass (always present)
> +        * - External bypass A and B (optional, or INT_MIN for testing)
> +        */
> +       st->gain_configs =3D devm_kcalloc(dev, 4,
> +                                       sizeof(*st->gain_configs), GFP_KE=
RNEL);
> +       if (!st->gain_configs)
> +               return -ENOMEM;

  /* Start filling the gain configurations with  data */
  i =3D 0;

> +       /* Always include internal amplifier (14dB) */
> +       st->gain_configs[i].path =3D ADL8113_INTERNAL_AMP;
> +       st->gain_configs[i].gain_db =3D 14;
> +       i++;
> +
> +       /* Always include internal bypass (-2dB insertion loss) */
> +       st->gain_configs[i].path =3D ADL8113_INTERNAL_BYPASS;
> +       st->gain_configs[i].gain_db =3D -2;
> +       i++;
> +
> +       /* Add external bypass A if configured */
> +       if (!device_property_read_u32(dev, "adi,external-bypass-a-gain-db=
",
> +                                     &external_a_gain)) {
> +               st->gain_configs[i].path =3D ADL8113_EXTERNAL_A;
> +               st->gain_configs[i].gain_db =3D external_a_gain;
> +               i++;
> +       }
> +
> +       /* Add external bypass B if configured */
> +       if (!device_property_read_u32(dev, "adi,external-bypass-b-gain-db=
",
> +                                     &external_b_gain)) {
> +               st->gain_configs[i].path =3D ADL8113_EXTERNAL_B;
> +               st->gain_configs[i].gain_db =3D external_b_gain;
> +               i++;
> +       }
> +
> +       /*
> +        * If there's a free external bypass path, add one with INT_MIN g=
ain
> +        * to represent "nothing connected" for testing purposes

Missing period at the end.

> +        */
> +       if (!device_property_present(dev, "adi,external-bypass-a-gain-db"=
)) {
> +               st->gain_configs[i].path =3D ADL8113_EXTERNAL_A;
> +               st->gain_configs[i].gain_db =3D INT_MIN;
> +               i++;
> +       } else if (!device_property_present(dev, "adi,external-bypass-b-g=
ain-db")) {
> +               st->gain_configs[i].path =3D ADL8113_EXTERNAL_B;
> +               st->gain_configs[i].gain_db =3D INT_MIN;
> +               i++;
> +       }
> +
> +       st->num_gain_configs =3D i;
> +
> +       /* Check for duplicate gain values */
> +       for (i =3D 0; i < st->num_gain_configs - 1; i++) {
> +               for (j =3D i + 1; j < st->num_gain_configs; j++) {
> +                       if (st->gain_configs[i].gain_db =3D=3D st->gain_c=
onfigs[j].gain_db)
> +                               return dev_err_probe(dev, -EINVAL,
> +                                                    "Duplicate gain valu=
es not allowed: %d dB\n",
> +                                                    st->gain_configs[i].=
gain_db);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int adl8113_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct adl8113_state *st;
> +       struct iio_dev *indio_dev;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st =3D iio_priv(indio_dev);
> +
> +       st->gpios =3D devm_gpiod_get_array(dev, "ctrl", GPIOD_OUT_LOW);
> +       if (IS_ERR(st->gpios))
> +               return dev_err_probe(dev, PTR_ERR(st->gpios),
> +                                    "failed to get control GPIOs\n");
> +
> +       if (st->gpios->ndescs !=3D 2)
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "expected 2 control GPIOs, got %d\n"=
,

%u

> +                                    st->gpios->ndescs);
> +
> +       ret =3D devm_regulator_bulk_get_enable(dev,
> +                                            ARRAY_SIZE(adl8113_supply_na=
mes),
> +                                            adl8113_supply_names);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "failed to get and enable supplies\n=
");
> +
> +       /* Initialize gain configurations from devicetree */
> +       ret =3D adl8113_init_gain_configs(dev, st);
> +       if (ret)
> +               return ret;
> +
> +       /* Initialize to internal amplifier path (14dB) */
> +       ret =3D adl8113_set_path(st, ADL8113_INTERNAL_AMP);
> +       if (ret)
> +               return ret;
> +
> +       indio_dev->info =3D &adl8113_info;
> +       indio_dev->name =3D "adl8113";
> +       indio_dev->channels =3D adl8113_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(adl8113_channels);
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static struct platform_driver adl8113_driver =3D {
> +       .driver =3D {
> +               .name =3D "adl8113",
> +               .of_match_table =3D adl8113_of_match,
> +       },
> +       .probe =3D adl8113_probe,
> +};

> +

Redundant blank line.

> +module_platform_driver(adl8113_driver);

--=20
With Best Regards,
Andy Shevchenko

