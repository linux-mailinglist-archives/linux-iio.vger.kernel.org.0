Return-Path: <linux-iio+bounces-18359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E08A94654
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E23A747C
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80671D540;
	Sun, 20 Apr 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB3d/ggH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D62F2E;
	Sun, 20 Apr 2025 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745112183; cv=none; b=B8GhE6gP8e1ujSiRdhHahOSmIOb5QGIMAGdoy/JlZdmV8sr10hChWpDkSzjRoTwNnncsuYSHxWnru3Q1V6/yzZg9BRpsWZI1T/XCFdjmbdsS99oSiVfWJg2qKU1Ic/x2p/omwsJJkPV3g2ja4GUcujdg6S0pqLv7Rzwc4jUfR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745112183; c=relaxed/simple;
	bh=KhWPpz4h7daNdjBLjmP9Myi2nI9UnnKN8WWqx7NZ9gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7LFh78CPZBpsvv5xukRcGoihUriEyPdNq3MPcsa4U3YZpkU+fsC+hHmm3/g7dj7ipW4rRx87gQtlFvUuIojZAd/Pu/kUWISyVypXIeIbgOYIfqtaehesbyurK8beV2+bEiSZ375wpmFV6IwtvBEYsburaQj75JQ2Z54zqz8tIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB3d/ggH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476a1acf61eso29341831cf.1;
        Sat, 19 Apr 2025 18:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745112181; x=1745716981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxyqKswJBcd23O6PGhjqBc5AEkx9ltkxdSYxex6zxdI=;
        b=IB3d/ggHnMhxFdqCj3+mofPPPvRafI5QMKESCwuEgXSiH8a24dhUFt4uCHsZ2kQeGD
         T43jnujhvk43VfLt7GkV5pv5Y88ueOE1WDii1IO2dXDLBRVPYEo4U2L+mZ7tklb86AuR
         YRivl6tmLYCui6O/qa3HYjyUf3pu0A3jr5nmUf60KelFamlyXtanQioco/USr21mzBYV
         bjAq4vi8qiGMARmX6AMLbuJq6a7aElHmlqtx6OnbmF0PWr0n9mNDjt4RcDKiXvQ4sUF2
         CQzZQkGtOoUMjNhi5UHczd54eNrZOGvDStCKYexWvNUMeuEoawh5Ff5quIEukKUlDnz0
         kfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745112181; x=1745716981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxyqKswJBcd23O6PGhjqBc5AEkx9ltkxdSYxex6zxdI=;
        b=wAecUv4lbZtS31aW2nND0NQnUk1I28p9iylW5syWavWu91Tz5k7zHIUdjvk6nawmZd
         xDAfXx0jovu19AUi8ihw5qmt8+ZnYfDCDzvUvJTlux3JL5j3tPtun8ZQLTYfysZ6iLEU
         hB0DrHYlJh0hPaJh+w/DVIOiowPShAzRsuby8aVlh/HzvApgT5g5IzGcVk5gH3/3qMuh
         LxQiZ3WPRfrxNR0K0wXKXkuF1tQHRHHIZwclXYtMPXLhPHAs0YaJ8Q1aOaUgrixpL5bh
         8XUwA8owL0itXykfSdxi260zxu60MLUWF7nSmsiBgwTZPyV6aPc0jW4IAkP9XQp5jZ5z
         EO9A==
X-Forwarded-Encrypted: i=1; AJvYcCVmGBmPEDHf4Q/jzVA8shi2kNs5bRODrx5R6KcU6DuxoIcjS1ViSz4LOrC0378x0brX0jKdvKmziMqcMkgI@vger.kernel.org, AJvYcCXeP6d+/tffS0a13OhARaAWv6SjZ1SvswBFqy11NBMjxqZMXHtCrc1TbLGRyo7DIyG04JJ9/SfM@vger.kernel.org, AJvYcCXy0hfPyMvSYWFVR7ShcXGGu7h6ZCjuBOzhG6QizJdg2rXdZA8IsPopEH6EdI7yHWu4SuWOPAhRp0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QaSYfWcQ8fOyUhgZcC5AGMrUGGtNYNPHz7qkz3ewenlXoJYf
	W6tgbtONUwEeSnve52UPL+ZPx1wdHwdM/mlFwU+QCSw7AqZFKV+Ut086twtB976KRYF29izTb0D
	JdxMNnN9pECTiTudncIgkhzUq/O0=
X-Gm-Gg: ASbGnct3CJ2JRmb0tJOjibsiwsRHwa7ZF4HliuCUaTgRYvf3GstZdYf5+/rBfYleBGh
	F9pNpqQQhw/H2EtoVsdsbQGUtUrjvRZ9z7wUE5B+/JOZulcbFbOrZAalK+HswYtRL8DNE9Nek8p
	W8a+KEBV/bg85DuFQLQ1H7o+zxoAQIucRMF5FKZibkKiPXQJlXi9VArg==
X-Google-Smtp-Source: AGHT+IHnGYfQbcn/WQ4GGhGvsjwawX6Nw8SlnXZV+4R+WT2w1WZDDggokc+Xcz4rzl26ssEHAwXyrnla530dTrhKrz4=
X-Received: by 2002:ac8:5795:0:b0:47a:e6d1:4126 with SMTP id
 d75a77b69052e-47aec4b7548mr137854241cf.39.1745112180995; Sat, 19 Apr 2025
 18:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420003000.842747-1-gshahrouzi@gmail.com> <aARFqG--oRuwhUmR@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aARFqG--oRuwhUmR@debian-BULLSEYE-live-builder-AMD64>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Sat, 19 Apr 2025 21:22:50 -0400
X-Gm-Features: ATxdqUEwYPFWsnNKLSE1Z0Vm8Bl984yRpdhp0C5WBou58d7ANseU5iYMDnK16UM
Message-ID: <CAKUZ0z+aBu-cLKqbU6nHjSPDWzdF08z484p+s0tqMM1c1rTwXA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: iio: ad5933: Correct settling cycles encoding
 per datasheet
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 8:52=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 04/19, Gabriel Shahrouzi wrote:
> > Implement the settling cycles encoding as specified in the AD5933
> > datasheet, Table 13 ("Number of Settling Times Cycles Register"). The
> > previous logic did not correctly translate the user-requested effective
> > cycle count into the required 9-bit base + 2-bit multiplier format
> > (D10..D0) for values exceeding 511.
> Hmm, the above description should probably go on the refactoring patch I =
think.
> Otherwise looks good.
You're right - will update that for v4. I don't think my description
was accurate either since the old logic did correctly map the cycle
counts to the correct bits. It just didn't use the correct mask.
>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>
> >
> > Clamp the user input for out_altvoltage0_settling_cycles to the
> > maximum effective value of 2044 cycles (511 * 4x multiplier).
> >
> > Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 =
Impedance Converter, Network Analyzer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> > Changes in v3:
> >       - Only include fix (remove refactoring which will be its own
> >         separate patch).
> > Changes in v2:
> >         - Fix spacing in comment around '+'.
> >         - Define mask and values for settling cycle multipliers.
> > ---

