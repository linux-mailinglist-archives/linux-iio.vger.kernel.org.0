Return-Path: <linux-iio+bounces-23424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33EB3C7F2
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 06:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475CEA23FF9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 04:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368227816B;
	Sat, 30 Aug 2025 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrmjRqX/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D7182D2;
	Sat, 30 Aug 2025 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756528958; cv=none; b=QOnJ9Nm4dLJ/g8tZpa+Wk5roX2dQgwQlOfaYrhrtqBy53vzvV1m2aKub+LkIs/0Q1qWSk4XLM+Pwft3ZrM4tHMvg2iJWOA3XbPVYEaXPbOl4Zgbvz8mw6H/ymj77TUn9iRJqpOti6nOf0Rfhy+ancXkZwK88oUa2MuDiKKMOfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756528958; c=relaxed/simple;
	bh=leo62WqRyTwSIBFzId4SVrc9r4sBFDab6K2FLTaQ4+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww/HmB93iUWrFaknnf3AsZ78e6NLBMs3+fx6SE/+tFe5+nruVmVZw4eAaL3M4ZkbJE9vxx/F9plwdobac63snp22L3JAu1qCQSNdenJdtCwmUws8sUFRrd4RgL0LUBoSMzbBCkK7qggDAe09f/NIad7E/A7tLIuDK58b+zAoNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrmjRqX/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb72d51dcso405107466b.0;
        Fri, 29 Aug 2025 21:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756528955; x=1757133755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgRSvboKKeqBOz+PB0U3qyVuxTryf7POlbdSMXbeHzY=;
        b=OrmjRqX/p4/lgqQLMvciFQi/tsIw0rEYqYucc8ELzSSCbMv0LLNeEFvB1lV58qwHtF
         JP/RsODhYdmxBhS3U0GrFot3zepW3jAzjc+qcx+TJ2pOcIgIe8Dpagv7MlEwMIhIzZgK
         LlVLOe43k12W68j+8NHRuBDaNByUOJRn2NI4XvZlO/8c28t2xyjnSD/JGtfStGT2Csvt
         v0IcmPOZClnsl3Gs8KkTFGde62N1gWY+bC0oaF25kQSPDdJOtI069Gkyk/HmvIhlJS2r
         lc5e88A/4mSGP2t/j9EFo0GNJTdjgM7rlrUE+6iKuqeyK5eM+fNXHoyjzb7M7sdv4uMT
         sIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756528955; x=1757133755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgRSvboKKeqBOz+PB0U3qyVuxTryf7POlbdSMXbeHzY=;
        b=TfSK0BHxM8soT+E7wbgMamp/nCiu+tmzGoqxLODccY2Z2SdpORqJ3U0h13fv5Vh7MK
         u+SZyTClzVHyZkSRxb28FWhCaVCq3ZvhjmfZQQmReTYUj+J5zAQOverAtyOkFSlocH+v
         KfKZR4ULz48UZ6UoiKgvZI7djkbYSnzk96wJAZ1EmvzW0OGqGBYsISkQArbCZK04WgKn
         /kz0rhFjAr9thE6cbuyoPQ44u+E2u08Jecyj529cUOEO3dG/1xN7q7jdXH4eiuMezlpx
         yU9sNOufcBu2wN1lrLCJnlRTy6BsuKcpgarqib3x0sLlD4qU6GWfodNwV0acKhHZq5aV
         35XQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3cZ3i95RMU+h/FPpVI3eLcqzTDo0mfr6xhh/L0R0Avfo8A2oqreYh8raQMeznyM1gz+1qORJul2E=@vger.kernel.org, AJvYcCVbEsA0AjACizHcNDIVTisGE1rDev14qgN5Z+nWJjItRLjDrVpHxAl6UUSm7xiX+GUOgxLzwawau7lHP6Y=@vger.kernel.org, AJvYcCW0L95Bne1wBkZ6adv8jxtbVPaBPpJS3j4jvRxB7/6Z9+Fn3NwzjZlJYhoog3EkWhubxVPh1q04FSYDyhcy@vger.kernel.org
X-Gm-Message-State: AOJu0YyzR0zInSDBtp7YTGewri8VLGjfHVTJ7EJfa04x3dR4lfEtft1j
	aTB53C/TG0h9pobPh4yGXFu+PKPX8k6OOvLQWOEswcAnfqbq7k0gXYvl8+dJxBjbZCWxHrMNFFl
	Pwheh2JRtftMiLHdb8pbyhg8Nx/EitnzsJpgeMYk=
X-Gm-Gg: ASbGncvyyhJKz+z76o4kvhI57md6byPpXGH6bXgC/e5S6twkTAg2RkKTcMI+B6rKxeX
	hghsvzsQPVtdGN638t5d70Pd3XdRbO4RxJcVJ6joLsKrnpKa7PY3VtqVO0ZYmTvFytVYB4p/KiA
	q+KPtMOrQlGzWvFG2055WqMAnYdq2cpFjoKrwVIjB7/M2eTzQF9k9optd6/9WbHbuNSE884hxtA
	VOe49kZociGesvbCw==
X-Google-Smtp-Source: AGHT+IFDh0sbQ3WpOeSYtIdAhA2o+X/8g/pvNwKGL94yAqGaGBuo0dg3ymV7R8A0pJjTpujFtDhcLm5rvrEe4yLO4Is=
X-Received: by 2002:a17:907:7289:b0:ade:c108:c5bf with SMTP id
 a640c23a62f3a-b01d976d963mr89940766b.43.1756528954938; Fri, 29 Aug 2025
 21:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
 <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com> <CAHp75Ve=xJ6vTUydaTw9GuYr22ZXp3HFA5N0tP7NET=CvZJB8Q@mail.gmail.com>
In-Reply-To: <CAHp75Ve=xJ6vTUydaTw9GuYr22ZXp3HFA5N0tP7NET=CvZJB8Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 07:41:58 +0300
X-Gm-Features: Ac12FXxEZ0d6nNnm_IZqpmXBwVouEaCeadUXn5fZg3Jt7I3lhY7MnFrTwWJvypQ
Message-ID: <CAHp75Vd+hAucOyjqLj=rY3oLSySiReVupRQdBjwoLQSPAZMNMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
To: David Lechner <dlechner@baylibre.com>
Cc: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, 
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 7:37=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Aug 29, 2025 at 2:41=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:
> > On 8/28/25 5:17 PM, Duje Mihanovi=C4=87 wrote:

...


> > > +     ret =3D regmap_bulk_read(*map, regs[chan], buf, 2);

On top, please drop a double pointer and use map directly. That's
already a pointer, what's the issue with it to begin with?

> sizeof()
>
> > > +
>
> Redundant blank line.
>
> > > +     if (ret)
> > > +             return ret;

--=20
With Best Regards,
Andy Shevchenko

