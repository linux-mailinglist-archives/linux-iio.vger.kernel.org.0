Return-Path: <linux-iio+bounces-18906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA790AA5122
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 18:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB684646A5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9712609ED;
	Wed, 30 Apr 2025 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMpaN32Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD61494CC;
	Wed, 30 Apr 2025 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029140; cv=none; b=AOfolUoh3F+tAABUgk8k52Tzz/Ts3mNxLNRimVjZvAVx9dTVyj7uN9t+pwG0hRqXj5J9nksQy0J++N4EKHw4SHN9HqELkG+8vG9eshkG6sLBWKpB3BmMEcUTxrv5rTAAOfGtSf1lWF1HD0IS/DKDAoF+4ZXY2W/4CfbhJPuvtho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029140; c=relaxed/simple;
	bh=m3FlkjS9BTXU/FOc6nzXxhXFJ/EstJsMNRV3Dz89nBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vm0Mo9KmBPnuVF7avo95VtwgCY1iEq7zOL3Vji0lgQB5dpeuJX7pYjzGAnS8arfCimoYL5/XOt8FVbFDYMyVWkpyEkW1IymeK8Yl+NitlX+PdQ7dgU5lioq2fC0YdbjQ68Ool7QqYM8cus878GhS6NKaG9i1d3D0MDR1Muvd1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMpaN32Y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so55737675e9.1;
        Wed, 30 Apr 2025 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029137; x=1746633937; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5S9e1DWGqEFvpNpYn3bjcrfQGdDQ4Z+tozseIJJX8Y=;
        b=fMpaN32Yg6C15q4b+rneOGFp5NccmOsJMT7l02p6NHgkYpye0buLX5SQKhFjnekoMh
         x2c4ksG7VFWTGwPIgqmCEeuMhhVUGQJNLUtpEUQCXt3M12fWKZlj42xG+fXWO/NeL3Sg
         8IJIbsfSPeaPzpJfNPFd7UfxTatzlOslwWl4fDJrDdzyxE5BnxrHLugu9TURK2xZNuog
         CeNqygNi/59mRzqgdk4Ttn2C9CIkXzUGAF7PhZ1s4uvGfEqXhn+oJgtGQDVe7zATxaeO
         XV+zxeL4ygX+/g6uYhW4O69kMVlgVVkdu7ldwe1doRrbC6x0VNpnZ+rNFKhHWhQt0/j2
         dW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029137; x=1746633937;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5S9e1DWGqEFvpNpYn3bjcrfQGdDQ4Z+tozseIJJX8Y=;
        b=X9gkFH9N9+51PX8D98/dOGZ1Yv5L+WzJxVuDsG/hZaWSJuU6CkybiDtVGkKBWaRUWk
         qiRanEbx4dvpereX9bOmIBsf5NOSVXqOsMJNf0af58Uwo3EkrR1geu69oaEhH2uYTfMS
         5g8b58rAEL9mf0QCnvHD2UdIanqJOHs9W4bPaB7ogj/M1QLxS8Dd6/3zGyE8b341hxWH
         dRLFOEGppsuQ1UEHMd1/85evOzAnV4oGHHD1lY2wwP6gzD4NqqCw3rUNJc6P6EDWAi7l
         Fq2xaqegfkIrRw/PYPUZOcfd16y/o+BiI/Ktpm1iDz5opZkxJpeHtSXjXhytbX1P7axp
         CT+g==
X-Forwarded-Encrypted: i=1; AJvYcCUlgHM1f14MhPjjUTINIgq9k+RQ46/9m4wJbFWPRaZ2VqNwAuCctnra8Wap6EHDm0tlWqe2KMzB8Hgk1DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0Lcn7BJB98msLl5eAOXZ3SRUAG8BIYfsfUS5JkEHnE6Qrb7u
	3n+Qck2jqzNzwkK03En7RmISI7udD+1WoXtjzLMFMHCgGTNfDBJX
X-Gm-Gg: ASbGncutxbQmaMT5dtsmmZYUMmIEvvDqsX16qsI8p1l5HQyf9CIuoNDpT7MRwJT6RsY
	bzX/ClbYVByBgnj3QJ8sSM/cHDHnjrOz0hyxdKGDBQ3dQgEG7sBChKbHgYpPcorfLBpI3SH39BL
	V37bFewAHnCcDQde7aCA8pf10hA4VwCQ5X+qy+wR07iUkxtVWZD7UmHpJApFz4aHB95TkWCoHjc
	07S8adFFIOOISyzx/vkJdW6B/4OibC2/bLTBmAjkvtiMpLJ45UdrQ8DChS34Yy3fN63eLBt8UIu
	6mKuEVN3A2iAjLUhZrQw/kk+To2ueuKQaXxub8Yy5y1v9oefcvVVhB8XA7mSs03cNIzA73qb7/w
	pB6wKj5Et8R4n
X-Google-Smtp-Source: AGHT+IF+0FsUtiZZIFNQGFEeJHnqBv2psnote9Irpa5eEjYMg2hfFzoB8Ru87RV07vlOJ5l+POqEug==
X-Received: by 2002:a05:600c:1e20:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-441b1f35c86mr45681905e9.10.1746029136799;
        Wed, 30 Apr 2025 09:05:36 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b209a4sm29411885e9.30.2025.04.30.09.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:05:36 -0700 (PDT)
Message-ID: <633ae10805f20a7c4c56d0197c200411f480c374.camel@gmail.com>
Subject: Re: [PATCH v4 1/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Eugen Hristev
 <eugen.hristev@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Wed, 30 Apr 2025 17:05:41 +0100
In-Reply-To: <5c762653-b636-45bd-8800-e804ad8dfda5@baylibre.com>
References: 
	<20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
	 <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-1-6f7f6126f1cb@baylibre.com>
	 <1d90fae5-9c58-4a77-b81c-2946e7cc74d4@baylibre.com>
	 <5c762653-b636-45bd-8800-e804ad8dfda5@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-29 at 14:31 -0500, David Lechner wrote:
> On 4/28/25 9:12 PM, David Lechner wrote:
> > On 4/28/25 3:23 PM, David Lechner wrote:
> > > Add new macros to help with the common case of declaring a buffer tha=
t
> > > is safe to use with iio_push_to_buffers_with_ts(). This is not trivia=
l
> > > to do correctly because of the alignment requirements of the timestam=
p.
> > > This will make it easier for both authors and reviewers.
> > >=20
> > > To avoid double __align() attributes in cases where we also need DMA
> > > alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS().
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> >=20
> > ...
> >=20
> > > +/**
> > > + * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer w=
ith
> > > timestamp
> > > + * @type: element type of the buffer
> > > + * @name: identifier name of the buffer
> > > + * @count: number of elements in the buffer
> > > + *
> > > + * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses
> > > __aligned(IIO_DMA_MINALIGN)
> > > + * to ensure that the buffer doesn't share cachelines with anything =
that
> > > comes
> > > + * before it in a struct. This should not be used for stack-allocate=
d
> > > buffers
> > > + * as stack memory cannot generally be used for DMA.
> > > + */
> > > +#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count)	\
> > > +	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count)		\
> > > +	/* IIO_DMA_MINALIGN may be 4 on some 32-bit arches. */	\
> > > +	__aligned(MAX(IIO_DMA_MINALIGN, sizeof(s64)))
> >=20
> > I just realized my logic behind this is faulty. It assumes sizeof(s64) =
=3D=3D
> > __alignof__(s64), but that isn't always true and that is what caused th=
e
> > builds
> > to hit the static_assert() on v3.
> >=20
> > We should be able to leave this as __aligned(IIO_DMA_MINALIGN)
> >=20
> > And have this (with better error message):
> >=20
> > static assert(IIO_DMA_MINALIGN % __alignof__(s64) =3D=3D 0);
>=20
> I was working late yesterday and should have saved that reply until morni=
ng
> to think about it more!
>=20
> We do want to align to to sizeof(s64) instead of __alignof__(s64) to avoi=
d
> issues with, e.g. 32-bit kernel and 64-bit userspace (same reason that
> aligned_s64 exists and always uses 8-byte alignment).

What issues could we have? In your inner macros I think you still make sure=
 we
pad everything up to sizeof(s64) right? Am I missing any subtle issue?

but...

>=20
> So I think this patch is correct as-is after all.

FWIW, I do prefer this approach or what Andy suggest (min as sizeof(s64)).

- Nuno S=C3=A1

