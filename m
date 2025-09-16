Return-Path: <linux-iio+bounces-24128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD57CB58F3B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 09:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C28F4E2153
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 07:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B92E62C0;
	Tue, 16 Sep 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ3cEDld"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B969279DD8
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008005; cv=none; b=DckRrRnpvkruQ/Cgl8qyOZ5DBjAmYcVpsROypEL6XZquiCbBE+xK66cnYq1uC+8crheyOhp1JWdB1NfsJqHvVIhLqDxpnQ2ISpBNuLA8uuyr01oQFNcSUjBvO5cwMBFZHGaYL+O+ubh3j1OOdXe2Slyg5HOK+UnvR5g8OS4S8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008005; c=relaxed/simple;
	bh=xCeRAMSeik3Ij+GYUSuPeX8oLZZe8/JHQM9MhsrFjbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gul3s9MYWb0EZ/FniTaUqgD+pV1Nl6DemAG+fLtI4DZglV9cHGsw4ia9869BJG4E3gWXvcLJNawLmDwArkyyKIfiXQRX5GnaKg+S8sOpr4hUU7q3sZ4VGWr/9Q3WPRfRhUulef8/cDjoxnW+lW0Dxx8IYUR1mrnKgfFtjdT4/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ3cEDld; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-337e5daf5f5so54412251fa.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 00:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758008002; x=1758612802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRaB0QRQ+CwkntAtDL6wAD1iaM0SOq9+/31jrQixXeE=;
        b=IJ3cEDldfEGaKcTaMUddrPQbdPf9nJwHdM5eIWA6xe9d+ifNGskeFHIzZk8v5OH2yM
         xMNmbjEv/g1qksXD487rOluL+6LDSXf3BMu8OnUGCdLqx0gs4bTaSD2Pr+iIwp6ilhpb
         Lzw8lcH9ab33xpshZANrz4lklvLM1YAz8BGyKXRxu/3/snVu1iBgHmCJRjk7SKhEDcJp
         fR9JMw2c/tpMEb2tg5RaoMGpHG3joAMHO3s2Y18wRWLc/hMdEW4Wq9EZYX+vQxYudpjT
         7EbEHm4IZXUkCDsE4GcTdqHtvVZKTff1w/o15ogr00tbck41HSpzZoDsOxT5f9w/98m3
         CFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008002; x=1758612802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRaB0QRQ+CwkntAtDL6wAD1iaM0SOq9+/31jrQixXeE=;
        b=MwLe0OnzsmyvB/mgIPPZa06LSzdMdbvdt9CW5KkXRQvlS0K8SBaRNLkXKqrY0mBF1A
         4nFPnE4OVzCVvNwJKftJV3TgyA3TFdgzlrrI/1Q46NqzeI5Zho0iJQqSZP94f/Z8bOpt
         c4fh8R3e+jrJmX8vjF8n8Y5L7rTmTxbITaMsLJee76R1IuwS0GZwo+HgDkhrrlZHDDHu
         ozdgPSxUd1gjEQJHJuV3n7nNg4OdYFpsNaWaBrjprnV99g6KkNZ77JErErayFutzuyrZ
         oWqSxhMP+zF3kjj4PItr8Bw0nCx1c1LEmpZh4i/+LdKvWSQJnHPJh4KVmahUly+ThFq/
         M/mg==
X-Forwarded-Encrypted: i=1; AJvYcCX8TEUFAG7319p94R+XsDObJICTpxjKqq3+Ax4D5PNx0FX0nsAyOkxhu7F5zEYa7EcKYVsjmHm8PEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDavSqztn2drkinCfuLNwuitY3VBg27Ed3veKBvl57RwGnX+GN
	yOms5Ca4g8Dp09rhAAt8qlwwW2eqHsP4yS8DXdSiLb/zgOTvn1O1XazjbzMfNYuGPVxlQn1CW2J
	mKn0iQfR/UDdkhu2r3PSCXMzthmb2jb8=
X-Gm-Gg: ASbGncvzR8nrZr+pTJdt/e8NEVrp7gPiCVvCpg2ZzHV/boxzEBY349ASIeu6mfMlhzs
	ts88QkcwneZQ6PMQxGWzctxB3cFDOgrSml3jUAhcKZlJX+VP6seiPlK8TXI4JimRFK09jzRxj7H
	FOvsEeVnEB/yHVSA1bSbZLyZYMLngBBUXqO1K1wMexeB7umqNaq1a9vscRsOKcdu4k9ccO6FSiI
	fou1Ug=
X-Google-Smtp-Source: AGHT+IG7pjCLsgXwD5N0VxlPDgIAlAe43EQY6konXmywpkCawCRcZViVf5KqJj0G3f36rR6VMBI3m9oWeXKQcQHVTPw=
X-Received: by 2002:a05:651c:b1e:b0:333:f25b:2900 with SMTP id
 38308e7fff4ca-35cc02b7981mr4653811fa.5.1758008002137; Tue, 16 Sep 2025
 00:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com> <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com> <20250915211321.47865d3d@jic23-huawei>
In-Reply-To: <20250915211321.47865d3d@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Sep 2025 10:32:45 +0300
X-Gm-Features: AS18NWCO2CWCadsZfD4Zx3x2Kk_cH8eq1ZHLhEBNLfL8EtEvcHNkIFb9wcymKKQ
Message-ID: <CAHp75VdJ8MH=S4GbEbuky0-gFFxhKbBHsNiiajh-+jxCSPMDXw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:13=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> On Mon, 15 Sep 2025 17:12:34 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:

...

> > > +   data->vref_mv =3D ret / 1000;
> >
> > I still think moving to _mV is the right thing to do.
> > There is no 'mv' in the physics for Volts.
>
> I'm not disagreeing with this review but I'm also not going to hold a
> driver back for that given timing is pretty much such that I merge it
> today or it sits a cycle and this one is very near...

Sure, nothing in my last reply is anyhow a serious obstacle.

> I'll get fussier on this once we have written up some guidance and may
> well send a patch to modify existing recent cases like this one!

--=20
With Best Regards,
Andy Shevchenko

