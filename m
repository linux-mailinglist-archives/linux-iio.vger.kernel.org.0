Return-Path: <linux-iio+bounces-2050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BC84269D
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 15:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D3B1C268DF
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E686D1D8;
	Tue, 30 Jan 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRxWmmuR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5086D1D3
	for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623527; cv=none; b=Kf8ml9cH9oY+otQO4BB4TWrJL90mAfY+I+AN45e5PVFga/R10Q2bhvu48xhJvBB8LRNzYkhvcFDY/6ENmI5/TNrBlV0vpFGF55Ke6CyqjoODi862f3Noe33raH+sYv8RzFX37HmVRcXmRlSOjpFJK1BqvCEeW+56T0EngE7kNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623527; c=relaxed/simple;
	bh=bwdmT/elt4Y8Jpk+SXQUGatVeEJVXvW8q9rDffQKDK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kn28rk4wTytZZKajaJ4AIYoLmhJ5IOFYa+6K6KcK0m5X75r9zf93LKK6K2a0uTGK9+pyM2L4+F1lDJdgS+I09oJAZS4g1Ysa0u5RZbaZm89LibvEg6hl0+fFZGfzZxmaZYkZXF2U2LuYr407Sk8l4NMu8fmw9Ks7bXoHpCOkSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRxWmmuR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d057b6ddfdso10667491fa.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 06:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706623523; x=1707228323; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ooxN1jxUsP1LOjCvI3qgaE0sKyJ2+HAMv2LVNjgf/w0=;
        b=HRxWmmuRXd1YZWJMHE/DbG4AC/Xa/cBSf5ouXKqvpIU4HAx7TXnJH7Yh5iqhBj+V0O
         /9MUVwQhcq0ZBi6Pif/pVEKIexy1ycE+01v9K+HjONa1T3ckF8lNdfVVeIloyAiznswW
         J2NXHhEnlI8tzNHtTHYvhv331BadCtuyI98hOp3bUGYQzMXgXBtQ2GtGeJhHaq1aStLJ
         FYM0ii0qcvkhKx0nUbMAkh0jSQxwiBPsRfkGzOhCejVHdVO3F8rMzj/gvzF1Nrv/e7A7
         xxl5Q292Um2uBHwfDVqPAtMKvEfkOdsUiiFFn6GRFu2vvc7hBfIv7fTkKsUfNysjlBf+
         2JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706623523; x=1707228323;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooxN1jxUsP1LOjCvI3qgaE0sKyJ2+HAMv2LVNjgf/w0=;
        b=ebArjN+kEYHGHC0yhf5CmMldL8EncNRPEyGQarOh2qTMYos3VIJ969TjdbM2OObisx
         4L9CdGNLAFa2JvOCF5HDGhKe7PRCG67Le3Juz1YHfLszVt+RFsEIxrwTnbEXpabSkX3l
         +ggqGygXmRJ7B/s+4SKM7XDa809zgMcqfwuMaOqnyHctEe7i/6TcUAUkxYT9BKkaYp3t
         hmvZGhb1EeTlzG7ge4CR8X/LMittK0s5BLlt9ZF0M25RVjL9qjYqiBS6D32VCY/uCjnU
         3HvBO8hYyXQ4aaeoczr9L71AXRAqcdyukbBralKuPt4HqkfdlQZSbqaUe5AK1CGOzIgo
         RRkA==
X-Gm-Message-State: AOJu0Yxff18BVlE6Gh2vZY4ezSK32679jE9RzRQ4BoKYii1rkSkGLBGv
	4M+m2NczRJvjRTPo7Oa8gTpqyc0ajeta0jQlWabmlYgWxUew8htn
X-Google-Smtp-Source: AGHT+IGxB8fh8cvYDTCfEmZR00D0bZkjtVeNIbA7FpNCea1sFtpiLEzID1/xL/1o7DkSPutn47POOQ==
X-Received: by 2002:a05:651c:1986:b0:2cd:7357:58eb with SMTP id bx6-20020a05651c198600b002cd735758ebmr7036559ljb.39.1706623523081;
        Tue, 30 Jan 2024 06:05:23 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6244000000b0033ae4a3b285sm8524437wrv.36.2024.01.30.06.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 06:05:22 -0800 (PST)
Message-ID: <d9b960c806cb5fc598a9149b38a2f139b42e5f24.camel@gmail.com>
Subject: Re: [PATCH 00/10] IIO: Use the new cleanup.h magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Tue, 30 Jan 2024 15:08:39 +0100
In-Reply-To: <20240128150537.44592-1-jic23@kernel.org>
References: <20240128150537.44592-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-28 at 15:05 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> The prerequisites are now in place upstream, so this series can now
> introduce the infrastructure and apply it to a few drivers.
>=20
> Changes since RFC v2: Thanks to David Lechner for review
> =C2=A0- Use unreachable() instead of misleading returns in paths we can't=
 reach.
> =C2=A0- Various minor tweaks and local variable scope reduction.
> =C2=A0
> A lot of the advantages of the automated cleanup added for locks and simi=
lar
> are not that useful in IIO unless we also deal with the
> iio_device_claim_direct_mode() / iio_device_release_direct_mode()
> calls that prevent IIO device drivers from transitioning into buffered
> mode whilst calls are in flight + prevent sysfs reads and writes from
> interfering with buffered capture if it is enabled.
>=20
> This can now be neatly done using new scoped_cond_guard() to elegantly
> return if the attempt to claim direct mode fails.
>=20
> The need to always handle what happens after
> iio_device_claim_direct_scoped() {} is a little irritating but the
> compiler will warn if you don't do it and it's not obvious how to
> let the compiler know the magic loop (hidden in the cleanup.h macros)
> always runs once.=C2=A0 Example:
>=20
> 	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> 		return 42;
> 	}
> 	/* Can't get here, but compiler about no return val without this */
> 	unreachable();
> }
>=20
> Jonathan Cameron (10):
> =C2=A0 iio: locking: introduce __cleanup() based direct mode claiming
> =C2=A0=C2=A0=C2=A0 infrastructure
> =C2=A0 iio: dummy: Use automatic lock and direct mode cleanup.
> =C2=A0 iio: accel: adxl367: Use automated cleanup for locks and iio direc=
t
> =C2=A0=C2=A0=C2=A0 mode.
> =C2=A0 iio: imu: bmi323: Use cleanup handling for
> =C2=A0=C2=A0=C2=A0 iio_device_claim_direct_mode()
> =C2=A0 iio: adc: max1363: Use automatic cleanup for locks and iio mode
> =C2=A0=C2=A0=C2=A0 claiming.
> =C2=A0 iio: proximity: sx9360: Use automated cleanup for locks and IIO mo=
de
> =C2=A0=C2=A0=C2=A0 claiming.
> =C2=A0 iio: proximity: sx9324: Use automated cleanup for locks and IIO mo=
de
> =C2=A0=C2=A0=C2=A0 claiming.
> =C2=A0 iio: proximity: sx9310: Use automated cleanup for locks and IIO mo=
de
> =C2=A0=C2=A0=C2=A0 claiming.
> =C2=A0 iio: adc: ad4130: Use automatic cleanup of locks and direct mode.
> =C2=A0 iio: adc: ad7091r-base: Use auto cleanup of locks.
>=20
> =C2=A0drivers/iio/accel/adxl367.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 297 +++++++++++----------------
> =C2=A0drivers/iio/adc/ad4130.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 131 +++++-------
> =C2=A0drivers/iio/adc/ad7091r-base.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 25 +--
> =C2=A0drivers/iio/adc/max1363.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 171 +++++++--------
> =C2=A0drivers/iio/dummy/iio_simple_dummy.c | 182 ++++++++--------
> =C2=A0drivers/iio/imu/bmi323/bmi323_core.c |=C2=A0 78 +++----
> =C2=A0drivers/iio/proximity/sx9310.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 114 ++++------
> =C2=A0drivers/iio/proximity/sx9324.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 109 ++++------
> =C2=A0drivers/iio/proximity/sx9360.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 115 ++++-------
> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 +++
> =C2=A010 files changed, 518 insertions(+), 729 deletions(-)
>=20


Just one comment that boils down to preference... So, LGTM:

Reviewed-by: Nuno Sa <nuno.a@analog.com>


