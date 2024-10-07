Return-Path: <linux-iio+bounces-10279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD929930DE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E890B1C2279B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014DD1D79AF;
	Mon,  7 Oct 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbB3Igva"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF765338D;
	Mon,  7 Oct 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314117; cv=none; b=b+ARTTIxGLlkQzCVr/1QmCLolFsEy1naMYS0MRO6atohvLKrMl3VaP4E/jGe4t8dXT2xfFnBZZDymRxWvSEwLGRbGUo7GQRZ9pQ8kVsxvZ3c9vxeM1xR8CQ1dHS97MukKLGETdrgcvx6YjEdnwUgxJ5seMqwgQ4MiAPtDdlLA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314117; c=relaxed/simple;
	bh=gunTeazw+ZrkxkOgLjuxsBZi3IH0C+YwzRH8GZ2kJxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Br4KwzR3rdTSyKmb6gm1D/a1yIwhZVip9/wVaHGUIyA4aPL3i4GAbZT2mV5jVSQ77lOnLIW1Jm3ZvihOTtMwreueFJJy9KsiYXsa1FpD/Q5Vt4sdmWZU7n959D4IgJ6M2JlOA2nH+G/0PbM32zF55mxwVYC1UPR3r+LSQM6V+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbB3Igva; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99415adecaso307637466b.0;
        Mon, 07 Oct 2024 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314114; x=1728918914; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PN07q14I0ERr6DSt1fbUdHvm12enYACHqhoLOwef/JQ=;
        b=cbB3Igva2WQ7uE7PEFKGjejUc46YT2BOh91hAWH3WrNolyF1dDQYLoHG0e2xF0is7M
         qB8a9BrOE5od4su5HLQTkhJf49JFlwCJOiEb2Pj8DntgfQGTzTk8Qj3ybKS8aD5Blutn
         vbVPwdRAazlZ+v+lOkj/UDRNBr3iJFmj3t75RqOJmybBYIKd/+Fwq2QmDBl+nuBrzV1a
         my8SQRubMH2u/OJcRhzUIa1liMAOWM9WabFw254YnjZ59KKEXu0nj9ZRUJONyYCSkRLT
         hc67NUvsaJ+f5U0oAYaCBZ2yYF0ZLvwJw7UoWhDkdlSN3rYn+AE62q4KHa7TMS6g3ZOl
         hJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314114; x=1728918914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PN07q14I0ERr6DSt1fbUdHvm12enYACHqhoLOwef/JQ=;
        b=GUVHplkKaMY6Ox7TgK7lt0k7A2GG8OOljyxSS9ICCHO/OCD37UVMxiKlgQQoTAL/hO
         rBY/k2DOAvh3yvM9kGDZH2vlBCjXkeu4Jlqe8/j+8XQHq8Av1KL2PGajOTezfUoUR0z7
         zLKIVI75N2hOPb9K4gq770zc7gO9KIk8vxlRYPbwk+VgFCd9XwU1niX3HIZEdZggQOFU
         QBlpE1OsJpswrTShBeNhw0spwKFrxirMXrPHxwUn7Hw9PYLUxRdLGnEd7o8TX6vGSdk4
         aWRBBupjJI9sb5EDgVH7qWSMEgo3AbQx4CjWy1aKvxoARl5KoAIJS1gMY7MGzcE6BjnS
         it4w==
X-Forwarded-Encrypted: i=1; AJvYcCUGjbCPmuJvG4tEK+hvvCd9HGsi2OFm2GBHhaouiD7QgHpp/Y5NDo7iU/dMQbH/Vonuo2FX12r4k/0=@vger.kernel.org, AJvYcCVHb6TIRAPYI9Qiw49T81Pyj+hoLas747MfZ1eNRDiRPUcQl/aa83ZqgYsK3YMh4Ln2YsxLmf39MPRePj8=@vger.kernel.org, AJvYcCViSVKgvFI4G79ntIZZBz6lTewCa3meGYM/YOIvVvMwYNDvGsnfPwlcrhVCFvSHZ4i83iAfjpv4GK/KvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrjg2rQtfwih1uzIA4Wno47+KOca35jqftMYc5cLe875c51LC
	/W7iZvzEQULfqaPy3uePrY2t80ykHV3alEiW+Rr7tH1Ixr1fu5s2oLCV4wzc
X-Google-Smtp-Source: AGHT+IEkPYPI+5UiY0ODqposUxSq+duU2m4ZE0vN/XilFUXU5SaI4dF8VsvgVyvujSmlc0AzpSmEpA==
X-Received: by 2002:a17:907:36c8:b0:a8d:43c5:9a16 with SMTP id a640c23a62f3a-a991cede585mr1334495166b.6.1728314114235;
        Mon, 07 Oct 2024 08:15:14 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993ddeddadsm328187566b.198.2024.10.07.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:15:14 -0700 (PDT)
Message-ID: <8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com>
Subject: Re: [PATCH v2 5/7] iio: inkern: copy/release available info from
 producer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matteo Martelli <matteomartelli3@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>,  Christian Eggers <ceggers@arri.de>, Peter Rosin
 <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
 <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Date: Mon, 07 Oct 2024 17:15:13 +0200
In-Reply-To: <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
	 <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-07 at 10:37 +0200, Matteo Martelli wrote:
> Consumers need to call the read_avail_release_resource after reading the
> available info. To call the release with info_exists locked, copy the
> available info from the producer and immediately call its release
> callback. With this change, users of iio_read_avail_channel_raw() and
> iio_read_avail_channel_attribute() must free the copied avail info after
> calling them.
>=20
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
> =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 64 +++++++++++++++++++++++++++++++++-----------
> =C2=A0include/linux/iio/consumer.h |=C2=A0 4 +--
> =C2=A02 files changed, 50 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index
> 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa2cea447e168007a4=
47ffc0d91
> 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -760,9 +760,25 @@ static int iio_channel_read_avail(struct iio_channel=
 *chan,
> =C2=A0	if (!iio_channel_has_available(chan->channel, info))
> =C2=A0		return -EINVAL;
> =C2=A0
> -	if (iio_info->read_avail)
> -		return iio_info->read_avail(chan->indio_dev, chan->channel,
> -					=C2=A0=C2=A0=C2=A0 vals, type, length, info);
> +	if (iio_info->read_avail) {
> +		const int *vals_tmp;
> +		int ret;
> +
> +		ret =3D iio_info->read_avail(chan->indio_dev, chan->channel,
> +					=C2=A0=C2=A0 &vals_tmp, type, length, info);
> +		if (ret < 0)
> +			return ret;
> +
> +		*vals =3D kmemdup_array(vals_tmp, *length, sizeof(int), GFP_KERNEL);
> +		if (!*vals)
> +			return -ENOMEM;
> +

Not a big deal but I would likely prefer to avoid yet another copy. If I'm
understanding things correctly, I would rather create an inkern wrapper API=
 like=20
iio_channel_read_avail_release_resource() - maybe something with a smaller =
name :).
Hence, the lifetime of the data would be only controlled by the producer of=
 it. It
would also produce a smaller diff (I think). I just find it a bit confusing=
 that we
duplicate the data in here and the producer also duplicates it on the ->rea=
d_avail()
call. Another advantage I see is that often the available data is indeed co=
nst in
which case no kmemdup_array() is needed at all.

- Nuno S=C3=A1



