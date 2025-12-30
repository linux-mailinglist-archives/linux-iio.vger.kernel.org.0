Return-Path: <linux-iio+bounces-27435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5842CEACEE
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 23:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DF0C301C97C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94FB2820DB;
	Tue, 30 Dec 2025 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiqutIpn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD34248F6F
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767135459; cv=none; b=SOaoJFfIF9AeCk/A3dxY9Og7w24k0MI2CFI/IqxB4cCMSyEdkFpNR7hXR1RpBr9xESQ3nbE6GnNYeUNXHtCuymxRHDn8IOUA7NYtrCJevbxTPlJoI1cm+01YpqiJ0vx0RB/wz7/0ND8s4w1bERtrzFtoqGUFQRQGBE2R8L+YaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767135459; c=relaxed/simple;
	bh=fCzC6vLc1i4K/LRcoy7/bgdJHCoLH4W7prlzP3nbeUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9Ll6T/vdSLh/Loaz2Sqlk8EkCq2xFiK9vMluqVlea4I/cTy2ur7O0kRrTSnd/ERvFneaJd+j7PrBk9fN+hqs7ZwtZtFS38SDTmZoRc3UNey7WcV84+I77rM+FTlZ0poBPgS4OGgM4miiV+FF/c42RsqlG3SMMNYjFFjsV1k89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiqutIpn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7ffa421f1bso1960821666b.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 14:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767135456; x=1767740256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCzC6vLc1i4K/LRcoy7/bgdJHCoLH4W7prlzP3nbeUw=;
        b=EiqutIpnnUpXTBabNnNiHUdC41PBgOZ0dAspb96tE3mE+SN7RmCq1nPOg2eWZp1SsU
         Vu4qo2fgd9zHZ1yMUBAn15VTeoU16OP1ZMNzvTQCPno7XfLCh1mfY+Y/ss4JgX62a5KU
         RazWC4MBo1KHduHzu/8Nip9EHCbSLonbRboB8y6GDXjjoKj8mjPGfjWT3IwQoMrmhAGt
         BUfFEmS54nmlgMypEfrDvXCKsFMsycYqdr1Uf+pjF8gXvZUirewnU9B19RTOR6Xa5rLL
         2dnareRJ560cfsR6xFsBSNrgve9doOYNs79Ln1Bihe4yvB4v2TEM/lWm4ow3Rw75LdCt
         NEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767135456; x=1767740256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fCzC6vLc1i4K/LRcoy7/bgdJHCoLH4W7prlzP3nbeUw=;
        b=wyJjVuw8jW19/PqIdN6h+avv62sCCw0WW2hqCjJzzZ9BjTh1os6vEM5U3qFamk4AJX
         v0/gUXARVVZYspsxnWHHaLXgayRuCu5JDooQLPmeG6LxYzYUljnZGA3Jc/N1Xb0dKKoq
         h6HYW/MhouMZwgEiL9ALhqTZNuu02psDgpJK7BH4ycqJa2BhJjH2HgiE+kuTaGVEecJO
         VBeTUis0b0Ef/G4JmtQsqvT9oQdZce2n+FHri3yg3jkhAHIG0ZJIDWuVig454FYlpprJ
         538WCwiS6qvPOYQwYxh8BymcSUZafgYvcT3YhGk/4ozWzXQFXQa5vL/Y9IzAxlKWFWEB
         BJow==
X-Forwarded-Encrypted: i=1; AJvYcCVGOaXAu0clyvKkrPbk8CT7iOFuxnCRTov3qBtT6Jx8LG5AsnyoAUQRvnoxSwqWKZccU5C0VZ+/i90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6XKnay/P5KKQc8J93o4L+FHON24FF/RmH4m+qWM1R7UmjAuar
	IV9GzYxKLvU0o0ddxH2MrN+OJ50LpMLMDXNW2s8ou48ogygwYl3qrBlhRLF4k7iDOh8jHy69meQ
	JH+EREgKtCGaPdwjsZ87hr0d2VWVzdRk=
X-Gm-Gg: AY/fxX6FWB8f3CYdn9GX/FUyyP9/nlUvyWcmuY+fRsztHmgXh65qJC7jXqecLfj6Hqh
	LoM4GVVSmj23VElKBRMuZCfDJIHqU7J6EvfTQlyuf3NCNhNDqha1wfohEPSgL0YeCo8HM7HbkF+
	+fkQRr/Xn4PrhHVWTdlyfA5lBXRyeWsaZDsvHG0yfOF0ia/Tq/J/Uz5R9FxPJ+3yhh9uA6eLG64
	+8dg75bCHpfjh6GirZVuFVtqj0lMYdoiwbA70KheZG6TX6UokaMM322DInLQWj1AQdctC6bhFQD
	GRem4bsJmJNGiq7hzt3NIhUMG/ZRGnlBuc94mXwFAof/KqXVMADo4RaeNiX0RlIosWt8aTb64xN
	40CgK6IE=
X-Google-Smtp-Source: AGHT+IF4Fdu6Q0XK+SszfFyWCaCJAkiq+H7nTHS/3UO7+t+nYKqybllRelyl2BL93gmscmbksnqzhzXQSKGnqmNIj9g=
X-Received: by 2002:a17:907:8688:b0:b80:456d:bd99 with SMTP id
 a640c23a62f3a-b80456dc544mr3804458966b.19.1767135456312; Tue, 30 Dec 2025
 14:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230203459.28935-1-tomasborquez13@gmail.com> <20251230203459.28935-7-tomasborquez13@gmail.com>
In-Reply-To: <20251230203459.28935-7-tomasborquez13@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Dec 2025 00:57:00 +0200
X-Gm-Features: AQt7F2oq77hqLNdnBzl2NuGj_pgFua0ObGKygvJMi5N45990joVQYyw1HYDblLA
Message-ID: <CAHp75VfYsJu4Z9QjM1uCEN6WYZJ=juF+5bw3zoE-A0uMpYR5Pg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] staging: iio: ad9832: add sysfs documentation
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:35=E2=80=AFPM Tomas Borquez <tomasborquez13@gmai=
l.com> wrote:
>
> Add sysfs ABI documentation for the AD9832/AD9835 Direct Digital
> Synthesizer chips, documenting frequency, phase, output control,
> and pin control attributes.

...

> +KernelVersion: 6.19

6.20. The 6.19 boar already sailed.


--=20
With Best Regards,
Andy Shevchenko

