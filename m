Return-Path: <linux-iio+bounces-23130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C156B30E8D
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 08:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774D61CE3FAF
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 06:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF862E282B;
	Fri, 22 Aug 2025 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFNfNOPf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851D7262F;
	Fri, 22 Aug 2025 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843153; cv=none; b=LIx3L7ehx7RmZM7fcl2AK456feTh/XtBLfCtZJ9RdPE/qrm8BdmJ7LVIueVOtrP2ycsAHBjGgSQfHUiwkmy+1DKeMZtoSASxOpsoLvkQQT9DyYKpBDRCKDs7cajSkCZLms8IxTQPK59wnITbrXx99dp7NvJxyyJLx2nWW+owOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843153; c=relaxed/simple;
	bh=LhSLL9e6B9AAwZvmGOujsflvopTdIP4LayPRhrm+i3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hx/5qV7xugnjLwE5w1bEQTxUJ1BJkecA2AabQouiZ1DuvcR0RNWS3XaYVD6QKvGQz+ubAjj+WbDp6jl/MDNJ0gkrROW2UIAUx6HiUZMm1xF3BTq5YBIwwkbH24g+GSFVZ6Sfzu7MoVHS4YD+tTKtmaFBnINbtW7P70d6jM26cMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFNfNOPf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb61f6044so301746766b.0;
        Thu, 21 Aug 2025 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755843150; x=1756447950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhSLL9e6B9AAwZvmGOujsflvopTdIP4LayPRhrm+i3g=;
        b=eFNfNOPfGTlSFricJZt000adwYUWI5DAKpgaVMTAL5RR7gfMnUJSvY6tsa0ngyH0E+
         /WAwWDHeU2XAh6FnPJfZi1E0lIx0zfgnRHGYQDdbOOraXht1lbJOljD514GpA8t7/4W1
         hJn8XUCXHyYeI6SGAOWZ9zgy7LbcNRPR79HPJx/NnmSvtVeDCac3bmUCQ2BGPFA9rTat
         MiGOaHiRG0poi89JFvor1Yk/BnzHrMe2XrBs45M4ocJuWAZxC7Cb2Y4flEsUFrCb+Y4g
         BNlHqb2MDpAHte1YjCo/e3+VReouJuHSQ8wr2d6w8DKTWBeDGUljdjv8kZCPm5Qijt1i
         l2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843150; x=1756447950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhSLL9e6B9AAwZvmGOujsflvopTdIP4LayPRhrm+i3g=;
        b=PBr6Xyc/0yGX9ZBjrRvkMSkfXlUlhfMJnpP6snV5wjtjGa0ZE7nCf/CLjucWoZFelX
         D1LECFBdSBUQEU4OnqIV7s6zPXKAliq6KU9Br/nCE7S34KVkOsks02xOHiSYz/angynJ
         3veu2aV9YSKjyxiGhDzKu3f8ipkA2G8J1prFETfYKmD1wWC8FcTrfjsWEAOhYDlPTKJy
         03lFowbpaGwwJnW+mPUMityIadmExgXPSWH4xTxo43Dct4WkvCAVL0koy8qDhhcwM27f
         sq18k6pb+Nx19ysb46qiGB8BGWbsfV/cdP9nu1JAdioFQ7gqc99+D11xlB7zokh3t+DX
         AbSA==
X-Forwarded-Encrypted: i=1; AJvYcCUEx/ipWefmWcG4b1ILYl0EnEZERZyq90tYYfyH8/S1Hy2ro3Xe4P/DF1mtZPKj//MaG0XVF/0LcUtC@vger.kernel.org, AJvYcCVBZWAXKQkzJAZSnVihTguasBN3+FiJnEH8t6UjGPUTuCX9/Ifbo/jgRZFh5vRS76a5vHKlqMZ7/b2AjfOi@vger.kernel.org, AJvYcCXbq8VYYKrXEBimk4+DxPyQqcLgm7Psz06647WB9b7KsTa8qZwM6RWhD/aPY7Nj6MhRixxTZHU5zoUs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx744jxQZWSTDP6U9gZQ4xCgytmtlelL4dkh/EL2ijayO/WIBoD
	BtXhftFH6au4GdUNtvLPSL9MeawakwlxBMp91nVzgyFhA8nSd4ukfeN2OPqFrq5Ug/4q5yNwDm9
	cn/oatkwjCj7eAE82I1GlAmJozESex5mDPZ8PLF0=
X-Gm-Gg: ASbGncvfxVrvcYrnoSqkRKHN6uwkttMBxlAqHQdyS4yj0YDSmdAwQ4h5ABledehz0b7
	q9Uz3No6d9Zy5LwKV2k7oGvjaC3WhohVFXyPziYogzSuxnX+3wHWbuzyQmkGflDkEkpmYX6AcUQ
	TrjKMCRSK0eJEU+U2s8RN00FhDUnquFnBwCGGH+buyB/8u8DCyLrSojElgFTs/D6ueI8HCi23cu
	/yPLso=
X-Google-Smtp-Source: AGHT+IHhYMuJFyaWh7s3kCivnxAbgWFVJsFET1lvGj1oS6aO8CW5sWhRa/8NlKjsTAxe7mAAoWCmJ/1pE8MO9LMieVI=
X-Received: by 2002:a17:907:a089:b0:af9:5b51:2e6d with SMTP id
 a640c23a62f3a-afe28c96336mr191277666b.0.1755843149602; Thu, 21 Aug 2025
 23:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
 <aKXW5pGiN18DyIZ7@smile.fi.intel.com> <aKaMPMnGRyvKqTny@dixit>
 <CAHp75Vdw5X1Y057fpGjdvVGwKq0x0UBdm8py+m+55RbzXi1PJw@mail.gmail.com> <aKfYlP-yWdQi34db@dixit>
In-Reply-To: <aKfYlP-yWdQi34db@dixit>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Aug 2025 09:11:53 +0300
X-Gm-Features: Ac12FXxcbGBvQWNbfM4ap7xlZtMvAEEgt4gYfh6-pLar28-Ixfel30OkWz8zK8s
Message-ID: <CAHp75VfDR0UsjSufDQmO5+nx5jqoPL+qHgGRVMdH4Tp0+3wsoA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:40=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.c=
om> wrote:
> On Thu, Aug 21, 2025 at 10:41:03AM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 21, 2025 at 6:02=E2=80=AFAM Dixit Parmar <dixitparmar19@gma=
il.com> wrote:
> > > On Wed, Aug 20, 2025 at 05:08:38PM +0300, Andy Shevchenko wrote:

...

> > > > Interestingly that you have used 100 limit and suddenly don't do it=
 here
> > > > and maybe elsewhere. Why inconsistent style? Please, go through the=
 whole
> > > > file and make sure the style is consistent in all of the aspects:
> > > > - C style used
> > > > - comments style (one-line and multi-line)
> > > > - indentation
> > > > - etc.
> > > I tried to follow 80 limit(except few places where it was just on bor=
der or not
> > > clear to read). I belive the standard is to use 80 limit(correct me i=
f I referred
> > > wrong place) and I will recheck to meet that.
> >
> > There are two standards, the old and strict one -- 80 characters, and
> > this subsystem _tries_ to follow it and relaxed with 100 limit.
> > The exceptions are possible when it affects readability.
> Understood, I will go with 100 limit and make sure everything is well wit=
hin it.

It seems I was not clear enough. The IIO hardly tries to use the 80
limit, so don't go for 100 until it's agreed upon with the
maintainers.

--=20
With Best Regards,
Andy Shevchenko

