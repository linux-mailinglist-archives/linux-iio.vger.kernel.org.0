Return-Path: <linux-iio+bounces-23780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F43B45994
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737AD1C21CF5
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194E135CEBB;
	Fri,  5 Sep 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgNTZZ0f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D33451BE;
	Fri,  5 Sep 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080232; cv=none; b=cAhPQUKfR42NmRVt9qpmzVIgs6MXBVZhAeMEC5BzifYLHMTVaG8zYYWQILlbOQRQHWwrU2Z2T0cC3pA2/AOj7u7UMaNFBkhNXOtA6edRHbjeXZbFVFPZ1cEkl5jSZmGw+A+PWYv9+N0uUEua/B+RA8StoUH5hgKs0Da7WBUG5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080232; c=relaxed/simple;
	bh=P3Q4uhxPRcsG6nzEVg3XOmj0dNzFAkDhoZFytzRFyL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cL9diCae7YQyy7MIw8CuxFMPmD+rud5dqg4vwvb5PTXBcJuxArU9/CufM2as/Z37fXyNT/lYEGGqmPv/Cj4gUJoJAwGTWNIOXm9gL91CAvEEbeJO+i2jMgVb+KIDldpWnwuHQft7H+FuoVPhn0yX7CAdB6I1P0Xsefn0MA8qn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgNTZZ0f; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61d3d622a2bso4276483a12.0;
        Fri, 05 Sep 2025 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757080229; x=1757685029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsDRGR++bormrxuQpTob+gGR1rNtwUxynLJUN3PiAt4=;
        b=jgNTZZ0fV1eGLD60bf0ZbogA1PWZb/mkrXhl/PNvjw9HOEhwvVnNt6PTJgkCsvvmop
         kMkR/1M+zTT1S9vZMnIlVWmhozT1ia52OHfqa0wM9w/DB8PIy2HWKcMj0Tm6FYK4DtF/
         tF576tdISNGSHGQyXmKmYKaOy2LqMLB12mfYOpLfGA3xaiiD3opT7OOlnNweNAj1FwWW
         BWsIqPAx0VGjCo5L52dX8fTdIG2jo6YbtYX6/WrPzaWX1o9jsaaXiZiEf2BoIIyOY5oq
         EpGPe+M5XLk7HlNIhhyjAwW79BsaHQhXjxKcx8FG1/jhJZKJeKwHuhUdifzBFF3JAfZ6
         ZyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080229; x=1757685029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsDRGR++bormrxuQpTob+gGR1rNtwUxynLJUN3PiAt4=;
        b=pIUPz1lZXGmPOV67VZMnnL4saTYT0POUa1AoPpYDU55ju1TID5gcc86AjoSviR1qQv
         MGA/rNXQBw41cDIaFi7ghsGLs6Xf8zaPok7HT8/j0W9/qhJeeFSBkyNWXJJ/BNQohHvL
         /vPEOizBWaXAI4TPRnsTWa6O5jYZGrDZ+g9TKlA8/zbzXWpFZkJPh4lKsxbRP/r4ns++
         RlfH5HuDIu5zTpHkk3W1KtL7iX5D2mSJjtNNvn2iBbaFJUI1A5P/TT6b8mOqc6+jaPIt
         drpTa6GX15jRp3PwNW8as6lLbV3T2RC5GEgiZFEAO/xAA0S8r2y5L1jSuVI6H7KfT1SI
         auBA==
X-Forwarded-Encrypted: i=1; AJvYcCUs7YLobpxsFhw2SZSh45T7D3FpDVD+lWInWUIgIcfoYJuSf7ji/O2QUs38SI2aTB/ezKoyUvAAK9G4HxoT@vger.kernel.org, AJvYcCV3gHaswnjkYUYEiqkxQL70P8fKjVa3v+i2bLSTasQJLIfuCcAJ7Kd4UiR4yFnMYH1rO1IeN5OtZaej@vger.kernel.org, AJvYcCXKc6TIbhimAxVzBeRqPi9m/a8NpqhE+wBv6hhpaEwwvAcmLWjMz0gE8CtouM8NAQc4Vj4EtcQLZlYT@vger.kernel.org
X-Gm-Message-State: AOJu0YxyF3U8FMFw5tQOh2ZoATCweSjQGCiFNwev3M8dGdNuu5lwX56p
	1Oi0vr4BsXcKki9e4BH30tjHHI5gTom5hqpMwW99kR1r3zpCDaDml1leysApi+PT8RyqRThgyYy
	SEc45WkKcsrP9fCGEErfJuAMNK4MhCSs=
X-Gm-Gg: ASbGncsnU0qQXOounx4g55lR2PQ5Y84BCWDP1KyuVawngLBYufg6DAwlZhmHt4csniN
	uV2PCnS95l4SUtGUpUpU7IbsKAcvuasEkpM3h9E4e6Sq6BxmeD8lzijf07JtO3ugyRko95RpZC1
	upJ2rtTfXb+rmmlX06umjgEk/pAa22ErAIlap2kqnn13RI9UqWX0w55/lqN8nmpVu5LXMnR9bS0
	Z/rUp4Rt2542lkP5e3E
X-Google-Smtp-Source: AGHT+IHjWWI9HbRGOxg6LjImm1wlKdJKXEOOX3NTMgz3aDtQ5bkt1lgUY0YKC8oZiVEVz59Ge+csrDJT51esVT2Tq4A=
X-Received: by 2002:a17:906:37da:b0:b04:7eba:1b55 with SMTP id
 a640c23a62f3a-b04931013c1mr293547266b.19.1757080229304; Fri, 05 Sep 2025
 06:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com> <aKbk9WYtfb5L5la4@smile.fi.intel.com>
 <FR2PPF4571F02BCCFD984FDD99C69CAE7298C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aLmY2mKg_FsPOpsq@smile.fi.intel.com> <FR2PPF4571F02BCEB6C4FA4B3641299A72C8C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR2PPF4571F02BCEB6C4FA4B3641299A72C8C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Sep 2025 16:49:52 +0300
X-Gm-Features: Ac12FXzLd2wqWO1IzNY4C04FzCYHy2I8A2mtoLZ2cJjriRJysLqX_toKQl18uwM
Message-ID: <CAHp75VcLo__aS1GJCN_zgd5PgNKgtSGbCWbY07qngEFVXBtQVA@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in iio devices
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:44=E2=80=AFPM Remi Buisson <Remi.Buisson@tdk.com> =
wrote:
> >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >Sent: Thursday, September 4, 2025 3:49 PM
> >On Thu, Sep 04, 2025 at 01:01:32PM +0000, Remi Buisson wrote:
> >> >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> >Sent: Thursday, August 21, 2025 11:21 AM
> >> >On Wed, Aug 20, 2025 at 02:24:21PM +0000, Remi Buisson via B4 Relay w=
rote:

...

> >> >> + /* Disable FIFO and set depth. */
> >> >> + val =3D FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
> >> >> +                  INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
> >> >> + val |=3D INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MAX;
> >> >
> >> >FIELD_MODIFY()
> >> Ok, great.
> >
> >Actually this is not a modification per se, it's just an assignment (PRE=
P)
> >split to two lines, can you just make it a single expression (wrapped on=
 a few
> >lines, though)?
> >
> You mean droping the FIELD_MODIFY suggestion and doing something like:
> val =3D FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
>                  INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS) |
>          FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MASK,
>                  INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MAX);

Yes.

--=20
With Best Regards,
Andy Shevchenko

