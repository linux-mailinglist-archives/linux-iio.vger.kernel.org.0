Return-Path: <linux-iio+bounces-4909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EBD8C0300
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 19:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966CB1F247B6
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD659165;
	Wed,  8 May 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tNopM4RS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128004500B
	for <linux-iio@vger.kernel.org>; Wed,  8 May 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188885; cv=none; b=TcL2aKzs4e/zwsEaKQFX/RWN6BasN6lh1xjVAfkqZmLyCE+heEFJBq5+uTbNaYuX5TFrn983xcAXDaVYQWz5fnP6jPNUS4dm4xttx2BZYuUof46eYNJSadOKtNjcErSv0SWeU85G8ij//t5/hHtDP0Fx4/XNrXWc7K5qkiEl6w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188885; c=relaxed/simple;
	bh=m7e9FA+/CGUD8recWszU9j2hn0vK1y2+HNyRsRo6tkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5rD0DiFX6izspzMHmmrAobilypdCdYFWgvFa2Ydl7NlBIGlMGLZViGjbqFeOm4Vqn66NJMwE6zHDZ8B2yrv3eYxSl3slMG5VrDxRRw813cPvgbqO61t9TB5jtFbxtqIv36NERcwtbJr6DbW6IpRVrbKKInxKQXvrYbAZH82ss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tNopM4RS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e4939c5323so7432931fa.2
        for <linux-iio@vger.kernel.org>; Wed, 08 May 2024 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715188881; x=1715793681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GndLXxg7LjkXPI0lTWLQipONPUywXcP78DbfL7UFwMA=;
        b=tNopM4RSEclATbqFfhVeOfD60dGsq4TpWdW/GkfDtnb/v113C8d3CbCGmWtiPgMoSl
         yhmp4fqSZXMva/7+Fmsr0vz+UjPxoiNsXlnSsn1LV36134yige56zIxzkk5TL4GOxmXB
         UENhFOQ9K1WIUdoVupz768N+3VSzqcRw8cy/AZctN8QWjPyb5FczXj7drRSkv+tEIkOX
         TgLUjNYF8ErlJS0JZMd3CvddAuFw5SJZ4CLu99KC4zMRiPTgdJnunQ+VGc9bzGhw33rO
         ixgY67ZuLidRjnAIzXRlBVhBDtiZROAYb/kFjn0YqT6XhGT4VfGITGgHnZ0MchcHFayC
         ToMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188881; x=1715793681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GndLXxg7LjkXPI0lTWLQipONPUywXcP78DbfL7UFwMA=;
        b=bPDhhSd4+I3PaAIKNIcoFRWE83w57sZB50Nj+Ha6FKD9h1PDLhF627N7MS/rMuPbtR
         fqU4a1RuAC/tIMjCnTcqjRGf16Io3+Pcz9rssJD6G141byR3sqE9lxoVi3bf6pyNqvNy
         g8hnheswzRwXlRU5SmKld3HwXQGVv9l8W80L9tzUGrVkL7Q7FH0Yr5IOVEliwM+kpHUT
         xbe1QBzOHcSHNXJ7OmdhEz35c7TXmY33TKLvQV2rulKOMdr8r/gPU+nW9BiaLcmDUkSv
         OvTWLOTa+Mj8VwiOW0IjtNqlJ5KSlqi+4nXn9xdJy4e6uPHRwfaVAmNDLSYWN4FboyP3
         ITIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEzG9EmLvl5teuqSY8dEoCMsfdKiydIewC2o2D2G6w9c+zndc9Fn2qBtRrofQtpB1rJIewTb+2GBDgsU17inyQaZzNunAe1gnv
X-Gm-Message-State: AOJu0Yx+gB2tw4ZVqBVjgzyOJoqhPg0Nwt3aHJet5A8qcwiwwbev17B5
	uDYRA14+FMHqS0jb7PXpxlmq6lMwm/TW+f6c5AYiVXQAr4eiw0Jyjtm+SAmysRzTroFUn3nK7nM
	pWTl5ULs+qlVthiaLuuZz+8mvqFOFoDUIJVke4Q==
X-Google-Smtp-Source: AGHT+IGEEt/X1HBcZ8GvMPKSAZtaw9oCyg6e6/g625a7K7p6uRZUOzQGv0zldt06N0j06M/4XRIHFuOjDvwph/sOmg4=
X-Received: by 2002:a2e:91c9:0:b0:2e1:f05f:6424 with SMTP id
 38308e7fff4ca-2e446e81666mr25956051fa.15.1715188881132; Wed, 08 May 2024
 10:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
 <20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com>
 <20240508124049.00001661@Huawei.com>
In-Reply-To: <20240508124049.00001661@Huawei.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 8 May 2024 12:21:09 -0500
Message-ID: <CAMknhBFob4Wd8Gm8W8NKSuL9UbBCY8+fAN_voGPhb4Fy1tAT-w@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] iio: adc: ad7380: add support for multiple scan type
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Julien Stephan <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 6:40=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue,  7 May 2024 14:02:08 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > The AD783x chips have a resolution boost feature that allows for 2
> > extra bits of resolution. Previously, we had to choose a scan type to
> > fit the largest resolution and manipulate the raw data to fit when the
> > resolution was lower. This patch adds support for multiple scan types
> > for the voltage input channels so that we can support both resolutions
> > without having to manipulate the raw data.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> I'm wondering about the control mechanism.  I was thinking we'd poke
> the scan type directly but this may well make more sense.
>
> This is relying on _scale change to trigger the change in the scan type.
> That may well be sufficient and I've been over thinking this for far too =
many
> years :)
>
> It will get messy though in some cases as the device might have a PGA on =
the
> front end so we will have a trade off between actual scaling control and
> resolution related scale changes. We've had a few device where the scale
> calculation is already complex and involves various different hardware
> controls, but none have affected the storage format like this.
>
> I'll think some more.
>

Here is some more food for thought. The AD4630 family of chips we are
working on is similar to this one in that it also has oversampling
with increased resolution. Except in that case, they are strictly tied
together. With oversampling disabled, we must only read 24-bits (or 16
depending on the exact model) and when oversampling is enabled, we
must read 32-bits (30 real bits with 2-bit shift). So in that case,
the scan_type would depend only on oversampling ratio > 0. (Writing
the oversampling ratio attribute would affect scale, but scale
wouldn't be writable like on ad7380.)

It seems more intuitive to me that to enable oversampling, we would
just write to the oversampling ratio attribute rather than having to
write to a buffer _type attribute to enable oversampling in the first
place. And other than requiring reading the documentation it would be
pretty hard to guess that writing le:s30/32>>2 is what you need to do
to enable oversampling.

