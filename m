Return-Path: <linux-iio+bounces-7839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC6393B127
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52541B2161B
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71318158A3C;
	Wed, 24 Jul 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNFLj8G+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77906158A27;
	Wed, 24 Jul 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825948; cv=none; b=uZE6VmVfB0l9n1Jiz/mhGZe2wWJ+8VfsUOqS22Tqa/LtsuXoK/15DcWrpBxh2dFEKb/xf9R5eJm56IxxuzhfVJWWTFoUrcv4RYkURDbvRAbhr7vk1XTtwohqu04GJJ5slhqFX2HkaYI1/t5itL801+vpAf8XTvbb2NIGx/Lq/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825948; c=relaxed/simple;
	bh=JBew7+7Z4xxRoVjKFPESOvm+b6WO14dcxgTb1eev5fE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wd0gGwiMumw/jIoHJBJgRduv4WM62nfkj0jJTN/G4wn3lrZCfMLnfcCMM09cmdyNjGTChx+vZh23D0ola1naLSVPEecVuyPVz2STNJGGn4mWESl6sn+PaFTnKMqe3Gm+Lum21S+oE06mm1aDsvLJF6LFs2kkwzT9yJek6wJU+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNFLj8G+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ef95ec938so4969961e87.3;
        Wed, 24 Jul 2024 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721825944; x=1722430744; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=muSBmcOiECFvwsu9VagpVPFWhJUur+6R6QMXjMNUt4k=;
        b=RNFLj8G+TvPVYtu0dVkXa9/t81oMnup2Bx7QeTW+v1xRs5z80l3Fq+yy7HgwJfmWe9
         7QygtAddl17/5O6H0fKDxMUO0vdnxjN7lwByEwgilLeYpdsLXvAufOMEhjPdfo2z8NTg
         C7U3BhpNb21ZWISJqHM4MOtF+wfXYWbb6Tmq3l1+ZZASN4bpgpaxvI+y2ZXRUCfOznKI
         Sn+kS9oDqwDcdmAwiYnqwtkrFlHF2pk/51PHby/H2hNSHJtXJH6tOT608UZg5cMRTapf
         OTwNS49rG+UN06wJ+NT86/1+GA8QDEyjpWUFzIXtJwoQTatB3TChEOMj/y+bnNAERRDF
         5zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721825944; x=1722430744;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muSBmcOiECFvwsu9VagpVPFWhJUur+6R6QMXjMNUt4k=;
        b=r0SarPZOt3EeK00tyu/muuH2BJcKLDRyp3Ilk3wS1oQGUjRSu4VoaNogizREljnjP8
         79866NzwWA4Fa4yRCIoJRiDZq4eVAKJtyxGnquP9oS4ym7vM1H6D/G75opgTfcCOTZZZ
         niDTbc1jltXwAhng9Nm+V6u8CA8E7ft2zhjOaGbuMa4m34N1TI/p8kdMoCCxI6yEbndc
         qgYkEj9Dt8/2w/9ww3QVPUUZyazggPWqM5UXLjkTmh9vbd/bNh0iuJtx1rsfzxdX0wX7
         9yDQd7uKT8ToLnZIRrAuwWGIyyLq+3EtEAOIFwyHT0XIYEiHhWh9NyxoBpjLz5ohCiL0
         yAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWW5T8Sv5AcVqq1V6OIGM3zH7MzROT3fZBHhyTFSvV4AIR5FoRxk31ZqkU5So4leKk2ikjeq8cIM+zCmQVUjK2oz3VUaHoGfhZENQ+OdIOuL1g5wJztzzuMadm1G2PsyXucIpXLd4R4i1pGxVqFF1J5KEspqnITsfaOEVAijO+mQDEtoF5pqkfQ5vYLYU6HqvccIBwSFDLYst53icS1g==
X-Gm-Message-State: AOJu0YxUYnSxNb5g0OekwJ1Jy3a76RGxUNVcS3ZoQlu3bUuLSjKgR1wZ
	Vh0bwTf7Ds7GA5iT4glvN0vF+VYFuy7z4VWNb9PB/6ZrKdt59zGr
X-Google-Smtp-Source: AGHT+IE5sHCbBSEQ3CWuQCtIpLWEic5Mf/F10n+M1n6vIlPqvCt6BOtsAI1CEGxM9C+PCsf+TAn8BA==
X-Received: by 2002:a05:6512:a87:b0:52c:dd7d:3fd4 with SMTP id 2adb3069b0e04-52fceffd049mr1389580e87.25.1721825943143;
        Wed, 24 Jul 2024 05:59:03 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9edb0539sm158452866b.130.2024.07.24.05.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:59:02 -0700 (PDT)
Message-ID: <57a0facaec260a01dea4b8ea4d6c0a428ec54ec6.camel@gmail.com>
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
Date: Wed, 24 Jul 2024 14:59:02 +0200
In-Reply-To: <a0313f7a-39b0-4156-87f7-816e8666dea8@baylibre.com>
References: 
	<20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	 <20240722-dlech-mainline-spi-engine-offload-2-v3-3-7420e45df69b@baylibre.com>
	 <34ff08ef8b550ff2979dc50204fad500b9bb41e3.camel@gmail.com>
	 <a0313f7a-39b0-4156-87f7-816e8666dea8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-23 at 09:30 -0500, David Lechner wrote:
> On 7/23/24 2:53 AM, Nuno S=C3=A1 wrote:
> > On Mon, 2024-07-22 at 16:57 -0500, David Lechner wrote:
> > > This extends the SPI framework to support hardware triggered offloadi=
ng.
> > > This allows an arbitrary hardware trigger to be used to start a SPI
> > > transfer that was previously set up with spi_offload_prepare().
> > >=20
> > > Since the hardware trigger can happen at any time, this means the SPI
> > > bus must be reserved for exclusive use as long as the hardware trigge=
r
> > > is enabled. Since a hardware trigger could be enabled indefinitely,
> > > we can't use the existing spi_bus_lock() and spi_bus_unlock() functio=
ns,
> > > otherwise this could cause deadlocks. So we introduce a new flag so t=
hat
> > > any attempt to lock or use the bus will fail with -EBUSY as long as t=
he
> > > hardware trigger is enabled.
> > >=20
> > > Peripheral drivers may need to control the trigger source as well. Fo=
r
> > > this, we introduce a new spi_offload_hw_trigger_get_clk() function th=
at
> > > can be used to get a clock trigger source. This is intended for used
> > > by ADC drivers that will use the clock to control the sample rate.
> > > Additional functions to get other types of trigger sources could be
> > > added in the future.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >=20
> > > TODO: Currently, spi_bus_lock() always returns 0, so none of the call=
ers
> > > check the return value. All callers will need to be updated first bef=
ore
> > > this can be merged.
> > >=20
> > > v3 changes:
> > > * renamed enable/disable functions to spi_offload_hw_trigger_*mode*_.=
..
> > > * added spi_offload_hw_trigger_get_clk() function
> > > * fixed missing EXPORT_SYMBOL_GPL
> > >=20
> > > v2 changes:
> > >=20
> > > This is split out from "spi: add core support for controllers with
> > > offload capabilities".
> > >=20
> > > Mark suggested that the standard SPI APIs should be aware that the
> > > hardware trigger is enabled. So I've added some locking for this. Nun=
o
> > > suggested that this might be overly strict though, and that we should
> > > let each individual controller driver decide what to do. For our use
> > > case though, I think we generally are going to have a single peripher=
al
> > > on the SPI bus, so this seems like a reasonable starting place anyway=
.
> > > ---
> >=20
> > How explicitly do we want to be about returning errors? It seems that i=
f the
> > trigger is enabled we can't anything else on the controller/offload_eng=
ine so we
> > could very well just hold the controller lock when enabling the trigger=
 and=20
> > release it when disabling it. Pretty much the same behavior as spi_bus_=
lock()...
>=20
> The problem I see with using spi_bus_lock() in it's current form is that
> SPI offload triggers could be enabled indefinitely. So any other devices
> on the bus that tried to use the bus and take the lock would essentially
> deadlock waiting for the offload user to release the lock. This is why
> I added the -BUSY return, to avoid this deadlock.
>=20

If someone does not disable the trigger at some point that's a bug. If I un=
derstood
things correctly, even if someone tries to access the bus will get -EBUSY. =
But yeah,
arguably it's better to get a valid error rather than blocking/sleeping

> >=20
> > ...
> >=20
> > >=20
> > > +
> > > +/**
> > > + * spi_offload_hw_trigger_get_clk - Get the clock for the offload tr=
igger
> > > + * @spi: SPI device
> > > + * @id: Function ID if SPI device uses more than one offload or NULL=
.
> > > + *
> > > + * The caller is responsible for calling clk_put() on the returned c=
lock.
> > > + *
> > > + * Return: The clock for the offload trigger, or negative error code
> > > + */
> > > +static inline
> > > +struct clk *spi_offload_hw_trigger_get_clk(struct spi_device *spi, c=
onst char
> > > *id)
> > > +{
> > > +	struct spi_controller *ctlr =3D spi->controller;
> > > +
> > > +	if (!ctlr->offload_ops || !ctlr->offload_ops->hw_trigger_get_clk)
> > > +		return ERR_PTR(-EOPNOTSUPP);
> > > +
> > > +	return ctlr->offload_ops->hw_trigger_get_clk(spi, id);
> > > +}
> > >=20
> >=20
> > It would be nice if we could have some kind of spi abstraction...
>=20
> After reading your other replies, I think I understand what you mean here=
.
>=20
> Are you thinking some kind of `struct spi_offload_trigger` that could be
> any kind of trigger (clk, gpio, etc.)?
>=20

Yeah, something in that direction...

- Nuno S=C3=A1

