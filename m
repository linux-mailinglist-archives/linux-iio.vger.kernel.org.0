Return-Path: <linux-iio+bounces-18444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED69AA951C5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08F77A4409
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378B1266566;
	Mon, 21 Apr 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSiRlQM5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF5264A74;
	Mon, 21 Apr 2025 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242741; cv=none; b=jlBDa+C/T+r9Bc/XCJbab9QKS3wNLYh4thY8bwXtTrHW+HLxOwSJsiVkKUuYf8seTtCZkXLthW+SJ4UZ56oxzki+Th1O7CRufZMdhOE7kasAX+1OFZhL0GpsSA/Q/4wRdZgPRk+sZmO3TNoYUlXNTCzP6s+xTcolXFfVd79p98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242741; c=relaxed/simple;
	bh=8lR4YawUzxF9gm3YTPikm58kY0KHQCev0m6IyQOjNmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt7fqhrSjASoCz5MI0Qqnec50p34yIdiQpuu2OYhJqgKwt70calMqawycaBhYJTXValrfMBZ1rSx5SdH0wDaa8R7EgSknZNcwmEoipBUKlgMUgCS1nPEBhvOWzqwhoVkGQoR/6C+v9WASJvPwYP/gKAPMuJ5g0KohMM8evnZDMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSiRlQM5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47662449055so19683211cf.1;
        Mon, 21 Apr 2025 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745242738; x=1745847538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lR4YawUzxF9gm3YTPikm58kY0KHQCev0m6IyQOjNmY=;
        b=YSiRlQM5jfYzOphlUfM/3Sy2v/Kv0+bqgt5Id32OGl3n127P1oAy0IYwOlnqGWWyqE
         Dbtu/cWZ9Zv0AWBnKL63NaPNHYLr83jB5MlM90wOOmA4uiHenO9VrJFGeMUj8gq3+5lo
         mLEqK/y4veIMmLO63+SoA+MVYOJaWQa5KqiBchkPgX02Wgk7LIrMI5DxjFe/DTPewgPM
         Tpv2VThj/Jm4uGNIPdMvgZ7g2MHFwAE3j7frPtOoIrYcG87U/m4+IcUn5ITqbrRh2aVw
         +OjJwgcaiQq0G3VwRfa+h54RpDEYcG4AQUvrP1FN9katec5NW6c07Hmqe4Tu3LuR8gTZ
         ojWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745242738; x=1745847538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lR4YawUzxF9gm3YTPikm58kY0KHQCev0m6IyQOjNmY=;
        b=KXY6+RAyKWHCgehfEMGXu/3WMY/ablLyyS/oo0ckj4p18CniimOpMoS51eEm5ZHn1K
         WtyD3GB4GJjofDkemGplM1UQKkLHlDKr9JbI+D+8IjImXNwcEWULZzPolI3bH6HWQHiY
         k3+iJlN7oGQ2o/wCN1Rdl35jJSriBEVCt7vnGZaoqYlQQRZKZ0j+xJDH/t4mRSS5P8bj
         10OFcse2jMG7fSGJIiVH1V+SKZ81gf9SBAFyApv/2kD6ZCmN5lmDrLmdmeOOGy0BrovJ
         oINRlrOZqNBALwKSFLJ102ZiH2owzOoks6QKEsjAS1B3WSuFOPW7AtSFE4uGMk2zO9xp
         n/cw==
X-Forwarded-Encrypted: i=1; AJvYcCU99Of+L4HKqIiM5mRcKgm+gxpkUbLcJlUybBrQo8F8uKDrttcOOyLGUQYgCuIU2B0hw/bUopNNeYE=@vger.kernel.org, AJvYcCUbSel72h4yczgAaqCCjtbIVi1IR738qfttwr5yQEcP78hlKb0u1Jqq8+rkuqq9A23rKGGPmuOIO/INdmVy@vger.kernel.org, AJvYcCW1ErFa+6rSYgzQ8zrP8iAXHZdC5hZaSmV6NCM8hGP34e3yW9LFpFA7JqF87EvbM9DROGzJfg/y@vger.kernel.org
X-Gm-Message-State: AOJu0YyKitcE/Q8W5r6/gACQH0ep39ZlbDFGxdGDzCQq+rz/dJB7zrlW
	brYhfWU44BRn2Lrdl7P4ivy0k1rW2tH+CwSj+zpUZzXorwBro//FibxPw5m62Yw62rOiZW02VrK
	IfuUONso2Sbqq8065TnERLppSing=
X-Gm-Gg: ASbGnctPORP+afnkOYinI2HwCAEtOwJl4WrA27EGPfb+bT9TO6wBEujycV7PXrvPiQ+
	p8LQGsghVgwa9nKuNax0AmPT0gjk1nB30yitQpBjr8og6wgccxyPLDT+JHDIo2Ton8KvZkXhtQl
	eFUKqbizvkqhQX2v0Vs3NbULQOsvMDA43rEpZ6L21alYjHAYY4kGS/fQ==
X-Google-Smtp-Source: AGHT+IFDANpJcqnxiNwpvLo83FTQELypzcIlu5k2ebGCf1WLDh5Z68JcqVHI4AdI9K1kJkqM+xd7gDHdkC7A/R1Jb/Y=
X-Received: by 2002:a05:622a:1998:b0:477:5d12:aa4d with SMTP id
 d75a77b69052e-47aec4c3d22mr204747991cf.39.1745242738187; Mon, 21 Apr 2025
 06:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417135434.568007-1-gshahrouzi@gmail.com> <aAQZrhBLQCa0TjOJ@debian-BULLSEYE-live-builder-AMD64>
 <CAKUZ0zLMAZFHwvuqfoL6JZfphYRhtjkqOyi50_ZffbA7-4MCew@mail.gmail.com> <20250421120749.66b04533@jic23-huawei>
In-Reply-To: <20250421120749.66b04533@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 09:38:47 -0400
X-Gm-Features: ATxdqUE_17qAcsPlqPvvpcyUwPKjF9_hB_0h8fmZDEfhDjZVt-Rp-IXf8BtVm1U
Message-ID: <CAKUZ0z+AvV6XMk3Fe+qKs+DnUHESKjj6pwSNmgSc-PaPKCCWGQ@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: Use SLEEP bit instead of RESET to disable output
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, gregkh@linuxfoundation.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:07=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 19 Apr 2025 21:41:50 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > On Sat, Apr 19, 2025 at 5:45=E2=80=AFPM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > On 04/17, Gabriel Shahrouzi wrote:
> > > > According to the AD9832 datasheet (Table 10, D12 description), sett=
ing
> > > > the RESET bit forces the phase accumulator to zero, which correspon=
ds to
> > > > a full-scale DC output, rather than disabling the output signal.
> > > >
> > > > The correct way to disable the output and enter a low-power state i=
s to
> > > > set the AD9832_SLEEP bit (Table 10, D13 description), which powers =
down
> > > > the internal DAC current sources and disables internal clocks.
> > > >
> > > > Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > > ---
> > > Looks okay.
> > >
> > > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > >
> > > Unrelated to this patch but, if anybody be looking to work on getting=
 this out
> > > of staging, I think maybe this driver could use out_altvoltage_powerd=
own ABI
> > > instead of this custom out_altvoltageX_out_enable.
> > > Crazy thing this driver doesn't declare a single IIO channel.
> > > Seems to be somewhat ancient IIO driver.
> > I can start tackling this.
> This has crossed with a series from Siddarth.
>
> Take a look at what is in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/=
?h=3Dtesting&id=3Daa703203cbbca22ac46d42d4cd41232491827152
>
> Please rebase this one on top of that as I think the bug is still there?
Got it. Yes, I believe it is still there.
>
> Given there is work going on for this driver and the bugs are ancient, I'=
ll
> not take any patches through the fixes tree for now. Instead I'll just qu=
eue
> them up for the next merge window.
Got it.
>
> Thanks,
>
> Jonathan
>
> > >
> > > Regards,
> > > Marcelo
> >
>

