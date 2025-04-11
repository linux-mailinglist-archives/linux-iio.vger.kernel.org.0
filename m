Return-Path: <linux-iio+bounces-17976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD4A86639
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 21:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C27174428
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 19:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6140627BF77;
	Fri, 11 Apr 2025 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm2hXpOS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B3233153;
	Fri, 11 Apr 2025 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399336; cv=none; b=tUWDE++iF9iBpNHz6Z2OM26ThPmZv7sXKBgI1b4eURd1sXvPgjuCu0R9yINsx9alVYoUrbKQvcUCocpilhaoJJappC1ktutQVR7XeLHaCn/4ORvd8FsEZNEyPCgYX8wtfdbWgX2GXwprF4ZbOpOPHrRuVPGoC5fWV2n+IPcMgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399336; c=relaxed/simple;
	bh=89S6jUFBdre4FBJDt9xv9Ve9zhB8mTXROUpU59oVJww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvz8ff3gUwnNGAtHkE7M2JepL+ZromduiL3Yu4pkKHYE99quoda+Z9ImkIVXRxULQBEwTlLPMVrSXY8hhfwLVeEoYe67rrSuf9+/bI9cW073U2KyjhY5pjGbaURq4+5yj6v1wKPYOEC6OMrXR2VhIc6PP4/VzjTPlctleIMaVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm2hXpOS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso4315339a12.2;
        Fri, 11 Apr 2025 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744399333; x=1745004133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk7Wr7mkEPmLsW55w0PzOV8/ik4aRFBmHrK0Atj+A3M=;
        b=jm2hXpOSmcg9KCrKKxCYxruXzBFQ1GbjfilgCgT+WQOp/useofOMVtWsdL+epn62P9
         PVDBwFcZI78oUYRizCMJxXPq64ah19cc3372V57TDcr3wYzGDTjw0V51ICySBDnTerK+
         H0z1MMdte7vSU8nP6IRRRB70E1U8Q9J7GXC7diEiPS5/BZ/WZ1ZsofY0AH3LBtAvZpdf
         gCb3FeMuGUJ63boTqdNprDCGfPcsufR+c8zEG0ZOOrY1QqiXhQUo0AI1UTlX1KV2xIxG
         CD6n7f9j5E9CfioR1XbwcaX1GaQLCNpZTfzcd0j/nOPqqxDh+3rVvmyMxbFi5PXoxlPR
         LDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744399333; x=1745004133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xk7Wr7mkEPmLsW55w0PzOV8/ik4aRFBmHrK0Atj+A3M=;
        b=o4pde8S8Lp0fMj20Sbqrxp22y8raDASAuTU7gcQmqAhZ2WUtO/N8COdkabmhKkJz64
         fd+q6ZJW6mvg4jJoNHqFunoi5lvB31danRYk75lM/gVw8vD/D/0b+vuqDiUizW7VwVau
         sukcx0vKB9zb5t+PCLcwFes8eqM/NuoTI5jZgot54/Bzdi7bDEVh49zsIdEnT8n0bwaf
         FdolOJYX7aHXaQE71/7H1xVgm+9jIHtCDHGaRDdMHs3dJmvrpXaKQX6dRLclp5reYFZq
         yhoBQxhLFKuW6ypRFrNwZIvjle3u1XNOsGsCSyzt2/tUfJ2zXW/DMBzlJWk6r3KL57I6
         +z7w==
X-Forwarded-Encrypted: i=1; AJvYcCUXPATKSw/Kb+sX2bMlLibaQaRtQ8KuIjnkxmparu+riW96PYcDtFZ1mmd/2Rw/ldJLmXATC9Kx8Fin@vger.kernel.org, AJvYcCVSTKjE8KQqa6AY3EgjuXV4A1v7ggi8bpee4ok8/Yr56DRm8onaIBepeKRvH5yPRBcVeEAVI3dYgGCzy37M@vger.kernel.org, AJvYcCWk9NJ3ph+3x77xBZoO+kyjDdoAGaxL96WsTUrQkM6NO7tL04MhpqAunec9RGoCXtfI3gv8cuQKKJxT@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgXDZ1IUe7h66Sz9sXcEPR7agr7GiOXaK7LPZDXwszIdawB4I
	4O9UBLNgcETHo0NosobtF67jK7PmJe/V5UReGwPoaIlbKA7CreXQjLwPXltc1CAD2gErxExR83P
	/SR3TyKIHu5Y8zAk6LCVryS8ayV5jESxU26s=
X-Gm-Gg: ASbGncv3RFlapjrEKx5vJRA0YPd4vhRqFzQgKWIdZJ8pSG+JDWg0envdgxJhv1kU1ix
	IScgC+FJRXBixX8eOzKg8MUFqO4s46fABW/YjrvGRic6Se3O4TlbMupOkszs05N3+JY1Y5PuDv7
	GVx5T3yT/uuoGTFvJUefhrww==
X-Google-Smtp-Source: AGHT+IHafh0TzT82Q1iwtIEjA7exiMMqBkorbBoifF+rPaD2kGx/h0ceVXvgMfgp0zq3ea62NLd3qNqvroIvJGLvt54=
X-Received: by 2002:a17:907:3d12:b0:ac3:17b6:737 with SMTP id
 a640c23a62f3a-acad36a465cmr370801166b.45.1744399332544; Fri, 11 Apr 2025
 12:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com> <20250411-add_newport_driver-v1-2-15082160b019@tdk.com>
In-Reply-To: <20250411-add_newport_driver-v1-2-15082160b019@tdk.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 11 Apr 2025 22:21:36 +0300
X-Gm-Features: ATxdqUGv9nEafQzbmPl55jX5Pjx8laLLf3mgfmv5IDwzcpTt7W8ptj4-S2DCF6k
Message-ID: <CAHp75Vdj81u8sXfsgBPYumFKWqsatJGHeME4rTtWM9NME6g0ZA@mail.gmail.com>
Subject: Re: [PATCH 2/8] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 4:28=E2=80=AFPM Remi Buisson via B4 Relay
<devnull+remi.buisson.tdk.com@kernel.org> wrote:
>
> From: Remi Buisson <remi.buisson@tdk.com>
>
> Add I2C driver for InvenSense ICM-456xxx devices.

...

> +/*
> + * Copyright (C) 2025 InvenSense, Inc.
> + */

One line (instead of 3), please! This will slightly help with these
rather longer files.

...

> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

Here and in the rest of the files the list of the header inclusions is
(semi-)random. You shouldn't use kernel.h and other "proxy" headers in
the code, please follow IWYU principle.

...

> +               return -ENOTSUPP;

This is wrong. Please check what other drivers return in such cases.

...

> +       regmap =3D devm_regmap_init_i2c(client, &inv_icm45600_regmap_conf=
ig);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);

err.h is missing.

...

> +/*
> + * device id table is used to identify what device can be
> + * supported by this driver

Please, respect English grammar and punctuation in all multi-line comments.

> + */

...

> +               .data =3D (void *)INV_CHIP_ICM45688P,

Just no. Please, use real pointers.

...

I'm not going to review anything else, the above already deserves a new ver=
sion.

--=20
With Best Regards,
Andy Shevchenko

