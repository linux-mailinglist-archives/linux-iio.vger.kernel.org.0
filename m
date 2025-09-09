Return-Path: <linux-iio+bounces-23902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9AB4ACE7
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB5116799D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0222F3C30;
	Tue,  9 Sep 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Irzlj/+f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE193054E4
	for <linux-iio@vger.kernel.org>; Tue,  9 Sep 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418796; cv=none; b=S7TTyPS3gWHwc3B4/QD8DOSc5rjuDzv4qgRgQFd+l0j7OOOTkFHIPyd0xTAV+4Mu8URKpdr3OEc4vWcL+4yj70kvA0BCiBC8j2ngtM00XA7V25h1+A90bChTJBeiWxx/ETtLMANeMhXWoxLYwtBahURXCZC90JNuAIzUdgfN9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418796; c=relaxed/simple;
	bh=7p/IFQC8oZeSqLO0B3nFKcXQ4vxxPtWVpr4nLoPMO/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3GeJOyuZJ8lcmV19OmZC5ty/jU1+//PcT9lJ2qSuFERFX3NctoyPxCKEMeqIPb6Ts18sijf+er6BcKAvAmIgkdi1dL6krYDa2QZcSIuU9eQwqOj1QtPKs1cOsdNe2zI5lzUNGr7bX5OulItvhk9KC7DyrK6pBqkg1tpsWI7Wds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Irzlj/+f; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1757418789; x=1757677989;
	bh=lD7LJZ28elt7iNEzz4ZSyjVvQeRMRYgTPV53PvtxbB0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Irzlj/+fwS3ZT1i22FdTTv/TMBCGn4cxWe140XroU3yqw/qmiM43ju1VGdSmTPTZY
	 DFE5Q8s0fKi50AK6bklbqNPq0cZxUNIYwvOY0YLjAYLKak9WHOkw7lmPkSTCzz3o49
	 D+d/cTvqPkq34G2+6CaYGYbUpdSkvgHDB3JeDRy+JGcWcuX7UCr3ehG8Gt/IpEAkq2
	 Sby9T26htePPBq93GGRFWXMO4B8JGToD1qigETFc2e6WHqgz3x4DHuZGrJqjrsXFxa
	 u6pwD6rI391/MiEwgE978bsfjJNFKwt9wrpV3pdapXuCg2qCIpbG2SMVaqwynti8j5
	 ERNpQ7YhJaXmA==
Date: Tue, 09 Sep 2025 11:53:02 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 5/5] iio: imu: inv_icm42600: use guard() to release mutexes
Message-ID: <wl4fvd76hjf66k6pmkoce5wg5luspxjjsclxg5pdh7rjycarko@ovddl55mn77l>
In-Reply-To: <aMAR4Jx3pWQ1_rjX@smile.fi.intel.com>
References: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com> <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com> <aMAR4Jx3pWQ1_rjX@smile.fi.intel.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: cf527d5107a9426c6e8d871b73c77ca78b4c1d4a
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 02:39:12PM +0100, Andy Shevchenko wrote:
> On Tue, Sep 09, 2025 at 09:11:11AM +0200, Sean Nyekjaer wrote:
> > Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> > for cleaner and safer mutex handling.
>=20
> ...
>=20
> >  =09/* exit if FIFO is already on */
> >  =09if (st->fifo.on) {
> > -=09=09ret =3D 0;
> > -=09=09goto out_on;
>=20
> Probably you wanted the same comment here
>=20
> =09/* increase FIFO on counter */
>=20
> > +=09=09st->fifo.on++;
> > +=09=09return 0;
> >  =09}
>=20
> ...
>=20
> >  =09/* exit if there are several sensors using the FIFO */
> >  =09if (st->fifo.on > 1) {
> > -=09=09ret =3D 0;
> > -=09=09goto out_off;
>=20
> In the similar way
>=20

Considered it. But isn't it obvious whats happening?
I will be happy to add them...

/Sean

> =09/* decrease FIFO on counter */
>=20
> > +=09=09st->fifo.on--;
> > +=09=09return 0;
> >  =09}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20


