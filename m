Return-Path: <linux-iio+bounces-22558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C049EB2045F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D319818A059F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D15233713;
	Mon, 11 Aug 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LymLS/9A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A21EF0B0;
	Mon, 11 Aug 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905803; cv=none; b=At42vlyk5x4Pb7CfYzv7ApLP5sEiHw4hZdrgKGFmS8QbhZ4B2tH/ucl2pig4y11T+WVIoep7IkeyrDsqDNs4QGYujUsmLafcSmOfVEuatAk0CDLo+MUEJE+pei6qhdUksLy97AJ/UEglBzQKH/8nsw3qo5kLwf5+xcVoJJdEW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905803; c=relaxed/simple;
	bh=+IYKCD0nOJYn6yRnTmu3JVuBWFyDouOFfYOc8XfdO40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgDJ5SUu8/nAvxURRFwLVqe+mf4i4oX8xWjfL7HtoNHNlgPoHH6kg2k86NJgmCFLBHK3vQa4TFA78dHOLwD6u3feE3ofszbdMuJebt8qreKtJBWaZxWz4GXqOfjfz28LMwZpMYw5oWKEVXabUE9b0dUWp0vrVeQMgVVV8HSfc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LymLS/9A; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1754905795; x=1755164995;
	bh=+PMplA1rCZ5dgg5MkoqVzFnRYmdaxtuR8d/bb3ek6y4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LymLS/9AfzD/Wlf1SaWPfAuzDiRI+bk4LmcY+Au0QJutZOVfqnHqc4cSdtqpqaBKr
	 UMg417pOsWxsZcEr8PqslseE94aiQXFqcG4JeXZUtryRqg97okEjLxt8YpHT/TIXsC
	 4Ay9dNwaDwO5OIkLYzv09V+9KgDT40v9TKPvRj9S/HY3aC/46vbX8H2pJp3btAcruq
	 CSGpGcB/19IV+cJtjSuRtkI2LHR5W5HqL19VkgvcSlrb3IQ7u+PGGVQNNntOrhRNCo
	 Qr2ccZ3VI9DlJ+pvj9gVS17jLeE9rkoGh9vO1TM9eUB3dee9+00+KHlfNMT4cjF5ZZ
	 FwWfSps551hWQ==
Date: Mon, 11 Aug 2025 09:49:49 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>, jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: change invalid data error to EBUSY
Message-ID: <xfhhfw75w5pqvzhcujrszzom43mzejllqnvh5ulcnj22ifp4fs@q5zohi6c2vxv>
In-Reply-To: <20250809202440.552e1cdf@jic23-huawei>
References: <20250808-inv-icm42600-change-temperature-error-code-v1-1-986fbf63b77d@tdk.com> <20250809202440.552e1cdf@jic23-huawei>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 3766b6357cc8ef568932d723a6bcb7c1339773d6
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 09, 2025 at 08:24:40PM +0100, Jonathan Cameron wrote:
> On Fri, 08 Aug 2025 09:40:10 +0200
> Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.c=
om@kernel.org> wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >
> > Temperature sensor returns the temperature of the mechanical parts
> > of the chip. If both accel and gyro are off, temperature sensor is
> > also automatically turned off and return invalid data.
> >
> > In this case, returning EBUSY error code is better then EINVAL and
> > indicates userspace that it needs to retry reading temperature in
> > another context.
> >
> > Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor su=
pport")
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > Cc: stable@vger.kernel.org
> +CC Sean who raised the issue.

Reviewed-by: Sean Nyekjaer <sean@geanix.com>

>=20
> > ---
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_temp.c
> > index 8b15afca498cb5dfa7e056a60d3c78e419f11b29..1756f3d07049a26038776a3=
5d9242f3dd1320354 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> > @@ -32,8 +32,12 @@ static int inv_icm42600_temp_read(struct inv_icm4260=
0_state *st, s16 *temp)
> >  =09=09goto exit;
> >
> >  =09*temp =3D (s16)be16_to_cpup(raw);
> > +=09/*
> > +=09 * Temperature data is invalid if both accel and gyro are off.
> > +=09 * Return EBUSY in this case.
> > +=09 */
> >  =09if (*temp =3D=3D INV_ICM42600_DATA_INVALID)
> > -=09=09ret =3D -EINVAL;
> > +=09=09ret =3D -EBUSY;
> >
> >  exit:
> >  =09mutex_unlock(&st->lock);
> >
> > ---
> > base-commit: 6408dba154079656d069a6a25fb3a8954959474c
> > change-id: 20250807-inv-icm42600-change-temperature-error-code-65d16a98=
c6e1
> >
> > Best regards,
>=20


