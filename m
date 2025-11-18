Return-Path: <linux-iio+bounces-26285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A87D6C68F61
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 12:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AAA442ADED
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032334EEF0;
	Tue, 18 Nov 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZAtqTs4G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17733BBBB
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463724; cv=none; b=a7OFP8RV1obakLdWQvZXbs5AlRSjvA40tPZ8JPrq5VIfkAsrK60yryNEBEQU/509NAEOprSwbeiRHRDSOU/ioyQprLADSnUDf/OGvtq2VbAPz5zryYDxPGZkAkKzC+IW17aScBSeeooiOMfhYhGBW/zMoUxnZ4HQ5BvyuGeb3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463724; c=relaxed/simple;
	bh=dL91RMvArCj2oifh85PvRYipSwRchrvGh47W7uDfdvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TtA4383dfeAJh7FjlW8mCikygbfCBUrhkTtenqQ2eSpvMaDHToyENxEgsfTfvhCyJfpAzO7GJ8bv9OCtzgPIQp8Fi7Fr66vdfxwUqIPe+kwNThn0fICynye85WQqBkQea1NKrGOh+PjGnwC98D4CoLqDGeKZhoiMNucSj4GCbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZAtqTs4G; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso8554016a12.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 03:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763463720; x=1764068520; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dL91RMvArCj2oifh85PvRYipSwRchrvGh47W7uDfdvQ=;
        b=ZAtqTs4GeZdYTQ6pbX//tbLd0SBSXZvnGEKg7RZ0bYBC2lKJPt53pqTeDBWh+BWv4I
         TyKHAZofwAQbcy+s6DLefwTgT9mtS1JodREBBto1pjUGwQ2GoMcE9E8CHPXFh2wWwCm1
         KWIwucdeXO5r+2TfQhLlVs7cmSv9icZhz+lcVGtgV92QvXTx7FieamFt0qSvdbP8WsjL
         dzR2k0yFIRcqYFwGF64ygobeCowaatTVH4mbCvE8lkr5Syk35khj8HM347RWpkVYeYvP
         4Wpbm/SgHRiKGqsdW/0uYrU6M6mKmxmdmk28M7L6qgSu5urUghb3PTd5cy1Ei0BBg8QZ
         /GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763463720; x=1764068520;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dL91RMvArCj2oifh85PvRYipSwRchrvGh47W7uDfdvQ=;
        b=SwSUjOm9S59HwTUZ3bUWnxYhWcmfE0HiKLW8u9gBO7fqr/vLvKTUNL/JNFyq/swX56
         ANXnQV6D8tI580tKVnFqn2FsmYjIpeIPnrS8LE+qfRO5AsHNfeoZImNgAvBz0O0QJVX1
         9RY40a2o3ndLO1e5WrM7GWooD6dWOw87mSCuWLdO9aH/y/6c5T3ZUsP6yN8r7BNN3un2
         /9P4L/MnH37DrhIQIx2h6/zy1iGu6pY/hh9aCIFPIvrxi8FXotnDrVVG6et6772c9PJT
         kWusRnTibxyN3vFx4qb8HEB2n3jjtiw7ZMwM2QWjP6QcbztWVy2jD6XwTOon2C6m+WS6
         4vtg==
X-Forwarded-Encrypted: i=1; AJvYcCXXw2sgkxyEqMybLavfN1C5a0UfGG01amM1nsu+FM0iq3plRZ01jaGj2svrbh2OUCNaszzF2jhIq+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xqkFfoD15/OwZwE+z2nJKG7ZrHgx9jT8wReKzmil1eXx2kyc
	x1wdxSTmWDzvltmmIAUiZLg5HmptYQ6mkOAs5PDWHgCtfdmJmR/Vqj7Ix5Y8pU5vrGE=
X-Gm-Gg: ASbGnctrZ2YSu9M9HhrSCRzbQ5fi+YYoGKFss1d1aLSIYvX1B/4v0kCMg/DzUxM3uhr
	GGnL67O7ywqS9rznIovFTXsyst8+cXqjuHJiqcjV90sqTcGMQOFpXpWKm/bRdZOkxDWWlh407se
	R2DY2LQ1H2/ih7b1cCRlpepxF0qUQaPzTdqmqaD9+VA7lP7Upc7wjbgogkzLJ7XWXFNSfEgD55n
	hWRz5q4CcDLiVU5HLrA2l9V5HJ+mG9hiaynO4sKNqTbkAycTdlp5tecpFq4HraIxMdyrJ6fE/uh
	Kp3uOsVXMVZmPbsFW777VAfdP+j/9uNa/WzM/UC8IA0rnMhbXtnsy8aTucyQpLgzlL0CZjOMw20
	UUznaSJrs8hrMaQj5aERDPFu/dgyb+gZa4BwzXTgxQFbayhwNd8CEmIy6UDBjOHWliAa5yMyBcD
	QSgrtptRrTjntQZBxUQSz9d9lSgbEiobs/n2HlaIIZzQrPWe86knI8
X-Google-Smtp-Source: AGHT+IGc9SAOhei75g1LvDQt83H+WbRR0LBxKcG2GwxBm7/Koe7BtnMqxocW5zP64x/d7RD9bbU12Q==
X-Received: by 2002:a17:907:94d6:b0:b65:b9fb:e4a7 with SMTP id a640c23a62f3a-b73677ed936mr1493042866b.9.1763463719592;
        Tue, 18 Nov 2025 03:01:59 -0800 (PST)
Received: from [10.203.83.177] (mob-176-247-42-155.net.vodafone.it. [176.247.42.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdaf30dsm1329665166b.60.2025.11.18.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 03:01:59 -0800 (PST)
Message-ID: <82bf13fd5ada664d9e4fdbc3ee453204e55d318b.camel@baylibre.com>
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on
 a per axis basis
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Nov 2025 12:01:57 +0100
In-Reply-To: <aRxN_Gnsl0qq8wDn@black.igk.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-9-flavra@baylibre.com>
	 <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
	 <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
	 <aQNueWesrf_vXO06@smile.fi.intel.com>
	 <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
	 <aRxN_Gnsl0qq8wDn@black.igk.intel.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-18 at 11:44 +0100, Andy Shevchenko wrote:
> On Mon, Nov 17, 2025 at 08:23:35PM +0100, Francesco Lavra wrote:
> > On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrote:
> > > On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco Lavra wrote:
> > > > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko wrote:
> > > > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco Lavra wrote:
>=20
> ...
>=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_enable =3D hw->e=
nable_event[event];
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D state=
 ? (old_enable | BIT(axis)) :
> > > > > > (old_enable
> > > > > > &
> > > > > > ~BIT(axis));
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!!old_enable =3D=
=3D !!new_enable)
> > > > >=20
> > > > > This is an interesting check. So, old_enable and new_enable are
> > > > > _not_
> > > > > booleans, right?
> > > > > So, this means the check test if _any_ of the bit was set and
> > > > > kept
> > > > > set or
> > > > > none were set
> > > > > and non is going to be set. Correct? I think a short comment
> > > > > would be
> > > > > good to have.
> > > >=20
> > > > old_enable and new_enable are bit masks, but we are only interested
> > > > in
> > > > whether any bit is set, to catch the cases where the bit mask goes
> > > > from
> > > > zero to non-zero and vice versa. Will add a comment.
> > >=20
> > > If it's a true bitmask (assuming unsigned long type) then all this
> > > can be
> > > done
> > > via bitmap API calls. Otherwise you can also compare a Hamming
> > > weights of
> > > them
> > > (probably that gives even the same size of the object file, but !!
> > > instructions
> > > =C2=A0will be changed to hweight() calls (still a single assembly ins=
tr on
> > > modern
> > > =C2=A0architectures).
> >=20
> > These are u8 variables, so we can't use the bitmap API.
>=20
> OK. But hweight8() can still be used.
>=20
> > And I don't
> > understand the reason for using hweight(), given that the !! operators
> > would still be needed.
>=20
> No, you won't need !! with that.

I still don't understand. Are you proposing to replace `if (!!old_enable =
=3D=3D
!!new_enable)` with `if (hweight8(old_enable) =3D=3D hweight8(new_enable))`=
?
That won't work, because we only need to check whether the Hamming weight
goes from zero to non-zero and vice versa.

