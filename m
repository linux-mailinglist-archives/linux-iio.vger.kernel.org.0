Return-Path: <linux-iio+bounces-9663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E880E97D5CD
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8517287D35
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367613B29B;
	Fri, 20 Sep 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPWDQBKr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3834716A955;
	Fri, 20 Sep 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836657; cv=none; b=DJhs4qcqBuhjVoizY/GXqciWxW0GFRYGz42JnqNJAdNk5WpYS5idztYkBUie1kbAA7B1UuW58nHgDOB93gN3Wmqh/1agrQ9foP0TlTTP8LE8Y8uQH52yX9WmCt88CoogJ/gCI2ZZcNmgY4jB0ZkdLGFS23xTx+hmU1EFAiT4Mxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836657; c=relaxed/simple;
	bh=hAgZ+ka00T4iPgRSlHtpXqpUznTxJDKnlbc4iYIWZIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ksqaAwpQpJ+5cos6YNj2+x/qpBZwTiz6QkIuOC1sjCBy9QfQIRcULup7Ndcafh0SdSizUiOLNZ92z15/fW48Nkc5ufflBT+NatPhltYm7nUiYrwMz6ArWHAh4z1Ni/0SW6gOadM6aLeE1XdynfKZhX+2Dc8QapcH4Iaws/xwNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPWDQBKr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so4750470a12.1;
        Fri, 20 Sep 2024 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726836653; x=1727441453; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q3TNK0Ne4mj4tv9w2rjHOLXOPUridZ81HYwSt+U/uK0=;
        b=CPWDQBKrAERuQOlia4Uji9zSQdOKH10TU0TD7Xg0UGo3uC8UCBrmRtUWccoeZqHHpI
         OI8IW681OunbU4Ek75xa46qyV5w7ayvBZiUEKo5iga75S752p4tuCwkjuo8EWxROaveY
         RvfbmbHpVc2YimZUmtjniW5O7shyINovAH/s1jhntTQTj33/7Wqx4Shbut1uccinlwfG
         dFe8/3K6gDuUCImnm12d78fzJLeGge6wOjnrqvyztIooj2dKDi7h+BYPoBmOBijsEB8p
         6JwBNUwL4eEsC3gb3NXyq7uXNzofrsY2rBLQVnXCiS2WRkyvXNT1tlasr2PgTgYMPCzq
         P9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836653; x=1727441453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3TNK0Ne4mj4tv9w2rjHOLXOPUridZ81HYwSt+U/uK0=;
        b=I9GmEkac5rnVl831gu6bJogVp1lfYPJHkC8LO5sOSkH2Ocb29DJY5BQFrBf6X9Pr1I
         tT/jHRkWO/QRWzECDfPudk+PmwXHK7ShIkNPzdzDfsSDG5WDPpWTmbHuHiIm8JNecY2K
         8uxEU2BkfrTwA1ErokiHRMqGNEsXXm1oFkjl23v7k1n5xMnfhekTDk9MPEgasvD5GkXM
         E6bTEXSPkGQlQRpBsciJydQVaOEsen4yz3miK3676cofXQSp8uI8Jqkpv2CTbveuOKSz
         KgCEr4lFJxw0QQ6+bsDJdI3f7yvaHq/YPgtogf5GSqLoNmkZ/NAw+kG8e4skTxSjkCG+
         hyyA==
X-Forwarded-Encrypted: i=1; AJvYcCVE1gcbfV3tBnAgcl0JZKGEQhqIzNxyzJRs2HPSPuMSoS5lXqpkg46IAqU9QJqgnrLz9PQsX9knYXDM@vger.kernel.org, AJvYcCXD6mpZKRwCnt+a0HYxp3rGvdIg4n4yhx5X7/keINudILxlN9/5TNv4v03efvT/dLfYwEBsiH/XfsFYm2pd@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJYGsQwAxd9bgSjqHrJQD0x5qL4OPnP6c2zUhRM5Kf8kIndun
	pw2cDeI7BnGTEqDb7aYAhICuLp+3eqSRW19yHdKDND7SeQD/tU+b
X-Google-Smtp-Source: AGHT+IFaCW38zRvYTrHIZ9b7fyALnjerXHiuZoWu3eQ+kShZryyD398RG9SXF2/Jak1MdAKkSEfnAQ==
X-Received: by 2002:a17:906:dc92:b0:a8a:7884:c491 with SMTP id a640c23a62f3a-a90c1cba762mr709465866b.17.1726836653259;
        Fri, 20 Sep 2024 05:50:53 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b38bdsm845185066b.110.2024.09.20.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:50:52 -0700 (PDT)
Message-ID: <60610fe3e5885033c0a1d14db6e2f576367a2e44.camel@gmail.com>
Subject: Re: [PATCH v3 05/10] iio: backend: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Date: Fri, 20 Sep 2024 14:50:52 +0200
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-19 at 11:20 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Extend backend features with new calls needed later on this
> patchset from axi version of ad3552r.
>=20
> The follwoing calls are added:
>=20
> iio_backend_ext_sync_enable
> 	enable synchronize channels on external trigger
> iio_backend_ext_sync_disable
> 	disable synchronize channels on external trigger
> iio_backend_ddr_enable
> 	enable ddr bus transfer
> iio_backend_ddr_disable
> 	disable ddr bus transfer
> iio_backend_set_bus_mode
> 	select the type of bus, so that specific read / write
> 	operations are performed accordingly
> iio_backend_buffer_enable
> 	enable buffer
> iio_backend_buffer_disable
> 	disable buffer
> iio_backend_data_transfer_addr
> 	define the target register address where the DAC sample
> 	will be written.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/industrialio-backend.c | 111 ++++++++++++++++++++++++++=
+++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 23 ++++++++
> =C2=A02 files changed, 134 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 20b3b5212da7..f4802c422dbf 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -718,6 +718,117 @@ static int __devm_iio_backend_get(struct device *de=
v, struct
> iio_backend *back)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * iio_backend_ext_sync_enable - Enable external synchronization
> + * @back: Backend device
> + *
> + * Enable synchronization by external signal.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_ext_sync_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, ext_sync_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_ext_sync_enable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_ext_sync_disable - Disable external synchronization
> + * @back: Backend device
> + *
> + * Disable synchronization by external signal.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_ext_sync_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, ext_sync_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_ext_sync_disable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
> + * @back: Backend device
> + *
> + * Enabling DDR, data is generated by the IP at each front
> + * (raising and falling) of the bus clock signal.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_ddr_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, ddr_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_enable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate) mo=
de
> + * @back: Backend device
> + *
> + * Disabling DDR data is generated byt the IP at rising or falling front
> + * of the interface clock signal (SDR, Single Data Rate).
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_ddr_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, ddr_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_buffer_enable - Enable iio buffering
> + * @back: Backend device
> + *
> + * Enabling the buffer, buffer data is processed and sent out from the
> + * bus interface.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_buffer_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, buffer_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_enable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_buffer_disable - Disable iio buffering
> + * @back: Backend device
> + *
> + * Disabling the buffer, buffer data transfer on the bus interface
> + * is stopped.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_buffer_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, buffer_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_disable, IIO_BACKEND);
> +

IIRC, both me and Jonathan had some comments about the above 2 calls? Aren'=
t they
about buffering? I think I mentioned something about using the same buffer =
ops as
typical IIO devices use.

- Nuno S=C3=A1


