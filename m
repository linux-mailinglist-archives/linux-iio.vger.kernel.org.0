Return-Path: <linux-iio+bounces-18882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60296AA3B0F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 00:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFCE3A7F66
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC28270EC8;
	Tue, 29 Apr 2025 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeTLEOHD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0341C26B972;
	Tue, 29 Apr 2025 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964661; cv=none; b=dKRG5YkfbSjxIUSpEaIMsfI2j4oGvZVDceC64032MrcVGRh6iRa6eaaKTM/BQrOY5Q5QSC8jD46BQ5b8q1Gev9FY2fq3CLieVdLYcOz4OpQHxy9c+eenLno5AdN+b/5SpO8Gt8fUZ3q8OXzqYmP/WVDxfRJu+DieftcJGV57xUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964661; c=relaxed/simple;
	bh=GqNTtiTxvSw2B7Od27I5dBawehz/1CBbZiKPhBAXy+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pG45UezBLR14q52akxFJz88yUJ2zJ+R2kMygdtQCImvFpWxw3+WPP6Lzedd44YFwWXsKe13oBWTpRzYXwe/hJNGZaAMnSxehQvdsvr11Ii0aw8klItHkzDI7S1X+1opiiwOtABNnA76yOFwbTxGT1hNa9F/3GG/44EF+i91SPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeTLEOHD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac7bd86f637so56584166b.1;
        Tue, 29 Apr 2025 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745964658; x=1746569458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wulbu5u6nmYY7TAEYvPimM4g5rhZn504exzjJnSIs0A=;
        b=ZeTLEOHDTLlwToDftStZFdTEjVcMMEGDt9Pu08oGEEEGno/8EjGpQ7YMzIkNlAR80y
         OVoK7hwlROHPoEcb67mF2ul9XoVxj+NEW48JFbccJAzTU1fRp4kgbGzzohfhLLhwjiOP
         aWSDPrwMTYXVGdGHkcYBf2qIAQ4F6yQb9q97dnnbN41xUQi2wUVy0bOT+sWb/YPJiRIT
         DUjCCnFW1Yl4fy1UVrotA0gH5bOiXOBhivIDnZYgGhKvnWtPBGLm3QK+y12uzDvkKx/S
         jFLZtkrpQGHV/jRhEM6ZRoKX6Sz00yVLVI88lF8iD6Ag45UMt0FRh7lKmVebZ1ot9f/N
         7fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745964658; x=1746569458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wulbu5u6nmYY7TAEYvPimM4g5rhZn504exzjJnSIs0A=;
        b=rPqNDtw6ICucMIA9b8/5Epp2qakv+1373N8jM6p80JgO4D6I8KdeaikoAJEGNnzii+
         lbmIaSTNmkX22700DYYpNFFPuMoa6ntAdnBm+GB1pjC5Tt0c7b0HPPBxsUKNBFbXPCvz
         Um9p1SA2K3Uqv6a7NWUYGsE6l6+OsD/m9f/lha+kJL2aRqpimZbPR/OrtHXXokIpIOTi
         pvTK0X2LgcIjRJ3z5SLS+NpZXloxkdPVGuEn0iluiDHkILqdjK+nTevs/rvKgSnoSuo7
         FGe0YOCytBjuoPpp593lVY8fsRswijpUt1VmzdOxVRtIdJfOq2pFBJLqoHYStJTbobkH
         jawQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDaZ7DhgepaE0jJh8hexWGs8OpEusD8ElNr2udsQddN5H/BzH1WOM4V0gb/Da6HPdSpThFAOB7jM9v@vger.kernel.org, AJvYcCWiCfNbbIbt8kpWbU5IK8d93P5MqJ/6aUJhKirqNdhIMtsBX8+hR+Hqh1AAwIhMNscJBqSNI0NNi3mSNL6k@vger.kernel.org
X-Gm-Message-State: AOJu0YzFflwczE1Hx/SvYM2QOoNPb7At0gSeS3LQokuHuHdEYlNm29jx
	IM0z/HX7drK2hYUX8rSKbNCxWG1Vap+XPkHPyD7ptCL7cPHvABf1AOkwCpBe5AVsPN7ZSzVNj87
	vd4nzD0rpykWtTFzSddgJM1IdX3iCWUwV
X-Gm-Gg: ASbGncvH1kMGLFi6v17rrMHJ7NHQyaxuz2AP1FLG2hgnlznk9TmeDbniLzPufJ1fLAi
	byptNqDWBR/d5f0J86fKWONtwOePBTnoGoNYcnQP7/BidGTPuowQqbewo9drL9N0MGTPM6xc8lZ
	lkmVigay0bNinnPLq48JjP4Q==
X-Google-Smtp-Source: AGHT+IEP3NhL/X+HGFkP7T+eVwgBMrq8dKdaULUna2iGfDJHUUpnompPv3eQ5Fa7S3ZoUoLz3Wyc3rWUksCJET0ed1M=
X-Received: by 2002:a17:907:d7c9:b0:ac8:1bbe:1a5b with SMTP id
 a640c23a62f3a-acedf68c324mr42633266b.9.1745964658156; Tue, 29 Apr 2025
 15:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745841276.git.marcelo.schmitt@analog.com> <bede8227189637568f9425cd6848e21be33c2fd2.1745841276.git.marcelo.schmitt@analog.com>
In-Reply-To: <bede8227189637568f9425cd6848e21be33c2fd2.1745841276.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:10:22 +0300
X-Gm-Features: ATxdqUE51YLYIJWeU7niHWudQb-M0VRI0qqBX2prqt2-zVx1RvrYKOwtW5zXbFI
Message-ID: <CAHp75VdtpdfXUG08KytBAtrQC2VoaHnPr0-XL1jeqnXUZ-bgwQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] iio: adc: ad4170: Add clock provider support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:28=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> The AD4170 chip can use an externally supplied clock at the XTAL2 pin, or
> an external crystal connected to the XTAL1 and XTAL2 pins. Alternatively,
> the AD4170 can provide it's 16 MHz internal clock at the XTAL2 pin. Exten=
d

its

> the AD4170 driver so it effectively uses the provided external clock, if
> any, or supplies it's own clock as a clock provider.

its

...

> +static const char *const ad4170_clk_sel[] =3D {
> +       "ext-clk", "xtal"

Keep trailing comma when it's not a oneliner assignment.

> +};

...

> +static int ad4170_register_clk_provider(struct iio_dev *indio_dev)
> +{
> +       struct ad4170_state *st =3D iio_priv(indio_dev);
> +       struct device *dev =3D indio_dev->dev.parent;
> +       struct clk_init_data init =3D {};
> +       int ret;
> +
> +       if (!IS_ENABLED(CONFIG_COMMON_CLK))
> +               return 0;
> +
> +       if (device_property_read_string(dev, "clock-output-names", &init.=
name)) {
> +               init.name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-clk",
> +                                          fwnode_get_name(dev_fwnode(dev=
)));

Why not %pfw ?

> +               if (!init.name)
> +                       return -ENOMEM;
> +       }
> +
> +       init.ops =3D &ad4170_int_clk_ops;
> +
> +       st->int_clk_hw.init =3D &init;
> +       ret =3D devm_clk_hw_register(dev, &st->int_clk_hw);
> +       if (ret)
> +               return ret;
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +                                          &st->int_clk_hw);
> +}

...

> +       ret =3D ad4170_clock_select(indio_dev);
> +       if (ret < 0)

Why ' < 0' part?

> +               return dev_err_probe(dev, ret, "Failed to setup device cl=
ock\n");
> +
> +       ret =3D regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock=
_ctrl);
> +       if (ret)
> +               return ret;


--=20
With Best Regards,
Andy Shevchenko

