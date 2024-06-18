Return-Path: <linux-iio+bounces-6453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E26F90C722
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 12:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C411F26309
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E8152197;
	Tue, 18 Jun 2024 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MajyHx8l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACEE149C44;
	Tue, 18 Jun 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699449; cv=none; b=l8tIKgTYWVZGSOxA5yp+POZMIqMgR4Line59kjp3xph5cMaFMTVlOSBbOGcxzL6/ozvcQeWdaKG56/HGygp7L74OijXwsrcWhbkq71sf0d4fZY7Ku788VQblOniB54U/FmXtiJJvfRkHZMSf/KkBv+Ccj9lsXlu6neequOgVUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699449; c=relaxed/simple;
	bh=6FT1Od5d7MtnOn4kQe90In3Q4FHEYuebZEe5Hl7XNcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKXqDiMAw9N5E7VX4LGCn3mW1I6SiYhjg6P+K3ggHFqSpCn3ZOlM7FcUSXGWDs2LiXtPv+deQEur5p57ijW4IdpNAZtyoqh4SLB0fJuSsyyjm77uDqOmPImErcrnoJLpeNw2ccVyMCeJA0e6Xa2fnCa8LVTTpdSGHLvcV6lO7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MajyHx8l; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so2755490a12.1;
        Tue, 18 Jun 2024 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718699446; x=1719304246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6FT1Od5d7MtnOn4kQe90In3Q4FHEYuebZEe5Hl7XNcE=;
        b=MajyHx8lWDyjWqB1xHFecdJJAobLb/kLF33nL5CBVRNBsU8I91v2GIc56govwItLb4
         hjaE3zdViqrGwt+AxvibiNPznQiwHWgvEAZXVMaB2IiwDy/xJakRQw2BmRqH3BIzUte3
         l4leTqTnq+eXs8px6w+Hs+mZ9kVlx+1ivl1sxa5/gEMi8M7SPaVWowD1OH3O2u3WkorK
         tQItV+HQ0IxspYWkoJW+juFCpmBwVwvgwIIH/RhbguqyuXu3WVMwA4bBcs2nYEV5JsGC
         pVRr3NX0x422jUJCysekW11HVeynG106EyPgmkAuPZXADBlpBsM5PBWwsoKAWEBPc50W
         qvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699446; x=1719304246;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FT1Od5d7MtnOn4kQe90In3Q4FHEYuebZEe5Hl7XNcE=;
        b=A6fO4YiUdiYklc9gWOhNfjmi9aDuBKFP7/In8JLN7Vy25yMSZqtPdKCp6OwcW1SrWa
         gGUePvhPlIgWg76ynnHnLHBJJ1UAd6xB+mY2GVaX18ZiG0ASi9SF+1YWtGumcytjco02
         +CFMRmbrl5xkvgcGyvw3jg3e6gI5nx9CcgnDmKbUNL+JoNNOERk8ItneCvcgY+MCCv2n
         0ILU76O4d0FTY09bHKsoiaF3PgM6DgfftNJ1aaIbwTLplNex95HWXi9lsYmm4Y4g7Set
         RwvEvT2UQNLFg2jjYaXtQ5SXM1UCee94SXOMzT7uytTXrAx5W4AfXYt67rGcoAJJq/JO
         aK+w==
X-Forwarded-Encrypted: i=1; AJvYcCVX6AbvIdAGpHN8spcWg2tzKlSRgX3EsEYi3sFTlKoOAMv0LMz1tlS1BP72vK2D7CKr6l8wyyGbLeQlmJXH58eem8gWFF/17S6t9pgTG6IQw2FSGBjC56tAviOyrLiPsJD7Hx96PUyu
X-Gm-Message-State: AOJu0YwbalI3glXfO6cu+IbW9uXc9zLOYW1OY67chq9xWzomwlehcF3d
	RYhi8XqFdGr6/9VM6GExyTVtMZcjGZLFBhhXL+0+8t/lrQAljR4NMU9ODf6dwspzcQ==
X-Google-Smtp-Source: AGHT+IHQbE7jFMXH3wO0Z8MsAhLV7cYwJYfZ6QOolSOHUg4GJ8a3hI83WNeUtzk11P+APsDR13KWyA==
X-Received: by 2002:a50:8711:0:b0:57a:339f:1b2d with SMTP id 4fb4d7f45d1cf-57cbd673ee7mr7279502a12.5.1718699445403;
        Tue, 18 Jun 2024 01:30:45 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da6d0sm7385973a12.26.2024.06.18.01.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:30:45 -0700 (PDT)
Message-ID: <8ba6d78d2cd7f58d1d24e3c32211a8ef0d6864fc.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: adi-axi-dac: improve probe() error messaging
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Trevor Gamblin <tgamblin@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, linux-iio@vger.kernel.org,
  linux-kernel@vger.kernel.org
Date: Tue, 18 Jun 2024 10:34:34 +0200
In-Reply-To: <20240617151820.3337034-1-tgamblin@baylibre.com>
References: <20240617151820.3337034-1-tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 11:18 -0400, Trevor Gamblin wrote:
> The current error handling for calls such as devm_clk_get_enabled() in
> the adi-axi-dac probe() function means that, if a property such as
> 'clocks' (for example) is not present in the devicetree when booting a
> kernel with the driver enabled, the resulting error message will be
> vague, e.g.:
>=20
> > adi_axi_dac 44a00000.dac: probe with driver adi_axi_dac failed with err=
or -2
>=20
> Change the devm_clk_get_enabled(), devm_regmap_init_mmio(), and
> devm_iio_backend_register() checks to use dev_err_probe() with some
> context for easier debugging.
>=20
> After the change:
>=20
> > adi_axi_dac 44a00000.dac: error -ENOENT: failed to get clock
> > adi_axi_dac 44a00000.dac: probe with driver adi_axi_dac failed with err=
or -2
>=20
> Suggested-by: Nuno Sa <nuno.sa@analog.com>
> Tested-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> Added Angelo as Tested-by since he tested the patch on an internal
> setup.
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



