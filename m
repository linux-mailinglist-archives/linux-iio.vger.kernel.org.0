Return-Path: <linux-iio+bounces-26543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD3C92752
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 16:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 074F44E2ADC
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1BF23370F;
	Fri, 28 Nov 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNtIeuPw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B15618A921
	for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764343921; cv=none; b=C+4fFsB+5Bl9rSW2rRnzmgOfrcuCIpSIvMcgaRgu77KGZqEEZ2SSimj8HNFdqQcHUBpOhpwFSoBn50EPpisM1Ip4jU1lWcIaCObhBT59lzh+h9QW+F2Sp0rxyOIfaWXn7RfruNBTYBJtEXX7J6POSlX4JtWqSMWNkJ81sX91tCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764343921; c=relaxed/simple;
	bh=/ceaKwFoCOJeQQxnRhCj2PUKkZkv2X0n8YRS5EsIEfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrufCyMllVUORIrGWnA1vIV4UcXwcb2027qPX2uUhBYBmA7keJ5/GyOogLVnVqqb74vP20zlEkibTw30WFzT52ss1nbnopbs7XsxOKf0xKC9Hm0v5nSf/ewsQg5dYNuxh/q740KaWTEe5Von72iGgb/N7iyOjZ3dmiErmYfSgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNtIeuPw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b735487129fso285704266b.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 07:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764343918; x=1764948718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hc1FZf0aqmy9hRVTukjlsEkGxkhbp+DXkrM0VuX/3lw=;
        b=WNtIeuPwXG/7jc8atszUHEPJGJiq/MtQ25XAMqeMS0U1hBlwz2FSQ2+c5t5OCpgLzy
         pLqZp51oiBXDIOE4PZUFENellK9qCVPfMjFCNmbyWv88MiqVrQ2rXtprlrRM8EzyBoYa
         1sof10NUf+19z6a7yLXuC6bIT1EG3HfQnssbu2IHRlV1G8HUJfypmnq0IMGoI4rkQgls
         A5Lb0QFN9gPqh3SJShRnwczJLCndjsSlasJGNC7JCGG7dlvSTOduzHk/543Rc70egWub
         7o5KcTLt2Jk9xQEdHTiG9TON9uC05yQCPoIxU/z5lGM09cBn3JvYV4pFD6wsdxrq9kOI
         y4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764343918; x=1764948718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hc1FZf0aqmy9hRVTukjlsEkGxkhbp+DXkrM0VuX/3lw=;
        b=qZfwRrX9B9ERhDPf0U1zIBBrtT5opyZxFU+WRQk7Lb72Rx8BbxK0JCw+8+cqRwdNC5
         slv8MhdMQRQh/bt1wTdQiH1IAr7UtmSm3aRCnOAuaWcDYv6jvQaVnaQLzstjDfqzxhZS
         OFxT8L2pm9R8/7ra9bZOpa554jYIcePxhwplIzKL+3EXASThM4fF7lKQQzjDBsltSmzx
         /kZZtERH4Sqa3R+2eaOYTqDEgcjqyOTU3CIxbZzvuyBIpQcIDbs7kTK0BQz6DtkSIaHt
         S9dSEGEeHl/OzTrINAPO22aCgCQvI+axOBadqKVn+WdeYV3ilzJjRZqBKX9awWj8CD2V
         yBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb7NtAn6XXtrxJd3+UDAnfOxUd+uoUhQu9vNmoiiwqB0MYfOs5TqJAPvqQvbJw2Ja3a2fL2q9Xiic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/HIw+RCofyCtX1tfwI0+opkqoOgz7lZORyvfie/hxQYVIl9y
	BZwdrHrj8SsYzsF8RUzmomKVvHKaNvyM/j+qncCuq9VtX8rVEjZqmXoSRfS4CJyIOp1+VZ4eLaM
	mcj3dUyIZMEYjvZtdzAxB7gPn0HitJbw=
X-Gm-Gg: ASbGncuFL5zWMEHGRcbYsClCaMupinEh5wj4ZBMRkyIiU3qy7mz7HlIYlDiucKiCKup
	EIEwH5iiAX0AfrzuDAQ1BA86JOTnpTXtPledMZ0J5ViO87aBO9MWdcWDoCJtG+Y/6P/SRIwZF9q
	KLKIYXIZYYCZfCGxy6N3ji2VVXQ2Z/9mNEwmw2pEGIDlvbLOUki4AmbkyifK0jW9HQROtnxvgBP
	Jpj7w0ObriM2lEdgNxM4Q6J0DFoI0PCBeh7qmUNum7CZbKmRsFEWSJbIJBvr9/WgzpKaUElx2j/
	H5B2yv6/OxY6blV40scfg+GNLA1UUF9PTkGhZtqYgYidfhKj+6CeFC9t14YdLhO5KW7maYo=
X-Google-Smtp-Source: AGHT+IEkaWdPxsxO9lXpXlyIAWQmJuU0jnxGE0pUniLra+0Lkcwppxrj2fbXL+oGy9pVvB7uq4pEc5YxeW3toeoJjFY=
X-Received: by 2002:a17:907:9484:b0:b70:7e10:4f4b with SMTP id
 a640c23a62f3a-b76715abd4cmr3082173066b.18.1764343918319; Fri, 28 Nov 2025
 07:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128140726.243005-1-flavra@baylibre.com>
In-Reply-To: <20251128140726.243005-1-flavra@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 28 Nov 2025 17:31:21 +0200
X-Gm-Features: AWmQ_bn5I46QDC1JH-rnvhIejIRl3eCY9yvDazrK2U9ovWOIIJHZvyPKxY8e_M0
Message-ID: <CAHp75VfRS-6paBqS0oXMq9mVrD5Ms8fX4LRA4k8tK-VV87Lw3Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: adxl380: fix handling of unavailable
 "INT1" interrupt
To: Francesco Lavra <flavra@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 4:07=E2=80=AFPM Francesco Lavra <flavra@baylibre.co=
m> wrote:
>
> fwnode_irq_get_byname() returns a negative value on failure; if a negativ=
e
> value is returned, use it as `err` argument for dev_err_probe().

Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> +               if (st->irq < 0)
> +                       return dev_err_probe(st->dev, st->irq,
>                                              "no interrupt name specified=
");

Just noticed that the trailing \n is missing.
Can be also folded or done in a separate patch. Up to you.

--=20
With Best Regards,
Andy Shevchenko

