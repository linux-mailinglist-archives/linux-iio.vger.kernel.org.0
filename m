Return-Path: <linux-iio+bounces-14915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F20A25901
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A5B1651D3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D00F2040A8;
	Mon,  3 Feb 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQWOE/JJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64920127F;
	Mon,  3 Feb 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584675; cv=none; b=aUXxz5DkcLwZxAKhjSGQjnex2gpHFzsFZRHq6kHPeRd/jS7EsAJnWQwRhNB4tZVw3e8+/KfOoUV0q3O77/Il9/v093wM1YjuN/f/pSawGYtjd2b/aqoeR6Joj7W5qehkclFaJCvV/bIjLtTRDTQpjYOmq3hUZcY38Z6nEnG25FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584675; c=relaxed/simple;
	bh=QJSfw0ibffczpv3ZVDja1neQo0fo+tjFi3CxupB7wBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIZnEbg1pV37N3YU/Lf6oCZoeD2AQwyPV6J49v84CJYfvptar7H9VpkAH6pOeAT+rs1Km5KdG0bsnHZsbNUaIn/z8f1+68Tr5CO25HZPTuP4ohFlbCGLv4CTbd/IRDHYuieeaS/3U1U/9Pscja+5cuaErCLtSNbXmZityqY9vmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQWOE/JJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab6fb2940d4so618418766b.1;
        Mon, 03 Feb 2025 04:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738584672; x=1739189472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC3+WjLhlpstTgR2X3bUINeiUZ7D7J/mU9HK8P5Il04=;
        b=lQWOE/JJlcdjat++l0KrI7Dyx7R/wQPV/2zT1jb9cikcNxcklRTcJug0n57k7nYBzb
         TRJYx5gYtI4qmXIxQDzq2e9ERqiQjkOOoh+0jDqJmW5YFEHMgNBQ6xHk7KYglf/JlWVy
         LIPIVoA+ZrRsUgKkjT38MU+BCknW7m5P7i9gAMDG7bF+PTH2/u5dFUoklJTIuA1e01Cl
         vlGraL7USPLef/Eh6oQbUltSkSZQPlUP3Fyqu4GNraMbHJjxirpf5h0PC65bskxcHg3N
         RAz9ACdriWCo440OzkyQ5irTH+mOVA/sA+yGp/U53OTLY46TuxyATjPVtMnGQc9mLuT9
         skrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738584672; x=1739189472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC3+WjLhlpstTgR2X3bUINeiUZ7D7J/mU9HK8P5Il04=;
        b=Kjn4xov1Tx2b/z8j0FrayrY0rsfYewM/XnwKRPSf7XbwhN+QKPElqa5f1pop3emxlV
         2YIH8ZUWlRZKOwwuU7SjQxK9mbw2JhBAjfccjStQ82XFH7Y4nGWG0+KKJJJhz0NAUqo7
         pVU7B6ev7FDc7Z0asdL+/Fk4Fg2cSyKRAbInv39UaXhzDVkMvdlcxjd9hn0vNQW6LuFq
         VOu/ULYjCMqkAwTbkgWosY9ZZFzOAW20DOe+kxHF6JTSwjIlBioxfRy7lA4szIbidZA6
         MtqKRXDQYxvCm0iqaU8as3YZYYF3Ry7vayK2xyZ9WeOusx+FgdXvTT6cjCUr2OPhewDP
         /WUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHKGvhUbkNYcOXyRil3pLt/NsehFEQHU9BKKVhdjO+1HIgurtN3NQCrf5ZpoFrXN/sTb6j6IC+/kE4@vger.kernel.org, AJvYcCULJtjdd/pwaXRhAw11+AQA8Dn6gn5ydG6RVA6RYqh27Pc5D2jC73aWtkN4Thgz1OsdSffbcMR82yCD@vger.kernel.org, AJvYcCVHq1n+qAKqomWif3mj3YSN+3avimmx5HTQfgycna7dL3RC623xEKVClSs1UcG6+Glf+gAoE17U4XLbOU+j@vger.kernel.org, AJvYcCVnxD83y24YqZRin5danHyXj+9ZaAdXKpG0q2n77ZcQM/756cRcp88IicOMzEewP98ZY8lPSKPEx8nXz+M=@vger.kernel.org, AJvYcCX5bZSMjXbqXcUTODn4iYAijehUmuYm8b3LwvkArjKK17p5L1gRgSPX6gNv2Drh6n/xST3UFMrB@vger.kernel.org, AJvYcCXnS1Wg3y78e8t9cX1klcQiHF4Uzl93cIzBXKa79ED8554JbWAN557MW5/5Ci+vwDyBfCjjDi1wftuQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQQDkdAhX5Wt2o05tvvUYK5pckvQuVhisuP+iuIlb5fOsXluH
	iprGJBhwUJN88NX8KiGwrUNbS1TSLx/0/Tsl2KWq4rOMU5g/PZPYCzpXPzEHz8Mkwp56GLHdIeq
	YikjefmTrd7lJ8+kv7jgr0V7kbsA=
X-Gm-Gg: ASbGncv9BcF8HBd0bji2UkwCOHmpbWHAj1UexDyVcwE177AXJRP8h2Sjcx99+qRsiC1
	cXHG1/9AxubbP2xKtrzKipchDRq+TLgFuoLiktDjedopfyf8dn5gz5vPz3JJQ0zwnKpWoZJ7qNj
	4=
X-Google-Smtp-Source: AGHT+IEl0shu0wyCbYmjiWbZ8xSkp39SyMbNA10oWwjLNUg4dYl7AJ/ctOStbBTvln5XQSzLfDgbhCKUVzpxgJe5YOM=
X-Received: by 2002:a17:906:1707:b0:ab3:a18e:c8b6 with SMTP id
 a640c23a62f3a-ab6e0c3105fmr1897817666b.10.1738584671668; Mon, 03 Feb 2025
 04:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <20250131-gpio-set-array-helper-v1-2-991c8ccb4d6e@baylibre.com> <CAMuHMdVqNiquGdEs16GMTA6DPCko=TX84XWJygAorTnQk=+PUA@mail.gmail.com>
In-Reply-To: <CAMuHMdVqNiquGdEs16GMTA6DPCko=TX84XWJygAorTnQk=+PUA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 3 Feb 2025 14:10:34 +0200
X-Gm-Features: AWEUYZk_mY3onXi_-WCfb4vPsGEHZy7b021-vFp4QXXzEaG2YFkuGveLah_lXTQ
Message-ID: <CAHp75VcUiNVFktAL8zFSf-8tw_J1vJp+D_4Z-hYDqRp4S9C7ZA@mail.gmail.com>
Subject: Re: [PATCH 02/13] auxdisplay: seg-led-gpio: use gpiods_set_array_value_cansleep
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Lechner <dlechner@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 12:35=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Fri, 31 Jan 2025 at 21:24, David Lechner <dlechner@baylibre.com> wrote=
:
> > Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
> > gpiods_set_array_value_cansleep().
>   ^^^^^^
>   gpiod
>
> Am I really the first to notice you got this wrong in each and every patc=
h? ;-)

Who reads the commit messages? :-)

--=20
With Best Regards,
Andy Shevchenko

