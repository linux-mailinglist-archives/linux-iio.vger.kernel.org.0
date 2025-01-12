Return-Path: <linux-iio+bounces-14257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00272A0ABC8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 21:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D555B3A7868
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4DE153BF0;
	Sun, 12 Jan 2025 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZncgMr9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01E6FB0;
	Sun, 12 Jan 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736713202; cv=none; b=n64h1l5kCk0p9l4zuWnoo3Ieqsl8WHjpf293P8Uj67D5nGqx4RbfSV4CxletO8JXJh3wttPl/jkkbdPU0kzTKlEsScsrCj+Dr3UrKykrUw0Pl5kXQbRtMQtKy1wp1UfSrZfT7ZX0/AmJC2be6H5QdZFFM/RoOhTt5aCGkoEtjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736713202; c=relaxed/simple;
	bh=4+mIAIr930Prpzj1FaDZjN1RyA411FUplHJhp1K5MtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB2xkMxLwKThQA1/f22vOYSKJnwVQDrwQUG4HOqa4uRhmN7CS454rHKDqVFVNnlisH6kZ+TVru7zQzF3YbCx/kXAE2gJgZuGD8X2M7QNuyQHTVYW63WJingSwSOIWSeijZ57FNNR8Z3LqinPUzxZIznMfFgmvOXP7BISuQh4xv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZncgMr9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so549081066b.0;
        Sun, 12 Jan 2025 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736713199; x=1737317999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP5Jxg2wXZ19Fu/fF7N/KGBsAjQNWcYFvwoHEJIua1I=;
        b=AZncgMr9bBLIDW6BNc7pJhqXliVlU3sYTWLPqZARzn8zuD/s80/qZwlvE0fj67cW/r
         6jJ7tGRI2+9tUhWtamga4sxMTzzn2Jl5MCFV1ctKxH5cQVnJsg775+LGcR3cGh11qtyt
         rXc6nNgG/pMmwISLdNs2zQtauEcaooxjvFu3fP9sXhoyuz2aTgQ+jAlOHrZXoH61XAoZ
         dLu4Ngm0xyZ71KbecfTcQ1PcGGAl9yBlog9ve2oJlEGST2zAievKdHbjFddngGQ/8lnn
         tsfL7h8NXIB+8KhhylXNOEL47zOjb28TdaxmufNacX4gJaiOSrlGz8ViEoLljc43W8xS
         FrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736713199; x=1737317999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lP5Jxg2wXZ19Fu/fF7N/KGBsAjQNWcYFvwoHEJIua1I=;
        b=Jo1+VgvoHkZol7SubkfOm7IMAQeM1rR6vS2v8utFc/vKtzZeCmQQta4t8wp30dA12r
         Xne5+zFpgEKuxIhMtWWEPxIXBxoC40/8vy2r+L4G3XhFh50b1Ef0FJ+cq22qEkDthfsf
         ySMJ6Gqj6z43ow6wls6/xncxLPPX9edVeigWdduLTmp5XIOnJslfLpd43NP/iBWXBBZ/
         oAUi/KwtX6y4j/2X82c8VhKtrU+evjPhJKeR+EzhfNxCPf2LNtcw29d2n2VdpJOsCRbP
         AQ5hh+Vp0XMgohvC9JaOFh8pC78Z96ZiMvx4mbxvEE9k0qOxFqv2nr+Ez882KB/ecPMZ
         Bzpg==
X-Forwarded-Encrypted: i=1; AJvYcCU4woFaulrJwpGrhUHrwZeRDW/eLxbsC6zN6H081nbE+jFIb1VORLj+89O90nX/rUBPr/bqhK4kMow=@vger.kernel.org, AJvYcCVMN+655UGR3B6UsKj7TpIeVdeskK8Zk9VXyzUZlGbKTH6hoIV06/IB1RiipPAS1kbKdijBmL5bgIjK@vger.kernel.org, AJvYcCVeFpn8zbLRxPje5eAqwrQeHf/IJCz3XUngR64O7Hpgtr0RvIsYSxqbJwjmp234RqqfQ7GidvqS2B5QrwtG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3vCoj7ASqCC4TjpFGziUQFImqhKQKwzJdYrwYhHrwJ681tdB
	G7T+ujMFwhtrU7qrel5ivGpYZA40ff7YREHPXC/zT9Ac1dLZn0J3seXZh74npBhZ60y53NQ1Qts
	WcKGazNIZ/cq2LqWCcqvO8Wj30HU=
X-Gm-Gg: ASbGncuhfCkKWMJovUYOiHkaWCzM70JDcQRgvrpDmJxRiNLHbDNonN/avFd50wkM0WR
	fcjYJGqbX9xYweOGa0l0MxlFvwvpQzWpDPRbEIg==
X-Google-Smtp-Source: AGHT+IGS1Y2cgvlqundn2qG2aMO/mymRD0ZF/+1OhbjGrsPKvt6UYU3inEl2o/CtIBuo+n0udEcNKHhmHd/Lrf3dtK0=
X-Received: by 2002:a05:6402:278f:b0:5d0:ed92:cdf6 with SMTP id
 4fb4d7f45d1cf-5d972e1c66bmr39582523a12.19.1736713199106; Sun, 12 Jan 2025
 12:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
 <20250108-ad7380-add-alert-support-v4-1-1751802471ba@baylibre.com>
 <Z4Pt9oZEkfQMuYUm@surfacebook.localdomain> <20250112164201.067ecd9e@jic23-huawei>
In-Reply-To: <20250112164201.067ecd9e@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 22:19:22 +0200
X-Gm-Features: AbW1kvY6hIIff8bYrCsKiFhV2TzELxRISxmDGvELlofqGm_Occ_U8R9FclAuHUE
Message-ID: <CAHp75VcjakHxSE=9=WAbkJOXQ53PJPrv43trrxBy6Vh6+KK7eg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] iio: adc: ad7380: do not use iio_device_claim_direct_scoped
 anymore
To: Jonathan Cameron <jic23@kernel.org>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 6:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 12 Jan 2025 18:29:42 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > Wed, Jan 08, 2025 at 01:49:33PM +0100, Julien Stephan kirjoitti:
> > > Conditionnal scoped handlers are turning out to be a real pain:
> > > readability issues, compiler and linker handling issues among others =
so
> > > rollback and remove the scoped version of iio_dvice_claim_direct_mode=
.
> >
> > Is it IIO level decision or you as a contributor to/maintainer of this =
driver?
> > If the former? can you add a Link to the discussion?
>
>
> IIO. Agreed a link would have been sensible here.
>
> >
> > Otherwise, I would like to understand the common approach / practices i=
n IIO
> > WRT individual drivers to deviate the common approaches. Jonathan?
>
> Patch series on list ripping the whole lot out that has some more explana=
tion
> and links.  Basically we never found a way to overcome the short comings =
of
> conditional scoped guards.
>
> https://lore.kernel.org/linux-iio/20250105172613.1204781-1-jic23@kernel.o=
rg/

Thanks, it was an interesting dive into "how did I spend my holidays?" essa=
y.

--=20
With Best Regards,
Andy Shevchenko

