Return-Path: <linux-iio+bounces-25561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D2FC13C7D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446F23AA418
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493502FE578;
	Tue, 28 Oct 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrWjjoaz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F22BDC34
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643326; cv=none; b=KDu3OlLnkz+KLDvhXkskvM+IPWWL0NdqyRzzANZngtO+I732nCjM1bkpyozFnezDjrj1V6rnUiWRGveL9ssQIBewlbDueugi3dTDSjTB2UyydYP/2ehgo2QvTdxOrwHwifqc+1vaj/d8bOznH1WXWbdmb+2MBgjYwVhSBMng+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643326; c=relaxed/simple;
	bh=qyDtyfHUsDFrz2HvcrljCpitgV3nqN5bjNEUeswpEB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gqLWSQlCp3TzzhHqanuBVXPLbLVnrFLVxIg8X2qG7PbjOHGx3HuOq7LW+i+dw81LgY9G8QhWj9fM2O9Qs5xEINWMzqD6UuxRDkRpAHacTxJ99eSPhRBZO2Cs1brkpLsv0Npr1YNv7kWIi4rboFZ/IDcMlMK0vy1cL+kHMWACTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrWjjoaz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475d9de970eso28676205e9.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761643322; x=1762248122; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qyDtyfHUsDFrz2HvcrljCpitgV3nqN5bjNEUeswpEB4=;
        b=CrWjjoazv3ym7sCg25MNCrIfjwOjVeb/nNT4nlbaiDpgcHu3sLRn5MkrbAu6y6KJ46
         WbB9EGNEouYqVy0jpFovQ9eHowyl75j/v7eKfnOk9WFzocNBTKILX5K3LBCuknqdSx11
         mEWKiiYdDZzX20svGkr5ltrR6wIsSyXA13SYPnvF+Q9ANzDuSZf9gYAsUITcdJQNKuRa
         My7jBYtyq7LthhngjjjCJZyo/epXk9AbISVGl0ZmINbbdkBdurNpHJEo6JrT0U7gbFBF
         rbA5k3Lpavq6GcfUdoOeLcIJHv1hW8UVzz4R9dPCA9L19q0InMxm8DAtJ2Dxskc0tRIK
         QJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643322; x=1762248122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyDtyfHUsDFrz2HvcrljCpitgV3nqN5bjNEUeswpEB4=;
        b=SovEQeWIfzxw6BMKH1JLu7WvIo4ib5tTeIHZlVFl335MMjYQlPcmBEissi82ySH8SQ
         Hm2MQuDz5GSCAfLSxwH9Pb6aPwW2OMsleqSZqiajcIdd/Jsy3lQoBKpeFfwsp/dUgK/D
         pNK6oFIXh7oIS5/i1PbXdPg76IUL0OKNquuEkHG2cAO1cKibCbvk0gCTL+v8+rpCW0Rz
         KjcqNbD5SoaQoeDYiyqZFvrPaOswL76h3TRbuLwja5ahU6N7UcJQa+lgrRnyVjkw1YJb
         QHVPj2J/EGcSvlQwD+wyQnxU1tux390VF3fKna57h/6rUXK1srzTH5/OSu5jcoazO7M4
         P77g==
X-Forwarded-Encrypted: i=1; AJvYcCWmThs0AygOOxYAmZR+XuBDsiRFTlqAuRqn7jWmV+YJG1kSxOQiiNlhj672bpk88Pc3nQ6AL7d7dQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrbi/+0A+1569aj1t51hha/2CxQLli3M6Pd+9o80N8+PhvpKZ
	6UNFnskKHGdvHSFzOyPScu2f2FO8ZkbOCh13Zh5C2TbIun0Ini72J6fl
X-Gm-Gg: ASbGncs4fCy+DrN8n4kXhwWuFmBdJbhhgnAArVGA5thpPrD1t9up4RSPD6pHVCbN04d
	1a6MtUC42ealIGxtI7jFnihgifrslybkM9IPOHF7ikYgNdO0b5SVYKd3jIUSxYTObKlvTi44yyA
	d12zjPgxRWgHnJBLRoe68hPT6Mx4vzAt9h+PgcSKp68oPMEQtPnkzZIR9tvv4VR3puIIr0tTPDt
	uzvI1UmrrQawb1L5NjG5zdCmRziiGQwNSolYpn/s8CV5eGqW0KhmmWGIGdrhl/KfrlbjP13IMX8
	LULD+fRMw00ivjriUUmV9PdWVsvy8PMpSI0hLXHoCnforeHaxFt0t1FObkjz5W9tQRG7txjbFP5
	dsmFutwyGfgXRoDeipRuqVNByLTOoWcoEfn3IIOiN19CI++MiCFZ4WwiEYK89hvtLKRlXzO1xOv
	y7y/0s6jNF
X-Google-Smtp-Source: AGHT+IHwdxWEuyCVgrLBxpjJGOZCTptkhpTE8tcoIQqfi03N4Kvtq0Ch1ugi5oZ8rA6JxgyVnew9Vw==
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr21047585e9.35.1761643322238;
        Tue, 28 Oct 2025 02:22:02 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd48942dsm187244135e9.4.2025.10.28.02.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:22:01 -0700 (PDT)
Message-ID: <5e3bf0d87ae1b539d134edefee67d3e3ef3b46cb.camel@gmail.com>
Subject: Re: [PATCH] iio: core: Use datasheet name as fallback for label
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 28 Oct 2025 09:22:36 +0000
In-Reply-To: <aQB5Dw2Eg0tVdNow@smile.fi.intel.com>
References: <20251027124210.788962-1-wens@kernel.org>
	 <20251027144327.09f59982@jic23-huawei>
	 <aQB5Dw2Eg0tVdNow@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 10:04 +0200, Andy Shevchenko wrote:
> On Mon, Oct 27, 2025 at 02:43:27PM +0000, Jonathan Cameron wrote:
> > On Mon, 27 Oct 2025 20:42:09 +0800
> > Chen-Yu Tsai <wens@kernel.org> wrote:
> >=20
> > > Some IIO drivers do not provide labels or extended names for their
> > > channels. However they may provide datasheet names. axp20x-adc is
> > > one such example.
> > >=20
> > > Use the datasheet name as a fallback for the channel label. This main=
ly
> > > benefits iio-hwmon by letting the produced hwmon sensors have more
> > > meaningful names rather than in_voltageX.
> >=20
> > I definitely don't want to have different behaviour for in kernel reque=
sts
> > and for people reading the _label attributes.=C2=A0=20
> > https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/iio/industria=
lio-core.c#L1232
> > would need modifying to allow for the sysfs attributes to be created.
> >=20
> > In general I'm not sure I want to do this.=C2=A0 Datasheet names can be
> > exceptionally
> > obscure which is why we've kept them hidden from userspace.=C2=A0 At le=
ast dts
> > writers
> > tend to have those names on their circuit diagrams and tend to have
> > datasheet access.
> >=20
> > Let's see if anyone else has feedback on this suggestion over next week=
 or
> > so.
>=20
> This is an ABI change without

Indeed...

> 1) proper documentation;
> 2) backward compatibility (i.e. there is no knob to opt-out the change, o=
r
> make
> it opt-in).
>=20
> In this form is definitely NAK.
>=20
> If you wish something like this, better to have a separate attribute. But=
 the
> problem maybe also that the same component (or 100% compatible one) made =
by
> different vendors and have different datasheet names. This means that the=
 new
> attribute may still be ambiguous. Hence I see a little sense to have it,
> rather
> better to have these links / names to be put in DT schema. At least there=
 we
> have different vendors and compatibility mappings.

I mean, we already have labels for channels so this all looks like a bit of
overlap to me (though I see the temptation of going this way). For
extended_names, there was a reason why it came as a fallback for .label() [=
1].
For this, I'm not really convinced for now. There is also at least one driv=
er
already exporting the .datasheet_name as a label [2] so maybe we should do =
that
instead (again, I understand that doing it like this we only need to change=
 one
place...)? Otherwise we should clean up those and that should definitely be=
 part
of the series (if we even consider this).


[1]: https://lore.kernel.org/linux-iio/20210618123005.49867-1-paul@crapouil=
lou.net/
[2]: https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/iio/adc/xili=
nx-ams.c#L539

- Nuno S=C3=A1

