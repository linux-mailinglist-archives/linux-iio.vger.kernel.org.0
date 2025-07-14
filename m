Return-Path: <linux-iio+bounces-21637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CCB03BB8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 12:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76467189B838
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC18F244186;
	Mon, 14 Jul 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="aBgYoWLX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A61DDC2B
	for <linux-iio@vger.kernel.org>; Mon, 14 Jul 2025 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488174; cv=none; b=UZdf7CTkeqbAVLE6Z76I+gqhTNAWU1iO4m0JEzGqLizhQP7tg/cnT0EpWKqKPiMzwrJkjpEs6oTQxR18RVBRdna4/CnIkr53VdDMYeNYuoNoW4/ujEQTpinQS+m+NakQlOQcK6ljpcBPjiMZ+8mA8AKG/TuuhRLAgsLMOt8AYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488174; c=relaxed/simple;
	bh=TEA+LcV8PJ/77CIpg1cZRcs6OYEz2keG6V1mKniOMXU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvrWOxzeur+E3y5P/mEZjiIkq9l6Wy4vXN0/jonO32ILtQ+GYQYxQ496HIUTzCsjwvZgHlsb9aXXt+6bNW2QzCeNFZ1SnSvUmY1TdSEBKnC/CYXX4zqy7rS9+tduoB1mUvT8UT9bi6XXOTX96pZp2S9vCgWs70fZll/jDNvEh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=aBgYoWLX; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752488165; x=1752747365;
	bh=TEA+LcV8PJ/77CIpg1cZRcs6OYEz2keG6V1mKniOMXU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aBgYoWLXNvAxJ8mnO0Ux+QFgS3RV7HwkD+5cW19RgaWPJjTjaznFcjVaY/ZcZFEw8
	 NdThDsXerd1fnlMJsB69/xi0JSP39H0bzDPm+dsnoSVWqwfoqO81+t1GRNFzQRBpKa
	 VsmGwF4edjOySmBr9UA/E1ceKSAbWpZbBuLiO4VQRJsEULYWRKaZ1YSrgy253J+twz
	 eooe2nEZP/u/q9fvp2GMbC9BSO8FiQcX+U4LhQBXanJbH+DtfWRraOPJlQUbMlwUjr
	 D2YezV+RblSlPW8HDR1NbWE/mYUrxJCy6JPmtm1FsnlA/NjEyd2O42TDGCodyiKh9O
	 m4BljzDikaAvQ==
Date: Mon, 14 Jul 2025 10:15:59 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
Message-ID: <kcrov3lqigiqzea2eds73ibhix46ovqrqkhodfatqwfmjanxya@l2cla3fkl6ow>
In-Reply-To: <20250713153227.08af0a54@jic23-huawei>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com> <20250709-icm42pmreg-v1-6-3d0e793c99b2@geanix.com> <20250713153227.08af0a54@jic23-huawei>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 60d8d85adecaea37af326a4d51a2bcdaffed5921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 03:32:27PM +0100, Jonathan Cameron wrote:
> On Wed, 09 Jul 2025 14:35:14 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> > Do as in suspend, skip resume configuration steps if the device is alre=
ady
> > pm_runtime suspended. This avoids reconfiguring a device that is alread=
y
> > in the correct low-power state and ensures that pm_runtimeM handles the
> > power state transitions properly.
> >
> > Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42=
600 driver")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
>=20
> Not really related to what you have here, but this code would really
> benefit from using guard(mutex)()
>=20
> Jonathan

I have converted most of this driver to use guard(mutex).

Does it make sense to use guard(mutex) in functions that still relies on
goto error out? Like...

static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
{
=09struct device *dev =3D regmap_get_device(st->map);
=09__be16 *raw;
=09int ret;

=09pm_runtime_get_sync(dev);
=09mutex_lock(&st->lock);

=09ret =3D inv_icm42600_set_temp_conf(st, true, NULL);
=09if (ret)
=09=09goto exit;

=09raw =3D (__be16 *)&st->buffer[0];
=09ret =3D regmap_bulk_read(st->map, INV_ICM42600_REG_TEMP_DATA, raw, sizeo=
f(*raw));
=09if (ret)
=09=09goto exit;

=09*temp =3D (s16)be16_to_cpup(raw);
=09if (*temp =3D=3D INV_ICM42600_DATA_INVALID)
=09=09ret =3D -EINVAL;

exit:
=09mutex_unlock(&st->lock);
=09pm_runtime_mark_last_busy(dev);
=09pm_runtime_put_autosuspend(dev);

=09return ret;
}


If I use guard_scoped(..) it creates a lot of diff lines...

/Sean


