Return-Path: <linux-iio+bounces-7340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE19286A8
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1D91F2302A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59314885E;
	Fri,  5 Jul 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAtYpGwB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233F14659F;
	Fri,  5 Jul 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174701; cv=none; b=TXk/SfOWzke4+pcahRH/jPMXKdymAsLkL7EctMICJ1dVYkYUO7iYE37PpfYfuvwneTbmQuAo4LpXDZSJ9UW3MRYuzPeZojjfIBrUB7z/sunQBK6N6DdR664r1qZpMEQFgZusoGxlqMcmV0zoNWGMFonybHrPHRjmb9BcALYHvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174701; c=relaxed/simple;
	bh=p0wKucMNP2ESwZy6HwLX9yMbUOXNi1BiG2FPMbS/Mes=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KXvDQKTFecPAzm6s/bjYb8cZxnkpR5zrpQJUauESqszOFacAtQOc+Oa+WtBVmqJmfBeHoFM0IC6iZV5P7MCQGGGPnwq41d5hFobP+8HihWcNSRYtkK+9dLC0qJaJP1m4Rme63Tofcp8pGjeIKQoQkQJAlhoGUZvs/+YDwSFM61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAtYpGwB; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee794ebffbso23960871fa.1;
        Fri, 05 Jul 2024 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720174698; x=1720779498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=43NgL66AZcBZsA04MV0R2l/SVAIXfdD44CFW558QA6o=;
        b=AAtYpGwBJrsg4UUanIXUwFrwFAyoEoy/Cg1OgEhOjjY2D/6AhAGSNk+3s3y/Skn7AK
         jhpYPH/FowbLUt7I37KbBQClmOohuxY0tpln1XhZDXZU7vNBoPM0gUK7va0ObJ8yqj+5
         1gZvL+P3/v3YLqMx3LXI6qLn9PXOdI3yZTpbhr+k6NJ4krLmuZu08mNp1mZBwZd3nCyJ
         CkkC0vzV23/MPwtR/gwP+YnSqHYZ8ffBLa5kivdV+gkbXHc07zgk64g4E5ToM26T7dOH
         zaXKS+kW88h6nSQWY8LA+KshQ4JR33PPXSYk5xKg+v5Qw2quCcWeHcdkIJcB4PGD05YM
         9fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174698; x=1720779498;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43NgL66AZcBZsA04MV0R2l/SVAIXfdD44CFW558QA6o=;
        b=t730ddj5OCgn7JsM89K6cCFsGLjpCRoUqGA2Hgrkaf+6DiaIUkFMAh4H5DZ5tG2xTv
         ZLTN8Z2d1fXCNUDW/jd8zMbFYhhsi1v/PBHl1yVBq6J59yU24zTlnxp1YR4S9I6b4ptf
         haxI45UNtT1wsNnwKdk16V4xZcweiuQNkGCK9lzz2dGetA1CyY2g8K1+RVjN4Etw9bFY
         i9Xn/36IEFZiUyg5D4ex6LwsyTx1T8nmK4z2xBPy8h9ypbNclxERHOQyl40ub0HEyMyA
         uhArUhCat13anNwmnN9paf13m28KlxjoW9t0jnYKOF6GBOkZxyZ6VM8mnE8T2hgWR/iC
         0igg==
X-Forwarded-Encrypted: i=1; AJvYcCWGlm7SBwPg1HuqoEzcOi7u9va9eW7qT3oFxuNYurvK2buUbAoR+5qbYIUXYycyXEO/mIM7S17ZSQt9ZWZrVLakd4BogyAy7OhrAQmc
X-Gm-Message-State: AOJu0Yw31tRW5/znZNPvvVANUMXvxTZP7AQ7t/pow6V2gZCyk2ZvuI+X
	SYS2yPjiMhfDY2Uut6Q6gfMbRORpu+jf4z5Wxe8oLeqxL3OscC2Z
X-Google-Smtp-Source: AGHT+IEUMDlt94QW/JlVMXt/5txcvz0TQfnqYGXAzmvYCAIPb5YY2MFEUWa0HhdkwQhkDkSI9fSweA==
X-Received: by 2002:a2e:a605:0:b0:2ee:7d6d:2ce3 with SMTP id 38308e7fff4ca-2ee8ed904a4mr30571031fa.13.1720174697464;
        Fri, 05 Jul 2024 03:18:17 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a76841c4ffcsm267590866b.41.2024.07.05.03.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:18:17 -0700 (PDT)
Message-ID: <e1de64478918e495ccdcbcb5ad5bae0e48d45808.camel@gmail.com>
Subject: Re: [PATCH v4 1/8] iio: add read scale and offset services to iio
 backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 fabrice.gasnier@foss.st.com,  Nuno Sa <nuno.sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 05 Jul 2024 12:18:16 +0200
In-Reply-To: <20240704155338.2387858-2-olivier.moysan@foss.st.com>
References: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
	 <20240704155338.2387858-2-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-04 at 17:53 +0200, Olivier Moysan wrote:
> Add iio_backend_read_scale() and iio_backend_read_offset() services
> to read channel scale and offset from an IIO backbend device.
>=20
> Also add a read_raw callback which replicates the read_raw callback of
> the IIO framework, and is intended to request miscellaneous channel
> attributes from the backend device.
> Both scale and offset helpers use this callback.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
> =C2=A0drivers/iio/industrialio-backend.c | 34 +++++++++++++++++++++++++++=
+++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 +++++++-
> =C2=A02 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index efe05be284b6..4e0ff6e6e9d4 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -357,6 +357,40 @@ int devm_iio_backend_request_buffer(struct device *d=
ev,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
> =C2=A0
> +/**
> + * iio_backend_read_scale - Request channel scale from the IIO backend.
> + * @back:	Backend device
> + * @chan:	IIO channel reference
> + * @scale:	returned scale value
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_read_scale(struct iio_backend *back,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *scale)
> +{
> +	return iio_backend_op_call(back, read_raw, chan, scale, NULL,
> +				=C2=A0=C2=A0 IIO_CHAN_INFO_SCALE);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_read_scale, IIO_BACKEND);
> +
> +/**
> + * iio_backend_read_offset - Request channel offset from the IIO backend=
.
> + * @back:	Backend device
> + * @chan:	IIO channel reference
> + * @offset:	returned offset value
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_read_offset(struct iio_backend *back,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *offset)
> +{
> +	return iio_backend_op_call(back, read_raw, chan, offset, NULL,
> +				=C2=A0=C2=A0 IIO_CHAN_INFO_OFFSET);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_read_offset, IIO_BACKEND);
> +

Hi Olivier,

Not exactly what I had in mind :). My thinking was to have:

int iio_backend_read_raw(struct iio_backend *back,
			 struct iio_chan_spec const *chan, int *val, int *val2,
                         long mask)
{
	return iio_backend_op_call(back, read_raw, chan, val, val2, mask);
}
EXPORT_SYMBOL_NS_GPL(iio_backend_read_raw, IIO_BACKEND);

Then, on backend.h

static inline int iio_backend_read_scale(struct iio_backend *back, struct
iio_chan_spec const *chan, int *val, int val2)
{
	return iio_backend_read_raw(..., IIO_CHAN_INFO_SCALE);
}

Advantage is that we only need to export one symbol from the framework. But=
 the most
important piece I don't really agree in the patch is assuming NULL for val2=
 (even
more in scale where often we use both vals). So I think it already makes se=
nse to
expose the API with two int's even if you don't need them for your usecase.

- Nuno S=C3=A1



