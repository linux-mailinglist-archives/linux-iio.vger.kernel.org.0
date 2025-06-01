Return-Path: <linux-iio+bounces-20115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CABACA03F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 21:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2AB17207E
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757DE238C29;
	Sun,  1 Jun 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IniqD/X9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0A1BC2A;
	Sun,  1 Jun 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748806043; cv=none; b=elvbgK54EaCNZ+SUpXryKX3eLJXs3jpnxhCHtNv2m86PtWEsnQ/qNcj+Yw1EGaP2qvM+3VWFvg8xFI8oCd96zKT6GWh7fBN0QQkTss7gO8Gfk14uE1jefhm0XzmdIE4yj3/bweu64o6FY1rh9xaEXkfWM5RUMxnAvxE3BXlGW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748806043; c=relaxed/simple;
	bh=ScLkdUn4PMY6wgYArU7L6vbvveEf7NzRCheQBOeVmFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGX6aIPmN5ikm52ypeKzo/dm1faO6IniHqIWUKkAX70839K97vlCHFbnQNrVNZOgqMV2MhCSqIuXpcDXlcr0/Z0mTI393clXpkDThK8I+DgxuiD9sz2M0cDHNxG8w1hLQ/rVIkmN2mUN6YhQ7jMfzR4/4zScu9y4D/kwScJEVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IniqD/X9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad883afdf0cso714940766b.0;
        Sun, 01 Jun 2025 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748806040; x=1749410840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc/k+pCtYU6pJW7Wb+/1+zZ1iirP7vqOl4NvXjjQC0s=;
        b=IniqD/X95HbctEkenWGYZF4HF8bb2Wa9zY0ZE3NWxDT0MusbNrPXW1pnXNK/R676Kq
         TiQ4TiXipuE5cw5LB8QBzPugG8VGrzA7a8g7FDYjcWMZtNQUJ46d2x0zVHzThAiuRF83
         IHm1fZenRbCNAM/8WGJbKDhbXRPcFFuF1X3WEmIzCbxxUlkK8SduwsHrgdEovmXUk3d+
         QMfU44SonFtORIDVDWuF1LgRPv2a9CTrRM90znQfUOgQr5iUOVa/Iw5kg0IDaCxy3DS5
         ejWFuYSy2vznL59Jlp3TptotrDc1V3f6AaGv1U5MSnU53LT3ifSOy5gxt5m8OPUJFNxv
         VJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748806040; x=1749410840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jc/k+pCtYU6pJW7Wb+/1+zZ1iirP7vqOl4NvXjjQC0s=;
        b=UqPZrnKcy5gMgj5I9wEm1lK4itxxWbld+pr9lDqdqwlJ4vvk0M4rw0eUt5zDU7skTK
         EfA+ZlzVmy7Px+vu0t8C14PkL1e/YyW9yTizUPw/5V/AdFkvFYaKD+NTvVEjbjlDSnI2
         7rej+wmAlvtPW+m1vOE/0/PMHIFtNkEVMYQEu1/nA8t2snXF/vpmbt13TMwwa4SFC2Va
         bOX66084h/NtQacw8BKLd1cMvifny/dlm7wzQ02dg15sqlH7nLMo2n1/yXzCD6pOFh7p
         9ban8z18rpS1gdqY5MXi2xMum57kHJS8msgJMaof18/cXsb0MaMWsyhS5cehjr91OQDz
         6eNg==
X-Forwarded-Encrypted: i=1; AJvYcCVz0uY1V9Owo/+hP4wIgjKfTDJeT4M3CeFvtsxmfz9bQoyOm0/mtJ5BiuzbbsgE59RtcewJR7VlxXo=@vger.kernel.org, AJvYcCWrh6noaxrblxFDbFghhfFZ77XYmUjs9bmt22qCVh807bKVHkChQCaFKojyqaHX3npZoysM2XjJlHnq@vger.kernel.org, AJvYcCWzGSmTTm0F3RqBNAeVI5Fm9eC5ao+5gs0bzODDCp6AiU6euuijIeV15/su3lfQZW/Jt3ST/tGMIPwjL+iL@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrkyDh02sQ6C2QtQN8ZEGDPFkL1m2SSjGMWbfRsgK5YRliInQ
	utwNlie+eYeJUzWBUJ8rjwiicigN2aqURAIHFSm4vFvS4JsDAeT7HOkwqyVZ42JPEzSc23Rqs2+
	AUfskxGN4mDhGvTLmTxbZfyx6XKb7wltH+gwU
X-Gm-Gg: ASbGnctuoiE09w9m2+tSlMzJtcflYkLTyKiEep15EVGuziWDzrm8+Z1+zUSloPSGsbz
	2gP+ksYK5V4BBd+yC/Oq+K4SIhUgifjU3xMfN11RJ8ivqNU0ZjL0UzF1gPiomuwUfuf56Cx1H25
	4lDmtpVcWxMEsQfSdKOALaZzeOMcoVYMjA
X-Google-Smtp-Source: AGHT+IF5k4C0Bcd/ybdwcDgzNvrtEuVO9s6UNeWqrxE1lZmbP2mEABJ4x2uUF7W2NDX83BWL074nNz2nhmj1l9D+9sw=
X-Received: by 2002:a17:906:a996:b0:ad8:9909:20aa with SMTP id
 a640c23a62f3a-adb36bee594mr719706466b.40.1748806039692; Sun, 01 Jun 2025
 12:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-7-l.rubusch@gmail.com>
In-Reply-To: <20250601172139.59156-7-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jun 2025 22:26:42 +0300
X-Gm-Features: AX0GCFupdY86AmtyRSyHYdTfVMRHIiwnj_7rlmrr-KRB-HeB42H8neEe03J_my0
Message-ID: <CAHp75Ve6nifph44F-_sOwqSBBy_Ay5BeH9QxWMmMUNR1N7wUzQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] iio: accel: adxl313: add basic interrupt
 handling for FIFO watermark
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com>=
 wrote:
>
> Prepare the interrupt handler. Add register entries to evaluate the
> incoming interrupt. Add functions to clear status registers and reset the
> FIFO.
>
> Add FIFO watermark configuration and evaluation. Let a watermark to be
> configured. Evaluate the interrupt accordingly. Read out the FIFO content
> and push the values to the IIO channel.

...

> +static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int=
 value)
> +{
> +       struct adxl313_data *data =3D iio_priv(indio_dev);
> +       const unsigned int fifo_mask =3D 0x1f, interrupt_mask =3D 0x02;

GENMASK()
BIT()

> +       int ret;
> +
> +       value =3D min(value, ADXL313_FIFO_SIZE - 1);
> +
> +       ret =3D regmap_update_bits(data->regmap, ADXL313_REG_FIFO_CTL,
> +                                fifo_mask, value);
> +       if (ret)
> +               return ret;
> +
> +       data->watermark =3D value;
> +
> +       return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> +                                 interrupt_mask, ADXL313_INT_WATERMARK);
> +}

...

> +static int adxl313_get_samples(struct adxl313_data *data)
> +{
> +       unsigned int regval =3D 0;

Useless assignment.

> +       int ret;
> +
> +       ret =3D regmap_read(data->regmap, ADXL313_REG_FIFO_STATUS, &regva=
l);
> +       if (ret)
> +               return ret;
> +
> +       return FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
> +}

...

> +               ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +                                               &adxl313_irq_handler,
> +                                               IRQF_SHARED | IRQF_ONESHO=
T,
> +                                               indio_dev->name, indio_de=
v);
> +               if (ret)
> +                       return ret;

Now I see the first user of 'irq'. Logically these two patches may not
be split. Or split should be made differently, let's say IRQ type
holding variable + switch case can go in the first preparatory patch
(however it will make a little sense without real users, as it is/will
be a dead code).

--=20
With Best Regards,
Andy Shevchenko

