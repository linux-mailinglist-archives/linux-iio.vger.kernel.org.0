Return-Path: <linux-iio+bounces-14303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D407A0C151
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 20:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058447A2466
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 19:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6511CB9E2;
	Mon, 13 Jan 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnI3S2yD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541EC1B21BC;
	Mon, 13 Jan 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796243; cv=none; b=TMplntBtZpFR6BDc8xwmnoMcJRKnxe5D+c4Up/oB3S6y3zL209SWABrcU56dAEM4eX5NQbP86B+QevJwTOM1InSc48GwN+uRa4ETOhYC9VLceX2epPiotimvLfbOaR9Q+sMtNGSX3IV+czk2EMlOouZU/+lOVksGNGVRxuEGflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796243; c=relaxed/simple;
	bh=Umu9UrW9TO3I2erQ+JEA6A+7LHpPVBphN3aQGziCzgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqJ4LypMjQJImfvdHdeT2/zbay7PVqay7vn6woXk0PtCk3tZqDlYkzKj6C9bS69945sw0Yb8T7elpRCtQYh+07UOy4dfGuJdi6xau361dAt4vAhhjRBXFJbivOf85R5VoL+f7PO7zaObo+R4NByV0o0kT9NAzxlCw2nZuobJP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnI3S2yD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso824544466b.3;
        Mon, 13 Jan 2025 11:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736796239; x=1737401039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+2XtHqUfN0cnrDUpReiLg6E5eKQJA73ha0wU7YxT90=;
        b=KnI3S2yDcACcbv5wmbiCC0ZD5g+kKhy0+g2ozlFtJisUyU/xQg/jyUOgEIBJ54U0m7
         nMPdq/G9p3e19iKm8NLE71op1cFcTKznqlyfWjB9MrWdfE9xmdOjp2UncY14NwkgqkMn
         dGFjGRVkJ0I8ZU8wSUMruJwLVpgjxSHWpLPljU3Vf5TYsY2KvXcru5lRhuivYopVtI4V
         EB4RlEzCqUm9bi4PPShGzLr3OBdOLIDVonWibVL0/GxNpUnoJwvw7kyKFHJ7CNtbIiTB
         it7hgQlQ/UYUmsKsW24iNLmXaf8t5W8b1+BAKnXsIPKndrXiGYaqsb+FrKCyOaMCd9zY
         wapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796239; x=1737401039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+2XtHqUfN0cnrDUpReiLg6E5eKQJA73ha0wU7YxT90=;
        b=KszCbE/eUb/mX98hEkqdxB1vKRLwdCtcCAQToVExWDw5ookrY09SkD9pqr4C5Y5uRW
         UF6h+KxVqJaSURzRfIh3NHDBTu6mSDnJxzGL+MvL+KbD9TQ/K9LszTXIxftG+fA52cpN
         7jPeO1k1J7ejeoi1qE5Zd/rdcLW91Oz+ZuP8BGmHkh76JpRmMGwKoIUBiOVGSu5cj6zf
         ym8kFNBQe65D6lR7MO+2TDGjcdkncmtNugSsHMibkaH2JgA4R9qkOIWR350ayCEXhCcH
         lWMz4OS/N/9mZ0c9jdE3Nhsox/nR0ywW+OYa+zRODmpU2Wcu1fDy95xRi1X0RSqdGd0P
         m/qg==
X-Forwarded-Encrypted: i=1; AJvYcCUg/cvNtfLGgWC9RzxqhOYkNn6qNG0WWovgH/5pP/Z32Qa5Hj5PpcmhwK/OgG9uSFXy/2fz1HvIeveVVWXe@vger.kernel.org, AJvYcCXgx2sCshlxV7Vjn88XGbEEnIBgDt1A0OeaG/p0ijtWpokTiIoD8EgxtmUZygubBOnRyirkdWI7a+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwADW+loAwLLx+67lWrGizCYFNYgSH01yA+eNn4vWpNVp13iEGl
	tk7qmBsv38zEqwDaba5a3MqJhpXTvMz5oi3M9M9mFyZ/YkJbtaW7vztxwF4t9kzzlRiRS3j5NLu
	ESsW84hmj1HoyoHMZA/n0VsybbKc=
X-Gm-Gg: ASbGncv9IYxGcsn5zaG7fup0MupuSIkUqXLRPnUNT2bvhSJUjocOMLrmW+e/wTmC/gt
	9vjlHFJcXC9N3978zRZXckjXAzPTVqQVBoAk9Rg==
X-Google-Smtp-Source: AGHT+IHOeVTi+PVxrtG2LMQyClp1RbIi99BTRUiYZ5OYRxlbpC4+/1Pg/pwd+nNTcp5qBbIW820hmCuJN2NURqGF92w=
X-Received: by 2002:a17:907:3f95:b0:aa6:9b02:7fd0 with SMTP id
 a640c23a62f3a-ab2aad3f4a6mr2172149966b.0.1736796239356; Mon, 13 Jan 2025
 11:23:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113132214.36276-1-victor.duicu@microchip.com>
In-Reply-To: <20250113132214.36276-1-victor.duicu@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Jan 2025 21:23:23 +0200
X-Gm-Features: AbW1kvbmNW3BJlzGMQSiXVNCbuXym3jCA_Pkz7i3dKQ6et2FOfIHawvAA2UCS8M
Message-ID: <CAHp75VcyVsZ=Q3d0i7YWGgZms8bSokcQgDKs1U0h=RsSVxanAw@mail.gmail.com>
Subject: Re: [PATCH v1] iio: adc: pac1921: Move ACPI_FREE to cover all branches
To: victor.duicu@microchip.com
Cc: matteomartelli3@gmail.com, jic23@kernel.org, lars@metafoo.de, 
	marius.cristea@microchip.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 3:25=E2=80=AFPM <victor.duicu@microchip.com> wrote:
>
> From: Victor Duicu <victor.duicu@microchip.com>
>
> This patch moves ACPI_FREE in pac1921_match_acpi_device

ACPI_FREE()
pac1921_match_acpi_device()

> in order to cover all branches.

Do we need a Fixes tag?

...

> +       ACPI_FREE(status);
> +

Not sure if we need this blank line.

>         if (!label)
>                 return -ENOMEM;

...

Other than above, LGTM, thanks for addressing it.

--=20
With Best Regards,
Andy Shevchenko

