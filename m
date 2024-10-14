Return-Path: <linux-iio+bounces-10544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F799C018
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 08:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DF71F231F8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 06:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA8E143C5D;
	Mon, 14 Oct 2024 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrSrkX54"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29313B5B4;
	Mon, 14 Oct 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887741; cv=none; b=ARuQDs7em9BbcsAEToiyIi4zcImCW0utCr3mwZC9ffrfg3Q+j+W+v3Fln+FUVKXY6K4JTlBcEXqpfTuqt/83tjmDs35Qd7vbnycr9UOLefB/36qH8CVF3KhpnIyzvO1/AA1UMlxqCUo+Xlc/09hNJtEwB3emUE6fLpAZj/XoD0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887741; c=relaxed/simple;
	bh=ZkgW5vYO4joq2Z/uGOt5rwCB6DTYX7lp7/3pY/P6+nU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GjGKQjdicpq7BB0aPJA2i/R384fXHPHqCLEnxMIuHEuEyruwRwb8P2Hwv811s5uKbIDqbmUhGcYs++P8QYwIXEchAWibKQRn8LRNGzbi6BdZqQ3aT55i2qmFfRXquqO0t5Rjg9+yyORU8eLvly9t02fpdSob8/CPRyxpNJXvReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrSrkX54; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4311420b63fso29116025e9.2;
        Sun, 13 Oct 2024 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728887738; x=1729492538; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZkgW5vYO4joq2Z/uGOt5rwCB6DTYX7lp7/3pY/P6+nU=;
        b=XrSrkX54hvQw5WTUEXWXsGy/zKCQkLzLAMziJLQqqJeRWkDDlh5tJyc9JaedUiavUH
         gea0JcwFbn9yo5ZKrrGZKb1sEiaW+/V8eFf/K7Ki7v3HZQ75P0IQa7VcJivuBfDqka6k
         Aa2uQfLLpu7fisYYfqmH8VIKTZ3BoL1NnMhHLHiGCy/HBPk/+6PLIw2165lPaGJDEZ4o
         A1+MD/leXPvS19A7Y+94eXdOGYyvRJNpCfNdfcaItWoE+X2ChfDMfL1P52hOReWwVbBl
         b0Dxd3JUx3y/Fp5J2GusWM7PwAYq5VH0IhYAeqsKUnf0QIy83/m4eXwtI+Jn4qjEJhYg
         b5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887738; x=1729492538;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkgW5vYO4joq2Z/uGOt5rwCB6DTYX7lp7/3pY/P6+nU=;
        b=IxdIvQSKODD9kC0qjW/VmfKqoxyU02rB9uxXk1bM1qREHp4mZIzwQ0VkUr8GrKmlQN
         3mFj+rhMymMWAzPo7QpjH6Eltv4pER5WkkMygdBJn2YPeqzvNka9LKusHtlZH3KcdDBm
         Y0mucV5+e0xK8SBCASp763kcUz1NPsgnaczzEedOGFDPvwHYlJZ43YrvIi5DlZ5NTs7Y
         Ir5esMK0YjG4ZnEPBk44BBy2Qh2kJTyTEEU/2maXS/8ZnFl7pnbQP1nP+RPqUU6ExS/D
         d7Yo5PWPz9bibUhS32wlp8TLjmsbmpHokr2irDE0ODdQjrZVQ9jix+iT0KgwUaR/bJXx
         jW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsP94ofoIwTKU2DEjsjVJwRAOBKRr0eOuzXEGBbLTpgE5zThjXS/M62FXDTcEgTpgxB+NrSvDcTFfLFIUF@vger.kernel.org, AJvYcCWH8LyWstQy/axjtvbw7oH6e/+a6IUUVo1zIjWZKwus1xUFShQvPCZ6nizYgGoxntoLCysshLA8SRA=@vger.kernel.org, AJvYcCX5khlFR4SPRvDSSB6bCiPhH32SAET5BOSmVI20zUw35LzYJ870NHMLnAplMQUwmJc44X4jT5uvBTD4jw==@vger.kernel.org, AJvYcCXLT6+AnmWUOJ+BnZLkqYqP8/YlFGbemll4oTrSpVAfeGMHTlu2lHo+7z1+OKCm87tzUIJGQk+ceO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygyNFjgBzujkGDhrXuBksCpyglMGyrQNeDYhZKr7jH0T6k4YJd
	uSOu5qDgQcR8KlLgdudWEJ5fveK1jiR/J1GqyoO2x+rPZDMsuFH1
X-Google-Smtp-Source: AGHT+IFHO+5s6Fw09SE6aT49ckvKglgKqyMSHdvbyT7PrkepR+1k6oGCdyf9Vm714qtnk+/QNrPBqg==
X-Received: by 2002:a05:600c:1d8c:b0:424:ad14:6b79 with SMTP id 5b1f17b1804b1-431255dc78bmr56827765e9.8.1728887737673;
        Sun, 13 Oct 2024 23:35:37 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd? (p200300f6ef1521002c2bbcc5835ec2dd.dip0.t-ipconnect.de. [2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fa54sm10517019f8f.84.2024.10.13.23.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 23:35:37 -0700 (PDT)
Message-ID: <f17530fc6ae51292117eae4d3e00a3c922386f47.camel@gmail.com>
Subject: Re: [PATCH v2 5/7] iio: inkern: copy/release available info from
 producer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matteo Martelli <matteomartelli3@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers	
 <ceggers@arri.de>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Paul Cercueil <paul@crapouillou.net>, Peter
 Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, 	linux-pm@vger.kernel.org
Date: Mon, 14 Oct 2024 08:39:53 +0200
In-Reply-To: <172877455634.1202.4959444122842083990@njaxe.localdomain>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
	 <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com>
	 <8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com>
	 <172837007815.3337.5869213289160447430@njaxe.localdomain>
	 <8241b4caf9ebacb116f50bfe1503f325cc576066.camel@gmail.com>
	 <172837459910.12274.5022869861872605261@njaxe.localdomain>
	 <27e0d7b2a70015300047d9388edc87a8ece0c0dc.camel@gmail.com>
	 <172849861528.354008.17477801981314044908@njaxe.localdomain>
	 <20241012164732.518f86a5@jic23-huawei>
	 <172877455634.1202.4959444122842083990@njaxe.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-10-13 at 01:09 +0200, Matteo Martelli wrote:
> Quoting Jonathan Cameron (2024-10-12 17:47:32)
> > On Wed, 09 Oct 2024 20:30:15 +0200
> > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> >=20
> > > Quoting Nuno S=C3=A1 (2024-10-08 14:37:22)
> > > > On Tue, 2024-10-08 at 10:03 +0200, Matteo Martelli wrote:=C2=A0=20
> > > > > Quoting Nuno S=C3=A1 (2024-10-08 09:29:14)=C2=A0=20
> > > > > > On Tue, 2024-10-08 at 08:47 +0200, Matteo Martelli wrote:=C2=A0=
=20
> > > > > > > Quoting Nuno S=C3=A1 (2024-10-07 17:15:13)=C2=A0=20
> > > > > > > > On Mon, 2024-10-07 at 10:37 +0200, Matteo Martelli wrote:=
=C2=A0=20
> > > > > > > > > Consumers need to call the read_avail_release_resource af=
ter
> > > > > > > > > reading
> > > > > > > > > the
> > > > > > > > > available info. To call the release with info_exists lock=
ed,
> > > > > > > > > copy the
> > > > > > > > > available info from the producer and immediately call its
> > > > > > > > > release
> > > > > > > > > callback. With this change, users of
> > > > > > > > > iio_read_avail_channel_raw() and
> > > > > > > > > iio_read_avail_channel_attribute() must free the copied a=
vail
> > > > > > > > > info
> > > > > > > > > after
> > > > > > > > > calling them.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com=
>
> > > > > > > > > ---
> > > > > > > > > =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 64
> > > > > > > > > +++++++++++++++++++++++++++++++++--
> > > > > > > > > ----
> > > > > > > > > -----
> > > > > > > > > =C2=A0include/linux/iio/consumer.h |=C2=A0 4 +--
> > > > > > > > > =C2=A02 files changed, 50 insertions(+), 18 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > > > > > > > index
> > > > > > > > > 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa=
2cea4
> > > > > > > > > 47e16800
> > > > > > > > > 7a44
> > > > > > > > > 7ffc0d91
> > > > > > > > > 100644
> > > > > > > > > --- a/drivers/iio/inkern.c
> > > > > > > > > +++ b/drivers/iio/inkern.c
> > > > > > > > > @@ -760,9 +760,25 @@ static int iio_channel_read_avail(st=
ruct
> > > > > > > > > iio_channel
> > > > > > > > > *chan,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!iio_channel_has_avail=
able(chan->channel, info))
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > > > > > =C2=A0
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail)
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return iio_info->read_avail(chan->indio_dev,
> > > > > > > > > chan-=C2=A0=20
> > > > > > > > > > channel,=C2=A0=20
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 vals, type, length,
> > > > > > > > > info);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const int *vals_tmp;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int ret;
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D iio_info->read_avail(chan->indio_dev,
> > > > > > > > > chan-=C2=A0=20
> > > > > > > > > > channel,=C2=A0=20
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0 &vals_tmp, type,
> > > > > > > > > length,
> > > > > > > > > info);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (ret < 0)
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r=
et;
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *vals =3D kmemdup_array(vals_tmp, *length,
> > > > > > > > > sizeof(int),
> > > > > > > > > GFP_KERNEL);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!*vals)
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -=
ENOMEM;
> > > > > > > > > +=C2=A0=20
> > > > > > > >=20
> > > > > > > > Not a big deal but I would likely prefer to avoid yet anoth=
er
> > > > > > > > copy. If
> > > > > > > > I'm
> > > > > > > > understanding things correctly, I would rather create an in=
kern
> > > > > > > > wrapper
> > > > > > > > API
> > > > > > > > like=20
> > > > > > > > iio_channel_read_avail_release_resource() - maybe something=
 with
> > > > > > > > a
> > > > > > > > smaller
> > > > > > > > name :).
> > > > > > > > Hence, the lifetime of the data would be only controlled by=
 the
> > > > > > > > producer
> > > > > > > > of
> > > > > > > > it. It
> > > > > > > > would also produce a smaller diff (I think). I just find it=
 a
> > > > > > > > bit
> > > > > > > > confusing
> > > > > > > > that we
> > > > > > > > duplicate the data in here and the producer also duplicates=
 it
> > > > > > > > on the -=C2=A0=20
> > > > > > > > > read_avail()=C2=A0=20
> > > > > > > > call. Another advantage I see is that often the available d=
ata
> > > > > > > > is indeed
> > > > > > > > const in
> > > > > > > > which case no kmemdup_array() is needed at all.=C2=A0=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > If I understand correctly your suggestion you would leave the
> > > > > > > inkern
> > > > > > > iio_channel_read_avail() untouched, then add a new inkern wra=
pper,
> > > > > > > something
> > > > > > > like iio_channel_read_avail_release_resource(), that would ca=
ll
> > > > > > > the
> > > > > > > producer's
> > > > > > > read_avail_release_resource(). The consumer would invoke this=
 new
> > > > > > > wrapper
> > > > > > > in
> > > > > > > its
> > > > > > > own read_avail_release_resource() avoiding the additional cop=
y.
> > > > > > > The call
> > > > > > > stack
> > > > > > > would look something like the following:
> > > > > > >=20
> > > > > > > iio_read_channel_info_avail() {
> >=20
> > Here you are talking about the core code that produces a string.
> > But you've done that in reply to v5 which is about inkern interfaces
> > that don't work in strings...
> >=20
> >=20
> >=20
> > > > > > > =C2=A0=C2=A0=C2=A0 consumer->read_avail() {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_cha=
nnel_raw() {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 iio_channel_read_avail() {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->read_avail() {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmemdup_array();
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0 iio_format_list();
> > That's effectively making the safe copy that is handed back to the
> > caller. So this is fine.
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0 consumer->read_avail_release_resource() {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_cha=
nnel_release_resource() {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 producer->read_avail_release_resource() {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree();
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > > > }=C2=A0=20
> > > > > >=20
> > > > > > Yeah, exactly what came to mind...
> >=20
> > I'm very confused what scope of comments here is. Maybe the easiest thi=
ng is
> > to send the code.
> >=20
>=20
> The function call graph example and the related comments above were just
> to show the full flow of a read_avail() call on a consumer driver in
> case an inkern release_resource() wrapper was used instead of an
> additional consumer copy. This just to confirm that I was on the same
> page as what Nuno suggested.
>=20
> >=20
> > > > > > =C2=A0=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > I was going with the simpler solution you described, but my
> > > > > > > concern with
> > > > > > > it
> > > > > > > was
> > > > > > > that the info_exists_lock mutex would be unlocked between a
> > > > > > > iio_channel_read_avail()
> > > > > > > call and its corresponding
> > > > > > > iio_channel_read_avail_release_resource() call.
> > > > > > > To my understanding, this could potentially allow for the dev=
ice
> > > > > > > to be
> > > > > > > unregistered between the two calls and result in a memleak of=
 the
> > > > > > > avail
> > > > > > > buffer
> > > > > > > allocated by the producer.
> >=20
> > Yes. That's why we have to free the produced copy under the exist_lock
> > (and take yet another copy).
> >=20
> > > > > > >=20
> > > > > > > However, I have been trying to reproduce a similar case by ad=
ding
> > > > > > > a delay
> > > > > > > between the consumer->read_avail() and the
> > > > > > > consumer->read_avail_release_resources(), and by unbinding th=
e
> > > > > > > driver
> > > > > > > during
> > > > > > > that delay, thus with the info_exists_lock mutex unlocked. In=
 this
> > > > > > > case
> > > > > > > the
> > > > > > > driver is not unregistered until the iio_read_channel_info_av=
ail()
> > > > > > > function
> > > > > > > completes, likely because of some other lock on the sysfs fil=
e
> > > > > > > after the
> > > > > > > call
> > > > > > > of
> > > > > > > cdev_device_del() in iio_device_unregister().
> > > > > > > =C2=A0=20
> > > > > >=20
> > > > > > Yes, you need to have some sync point at the kernfs level other=
wise
> > > > > > we could
> > > > > > always be handling a sysfs attr while the device is being remov=
ed
> > > > > > under our
> > > > > > feet. But I'm not sure what you're trying to do... IIUC, the pr=
oblem
> > > > > > might
> > > > > > come
> > > > > > if have:
> > > > > >=20
> > > > > > consumer->read_avail_channel_attribute()
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->info_lock(=
)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->read_avail=
()
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->kmalloc()
> > > > > >=20
> > > > > > ...
> > > > > > // producer unbound
> > > > > > ...
> > > > > > consumer->read_avail_release()
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> > > > > >=20
> > > > > > // producer->kmalloc() never get's freed...
> > > > > >=20
> > > > > > The above is your problem right? And I think it should be a val=
id
> > > > > > one since
> > > > > > between ->read_avail_channel_attribute() and read_avail_release=
()
> > > > > > there's
> > > > > > nothing preventing the producer from being unregistered...=C2=
=A0=20
> > > > >=20
> > > > > Yes, that's the problem.
> > > > > =C2=A0=20
> > > > > >=20
> > > > > > If I'm not missing nothing one solution would be for the produc=
er to
> > > > > > do
> > > > > > devm_kmalloc() and devm_kfree() on read_avail() and
> > > > > > release_resources() but
> > > > > > at
> > > > > > that point I'm not sure it's better than what you have since it=
's
> > > > > > odd enough
> > > > > > for
> > > > > > being missed in reviews...=C2=A0=20
> >=20
> > If it's an allocation to keep a copy for an active consumer then that i=
s
> > nasty
> > as the lifetime is completely untidied.=C2=A0 Effectively you are garba=
ge
> > collecting.
> >=20
> > > > >=20
> > > > > I honestly didn't think of this and it would in fact prevent the
> > > > > additional copy. But I agree that it could be missed in new drive=
rs,
> > > > > maybe a comment in the iio_info read_avail_release_resource() cal=
lback
> > > > > declaration would help?=C2=A0=20
> > > > > > =C2=A0=20
> > > > At this point I would say whatever you or Jonathan prefer :)
> > > > =C2=A0=20
> > >=20
> > > I run some quick tests with this approach and haven't found any issue=
 so
> > > far.=20
> >=20
> > I can't see what is preventing the race you describe where the
> > release callback is swept out by a driver unbind of the provider.
> > So unless we can show that is safe I don't see a way to avoid a consume=
r
> > copy.
> >=20
> > Long shot, Lars-Peter I think you fixed up most of the previous races i=
n
> > this
> > code, don't suppose you remember how it works?
> >=20
> > > I would personally switch to this approach as it would be much
> > > simpler and easier to understand, and since the avail lists are const
> > > for most of the current drivers I would not expect many new drivers
> > > needing a dynamic available list. However, I will wait Jonathan feedb=
ack
> > > first.
> > The idea here is almost no one actually makes a copy in the producer.
> > The consumer copy is a necessity to my thinking because we are effectiv=
ely
> > passing the ownership of the data.=C2=A0 Unfortunately we have no idea =
how
> > the producer would free it so we need to create our own copy.
> >=20
>=20
> You are indeed right. During the last comment reviews I focused on the
> fact that using a devm_kfree() in the producer's read_avail_release()
> would prevent the memleak but I completely missed that it would not
> prevent the race condition: without the consumer copy, the consumer or
> core code could still try to access a freed buffer after the producer
> driver gets unregistered.
>=20

Yeah, this would be indeed an issue... Good catch!

- Nuno S=C3=A1


