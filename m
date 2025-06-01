Return-Path: <linux-iio+bounces-20118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2763BACA058
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 21:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC53617297E
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656C023875D;
	Sun,  1 Jun 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0r6DrPA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E76140E30;
	Sun,  1 Jun 2025 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748807664; cv=none; b=Be1FEc0bo3fxVnegS/vCJW0dWUSttnlwIhRsoMPEU4ZAsl4yhb68+8B15bRf3VkBD6QLoRPReFLwznSJ/oA8sQdleNeOi9noHH3DcVAGOHB5ZYgHi84CGK0ZVi/cyseukF02Yzg/dB7Ki+MdaCDGS2y2nnAK0ah+L9RBtErEB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748807664; c=relaxed/simple;
	bh=okmqYDFYTj0N8/RbvtxGNYxNglDX9bIPQed8iT5MgSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dc+p0EYek7ytmgEtZwBz7b/hD7hTNQuVfR45jw56qe7u7r3GNEc2FIUMQjq/ODVJaBV0YMnOPRthiUbbWvQ72mz24opko8lzk1kWIQVpxK7V7xCUi/BXTtE/vzJHcBCDe7yC9RDJGl74fD+0pbZsPqASArskVF/We4Qr91OE1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0r6DrPA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so7859373a12.3;
        Sun, 01 Jun 2025 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748807660; x=1749412460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeF/949IPaTKS3FEiz0D2QNOdvwROIAr78Br60q0vkc=;
        b=P0r6DrPA0dBZ4Y5aUzeuXixv6GpFjZ6Cddfnsv4kx8Zc2iC3/hUu0YkiZ0jUXmNZuM
         cy9Mwto1yN062byy55kYA5lGhHIcKOfFiohR0pvajiLYsTZ+jOcoQFaEAKvbHV3F2h4j
         949xOhzIFNPW/A4q6sD8tGbPxjueYTLiMSG75fOqS/B7t0Ee53A7BYQgud27snzTvLcH
         fIzesaEXKx/B4IazASg42kpHHKDM7W+5wp8gh4nDNM40MzKKOmixDbal0llYb08MiCtB
         g8dd09yVXxJHYntk586+fEvG1EYdOrom9+lkQrchkR3D9fekWXQh7ML/WM0mFztl0Trr
         n2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748807660; x=1749412460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeF/949IPaTKS3FEiz0D2QNOdvwROIAr78Br60q0vkc=;
        b=gr/dNQhMzqR9in+TvTvqnVG1BkHWW1jHStyy1voQv2CmVlsKOeJRODoYpt9KZvR+uI
         Bd1VThWU+Y5KIg0Giun4ZGPgsy07NVdgYq+5EmWLefUcP/hHbNHkJ2zpiDcaLfQLD1l3
         Ta27qGpAkviZneBvA5JM2Ztoe+hm1CHEP901fdoT08eoX8vzAknlj1ReDrU+HXzyjb68
         vCx4cjmzGXBVVLXyk1vyBNQORh3sbK3sUPHcgFoghmj4XTUT1eFoskiHWKt1Q9YdmGqL
         FMqgzo8Mrq1KeGuZXNJqDXWJCpmAS1NbNqqjF+Nr/WHtbcMTwsYMhedbr7jaQ2xGc7he
         vRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZOX+Zw3UgAClwjQrh0zBFCZIUIRgWacO++aHC7sxUSKpLu3pA/H026pIuzOwlIPDftsRNjm+KxU=@vger.kernel.org, AJvYcCWibdqAz/IajWYRptHKEg9z9aKtUB/DDOEsz0rCc7C0bkwF1pdp+L0JiRu1uLmYifwYE0wTTu/0EvSQ@vger.kernel.org, AJvYcCXu1JvRwqhiqppDISKgqFMglQj1dJMUwUMlg3gV4GgvxN3mKi4laA4Cg3uL7WlkznK7W1XaTJcrK3jG1T31@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHS8gOgQnIHJxICUVLOLS1KDsGHxuG4hPBg4L+KWDKEovpeT1
	mfnQFISy3FuT3r1+B+mZe13Gyn7WTybThqxquz/fWKEogxB7GlUg0M4Rnbteqboy+Ts8HrHURfj
	er18asl7Gts6YPvOcdb87hPhKbh9dsnc=
X-Gm-Gg: ASbGnct8tbzOUQ1lHYKtd+whahjwFTlEs4kiYqBANZZPvpQNeTCH40WXO6EtfZMzVBr
	227gpLpikPO2ny031axEXsDmY5NlB57YrvWvPjvAIkhMjFOPxfHcmNP522RlpU88APHozKxPCOQ
	McSGn6E+gKdfzZIb4UMqclebDD8jlmz/l0
X-Google-Smtp-Source: AGHT+IFeiRxISUrPSwHaJZo2F9AfzgmgvdlWWkKx8O60ki8IaOmiTIlD2glCFQ04x3ZnrEYWSt5aIWE5XAIJX5ob2VY=
X-Received: by 2002:a17:907:2d9e:b0:ad8:ac7e:eead with SMTP id
 a640c23a62f3a-adb36be22a1mr872958566b.39.1748807659567; Sun, 01 Jun 2025
 12:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-11-l.rubusch@gmail.com>
In-Reply-To: <20250601172139.59156-11-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jun 2025 22:53:43 +0300
X-Gm-Features: AX0GCFtzLuDg3Z8rNDToVIodY39D5KaVGPsm9B3o6B-8A-k8SanEKJlCDCWwF5Q
Message-ID: <CAHp75Ve+f4c-aVD3vMfi1NP7vohJWDFFO+F4ckYCKkw2iYDsFw@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] iio: accel: adxl313: add AC coupled
 activity/inactivity events
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com>=
 wrote:
>
> Add AC coupling activity and inactivity as MAG_ADAPTIVE events. This adds
> up an additional set of threshold and period handles, verifies matching
> disabling functionality and extends setting the link bit to complementary
> event configurations.
>
> This means, e.g. either ACTIVITY or ACTIVITY_AC can be enabled. The most
> recent set will remain configured. Disabling ACTIVITY where ACTIVITY_AC w=
as
> enabled is ignored, since it does not match (should be disabling
> ACTIVITY_AC). When INACTIVITY or INACTIVITY_AC is also enabled, the link
> bit will be set. Note, having the link bit and auto-sleep in place activi=
ty
> and inactivity indicate the power save state change and thus will only be
> triggered once a state transition occurs. Since there is a separate AC bi=
t
> for ACTIVITY and for INACTIVITY, events can be linked independently from
> each other i.e. ACTIVITY can be linked to INACTIVITY_AC for instance.
>
> When one of both is disabled, the link bit will be removed. Hence, the
> remaining event will not indicate a plain state change anymore, but occur
> as a periodically triggered inactivity event or for each activity event
> above the threshold.

...

> +/**
> + * adxl313_is_act_inact_ac() - Check if AC coupling is enabled.

> + *

Unneeded blank line.

> + * @data: The device data.
> + * @type: The activity or inactivity type.
> + *
> + * Provide a type of activity or inactivity, combined with either AC cou=
pling
> + * set, or default to DC coupling. This function verifies, if the combin=
ation is
> + * currently enabled or not.
> + *
> + * Return if the provided activity type has AC coupling enabled or a neg=
ative
> + * error value.

Missing Return section. Always try kernel-doc validation when adding
new kernel-doc descriptions.

> + */

...

>         unsigned int regval;
> +       int coupling;

Why? Doesn't 'ret' suffice?

>         int axis_en, int_en, ret;

...

> -       int act_en, inact_en;
> -       bool en;
> +       int act_en, inact_en, act_ac_en, inact_ac_en;
> +       bool en, act_inact_ac;
>         int ret;

For all your patches: try really hard to avoid the ping-pong coding,
i.e. when you add something in one patch in the series and change in
the other for no reason. I.o.w. when the initial code may be written
already in a form that doesn't need further changes (e.g., switch-case
vs. if).

This patch is *very* noisy due to the above. So, just slow down, try a
new approach that you have less '-' lines in the diff:s all over the
code.

--=20
With Best Regards,
Andy Shevchenko

