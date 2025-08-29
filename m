Return-Path: <linux-iio+bounces-23374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B7EB3BC80
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187D17BFA60
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA62031AF23;
	Fri, 29 Aug 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXhkGjUx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F642EA163;
	Fri, 29 Aug 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473935; cv=none; b=bFcSgH2cQhnXT3xlCfJChR1ItbiZuEwP7KgqRUCpxyuXrgrhmg9dmrNKlOAgFWp9L5uEmM9eu6SA7w11hp93KdPuVae3GDwdge1MK2WNDSqgm8NsMn6xHpaUMv0zAvrS8CE5QEQNC68H51QMp2e2WihHIOXPJIEuCXkDmM2J17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473935; c=relaxed/simple;
	bh=13OnVDf/sAxHNckkog8w2xGR8tfDJotBDKm/FrAR5ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zh+YBOlzix1fMGSRhbCyI8m7rdd//r58mo/78bctvVlc6hsrvo9if1HNsfOaWSXhtAyo4NYcI6nL3vhwHjLZZ7cdpz9Fus/g5UzN/fXSW75T/BUs97f9bu39dp2evw8ylNJhEan5khpHxGx4oNaeMu7G9lR9jc9AsB83q2b9g0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXhkGjUx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336674f95e7so15393461fa.1;
        Fri, 29 Aug 2025 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756473932; x=1757078732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihnCeRsBS5nSjU4Ma1y329UkAq+vjSlSUh3y4YGvUp4=;
        b=BXhkGjUxCbPHd/tHg7rmG2VrSeE0I0YMv+Iu40YbrjZYxe9ZzN8PX5iLNsCc9HLjGl
         XhAFTkXHAX3xkhereQfm1SSfLbf7yC75bTSDumKOcZyvxi+d+dzPlBQDKRMuqVP9toLo
         H+MmUkkem9v2xzWGaJn9Er0epecH3idgHFcTdpCn99mZQEqVZajEtrzG8arkeBZp+ttF
         JAN41HSvpHROH7ov8X7XJ71jsUV6wL2eG3O/M9PT+KYCMVzyURib4bRyuAiWJ1U9CNL9
         q1Aan0MCWFUZhJohevGUIHsmsG3tJkXYnrNJBfRez2gpj08lL5lqkRJAHGzJ3xca/pXd
         Zd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756473932; x=1757078732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihnCeRsBS5nSjU4Ma1y329UkAq+vjSlSUh3y4YGvUp4=;
        b=svhSPJGhIHjDYKZHvUXC8VeVizzSNdMY+V4gerJHEtjzkRjLfwO6UjWD5mLRRwsoPy
         KgPNvgqsT3Ug0WpX6ArDqIJYHnxdX+vrFkg4zQed5rkl5EErynkXhPjy5Ob6oFGSDx2n
         iyRxQEQYLJsi40Xj5olX5IroqtirVQLx0HK/wfClOIU+s7J9jeD8WDVY+1PFfda1myCS
         jTbU2C9o07MMQeOoSbLwJeWSh0yMmKnIS0R1PiBjb5lBTHXdxN7QC3vKpRNDqCL/VVN7
         jgji3TCkHAjfea9b909sx0ZWwlcQjQuqiqRGzwVzC3waff3wE3UqYrxQHczREgo9uwB8
         O4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQGHpeeGINJwfzRmHjhETBVrowWuRmNBqAcs/6zByUynggP3sjyuF75S0cJ3cIlhlIFCzhia6AKpk=@vger.kernel.org, AJvYcCWyA/NlYbgXWuobA9F/ie0vC+dM+zD+6uC45t2wwu39kZiXNsNB3iqalXnaVhh7iqrL1/kYNqzvt/ZA906a@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRPQuUrMqvAP/MQCx6ICn1+MDxYoJDKVclabt+JRiozS4chYm
	ckYZrXrIukw7A6LBjK3JNO6CuBEw2mFuDBh2iUqM4MesrofPUvVnIMhtMpqfBcMYo+yktT+Tdco
	J9+yjAyRAvVSNxWV0/Vch2sYrquHnF34=
X-Gm-Gg: ASbGncsTu5t9nitlaRvWdaFCKx27VI0K4wHzQhe7nxtYsgkOFDve8Wwwsyp+rfGcY1X
	UzxJ0dDvaECskD1rWVIiFFdl63eocsgj/wKFMCliKHDl3N30lakBucM3pIQKbT65YPHNXBGnAYB
	lhusqMeFST8Tm2m/4NApzZ+eGa6yxolmxYrg95kOIKplQluzwQ/ovMnc74X5Yky9MiIeJn9zIxx
	AQNDm8=
X-Google-Smtp-Source: AGHT+IH6qqomGe/yL0HOex0oCgRP+y5v+ffrVg54AbftKGpVClglSM9311F+1wE6aDSax5XlvxvfmCeDqK9JGaeryDI=
X-Received: by 2002:a2e:bc02:0:b0:336:527a:5b4d with SMTP id
 38308e7fff4ca-336527a5f6bmr74484861fa.19.1756473931608; Fri, 29 Aug 2025
 06:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-iio-use-more-iio_declare_buffer_with_ts-7-v2-1-d3ebeb001ed3@baylibre.com>
 <CAMuHMdWNNu+gwHdhfaShLyXHqxD=esp4CXpWiHJCqrCGho0z3g@mail.gmail.com>
In-Reply-To: <CAMuHMdWNNu+gwHdhfaShLyXHqxD=esp4CXpWiHJCqrCGho0z3g@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Aug 2025 16:24:53 +0300
X-Gm-Features: Ac12FXxgGU9YaVpW73v9rYw_1kG5_PAhRYBPkGVzJYAG-O4XInTFZM2Kmnz3SOs
Message-ID: <CAHp75VdMAMQ21xT-WBQUYA4G-fcUG+fTm8oGo4i4PgOWJ8-_vg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: isl29501: fix buffered read on
 big-endian systems
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Mathieu Othacehe <othacehe@gnu.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:48=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, 22 Jul 2025 at 22:55, David Lechner <dlechner@baylibre.com> wrote=
:

...

> > +       struct {
> > +               u16 data;
> > +               aligned_s64 ts;
> > +       } scan =3D { };
>
> This still looks rather obfuse to me: you rely on the implicit
> presence of a 6-byte hole between data and ts, and on the implicit
> 64-bit alignment of data.
>
> What about making this explicit?

It's problematic as it's non-uniform. In each driver the author should
carefully think about this and it appears that many just made the same
mistake(s) over and over. The proposed fix doesn't rely on the actual
type and members before ts. That said, NAK to your proposal and ACK
for the original patch.

\>     struct {
>             u16 data;
>             u16 unused[3];
>             s64 ts;
>     } __aligned(8) scan =3D { };


--=20
With Best Regards,
Andy Shevchenko

