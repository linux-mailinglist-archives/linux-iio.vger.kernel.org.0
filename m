Return-Path: <linux-iio+bounces-19715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AEAABC721
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 20:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621B83BB51D
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BD3286D65;
	Mon, 19 May 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC2/Cw3K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B33A2874EA;
	Mon, 19 May 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747679056; cv=none; b=KKMJiwdG++nZy4dRqYT7Z9oniCddH6WK7b5PiD0FYH8i6YXuo5V37jZSZHhPuVH4AuCRrcO/2KDBP721uelSxU7id95HDQ+TSAStaH2bjxyVc9ybJx8H31nYBNhwMRpSFk6S7dFMJObwxKEuzsIH515+F8ZHd/kB+5dD+wdioHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747679056; c=relaxed/simple;
	bh=3yuG6YCZZkTsEZ4sjG0vHbbdeqds1A8LT7+eP2zjudo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mu8JBiumxBeYeOfNy7sCDwnM1jxOwVyxXVL9EMaSBoRXE1jKWoXkETLQ1391VdAvx0X4bFt/8rlT/S9JSY+N8SHoSdn5ZpnvVzDodns/Chuvq0TwmTrnDCAeKgQ1/aC/m9miqSnoQldSauhtKojE4WSfpds1yfYEEmcjqemedFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC2/Cw3K; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30ea8b7c5c2so2187697a91.3;
        Mon, 19 May 2025 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747679054; x=1748283854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yuG6YCZZkTsEZ4sjG0vHbbdeqds1A8LT7+eP2zjudo=;
        b=CC2/Cw3K6/QCgS/c8gGH0/uWN4iVdq57riVWgUPehyNbJKWNZjmywbMIqjZUy12w0H
         udJ4Drs3cKNxs+hkZfORP23JqbaNjhJJxCyphs4FDqtSJZrLap7yAnyJk7W/q+lyA3mT
         2ey9Bd2RVQQZfkHaWlMA4jl2fTRuei+KneauQ0FzBfSk2RuK5pati4l4QS0XejCcHbVh
         +zzaqVOCftrfNydKLs7OarwkzvMKXQ3loNGfe3jHTS89ACc0QnQysDyu/BshkMwvJbCj
         0RvHorAdKZyH7PVmqfjBWKFHVVrbOTLT2FIAxLuBGnW7QYHMuBeBRcmteYQtOMGdagSb
         8lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747679054; x=1748283854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yuG6YCZZkTsEZ4sjG0vHbbdeqds1A8LT7+eP2zjudo=;
        b=meuImoqKaGbzs6+b6pEW8sRXEUNMi3FDj5qzQvI4s/aT3ckYemhmFPREhVJdeET5hc
         KrUz515oyMtRB7nPrhhdadEw15+iqC6wfsqcLB7QM9qOl2uZ41XmiPrKTQbDOvJPcPtA
         iXtxubuYvdJ8l4m/pi9sNIcK37yocC1OI6C6/cAJSSQG7h6p+ichwDfW9zbjK5OxbuWD
         Hq82gznIeqvtbii1jOr7Ja1Z1iWouOp7TZyzPbg4e26zqFtlgmyF8k5OWyQZ0ztnS+FR
         8gYpbZGBmdL77rKXIjxGowoMmY54pY/Svmmbr7z27lqwnx+JnNmRehi/2aBzGNlJ257A
         Egvw==
X-Forwarded-Encrypted: i=1; AJvYcCUyc95/9RnMhFU8NYqY6kv0JGtA7ruQrGsRkIgyvYS9EsehOEQJJPWIG3J4GJadTbpPGyI3m+R8YjT2Tj/5@vger.kernel.org, AJvYcCWj7X+aFQiHuDlSvNbctSzweKwwgXcVHb/JZWrMf/mBSIxOgn7h0ULgDSIUeGArv0ZfUn7boSGKEaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp6sdwLGrAumuYE85nX9TVtUVqAE+XYTLcY+6ZWoi5iVPFwq/Y
	Ru7w5kNvMQXAk8mGnYT2eZdPnFL4C5VBSJFiwahLIfJQOP0IrbH90SZm5YNvDtTQ3H9JmKSiNUG
	4HTgmu1fmG/9VvqHDVlF6eP8HgJvjZ60=
X-Gm-Gg: ASbGncstINKzZPVdmsbLIh1idyHMkYci7fohcTFEmpgb94IvPlWWFI/Iue3QeHYpyn4
	EWSB7V8m8OUUf7xvV8sp4P/alaakM1XU1K0LR0XFopk9Veelk/HapeprWhJiBrn96LxUbip9A6j
	wunuMTl996o0VGY4z7otXF0YC3LJCpsd2XnA==
X-Google-Smtp-Source: AGHT+IHmlpnUrqtWUhYfgZb4ImW7swMGNC/uf5vTuHRu1M1uwil4qqjaBE1ka+WOyVPVZg4y/tYqvYW68YNFda/fAfY=
X-Received: by 2002:a17:90b:6c8:b0:30e:8f60:b4c with SMTP id
 98e67ed59e1d1-30e8f600d77mr21594237a91.16.1747679054505; Mon, 19 May 2025
 11:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com> <f06d231d-297f-4c83-b457-b9eb242b9c93@baylibre.com>
In-Reply-To: <f06d231d-297f-4c83-b457-b9eb242b9c93@baylibre.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 20 May 2025 03:24:03 +0900
X-Gm-Features: AX0GCFvmEWIRJCR1b9xEYVREnCG9wYgk71oNXkvAWn9Tpq1GQNEWrvNKYGsdrow
Message-ID: <CAKbEzntfFix95SG5CkCzMWGuDXdztTQRv+SYOEaWsSHwmYoCOA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] iio: Introduce new timestamp grabbing APIs
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:28=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 5/19/25 9:25 AM, Gyeyoung Baek wrote:
> > Support automatic timestamp grabbing by passing `true` to the `timestam=
p_enabled` parameter of `iio_triggered_buffer_setup_new()`.
> > So consumer drivers don't need to set `iio_pollfunc_store_time()` as ei=
ther the tophalf or bottomhalf manually.
> >
> > For this, triggers must indicate whether they will call `poll()`, `poll=
_nested()`, or both before
> > calling `iio_trigger_register()`. This is necessary because the consume=
r's handler does not know
> > in advance which trigger will be attached.
> >
> > Once `iio_trigger_attach_poll_func()` is called, a timestamp is grabbed=
 in either the
> > tophalf or bottomhalf based on the trigger's type (POLL or POLL_NESTED)=
. If the trigger
> > supports both (e.g., at91-sama5d2-adc.c), it is treated as POLL_NESTED =
since the consumer's
> > tophalf is not invoked in poll_nested(), but the bottomhalf always is.
> >
> > If the attached trigger supports timestamp grabbing itself, the consume=
r does not need to handle it.
> > Instead, the consumer's `poll_func` pointer is passed to the trigger, w=
hich can then store the
> > timestamp directly into consumer. Trigger drivers can pass timestamp va=
lues to consumers in a consistent
> > interface using the new API `iio_trigger_store_time()`.
>
> This is explaining what it does and how it works, but we really want to
> know first _why_ we need this and why it is better that what we already
> have or what sort of problem this is fixing that the current situation
> can't handle.

Hello David, thanks for the review.
I see that I didn=E2=80=99t explain the reason properly.
The following explains the reason for these patch series.

There are three cases when a timestamp can be grabbed:
1. In the consumer=E2=80=99s top half (which is the most common case, using
`iio_pollfunc_store_time()`),
2. In the consumer=E2=80=99s bottom half,
3. Directly by the trigger before polling the consumer (for drivers
using their own trigger).

Since the consumer can't know what type of trigger will be attached at
runtime, the following two problems can arise:

1. When a trigger that calls `iio_trigger_poll_nested()` instead of
`iio_trigger_poll()`is attached:
most consumer register `iio_pollfunc_store_time()` as top-half
expecting a timestamp, but top-half is not invoked.
And this is not the intended behavior of consumer devices.
2. When a trigger directly provides a timestamp:
The consumer=E2=80=99s handler checks whether a timestamp has already been
grabbed using if statement (like light/rpr0521.c),
or overwrites the existing timestamp even though it was already
provided by the trigger.

This patch series addresses these two issues.

--
Best regards,
Gyeyoung

