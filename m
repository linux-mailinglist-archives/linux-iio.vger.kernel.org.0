Return-Path: <linux-iio+bounces-26646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54AC9C8AA
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A033AB42B
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8132D0611;
	Tue,  2 Dec 2025 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD7t/eOh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B52C21CF
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698597; cv=none; b=qnf9xyyZ7BnciUwc4xYrFQNajUfonp7IqJl9u5fgUIucAM6cwcVLnbyCvFepAsqs0L6nA+DMnpT3Tk5S+ya+d1fb3vILAvZrv0/T5dN5NIEB1Wf1RcY+BgWEtp/sgNVV3lMre/10q6jk/8H0os2GjXp/evbIr9Ukf6zLs+FD5DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698597; c=relaxed/simple;
	bh=xYFCAMP/TzmAZ3h96BG3mcGcEgMJvGWYRrdvrsW+NNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plcy6iOv7Bux5hpbyHAA4Ro8VrsNgJq0TrPvPNux553jD89HvF9ThX7uNKM99YhlHlYht3OeMAv8rzrmshKAd1XkiMMkRVrwCy7MolcgxuV/8Dxqu7y4dTgjkn+ACSdDgTMC91bk3l39oqI/z2A9/uMxs3TctBKrB1pGxeMVHbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD7t/eOh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so776088666b.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 10:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764698594; x=1765303394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX3uO876Nbv16MV1u14hjtjcfT7O6fugZYUBWagHA1Y=;
        b=GD7t/eOhNrI+P4kPW0baDv4yAi6/F4pcEr+Pi431pEC8O9S8Ke8F8uEIx99A9AL3ao
         JT3bdvO59pHit0WDHyF9nXuowk28Xd2mwBfBNIulTGIFon/GjztRVqY6CZRTSbbGR9c2
         3COoq/GCFBbwzCXQoGU80Ynpc+zcRsjr4eGyVzfLge75X9M8vIOV9mfXuxUMZiIXXlkf
         S29WBVZgodhD4Z5JVi2ohqEV/H1IWhonBLuUgVmjFiXKoNjc/oL59sMPeLOU2hiRzbya
         k1osTkb1xi+AlT4X2cZ9/eWVd4gbt8jP4aPKLoDlAT56lroPAWIQYNIgyFYL51B77jfP
         HUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698594; x=1765303394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TX3uO876Nbv16MV1u14hjtjcfT7O6fugZYUBWagHA1Y=;
        b=tSrAnHo64LzweGnwrJklV3SFIoI8OTsW4f+sKG9HvzCEXe1p2/WhBcWTKS1Z1t3I0v
         g9BxKBS++44fIyUmtjuf8M1mU+wIlJR8MozEJY3r7Rpjp9KzvjZ+4lWhXyC+Vrp9SLT2
         B4shLUbLJtyVm+CwhqcM0gyxS6hGtAXp23qNrCU+Mxrh7rVJGjPdERfjEDibx00TjN+A
         SMj7sxE8UvSpU5YjSuCfRvwd8qHiNOcAZohrMBUoBfW2d1OjzdsrpJWZD9+avhzORYI7
         1AWvLI/jsFBBRkaD96TILQZ2qoY5cnIQuvc8IpvB/fKhzava8sEZBkJov+VBd7O6leoA
         uz9A==
X-Forwarded-Encrypted: i=1; AJvYcCUcc1itJuzKSq9mTnl3BQaCoEv0l1aouyx0UGVv+xtx8C+hbqJ6RriylohJHPaSlmJVS9CfaWRcacg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFvy8/qkYKEWJJ8rxW7p/2OPnyLvkQLKMMvCOyjpHoMLM0up4
	Em5T2E6ZyebEjDr+cK5L1hTYxMwm0vTW+0g+/Ce9b6xmHc7AqaCe/42bEh9ypc77LNHNu2NfSv/
	5LN5Kym+tSQoDMy1scCsWKFLlUyfcKBk=
X-Gm-Gg: ASbGncsOT+ZHCwiyT/3/eaCsbevxK/CuD/153rSIy7LzJiBl5MX5cid/ui8gvT/3Rx5
	D+s71Zw20Zk50hTmhzbDVm9/8PcEn9o1T07tlTo3Q3WonDsvMb7IuQo2QOtfXJYXOVUs6riag53
	HGoYgOP/qH0/WCCB1Oy79RyQH4UztRrC8WlljS7Y2APHIBOPmDr7M9u0CUIMe8E6kg5zmINsE5i
	uto3hGNOF0UUvTgPIR4yS9WrnjBecKp08JPF63sgJokDfO1cFLuNbO5OJUcgK4CXUR1whrPY28m
	yAlUf6QbLm0ibFQe6HBct/4ChjpHZMRwH26j9aN8xhcTptnxmzPmG4jKsytvry1tJlpESIA=
X-Google-Smtp-Source: AGHT+IGdSyF8+NtOshXIDUNIdb8J45I23/XSFH/NeWfoT4LBellHCBO1HIMFayepWdznlKwec73WSVm0fZH76CVkJU4=
X-Received: by 2002:a17:907:801:b0:b73:7b97:5bfb with SMTP id
 a640c23a62f3a-b76717053b4mr4837949566b.33.1764698593583; Tue, 02 Dec 2025
 10:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com> <aS7zf3ZGVEdTrNvF@smile.fi.intel.com>
 <c1cce165-0c34-4277-89b4-b0117ebb4bba@vaisala.com> <2ccd698bb58f36fc1d25c36c43e20a6b689cdf5c.camel@gmail.com>
In-Reply-To: <2ccd698bb58f36fc1d25c36c43e20a6b689cdf5c.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Dec 2025 20:02:35 +0200
X-Gm-Features: AWmQ_bmATDCGue2u0lVzTBdkbGUyGZr72kCUT-8qxUG7ESeEV-CyNEnBmWxx5MQ
Message-ID: <CAHp75Vda+uCkfcTY2T0LzETMnkLCZfMVnUAxLhmATLzrrLwaNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 6:08=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
> On Tue, 2025-12-02 at 17:01 +0200, Tomas Melin wrote:
> > On 02/12/2025 16:11, Andy Shevchenko wrote:
> > > On Tue, Dec 02, 2025 at 12:53:09PM +0000, Tomas Melin wrote:

...

> > > > + return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
> > > > +                         AN877_ADC_TRANSFER_SYNC);
> > >
> > > I would make it one line, despite on being 85 characters long.
> > > But it's up to you and maintainers.
> > I would like to not fight against checkpatch here.

Checkpatch doesn't complain about this unless you specifically tell it
to do so with --strict.

> AFAIK, Jonathan policy is that 80 column limit is still the preferred lim=
it unless readability is
> hurt. So I would say the line break here is up to the IIO policy.

Right, that's why I wrote the second sentence there :-)

--=20
With Best Regards,
Andy Shevchenko

