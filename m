Return-Path: <linux-iio+bounces-5994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D0890010B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 12:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFFF1C22BB6
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B78A15DBAD;
	Fri,  7 Jun 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0CZUZWG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432815D5A5;
	Fri,  7 Jun 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756673; cv=none; b=cof1jt5+W7UJRdEepWXWLCh31XEmiMGNRJ6suwZv/To/7Hl4w+bg7NTEVpY2J9eFrreobRoTA6KvArLqe5oln3Yo6fUhZtVFBDcyJS2g2vSm+t36NtSQ99Rn/q97epvu6XVMaA3we10Z2jeZWVej/k7/3c+3ga7xPWHAHlm4eRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756673; c=relaxed/simple;
	bh=AI2ieUO/6av7s9ZXod25pYy+JFppaxhrF6e/NoXP2Ws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPmfCWV4xXh+19qE4JdY5R/byvRxWIu2FkJYBCtZHAKPpKofpYEu0WqAV/HKsoZriJOtFg3pdCtjYyRQCoOyIK7+K9IxupVzGNXpCyW3VcFLIEf53HzZ8Al5uenyXW5BCqf8j/nWv7A7njcxL+CD+fUF++yTabOAKBKaPLXXrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0CZUZWG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68ee841138so252765166b.1;
        Fri, 07 Jun 2024 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717756670; x=1718361470; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cYd5bpwy4meymqvJV+NAOZHVbo2MmJICLvFAiNGTisQ=;
        b=a0CZUZWGNsUHaTmqBd5ASKEct25BJ4H59gXABj3EK8s0gtBsbiNwKlRlKYyd+FrPTv
         JtWrCSB3uGIW1lqnpsbr7ksX9WWqmYBRKaqDMHrBU+O4j4bekeU6x1cmaZ/hnOGM3pTE
         jk8k7fHGswNI7/obxkriZbKpK2hr6NjrT5Vu60sMryXJt0Pc341G1GEl2/PE8EFHw4sX
         kvGOJSFEcJLdGQaDo575QIQp0aYGyIQvaNrEtwub+0BVFPH0Fni0xWhG3htiCDwv0mma
         kU1RkCSp8+IcICfk4Xo0+t9605UrnJAsOn3/UUrBvAo/i5qxQFJDk63j6EtrkRWf4hmi
         yjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756670; x=1718361470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYd5bpwy4meymqvJV+NAOZHVbo2MmJICLvFAiNGTisQ=;
        b=BsZs00YfXRUwvr53JmSVIF7J/rX7n7mvVJVe8++4wrNdQpC0o+COrU6TPND+aP1oYX
         xF6vdZm6S9dNdjn2dwac8L90Y/A4iesmNpWJClrIHlO0H8XP7AuzW4zZt9ZGHS3HoGsE
         33W+9WMRP7SLw3JADv6MmOQufdb5GI8yvMI7i4EQORwCjvHIFoqPYW7pVSCsWTkQYb5t
         zp8FSGYHeS9doX4UgDmwONW7RApJZ/Qn9+Dup4OvgbBH646TPHkIV0YlDg63Yfa3ytzN
         Smk80BKejKFqwuHXYYXEQHjqAL8/zMMe9NgQDd6LQpAdVQKRw2s8T/MVM94uhK9RF+Y7
         Y4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+XZDstqwbB1umnhGhTAqwQ/SElrxNobpeX42PhsdWkRhalzqEDBN18FzWjmMJqPUb/FMmqx8meJ0iPbl/8clN7FYd+A0oOF4892ft+HakthMyLeBRhbI+x1mB2wBpu09Sud8uHClp
X-Gm-Message-State: AOJu0YzYo56jVyTwizHe2Y919b/bEO5S37wWb3j9DYQyTArqiRuM7uFq
	bPHYRJ4MlvljcAj61aNagCng1aXHEb73B8aKs9C4mJbv2sXgJ6Z+
X-Google-Smtp-Source: AGHT+IEot8u6Kx2dBaaFTnk43HtFN61gLaNoiPmigTk6/4aDOSDBPYQkxaKir0bIj5Yf+9nCU8EZUQ==
X-Received: by 2002:a17:906:e2c7:b0:a66:7666:fc62 with SMTP id a640c23a62f3a-a6cd6664187mr148202666b.22.1717756669944;
        Fri, 07 Jun 2024 03:37:49 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80728867sm226290366b.192.2024.06.07.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:37:49 -0700 (PDT)
Message-ID: <3f1a6ccf23cb901473bd490b1ca7330db51a1313.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Petr Mladek <pmladek@suse.com>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Jyoti Bhayana <jbhayana@google.com>,
 Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andi Shyti
 <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
Date: Fri, 07 Jun 2024 12:41:37 +0200
In-Reply-To: <ZmHD63_tvC75To8r@smile.fi.intel.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
	 <20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
	 <ZmGMwwglUlS6_NI_@smile.fi.intel.com>
	 <da57a64e4f5cdda7ee6b794c448995eee648c436.camel@gmail.com>
	 <ZmHD63_tvC75To8r@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 17:12 +0300, Andy Shevchenko wrote:
> On Thu, Jun 06, 2024 at 02:27:03PM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2024-06-06 at 13:17 +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 06, 2024 at 09:22:38AM +0200, Nuno Sa wrote:
>=20
> ...
>=20
> > > > +			return dev_err_ptr_probe(&st->spi->dev, -
> > > > EINVAL,
> > >=20
> > > You can make all these lines shorter by using
> > >=20
> > > 	struct device *dev =3D &st->spi->dev; // or analogue
> > >=20
> > > at the top of the function.
> > >=20
> >=20
> > Well, I had that in v2 (making the whole driver coherent with the local
> > struct
> > device helper but you kind of "complained" for a precursor patch (on a
> > devm_kzalloc() call). So basically I deferred that change for a follow =
up
> > patch.
>=20
> Hmm... I don't remember the story behind this, but probably it's good to =
have
> this done one (precursor) or the other way (follow up). Just check how ma=
ny
> changes will be done, whichever diff is shorter, choose that one.
>=20

Well that has not much to do with the current series. I would prefer to hav=
e a
follow up when we're done with the current changes. Right now I would reall=
y
prefer to focus on the new dev_err_* APIs and see if anything else is neede=
d for
this to be acceptable.

- Nuno S=C3=A1

