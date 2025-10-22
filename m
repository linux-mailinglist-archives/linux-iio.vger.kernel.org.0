Return-Path: <linux-iio+bounces-25339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DADBFAC69
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 10:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568943B8238
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 08:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598B32EBBAC;
	Wed, 22 Oct 2025 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E8h+jbOf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF22FBDE2;
	Wed, 22 Oct 2025 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120362; cv=none; b=HzZderu40wEq3kUwEO25KH5j0xlKfaAhGIc1hYJk0ZbN+PfJQKQf/CclREIlWVwuMffCaLyMIMsE0+DndkARL3T297JEQjOMZ2PIN61ng4jA1xcNooYAvujBhe+3Nv5CqHNkXKTbFFrozv+xsib7//niEJ88urfseGuZfSdmxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120362; c=relaxed/simple;
	bh=/u7cWJFmGb/0w3Q0RV4B5oTchZg1wFWsEu3Y+CNnIGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHkYQCUt0NZrc4jBeiRxLhivj1R66zDD2gJwKAELlATqnCSYH3GwesDxrxZj6FsnzW5LG83DnFMiYqtndqVFqbM51jZw5FMJhcN5KZX+N27VAcVOTye3FD32CThnSTHjqLJpiH3Bay1ya7H4NmTJSDqB2q5fDe2KnaDoeVSIjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E8h+jbOf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 79B114E41271;
	Wed, 22 Oct 2025 08:05:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4BB03606DC;
	Wed, 22 Oct 2025 08:05:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3AB4102F242C;
	Wed, 22 Oct 2025 10:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761120355; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bT/1MPxwrmKaeOltuH31t1GkUZWM2AMvg1m2hzc9/1o=;
	b=E8h+jbOf8YX1pJ0j+IrYZWNJogH+0/urPN8krmqLEcautSwXzEF6rctq7whJ/1XmYujiDa
	T3uXjMZjsA1bbf7lSQylFTKGeKBmVLjxI1/UJyb2aA1znzYHewpYAYSSr84ukB4QPxLbXN
	ZWOqtlt+4TKdeLg6B1UgxIilXCpyJxdXIV9Z/Rm1j8qBOoN7L7vsOb/n1OOKkxzrjK14QF
	r9f7GkqOPFVlxr99h32ACznyorrpNf84W1Si2ewWh7iI34xiGyvZ1BhErMipVgk8VMmBnL
	F3xvdMj9x1kv0mYcjtSjCJNzGboiR5rKA0/qkD7ao2ZoWRhRhDOlJQigm4aMHg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Herve Codina <herve.codina@bootlin.com>
Subject:
 Re: [PATCH v2 5/5] regulator: ltm8054: Support output current limit control
Date: Wed, 22 Oct 2025 10:05:40 +0200
Message-ID: <3500149.e9J7NaK4W3@fw-rgant>
In-Reply-To: <20250925-ltm8054-driver-v2-5-bb61a401a0dc@bootlin.com>
References:
 <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <20250925-ltm8054-driver-v2-5-bb61a401a0dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3863480.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart3863480.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 22 Oct 2025 10:05:40 +0200
Message-ID: <3500149.e9J7NaK4W3@fw-rgant>
In-Reply-To: <20250925-ltm8054-driver-v2-5-bb61a401a0dc@bootlin.com>
MIME-Version: 1.0

Hello everyone,

I've encountered a rather troublesome issue with this particular patch,
which has delayed version 3 of this series. I'd like to describe it here,
so that you can tell me if you have any suggestions for an upstreamable
solution.
 
The problem concerns the set_current_limit() and get_current_limit()
callbacks:

On Thursday, 25 September 2025 14:37:37 CEST Romain Gantois wrote:
...
> -static const struct regulator_ops ltm8054_regulator_ops = { };
> +static int ltm8054_set_current_limit(struct regulator_dev *rdev, int
> min_uA, int max_uA) +{
> +	struct ltm8054_priv *priv = rdev_get_drvdata(rdev);
> +	u64 vdac_uV;
> +
> +	min_uA = clamp_t(int, min_uA, priv->min_uA, priv->max_uA);
> +
> +	/* adjusted current limit = Rsense current limit * CTL pin voltage / 
max
> CTL pin voltage */ +	vdac_uV = (u64)min_uA * LTM8054_MAX_CTL_uV;
> +	do_div(vdac_uV, priv->max_uA);
> +
> +	dev_dbg(&rdev->dev,
> +		"Setting current limit to %duA, CTL pin to %duV\n", min_uA,
> (int)vdac_uV); +
> +	/* Standard IIO voltage unit is mV, scale accordingly. */
> +	return iio_write_channel_processed_scale(priv->ctl_dac, vdac_uV, 
1000);
> +}
> +
> +static int ltm8054_get_current_limit(struct regulator_dev *rdev)
> +{
> +	struct ltm8054_priv *priv = rdev_get_drvdata(rdev);
> +	int ret, vdac_uv;
> +	u64 uA;
> +
> +	ret = iio_read_channel_processed_scale(priv->ctl_dac, &vdac_uv, 1000);
> +	if (ret < 0) {
> +		dev_err(&rdev->dev, "failed to read CTL DAC voltage, err %d\n", 
ret);
> +		return ret;
> +	}
> +
> +	uA = (u64)vdac_uv * priv->max_uA;
> +	do_div(uA, LTM8054_MAX_CTL_uV);
> +
> +	return uA;
> +}
> +
> +static const struct regulator_ops ltm8054_regulator_ops = {
> +	.set_current_limit = ltm8054_set_current_limit,
> +	.get_current_limit = ltm8054_get_current_limit,
> +};
> +
...

I've encountered a lockdep splat while testing these callbacks. I've
included a summary of the splat at the end of this email [1].
 
After investigating, it seems like the issue lies with IIO callbacks in the
ad5592r driver being called with the LTM8054 regulator device lock held.
 
The ad5592r callbacks themselves call into the regulator core to enable the
DAC's regulators, which might try the LTM8054 lock again in the same
thread, causing a deadlock. This would only happen if the LTM8054 was
supplying voltage to the ad5592r.
 
There are two parts to this issue:

1. Making sure that the CTL IIO channel used by an LTM8054 device isn't
supplied by the LTM8054 itself (or a consumer of the LTM8054). Solving this 
removes the risk of an actual deadlock.
 
2. Silencing the lockdep splat. The splat seems to be triggered by the IIO
driver taking the general regulator ww_mutex context, which means it will
still occur even if we've made sure that the IIO channel isn't a consumer
of the LTM8054 regulator.

For part 1., a potential solution would be to create a device link with the
LTM8054 device as a consumer and the CTL IIO channel as a supplier. IIUC
device links do not tolerate cycles, so this should ensure that the IIO
channel isn't a direct or indirect consumer of the LTM8054.

However, the LTM8054 driver cannot access the IIO device struct to create the 
link, so adding a new IIO consumer API function could be necessary.
 
For part 2., I'm having more trouble finding a proper solution. One
potential fix would be to put the IIO channel reads/writes in a LTM8054
driver work item and have them run without the regulator lock held. This
would incidentally also solve part 1., however it would make the current
limit operations asynchronous, and it seems like a lot of unnecessary
complexity.
 
Please tell me if you have any suggestions for solving this, I'll keep
searching on my side in the meantime.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

[1] lockdep splat summary
```
WARNING: possible circular locking dependency detected
6.17.0-rc6+ #9 Not tainted
------------------------------------------------------
kworker/u17:0/34 is trying to acquire lock:
(&iio_dev_opaque->info_exist_lock){+.+.}-{4:4}, at: 
iio_read_channel_processed_scale+0x40/0x120
   
but task is already holding lock:
(regulator_ww_class_mutex){+.+.}-{4:4}, at: ww_mutex_trylock+0x184/0x3a0
   
which lock already depends on the new lock.
   
   
the existing dependency chain (in reverse order) is:
   
-> #2 (regulator_ww_class_mutex){+.+.}-{4:4}:
       lock_acquire+0xf0/0x2c0
       regulator_lock_dependent+0x120/0x270
       regulator_enable+0x38/0xd0
       ad5592r_probe+0xcc/0x630
       ad5593r_i2c_probe+0x58/0x80
   ...
       ret_from_fork+0x10/0x20
   
-> #1 (regulator_ww_class_acquire){+.+.}-{0:0}:
       reacquire_held_locks+0xd4/0x1c0
       lock_release+0x148/0x2c0
       __mutex_unlock_slowpath+0x3c/0x2f0
       mutex_unlock+0x1c/0x30
       regulator_lock_dependent+0x1d4/0x270
       regulator_get_voltage+0x34/0xd0
       ad5592r_read_raw+0x154/0x2f0
       iio_channel_read.isra.0+0xac/0xd0
       iio_write_channel_processed_scale+0x64/0x1e0
       ltm8054_set_current_limit+0x70/0xd0
   ...
       ret_from_fork+0x10/0x20
   
-> #0 (&iio_dev_opaque->info_exist_lock){+.+.}-{4:4}:
       check_prev_add+0x104/0xc60
       __lock_acquire+0x12a4/0x15c0
       lock_acquire+0xf0/0x2c0
       __mutex_lock+0x90/0xc80
       mutex_lock_nested+0x28/0x40
       iio_read_channel_processed_scale+0x40/0x120
       ltm8054_get_current_limit+0x34/0xa0
       kthread+0x11c/0x1f0
   ...
       ret_from_fork+0x10/0x20
   
other info that might help us debug this:
   
Chain exists of:
  &iio_dev_opaque->info_exist_lock --> regulator_ww_class_acquire --> 
regulator_ww_class_mutex
   
 Possible unsafe locking scenario:
   
       CPU0                    CPU1
       ----                    ----
  lock(regulator_ww_class_mutex);
                               lock(regulator_ww_class_acquire);
                               lock(regulator_ww_class_mutex);
  lock(&iio_dev_opaque->info_exist_lock);
   
 *** DEADLOCK ***
```

--nextPart3863480.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmj4kFQACgkQKCYAIARz
eA6puRAAnJGqhKF/LyR1iSyJYMIpEbmkGrn44GV4qMZpIK/EAwx5vhTXSevTcG+v
wt/5ovGF/Fs0IuZ9LLheFczozHvDk33TfK/Pa62zePu1PnMYwJ9Q1dwoqHDQCrHI
RzB1EMsKj1S22YwPuHrNc8NH+VkSaVvE+kChOze42mvwS86qY+O9QA4q+tUkMEAu
W6kgmy9SQZDqqosIdNiotok5UyQoQKuA+4cWzFPwpCUMqo13GIhQ2wXYqWHxSBTR
ZuWMWqq2c2lzLrxiqLUEUVsdyL1AG7FyUOBqQ0SWoyId0Zq18a8vr7vPyftsb+rt
f0pqu14srqOA/xyUYfRv11FYRzr3oi11GZw5tRI7Nn74MhxZUWh4KmoYCKAjnNRN
UQyjrKsl74BTC8F38/JBp+rqL4SYzhJh8/53Up7Dh5aCJXJvEEpI1k8pBTSOqdpU
aC8fVDbVjiBn2EVobiBP75wnvEvLz/jRZAphZWpFJDa1+LZ178GqWZCKF/Y0O+jI
JW2g25G/FHZiYhcKHwyH19xY8+vCnaF/dQyL49TprCSSUJdQBaijZal5jwLtidjm
MYE+Hopih7ccfVwKhmyghQhfblZLvc+/6zpr6mSE4BmKT0crqgSQXAxuE/vIZOYI
Zg+H7rvLGF06Coe8e0flLq7e3zh1hAsE9yWM1UNOsywvU8YEAbo=
=wEUM
-----END PGP SIGNATURE-----

--nextPart3863480.aeNJFYEL58--




