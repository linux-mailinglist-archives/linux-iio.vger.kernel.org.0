Return-Path: <linux-iio+bounces-17768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCFEA7E5F7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8AA7A3F6E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12FD2080FE;
	Mon,  7 Apr 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br8R2GIP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C12066EF;
	Mon,  7 Apr 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042379; cv=none; b=rYNc9thr+jqiL4J4z/WzJH3fFSQOT/V/SdkFziXeqWYa2oZJrfkXyOKfEegxbApiuhgF/hCqHND53E/mj1cKSjSBOVKhQo7gjOr243xvStR690LwOEV86ERh8Lx7kX3hszfI7Fbi3CZ7c3Fn3GPZLBELM+nu01trspWd8YgxXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042379; c=relaxed/simple;
	bh=ZAPVS+gOYLQX255ZJo3mBjglhSU+jqR3+Ldyi1Zahx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JWbrjaTtEGWPf5XuN1twphQAyMEpVh7zSxMTrIy8wzo+wQ5yrHTPH16Jr9+KpGb5XYgiHgOvIQeYAk7XX722kUpYAAzPC1QugduYLpDfdRzi+v6huha3otpDICtqw7PWyuMOw1sSuTdX04RGh80Lhg/nSnGp1Gl5JaOIMZaectQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br8R2GIP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so19051795e9.0;
        Mon, 07 Apr 2025 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744042375; x=1744647175; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RLDy66M+skbjiXw8NJvCe4Orr2lfF4gig4D2dSbfbp0=;
        b=br8R2GIP0a7oAf5WXMEeWvenVzchBIlZfjYEizMdgoF09oza5Q9M8CXPyvLF/JUywd
         BJNGdlUuZCsloA9+KKV5j/fO3SHNTz37EEOctCyPQN+mxBCARySvAikbTF1LqYOB89Gg
         rN77s9LYMt8wuB4I5GkwY5IZrs174F3QoUH2X0foH4onyPHvt87mtAJjaXdq3L1Tbm1B
         r7Ip0CTjh2ddL0IhIiaW6/v4WfiwdIgEqKDdVR+Yr7yFHQjNgU2GnkwPIMtazpylfZvU
         7JiWtxP6cQdnIK/zkXmz0pTp4kHeKwH/ZQf6kbh6t3Iejma6Y11NzKNKqLfSCQEOGVvc
         ABsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042375; x=1744647175;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLDy66M+skbjiXw8NJvCe4Orr2lfF4gig4D2dSbfbp0=;
        b=Zl30XFq+uIYj1urdxDptsYWwFzm3EAeF6aAXBl9w7mWI11fWgyjZscLili9lD2hU8P
         4LmXe1DEzvzKu6g4YLENgslFbznCKUImWOM6gNXN94A801pbr4YCEYXqjfLlnPHDRuau
         SaFUYwDaUJ3PWrN2Mlqbcn1Of6rJ/nfYTTH1EtdGUOMeKz90TPOGaAwu5/BNS2sGZ56P
         GFUZqtm1AsJSt1JwYmcm3yaDd9cu47XTRQm8SR81oVBCR4escl7VVYIPialCFiHbPbhg
         ryrxYLrxDyy6Jc3trJL+h1ffgF+ZZare9zV/lQJxw3IWv+J3AfcxyK0yar5Pq9fJVeRB
         JEwA==
X-Forwarded-Encrypted: i=1; AJvYcCUwHIai3kuvETI9CpbSRUenC0r8bFhLkL9UwjYnEDc6D4qEmrZU6rJNQ7LDtR03rkN3LM8L2iGZ+s0=@vger.kernel.org, AJvYcCXOUXHac0SoV8DdzcqGjuesAo6fTbWZkNz3nuZv3OYq5rq3OtZefNQZsTAKlnHpKV1YJzRirn+mBI7p1+wA@vger.kernel.org
X-Gm-Message-State: AOJu0YziU0k1b5pjLddaGKxLBKDD0Ay3fYW8sdjIfjZTbzVfBi37XQwM
	dBYOGiZYTOxE9GQvnY0FZk8HUXBBNYg9tC8xC+MyXZrhcaZBYQbz
X-Gm-Gg: ASbGncuoWSZuunmxuxaco6BQB3eRvwGOT/Otz31qIwix6zEbv9RPagVuHQUTzrjY/Os
	nPU+QAEqCCrrccLNNZ55XyhdapMdEO1nWs+wsqoBbC9kgSw/8LUgG/P/+z4yTFbi2zx6/jAID0y
	nD/W1zv7Jq0OEoPA9+6ZFbxfg2DoS5pe17I6unq6BqD+plp6SL47nGw+oQaYFcsSZi04Akoz2Fx
	MZP8f8vOUgk+JWIyLZqFnsD2Ylr0Wgxy3mEa9IEvZDZFshSDIf2wWwOjCUJUeDg1h170uhZvhvc
	xz7bCTN97mlbDYxq5eZIqMuLD6IMaqnr4eGx39eyMewgqqL3IQ77wtkB6nh64qUCCLHMlzbL0Vr
	HJebMbayct3gPgwUf
X-Google-Smtp-Source: AGHT+IGavjcD1KAEWkLQOWDLjtHgtYaw58xAL940PRwvs9hdMB5w+SN/KBABwEIWKBrtqylQIiLSzg==
X-Received: by 2002:a05:600c:3b94:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43f0ab8c6d2mr14232785e9.13.1744042375344;
        Mon, 07 Apr 2025 09:12:55 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226f2bsm12663765f8f.96.2025.04.07.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:12:54 -0700 (PDT)
Message-ID: <3ac77217946c26069be967065b316c63e12d626b.camel@gmail.com>
Subject: Re: [PATCH v3 3/5] iio: backend: add support for data source get
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen	 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier
 Moysan	 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 07 Apr 2025 17:12:55 +0100
In-Reply-To: <20250407-wip-bl-ad3552r-fixes-v3-3-61874065b60f@baylibre.com>
References: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
	 <20250407-wip-bl-ad3552r-fixes-v3-3-61874065b60f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-07 at 10:52 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add backend support for getting the data source used.
>=20
> The ad3552r HDL implements an internal ramp generator, so adding the
> getter to allow data source get/set by debugfs.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-backend.c | 28 +++++++++++++++++++++++++++=
+
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 5 +++++
> =C2=A02 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index
> a43c8d1bb3d0f4dda4277cac94b0ea9232c071e4..c1eb9ef9db08aec8437d0d00cf77914=
ad661
> 1b72 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -380,6 +380,34 @@ int iio_backend_data_source_set(struct iio_backend *=
back,
> unsigned int chan,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_set, "IIO_BACKEND");
> =C2=A0
> +/**
> + * iio_backend_data_source_get - Get current data source
> + * @back: Backend device
> + * @chan: Channel number
> + * @data: Pointer to receive the current source value
> + *
> + * A given backend may have different sources to stream/sync data. This
> allows
> + * to know what source is in use.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_data_source_get(struct iio_backend *back, unsigned int c=
han,
> +				enum iio_backend_data_source *data)
> +{
> +	int ret;
> +
> +	ret =3D iio_backend_op_call(back, data_source_get, chan, data);
> +	if (ret)
> +		return ret;
> +
> +	if (*data >=3D IIO_BACKEND_DATA_SOURCE_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_get, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * iio_backend_set_sampling_freq - Set channel sampling rate
> =C2=A0 * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index
> e45b7dfbec35c094942a3034fc6057a7960b9772..e59d909cb65924b4872cadd4b7e5e89=
4c13c
> 189f 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -84,6 +84,7 @@ enum iio_backend_interface_type {
> =C2=A0 * @chan_disable: Disable one channel.
> =C2=A0 * @data_format_set: Configure the data format for a specific chann=
el.
> =C2=A0 * @data_source_set: Configure the data source for a specific chann=
el.
> + * @data_source_get: Data source getter for a specific channel.
> =C2=A0 * @set_sample_rate: Configure the sampling rate for a specific cha=
nnel.
> =C2=A0 * @test_pattern_set: Configure a test pattern.
> =C2=A0 * @chan_status: Get the channel status.
> @@ -115,6 +116,8 @@ struct iio_backend_ops {
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_backend_da=
ta_fmt *data);
> =C2=A0	int (*data_source_set)(struct iio_backend *back, unsigned int chan=
,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_data_sourc=
e data);
> +	int (*data_source_get)(struct iio_backend *back, unsigned int chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_data_source *da=
ta);
> =C2=A0	int (*set_sample_rate)(struct iio_backend *back, unsigned int chan=
,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 sample_rate_hz);
> =C2=A0	int (*test_pattern_set)(struct iio_backend *back,
> @@ -176,6 +179,8 @@ int iio_backend_data_format_set(struct iio_backend *b=
ack,
> unsigned int chan,
> =C2=A0				const struct iio_backend_data_fmt *data);
> =C2=A0int iio_backend_data_source_set(struct iio_backend *back, unsigned =
int chan,
> =C2=A0				enum iio_backend_data_source data);
> +int iio_backend_data_source_get(struct iio_backend *back, unsigned int c=
han,
> +				enum iio_backend_data_source *data);
> =C2=A0int iio_backend_set_sampling_freq(struct iio_backend *back, unsigne=
d int
> chan,
> =C2=A0				=C2=A0 u64 sample_rate_hz);
> =C2=A0int iio_backend_test_pattern_set(struct iio_backend *back,

