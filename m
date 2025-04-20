Return-Path: <linux-iio+bounces-18388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC6A94900
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 21:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EC93AF99B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98342144D2;
	Sun, 20 Apr 2025 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANuzMosm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E702262A6;
	Sun, 20 Apr 2025 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177076; cv=none; b=DYHGm90HIgYyJK1RVKl0qhwAnqkcG0ls7B4siOuh+nQJ6gJfr5wQr56X6kKm7668a2ELDRgkYjA/jU4BGtHMUKmyS+vqrTnbF5L690DiqLOHEclYI1o4GzVHhpmt17k12SAp0s++KH7xLZtQWQOCFU0O3y/kDHCkQREz+iuQ6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177076; c=relaxed/simple;
	bh=+ZwG6TUds/zF9L/s4eqi8J+qsvAhJczC3oXNu+yOCgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5+4Y8JK7m2gyBFw0uJQIdQIkWsyQnVsKjirNHDr635JlZVYJoFg2EebwcPvWQfTYUPbqRw4Cg3HvTQ4rrE6M8qavp0c8k7xh0YHWKkfHGjsYBKtoc7m+VTXQ4p7f31y5aRiLSd0wUd3nBrCE59WBmzEmMWKi7W8cvh8z05Alnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANuzMosm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso354549666b.1;
        Sun, 20 Apr 2025 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745177073; x=1745781873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAb3IW2U+Y0CEoYIgTerDejZkVTNHvlFmMSCCEr/Dk8=;
        b=ANuzMosmtUwDcmR+N8exKOhx5ZpRSzf3FNmoH6Q4OFVw2Ud/Wzxtic2oFN6v/UydiI
         G4XkXefwGSb/UOAqerikzFemd7+oi/rUT/do/Pfx9cwqo5ROAfFVOmk4iIWoVcFCbKTF
         79umOo/spw6gxqYAYZSuHGEoKagbfKxbVGlQ/5dXDht1sVK05qVUFlEPurY6q7GTkJX5
         6FAOZ41UjmclRQeeVF3j35xeJvW6OToSBv1y5vlDrE9aaSKR59RueZvsLXOFx/o88A4r
         B9A/7X1394nNfkKxY8rXPSIXnolpXvE0p3SF3T2jI082XFuG+2YQtC59te6QPzvS51ck
         WvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745177073; x=1745781873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAb3IW2U+Y0CEoYIgTerDejZkVTNHvlFmMSCCEr/Dk8=;
        b=u6LQP5WgYWOrFhxhUUlviQIrpPGrslvmlKNajN0Q7qlVmiLIrM/GLr2gxk45XFtqZp
         2zyhHdeNbtApHnzAEl52LCr1F0dYgKUdNTCY544rUT9n0xxW4NQuiBph3Mhev4dIw5yf
         7pJumKFQruEBq6aNJFQExDsocQ8Vei8yXC44XeOTuA1JGTMiQDBVYIa/LzqBg/P+udrL
         kOkO9reU2/x6+oG3rfbegEZw+8ey5CnJsrfu0KOjjNIYrO+DJ64YzjVUYZGTT8UZmGrS
         6cPdXj5ytEChGYyHg/rE7XzhC+/maLAhAXoHA4mRgRV6iUb8urIeKd6zdCCcPmUpw7N6
         O+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY/3hfoFjQbau8FP8ZQ88q92aLwKHlC++c8/p7bC6QmA++2Tk6BhATzz0DoWuxvZTlydsYL/5dC8AS@vger.kernel.org, AJvYcCVzj5GLEVTnVbsYDftanvA0/x5t2osoLdW7HJhYw3p4op5+Q6/FkSQTV5x0UPmWk9t7AeymodhVMUaA@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAEr/dUX9+PUJFH3xSJlyOMIvmn6JVIxe2twWLYgMCbS8wam2
	0qM40JkGa1qGtiwVAUQrcezc/YB/V0a0TC93ySnUrskQBublWOjIIi/Qqd2PsTalo5n0ifnOzQf
	rVXpjGmF0wV5wiu89Av2yq5m9C2mZcYQn
X-Gm-Gg: ASbGncuvel+iRUKgYP4KonTf1j7H0U0BNOYA7yJR6gGqgrPEEcmH6FRI63xRFxagjoq
	FUrcqMY7LI8p+hTZVOSYWl5OT7tKpEF0RqhuRF4B8Opq6oZo3Ff03UQWQTJGAJhwF2tUPkwJsyL
	Qz3Nli+RWNwPf7+W+QDH31jA==
X-Google-Smtp-Source: AGHT+IH/tETSgsJJ15TqqBJbxinQZ77VukpTFuX5UaoPFmdF/4CFn4G1YEWQx6DqmBpRFhObs2yay4bY89EWUQiCytQ=
X-Received: by 2002:a17:906:7315:b0:ac7:d0fe:e9e4 with SMTP id
 a640c23a62f3a-acb74b2c99bmr922584266b.19.1745177073186; Sun, 20 Apr 2025
 12:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420181015.492671-1-gye976@gmail.com> <20250420181015.492671-4-gye976@gmail.com>
 <CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
In-Reply-To: <CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 20 Apr 2025 22:23:57 +0300
X-Gm-Features: ATxdqUEdISURzEmcs5ylX67eb2MGhK84k2Lb9gWkVAIdn2hNwQhrrPBI3cyvLls
Message-ID: <CAHp75VcaGqR-c23GCOKo3RLO-omtt9YgPuHmCUteAqYt6yon7Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 10:21=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Apr 20, 2025 at 9:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> =
wrote:

...

> > --- a/drivers/iio/chemical/Makefile
> > +++ b/drivers/iio/chemical/Makefile

> >  obj-$(CONFIG_SPS30_I2C) +=3D sps30_i2c.o
> >  obj-$(CONFIG_SPS30_SERIAL) +=3D sps30_serial.o
> >  obj-$(CONFIG_VZ89X)            +=3D vz89x.o
> > +obj-$(CONFIG_WINSEN_MHZ19B) +=3D mhz19b.o
>
> Preserve order.

Ah, I see it's ordered but by Kconfig, Why do you have WINSEN in the
option and no such thing in the filename? I would drop that from the
config option.

Jonathan, what do you think about this? Which order (in case of
misalignment between module name and configuration option) should be
taken?

--=20
With Best Regards,
Andy Shevchenko

