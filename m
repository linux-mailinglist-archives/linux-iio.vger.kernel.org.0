Return-Path: <linux-iio+bounces-21984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C347B10E2D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 17:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A4A3B20CA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CF72E92BB;
	Thu, 24 Jul 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPEUYhPV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E8171D2;
	Thu, 24 Jul 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369238; cv=none; b=Z1YCjACecbU38dWmFVLzRnPGbyTBlGz0aldu6mAFYKkl08sU0cGNzWzJ61qGkcpsqLOnUN9QSLbNsdxLFbMzquUpfbsGTL/k1ye3xbVOeq5/J7GXCPqUFe6dcw50tLM1W2i7BptxFC+g5MgyyHfk0jV76nuUx4cXoYCq7m47ZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369238; c=relaxed/simple;
	bh=ZxmH4SzikF5TKcM2bbpbFcFuDVbo7XgJ+M5iDeTGBy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osM4vzvPFqnmlvQUOa7EvFEPA0AgdxwikZipZFHWsleE3UeKlRKVSc53kMLIiQfTCOMa+TrmXmO2APZ0lfbZSCOz+F3pEAYsx4QdEUzx7lHGsaV3hrHcqXoRwuNNshGAaShjIcU+4pODkZllC+WxrK0QvA3U5TD4Ltj9NvKlMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPEUYhPV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso9283321fa.3;
        Thu, 24 Jul 2025 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753369234; x=1753974034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEO8jnwtS4YFL1JVgf3rJ0dp20O+pYUiFEophsQJcsg=;
        b=kPEUYhPV8hEs3MW9ABuBsIROntyn7MbNBHtort5Btp4voV7zQCPYl1nPe7/xvgLvIx
         Vgd/QsIpHqGzxpZ8MtLtajx+zKK6hMXL5KjshXCYdnGdFMDnUOWfEoC5gn9e0tepB8sL
         hH2/27xXgnW7E8u+oLCZN2BRzO/C3BRJ7/IZtFA8nnO3mJPgkdw9IVw87XEEBjhBv+dX
         WQTAtkeTUMihR8SEj+AuwDJtok7yEgR75zzjnhGYwfWUAi62k+JkvTmHWh9q4Dx++xU0
         oT9PW/+cmsyRbdHtwDWHiI9oX68uj8GoBBYO+kLbQ+2JmvRNw0WUJN9+Ss2Ul+YONapl
         xg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753369234; x=1753974034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEO8jnwtS4YFL1JVgf3rJ0dp20O+pYUiFEophsQJcsg=;
        b=QxoGSPjjUDrNvFEV8kANKw8m+8LpBhG7wsidsFaYKDhPU9IudLbmx2Es4/37VqpWlq
         6hA4pfW6H6qOqhnDLxWJ/0sxgBhA7o8WfacTwjRLTJkEs9e1qoa5mx4NLBFTvDknluWs
         sVc7OrqTcA15G3n0WZOJ/852rp475ffoM+msBB21pR8yIkbgGIRAI3ddB9qtiFW45yBg
         gccuaU1jrXr7MaVduhGPrRoY11UVrUkMBSEb6nJya7Fk/cdGfZxzaklGm6UVN1uA6yNO
         oJKDyz08jl5PU1fhtScP1oteLYENNHM7KEq3oC5u+cQkbLlxdC+69iEbaoJepAFq7TD7
         Y9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUStClljwola/0+zvpPMzmMtpsBQk9ju+duKuDXQNoVinCXsdT5RsP6onIoQAR4XFP8L6AZlvy1UOk=@vger.kernel.org, AJvYcCXy5ehFfWQjjoyul7nn9z3ozBEcxCv2iQOh71j6I7dXm/Hju0AhppVh0+c5Mm+Q/ZcBjfXJtQQHVQXe19bN@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHv5id1zuKNz25c8bzBOWVca76kH7dsgeVSMxG4pMCpOHGjNP
	h0vyhKcfGNHQbJ75jkDdnT+yXYf7G1l2+SXn/7hlbreNURBBzaMVWhC7Vf7adhANRukV21CQqtq
	OMuqbqW3JU3QMorsyhk8OcOhmEx+vsO8=
X-Gm-Gg: ASbGncvlqdF3sfVxN+JTiomiT/wjhJUeDjCnY6vruiUm9PUT7qk8VAyHmMa5/WeTQ9f
	hY3CUp0B8kRgalxb3/nDvrDpuXdIUg7cy4jvxTJvzKLub9uZVr6adetC4I5CmYc7UeAKyHw+90O
	SciG4M19HlNLB2DSkWPCB2arf4x8vriqYPN2uLYlF1gBePgKDu+BuQZ1tKHL8wYED8oEIh3Xn7L
	aiOnqFjDSDBvqCB6swHK6hiFIUFwm6Bx6vZnaLN
X-Google-Smtp-Source: AGHT+IHbsJdiT+jnLJxAf4qFtrpWQIp3muxOgWuyXIWP7IbvRlKO+xXRZy//g/lV0xYJRGskC7fawViVSkRbFgFpKVI=
X-Received: by 2002:a05:651c:10a2:b0:32a:7979:47c3 with SMTP id
 38308e7fff4ca-330dfca2d90mr13895731fa.11.1753369233248; Thu, 24 Jul 2025
 08:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723180457.629833-1-akshayaj.lkd@gmail.com> <1abf4238-5bf4-44e9-9a4b-41838cc9e472@baylibre.com>
In-Reply-To: <1abf4238-5bf4-44e9-9a4b-41838cc9e472@baylibre.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Thu, 24 Jul 2025 20:30:20 +0530
X-Gm-Features: Ac12FXxDJjHmNE2jOgrSDG0180sR6BTDzU6Pf6OmTLqME_ElvamHfOhzl3gw4Vw
Message-ID: <CAE3SzaTAAWKpwe0X6969tzfhoj4px1hEuEu-P-nK-Hh7axDHUQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Add debugfs register access support
To: David Lechner <dlechner@baylibre.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, 
	shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 1:44=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> We don't need separate lines if there is no gap. I didn't check all of th=
e lines
> but at least these last two can be combined since LTR390_THRESH_UP_BYTE(2=
) is
> 0x23 and LTR390_THRESH_LOW_BYTE(0) is 0x24.
Done. In other lines there is no gap.
For your convenience, I am writing the actual value of these macros as comm=
ents.
static const struct regmap_range ltr390_readable_reg_ranges[] =3D {
       regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL), // (0x0-->0x0)
       regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE,
LTR390_MAIN_STATUS),//(0x4-->0x7)
       regmap_reg_range(LTR390_ALS_DATA_BYTE(0),
LTR390_ALS_DATA_BYTE(2)),//(0xd-->0xf)
       regmap_reg_range(LTR390_UVS_DATA_BYTE(0),
LTR390_UVS_DATA_BYTE(2)),//(0x10-->0x12)
       regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),//(0x19-->0x1A)
       regmap_reg_range(LTR390_THRESH_UP_BYTE(0),
LTR390_THRESH_LOW_BYTE(2)),//(0x21-->0x26)
};

>
> And we could avoid adding the extra macros just for this since they
> aren't used anywhere else.
>
I only added the following macros:
+#define LTR390_ALS_DATA_BYTE(n)                ((LTR390_ALS_DATA) + (n))
+#define LTR390_UVS_DATA_BYTE(n)               ((LTR390_UVS_DATA) + (n))
+#define LTR390_THRESH_UP_BYTE(n)            ((LTR390_THRESH_UP) + (n))
+#define LTR390_THRESH_LOW_BYTE(n)         ((LTR390_THRESH_LOW) + (n))

I can remove them too, but then in regmap_range, I will have to
statically write like you mentioned.
regmap_reg_range(LTR390_THRESH_UP, LTR390_THRESH_LOW + 2).
That is also fine, but I feel that using parameterized macros is a
much cleaner way, as also mentioned
in v1 review comments by other maintainers. Let me know your thoughts.
I am happy to let them go too.

Thanks,
Akshay

