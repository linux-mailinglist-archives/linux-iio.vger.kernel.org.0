Return-Path: <linux-iio+bounces-18558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE2A98546
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 11:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4226A5A1ADD
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA022F767;
	Wed, 23 Apr 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm5q6czB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403FF20CCDF;
	Wed, 23 Apr 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399937; cv=none; b=g0BstyBQtuGrNYXsdMh9Tq7k+//Nx+HA93xowArkBCX/N/goY0uF7z0AhhZbBcxNY2icQLOsOEWWYo++GvCIy86TIxXq1P35Iw1B0onDbcEC4kkexBCntlvI5JKMRUJxzJRdCO7tizeZJhwt0V/AXYhCSc+cvLdwk0ngYPDhxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399937; c=relaxed/simple;
	bh=E+HRHrDCaWbEY15xFZ9y7fcANkgo1uK8mrgkg76ViiQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBt3i9SLA+BNTeg5+OJyTr+9/jOJJS1V0jEa75V+dk7YE+MYO3BzK6XuJwoHqpjTJK3yLN4g5H1oACQz6zn3NciYudpQNI4ReMVJj5XbLs4MAicNb+fhEYMxj7JoyksUL03QBlzZCT7YxlB14/hreZMuyoQiA2vpNIyxb6O5orc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm5q6czB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso4898615e9.0;
        Wed, 23 Apr 2025 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745399933; x=1746004733; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VrGROsqZIwKCgrOnIO0opoKDeXx0qHVFUxais3JjiPU=;
        b=Dm5q6czBUdLTICAcM1tK0fbsY44sGRbML/ldSA+q8dbp0afKwOB++Tk69+hL2zhD3h
         /nOa9bV1+LeSQw9RPlz2aiLNPOFzAQX2yTUwhDcn/93DmxdgEo/tKzJQ7JbQto3su9Aa
         6yaN9UvXjXUb6zWu4GhvMgtsLwcTso+GA1yDW+83WJM13//87Zz3ru9Xcey1j7eDOSqS
         tsHOGQ5yH8rhOfCewfXRvunJhPtvLlshmGeAdyNBKetETm4kEIc5LEj0OnZKJ7lPVxgl
         LJvT6Gbw1lj2DahrE5Y3Jl6weoKDWvGrGDMHZDKyK/7YyWXoqRFapPHMySWqu9Ym61Al
         pvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745399933; x=1746004733;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrGROsqZIwKCgrOnIO0opoKDeXx0qHVFUxais3JjiPU=;
        b=EM+mDAkExZ9rVw6vCdF51RCD2jVZrYamTIzY1f49i2u7bGpjRD6/iXmsJQQHYAJVLR
         +r0kQISdeJ0BGNxs72KbV3o8JmMITYOl017ydBrbwkFem8T2yn/U8TkqMtp9O52VkHZ/
         uBi/oxeTNVR6ZzjomkGN+Nh/NPyhTAeZcez709y3u8FHUvdszQZNsuvvlhWvlBIeXN7K
         Mf9NxU2EzIRl9J8pi6vro3Yemj+7ppAawSJiCUVs3/U8Lez5egioO5OFjwchL8FKItjH
         V/uevLEwRysTmKwerl/998ValCGuuV5pMSNDrygwswwoOCAi3W+7yAq5Ju5UcmSanQMd
         BxZg==
X-Forwarded-Encrypted: i=1; AJvYcCVCv9MTvtX32jCY2+E8XdZ2qSibicZfhjL5x/wFA9MRH6crXvaP/2yWl/rl5oCU2QlUKsSUM40COIqcRRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iBjaS9rP7MGK2M3CUdJtMIXtXAtDVf2Y7puxN80r9jawhlaR
	SFhEL5hMIN6MT6feZVbGReCxGWq2RVJPrqOo7k4q6k9KB3nJ1ruE
X-Gm-Gg: ASbGncv97lHy/dAkNAKy4Lm81seq0QrsOz806JkonAB1y1kKtOHWVmLAM4rFE5A4qAv
	skcVsAogiGbTdtwp37Kd6r08djZKnH/hh3hCcRpQ5SheLYkV35Zt+MaVP8+hv/jMJWZ9Xxo6dTZ
	+oVGke7Bop0SAfHXRPAwJOs6Z4HvyY0u4BQGEQSIDquSQniFZD8TzSALe0xoKjtnN8QJ6fPnUGn
	VHTOV3s++u2xr41tiAJA9f203/hem0tLdugHdHmI7iECo2ObapICV5r5GzpwQbYKsyExOSj4Dsr
	aiIPrH9yRKUK35+nCHt5kYfhB+XV92N6IXJB0K806NBy1dhsaIO5gV5dkwgHOYMFeL/KwD3Y/ih
	igwKXksIcZruK
X-Google-Smtp-Source: AGHT+IG4usbOo5npOeZN1xbvBwncAj7wxo11cJLpW32A6dZWurXCH49f3H3MAKTcb59zIVTdCG5IiQ==
X-Received: by 2002:a05:600c:2d46:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-44091ee7a72mr12670515e9.5.1745399933033;
        Wed, 23 Apr 2025 02:18:53 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d16dc0sm18664225e9.6.2025.04.23.02.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 02:18:52 -0700 (PDT)
Message-ID: <701bfc6a715046044dbc789f1c11c7f85395c7a8.camel@gmail.com>
Subject: Re: [PATCH v2 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
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
Date: Wed, 23 Apr 2025 10:18:55 +0100
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
References: 
	<20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
	 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,

Nice patch, I really think these will be very helpful... Just one comment b=
ellow

On Tue, 2025-04-22 at 17:07 -0500, David Lechner wrote:
> Add new macros to help with the common case of declaring a buffer that
> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
> to do correctly because of the alignment requirements of the timestamp.
> This will make it easier for both authors and reviewers.
>=20
> To avoid double __align() attributes in cases where we also need DMA
> alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0include/linux/iio/iio.h | 36 ++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 36 insertions(+)
>=20
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index
> 638cf2420fbd85cf2924d09d061df601d1d4bb2a..4dd811e3530e228a6fadbd80cfb2f50=
68c3d
> 6a9a 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -7,6 +7,7 @@
> =C2=A0#ifndef _INDUSTRIAL_IO_H_
> =C2=A0#define _INDUSTRIAL_IO_H_
> =C2=A0
> +#include <linux/align.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/cdev.h>
> =C2=A0#include <linux/compiler_types.h>
> @@ -777,6 +778,41 @@ static inline void *iio_device_get_drvdata(const str=
uct
> iio_dev *indio_dev)
> =C2=A0 * them safe for use with non-coherent DMA.
> =C2=A0 */
> =C2=A0#define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
> +
> +#define _IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
> +	type name[ALIGN((count), sizeof(s64) / sizeof(type)) + sizeof(s64) /
> sizeof(type)]
> +
> +/**
> + * IIO_DECLARE_BUFFER_WITH_TS() - Declare a buffer with timestamp
> + * @type: element type of the buffer
> + * @name: identifier name of the buffer
> + * @count: number of elements in the buffer
> + *
> + * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts=
().
> In
> + * addition to allocating enough space for @count elements of @type, it =
also
> + * allocates space for a s64 timestamp at the end of the buffer and ensu=
res
> + * proper alignment of the timestamp.
> + */
> +#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
> +	_IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(sizeof(s64))
> +
> +/**
> + * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer with
> timestamp
> + * @type: element type of the buffer
> + * @name: identifier name of the buffer
> + * @count: number of elements in the buffer
> + *
> + * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses
> __aligned(IIO_DMA_MINALIGN)
> + * to ensure that the buffer doesn't share cachelines with anything that
> comes
> + * before it in a struct. This should not be used for stack-allocated bu=
ffers
> + * as stack memory cannot generally be used for DMA.
> + */
> +#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
> +	_IIO_DECLARE_BUFFER_WITH_TS(type, name, count)
> __aligned(IIO_DMA_MINALIGN)
> +
> +_Static_assert(sizeof(IIO_DMA_MINALIGN) % sizeof(s64) =3D=3D 0,
> +	"macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp
> alignment");
>=20

I wonder about the usefulness of the above assert... AFAICT, the default
alignment is 8 bytes and I could not find any arch defining ARCH_DMA_MINALI=
GN
smaller than that (would be very odd to have a cacheline smaller than that =
these
days). For bigger values, nowadays they are all power of 2 and I would be
surprised otherwise. But the more important question to me is what if the a=
bove
assert fails? Will we not allow IIO or some drivers to be used in that
architecture? It can become a very "painful" situation (assuming these macr=
os
get widely used). So, IMHO, either we assume the above can happen and rewor=
k the
macros to make it work for that hypotetical case or we assume the above is
always true and drop the assert. TBH, I think it would be a fair assumption=
...

On top of that the assertion is wrong:

sizeof(IIO_DMA_MINALIGN) !=3D IIO_DMA_MINALIGN :)

On the other hand, as I mentioned in V1, I think that an assertion or
BUILD_BUG_ON_MSG for making sure 'count' is a compile time constant express=
ion
would be helpful. Sure, we'll get -Wvla but some developers might still ign=
ore
the warning and send patches with these arrays. So, it would be neater if w=
e
fail to build and force them to fix their code.

- Nuno S=C3=A1

