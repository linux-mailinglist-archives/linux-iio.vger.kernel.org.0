Return-Path: <linux-iio+bounces-26786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ED1CA7F41
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 15:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F879346E5FB
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 11:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18D261393;
	Fri,  5 Dec 2025 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ1pNoqb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1830FC18
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935934; cv=none; b=pv7YvyFCoRvsGWFokNHP5NwX4SQMh9+fhJl1LgDChWvC2sXcmXJkt2K4fxpBox3c3OwMLHJJCXUYxgxIGEUVXbmodqaVLOLJHaK4VCu+zWiga/bAm/EwMz7YhJAQrNRxumt2M+REkBGgbUN64DT4Lil7wkxD1x2bVJzCjXLyAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935934; c=relaxed/simple;
	bh=lEZZkQWnaU+vr7KPvs3gPQC+5s7NTOG0wy/s0uA4OEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmJ/o/Dh/TLFQVhfPZbnp/FPCleh3UdvNC16SQCh2pgiQf4aUCEhH0Ja4bM+4ESDXlk9NC/gQtv+4Tp5YXMXYIYiOM5r9OCVH0N+u+SctFxxWiNc3RncxJEYUdJbzBFJjBE6lRd8t9c8p0J/2iC4L0kNFa8Bv9erpCWnh6ZzaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ1pNoqb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so319227666b.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 03:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764935927; x=1765540727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEZZkQWnaU+vr7KPvs3gPQC+5s7NTOG0wy/s0uA4OEQ=;
        b=CQ1pNoqb2QvMePgOd+65217yeXmfjjpz/1FhOw3vDKpROQkT00TvilT5roTLadHh4X
         ZF9VPLcBSjZCPGAhKx7Q8u4Aq5m9G94pPfWqGIbxOCwakJi3sF//0sakyKQilSDZDFz2
         B1wgfn6DmnoLKWMdZ2np61OFsYtdnaIVQRL6X1jjVyQlWuvxjZMtogzZSIo3vJDAVy07
         ie3p3zX+FPuU8UO7vPHA7NLfpEtGyPam4BvhjvZpuFbRFTOW89wsWET21eMrLDpvYiSU
         52gHxSc/SDJ4mB2o0LbjYOrbw5cm7fEk30MjS1hUXWVxjH8PDkgupx/lKDQXktp4Yzh7
         1oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764935927; x=1765540727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lEZZkQWnaU+vr7KPvs3gPQC+5s7NTOG0wy/s0uA4OEQ=;
        b=wPfp+LO6/czsqGGedVMgiKqGK4YybNtGePLRnw+CscoV69O7c3tXHiijQ/GfOL5Qlr
         oXjGWvnTUaIAUqNbVmyR2Sh/cCDXqGnJVGFgafWR2eqem04bjyCuar1z5CsED4lc8Ck2
         vPFYzintfey4HLxTLWOChpQuIo5SFUHbOkcXRKIpB9Ye0BGdm+zmRYq1t3v/AjOmmNVx
         CMJHlXOsWYuSdmKAU1IdvnMthrrsQ8zWRADyqqWwBrmyi1RMTr9DtVF0bOikoGq2M4HZ
         UXCvr+LV2oshP0ZcCTub5KGv7ly0WKm6AE6RR81YauEW0i8SiOOsGXNNiqw/TBK3MlMk
         4Krw==
X-Forwarded-Encrypted: i=1; AJvYcCWGjOr5S38T/8YobH+41obALG8gsWIIdXeF0R96HamHhITg4KpUkoHdkjz6g/o9qVrrfJOpKnRgsxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuzz93RL5agwelD3pjvBzYBaUv892doNK+jw5eE21de1QsmK8b
	CoN4BPI8yDQERm0zcROLlqp/UxOghZuDqAj8EteEU6Cuqvbb+SMOu26xvFmu/5kH59q7Qral8IY
	TF4W2Gww9dp0QS5xkDJxhQtFsTnzUuII=
X-Gm-Gg: ASbGncsr/mos9ACmU/gW4a4PLBwHtotOPSjsTOVji096f6c+0YRCk+QldnDX0UkS5B6
	LhY3S+m16bkERlgNeq1Je41B3+PglbG1tCpGUw++0oWHhljIMpVyuYxS6/mYzM3Qa+MYJ68/4se
	jRtPuIf4ApOvv7xu4mNcXcr7PGoEEHB4+rXx1cv8CLY2COP7V8bnbZmnSlyBivhbP2GrCX5aaAw
	EPdQnaftzh4vvUyn5oFXrJx1MzKOHeA5PFQuBgPPcFxDoMv9gzttZIVWg4CpR4w5LY+OPkN8aFy
	whM/vq71QZ10iHZG4LvIIoYBjmtWr0ClU2x5qJSP8ShTj9Ie6OaCEWAsC4Zw5ZDRb7Iu0dq9JS7
	9MvSNBg==
X-Google-Smtp-Source: AGHT+IGZuIBDfgxNGOQaoh5uGGyzQyLCvmjAErNbL1JjRFzrJqHpSNBaapzTPHWiHoSEvTakv2GPBIiwnERR+AT8FCY=
X-Received: by 2002:a17:907:7fa4:b0:b73:43ee:a262 with SMTP id
 a640c23a62f3a-b79dc734f36mr1099263466b.51.1764935926694; Fri, 05 Dec 2025
 03:58:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
 <20251204-iio-axi-adc-minor-change-v1-2-2d441d6c5b65@analog.com>
 <CAHp75Vc46cy7vGPAHksFB5QT0Mc_ztGaODtyLeEQHveNrYKg=Q@mail.gmail.com> <d385344e47410305be75aed6ad1d1183cb93d450.camel@gmail.com>
In-Reply-To: <d385344e47410305be75aed6ad1d1183cb93d450.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Dec 2025 13:58:10 +0200
X-Gm-Features: AWmQ_bl-ijsDmnO2LJEnty1816Tl23j4i6rCrf75hNf-brywH0pf9J0RCg285bc
Message-ID: <CAHp75Vdk7tsqzf04SGWuCY+=q95HhA0A4dQy15QceGieQqQO=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: adi-axi-adc: Turn dev_info() into dev_dbg()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 1:24=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
> On Thu, 2025-12-04 at 21:11 +0200, Andy Shevchenko wrote:
> > On Thu, Dec 4, 2025 at 5:23=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >
> > > We should not abuse logging and logging a successful probe is clearly
> > > abuse. Turn it into dev_dbg().
> > >
> > > If it turns out the IP version is that relevant we can make it easy t=
o
> > > get through a new debugfs interface later on.
> >
> > Hmm... This prints a version information. Does the user have different
> > means to get the same information?
>
> It can read it directly from the registers through debugFS. But is that a=
 blocker? I mean,
> there are tons of devices where we could potentially print some product_i=
d or silicion rev but that
> should not be a reason for bloating the console, right? Or is your argume=
nt that once done, it's a
> bad to take it back?

At least when one of my regmap patches regressed, this was the exact
information that was printed by the affected driver and more or less
immediately visible to the user and/or easy to get.

> As mentioned in the commit message, we could add a "version" debugFS file=
 to print the same info but
> that would require a bit more work.

Not sure it is worth doing so.

> Anyways, if too much trouble, I can drop the patch...

Up to you, I'm talking from my own experience.

--=20
With Best Regards,
Andy Shevchenko

