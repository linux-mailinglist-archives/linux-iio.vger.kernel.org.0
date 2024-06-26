Return-Path: <linux-iio+bounces-6938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA565917B41
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 10:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF8828199B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D87166316;
	Wed, 26 Jun 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHjZaIBU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963A15F41F;
	Wed, 26 Jun 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391572; cv=none; b=hcWUyehrfg4+oCfo8h4tPHTqUrJwCZ4a+ZIFEm+9DJaN0OXauSlnb63jmNmKJmRqaesDmm7lGqxDpoM/JL3UDFgYhOBc9yECcA3atEverr6zbJaL8EiTK4mKxSPPNGVlMj6U5mF7+lRslAVwnGP/4QcEKrnFp7dTuljVZyeu5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391572; c=relaxed/simple;
	bh=h79mznHSl/W4ra79KGuRF64LsBrfy+2kmSGDsL9msYs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pua8tHID6j5ubhOBP3vnCZtQT+fPCO/Z9NQe0sinVZB/0W3ITc5cGdcvbLCZCkaJAm7LBQPXKxbkYJXK8gp98Fr44u54mMQk3/mwbTbmM1By6yhqiY7BfZLTi6WrqUCHw3BDAwZMP8fnCtLjCnofUGjqSvqy3kfChY4ttVbRPaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHjZaIBU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724b4f1218so467546166b.2;
        Wed, 26 Jun 2024 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719391569; x=1719996369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gF+HoMYTQDkw0ZS822ARO0ZCBDmJWzWJIFLnjrTtD1Q=;
        b=mHjZaIBUQzg70Oxa+qN19dGrCQ2Li/BwppWi+ucj5kVnILOpkpqQll9w/XjqUCUfqv
         oKiY6KJm9X6qQN4e8/RLbkvMrShhfV2DtfTbCTx5xMAMxGR2WdYBubNFvLfwC/rKvp3t
         F+HjCKMdJT5mlD0Xv0YXRC5EtWgj4yXkYxrBOtlcKRJ1kz1zPh3KNW/SPovQkkVkUrpL
         t2zSSesQwzWH5CEfORQcuYMmhd6RyjWAhF6EdSzO6Y9xay6jfbdN7AOcW3dlnPh7WR52
         UPvkdga+YbygHEg1tC6iq7mrp0DXi7Euvw7gCFPfEJ7NnzG8PsA312fkNQUxm17vxf58
         MBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391569; x=1719996369;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gF+HoMYTQDkw0ZS822ARO0ZCBDmJWzWJIFLnjrTtD1Q=;
        b=LFczI7OjUr5sZbJbgxLz0RvZ/cl9Bc3s5IeYyNkVIl/o3ztVRX+oMLBOPIYWuBewv8
         2xV+qEqjMtsZJpmDNYFDPwGm1PpA/kPWfA1BS/n6BBR8Rq7niPe5V0W1hmtBHjw6d+7k
         9qoglh7M1i2kj91awS936M6fR3Q7HeX7VbDvEpL+znPpcxOxoBTxJvgX/RnI5SUPe7Qi
         levGzGe7X7n0LM94b9swvyJz5XeVu5fuInumPneqDvWyUM3v88913wVo9fKc4LBXFm6o
         dTM1MrV9Ciz1QN0z+iwBAS0ibShBE9Pa13n+Rhl0dGPSF/OZRqPb89U8xI0zZYxEnS3l
         S8gA==
X-Forwarded-Encrypted: i=1; AJvYcCWD3wpseIYue/pjofrV7Jno6bsLf3SX5gqZRogAX+TXP4accrJw/1zJAhZAAfz4freZgUAx3TpjxbrM3l9Utv2wLWCb7ju9WVEIqAgh
X-Gm-Message-State: AOJu0Yw4SEb5lIa2vWCkpl38Vxv0rh01Dc7RY5bnno5Y3pOdVOak9to4
	709jfq9PfsScRGJbiI7DSYGsyk8YdM0AsntVzTmvps0JctZ2R0NX
X-Google-Smtp-Source: AGHT+IG8ObbyB4q/RgRD5c3NC+vzw0I1wf5g7edgZFLdXdG8BcDf3rHZYSX45sd8t+mZqsuX5bCwXA==
X-Received: by 2002:a17:906:7c49:b0:a68:b557:76f5 with SMTP id a640c23a62f3a-a7242e12fd3mr593042766b.69.1719391569024;
        Wed, 26 Jun 2024 01:46:09 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7244dbeecesm397252566b.218.2024.06.26.01.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:46:08 -0700 (PDT)
Message-ID: <0a5f82ad9ba032d03b389fce54360a82914c15af.camel@gmail.com>
Subject: Re: [PATCH v2 1/8] iio: add read raw service to iio backend
 framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 fabrice.gasnier@foss.st.com,  Nuno Sa <nuno.sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 10:50:00 +0200
In-Reply-To: <20240625150717.1038212-2-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
	 <20240625150717.1038212-2-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 17:07 +0200, Olivier Moysan wrote:
> Add iio_backend_read_raw() service to support attributes read
> from an IIO backend.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
> =C2=A0drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +++++-
> =C2=A02 files changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 929aff4040ed..0e2653de1956 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -357,6 +357,27 @@ int devm_iio_backend_request_buffer(struct device *d=
ev,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
> =C2=A0
> +/**
> + * iio_backend_read_raw - Request a channel attribute from the IIO backe=
nd.
> + * @back:	Backend device
> + * @chan:	IIO channel reference
> + * @val:	First element of the returned value
> + * @val2:	Second element of the returned value
> + * @mask:	Specify value to retrieve
> + *
> + * This callback replicates the read_raw callback of the IIO framework, =
and
> is intended to
> + * request miscellaneous channel attributes from the backend device.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_read_raw(struct iio_backend *back, struct iio_chan_spec =
const
> *chan, int *val,
> +			 int *val2, long mask)
> +{
> +	return iio_backend_op_call(back, read_raw, chan, val, val2, mask);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_read_raw, IIO_BACKEND);

I actually got an idea when looking at this for my existential crisis betwe=
en
dedicated APIs and a catch all .read_raw() :). What we can do is just provi=
de
the .read_raw() or write_raw() ops to backends (so we minimize the number o=
f
ops) and then we build on top of them for providing more readable (dependin=
g on
the case; some cases it does make sense to just call iio_backend_read_raw()=
)
APIs to frontends.

So in your case you could have in backend.h

static inline int iio_backend_read_scale(...)
{
	return iio_backend_read_raw(..., IIO_CHAN_INFO_SCALE);
}

Naturally no need for you to do this right now in your series. Just wanted =
to
write it down before I go into other stuff and forget about this :)

- Nuno S=C3=A1



