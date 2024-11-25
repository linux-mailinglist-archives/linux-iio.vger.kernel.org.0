Return-Path: <linux-iio+bounces-12643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9C9D86F6
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 14:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1803D166919
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C51ADFF1;
	Mon, 25 Nov 2024 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is0dvLPp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6B1ACDE8;
	Mon, 25 Nov 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542485; cv=none; b=p4dob8kKVkqZr+r2uI+gLnQJnappT3TLdY43D6waGrjyr1e6Nr7j5F3nYO51XaPrWH9zV+7n0VygrCK48nlz76jZxPRcU9s56S7JZIec6gQQlYve2rInw8K+eiZONShfHWr8pvZyHnOCFZOWMh8JBcpYyowa9GoAwKY4myTL7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542485; c=relaxed/simple;
	bh=r9lkHO1FFzLwQ6iFQt3hcN9n6ULg/dlsFSnIbCI5/TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmdIssePEKrLidMP7BGYLwJsk1xSmVq9rT7zt4nSTpc9GPXLNkN+q16G9CvA3cngpAdObzFNnKbEfkTveThFjjYzplZlJ8ZvQax1BWK8mfDhWEqFI5GtDSc7EOBit05PHVAQoujPRN+gjGa6/GH21WURx6CQRhU0CSniCqmiK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is0dvLPp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfe5da1251so5519527a12.1;
        Mon, 25 Nov 2024 05:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732542482; x=1733147282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fA1F5WZzvKo1QuPRZbBAhyS6aNTDvmwps9SWjuQ01U=;
        b=Is0dvLPpdcZ4A+3AbJKewBuqkz2UmlhDfnc4N47JehJHmetx8BtglWhdNTrkjIH67/
         Tgr7C0SgBiVdliLfXwgPBuh3NaKDHhfDKZkyXfO77vGRN5I4jGeq9XPTM2oRoQBZUT1O
         bjUVLGtPYyGAZugYOMFGTBSO+yxevAJ1h0zPYHH1YFABnCM/ObH2QehvSIJhb2KYzKVu
         0zi4Xll7RfKF3D99UwJAcYob9cQNsrpQBgtHOpg5cRkkoZFDeQd0p5Qq99Qq7a8wddMd
         h22Ced2JKdVM2tp9DcJ0CVqy9kmt/Exd44yfu31Khme3s/f1reQMIPz90HFWMM3ujEfa
         zHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732542482; x=1733147282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fA1F5WZzvKo1QuPRZbBAhyS6aNTDvmwps9SWjuQ01U=;
        b=UO3no1XHK6Wb8qJt4Qaq0rEugiljMoxG47SP2sX+UXGIK4nqdZM03IE7bLTOKtcNOm
         yuFTuhIcnT5xfmv3KS/UeHcSZRF8i7MY8U3NMTHWfqr2vM+2Q5o1gI7fLfxKDwjRADc2
         aukmPuc2NqwqeW1SLtPrL7oxo8/kmB8NDCQbCRqZcqy+F3429eu7SBtmXMW27wc6E77R
         ADZe4Z0W9zuAwAHXvSZiBG6tm8PlK+7I4VZG+p7IrCcVQJDpQhmvRZX15KHx+qXI6TsU
         2+5NeM3NmWfhLz3fLr3iEh0XJMcM34GWAic7KCnqUWtfZyU/n/Z3Jzl7dLaRY4jbNLhQ
         a+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWHCufahhcItnR/GcRmSCiiLMJmzryw5Q08jCbQKOjxASCcpTjBUge9QRIeNoNA9wncw0el6B28+d4h@vger.kernel.org, AJvYcCWfU3uUwvP6bk5fgVGwqilsMWFUJWZapsgpgMu2QAFkqLt2DTbz+Bf7Xieb1M/elOPjNRY75usE9IAG@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpqS2i2OzCQGw5zMbpdcjjLnSTtxD+1b0vMsYgQQRyT3/2Ieu
	eMcT1kif/pod0kyOmRUz6tjsLAvt1SR9udFndWeJF6qRZ7Eqf3srEsvJ/ap+uHL8InuRU0gbmGb
	3OnzeE4EZAoFCDtwnIB5sv3+b4A4=
X-Gm-Gg: ASbGncsNUCHbkQsEjRdrUba4+XxmeeENmG2azrco0p+P3f0tSF9m+7XVbI8YLqwBAuQ
	UamYd7zDtcZTNrZO51LmwUuW1Q+C3q05wbw==
X-Google-Smtp-Source: AGHT+IHcbV66eT+bwaP/+AEbTKqcauCg3LmlqWNWCdN1eoerWIsVQ7yse2m70EOdWHdwTsHonAStf+FnNnnFL85D2mM=
X-Received: by 2002:a17:906:31c5:b0:aa5:225f:47d9 with SMTP id
 a640c23a62f3a-aa5225fb282mr868286066b.29.1732542481607; Mon, 25 Nov 2024
 05:48:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-22-u.kleine-koenig@baylibre.com> <CAHp75Ve_sD-a-m4pYmKrT=LhajO=F7TG7KM7AsM47J0=ksVgNw@mail.gmail.com>
 <eghe47rkwxmcfkamayemvwfksonrwbysaadakbdm4lvzcsy4ee@7gftiif7ka6i>
In-Reply-To: <eghe47rkwxmcfkamayemvwfksonrwbysaadakbdm4lvzcsy4ee@7gftiif7ka6i>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 25 Nov 2024 15:47:25 +0200
Message-ID: <CAHp75Ve3hBhCMFkjA4-hiLfGQLeeGt_74e=PwTH_nF1NCYiyOA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] iio: adc: ad7124: Implement temperature measurement
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 1:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Fri, Nov 22, 2024 at 10:31:07PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > > +       /* Add one for temperature */
> > > +       st->num_channels =3D min(num_channels + 1, AD7124_MAX_CHANNEL=
S);
> >
> > Is the type of both arguments the same?
>
> Hmm, my compiler is happy with it at least. I don't understand why
> though. I'll do a few more tests ...

If num_channels is signed int or shorter than (independently on the
sign) int, then it's obvious why. + 1 makes it int.

--=20
With Best Regards,
Andy Shevchenko

