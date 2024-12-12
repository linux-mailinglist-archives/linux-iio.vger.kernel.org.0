Return-Path: <linux-iio+bounces-13387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC539EE550
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 12:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324B6167237
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54569211A27;
	Thu, 12 Dec 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3JPsWSm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF461C1F22;
	Thu, 12 Dec 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003920; cv=none; b=fhp3DT25u4Pno0mPHgNHYd0gJHq9FOZjE9SrKpr3284GAbhuQqWWocqusvOct7D52ecvbsAskkd/lxKaCL9lu1DjP053nPEMOkO6XcKIgJ8liwvWygDDW3GGPEY6KrtOh7rLk023qYLvS4rzASYF10oddIlaEFh/ezUYEjbddRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003920; c=relaxed/simple;
	bh=fLIq/Fm07wXBtR064VLoAm6+sFFLbwqCKEEJwQHxcLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcR4dUh6FQ73PNWbj4K+dyT0aZB46Xs+kVHwUfvDm6pthIFb2q5Q3qoV8QyK6V3chpvyednIHU0ohK4l++7mVFENFL5hNp4kcn1LJKKsbB8WYd8+x6rSjk2gNo/9gz/5RhrtdvGDdZ8YuMF0Rz+6gdz5Q4cwARMeSzu9dt0ZlE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3JPsWSm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa662795ca3so325874066b.1;
        Thu, 12 Dec 2024 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734003917; x=1734608717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptjrii+7SwOKFtxCdSk87099t5j1kzGMv47Ethk1ZGU=;
        b=j3JPsWSmSkPABmu8KWRir4iYtbLhaC24hpeMTbznU/87Hx/yNuT2R4GOhaqemftg83
         mYZhzUi0AOekYZ65QptVvgIO23wRl5SgcCOT+9j7xt8RqC/fAmSchEasZ7QjUz1aBxSK
         qEhXzDn5jvd/QwXAhpQ/1Hxtmqtgmj2PqWM2B4Ke+kFR44a428Ywz+/MUPrgifcWfuTN
         1kTaeJDQChr3S3wtiGzRbAiXRoUNQ1VFywtp3SCStO3jWyc2S3cAEZkSCqZpbFnv4Jef
         mbPH9i4lFpvbtzaF7iIcsjxW52y8KUgPdwwLj8SBqaE0RfgzZTQV4H9Y2SHIaP5H15Ln
         YrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734003917; x=1734608717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptjrii+7SwOKFtxCdSk87099t5j1kzGMv47Ethk1ZGU=;
        b=XK8lECSf3lypTVeYBEtmBc69/V/SXN2FUXcOy25IzZVjbDzki8SSKld8475Do1l+Jh
         OI6DChA3C7I6YJXJV+oUmfFoJoPLgcR2TqvcS/j1y+DHVcEEi3hOfmvIX9VtoFar7vQt
         /W3sqvHSu4yGh9SmegyuqGXHBdfthg+e0lzElwaFf9XRjW5MLhVAwQkJR4YuF5UaUMBU
         2Yz5SXxled3O48I6i2NnkRGZFtXy20iuWkMXnzi4CBIt12MQVvDRUDg4bxpDXRHvpN9i
         0SKZuuscQjLyhQyaDUPG+VPCZ/95zrX2wrVl3swjiJyvPhlbOYZ2Y/DYGTE3VwjNuS3+
         Zbsg==
X-Forwarded-Encrypted: i=1; AJvYcCUcGHJYv3WiPDXb4q7gg4otWjOmh76rgpERrzLgNG68qwpHOi6IkSdCE7Zr31fh3RJXutM48sQ1rfnK@vger.kernel.org, AJvYcCX78IJzKqbp6SuexHwY0I5nb1ZwQ8Q8Y5y3Yao7jE8jUBEJGNjCe8nOg8dOMK56hWv3/OtIPX7Ik8O1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42nh0BlfDMN87GG/djRLcHgnTV3zN/XFgOBFI+LAyhdtej8oc
	7Abhy16985y/4LfLDKRH6zQ3zWjFRrp3iMlJ1sCuIE3Pp3G26UXTXC9WhArktCuNPXT9uAuisGm
	c+KUmOmMDHV7vr2woDVlmrXt3cXA=
X-Gm-Gg: ASbGncvmVSi4CJN6eqstIn8Qcz9AbywHMT5AeWEen2fSHv0Wvrwv9O3MEIAg+DJwzgf
	cuwlIPkw4yNJOiiVv7B62og9mvhlWTmsDEa1f3Q==
X-Google-Smtp-Source: AGHT+IHGnNUYjIZOxGYJMfS0ohnfX3SDYcKFlkURL2aQNBGKerxFdyXhg9w7qTxl6eAQtPw8hcFTDxx7RtErU10FTFs=
X-Received: by 2002:a17:906:c511:b0:aa6:7c36:3428 with SMTP id
 a640c23a62f3a-aa6c3ce62d4mr287241866b.0.1734003916538; Thu, 12 Dec 2024
 03:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
 <20241208124427.3b90701e@jic23-huawei> <roit3rdw6a2wv65fpq7xuullbreyz463nch2n2xmjop3b2saoe@pbhm4kahmgsj>
 <20241211192459.430fd9d3@jic23-huawei> <cfw2bybkcyzis7y2xv3xxczv7qqyk2723ccb4sqearub557orn@7nqqzeuvokmz>
In-Reply-To: <cfw2bybkcyzis7y2xv3xxczv7qqyk2723ccb4sqearub557orn@7nqqzeuvokmz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Dec 2024 13:44:40 +0200
Message-ID: <CAHp75Vd9bz5j5wzWEzmGQQby+s4HQNpm_Y_9evC9fxdWUucUnA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] iio: adc: ad7124: Various fixes
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:28=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Wed, Dec 11, 2024 at 07:24:59PM +0000, Jonathan Cameron wrote:
> > On Mon, 9 Dec 2024 10:47:29 +0100
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

...

> > A backport won't go anywhere until these are upstream.  At that point i=
f you
> > want them, feel free to suggest backporting these and provide the code =
;)
>
> I've not given up hope that you agree to backport also the rdy-gpio
> change yet. I won't invest the work without knowing it's used in the
> end. So I'll wait until the changes are upstream and you made up your
> mind. Then if the need arises, I will help.

AFAIK the process, any contributor may suggest a bacport of a few
patches if the justification is good enough, I don't understand how
Jonathan's view can be an impediment here (he may be a help, of
course).

--=20
With Best Regards,
Andy Shevchenko

