Return-Path: <linux-iio+bounces-18884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB5AAA3B44
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 00:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA2A189A478
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2F26FDAF;
	Tue, 29 Apr 2025 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn4fgxXB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4651C8630;
	Tue, 29 Apr 2025 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965016; cv=none; b=GSdaYCH02rffeNheyK5If7d26pmdFlFBuEDkaIERe9v4gP9e3f/HTKqBajclVdreXq3iNLPlTmG9xhkkH5Zg0zfEEXwR3eVZvrfqaTRExCHVs0UXRrK6uF1uR/QJDZEW5Ov+EOrjgrM5KvxdVpjlMQSUmaYr8fc8S7gvKBPHD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965016; c=relaxed/simple;
	bh=m9RrjlA+hLKSFbnlnSAcn5ppzHwNl4WuyjI9nWA63dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+2OPla559quIESVmxtc0tsqeQOkhQ19JlYQ9APkKOg+IZHoqSZ46vo1kL1nG+4Xebe1jtK5sHvAiO8ofOtoTqPGzIemVuNTziiFSDo4FP7ulk6n+qskaQMWIw7YQxJi7yYE789E0fEP+184z8gfuscqGwABD1hBEnQFwhtHkb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn4fgxXB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac25520a289so1046492066b.3;
        Tue, 29 Apr 2025 15:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745965013; x=1746569813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWE9Brl0rfnWuNnW+ftgre9u8u4eT9kBgPEjJA4544c=;
        b=Pn4fgxXBSEX7+jhcNshcLj+Cdr7Mnk1gh3VyyHxmN99Rzg018N5QWc4fkMU0Cn0WJ5
         cPAZrsMkG6oTItKaO6iaUwSU9CmAobUVriiqy8Z9tgVlIzGkeqk7SB4RMGZbRzjlSCAK
         /KWLh5GJW7uvTRSzNEf/NbKyvkGNz0gl3cGyQmAN/7j8bpLtu7krECULOhBrCgayVZMZ
         leCloVpef+3v9dlll41zl8FUT6v2GcGIUqHYDgM0HYmU502FeurwISOPctCxJ6uYOPhm
         X6vZzFvA4tVWWBRT20dUQRaQR118yGinrtxLHjbQcXmnEI43vFBITO3loqWg+KmJaE5n
         zwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745965013; x=1746569813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWE9Brl0rfnWuNnW+ftgre9u8u4eT9kBgPEjJA4544c=;
        b=nxLFHRumxMCN+C3RdiXKttq6i/9oYt1jK0LuJeK53ISyg5hm5g5EfEBfsp41zj4sGr
         rpJwmoi9YzzOaZ3aPafB3ZOMxOWFG6fb74HGdhUFLHPKbdwhiSzGhO4xwZX8TQXf90WG
         +uz23YSwNCexcub4WuccqqLwEMTKGa1HcuGuhANEfsKFq/B5wxcRpEz+7bA2avalnQDH
         ftUnJmVZVgfg2cnH7giXxezmVnWuOnIFxRg7q69i26U18ryAC9Ja4+c/CGibFymP4qSi
         rjLTpFA6Nz1WO6aGIDZ++s7SBH2sPknQVOsMlgRAJ1biIsU5avBlEpgQkN4DkXx05FPg
         4Q7A==
X-Forwarded-Encrypted: i=1; AJvYcCWv4v3dMbJTLx2+W37V9nHHHfXnfof9BlrbyZ0yUOZan76I9F1/jf9kdCaja6EiO8nEPKH6FWxdRi7PcBk/@vger.kernel.org, AJvYcCXjRjcahzLegrd/PHt7uznLBDmgIM+ctB3Vr1P/jV15KFBAN6u2glN1oaXWIdKd/arvEqgiP1o/Ld8p@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUfAvNeix8mpDFvUk7Z1NlL9VQyv4fwuicAz9wC1CBsmp/8ua
	9rsD4RikI+KNR8O63CPad5rSDKzfwKYbyr96gn+TTjoXllXRNLyfAqPendZ31wTYJBy9eqxkuaT
	DCr2hMetGQslvY/nopQVZdDpW/o8wJsr7
X-Gm-Gg: ASbGncvfYfpEo1y4CdupjLbr90iZVWGp9HPihQOcPzaXDB/iAU0oZAjqqcxN7HXeeed
	ZAz6C9UpSc4LfQ9QwrQc6mPwInWNJAXobz5NousiUyP3ZChNXbykB77wcb259yeWocdyC3YVOrF
	xVhFoYD6SksK3N/wVRD5vMzg==
X-Google-Smtp-Source: AGHT+IEb6dTbElip3EmWSrC2X4SHc8Rt6utXcnf8GLabFkhFihwLjXxB/SJlsMV7raaDAm/3PFi30D8huLEx4T1VZOw=
X-Received: by 2002:a17:907:944a:b0:ace:d442:e3a0 with SMTP id
 a640c23a62f3a-acedc6ffde9mr91026066b.39.1745965012492; Tue, 29 Apr 2025
 15:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745841276.git.marcelo.schmitt@analog.com> <c249f5c7ee07583b65cd40b0fc6f1faa79c3bfe9.1745841276.git.marcelo.schmitt@analog.com>
In-Reply-To: <c249f5c7ee07583b65cd40b0fc6f1faa79c3bfe9.1745841276.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:16:16 +0300
X-Gm-Features: ATxdqUFdJ9EegEBEA6QqF8ZxYeOXvJ-WRQFYJ3QV1-4y42J2gHYRasVrA_38ug8
Message-ID: <CAHp75VcCgcOd4z7OYm67ijpad2NjmEBOM5gMJHyWbjd2M9-hkw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] iio: adc: ad4170: Add support for internal
 temperature sensor
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:29=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> The AD4170 has an internal temperature sensor that can be read using the
> ADC. Whenever possible, configure an IIO channel to provide the chip's
> temperature.

...

> +               case IIO_TEMP:
> +                       /*
> +                        * The scale_tbl converts output codes to mV unit=
s so
> +                        * multiply by MILLI to make the factor convert t=
o =C2=B5V.
> +                        * Then, apply the temperature sensor change sens=
itivity
> +                        * of 477 =CE=BCV/K. Finally, multiply the result=
 by MILLI
> +                        * again to comply with milli degrees Celsius IIO=
 ABI.
> +                        */
> +                       *val =3D 0;
> +                       *val2 =3D DIV_ROUND_CLOSEST(chan_info->scale_tbl[=
pga][1] * MILLI,
> +                                                 477) * MILLI;

Do not wrap lines like this. Use a logical approach, i.e. the '477) *'
part should be on the previous line.

> +                       return IIO_VAL_INT_PLUS_NANO;
> +               default:
> +                       return -EINVAL;
> +               }

--=20
With Best Regards,
Andy Shevchenko

