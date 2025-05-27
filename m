Return-Path: <linux-iio+bounces-19975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEFDAC5C17
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 23:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D113B5EFF
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 21:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF150210F5A;
	Tue, 27 May 2025 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky9ByhhS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371C1ACEAC;
	Tue, 27 May 2025 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380754; cv=none; b=n8qOjqJtG+ynrbA1TeVvSM8o3LEoe5+EL5re2osNjcaZGEIM6dzFqzC/hmWp8Mf8vLoJ9Sawc18/Lwn1o5ePc7hE2gy58+oilFS2InAbD/wl6emAUL3qu0dkzNI5dLuJCovKLPBe/HrjM2KmHROEBRimIMFAKM37BXDWPFkz8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380754; c=relaxed/simple;
	bh=QNXapWZJsE3dC+9G+ikHCtws5pJjt7oS+h1R5KWH/J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vzem7ZikGgH3HVoJVEFeXHczO9U2pL6Q0X3RlYnX/0utjs+Ab7pN6F6MeB4tHf6vFjuUbgh7FBu6C++ctueaNFv1Jyc6EYU7bPGW9WM3hH1p3qy+fqjsUYzzYruWHYZw4q3nafJDiAgN+xMJjWpFDLMZHnVPCSpsH+n6hhb8tn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky9ByhhS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso6630056a12.0;
        Tue, 27 May 2025 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748380751; x=1748985551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNXapWZJsE3dC+9G+ikHCtws5pJjt7oS+h1R5KWH/J8=;
        b=ky9ByhhSNTZ5nq0z3sQLZ3aMqbr9SQRcPgVSeriVhASKd0DnVQZG+YVIKfvNUycO6V
         3E1m5DxP5DTDNtSYEkRTpuRQHVh3aGyBcHtbC3TOkKO3bCQ6/xIhhf1QWDOXivU+cYSh
         aeMkuTpzvfJxjSCuAnzsrIiR6kR6eXdpVXK8lXNw7ZEvmfakiaPXD7VJQUeoU+Jm9vjF
         bjb9/mw/5FBAgv6MMDxYGH1MF3QH3oNUkmA5QcdgDWSAlk6ItaStLvmbaNDYaknerTDR
         hr78GbSeJvs55iQtKolZibgdKliRqWujiRKuapplcSf6zsaWvNIPPV+A4H2JGcY2eksG
         MslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748380751; x=1748985551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNXapWZJsE3dC+9G+ikHCtws5pJjt7oS+h1R5KWH/J8=;
        b=WP+xN6CpiwpX/88kiS4ApeyoxV5DmQ8ntwnODOK9WXm5C+Ta6dmgCXBkviNx6I8f7i
         LskUkskWI0S3pC/7tvPl8wxP1TF5QhRjmYbQpuLGF98IER6jRhevt34S47ecumKKhAGn
         UDPliXI16CdwJKNxJ0yIaGzH6BiQKqKHIH2zLnwR7hRgXcfjcwM2FyF9KJSjCcihaZ6k
         Q31Yl1mdnKynJR7wUs+pVqEQ4C3QG10P7We/8BuWL73cMQ+GRrNj1xf6IQl1esMBAzs3
         8GkBUa3zYnKrnaS4ZLGE3/6Cbv02xEvhAOfWEWFRT3/8XVjOwwrJiiuwb3F4N3KAaIwH
         svGA==
X-Forwarded-Encrypted: i=1; AJvYcCWo1nDcPYUQBQCpgeWmDHOqIxhMg4KtwFnQuvKvEB/d1FuAiPzUraODClaivCnF+Z4kF5jA3KB7nkokopnz@vger.kernel.org, AJvYcCWyTY8tK/oTEmB1z234Ot4h4rZf9cwDwHyIj6JlESbN8jQkJ3oJ8RRFeUavefqG6BKQc/TZryV32Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg0GganIPmXumSU95KIns7SQkWg1K5jNOfPROOKqem/e1Wdbtd
	wVZiU4HubAPY3gciIoinc8yBPLdLlhgmk1nYntiTW9G+tNeGgs3yndqkqdEeDRtxvljzWPV897b
	VJU7CUbofyi0XeZDgub77BM3YTsWm34Y=
X-Gm-Gg: ASbGncvY6Q7mejuwrg4uCE8XKr9Br5qPuLFT6TDaitDRJoZmJN4LRMowipG8GzsDpUC
	STNmzkD8j/XIhk9xJ8ppeRtiHscGJPJiXV86iqC9td3GAOVe1ZKux1WWlE7TkhmSW7QmXjmYjOc
	FYHg1fuqpYocl7fUmx5S3OJ3adcP7g+uLW54ZQkpaBm5S8Fw==
X-Google-Smtp-Source: AGHT+IE+S2MVeo+3/sxGQLYFz2Hcp8x3nRWvwF87mAfdOLk/d5dJa1KwvvCt1EUnmqr03VYT0OhOmyVhhkU/BqOcSzM=
X-Received: by 2002:a17:907:9616:b0:ad2:2e5c:89c5 with SMTP id
 a640c23a62f3a-ad85b13879amr1396851966b.20.1748380751239; Tue, 27 May 2025
 14:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527200534.98689-1-gye976@gmail.com> <CAHp75VcUr7-X+F1f=wPH4=Z7q3kFffv8BgkmKWM4VTjy2w-tGg@mail.gmail.com>
 <CAKbEznuuGX3Gnqg6WF2mqbigRps0gzK_PfGHGNy8-v1WOZoMUQ@mail.gmail.com>
In-Reply-To: <CAKbEznuuGX3Gnqg6WF2mqbigRps0gzK_PfGHGNy8-v1WOZoMUQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 May 2025 23:18:34 +0200
X-Gm-Features: AX0GCFsKbz9xXTe30H4PaFsKzDdWANkcbuG1BlN2lXy99rHGR9MCfOWniEri0Hc
Message-ID: <CAHp75VfEeNyspiMSax1_d+cpbmCQQVbOBEPCHuAag2O0ZHC1jA@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Avoid data race
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 11:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> w=
rote:
> On Wed, May 28, 2025 at 5:25=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, May 27, 2025 at 10:05=E2=80=AFPM Gyeyoung Baek <gye976@gmail.co=
m> wrote:

...

> > At bare minimum they are not relevant to the patch change and haven't
> > been described in the commit messages.
>
> Hi Andy, thanks for your review.
> I initially skipped this part as I thought it was minor.
> But on a second look, it seems better to separate the declaration from
> the logic.
>
> What do you think about the data race logic? Would it make sense?

The point is valid, the atomic_read() + atomic_set() is 101 thingy,
whoever did that doesn't really have a clue what atomic(ity) is.

--=20
With Best Regards,
Andy Shevchenko

