Return-Path: <linux-iio+bounces-18025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B6DA86E92
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 20:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9BD17BE7B
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFA4204C2E;
	Sat, 12 Apr 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXwS1XTk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971C1F0E2C;
	Sat, 12 Apr 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481034; cv=none; b=Xxw6wJYFtID7JcsReQ10xrm/uFP/SMpUKR7F2C8kBARFul9UY3m7kp9Oi91hya0u7JCmAHEjIQ2NJFTi+QQf/iytvJpoL2jRF4tfaxZ0K6vf0ACj8uT92Dm8CcF2o/A1wPYEnOkd1cP6lurn0G+/Dhhjen0zlG86M9Zrhgu2Ph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481034; c=relaxed/simple;
	bh=6t6uSzQuqWn4utuU4wpA8OjjjBKqZq8nRBYWbRHlkis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjmL92Is3NmfCVwNG4WC7enidnO2rl+XXk8qjcCKSAtml6m2lFxDwOcTPtK8CAIh/iwq8m/DAEx31PESyNjqz+Zmk3l47ImAUK8XS2SL3UdX0qs4sXDVI3qXSA1JT4wq7wkqr4llIo9kJ3rCosh9VV101xk3Ez3S//UtAIxdi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXwS1XTk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acacb8743a7so383443766b.1;
        Sat, 12 Apr 2025 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744481031; x=1745085831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1AfftDC7tzDqtuFpIOrA7vZQs9MHaRoHA8D6Qgf4F4=;
        b=XXwS1XTkKwnmHjeodp2KXBjXNaXMg3XZAA69FGYE9/Xd4PDwjM2e/VhpleUGj/bgP+
         i0rm1oxpWLIEfhKT0f5y+hjypM8WRVGxQvxybDx/KO1md6qPLATaP7ex/5BzzXTgxvLz
         CLYxacEav4ZFMsMmLoarsDGBheeiUCl6piZ/3dUGsIYjJ1c/vu4aF5TorjMW22eKl/nY
         v8S2fiGDq/GNFitFOwnNVvT5bsXlPTR7gHkzLZuDnSSNEGLEKVMXe+MrseJIxBXR5jZi
         7oQlRmAYOdCUiq0NfMIoKP3rWZYs2Kpcafb68JyIBsWocii99nt/VFdCVOL+FSgJnAYU
         svDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744481031; x=1745085831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1AfftDC7tzDqtuFpIOrA7vZQs9MHaRoHA8D6Qgf4F4=;
        b=OSvb4dletYYbiGlJ4NXg9Zmq0UJ//OwgT507lyPIpwmWkUEuoZZi+wkb8K7CvlS8os
         I/7oe2YC2+kWkMD547ONBamRJFbCLGKWn+IoVvokLrGVHziTyEWHNNKv2L8q4vsjPW3H
         wm1SRAVXq0lkk6b5Us0z1IbSksrXC0SMkpJuCijE0D63A3HO2RT1KbmDY+6IMJOoDte0
         Km7BSlHgj0vh/lx8ePNfdzASrcOXnGZx8p/tj3LmPr7u3BBz2YE/4h4RaqhkVktT0flN
         DEqapuPYUTXAKLOSbiwxa7lV5upKuB6SZ0g+iua6iysoyi+yqKXgmX97uC5v3tRGszKl
         hliw==
X-Forwarded-Encrypted: i=1; AJvYcCV8dQR71vzSRw2wh0zvvl+QMIeNdk8fHx4hk45vVlzXjWcOeNNSnHr4nuAmgCI8BCAlSYg3vBGdbBYWVcVd@vger.kernel.org, AJvYcCWmaRtgOr8IxR6n7kvUVL6tTUOFEDXJtoybx4CUTJBULM7Z6vf1j+WNiB85YMiO681ytb/indTzen8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cx5pHAq1/np4hl031vMcyFo4wn86XUfb1BvCQJ6oJF1XL1ed
	MTLWwIcW9VEPG+0+JgS8yAjpvK1uk9hPLKhRSyfXt6zze7FKWTYy2SjVHQ5SHPRvWlZo1OWdhTz
	LLG3P73/Ajd5qoLFCjnMchIsDAoY=
X-Gm-Gg: ASbGncvrkfbiKWZPH6VweoJHHt+/MYmKr/3q0F1XDgpg617aBtUcjmneKn+Z2oKbNVy
	9bjHvaYm+G7YphleNucfovdQIZMr8rAggM8mDPXoZVPHbZgJ8yNNkX8OyEqxrzo8zkS7sc+D0UA
	7U+iF/OMtPo0+Hh9AbBgs+uw==
X-Google-Smtp-Source: AGHT+IGYE4kTYrUEwsxdsfbYJxRBYqNpAxSqWvgBGtG8L7OmC/ghcf/6u/LpPwB3jZUJRpvDu7xsW0Pzu+bHaaLbxis=
X-Received: by 2002:a17:907:3d4f:b0:aca:b45a:7c85 with SMTP id
 a640c23a62f3a-acad17ceaf8mr564225166b.19.1744481030786; Sat, 12 Apr 2025
 11:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
 <20250409-ad3552r-fix-bus-read-v2-1-34d3b21e8ca0@baylibre.com>
 <Z_alFXGBhFxk-h0e@smile.fi.intel.com> <20250412140046.164bb4bc@jic23-huawei>
In-Reply-To: <20250412140046.164bb4bc@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Apr 2025 21:03:14 +0300
X-Gm-Features: ATxdqUGU5gIjzY5sA4qftaEHGiH3ytye2K98rdHnu3Td7yIStOP0bKait-92ORU
Message-ID: <CAHp75Vc_DjOYFCExi=h5Qd1+ACgiBzYo1Q-UHSyZVSNJOwbvXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: dac: adi-axi-dac: fix bus read
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, 
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 4:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Wed, 9 Apr 2025 19:49:25 +0300
> Andy Shevchenko <andy@kernel.org> wrote:
> > On Wed, Apr 09, 2025 at 11:16:54AM +0200, Angelo Dureghello wrote:

...

> > > +   ret =3D regmap_read_poll_timeout(st->regmap,
> > > +                           AXI_DAC_UI_STATUS_REG, ival,
> > > +                           FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival=
) =3D=3D 0,
> > > +                           10, 100 * KILO);
> >
> > It's timeout, we have special constants for that, I believe you wanted =
to have
> > USEC_PER_MSEC here.
>
> This is an odd corner case.  If we had a define for that 100 along the li=
nes
> of X_TIMEOUT_MSEC then I'd agree that using USEC_PER_MSEC makes complete =
sense.
> All we have is a bare number which has no defined units.  I'd just go wit=
h 100000 and
> not use the units.h defines at all.  They make sense when lots of zeros a=
re involved
> or for standard conversions, but to me not worth it here.

I still think it's slightly better for at least two reasons:
1) the named constant makes it easier to understand the units (esp.
for the unprepared reader who doesn't know well the kernel internal
APIs);
2) educational and similar cases when somebody will copy'n'paste
(okay, copy, paste, and modify) this with thinking that this is a good
practice, which may lead to bugs when it will be more zeroes that easy
to miscount.

I prefer the constant.

--=20
With Best Regards,
Andy Shevchenko

