Return-Path: <linux-iio+bounces-25594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E5C155FF
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 610F95645F1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1567338F36;
	Tue, 28 Oct 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj6mxv7s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3933345E
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664318; cv=none; b=F7mE2FcgU7TKanUjsp4swO+y4ZKS0Z+SnjaUgyo/T1da/77/r7UCj0Gjc5sAIbojEB1PShDsiywE9mm/DjLBaN8LKlaxk4qa0UT24ax78u7D1RaHeTGVO/MdJoIlmNYTUIqhcX/9u5jAtgmbpZStD+LktNk+IuPE8WU5vky8Fbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664318; c=relaxed/simple;
	bh=Qr/KyAPoigB6wGqTmF3cfWVgtdtDjq7kPZAEP+Ml/4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQN8samR2Gt/NfKtahTLX2NIvP4S/9o4RgOYNHva84tXA3gByRhNaadcuIgNpQ8OoCpY9rFpQoiiugb7IrmT5Bkgm9E35kkx9PpXiai1XJmuyHfIsPNfk6/HZMEjqmB8HQFjwMdQ4+CXw8x9Lnxd1axYyd9f+ZvrQJpBdNcZz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj6mxv7s; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso4574791f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761664315; x=1762269115; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjSsl/zr2RGPbqL1Wt5/pHo4BllECloxOeLOdg73hOI=;
        b=Yj6mxv7smPXu7BnjeJe5+ZnporkKoEJbWRBoVdt/NohgrMM4NCQ2FAAzxuiL22v5RU
         5TFVrAU/Abh+o6fBCIV8fF3UgmDSX8G910V1ljoHave96q7fNv4KrmjuBBKh/A/Ztpvz
         OUZ3ygcKMn0gqeUM3e9dz1XM7o7PZhxnlB4JnoJsEKsab7Sbej0Eb3XbtIZGL1zjbCk+
         3WNH/26R9IUKR9a7yP4GebumuMRJC0bKKQvjQYvUugz1z7CXcb4WzMrpiTXpb+7zZgYd
         OWifmDZ2R9owmeRhpe5a5uWmq2DhZIcRYW8cjLwR8D+ZmIfYJtQR5WpZdQZY2fAaSzG/
         HXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664315; x=1762269115;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjSsl/zr2RGPbqL1Wt5/pHo4BllECloxOeLOdg73hOI=;
        b=ickb/zgVD0hi8jWuR8kJQ5jEe39q8QV2jk8tHcslBwws7zZpqXVhcSiP1F4dg+Dc33
         riyp6JrPaGl+1icQiUmHkhAzrVuQe4J3s3K94+WXJdAdI5nO7uw4vHWwjziOTbpzqoQQ
         3cYDzOxUEQbofjFRRjmEzd9X/9V34SY/P6lWglmsQqKhqCH5mGE6QcEkG2LD+4eDhuHb
         YIlgh/TDc9snoocP+QTqwDMLFmIC6o3zU0uhdVh8W0+4+Si0ncz417sDq4pJEdZ1pbIP
         pTU+dNL5LWPcMbKvfSJfiod8FvlV6oKTjTkN7QH1Cuqf+Am/WhPtvuiAZt33hEGzmxQa
         zAvg==
X-Forwarded-Encrypted: i=1; AJvYcCUZKCRVQQwGna3/w7r9KsxydjyY24RdA0ve6mQgaw+vekpTNiXqNdLLh38OTson9IBQei7n2st9fgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhX9R/Dd0gfhXhPcjABwlzSBnwn5ia0ELkZtlBuUDzflhjVzu9
	SwRPop0FhaWLwaTja3ZLTw89dN2NoStVcyRTdK55p5vPhTXiA9p6rJEZ
X-Gm-Gg: ASbGncsYMfjNGBYr6athPmDyvUPg3hLkDM39BSSC2BKgqmTzcEwkFZRJ4xAklKEH57G
	qb9kuQoG0QxG03FEq9tCnakHvxw2Z1ChpX5+ggCr4B5ZVdo/3n9Th+qCZqaCmN5/IomFT2iGHL8
	byXuNnd7vsZFIxqbbh3f2pixWQs7vMiV91qnPF4JbnQIBwloIzsrVWqaCvAXy+ozy9wLFKVeU+y
	Laigs8rdQuLSEjv+PyqU+BoJYiJz9E/f0sriuvt4PpnIrygNesyfqLIQJhPZGnskU1Kxelx/5ad
	b7bdtdh30kYl3geBaqTvuqUoDv3twjwDhyXBDOspgjTaZCDA02T52Z4x6VJaaTZABesM33wXUk+
	/RsFw/obxHykBrHZYLNX3NegqBBCVjiMDwqI4ILmB8rtyLGqPL+lNGy+qAkwMzU1r/i2RFmzJ7Z
	K6mr4mkIkk
X-Google-Smtp-Source: AGHT+IFPxw32NZKMKQgnPWJvuhcMFSKP9503oZjSJujNBAOtA1b22zAMwvsT1JdfgSFWibEQaBFoNQ==
X-Received: by 2002:a05:6000:184b:b0:405:ed47:b22b with SMTP id ffacd0b85a97d-429a7e4b7eamr3546205f8f.10.1761664314816;
        Tue, 28 Oct 2025 08:11:54 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b6fsm20941347f8f.1.2025.10.28.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:11:54 -0700 (PDT)
Message-ID: <aecd2e25900f2ef38f937a295e995269c433453b.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Miaoqian Lin <linmq006@gmail.com>, Markus Burri <markus.burri@mt.com>, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 28 Oct 2025 15:12:29 +0000
In-Reply-To: <aQDXF-AIF6wNIo76@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
	 <aQB8PRlaBY_9-L8d@smile.fi.intel.com> <aQB8j7Hc3b9vAT5_@smile.fi.intel.com>
	 <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
	 <071e3da4d69e10d64c54a18b7dd34ae11ab68f58.camel@gmail.com>
	 <aQDXF-AIF6wNIo76@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 16:45 +0200, Andy Shevchenko wrote:
> On Tue, Oct 28, 2025 at 12:31:04PM +0000, Nuno S=C3=A1 wrote:
> > On Tue, 2025-10-28 at 11:07 +0200, Andy Shevchenko wrote:
> > > On Tue, Oct 28, 2025 at 10:19:27AM +0200, Andy Shevchenko wrote:
> > > > On Tue, Oct 28, 2025 at 10:18:05AM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:
>=20
> ...
>=20
> > > > > > +	if (count >=3D sizeof(buf))
> > > > > > +		return -ENOSPC;
> > > > >=20
> > > > > But this makes the validation too strict now.
> > > > >=20
> > > > > > =C2=A0	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppo=
s,
> > > > > > userbuf,
> > > > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 count);
> > > > >=20
> > > > > You definitely failed to read the code that implements the above.
> > > > >=20
> > > > > > =C2=A0	if (ret < 0)
> > > > > > =C2=A0		return ret;
> > > >=20
> > > > > > -	buf[count] =3D '\0';
> > > > > > +	buf[ret] =3D '\0';
> > > >=20
> > > > Maybe this line is what we might need, but I haven't checked deeper=
 if
> > > > it's
> > > > a
> > > > problem.
> > >=20
> > > So, copy_to_user() and copy_from_user() are always inlined macros.
> > > The simple_write_to_buffer() is not. The question here is how
> > > the __builit_object_size() will behave on the address given as a para=
meter
> > > to
> > > copy_from_user() in simple_write_to_buffer().
> > >=20
> > > If it may detect reliably that the buffer is the size it has. I belie=
ve
> > > it's
> > > easy for the byte arrays on stack.
> >=20
> > I think the above does not make sense (unless I'm missing your point wh=
ich
> > might
> > very well be).
>=20
> It seems I stand corrected. I was staring too much at copy_from_user() wi=
thout
> retrieving the validation logic behind simple_write_to_buffer().

:)

...

> >=20
> > I think you can easily pass a string >=3D than 64 bytes (from userspace=
).
> > AFAIR,
> > you don't really set a size into debugfs files. For sure you can mess t=
hings
> > with zero sized binary attributes so I have some confidence you have th=
e
> > same
> > with debugfs.
> >=20
> > And even if all the above is not reproducible I'm still of the opinion =
that
> >=20
> > buf[ret] =3D '\0';
> >=20
> > is semantically the correct code.
>=20
> Yes, but it should either be explained as just making code robust vs. rea=
l
> bugfix.

Agreed. If we find it's the former, the commit message should be updated.

> For the latter I want to see the real traceback and a reproducer. I also
> wonder why
> we never had reports from syzkaller on this. It has non-zero chance to st=
umble
> over
> the issue here (if there is an issue to begin with).

If I have the time, I might do it. If my suspicious are correct, it should =
be
fairly easy to reproduce.

- Nuno S=C3=A1


