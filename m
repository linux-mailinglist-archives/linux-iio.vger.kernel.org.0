Return-Path: <linux-iio+bounces-23159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E8FB320B9
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815281BA8536
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502BD30BF6F;
	Fri, 22 Aug 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrvrSPn7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812E285C8C;
	Fri, 22 Aug 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881301; cv=none; b=s9RXF6UDmRby3YzDM4x2NgAFDYkL+fcZIuf3FM65E+Q8jsLFQJ5o27CsfxwwhVJV6OZBEp5x3RFO7Aviw4VUib4nD7edA/uH0hBLjRVAWNdLss/yHBU9wDMTGFIN/1TVp+HFwqN9NXQopRsl2yyAE0oQJf2BMmsmPq9ZlYrHXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881301; c=relaxed/simple;
	bh=m9/zEgxBbLFqMOjy+Vf77O/OAO1RTz6rJmG6l1hSjBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMMyrGQMO3adIH//a062vxPWnkauPquTWt7XwMI8fYrnJ2QJxjvFbSpbAKzNKdFH6Bl//m7Xyl9gWRqruHROoTwUGfbud8jrAOpAkChZlNivfem3mU2YGWXXZ6bZOrzBo2XQJrRTeE9JRM6PzDHVHAQOk5lSIoeLCPmKMb7XQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrvrSPn7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb79f659aso383732966b.2;
        Fri, 22 Aug 2025 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755881296; x=1756486096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ryekvywWpfMy8Ss+YQoqzDrE/6dWRIDmmej9hkWous=;
        b=HrvrSPn7N3RpZReWrPUBHMvPAYs8hzxHNUVkGPANTTtkejovq5NmiRSFGy9KYW8Ik2
         eG8rbgFRiViyD48KBfVjOGkrMLYI1oZh7cAK6S7GKDrMSlKXojGGVPSQM+xKROQkVb/1
         xBr5UMUTqbz4aJQWmmK4gZSdl8Nl9CcKfnV4LmUVUr3scvjGNdI8pbdLFqKEWqxR1pGe
         FF8hw4SQ8tg6l7qvl/eDkBmJbRQEei+fWEmzP3QDeMK7BkeC3lAOyGjiaBubOVJkHOyS
         hQ3SBTVuQxWUIdD7jGj+4ARoDjRQPB/yqUzLASVirxHkVURHVNVgPND2u+Jhp/4I6lkP
         UX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755881296; x=1756486096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ryekvywWpfMy8Ss+YQoqzDrE/6dWRIDmmej9hkWous=;
        b=NB0QH73Hihv9Z1Sv5i+aYkI/6yg+tEFqo3DP4cn3GRbmXSQPNizcCzUPr6Cz4X1ntF
         TmaCDriZSyjT+BPyCWZjnHJDGXN5ZtN9YYWxjVIH2hOm80L2CapeEwioVY5ujCEmVjo/
         HVHHLZsmRqKecjwkZWNhGoccdhSSztzb0bOKh2p3/tEKBnbuhEjvVyD2VKzSyBE9xb+Z
         tLPwQq2goa0dBk1fkWJeZoKRRjiH6jM1p4MQ+TR65Yux+VFQqtqZQAyxn0SAZahMhwrk
         oVGXxVx08xNzkwkuHR4R1BqUupCp795rAicN9al18pcGgeynEbvRo4qpTkGrawRU0N+6
         dWyA==
X-Forwarded-Encrypted: i=1; AJvYcCVlH4f+uXTFoF1oqxQPLMvcugbbean/nHk5qfRkuPDiuMec30AGeyaraZEEUHx8nKnBF280hI087ATs@vger.kernel.org, AJvYcCVt3obyycwfwhX1HxdIqmfNUoBb/qtPywCAbGTugaP55/bgYNQvO5gWZFE8AQAmY5j9c7bYFjj43kpz@vger.kernel.org, AJvYcCWDaOCK9EPzffCVDd16m4zHyDerf89Du1Tq9p/9x0JgH+ICv6hz1kS0g142eEzWdkGctcOvBYmMWZNKRAJ1@vger.kernel.org
X-Gm-Message-State: AOJu0YzREoOgy271jHHCAVomUuyL4pkSSTKzYb5UvIil9b9ikmfut2mn
	UhlegVG4kZIEipRsjybIpATlgk/sV0/isvqkhWUxBb22WOyX/nMeKtU8WTveANBaQWtJUK1BNTX
	5r64W+D+A5mXr7z+syhFAKnoBSG3aXwdr0+R9Uww=
X-Gm-Gg: ASbGncsKv7vC6VjB+VgOnul9lQaKPM3+s54ZOQ/ybxapOo50y+d7xNDkhczov+neDV9
	XVX64IlR6jzIpQk30FZjZcQf6t+T0PMHgQ9JscsVo6jtDgpgFjSvMpuYIamrneMx/lcSiM/zDT0
	G+ffPIDkJFozQyLJamGGXp6okuxS34MnU+EnL+VHyDFQz9kjV8ij1bAtberFHvjxWLufrXETJkq
	kq9WmC/zA==
X-Google-Smtp-Source: AGHT+IFm68yZ6GRjGnbguBBagvthdC7rt33OMmtjlajRu/zNCcj+GlG3u+QtHSQkuyPMsXuH2Y0+HkMsH6lmQ6nMsUI=
X-Received: by 2002:a17:907:7202:b0:af9:bfef:156b with SMTP id
 a640c23a62f3a-afe296a7876mr259675366b.59.1755881295464; Fri, 22 Aug 2025
 09:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
 <20250822-upstream-changes-v8-4-40bb1739e3e2@watter.com> <CAHp75VdMCY3=bL2t7zWw0D1WqtiLXrWi+ptjpaxK16b8J1KVSg@mail.gmail.com>
 <7C976B5E-781D-472B-B2C8-3AD22550E036@watter.com>
In-Reply-To: <7C976B5E-781D-472B-B2C8-3AD22550E036@watter.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Aug 2025 19:47:39 +0300
X-Gm-Features: Ac12FXyQ6joBP2nusnELrLQPneRJfO01oBOdppEm3OUW9-7VBBVAUa3Juz1iLHs
Message-ID: <CAHp75VdbfCenb+N4rY59hG1E9DL9s4ibCdQX=Ar8hT0_wi5h+Q@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] iio: mcp9600: Recognize chip id for mcp9601
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 7:07=E2=80=AFPM Ben Collins <bcollins@watter.com> w=
rote:
> > On Aug 22, 2025, at 11:57=E2=80=AFAM, Andy Shevchenko <andy.shevchenko@=
gmail.com> wrote:
> > On Fri, Aug 22, 2025 at 4:24=E2=80=AFPM Ben Collins <bcollins@watter.co=
m> wrote:

...

> >> +struct mcp9600_data {
> >> +       struct i2c_client *client;
> >> +};
> >> +
> >
> >> -struct mcp9600_data {
> >> -       struct i2c_client *client;
> >> -};
> >> -
> >
> > Seems we discussed this. And my suggestion was to defer the change to
> > when it will be needed.
>
> And my response was that it=E2=80=99s needed in 5/5 where I add the mcp96=
00_config()
> function. That function will need to be before mcp9600_channels[] in the
> IIR patch series.
>
> So either I move mcp9600_data now, or I leave it and put mcp9600_config()
> below it, and then in the IIR series I=E2=80=99ll have to move both up.
>
> Didn=E2=80=99t seem to make sense to move 30 lines of code later when I c=
an move
> 3 lines now.

TBH, I have no strong preference, I leave this to Jonathan and other review=
ers.

--=20
With Best Regards,
Andy Shevchenko

