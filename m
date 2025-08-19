Return-Path: <linux-iio+bounces-22967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37AAB2BDD8
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 11:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59477527807
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 09:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8E31A046;
	Tue, 19 Aug 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnmVnRgr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C7319864;
	Tue, 19 Aug 2025 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596814; cv=none; b=Hqqw4PCZP64xX1L2eAna755J9RYWSPRda5asAh2Bv4uUgTInpqmsv2/VhIBga87HG3nGp/SPFqKhwC75sPIOLGn26yj98YqeR5U/I0nSV0yhggkNu2xoIGHqZyW3aR6nd4FKcHgGxRnIdroT31rGCqbByPHg7ZcEbnRAhUtNbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596814; c=relaxed/simple;
	bh=UpGOAWXYbpCp4AcWDvEoBwI8mc7ei02D4aK7TjlubcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpIB8NfBLgGv20FaC0+thc6X6OCx2QlZRySzzxqt6P4aIqFHyd5CBAql7fUuZ/WRrjRl/fMDHkf0W0iObsnRA37ZtftOyYp5TxA6xTSekx+VhsKmWk/mZBNYmj5vR2qvUh9urR+WtQ8W0m9cLpbpJanFlcmW5VMIZkFAOqQRijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnmVnRgr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7ae31caso905413666b.3;
        Tue, 19 Aug 2025 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596811; x=1756201611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHR1+LnsyqQCjvU9VYbnlkSX6a8oXRzaW4bWSSLO4t8=;
        b=DnmVnRgroLML0U8NSBs2LD87MQPpFy4mDRZ+KTv82w+9arLt/jbEuGtShz5RfG9JLK
         IaPnekW/QizeuQkE/xjPGGEmSEoxByGavkna1RLKYcnr9eWodEuVz5AWO7hbvxSU0Ec/
         uN9eImnig05l071wu7ctMJVJOAzT/imZo2hv+/4LmXjSYTQhIsoo/RTQVIxYr6D8YMDX
         Mjj1DNj3LfrUtFA+BH8Io9Nz61BkFIUg0Pe8l8AvmwBg0i19VqbwKriq4fBtwvv+3asT
         Dct7ga47qvqbqmdOmeirxug6wYBSOb7aw1eq7Lj3AV3LJObQLIvmPeE2F2cLM3PcYARQ
         21wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596811; x=1756201611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHR1+LnsyqQCjvU9VYbnlkSX6a8oXRzaW4bWSSLO4t8=;
        b=aokr68PYuIYSRNl58DnMcoDoeHJDfRln4AWLPrN+dt+JnwYwW3/OZvV4XAXIBKzgQ1
         RJhq8Vfayg6j73qRpGpZGGzlF/o5POd3PupgDp7dgRbUN5p5bKDvDZ7ojuTi89BPCJJe
         RXrkEBFli3EL4Pp/zzJ8nEhZw6CdmwDv1J7OQgG7vj+Qpw0TZJuUWwPsg6KoL44EVdKI
         RouLZVU8LFobl4NPJ7/oNEV69x9x0JyQH0p7Cev/BMe7Hw/R6pGqxQ4Tv9BIb4ObQP8s
         OOqz0hboXgQeGodC3mY5+SnnVhbS6lw0QZ1RbTT6sN1aiN2BqSSQkF41NpdfIG7aAAxG
         hP5w==
X-Forwarded-Encrypted: i=1; AJvYcCURx23+DL+fM1CiCX+3qguyJlSUGtxeP3JFdcF4ULNgiu8LlF4xZdp8LweSXLYUzPIdmoe3dF9NOOc=@vger.kernel.org, AJvYcCUUawhLUFdZx9MC02bNv3uyKPnw4fhkitSUyXwoPm9dU4tYpRi2JNiOJfXhsV4uNpdRvfbrxRwc44yJ3wrB@vger.kernel.org
X-Gm-Message-State: AOJu0YxdVotkoMYd0tZzUnOOPV714/3/5aw3QJ3Tz42cvyoAyWGwrSP/
	afQoSDLCAQsdkosvBaPQAWgSPhSlJFWBCM0E2co6yTXPSL6bAGdQy1Pnihlf8aGg/z96rRetbj1
	MWkqx8b+s6NAyWm/g6jcwhCMW4yYBzlI=
X-Gm-Gg: ASbGncvgTdUbkTRq/1of8U1gmDngDiJFWNu4MVl9YfdX9aUG1f3SSk+mUBDZvOmEcZz
	ho2LqrmZDCSr/eqyYOXbANTT4jmCByL4xS2k3kK4fO3yQeuHZZfgGf6IzgZpKaPZiD9SGkzV0pg
	a1qw6VV610761ir/N9R9+j+pAm2Jm5RsSJPMzriaUFVpGtbu7wh6ToD4PKy4TOsPJLlT6NErVNt
	MuMRj8=
X-Google-Smtp-Source: AGHT+IH/WC5OrNyjsCt6bSD85vhC1Tzxdo/8mJluv/2xFXUP1fb2Y03uGT+yunrqxu0uL3hZdsc26M1MGHskK1UmZkU=
X-Received: by 2002:a17:907:3e9f:b0:ae3:b2b7:7f2f with SMTP id
 a640c23a62f3a-afddd0c3b78mr174854966b.40.1755596810877; Tue, 19 Aug 2025
 02:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819085542.538715-1-rongqianfeng@vivo.com>
In-Reply-To: <20250819085542.538715-1-rongqianfeng@vivo.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 12:46:14 +0300
X-Gm-Features: Ac12FXzJDMjCDfVZA8d6PwPJEGCZtkOqMTgPbw20bvKZMIjSZagR4VVu99uFKNM
Message-ID: <CAHp75VdAySwLZ8gf_mDoQDX4KdC-hsCYL3VbkZSk_NSKNY5VTw@mail.gmail.com>
Subject: Re: [PATCH] iio: common: scmi_iio: use kcalloc() instead of kzalloc()
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 11:56=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:
>
> Replace calls of devm_kzalloc() with devm_kcalloc() in scmi_alloc_iiodev(=
)
> and scmi_iio_set_sampling_freq_avail() for safer memory allocation with
> built-in overflow protection.

While this change is correct...

...

>         sensor->freq_avail =3D
> -               devm_kzalloc(&iio_dev->dev,
> -                            sizeof(*sensor->freq_avail) *
> -                                    (sensor->sensor_info->intervals.coun=
t * 2),
> +               devm_kcalloc(&iio_dev->dev,
> +                            sensor->sensor_info->intervals.count * 2,

...I would also switch this to use array_size() instead of explicit
multiplication as it will check for boundaries that are not static in
this case.

> +                            sizeof(*sensor->freq_avail),
>                              GFP_KERNEL);
>         if (!sensor->freq_avail)
>                 return -ENOMEM;

--=20
With Best Regards,
Andy Shevchenko

