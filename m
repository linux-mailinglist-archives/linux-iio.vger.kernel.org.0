Return-Path: <linux-iio+bounces-12650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800EA9D8CDF
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 20:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26426B22DC3
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F81552FC;
	Mon, 25 Nov 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLh7kTIZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F7117C7CA;
	Mon, 25 Nov 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563233; cv=none; b=GnxitSf5D/+IKHOgnHaHCDBY8N/rit7AJ+vWBJNh6Ui+xg0VoqPddLyAdQw4nX97ZxFb8AtMuc7Ia6kP+x1tAdkrCtO2jFB63FHDqdzICKERWs8U0g7yMVQR2tfkueVmemHmEuyMFFWnXorQ4+M4qITta0KnH/IYiU3qpSbYvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563233; c=relaxed/simple;
	bh=zT0qGjGeHvnzO0Ipih0ljKKPY3GGliZJ34RYqgSNZ1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftHTuUKavd/NK+AT6yfJCx7eEk1EuslCb9Acl6TirEt08cS95n/k/BX99Wpfi0vR6NJEXmtVClz6M6Yuj6ySpjWkcfYPb34z020u53HESS/peTN5yEdJuGCF/7z/9VGanqYwpnzzwPrzBrHEk7klGgDvfYsPcx1pIzApHpnPlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLh7kTIZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53da6801c6dso4475402e87.0;
        Mon, 25 Nov 2024 11:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732563230; x=1733168030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfiUBwzy6ppvmcqHTpFyPxmKtuZxw0jbNcOCDi3xpDw=;
        b=LLh7kTIZlF1yl2kcw6mTMi7U6iO7UCG3gKuV2ZANDcVuaHr3eQNqKXbFLncsvlBHG/
         7meSE5uiQj0TsZOh8kphNrJUcYMcYJFw+68lgUlKjMsJfnAAmdkPknuWLJVJ3/nqpAJD
         02gVlk5hg/UexNF2iM+tVyBwJCdQl7eineCKWG8m8wCPH5/gxqAVZ5A3Fsjd3WsBavap
         QIlUPWQR13dkV2lZ3jlBP0RbFtOoLtq4+H2EXlMhfzzXZJ6WYpVFHdjNAWP7go4xZX6+
         u2RqT31MGcnjccjuZ88EaU90URrrh3NTP/SyAvNUh1UeHZWUjGDawn4Do4BIhsCBtil2
         5dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732563230; x=1733168030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfiUBwzy6ppvmcqHTpFyPxmKtuZxw0jbNcOCDi3xpDw=;
        b=ExqVvC+nh2ezr/FCyiU+6DMQJhDh1CGC+dqxRoWrrpRaYJiicOMZ1EYv04/aFSYJ4/
         my8OhYxCEFUj0AvnoKfzP1PF5zf87B6L5feQ7leW93+eyI15XxGDm6QNEnDLpVD/FGao
         dtpiV0Nz27g0ULlUxFQUKZ+otD2mV+LpNNHVDjN+B/dLGK4kByvoO6IE1bntunKRVnWw
         DgTYNogSgY79J7pK6xH2OVumFev/r/FyMNaTuigRKtnHet3mXxLqNlnrnUPRv7CyV0HO
         L1av8Qmf1XrEBaVtzWdFfdDX1Igiofm6fWa07/t7XOSfasA59GovqjBGbkJDcOM+ec/M
         ao+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZuWB70zaHLah54pd+yg6ZP6VmSd8v7itlJ2ib64DNWP5xdRWUUmyl1G34wgUAXOZe8t+FeSPDy8e7@vger.kernel.org, AJvYcCWjdmOUiI2bBishDJIRuqIEpP+pwozlptQWaMYFtyt+9WXVN3p7KoYvDoar+TDVY5C0ueNA5GbZjB32@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyt4D+qCpe8wYJdM0ZhbJjrRuM4Z30f2dwqZOIriIabVyc6S+j
	kINa6RrkiZ4hYn/qKIA/ntKTccIyMnxfdMvTIpoGv8hBnswE2nrWh18+rP3IU3aB9QpKVbfnfpC
	lx7xffjR5oaHPCbruNmZawoyjR4Wob+vU2TA=
X-Gm-Gg: ASbGnctKOtMTbPHgj4D8re1ZmK2vGAD1dBydVlcBU673bo8NeCpbH65mcJ4/kRIK+Wq
	+4kOl/1gC7um0kzcqXDYrdT0FOgT4OAm8kA==
X-Google-Smtp-Source: AGHT+IF6zQ/iyeuHW2wAztLLhhg0HWiTby+OusYYzl+JlXk5O3Q5aGBcG0FN74ry/J2s16voRoXzowcd/03NMwq9E3w=
X-Received: by 2002:ac2:424d:0:b0:53d:d3f1:13aa with SMTP id
 2adb3069b0e04-53dd3f113d8mr5125445e87.20.1732563229368; Mon, 25 Nov 2024
 11:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-22-u.kleine-koenig@baylibre.com> <CAHp75Ve_sD-a-m4pYmKrT=LhajO=F7TG7KM7AsM47J0=ksVgNw@mail.gmail.com>
 <eghe47rkwxmcfkamayemvwfksonrwbysaadakbdm4lvzcsy4ee@7gftiif7ka6i>
 <CAHp75Ve3hBhCMFkjA4-hiLfGQLeeGt_74e=PwTH_nF1NCYiyOA@mail.gmail.com> <2tsxyxmfh3ozolsziu3bps7liagzl4gmvy4oykvyeapziagvy4@tfa2lcxmdsmf>
In-Reply-To: <2tsxyxmfh3ozolsziu3bps7liagzl4gmvy4oykvyeapziagvy4@tfa2lcxmdsmf>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 25 Nov 2024 21:33:12 +0200
Message-ID: <CAHp75VcMHyqjsAVveRf58PhoiKyPJRsjBQiLkz+XVu+NDc+Wog@mail.gmail.com>
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

On Mon, Nov 25, 2024 at 4:52=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Mon, Nov 25, 2024 at 03:47:25PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 25, 2024 at 1:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > > On Fri, Nov 22, 2024 at 10:31:07PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > > +       /* Add one for temperature */
> > > > > +       st->num_channels =3D min(num_channels + 1, AD7124_MAX_CHA=
NNELS);
> > > >
> > > > Is the type of both arguments the same?
> > >
> > > Hmm, my compiler is happy with it at least. I don't understand why
> > > though. I'll do a few more tests ...
> >
> > If num_channels is signed int or shorter than (independently on the
> > sign) int, then it's obvious why. + 1 makes it int.
>
> Ah indeed, I should have understood that without that explanation.

Yeah, but a closer look shows to me that num_channels is unsigned int
or did I look in the wrong place? If that's true, that should make a
warning appear since AD7124_MAX_CHANNELS is signed int...


--=20
With Best Regards,
Andy Shevchenko

