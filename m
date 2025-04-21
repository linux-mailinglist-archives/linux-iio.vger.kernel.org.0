Return-Path: <linux-iio+bounces-18440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46EDA9519A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6F23A85B9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE6B265622;
	Mon, 21 Apr 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg0dQwuU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD91362;
	Mon, 21 Apr 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241877; cv=none; b=BaMQ/crxRFGxCdRQRz32cWOGfWtdTlyDFgyzWYiUJTKNi6CgkloMOOncmgRuz7tDUQhHNw4nj5ued/EYH2sFW+m8CD47hAiSn/ZMYzbUYp0ZcZEIzw2rSCFmtNiFnOOHrUNvkgEhVmnKZO+oULcKJTkeEABOM2KID4fPn+frwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241877; c=relaxed/simple;
	bh=PTkcCiDtr5aIKVeI0emRtcw8lJMkyHU4AQVhpwrA+Vk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzoGzenPTCbvoLVNnIQ35o3Z9T7wyKS42HYGl059p6EC5SeyLfuEREL++22YCKYoKvYhrYkIB9NK7e82z9HnwL6Ecmwf9GiA2ffJKVmrbrcVlWmKzLBYkDV8PVT+m0ygyzBX83JC56DcnfPlIb1/Z/KGMAbzHbTg7Nwc6PeSTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg0dQwuU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso39038375e9.2;
        Mon, 21 Apr 2025 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745241873; x=1745846673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wx4yVL5ZudMMnzTwUXZo6d1VGF4+x7P+sQRc6+MEvuY=;
        b=Cg0dQwuUZhy+hIWX2Y4VJbKT8m1N0vrNounPpg41wMicy6hvNJLCyfKxLa0RNV24Ry
         Kuy7sRfovnMZx+9xcQiNy7LtXc9mp4THnqVbx0U4USsWAjIDlnFGjEQvfthPCK6xs5E1
         Ph24+RekhkEWMJFQqrMSy9mW1SPO2EwN5BRcDhuiDG0KgGgqM8aU0IzpLJOKOss4q2ht
         lHlt+LZGcjz3EAUTd15ZT5NCqXc+TvJzC5XkTPYlVb+30kaHm5+H78uORONxz5RuqSp7
         tVMFjBvbI+rlLSiVeeGdth8d9UFZXxKKwxgE21sm3LjkzF4O3i4V9I7sdAWUtKCFj2Du
         ljWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745241873; x=1745846673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wx4yVL5ZudMMnzTwUXZo6d1VGF4+x7P+sQRc6+MEvuY=;
        b=bwzs7N2Tok5VGb4aY9yuaBhMkqjP8nlosFUOFuDNr2me47fN4BnytOkxKhETYixgr+
         xYeQSqgnSHzpwY13nNiy8K5UrWlQJ0c+1mTiUF7uNklWiWK6JWM1y3vHjSbe72dPvsrk
         aGW8oRSLRvIdr49Y5AmmiLXutmER1gb1yEB0OJHu/ca6nGRjxi9YNt7LS6oQ6/NjRVtD
         pehN9LPs2JKJBowxS1K937XIzExp/AhR+QZMuw1gKMq0LO3Dk+bL0KSyIuKdoPWSwIHJ
         s3MudS9WuHmnglhYaYyXTGpmqTLC/mOwS8spBnEnnv26ZZdT570wj9BSfQsfkH4czxEE
         LIeg==
X-Forwarded-Encrypted: i=1; AJvYcCX9XsOKCdKJb9Lna4W+bWVvlWuN8PwyULA7c7JEE0Ub1EKKQQDCE7YUrEUgm9pz32ThI4+KhB38yJqPSps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomTa+ORKFuROpXQyhQZW/64AE1HdDZGNX1o4ueSBBVMNl1/3p
	4AuBuIWGn9lY9z2Fcsj2yMoCA3eQu+Q3gyN9xZW4Ipde0XRYncI6
X-Gm-Gg: ASbGncteYPjU+Cly8vJkdopkJUoBzBh7gWkWhd9oOSE2Ovj7aXLoe7fcpIkk+OOkdfD
	VlfvjUASLpjjK4KFR5mtgjqrwMhVdVE8xnzTECY4kHt/SMfFsThvFVsM5qKRhoS/LwnN/QnxW/6
	B7GkgV/4E4yXGo54deMK210F+f+8wp76n9mV+ZzRGleyDgpHTeUHLvbGA0mZLhnpSh96Ts0J2eu
	E2ak2lzRTeaQrm5Ijs2Kp6FwgWrtJZM5dBTZrcgIjG0TsTgUTpk9WrwFbaQLhZkTHEdbdg+OGR0
	BI5MD4Eh2B4lcl0mY58Ng/Qc9g5lKlpzpVhYMsRtVingMetmjQBkNdS7DK6f3h2j8aUED7PtLX0
	PIlE1OGnyAsBwIDeVxTG0BrU=
X-Google-Smtp-Source: AGHT+IFcfG5PsZxAY87WCber6ZZQZ95hB9HZmlN/ZjlW2HZ32kLUEcFlavWq71X2FmtNEObUJqL3Ig==
X-Received: by 2002:a05:600c:4450:b0:43d:94:cff0 with SMTP id 5b1f17b1804b1-4406abb198amr83604095e9.19.1745241873363;
        Mon, 21 Apr 2025 06:24:33 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db173sm133072715e9.32.2025.04.21.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:24:33 -0700 (PDT)
Message-ID: <8b5687ec66236b0869c864f65e2e04fd6e58e725.camel@gmail.com>
Subject: Re: [PATCH 1/4] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Apr 2025 14:24:36 +0100
In-Reply-To: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-1-ee0c62a33a0f@baylibre.com>
References: 
	<20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
	 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-1-ee0c62a33a0f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-18 at 17:58 -0500, David Lechner wrote:
> Add a new macro to help with the common case of declaring a buffer that
> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
> to do correctly because of the alignment requirements of the timestamp.
> This will make it easier for both authors and reviewers.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0include/linux/iio/iio.h | 16 ++++++++++++++++
> =C2=A01 file changed, 16 insertions(+)
>=20
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index
> 638cf2420fbd85cf2924d09d061df601d1d4bb2a..f523b046c627037c449170b7490ce2a=
351c6
> b9c0 100644
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
> @@ -770,6 +771,21 @@ static inline void *iio_device_get_drvdata(const str=
uct
> iio_dev *indio_dev)
> =C2=A0	return dev_get_drvdata(&indio_dev->dev);
> =C2=A0}
> =C2=A0
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
> +	type name[ALIGN((count), sizeof(s64) / sizeof(type)) \
> +		=C2=A0 + sizeof(s64)/ sizeof(type)] __aligned(sizeof(s64))
> +

I tend to agree with Andy on the two alignments thing. Independent of that =
I
guess this is also not intended for stack allocations? If so, we should may=
be be
clear about that in the docs... If we do intend using stack allocations we =
could
improve it by making sure the build fails if "count" is not a constant
expression (likely it will already but I think we should make the intent cl=
ear).

- Nuno S=C3=A1

> =C2=A0/*
> =C2=A0 * Used to ensure the iio_priv() structure is aligned to allow that=
 structure
> =C2=A0 * to in turn include IIO_DMA_MINALIGN'd elements such as buffers w=
hich

