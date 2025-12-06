Return-Path: <linux-iio+bounces-26839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18191CAABA7
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 18:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ADF73016DE3
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE3929D295;
	Sat,  6 Dec 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxjoWnWg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C029BDB5
	for <linux-iio@vger.kernel.org>; Sat,  6 Dec 2025 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765043754; cv=none; b=qHl3DRfnTZZNYpy5ng6l+Wit6HKwOTKU7xEDGh8al040DUE1BQDTuJXf/2QEu4ZeEsDP+Ay2DLNy/FxYNOa6pRIx/B9ENpuSTe5QQhGp6A758Uyk89SP6G2wumwE1e5F9uw5E9dRGO2LDvO9zdJLa1I4mvoEYPdRSrDVgIlKD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765043754; c=relaxed/simple;
	bh=Z02cxVuqfgpA4L3ckOXrQaQaIPpC3NDp2qooOpCtoqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBALM2iOjB/FIFvIJV+ye3QDHmaEQ+iQ7iMyRj8iO/gmgu8+qWAkjWaxVSTwEt3BYjy7CFvrWn0XTIsnh4iKB/42ZeihaTnQ0SkqX3uIQnOtSuZiOoO3yeKXeAGAjdHrc/t32exqGo4gSGjiY57aPRhS7QBznT7mQ6vgSfLFJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxjoWnWg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736d883ac4so544673766b.2
        for <linux-iio@vger.kernel.org>; Sat, 06 Dec 2025 09:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765043751; x=1765648551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLk8Tf4M4gq4CDb3hydQK0T0F2wCwNIr/xXBGPmElBo=;
        b=AxjoWnWgSGePvuz9uVDYre47qMURKm+ob61QaOY/TDglBZuUyf9rxFIAZ+mjdk3rvd
         50hiXyKZVVDHtUHLYJG68dF+uWUdKvZavhref9E1JQUrQ5UhDA0LDxtXVdTivX03MFcE
         LGC7alAF6DiAtjTseL6qRyPP2NZERLqyF4E0MlXf3VYiEtnlZ/Nm/Ksx8h4yFczgbzjL
         B/eferoa7pizw3AuctxRNtGIyGpsiz//Lw7VM0a15iEyW3TDWwhqzNpmsSYHQkywaRoO
         AodpCHYYrbUZ3BQoxmNpbpR9wGHSBVhbueNr89U+zX5/Rizle22HprKkxDY0f1OnV1BS
         vQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765043751; x=1765648551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLk8Tf4M4gq4CDb3hydQK0T0F2wCwNIr/xXBGPmElBo=;
        b=ENOIT63wsgFTsfbuRI0x3CPQ4hKAZraRC/TInb4R8yqZGlx/HbaKjEuiaP04A7HtCu
         ELwwsml6MnEtVUst9Y1apk1ny/jkKm0c6MIrwQcI2UrawoVDvVXczzr/RLghzz9ohUCb
         H/btrljY03ko9FZlsCrvSCLjHjF2RH8k/nTRZMQlf3I2fIF64lZ8RFwqlPIu0j4L5S3Z
         LeZp0Nl/biRlfGS7hxkZsV/rcIhvn6PEcCe3yS+kP90C24Lys+XnW3dDDakiccf+7KMN
         DAi/J/2138Gt9Aigsww/VbnOD0u8cZM30498j9ogfabi0VkYmBKtxra8eGgLXhLYXlaC
         U7tg==
X-Forwarded-Encrypted: i=1; AJvYcCVnBirbSg1v/nq7i7kRkWhDeD8VVaWk+CcpH1j/LKQHCuu0Yy3wlrWBoRgOi79rixKtCKMS9RjaU3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKFXNbdYfVZRnLQWeDn70lZhyWnFqhnvz+Gdit8Bw7sFEm3qvQ
	MRBHr9eOkeZBwkLq8VTZwPnM2LfvxgFDFtOwH7eTjBo1EYNQkSJo3LVIWVu+I9aNDc9QJlchgSz
	njCbUFmDHUMJjq9gH8rdWRE4n98U/3io=
X-Gm-Gg: ASbGncsGcXcsXobmg+S+RX3ldp6tCDVhkpKnmeBNGeAfjnhcLrH2/q4Q1mYwbgeVUSJ
	P3HSozaSlNSU+9fz/r2ooFMIu9p3f5WwIIydZ8MSnpCudrOrpEevW0ezLtK3OPcrMpXS8skS2bd
	+0oH/wX7YqQQWQMn4DMkosRPMfp/ZV59jmDT4GOzg2cU9/6xlR3DFPrG1G9EtC7EIwMnxrR6tjT
	R4xyIdfd0u+c1TqwXZlcxvY+06iPxT4lUCC389OzBOiPnKLBByiWnlMveSFgG0cA0/Y905CrHmA
	iEOJ925flhovHnRPjnsv5+vfEe9/3K2uTuMMp1uYqCXnDAMmC7xjCyD3+XqN7HJZlO3E8BCSkvE
	9JKCnew==
X-Google-Smtp-Source: AGHT+IHMYAPXfpmOx0zm8Ozq4s14B6iTQ3wk7I10P1ZwmL4AobXc9zWrRoIBTa2QsxhDu4ZkCLpyymZVDT0zcF15Xz4=
X-Received: by 2002:a17:907:86a5:b0:b73:7974:94d1 with SMTP id
 a640c23a62f3a-b7a2474f52cmr324312266b.36.1765043751419; Sat, 06 Dec 2025
 09:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251206132120.11059-1-rodrigo.gobbi.7@gmail.com>
In-Reply-To: <20251206132120.11059-1-rodrigo.gobbi.7@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 6 Dec 2025 19:55:15 +0200
X-Gm-Features: AQt7F2qrYDLaYlydsxVt3jKjNQ0sF_ttGfJA1b5QF9XcU6MIBXV_Muj1f1UauW8
Message-ID: <CAHp75Vc3K=w1FukPmPkuhiFDj2JgZpWeiD1b2d++a_mybZH3rg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: spear_adc: cleans up, update and sorts the
 existing includes
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 3:21=E2=80=AFPM Rodrigo Gobbi <rodrigo.gobbi.7@gmail=
.com> wrote:
>
> Remove unused includes and add what is being used (IWYU principle) and
> sort the remaining ones.

...

> +#include <linux/array_size.h>
>  #include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>

> +#include <linux/compiler_types.h>

It's rare that we include this low-level header in the driver's C
code. Usually we do include types.h. Also types.h is missing for uXX
in the code. Also types.h brings NULL definition from stddef.h and we,
for now, consider that it's guaranteed inclusion, so we don't add
stddef.h explicitly in such cases.

>  #include <linux/completion.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>

> +#include <linux/of.h>

Jonathan already said about this one.

> +#include <linux/platform_device.h>
> +#include <linux/property.h>


--=20
With Best Regards,
Andy Shevchenko

