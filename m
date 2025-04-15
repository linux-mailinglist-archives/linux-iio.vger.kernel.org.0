Return-Path: <linux-iio+bounces-18142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80693A8A648
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 20:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05456189E2BA
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDABD2206A6;
	Tue, 15 Apr 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyi/3x9+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D732DFA3A;
	Tue, 15 Apr 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740207; cv=none; b=Q59BRGQ4J15Ol/9zXLPfRq74gXY2pMYzQzBZ4fWn/qaKTXX5cukvy/wVvUg1VBTedpgIoEe/Ic8FNJJJKViv36Gcm+7stBVrvuRy8+zKQldbIJ2oHtt8s4MTK0FsGrJqEwJSoFuUT3IyoZZ54m9d0fHbQxJAEwMfXoAXXnJHOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740207; c=relaxed/simple;
	bh=+eghJ4x+Ds+Ccq/zvXc4mswzGPnjEx99kC6uBVTT3Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFfB74uJo69E4YiW/f34Stdjklt5DsSropma0Zj4v5DYWZZ/7fukrHY7yTiqH+GTk9y2pLv9XoVo3nDucq7hUEgDKGHR8fi+uh9hziiHhCnnKZ/PyK6wMFL+7ta8J2qrnPNxGMBQ4r70+sditHTPUNWK42zxYUqTLiZQ+1TUGYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lyi/3x9+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so8634834a12.0;
        Tue, 15 Apr 2025 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740204; x=1745345004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb9qKhu2k1IpUvme0BwFktjGiMrYNfcDlPf0UXzXUVI=;
        b=Lyi/3x9+j9R0dqkv+ukxDE+U7rh0dnEHaQ/rfvCcmZO+aIHhNqDks+jdNCl+dpCGft
         DzP/1PDaxkgqK17fgV01ha7UgRUOnS3rotA1VEiHeYnpET82bYv7c7j2R0PG7RuuodYg
         2w0a4QE2jiuBIsRU/R83FiVbusue0/rIa3fpD9H3sr2jZAvp5bZBQecd8SVyVykhHnN4
         rXji/Pnvu95h3j1/AfP1uWeQ+eH4yGz6xP8vmD+opEqeNs3FHkg8cwRQxyyKAt3Itpv1
         UZBrFgPDftGuon3k/nRdhNpWbSYTyCPA3Ebcdiu5mtbGglEAjylpHJ5QxEMn0/NIt85q
         ceOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740204; x=1745345004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wb9qKhu2k1IpUvme0BwFktjGiMrYNfcDlPf0UXzXUVI=;
        b=V/7x1mXeuSk69MZN9aqSfrLs7viTurRxdhhgPMWJMUmxtzy7OugnHOTCTGzfPu5LyO
         TbUZBRd6uO0LdKKEObNHGuCWvD3w6DNlW/d/92avTnBz9c65IA9cbuAiQF2j4AiYkk/5
         1k5azzCApp+cp6Mzvz75iAn9V4Bm9Umd7Ri328i93Rl6VhsF0vtSHay3Zcb4b+8MgHSK
         HZILeLeXgqBaVvwHzw+Ur+ZRDsiwzOyIFvB9JiFThmKEELLGWGhIUEfZhcauRSiV4LDb
         5z852aK/QvPLrI9Lko6LsoavkA8l1Et8Uti2fMvpYVNOAlWkbM5PHkbojPBqMtTZKibL
         LOww==
X-Forwarded-Encrypted: i=1; AJvYcCUifHg9nosAQPEp0/inHe41+OKHizmW98U1iTnluRLJSEKIZemV+4JFYnF5pcvMmyrOvTEHzMPdLYVzTA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmE5Ty2qDVeufADs9E5CNJyCcU3B5C7CezHCGnbFJitzHDq+Q
	ASfy9s7ZCTIusDNye/afxntTpBu1WnNR5Hx9kNqDnXT98VsCD5wzxbzp+tFjkiAqivG1KpCWN4I
	D8lCBJUD16dHDUVcAeo838XHcGrE=
X-Gm-Gg: ASbGncsimddXVbckJhyutBgrN04u9SOn9V9/nu1AJnUm8kTZsgTQ346Ywtwg4W/KYAf
	eotkq/IDwMbsb4rUfyHV/HvNZCte1GiE4SR5zasA6YHr/7Z0i6uZHSaaFdZ/4i9ag8xlVNK6Y5Z
	p/YY5joNAw+xof4HKhkXgyxw==
X-Google-Smtp-Source: AGHT+IGyoaExq6lmduv0ioWZoFMPyQfOKlchXrfsCHKLALExxyE/uhXIbOVRgv4AlIM/ZVfNMa3oiOaBOBFwlsQ+6ko=
X-Received: by 2002:a17:907:3ea6:b0:ac8:17a1:e42 with SMTP id
 a640c23a62f3a-acb38251b55mr1864866b.22.1744740204008; Tue, 15 Apr 2025
 11:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
In-Reply-To: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 Apr 2025 21:02:47 +0300
X-Gm-Features: ATxdqUHo0j2G7HhInsD2Ea9yS3LAPGWvf8sSTVKbBAs4CuoCzvP5lAmVqkvszb0
Message-ID: <CAHp75VendQGLdpggySS3mX6M2YSeS70bvE8yg7sp_LNGDS-Scg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad4000: Avoid potential double data word read
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com, 
	andy@kernel.org, marcelo.schmitt1@gmail.com, 
	David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 3:21=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Currently, SPI-Engine offload module always sends 32-bit data elements to
> DMA engine. Appropriately, when set for SPI offloading, the IIO driver us=
es
> 32 storagebits for IIO ADC channel buffer elements. However, setting SPI
> transfer length according to storagebits (32-bits in case of offload) can
> lead to unnecessarily long transfers for ADCs that are 16-bit or less
> precision. Adjust AD4000 single-shot read to run transfers of 2 bytes whe=
n
> that is enough to get all ADC data bits.

...

>         xfers[1].rx_buf =3D &st->scan.data;
> -       xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.storagebits);
> +       xfers[1].len =3D chan->scan_type.realbits > 16 ? 4 : 2;

But wouldn't be logical to have

       xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.realbits);

?

--=20
With Best Regards,
Andy Shevchenko

