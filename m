Return-Path: <linux-iio+bounces-18543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D567DA97A80
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982EA3B4FF0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8169820CCDF;
	Tue, 22 Apr 2025 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY2jFXu8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9E41C69;
	Tue, 22 Apr 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361057; cv=none; b=fh4P7V2yNBXV62lqGGRvcn+uASAYYs6t506McAchYYcLTbztfOevpUvpPG11ZHvIJkYBio4VaZAg/qTAESgdOSi1p/rwm4TuzUxOEijwuYjfgVLRCT+nnXLeBuPZC8Mh5ZU0q8bkUz1ur2BQTLAC/nOPSiSSJu/LtM71UY7TM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361057; c=relaxed/simple;
	bh=yqqf7SXgxooT45kd9Pexv9Aea9WDtDR0VWw7cmnYKUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbtV0M34Qt18wrvwyHcg1Sm6z+I4Fj2nRXEj6ZilCvZVgPbToRUqoiuGf1e7Hsi0352Taa1RX8E6cgAdxeZhXjpb95oQozdAisdanSwn8U/Ta2zYoeAjp5krV7KcE5hKsHtVEf6+Pwnxd1NIIGOLpqs6PxUm8Mpkj4+Sa+1EeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY2jFXu8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so954603366b.1;
        Tue, 22 Apr 2025 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745361054; x=1745965854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzNCI1euiML81T+O/Mxg+dH4/vZAirx+HsgT3Ub2AsQ=;
        b=jY2jFXu82PAEBm4lpftNIEfSRehO9IJsvhN18a3UkIoWW0sE/QgzTUaPdRrZyBl6+h
         UxLmzt9OV7KaSRHKrevxLuRthzbJMvKK5POUxCtClCPuLBg6qsi8J5L0PndutLdWFmRW
         32F9YEqdRzeyWWv2yMHbuSpRLkDnAPxyNPfhIFTl6D/mmOzKsDarirWAn62+LjxPdAmV
         0UVKeCUNYSfczcWIXTEbsc/ai+Yy2XOz6WLhkk3lCzmW4JHyIqqEGvhByuEEm5d7Dzlq
         nHeslsP4UlI1tzSQl+ta74rWQtHoZM/YSB99zOEpd35CQLpQ+BBXCwB3evnkvHAPRI5k
         Mcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745361054; x=1745965854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzNCI1euiML81T+O/Mxg+dH4/vZAirx+HsgT3Ub2AsQ=;
        b=lZy5E/hQb+4HE9+hp705ATfs/LRqwZhKcAZY1kQAscyk5/f0BHlxKVKtlSXRnA4moh
         OA9h24YNEFJdKgsQGAaYcu1e0Ttj++s7QxvuO1C81T9qQA+eKtezFlfHqJ9A0oO/FwIy
         2sIhU+u+U6l8z71JLvE0xYMSAUHkpPSGgNeDEQiS4lKhSiw/4vNaZjDR5LhjLzT4cEAM
         gRnXnHlsjZ/Esx8BhvF0t6Kc+l+5RFLzIjoEIIHpRHX5WAd1o75GN7kAeK9f0DsFhwrx
         7j0s13JJJWkXrbUoD0LF/0DHxycb0nD9t8GEshifPtisu84VSbMW5OvxWW3WvyfsLTnP
         HxYw==
X-Forwarded-Encrypted: i=1; AJvYcCVntsgSfjFWBhsJzbeXUgsVsuHk2br2PhzU3b4EADVIUW9mjysg2TVlxLLPtLJ78VX5QaqJ4ZLphk0O5l0k@vger.kernel.org, AJvYcCXE2pNc7+Z/DwJbVfaEUDVxYNg/waZQJLEsi4Z+QnPd8GKTbcV6iFkBpm/ZCpneyBCLjZXf4Bc/3vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZA29b20O7aBQEw88/IcxiVzrgCuJ3f9JKO5ve7iTAdfxsndtT
	gLa/hIm2fNwK4BdLM3DMlBO0u/BElh/z4coy5S3lfyHhRszvDIUwds0c03XnKA+lxgz29vnFSLF
	EfLVECANoG2bEkHbUDdkDDpChhtU=
X-Gm-Gg: ASbGncvzMg6OeX08QIEPjYsYCrtW6EhYVamcmObdcTSZwVrRS+6kijl3XhUWEiTenVz
	qTlU7LmKhWWusnytQBX2ZC5MW6PvgyGW5BZyLE9XGQx1p7XxvQLq7myk8K6cflhq6hfvme8n424
	pMcDwi8k4fmTqU6AFw/mvOZQ==
X-Google-Smtp-Source: AGHT+IE3998SOoM5TQwHkEiv9/r4ac5IEpqWhP34QWkVmaptlSFgMZv97T7hlOYNeYrjUabrHKcmyKVktjZdI8yC4gE=
X-Received: by 2002:a17:907:3fa1:b0:ac2:c1e:dff0 with SMTP id
 a640c23a62f3a-acb74b4ccd4mr1141325966b.19.1745361053675; Tue, 22 Apr 2025
 15:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 01:30:17 +0300
X-Gm-Features: ATxdqUF9L-QdkcRUaS4VEbEYroG2Kvz6r19047Y4gFd893gEmo8RVU6ynKAGZL8
Message-ID: <CAHp75VeuNhfJrNAZZwY2tEHte=UPHLOPNUz7y_J20xv2+_Zdeg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 1:08=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Add new macros to help with the common case of declaring a buffer that
> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
> to do correctly because of the alignment requirements of the timestamp.
> This will make it easier for both authors and reviewers.
>
> To avoid double __align() attributes in cases where we also need DMA
> alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS.

...

> +#define _IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
> +       type name[ALIGN((count), sizeof(s64) / sizeof(type)) + sizeof(s64=
) / sizeof(type)]

Single leading underscore seems to me not so usual, I saw people use
double underscores to make sure that it will be visible that it's an
internal one (kinda).

...

> +_Static_assert(sizeof(IIO_DMA_MINALIGN) % sizeof(s64) =3D=3D 0,

Why not static_assert() ? Because of the message? But static_assert()
supports messages AFAICS.

> +       "macros above assume that IIO_DMA_MINALIGN also ensures s64 times=
tamp alignment");

--=20
With Best Regards,
Andy Shevchenko

