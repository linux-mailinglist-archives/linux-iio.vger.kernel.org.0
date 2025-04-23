Return-Path: <linux-iio+bounces-18564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85745A993C9
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835C19A7E06
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE85280CC8;
	Wed, 23 Apr 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1M+T8Q/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9A2820DD;
	Wed, 23 Apr 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423056; cv=none; b=eKHm0o10GQToEKcj/atO2VX95QE5QhKe+wA5zpCrtzwUvgquhoolgsCOyHeijpfZQuT3MejeiQUcRvjfM9qrRRGOl88OL2ulPximm0hVVbG2G/XPUKQJ5woFd4nalb5X8SIjC7ToalBVfqtI/htDm/3V50AcU6LB5jcx9Duv1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423056; c=relaxed/simple;
	bh=HOfLM7JjriZIicDn/FCwjvt9wB+7R2BYhmdG/mdWeLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1gXJxGm5h1OljTVcIdhNbl5u777TV+tAKxzRPedVCtdQaxGEB3MgC0SWQyBaOlztgForUq28b832bRFd7bqxYyUbJnkvNPC1i16ZBWFOYITUonm/0oJJqP+PVN65PnGpr2kbMrw5QZvFMS6VWQo29ZH0KZL3QKO6SROKVz93H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1M+T8Q/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so1349666b.1;
        Wed, 23 Apr 2025 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745423053; x=1746027853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOfLM7JjriZIicDn/FCwjvt9wB+7R2BYhmdG/mdWeLY=;
        b=Z1M+T8Q/zJJsB2rq0/J+uqx2pyEYcAIqPG5f2HOxMEqL+aTRVFl6A9k/Emmyrslm+S
         4W6YLNxSWNtfbbWaoi2wfU1YVRQJZFROEeCtFn/G7yb9uUiVnoPeoUOOgmzM1yCxE86x
         QrxImMOdRH42pbdwQHmJH7NRPe4SSCalj6mnWAtufsCGkBoGPmWxUyHrAOwbcBwV4FoU
         oIDQWdZgiJpK96Zfrn5H4qj3AOpYiRhH7UikzVZbxRNc/ZmdiQ3CYKzjxXfpqJi4r5gW
         pcgnRe3zWOr4DIb+bPgcLldh//Br1O1GCUxcpvRN5vvnkh+OL39zysjW22dfS6O2V0En
         gvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745423053; x=1746027853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOfLM7JjriZIicDn/FCwjvt9wB+7R2BYhmdG/mdWeLY=;
        b=kKABFSIU19n5IKA4gsRLxdK4IBYNe4q8geo1XbLb1qmAZEQHDrPK4CJzJxP/K94h1t
         WGCZEhoTyf9gzLo7PGfME333/x/7ZdSpgAR9Dq4q6D0cfd1Vzwv/hqkB3qKXG6Wp4vp1
         3FnCEmvE9WBBA1r07CTPOLnK9YzgjZcUnE5KOCSDRdIt+RgOUvWwA0X2jClsLjDS+1C4
         LlxyS0WPQGAEDmEwCV01C9ZWaczdVmFAcdBnGJ4YZ2pYf3/GMxOKYzlUncOFvLfIFI/h
         EnjLymY+01BKjblqrAmh4Rc7tdlzgPka+uwSewnEGyGJKlS8NDIEdneTybmVGHGah7NK
         S6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV5S9Fknf+d5YYkp1e8imBVhi+XaxwHhLEfrfGWccllno68CTfwYhIPpDhmzbL/DX67eViBgDEKjs8=@vger.kernel.org, AJvYcCXxFWwJSAhwRT0lJ0dmq/WNqqno83dyJpcx5iR/OUmtFFhq/wQZGB+56IGjz3xomTLCKicSD3cCaOUqhPjY@vger.kernel.org
X-Gm-Message-State: AOJu0YylJYnMnmZkeynWkdznP8WXurobmGTfGbkRGyzzoxzNYDyCQkaD
	T2UA1ImMjB8C23nCleL31yXszroN+0iLxsol8cqMRLq4yAIIc9JYrL8WHkpe9Rhbd+qXQTOslaz
	LWPpTy90yAl9QAajv2ITNQHMbJ9I=
X-Gm-Gg: ASbGnctIEmmHH4jDWWjM8oUOcOfsAf0vU9TuHWUfrwB5goWTKbY7cMdgAtXJEJ7oZ+N
	qcLght/QFeKcwKTHUSELzmt1RMiMtKLEw6kvA0H92zK2m/9kQPt37as98gn+DIxxFpNhScZ61Fb
	GxiWxfK48ovgmvNOnov2StCWgr
X-Google-Smtp-Source: AGHT+IEh10/g6UpR5zcfKcRlJ1eIFJJL8RU3TUMydcbdyNHCTocp853352wJl3uZig94uDrY0mqj8Z/xpS4+8NeuIZ4=
X-Received: by 2002:a17:907:1b25:b0:aca:a3da:80b8 with SMTP id
 a640c23a62f3a-acb74e10307mr1496886266b.55.1745423052773; Wed, 23 Apr 2025
 08:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
 <701bfc6a715046044dbc789f1c11c7f85395c7a8.camel@gmail.com> <b4218efe-3785-4065-a3f7-57824e882f09@baylibre.com>
In-Reply-To: <b4218efe-3785-4065-a3f7-57824e882f09@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 18:43:35 +0300
X-Gm-Features: ATxdqUFnVmc8eal9oBgTUwd0yi1TwsVHD4EVlbX0omsSpj6kupk_A2ZmCeLZVNo
Message-ID: <CAHp75Vfa0spzCW8WmR32N7u55N89kxywK5uuYMZDJUNHwSZoDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
To: David Lechner <dlechner@baylibre.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 5:51=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 4/23/25 4:18 AM, Nuno S=C3=A1 wrote:
> > On Tue, 2025-04-22 at 17:07 -0500, David Lechner wrote:

...

> > On the other hand, as I mentioned in V1, I think that an assertion or
> > BUILD_BUG_ON_MSG for making sure 'count' is a compile time constant exp=
ression
> > would be helpful. Sure, we'll get -Wvla but some developers might still=
 ignore
> > the warning and send patches with these arrays. So, it would be neater =
if we
> > fail to build and force them to fix their code.

> BUILD_BUG_ON_MSG() won't work because it expands to a do/while loop which=
 won't
> work in static struct declarations. But I can try to see if we can come u=
p with
> something that works.

I guess Nuno is okay with static_assert() and TBH nowadays the
BUILD_BUG() as is most likely historical.

--=20
With Best Regards,
Andy Shevchenko

