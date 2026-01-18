Return-Path: <linux-iio+bounces-27908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC963D39762
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 16:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8700D30071BC
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993632E739;
	Sun, 18 Jan 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyN58Ppw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877A1E32A2
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768749560; cv=none; b=epGwjTcjjDZ5msWU1z+GrKe+milTNlb6zAt8GGzMUMTYv58NJJd/Z60Nlk3e040NhTTvoctt4KSC3WGF++GX4Kd48h2TLC8djwm2fPJ8XYevLbMzOLf4CRHDgxZZXMYmST9NxwOfYi7zr/d/PDw1PpsWrNzIFa7D1KJahPMxxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768749560; c=relaxed/simple;
	bh=g06A1tXDMolKKapiyzUzcHhUdjAZvYx4RznKjM44peE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=UGp0Wbd2Hl16UXY8OrSvpCogG9alI3ZrkUW+bGp4XtLg+TfQvqc0C3cgsGdhoBwMNxN7hrTxQFm1gu2xLYRQCzrRGrxukvgewKLWRURVXPgPj14qNEMcu+i4Kf0AWohKRolzZjahPMMi3kUucB21jwqXZFn5yyez7TshZRqBSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyN58Ppw; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-563610de035so2856489e0c.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 07:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768749558; x=1769354358; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOUvpplcT3urd/iksfVnrJu08Fkv1KRGqxSkXimkTS8=;
        b=fyN58PpwIFB6qd4MdxU+we58A6NLRcx47WZnnDDOUVanOm7UCN6B2GJdTyXQwJnddU
         +V1eI9H1iXvcgcKL8BkYKkb7fAxs2EdyiFVsPcJByYBytxeULmksSzfEJsa69R5HQv4S
         8LAPYilIivBktSYoB1nG5VV8n4YRHxRqQj+2i2Nal6WjMjG1ZUp3b2LMm0fxPl7f0x3A
         am1uGbmDZmqx61oXOiVG8ZfyQOia6BYviNAcTCw7egP3cHaYxdQgcxXPH4KN1xkQy78e
         M0zo+uqkBFNWqGx2Bw6QkcPL7ezsKHPVR/d4WswYNr6WqiVZjLm3ws95bVH4ZaKsodI+
         0UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768749558; x=1769354358;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOUvpplcT3urd/iksfVnrJu08Fkv1KRGqxSkXimkTS8=;
        b=v8YZAcghtUl4haNbv2fvL91XI0zEXhJdqRlTN3/5FVJbKKV+30szzN+AFngE4yZbJN
         HvGQtr6UZcMsaMLWzMzNCwbntaq4CdsMhrxP4Z2YcFTk5psuRx77FBvRKMfpq4ayamcv
         dWNhepc1SL81S81J8kX29mI1QwHE+uZgRPEpn0GrbC+Q7AqxJi747eoKUfc4jpwMy77R
         JC8WSbDZZ5HzVGWnlLZDBnr9+36IVJXHEsOzIeUXtkTaJ6eoceZqrwos4GVxJpsDb2+p
         sCa26NZQyIlVas8UkVGRliwXqLUjbQplQJZL9Rve5DlIOn0peqRg6VOFkXZCXA1agorz
         JcDg==
X-Forwarded-Encrypted: i=1; AJvYcCUrUYLb9E41eJCJd0WHyljwGFGntG0GjAabZuSDqzSrr34jJwhmTgCJHEVG7ULuqupWgZWjISRl/8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfj/8/yJNDh0wYf7ui+johP1pIfMuN+eZV6/ppehQtNViBA6b
	ijLugoDJAjlLk7XHFKv234ZBKB3n9tLcseaKPqj5DZ+s0NCcqwoREFHB
X-Gm-Gg: AY/fxX7omjaDAC1WgXb3kDjonbc0r7JDZhSjci2GsdEqDsm8reCzB9MGpDtJD+RRPok
	J65DFKwRNmzWHTgbENAvWDLAxfOOQOvLBu7t6yPopUEGmvXBRgpT8rt9E+lmjJTJgmnNscGUMiB
	fKvTCZ85R4V2tS13FRocUVMtjtED6oG6zlXF/srEcJsWs5nkyGLngtWtosBDBFQQQSNiIBSIXdD
	VT8w2rGtBS726xTpBl44/H3659FWiSnmBEIHyn3n2e0/x7UHI5n6Jxh13T7Xw9/iE2UEvUIO3zN
	0jUN+Gn2AhZs0QMa0TuqZU4/XEZgijinXkW7RY1GdqiuiBk9GEYztXqKuv3cp6FUKDwdE/gWELv
	KhXyzLvAD47bFRzVQ+gO+eqFEOElq/mvb15UWhsbaRrjCv7kB90XYj94Vy0LYYt5ah514q2fEV1
	B19oxqm0NpHTYB
X-Received: by 2002:a05:6122:3c92:b0:563:7062:2a75 with SMTP id 71dfb90a1353d-563b5be1d20mr2679439e0c.8.1768749558189;
        Sun, 18 Jan 2026 07:19:18 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6fdb023sm2154628e0c.3.2026.01.18.07.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 07:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Jan 2026 10:19:09 -0500
Message-Id: <DFRTDXTFAYGT.46CY6IJICG4W@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck"
 <groeck@chromium.org>, "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v3 0/7] iio: core: Introduce cleanup.h support for mode
 locks
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
 <363f81bfe996de839a43e9f6a355ed014cd3de8a.camel@gmail.com>
In-Reply-To: <363f81bfe996de839a43e9f6a355ed014cd3de8a.camel@gmail.com>

On Sun Jan 18, 2026 at 5:00 AM -05, Nuno S=C3=A1 wrote:
> On Tue, 2026-01-06 at 03:06 -0500, Kurt Borja wrote:
>> Hi,
>>=20
>> In a recent driver review discussion [1], Andy Shevchenko suggested we
>> add cleanup.h support for the lock API:
>>=20
>> 	iio_device_claim_{direct,buffer_mode}().
>>=20
>> Which would allow some nice code simplification in many places. Some
>> examples are given as patches, but the last two are the biggest
>> differences.
>>=20
>> In this version I dropped the RFC tag, as the general feeling is to go
>> through with this after some modifications. Main one is the addition of
>> IIO_DEV_ACQUIRE_{BUFFER,CLAIM}_MODE() wrappers to avoid drivers using
>> the guard classes directly. I also added comments on the forbidden ways
>> to use this API but I definitely still take suggestions on this.
>>=20
>> For now I dropped iio_device_claim_buffer_mode() rename, as this point
>> is still being discussed. My suggestion based on the RFC discussion is
>> to do it, but in a separate patch (using coccinelle) and while we're at
>> it rename the whole API like this:
>>=20
>> 	iio_dev_mode_lock()
>> 	iio_dev_mode_direct_trylock()
>> 	iio_dev_mode_buffer_trylock()
>> 	iio_dev_mode_unlock()
>>=20
>> Let me know what you think and thanks for taking a look!
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>> v3:
>>=20
>> =C2=A0 - Reword commit message of patch 1: infallible -> unconditional.
>>=20
>> =C2=A0 - Drop "*strongly*" in __iio_dev_mode_lock() kernel-doc and be a =
bit
>> =C2=A0=C2=A0=C2=A0 more clear on the function's intention.
>>=20
>> =C2=A0 - Keep comment about inline functions and sparse markings, but dr=
op
>> =C2=A0=C2=A0=C2=A0 the __cond_acquires() part, as the new implementation=
 makes it
>> =C2=A0=C2=A0=C2=A0 unnecessary.
>>=20
>> =C2=A0 - Implement iio_device_release_*() as macros around
>> =C2=A0=C2=A0=C2=A0 __iio_dev_mode_unlock().
>>=20
>> =C2=A0 - Rename iio_device_claim_buffer_mode() ->
>> =C2=A0=C2=A0=C2=A0 iio_device_try_claim_buffer_mode() to avoid silently =
breaking
>> =C2=A0=C2=A0=C2=A0 out-of-tree drivers.
>>=20
>> =C2=A0 - Drop the `_` argument prefix in new macros, as there are no nam=
e
>> =C2=A0=C2=A0=C2=A0 conflicts.
>>=20
>> =C2=A0 - Drop "dummy" from IIO_DEV_ACQUIRE_DIRECT_MODE kernel-doc, as th=
e
>> =C2=A0=C2=A0=C2=A0 `claim` variable does store the error value.
>>=20
>> =C2=A0 - Drop IIO_DEV_ACQUIRE_BUFFER_MODE() until a driver actually need=
s it.
>>=20
>> =C2=A0 - Rename IIO_DEV_ACQUIRE_ERR() -> IIO_DEV_ACQUIRE_FAILED() to mak=
e the
>> =C2=A0=C2=A0=C2=A0 name more clear.
>>=20
>> =C2=A0 - Rename IIO_DEV_GUARD_ANY_MODE() -> IIO_DEV_GUARD_CURRENT_MODE()=
 to
>> =C2=A0=C2=A0=C2=A0 make the name more clear.
>>=20
>> =C2=A0 - Add missing . in iio_device_release_direct() kernel-doc.
>>=20
>> =C2=A0 NOTE: Andy suggested __iio_dev_mode_*() be exported into the IIO_=
CORE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 namespace. However, this cann=
ot be done because these functions
>> 	need to be called inline, so Sparse can see the __acquires() and
>> 	__releases() tags.
>>=20
>> =C2=A0 Happy new year to everyone :)
>>=20
>> v2: https://lore.kernel.org/r/20251211-lock-impr-v2-0-6fb47bdaaf24@gmail=
.com
>>=20
>> =C2=A0 - Add __iio_dev_mode_lock() (formerly iio_device_claim()) in the =
first
>> =C2=A0=C2=A0=C2=A0 patch.
>>=20
>> =C2=A0 - Added comments to make sure __iio_dev_mode_lock() is not used b=
y
>> =C2=A0=C2=A0=C2=A0 drivers to protect internal state, or in general.
>>=20
>> =C2=A0 - Add patch which re-implements iio_device_claim_direct() using
>> =C2=A0=C2=A0=C2=A0 __iio_dev_mode_lock().
>>=20
>> =C2=A0 - Match iio_device_claim_buffer_mode() semantics by reimplementin=
g it
>> =C2=A0=C2=A0=C2=A0 in the same way as iio_device_claim_direct().
>>=20
>> =C2=A0 - Guard classes now are prefixed with __priv__ to make sure drive=
rs
>> =C2=A0=C2=A0=C2=A0 don't use them directly.
>>=20
>> =C2=A0 - Add IIO_DEV_ACQUIRE_{BUFFER,DIRECT}_MODE() documented wrappers
>>=20
>> =C2=A0 - Avoid any function renames (for now).
>>=20
>> =C2=A0 - Rename dummy variable `claim` instead of `busy` on vcnl4000 pat=
ch.
>>=20
>> =C2=A0 - Avoid scoped guard in max30102.
>>=20
>> =C2=A0 - Keep using iio_trigger_validate_own_device() insted of
>> =C2=A0=C2=A0=C2=A0 iio_trigger_using_own() in opt4060.
>>=20
>> v1: https://lore.kernel.org/r/20251203-lock-impr-v1-0-b4a1fd639423@gmail=
.com
>>=20
>> ---
>> Kurt Borja (7):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: core: Add and export __iio_dev_mode_=
lock()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: core: Refactor iio_device_claim_dire=
ct() implementation
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: core: Match iio_device_claim_*() sem=
antics and implementation
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: core: Add cleanup.h support for iio_=
device_claim_*()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: light: vcnl4000: Use IIO cleanup hel=
pers
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: health: max30102: Use IIO cleanup he=
lpers
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: light: opt4060: Use IIO cleanup help=
ers
>>=20
>> =C2=A0drivers/iio/adc/ade9000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0.../common/cros_ec_sensors/cros_ec_sensors_core.c=C2=A0 |=C2=A0=C2=
=A0 5 +-
>> =C2=A0drivers/iio/health/max30100.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>> =C2=A0drivers/iio/health/max30102.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 33 ++---
>> =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 86 +++---------
>> =C2=A0drivers/iio/light/opt4060.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 52 +++-----
>> =C2=A0drivers/iio/light/vcnl4000.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 49 +++----
>> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 145 +++++++++++++++++++--
>> =C2=A08 files changed, 196 insertions(+), 184 deletions(-)
>> ---
>> base-commit: fb2f4eb29a258145b0336601f00509cab6e93e7c
>> change-id: 20251130-lock-impr-6f22748c15e8
>
> Nothing to add from me...
>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Thank you for your feedback, Nuno!

--=20
Thanks,
 ~ Kurt


