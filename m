Return-Path: <linux-iio+bounces-19408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA86AB255B
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 23:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828731B62EB7
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 21:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D71EA7C9;
	Sat, 10 May 2025 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO0lrHtG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13E4685
	for <linux-iio@vger.kernel.org>; Sat, 10 May 2025 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746913085; cv=none; b=eW38nwPdmu8EP/cT2kznU/0zAGAQ0fNz7m7oiCRZpgabmRD2coTdYJxe7Zjuy5J4uzB8f+CLpSawKRIvP9vcUBCVDibZHpPhkNn8qgvJrO5eTJyP5VPS0rIjjD+FJjF+bDaGGg0WdOmpMdf/6jUXEDHoL/Oz3joOhIwGXbFY/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746913085; c=relaxed/simple;
	bh=k6my+cKPlyc/sgoY2kudnndueRhhx0QguQs/I2p9bHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLnJY/67fwBvIRlupEPrz98j7dtUKNgQXF3XFesktR7AXWlRphC04Bnw6Yv9J426T6jF0pO5c0cyKuyh/zdEE7NRDJ/9JD6BYvsY+jy83MFq3+5pP1ZA0QTZ5xjsj/OoQNMKJ2+e8powxbN4VMLx6azbZ9cbRuE8pAgNcOTX5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO0lrHtG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ace94273f0dso629390366b.3
        for <linux-iio@vger.kernel.org>; Sat, 10 May 2025 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746913082; x=1747517882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SphYRkBChBiUqv8D5jExwQIWpEWmz41RFxXJvlPnzz8=;
        b=bO0lrHtGOBKJg/eQ2/0hQS/oLN1Js+0g3DvCnpehCVWPgy9CY2HkEpTHofI50pl9Th
         y/ogoWib0eb7wyPKGsvQmDoQZsRzmlNoItJ/zH9FTYfLMFIMyXr/JRIsbImkqgsFhOIp
         zfM1kRkYQEPftNuYwD5fK4PNRmxNtMum5sLr+vUkZyqdVnTWeJ8IQRtIsLLOIg0uwzkB
         fpBTyg8JVlnRlq0TBOKzJIOQOYHrKLDRbsmYC6KLoIl4qb91BzYhj66R6SfEURf3kSSL
         OhGdWKoK0fx4t9Zzosak0SmBYmZQ/jOo2YpgmIj267TXNt1v8kj8TOHJDFHHuUrj+Inf
         +dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746913082; x=1747517882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SphYRkBChBiUqv8D5jExwQIWpEWmz41RFxXJvlPnzz8=;
        b=ChVJ6qLx4pdYx66ZnczZ4V8XTaoVmmVjSR2cPxRY5pp3ArGGWE6p+LzV/BJFJuUUZs
         FMuPNoizNwKJcvnqu8FUY3WXZcHYVS9xBRu8gAlpLZTrt+qq0n4cBO/yrOxFvyfh01YT
         v44bhwq0yPs0Px0f+6fuSFfOYZWz0XckEB0RSFfMTHLwLPUtKOmZs9u3h1g/Ri432YF/
         m4QC9vzs5E2/LrkKqtiO5E+mn5KdXj26kzV91ux4oYLznnmNIYy4Cpb7lqVznZ6ZBJgR
         /9HobnpbF/gOOJ7UntB1C5nxOuMPVzI7ZNEbnA9xhC0VR64CJCf3bPfQ/Mj8iJG4nTd0
         LuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSLBB9KhoqKrB6DapkItXKPluWCXFhUwgBTdPfVzXTsr/+sGmZFZnBYcoeTiz+u0qyXxQTwRKXVKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVs7sdS56ZB10/oZToNbM8TsRh3bYxFTQLusk0J0o+PLcn6cbH
	r8x0i8atoHIdhAzlJL13P73jE8VSK9BVD9cqwI0ul0QrOStbKaokVoB24Z4XjeNJmGEEv/sde/S
	FT9lfED1cJ3HTFCm0cjAx6vtSkK2PhWDUMPs=
X-Gm-Gg: ASbGnctERsGLFkylk9FjFBWC+UP4wwtv8VH2D2rib6mpH19tDXbNJQTSnNjrDO66XbG
	+In75TRZIpX3kiOy46GQYhFoFwG2/vDHEH+BEA78bMTAy8I71ICjqZpa0BGdrs35dsNrr8C8QFU
	mqA3Aw30jrZveUzov7VLxsC4e62JIlVyQL
X-Google-Smtp-Source: AGHT+IFOvMcGK2vhxkEsLmkfo/oCF2QO+pxlEmKeECtO7YnjWJJ1Jo+K8t9YL7T1Vi7Q1NYSR/yL5DN+WDg44GoF4os=
X-Received: by 2002:a17:906:9c8a:b0:ad1:fa48:da0a with SMTP id
 a640c23a62f3a-ad2190552b5mr723578866b.35.1746913081658; Sat, 10 May 2025
 14:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509013931.47524-1-andrew.lopes@alumni.usp.br>
 <CAHp75Ve7-hMUxrmXQnkMjynhPUbD6R+K=-j+h0zELvcxZdy5nw@mail.gmail.com> <CANZih_SYwX2vLO79iiLbH7QXNkMgsc6+4byPC4bV849=whkYMw@mail.gmail.com>
In-Reply-To: <CANZih_SYwX2vLO79iiLbH7QXNkMgsc6+4byPC4bV849=whkYMw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 11 May 2025 00:37:25 +0300
X-Gm-Features: AX0GCFtklTkS4pFaKQYTatzB3C_Yd6UDyWl4jJc9CmBnR8yP6Md-4a_oh331t5Q
Message-ID: <CAHp75VcVM0fJ0XO2G71czFK_R3G0Vz+vm9pHxrftQ0tTPtHgvQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
To: Andrew Ijano <andrew.ijano@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>
Cc: gustavobastos@usp.br, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Cc: mailing list and other stakeholders back. You mistakenly sent
this privately.

On Sat, May 10, 2025 at 9:56=E2=80=AFPM Andrew Ijano <andrew.ijano@gmail.co=
m> wrote:
> On Fri, May 9, 2025 at 6:06=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

Also, this has some questions, so the new version of the patch will be
ignored as we haven't settled this review down. Also it appears that
some of my comments were ignored. Please, go via my initial reply and
check all comments.

...

> > > -                       *val =3D sign_extend32(be16_to_cpup((__be16 *=
)st->rx) >>
> > > +                       *val =3D sign_extend32(be16_to_cpu((__be16) r=
et) >>
> >
> > This doesn't look good, can you define a proper __be16 variable on
> > stack and use it instead of ret?
>
> Yes! Also, sparse showed a warning about this casting between restricted =
types.
> Do you have a suggestion for how to handle this? Or is it safe to ignore =
it?

As I said above, define a properly typed local variable for this and
do endianess conversions using it.

--=20
With Best Regards,
Andy Shevchenko

