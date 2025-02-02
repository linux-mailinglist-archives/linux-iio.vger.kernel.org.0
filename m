Return-Path: <linux-iio+bounces-14858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B732A24D92
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 11:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1595163E50
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B671D63D3;
	Sun,  2 Feb 2025 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAWlHutB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C77111AD;
	Sun,  2 Feb 2025 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738491931; cv=none; b=Ie521BGiXsu2EsjO51OduW8HTA07BxxUL4j/UGEGQ9i/pxerzdJKf4zU5QlZRoz+bhvd2HdQISPBFTjfJM1+bDp0OWhgF42KlDXZY1XfLLa389OwRHkj65AjA/xknYWQPn86+3PHbeegzEXSImc2nB/ULVyO7i9imuiyD2sTOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738491931; c=relaxed/simple;
	bh=1b1/w9IendxT0jgiUfXbAscOuqznDbGsGPD6elKdfU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuoUBCkm6jbZARScpqDYniztPucTRrwlhnbCP7fVb8WRe5KctcpGEXzaZxVg/gUo+MxkiV5vBFfe3lX+zoBoPG8eyHMOYyOncFzQFpzfKzXdXB0ohCnHNGgHq6379KpN9wd68A3yjxFRVBa2jXP2fabpeNMdG4uWYrzp3sN8XEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAWlHutB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab34a170526so540739466b.0;
        Sun, 02 Feb 2025 02:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738491928; x=1739096728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdlPHcGzMZa0B21D7l1gQYa9EwUPuFt0Vh35VUcb6gI=;
        b=FAWlHutBqC8EXj3KJ+rgclgG+O2P7/zM868eSEsvuJcju3Thxx2s+pULTF1UM4qvTY
         tctRb3R/e0paVOFC5wnxEcdouuSQXAwcRN1jCXKNInNvmIGd31FGXw6Zs/4KgDnsB0Yf
         qQ6KdxYgqwl/0Y54WePjnzjDrxWLIZk0e6YeF82b3dQoz3Rkxl6jAZFkj6E+WXJS0Tdn
         CAWVeDJjmB1z/LCAn3jDbAbt5Pqkn9GW9ra+Tv6BLRBl5vRWWnKB+xebBpR+Es/7XX78
         44LYnmnCIf+C03cA4xAWF2OXkDupwWiCPDwhn6Wh3ehKkujKOenL23kDfGRT7HqK0ll3
         S1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738491928; x=1739096728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdlPHcGzMZa0B21D7l1gQYa9EwUPuFt0Vh35VUcb6gI=;
        b=pPO8KCG6449FB+1vn/q+N4C42xlmwdZEBsDxxe+ECkhttJw9QZ2r0EL1B6iy+MmK4a
         JcPbMlhJwursgyaTgfIgBMYS9JoNugHIRPVC6Gdxy4SIoNK6AxjzIVHATQpOI+i7qGs/
         gf8krtlV3x4hdy9bNnSL5jPw1qfxL0vFrHPmq+alc4xpgKZbxs89w6vgYI3ipJCfyKQY
         +lMDRqcSXgwjBNvJ12BTKm7bbeE92k4estqlY4ZdWlVNr+k+Yxm0PBQusn/6tiurlkBd
         Hu8QvNR1nvtu+CjJD3c5FNQ2L6M9fwdQ33u/PH38fFTi5To78270d+XezuaoCk4nmhNl
         RW1w==
X-Forwarded-Encrypted: i=1; AJvYcCUH05v4hBCSo/hpWTchd9BvdSHGqZuBmd6ByVa9paTNZPf9FYc1suXvIO48eNQ5FKyzsD4r0DN7EzJO@vger.kernel.org, AJvYcCVBl7DfgcILWMlv392ezzH77Enwq2qt4gfzxAG/K1X4IkXNq/Jv/v+S7bOJmSlU7qCknTQUeRLneBHn@vger.kernel.org, AJvYcCVJPnZhwOciBR1tJGQS/cje5xz3nTT4DkaWvczz2TCrwXzRgySg36in95ZJ8zeUEfGF3nQi10w2Oagzsdk=@vger.kernel.org, AJvYcCVTZK4XiJ39D+ztbfMYAQXsrenkhyc5cDW9L0o/CVGApFpi4Z3KbzeYOAWw0V5YU4VbGwnWRHxiEOAV@vger.kernel.org, AJvYcCWmEco0YujFAeLRZBoWLQ/Fx6QRRxBqZjFpdaIBEqkig6gy+JULmW1PwHj9GTT1aLrJLzBy8sajxMRcZjae@vger.kernel.org, AJvYcCX8oTRQTMOepAkGY/J9H8vAeCUXY1Y0aRmOJfrDNLCIOPEa0vYDT8hNqy1CvCkc4hFT32onNi4D@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Km4JaDC1VQT3xDJWvwpocsr+ICpvTV10+ouyY6sXW17bPD4L
	gZEeevD+XDQY/srDxcsv1dHakzDRZUvTiu61Rvtt+VEDmfklQgLlCLZw8kWPoRwi185hLhgnSZd
	Um6wzxMeXa6u3epzjjGYbOxPSaMs=
X-Gm-Gg: ASbGncsSYdUK/EvO8d0i7um1hFVGcIQkXa8JKNBOQnL0EYy1t4qRE0nW9f2jNDc3xrA
	kFPal9p7GhMbo2iofhsgV38eqrxqVYpeesh9e11h0wFl5BSQ9UfjDmWEu6FnVt9MyrfkzvzPX
X-Google-Smtp-Source: AGHT+IEe8Rl+26kJYboaEyv9dzKjHCf1EquLTFTNEmfRhSj6NS9YUXAt18BK9166iZzYwlVFITDfnfsB89tlBK0RZx0=
X-Received: by 2002:a17:907:3d8d:b0:ab2:c208:732d with SMTP id
 a640c23a62f3a-ab6cfdbc500mr2040178166b.40.1738491928328; Sun, 02 Feb 2025
 02:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com> <20250131-gpio-set-array-helper-v1-13-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-13-991c8ccb4d6e@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Feb 2025 12:24:52 +0200
X-Gm-Features: AWEUYZmb_RiThc9nFDP5Gjh9f1xghmR68DNS7zeGbd5iSayr1cQhK5HkwKbJyC0
Message-ID: <CAHp75Vd_ZUqBhQGKzc6qCHrrUUHzFqyaxTz_vdSKN5EK-bazQw@mail.gmail.com>
Subject: Re: [PATCH 13/13] ASoC: adau1701: use gpiods_set_array_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 10:25=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
> gpiods_set_array_value_cansleep().

...

>                         __assign_bit(1, values, 1);

Seems like an interesting way to say __set_bit().

--=20
With Best Regards,
Andy Shevchenko

