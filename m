Return-Path: <linux-iio+bounces-26992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C51BCB2C07
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 12:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33E4230069B3
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C032255D;
	Wed, 10 Dec 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edNWy3IV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288C320CA2
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364424; cv=none; b=R4HX/jLhG4aS/nrRRAcrQ0xZY8Uz2oVtahMxLQzjWVLQ2+yoFw2UeZBxCyZiasbeTVgtPyIq8m91C4Yu6NrskgxDTlcMpz9QBXVUCKbXCcKFqPm93TE2unlMb3Vmm9eTfO1u6/T0hRP7LCZxauH+RMxWBr14VNQVqz4bvTYovJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364424; c=relaxed/simple;
	bh=NyL9C4Q7nKA3xVfg/2QpoLWEPS5+KcYWdViAB5mP6vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVtA/iaUarQIDVJagkSNcHZKJCqwPYj9FXWelgthYJxjHvTz3EI+Jl1bUCqax8hrpG7tbtnxJTuJzF/rPgqpq1WmkPUhr7fRfaICx+MH4SAE63RnIOPeojU3gQAqkNffT+zZj0171dNh3ppSpZLelGi7zl+92O4bv29Hp633sVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edNWy3IV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7bd8b170e0so149854366b.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 03:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765364420; x=1765969220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDGP1HvpfMkO5vmj5IH/U7W1oBMmvxtv1IG7s407g+g=;
        b=edNWy3IVPXPM3zU0wC+OKVwWWtCTa1/IJXbpNDirrBoxMb1Kt2PYezGogg60Nb4H48
         PNN2mdxCWesb+nHbV1TzU6cgTEGqJo/qrm6Ekcq07K07hFTxVr+6eaKUu8Bylg3+fAmz
         1oN9yTrdBF0RO9JYEIP/THEMF1S+8Uuv/46QIdJWrm8h1qeoJ00tNOvniBGU8SIHzwox
         42Bm4ElYEWIxIM0nCghOqgv6WadJKqRKbBUo2ZifquI0MkUyW61LTblN3tevhRHosZXM
         iUsVzx+1tSulRHxFTe2T/7naVYZl9E9HbRt64W7UCQTqsD15n/y8ufuj2rydaJie9HaO
         e2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765364420; x=1765969220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iDGP1HvpfMkO5vmj5IH/U7W1oBMmvxtv1IG7s407g+g=;
        b=qdTKdd8ARSdA5In8CASVHopVk0CybZeXUS3yIYA36QqTsyxwpQvp33Uy5BYnqd1jKW
         qsGpCyyTvX9eVrOWKrU4h4f76VN/jMcOWw7x0pvD+PTfXqrQNh0PFGU0aFnNrbcTQc9S
         KXnJh6HuFIZfvU7uwCsRgT754uj+rImaYfvXNuK/DxKpECgAd3aedDygODM6isbra3st
         4Of9tltU2Y95b00GzV0XxUV+3iAxhg27VGdczAgR5DTwFRYPBw8/mvDGm5zQANzsetFi
         kY++Ay2hrp6dR6dgmN+Lh6CENLPh75ZUZf6KVMccHwY9Gq+un43zskmLhGqspVvZsHpQ
         HzGg==
X-Forwarded-Encrypted: i=1; AJvYcCXEbEapMd3/zOZZ5yug6XNVWyoA9p8Zwx1i7ATS3g1yh8ibNmXVoKFav6LWRHvra7JHtEOY+pCGIB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1du+BTkNMNvNLi+ivX4t2jW2fnIUPBIZfI5WdVYJJZQkmihF
	tMWcLniIpTJEtrgmWXeJJNMBMCXDg7EcY9y0nNIypDTd4znFLOXFkkvCSST7fMfq2B/THxzPxew
	VG3Qwv02eIBVNGDrwGHMFOTIL3ALDwuA=
X-Gm-Gg: AY/fxX4mEzMzy3xynf2m3uwhT/+TrjOl466ndxkOkg75VIZhGgrdustNi/0qqD5SMd0
	OAcBqA+VOaGlfumKwuiM0RlMIDs9pcUz83fQd542HNDxqqX6tfBjMJCpwYYYznqvHOwJGyhtO+B
	PUkZ2iot/wWD7GJ3dQIliOOP8AxO2IPzYyXqGJe/QVzlPUuqaqt3oOIpgGBmKYTOEsoUpquhP1g
	E9nxxDg6NSZCEUvdaUg7BnkJDGOs4W9mL5Sa9Z8vdlHpArt7Zm35DQamSQ3D0cgSfceQA+Z6wMb
	bR47QcGVrr8Qln98HbkL1zn/Z3Yy8lJOpg5VlBUu0MkPmQcyRFSSwMzQsMORS8O+O+zPm4apYbc
	k2flsjGg=
X-Google-Smtp-Source: AGHT+IFw5sv5HXkXEMI2iheFRxQ9CQIewk40C9/tFhkHDACVndFWuGjn2muHwTeRVZoGxiPmcZt+1g/gDVd6sRshhE4=
X-Received: by 2002:a17:907:3da7:b0:b73:8d2e:2d38 with SMTP id
 a640c23a62f3a-b7ce8427b94mr209542666b.50.1765364419760; Wed, 10 Dec 2025
 03:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-4-34e05791de83@baylibre.com>
 <aS79ex5Konr_EeMA@smile.fi.intel.com> <2aca99a6-9541-4cd4-933e-815ceaabe365@baylibre.com>
In-Reply-To: <2aca99a6-9541-4cd4-933e-815ceaabe365@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Dec 2025 12:59:43 +0200
X-Gm-Features: AQt7F2oyHJ70Ni3PdQ_hcep-LsJmXx61VP_xsyFV78eFuHodczdlUa0PKwRFL7A
Message-ID: <CAHp75VeC1VePFHr9y+5spkyGh3viwu1vwdd+jRcDzyZJq_W1Fg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 2:02=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 12/2/25 8:53 AM, Andy Shevchenko wrote:
> > On Mon, Dec 01, 2025 at 08:20:42PM -0600, David Lechner wrote:

...

> >> +static u8 spi_engine_all_lane_flags(struct spi_device *spi)
> >> +{
> >> +    u8 flags =3D 0;
> >
> >> +    int i;
> >
> > Why signed?
>
> Because it is conventional.

I would expect the variable to be the same or close enough to the one
that defines the limit.

> >> +    for (i =3D 0; i < spi->num_data_lanes; i++)
> >> +            flags |=3D BIT(spi->data_lanes[i]);
> >> +
> >> +    return flags;
> >> +}

...

> >>      version =3D readl(spi_engine->base + ADI_AXI_REG_VERSION);
> >> -    if (ADI_AXI_PCORE_VER_MAJOR(version) !=3D 1) {
> >> +    if (ADI_AXI_PCORE_VER_MAJOR(version) > 2) {
> >
> > But this includes v0 as well!
>
> I think it is OK. There was never a version 0 released, nor
> is one expected.

Perhaps a note in the commit message?

> >>      }

--=20
With Best Regards,
Andy Shevchenko

