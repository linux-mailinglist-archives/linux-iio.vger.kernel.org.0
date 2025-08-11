Return-Path: <linux-iio+bounces-22575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E5B20BD9
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9360C3B8F29
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC2E23D2BA;
	Mon, 11 Aug 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB4Wm3rC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F25FEE6;
	Mon, 11 Aug 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922330; cv=none; b=aw4ejKAoiILKfWxQpkDHK1b3IAZaUpMQalX7kGc80LEANtLk6ubG5imkrd0IjDl+myjDhM7v1ak8p/umxfzZ/6IQav76aPKZiw3TtWZqJDqyfWBJ27iGIqCtjFp4vLapJxsPqddQAtCz4Urn0KJb2S28683x9DGgf4NKR4Yfkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922330; c=relaxed/simple;
	bh=iWqnGf/hu1RSzlIIZddfO5a/PW2ZykqHUtyn5u3/88c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogBynTwDQEpbjX0LCKfagi2yVWVCt04I7nJDOBHMxdlZZPfajupjXq72EPsRuydqXQhCzTC/72IPETUOW7UGgpyJwtoAnd82guBRXB71U1/YulaY9kPCFLUyLrgjaCVk38NQWydyL2QTOuNZzV7Udrboqv+BYx5n8WdeY1/EaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB4Wm3rC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6182ea5a6c0so1600731a12.0;
        Mon, 11 Aug 2025 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754922328; x=1755527128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLfTfi5NEouKdnEk0ve7RHoemhhaVCQClGf6sNPBYTw=;
        b=JB4Wm3rCnJQIaXHi7EdpbYHL2eOZ1iryp4T1Sl+SDujD2Xn2AmD0HpG8hzR/1pMixi
         1V+Srm2BU2O3w58biiF23S6Hm5lTZfg3nk9qKgmevmgVMuBmCAhtTNU73eyKN74jMFe+
         KG1xFf7BG64Yzk7W3Tv/WP98zV62fL6lhV2KIeCI5oBSMZ6cdDHycL2h1VlucQdLuNeL
         leWTPyT1DbdmG867bRaPQoxaK5kIiQcb9IIJuhbmfNv+QfuyKjfzZ/uWklHS9eenom0z
         edHhvo0aouu98C4W6ZdgoD86gTIaFvD5sV8YStKwTlh1nD2vtKoHDmGylrtiHG5qjEHQ
         r4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922328; x=1755527128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLfTfi5NEouKdnEk0ve7RHoemhhaVCQClGf6sNPBYTw=;
        b=ubOvnKjqKEf2LT1ky9Ub3SXrlnCqlZFJOsz+wTY1X3cf6CTquyUorcF3Q3kW+iANL4
         SdyrRNcMVpvKs2bZ01MMpXW3UCz+QiaU/gbP8hyUFTTXuLFih/GKYo6n/oyFjxL8KuH2
         JsjAvUf1180epsgd8uRnuKUj6H4O19QZHkb7hOITC/C5a1GZtlSdKJhGfsOWeyLNYCBE
         8ZV9HokfwijDUlvYfKxM4FuyZcQz9e7OonqS/rIm8asSP1iuzEB8OhXE3MDfPhcPjtry
         BFyU1hpbnbo/X+mYJ3bDW//SMmYcfQIXNg36WatVDhkfbMHBpW9piPNGAzwGYgv1CFDx
         3X0w==
X-Forwarded-Encrypted: i=1; AJvYcCUsWzGhgSVkgleBfDaDMzXjp63iqLdXsxW5AjPPiMWEIExoNUxF1eTsKJ+KE3p1yt0iifMoGqSinbk=@vger.kernel.org, AJvYcCWyJ97au2TeWsIvyd0SkzleHst0XFOBA0Qfayg2VhJqEPVp5rJxnxlTglyPfqcWj5WJbMW1hjwxpBN2a/QR@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0wCgrSpvHkc3VBsigyC3R3c/qypP2+gVekvGbl239qdYtH1O
	HToNrXzG3F7YMHZ/lnLtIJIJqd/iXC2fT7rdYIyC9jTL7ABPbe/pT2wcF9upp4gO1XG/KFy7M7T
	9QpFwysR6s8TbVvdGKTMDxT76TuS47y4=
X-Gm-Gg: ASbGncu4COM65GyUHRFu95zDF/7EhgASpmS5wBEGMK7Wg+xCHajBuhTJAIqU3XokHzU
	FGzULyceaQSHt1YPZmf0s62GbLJ6ndcwHQ7cttPfPNozOSIqSAZYtGEABfbUxJbagh5/hcbXjiJ
	EFMON+L+fW4HBhem4sk0ZT1j+tCxl8HKtXH+4HQxqoAvkAR5965QvK91KkKA656AIoaPH9uE05i
	IpIyfLtZA==
X-Google-Smtp-Source: AGHT+IGdU10NGg29khHjBwddhKjzTQJs2rQO8SQqzjT97HlICwegX0ze2wGY0caE5t0GfFviiUx1pTHyctKVkMMLAjc=
X-Received: by 2002:a17:907:1c29:b0:ae3:c968:370 with SMTP id
 a640c23a62f3a-af9c6545861mr1085689166b.59.1754922327440; Mon, 11 Aug 2025
 07:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com>
 <20250808-icm42pmreg-v2-1-a480279e7721@geanix.com> <CAHp75VdKNE0xD8xbJQ2RSCA=_MB9DMZtXRTCNkpdKdv8vW-Q-w@mail.gmail.com>
 <20250809190609.4fef9df7@jic23-huawei> <CAHp75Vc5CxOj77cw85hmioFTG6YJCe3ZJWwJsJW+QL79K8GpWw@mail.gmail.com>
 <yegzkmvizfcxwohvkxtfguylamvlpy3hsabkxydjwhyiy3fonn@mqjqdpkpo375>
In-Reply-To: <yegzkmvizfcxwohvkxtfguylamvlpy3hsabkxydjwhyiy3fonn@mqjqdpkpo375>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 16:24:50 +0200
X-Gm-Features: Ac12FXxR_g_-ECRSvcsngPlXK6CwvVYVWvq7G3YjjLZOjzN1FTCGFPqDKcdvpx4
Message-ID: <CAHp75Vf-WGZ53Hj=QOgeft3oWYnO3kPFXsDSD0gaAqTNdciHfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: imu: inv_icm42600: Simplify pm_runtime setup
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:21=E2=80=AFPM Sean Nyekjaer <sean@geanix.com> wro=
te:
> On Sat, Aug 09, 2025 at 10:27:52PM +0100, Andy Shevchenko wrote:
> > On Sat, Aug 9, 2025 at 8:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > > On Fri, 8 Aug 2025 23:37:51 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Aug 8, 2025 at 5:58=E2=80=AFPM Sean Nyekjaer <sean@geanix.c=
om> wrote:

...

> > > > > +       struct device *dev =3D regmap_get_device(st->map);
> > > > >
> > > > > +       if (!pm_runtime_status_suspended(dev))
> > > > > +               regulator_disable(st->vddio_supply);


> Andy, when doing reviews please keep the function name, as it's much
> easier to add the changes.

Sure, sorry I missed it, I thought it was obvious, but you are right,
it's better to keep more context.

--=20
With Best Regards,
Andy Shevchenko

