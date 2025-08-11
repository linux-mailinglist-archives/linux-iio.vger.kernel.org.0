Return-Path: <linux-iio+bounces-22564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC316B20838
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 13:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A00E7A4501
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6D2D29C6;
	Mon, 11 Aug 2025 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALhyrOvZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71E21D3E6
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913240; cv=none; b=WlPFIYk5MQVx1EZ3hfNqnIlJUA7AH9IDefSiHyTyPq5U/Kak3NvmdoIgSNkWqvWxflFBLjBKJjbjy2leJf7cu1PFAYqDchRYTQO3kIYDgUXSicRlGGDnUAZAtcWvQFvAePy0gI7cDqYjOvGi3h5/x2BwdL7E+SDQRyQGVilsNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913240; c=relaxed/simple;
	bh=vTcVajWZSwWJAW4aC+2CIlen/+PKnf8e1kdvcsRlZn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=df2aJhyvuoXi/FvaCYHCb2MoCPtFR+DJT8YyPDYRn066OITJv/3HnU82SQtzHCI7aHtzGtF4kNOACZCBkLAtVlNvYF2QyhbA0W71A7q4LAIPKbuTQJB0HustatGZz4/h6am+Gw7IB0fZOFflev971JZ5K+TG78WVrJl9gb49EQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALhyrOvZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af949bdf36cso674802266b.0
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754913237; x=1755518037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84q/Xk0mDJYqnl19VrH9YlNpD9nrRtfnSD0rO+JesEk=;
        b=ALhyrOvZR74Z8Yktj1mwmQpaM4jEfDehnUxDEFMJlGdusJ8mgDHJgUxd6+4ePnqKql
         t8CY0LalXAb5kT4ypAG0738krrrdKjKLx2MOwBktKVANlFvmAOz1Eu/khM8qNbiRrUoU
         GhgqnrJ4zg+QJ0Fy/MBoLIb6smTXO4IHywh8SgEuYpymBybKENmdOp9IYOXYcafMZbIZ
         CVgWlLjVFAg07Zp/mD3sVLAgfx8nwhlqE8B8Zil8uwRKlz/uWQeb9CXr9nGPLAvSFZqK
         nXXR+rFoCkMekBvsdr7hvgaQDs1NgF2OK5Pk7hefovh66bIPel2Hq1HyZ5In68Tk3nxq
         VH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754913237; x=1755518037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84q/Xk0mDJYqnl19VrH9YlNpD9nrRtfnSD0rO+JesEk=;
        b=cSCf58eDQsh5DtRAbWKtbNUlBZzejPip4psXQZSs/mUZBlmMUqxCQWy3+gm7oKn+2A
         ccSAiNoDZeAgvJA3jDHv+Bu6ZxFf34EkNQaVOw4AMAOMIuqxvp24L+yPoywqE+CybkRo
         nJPHvdAgoYxrzoxJbyyHn5L/8C9UEbw+8zCkO3pRzekzRElB2S82AhVLOTgZVBTqQjy4
         JFdWDKoKL90ANkNCSo8Wejlr0HO/b/Y151UnfFiT9E0q3UTt3S5iPOttIyDy+lf6tHOf
         p97qs6mnlUu8pnmjWH3hwgO0Jvuz0ymoHYj0IE1Vp2xgyQK+qtJIIOQU0rEy2ze/xFo1
         iYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqS5kZ5X3MChd4ylA8ttKinh2v5v4L3+iIAsDX3/aTMYjUpMgM2/6iDbCU4OHJIFg7xpEGD8pSod8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBHz5/CwncRKcgCz1O2zrmoygKFnRH0pR6E4Q/0+172PbzUUY
	vHddUdIZJFsBorJGnZ1C5cBLgF9G3ZArmrjWCagLQGTDjrwGl0XVTRWKjUscIHQXUVHv1sf5Fqy
	QhprxpvC+ip4bAnssHakglMMF40mCpTdxScOsvMU=
X-Gm-Gg: ASbGnctOEJsmfRJcz53XSDg3mR5CPn2h8yFeSkcPTwAc0qTUvt6Pslxq44AwUcBWjq1
	lCZN4XFVoNRKs07ETUuVfzJCxdiQoFzH9aQD1QbGYr4XrF8oMdPFcA88ENWBqkI53Uhe7JsZvwr
	kfr8vCDV4wGf+9QAy4rviSeg+5XOqaiG2hZanQ0NU/mUZZhVqNH5YVv3w1hadnyOjixsQXOsxig
	q+rkNwfZg==
X-Google-Smtp-Source: AGHT+IHp0yygxy+LV3ehWMpn/lTZnERs+tAoXnoEztlmQNj6spapJJRi6BoOuousJrflr1vBhlW34v+gy4FMJx0t5Nw=
X-Received: by 2002:a17:907:8690:b0:ae3:ed38:8f63 with SMTP id
 a640c23a62f3a-af9c63fc36bmr1209206266b.14.1754913237128; Mon, 11 Aug 2025
 04:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
 <CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com> <g7qklr4fx7qria6yeztybimqa26nyysmalbr7vbotjsojw63cw@6n36krmjw77v>
In-Reply-To: <g7qklr4fx7qria6yeztybimqa26nyysmalbr7vbotjsojw63cw@6n36krmjw77v>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 13:53:20 +0200
X-Gm-Features: Ac12FXyN-3gkQ7mOD2hVG4SdjB1Quh4RP7GiKVofhAkaO-ySlPrT2QVSfZkHPQc
Message-ID: <CAHp75Vcz1Syosz_uSOka2RCWP7-xiRB5f4iqmWkEPz12iLmkcQ@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 11:42=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> On Fri, Aug 08, 2025 at 11:56:23PM +0200, Andy Shevchenko wrote:
> > On Fri, Aug 8, 2025 at 6:09=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:

...

> > > +       st->r4_rf_div_sel =3D 0;
> > > +
> > > +       while (freq < ADF4350_MIN_VCO_FREQ) {
> > > +               freq <<=3D 1;
> > > +               st->r4_rf_div_sel++;
> > > +       }
> >
> > This is a reimplementation of ffs()/fls() or similar calls. Do you
> > have a plan to clean up?
>
> Oh so? Not seeing any direct way of using ffs()/fls() for achieving the
> same as the above.

Bit operations are hard, I know :-)

r4_rf_div_sel is a power-of-two shift to make sure the freq is just
above the MIN_VCO_FREQ. Of course it's just a subtraction between
fls() of the MIN_VCO_FREQ (which is compile-time constant, I believe),
and fls(freq). No need to loop, really.

--=20
With Best Regards,
Andy Shevchenko

