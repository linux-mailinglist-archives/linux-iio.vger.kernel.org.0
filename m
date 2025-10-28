Return-Path: <linux-iio+bounces-25582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F6C15312
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C810189765A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AA32D450;
	Tue, 28 Oct 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsu/3FEj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC222A4E8
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662211; cv=none; b=BWVAb4X2GcA+ysbF3kUXOyukqzXJfIvGm1rk5L7E4t3ECuWzhJRf0DVczuTg2uE6RTGst9g6hOV5ptqa1CDin32Flz7QlLGbhmTJWqHcFTVsOYhMyItiH5DYG9F21wcsmxCbygmTfKM4b9A5kemKP5MqjT8mosZqPxjOst+3BSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662211; c=relaxed/simple;
	bh=2GvH00DhaFoAyZpv95ecvQbVJDyfnIvOh5tRoc/cRIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSvvp0n7V9GdxZ9W7Jz0AELN2BlMXlXMg66LA7ZZQjJvTtldP+rmGbi5GstxNIdu7NZGlHySOm1XNO68CiBvMN2szFQ2SWOwOJD8BpuqY8IUlT5QvaoEMl73jRTcFSgHYCbEvFRlj2GArj4gyvnCTgoz+J0VpulgXXlKKzifhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsu/3FEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF088C4CEE7
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761662210;
	bh=2GvH00DhaFoAyZpv95ecvQbVJDyfnIvOh5tRoc/cRIU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Hsu/3FEj3tqI6gOiQPxoPutJe4NoOm4sYCbJtBBL/TO3+HIj6QdbZ+Rzz8QwpZQqP
	 YunqXiY86Amiph0eOF7gDuoFv8mo+E0ZoR1vLXBbTedeJtH48jeHYoHox6WUQWFKcE
	 N9UxCe8xeJMnmwtDbZPPvHQJ91n8qUMOz41T7NkvZV/Fy00NWenRI64XAE7JYWb11S
	 IlpA4EM24ndfYOtrh9NMYMlvorMHkKPyRo2iBloA67lG+ODczYgxjsKulYsA+aCzG9
	 OsPWSFsC44BXU2DUuSHqdC3nBYTxW7bDccXWaG9wR05Fhqp24y2KM7aFzJz0tHaKyg
	 1OT4vxlhe4UuQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378d710caedso66766201fa.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 07:36:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcUXcD9Zv9v+2QEUV/PdtS/TPgxcc4GcyCu/6nQ5/36iq/3LztWKQ7r7dfTBED/ZMmwogk1YO3ybg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUZAMDE/ig8Foubb0Jr3DvefGAJjttoLrUomZdYNYFrWaLpAq
	vR7fwOIdrBkq+G8/xizrzAW3bOlUcU/LemTaq5tZ2XgV9u49AKDa8nElHXyDO2OW+pYCEL6gafu
	ZyjfZx8rmPCbc+EV9m7w/TzGmLsnvJEc=
X-Google-Smtp-Source: AGHT+IFagmaN5pc8iTFpBam1mflqLJDFKJBmwYlCcnaXRBDuRgltQZk228NAOylmAF/pciOjvgmG1eG++a7Vlch3b2o=
X-Received: by 2002:a05:651c:25c4:10b0:378:df4b:569 with SMTP id
 38308e7fff4ca-3790779e617mr8935051fa.43.1761662209194; Tue, 28 Oct 2025
 07:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027124210.788962-1-wens@kernel.org> <20251027144327.09f59982@jic23-huawei>
 <aQB5Dw2Eg0tVdNow@smile.fi.intel.com> <5e3bf0d87ae1b539d134edefee67d3e3ef3b46cb.camel@gmail.com>
In-Reply-To: <5e3bf0d87ae1b539d134edefee67d3e3ef3b46cb.camel@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 22:36:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v676eOkPOc33+FMX6k9562gn34+MR15t-iucLjd0qQKs7Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkJ_P7M7poPJ00fR776xU6XPnoNYlaeTx79cNFzr9mfOUrn0-hhdF9xEcM
Message-ID: <CAGb2v676eOkPOc33+FMX6k9562gn34+MR15t-iucLjd0qQKs7Q@mail.gmail.com>
Subject: Re: [PATCH] iio: core: Use datasheet name as fallback for label
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:22=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Tue, 2025-10-28 at 10:04 +0200, Andy Shevchenko wrote:
> > On Mon, Oct 27, 2025 at 02:43:27PM +0000, Jonathan Cameron wrote:
> > > On Mon, 27 Oct 2025 20:42:09 +0800
> > > Chen-Yu Tsai <wens@kernel.org> wrote:
> > >
> > > > Some IIO drivers do not provide labels or extended names for their
> > > > channels. However they may provide datasheet names. axp20x-adc is
> > > > one such example.
> > > >
> > > > Use the datasheet name as a fallback for the channel label. This ma=
inly
> > > > benefits iio-hwmon by letting the produced hwmon sensors have more
> > > > meaningful names rather than in_voltageX.
> > >
> > > I definitely don't want to have different behaviour for in kernel req=
uests
> > > and for people reading the _label attributes.
> > > https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/iio/industr=
ialio-core.c#L1232
> > > would need modifying to allow for the sysfs attributes to be created.
> > >
> > > In general I'm not sure I want to do this.  Datasheet names can be
> > > exceptionally
> > > obscure which is why we've kept them hidden from userspace.  At least=
 dts
> > > writers
> > > tend to have those names on their circuit diagrams and tend to have
> > > datasheet access.
> > >
> > > Let's see if anyone else has feedback on this suggestion over next we=
ek or
> > > so.
> >
> > This is an ABI change without
>
> Indeed...
>
> > 1) proper documentation;
> > 2) backward compatibility (i.e. there is no knob to opt-out the change,=
 or
> > make
> > it opt-in).
> >
> > In this form is definitely NAK.
> >
> > If you wish something like this, better to have a separate attribute. B=
ut the
> > problem maybe also that the same component (or 100% compatible one) mad=
e by
> > different vendors and have different datasheet names. This means that t=
he new
> > attribute may still be ambiguous. Hence I see a little sense to have it=
,
> > rather
> > better to have these links / names to be put in DT schema. At least the=
re we
> > have different vendors and compatibility mappings.
>
> I mean, we already have labels for channels so this all looks like a bit =
of
> overlap to me (though I see the temptation of going this way). For
> extended_names, there was a reason why it came as a fallback for .label()=
 [1].
> For this, I'm not really convinced for now. There is also at least one dr=
iver
> already exporting the .datasheet_name as a label [2] so maybe we should d=
o that
> instead (again, I understand that doing it like this we only need to chan=
ge one
> place...)? Otherwise we should clean up those and that should definitely =
be part
> of the series (if we even consider this).

Thanks for the pointers. In my case I think either solution works.

The axp20x-adc driver currently provides _no_ labels. Would adding labels
now be considered backward incompatible?


Thanks
ChenYu

> [1]: https://lore.kernel.org/linux-iio/20210618123005.49867-1-paul@crapou=
illou.net/
> [2]: https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/iio/adc/xi=
linx-ams.c#L539
>
> - Nuno S=C3=A1

