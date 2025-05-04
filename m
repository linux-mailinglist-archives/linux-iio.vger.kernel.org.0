Return-Path: <linux-iio+bounces-19044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 388D2AA875F
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 598AF7A3A10
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275F1C84AF;
	Sun,  4 May 2025 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFbsmnFX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5551FAA;
	Sun,  4 May 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746373621; cv=none; b=rH2yY0fhI/LG1C9HfuVQgQQ21LxJEQSmvucc1u5TTizus1GP7igAogatZKO/vJyxxmApYn6M7mvbJEhhcXZO669Tjo1NXDBXjB+7dIWVBTA98YQlPh525Y/d7IDBNLt+O0RQR9Z/HTqgVNa382/Lo9zjWUf2s6AbSUNsn7OS4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746373621; c=relaxed/simple;
	bh=eg438LQYInqo9y9/Eti33rySAFBXRXmJbYUQgtWCs0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgR/wd+caqG2QE/cfJtngg4sPK4UlF3ld8oYfJU++JNOEJC03xZQy6dEE60WoI5BHxGuwf12wJGv1MhZWXL0iREOl3YQmFxYPCb64F/qCf0IJbNtIUDcLmpSavbv/H8vE233ZeLXIqSCmNgPVDa+95xHJ5d11EMmanlLMTw1Hgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFbsmnFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5908C4CEE7;
	Sun,  4 May 2025 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746373620;
	bh=eg438LQYInqo9y9/Eti33rySAFBXRXmJbYUQgtWCs0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gFbsmnFXqB/zNRPAC4/USD3No37/d31n3jIhyUrZl1uaZL4rPhRiMhau+tkJ0ryx9
	 5PJKG3UvnIjUZ7Zq3HgjU/QPaUwrjfPOHp23zcqKso6amW2OkkAKqhL6vAqfGqO4Z6
	 qxLMgkUdg/nW/U46nUuC7IIWpSu32lf8t3KnGXjNtCGjmsvWlUD5nHwnMfX8dRbUPx
	 gQf15QdnlsPQbD/elmUgyvoESRY6tcWYPXjNHVp2EqQQnmb+E0cReCgfnr5RRIDMQ2
	 yiHTm9ns3fg+kGyClV6O0GjHmkD0+1ZiusGmg2FzgjOXwIRluHA7+xQZPgPPRL4nHY
	 H1J69SuM773jQ==
Date: Sun, 4 May 2025 16:46:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: accel: fxls8962af: Fix temperature
 calculation
Message-ID: <20250504164654.1ecf7215@jic23-huawei>
In-Reply-To: <CAHp75VehpQdxFDXE8L0TeaOxHBTHNorOZ95rL48kQAiViAJ_zg@mail.gmail.com>
References: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com>
	<20250502-fxls-v2-1-e1af65f1aa6c@geanix.com>
	<CAHp75VehpQdxFDXE8L0TeaOxHBTHNorOZ95rL48kQAiViAJ_zg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 May 2025 17:19:44 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, May 2, 2025 at 9:15=E2=80=AFAM Sean Nyekjaer <sean@geanix.com> wr=
ote:
> >
> > According to spec temperature should be returned in milli degrees Celsi=
us.
> > Add in_temp_scale to calculate from Celsius to milli Celsius. =20
>=20
> ...
>=20
> > +/* Raw temp channel scale */
> > +#define FXLS8962AF_TEMP_SCALE                  1000 =20
>=20
> Wouldn't constants from units.h be helpful here?

Whilst you are just continuing local style, I'm not sure
these defines really bring much at all given the TEMP_SCALE
one for instance is only used in one place which is
explicitly getting the temperature scale.  It's not a magic
number that needs a define. It's a number that means it's own
value :)

Using MILLI there would be a nice bit of self documentation
though.
>=20
> >  #define FXLS8962AF_AUTO_SUSPEND_DELAY_MS       2000 =20
>=20
> (2 * MSEC_PER_SEC)
>=20
> This gives immediately that we want 2 seconds of delay.
>=20
True but not part of this patch so that would be a nice
little follow up.  Possibly dropping this define in favour
of using that inline.

Jonathan



