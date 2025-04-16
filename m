Return-Path: <linux-iio+bounces-18153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934CFA8AFF2
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 08:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA11A4416F1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C223E18FDD2;
	Wed, 16 Apr 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3JoPS6J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90B17BBF;
	Wed, 16 Apr 2025 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783230; cv=none; b=n4U/4ecipx3Nd7WhQMToLJwnvnmhrNgED455t4ulMHCma3JwmE1dMlaSealkiu/4ksF4C9J9OC1PtippzjpzDepEzclDvV5lNr3xGLJFh4chh6X8dxpmOFwZh2SrHGtJNiLXR9aDVCLXDVEAXVUrD9V8kJUmZozhFelL3qXmVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783230; c=relaxed/simple;
	bh=44ClFAmCBBxnmARXjZTeLqttg2YmlsQXew1pJwmGQzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFffzg0Gal/WUbRsJ9q6m7ymVuH2SA56OynQiNqappg9XHLpt+N9fOFu7aoK4pgAfP3BsN1gFBQf6jLh3zG7Th7Apwri271CnI3VTFTUk2gK7/0pSG3MF/MhwKw29D+usE0JWKyHbrzubuuGk7gyIbVZLmg27HMV78HUgdQqK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3JoPS6J; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb415dd8faso22634866b.2;
        Tue, 15 Apr 2025 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744783227; x=1745388027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vsp+afqlaVaPaWGNEKSN03AquL3hJPS34QjJ7Hf3ZXM=;
        b=l3JoPS6JyR4rVANXr1dJbcGdK1H3HJoFOXv/Z7ruATXTAAlPPhVNn2eDJE5SZDfr49
         HR7nb10twi4M6UVMgDVNrEuqt4mP+Fg56mEm5/phS4SshhGf7vPUcJzEre6Z5B+0GWHJ
         gDvBWDEUkAiMM9uPHd5br8lFtq3EofGNRiglJ7G8Qd1yEOF0ZoWwPZOMiykSH9Qlgilf
         aUJaRZykIOKTV1DWqaRdKSq5t/Gia+X1t1SfnA5r+TkCrPlvwlM1zFawLVYkhnrfhzUW
         J5Q2oHbCN+gt2FEccGUDYbd2qFetnw9iPKc2Az0uBJaHqScKO4NuQ0gzssVQChBtXvI3
         GYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744783227; x=1745388027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vsp+afqlaVaPaWGNEKSN03AquL3hJPS34QjJ7Hf3ZXM=;
        b=FTepBlDOCHcWN/oLE+/5IIV3l8XmlOeA1XhP0s/vlP+R7wCv8HQ13OD+W06ukbQX+q
         0KltLHyYlYSaRfyx/QaPR5fJcHhvjEOD7VHV//NCNZLllNXUEQJ6b2YKSlAeU1F+Hw3i
         3Cawlvy19KLlO9FaM6AghCsdU5Ug005k4sIWyFcQUA4Dv1S7gCD39v2Ag1rlE+iv1vL6
         x5t251V8Lh1O1+y/ekGP8lGcyxyChEY95yWBdozCdlFkUt/LNMWsKfXgzdODiaZ2matF
         YWDbvwoSHekT5Srsh0iIES1jdD29/l6JyjDkgYDk/Cw5s4bEWZdiEug58WglE08c9P4P
         DXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaUp74D+NmaHEYIqUAu6gd5oxrMPRO0XQlzxMA6W0bC2aS04gNHrmakcQrYLeZZ+Xx/BdRJnyU8k0=@vger.kernel.org, AJvYcCVvy7EE0K72kBA6o6aXBj4hb+aod8u/AuIrNFnG7J+PKakfxx6tN17liCl9dDGg4DbHA6g7YC0wMgT2bGNQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMoi+6dxV3RjwS8FUwIPtgP2HKgI8e/PIJWOw9r0pvP81UcVI
	uVL2FdSw/XwNN5sU9zj+Uh4voANK9sEilN25KpUatbOwHHwCMzTW9rsGyc/4lqAlin0AKCHCcts
	vobwr948QxA8+c6RKLD+LgGsQM0o=
X-Gm-Gg: ASbGncuym0/sXdxd88ju02PQSjBdtJMW77IX/Eyl4BFQCEHtNybBBdHlpA9yqQAjaJI
	amZ/VcZPq3mPy0koPJC6na7gwyf1m3uqY2zpdwBQ3ZYTrSJu/tpjHEYNhNHYy8nlp6Mrd77Vjat
	+Oy1DsU2GM25scgF9Us+RpQch+
X-Google-Smtp-Source: AGHT+IHMIxX5rwPfS/j56rk4yypp9VTS7Bc+6LEqqRevK0DhgsS950uCCtn7jXTiQ8NES3B5JSZdSe7t549gLDA4yis=
X-Received: by 2002:a17:906:f5a9:b0:ac2:cf0b:b809 with SMTP id
 a640c23a62f3a-acb429ed4d2mr41933966b.31.1744783226864; Tue, 15 Apr 2025
 23:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
 <CAHp75VendQGLdpggySS3mX6M2YSeS70bvE8yg7sp_LNGDS-Scg@mail.gmail.com> <22858e4f-db8e-4c97-8551-a1934a9f2fe7@baylibre.com>
In-Reply-To: <22858e4f-db8e-4c97-8551-a1934a9f2fe7@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 Apr 2025 08:59:50 +0300
X-Gm-Features: ATxdqUHZcscHd7XWDApXBdkGOF8mb5GKNe59iNB0pyi1gXqy8fAD-Q03iOu1U8Y
Message-ID: <CAHp75VdKpSnwfKO4GaJmVOs8kHASsZ4V9yNcZ7EF_GVoDNmrfw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad4000: Avoid potential double data word read
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 12:22=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
> On 4/15/25 1:02 PM, Andy Shevchenko wrote:
> > On Tue, Apr 15, 2025 at 3:21=E2=80=AFPM Marcelo Schmitt
> > <marcelo.schmitt@analog.com> wrote:

...

> >>         xfers[1].rx_buf =3D &st->scan.data;
> >> -       xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.storagebits);
> >> +       xfers[1].len =3D chan->scan_type.realbits > 16 ? 4 : 2;
> >
> > But wouldn't be logical to have
> >
> >        xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.realbits);
> >
> > ?
>
> No, SPI expects 1, 2 or 4 bytes, never 3. If realbits is 18, we
> need len =3D 4.
>
> It would have to be:
>
>         xfers[1].len =3D roundup_pow_of_two(BITS_TO_BYTES(chan->scan_type=
.realbits));
>
> But that gets too long for 1 line

Actually there are a handful of drivers including SPI core that need
that helper already, I would prefer to have a helper defined in spi.h.

, so I prefer what Marcelo wrote.
>
> Maybe an idea for another day:
>
> #define SPI_LEN_FOR_BITS(bits) roundup_pow_of_two(BITS_TO_BYTES(bits))

Right, but as static inline to have stricter types.

> There are a couple of places in spi/ that could use this and several
> iio drivers.

--=20
With Best Regards,
Andy Shevchenko

