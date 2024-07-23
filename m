Return-Path: <linux-iio+bounces-7814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6DE939BD7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 09:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F3B282C78
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40A314AD3B;
	Tue, 23 Jul 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpYlbAGO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357842AB3;
	Tue, 23 Jul 2024 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721720465; cv=none; b=idx/ssWsIiFeuw0aYzh2e7Fwl8u/iSNW+XT3HRTD/qVBg8EuKVWK22I6ou+OToJMYgQrWPrBTEBVXZVqOu9flfxM1ydYekKzWTwksBwGo73TcZgrgdcSHB86w6EAmLNlBzqoGSgxD9ouyI2E1rWNODnbBk+HjuGkfdT7Z3EPzk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721720465; c=relaxed/simple;
	bh=80lFWu2aU5SuLLK3CqfXAqobVRHpbcPDltb6sY6jPxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qLKbU5uYpqUCq3xaf3msAOqCdnGvsmMV1+6MmQRSKpCkA60IX4lBLMhPokUG4oNfenRyNGTHi0U9sf1+exLIm252OwOH+fJr5fEPZXms9IjfF4+Vnsmz7cP0VbB1H6gEwTAiawISWHQsEVLWt19liHtlMoSjaL2E1aaxkqevsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpYlbAGO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so4644775a12.0;
        Tue, 23 Jul 2024 00:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721720462; x=1722325262; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oy9WQJkQk0A8z2TL2FvMGedujDaGcIUK+69tzorF7cQ=;
        b=FpYlbAGOK2uFLcJ0D5xdU74zkTlIgsv+q7HaKh+Is2sskbZNN5+SIXN4zszPe6nPQS
         jksD6NIisWHuGKCnDfyVEH/J58Gj+hyCVNQ+N+E+kiXNooJXmSE/EYHclxTrGzrvBezf
         +Jgi8JS4FTwFN7Qsj1W6MbSgCsWUgiMdH8yxv9bg68EVdwn2jp0IfAaLRr+/74Ij9Q18
         Yhj5DmwjGC9pDf/8yhjDZetACfS+LJ/jOXqlI2BggVFpb2AD7pBKQHIC/FQaUm5sw2o+
         BO6myVSpmYEzM0KwBSeH+DEAXnQM9lzbVrY5nbSDzOeRRGogIME5mefOMngRHLErJM2E
         Lvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721720462; x=1722325262;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oy9WQJkQk0A8z2TL2FvMGedujDaGcIUK+69tzorF7cQ=;
        b=hvqwdAOudi1AdcqZ7KSdzM1H+7piSQQBA0VdvwCSz5zIkX8cx3OjtVU9v+GImQfpWy
         hSibBOdshw3cumKW2VE6wKlSbWzki546B4dq8Oy8xnRs6H6IVFom+KSlK0lvRITwnCkw
         gwy3PF/3ojw9Ww5h2LuT0BEW7K8QMqzrj29f9KsDViKTYcAAkA4LmDTZAFqp0MCFj4vV
         s1ie2t6uq+Ju4LUo9zYL4tf+kHW/npv2xiqsNIurVHiqRhj7Kj8hdimwjhwyDdJSpC3j
         JdR2+CIUJrzrnDrzWxSNFcM6eU8TtmrBAjk4U47DInmQdiT6j5Svkb4BvM0v4YszEDRH
         mcDg==
X-Forwarded-Encrypted: i=1; AJvYcCUmPJlkfbEd7fPDWpnmojFmfxtukbDRh4Nvi7gWkUswgkSfawQ5zlxJbWFy9LSiPF6qKL+4BZ3YQZMdz9vwqkUfOt5NTzzfettAVzswb+Y9uel+jB7LvMWM8PFiN2veQXQJCb/bkln/CWCzDblOPHEVcS2RFr0qEScgcjHmQieK/AyNoHpsW8B+kNBtvdaE9vrpAHNI8lH1s+K7rDGHYw==
X-Gm-Message-State: AOJu0YxWmyICE41jmVWlyIr3xJ8FZYNoGbAeQ/2EUAPorDy1fZvoZjvB
	ksBRxpW+9bwkwZfIHAyFolGvgB9CbrW3uOYIrYHo5BGjS8ElKx0t
X-Google-Smtp-Source: AGHT+IGaExXGqEYPgYZAArl1P4fXTe5Ofei9ZZZs6/nt/IEkmlG6gI7S075gOxgSP17Yt8Az9ChpOQ==
X-Received: by 2002:a50:9e29:0:b0:5a3:a4d7:caf5 with SMTP id 4fb4d7f45d1cf-5a943ee0aacmr1369334a12.36.1721720462053;
        Tue, 23 Jul 2024 00:41:02 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a7344dd630sm3408572a12.54.2024.07.23.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 00:41:01 -0700 (PDT)
Message-ID: <ffa0e8ceea5663fa3d93664735fd867b7b5891b8.camel@gmail.com>
Subject: Re: [PATCH RFC v3 2/9] spi: add basic support for SPI offloading
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
Date: Tue, 23 Jul 2024 09:44:59 +0200
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-2-7420e45df69b@baylibre.com>
References: 
	<20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	 <20240722-dlech-mainline-spi-engine-offload-2-v3-2-7420e45df69b@baylibre.com>
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
> SPI offloading is a feature that allows the SPI controller to perform
> transfers without any CPU intervention. This is useful, e.g. for
> high-speed data acquisition.
>=20
> This patch adds the basic infrastructure to support SPI offloading. It
> introduces new callbacks that are to be implemented by controllers with
> offload capabilities.
>=20
> On SPI device probe, the standard spi-offloads devicetree property is
> parsed and passed to the controller driver to reserve the resources
> requested by the peripheral via the map_channel() callback.
>=20
> The peripheral driver can then use spi_offload_prepare() to load a SPI
> message into the offload hardware.
>=20
> If the controller supports it, this message can then be passed to the
> SPI message queue as if it was a normal message. Future patches will
> will also implement a way to use a hardware trigger to start the message
> transfers rather than going through the message queue.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v3 changes:
> * Minor changes to doc comments.
> * Changed to use phandle array for spi-offloads.
> * Changed id to string to make use of spi-offload-names.
>=20
> v2 changes:
>=20
> This is a rework of "spi: add core support for controllers with offload
> capabilities" from v1.
>=20
> The spi_offload_get() function that Nuno didn't like is gone. Instead,
> there is now a mapping callback that uses the new generic devicetree
> binding to request resources automatically when a SPI device is probed.
>=20

Given my reply to the cover you can start calling me names already :). But =
even
with that function back I think we need a more explicit provider/consumer l=
ogic.

> The spi_offload_enable/disable() functions for dealing with hardware
> triggers are deferred to a separate patch.
>=20
> This leaves adding spi_offload_prepare/unprepare() which have been
> reworked to be a bit more robust.
>=20
> In the previous review, Mark suggested that these functions should not
> be separate from the spi_[un]optimize() functions. I understand the
> reasoning behind that. However, it seems like there are two different
> kinds of things going on here. Currently, spi_optimize() only performs
> operations on the message data structures and doesn't poke any hardware.
> This makes it free to be use by any peripheral without worrying about
> tying up any hardware resources while the message is "optimized". On the
> other hand, spi_offload_prepare() is poking hardware, so we need to be
> more careful about how it is used. And in these cases, we need a way to
> specify exactly which hardware resources it should use, which it is
> currently doing with the extra ID parameter.
> ---
> =C2=A0drivers/spi/spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 123
> ++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/spi/spi.h |=C2=A0 57 ++++++++++++++++++++++
> =C2=A02 files changed, 180 insertions(+)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index d4da5464dbd0..d01b2e5c8c44 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2477,6 +2477,51 @@ static int of_spi_parse_dt(struct spi_controller *=
ctlr,
> struct spi_device *spi,
> =C2=A0	of_spi_parse_dt_cs_delay(nc, &spi->cs_hold, "spi-cs-hold-delay-ns"=
);
> =C2=A0	of_spi_parse_dt_cs_delay(nc, &spi->cs_inactive, "spi-cs-inactive-
> delay-ns");
> =C2=A0
> +	/* Offloads */
> +	rc =3D of_count_phandle_with_args(nc, "spi-offloads", "#spi-offload-
> cells");
> +	if (rc > 0) {
> +		int num_offload =3D rc;
> +
> +		if (!ctlr->offload_ops) {
> +			dev_err(&ctlr->dev, "SPI controller doesn't support
> offloading\n");
> +			return -EINVAL;
> +		}
> +
> +		for (idx =3D 0; idx < num_offload; idx++) {
> +			struct of_phandle_args args;
> +			const char *offload_name =3D NULL;
> +
> +			rc =3D of_parse_phandle_with_args(nc, "spi-offloads",
> +							"#spi-offload-cells",
> +							idx, &args);
> +			if (rc) {
> +				dev_err(&spi->dev, "Failed to parse offload
> phandle %d: %d\n",
> +					idx, rc);
> +				return rc;
> +			}
> +
> +			if (args.np !=3D ctlr->dev.of_node) {
> +				dev_err(&spi->dev, "Offload phandle %d is not
> for this SPI controller\n",
> +					idx);
> +				of_node_put(args.np);
> +				return -EINVAL;
> +			}
> +
> +			of_property_read_string_index(nc, "spi-offload-
> names",
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx, &offload_name);
> +
> +			rc =3D ctlr->offload_ops->map_channel(spi,
> offload_name,
> +							=C2=A0=C2=A0=C2=A0 args.args,
> +							=C2=A0=C2=A0=C2=A0 args.args_count);

In here, I would expect for the mapping to return something the core could =
then
directly pass into the other operations. And hence saving controllers to al=
ways
have to do a lookup in all the operations.

It seems we may need a struct spi_offload * object that can be attached to =
a
given spi_device and that can be directly passed and used by the specific
offload operations.=20

- Nuno S=C3=A1


