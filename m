Return-Path: <linux-iio+bounces-22233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0DDB19524
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 22:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC97A8065
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 20:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EF919258E;
	Sun,  3 Aug 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZsj3oNg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74384A28
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754253080; cv=none; b=YmbqADsICGvFLHcC9QO9b+8c/Ia4MjmNJfvsMl6uwaP8SXMDfQkrxI/eO55yp9RezqOIaZe4nLneA6YQ3wXSE7ilJoUD/fZ8P06jK+sVC9qtFf4zR5dHGJ+fN1ViMu9jslFx92QUwbG/PiDrIDYJpiouL7h2tioQMJbWh79Zk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754253080; c=relaxed/simple;
	bh=upMDVv6NvaOHqKV6XNd5JgoWZrAVACL3vUt9S9X9/Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9PdDy01I/zWRRwJpwNoBbuMf+WoDi90q96ot0btB6BCEWOrIei/M6RZYPysNSFKLb4SPSUcJrPllhqT4jaT5ZKeuwf2M3jPPHK1hyZWrga+rd+YsUlECwh+6oTmNw8uGbKaNrqDuwjReCcWlewDQARqdc6dk/prnMm1g423V7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZsj3oNg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso5668272a12.0
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754253077; x=1754857877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdjXejKvsrZR/Y5nOFrcXs1YCZy5pHGi6vE6FYRTFO4=;
        b=CZsj3oNg9aZUXLw3/Ndyo97vGqp2jVZcI2/yglpLaTUHvst2PMwLaWGGlmYJUuG6bV
         YZmcum+VTo6W7U0Cmta3f8eCSPtiLviB3hdj2kugH0BA13zurXlYsV6xydFj1gZ5X8m9
         FThWsXphDJxNEPREazzpdiV7GAUh8U5ejJbcSMlG+rb+Wxb5zUSu4l4rmgUqsFHS/sqB
         KTiNbNQ8Q9pICAvKwhgDm8IhY/JR7A5d6JGnzGRAyA2P8p7I9GqQ/jZqiUezCbMOKZ/e
         TWbAO85UkAgSIJZmyGyvL9PVnzH8ON4DJCHAFzwgfpmhqK63ENy7wklX7tWsCtisjT6E
         +0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754253077; x=1754857877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdjXejKvsrZR/Y5nOFrcXs1YCZy5pHGi6vE6FYRTFO4=;
        b=kPrl2o4wusW/GjCDoev0boRks8w2ll8EUvncKRz3SY4JOFNsFN6C1JmQ3fukq/d+EI
         TqopjhgXZ4P/boZUovgvhN0dL3QvwPwGfLdnuYCZCrKThkqYXQw7VbxXDCoa+tJeswWl
         Reildls+U50KwSM+4SYDvlLn8A2ujquKO8iErU/PPby9cmcVZ0Guwyi3qifksaIu9nri
         xmh+mVxxTOe7foEK2jPe0Oy5MrhwTGpm6I2e99Qupxe2eA4afGOvetD5dKK4XpMObav8
         gWJsfgrktxes1sJ7mRWmin6BE35oW2Fpk6+k0So7erZ4DTK7Z9Wo0NaIJGKAJwBwPSHB
         85Qw==
X-Gm-Message-State: AOJu0Yxl172zjt3uOdxCGN0O1s4J71goGFQel1NmC9BQRGPITpRXvyqZ
	VastOezsmnBJmd0bDoOlWw26s4nAZDa/309buNDXBjR6i0ZQH9ZXGz0RfHYm1V8r9Nu+Vpm1Fam
	LpuES/ENc3fED7yDpYS1l/Bp6o2rEUJc=
X-Gm-Gg: ASbGncslqEhs/mcXaf22k1JLQ1i4KXbFJWP/lMCBwICd8/YIH5t02VhQRuRWg4m8MwY
	+O0PFgfV0EyLcEdEs2X2KxkrjOh0/P5gK2tPvLHS5x7oOtmcLM5yYw13KAhPn4hrHKO3NQMvp2a
	4KgW7gPGeTWs/Bh4XDRMNKk/NDXB0Xq8aBPOwcMJ9oHARVciUmIku3mcYSS7CY1d8Uez79bBBtm
	N+5jjvvhZefOLLRis7gOoMN5D1fCtf60o3rQm1qmw==
X-Google-Smtp-Source: AGHT+IHyAMr0WqgTaFekhBw4JRgGM6Zq4IyctSqfhGVEFleMUjY+qhtGL50W6M5b5F6Gajxo2Fe2omNrS551ex7Hby0=
X-Received: by 2002:a17:906:6a1b:b0:ae0:c690:1bed with SMTP id
 a640c23a62f3a-af94021ca5fmr477309366b.51.1754253077000; Sun, 03 Aug 2025
 13:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250803140802.36888-1-Achim.Gratz@Stromeko.DE> <20250803140802.36888-6-Achim.Gratz@Stromeko.DE>
In-Reply-To: <20250803140802.36888-6-Achim.Gratz@Stromeko.DE>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 22:30:40 +0200
X-Gm-Features: Ac12FXwBANcLhPtGbHx1FGc7a8lIr87e-arAZ7jmyKrLvtdXzamSUfFkb-8DTfg
Message-ID: <CAHp75VdL2ZDYAU+Ho2-mDoxbewEc4GzTxg5LE+kDM+ZPh-JXkA@mail.gmail.com>
Subject: Re: [bmp280 v1 5/6] iio: pressure: bmp280: remove code duplication
To: Achim Gratz <Achim.Gratz@stromeko.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 4:09=E2=80=AFPM Achim Gratz <Achim.Gratz@stromeko.de=
> wrote:
>
> Refactor to get rid of duplicated code.

Maybe this patch should be somewhere earlier in the series?

...

> +       int raw =3D 0;

Why integer and especially why _signed_ integer?


--=20
With Best Regards,
Andy Shevchenko

