Return-Path: <linux-iio+bounces-16656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23699A58E39
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 09:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C81816B76F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A382222589;
	Mon, 10 Mar 2025 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXgfFjF+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACE1401B
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595688; cv=none; b=fMp8wc9uocRyibcoWpPOlluw/XfbzyWozPgpMrOAkn05mgYiat59f9/xNRT0ebBznCEMesARmdNaNoxrMURKYL7lz/GAnpwi2B/+vY3qpr/gCTZil0udfQO/Q2eoMrMis6YuVfQjBtJLeaCL9O5b+QhOmEJAn61+fJUcJB12ZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595688; c=relaxed/simple;
	bh=MvuVP/oKC49Fd+Fvae5Qa5MrmN2Fp9WBecEoGu5S+eA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/T95Hjgs3/1J0HzVj8dH0i2sddmbcWjD30h83NHaJalnKDsZ5AobjJR8W3Bxl3OXbdGRt+58IcD19RL2FjnVn/IG/VCm7Ni5G34QkXFNOhUyLKo7bxruGIxKe2wyY5qBdIDgVQ2pa1TiX08zMukpyCWNWOkXwaH6XDao+jxsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXgfFjF+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43690d4605dso22871645e9.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741595685; x=1742200485; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tMT7YrgpsCth3QlkQwF754F4TmpeKje1S+pU1AGoCe8=;
        b=fXgfFjF+GtcAZBqENAM5mFnHtjGvdK+kzwqy9q1by9xWhA+vP6ImKnNoG0VgQymlYj
         api17PKphw9hPAeRjAkQooW3XKc9/AAvGVmYDwPCsm1pdkRq0Jg+wZMRRS7e4CTNTBpA
         u0Hpb/VKvRvlOmuMtYT2V2Oq1/Ma+S1EjToGqJHrPyqZNoc/VJKKxNoJILH1xww76ZGt
         XZN38/mSebO24uwu5Jo7kkEpqVZ8BKZ3SCf7grQHXP4kTdiFa0slN8CA0w51efdHnk6i
         +Afrvre21zaV8vuhwe4fzErk6RJRifSjdAvfik5FujRooQQKKxvNYublB/Vfv9q7Sp9z
         7zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595685; x=1742200485;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMT7YrgpsCth3QlkQwF754F4TmpeKje1S+pU1AGoCe8=;
        b=HkiSMihiMrX/xw4ZPKHufGEOhf7jplpM9dQdQ6HSzSnX3oN2iqfOWxUrrqx/RVs37i
         k41Y5qQJY4SJN1n/EVUfnRqnN8DIHG/jBej/Tk/1NrCarPjZ+Tj1G97x+6ZBw000X9rF
         aZ3Egku6Pt3wYilrUxjNmO4ryAZahaMUMZBoH/bSvff2dMD5l4Ev8/sGdYuLZ2XjZEuz
         KI+Uj2lzdfxXmNxbpsVNTpzDne4wiv1VkdD/jpyhBjSL9g9yDzs3j2uonqNwuTVhp0uU
         NA312q//YnzQdPBH//cCtjV4udo7xVC8gm77kaxkSNh8wujP0N7/dqEyr2ZGhtm/6I2I
         Y4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Vgj8P8mywm1KrVmOLbznyhI6D9X+Jj/4Cx3z0FHbH6XbuEuL7TXcbqVEokv8CXzqO9mXmX4UbNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/pVLBjNb41Oc2KO1RMcj0EfFQz3NRzBpHtD0CJvHthRIRWOYR
	+eK8QOfp55LZR7+J6asLoDxXSabuJNURrxRbaFN6KXTB7+ksTC3mp3QkVt5UAlw=
X-Gm-Gg: ASbGncu2X/L/yHN5AKIm5QAcv4iw0U3FqBKYx+V234/hH8Wkt/HkezBeyvbfW4aIZl6
	z68PkcBz8RPPJ6/iPq/N6VkPAv+yOSG3D6wyEY0d43R6VWmgQS1pL+dA3QimsD8j6Ler7jlGMxK
	aEnR/edFoZ3TSsiTEfl0WJhOUEQBYQIhSsIZMCG4Uh2cQwl4nwkbB9riA/7GQzEpilCowOhS9+U
	y8SHm8KI2cwQIjUTtQAcVOiGnT0/kukL/z6Cw6fbIzd3bN2ncUawFKRoTku97Shhkl47KlvPkk+
	8MeQh3bUhvHI7FDPnzcMb+FsXDgefa3VWLtFloP3ZvrzNdc9HmOKkdpovQQIHq58Z7/f+pJlaER
	wt3ZGsLpvwpj4Uo+taKe4k+zoCfc=
X-Google-Smtp-Source: AGHT+IEo05jHtXJnk5Fe+0KZ8HXMT3/zs/sQM2wWHFDw4jhXtSASU7ouATXX5U55WrGILSsqSRZv+A==
X-Received: by 2002:a05:6000:4106:b0:391:47d8:de3d with SMTP id ffacd0b85a97d-39147d8e0bamr2487779f8f.16.1741595685232;
        Mon, 10 Mar 2025 01:34:45 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfa97399esm19374475e9.14.2025.03.10.01.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:34:44 -0700 (PDT)
Message-ID: <dce7a134576836f58c41d5a3cb3bf244f0f9c447.camel@gmail.com>
Subject: Re: [PATCH 01/16] iio: introduced iio_push_to_buffers_with_ts()
 that takes a total_len argument.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>
Date: Mon, 10 Mar 2025 08:34:50 +0000
In-Reply-To: <20250309182100.1351128-2-jic23@kernel.org>
References: <20250309182100.1351128-1-jic23@kernel.org>
	 <20250309182100.1351128-2-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-03-09 at 18:20 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Check that total_len argument against iio_dev->scan_bytes.
>=20
> The size needs to be at least as big as the scan. It can be larger,
> which is typical if only part of fixed sized storage is used due to
> a subset of channels being enabled.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> =C2=A0include/linux/iio/buffer.h | 13 +++++++++++++
> =C2=A01 file changed, 13 insertions(+)
>=20
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 3b8d618bb3df..75d5e58b646b 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -45,6 +45,19 @@ static inline int iio_push_to_buffers_with_timestamp(s=
truct
> iio_dev *indio_dev,
> =C2=A0	return iio_push_to_buffers(indio_dev, data);
> =C2=A0}
> =C2=A0
> +static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data, size_t total_len,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t timestamp)
> +{

Kind of a nitpick but what about data_len as the size relate to *data?

> +	if (total_len < indio_dev->scan_bytes) {

Given this is to be called on a fastpath and that the above is clearly a bu=
g,
what do you think about unlikely(total_len < indio_dev->scan_bytes) for som=
e
micro optimization?

Anyways, this looks like a nice API improvement to me!

- Nuno S=C3=A1=20
>=20

