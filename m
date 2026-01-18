Return-Path: <linux-iio+bounces-27906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5ED393B4
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 10:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C76AF30115C6
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A345A2D97B4;
	Sun, 18 Jan 2026 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsjE8M+d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5878F39
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730352; cv=none; b=DKPGF3IEeZj5fvHMl5v3A3yeYAd/1nQxRFXWrDZ3vR5PCeRFzm8pXQs+o5AUnThppLXTP8oXt3Na8E7c30WiaGZBThTlTaxNbhhS0cz0xp/+FcEAKvDchvn6/YW718Knyu3xjCv0k41R6QIQs9aiTqSU5uSTXoQaUWDklbfPbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730352; c=relaxed/simple;
	bh=08rC0cvF54ACB0PVeySzp8VYTmE3tgW3pybPh55JTAc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VaTEicUwKSMc9niTzkW3cwoCYS4wbD3ZLpQR1w4r9XM/7voSCifxqFvb961EO++kPgx9OhLWHY4GIFVfV9L56TyXeubp4R7gpX1L0b9lUmecQQ0ChHDvQiFGMcN2AW80CZvbV9O5AbvtJHr107nIhvRss2naFG/e8OVFni5Fb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsjE8M+d; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b73193dc8so3212995e87.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 01:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768730349; x=1769335149; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X5Wp4PFW3FDjcGZeHy285d4DuBD8ZW5QDx8KF4QEZ6I=;
        b=IsjE8M+dad7qvvvYKEGD5hV/seb8DPLFf/uAl4lQxd9Bc3hkOnbP3XEFDKmBi3WySt
         fIKIcVyKby8jqKvW/5wQ0RE48y6b4u0WXAyYfoms/bqiUPQWcMl4xnuUmOuWsUmRq2M3
         y9g/ZnhRPJWSLGeoTRG2XzCJxhfFw409QnOeNAgDKn00lEQfTHLQ3nsvSNGH42fEqgoP
         9xkqLTvHBO9pa830dkOpJTXyiwRJGQiCjThrFfQ4yCYN3DrPNd6R64MkP9zZXt2g5FpL
         uXZRtap3g/AkqGyOjHEQ9vCSY1Oqb+2Dgiq+5E6mQX/X4GtH1pPMphTQx4UZdSb+b82I
         wjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768730349; x=1769335149;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5Wp4PFW3FDjcGZeHy285d4DuBD8ZW5QDx8KF4QEZ6I=;
        b=TydG+rmAvA4wmQEizET2froFZOL0X3DOr+iLCFhOwqCmURbV5Krr/n8E60n583nio0
         Us5x4yX0MmVuY3Ohh0ZFDvdOCDa8JVAWflhoNE9dyRC1++fscqFFK7AqvTNBDWROL0Gn
         7SuLbTF4swU8ijCfsaLOfzkjS6PjC/zVSPG3wxd3Vf8agMs9G0Y26YG5TXbFUmu9XSmW
         4khhPevZN4ooBiSzLCkufaxbJh0Lq4J5A6VC3DPgVSVmhcggsJGGz1AyhRkE/rMkT6yw
         zvrfjgE0CN//1lQS+iNS9mBAPnyEUjLumeLZMFPC1PU4yOaAPXAyqz1mbe4bxMSiHRml
         fjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWrlRapVFae88yoRx5CE3hcmlIiuWeWfEzqHyHFGXb67INtaMyyITbe2I/8KVSkgaZzYaSNQEptyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/byKPvRweUNLiENdb8/pTpG34pBI0YarkgHaui+N4ie8iSE1H
	leXGsHwhfyNRzWZvqK0psSjyFHaQ8qHqLLd8tj8o8epvagUAXBYKLvgc
X-Gm-Gg: AY/fxX5sktPDbEwHcn54T1cv0OQMyxA3myafb5lmMNMDYOnIJBhEKXD0/6H0VUS4SWc
	dyY5bgia9/XrS+QsDUJ6ApyRfFlhL0weIDU4lJySpQTTrGkP/6+eac6HeYqw87i4zhqTu2vqz1U
	PsIunnqBAkcl2upexvMiWx+fREmUT0r3qd3qXVFx26OY42Xrch30NAegAwrCJoDKsPtB0//Gi/u
	auLxn1RMA9YZK6frSzORN+Nao2siKsIZVzV5xKaU6xN+ikuXnmhzfMC3FdTay9IxVkEf6iM9V+S
	GgyoDVpPJeLh66TsdFqWjxxLReu4DXH4ZVh2DnbeB1sC7P0Gr0GWDjtHTJud8Yu7lzz5m2DX32C
	gJ2Y48gPaTLJKJixhKLsUinwGTbIE/o4c4tN3zzHHPP2hwZ3zhg2fB0c+B00B6an5xor9i3YkYk
	QSLEbnpeOlGDOATC0WlNMpbiIpCPltAxH6O4Ycl2fwGyWX+STX86UZmyx3lPo=
X-Received: by 2002:a05:6512:3b0d:b0:59b:78b2:27fc with SMTP id 2adb3069b0e04-59baeee5f3emr2568080e87.42.1768730348531;
        Sun, 18 Jan 2026 01:59:08 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf397728sm2292945e87.49.2026.01.18.01.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 01:59:07 -0800 (PST)
Message-ID: <363f81bfe996de839a43e9f6a355ed014cd3de8a.camel@gmail.com>
Subject: Re: [PATCH v3 0/7] iio: core: Introduce cleanup.h support for mode
 locks
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
	 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Date: Sun, 18 Jan 2026 10:00:10 +0000
In-Reply-To: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-06 at 03:06 -0500, Kurt Borja wrote:
> Hi,
>=20
> In a recent driver review discussion [1], Andy Shevchenko suggested we
> add cleanup.h support for the lock API:
>=20
> 	iio_device_claim_{direct,buffer_mode}().
>=20
> Which would allow some nice code simplification in many places. Some
> examples are given as patches, but the last two are the biggest
> differences.
>=20
> In this version I dropped the RFC tag, as the general feeling is to go
> through with this after some modifications. Main one is the addition of
> IIO_DEV_ACQUIRE_{BUFFER,CLAIM}_MODE() wrappers to avoid drivers using
> the guard classes directly. I also added comments on the forbidden ways
> to use this API but I definitely still take suggestions on this.
>=20
> For now I dropped iio_device_claim_buffer_mode() rename, as this point
> is still being discussed. My suggestion based on the RFC discussion is
> to do it, but in a separate patch (using coccinelle) and while we're at
> it rename the whole API like this:
>=20
> 	iio_dev_mode_lock()
> 	iio_dev_mode_direct_trylock()
> 	iio_dev_mode_buffer_trylock()
> 	iio_dev_mode_unlock()
>=20
> Let me know what you think and thanks for taking a look!
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> v3:
>=20
> =C2=A0 - Reword commit message of patch 1: infallible -> unconditional.
>=20
> =C2=A0 - Drop "*strongly*" in __iio_dev_mode_lock() kernel-doc and be a b=
it
> =C2=A0=C2=A0=C2=A0 more clear on the function's intention.
>=20
> =C2=A0 - Keep comment about inline functions and sparse markings, but dro=
p
> =C2=A0=C2=A0=C2=A0 the __cond_acquires() part, as the new implementation =
makes it
> =C2=A0=C2=A0=C2=A0 unnecessary.
>=20
> =C2=A0 - Implement iio_device_release_*() as macros around
> =C2=A0=C2=A0=C2=A0 __iio_dev_mode_unlock().
>=20
> =C2=A0 - Rename iio_device_claim_buffer_mode() ->
> =C2=A0=C2=A0=C2=A0 iio_device_try_claim_buffer_mode() to avoid silently b=
reaking
> =C2=A0=C2=A0=C2=A0 out-of-tree drivers.
>=20
> =C2=A0 - Drop the `_` argument prefix in new macros, as there are no name
> =C2=A0=C2=A0=C2=A0 conflicts.
>=20
> =C2=A0 - Drop "dummy" from IIO_DEV_ACQUIRE_DIRECT_MODE kernel-doc, as the
> =C2=A0=C2=A0=C2=A0 `claim` variable does store the error value.
>=20
> =C2=A0 - Drop IIO_DEV_ACQUIRE_BUFFER_MODE() until a driver actually needs=
 it.
>=20
> =C2=A0 - Rename IIO_DEV_ACQUIRE_ERR() -> IIO_DEV_ACQUIRE_FAILED() to make=
 the
> =C2=A0=C2=A0=C2=A0 name more clear.
>=20
> =C2=A0 - Rename IIO_DEV_GUARD_ANY_MODE() -> IIO_DEV_GUARD_CURRENT_MODE() =
to
> =C2=A0=C2=A0=C2=A0 make the name more clear.
>=20
> =C2=A0 - Add missing . in iio_device_release_direct() kernel-doc.
>=20
> =C2=A0 NOTE: Andy suggested __iio_dev_mode_*() be exported into the IIO_C=
ORE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 namespace. However, this canno=
t be done because these functions
> 	need to be called inline, so Sparse can see the __acquires() and
> 	__releases() tags.
>=20
> =C2=A0 Happy new year to everyone :)
>=20
> v2: https://lore.kernel.org/r/20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.=
com
>=20
> =C2=A0 - Add __iio_dev_mode_lock() (formerly iio_device_claim()) in the f=
irst
> =C2=A0=C2=A0=C2=A0 patch.
>=20
> =C2=A0 - Added comments to make sure __iio_dev_mode_lock() is not used by
> =C2=A0=C2=A0=C2=A0 drivers to protect internal state, or in general.
>=20
> =C2=A0 - Add patch which re-implements iio_device_claim_direct() using
> =C2=A0=C2=A0=C2=A0 __iio_dev_mode_lock().
>=20
> =C2=A0 - Match iio_device_claim_buffer_mode() semantics by reimplementing=
 it
> =C2=A0=C2=A0=C2=A0 in the same way as iio_device_claim_direct().
>=20
> =C2=A0 - Guard classes now are prefixed with __priv__ to make sure driver=
s
> =C2=A0=C2=A0=C2=A0 don't use them directly.
>=20
> =C2=A0 - Add IIO_DEV_ACQUIRE_{BUFFER,DIRECT}_MODE() documented wrappers
>=20
> =C2=A0 - Avoid any function renames (for now).
>=20
> =C2=A0 - Rename dummy variable `claim` instead of `busy` on vcnl4000 patc=
h.
>=20
> =C2=A0 - Avoid scoped guard in max30102.
>=20
> =C2=A0 - Keep using iio_trigger_validate_own_device() insted of
> =C2=A0=C2=A0=C2=A0 iio_trigger_using_own() in opt4060.
>=20
> v1: https://lore.kernel.org/r/20251203-lock-impr-v1-0-b4a1fd639423@gmail.=
com
>=20
> ---
> Kurt Borja (7):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: core: Add and export __iio_dev_mode_l=
ock()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: core: Refactor iio_device_claim_direc=
t() implementation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: core: Match iio_device_claim_*() sema=
ntics and implementation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: core: Add cleanup.h support for iio_d=
evice_claim_*()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: light: vcnl4000: Use IIO cleanup help=
ers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: health: max30102: Use IIO cleanup hel=
pers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: light: opt4060: Use IIO cleanup helpe=
rs
>=20
> =C2=A0drivers/iio/adc/ade9000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0.../common/cros_ec_sensors/cros_ec_sensors_core.c=C2=A0 |=C2=A0=C2=
=A0 5 +-
> =C2=A0drivers/iio/health/max30100.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> =C2=A0drivers/iio/health/max30102.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 33 ++---
> =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 86 +++---------
> =C2=A0drivers/iio/light/opt4060.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 52 +++-----
> =C2=A0drivers/iio/light/vcnl4000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 49 +++----
> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 145 +++++++++++++++++++--
> =C2=A08 files changed, 196 insertions(+), 184 deletions(-)
> ---
> base-commit: fb2f4eb29a258145b0336601f00509cab6e93e7c
> change-id: 20251130-lock-impr-6f22748c15e8

Nothing to add from me...

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

