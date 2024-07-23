Return-Path: <linux-iio+bounces-7815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A5939BF4
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 09:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4780B21097
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31AD14BF8D;
	Tue, 23 Jul 2024 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIPwfBjH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9014B96D;
	Tue, 23 Jul 2024 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721720996; cv=none; b=K+lrc4dfXvJ8SwjERehpRBQagDTwhZ1CoN8RJE+NZ/DI/ieSheyMGp6OqtZV7JbHx48wDhDTrO7KG7r9OsU996Jj+ErlPpmHV1buZQ2ob1uo+6y6jpUHLOXPu4gqb+8zT9gTSXyYfgJro/jttdMLEwhP4gQrjWcuTYEDDRzqW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721720996; c=relaxed/simple;
	bh=OJ1Lx420+3XCr9wQXYtWQ1EfQYvMybmo8RnuHaRC5F4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n0nudkGYmpZiA3dD/9t2BA64jTmfq+RvpDLA6kwoij/idLycBW0rfofUS5wXOviM9dQfvqJ2NCIEK4S+T1xinQtlH+3HW5/bRSNBt1fsnc0jnHEseFmhBWNk80H7tf6uB+gxkft6WELzxAsvjbnSRU9mZ4rAfwJhp8M/MyTvuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIPwfBjH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77c1658c68so560185366b.0;
        Tue, 23 Jul 2024 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721720993; x=1722325793; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1IpYYMxxShf6RYVCcuCFgZb/pH86vZOBQuiBP+GbtnQ=;
        b=hIPwfBjHeCIOB5O8TlrY1Llqwn8/uEMrkqYFg1kjTfeOg2fLLAd67X9Cq4bNfCB/dQ
         dliVdAPXzjNuBNBc/Ov9WlQpnQn33sxMo5DNzfxzk+3DPLkQgvYtbOGM5Y3K0z8Vw1Ex
         wYXH+0Wec1FDBad3nsCCd7DfiTLc7h/DiN3jYvSGrG38LBx1J4VNtzRZczSv/nsrwe7M
         mQfcOYfDi2u/d1Ab5uGsM+IPWk1v1z/bKuJyRQ7ov6DuUAfo1ypZM8Ysnvtih1sEmoCI
         pWU7DBX+ipP1oL+Imi7/VF/KTjAdE3vLkz+KU7iAjxFMLBx1ePXCdf4eKJOG8mLMgqGX
         faQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721720993; x=1722325793;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1IpYYMxxShf6RYVCcuCFgZb/pH86vZOBQuiBP+GbtnQ=;
        b=uX+o6NLRrhcRn0MO1TiR7KnoqsVce7A35xLxP6BqNda/dgSXRFv8a8PRzPsrKVCzQi
         2JgOYm0KIVWpny3HY3wa1s5TqMmM+RYQ+b1gGYmThGgo//aUpvg53UQ1Jn0xLqrtOGL8
         nwxH2RX8EYox9KEkAInHXZlLJw2vQ9Wb/qqlUoieOBK5YpRGvRmrcPh7qifqitp7RNFK
         wmfRlHiDB9bimryVmVcjU3/ml5dqGidR0EFyMWnutcKqyCcEpKYoRXnDkAz/A9/S+wb+
         lumvnXQqMk9oPBQzYEcw2A5AWqQspWlKE1D0nWw8GCC4cFXJrfGHcVfSgf71Ffo4EpNx
         4eiw==
X-Forwarded-Encrypted: i=1; AJvYcCV282UuopS9sDo/VUry1X4u0gbCYDcgUyeH32v0B5w17/vhtj1I4LsrPhEeG8+sfZdKHzceDMmmWtPoCq3d7AtckVXDYkBBSW+uf5RgSMf1Y4qjgebqAArgnfu1iH93Roamv49aQWlc7w0gSeywQQ9m/8j0lEGjPlK3UKnI+pIJ8v4vi+lMvb3AJkqHZFgUZ8BJ64MRcVrBQwxS4HK8bQ==
X-Gm-Message-State: AOJu0YwDQiEsJNJrpC4AfQzDGF0PfX5bAAdWbIRqKjYX1+Vlk1jcJY5f
	xqSDR67CAOCY54dwPIyM8gMYE2q3kkoQMvxMhrERWTdc2BZiaZQA
X-Google-Smtp-Source: AGHT+IEVKxcytWZbuj8LykRy0FgifScZhpE9BEtX4YEZKRgZhhrDmjPXCFDpeMajYwqknlC0nVNSKg==
X-Received: by 2002:a17:907:9802:b0:a77:c8f8:f9d0 with SMTP id a640c23a62f3a-a7a88478687mr167355766b.44.1721720992848;
        Tue, 23 Jul 2024 00:49:52 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7b6622sm510949566b.50.2024.07.23.00.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 00:49:52 -0700 (PDT)
Message-ID: <34ff08ef8b550ff2979dc50204fad500b9bb41e3.camel@gmail.com>
Subject: Re: [PATCH RFC v3 3/9] spi: add support for hardware triggered
 offload
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Tue, 23 Jul 2024 09:53:50 +0200
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-3-7420e45df69b@baylibre.com>
References: 
	<20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	 <20240722-dlech-mainline-spi-engine-offload-2-v3-3-7420e45df69b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 16:57 -0500, David Lechner wrote:
> This extends the SPI framework to support hardware triggered offloading.
> This allows an arbitrary hardware trigger to be used to start a SPI
> transfer that was previously set up with spi_offload_prepare().
>=20
> Since the hardware trigger can happen at any time, this means the SPI
> bus must be reserved for exclusive use as long as the hardware trigger
> is enabled. Since a hardware trigger could be enabled indefinitely,
> we can't use the existing spi_bus_lock() and spi_bus_unlock() functions,
> otherwise this could cause deadlocks. So we introduce a new flag so that
> any attempt to lock or use the bus will fail with -EBUSY as long as the
> hardware trigger is enabled.
>=20
> Peripheral drivers may need to control the trigger source as well. For
> this, we introduce a new spi_offload_hw_trigger_get_clk() function that
> can be used to get a clock trigger source. This is intended for used
> by ADC drivers that will use the clock to control the sample rate.
> Additional functions to get other types of trigger sources could be
> added in the future.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> TODO: Currently, spi_bus_lock() always returns 0, so none of the callers
> check the return value. All callers will need to be updated first before
> this can be merged.
>=20
> v3 changes:
> * renamed enable/disable functions to spi_offload_hw_trigger_*mode*_...
> * added spi_offload_hw_trigger_get_clk() function
> * fixed missing EXPORT_SYMBOL_GPL
>=20
> v2 changes:
>=20
> This is split out from "spi: add core support for controllers with
> offload capabilities".
>=20
> Mark suggested that the standard SPI APIs should be aware that the
> hardware trigger is enabled. So I've added some locking for this. Nuno
> suggested that this might be overly strict though, and that we should
> let each individual controller driver decide what to do. For our use
> case though, I think we generally are going to have a single peripheral
> on the SPI bus, so this seems like a reasonable starting place anyway.
> ---

How explicitly do we want to be about returning errors? It seems that if th=
e
trigger is enabled we can't anything else on the controller/offload_engine =
so we
could very well just hold the controller lock when enabling the trigger and=
=20
release it when disabling it. Pretty much the same behavior as spi_bus_lock=
()...

...

>=20
> +
> +/**
> + * spi_offload_hw_trigger_get_clk - Get the clock for the offload trigge=
r
> + * @spi: SPI device
> + * @id: Function ID if SPI device uses more than one offload or NULL.
> + *
> + * The caller is responsible for calling clk_put() on the returned clock=
.
> + *
> + * Return: The clock for the offload trigger, or negative error code
> + */
> +static inline
> +struct clk *spi_offload_hw_trigger_get_clk(struct spi_device *spi, const=
 char
> *id)
> +{
> +	struct spi_controller *ctlr =3D spi->controller;
> +
> +	if (!ctlr->offload_ops || !ctlr->offload_ops->hw_trigger_get_clk)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	return ctlr->offload_ops->hw_trigger_get_clk(spi, id);
> +}
>=20

It would be nice if we could have some kind of spi abstraction...

- Nuno S=C3=A1

