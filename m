Return-Path: <linux-iio+bounces-26952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BECCAE26A
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 21:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A978300F71A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345D2D0C84;
	Mon,  8 Dec 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9S/EjlY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F625257827
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765225191; cv=none; b=iEQoQ32D+0M2i2UAJEL5TD4D/lphFI08vCgzfXjraxFhb0IkGeOKWvqt1+VthJe2l9gx0qvi6rG8skzJT6LdUnMitkGqCmtDEkblh+RSrDBHeXarBWpl9M/FHLGWyEl+gA8GIeQl3hQeTzM/wjzqHYDwRNP+qSiC1Bvh8kXtUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765225191; c=relaxed/simple;
	bh=hWdqOBrz7R1PeIl/el4CDNV4J6gTBam74svClDpbo7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCvzYmezilWRE4n5CR/cHNecxxq82xDtEKmStl0RUWncCuhTykmv1Ymd00vQS6qpNp+2RzJlIJAGnvuQrFfMsv7p2H/5N9krZpgefGot9+NMC2Z1z9C5E5oQf7gGC1xESjkX0MTtGf2J3YbAL3wL/clpZ08c+7c1ylk+fou1ZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9S/EjlY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b770f4accc0so651818266b.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Dec 2025 12:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765225186; x=1765829986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKZmOzDUaUoAwYcr15jUyHM3kks+XuMcXkYp9bMVE7w=;
        b=j9S/EjlYOPc0tmscjLe6Cy3kinRaNZaYlnQFJLIQYJ+DOJoPtPtuf5z9y9LGPg0pwq
         EU2i+wkxqBdqRGm4/OJ2SInWblq+fT1WNe/K3+AtZVuya2+8pikxUO8MKph6kcvZU9nb
         Z1Q8v+HpucBTdZrQLI2TI57M1YUjJZtdrivjoIedpa07pAdrQW2hXmoy3FTrDE+xGUE0
         kIJT6J9CwTbHm1ocyURCy3mnMeLsjJ5Lxr+2OQq0B5Mr4qzX/fMzYKHVv6kO0eYB2iEX
         U5r1zhmYjRnak4XUOe903ddM3iYjGm7m8I1CNUc/jEtlbmwGGrtBmrJG0OFtJlt0Z61u
         HPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765225186; x=1765829986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKZmOzDUaUoAwYcr15jUyHM3kks+XuMcXkYp9bMVE7w=;
        b=JN43kKSe9UyHO2sBPnZFVV1t7ICecyWiM9SmrsxNgjKIvfUr1ZsewOkYj2bCxtyltO
         6wyU7CFd5TmExcEKzN5HtGIfjtGNEMOeGzV3G5rp0V46fpb1sRHng7u4GSjDrhgJkgGz
         6sukhEyWF1sVDe/Iv7rspi5cKzFK6jIzZNgT/SKxNNjzjrGCiRPK5ftbZlEzU2+fE0+9
         N4Mpu3UVs8/e7qX/udZH1Txs/Cy0uBRgAgkbja9OzKTVS3/VoDPOYs703FSpJfPpYAkl
         VtP8DgOlNQw+Fncr89wWdWWeMloDuE+yYPw8HjB+wsO700tLfSYWfH13SLBshM8ASAQj
         ZxqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMJ7v0K0Cf2/GkpQEie+Ri5v/nX5NFMYrPrb/Jt8tDlS0Fz6Bqek/O4ZCy+B9vP5vk8/94yhQu9L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvKQwnAGzpLlws1gDqincSX66rP71iIRR1LLHhbfmolfXMj2i
	ZRCSic8e/bwToZb+Xtcx4qu3KiIURPBSiT0WAM7pOJu4WPEKkV0GSJlSwpTj899FlPCUPx3p6fY
	WTflQNoWRIUlAWFFFmUCtSusIHK4qMww=
X-Gm-Gg: ASbGncuorOOtTJF7wGwck6eQfuaulEMNlZEmVqBohmjfMGqOoH8RHCl0TtD25i4e8ZL
	Xv8/kMtFk1LkTRiN3Fd9sXnj3FhGV8jAEdBOFtmgatmVqLOKxd8AzSGwcqS9xNoG3DrMFFOF0rG
	07hxGcT7D/oCNMN0+8fdlWOi19r7YAMxCRuNoMRnLL9dVq388P6io6BupFPzCAvVimQt1ufUnI8
	asCupHLeUrLNi3pwDPv5eA3yFM2ui+t1BvfOl7suqT+1tdN7N9mdFQMnAFjhphfBXG3toLY7MkU
	gQ3Z5sQbLVDa7VT/cTZfRgNkFn5gKFWsXm0yn0VlBmhOX5hTVvPHpHu4+IZEjvv+jnC8e4M=
X-Google-Smtp-Source: AGHT+IEUpQKhOdnGkSJrXCD9ru1GSPCmA3oCC5KHZuH2mk/anfUqxaM5QdotcE/qo0aZj1mmuIyONsfWtt9rgCO+HW4=
X-Received: by 2002:a17:907:7ea9:b0:b79:eaf6:8f5e with SMTP id
 a640c23a62f3a-b7a243240cbmr856245566b.14.1765225186239; Mon, 08 Dec 2025
 12:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-ads1x18-v7-0-b1be8dfebfa2@gmail.com> <20251208-ads1x18-v7-2-b1be8dfebfa2@gmail.com>
In-Reply-To: <20251208-ads1x18-v7-2-b1be8dfebfa2@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Dec 2025 22:19:10 +0200
X-Gm-Features: AQt7F2rqtm5RNbc5lBiWpDGQ2X5YQaHmKp0kfPnaTHBpVZSjqqEEk3fjrcqdUGE
Message-ID: <CAHp75VcOVpGbb3UBm+QQrw25=yU+J624c29ptMk8yrJpNEL=jA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: Add ti-ads1018 driver
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tobias Sperling <tobias.sperling@softing.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 9:25=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wrote:
>
> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
> analog-to-digital converters.
>
> These chips' MOSI pin is shared with a data-ready interrupt. Defining

Either "This", or "pins are".

> this interrupt in devicetree is optional, therefore we only create an
> IIO trigger if one is found.
>
> Handling this interrupt requires some considerations. When enabling the
> trigger the CS line is tied low (active), thus we need to hold
> spi_bus_lock() too, to avoid state corruption. This is done inside the
> set_trigger_state() callback, to let users use other triggers without
> wasting a bus lock.

...

> +/**
> + * ads1018_calc_delay - Calculates a suitable delay for a single-shot re=
ading
> + * @hz: Sampling frequency
> + *
> + * Calculates an appropriate delay for a single shot reading given a sam=
pling
> + * frequency.
> + *
> + * Return: Delay in microseconds (Always greater than 0).
> + */
> +static u32 ads1018_calc_delay(unsigned int hz)
> +{
> +       /*
> +        * Calculate the worst-case sampling rate by subtracting 10% erro=
r
> +        * specified in the datasheet...
> +        */
> +       hz -=3D DIV_ROUND_UP(hz, 10);
> +
> +       /* ...Then calculate time per sample in microseconds. */
> +       return DIV_ROUND_UP(MICROHZ_PER_HZ, hz);

If time per sample is in =C2=B5s, the associated frequency is in MHz, so
the correct constant is HZ_PER_MHZ. What did I miss here?

> +}

...

> +static struct spi_driver ads1018_spi_driver =3D {
> +       .driver =3D {
> +               .name =3D "ads1018",
> +               .of_match_table =3D ads1018_of_match,
> +       },
> +       .probe =3D ads1018_spi_probe,
> +       .id_table =3D ads1018_spi_match,
> +};

> +

Unneeded blank line.

> +module_spi_driver(ads1018_spi_driver);

...

Other than above, LGTM!
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

